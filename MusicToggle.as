package
{
	import flash.display.MovieClip;
	import flash.media.Sound;
	import flash.media.SoundChannel;
	
	//-----------------------
	//Purpose:				Toggles a sound on or off
	//
	//Properties:
	//	
	//Methods:
	//	
	//-----------------------
	public class MusicToggle
	{
		// Constants //
		
		//- Constants -//
		
		
		// Public Properties //
		
		public function get playing():Boolean
		{
			return _playing;
		}
		
		//- Public Properties -//
		
		
		// Private Properties //
		
		private var _playing:Boolean;
		private var _position:int;
		private var _sound:Sound;
		private var _soundChannel:SoundChannel;
		
		//- Private Properties -//
		
	
		// Initialization //
		
		public function MusicToggle(sound:Sound, soundChannel:SoundChannel)
		{
			_sound = sound;
			_soundChannel = soundChannel;
			
			_playing = true;
			_position = 0;
		}
	
		//- Initialization -//
		
		
		// Public Methods //
		
		public function Toggle():void
		{
			if (_playing == true)
			{
				_playing = false;
				_position = _soundChannel.position;
				_soundChannel.stop();
				return;
			}
			else
			{
				_playing = true;
				_soundChannel = _sound.play(_position);
			}
		}
		
		public function GetGraphics():MovieClip
		{
			var mcMusicToggle:Music_Toggle_MC = new Music_Toggle_MC();
			
			if (_playing == false)
			{
				mcMusicToggle.gotoAndStop(2);
			}
			
			return mcMusicToggle;
		}
		
		//- Public Methods -//
		
		
		// Private Methods //
		
		//- Private Methods -//
		
		
		// Testing Methods //
		
		//- Testing Methods -//
	}
}