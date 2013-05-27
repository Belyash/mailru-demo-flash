package ru.my.config {
	import flash.events.Event;
	import flash.events.EventDispatcher;
	import flash.events.IOErrorEvent;
	import flash.net.URLLoader;
	import flash.net.URLRequest;

	/**
	 * @author alexanderdolgov
	 */
	public class ConfigLoader extends EventDispatcher {
		private var request : URLRequest;
		private var loader : URLLoader;

		/**
		 * Loading data
		 */
		public function loadData(config : String = "") : void {
			request = new URLRequest();
			request.url = (config) ? config : "settings/config.ini";
			// loading
			loader = new URLLoader();
			loader.addEventListener(Event.COMPLETE, decodeJSON);
			loader.addEventListener(IOErrorEvent.IO_ERROR, onIOError);
			loader.load(request);
		}

		/**
		 * после того как JSON загрузился
		 */
		private function decodeJSON(e : Event) : void {
			var settings : Config = Config.getInstance();
			settings.data = ru.my.config.JSON.deserialize(loader.data);
			dispatchEvent(new Event(Event.COMPLETE));
		}

		private function onIOError(event : IOErrorEvent) : void {
			trace("Loading error, settings data");
			dispatchEvent(new Event(Event.COMPLETE));
		}
	}
}
