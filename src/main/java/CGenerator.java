/**
 * Created by daniel on 24.06.15.
 */

//bo mi z jakiegoś powodu classpath nie działa xd
import java.lang.*;

public class CGenerator {
    StringBuilder result = new StringBuilder();
    node top;

    public CGenerator(node top){
        super();
        this.top = top;
    }

    public String generateC(){
        node actual = top;
        node work = top;
        while(!actual.id.equals("prog")){
            actual = actual.child;
        }
        //nazwa programu powinno iść do val ale pomieszałem w gramatyce
        result.append("//Program name: "+actual.child.id).append('\n');
        result.append("#include <stdio.h>").append('\n');
        //przejscie do wnętrza sekcji block
        //dla tych bloków będzie trzeba po kolei generować kod
        System.out.println("ACTUAL ID: " + actual.next.id);
        System.out.println("ACTUAL ID: " + actual.next.next.id);
        System.out.println("ACTUAL ID: " + actual.next.next.next.id);
        System.out.println("ACTUAL ID: " + actual.next.next.next.next.id);
        System.out.println("ACTUAL ID: " + actual.next.next.next.next.next.id);
        System.out.println("ACTUAL ID: " + actual.next.next.next.next.next.next.id);


        actual = actual.next.next.next.next.next.next.next;
        System.out.println("ACTUAL ID: " + actual.id);
        result.append("//block section").append('\n');
        generateBlockCode(actual, true);
        //actual = actual.next;

        return result.toString();
    }

    private void generateBlockCode(node actual, boolean isMainProcedure){
        node top = actual;
        node work = actual;
        switch(top.id){
            case "body":
                //dla zwykłych procedur będzie to robione inaczej (definiowane wcześniej)
                if(isMainProcedure)
                 result.append("int main(void)").append("\n").append("{");
                while(work != null && !work.id.equals("statement")){
                    System.out.println("CURR ID:" + work.id);
                    work = work.child;
                }
                boolean hasNextStatement = true;
                //przetwarzanie statementów
                while(hasNextStatement) {
                    generateStatement(work);
                    work = work.next;
                    hasNextStatement = work != null;
                }
                result.append("}").append('\n');
                if(top.next == null)
                    return;
                else{
                    //narazie nie wiem czy coś może jeszcze tutaj powstać
                }

            break;

            default:
                result.append("Something went wrong..");
                break;
        }
    }

    private void generateStatement(node actual){
        node top = actual;
        // na chwilę obecną nie obsługujemy labeli więc idziemy odrazu do unlabelled
        node work = actual.child.child;
        node next = work;
        switch(work.id){
            case "simple":
                    work = work.child;

                    switch(work.id){
                        case "writeln":
                            result.append("printf(");
                            generateWriteStmt(work.child);
                            result.append(");").append('\n');
                            break;
                        case "ewriteln":
                            result.append("printf(\" \\n\")").append('\n');
                            break;
                    }

                break;
        }
    }

    private void generateWriteStmt(node actual){
        node top =actual;
        node work = actual;
        //przejście do dalszego noda wyrażenia - bezpośrednio do factora dla ułatwienia..
        work = work.child.child.child.child.child;

        switch(work.id){
            case "string":
                    result.append('\"').append(work.val).append('\"');
                    System.out.println("FOUND STRING: " + work.val);
                break;
        }

    }
}
