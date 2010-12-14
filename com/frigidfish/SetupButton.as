package com.frigidfish {
	
	import flash.events.MouseEvent;
	
	public class SetupButton {

		public static function add(button:Object,label:String, event:String):void{
			
			button.text = label;			
			button.addEventListener(event, displaySortingMessage,false,0,true);
		}
		
		private static function displaySortingMessage(event:MouseEvent){			
			event.target.gotoAndStop(3);				
		}
	}	
}
