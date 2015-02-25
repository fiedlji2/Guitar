rec=dsp.AudioRecorder;
rec.SampleRate=8192;

while 1<2;
    y=step(rec); 
    %pause(0.001);
    sound(y,rec.SampleRate);
    %plot(y);      
end    