# Faust - cheat sheet

## Signal Generators

> process = 1;

*y(t>=0) = 1*

> process = os.osc(10);

*y(t)=sin(2 pi 10)*

---

## Operations

### Composition

**Split(priority 1)**

> A <: B

**Merge(priority 1)**

> A :> B

**Sequentital(priority 2)**

> A : B

**Parallel(priority 3)**

> A , B

*y(t)= A(t), B(t)*

**Recursion(priority 4)**

> A ~ B


**Identiy Function ("Wire")**

> _

*y(t) = x(t)*

**Cut Function**

> !

*y(t) = 0, x(t)*


### Arithmetic

> +, -, *, /, %, ^

**3 Diffrent Types of Notation**

**Core Syntax**

> process = _, 0.5 : *;

**Infix Notation**

> process = _*0.5;

**Prefix Notation**

> process = *(_,0.5);

### Comparision

> ">", ">=", "==", "!=", "<", "<="

*y(t) = 1, when x0(t) operator  x1(t), 0 otherwise*

### Bitwise

> &, |, xor, <<, >>

### Trigonomic

> acos, asin, atan, atan2, cos, sin, tan

**Example: Sinewave Osciallator**

> import("stdfaust.lib");
> // ma.SR - Current Sampling Rate
> phasor(f) = f/ ma.SR : (+,1:fmod)~_;
> process = phasor(440) * 2 * ma.PI : sin; 

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
> import("stdfaust.lib");
> gain = hslider("gain",0,0,1,0.01);
> process = *(100) : min(1) : max (-1) : *(gain);

### Selectors and Casting

**Switch between signals**
> select 2, select3

**Convert samples to**
> int, float

**Example: Selection of 2 with button**

> import("stdfaust.lib");
> gain = hslider("gain", 0.1, 0, 1, 0.01);
> process = button("440/880Hz"), os.osc(440), os.osc(880) : select2*gain;


**Example Selection of 3 with nentry**

> import("stdfaust.lib");
> gain = hslider("gain", 0.1, 0, 1, 0.01);
> process = nentry("Selector", 0,0,3,1), os.osc(440), os.osc(880), os.osc(1640): select3*gain;

---

## Time based Operations

### Delaylines

**1-Sample Delay**

> mem 

**Variable number Sample Delay** 

> @

**Example: 1-Second Delay**

> process = 1, ma.SR : @;

**Example: Dirac Impulse**

> import("stdfaust.lib");
> dirac = 1-1';
> process = dirac;


### Tables

**Read-only table**

> rdtable

**Example: Dirac Impulse every 4096 Samples**

> import("stdfaust.lib");
> dirac = 1-1';
> phase = 1 : +~_ : %(4096);
> process = 4096, dirac, phase : rdtable;

**Read-Write Table**

> rwtable

---

## User Interface

**Vertical slider**
> vslider("name", std_value, min_value, max_value, stepsize);

**Knob**

'''
vslider("name[style:knob]", std_value, min_value, max_value, stepsize);
'''

**Horizontal slider**
> hslider("name", std_value, min_value, max_value, stepsize);


**Button**

> button("name");

**nentry**

> nentry("name", std_value, min_value, max_value, stepsize)



---
