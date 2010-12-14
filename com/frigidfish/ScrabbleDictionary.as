package com.frigidfish{

	import flash.utils.ByteArray;
	
	public class ScrabbleDictionary extends ByteArray {
		
		[Embed(source = "sowpods.txt",mimeType = "application/octet-stream")]
		
		private static const ScrabbleFile:Class;
		private static var words:Array = new ScrabbleFile().toString().split(" ");
		
		public static function contains(word:String):Boolean {
			return words.indexOf(word.toLowerCase()) > -1;
		}
		
		public static function random():String {
			return words[Math.floor(Math.random() * words.length)];
		}
		
		public static function getWords():Array{
			return words;
		}
		
		public static function ordered(s:String):Array {
			
			var a:Array = new Array();

			for (var i in words) {
				var f:String = s.charAt(0);
				var m:String = s.charAt(1);

				if (words[i].search(f) != -1) {
					var cut:String = words[i].substring(words[i].indexOf(f) + 1,words[i].length);

					if (cut.search(m) != -1) {
						a.push(words[i]);
					}
				}
			}
			return a;
		}
		
		public static function firstLast(s:String):Array{
			
			var a:Array = new Array();
			
			for (var i in words) {
				var f:String = s.charAt(0);
				var m:String = s.charAt(1);

				if (words[i].charAt(0) == f) {					

					if (words[i].charAt(words[i].length-1) == m) {
						a.push(words[i]);
					}
				}
			}
			return a;			
		}		
	}
}