package com.mysite {
	
	import flash.display.MovieClip;
	import flash.display.*;
	import flash.events.*;
	
	public class Launcher extends MovieClip {
		
		
		public function Launcher() {
			addEventListener(Event.ENTER_FRAME, pointAtCursor);
		}
		public function pointAtCursor(event:Event) {
// get relative mouse location
var dx:Number = mouseX - this.x;
var dy:Number = mouseY - this.y;
var cursorAngle:Number = Math.atan2(dy,dx);
var cursorDegrees:Number = 360*(cursorAngle/(2*Math.PI));
// point at cursor
this.rotation = cursorDegrees;
}
		
	}
	
}