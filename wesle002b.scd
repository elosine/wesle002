(s.options.numInputBusChannels = 4;
s.options.memSize_(65536 * 8);
s.waitForBoot{
	e = Buffer.read(s,"/Users/jwy/Documents/GitHub/wesle002/grainEnv/gEnv_expodec.aif");
	SynthDef(\wesle002, {
		arg amp=1, outCh = 0, inCh=0, envBuf, thresh=0.55, grDurA=0.055, grDurB=0.085, delayTime= 0.165, damp= 0.5, size=0.1, diff= 0.707, feedback= 0.4, modDepth= 0.0, modFreq= 0, mix=0.8;
		var src, chain, trig, grain, ghGrain, sig;
		src = SoundIn.ar(inCh);
		chain = FFT(LocalBuf(512), src);
		trig = Onsets.kr(chain, thresh, \rcomplex);
		grain = GrainIn.ar(2, trig, TRand.kr(grDurA,grDurB,trig), src, TRand.kr(-1,1,trig), envBuf);
		ghGrain = Greyhole.ar([grain,grain], delayTime, damp, size, diff, feedback, modDepth, modFreq);
		sig = Mix.ar([grain*mix, ghGrain*(1.0-mix)]);
		Out.ar(outCh, sig*amp);
	}).add;
})
x = Synth(\wesle002, [\envBuf,e]);
x.set(\inCh, 2);