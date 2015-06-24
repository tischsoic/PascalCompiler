/**
 * Created by daniel on 23.06.15.
 */
public class node {
    public node child = null;
    public String val = null;
    public String id = null;
    public node next = null;

    //Konstruktor dla cup'a
    public node(node child, node next, String val, String id){
        this.child = child;
        this.next = next;
        this.id = id;
        this.val = val;
    }

    //Konstrukor dla jflex'a
    public node(String val, String id){
        this.val = val;
        this.id = id;
    }
}
