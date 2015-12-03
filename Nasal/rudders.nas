# Velocity XL
#
# Custom Flight Surface Operations
#
# Gary Neely aka 'Buckaroo'
#
# Rudder/Speed Brake operations

var speedbrake   = props.globals.getNode("/controls/flight/speedbrake");
var rudder       = props.globals.getNode("/controls/flight/rudder");
var rudder_left  = props.globals.getNode("/controls/flight/rudder-left");
var rudder_right = props.globals.getNode("/controls/flight/rudder-right");

setlistener(speedbrake, func {
  if (speedbrake.getValue()) {                  # If speedbrake engaged, then set the rudders
    rudder_left.setValue(-1);                   # to max outboard values as speedbrakes.
    rudder_right.setValue(1);
  }
  else {                                        # else rudders get user input
    rudder_left.setValue(rudder.getValue());
    rudder_right.setValue(rudder.getValue());
  }
});

var rudder_loop = func {                        # If spoilers not engaged, update rudders
  if (!speedbrake.getValue()) {                 # based on user input. Rudder throw is always
    if (rudder.getValue() > 0) {                # outboard, so the inner-turn rudder is the
      rudder_right.setValue(rudder.getValue()); # only active rudder.
      rudder_left.setValue(0);
    }
    else {
      rudder_right.setValue(0);
      rudder_left.setValue(rudder.getValue());
    }
  }
  settimer(rudder_loop, 0);                     # Update at framerate
}

settimer(rudder_loop, 3);                       # Delay startup a bit to allow things to initialize
