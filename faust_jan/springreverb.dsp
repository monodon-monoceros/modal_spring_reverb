import("stdfaust.lib");

// Non Linear Pre Gain
dwell = _*gain : ma.tanh
with{
    gain = hslider("[0] Dwell[style:knob]", 1,0,20,0.001) : si.smoo;
};


// Predelay
predelay = de.sdelay(0.2*ma.SR,4096, length*ma.SR)
with{
    length = 0.001*hslider("Preday[unit:ms][style:knob]", 0,0,200, 0.1):si.smoo;
};

// Linear Modal Spring Model
modalreverb = sum(i,N, fi.resonhp(modes((i+1+15)),q,1/N)) // + 15 in modes function because of filter stability
with{
    q = hslider("[1] Damping[style:knob]", 500, 50 ,5000,1) : si.smoo; //damping = 0.001; 0.00005 -0.01, q = 1/(2*damping);
    // Material constant - sqrt(E/rho), Steel = 5063, rubber = 60, concrete = 2357
    material = hslider("[2] Material[unit:m/s][style:knob]", 5063,4000,6000,1) : si.smoo;
    length = hslider("[3] Length[unit:m][style:knob]", 2.5,1.5,7.5,0.001) : si.smoo; // length of unwounded wire 
    radius = 0.000175; // in [m]

    modes(n) =  ma.PI/4 * material * radius * (1/length^2) * n^2; // in [Hz]
    N = 300; // Number of Modes
    // N 447 modes in range (0-22050Hz) for steel, 2,5m length and radius of 0.175 mm
};


// Cutoff Transition Frequency
cofilter = fi.lowpass6e(cutoff)
with{
    cutoff = hslider("[4] Cutoff [unit:Hz][style:knob]", 4500,1000,15000, 0.01):si.smoo;
};

//Effectline
fxline = predelay : dwell <: modalreverb : fi.lowpass6e(cutoff);

//Dry-Wet Signal Mixer
drywet(fx) = _ <: _, fx : *(1-w) , *(w) :> _
    with {
        w = hslider("[5] Dry-Wet[style:knob]", 0.5, 0, 1, 0.01):si.smoo;
    };

process =  drywet(fxline) <: _,_;

// To Do: Button to "kick" the Springs
// kick= 5000*button("Kick");
// fxline = _+kick: ...
