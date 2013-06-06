package com.mysite {
	
		import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

	
	
	public class Rockethero extends MovieClip {
		private var speed:Number;
		
		public function Rockethero() {
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
		}
		
		private function onAddedToStage(e:Event):void
		{
			speed = 8;
			this.addEventListener(Event.ENTER_FRAME, loop);
		}
		
		private function loop(e:Event):void
		{
			this.x -= speed * Math.sin(rotation * (Math.PI/180));
			this.y += speed * Math.cos(rotation * (Math.PI/180));
			//speed++;
		}
		
	
	}
	
}
