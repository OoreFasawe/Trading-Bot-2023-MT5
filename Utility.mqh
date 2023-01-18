// #property copyright "Copyright 2023, Ooreoluwa Fasawe"
// #property link "lmndccc"
// #property version "1.00"
#property strict

// MAIN CHART INDICATORS
bool seen = false;
input string S1 = "||======== EMA 200 Settings ========||";
input int EMA_Period = 200;
input int EMA_Shift = 0;
input ENUM_MA_METHOD EMA_Method = MODE_EMA;
input ENUM_APPLIED_PRICE EMA_Apply = PRICE_CLOSE;

input string S2 = "||======== MA 10 Settings ========||";
input int MA10_Period = 10;
input int MA10_Shift = 0;
input ENUM_MA_METHOD MA10_Method = MODE_LWMA;
input ENUM_APPLIED_PRICE MA10_Apply = PRICE_WEIGHTED;

input string S3 = "||======== Bollinger Bands Settings ========||";
input int BB_Period = 3;
input double BB_Deviation = 0.500;
input int BB_Shift = 0;
input ENUM_APPLIED_PRICE BB_Apply = PRICE_CLOSE;

input string S4 = "||======== Parabolic SAR Settings ========||";
input double PS_Step = 0.02;
input double PS_Maximum = 0.2;

// WINDOW 1 INDICATORS- RSI WINDOW
input string S5 = "||======== RSI Settings ========||";
input int RSI_Period = 1;
input ENUM_APPLIED_PRICE RSI_Apply = PRICE_CLOSE;
input int RSI_Shift = 0;
// toDo: add levels 10 & 90

// same MA 10

input string S6 = "||======== MA 2 Settings ========||";
input int MA2_Period = 2;
input int MA2_Shift = 0;
input ENUM_MA_METHOD MA2_Method = MODE_SMMA;
input ENUM_APPLIED_PRICE MA2_Apply = PRICE_CLOSE;

// chart indicator stuff
int CHART_SYMBOL = NULL;
input ENUM_TIMEFRAMES TimeFrame = PERIOD_M15;
int candlesUsedToMonitoForCrossingAndPSAR = 5;
int checkCandsForConsCount = candlesUsedToMonitoForCrossingAndPSAR + BB_Period;
enum ENUM_TRADETYPE
{
  NONE,
  BUYS,
  SELLS
};
enum ENUM_RELATIVEPOSITION
{
  EQUAL,
  ABOVE,
  BELOW
};
input int rT = 0;
// take profit stuff
input int stopLossInPoints = 100;
input int takeProfitInPoints = 50;
double StopLevel;
input bool UseFixedStopLoss = false;
input bool UseFixedTakeProfit = false;
input bool UseTakeProfit = false;
input bool UseTradeCooldown = false;
input double atrTPMuti = 1;
input double atrSLMulti = 1;
input bool UseBreakEven = true;
input double BreakEven = 2;
input double BreakEvenAfter = 10;
input bool UseTrailingStop = true;
input double TrailingStop = 10.0;
input double TrailingStep = 1;

input string TimeFilter = "==== Time Filter ====";
input bool UseTimeFilter = false;
string Time_Start = "09:00";
string Time_End = "22:00";

// spread stuff
input string SetGeneral = "==== General Set ====";
input string MaxSpreadInfo = "If MaxSpread=0 not check spread";
input double MaxSpread = 0.0;
string MaxOrdersInfo = "If MaxOrders=0 there is not limit";
int MaxOrders = 0;
input int Slippage = 3;

// previous guy
enum TPP
{
  TP1,
  TP2,
  TP3
};
enum SLL
{
  SL1,
  SL2
};
enum Dir
{
  LongOnly,
  ShortOnly,
  Both
};
enum TRADESTRAT
{
  MINE,
  PREVIOUS
};

datetime LastTimeBarOP2;
input Dir SelectDirection = Both;
bool TradeOnNewBar = true;

bool CheckSpread;

input int BuyTotal = 1;
input int SellTotal = 1;
//input TRADESTRAT eaImplementation = MINE;
int CountBuy()
{
  int open = 0;
  for (int i = 0; i < OrdersTotal(); i++)
  {
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
    {
      if (OrderSymbol() == Symbol() && OrderType() == OP_BUY)
      {
        open++;
      }
    }
  }

  return (open);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountSell()
{
  int open = 0;
  for (int i = 0; i < OrdersTotal(); i++)
  {
    if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
    {
      if (OrderSymbol() == Symbol() && OrderType() == OP_SELL)
      {
        open++;
      }
    }
  }

  return (open);
}

// previous guys end

struct BBand
{
  double upper;
  double middle;
  double lower;
};

struct MT4_ORDER
{
  long Ticket;
  int Type;

  long TicketOpen;
  long TicketID;

  double Lots;

  string Symbol;
  string Comment;

  double OpenPriceRequest;
  double OpenPrice;

  long OpenTimeMsc;
  datetime OpenTime;

  // ENUM_DEAL_REASON  OpenReason;

  double StopLoss;
  double TakeProfit;

  double ClosePriceRequest;
  double ClosePrice;

  long CloseTimeMsc;
  datetime CloseTime;

  // ENUM_DEAL_REASON  CloseReason;

  // ENUM_ORDER_STATE  State;

  datetime Expiration;

  long MagicNumber;

  double Profit;

  double Commission;
  double Swap;
};