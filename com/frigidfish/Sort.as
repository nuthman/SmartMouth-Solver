package com.frigidfish{

	public class Sort {
		
		public static function hiToLow(a:String, b:String):Number {

			if (a.length < b.length) return 1;			
			else if (a.length > b.length) return -1;
			else return 0;			
		}
		
		public static function lowToHigh(a:String, b:String):Number {

			if (a.length > b.length) return 1;			
			else if (a.length < b.length) return -1;
			else return 0;
		}
	}
}