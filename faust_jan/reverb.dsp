import("stdfaust.lib");

// for Testing
source = button("play") : pm.djembe(60, 0.3, 0.4, 1), 0.25: *;

material = 5063.6968+vslider("[4] Material[style:knob]", 0,-700,500,1); // Steel - Material constant - sqrt(E/rho) in [m/s]
// material = 60; // rubber
// material = 2357; //concrete
length = 2.5116; // length of wire [m]
radius = 0.000175; // radius [m]
//damping = 0.001; 0.00005 -0.01
// q = 1/(2*damping);


q = vslider("[0] Damping[style:knob]", 500, 50 ,10000,1);

// N 447 modes in range (0-22050Hz) for steel, 2,5m length and radius of 0.175 mm
N = 42;
gain = (1/N)*vslider("[1] Amplitude[style:knob]",1 , 0, 2, 0.001);

modes(n) =  ma.PI/4 * material * radius * (1/length^2) * n^2;

// + 4 in modes function because of filter stability
modalreverb = sum(i,N, fi.resonhp(modes((i+1+4)),q,gain));

drywet(fx) = _ <: _, fx : *(1-w) , *(w) :> _
    with {
        w = vslider("[2] Dry-Wet[style:knob]", 1, 0, 1, 0.01);
    };


feedback = vslider("[3] Feedback", 0, 0, 1.5, 0.01);

process =  drywet(_<:modalreverb) <: _,_;
//process =  source <: modalreverb  <: _,_;
