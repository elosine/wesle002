(s.options.numInputBusChannels = 4;
s.waitForBoot{
	m = ServerMeter.new(s, 4, 2);

	b = Buffer.read(s, "/Users/jwy/Documents/GitHub/wesle002/shortnotes.aif");
	e = Buffer.read(s,"/Users/jwy/Documents/GitHub/wesle002/grainEnv/gEnv_expodec.aif");

	SynthDef(\wesle002, {
		arg out = 0, buf = 0, envBuf, trackFall= 0.2, slowLag= 0.2, fastLag= 0.004, fastMul= 0.5, thresh= 0.05, minDur= 0.1, grDurA=0.1, grDurB=0.25;
		var src,trig,sig;
		// src = PlayBuf.ar(1,buf,loop:1);
		src = SoundIn.ar(2);
		trig = Coyote.kr(src,trackFall, slowLag, fastLag, fastMul, thresh, minDur);
		sig = GrainIn.ar(2,trig,TRand.kr(grDurA,grDurB,trig), src, TRand.kr(-1,1,trig), envBuf );
		Out.ar(out, sig);
	}).add;
})
x = Synth(\wesle002, [\buf,b,\envBuf,e]);
x.set(\fastMul, 0.8);
x.set(\trackFall, 0.2);
x.set(\fastLag, 0.004);
x.set(\thresh, 0.05);
x.set(\slowLag, 0.10);
x.set(\grDurA, 0.035, \grDurB, 0.062);