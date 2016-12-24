/*
  -------------------------------------------------------------------
  Utility Interface (Omit.java)
  ------------------------------------------------------
  This program contains various strings to create 
  a regular expression to omit certain special 
  characters in the text

  Program Structure:

  Class        : Omit
  Constructors : no constrcutor 
  Methods      : no methods
   -------------------------------------------------------------------
*/
public interface Omit {
    static String comma = "\\,";
    static String period = "\\.";
    static String questionMark = "\\?";
    static String exclamationPoint = "\\!";
    static String quotationMark = "\"";
    static String hyphen = "\\-";
    static String colon = "[:]";
    static String semicolon = "[;]";
    static String apostrophe = "\\'";
    static String parantheses0 = "\\(";
    static String parantheses1 = "\\)";
    static String parantheses2 = "\\{";
    static String parantheses3 = "\\}";
    static String parantheses4 = "\\[";
    static String parantheses5 = "\\]";
    static String ampersand = "&";
    static String spec1 = "“";
    static String spec2 = "§";
    static String slash = ""
    static String or = "|";

    static String exclude = comma + or + period + or + questionMark + or +
            exclamationPoint + or + quotationMark + or + hyphen + or +
            colon + semicolon + or + apostrophe + or + parantheses0 + or +
            parantheses1 + or + parantheses2 + or + parantheses3 + or +
            parantheses4 + or + parantheses5 + or + ampersand + or + slash;

}
