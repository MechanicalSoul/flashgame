package com.mysite {
	
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.events.KeyboardEvent;
	import flash.ui.Keyboard;
	import flash.events.Event;
	import com.senocular.KeyObject;
	import flash.display.Stage;
	import flash.text.TextField;
	import fl.transitions.Tween;
	import fl.transitions.easing.*;
	
	public class Base extends MovieClip {
		public function Base() {
			trace("ff");
			stage.stageHeight = 1000;
			stage.stageWidth = 1000;
			//var stageRef:Stage;
			//var key:KeyObject = new KeyObject(stageRef);
			var menu:Menu = new Menu();
			//var cow:Cowboy = new Cowboy();
			
			addEventListener(Event.ENTER_FRAME, EnterFrame);
			
			
			//stage.addChild(cow);
			stage.addChild(menu);
			/*cow.x = stage.stageWidth/2;
			cow.y = stage.stageHeight/2;*/
			/*ourCowboy.addEventListener(MouseEvent.CLICK, clicker);
			stage.addEventListener(KeyboardEvent.KEY_DOWN, keydownFunction);
			stage.addEventListener(KeyboardEvent.KEY_UP, keyupFunction);
			*/
		}
		
		
		
		
		public function EnterFrame(e:Event):void
		{
			/*if(key.isDown(Keyboard.LEFT))
			{
				rotation += speed;
			}*/
		}
		
		
	
		/*public function clicker(e:MouseEvent):void
		{
			
			trace("111");
			var xScale:Tween = new Tween(e.currentTarget, "scaleX", Elastic.easeOut, 1, 2, 5, true);
			var yScale:Tween = new Tween(e.currentTarget, "scaleY", Elastic.easeOut, 1, 2, 5, true);
		}*/
		
		
		
		
		/*
		public function keydownFunction(event:KeyboardEvent):void
		{
			if(event.keyCode == Keyboard.LEFT)
			{
				x += -5;
			}
		}
		public function keyupFunction(event:KeyboardEvent):void
		{
			
		}*/

	}
	
}