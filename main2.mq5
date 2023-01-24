#include "Condition_Functions.mqh"

void OnInit()
{
   // indicator arrays
   // ArrayResize(ema200Data, checkCandsForConsCount);
   // ArrayResize(ma10Data, checkCandsForConsCount);
   // ArrayResize(bbData, checkCandsForConsCount);
   // ArrayResize(pSarData, checkCandsForConsCount);
   TesterHideIndicators(true);
   EMA_Handle = iMA(NULL, TimeFrame, EMA_Period, EMA_Shift, EMA_Method, EMA_Apply);
   MA10_Handle = iMA(NULL, TimeFrame, MA10_Period, MA10_Shift, MA10_Method, MA10_Apply);
   BB_Handle = iBands(NULL, TimeFrame, BB_Period, BB_Shift, BB_Deviation, MA10_Handle);
   PSAR_Handle = iSAR(NULL, TimeFrame, PS_Step, PS_Maximum);
   ATR_Handle = iATR(NULL, TimeFrame, 3);
   if (EMA_Handle == INVALID_HANDLE || MA10_Handle == INVALID_HANDLE || BB_Handle == INVALID_HANDLE || PSAR_Handle == INVALID_HANDLE){
      Print ("Can not get all handles!!! Error: " + GetLastError());
      return;
   }
   else 
      Print ("Handles are correct");

   ArraySetAsSeries(ema200Data, true);
   ArraySetAsSeries(ma10Data, true);
   ArraySetAsSeries(bbDataUpper, true);
   ArraySetAsSeries(bbDataLower, true);
   ArraySetAsSeries(pSarData, true);

   //DigitPoints = MarketInfo(EASymbol, MODE_POINT);
   MultiplierPoint = 1;
   if ((_Digits == 3) || (_Digits == 5))
   {
      MultiplierPoint = 10;
      //DigitPoints *= MultiplierPoint;
   }

   // started information
   ExpertName = MQLInfoString(MQL_PROGRAM_NAME);
   //EASymbol = _Symbol;
   if (StringLen(EASymbol) > 6)
      SymbolExtension = StringSubstr(EASymbol, 6, 0);

   // Minimum trailing, take profit and stop loss
   // StopLevel=MathMax(MarketInfo(EASymbol,MODE_FREEZELEVEL)/MultiplierPoint,MarketInfo(EASymbol,MODE_STOPLEVEL)/MultiplierPoint);

   // Operation info
   OperInfo = ExpertName + ": Working well....";
}

void OnTick()
{
   CheckSpread = true;
   //"||======== Initialize indicators ========||"
   CopyBuffer(EMA_Handle, 0, 0, checkCandsForConsCount, ema200Data);
   CopyBuffer(MA10_Handle, 0, 0, checkCandsForConsCount, ma10Data);
   CopyBuffer(BB_Handle, UPPER_BAND, 0, checkCandsForConsCount, bbDataUpper);
   CopyBuffer(BB_Handle, LOWER_BAND, 0, checkCandsForConsCount, bbDataLower);
   CopyBuffer(PSAR_Handle, 0, 0, checkCandsForConsCount, pSarData);

  
   //Comment("ema: ", ema200Data[0], "\nma: ", ma10Data[0], "\nbbupper: ", bbDataUpper[0], "\nbblower: ", bbDataLower[0], "\npsar: ", pSarData[0], "\ntrade type: ", marketScanType);

   //"||======== Trade ========||"
   if (tradeCoolDownPeriod == false && GoodTime())
   {
      trade();
   }
   else
   {
      MqlDateTime temp;
      TimeToStruct(TimeCurrent() - startTime, temp);
      if (temp.min == 30)
      {
         tradeCoolDownPeriod = false;
      }
   }

   // "||======== Check trades currently running and update if necessary ========||";
   if (PositionsTotal() > 0)
   {
      Print("Order Management Working");
      //Print("PositionsTotal: ", PositionsTotal());
      monitorOpenTrades();
   }

   // toDo: Add minimum distance for trailing and move amount as seperate variables and add that bars are checks for a preceding cross and not that the ema is just above
}

void OnDeinit(const int reason)
{
   //------------------------------------------------------
   IndicatorRelease (EMA_Handle);
   IndicatorRelease (MA10_Handle);
   IndicatorRelease (BB_Handle);
   IndicatorRelease (PSAR_Handle);

   ObjectDelete(0, "Background");
   Comment("");
   //------------------------------------------------------
}