/**
 * Created by Mariusz on 2015-06-14.
 */

import java_cup.runtime.ComplexSymbolFactory;
import java_cup.runtime.ScannerBuffer;
import java_cup.runtime.XMLElement;
import javax.xml.stream.XMLOutputFactory;
import javax.xml.stream.XMLStreamWriter;
import java.io.*;

import javax.xml.transform.*;
import javax.xml.transform.stream.*;

public class Main {

    public static void main(String[] args) throws Exception {
        // initialize the symbol factory
        ComplexSymbolFactory csf = new ComplexSymbolFactory();
        // create a buffering scanner wrapper
        ScannerBuffer lexer = new ScannerBuffer(new Lexer(new BufferedReader(new FileReader(args[0])),csf,"TEST_TEST"));
        // start parsing
        Parser p = new Parser(lexer,csf);
        XMLElement e = (XMLElement)p.parse().value;
        // create XML output file
        XMLOutputFactory outFactory = XMLOutputFactory.newInstance();
        XMLStreamWriter sw = outFactory.createXMLStreamWriter(new FileOutputStream(args[1]), "utf-8");
        // dump XML output to the file
        XMLElement.dump(lexer,sw,e,"expr","stmt");

        // transform the parse tree into an AST and a rendered HTML version
        Transformer transformer = TransformerFactory.newInstance()
                .newTransformer(new StreamSource(new File("tree.xsl")));
        Source text = new StreamSource(new File(args[1]));
        transformer.transform(text, new StreamResult(new File("output.xml")));
        transformer = TransformerFactory.newInstance()
                .newTransformer(new StreamSource(new File("tree-view.xsl")));
        text = new StreamSource(new File("output.xml"));
        transformer.transform(text, new StreamResult(new File("ast.html")));
    }
}