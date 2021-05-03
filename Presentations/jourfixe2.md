% Entwurf Nachall System mit Faust
% Gruppe 5: Abel | Hadacek | Thiele | Aïssa
% Digitale ASV Jour Fixe 04.05.21 - KW 18

# Ziele
## Hauptziele
- Echzeit Realisierung eines Federhall Effekt in **Faust**
- Implementierung eines State Variable Filter
- Erzeugung eines VST Plug-Ins
- Umsetzung auf Embedded System Teensy 4.0

## Zusätzliche Ziele
- Erweiterung des Federhalls Models
- Implemtierung von Nicht-Linearitäten

# Erreichte Ziele - KW 17
- Einarbeitung in Faust abgeschlossen
- Erste echtzeitfähige Implementierung des Federhall-Models
   - in Faust WebIDE
   - Test über 400 Schwingungsmoden
   - Echtzeit Veränderbare Parameter
      - Länge der Feder $l$ in $[m]$
      - Materialkonstante $\sqrt()$in $[\frac{m}{s}]$
      - Amplituden der Moden
      - Dämpfung der Moden
   - Instabil bei kleinen Resonanzenfrequenzen $f_r \leq 1Hz$

# To Do - KW 18: Struktur Effektgerät
![Ziel: Federhall mit SVF](https://raw.githubusercontent.com/monodon-monoceros/modal_spring_reverb/main/img/SpringReverb_blockdiagram.png)

# To Do - KW 18: Umsetzung des SVF-Filter
![State Variable Filter nach Chamberlin](https://raw.githubusercontent.com/monodon-monoceros/modal_spring_reverb/main/img/Faust%20Chamberlin%20Blockschaltbild.png)


# To Do - KW 18: Stabilisierung des Federhall Filter
![Feder Hall Modell](https://raw.githubusercontent.com/monodon-monoceros/modal_spring_reverb/194780f39cdea28c3f211d8d262ee9cc7cf287e8/faust_jan/reverb-svg/drywet-0x7fec4e341740.svg)

# To Do - KW 18: Zielplattformen
- Erste Umsetzung eines VST Plugin
- Erste Umsetzung auf Embedded System
![Zielplattformen](https://raw.githubusercontent.com/monodon-monoceros/modal_spring_reverb/main/img/vst_teensy.png)

