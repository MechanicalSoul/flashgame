package com.mysite {
	import flash.display.MovieClip;
	import flash.display.Stage;
	
	import flash.events.Event;
	
	import flash.text.TextField;
	import flash.text.TextFormat;
	import flash.system.fscommand;
	
	import flash.display.MovieClip;
	
	
	public class Score extends MovieClip {
		var scoreText:TextField = new TextField;
		var timeText:TextField = new TextField;
		var roundText:TextField = new TextField;
		var myTime:Number = 0;
		var myRounds = 1;
		var totalScore = 0;
		public function Score() 
		{
			
 var format:TextFormat = new TextFormat();
 format.font = "Tahoma";
 format.color = 0x000000;
 format.size = 35;
 scoreText.defaultTextFormat = format;
			addChild(scoreText);
			scoreText.x = 150;
			scoreText.y = 25;
			scoreText.width = 500;
 			scoreText.height = 60;
			
			
var format2:TextFormat = new TextFormat();
 format2.font = "Tahoma";
 format2.color = 0x000000;
 format2.size = 35;
 timeText.defaultTextFormat = format2;
			addChild(timeText);
			timeText.x = 600;
			timeText.y = 25;
			timeText.width = 500;
 			timeText.height = 60;			
			
			timeText.text = "Time " + myTime;
			
			
var format3:TextFormat = new TextFormat();
 format3.font = "Tahoma";
 format3.color = 0x000000;
 format3.size = 35;
 roundText.defaultTextFormat = format3;
			addChild(roundText);
			roundText.x = 350;
			roundText.y = 25;
			roundText.width = 500;
 			roundText.height = 60;			
			
			roundText.text = "Round № " + myRounds;			
			
		}
		
		public function scoreUpdate(myscore):void
		{
			scoreText.text = "Score " + myscore.toString();
			totalScore = myscore;
		}
		
		public function timeUpdate():void
		{
			timeText.text = "Time " + myTime.toString();
			myTime++;
		}
		
		public function roundUpdate(boss):void
		{
			if(boss == false)
			{
			roundText.text = "Round № " + myRounds.toString();
			myRounds++;
			}
			else
			if(boss == true)
			{
			roundText.text = "Boss Fight";
			}
			
		}
		
		public function winLose(win):void
		{
			if (win == true){
				totalScore = Math.round(totalScore / myTime * 1000);
				removeChild(scoreText);
				removeChild(timeText);
				roundText.x = 200;
				roundText.text = "You win! Your score is: " + totalScore;
			}
			else
			if (win == false){
				roundText.text = "Game over";
			}
		}
	}
	
}
