% Entwurf Nachall System mit Faust
% Gruppe 5: Abel | Hadacek | Thiele | Aïssa
% Digitale ASV Jour Fixe 04.05.21 - KW 18

# Ziele
## Hauptziele
- Echzeit Realisierung eines Federhall aus Audiotechnik in **Faust**
- Programmierung eines SVF-Filter
- Erzeugung eines VST Plug-Ins
- Umsetzung auf Embedded System auf Teensy Model 4.0

## Zusätzliche Ziele
- Erweiterung des Federhalls Models
- Implemtierung von Nicht-Linearitäten

# Erreichte Ziele - KW 17
- Einarbeitung in Faust abgeschlossen
- Erste echtzeitfähige Implementierung des Federhall-Models
   - in Faust Web Ide
   - über 400 Schwingungsmoden
   - Echtzeit Veränderbare Parameter
      - Länge der Feder $[m]$
      - Materialkonstante $[\frac{m}{s}]$
      - Amplituden der Moden
      - Dämpfung der Moden
   - Instabil bei kleinen Resonanzenfrequenzen $f_r \leq 1Hz$

# To Do - KW 18
- Umsetzung des SVF-Filter
- Stabilisierung des Federhall Filter
- Umsetzung der Struktur des Effektgerät
- Erste Umsetzung auf Embedded System
- Erste Umsetzung eines VST Plugin
![Zielmodel](SpringReverb_blockdiagram.png)

