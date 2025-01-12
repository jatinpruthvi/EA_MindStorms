//+----------------------------------------------------------------------------------+
//|                                         Heiken ashi - Suavizado MTF Separado.mq4 |
//|                                                                                  |
//+----------------------------------------------------------------------------------+
#property copyright "rodolfo.leonardo@gmail.com"
#property version       "1.20"
#property link          "https://www.mql5.com/pt/users/rodolfolm"
#property description   "Indicador Heiken ashi Suavizado  MTF"
#property strict


#property indicator_chart_window
#property indicator_buffers 4
#property indicator_color1  CLR_NONE
#property indicator_color2  CLR_NONE
#property indicator_color3  CLR_NONE
#property indicator_color4  CLR_NONE
#property indicator_width3  0
#property indicator_width4  0



//------- Parametros ------------------------------------------

//extern string note1 = "Chart Time Frame"; // note1
//extern string note2 = "0=current time frame";// note2
//extern string note3 = "1=M1, 5=M5, 15=M15, 30=M30";// note3
//extern string note4 = "60=H1, 240=H4, 1440=D1";// note4
//extern string note5 = "10080=W1, 43200=MN1";// note5
//extern int TFBar       = 1440;           // TimeFrame

extern ENUM_TIMEFRAMES    TFBar = PERIOD_CURRENT;   // Time frame to use
extern bool bcgr       = false;           // BackGround
extern int NumberOfBar = 2000;           // Número de barras
extern color ColorUp   = DarkGreen;//Cor de compra
extern color ColorDown = Maroon;//Cor de venda
extern color ColorUpOC   = Teal;//Cor de compra
extern color ColorDownOC = Crimson;//Cor de venda
extern bool PaintBar0 = true;//Pinta Barra Atual
extern bool Shadown = true;//Sombra
extern bool OC = true;//OC
extern int HmaPeriod = 30;
extern int NextHigherAuto    = 1;
//+------------------------------------------------------------------+
double bufferHc[];
double bufferHo[];
double bufferHh[];
double bufferHl[];
double working[][8];
int    HalfPeriod;
int    HullPeriod;
extern string magic ="A";

#define _hrOpen  0
#define _haOpen  1
#define _hrClose 2
#define _haClose 3
#define _hrHigh  4
#define _haHigh  5
#define _hrLow   6
#define _haLow   7

//+------------------------------------------------------------------+
//| Custom indicator initialization function                         |
//+------------------------------------------------------------------+
void init() {
if ( TFBar == 0 )
    TFBar = Period();
  if ( NextHigherAuto > 0 ){
  
  for (int i=0;i< NextHigherAuto;i++){
       TFBar = GetHigherTimeFrame( TFBar ) ;
   }
   
   }
  
   int i;
   int StartBar = 0;   // added by RaptorUK
 //  magic="S"+HmaPeriod;
   
   if(!PaintBar0) StartBar = 1;   // RaptorUK added by RaptorUK

   
  for (i=StartBar; i<NumberOfBar; i++) {  // RaptorUK modded from 0 to StartBar
  if(Shadown)
    ObjectDelete(magic+"BodyTF"+TFBar+"Bar"+i);
    
      if(OC)
  ObjectDelete(magic+"SBodyTF"+TFBar+"Bar"+i);

  }
  
  
  for (i=StartBar; i<NumberOfBar; i++) {  // modded from 0 to StartBar
  
  if(Shadown)
    ObjectCreate(magic+"BodyTF"+TFBar+"Bar"+i, OBJ_RECTANGLE, 0, 0,0, 0,0);
    
     if(OC)
   ObjectCreate(magic+"SBodyTF"+TFBar+"Bar"+i, OBJ_RECTANGLE, 0, 0,0, 0,0);

  }
  
     SetIndexBuffer(0,bufferHh); SetIndexStyle(0,DRAW_HISTOGRAM);
   SetIndexBuffer(1,bufferHl); SetIndexStyle(1,DRAW_HISTOGRAM);
   SetIndexBuffer(2,bufferHc); SetIndexStyle(2,DRAW_HISTOGRAM);
   SetIndexBuffer(3,bufferHo); SetIndexStyle(3,DRAW_HISTOGRAM);
   
   //
   //
   //
   //
   //
      
   HmaPeriod  = MathMax(2,HmaPeriod);
   HalfPeriod = MathFloor(HmaPeriod/2.0);
   HullPeriod = MathFloor(MathSqrt(HmaPeriod));
   
  Comment("");
}

//+------------------------------------------------------------------+
//| Custor indicator deinitialization function                       |
//+------------------------------------------------------------------+
void deinit() {
 
 
   int StartBar = 0;   // added by RaptorUK
   
   if(!PaintBar0) StartBar = 1;   // added by RaptorUK


  for (int i=StartBar; i<NumberOfBar; i++) {  // RaptorUK modded from 0 to StartBar
    ObjectDelete(magic+"BodyTF"+TFBar+"Bar"+i);
   

  }
  for (int i=StartBar; i<NumberOfBar; i++) {  // RaptorUK modded from 0 to StartBar
    ObjectDelete(magic+"SBodyTF"+TFBar+"Bar"+i);
   

  }
  Comment("");
}

//+------------------------------------------------------------------+
//| Custom indicator iteration function                              |
//+------------------------------------------------------------------+
int start() {

int counted_bars=IndicatorCounted();
   int i,r,limit;

bool OK_Period=false;   
  switch (TFBar)
  {    
    case 0:OK_Period=true;break;
    case 1:OK_Period=true;break;
    case 5:OK_Period=true;break;
    case 15:OK_Period=true;break;
    case 30:OK_Period=true;break;
    case 60:OK_Period=true;break;
    case 240:OK_Period=true;break;
    case 1440:OK_Period=true;break;
    case 10080:OK_Period=true;break;
    case 43200:OK_Period=true;break;
  }
  if (OK_Period==false)
     {
        Comment("TFBar != 1,5,15,30,60,240(H4), 1440(D1),10080(W1), 43200(MN) !");   

       return(0);
     }
  if (Period()>TFBar  && TFBar != 0) 
  {
    Comment("mCandles: TFBar<"+Period());

    return(0);
  }
  

  double   po, pc;       // Öåíû îòêðûòèÿ è çàêðûòèÿ ñòàðøèõ ñâå÷åê
  double   ph=0, pl=500; // Öåíû õàé è ëîó ñòàðøèõ ñâå÷åê
  datetime to, tc, ts;   // Âðåìÿ îòêðûòèÿ, çàêðûòèÿ è òåíåé ñòàðøèõ ñâå÷åê


    
  
   if(counted_bars<0) return(-1);
   if(counted_bars>0) counted_bars--;
         limit = Bars-counted_bars;
         if (ArrayRange(working,0) != Bars) ArrayResize(working,Bars);



 int TF = TFBar;
 
   for(i=limit, r=Bars-i-1; i >= 0; i--,r++)
   {
    if(0 <= r && r < Bars && 0 <= i && i < Bars-1){
      working[r][_hrOpen]  = iMA(NULL,TF,HalfPeriod,0,MODE_LWMA,PRICE_OPEN,i)*2-iMA(NULL,TF,HmaPeriod,0,MODE_LWMA,PRICE_OPEN,i);
      working[r][_haOpen]  = iLwma(_hrOpen,HullPeriod,r);
      working[r][_hrClose] = iMA(NULL,TF,HalfPeriod,0,MODE_LWMA,PRICE_CLOSE,i)*2-iMA(NULL,TF,HmaPeriod,0,MODE_LWMA,PRICE_CLOSE,i);
      working[r][_haClose] = iLwma(_hrClose,HullPeriod,r);
      working[r][_hrHigh]  = iMA(NULL,TF,HalfPeriod,0,MODE_LWMA,PRICE_HIGH,i)*2-iMA(NULL,TF,HmaPeriod,0,MODE_LWMA,PRICE_HIGH,i);
      working[r][_haHigh]  = iLwma(_hrHigh,HullPeriod,r);
      working[r][_hrLow]   = iMA(NULL,TF,HalfPeriod,0,MODE_LWMA,PRICE_LOW,i)*2-iMA(NULL,TF,HmaPeriod,0,MODE_LWMA,PRICE_LOW,i);
      working[r][_haLow]   = iLwma(_hrLow,HullPeriod,r);
      
    
      
      double haOpen  = (bufferHo[i+1]+bufferHc[i+1])/2.0; 
      double haClose = (working[r][_haOpen]+working[r][_haClose]+working[r][_haHigh]+working[r][_haLow])/4.0;
      double haHigh  = MathMax(working[r][_haHigh],MathMax(haOpen,haClose));
      double haLow   = MathMin(working[r][_haLow] ,MathMin(haOpen,haClose));

      if (haOpen<haClose) 
         {
            bufferHl[i]=haLow;
            bufferHh[i]=haHigh;
            
             ph = haHigh; 
             pl = haLow; 
         } 
      else
         {
            bufferHh[i]=haLow;
            bufferHl[i]=haHigh;
            
             ph = haLow; 
             pl = haHigh; 
             
         }
         
      bufferHo[i]=haOpen;
      bufferHc[i]=haClose;
      
      po = haOpen;
      pc = haClose;
      
      to = iTime(Symbol(), TFBar, i);
      tc = iTime(Symbol(), TFBar, i) + TFBar*60;
      


       if(Shadown){
     //-------------------------------
      ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_TIME1, to);  //âðåìÿ îòêðûòèÿ
      ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_PRICE1, ph); //öåíà îòêðûòèÿ
      ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_TIME2, tc);  //âðåìÿ çàêðûòèÿ
      ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_PRICE2, pl); //öåíà çàêðûòèÿ
      ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_WIDTH, 2);
      ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_BACK, bcgr);
      }
    //-------------------------------
    
      if(OC && bcgr == false){
   //-------------------------------
      ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_TIME1, to);  //âðåìÿ îòêðûòèÿ
      ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_PRICE1, po); //öåíà îòêðûòèÿ
      ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_TIME2, tc);  //âðåìÿ çàêðûòèÿ
      ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_PRICE2, pc); //öåíà çàêðûòèÿ
      ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_STYLE, STYLE_SOLID);
      ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_WIDTH, 2);
      ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_BACK, true);
    //-------------------------------
    }
 
 
 
       //-------------------------------
       if (haOpen<haClose) {
         if(Shadown)
          ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_COLOR, ColorUp);
            if(OC)
          ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_COLOR, ColorUpOC);
 
        } else {
           if(Shadown)
          ObjectSet(magic+"BodyTF"+TFBar+"Bar"+i, OBJPROP_COLOR, ColorDown);
           if(OC)
          ObjectSet(magic+"SBodyTF"+TFBar+"Bar"+i, OBJPROP_COLOR, ColorDownOC);

        
     
     }     
     
      }
   }
   
   //
   //
   //
   //
   
    

      
      
  
  return(0);
}
//+------------------------------------------------------------------+


double iLwma(int forBuffer, int period, int shift)
{
   double weight=0;
   double sum   =0;
   int    i,k;
   
   if (shift>=period)
   {
      for (i=0,k=period; i<period; i++,k--)
      {
            weight += k;
            sum    += working[shift-i][forBuffer]*k;
        }
        if (weight !=0)
                return(sum/weight);
        else    return(0.0);
    }
    else return(working[shift][forBuffer]);
}


int GetHigherTimeFrame(int CurrentPeriod )
{
  if ( CurrentPeriod == 0 ) CurrentPeriod = Period();
  if(      CurrentPeriod == 1 )     { return(5); }
  else if( CurrentPeriod == 5 )     { return(15); }
  else if( CurrentPeriod == 15 )    { return(30); }
  else if( CurrentPeriod == 30 )    { return(60); }
  else if( CurrentPeriod == 60 )    { return(240); }
  else if( CurrentPeriod == 240 )   { return(1440); }
  else if( CurrentPeriod == 1440 )  { return(10080); }
  else if( CurrentPeriod == 10080 ) { return(43200); }
  else if( CurrentPeriod == 43200 ) { return(43200); }
  
   return(0);
} // int GetHigherTimeFrame()


string TF2Str(int iPeriod) {
  switch(iPeriod) {
    case PERIOD_M1: return("M1");
    case PERIOD_M5: return("M5");
    case PERIOD_M15: return("M15");
    case PERIOD_M30: return("M30");
    case PERIOD_H1: return("H1");
    case PERIOD_H4: return("H4");
    case PERIOD_D1: return("D1");
    case PERIOD_W1: return("W1");
    case PERIOD_MN1: return("MN1");
    default: return("M"+iPeriod);
  }
  return(0);
}