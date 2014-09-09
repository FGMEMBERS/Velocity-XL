MixtureGate = func {

	var GateState = props.globals.getNode("/controls/engines/engine[0]/mixturegate").getValue();
	var MixVal = props.globals.getNode("/controls/engines/engine[0]/mixture").getValue();
	var MixMin = 0.33;

	if((MixVal < MixMin) and GateState)
	{ 
	  setprop("/controls/engines/engine[0]/mixture", MixMin);
	}

}

initialize = func {

	### Initialise Mixture Gate ###
	props.globals.getNode("/controls/engines/engine[0]/mixturegate", 1).setBoolValue(0);

}