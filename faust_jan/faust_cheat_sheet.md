# Faust - cheat sheet

> Notes taken during Faust Kadenze Course

## Declarations

```faust
declare name "Spring Reverb";
declare version "0.1";
declare author "Jan Abel";

declare interface "SmartKeyboard{
    'Number of Keyboards' : '1',
    ...
}";
```

## Enviroments Grouping

```faust
myconst = environment{
    v1 = 0.2;
    v2 = 0.5;
};

process = myconst.v1 +  myconst.v2;
```


## User Defined Functions

**Example: Dry-Wet Function**

```faust
echo(d,f) = + ~ (@(d) : *(f));
pingpong(d,f) = echo(2*d,f) <: _,@(d);

// High Order Function
// Function of a Function
drywet(fx) = _ <: _, fx : *(1-w) , *(w) :> _
    with {
        w = vslider("dry-wet[style:knob]", 0.5, 0, 1, 0.01);
    };

process = button("play") : pm.djembe(60, 0.3, 0.4,1) :drywet(echo(ma.SR/4, 0.75));
```

**Recursive Functions**

```faust
duplicate(1,x) = x;
duplicate(n,x) = x, duplicate(n-1,x)
```

```faust
count((x, xs)) = 1 + count(xs);
count(x) = 1;
```

**Pattern Matching**

```faust
revecho (N,d,a) = _ <: R(N,0) :> _
    with{
        R(0,m) = echo(d*m,0);
        R(n,m) = echo(d*m, a^n), R(n-1, m+1);
        echo(d,a) = @(d) : *(a);
    };

process = button("play") : pm.djembe(60, 0.3, 0.4, 1) : revecho(5, ma.SR/10, 0.7);
```



## Signal Generators

```faust
process = 1;
```

>y(t>=0) = 1

```faust
process = os.osc(10);
```

>y(t)=sin(2 pi 10 t)


```faust
os.triangle(frequency);
os.sawtooth(frequency);
os.square(frequency);
no.pink_noise;
no.noise;
os.impulse;
```


## Operations

### Composition

**Split(priority 1)**

```faust
A <: B
```

**Merge(priority 1)**

```faust
A :> B
```

**Sequentital(priority 2)**

```faust
A : B
```

**Parallel(priority 3)**

```
A , B
```

> y(t)= A(t), B(t)

**Recursion(priority 4)**

```
A ~ B
```

**Identiy Function ("Wire")**

```faust
_
```

> y(t) = x(t)

**Cut Function**

```
!
```

y(t) = 0, x(t)

**Example: Noise Generator**

```faust
random = +(153645176537152) ~ *(35657651);
noise = random / 2147383647.0;
process = 0.5* noise * vslider("Volume[style:knob]", 0.2, 0, 1, 0.001) <: _,_;
```

**Example: Ping Pong Echo**

```faust
echo(d,f) = + ~ (@(d) : *(f));
pingpong(d,f) = echo(2*d,f) <: _,@(d);
process = button("play") : pm.djembe(60, 0.3, 0.4,1) : pingpong(ma.SR/4, 1.1);
```


### Arithmetic

> +, -, *, /, %, ^

**3 Diffrent Types of Notation**

**Core Syntax**

```faust
process = _, 0.5 : *;
```

**Infix Notation**

```faust
process = _*0.5;
```

**Prefix Notation**

```faust
process = *(_,0.5);
```

### Comparision

> ">", ">=", "==", "!=", "<", "<="

> y(t) = 1, when x0(t) operator  x1(t), 0 otherwise

### Bitwise

> &, |, xor, <<, >>

### Trigonomic

> acos, asin, atan, atan2, cos, sin, tan

**Example: Sinewave Osciallator**

```faust
import("stdfaust.lib");
// ma.SR - Current Sampling Rate
phasor(f) = f/ ma.SR : (+,1:fmod)~_;
process = phasor(440) * 2 * ma.PI : sin; 
```

### Log. and Exp. Functions

> exp, log, log10, pow, sqrt

### Other Function

**Absolute, Minimal, Maximal**
> abs, min, max

**floor, ceil of an Float**
> floor, ceil

**Floating Point modulo, Float remainder**
> fmod, remainder

**Closest Int of given float**
> rint

**Example: Simple Distortion (Hard Clipping)**

```faust
import("stdfaust.lib");
gain = hslider("gain",0,0,1,0.01);
process = *(100) : min(1) : max (-1) : *(gain);
```

### Selectors and Casting

**Switch between signals**
> select 2, select3

**Convert samples to**
> int, float

**Example: Selection of 2 with button**

```faust
import("stdfaust.lib");
gain = hslider("gain", 0.1, 0, 1, 0.01);
process = button("440/880Hz"), os.osc(440), os.osc(880) : select2*gain;
```

**Example Selection of 3 with nentry**

```faust
import("stdfaust.lib");
gain = hslider("gain", 0.1, 0, 1, 0.01);
process = nentry("Selector", 0,0,3,1), os.osc(440), os.osc(880), os.osc(1640): select3*gain;
```

## Time based Operations

### Delaylines

**1-Sample Delay**

> mem 

**Variable number Sample Delay** 

> @

**Example: 1-Second Delay**

> process = 1, ma.SR : @;

**Example: Dirac Impulse**

```faust
import("stdfaust.lib");
dirac = 1-1';
process = dirac;
```

### Tables

**Read-only table**

> rdtable

**Example: Dirac Impulse every 4096 Samples**

```faust
import("stdfaust.lib");
dirac = 1-1';
phase = 1 : +~_ : %(4096);
process = 4096, dirac, phase : rdtable;
```

**Read-Write Table**

> rwtable

## User Interface

**Vertical slider**

```faust
vslider("name", std_value, min_value, max_value, stepsize);
```

**Knob**

```faust
vslider("name[style:knob]", std_value, min_value, max_value, stepsize);
```

**Horizontal slider**


```faust
hslider("name", std_value, min_value, max_value, stepsize);
```

**Button**

```faust
button("name");
```

**nentry**

```faust
nentry("name", std_value, min_value, max_value, stepsize)
```

**checkbox**

```faust
checkbox("name")
```

**Bargraph**

```faust
hbargraph("name", minv_value, max_value);
```

**Grouping of UI Elements**

```faust
tgroup("label", code) // Tab Group
vgroup("label", code) // Vertical Group
hgroup("label", code) // Horizontal Group
```

**Oscialltor Synth with grouped UI**

```faust
import("stdfaust.lib");

waveGenerator = hgroup("[0]Wave Generator", os.osc(freq), os.triangle(freq), os.square(freq), os.sawtooth(freq) : ba.selectn(4, wave))
with{
    wave = nentry("[0]Waveform", 0,0,3,1);
    freq = hslider("[1]freq", 440,50,2000,0.01);
};

envelope = hgroup("[1]Envelope[style:knob]", en.adsr(attack, decay, sustain, release, gate)*gain)
with{
    attack = hslider("[0]Attack[style:knob]", 50,1, 1000,1)*0.001;
    decay = hslider("[1]Decay[style:knob]", 50,1, 1000,1)*0.001;
    sustain = hslider("[2]Sustain[style:knob]", 0.8, 0.01, 1,0.01);
    release = hslider("[3]Release[style:knob]", 50,1, 1000,1)*0.001;
    gain = hslider("[4]Gain[style:knob]", 1, 0, 1, 0.01);
    gate = button("[5]gate[style:knob]");
};

 process = waveGenerator*envelope;
```

# Feedforward (One Zero) Filter

```faust
oneZero = vgroup("One Zero Filter", _ <: (_': *(b1)),_:> _)
with{
    b1 = hslider("b1", 0, -1, 1, 0.01);
};

// b1 < 0 => Highpass
// b1 > 0 => Lowpass
process = 0.1 * no.noise : oneZero;
```

# Feedback Comb Filter

```faust
fComb = +~(@(delayLength) : * (feedback))
with{
    delayLength = hslider("Delay Length", 1, 1, 10000,1);
    feedback = hslider("Feedback" , 0, 0, 1.5, 0.01);
};

process = button("gate") * os.sawtooth(440) : fComb;
```

# Echo

```faust
echo = vgroup("Echo", +~(@(delayLength-1) : * (feedback)))
with{
    duration = hslider("[0]Duration", 500, 1, 2000,1)*0.001;
    feedback = hslider("[1]Feedback", 0.5, 0, 1, 0.01);
    delayLength = ma.SR*duration;
};

process = echo;
```
