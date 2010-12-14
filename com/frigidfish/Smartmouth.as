package com.frigidfish{
	import com.frigidfish.ScrabbleDictionary;
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;	
	import fl.data.DataProvider;
	import fl.controls.List;
	import flash.events.Event;	
	import flash.text.TextFormat;
	import fl.controls.TextInput;	
	import flash.text.Font;
	import flash.events.KeyboardEvent;
	import flash.events.FocusEvent;
	
	public class Smartmouth extends MovieClip {

		public var inputLetters:TextInput;
		public var word:Array 					= new Array();		
		public var bookendWords:Array 			= new Array();
		public var lettersInOrderWords:Array 	= new Array();
		
		public var invalid:String 				= "---NONE---";

		public function Smartmouth() {			
			
			setupButtons();				
			setTextFormats();
			stage.focus = inputLetters;
			
			search.addEventListener(MouseEvent.MOUSE_DOWN, mouseUp, false,0,true);
			search.addEventListener(MouseEvent.MOUSE_UP, searchFirstLast, false,0,true);
			search.addEventListener(MouseEvent.MOUSE_UP, searchInOrder, false,0,true);
			search.addEventListener(MouseEvent.ROLL_OVER, rollOver, false,0,true);
			search.addEventListener(MouseEvent.ROLL_OUT, rollOut, false,0,true);
			
			stage.addEventListener(KeyboardEvent.KEY_DOWN, function(){blinker.visible=false;});
			inputLetters.addEventListener(MouseEvent.CLICK,onFocusIn,false,0,true);
		}
		
		
		function onFocusIn(event:MouseEvent):void {		
    		event.target.setSelection(0, event.target.text.length);	
		}

		
		private function setTextFormats():void{
			
			var ms:Monospace 		= new Monospace();			
			
			var tf:TextFormat 		= new TextFormat();
			tf.size 				= 94;				
			tf.bold 				= true;
			tf.letterSpacing 		= 45;
			tf.font 				= ms.fontName;			
			tf.align 				= "left";									
			
			var listTF:TextFormat 	= new TextFormat();
			listTF.font 			= ms.fontName;
			listTF.letterSpacing 	= 40;
			
			inputLetters.setStyle("textFormat", tf);			
			firstLastWords.setStyle("textFormat", listTF);
			orderedWords.setStyle("textFormat", listTF);
			inputLetters.setStyle("embedFonts", true);
			firstLastWords.setStyle("embedFonts", true);
			orderedWords.setStyle("embedFonts", true);			
		}
		
		private function setupButtons():void{
			
			solving.visible 		= false;			
			solving.mouseChildren 	= false;
			solving.mouseEnabled 	= false;			
			search.mouseChildren 	= false;
			search.buttonMode 		= true;
			search.useHandCursor 	= true;
			search.stop();
			
			SetupButton.add(sortAlphaLIO,"Alphabetically",MouseEvent.MOUSE_DOWN);
			SetupButton.add(sortHLIO,"Highest Score",MouseEvent.MOUSE_DOWN);
			SetupButton.add(sortAlphaBE,"Alphabetically",MouseEvent.MOUSE_DOWN);
			SetupButton.add(sortHBE,"Highest Score",MouseEvent.MOUSE_DOWN);
			SetupButton.add(printInOrder,'TOP 20 "LETTERS IN ORDER" WORDS',MouseEvent.MOUSE_DOWN);
			SetupButton.add(printBookend,'TOP 20 "BOOKEND" WORDS',MouseEvent.MOUSE_DOWN);
						
			sortAlphaLIO.addEventListener(MouseEvent.CLICK, function(){updateList(orderedWords,lettersInOrderWords,false);});
			sortHLIO.addEventListener(MouseEvent.CLICK, function(){updateList(orderedWords,lettersInOrderWords,true);});			
			sortAlphaBE.addEventListener(MouseEvent.CLICK, function(){updateList(firstLastWords,bookendWords,false);});
			sortHBE.addEventListener(MouseEvent.CLICK, function(){updateList(firstLastWords,bookendWords,true);});			
			printBookend.addEventListener(MouseEvent.CLICK, function(){Print.now(bookendWords);});
			printInOrder.addEventListener(MouseEvent.CLICK, function(){Print.now(lettersInOrderWords);});		
		}	
		
		private function searchFirstLast(event:MouseEvent):void {
			if(!validLettersEntered()) return;
			var a:Array = ScrabbleDictionary.firstLast(inputLetters.text.toLowerCase());
			updateList(firstLastWords,a,true);			
		}
		
		private function searchInOrder(event:MouseEvent):void{			
			if(!validLettersEntered()) return;			
			var a:Array = ScrabbleDictionary.ordered(inputLetters.text.toLowerCase());
			updateList(orderedWords,a,true);
		}
		
		private function validLettersEntered():Boolean{
			if(inputLetters.text.length < 2){
				solving.visible = false;
				return false;
			}
			return true;			
		}
				
		private function updateList(list:List,a:Array,alphabetize:Boolean):void{
			
			solving.visible = false;
			var dp:DataProvider = new DataProvider();
									
			if(a.length == 0){								
				dp.addItem( {  label:invalid} );				
				list.dataProvider = dp;				
				return;
			}
			
			if(list == firstLastWords) bookendWords = a;			
			else lettersInOrderWords = a;			
			
			if(alphabetize == true) a = a.sort(Sort.hiToLow);			
			else a = a.sort();			
			
			word = a;
			
			for (var i in a) dp.addItem({label:a[i].toUpperCase()});			
			list.dataProvider = dp;			
		}		
			
		private function mouseUp(event:MouseEvent):void{solving.visible = true;}
		private function rollOver(event:MouseEvent){event.target.gotoAndStop(2);}
		private function rollOut(event:MouseEvent){event.target.gotoAndStop(1);}
	}
}