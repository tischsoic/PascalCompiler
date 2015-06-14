/**
 * Created by Mariusz on 2015-06-14.
 */

import java.io.*;
import grammar.*;
public class Main {

    static public void main(String argv[]) throws Exception {

        parser p = new parser(new File(argv[0]));

        p.parse();
    }
}
