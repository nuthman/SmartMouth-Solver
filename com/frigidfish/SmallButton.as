package com.frigidfish {
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.events.MouseEvent;
	
	public class SmallButton extends MovieClip {
		public var label:TextField;
		
		public function SmallButton() {
			stop();
			mouseChildren = false;
			this.useHandCursor = true;
			buttonMode = true;
			addEventListener(MouseEvent.ROLL_OVER, rollOver,false,0,true);
			addEventListener(MouseEvent.ROLL_OUT, rollOut,false,0,true);
		}
		
		private function rollOver(event:MouseEvent){
			
			gotoAndStop(2);
		}
		private function rollOut(event:MouseEvent){
			
			gotoAndStop(1);
		}
		
		public function set text(t:String):void{
			label.text = t;
		}
		
	}
	
}
