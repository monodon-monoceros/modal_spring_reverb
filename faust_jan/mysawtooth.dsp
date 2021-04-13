import("stdfaust.lib");
f = hslider("freq", 440, 100, 1000, 0.1);
g = hslider("gain", 0.5, 0, 1, 0.1);
t = button("gate");
process = os.sawtooth(f)*g*t;