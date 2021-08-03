package kadabra.states;

import haxe.Constraints.Function;
import haxe.ds.StringMap;
import haxe.xml.Access;

class States<T>
{
	public var current(default, set):Null<String>;
	var _current:Null<String>;
	
	public var states:Array<StateNode<T>>;
	
	public var onAdd:(T -> String -> Void);
	public var onRemove:(T -> String -> Void);
	
	var _cache:Array<StateNode<T>>;
	var _initialized:Bool;

	public function new() 
	{
		states = [];
		_initialized = false;
	}
	
	public function add(element:T, states:String, transitionIn:String = "", transitionOut:String = "", transitionHover:String = "", transitionUp:String = ""):Void
	{
		this.states.push(new StateNode<T>(element, states, transitionIn, transitionOut, transitionHover, transitionUp));
	}
	
	public function set_current(value:String):String
	{
		getState(value);
		return value;
	}
	
	/**
	 * Change the state and get all current nodes
	 * @param	state
	 * @return all current node (to display or whatever)
	 */
	public function getState(state:String = ""):Array<StateNode<T>>
	{
		if (_current == state)
		{
			return getCache();
		}else if (_current == null)
		{
			_cache = [];
			_current = state;
			return getCache();
		}else{
			_current = state;
			
			return getCache(true);
		}
	}
	
	function getCache(clear:Bool = false):Array<StateNode<T>>
	{
		if (clear) {
			
			//TODO transition out all but default
			var i = _cache.length;
			while (--i >= 0)
			{
				var node = _cache[i];
				if (!node.isDefaultState() && !node.hasState(_current))
				{
					if (onRemove != null)
					{
						onRemove(node.element, node.transitionOut);
					}
					 _cache.splice(i, 1);
				}
			}
			
			for (node in states)
			{
				if (node.hasState(_current) && !node.isDefaultState())
				{
					if (onAdd != null)
					{
						onAdd(node.element, node.transitionIn);
					}
					_cache.push(node);
				}
			}
		}else if (!_initialized){
			
			for (node in states)
			{
				if (node.hasState(_current))
				{
					if (onAdd != null)
					{
						onAdd(node.element, node.transitionIn);
					}
					_cache.push(node);
				}
			}
			_initialized = true;
		}
		
		return _cache;
		
		
	}
	
}