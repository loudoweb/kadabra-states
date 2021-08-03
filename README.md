# kadabra-states

States manager of objects.

## How to use

```
var tileState = new States();
//add a node to the state manager, by default all states with empty string will always be activated 
tileState.add(p, states, transin, transitionout);
//add callback to handle adding to display list (or whatever) and transition in
tileState.onAdd = onAdd.bind(_,_,tileContainer);
//remove callback to handle removing from display list (or whatever) and transition out
tileState.onRemove = onRemove;
//change the current state => all nodes with empty string and state == "pulse" will be activated
tileState.current = "pulse";
```
