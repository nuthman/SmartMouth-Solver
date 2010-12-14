package com.frigidfish{
	
	import flash.display.MovieClip;
	import flash.text.TextField;
	import flash.printing.PrintJob;

	public class Print {

		public static function now(a:Array):void {

			var mc:MovieClip = new MovieClip();

			for (var i=0; i<20; i++) {

				var tf:TextField = new TextField();
				tf.width	= 500;
				tf.text 	= a[i].toUpperCase();

				tf.y 		= i * 20;
				tf.x 		= 50;
				mc.addChild(tf);
			}

			var myPrintJob:PrintJob = new PrintJob();
			var result:Boolean 		= myPrintJob.start();
			if (result) {
				myPrintJob.addPage(mc);
				myPrintJob.send();				
			}
			else {
				//User does not have printer or user canceled print action
			}
		}
	}
}