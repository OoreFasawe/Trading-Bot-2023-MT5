#include "Condition_Functions.mqh"

double ema200Data[];
double ma10Data[];
BBand bbData[];
double pSarData[];
ENUM_TRADETYPE marketScanType;
bool tradeCoolDownPeriod = false;
datetime startTime = TimeCurrent();
int timeElapsed;
static int id = 1;

string SoundModify = "tick.wav";
string ExpertName;
string EASymbol = NULL;
string OperInfo;
string SymbolExtension = "";

double spread;
string display = "";
double DigitPoints;
int MultiplierPoint;

void OnInit()
{
   // indicator arrays
   ArrayResize(ema200Data, checkCandsForConsCount);
   ArrayResize(ma10Data, checkCandsForConsCount);
   ArrayResize(bbData, checkCandsForConsCount);
   ArrayResize(pSarData, checkCandsForConsCount);

   DigitPoints = MarketInfo(EASymbol, MODE_POINT);
   MultiplierPoint = 1;
   if ((MarketInfo(EASymbol, MODE_DIGITS) == 3) || (MarketInfo(EASymbol, MODE_DIGITS) == 5))
   {
      MultiplierPoint = 10;
      DigitPoints *= MultiplierPoint;
   }

   // started information
   ExpertName = MQLInfoString(MQL_PROGRAM_NAME);
   EASymbol = _Symbol;
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
   setMAdataOnArray(ema200Data, checkCandsForConsCount, EMA_Period, EMA_Shift, EMA_Method, EMA_Apply);
   setMAdataOnArray(ma10Data, checkCandsForConsCount, MA10_Period, MA10_Shift, MA10_Method, MA10_Apply);
   setBBDataOnArrayOffMAData(bbData, ma10Data, checkCandsForConsCount, BB_Period, BB_Deviation, BB_Shift);
   setPSARDataOnArray(pSarData, checkCandsForConsCount, PS_Step, PS_Maximum);
   //"||======== Determine trade direction interest ========||"
   marketScanType = getTradeType(ema200Data, checkCandsForConsCount);
   //Comment("ema: ", ema200Data[0], "\nma: ", ma10Data[0], "\nbbupper: ", bbData[0].upper, "\nbblower: ", bbData[0].lower, "\npsar: ", pSarData[0], "\ntrade type: ", marketScanType);

   //"||======== Trade ========||"
   if (tradeCoolDownPeriod == false && GoodTime())
   {
      trade2();
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
   if (OrdersTotal() > 0 && !UseTakeProfit)
   {
      // if(eaImplementation == MINE)
         monitorOpenTrades();
      // else if(eaImplementation == PREVIOUS)
         // ModifyOrders();
   }

   // toDo: Add minimum distance for trailing and move amount as seperate variables and add that bars are checks for a preceding cross and not that the ema is just above
}

void OnDeinit(const int reason)
{
   //------------------------------------------------------
   ObjectDelete(0, "Background");
   Comment("");
   //------------------------------------------------------
}