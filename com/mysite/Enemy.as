﻿package com.mysite
{
	import flash.display.MovieClip;
	import flash.display.Stage;
	import flash.events.Event;

	public class Enemy extends MovieClip
	{

		private var newX:Number = 0;
		private var newY:Number = 0;

		private var speed:Number;

		private var speedX:Number;
		private var speedY:Number;

		private var totalDistance:Number;
		private var previousDistance:Number = 0;
		private var currentDistance:Number = 0;
		
		

		public function Enemy()
		{
			// constructor class
			this.addEventListener(Event.ADDED_TO_STAGE, onAddedToStage);
			this.addEventListener(Event.REMOVED_FROM_STAGE, onRemovedFromStage);
			
		}

		private function onAddedToStage(e:Event):void
		{
			
			this.x = this.getX();
			this.y = this.getY();
			
			speed = Math.round(1 + Math.random() * 5);

			this.addEventListener(Event.ENTER_FRAME, loop);
			//addEnemys();
		}
		
		private function onRemovedFromStage(e:Event):void
		{
			this.removeEventListener(Event.ENTER_FRAME, loop);
		}

		public function loop(e:Event):void
		{
			//enemySceneCutter();
			//x -= 1 * Math.sin(rotation * (Math.PI/180))*0.5;
			
			
			
			this.previousDistance = this.currentDistance;
			this.currentDistance = this.getDistance();

			if (this.currentDistance < this.previousDistance)
			{
				this.x +=  this.speedX;
				this.y +=  this.speedY;
				//this.x -= 1 * Math.sin(rotation * (Math.PI/180));
				//this.y += 1 * Math.cos(rotation * (Math.PI/180));

			}
			else
			{
				this.setNewPosition();
			}
		
		}

		private function setNewPosition()
		{
			this.newX = this.getX();
			this.newY = this.getY();

			this.totalDistance = this.getDistance();

			var time:Number = this.totalDistance / this.speed;

			speedX = (this.newX - this.x)/time;
			speedY = (this.newY - this.y)/time;
		}

		private function getX(): Number 
		{
			
			return Math.floor(Math.random() * 
				   (1 + (stage.stageWidth + this.width) + this.width)- this.width);
		}
		
		private function getY(): Number 
		{
			/*return Math.floor(Math.random() * 
				   (stage.stageHeight - 200));*/
			return Math.floor(Math.random() * 
				   (1 + (stage.stageHeight + this.height) + this.height) - this.height);

		}

		private function getDistance(): Number 
		{
			
			return Math.sqrt(Math.pow(this.x - this.newX,2) + 
							 Math.pow(this.y - this.newY,2));			
		}
		
		

		/*private function enemySceneCutter():void
		{
			if (x > stage.stageWidth)	
			x = 0;

			else if (x < 0) x = stage.stageWidth;

			if (y > stage.stageHeight - 450)	
			y = stage.stageHeight - 450;

			else if (y < 200) y = 200;
		}*/
	}
}