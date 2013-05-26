package com.mysite {
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import flash.events.Event;
	
	import flash.text.TextField;
	import flash.system.fscommand;
	
	import flash.display.MovieClip;
	
	
	public class Score extends MovieClip {
		var scoreText:TextField = new TextField;
		
		public function Score() 
		{
			addChild(scoreText);
			scoreText.x = 100;
			scoreText.y = 10;
			
			scoreText.text = "score";			
			
		}
	}
	
}
