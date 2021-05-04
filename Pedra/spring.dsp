declare name "Romulan Spring";
declare author "Dr.-Ing. Jan Abel, Dr.-Ing. Pierre-Hugues Hadacek, Dr.-Ing. Yassine Aïssa, Dr.-Ing. Steven Thiele";
declare course "Digitale Audiosignaleverarbeitung SoSe 21";
declare institution "Beuth Hochschule für Technik";

import("stdfaust.lib");








/*SVF Filter Implementation*/
TO BE DONE TILL MID MAI

//ADSR Enveloppe
svf_env = en.adsr(en_att,en_dec,en_sus,en_rel);
	with{
	en_att = hslider("Attack[style:knob]",0.5,0.05,10,0.01):si.smoo;
	en_dec = hslider("Decay[style:knob]",0.5,0.05,10,0.01):si.smoo;
	en_sus = hslider("Sustain[style:knob]",0.5,0,1,0.01):si.smoo;
	en_rel = hslider("Release[style:knob]",0.5,0.05,10,0.01):si.smoo;
	}

//Filter Block
svf_block = svf_gain*svf_filter*svf_env








/*Spring  Implementation*/
material = 5063.6968+vslider("[4] Material[style:knob]", 0,-700,1000,1); // Steel - Material constant - sqrt(E/rho) in [m/s]
// material = 60; // rubber
// material = 2357; //concrete
length = 2.5116; // length of wire [m]
radius = 0.000175; // radius [m]
//damping = 0.001; 0.00005 -0.01
// q = 1/(2*damping);


q = vslider("[0] Damping[style:knob]", 500, 50 ,10000,1);

// N 447 modes in range (0-22050Hz) for steel, 2,5m length and radius of 0.175 mm
N = 50;
gain = (1/N)*vslider("[1] Amplitude[style:knob]",1 , 0, 2, 0.001);

modes(n) =  ma.PI/4 * material * radius * (1/length^2) * n^2;

// + 4 in modes function because of filter stability
modalreverb = sum(i,N, fi .resonhp(modes((i+1+4)),q,gain));

//Physikalische Parametern



spring_block = spring(()*rev_time,()*rev_fb);









/* GUI Controls still to be ASSIGNED */

// SVF Filter
svf_gain = hslider("Gain[style:knob]",1,1,10,0.1):si.smoo;

svf_freq = hslider("Frequency[style:knob]",1,1,10,0.1):si.smoo;
svf_res = hslider("Resonance[style:knob]",1,1,10,0.1):si.smoo;

// Spring
rev_time = hslider("Time[style:knob]",2,0.1,10,0.01):si.smoo;    //to assign TO MULTIPLE PARAMETERS?
	











/* Process */


//TEST
fxline = fi.highpass(1,10000)<:modalreverb;
fxlinefeed =(+ : (fxline))~*(rev_fb);										
		rev_fb = hslider("Feedback[style:knob]",1,0,3,0.01):si.smoo;
		}


/* Dry/Wet */
drywet(fx) = _ <: _, fx : *(1-dry_wet) , *(dry_wet) :> _
    with {
        dry_wet = vslider("[2] Dry-Wet[style:knob]", 1, 0, 1, 0.01):si.smoo;
    };

// Enter the test chamber Gordon
spring_test =  drywet(_:fxlinefeed) <:si.bus(2);
process = ba.pulsen(1, 10000) : pm.djembe(60, 0.3, 0.4, 1) : spring_test;


//romulan_spring = _<:_,(svf_block<:spring_block):si.bus(2);
//process = ba.pulsen(1, 10000) : pm.djembe(60, 0.3, 0.4, 1) : romulan_spring;
