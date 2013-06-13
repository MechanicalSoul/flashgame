package com.mysite {
	
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	
	public class Launcher extends MovieClip {
		
		
		public function Launcher() {
			addEventListener(Event.ENTER_FRAME, pointAtCursor);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
		}
		public function pointAtCursor(event:Event) {
// get relative mouse location
var dx:Number = stage.mouseX - this.x;
var dy:Number = stage.mouseY - this.y;
var cursorAngle:Number = Math.atan2(dy,dx);
var cursorDegrees:Number = 360*(cursorAngle/(2*Math.PI));
// point at cursor
this.rotation = cursorDegrees;

}

private function onRemovedFromStage(e:Event):void
		{
			removeEventListener(Event.ENTER_FRAME, pointAtCursor);
		}
		
	}
	
}