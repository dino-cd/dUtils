import dUtils.functions.dString;

var s:String = "  Hello World  ";

trace(dString.trim(s));
trace(dString.ltrim(s));
trace(dString.rtrim(s));

var s2:String = "ActionScript 2.0";

trace(dString.startsWith(s2, "Action"));
trace(dString.endsWith(s2, "2.0"));
trace(dString.contains(s2, "Script"));

trace(dString.repeat("ab", 4));
trace(dString.padLeft("7", 4, "0"));
trace(dString.padRight("hi", 6, "."));

trace(dString.replaceAll("foo bar foo", "foo", "baz"));

var arr:Array = dString.split("one|two|three", "|");
trace(arr[0] + " " + arr[1] + " " + arr[2]);

trace(dString.countOccurrences("banana", "an"));
trace(dString.reverse("hello"));
trace(dString.capitalize("hELLO"));
trace(dString.titleCase("the quick brown fox"));
trace(dString.isNumeric("-3.14"));
trace(dString.isNumeric("12px"));
trace(dString.isAlpha("hello"));
trace(dString.isAlphaNumeric("hello123"));
trace(dString.truncate("this is a long string", 14, "..."));
trace(dString.stripTags("<b>bold</b> and <i>italic</i>"));

var chars:Array = dString.toArray("abc");
trace(chars[0] + " " + chars[1] + " " + chars[2]);

var codes:Array = dString.toCharCodes("Hi");
trace(codes[0] + " " + codes[1]);

trace(dString.fromCharCodes([72, 101, 108, 108, 111]));
trace(dString.indexOfNth("abcabcabc", "abc", 3));
trace(dString.isEmpty(""));
trace(dString.isEmpty("x"));
trace(dString.isBlank("   "));
trace(dString.isBlank("x"));
trace(dString.insert("helo", 3, "l"));
trace(dString.remove("hello!!", 5, 2));
trace(dString.compareIgnoreCase("Apple", "apple"));
trace(dString.equalsIgnoreCase("Hello", "hElLo"));
trace(dString.wrap("the quick brown fox jumps over the lazy dog", 15));
trace(dString.format("name: {0}, age: {1}", ["Bob", 30])
;
