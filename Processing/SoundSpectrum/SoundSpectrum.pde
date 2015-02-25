import ddf.minim.analysis.*;
import ddf.minim.*;

Minim minim;
AudioInput in;
AudioOutput out;
FFT fft;
int buffer = 1024;
InputOutputBind signal;

void setup()
{
  size(1024, 500, P3D);
  
  minim = new Minim(this);
  out = minim.getLineOut(Minim.STEREO, buffer);
  in = minim.getLineIn(Minim.STEREO, buffer);
  
  signal = new InputOutputBind(buffer);
  in.addListener(signal);
  out.addSignal(signal);
  fft = new FFT(in.bufferSize(), in.sampleRate());  
  textFont(createFont("Arial", 16));
}

void draw()
{
  background(0);
  fft.forward(in.mix);
  for(int i = 0; i < 500; i++)
  {
    //line(i, height, i, height - fft.getBand(i)*4);
    fill(255);
    rect(10*i,height,10,-fft.getBand(i)*6);
  }
}

class InputOutputBind implements AudioSignal, AudioListener
{
  private float[] leftChannel ;
  private float[] rightChannel;
 InputOutputBind(int sample)
  {
    leftChannel = new float[sample];
    rightChannel= new float[sample];
  }
  // This part is implementing AudioSignal interface, see Minim reference
  void generate(float[] samp)
  {
    arraycopy(leftChannel,samp);
  }
  void generate(float[] left, float[] right)
  {
     arraycopy(leftChannel,left);
     arraycopy(rightChannel,right);
  }
 // This part is implementing AudioListener interface, see Minim reference
  synchronized void samples(float[] samp)
  {
     arraycopy(samp,leftChannel);
  }
  synchronized void samples(float[] sampL, float[] sampR)
  {
    arraycopy(sampL,leftChannel);
    arraycopy(sampR,rightChannel);
  }  
} 

