import("stdfaust.lib");

// Non Linear Pre Gain
dwell = _*hslider("[0] Dwell[style:knob]", 1,0,10,0.001) : ma.tanh;

// Modal Reverb
material = hslider("[2] Material[style:knob]", 5063,4000,6000,1); // Material constant - sqrt(E/rho) in [m/s]
// Steel = 5063, rubber = 60, concrete = 2357
length = hslider("[3] Length[style:knob]", 2.5,1.5,7.5,0.001); // length of wire [m]
radius = 0.000175; // radius [m]
q = hslider("[1] Damping[style:knob]", 500, 50 ,5000,1);
//damping = 0.001; 0.00005 -0.01, q = 1/(2*damping);

// N 447 modes in range (0-22050Hz) for steel, 2,5m length and radius of 0.175 mm
N = 200;
modes(n) =  ma.PI/4 * material * radius * (1/length^2) * n^2; // in [Hz]
modalreverb = sum(i,N, fi.resonhp(modes((i+1+15)),q,1/N)); // + 15 in modes function because of filter stability

// Transition Frequencys of Spring Reverb
cutoff = hslider("[4] Cutoff [style:knob]", 4500,1000,15000, 0.01);

fxline = dwell <: modalreverb : fi.lowpass6e(cutoff);

//Dry-Wet Signal Mixer
drywet(fx) = _ <: _, fx : *(1-w) , *(w) :> _
    with {
        w = hslider("[5] Dry-Wet[style:knob]", 0.5, 0, 1, 0.01):si.smoo;
    };

process =  drywet(fxline) <: _,_;

// To Do: Button to "kick" the Springs
// kick= 5000*button("Kick");
// fxline = _+kick: ...
