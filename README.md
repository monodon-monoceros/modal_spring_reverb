# Modal Spring Reverb

Implementation of a *crappy* physical spring reverb model in Faust using modal synthesis.

>Projekt in den Kursen Audiotechnik und Digitale Audiosignalverarbeitung im WS20/21 und SS21 an der BHT

---

## To Do:

* Improvement of Model in Matlab
   * Modelling of frequency dependend attenuation
   * Modelling of Longitudinal/Torsional Waves
   * **How many Modes are Useful??**
   * Lookuptable for biquads Filter coefficients?
* Design UI
  * changeable Parameters
    * Input Gain
    * Output Volume
    * Blend/Mix
    * Material dependent Parameter - <img src="https://render.githubusercontent.com/render/math?math=\kappa">
    * Geometrical dependent Parameter - length of unwinded spring  
* embed Algorithm in Feedback Structure maybe with Statevariable Filter before Spring
  * https://en.wikipedia.org/wiki/State_variable_filter
  * https://www.youtube.com/watch?v=89rPF9J5f3A    
* How to change Parameter in Realtime?   

* Learning Faust
* Implementation in Faust
   * Plugin
   * Embedded Devices - RPi

---
## Project Plan

| KW | Date   | Task                    |
|:-: | :-:	  | :-:	                    |
| 14 | 06.04 	| Learning Faust  	      |
| 15 | 13.04  | Learning Faust 	        |
| 16 | 20.04  | learning Faust 	        |
| 17 | 27.04  | Improve Model  	        |
| 18 | 04.05  | Improve Model  	        |
| 19 | 11.05  | Implementation of Model |
| 20 | 18.05  | Implementation of Model |   
| 21 | 25.05  | Create Presentation     |
| 22 | 01.06  | Project Presentation    |

---
## Additional Material

[Faust Online Course](https://ccrma.stanford.edu/~rmichon/faustWorkshops/course2015/)

[Paper: EMBEDDED REAL-TIME AUDIO SIGNAL PROCESSING WITH FAUST](https://ifc20.sciencesconf.org/321070/document)

[Paper: Effect Design: Reverberator and Other Filters](https://ccrma.stanford.edu/~dattorro/EffectDesignPart1.pdf)
