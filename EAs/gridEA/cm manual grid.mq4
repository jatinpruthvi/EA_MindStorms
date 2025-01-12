//+------------------------------------------------------------------+
//|                               Copyright © 2016, Õëûñòîâ Âëàäèìèð |
//|                                                cmillion@narod.ru |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2016, http://cmillion.ru"
#property link      "cmillion@narod.ru"
#property strict
#property description "Ñîâåòíèê âûñòàâëÿåò ñåòè è ïîìîãàåò ñîáèðàòü ïðîôèò ñ ëþáîãî äâèæåíèÿ"

/*Ñîâåòíèê ñåòåâîé ïîìîùíèê

Êíîïêè ñîâåòíèêà
"Buy Stop" - îòêðûâàòü ñåòü îòëîæåííûõ ñòîï îðäåðîâ íà ïðîäàæó
"Sell Stop" - îòêðûâàòü ñåòü îòëîæåííûõ ñòîï îðäåðîâ íà ïîêóïêó
"Buy Limit"- îòêðûâàòü ñåòü îòëîæåííûõ ëèìèò îðäåðîâ íà ïðîäàæó
"Sell Limit" - îòêðûâàòü ñåòü îòëîæåííûõ ëèìèò îðäåðîâ íà ïîêóïêó
"Close Buy" - êíîïêà çàêðûòèÿ âñåé ñåòè è âñåõ îòêðûòûõ ïîçèöèé íà ïîêóïêó
"Close Sell" - êíîïêà çàêðûòèÿ âñåé ñåòè è âñåõ îòêðûòûõ ïîçèöèé íà ïðîäàæó
"Close" - êíîïêà çàêðûòèÿ âñåé ñåòè è âñåõ îòêðûòûõ ïîçèöèé
"Tral Profit" - êíîïêà ïðè íàæàòèè êîòîðîé ñîâåòíèê áóäåò òðàëèòü ïðîôèò âñåõ ïîçèöèé íà÷èíàÿ îò TralStart 

Â íàñòðîéêàõ ñîâåòíèêà
OrdersBuyStop - êîë-âî îðäåðîâ ñåòè BuyStop
OrdersSellStop - êîë-âî îðäåðîâ ñåòè SellStop
OrdersBuyLimit - êîë-âî îðäåðîâ ñåòè BuyLimit
OrdersSellLimit - êîë-âî îðäåðîâ ñåòè SellLimit

StepBuyStop - øàã îðäåðîâ ñåòè BuyStop
StepSellStop - øàã îðäåðîâ ñåòè SellStop
StepBuyLimit - øàã îðäåðîâ ñåòè BuyLimit
StepSellLimit - øàã îðäåðîâ ñåòè SellLimit
---------------------
Lot - ëîò ïåðâîãî îðäåðà îò öåíû, äàëåå ïî ôîðìóëå
LotPlus - äîáàâêà ê íà÷àëüíîìó ëîòó

Íàïðèìåð 
Lot = 0.1
LotPlus = 0.1

ïåðâûé ëîò 0.1    
âòîðîé     0.1+0.1=0.2 
òðåòèé     0.2+0.1=0.3 
÷åòâ¸ðòûé  0.3+0.1=0.4  
---------------------
FirstLevel - Ðàñòîÿíèå îò öåíû äî ïåðâîãî îðäåðà ( åñëè 0 òî îòêðûâàåòñÿ ñ óðîâíåì ñòîïëåâåë )
========================================
Ôèêñàöèÿ ïðèáûëè 2-âà ñïîñîáà:
ProfitClose - ïðèáûëü â âàëþòå äåïîçèòà ( íàïðèìåð ñòàâèì 100$ïðè äîñòèæåíèè îáùåé ïðèáûëè ñåòêè 100$ , îíà çàêðîåòñÿ)
TralStart  - ïðîôèò äëÿ ñòàðòà òðàëà â âàëþòå äåïîçèòà íàïðèìåð 50$
TralClose  -  çàêðûâàåòñÿ ïðè ñíèæåíèè ïðèáûëè íàïðèìåð òå æå 20$
Ïðèáûëü äîñòèãëà 50, âêëþ÷èëñÿ òðàë, ïðèáûëü ïðîäîëæèëà ðàñòè äî 60, ïîòîì îòêàòèëàñü íà 20 è âñå çàêðûëîññü ïðè 40$ ïðîôèòà
îòëîæêè óäàëÿþòñÿ, âûñêàêèâàåò àëåðò ñ âîïðîñîì ïðîäîëæèòü ðàáîòó? Ïðè îòâåòå Î Ê - âûñòàâëÿåòñÿ ñíîâà. 
=========================================
Îñîáåííîñòè çàêðûòèÿ îðäåðîâ
Ñíà÷àëà ñîâåòíèê ïûòàåòñÿ çàêðûòü âñå îðäåðà âñòðå÷íî, ïîòîì çàêðûâàåì ðûíî÷íûå, íà÷èíàÿ ñ ñàìûõ áîëüøèõ îáúåìîâ à ïîòîì îòëîæêè..
//--------------------------------------------------------------------*/
extern int     OrdersBuyStop     = 5;
extern int     OrdersSellStop    = 5;
extern int     OrdersBuyLimit    = 5;
extern int     OrdersSellLimit   = 5;
extern string _="";
extern int     FirstLevel        = 5;
extern int     StepBuyStop       = 10;
extern int     StepSellStop      = 10;
extern int     StepBuyLimit      = 10;
extern int     StepSellLimit     = 10;

extern string __="";
  
extern double  Lot               = 0.10;
extern double  LotPlus           = 0.10;

extern string ___="";
  
extern double  CloseProfitB         = 10;
extern double  CloseProfitS         = 10;
extern double  ProfitClose          = 10;
extern double  TralStart            = 10;
extern double  TralClose            = 5;

extern int     slippage             = 5;
extern int     Magic                = -1;
//--------------------------------------------------------------------
double STOPLEVEL;
double StopProfit=0;
string val, GV_kn_BS, GV_kn_SS, GV_kn_BL, GV_kn_SL,GV_kn_TrP,GV_kn_CBA,GV_kn_CSA,GV_kn_CA;
bool D,LANGUAGE;
//-------------------------------------------------------------------- 
int OnInit()
{ 
   int AN=AccountNumber();
   string FIO=AccountName();
   DrawLABEL("cm","© http://cmillion.ru/",5,5,clrGray,ANCHOR_LEFT_LOWER,2);

   EventSetTimer(1);
   LANGUAGE=TerminalInfoString(TERMINAL_LANGUAGE)=="Russian";
   if (IsTesting()) ObjectsDeleteAll(0);
   val = " "+AccountCurrency();
   string GVn=StringConcatenate("cm mg ",AN," ",Symbol());
   if (IsTesting()) GVn=StringConcatenate("Test ",GVn);
   GV_kn_BS=StringConcatenate(GVn," BS");
   GV_kn_SS=StringConcatenate(GVn," SS");
   GV_kn_BL=StringConcatenate(GVn," BL");
   GV_kn_SL=StringConcatenate(GVn," SL");
   GV_kn_TrP=StringConcatenate(GVn," TrP");
   GV_kn_CBA=StringConcatenate(GVn," CBA");
   GV_kn_CSA=StringConcatenate(GVn," CSA");
   GV_kn_CA=StringConcatenate(GVn," CA");

   RectLabelCreate(0,"cm F"    ,0,229,19 ,220,225);

   DrawLABEL("cm øò",Text(LANGUAGE,"øò è øàã","pcs & step"),95,30,clrBlack,ANCHOR_CENTER);
   ButtonCreate(0,"cm Buy Stop"     ,0,225,40,100,20,"Buy Stop","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_BS));
   ButtonCreate(0,"cm Sell Stop"    ,0,225,62,100,20,"Sell Stop","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_SS));
   ButtonCreate(0,"cm Buy Limit"    ,0,225,84,100,20,"Buy Limit","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_BL));
   ButtonCreate(0,"cm Sell Limit"   ,0,225,106,100,20,"Sell Limit","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_SL));

   EditCreate(0,"cm OrdersBuyStop"  ,0,120,40,50,20,IntegerToString(OrdersBuyStop),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm OrdersSellStop" ,0,120,62,50,20,IntegerToString(OrdersSellStop),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm OrdersBuyLimit" ,0,120,84,50,20,IntegerToString(OrdersBuyLimit),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm OrdersSellLimit",0,120,106,50,20,IntegerToString(OrdersSellLimit),"Arial",8,ALIGN_CENTER,false);

   EditCreate(0,"cm FirstLevel"     ,0,65,22,50,16,IntegerToString(FirstLevel),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm StepBuyStop"    ,0,65,40,50,20,IntegerToString(StepBuyStop),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm StepSellStop"   ,0,65,62,50,20,IntegerToString(StepSellStop),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm StepBuyLimit"   ,0,65,84,50,20,IntegerToString(StepBuyLimit),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm StepSellLimit"  ,0,65,106,50,20,IntegerToString(StepSellLimit),"Arial",8,ALIGN_CENTER,false);

   DrawLABEL("cm lot"   ,Text(LANGUAGE,"Ëîò","Lot"),200,138,clrBlack,ANCHOR_LEFT);
   DrawLABEL("cm +Plus" ,Text(LANGUAGE,"+ äîëèâêà","+ lot"),120,138,clrBlack,ANCHOR_LEFT);
   EditCreate(0,"cm Lot"      ,0,175,128,50,20,DoubleToString(Lot,2),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm LotPlus"  ,0,65,128,50,20,DoubleToString(LotPlus,2),"Arial",8,ALIGN_CENTER,false);

   ButtonCreate(0,"cm Close Buy"    ,0,225,150,100,20,"Close Buy");
   ButtonCreate(0,"cm Close Sell"   ,0,225,172,100,20,"Close Sell");
   ButtonCreate(0,"cm Close"        ,0,225,194,100,20,"Close");
   ButtonCreate(0,"cm Tral Profit"  ,0,225,216,100,20,"Tral Profit","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_TrP));


   ButtonCreate(0,"cm Close Buy A"    ,0,65,150,50,20,"auto","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_CBA));
   ButtonCreate(0,"cm Close Sell A"   ,0,65,172,50,20,"auto","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_CSA));
   ButtonCreate(0,"cm Close A"        ,0,65,194,50,20,"auto","Arial",8,clrBlack,clrLightGray,clrLightGray,clrNONE,GlobalVariableCheck(GV_kn_CA));


   EditCreate(0,"cm CloseProfitB" ,0,120,150,50,20,DoubleToString(CloseProfitB,2),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm CloseProfitS" ,0,120,172,50,20,DoubleToString(CloseProfitS,2),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm ProfitClose"  ,0,120,194,50,20,DoubleToString(ProfitClose,2),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm TralStart"    ,0,120,216,50,20,DoubleToString(TralStart,2),"Arial",8,ALIGN_CENTER,false);
   EditCreate(0,"cm TralClose"    ,0,65,216,50,20,DoubleToString(TralClose,2),"Arial",8,ALIGN_CENTER,false);


   ButtonCreate(0,"cm Clear"  ,0,75,25,70,20,Text(LANGUAGE,"Î÷èñòêà","Clear") ,"Times New Roman",8, clrBlack,clrGray,clrLightGray,clrNONE,false,CORNER_RIGHT_LOWER);
   return(INIT_SUCCEEDED);
}
//-------------------------------------------------------------------
void OnTick() {OnTimer();}
void OnTimer()
{
   if (!IsTradeAllowed()) return;
   STOPLEVEL=MarketInfo(Symbol(),MODE_STOPLEVEL);

   OrdersBuyStop=(int)StringToInteger(ObjectGetString(0,"cm OrdersBuyStop",OBJPROP_TEXT));
   OrdersSellStop=(int)StringToInteger(ObjectGetString(0,"cm OrdersSellStop",OBJPROP_TEXT));
   OrdersBuyLimit=(int)StringToInteger(ObjectGetString(0,"cm OrdersBuyLimit",OBJPROP_TEXT));
   OrdersSellLimit=(int)StringToInteger(ObjectGetString(0,"cm OrdersSellLimit",OBJPROP_TEXT));

   FirstLevel=(int)StringToInteger(ObjectGetString(0,"cm FirstLevel",OBJPROP_TEXT));
   StepBuyStop=(int)StringToInteger(ObjectGetString(0,"cm StepBuyStop",OBJPROP_TEXT));
   StepSellStop=(int)StringToInteger(ObjectGetString(0,"cm StepSellStop",OBJPROP_TEXT));
   StepBuyLimit=(int)StringToInteger(ObjectGetString(0,"cm StepBuyLimit",OBJPROP_TEXT));
   StepSellLimit=(int)StringToInteger(ObjectGetString(0,"cm StepSellLimit",OBJPROP_TEXT));

   CloseProfitB=StringToDouble(ObjectGetString(0,"cm CloseProfitB",OBJPROP_TEXT));
   CloseProfitS=StringToDouble(ObjectGetString(0,"cm CloseProfitS",OBJPROP_TEXT));
   ProfitClose=StringToDouble(ObjectGetString(0,"cm ProfitClose",OBJPROP_TEXT));
   TralStart=StringToDouble(ObjectGetString(0,"cm TralStart",OBJPROP_TEXT));
   TralClose=StringToDouble(ObjectGetString(0,"cm TralClose",OBJPROP_TEXT));

   Lot=StringToDouble(ObjectGetString(0,"cm Lot",OBJPROP_TEXT));
   LotPlus=StringToDouble(ObjectGetString(0,"cm LotPlus",OBJPROP_TEXT));

   //---
   double OL,OOP,Profit=0,ProfitB=0,ProfitS=0;
   double OOPBS=0,OOPSS=0,OOPBL=0,OOPSL=0,OLBS=0,OLSS=0,OLBL=0,OLSL=0;
   int OTBS=0,OTSS=0,OTBL=0,OTSL=0;
   int Ticket,i,b=0,s=0,bs=0,ss=0,bl=0,sl=0,tip;
   for (i=0; i<OrdersTotal(); i++)
   {    
      if (OrderSelect(i,SELECT_BY_POS,MODE_TRADES))
      { 
         if (OrderSymbol()==Symbol() && (Magic==-1 || Magic==OrderMagicNumber()))
         { 
            tip = OrderType(); 
            OOP = NormalizeDouble(OrderOpenPrice(),Digits);
            Profit=OrderProfit()+OrderSwap()+OrderCommission();
            Ticket=OrderTicket();
            OL=OrderLots();
            if (tip==OP_BUY)             
            {  
               ProfitB+=Profit;
               b++; 
            }                                         
            if (tip==OP_SELL)        
            {
               ProfitS+=Profit;
               s++;
            } 
            if (tip==OP_BUYSTOP)             
            {  
               if (OOPBS<OOP) {OOPBS=OOP;OTBS=Ticket;OLBS=OL;}
               bs++; 
            }                                         
            if (tip==OP_SELLSTOP)        
            {
               if (OOPSS>OOP || OOPSS==0) {OOPSS=OOP;OTSS=Ticket;OLSS=OL;}
               ss++;
            } 
            if (tip==OP_BUYLIMIT)             
            {  
               if (OOPBL>OOP || OOPBL==0) {OOPBL=OOP;OTBL=Ticket;OLBL=OL;}
               bl++; 
            }                                         
            if (tip==OP_SELLLIMIT)        
            {
               if (OOPSL<OOP) {OOPSL=OOP;OTSL=Ticket;OLSL=OL;}
               sl++;
            } 
         }
      }
   } 
   Profit = ProfitB + ProfitS;
   ObjectSetString(0,"cm Close Buy",OBJPROP_TEXT,StringConcatenate("CloseBuy ",DoubleToStr(ProfitB,2)));   
   ObjectSetString(0,"cm Close Sell",OBJPROP_TEXT,StringConcatenate("CloseSell ",DoubleToStr(ProfitS,2)));   
   ObjectSetString(0,"cm Close",OBJPROP_TEXT,StringConcatenate("Close ",DoubleToStr(Profit,2),val));   
   ObjectSetInteger(0,"cm Close Buy",OBJPROP_COLOR,Color(ProfitB));
   ObjectSetInteger(0,"cm Close Sell",OBJPROP_COLOR,Color(ProfitS));
   ObjectSetInteger(0,"cm Close",OBJPROP_COLOR,Color(Profit));
   
   ObjectSetString(0,"cm Buy Stop",OBJPROP_TEXT,StringConcatenate("BuyStop ",bs));   
   ObjectSetString(0,"cm Sell Stop",OBJPROP_TEXT,StringConcatenate("SellStop ",ss));   
   ObjectSetString(0,"cm Buy Limit",OBJPROP_TEXT,StringConcatenate("BuyLimit ",bl));   
   ObjectSetString(0,"cm Sell Limit",OBJPROP_TEXT,StringConcatenate("SellLimit ",sl));   
   //---
   if (ObjectGetInteger(0,"cm Clear",OBJPROP_STATE))
   {
      ObjectsDeleteAll(0,OBJ_TEXT);
      ObjectsDeleteAll(0,"#");
      ObjectsDeleteAll(0,OBJ_ARROW);
      ObjectsDeleteAll(0,OBJ_TREND);
      ObjectSetInteger(0,"cm Clear",OBJPROP_STATE,false);
   }
   //-----------------------------------
   //----- çàêðûòèå ïî ïðîôèòó  --------
   //-----------------------------------
   //--- buy
   if (ObjectGetInteger(0,"cm Close Buy A",OBJPROP_STATE)) 
   {  
      GlobalVariableSet(GV_kn_CBA,1);
      ObjectSetInteger(0,"cm CloseProfitB",OBJPROP_COLOR,clrRed);
      if (b!=0 && ProfitB>=CloseProfitB) ObjectSetInteger(0,"cm Close Buy",OBJPROP_STATE,true);
   }
   else {ObjectSetInteger(0,"cm CloseProfitB",OBJPROP_COLOR,clrLightGray);GlobalVariableDel(GV_kn_CBA);}
   if (ObjectGetInteger(0,"cm Close Buy",OBJPROP_STATE))
   {
      if (b!=0) if (!CloseAll(OP_BUY)) Print("Error OrderSend ",GetLastError());
      else ObjectSetInteger(0,"cm Close Buy",OBJPROP_STATE,false);
   }
   //--- sell 
   if (ObjectGetInteger(0,"cm Close Sell A",OBJPROP_STATE)) 
   {
      GlobalVariableSet(GV_kn_CSA,1);
      ObjectSetInteger(0,"cm CloseProfitS",OBJPROP_COLOR,clrRed);
      if (s!=0 && ProfitS>=CloseProfitS) ObjectSetInteger(0,"cm Close Sell",OBJPROP_STATE,true);
   }
   else {ObjectSetInteger(0,"cm CloseProfitS",OBJPROP_COLOR,clrLightGray);GlobalVariableDel(GV_kn_CSA);}
   if (ObjectGetInteger(0,"cm Close Sell",OBJPROP_STATE))
   {
      if (s!=0) if (!CloseAll(OP_SELL)) Print("Error OrderSend ",GetLastError());
      else ObjectSetInteger(0,"cm Close Sell",OBJPROP_STATE,false);
   }
   //--- âñå 
   if (ObjectGetInteger(0,"cm Close A",OBJPROP_STATE)) 
   {
      GlobalVariableSet(GV_kn_CA,1);
      ObjectSetInteger(0,"cm ProfitClose",OBJPROP_COLOR,clrRed);
      if (b+s!=0 && Profit>=ProfitClose) ObjectSetInteger(0,"cm Close",OBJPROP_STATE,true);
   }
   else {ObjectSetInteger(0,"cm ProfitClose",OBJPROP_COLOR,clrLightGray);GlobalVariableDel(GV_kn_CA);}
   if (ObjectGetInteger(0,"cm Close",OBJPROP_STATE))
   {
      if (s+b!=0) if (!CloseByOrders()) Print("Error OrderSend ",GetLastError());
      else ObjectSetInteger(0,"cm Close",OBJPROP_STATE,false);
   }
   //------------------------------
   //--- îòêðûòèå îðäåðîâ ---------
   //------------------------------
   double lots,price;
   if (ObjectGetInteger(0,"cm Buy Stop",OBJPROP_STATE))
   {
      if (bs<OrdersBuyStop)
      {
         if (bs==0)    {lots = Lot; price = NormalizeDouble(Ask+FirstLevel*Point,Digits);}
         else {lots = OLBS+LotPlus; price = NormalizeDouble(OOPBS+StepBuyStop*Point,Digits);}
         if (OrderSend(Symbol(),OP_BUYSTOP, lots,price,slippage,0,0,NULL,Magic,0,clrNONE)==-1) Print("Îøèáêà îòêðûòèÿ îðäåðà BS<<",GetLastError(),">>  ");
      }
      GlobalVariableSet(GV_kn_BS,1);
   }
   else
   {
      GlobalVariableDel(GV_kn_BS);
      if (bs>0) if (!OrderDelete(OTBS)) Print("Error <<",GetLastError(),">>  ");
   }
   //---
   if (ObjectGetInteger(0,"cm Sell Stop",OBJPROP_STATE))
   {
      if (ss<OrdersSellStop)
      {
         if (ss==0)    {lots = Lot; price = NormalizeDouble(Bid-FirstLevel*Point,Digits);}
         else {lots = OLSS+LotPlus; price = NormalizeDouble(OOPSS-StepBuyStop*Point,Digits);}
         if (OrderSend(Symbol(),OP_SELLSTOP, lots,price,slippage,0,0,NULL,Magic,0,clrNONE)==-1) Print("Îøèáêà îòêðûòèÿ îðäåðà SS<<",GetLastError(),">>  ");
      }
      GlobalVariableSet(GV_kn_SS,1);
   }
   else
   {
      GlobalVariableDel(GV_kn_SS);
      if (ss>0) if (!OrderDelete(OTSS)) Print("Error <<",GetLastError(),">>  ");
   }
   //---
   if (ObjectGetInteger(0,"cm Buy Limit",OBJPROP_STATE))
   {
      if (bl<OrdersBuyLimit)
      {
         if (bl==0)    {lots = Lot; price = NormalizeDouble(Bid-FirstLevel*Point,Digits);}
         else {lots = OLBL+LotPlus; price = NormalizeDouble(OOPBL-StepBuyStop*Point,Digits);}
         if (OrderSend(Symbol(),OP_BUYLIMIT, lots,price,slippage,0,0,NULL,Magic,0,clrNONE)==-1) Print("Îøèáêà îòêðûòèÿ îðäåðà BL<<",GetLastError(),">>  ");
      }
      GlobalVariableSet(GV_kn_BL,1);
   }
   else
   {
      GlobalVariableDel(GV_kn_BL);
      if (bl>0) if (!OrderDelete(OTBL)) Print("Error <<",GetLastError(),">>  ");
   }
   //---
   if (ObjectGetInteger(0,"cm Sell Limit",OBJPROP_STATE))
   {
      if (sl<OrdersSellLimit)
      {
         if (sl==0)    {lots = Lot; price = NormalizeDouble(Ask+FirstLevel*Point,Digits);}
         else {lots = OLSL+LotPlus; price = NormalizeDouble(OOPSL+StepBuyStop*Point,Digits);}
         if (OrderSend(Symbol(),OP_SELLLIMIT, lots,price,slippage,0,0,NULL,Magic,0,clrNONE)==-1) Print("Îøèáêà îòêðûòèÿ îðäåðà SL<<",GetLastError(),">>  ");
      }
      GlobalVariableSet(GV_kn_SL,1);
   }
   else
   {
      GlobalVariableDel(GV_kn_SL);
      if (sl>0) if (!OrderDelete(OTSL)) Print("Error <<",GetLastError(),">>  ");
   }
   //---------------------------------
   //--------- òðàë ïðîôèòà ----------
   //---------------------------------
   if (ObjectGetInteger(0,"cm Tral Profit",OBJPROP_STATE)) //òðàë 
   {
      ObjectSetInteger(0,"cm TralStart",OBJPROP_COLOR,clrRed); 
      ObjectSetInteger(0,"cm TralClose",OBJPROP_COLOR,clrRed); 
      GlobalVariableSet(GV_kn_TrP,1);
      if (TralClose>TralStart) TralClose=TralStart;
      if (Profit>=TralStart && StopProfit==0) StopProfit=Profit;
      if (Profit>=StopProfit  && StopProfit!=0) StopProfit=Profit;
      if (StopProfit!=0) ObjectSetString(0,"cm Tral Profit",OBJPROP_TEXT,StringConcatenate("Tral ",DoubleToStr(StopProfit-TralClose,2),val));
      else ObjectSetString(0,"cm Tral Profit",OBJPROP_TEXT,"Tral Profit");
      if (Profit<=StopProfit-TralClose && StopProfit!=0) 
      {
         CloseByOrders();StopProfit=0;
         drawtext(StringConcatenate("rl ",TimeToStr(TimeCurrent(),TIME_DATE|TIME_MINUTES)), Time[0], Bid, StringConcatenate("Close all ",DoubleToStr(Profit,2)) ,clrGreen);
         return;
      }
   } 
   else 
   {
      GlobalVariableDel(GV_kn_TrP);
      StopProfit=0;ObjectSetInteger(0,"cm TralStart",OBJPROP_COLOR,clrLightGray);
      ObjectSetInteger(0,"cm TralClose",OBJPROP_COLOR,clrLightGray);
      ObjectSetString(0,"cm Tral Profit",OBJPROP_TEXT,"Tral Profit");
   }
}
//--------------------------------------------------------------------
color Color(double P)
{
   if (P>0) return(clrGreen);
   if (P<0) return(clrRed);
   return(clrGray);
}
//------------------------------------------------------------------
void DrawLABEL(string name, string Name, int X, int Y, color clr,ENUM_ANCHOR_POINT align=ANCHOR_RIGHT,int CORNER=1)
{
   if (ObjectFind(name)==-1)
   {
      ObjectCreate(name, OBJ_LABEL, 0, 0, 0);
      ObjectSet(name, OBJPROP_CORNER, CORNER);
      ObjectSet(name, OBJPROP_XDISTANCE, X);
      ObjectSet(name, OBJPROP_YDISTANCE, Y);
      ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
      ObjectSetInteger(0,name,OBJPROP_SELECTED,false);
      ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
      ObjectSetInteger(0,name,OBJPROP_ANCHOR,align); 
   }
   ObjectSetText(name,Name,8,"Arial",clr);
}
//--------------------------------------------------------------------
void DrawHLINE(string name,double p, color clr=clrGray)
{
   if (ObjectFind(name)!=-1) ObjectDelete(name);
   ObjectCreate(name, OBJ_HLINE, 0, 0, p);
   ObjectSetInteger(0,name,OBJPROP_STYLE,0);
   ObjectSetInteger(0,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(0,name,OBJPROP_SELECTABLE,false);
   ObjectSetInteger(0,name,OBJPROP_SELECTED,false);
   ObjectSetInteger(0,name,OBJPROP_HIDDEN,true);
}
//--------------------------------------------------------------------
void OnDeinit(const int reason)
{
   if (!IsTesting())
   {
      ObjectsDeleteAll(0,"cm");
   }
   Comment("");
   EventKillTimer();
}
//+------------------------------------------------------------------+
bool CloseByOrders()
{
   bool error=true;
   int b=0,s=0,TicketApponent=0,Ticket,OT,j,LaslApp=-1;
   while(!IsStopped())
   {
      for (j = OrdersTotal()-1; j >= 0; j--)
      {
         if (OrderSelect(j, SELECT_BY_POS))
         {
            if (OrderSymbol() == Symbol() && (Magic==-1 || Magic==OrderMagicNumber()))
            {
               OT = OrderType();
               Ticket=OrderTicket();
               if (OT>1) {error=OrderDelete(Ticket);continue;}
               if (TicketApponent==0) {TicketApponent=Ticket;LaslApp=OT;}
               else
               {
                  if (LaslApp==OT) continue;
                  if (OrderCloseBy(Ticket,TicketApponent,Green)) TicketApponent=0;
                  else Print("Îøèáêà ",GetLastError()," çàêðûòèÿ îðäåðà N ",Ticket," <-> ",TicketApponent);
               }
            }
         }
      }
      b=0;s=0;
      for (j = OrdersTotal()-1; j >= 0; j--)
      {                                               
         if (OrderSelect(j,SELECT_BY_POS,MODE_TRADES))
         {
            if (OrderSymbol() == Symbol() && (Magic==-1 || Magic==OrderMagicNumber()))
            {
               OT = OrderType();
               if (OT==OP_BUY) b++;
               if (OT==OP_SELL) s++;
            }
         }
      }
      if (b==0 || s==0) break;
   }
   CloseAll(-1);
   return(1);
}
//-------------------------------------------------------------------
bool CloseAll(int tip)
{
   bool error=true;
   int j,err,nn=0,OT;
   while(true)
   {
      for (j = OrdersTotal()-1; j >= 0; j--)
      {
         if (OrderSelect(j, SELECT_BY_POS))
         {
            if (OrderSymbol() == Symbol() && (Magic==-1 || Magic==OrderMagicNumber()) )
            {
               OT = OrderType();
               if (tip!=-1 && tip!=OT) continue;
               if (OT==OP_BUY) 
               {
                  error=OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Bid,Digits),slippage,Blue);
               }
               if (OT==OP_SELL) 
               {
                  error=OrderClose(OrderTicket(),OrderLots(),NormalizeDouble(Ask,Digits),slippage,Red);
               }
               if (!error) 
               {
                  err = GetLastError();
                  if (err<2) continue;
                  if (err==129) 
                  {
                     RefreshRates();
                     continue;
                  }
                  if (err==146) 
                  {
                     if (IsTradeContextBusy()) Sleep(2000);
                     continue;
                  }
                  Print("Îøèáêà ",err," çàêðûòèÿ îðäåðà N ",OrderTicket(),"     ",TimeToStr(TimeCurrent(),TIME_SECONDS));
               }
            }
         }
      }
      int n=0;
      for (j = 0; j < OrdersTotal(); j++)
      {
         if (OrderSelect(j, SELECT_BY_POS))
         {
            if (OrderSymbol() == Symbol() && (Magic==-1 || Magic==OrderMagicNumber()))
            {
               OT = OrderType();
               if (OT>1) 
               {
                  int Ticket=OrderTicket();
                  if (tip==-1) error=OrderDelete(Ticket);
                  else
                  {                  
                     if (tip==OP_BUY && (OT==OP_BUYLIMIT || OT==OP_BUYSTOP)) error=OrderDelete(Ticket);
                     if (tip==OP_SELL && (OT==OP_SELLLIMIT || OT==OP_SELLSTOP)) error=OrderDelete(Ticket);
                  }
                  continue;
               }
               if (tip!=-1 && tip!=OT) continue;
               n++;
            }
         }  
      }
      if (n==0) break;
      nn++;
      if (nn>10) 
      {
         Alert(Symbol()," Íå óäàëîñü çàêðûòü âñå ñäåëêè, îñòàëîñü åùå ",n);
         return(0);
      }
      Sleep(1000);
      RefreshRates();
   }
   return(1);
}
//--------------------------------------------------------------------
bool ButtonCreate(const long              chart_ID=0,               // ID ãðàôèêà
                  const string            name="Button",            // èìÿ êíîïêè
                  const int               sub_window=0,             // íîìåð ïîäîêíà
                  const long               x=0,                      // êîîðäèíàòà ïî îñè X
                  const long               y=0,                      // êîîðäèíàòà ïî îñè Y
                  const int               width=50,                 // øèðèíà êíîïêè
                  const int               height=18,                // âûñîòà êíîïêè
                  const string            text="Button",            // òåêñò
                  const string            font="Arial",             // øðèôò
                  const int               font_size=8,             // ðàçìåð øðèôòà
                  const color             clr=clrBlack,               // öâåò òåêñòà
                  const color             clrON=clrLightGray,            // öâåò ôîíà
                  const color             clrOFF=clrLightGray,          // öâåò ôîíà
                  const color             border_clr=clrNONE,       // öâåò ãðàíèöû
                  const bool              state=false,       //
                  const ENUM_BASE_CORNER  CORNER=CORNER_RIGHT_UPPER)
  {
   if (ObjectFind(chart_ID,name)==-1)
   {
      ObjectCreate(chart_ID,name,OBJ_BUTTON,sub_window,0,0);
      ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
      ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,CORNER);
      ObjectSetString(chart_ID,name,OBJPROP_FONT,font);
      ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,0);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,0);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,0);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,1);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,1);
      ObjectSetInteger(chart_ID,name,OBJPROP_STATE,state);
   }
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr);
   color back_clr;
   if (ObjectGetInteger(chart_ID,name,OBJPROP_STATE)) back_clr=clrON; else back_clr=clrOFF;
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text);
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   return(true);
}
//--------------------------------------------------------------------
bool RectLabelCreate(const long             chart_ID=0,               // ID ãðàôèêà
                     const string           name="RectLabel",         // èìÿ ìåòêè
                     const int              sub_window=0,             // íîìåð ïîäîêíà
                     const long              x=0,                     // êîîðäèíàòà ïî îñè X
                     const long              y=0,                     // êîîðäèíàòà ïî îñè y
                     const int              width=50,                 // øèðèíà
                     const int              height=18,                // âûñîòà
                     const color            back_clr=clrWhite,        // öâåò ôîíà
                     const color            clr=clrBlack,             // öâåò ïëîñêîé ãðàíèöû (Flat)
                     const ENUM_LINE_STYLE  style=STYLE_SOLID,        // ñòèëü ïëîñêîé ãðàíèöû
                     const int              line_width=1,             // òîëùèíà ïëîñêîé ãðàíèöû
                     const bool             back=false,               // íà çàäíåì ïëàíå
                     const bool             selection=false,          // âûäåëèòü äëÿ ïåðåìåùåíèé
                     const bool             hidden=true,              // ñêðûò â ñïèñêå îáúåêòîâ
                     const long             z_order=0)                // ïðèîðèòåò íà íàæàòèå ìûøüþ
  {
   ResetLastError();
   if (ObjectFind(chart_ID,name)==-1)
   {
      ObjectCreate(chart_ID,name,OBJ_RECTANGLE_LABEL,sub_window,0,0);
      ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_TYPE,BORDER_FLAT);
      ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,CORNER_RIGHT_UPPER);
      ObjectSetInteger(chart_ID,name,OBJPROP_STYLE,style);
      ObjectSetInteger(chart_ID,name,OBJPROP_WIDTH,line_width);
      ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection);
      ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden);
      ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order);
      //ObjectSetInteger(chart_ID,name,OBJPROP_ALIGN,ALIGN_RIGHT); 
   }
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr);
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width);
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height);
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x);
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y);
   return(true);
}
//--------------------------------------------------------------------
string Error(int code)
{
   switch(code)
   {
      case 0:   return("Íåò îøèáîê");
      case 1:   return("Íåò îøèáêè, íî ðåçóëüòàò íåèçâåñòåí");                            
      case 2:   return("Îáùàÿ îøèáêà");                                                   
      case 3:   return("Íåïðàâèëüíûå ïàðàìåòðû");                                         
      case 4:   return("Òîðãîâûé ñåðâåð çàíÿò");                                          
      case 5:   return("Ñòàðàÿ âåðñèÿ êëèåíòñêîãî òåðìèíàëà");                            
      case 6:   return("Íåò ñâÿçè ñ òîðãîâûì ñåðâåðîì");                                  
      case 7:   return("Íåäîñòàòî÷íî ïðàâ");                                              
      case 8:   return("Ñëèøêîì ÷àñòûå çàïðîñû");                                         
      case 9:   return("Íåäîïóñòèìàÿ îïåðàöèÿ íàðóøàþùàÿ ôóíêöèîíèðîâàíèå ñåðâåðà");      
      case 64:  return("Ñ÷åò çàáëîêèðîâàí");                                              
      case 65:  return("Íåïðàâèëüíûé íîìåð ñ÷åòà");                                       
      case 128: return("Èñòåê ñðîê îæèäàíèÿ ñîâåðøåíèÿ ñäåëêè");                          
      case 129: return("Íåïðàâèëüíàÿ öåíà");                                              
      case 130: return("Íåïðàâèëüíûå ñòîïû");                                             
      case 131: return("Íåïðàâèëüíûé îáúåì");                                             
      case 132: return("Ðûíîê çàêðûò");                                                   
      case 133: return("Òîðãîâëÿ çàïðåùåíà");                                               
      case 134: return("Íåäîñòàòî÷íî äåíåã äëÿ ñîâåðøåíèÿ îïåðàöèè");                     
      case 135: return("Öåíà èçìåíèëàñü");                                                
      case 136: return("Íåò öåí");                                                        
      case 137: return("Áðîêåð çàíÿò");                                                   
      case 138: return("Íîâûå öåíû");                                                     
      case 139: return("Îðäåð çàáëîêèðîâàí è óæå îáðàáàòûâàåòñÿ");                        
      case 140: return("Ðàçðåøåíà òîëüêî ïîêóïêà");                                       
      case 141: return("Ñëèøêîì ìíîãî çàïðîñîâ");                                         
      case 145: return("Ìîäèôèêàöèÿ çàïðåùåíà, òàê êàê îðäåð ñëèøêîì áëèçîê ê ðûíêó");    
      case 146: return("Ïîäñèñòåìà òîðãîâëè çàíÿòà");                                     
      case 147: return("Èñïîëüçîâàíèå äàòû èñòå÷åíèÿ îðäåðà çàïðåùåíî áðîêåðîì");         
      case 148: return("Êîëè÷åñòâî îòêðûòûõ è îòëîæåííûõ îðäåðîâ äîñòèãëî ïðåäåëà, óñòàíîâëåííîãî áðîêåðîì.");
      default:   return(StringConcatenate("Îøèáêà ",code," íåèçâåñòíà "));
   }
}
//--------------------------------------------------------------------
bool EditCreate(const long             chart_ID=0,               // ID ãðàôèêà 
                const string           name="Edit",              // èìÿ îáúåêòà 
                const int              sub_window=0,             // íîìåð ïîäîêíà 
                const int              x=0,                      // êîîðäèíàòà ïî îñè X 
                const int              y=0,                      // êîîðäèíàòà ïî îñè Y 
                const int              width=50,                 // øèðèíà 
                const int              height=18,                // âûñîòà 
                const string           text="Text",              // òåêñò 
                const string           font="Arial",             // øðèôò 
                const int              font_size=8,             // ðàçìåð øðèôòà 
                const ENUM_ALIGN_MODE  align=ALIGN_RIGHT,       // ñïîñîá âûðàâíèâàíèÿ 
                const bool             read_only=true,           // âîçìîæíîñòü ðåäàêòèðîâàòü 
                const ENUM_BASE_CORNER corner=CORNER_RIGHT_UPPER, // óãîë ãðàôèêà äëÿ ïðèâÿçêè 
                const color            clr=clrBlack,             // öâåò òåêñòà 
                const color            back_clr=clrWhite,        // öâåò ôîíà 
                const color            border_clr=clrNONE,       // öâåò ãðàíèöû 
                const bool             back=false,               // íà çàäíåì ïëàíå 
                const bool             selection=false,          // âûäåëèòü äëÿ ïåðåìåùåíèé 
                const bool             hidden=true,              // ñêðûò â ñïèñêå îáúåêòîâ 
                const long             z_order=0)                // ïðèîðèòåò íà íàæàòèå ìûøüþ 
  { 
   ResetLastError(); 
   if(!ObjectCreate(chart_ID,name,OBJ_EDIT,sub_window,0,0)) 
     { 
      Print(__FUNCTION__, 
            ": íå óäàëîñü ñîçäàòü îáúåêò ",name,"! Êîä îøèáêè = ",GetLastError()); 
      return(false); 
     } 
   ObjectSetInteger(chart_ID,name,OBJPROP_XDISTANCE,x); 
   ObjectSetInteger(chart_ID,name,OBJPROP_YDISTANCE,y); 
   ObjectSetInteger(chart_ID,name,OBJPROP_XSIZE,width); 
   ObjectSetInteger(chart_ID,name,OBJPROP_YSIZE,height); 
   ObjectSetString(chart_ID,name,OBJPROP_TEXT,text); 
   ObjectSetString(chart_ID,name,OBJPROP_FONT,font); 
   ObjectSetInteger(chart_ID,name,OBJPROP_FONTSIZE,font_size); 
   ObjectSetInteger(chart_ID,name,OBJPROP_ALIGN,align); 
   ObjectSetInteger(chart_ID,name,OBJPROP_READONLY,read_only); 
   ObjectSetInteger(chart_ID,name,OBJPROP_CORNER,corner); 
   ObjectSetInteger(chart_ID,name,OBJPROP_COLOR,clr); 
   ObjectSetInteger(chart_ID,name,OBJPROP_BGCOLOR,back_clr); 
   ObjectSetInteger(chart_ID,name,OBJPROP_BORDER_COLOR,border_clr); 
   ObjectSetInteger(chart_ID,name,OBJPROP_BACK,back); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTABLE,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_SELECTED,selection); 
   ObjectSetInteger(chart_ID,name,OBJPROP_HIDDEN,hidden); 
   ObjectSetInteger(chart_ID,name,OBJPROP_ZORDER,z_order); 
   return(true); 
  } 
//+------------------------------------------------------------------+ 
string Text(bool P,string a,string b)
{
   if (P) return(a);
   else return(b);
}
//------------------------------------------------------------------
void drawtext(string Name, datetime T1, double Y1, string lt,color c)
{
   ObjectDelete (Name);
   ObjectCreate (Name, OBJ_TEXT,0,T1,Y1,0,0,0,0);
   ObjectSetText(Name, lt,8,"Arial");
   ObjectSetInteger(0,Name, OBJPROP_COLOR, c);
   ObjectSetInteger(0,Name, OBJPROP_ANCHOR, ANCHOR_LOWER);
}
//--------------------------------------------------------------------
