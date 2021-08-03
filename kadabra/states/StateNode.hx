package kadabra.states;
import haxe.ds.StringMap;


class StateNode<T>
{
	public inline static var DEFAULT:String = "";
	
	public var states:Array<String>;
	
	public var element:T;
	
	public var transitionIn:String;
	public var transitionOut:String;
	public var transitionHover:String;
	public var transitionUp:String;

	public function new( element:T, states:String, transitionIn:String = "", transitionOut:String = "", transitionHover:String = "", transitionUp:String = "" ) 
	{
		this.states = parseState(states);
		this.element = element;
		this.transitionIn = transitionIn;
		this.transitionOut = transitionOut;
		this.transitionHover = transitionHover;
		this.transitionUp = transitionUp;
	}
	
	inline private function parseState(state:String):Array<String>
	{
		return state.split(",");
	}
	
	/**
	 * 
	 * @param	State
	 * @return
	 */
	public function hasState(state:String):Bool
	{
		if (state == DEFAULT)
			return states[0] == DEFAULT;
		if (state.indexOf(",") != -1)
		{
			var check = false;
			for (s in state.split(","))
			{
				if (state.indexOf(s) != -1)
					return true;
			}
			return false;
		}
		return state.indexOf(state) != -1;
		
	}
	
	public function isDefaultState():Bool
	{
		return states[0] == DEFAULT;
	}
	
}