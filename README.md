# Modal Spring Reverb

Implementation of a *crappy* physical spring reverb model in Faust using modal synthesis.

>Projekt in den Kursen Audiotechnik und Digitale Audiosignalverarbeitung im WS20/21 und SS21 an der BHT

---

## Some Ideas:

![Blockdiagram](https://raw.githubusercontent.com/monodon-monoceros/modal_spring_reverb/main/SpringReverb_blockdiagram.png)


* Improvement of Model in Matlab
   * Modelling of frequency dependend damping
   * Modelling of Longitudinal/Torsional Waves
   * **How many Modes are Useful??**
   * Lookuptable for biquads Filter coefficients?
* Feedback Structure
* switchable Statevariable Filter before Spring for more musicality
  * like this: https://www.youtube.com/watch?v=89rPF9J5f3A    
  * https://en.wikipedia.org/wiki/State_variable_filter
  * https://ccrma.stanford.edu/~jos/svf/svf.pdf
* Design UI
  * changeable Parameters
    * Input Gain
    * Output Volume
    * Blend/Mix
    
    * Damping
    * Material dependent Parameter - kappa
    * Geometrical dependent Parameter - length of unwinded spring

    * Filter Cuttoff Frequency
    * Filter Resonance
    * Filter Mode/Mix (LP,HP,BP)   


* Gain Elements Non-Linear?
  * Soft Clipping
  * tanh(x)
  * https://jatinchowdhury18.medium.com/complex-nonlinearities-episode-0-why-4ad9b3eed60f
  * https://ccrma.stanford.edu/~jatin/papers/Complex_NLs.pdf
    
* Is it possible to change parameters in realtime with modal approach?   


## To Do

* Learning Faust - Faust Online Course
* Implementation in Faust
   * Plugin
   * Embedded Devices - RPi / Teensy

---
## Project Plan

| KW | Date   | Task                                              |
|:-: | :-:	  | :-:	                                              |
| 14 | 06.04 	| Learning Faust (Installing, First Steps) 	        |
| 15 | 13.04  | Learning Faust 	                                  |
| 16 | 20.04  | learning Faust 	                                  |
| 17 | 27.04  | Improve Model  	                                  |
| 18 | 04.05  | Improve Model  	                                  |
| 19 | 11.05  | Implementation of Model                           |
| 20 | 18.05  | Implementation of Model                           |   
| 21 | 25.05  | Create Presentation                               |
| 22 | 01.06  | Project Presentation                              |

---
## Additional Material

### Faust Tutorials

[Faust Online Course](https://ccrma.stanford.edu/~rmichon/faustWorkshops/course2015/)

[Physical Interaction Design for Music](https://ccrma.stanford.edu/courses/250a/)

[Kadenze: Real Time Processing](https://www.kadenze.com/courses/real-time-audio-signal-processing-in-faust/info)

[Music 320C: Audio Plugin Development in FAUST and C++](https://ccrma.stanford.edu/~jos/intro320c/Schedule.html)

### Embedded Stuff

[Paper: EMBEDDED REAL-TIME AUDIO SIGNAL PROCESSING WITH FAUST](https://ifc20.sciencesconf.org/321070/document)

[Paper: Real Time Audio Digital Signal Processing With Faust and the Teensy](http://smc2019.uma.es/articles/S1/S1_03_SMC2019_paper.pdf)

[Faust on Teensy (electronics)](https://ccrma.stanford.edu/courses/250a-spring-2021/labs/2/)

[DSP on the Teensy With Faust](https://faustdoc.grame.fr/tutorials/teensy/)

### Audio DSP

[Paper: Effect Design: Reverberator and Other Filters](https://ccrma.stanford.edu/~dattorro/EffectDesignPart1.pdf)

[Audio Signal Processing in Faust](https://ccrma.stanford.edu/~jos/aspf/aspf.pdf)
