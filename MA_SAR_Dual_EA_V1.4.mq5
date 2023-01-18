//+------------------------------------------------------------------+
//+------------------------------------------------------------------+
//|                               Copyright © 2020,       iLyaz Kazi |
//|                                               Telegram: @iLyaz7  |
//|                                       Telegram: @FreeIndicator7  |
//+------------------------------------------------------------------+
#property copyright "Copyright © 2020, Telegram: @iLyaz7"
#property link "Telegram: @iLyaz7"
#property strict
#property description "Telegram: @FreeIndicator7"

#define Bid (::SymbolInfoDouble(_Symbol, ::SYMBOL_BID))
#define Ask (::SymbolInfoDouble(_Symbol, ::SYMBOL_ASK))

#define OP_BUY 0       // Buy
#define OP_SELL 1      // Sell
#define OP_BUYLIMIT 2  // Pending order of BUY LIMIT type
#define OP_SELLLIMIT 3 // Pending order of SELL LIMIT type
#define OP_BUYSTOP 4   // Pending order of BUY STOP type
#define OP_SELLSTOP 5  // Pending order of SELL STOP type
//---
#define MODE_OPEN 0
#define MODE_CLOSE 3
#define MODE_VOLUME 4
#define MODE_REAL_VOLUME 5
#define MODE_TRADES 0
#define MODE_HISTORY 1
#define SELECT_BY_POS 0
#define SELECT_BY_TICKET 1
//---
#define DOUBLE_VALUE 0
#define FLOAT_VALUE 1
#define LONG_VALUE INT_VALUE
//---
#define CHART_BAR 0
#define CHART_CANDLE 1
//---
#define MODE_ASCEND 0
#define MODE_DESCEND 1
//---
#define INDEX_TIME 0
#define INDEX_TICKET 1
#define INDEX_LOTS 2
#define MODE_LOW 1
#define MODE_HIGH 2
#define MODE_TIME 5
#define MODE_BID 9
#define MODE_ASK 10
#define MODE_POINT 11
#define MODE_DIGITS 12
#define MODE_SPREAD 13
#define MODE_STOPLEVEL 14
#define MODE_LOTSIZE 15
#define MODE_TICKVALUE 16
#define MODE_TICKSIZE 17
#define MODE_SWAPLONG 18
#define MODE_SWAPSHORT 19
#define MODE_STARTING 20
#define MODE_EXPIRATION 21
#define MODE_TRADEALLOWED 22
#define MODE_MINLOT 23
#define MODE_LOTSTEP 24
#define MODE_MAXLOT 25
#define MODE_SWAPTYPE 26
#define MODE_PROFITCALCMODE 27
#define MODE_MARGINCALCMODE 28
#define MODE_MARGININIT 29
#define MODE_MARGINMAINTENANCE 30
#define MODE_MARGINHEDGED 31
#define MODE_MARGINREQUIRED 32
#define MODE_FREEZELEVEL 33
//====================================================================================================================================================//
enum TypeC
{
  Close_Ticket_Orders,
  Close_Basket_Orders
};
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
enum colorswitch // use single or multi-color display of Histogram
{
  MultiColor = 0,
  SingleColor = 1
};

//====================================================================================================================================================//
//--------------------------------------------

bool SoundAlert = false;

input int BuyTotal = 1;
input int SellTotal = 1;

input ENUM_TIMEFRAMES TimeFrame = PERIOD_M15;

input string S1 = "||======== MA1 Settings ========||";
input int MA1_Period = 2;
input int MA1_Shift = 0;
input ENUM_MA_METHOD MA1_Method = MODE_SMA;
input ENUM_APPLIED_PRICE MA1_Apply = PRICE_TYPICAL;

input string S2 = "||======== MA2 Settings ========||";
input int MA2_Period = 200;
input int MA2_Shift = 0;
input ENUM_MA_METHOD MA2_Method = MODE_SMA;
input ENUM_APPLIED_PRICE MA2_Apply = PRICE_CLOSE;

input string S3 = "||======== BB Indicator Settings ========||";
input int period = 5;
input double Deviation = 0.500;
input int Shift = 0;
input ENUM_APPLIED_PRICE Apply = PRICE_CLOSE;

input string S4 = "||======== Parabolic sar Settings ========||";
input double step = 0.02;
input double maximum = 0.2;
input string S66 = "||======================= GENERAL Settings =======================||";
input Dir SelectDirection = Both;

bool TradeOnNewBar = true;

//--------------------------------------------
input string AdvancedSets = "==== Set Signals ====";
bool OpenEverySignal = false;
input bool CloseInSignal = false;

TypeC TypeAutoClose = Close_Ticket_Orders;
bool CloseInProfit = false;
double PipsCloseProfit = 25.0;
bool CloseInLoss = false;
double PipsCloseLoss = 100.0;
string SetOrders = "==== Set Orders Parametre ====";
input bool UseTakeProfit = true;
input double TakeProfit = 10.0;
input bool UseStopLoss = true;
input double StopLoss = 10.0;
input bool UseTrailingStop = false;
input double TrailingStop = 10.0;
input double TrailingStep = 1;
input bool UseBreakEven = false;
input double BreakEven = 2;
input double BreakEvenAfter = 10;
input string Money_Management = "==== Money Management ====";
bool AutoLotSize = false;
input double LotSize = 0.01;
double RiskFactor = 1.0;

input string NewsFilterr = "==== News Filter ====";

input string DailyFxURL = "http://www.dailyfx.com/files/Calendar-";
input string InvestingURL = "http://ec.forexprostools.com/?columns=exc_currency,exc_importance&importance=1,2,3&calType=week&timeZone=15&lang=1";
input bool LowNews = true;
input int LowIndentBefore = 15;
input int LowIndentAfter = 15;
input bool MidleNews = true;
input int MidleIndentBefore = 30;
input int MidleIndentAfter = 30;
input bool HighNews = true;
input int HighIndentBefore = 60;
input int HighIndentAfter = 60;
input bool NFPNews = true;
input int NFPIndentBefore = 180;
input int NFPIndentAfter = 180;

input bool DrawNewsLines = true;
input color LowColor = clrGreen;
input color MidleColor = clrBlue;
input color HighColor = clrRed;
input int LineWidth = 1;
input ENUM_LINE_STYLE LineStyle = STYLE_DOT;
input bool OnlySymbolNews = true;
input int GMTplus = 3; // Your Time Zone, GMT (for news)

string TimeFilter = "==== Time Filter ====";
bool UseTimeFilter = false;
input string Time_Start = "09:00";
input string Time_End = "22:00";

input string SetGeneral = "==== General Set ====";
input string MaxSpreadInfo = "If MaxSpread=0 not check spread";
input double MaxSpread = 0.0;
string MaxOrdersInfo = "If MaxOrders=0 there is not limit";
int MaxOrders = 0;
input int Slippage = 3;
bool RunNDDbroker = false;

input string MagicNumberInfo = "if MagicNumber = 0, expert generate automatical MagicNumber";
extern int Magic_Number = 1001; // Magic Number

string CommentsOrders = "EA";
double LastBuyPrice, LastSellPrice;
//====================================================================================================================================================//

string SoundModify = "tick.wav";
string ExpertName;
string EASymbol;
string OperInfo;
string SymbolExtension = "";

double DigitPoints;
int MultiplierPoint;
double StopLevel;
double Spreads;
double Spread;

int OrdersID;
int TotalHistoryOrders;
int HistoryBuy;
int HistorySell;
int OrdersOpened;
int SumOrders;
int TypeLastOrder;
int BuyOrders;
int SellOrders;
int i;
color ChartColor;
bool CheckSpread;
bool TimeToTrade;
bool OpenBuy = false;
bool OpenSell = false;
bool CloseBuy = false;
bool CloseSell = false;
datetime BarOpenBuy = 0;
datetime BarOpenSell = 0;
datetime TimeBegin;
datetime TimeEnd;
datetime LastTimeBar;

bool MaBuy = false;
bool MaSell = false;
bool MaBuy2 = false;
bool MaSell2 = false;
bool MaBuy3 = false;
bool MaSell3 = false;
datetime StartTime;
datetime LastTimeBarOP2;
int handle_iCustom;        // variable for storing the handle of the iCustom indicator
bool m_init_error = false; // error on InInit

#ifdef __MQL5__
#ifndef __MT4ORDERS__

// #define MT4ORDERS_BYPASS_MAXTIME 1000000 // Max time (in microseconds) to wait for the trading environment synchronization

#ifdef MT4ORDERS_BYPASS_MAXTIME
#include <fxsaber\TradesID\ByPass.mqh> // https://www.mql5.com/en/code/34173
#endif                                 // #ifdef MT4ORDERS_BYPASS_MAXTIME

// #define MT4ORDERS_BENCHMARK_MINTIME 1000 // Minimum time for the performance alert trigger.

#ifdef MT4ORDERS_BENCHMARK_MINTIME
#include <fxsaber\Benchmark\Benchmark.mqh> // https://www.mql5.com/en/code/31279

#define _B2(A) _B(A, MT4ORDERS_BENCHMARK_MINTIME)
#define _B3(A) _B(A, 1)
#define _BV2(A) _BV(A, MT4ORDERS_BENCHMARK_MINTIME)
#else // MT4ORDERS_BENCHMARK_MINTIME
#define _B2(A) (A)
#define _B3(A) (A)
#define _BV2(A) \
  {             \
    A;          \
  }
#endif // MT4ORDERS_BENCHMARK_MINTIME

#define __MT4ORDERS__ "2021.06.01"
#define MT4ORDERS_SLTP_OLD // Enabling the old mechanism of identifying the SL/TP of closed positions via OrderClose
// #define MT4ORDERS_TESTER_SELECT_BY_TICKET // Forces SELECT_BY_TICKET to work in the Tester only via OrderTicketID().

#ifdef MT4_TICKET_TYPE
#define TICKET_TYPE int
#define MAGIC_TYPE int

#undef MT4_TICKET_TYPE
#else                    // MT4_TICKET_TYPE
#define TICKET_TYPE long // Negative values are also needed for OrderSelectByTicket.
#define MAGIC_TYPE long
#endif // MT4_TICKET_TYPE

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

  ENUM_DEAL_REASON OpenReason;

  double StopLoss;
  double TakeProfit;

  double ClosePriceRequest;
  double ClosePrice;

  long CloseTimeMsc;
  datetime CloseTime;

  ENUM_DEAL_REASON CloseReason;

  ENUM_ORDER_STATE State;

  datetime Expiration;

  long MagicNumber;

  double Profit;

  double Commission;
  double Swap;

#define POSITION_SELECT (-1)
#define ORDER_SELECT (-2)

  static int GetDigits(double Price)
  {
    int Res = 0;

    while ((bool)(Price = ::NormalizeDouble(Price - (int)Price, 8)))
    {
      Price *= 10;

      Res++;
    }

    return (Res);
  }

  static string DoubleToString(const double Num, const int digits)
  {
    return (::DoubleToString(Num, ::MathMax(digits, MT4_ORDER::GetDigits(Num))));
  }

  static string TimeToString(const long time)
  {
    return ((string)(datetime)(time / 1000) + "." + ::IntegerToString(time % 1000, 3, '0'));
  }

  static const MT4_ORDER GetPositionData(void)
  {
    MT4_ORDER Res = {};

    Res.Ticket = ::PositionGetInteger(POSITION_TICKET);
    Res.Type = (int)::PositionGetInteger(POSITION_TYPE);

    Res.Lots = ::PositionGetDouble(POSITION_VOLUME);

    Res.Symbol = ::PositionGetString(POSITION_SYMBOL);
    //    Res.Comment = NULL; // MT4ORDERS::CheckPositionCommissionComment();

    Res.OpenPrice = ::PositionGetDouble(POSITION_PRICE_OPEN);
    Res.OpenTimeMsc = (datetime)::PositionGetInteger(POSITION_TIME_MSC);

    Res.StopLoss = ::PositionGetDouble(POSITION_SL);
    Res.TakeProfit = ::PositionGetDouble(POSITION_TP);

    Res.ClosePrice = ::PositionGetDouble(POSITION_PRICE_CURRENT);
    Res.CloseTimeMsc = 0;

    Res.Expiration = 0;

    Res.MagicNumber = ::PositionGetInteger(POSITION_MAGIC);

    Res.Profit = ::PositionGetDouble(POSITION_PROFIT);

    Res.Swap = ::PositionGetDouble(POSITION_SWAP);

    //    Res.Commission = UNKNOWN_COMMISSION; // MT4ORDERS::CheckPositionCommissionComment();

    return (Res);
  }

  static const MT4_ORDER GetOrderData(void)
  {
    MT4_ORDER Res = {};

    Res.Ticket = ::OrderGetInteger(ORDER_TICKET);
    Res.Type = (int)::OrderGetInteger(ORDER_TYPE);

    Res.Lots = ::OrderGetDouble(ORDER_VOLUME_CURRENT);

    Res.Symbol = ::OrderGetString(ORDER_SYMBOL);
    Res.Comment = ::OrderGetString(ORDER_COMMENT);

    Res.OpenPrice = ::OrderGetDouble(ORDER_PRICE_OPEN);
    Res.OpenTimeMsc = (datetime)::OrderGetInteger(ORDER_TIME_SETUP_MSC);

    Res.StopLoss = ::OrderGetDouble(ORDER_SL);
    Res.TakeProfit = ::OrderGetDouble(ORDER_TP);

    Res.ClosePrice = ::OrderGetDouble(ORDER_PRICE_CURRENT);
    Res.CloseTimeMsc = 0; // (datetime)::OrderGetInteger(ORDER_TIME_DONE)

    Res.Expiration = (datetime)::OrderGetInteger(ORDER_TIME_EXPIRATION);

    Res.MagicNumber = ::OrderGetInteger(ORDER_MAGIC);

    Res.Profit = 0;

    Res.Commission = 0;
    Res.Swap = 0;

    if (!Res.OpenPrice)
      Res.OpenPrice = Res.ClosePrice;

    return (Res);
  }

  string ToString(void) const
  {
    static const string Types[] = {"buy", "sell", "buy limit", "sell limit", "buy stop", "sell stop", "balance"};
    const int digits = (int)::SymbolInfoInteger(this.Symbol, SYMBOL_DIGITS);

    MT4_ORDER TmpOrder = {};

    if (this.Ticket == POSITION_SELECT)
    {
      TmpOrder = MT4_ORDER::GetPositionData();

      TmpOrder.Comment = this.Comment;
      TmpOrder.Commission = this.Commission;
    }
    else if (this.Ticket == ORDER_SELECT)
      TmpOrder = MT4_ORDER::GetOrderData();

    return (((this.Ticket == POSITION_SELECT) || (this.Ticket == ORDER_SELECT)) ? TmpOrder.ToString() : ("#" + (string)this.Ticket + " " + MT4_ORDER::TimeToString(this.OpenTimeMsc) + " " + ((this.Type < ::ArraySize(Types)) ? Types[this.Type] : "unknown") + " " + MT4_ORDER::DoubleToString(this.Lots, 2) + " " + (::StringLen(this.Symbol) ? this.Symbol + " " : NULL) + MT4_ORDER::DoubleToString(this.OpenPrice, digits) + " " + MT4_ORDER::DoubleToString(this.StopLoss, digits) + " " + MT4_ORDER::DoubleToString(this.TakeProfit, digits) + " " + ((this.CloseTimeMsc > 0) ? (MT4_ORDER::TimeToString(this.CloseTimeMsc) + " ") : "") + MT4_ORDER::DoubleToString(this.ClosePrice, digits) + " " + MT4_ORDER::DoubleToString(::NormalizeDouble(this.Commission, 3), 2) + " " + // Больше трех цифр после запятой не выводим.
                                                                                                         MT4_ORDER::DoubleToString(this.Swap, 2) + " " + MT4_ORDER::DoubleToString(this.Profit, 2) + " " + ((this.Comment == "") ? "" : (this.Comment + " ")) + (string)this.MagicNumber + (((this.Expiration > 0) ? (" expiration " + (string)this.Expiration) : ""))));
  }
};

#define RESERVE_SIZE 1000
#define DAY (24 * 3600)
#define HISTORY_PAUSE (MT4HISTORY::IsTester ? 0 : 5)
#define END_TIME D '31.12.3000 23:59:59'
#define THOUSAND 1000
#define LASTTIME(A)                                          \
  if (Time##A >= LastTimeMsc)                                \
  {                                                          \
    const datetime TmpTime = (datetime)(Time##A / THOUSAND); \
                                                             \
    if (TmpTime > this.LastTime)                             \
    {                                                        \
      this.LastTotalOrders = 0;                              \
      this.LastTotalDeals = 0;                               \
                                                             \
      this.LastTime = TmpTime;                               \
      LastTimeMsc = this.LastTime * THOUSAND;                \
    }                                                        \
                                                             \
    this.LastTotal##A##s++;                                  \
  }

#ifndef MT4ORDERS_FASTHISTORY_OFF
#include <Generic\HashMap.mqh>
#endif // MT4ORDERS_FASTHISTORY_OFF

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MT4HISTORY
{
private:
  static const bool MT4HISTORY::IsTester;
  //  static long MT4HISTORY::AccountNumber;

#ifndef MT4ORDERS_FASTHISTORY_OFF
  CHashMap<ulong, ulong> DealsIn;  // By PositionID, it returns DealIn.
  CHashMap<ulong, ulong> DealsOut; // By PositionID, it returns DealOut.
#endif                             // MT4ORDERS_FASTHISTORY_OFF

  long Tickets[];
  uint Amount;

  int LastTotalDeals;
  int LastTotalOrders;

#ifdef MT4ORDERS_HISTORY_OLD

  datetime LastTime;
  datetime LastInitTime;

  int PrevDealsTotal;
  int PrevOrdersTotal;

  // https://www.mql5.com/ru/forum/93352/page50#comment_18040243
  bool IsChangeHistory(void)
  {
    bool Res = !_B2(::HistorySelect(0, INT_MAX));

    if (!Res)
    {
      const int iDealsTotal = ::HistoryDealsTotal();
      const int iOrdersTotal = ::HistoryOrdersTotal();

      if (Res = (iDealsTotal != this.PrevDealsTotal) || (iOrdersTotal != this.PrevOrdersTotal))
      {
        this.PrevDealsTotal = iDealsTotal;
        this.PrevOrdersTotal = iOrdersTotal;
      }
    }

    return (Res);
  }

  bool RefreshHistory(void)
  {
    bool Res = !MT4HISTORY::IsChangeHistory();

    if (!Res)
    {
      const datetime LastTimeCurrent = ::TimeCurrent();

      if (!MT4HISTORY::IsTester && ((LastTimeCurrent >= this.LastInitTime + DAY) /* || (MT4HISTORY::AccountNumber != ::AccountInfoInteger(ACCOUNT_LOGIN))*/))
      {
        //  MT4HISTORY::AccountNumber = ::AccountInfoInteger(ACCOUNT_LOGIN);

        this.LastTime = 0;

        this.LastTotalOrders = 0;
        this.LastTotalDeals = 0;

        this.Amount = 0;

        ::ArrayResize(this.Tickets, this.Amount, RESERVE_SIZE);

        this.LastInitTime = LastTimeCurrent;

#ifndef MT4ORDERS_FASTHISTORY_OFF
        this.DealsIn.Clear();
        this.DealsOut.Clear();
#endif // MT4ORDERS_FASTHISTORY_OFF
      }

      const datetime LastTimeCurrentLeft = LastTimeCurrent - HISTORY_PAUSE;

      // If LastTime is equal to zero, then HistorySelect has already been done in MT4HISTORY::IsChangeHistory().
      if (!this.LastTime || _B2(::HistorySelect(this.LastTime, END_TIME))) // https://www.mql5.com/ru/forum/285631/page79#comment_9884935
                                                                           //    if (_B2(::HistorySelect(this.LastTime, INT_MAX))) // Perhaps INT_MAX is faster than END_TIME
      {
        const int TotalOrders = ::HistoryOrdersTotal();
        const int TotalDeals = ::HistoryDealsTotal();

        Res = ((TotalOrders > this.LastTotalOrders) || (TotalDeals > this.LastTotalDeals));

        if (Res)
        {
          int iOrder = this.LastTotalOrders;
          int iDeal = this.LastTotalDeals;

          ulong TicketOrder = 0;
          ulong TicketDeal = 0;

          long TimeOrder = (iOrder < TotalOrders) ? ::HistoryOrderGetInteger((TicketOrder = ::HistoryOrderGetTicket(iOrder)), ORDER_TIME_DONE_MSC) : LONG_MAX;
          long TimeDeal = (iDeal < TotalDeals) ? ::HistoryDealGetInteger((TicketDeal = ::HistoryDealGetTicket(iDeal)), DEAL_TIME_MSC) : LONG_MAX;

          if (this.LastTime < LastTimeCurrentLeft)
          {
            this.LastTotalOrders = 0;
            this.LastTotalDeals = 0;

            this.LastTime = LastTimeCurrentLeft;
          }

          long LastTimeMsc = this.LastTime * THOUSAND;

          while ((iDeal < TotalDeals) || (iOrder < TotalOrders))
            if (TimeOrder < TimeDeal)
            {
              LASTTIME(Order)

              if (MT4HISTORY::IsMT4Order(TicketOrder))
              {
                this.Amount = ::ArrayResize(this.Tickets, this.Amount + 1, RESERVE_SIZE);

                this.Tickets[this.Amount - 1] = -(long)TicketOrder;
              }

              iOrder++;

              TimeOrder = (iOrder < TotalOrders) ? ::HistoryOrderGetInteger((TicketOrder = ::HistoryOrderGetTicket(iOrder)), ORDER_TIME_DONE_MSC) : LONG_MAX;
            }
            else
            {
              LASTTIME(Deal)

              if (MT4HISTORY::IsMT4Deal(TicketDeal))
              {
                this.Amount = ::ArrayResize(this.Tickets, this.Amount + 1, RESERVE_SIZE);

                this.Tickets[this.Amount - 1] = (long)TicketDeal;

#ifndef MT4ORDERS_FASTHISTORY_OFF
                _B2(this.DealsOut.Add(::HistoryDealGetInteger(TicketDeal, DEAL_POSITION_ID), TicketDeal));
#endif // MT4ORDERS_FASTHISTORY_OFF
              }
#ifndef MT4ORDERS_FASTHISTORY_OFF
              else if ((ENUM_DEAL_ENTRY)::HistoryDealGetInteger(TicketDeal, DEAL_ENTRY) == DEAL_ENTRY_IN)
                _B2(this.DealsIn.Add(::HistoryDealGetInteger(TicketDeal, DEAL_POSITION_ID), TicketDeal));
#endif // MT4ORDERS_FASTHISTORY_OFF

              iDeal++;

              TimeDeal = (iDeal < TotalDeals) ? ::HistoryDealGetInteger((TicketDeal = ::HistoryDealGetTicket(iDeal)), DEAL_TIME_MSC) : LONG_MAX;
            }
        }
        else if (LastTimeCurrentLeft > this.LastTime)
        {
          this.LastTime = LastTimeCurrentLeft;

          this.LastTotalOrders = 0;
          this.LastTotalDeals = 0;
        }
      }
    }

    return (Res);
  }

#else  // #ifdef MT4ORDERS_HISTORY_OLD
  bool RefreshHistory(void)
  {
    if (_B2(::HistorySelect(0, INT_MAX)))
    {
      const int TotalOrders = ::HistoryOrdersTotal();
      const int TotalDeals = ::HistoryDealsTotal();

      if ((TotalOrders > this.LastTotalOrders) || (TotalDeals > this.LastTotalDeals))
      {
        ulong TicketOrder = 0;
        ulong TicketDeal = 0;

        long TimeOrder = (this.LastTotalOrders < TotalOrders) ? ::HistoryOrderGetInteger((TicketOrder = ::HistoryOrderGetTicket(this.LastTotalOrders)), ORDER_TIME_DONE_MSC) : LONG_MAX;
        long TimeDeal = (this.LastTotalDeals < TotalDeals) ? ::HistoryDealGetInteger((TicketDeal = ::HistoryDealGetTicket(this.LastTotalDeals)), DEAL_TIME_MSC) : LONG_MAX;

        while ((this.LastTotalDeals < TotalDeals) || (this.LastTotalOrders < TotalOrders))
          if (TimeOrder < TimeDeal)
          {
            if (MT4HISTORY::IsMT4Order(TicketOrder))
            {
              this.Amount = ::ArrayResize(this.Tickets, this.Amount + 1, RESERVE_SIZE);

              this.Tickets[this.Amount - 1] = -(long)TicketOrder;
            }

            this.LastTotalOrders++;

            TimeOrder = (this.LastTotalOrders < TotalOrders) ? ::HistoryOrderGetInteger((TicketOrder = ::HistoryOrderGetTicket(this.LastTotalOrders)), ORDER_TIME_DONE_MSC) : LONG_MAX;
          }
          else
          {
            if (MT4HISTORY::IsMT4Deal(TicketDeal))
            {
              this.Amount = ::ArrayResize(this.Tickets, this.Amount + 1, RESERVE_SIZE);

              this.Tickets[this.Amount - 1] = (long)TicketDeal;

              _B2(this.DealsOut.Add(::HistoryDealGetInteger(TicketDeal, DEAL_POSITION_ID), TicketDeal));
            }
            else if ((ENUM_DEAL_ENTRY)::HistoryDealGetInteger(TicketDeal, DEAL_ENTRY) == DEAL_ENTRY_IN)
              _B2(this.DealsIn.Add(::HistoryDealGetInteger(TicketDeal, DEAL_POSITION_ID), TicketDeal));

            this.LastTotalDeals++;

            TimeDeal = (this.LastTotalDeals < TotalDeals) ? ::HistoryDealGetInteger((TicketDeal = ::HistoryDealGetTicket(this.LastTotalDeals)), DEAL_TIME_MSC) : LONG_MAX;
          }
      }
    }

    return (true);
  }
#endif // #ifdef MT4ORDERS_HISTORY_OLD #else
public:
  static bool IsMT4Deal(const ulong &Ticket)
  {
    const ENUM_DEAL_TYPE DealType = (ENUM_DEAL_TYPE)::HistoryDealGetInteger(Ticket, DEAL_TYPE);
    const ENUM_DEAL_ENTRY DealEntry = (ENUM_DEAL_ENTRY)::HistoryDealGetInteger(Ticket, DEAL_ENTRY);

    return (((DealType != DEAL_TYPE_BUY) && (DealType != DEAL_TYPE_SELL)) ||      // non trading deal
            ((DealEntry == DEAL_ENTRY_OUT) || (DealEntry == DEAL_ENTRY_OUT_BY))); // trading
  }

  static bool IsMT4Order(const ulong &Ticket)
  {
    // If the pending order has been executed, its ORDER_POSITION_ID is filled out.
    // https://www.mql5.com/ru/forum/170952/page70#comment_6543162
    // https://www.mql5.com/ru/forum/93352/page19#comment_6646726
    // The second condition: when a limit order has been partially executed and then deleted.
    return (!::HistoryOrderGetInteger(Ticket, ORDER_POSITION_ID) || (::HistoryOrderGetDouble(Ticket, ORDER_VOLUME_CURRENT) &&
                                                                     ::HistoryOrderGetInteger(Ticket, ORDER_TYPE) > ORDER_TYPE_SELL));
  }

  MT4HISTORY(void) : Amount(::ArrayResize(this.Tickets, 0, RESERVE_SIZE)),
                     LastTotalDeals(0), LastTotalOrders(0)
#ifdef MT4ORDERS_HISTORY_OLD
                     ,
                     LastTime(0), LastInitTime(0), PrevDealsTotal(0), PrevOrdersTotal(0)
#endif // #ifdef MT4ORDERS_HISTORY_OLD
  {
    //    this.RefreshHistory(); // If history is not used, there is no point in wasting resources.
  }

  ulong GetPositionDealIn(const ulong PositionIdentifier = -1) // 0 is not available, since the tester's balance trade is zero
  {
    ulong Ticket = 0;

    if (PositionIdentifier == -1)
    {
      const ulong MyPositionIdentifier = ::PositionGetInteger(POSITION_IDENTIFIER);

#ifndef MT4ORDERS_FASTHISTORY_OFF
      if (!_B2(this.DealsIn.TryGetValue(MyPositionIdentifier, Ticket))
#ifndef MT4ORDERS_HISTORY_OLD
          && !_B2(this.RefreshHistory() && this.DealsIn.TryGetValue(MyPositionIdentifier, Ticket))
#endif // #ifndef MT4ORDERS_HISTORY_OLD
      )
#endif // MT4ORDERS_FASTHISTORY_OFF
      {
        const datetime PosTime = (datetime)::PositionGetInteger(POSITION_TIME);

        if (_B3(::HistorySelect(PosTime, PosTime)))
        {
          const int Total = ::HistoryDealsTotal();

          for (int i = 0; i < Total; i++)
          {
            const ulong TicketDeal = ::HistoryDealGetTicket(i);

            if ((::HistoryDealGetInteger(TicketDeal, DEAL_POSITION_ID) == MyPositionIdentifier) /*&&
           ((ENUM_DEAL_ENTRY)::HistoryDealGetInteger(TicketDeal, DEAL_ENTRY) == DEAL_ENTRY_IN) */
                )                                                                               // First mention will be DEAL_ENTRY_IN anyway
            {
              Ticket = TicketDeal;

#ifndef MT4ORDERS_FASTHISTORY_OFF
              _B2(this.DealsIn.Add(MyPositionIdentifier, Ticket));
#endif // MT4ORDERS_FASTHISTORY_OFF

              break;
            }
          }
        }
      }
    }
    else if (PositionIdentifier && // PositionIdentifier of balance trades is zero
#ifndef MT4ORDERS_FASTHISTORY_OFF
             !_B2(this.DealsIn.TryGetValue(PositionIdentifier, Ticket)) &&
#ifndef MT4ORDERS_HISTORY_OLD
             !_B2(this.RefreshHistory() && this.DealsIn.TryGetValue(PositionIdentifier, Ticket)) &&
#endif                                                                                          // #ifndef MT4ORDERS_HISTORY_OLD
#endif                                                                                          // MT4ORDERS_FASTHISTORY_OFF
             _B3(::HistorySelectByPosition(PositionIdentifier)) && (::HistoryDealsTotal() > 1)) // Why > 1, not > 0 ?!
    {
      Ticket = _B2(::HistoryDealGetTicket(0)); // First mention will be DEAL_ENTRY_IN anyway

      /*
      const int Total = ::HistoryDealsTotal();

      for (int i = 0; i < Total; i++)
      {
        const ulong TicketDeal = ::HistoryDealGetTicket(i);

        if (TicketDeal > 0)
          if ((ENUM_DEAL_ENTRY)::HistoryDealGetInteger(TicketDeal, DEAL_ENTRY) == DEAL_ENTRY_IN)
          {
            Ticket = TicketDeal;

            break;
          }
      } */

#ifndef MT4ORDERS_FASTHISTORY_OFF
      _B2(this.DealsIn.Add(PositionIdentifier, Ticket));
#endif // MT4ORDERS_FASTHISTORY_OFF
    }

    return (Ticket);
  }

  ulong GetPositionDealOut(const ulong PositionIdentifier)
  {
    ulong Ticket = 0;

#ifndef MT4ORDERS_FASTHISTORY_OFF
    if (!_B2(this.DealsOut.TryGetValue(PositionIdentifier, Ticket)) && _B2(this.RefreshHistory()))
      _B2(this.DealsOut.TryGetValue(PositionIdentifier, Ticket));
#endif // MT4ORDERS_FASTHISTORY_OFF

    return (Ticket);
  }

  int GetAmount(void)
  {
    _B2(this.RefreshHistory());

    return ((int)this.Amount);
  }

  long operator[](const uint &Pos)
  {
    long Res = 0;

    if ((Pos >= this.Amount) /* || (!MT4HISTORY::IsTester && (MT4HISTORY::AccountNumber != ::AccountInfoInteger(ACCOUNT_LOGIN)))*/)
    {
      _B2(this.RefreshHistory());

      if (Pos < this.Amount)
        Res = this.Tickets[Pos];
    }
    else
      Res = this.Tickets[Pos];

    return (Res);
  }
};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
static const bool MT4HISTORY::IsTester = ::MQLInfoInteger(MQL_TESTER);
// static long MT4HISTORY::AccountNumber = ::AccountInfoInteger(ACCOUNT_LOGIN);

#undef LASTTIME
#undef THOUSAND
#undef END_TIME
#undef HISTORY_PAUSE
#undef DAY
#undef RESERVE_SIZE

#define OP_BUY ORDER_TYPE_BUY
#define OP_SELL ORDER_TYPE_SELL
#define OP_BUYLIMIT ORDER_TYPE_BUY_LIMIT
#define OP_SELLLIMIT ORDER_TYPE_SELL_LIMIT
#define OP_BUYSTOP ORDER_TYPE_BUY_STOP
#define OP_SELLSTOP ORDER_TYPE_SELL_STOP
#define OP_BALANCE 6

#define SELECT_BY_POS 0
#define SELECT_BY_TICKET 1

#define MODE_TRADES 0
#define MODE_HISTORY 1

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
class MT4ORDERS
{
private:
  static MT4_ORDER Order;
  static MT4HISTORY History;

  static const bool MT4ORDERS::IsTester;
  static const bool MT4ORDERS::IsHedging;

  static int OrderSendBug;

  //  static bool HistorySelectOrder( const ulong &Ticket )
  static bool HistorySelectOrder(const ulong Ticket)
  {
    return (Ticket && ((::HistoryOrderGetInteger(Ticket, ORDER_TICKET) == Ticket) ||
                       (_B2(::HistorySelect(0, INT_MAX)) && (::HistoryOrderGetInteger(Ticket, ORDER_TICKET) == Ticket))));
  }

  static bool HistorySelectDeal(const ulong &Ticket)
  {
    return (Ticket && ((::HistoryDealGetInteger(Ticket, DEAL_TICKET) == Ticket) ||
                       (_B2(::HistorySelect(0, INT_MAX)) && (::HistoryDealGetInteger(Ticket, DEAL_TICKET) == Ticket))));
  }

#define UNKNOWN_COMMISSION DBL_MIN
#define UNKNOWN_REQUEST_PRICE DBL_MIN
#define UNKNOWN_TICKET 0
  // #define UNKNOWN_REASON (-1)

  static bool CheckNewTicket(void)
  {
    return (false); // This functionality is useless - there is INT_MIN/INT_MAX with SELECT_BY_POS + MODE_TRADES

    static long PrevPosTimeUpdate = 0;
    static long PrevPosTicket = 0;

    const long PosTimeUpdate = ::PositionGetInteger(POSITION_TIME_UPDATE_MSC);
    const long PosTicket = ::PositionGetInteger(POSITION_TICKET);

    // In case that the user has not chosen a position via MT4Orders
    // There is no reason to overload MQL5-PositionSelect* and MQL5-OrderSelect.
    // This check is sufficient, since several changes of position + PositionSelect per millisecond are only possible in tester
    const bool Res = ((PosTimeUpdate != PrevPosTimeUpdate) || (PosTicket != PrevPosTicket));

    if (Res)
    {
      MT4ORDERS::GetPositionData();

      PrevPosTimeUpdate = PosTimeUpdate;
      PrevPosTicket = PosTicket;
    }

    return (Res);
  }

  static bool CheckPositionTicketOpen(void)
  {
    if ((MT4ORDERS::Order.TicketOpen == UNKNOWN_TICKET) || MT4ORDERS::CheckNewTicket())
      MT4ORDERS::Order.TicketOpen = (long)_B2(MT4ORDERS::History.GetPositionDealIn()); // All because of this very expensive function

    return (true);
  }

  static bool CheckPositionCommissionComment(void)
  {
    if ((MT4ORDERS::Order.Commission == UNKNOWN_COMMISSION) || MT4ORDERS::CheckNewTicket())
    {
      MT4ORDERS::Order.Commission = 0; // ::PositionGetDouble(POSITION_COMMISSION); // Always zero
      MT4ORDERS::Order.Comment = ::PositionGetString(POSITION_COMMENT);

      if (!MT4ORDERS::Order.Commission || (MT4ORDERS::Order.Comment == ""))
      {
        MT4ORDERS::CheckPositionTicketOpen();

        const ulong Ticket = MT4ORDERS::Order.TicketOpen;

        if ((Ticket > 0) && _B2(MT4ORDERS::HistorySelectDeal(Ticket)))
        {
          if (!MT4ORDERS::Order.Commission)
          {
            const double LotsIn = ::HistoryDealGetDouble(Ticket, DEAL_VOLUME);

            if (LotsIn > 0)
              MT4ORDERS::Order.Commission = ::HistoryDealGetDouble(Ticket, DEAL_COMMISSION) * ::PositionGetDouble(POSITION_VOLUME) / LotsIn;
          }

          if (MT4ORDERS::Order.Comment == "")
            MT4ORDERS::Order.Comment = ::HistoryDealGetString(Ticket, DEAL_COMMENT);
        }
      }
    }

    return (true);
  }
  /*
    static bool CheckPositionOpenReason( void )
    {
      if ((MT4ORDERS::Order.OpenReason == UNKNOWN_REASON) || MT4ORDERS::CheckNewTicket())
      {
        MT4ORDERS::CheckPositionTicketOpen();

        const ulong Ticket = MT4ORDERS::Order.TicketOpen;

        if ((Ticket > 0) && (MT4ORDERS::IsTester || MT4ORDERS::HistorySelectDeal(Ticket)))
          MT4ORDERS::Order.OpenReason = (ENUM_DEAL_REASON)::HistoryDealGetInteger(Ticket, DEAL_REASON);
      }

      return(true);
    }
  */
  static bool CheckPositionOpenPriceRequest(void)
  {
    const long PosTicket = ::PositionGetInteger(POSITION_TICKET);

    if (((MT4ORDERS::Order.OpenPriceRequest == UNKNOWN_REQUEST_PRICE) || MT4ORDERS::CheckNewTicket()) &&
        !(MT4ORDERS::Order.OpenPriceRequest = (_B2(MT4ORDERS::HistorySelectOrder(PosTicket)) &&
                                               (MT4ORDERS::IsTester || (::PositionGetInteger(POSITION_TIME_MSC) ==
                                                                        ::HistoryOrderGetInteger(PosTicket, ORDER_TIME_DONE_MSC)))) // Is this check necessary?
                                                  ? ::HistoryOrderGetDouble(PosTicket, ORDER_PRICE_OPEN)
                                                  : ::PositionGetDouble(POSITION_PRICE_OPEN)))
      MT4ORDERS::Order.OpenPriceRequest = ::PositionGetDouble(POSITION_PRICE_OPEN); // In case the order price is zero

    return (true);
  }

  static void GetPositionData(void)
  {
    MT4ORDERS::Order.Ticket = POSITION_SELECT;

    MT4ORDERS::Order.Commission = UNKNOWN_COMMISSION;          // MT4ORDERS::CheckPositionCommissionComment();
    MT4ORDERS::Order.OpenPriceRequest = UNKNOWN_REQUEST_PRICE; // MT4ORDERS::CheckPositionOpenPriceRequest()
    MT4ORDERS::Order.TicketOpen = UNKNOWN_TICKET;
    //    MT4ORDERS::Order.OpenReason = UNKNOWN_REASON;

    //    const bool AntoWarning = ::OrderSelect(0); // Resets data of the selected position to zero - may be needed for OrderModify

    return;
  }

  // #undef UNKNOWN_REASON
#undef UNKNOWN_TICKET
#undef UNKNOWN_REQUEST_PRICE
#undef UNKNOWN_COMMISSION

  static void GetOrderData(void)
  {
    MT4ORDERS::Order.Ticket = ORDER_SELECT;

    //    ::PositionSelectByTicket(0);  // Resets data of the selected position to zero - may be needed for OrderModify

    return;
  }

  static void GetHistoryOrderData(const ulong Ticket)
  {
    MT4ORDERS::Order.Ticket = ::HistoryOrderGetInteger(Ticket, ORDER_TICKET);
    MT4ORDERS::pOrder.Type = (int)::HistoryOrderGetInteger(Ticket, ORDER_TYPE);

    MT4ORDERS::Order.TicketOpen = MT4ORDERS::Order.Ticket;
    MT4ORDERS::Order.TicketID = MT4ORDERS::Order.Ticket; // A deleted pending order can have a non-zero POSITION_ID.

    MT4ORDERS::Order.Lots = ::HistoryOrderGetDouble(Ticket, ORDER_VOLUME_CURRENT);

    if (!MT4ORDERS::Order.Lots)
      MT4ORDERS::Order.Lots = ::HistoryOrderGetDouble(Ticket, ORDER_VOLUME_INITIAL);

    MT4ORDERS::Order.Symbol = ::HistoryOrderGetString(Ticket, ORDER_SYMBOL);
    MT4ORDERS::Order.Comment = ::HistoryOrderGetString(Ticket, ORDER_COMMENT);

    MT4ORDERS::Order.OpenTimeMsc = ::HistoryOrderGetInteger(Ticket, ORDER_TIME_SETUP_MSC);
    MT4ORDERS::Order.OpenTime = (datetime)(MT4ORDERS::Order.OpenTimeMsc / 1000);

    MT4ORDERS::Order.OpenPrice = ::HistoryOrderGetDouble(Ticket, ORDER_PRICE_OPEN);
    MT4ORDERS::Order.OpenPriceRequest = MT4ORDERS::Order.OpenPrice;

    MT4ORDERS::Order.OpenReason = (ENUM_DEAL_REASON)::HistoryOrderGetInteger(Ticket, ORDER_REASON);

    MT4ORDERS::Order.StopLoss = ::HistoryOrderGetDouble(Ticket, ORDER_SL);
    MT4ORDERS::Order.TakeProfit = ::HistoryOrderGetDouble(Ticket, ORDER_TP);

    MT4ORDERS::Order.CloseTimeMsc = ::HistoryOrderGetInteger(Ticket, ORDER_TIME_DONE_MSC);
    MT4ORDERS::Order.CloseTime = (datetime)(MT4ORDERS::Order.CloseTimeMsc / 1000);

    MT4ORDERS::Order.ClosePrice = ::HistoryOrderGetDouble(Ticket, ORDER_PRICE_CURRENT);
    MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;

    MT4ORDERS::Order.CloseReason = MT4ORDERS::Order.OpenReason;

    MT4ORDERS::Order.State = (ENUM_ORDER_STATE)::HistoryOrderGetInteger(Ticket, ORDER_STATE);

    MT4ORDERS::Order.Expiration = (datetime)::HistoryOrderGetInteger(Ticket, ORDER_TIME_EXPIRATION);

    MT4ORDERS::Order.MagicNumber = ::HistoryOrderGetInteger(Ticket, ORDER_MAGIC);

    MT4ORDERS::Order.Profit = 0;

    MT4ORDERS::Order.Commission = 0;
    MT4ORDERS::Order.Swap = 0;

    return;
  }

  static string GetTickFlag(uint tickflag)
  {
    string flag = " " + (string)tickflag;

#define TICKFLAG_MACRO(A)                                               \
  flag += ((bool)(tickflag & TICK_FLAG_##A)) ? " TICK_FLAG_" + #A : ""; \
  tickflag -= tickflag & TICK_FLAG_##A;
    TICKFLAG_MACRO(BID)
    TICKFLAG_MACRO(ASK)
    TICKFLAG_MACRO(LAST)
    TICKFLAG_MACRO(VOLUME)
    TICKFLAG_MACRO(BUY)
    TICKFLAG_MACRO(SELL)
#undef TICKFLAG_MACRO

    if (tickflag)
      flag += " FLAG_UNKNOWN (" + (string)tickflag + ")";

    return (flag);
  }

#define TOSTR(A) " " + #A + " = " + (string)Tick.A
#define TOSTR2(A) " " + #A + " = " + ::DoubleToString(Tick.A, digits)
#define TOSTR3(A) " " + #A + " = " + (string)(A)

  static string TickToString(const string &Symb, const MqlTick &Tick)
  {
    const int digits = (int)::SymbolInfoInteger(Symb, SYMBOL_DIGITS);

    return (TOSTR3(Symb) + TOSTR(time) + "." + ::IntegerToString(Tick.time_msc % 1000, 3, '0') +
            TOSTR2(bid) + TOSTR2(ask) + TOSTR2(last) + TOSTR(volume) + MT4ORDERS::GetTickFlag(Tick.flags));
  }

  static string TickToString(const string &Symb)
  {
    MqlTick Tick = {};

    return (TOSTR3(::SymbolInfoTick(Symb, Tick)) + MT4ORDERS::TickToString(Symb, Tick));
  }

#undef TOSTR3
#undef TOSTR2
#undef TOSTR

  static void AlertLog(void)
  {
    ::Alert("Please send the logs to the coauthor - https://www.mql5.com/en/users/fxsaber");

    string Str = ::TimeToString(::TimeLocal(), TIME_DATE);
    ::StringReplace(Str, ".", NULL);

    ::Alert(::TerminalInfoString(TERMINAL_PATH) + "\\MQL5\\Logs\\" + Str + ".log");

    return;
  }

  static long GetTimeCurrent(void)
  {
    long Res = 0;
    MqlTick Tick = {};

    for (int i = ::SymbolsTotal(true) - 1; i >= 0; i--)
    {
      const string SymbName = ::SymbolName(i, true);

      if (!::SymbolInfoInteger(SymbName, SYMBOL_CUSTOM) && ::SymbolInfoTick(SymbName, Tick) && (Tick.time_msc > Res))
        Res = Tick.time_msc;
    }

    return (Res);
  }

  static string TimeToString(const long time)
  {
    return ((string)(datetime)(time / 1000) + "." + ::IntegerToString(time % 1000, 3, '0'));
  }

#define WHILE(A) while ((!(Res = (A))) && MT4ORDERS::Waiting())

#define TOSTR(A) #A + " = " + (string)(A) + "\n"
#define TOSTR2(A) #A + " = " + ::EnumToString(A) + " (" + (string)(A) + ")\n"

  static void GetHistoryPositionData(const ulong Ticket)
  {
    MT4ORDERS::Order.Ticket = (long)Ticket;
    MT4ORDERS::Order.TicketID = ::HistoryDealGetInteger(MT4ORDERS::Order.Ticket, DEAL_POSITION_ID);
    MT4ORDERS::Order.Type = (int)::HistoryDealGetInteger(Ticket, DEAL_TYPE);

    if ((MT4ORDERS::Order.Type > OP_SELL))
      MT4ORDERS::Order.Type += (OP_BALANCE - OP_SELL - 1);
    else
      MT4ORDERS::Order.Type = 1 - MT4ORDERS::Order.Type;

    MT4ORDERS::Order.Lots = ::HistoryDealGetDouble(Ticket, DEAL_VOLUME);

    MT4ORDERS::Order.Symbol = ::HistoryDealGetString(Ticket, DEAL_SYMBOL);
    MT4ORDERS::Order.Comment = ::HistoryDealGetString(Ticket, DEAL_COMMENT);

    MT4ORDERS::Order.CloseTimeMsc = ::HistoryDealGetInteger(Ticket, DEAL_TIME_MSC);
    MT4ORDERS::Order.CloseTime = (datetime)(MT4ORDERS::Order.CloseTimeMsc / 1000); // (datetime)::HistoryDealGetInteger(Ticket, DEAL_TIME);

    MT4ORDERS::Order.ClosePrice = ::HistoryDealGetDouble(Ticket, DEAL_PRICE);

    MT4ORDERS::Order.CloseReason = (ENUM_DEAL_REASON)::HistoryDealGetInteger(Ticket, DEAL_REASON);

    MT4ORDERS::Order.Expiration = 0;

    MT4ORDERS::Order.MagicNumber = ::HistoryDealGetInteger(Ticket, DEAL_MAGIC);

    MT4ORDERS::Order.Profit = ::HistoryDealGetDouble(Ticket, DEAL_PROFIT);

    MT4ORDERS::Order.Commission = ::HistoryDealGetDouble(Ticket, DEAL_COMMISSION);
    MT4ORDERS::Order.Swap = ::HistoryDealGetDouble(Ticket, DEAL_SWAP);

#ifndef MT4ORDERS_SLTP_OLD
    MT4ORDERS::Order.StopLoss = ::HistoryDealGetDouble(Ticket, DEAL_SL);
    MT4ORDERS::Order.TakeProfit = ::HistoryDealGetDouble(Ticket, DEAL_TP);
#else  // MT4ORDERS_SLTP_OLD
    MT4ORDERS::Order.StopLoss = 0;
    MT4ORDERS::Order.TakeProfit = 0;
#endif // MT4ORDERS_SLTP_OLD

    const ulong OrderTicket = (MT4ORDERS::Order.Type < OP_BALANCE) ? ::HistoryDealGetInteger(Ticket, DEAL_ORDER) : 0;
    const ulong PosTicket = MT4ORDERS::Order.TicketID;
    const ulong OpenTicket = (OrderTicket > 0) ? _B2(MT4ORDERS::History.GetPositionDealIn(PosTicket)) : 0;

    if (OpenTicket > 0)
    {
      const ENUM_DEAL_REASON Reason = (ENUM_DEAL_REASON)HistoryDealGetInteger(Ticket, DEAL_REASON);
      const ENUM_DEAL_ENTRY DealEntry = (ENUM_DEAL_ENTRY)::HistoryDealGetInteger(Ticket, DEAL_ENTRY);

      // History (OpenTicket and OrderTicket) is loaded due to GetPositionDealIn, - HistorySelectByPosition
#ifdef MT4ORDERS_FASTHISTORY_OFF
      const bool Res = true;
#else  // MT4ORDERS_FASTHISTORY_OFF
       // Partial execution will generate the necessary order - https://www.mql5.com/ru/forum/227423/page2#comment_6543129
      bool Res = MT4ORDERS::IsTester ? MT4ORDERS::HistorySelectOrder(OrderTicket) : MT4ORDERS::Waiting(true);

      // Можно долго ждать в этой ситуации: https://www.mql5.com/ru/forum/170952/page184#comment_17913645
      if (!Res)
        WHILE(_B2(MT4ORDERS::HistorySelectOrder(OrderTicket))) // https://www.mql5.com/ru/forum/304239#comment_10710403
        ;

      if (_B2(MT4ORDERS::HistorySelectDeal(OpenTicket))) // It will surely work, since OpenTicket is reliably in history.
#endif // MT4ORDERS_FASTHISTORY_OFF
      {
        MT4ORDERS::Order.TicketOpen = (long)OpenTicket;

        MT4ORDERS::Order.OpenReason = (ENUM_DEAL_REASON)HistoryDealGetInteger(OpenTicket, DEAL_REASON);

        MT4ORDERS::Order.OpenPrice = ::HistoryDealGetDouble(OpenTicket, DEAL_PRICE);

        MT4ORDERS::Order.OpenTimeMsc = ::HistoryDealGetInteger(OpenTicket, DEAL_TIME_MSC);
        MT4ORDERS::Order.OpenTime = (datetime)(MT4ORDERS::Order.OpenTimeMsc / 1000);

        const double OpenLots = ::HistoryDealGetDouble(OpenTicket, DEAL_VOLUME);

        if (OpenLots > 0)
          MT4ORDERS::Order.Commission += ::HistoryDealGetDouble(OpenTicket, DEAL_COMMISSION) * MT4ORDERS::Order.Lots / OpenLots;

        //        if (!MT4ORDERS::Order.MagicNumber) // Magic number of a closed position must always be equal to that of the opening deal.
        const long Magic = ::HistoryDealGetInteger(OpenTicket, DEAL_MAGIC);

        if (Magic)
          MT4ORDERS::Order.MagicNumber = Magic;

        //        if (MT4ORDERS::Order.Comment == "") // Comment on a closed position must always be equal to that on the opening deal.
        const string StrComment = ::HistoryDealGetString(OpenTicket, DEAL_COMMENT);

        if (Res) // OrderTicket may be absent in history, but it may be found among those still alive. It is probably reasonable to wheedle info out of there.
        {
          double OrderPriceOpen = ::HistoryOrderGetDouble(OrderTicket, ORDER_PRICE_OPEN);

#ifdef MT4ORDERS_SLTP_OLD
          if (Reason == DEAL_REASON_TP)
          {
            if (!OrderPriceOpen)
              // https://www.mql5.com/ru/forum/1111/page2820#comment_17749873
              OrderPriceOpen = (double)::StringSubstr(MT4ORDERS::Order.Comment, MT4ORDERS::IsTester ? 3 : (::StringFind(MT4ORDERS::Order.Comment, "tp ") + 3));

            MT4ORDERS::Order.TakeProfit = OrderPriceOpen;
            MT4ORDERS::Order.StopLoss = ::HistoryOrderGetDouble(OrderTicket, ORDER_TP);
          }
          else if (Reason == DEAL_REASON_SL)
          {
            if (!OrderPriceOpen)
              // https://www.mql5.com/ru/forum/1111/page2820#comment_17749873
              OrderPriceOpen = (double)::StringSubstr(MT4ORDERS::Order.Comment, MT4ORDERS::IsTester ? 3 : (::StringFind(MT4ORDERS::Order.Comment, "sl ") + 3));

            MT4ORDERS::Order.StopLoss = OrderPriceOpen;
            MT4ORDERS::Order.TakeProfit = ::HistoryOrderGetDouble(OrderTicket, ORDER_SL);
          }
          else if (!MT4ORDERS::IsTester && ::StringLen(MT4ORDERS::Order.Comment) > 3)
          {
            const string PartComment = ::StringSubstr(MT4ORDERS::Order.Comment, 0, 3);

            if (PartComment == "[tp")
            {
              MT4ORDERS::Order.CloseReason = DEAL_REASON_TP;

              if (!OrderPriceOpen)
                // https://www.mql5.com/ru/forum/1111/page2820#comment_17749873
                OrderPriceOpen = (double)::StringSubstr(MT4ORDERS::Order.Comment, MT4ORDERS::IsTester ? 3 : (::StringFind(MT4ORDERS::Order.Comment, "tp ") + 3));

              MT4ORDERS::Order.TakeProfit = OrderPriceOpen;
              MT4ORDERS::Order.StopLoss = ::HistoryOrderGetDouble(OrderTicket, ORDER_TP);
            }
            else if (PartComment == "[sl")
            {
              MT4ORDERS::Order.CloseReason = DEAL_REASON_SL;

              if (!OrderPriceOpen)
                // https://www.mql5.com/ru/forum/1111/page2820#comment_17749873
                OrderPriceOpen = (double)::StringSubstr(MT4ORDERS::Order.Comment, MT4ORDERS::IsTester ? 3 : (::StringFind(MT4ORDERS::Order.Comment, "sl ") + 3));

              MT4ORDERS::Order.StopLoss = OrderPriceOpen;
              MT4ORDERS::Order.TakeProfit = ::HistoryOrderGetDouble(OrderTicket, ORDER_SL);
            }
            else
            {
              // Reversed - not an error: see OrderClose.
              MT4ORDERS::Order.StopLoss = ::HistoryOrderGetDouble(OrderTicket, ORDER_TP);
              MT4ORDERS::Order.TakeProfit = ::HistoryOrderGetDouble(OrderTicket, ORDER_SL);
            }
          }
          else
          {
            // Reversed - not an error: see OrderClose.
            MT4ORDERS::Order.StopLoss = ::HistoryOrderGetDouble(OrderTicket, ORDER_TP);
            MT4ORDERS::Order.TakeProfit = ::HistoryOrderGetDouble(OrderTicket, ORDER_SL);
          }
#endif // MT4ORDERS_SLTP_OLD

          MT4ORDERS::Order.State = (ENUM_ORDER_STATE)::HistoryOrderGetInteger(OrderTicket, ORDER_STATE);

          if (!(MT4ORDERS::Order.ClosePriceRequest = (DealEntry == DEAL_ENTRY_OUT_BY) ? MT4ORDERS::Order.ClosePrice : OrderPriceOpen))
            MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;

          if (!(MT4ORDERS::Order.OpenPriceRequest = _B2(MT4ORDERS::HistorySelectOrder(PosTicket) &&
                                                        // During partial execution, only the last deal of a fully executed order has this condition for taking the request price.
                                                        (MT4ORDERS::IsTester || (::HistoryDealGetInteger(OpenTicket, DEAL_TIME_MSC) == ::HistoryOrderGetInteger(PosTicket, ORDER_TIME_DONE_MSC))))
                                                        ? ::HistoryOrderGetDouble(PosTicket, ORDER_PRICE_OPEN)
                                                        : MT4ORDERS::Order.OpenPrice))
            MT4ORDERS::Order.OpenPriceRequest = MT4ORDERS::Order.OpenPrice;
        }
        else
        {
          MT4ORDERS::Order.State = ORDER_STATE_FILLED;

          MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;
          MT4ORDERS::Order.OpenPriceRequest = MT4ORDERS::Order.OpenPrice;
        }

        // The comment above is used to find SL/TP.
        if (StrComment != "")
          MT4ORDERS::Order.Comment = StrComment;
      }

      if (!Res)
      {
        ::Alert("HistoryOrderSelect(" + (string)OrderTicket + ") - BUG! MT4ORDERS - not Sync with History!");
        MT4ORDERS::AlertLog();

        ::Print(__FILE__ + "\nVersion = " + __MT4ORDERS__ + "\nCompiler = " + (string)__MQLBUILD__ + "\n" + TOSTR(__DATE__) +
                TOSTR(::AccountInfoString(ACCOUNT_SERVER)) + TOSTR2((ENUM_ACCOUNT_TRADE_MODE)::AccountInfoInteger(ACCOUNT_TRADE_MODE)) +
                TOSTR((bool)::TerminalInfoInteger(TERMINAL_CONNECTED)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_PING_LAST)) + TOSTR(::TerminalInfoDouble(TERMINAL_RETRANSMISSION)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_BUILD)) + TOSTR((bool)::TerminalInfoInteger(TERMINAL_X64)) +
                TOSTR((bool)::TerminalInfoInteger(TERMINAL_VPS)) + TOSTR2((ENUM_PROGRAM_TYPE)::MQLInfoInteger(MQL_PROGRAM_TYPE)) +
                TOSTR(::TimeCurrent()) + TOSTR(::TimeTradeServer()) + TOSTR(MT4ORDERS::TimeToString(MT4ORDERS::GetTimeCurrent())) +
                TOSTR(::SymbolInfoString(MT4ORDERS::Order.Symbol, SYMBOL_PATH)) + TOSTR(::SymbolInfoString(MT4ORDERS::Order.Symbol, SYMBOL_DESCRIPTION)) +
                "CurrentTick =" + MT4ORDERS::TickToString(MT4ORDERS::Order.Symbol) + "\n" +
                TOSTR(::PositionsTotal()) + TOSTR(::OrdersTotal()) +
                TOSTR(::HistorySelect(0, INT_MAX)) + TOSTR(::HistoryDealsTotal()) + TOSTR(::HistoryOrdersTotal()) +
                TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_AVAILABLE)) + TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_PHYSICAL)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_TOTAL)) + TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_USED)) +
                TOSTR(::MQLInfoInteger(MQL_MEMORY_LIMIT)) + TOSTR(::MQLInfoInteger(MQL_MEMORY_USED)) +
                TOSTR(Ticket) + TOSTR(OrderTicket) + TOSTR(OpenTicket) + TOSTR(PosTicket) +
                TOSTR(MT4ORDERS::TimeToString(MT4ORDERS::Order.CloseTimeMsc)) +
                TOSTR(MT4ORDERS::HistorySelectOrder(OrderTicket)) + TOSTR(::OrderSelect(OrderTicket)) +
                (::OrderSelect(OrderTicket) ? TOSTR2((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE)) : NULL) +
                (::HistoryDealsTotal() ? TOSTR(::HistoryDealGetTicket(::HistoryDealsTotal() - 1)) +
                                             "DEAL_ORDER = " + (string)::HistoryDealGetInteger(::HistoryDealGetTicket(::HistoryDealsTotal() - 1), DEAL_ORDER) + "\n"
                                                                                                                                                                "DEAL_TIME_MSC = " +
                                             MT4ORDERS::TimeToString(::HistoryDealGetInteger(::HistoryDealGetTicket(::HistoryDealsTotal() - 1), DEAL_TIME_MSC)) + "\n"
                                       : NULL) +
                (::HistoryOrdersTotal() ? TOSTR(::HistoryOrderGetTicket(::HistoryOrdersTotal() - 1)) +
                                              "ORDER_TIME_DONE_MSC = " + MT4ORDERS::TimeToString(::HistoryOrderGetInteger(::HistoryOrderGetTicket(::HistoryOrdersTotal() - 1), ORDER_TIME_DONE_MSC)) + "\n"
                                        : NULL) +
#ifdef MT4ORDERS_BYPASS_MAXTIME
                "MT4ORDERS::ByPass: " + MT4ORDERS::ByPass.ToString() + "\n" +
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME
                TOSTR(MT4ORDERS::OrderSend_MaxPause));
      }
    }
    else
    {
      MT4ORDERS::Order.TicketOpen = MT4ORDERS::Order.Ticket;

      if (!MT4ORDERS::Order.TicketID && (MT4ORDERS::Order.Type <= OP_SELL)) // ID of balance deals must remain zero.
        MT4ORDERS::Order.TicketID = MT4ORDERS::Order.Ticket;

      MT4ORDERS::Order.OpenPrice = MT4ORDERS::Order.ClosePrice; // ::HistoryDealGetDouble(Ticket, DEAL_PRICE);

      MT4ORDERS::Order.OpenTimeMsc = MT4ORDERS::Order.CloseTimeMsc;
      MT4ORDERS::Order.OpenTime = MT4ORDERS::Order.CloseTime; // (datetime)::HistoryDealGetInteger(Ticket, DEAL_TIME);

      MT4ORDERS::Order.OpenReason = MT4ORDERS::Order.CloseReason;

      MT4ORDERS::Order.State = ORDER_STATE_FILLED;

      MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;
      MT4ORDERS::Order.OpenPriceRequest = MT4ORDERS::Order.OpenPrice;
    }

    if (OrderTicket)
    {
      bool Res = MT4ORDERS::IsTester ? MT4ORDERS::HistorySelectOrder(OrderTicket) : MT4ORDERS::Waiting(true);

      if (!Res)
        WHILE(_B2(MT4ORDERS::HistorySelectOrder(OrderTicket))) // https://www.mql5.com/ru/forum/304239#comment_10710403
        ;

      if ((ENUM_ORDER_TYPE)::HistoryOrderGetInteger(OrderTicket, ORDER_TYPE) == ORDER_TYPE_CLOSE_BY)
      {
        const ulong PosTicketBy = ::HistoryOrderGetInteger(OrderTicket, ORDER_POSITION_BY_ID);

        if (PosTicketBy == PosTicket) // CloseBy-Slave should not affect the total trade.
        {
          MT4ORDERS::Order.Lots = 0;
          MT4ORDERS::Order.Commission = 0;

          MT4ORDERS::Order.ClosePrice = MT4ORDERS::Order.OpenPrice;
          MT4ORDERS::Order.ClosePriceRequest = MT4ORDERS::Order.ClosePrice;
        }
        else // CloseBy-Master must receive a commission from CloseBy-Slave.
        {
          const ulong OpenTicketBy = (OrderTicket > 0) ? _B2(MT4ORDERS::History.GetPositionDealIn(PosTicketBy)) : 0;

          if ((OpenTicketBy > 0) && _B2(MT4ORDERS::HistorySelectDeal(OpenTicketBy)))
          {
            const double OpenLots = ::HistoryDealGetDouble(OpenTicketBy, DEAL_VOLUME);

            if (OpenLots > 0)
              MT4ORDERS::Order.Commission += ::HistoryDealGetDouble(OpenTicketBy, DEAL_COMMISSION) * MT4ORDERS::Order.Lots / OpenLots;
          }
        }
      }
    }

    return;
  }

  static bool Waiting(const bool FlagInit = false)
  {
    static ulong StartTime = 0;

    const bool Res = FlagInit ? false : (::GetMicrosecondCount() - StartTime < MT4ORDERS::OrderSend_MaxPause);

    if (FlagInit)
    {
      StartTime = ::GetMicrosecondCount();

      MT4ORDERS::OrderSendBug = 0;
    }
    else if (Res)
    {
      //      ::Sleep(0); // https://www.mql5.com/ru/forum/170952/page100#comment_8750511

      MT4ORDERS::OrderSendBug++;
    }

    return (Res);
  }

  static bool EqualPrices(const double Price1, const double &Price2, const int &digits)
  {
    return (!::NormalizeDouble(Price1 - Price2, digits));
  }

  static bool HistoryDealSelect2(MqlTradeResult &Result) // At the end of the name there is a digit for greater compatibility with macros.
  {
#ifdef MT4ORDERS_HISTORY_OLD
    // Replace HistorySelectByPosition with HistorySelect(PosTime, PosTime)
    if (!Result.deal && Result.order && _B3(::HistorySelectByPosition(::HistoryOrderGetInteger(Result.order, ORDER_POSITION_ID))))
    {
#else                                  // #ifdef MT4ORDERS_HISTORY_OLD
    if (!Result.deal && Result.order && _B2(MT4ORDERS::HistorySelectOrder(Result.order)))
    {
      const long OrderTimeFill = ::HistoryOrderGetInteger(Result.order, ORDER_TIME_DONE_MSC);
#endif                                 // #ifdef MT4ORDERS_HISTORY_OLD #else
      if (::HistorySelect(0, INT_MAX)) // Without it, the deal detection may fail.
        for (int i = ::HistoryDealsTotal() - 1; i >= 0; i--)
        {
          const ulong DealTicket = ::HistoryDealGetTicket(i);

          if (Result.order == ::HistoryDealGetInteger(DealTicket, DEAL_ORDER))
          {
            Result.deal = DealTicket;
            Result.price = ::HistoryDealGetDouble(DealTicket, DEAL_PRICE);

            break;
          }
#ifndef MT4ORDERS_HISTORY_OLD
          else if (::HistoryDealGetInteger(DealTicket, DEAL_TIME_MSC) < OrderTimeFill)
            break;
#endif // #ifndef MT4ORDERS_HISTORY_OLD
        }
    }

    return (_B2(MT4ORDERS::HistorySelectDeal(Result.deal)));
  }

  /*
  #define MT4ORDERS_BENCHMARK Alert(MT4ORDERS::LastTradeRequest.symbol + " " +       \
                                    (string)MT4ORDERS::LastTradeResult.order + " " + \
                                    MT4ORDERS::LastTradeResult.comment);             \
                              Print(ToString(MT4ORDERS::LastTradeRequest) +          \
                                    ToString(MT4ORDERS::LastTradeResult));
  */

#define TMP_MT4ORDERS_BENCHMARK(A) \
  static ulong Max##A = 0;         \
                                   \
  if (Interval##A > Max##A)        \
  {                                \
    MT4ORDERS_BENCHMARK            \
                                   \
    Max##A = Interval##A;          \
  }

  static void OrderSend_Benchmark(const ulong &Interval1, const ulong &Interval2)
  {
#ifdef MT4ORDERS_BENCHMARK
    TMP_MT4ORDERS_BENCHMARK(1)
    TMP_MT4ORDERS_BENCHMARK(2)
#endif // MT4ORDERS_BENCHMARK

    return;
  }

#undef TMP_MT4ORDERS_BENCHMARK

  static string ToString(const MqlTradeRequest &Request)
  {
    return (TOSTR2(Request.action) + TOSTR(Request.magic) + TOSTR(Request.order) +
            TOSTR(Request.symbol) + TOSTR(Request.volume) + TOSTR(Request.price) +
            TOSTR(Request.stoplimit) + TOSTR(Request.sl) + TOSTR(Request.tp) +
            TOSTR(Request.deviation) + TOSTR2(Request.type) + TOSTR2(Request.type_filling) +
            TOSTR2(Request.type_time) + TOSTR(Request.expiration) + TOSTR(Request.comment) +
            TOSTR(Request.position) + TOSTR(Request.position_by));
  }

  static string ToString(const MqlTradeResult &Result)
  {
    return (TOSTR(Result.retcode) + TOSTR(Result.deal) + TOSTR(Result.order) +
            TOSTR(Result.volume) + TOSTR(Result.price) + TOSTR(Result.bid) +
            TOSTR(Result.ask) + TOSTR(Result.comment) + TOSTR(Result.request_id) +
            TOSTR(Result.retcode_external));
  }

  static bool OrderSend(const MqlTradeRequest &Request, MqlTradeResult &Result)
  {
    const bool FlagCalc = !MT4ORDERS::IsTester && MT4ORDERS::OrderSend_MaxPause;

    MqlTick PrevTick = {};

    if (FlagCalc)
      ::SymbolInfoTick(Request.symbol, PrevTick); // May slow down.

    const long PrevTimeCurrent = FlagCalc ? _B2(MT4ORDERS::GetTimeCurrent()) : 0;
    const ulong StartTime1 = FlagCalc ? ::GetMicrosecondCount() : 0;

    bool Res = ::OrderSend(Request, Result);

    const ulong StartTime2 = FlagCalc ? ::GetMicrosecondCount() : 0;

    const ulong Interval1 = StartTime2 - StartTime1;

    if (FlagCalc && Res && (Result.retcode < TRADE_RETCODE_ERROR))
    {
      Res = (Result.retcode == TRADE_RETCODE_DONE);
      MT4ORDERS::Waiting(true);

      // TRADE_ACTION_CLOSE_BY is not present in the list of checks
      if (Request.action == TRADE_ACTION_DEAL)
      {
        if (!Result.deal)
        {
          WHILE(_B2(::OrderSelect(Result.order)) || _B2(MT4ORDERS::HistorySelectOrder(Result.order)));

          if (!Res)
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(::OrderSelect(Result.order)) + TOSTR(MT4ORDERS::HistorySelectOrder(Result.order)));
          else if (::OrderSelect(Result.order) && !(Res = ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PLACED) ||
                                                          ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PARTIAL)))
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(::OrderSelect(Result.order)) + TOSTR2((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE)));
        }

        // If the remaining part is still hanging after the partial execution, false.
        if (Res)
        {
          const bool ResultDeal = (!Result.deal) && (!MT4ORDERS::OrderSendBug);

          if (MT4ORDERS::OrderSendBug && (!Result.deal))
            ::Print("Line = " + (string)__LINE__ + "\n" + "Before ::HistoryOrderSelect(Result.order):\n" + TOSTR(MT4ORDERS::OrderSendBug) + TOSTR(Result.deal));

          WHILE(_B2(MT4ORDERS::HistorySelectOrder(Result.order)));

          // If there was no OrderSend bug and there was Result.deal == 0
          if (ResultDeal)
            MT4ORDERS::OrderSendBug = 0;

          if (!Res)
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(MT4ORDERS::HistorySelectOrder(Result.order)) +
                    TOSTR(MT4ORDERS::HistorySelectDeal(Result.deal)) + TOSTR(::OrderSelect(Result.order)) + TOSTR(Result.deal));
          // If the historical order was not executed (due to rejection), false
          else if (!(Res = ((ENUM_ORDER_STATE)::HistoryOrderGetInteger(Result.order, ORDER_STATE) == ORDER_STATE_FILLED) ||
                           ((ENUM_ORDER_STATE)::HistoryOrderGetInteger(Result.order, ORDER_STATE) == ORDER_STATE_PARTIAL)))
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR2((ENUM_ORDER_STATE)::HistoryOrderGetInteger(Result.order, ORDER_STATE)));
        }

        if (Res)
        {
          const bool ResultDeal = (!Result.deal) && (!MT4ORDERS::OrderSendBug);

          if (MT4ORDERS::OrderSendBug && (!Result.deal))
            ::Print("Line = " + (string)__LINE__ + "\n" + "Before MT4ORDERS::HistoryDealSelect(Result):\n" + TOSTR(MT4ORDERS::OrderSendBug) + TOSTR(Result.deal));

          WHILE(MT4ORDERS::HistoryDealSelect2(Result));

          // If there was no OrderSend bug and there was Result.deal == 0
          if (ResultDeal)
            MT4ORDERS::OrderSendBug = 0;

          if (!Res)
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(MT4ORDERS::HistoryDealSelect2(Result)));
        }
      }
      else if (Request.action == TRADE_ACTION_PENDING)
      {
        if (Res)
        {
          WHILE(_B2(::OrderSelect(Result.order)));

          if (!Res)
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(::OrderSelect(Result.order)));
          else if (!(Res = ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PLACED) ||
                           ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) == ORDER_STATE_PARTIAL)))
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR2((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE)));
        }
        else
        {
          WHILE(_B2(MT4ORDERS::HistorySelectOrder(Result.order)));

          ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(MT4ORDERS::HistorySelectOrder(Result.order)));

          Res = false;
        }
      }
      else if (Request.action == TRADE_ACTION_SLTP)
      {
        if (Res)
        {
          const int digits = (int)::SymbolInfoInteger(Request.symbol, SYMBOL_DIGITS);

          bool EqualSL = false;
          bool EqualTP = false;

          do
            if (Request.position ? _B2(::PositionSelectByTicket(Request.position)) : _B2(::PositionSelect(Request.symbol)))
            {
              EqualSL = MT4ORDERS::EqualPrices(::PositionGetDouble(POSITION_SL), Request.sl, digits);
              EqualTP = MT4ORDERS::EqualPrices(::PositionGetDouble(POSITION_TP), Request.tp, digits);
            }
          WHILE(EqualSL && EqualTP);

          if (!Res)
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(::PositionGetDouble(POSITION_SL)) + TOSTR(::PositionGetDouble(POSITION_TP)) +
                    TOSTR(EqualSL) + TOSTR(EqualTP) +
                    TOSTR(Request.position ? ::PositionSelectByTicket(Request.position) : ::PositionSelect(Request.symbol)));
        }
      }
      else if (Request.action == TRADE_ACTION_MODIFY)
      {
        if (Res)
        {
          const int digits = (int)::SymbolInfoInteger(Request.symbol, SYMBOL_DIGITS);

          bool EqualSL = false;
          bool EqualTP = false;
          bool EqualPrice = false;

          do
            // https://www.mql5.com/ru/forum/170952/page184#comment_17913645
            if (_B2(::OrderSelect(Result.order)) && ((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE) != ORDER_STATE_REQUEST_MODIFY))
            {
              EqualSL = MT4ORDERS::EqualPrices(::OrderGetDouble(ORDER_SL), Request.sl, digits);
              EqualTP = MT4ORDERS::EqualPrices(::OrderGetDouble(ORDER_TP), Request.tp, digits);
              EqualPrice = MT4ORDERS::EqualPrices(::OrderGetDouble(ORDER_PRICE_OPEN), Request.price, digits);
            }
          WHILE((EqualSL && EqualTP && EqualPrice));

          if (!Res)
            ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(::OrderGetDouble(ORDER_SL)) + TOSTR(Request.sl) +
                    TOSTR(::OrderGetDouble(ORDER_TP)) + TOSTR(Request.tp) +
                    TOSTR(::OrderGetDouble(ORDER_PRICE_OPEN)) + TOSTR(Request.price) +
                    TOSTR(EqualSL) + TOSTR(EqualTP) + TOSTR(EqualPrice) +
                    TOSTR(::OrderSelect(Result.order)) +
                    TOSTR2((ENUM_ORDER_STATE)::OrderGetInteger(ORDER_STATE)));
        }
      }
      else if (Request.action == TRADE_ACTION_REMOVE)
      {
        if (Res)
          WHILE(_B2(MT4ORDERS::HistorySelectOrder(Result.order)));

        if (!Res)
          ::Print("Line = " + (string)__LINE__ + "\n" + TOSTR(MT4ORDERS::HistorySelectOrder(Result.order)));
      }

      const ulong Interval2 = ::GetMicrosecondCount() - StartTime2;

      Result.comment += " " + ::DoubleToString(Interval1 / 1000.0, 3) + " + " +
                        ::DoubleToString(Interval2 / 1000.0, 3) + " (" + (string)MT4ORDERS::OrderSendBug + ") ms.";

      if (!Res || MT4ORDERS::OrderSendBug)
      {
        ::Alert(Res ? "OrderSend(" + (string)Result.order + ") - BUG!" : "MT4ORDERS - not Sync with History!");
        MT4ORDERS::AlertLog();

        ::Print(__FILE__ + "\nVersion = " + __MT4ORDERS__ + "\nCompiler = " + (string)__MQLBUILD__ + "\n" + TOSTR(__DATE__) +
                TOSTR(::AccountInfoString(ACCOUNT_SERVER)) + TOSTR2((ENUM_ACCOUNT_TRADE_MODE)::AccountInfoInteger(ACCOUNT_TRADE_MODE)) +
                TOSTR((bool)::TerminalInfoInteger(TERMINAL_CONNECTED)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_PING_LAST)) + TOSTR(::TerminalInfoDouble(TERMINAL_RETRANSMISSION)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_BUILD)) + TOSTR((bool)::TerminalInfoInteger(TERMINAL_X64)) +
                TOSTR((bool)::TerminalInfoInteger(TERMINAL_VPS)) + TOSTR2((ENUM_PROGRAM_TYPE)::MQLInfoInteger(MQL_PROGRAM_TYPE)) +
                TOSTR(::TimeCurrent()) + TOSTR(::TimeTradeServer()) +
                TOSTR(MT4ORDERS::TimeToString(MT4ORDERS::GetTimeCurrent())) + TOSTR(MT4ORDERS::TimeToString(PrevTimeCurrent)) +
                "PrevTick =" + MT4ORDERS::TickToString(Request.symbol, PrevTick) + "\n" +
                "CurrentTick =" + MT4ORDERS::TickToString(Request.symbol) + "\n" +
                TOSTR(::SymbolInfoString(Request.symbol, SYMBOL_PATH)) + TOSTR(::SymbolInfoString(Request.symbol, SYMBOL_DESCRIPTION)) +
                TOSTR(::PositionsTotal()) + TOSTR(::OrdersTotal()) +
                TOSTR(::HistorySelect(0, INT_MAX)) + TOSTR(::HistoryDealsTotal()) + TOSTR(::HistoryOrdersTotal()) +
                (::HistoryDealsTotal() ? TOSTR(::HistoryDealGetTicket(::HistoryDealsTotal() - 1)) +
                                             "DEAL_ORDER = " + (string)::HistoryDealGetInteger(::HistoryDealGetTicket(::HistoryDealsTotal() - 1), DEAL_ORDER) + "\n"
                                                                                                                                                                "DEAL_TIME_MSC = " +
                                             MT4ORDERS::TimeToString(::HistoryDealGetInteger(::HistoryDealGetTicket(::HistoryDealsTotal() - 1), DEAL_TIME_MSC)) + "\n"
                                       : NULL) +
                (::HistoryOrdersTotal() ? TOSTR(::HistoryOrderGetTicket(::HistoryOrdersTotal() - 1)) +
                                              "ORDER_TIME_DONE_MSC = " + MT4ORDERS::TimeToString(::HistoryOrderGetInteger(::HistoryOrderGetTicket(::HistoryOrdersTotal() - 1), ORDER_TIME_DONE_MSC)) + "\n"
                                        : NULL) +
                TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_AVAILABLE)) + TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_PHYSICAL)) +
                TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_TOTAL)) + TOSTR(::TerminalInfoInteger(TERMINAL_MEMORY_USED)) +
                TOSTR(::MQLInfoInteger(MQL_MEMORY_LIMIT)) + TOSTR(::MQLInfoInteger(MQL_MEMORY_USED)) +
                TOSTR(MT4ORDERS::IsHedging) + TOSTR(Res) + TOSTR(MT4ORDERS::OrderSendBug) +
                MT4ORDERS::ToString(Request) + MT4ORDERS::ToString(Result) +
#ifdef MT4ORDERS_BYPASS_MAXTIME
                "MT4ORDERS::ByPass: " + MT4ORDERS::ByPass.ToString() + "\n" +
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME
                TOSTR(MT4ORDERS::OrderSend_MaxPause));
      }
      else
        MT4ORDERS::OrderSend_Benchmark(Interval1, Interval2);
    }
    else if (FlagCalc)
    {
      Result.comment += " " + ::DoubleToString(Interval1 / 1000.0, 3) + " ms";

      ::Print(TOSTR(::TimeCurrent()) + TOSTR(::TimeTradeServer()) + TOSTR(MT4ORDERS::TimeToString(PrevTimeCurrent)) +
              MT4ORDERS::TickToString(Request.symbol, PrevTick) + "\n" + MT4ORDERS::TickToString(Request.symbol) + "\n" +
              MT4ORDERS::ToString(Request) + MT4ORDERS::ToString(Result));

      //      ExpertRemove();
    }

    return (Res);
  }

#undef TOSTR2
#undef TOSTR
#undef WHILE

  static ENUM_DAY_OF_WEEK GetDayOfWeek(const datetime &time)
  {
    MqlDateTime sTime = {};

    ::TimeToStruct(time, sTime);

    return ((ENUM_DAY_OF_WEEK)sTime.day_of_week);
  }

  static bool SessionTrade(const string &Symb)
  {
    datetime TimeNow = ::TimeCurrent();

    const ENUM_DAY_OF_WEEK DayOfWeek = MT4ORDERS::GetDayOfWeek(TimeNow);

    TimeNow %= 24 * 60 * 60;

    bool Res = false;
    datetime From, To;

    for (int i = 0; (!Res) && ::SymbolInfoSessionTrade(Symb, DayOfWeek, i, From, To); i++)
      Res = ((From <= TimeNow) && (TimeNow < To));

    return (Res);
  }

  static bool SymbolTrade(const string &Symb)
  {
    MqlTick Tick;

    return (::SymbolInfoTick(Symb, Tick) ? (Tick.bid && Tick.ask && MT4ORDERS::SessionTrade(Symb) /* &&
          ((ENUM_SYMBOL_TRADE_MODE)::SymbolInfoInteger(Symb, SYMBOL_TRADE_MODE) == SYMBOL_TRADE_MODE_FULL) */
                                            )
                                         : false);
  }

  static bool CorrectResult(void)
  {
    ::ZeroMemory(MT4ORDERS::LastTradeResult);

    MT4ORDERS::LastTradeResult.retcode = MT4ORDERS::LastTradeCheckResult.retcode;
    MT4ORDERS::LastTradeResult.comment = MT4ORDERS::LastTradeCheckResult.comment;

    return (false);
  }

  static bool NewOrderCheck(void)
  {
    return ((::OrderCheck(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeCheckResult) &&
             (MT4ORDERS::IsTester || MT4ORDERS::SymbolTrade(MT4ORDERS::LastTradeRequest.symbol))) ||
            (!MT4ORDERS::IsTester && MT4ORDERS::CorrectResult()));
  }

  static bool NewOrderSend(const int &Check)
  {
    return ((Check == INT_MAX) ? MT4ORDERS::NewOrderCheck() : (((Check != INT_MIN) || MT4ORDERS::NewOrderCheck()) && MT4ORDERS::OrderSend(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeResult) ? (MT4ORDERS::LastTradeResult.retcode < TRADE_RETCODE_ERROR)
#ifdef MT4ORDERS_BYPASS_MAXTIME
                                                                                                                                                                                                         && _B2(MT4ORDERS::ByPass += MT4ORDERS::LastTradeResult.order)
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME
                                                                                                                                                                                                   : false));
  }

  static bool ModifyPosition(const long &Ticket, MqlTradeRequest &Request)
  {
    const bool Res = _B2(::PositionSelectByTicket(Ticket));

    if (Res)
    {
      Request.action = TRADE_ACTION_SLTP;

      Request.position = Ticket;
      Request.symbol = ::PositionGetString(POSITION_SYMBOL); // specifying a single ticket is not sufficient!
    }

    return (Res);
  }

  static ENUM_ORDER_TYPE_FILLING GetFilling(const string &Symb, const uint Type1 = ORDER_FILLING_FOK)
  {
    static ENUM_ORDER_TYPE_FILLING Res = ORDER_FILLING_FOK;
    static string LastSymb = NULL;
    static uint LastType = ORDER_FILLING_FOK;

    const bool SymbFlag = (LastSymb != Symb);

    if (SymbFlag || (LastType != Type1)) // It can be lightly accelerated by changing the sequence of checking the condition.
    {
      LastType = Type1;

      if (SymbFlag)
        LastSymb = Symb;

      const ENUM_SYMBOL_TRADE_EXECUTION ExeMode = (ENUM_SYMBOL_TRADE_EXECUTION)::SymbolInfoInteger(Symb, SYMBOL_TRADE_EXEMODE);
      const int FillingMode = (int)::SymbolInfoInteger(Symb, SYMBOL_FILLING_MODE);

      Res = (!FillingMode || (Type1 >= ORDER_FILLING_RETURN) || ((FillingMode & (Type1 + 1)) != Type1 + 1)) ? (((ExeMode == SYMBOL_TRADE_EXECUTION_EXCHANGE) || (ExeMode == SYMBOL_TRADE_EXECUTION_INSTANT)) ? ORDER_FILLING_RETURN : ((FillingMode == SYMBOL_FILLING_IOC) ? ORDER_FILLING_IOC : ORDER_FILLING_FOK)) : (ENUM_ORDER_TYPE_FILLING)Type1;
    }

    return (Res);
  }

  static ENUM_ORDER_TYPE_TIME GetExpirationType(const string &Symb, uint Expiration = ORDER_TIME_GTC)
  {
    static ENUM_ORDER_TYPE_TIME Res = ORDER_TIME_GTC;
    static string LastSymb = NULL;
    static uint LastExpiration = ORDER_TIME_GTC;

    const bool SymbFlag = (LastSymb != Symb);

    if ((LastExpiration != Expiration) || SymbFlag)
    {
      LastExpiration = Expiration;

      if (SymbFlag)
        LastSymb = Symb;

      const int ExpirationMode = (int)::SymbolInfoInteger(Symb, SYMBOL_EXPIRATION_MODE);

      if ((Expiration > ORDER_TIME_SPECIFIED_DAY) || (!((ExpirationMode >> Expiration) & 1)))
      {
        if ((Expiration < ORDER_TIME_SPECIFIED) || (ExpirationMode < SYMBOL_EXPIRATION_SPECIFIED))
          Expiration = ORDER_TIME_GTC;
        else if (Expiration > ORDER_TIME_DAY)
          Expiration = ORDER_TIME_SPECIFIED;

        uint i = 1 << Expiration;

        while ((Expiration <= ORDER_TIME_SPECIFIED_DAY) && ((ExpirationMode & i) != i))
        {
          i <<= 1;
          Expiration++;
        }
      }

      Res = (ENUM_ORDER_TYPE_TIME)Expiration;
    }

    return (Res);
  }

  static bool ModifyOrder(const long Ticket, const double &Price, const datetime &Expiration, MqlTradeRequest &Request)
  {
    const bool Res = _B2(::OrderSelect(Ticket));

    if (Res)
    {
      Request.action = TRADE_ACTION_MODIFY;
      Request.order = Ticket;

      Request.price = Price;

      Request.symbol = ::OrderGetString(ORDER_SYMBOL);

      // https://www.mql5.com/ru/forum/1111/page1817#comment_4087275
      //      Request.type_filling = (ENUM_ORDER_TYPE_FILLING)::OrderGetInteger(ORDER_TYPE_FILLING);
      Request.type_filling = _B2(MT4ORDERS::GetFilling(Request.symbol));
      Request.type_time = _B2(MT4ORDERS::GetExpirationType(Request.symbol, (uint)Expiration));

      if (Expiration > ORDER_TIME_DAY)
        Request.expiration = Expiration;
    }

    return (Res);
  }

  static bool SelectByPosHistory(const int Index)
  {
    const long Ticket = MT4ORDERS::History[Index];
    const bool Res = (Ticket > 0) ? _B2(MT4ORDERS::HistorySelectDeal(Ticket)) : ((Ticket < 0) && _B2(MT4ORDERS::HistorySelectOrder(-Ticket)));

    if (Res)
    {
      if (Ticket > 0)
        _BV2(MT4ORDERS::GetHistoryPositionData(Ticket))
      else
        _BV2(MT4ORDERS::GetHistoryOrderData(-Ticket))
    }

    return (Res);
  }

  // https://www.mql5.com/ru/forum/227960#comment_6603506
  static bool OrderVisible(void)
  {
    // if the position has closed while there is still a live partially filled pending order from which the position originated,
    // and the remaining part of the pending order was fully filled then but has not disappeared yet,
    // then we will see both the new position (correct) and the non-disappeared pending order (wrong).

    const ulong PositionID = ::OrderGetInteger(ORDER_POSITION_ID);
    const ENUM_ORDER_TYPE Type1 = (ENUM_ORDER_TYPE)::OrderGetInteger(ORDER_TYPE);
    ulong Ticket = 0;

    return (!((Type1 == ORDER_TYPE_CLOSE_BY) ||
              (PositionID &&                                                   // Partial pending order has a non-zero PositionID.
               (Type1 <= ORDER_TYPE_SELL) &&                                   // Ignore closing market orders
               ((Ticket = ::OrderGetInteger(ORDER_TICKET)) != PositionID))) && // Do not ignor partially filled market orders.
            // Opening/position increasing order may not have time to disappear.
            (!::PositionsTotal() || !(::PositionSelectByTicket(Ticket ? Ticket : ::OrderGetInteger(ORDER_TICKET)) &&
                                      //                                     (::PositionGetInteger(POSITION_TYPE) == (::OrderGetInteger(ORDER_TYPE) & 1)) &&
                                      //                                     (::PositionGetInteger(POSITION_TIME_MSC) >= ::OrderGetInteger(ORDER_TIME_SETUP_MSC)) &&
                                      (::PositionGetDouble(POSITION_VOLUME) == ::OrderGetDouble(ORDER_VOLUME_INITIAL)))));
  }

  static ulong OrderGetTicket(const int Index)
  {
    ulong Res;
    int PrevTotal;
    const long PrevTicket = ::OrderGetInteger(ORDER_TICKET);
    const long PositionTicket = ::PositionGetInteger(POSITION_TICKET);

    do
    {
      Res = 0;
      PrevTotal = ::OrdersTotal();

      if ((Index >= 0) && (Index < PrevTotal))
      {
        int Count = 0;

        for (int i = 0; i < PrevTotal; i++)
        {
          const int Total = ::OrdersTotal();

          // Number of orders may change while searching for
          if (Total != PrevTotal)
          {
            PrevTotal = Total;

            Count = 0;
            i = -1;
          }
          else
          {
            const ulong Ticket = ::OrderGetTicket(i);

            if (Ticket && MT4ORDERS::OrderVisible())
            {
              if (Count == Index)
              {
                Res = Ticket;

                break;
              }

              Count++;
            }
          }
        }
      }
    } while (
        /*           #ifdef MT4ORDERS_BYPASS_MAXTIME
                     _B2(MT4ORDERS::ByPass.Waiting()) &&
                   #endif // #ifdef MT4ORDERS_BYPASS_MAXTIME */
        (PrevTotal != ::OrdersTotal())); // Number of orders may change while searching

    // In case of a failure, select the order that have been chosen earlier.
    if (!Res && PrevTicket && (::OrderGetInteger(ORDER_TICKET) != PrevTicket))
      const bool AntiWarning = _B2(::OrderSelect(PrevTicket));

    // MT4ORDERS::OrderVisible() changes the position selection.
    if (PositionTicket && (::PositionGetInteger(POSITION_TICKET) != PositionTicket))
      ::PositionSelectByTicket(PositionTicket);

    return (Res);
  }

  // With the same tickets, the priority of position selection is higher than order selection
  static bool SelectByPos(const int Index)
  {
    bool Flag = (Index == INT_MAX);
    bool Res = Flag || (Index == INT_MIN);

    if (!Res)
    {
      const int Total = ::PositionsTotal();

      Flag = (Index < Total);
      Res = Flag ? _B2(::PositionGetTicket(Index)) :
#ifdef MT4ORDERS_SELECTFILTER_OFF
                 ::OrderGetTicket(Index - Total);
#else  // MT4ORDERS_SELECTFILTER_OFF
                 (MT4ORDERS::IsTester ? ::OrderGetTicket(Index - Total) : _B2(MT4ORDERS::OrderGetTicket(Index - Total)));
#endif // MT4ORDERS_SELECTFILTER_OFF
    }

    if (Res)
    {
      if (Flag)
        MT4ORDERS::GetPositionData(); // (Index == INT_MAX) - switch to an MT5 position without checking the existence and updating.
      else
        MT4ORDERS::GetOrderData(); // (Index == INT_MIN) - switch to a live MT5 order without checking the existence and updating.
    }

    return (Res);
  }

  static bool SelectByHistoryTicket(const long &Ticket)
  {
    bool Res = false;

    if (!Ticket) // Selection by OrderTicketID (by zero value - balance operations).
    {
      const ulong TicketDealOut = MT4ORDERS::History.GetPositionDealOut(Ticket);

      if (Res = _B2(MT4ORDERS::HistorySelectDeal(TicketDealOut)))
        _BV2(MT4ORDERS::GetHistoryPositionData(TicketDealOut));
    }
    else if (_B2(MT4ORDERS::HistorySelectDeal(Ticket)))
    {
#ifdef MT4ORDERS_TESTER_SELECT_BY_TICKET
      // In the tester, when searching for a closed position, we must first search by PositionID due to a close numbering of MT5 deals/orders.
      if (MT4ORDERS::IsTester)
      {
        const ulong TicketDealOut = MT4ORDERS::History.GetPositionDealOut(HistoryOrderGetInteger(Ticket, ORDER_POSITION_ID));

        if (Res = _B2(MT4ORDERS::HistorySelectDeal(TicketDealOut)))
          _BV2(MT4ORDERS::GetHistoryPositionData(TicketDealOut));
      }

      if (!Res)
#endif // #ifdef MT4ORDERS_TESTER_SELECT_BY_TICKET
      {
        if (Res = MT4HISTORY::IsMT4Deal(Ticket))
          _BV2(MT4ORDERS::GetHistoryPositionData(Ticket))
        else // DealIn
        {
          const ulong TicketDealOut = MT4ORDERS::History.GetPositionDealOut(HistoryDealGetInteger(Ticket, DEAL_POSITION_ID)); // Select by DealIn

          if (Res = _B2(MT4ORDERS::HistorySelectDeal(TicketDealOut)))
            _BV2(MT4ORDERS::GetHistoryPositionData(TicketDealOut))
        }
      }
    }
    else if (_B2(MT4ORDERS::HistorySelectOrder(Ticket)))
    {
      if (Res = MT4HISTORY::IsMT4Order(Ticket))
        _BV2(MT4ORDERS::GetHistoryOrderData(Ticket))
      else
      {
        const ulong TicketDealOut = MT4ORDERS::History.GetPositionDealOut(HistoryOrderGetInteger(Ticket, ORDER_POSITION_ID));

        if (Res = _B2(MT4ORDERS::HistorySelectDeal(TicketDealOut)))
          _BV2(MT4ORDERS::GetHistoryPositionData(TicketDealOut));
      }
    }
    else
    {
      // Choosing by OrderTicketID or by the ticket of an executed pending order is relevant to Netting.
      const ulong TicketDealOut = MT4ORDERS::History.GetPositionDealOut(Ticket);

      if (Res = _B2(MT4ORDERS::HistorySelectDeal(TicketDealOut)))
        _BV2(MT4ORDERS::GetHistoryPositionData(TicketDealOut));
    }

    return (Res);
  }

  static bool SelectByExistingTicket(const long &Ticket)
  {
    bool Res = true;

    if (Ticket < 0)
    {
      if (_B2(::OrderSelect(-Ticket)))
        MT4ORDERS::GetOrderData();
      else if (_B2(::PositionSelectByTicket(-Ticket)))
        MT4ORDERS::GetPositionData();
      else
        Res = false;
    }
    else if (_B2(::PositionSelectByTicket(Ticket)))
      MT4ORDERS::GetPositionData();
    else if (_B2(::OrderSelect(Ticket)))
      MT4ORDERS::GetOrderData();
    else if (_B2(MT4ORDERS::HistorySelectDeal(Ticket)))
    {
#ifdef MT4ORDERS_TESTER_SELECT_BY_TICKET
      // In the tester, when searching for a closed position, we must first search by PositionID due to a close numbering of MT5 deals/orders.
      if (Res = !MT4ORDERS::IsTester)
#endif // #ifdef MT4ORDERS_TESTER_SELECT_BY_TICKET
      {
        if (MT4HISTORY::IsMT4Deal(Ticket)) // If the choice is made by DealOut.
          _BV2(MT4ORDERS::GetHistoryPositionData(Ticket))
        else if (_B2(::PositionSelectByTicket(::HistoryDealGetInteger(Ticket, DEAL_POSITION_ID)))) // Select by DealIn
          MT4ORDERS::GetPositionData();
        else
          Res = false;
      }
    }
    else if (_B2(MT4ORDERS::HistorySelectOrder(Ticket)) && _B2(::PositionSelectByTicket(::HistoryOrderGetInteger(Ticket, ORDER_POSITION_ID)))) // Select by MT5 order ticket
      MT4ORDERS::GetPositionData();
    else
      Res = false;

    return (Res);
  }

  // With the same ticket, selection priorities are:
  // MODE_TRADES:  existing position > existing order > deal > canceled order
  // MODE_HISTORY: deal > canceled order > existing position > existing order
  static bool SelectByTicket(const long &Ticket, const int &Pool)
  {
    return ((Pool == MODE_TRADES) || (Ticket < 0) ? (_B2(MT4ORDERS::SelectByExistingTicket(Ticket)) || ((Ticket > 0) && _B2(MT4ORDERS::SelectByHistoryTicket(Ticket)))) : (_B2(MT4ORDERS::SelectByHistoryTicket(Ticket)) || _B2(MT4ORDERS::SelectByExistingTicket(Ticket))));
  }

#ifdef MT4ORDERS_SLTP_OLD
  static void CheckPrices(double &MinPrice, double &MaxPrice, const double Min, const double Max)
  {
    if (MinPrice && (MinPrice >= Min))
      MinPrice = 0;

    if (MaxPrice && (MaxPrice <= Max))
      MaxPrice = 0;

    return;
  }
#endif // MT4ORDERS_SLTP_OLD

  static int OrdersTotal(void)
  {
    int Res = 0;
    const long PrevTicket = ::OrderGetInteger(ORDER_TICKET);
    const long PositionTicket = ::PositionGetInteger(POSITION_TICKET);
    int PrevTotal;

    do
    {
      PrevTotal = ::OrdersTotal();

      for (int i = PrevTotal - 1; i >= 0; i--)
      {
        const int Total = ::OrdersTotal();

        // Number of orders may change while searching for
        if (Total != PrevTotal)
        {
          PrevTotal = Total;

          Res = 0;
          i = PrevTotal;
        }
        else if (::OrderGetTicket(i) && MT4ORDERS::OrderVisible())
          Res++;
      }
    } while (PrevTotal != ::OrdersTotal()); // Number of orders may change while searching for

    if (PrevTicket && (::OrderGetInteger(ORDER_TICKET) != PrevTicket))
      const bool AntiWarning = _B2(::OrderSelect(PrevTicket));

    // MT4ORDERS::OrderVisible() changes the position selection.
    if (PositionTicket && (::PositionGetInteger(POSITION_TICKET) != PositionTicket))
      ::PositionSelectByTicket(PositionTicket);

    return (Res);
  }

public:
  static uint OrderSend_MaxPause; // the maximum time for synchronization in microseconds.

#ifdef MT4ORDERS_BYPASS_MAXTIME
  static BYPASS ByPass;
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME

  static MqlTradeResult LastTradeResult;
  static MqlTradeRequest LastTradeRequest;
  static MqlTradeCheckResult LastTradeCheckResult;

  static bool MT4OrderSelect(const long &Index, const int &Select, const int &Pool)
  {
    return (
#ifdef MT4ORDERS_BYPASS_MAXTIME
        (MT4ORDERS::IsTester || ((Select == SELECT_BY_POS) && ((Index == INT_MIN) || (Index == INT_MAX))) || _B2(MT4ORDERS::ByPass.Waiting())) &&
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME
        ((Select == SELECT_BY_POS) ? ((Pool == MODE_TRADES) ? _B2(MT4ORDERS::SelectByPos((int)Index)) : _B2(MT4ORDERS::SelectByPosHistory((int)Index))) : _B2(MT4ORDERS::SelectByTicket(Index, Pool))));
  }

  static int MT4OrdersTotal(void)
  {
#ifdef MT4ORDERS_SELECTFILTER_OFF
    return (::OrdersTotal() + ::PositionsTotal());
#else // MT4ORDERS_SELECTFILTER_OFF
    int Res;

    if (MT4ORDERS::IsTester)
      return (::OrdersTotal() + ::PositionsTotal());
    else
    {
      int PrevTotal;

#ifdef MT4ORDERS_BYPASS_MAXTIME
      _B2(MT4ORDERS::ByPass.Waiting());
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME

      do
      {
        PrevTotal = ::PositionsTotal();

        Res = _B2(MT4ORDERS::OrdersTotal()) + PrevTotal;

      } while (
          /*             #ifdef MT4ORDERS_BYPASS_MAXTIME
                         _B2(MT4ORDERS::ByPass.Waiting()) &&
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME  */
          (PrevTotal != ::PositionsTotal())); // Only position changes are tracked, since orders are tracked in MT4ORDERS::OrdersTotal()
    }

    return (Res); // https://www.mql5.com/ru/forum/290673#comment_9493241
#endif // MT4ORDERS_SELECTFILTER_OFF
  }

  // This "overload" also allows using the MT5 version of OrdersTotal
  static int MT4OrdersTotal(const bool)
  {
    return (::OrdersTotal());
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static int MT4OrdersHistoryTotal(void)
  {
#ifdef MT4ORDERS_BYPASS_MAXTIME
    _B2(MT4ORDERS::ByPass.Waiting());
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME

    return (MT4ORDERS::History.GetAmount());
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static long MT4OrderSend(const string &Symb, const int &Type1, const double &dVolume, const double &Price, const int &SlipPage, const double &SL, const double &TP,
                           const string &comment, const MAGIC_TYPE &magic, const datetime &dExpiration, const color &arrow_color)

  {
    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = (((Type1 == OP_BUY) || (Type1 == OP_SELL)) ? TRADE_ACTION_DEAL : TRADE_ACTION_PENDING);
    MT4ORDERS::LastTradeRequest.magic = magic;

    MT4ORDERS::LastTradeRequest.symbol = ((Symb == NULL) ? ::Symbol() : Symb);
    MT4ORDERS::LastTradeRequest.volume = dVolume;
    MT4ORDERS::LastTradeRequest.price = Price;

    MT4ORDERS::LastTradeRequest.tp = TP;
    MT4ORDERS::LastTradeRequest.sl = SL;
    MT4ORDERS::LastTradeRequest.deviation = SlipPage;
    MT4ORDERS::LastTradeRequest.type = (ENUM_ORDER_TYPE)Type1;

    MT4ORDERS::LastTradeRequest.type_filling = _B2(MT4ORDERS::GetFilling(MT4ORDERS::LastTradeRequest.symbol, (uint)MT4ORDERS::LastTradeRequest.deviation));

    if (MT4ORDERS::LastTradeRequest.action == TRADE_ACTION_PENDING)
    {
      MT4ORDERS::LastTradeRequest.type_time = _B2(MT4ORDERS::GetExpirationType(MT4ORDERS::LastTradeRequest.symbol, (uint)dExpiration));

      if (dExpiration > ORDER_TIME_DAY)
        MT4ORDERS::LastTradeRequest.expiration = dExpiration;
    }

    if (comment != NULL)
      MT4ORDERS::LastTradeRequest.comment = comment;

    return ((arrow_color == INT_MAX) ? (MT4ORDERS::NewOrderCheck() ? 0 : -1) : ((((int)arrow_color != INT_MIN) || MT4ORDERS::NewOrderCheck()) && MT4ORDERS::OrderSend(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeResult)
#ifdef MT4ORDERS_BYPASS_MAXTIME
                                                                                        && (!MT4ORDERS::IsHedging || _B2(MT4ORDERS::ByPass += MT4ORDERS::LastTradeResult.order))
#endif                                                                                                                                                 // #ifdef MT4ORDERS_BYPASS_MAXTIME
                                                                                    ? (MT4ORDERS::IsHedging ? (long)MT4ORDERS::LastTradeResult.order : // PositionID == Result.order - a feature of MT5-Hedge
                                                                                           ((MT4ORDERS::LastTradeRequest.action == TRADE_ACTION_DEAL) ? (MT4ORDERS::IsTester ? (_B2(::PositionSelect(MT4ORDERS::LastTradeRequest.symbol)) ? PositionGetInteger(POSITION_TICKET) : 0) :
                                                                                                                                                                             // HistoryDealSelect в MT4ORDERS::OrderSend
                                                                                                                                                             ::HistoryDealGetInteger(MT4ORDERS::LastTradeResult.deal, DEAL_POSITION_ID))
                                                                                                                                                      : (long)MT4ORDERS::LastTradeResult.order))
                                                                                    : -1));
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static bool MT4OrderModify(const long &Ticket, const double &Price, const double &SL, const double &TP, const datetime &Expiration, const color &Arrow_Color)
  {
    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    // Considers the case when an order and a position with the same ticket are present
    bool Res = (Ticket < 0) ? MT4ORDERS::ModifyOrder(-Ticket, Price, Expiration, MT4ORDERS::LastTradeRequest) : ((MT4ORDERS::Order.Ticket != ORDER_SELECT) ? (MT4ORDERS::ModifyPosition(Ticket, MT4ORDERS::LastTradeRequest) || MT4ORDERS::ModifyOrder(Ticket, Price, Expiration, MT4ORDERS::LastTradeRequest)) : (MT4ORDERS::ModifyOrder(Ticket, Price, Expiration, MT4ORDERS::LastTradeRequest) || MT4ORDERS::ModifyPosition(Ticket, MT4ORDERS::LastTradeRequest)));

    //    if (Res) // Ignore the check - OrderCheck is present
    {
      MT4ORDERS::LastTradeRequest.tp = TP;
      MT4ORDERS::LastTradeRequest.sl = SL;

      Res = MT4ORDERS::NewOrderSend(Arrow_Color);
    }

    return (Res);
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static bool MT4OrderClose(const long &Ticket, const double &dLots, const double &Price, const int &SlipPage, const color &Arrow_Color, const string &comment)
  {
    // MT4ORDERS::LastTradeRequest and MT4ORDERS::LastTradeResult are present, therefore the result is not affected. However, it is necessary for PositionGetString below
    _B2(::PositionSelectByTicket(Ticket));

    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = TRADE_ACTION_DEAL;
    MT4ORDERS::LastTradeRequest.position = Ticket;

    MT4ORDERS::LastTradeRequest.symbol = ::PositionGetString(POSITION_SYMBOL);

    // Save the comment when partially closing the position
    //    if (dLots < ::PositionGetDouble(POSITION_VOLUME))
    MT4ORDERS::LastTradeRequest.comment = (comment == NULL) ? ::PositionGetString(POSITION_COMMENT) : comment;

    // Is it correct not to define magic number when closing? -It is!
    MT4ORDERS::LastTradeRequest.volume = dLots;
    MT4ORDERS::LastTradeRequest.price = Price;

#ifdef MT4ORDERS_SLTP_OLD
    // Needed to determine the SL/TP levels of the closed position. Inverted - not an error
    // SYMBOL_SESSION_PRICE_LIMIT_MIN and SYMBOL_SESSION_PRICE_LIMIT_MAX do not need any validation, since the initial SL/TP have already been set
    MT4ORDERS::LastTradeRequest.tp = ::PositionGetDouble(POSITION_SL);
    MT4ORDERS::LastTradeRequest.sl = ::PositionGetDouble(POSITION_TP);

    if (MT4ORDERS::LastTradeRequest.tp || MT4ORDERS::LastTradeRequest.sl)
    {
      const double StopLevel = ::SymbolInfoInteger(MT4ORDERS::LastTradeRequest.symbol, SYMBOL_TRADE_STOPS_LEVEL) *
                               ::SymbolInfoDouble(MT4ORDERS::LastTradeRequest.symbol, SYMBOL_POINT);

      const bool FlagBuy = (::PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY);
      const double CurrentPrice = SymbolInfoDouble(MT4ORDERS::LastTradeRequest.symbol, FlagBuy ? SYMBOL_ASK : SYMBOL_BID);

      if (CurrentPrice)
      {
        if (FlagBuy)
          MT4ORDERS::CheckPrices(MT4ORDERS::LastTradeRequest.tp, MT4ORDERS::LastTradeRequest.sl, CurrentPrice - StopLevel, CurrentPrice + StopLevel);
        else
          MT4ORDERS::CheckPrices(MT4ORDERS::LastTradeRequest.sl, MT4ORDERS::LastTradeRequest.tp, CurrentPrice - StopLevel, CurrentPrice + StopLevel);
      }
      else
      {
        MT4ORDERS::LastTradeRequest.tp = 0;
        MT4ORDERS::LastTradeRequest.sl = 0;
      }
    }
#endif // MT4ORDERS_SLTP_OLD

    MT4ORDERS::LastTradeRequest.deviation = SlipPage;

    MT4ORDERS::LastTradeRequest.type = (ENUM_ORDER_TYPE)(1 - ::PositionGetInteger(POSITION_TYPE));

    MT4ORDERS::LastTradeRequest.type_filling = _B2(MT4ORDERS::GetFilling(MT4ORDERS::LastTradeRequest.symbol, (uint)MT4ORDERS::LastTradeRequest.deviation));

    return (MT4ORDERS::NewOrderSend(Arrow_Color));
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static bool MT4OrderCloseBy(const long &Ticket, const long &Opposite, const color &Arrow_Color)
  {
    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = TRADE_ACTION_CLOSE_BY;
    MT4ORDERS::LastTradeRequest.position = Ticket;
    MT4ORDERS::LastTradeRequest.position_by = Opposite;

    if ((!MT4ORDERS::IsTester) && _B2(::PositionSelectByTicket(Ticket))) // needed for MT4ORDERS::SymbolTrade()
      MT4ORDERS::LastTradeRequest.symbol = ::PositionGetString(POSITION_SYMBOL);

    return (MT4ORDERS::NewOrderSend(Arrow_Color));
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static bool MT4OrderDelete(const long &Ticket, const color &Arrow_Color)
  {
    //    bool Res = ::OrderSelect(Ticket); // Is it necessary, when MT4ORDERS::LastTradeRequest and MT4ORDERS::LastTradeResult are needed?

    ::ZeroMemory(MT4ORDERS::LastTradeRequest);

    MT4ORDERS::LastTradeRequest.action = TRADE_ACTION_REMOVE;
    MT4ORDERS::LastTradeRequest.order = Ticket;

    if ((!MT4ORDERS::IsTester) && _B2(::OrderSelect(Ticket))) // needed for MT4ORDERS::SymbolTrade()
      MT4ORDERS::LastTradeRequest.symbol = ::OrderGetString(ORDER_SYMBOL);

    return (MT4ORDERS::NewOrderSend(Arrow_Color));
  }

#define MT4_ORDERFUNCTION(NAME, T, A, B, C)                            \
  static T MT4Order##NAME(void)                                        \
  {                                                                    \
    return (POSITION_ORDER((T)(A), (T)(B), MT4ORDERS::Order.NAME, C)); \
  }

#define POSITION_ORDER(A, B, C, D) (((MT4ORDERS::Order.Ticket == POSITION_SELECT) && (D)) ? (A) : ((MT4ORDERS::Order.Ticket == ORDER_SELECT) ? (B) : (C)))

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  MT4_ORDERFUNCTION(Ticket, long, ::PositionGetInteger(POSITION_TICKET), ::OrderGetInteger(ORDER_TICKET), true)
  MT4_ORDERFUNCTION(Type, int, ::PositionGetInteger(POSITION_TYPE), ::OrderGetInteger(ORDER_TYPE), true)
  MT4_ORDERFUNCTION(Lots, double, ::PositionGetDouble(POSITION_VOLUME), ::OrderGetDouble(ORDER_VOLUME_CURRENT), true)
  MT4_ORDERFUNCTION(OpenPrice, double, ::PositionGetDouble(POSITION_PRICE_OPEN), (::OrderGetDouble(ORDER_PRICE_OPEN) ? ::OrderGetDouble(ORDER_PRICE_OPEN) : ::OrderGetDouble(ORDER_PRICE_CURRENT)), true)
  MT4_ORDERFUNCTION(OpenTimeMsc, long, ::PositionGetInteger(POSITION_TIME_MSC), ::OrderGetInteger(ORDER_TIME_SETUP_MSC), true)
  MT4_ORDERFUNCTION(OpenTime, datetime, ::PositionGetInteger(POSITION_TIME), ::OrderGetInteger(ORDER_TIME_SETUP), true)
  MT4_ORDERFUNCTION(StopLoss, double, ::PositionGetDouble(POSITION_SL), ::OrderGetDouble(ORDER_SL), true)
  MT4_ORDERFUNCTION(TakeProfit, double, ::PositionGetDouble(POSITION_TP), ::OrderGetDouble(ORDER_TP), true)
  MT4_ORDERFUNCTION(ClosePrice, double, ::PositionGetDouble(POSITION_PRICE_CURRENT), ::OrderGetDouble(ORDER_PRICE_CURRENT), true)
  MT4_ORDERFUNCTION(CloseTimeMsc, long, 0, 0, true)
  MT4_ORDERFUNCTION(CloseTime, datetime, 0, 0, true)
  MT4_ORDERFUNCTION(Expiration, datetime, 0, ::OrderGetInteger(ORDER_TIME_EXPIRATION), true)
  MT4_ORDERFUNCTION(MagicNumber, long, ::PositionGetInteger(POSITION_MAGIC), ::OrderGetInteger(ORDER_MAGIC), true)
  MT4_ORDERFUNCTION(Profit, double, ::PositionGetDouble(POSITION_PROFIT), 0, true)
  MT4_ORDERFUNCTION(Swap, double, ::PositionGetDouble(POSITION_SWAP), 0, true)
  MT4_ORDERFUNCTION(Symbol, string, ::PositionGetString(POSITION_SYMBOL), ::OrderGetString(ORDER_SYMBOL), true)
  MT4_ORDERFUNCTION(Comment, string, MT4ORDERS::Order.Comment, ::OrderGetString(ORDER_COMMENT), MT4ORDERS::CheckPositionCommissionComment())
  MT4_ORDERFUNCTION(Commission, double, MT4ORDERS::Order.Commission, 0, MT4ORDERS::CheckPositionCommissionComment())

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  MT4_ORDERFUNCTION(OpenPriceRequest, double, MT4ORDERS::Order.OpenPriceRequest, ::OrderGetDouble(ORDER_PRICE_OPEN), MT4ORDERS::CheckPositionOpenPriceRequest())
  MT4_ORDERFUNCTION(ClosePriceRequest, double, ::PositionGetDouble(POSITION_PRICE_CURRENT), ::OrderGetDouble(ORDER_PRICE_CURRENT), true)

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  MT4_ORDERFUNCTION(TicketOpen, long, MT4ORDERS::Order.TicketOpen, ::OrderGetInteger(ORDER_TICKET), MT4ORDERS::CheckPositionTicketOpen())
  //  MT4_ORDERFUNCTION(OpenReason, ENUM_DEAL_REASON, MT4ORDERS::Order.OpenReason, ::OrderGetInteger(ORDER_REASON), MT4ORDERS::CheckPositionOpenReason())
  MT4_ORDERFUNCTION(OpenReason, ENUM_DEAL_REASON, ::PositionGetInteger(POSITION_REASON), ::OrderGetInteger(ORDER_REASON), true)
  MT4_ORDERFUNCTION(CloseReason, ENUM_DEAL_REASON, 0, ::OrderGetInteger(ORDER_REASON), true)
  MT4_ORDERFUNCTION(TicketID, long, ::PositionGetInteger(POSITION_IDENTIFIER), ::OrderGetInteger(ORDER_TICKET), true)

#undef POSITION_ORDER
#undef MT4_ORDERFUNCTION

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static void MT4OrderPrint(void)
  {
    if (MT4ORDERS::Order.Ticket == POSITION_SELECT)
      MT4ORDERS::CheckPositionCommissionComment();

    ::Print(MT4ORDERS::Order.ToString());

    return;
  }

  //+------------------------------------------------------------------+
  //|                                                                  |
  //+------------------------------------------------------------------+
  static double MT4OrderLots(const bool &)
  {
    double Res = MT4ORDERS::MT4OrderLots();

    if (Res && (MT4ORDERS::Order.Ticket == POSITION_SELECT))
    {
      const ulong PositionID = ::PositionGetInteger(POSITION_IDENTIFIER);

      if (::PositionSelectByTicket(PositionID))
      {
        const int Type = 1 - (int)::PositionGetInteger(POSITION_TYPE);

        double PrevVolume = Res;
        double NewVolume = 0;

        while (Res && (NewVolume != PrevVolume))
        {
#ifdef MT4ORDERS_BYPASS_MAXTIME
          _B2(MT4ORDERS::ByPass.Waiting());
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME

          if (::PositionSelectByTicket(PositionID))
          {
            Res = ::PositionGetDouble(POSITION_VOLUME);
            PrevVolume = Res;

            for (int i = ::OrdersTotal() - 1; i >= 0; i--)
              if (!::OrderGetTicket(i)) // Happens if i == ::OrdersTotal() - 1.
              {
                PrevVolume = -1;

                break;
              }
              else if ((::OrderGetInteger(ORDER_POSITION_ID) == PositionID) &&
                       (::OrderGetInteger(ORDER_TYPE) == Type))
                Res -= ::OrderGetDouble(ORDER_VOLUME_CURRENT);

            if (::PositionSelectByTicket(PositionID))
              NewVolume = ::PositionGetDouble(POSITION_VOLUME);
            else
              Res = 0;
          }
        }
      }
      else
        Res = 0;
    }

    return (Res);
  }

#undef ORDER_SELECT
#undef POSITION_SELECT
};

// #define OrderToString MT4ORDERS::MT4OrderToString

static MT4_ORDER MT4ORDERS::Order = {};

static MT4HISTORY MT4ORDERS::History;

static const bool MT4ORDERS::IsTester = ::MQLInfoInteger(MQL_TESTER);

// If you switch the account, this value will still be recalculated for EAs
// https://www.mql5.com/ru/forum/170952/page61#comment_6132824
static const bool MT4ORDERS::IsHedging = ((ENUM_ACCOUNT_MARGIN_MODE)::AccountInfoInteger(ACCOUNT_MARGIN_MODE) ==
                                          ACCOUNT_MARGIN_MODE_RETAIL_HEDGING);

static int MT4ORDERS::OrderSendBug = 0;

static uint MT4ORDERS::OrderSend_MaxPause = 1000000; // the maximum time for synchronization in microseconds.

#ifdef MT4ORDERS_BYPASS_MAXTIME
static BYPASS MT4ORDERS::ByPass(MT4ORDERS_BYPASS_MAXTIME);
#endif // #ifdef MT4ORDERS_BYPASS_MAXTIME

static MqlTradeResult MT4ORDERS::LastTradeResult = {};
static MqlTradeRequest MT4ORDERS::LastTradeRequest = {};
static MqlTradeCheckResult MT4ORDERS::LastTradeCheckResult = {};

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OrderClose(const long Ticket, const double dLots, const double Price, const int SlipPage, const color Arrow_Color = clrNONE, const string comment = NULL)
{
  return (MT4ORDERS::MT4OrderClose(Ticket, dLots, Price, SlipPage, Arrow_Color, comment));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OrderModify(const long Ticket, const double Price, const double SL, const double TP, const datetime Expiration, const color Arrow_Color = clrNONE)
{
  return (MT4ORDERS::MT4OrderModify(Ticket, Price, SL, TP, Expiration, Arrow_Color));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OrderCloseBy(const long Ticket, const long Opposite, const color Arrow_Color = clrNONE)
{
  return (MT4ORDERS::MT4OrderCloseBy(Ticket, Opposite, Arrow_Color));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OrderDelete(const long Ticket, const color Arrow_Color = clrNONE)
{
  return (MT4ORDERS::MT4OrderDelete(Ticket, Arrow_Color));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void OrderPrint(void)
{
  MT4ORDERS::MT4OrderPrint();

  return;
}

#define MT4_ORDERGLOBALFUNCTION(NAME, T)     \
  T Order##NAME(void)                        \
  {                                          \
    return ((T)MT4ORDERS::MT4Order##NAME()); \
  }

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MT4_ORDERGLOBALFUNCTION(sHistoryTotal, int)
MT4_ORDERGLOBALFUNCTION(Ticket, TICKET_TYPE)
MT4_ORDERGLOBALFUNCTION(Type, int)
MT4_ORDERGLOBALFUNCTION(Lots, double)
MT4_ORDERGLOBALFUNCTION(OpenPrice, double)
MT4_ORDERGLOBALFUNCTION(OpenTimeMsc, long)
MT4_ORDERGLOBALFUNCTION(OpenTime, datetime)
MT4_ORDERGLOBALFUNCTION(StopLoss, double)
MT4_ORDERGLOBALFUNCTION(TakeProfit, double)
MT4_ORDERGLOBALFUNCTION(ClosePrice, double)
MT4_ORDERGLOBALFUNCTION(CloseTimeMsc, long)
MT4_ORDERGLOBALFUNCTION(CloseTime, datetime)
MT4_ORDERGLOBALFUNCTION(Expiration, datetime)
MT4_ORDERGLOBALFUNCTION(MagicNumber, MAGIC_TYPE)
MT4_ORDERGLOBALFUNCTION(Profit, double)
MT4_ORDERGLOBALFUNCTION(Commission, double)
MT4_ORDERGLOBALFUNCTION(Swap, double)
MT4_ORDERGLOBALFUNCTION(Symbol, string)
MT4_ORDERGLOBALFUNCTION(Comment, string)

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MT4_ORDERGLOBALFUNCTION(OpenPriceRequest, double)
MT4_ORDERGLOBALFUNCTION(ClosePriceRequest, double)

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
MT4_ORDERGLOBALFUNCTION(TicketOpen, TICKET_TYPE)
MT4_ORDERGLOBALFUNCTION(OpenReason, ENUM_DEAL_REASON)
MT4_ORDERGLOBALFUNCTION(CloseReason, ENUM_DEAL_REASON)
MT4_ORDERGLOBALFUNCTION(TicketID, TICKET_TYPE)

#undef MT4_ORDERGLOBALFUNCTION

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double OrderLots(const bool Value)
{
  return (MT4ORDERS::MT4OrderLots(Value));
}

// Overloaded standard functions
#define OrdersTotal MT4ORDERS::MT4OrdersTotal // AFTER Expert/Expert.mqh - there is a call to MT5-OrdersTotal()

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool OrderSelect(const long Index, const int Select, const int Pool = MODE_TRADES)
{
  return (_B2(MT4ORDERS::MT4OrderSelect(Index, Select, Pool)));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
TICKET_TYPE OrderSend(const string Symb, const int Type, const double dVolume, const double Price, const int SlipPage, const double SL, const double TP,
                      const string comment = NULL, const MAGIC_TYPE magic = 0, const datetime dExpiration = 0, color arrow_color = clrNONE)
{
  return ((TICKET_TYPE)MT4ORDERS::MT4OrderSend(Symb, Type, dVolume, Price, SlipPage, SL, TP, comment, magic, dExpiration, arrow_color));
}

#define RETURN_ASYNC(A) return ((A) && ::OrderSendAsync(MT4ORDERS::LastTradeRequest, MT4ORDERS::LastTradeResult) && \
                                        (MT4ORDERS::LastTradeResult.retcode == TRADE_RETCODE_PLACED)                \
                                    ? MT4ORDERS::LastTradeResult.request_id                                         \
                                    : 0);

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OrderCloseAsync(const long Ticket, const double dLots, const double Price, const int SlipPage, const color Arrow_Color = clrNONE){
    RETURN_ASYNC(OrderClose(Ticket, dLots, Price, SlipPage, INT_MAX))}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OrderModifyAsync(const long Ticket, const double Price, const double SL, const double TP, const datetime Expiration, const color Arrow_Color = clrNONE){
    RETURN_ASYNC(OrderModify(Ticket, Price, SL, TP, Expiration, INT_MAX))}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OrderDeleteAsync(const long Ticket, const color Arrow_Color = clrNONE){
    RETURN_ASYNC(OrderDelete(Ticket, INT_MAX))}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
uint OrderSendAsync(const string Symb, const int Type, const double dVolume, const double Price, const int SlipPage, const double SL, const double TP,
                    const string comment = NULL, const MAGIC_TYPE magic = 0, const datetime dExpiration = 0, color arrow_color = clrNONE)
{
  RETURN_ASYNC(!OrderSend(Symb, Type, dVolume, Price, SlipPage, SL, TP, comment, magic, dExpiration, INT_MAX))
}

#undef RETURN_ASYNC

#undef MT4ORDERS_SLTP_OLD

#undef _BV2
#undef _B3
#undef _B2

#ifdef MT4ORDERS_BENCHMARK_MINTIME
#undef MT4ORDERS_BENCHMARK_MINTIME
#endif // MT4ORDERS_BENCHMARK_MINTIME

// #undef TICKET_TYPE
#endif // __MT4ORDERS__
#else  // __MQL5__
#define TICKET_TYPE int
#define MAGIC_TYPE int

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
TICKET_TYPE OrderTicketID(void) { return (::OrderTicket()); }
#endif // __MQL5__

//====================================================================================================================================================//
// OnInit function
//====================================================================================================================================================//
int handle_ind;
int handle_ind2;
int OnInit()
{

  //------------------------------------------------------

  //--- forced initialization of variables

  m_init_error = false; // error on InInit

  // Started information
  ExpertName = MQLInfoString(MQL_PROGRAM_NAME);
  EASymbol = _Symbol;
  if (StringLen(EASymbol) > 6)
    SymbolExtension = StringSubstr(EASymbol, 6, 0);

  //------------------------------------------------------
  // Broker 4 or 5 digits
  DigitPoints = MarketInfo(EASymbol, MODE_POINT);
  MultiplierPoint = 1;
  if ((MarketInfo(EASymbol, MODE_DIGITS) == 3) || (MarketInfo(EASymbol, MODE_DIGITS) == 5))
  {
    MultiplierPoint = 10;
    DigitPoints *= MultiplierPoint;
  }

  Print("multi: " + MultiplierPoint);
  Print("DigitPoints: " + DigitPoints);
  //------------------------------------------------------
  // Minimum trailing, take profit and stop loss

  StopLevel = MathMax(MarketInfo(EASymbol, MODE_FREEZELEVEL) / MultiplierPoint, MarketInfo(EASymbol, MODE_STOPLEVEL) / MultiplierPoint);

  //------------------------------------------------------
  // Background
  // ChartColor=(color)ChartGetInteger(0,CHART_COLOR_BACKGROUND,0);
  // if((ObjectFind("Background")==-1) && (!IsTesting()) && (!IsVisualMode())) ChartBackground("Background",ChartColor,0,15,210,182);
  //---------------------------------------------------------------------
  // Operation ifno
  OperInfo = ExpertName + "   Working well....";
  //------------------------------------------------------
  if (!MQLInfoInteger(MQL_TESTER))
    OnTick(); // For show comment if market is closed
  //------------------------------------------------------
  return (INIT_SUCCEEDED);
  //------------------------------------------------------
}
//====================================================================================================================================================//
// OnDeinit function
//====================================================================================================================================================//
void OnDeinit(const int reason)
{
  //------------------------------------------------------
  ObjectDelete(0, "Background");
  Comment("");
  //------------------------------------------------------
}
//====================================================================================================================================================//
// OnTick function
//====================================================================================================================================================//
void OnTick()
{
  //---

  CheckSpread = true;

  double MA1 = iMAMQL4(NULL, 0, MA1_Period, MA1_Shift, MA1_Method, MA1_Apply, 1);
  double MA2 = iMAMQL4(NULL, 0, MA2_Period, MA2_Shift, MA2_Method, MA2_Apply, 1);

  double Sar = iSARMQL4(NULL, 0, step, maximum, 1);
  double SarPre = iSARMQL4(NULL, 0, step, maximum, 2);

  double Upper = iBandsMQL4(NULL, 0, period, Deviation, Shift, Apply, UPPER_BAND, 1);
  double Lower = iBandsMQL4(NULL, 0, period, Deviation, Shift, Apply, LOWER_BAND, 1);

  Spreads = (Ask - Bid) / DigitPoints;

  if ((Spreads > MaxSpread) && (MaxSpread > 0))
  {
    CheckSpread = false;
    Print("EA || " + "Spread is greater than MaxSpread!!! (Spread: " + DoubleToString(Spreads, 1) + " || MaxSpread: " + DoubleToString(MaxSpread, 1) + ")");
  }

  if (CloseInSignal == true)
  {
    if (CountBuy(Magic_Number) > 0)
    {
      if (MA1 < Upper && iClose(NULL, 0, 1) < MA2 && iClose(NULL, 0, 1) < Sar && iClose(NULL, 0, 2) > SarPre)
      {
        CloseMe(OP_BUY, Magic_Number, "Any");
      }
    }
    if (CountSell(Magic_Number) > 0)
    {
      if (MA1 > Lower && iClose(NULL, 0, 1) > MA2 && iClose(NULL, 0, 1) > Sar && iClose(NULL, 0, 2) < SarPre)
      {
        CloseMe(OP_SELL, Magic_Number, "Any");
      }
    }
  }

  if (iTime(NULL, 0, 0) != LastTimeBarOP2 || TradeOnNewBar == false)
  {

    if (CountSell(Magic_Number) + CountBuy(Magic_Number) == 0 && (SelectDirection == LongOnly || SelectDirection == Both))
      if (MA1 > Lower && iClose(NULL, 0, 1) > MA2 && iClose(NULL, 0, 1) > Sar && iClose(NULL, 0, 2) < SarPre && CheckSpread == true)
      {

        double SL = 0, TP = 0;
        double OrderTP = NormalizeDouble(TakeProfit * DigitPoints, _Digits);
        double OrderSL = NormalizeDouble(StopLoss * DigitPoints, _Digits);

        if ((StopLoss > 0) && (UseStopLoss == true))
          SL = NormalizeDouble(Bid - OrderSL, _Digits);

        if ((TakeProfit > 0) && (UseTakeProfit == true))
          TP = NormalizeDouble(Ask + OrderTP, _Digits);

        if (TimeCurrent() > StartTime)
          for (int i = 0; i < BuyTotal; i++)
            if (!OrderSend(Symbol(), OP_BUY, NormalizeDouble(LotSize, 2), Ask, Slippage, SL, TP, "Buy", Magic_Number, 0, clrBlue))
            {
            }
      }

    if (CountSell(Magic_Number) + CountBuy(Magic_Number) == 0 && (SelectDirection == ShortOnly || SelectDirection == Both))
      if (MA1 < Upper && iClose(NULL, 0, 1) < MA2 && iClose(NULL, 0, 1) < Sar && iClose(NULL, 0, 2) > SarPre && CheckSpread == true)
      {
        double SL = 0, TP = 0;
        double OrderTP = NormalizeDouble(TakeProfit * DigitPoints, _Digits);
        double OrderSL = NormalizeDouble(StopLoss * DigitPoints, _Digits);

        if ((StopLoss > 0) && (UseStopLoss == true))
          SL = NormalizeDouble(Ask + OrderSL, _Digits);

        if ((TakeProfit > 0) && (UseTakeProfit == true))
          TP = NormalizeDouble(Bid - OrderTP, _Digits);

        if (TimeCurrent() > StartTime)
          for (int i = 0; i < SellTotal; i++)
            if (!OrderSend(Symbol(), OP_SELL, NormalizeDouble(LotSize, 2), Bid, Slippage, SL, TP, "Sell", Magic_Number, 0, clrRed))
            {
            }
      }
    LastTimeBarOP2 = iTime(NULL, 0, 0);
  }

  if ((CountBuy(Magic_Number) == 1 || CountSell(Magic_Number) == 1) && (UseTrailingStop || UseBreakEven))
    ModifyOrders(Magic_Number);
}
//====================================================================================================================================================//
// OnTick function
//====================================================================================================================================================//

//====================================================================================================================================================//
double iMAMQL4(string symbol,
               int tf,
               int period,
               int ma_shift,
               int method,
               int price,
               int shift)
{
  ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
  ENUM_MA_METHOD ma_method = MethodMigrate(method);
  ENUM_APPLIED_PRICE applied_price = PriceMigrate(price);
  int handle = iMA(symbol, timeframe, period, ma_shift,
                   ma_method, applied_price);
  if (handle < 0)
  {
    Print("The iMA object is not created: Error", GetLastError());
    return (-1);
  }
  else
    return (CopyBufferMQL4(handle, 0, shift));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_MA_METHOD MethodMigrate(int method)
{
  switch (method)
  {
  case 0:
    return (MODE_SMA);
  case 1:
    return (MODE_EMA);
  case 2:
    return (MODE_SMMA);
  case 3:
    return (MODE_LWMA);
  default:
    return (MODE_SMA);
  }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_APPLIED_PRICE PriceMigrate(int price)
{
  switch (price)
  {
  case 1:
    return (PRICE_CLOSE);
  case 2:
    return (PRICE_OPEN);
  case 3:
    return (PRICE_HIGH);
  case 4:
    return (PRICE_LOW);
  case 5:
    return (PRICE_MEDIAN);
  case 6:
    return (PRICE_TYPICAL);
  case 7:
    return (PRICE_WEIGHTED);
  default:
    return (PRICE_CLOSE);
  }
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
ENUM_STO_PRICE StoFieldMigrate(int field)
{
  switch (field)
  {
  case 0:
    return (STO_LOWHIGH);
  case 1:
    return (STO_CLOSECLOSE);
  default:
    return (STO_LOWHIGH);
  }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double CopyBufferMQL4(int handle, int index, int shift)
{
  double buf[];
  switch (index)
  {
  case 0:
    if (CopyBuffer(handle, 0, shift, 1, buf) > 0)
      return (buf[0]);
    break;
  case 1:
    if (CopyBuffer(handle, 1, shift, 1, buf) > 0)
      return (buf[0]);
    break;
  case 2:
    if (CopyBuffer(handle, 2, shift, 1, buf) > 0)
      return (buf[0]);
    break;
  case 3:
    if (CopyBuffer(handle, 3, shift, 1, buf) > 0)
      return (buf[0]);
    break;
  case 4:
    if (CopyBuffer(handle, 4, shift, 1, buf) > 0)
      return (buf[0]);
    break;
  default:
    break;
  }
  return (EMPTY_VALUE);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double MarketInfo(string symbol,
                  int type)
{
  switch (type)
  {
  case MODE_LOW:
    return (SymbolInfoDouble(symbol, SYMBOL_LASTLOW));
  case MODE_HIGH:
    return (SymbolInfoDouble(symbol, SYMBOL_LASTHIGH));
  case MODE_TIME:
    return (SymbolInfoInteger(symbol, SYMBOL_TIME));
  case MODE_BID:
    return (Bid);
  case MODE_ASK:
    return (Ask);
  case MODE_POINT:
    return (SymbolInfoDouble(symbol, SYMBOL_POINT));
  case MODE_DIGITS:
    return (SymbolInfoInteger(symbol, SYMBOL_DIGITS));
  case MODE_SPREAD:
    return (SymbolInfoInteger(symbol, SYMBOL_SPREAD));
  case MODE_STOPLEVEL:
    return (SymbolInfoInteger(symbol, SYMBOL_TRADE_STOPS_LEVEL));
  case MODE_LOTSIZE:
    return (SymbolInfoDouble(symbol, SYMBOL_TRADE_CONTRACT_SIZE));
  case MODE_TICKVALUE:
    return (SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_VALUE));
  case MODE_TICKSIZE:
    return (SymbolInfoDouble(symbol, SYMBOL_TRADE_TICK_SIZE));
  case MODE_SWAPLONG:
    return (SymbolInfoDouble(symbol, SYMBOL_SWAP_LONG));
  case MODE_SWAPSHORT:
    return (SymbolInfoDouble(symbol, SYMBOL_SWAP_SHORT));
  case MODE_STARTING:
    return (0);
  case MODE_EXPIRATION:
    return (0);
  case MODE_TRADEALLOWED:
    return (0);
  case MODE_MINLOT:
    return (SymbolInfoDouble(symbol, SYMBOL_VOLUME_MIN));
  case MODE_LOTSTEP:
    return (SymbolInfoDouble(symbol, SYMBOL_VOLUME_STEP));
  case MODE_MAXLOT:
    return (SymbolInfoDouble(symbol, SYMBOL_VOLUME_MAX));
  case MODE_SWAPTYPE:
    return (SymbolInfoInteger(symbol, SYMBOL_SWAP_MODE));
  case MODE_PROFITCALCMODE:
    return (SymbolInfoInteger(symbol, SYMBOL_TRADE_CALC_MODE));
  case MODE_MARGINCALCMODE:
    return (0);
  case MODE_MARGININIT:
    return (0);
  case MODE_MARGINMAINTENANCE:
    return (0);
  case MODE_MARGINHEDGED:
    return (0);
  case MODE_MARGINREQUIRED:
    return (0);
  case MODE_FREEZELEVEL:
    return (SymbolInfoInteger(symbol, SYMBOL_TRADE_FREEZE_LEVEL));

  default:
    return (0);
  }
  return (0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int TimeHour(datetime date)
{
  MqlDateTime tm;
  TimeToStruct(date, tm);
  return (tm.hour);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool CheckMoneyForTrade(string symb, double lots, ENUM_ORDER_TYPE type)
{
  //--- Getting the opening price
  MqlTick mqltick;
  SymbolInfoTick(symb, mqltick);
  double price = mqltick.ask;
  if (type == ORDER_TYPE_SELL)
    price = mqltick.bid;
  //--- values of the required and free margin
  double margin, free_margin = AccountInfoDouble(ACCOUNT_MARGIN_FREE);
  //--- call of the checking function
  if (!OrderCalcMargin(type, symb, lots, price, margin))
  {
    //--- something went wrong, report and return false
    Print("Error in ", __FUNCTION__, " code=", GetLastError());
    return (false);
  }
  //--- if there are insufficient funds to perform the operation
  if (margin > free_margin)
  {
    //--- report the error and return false
    Print("Not enough money for ", EnumToString(type), " ", lots, " ", symb, " Error code=", GetLastError());
    return (false);
  }
  //--- checking successful
  return (true);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double point(string symbol = NULL)
{
  string sym = symbol;
  if (symbol == NULL)
    sym = Symbol();
  double bid = MarketInfo(sym, MODE_BID);
  int digits = (int)MarketInfo(sym, MODE_DIGITS);

  if (digits <= 1)
    return (1); // CFD & Indexes
  if (StringFind(sym, "XAU") > -1 || StringFind(sym, "xau") > -1 || StringFind(sym, "GOLD") > -1)
    return (0.01); // Gold
  if (StringFind(sym, "BTC") > -1 || StringFind(sym, "btc") > -1 || StringFind(sym, "BCH") > -1 || StringFind(sym, "bch") > -1 || StringFind(sym, "DSH") > -1 || StringFind(sym, "dsh") > -1 || StringFind(sym, "ETH") > -1 || StringFind(sym, "eth") > -1 || StringFind(sym, "LTC") > -1 || StringFind(sym, "ltc") > -1)
    return (1); // Bitcoin
  if (digits == 4 || digits == 5)
    return (0.00001);
  if ((digits == 2 || digits == 3) && bid > 1000)
    return (0.01);
  if ((digits == 2 || digits == 3) && bid < 1000)
    return (0.001);

  return (0);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int ObjectTypeMQL4(string name)
{
  return ((int)ObjectGetInteger(0, name, OBJPROP_TYPE));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ObjectDescriptionMQL4(string name)
{
  return (ObjectGetString(0, name, OBJPROP_TEXT));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
string ObjectNameMQL4(int index)
{
  return (ObjectName(0, index));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountBuy(int magic)
{
  int open = 0;
  for (int i = 0; i < OrdersTotal(); i++)
  {
    OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
    if (OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderType() == OP_BUY)
    {
      open++;
    }
  }

  return (open);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
int CountSell(int magic)
{
  int open = 0;
  for (int i = 0; i < OrdersTotal(); i++)
  {
    OrderSelect(i, SELECT_BY_POS, MODE_TRADES);
    if (OrderSymbol() == Symbol() && OrderMagicNumber() == magic && OrderType() == OP_SELL)
    {
      open++;
    }
  }

  return (open);
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
void CloseMe(int Type, int Magic, string Reason = "Any")
{
  for (int i = OrdersTotal() - 1; i >= 0; i--)
  {
    if (Type == OP_BUY && OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic && OrderType() == Type && ((OrderProfit() > 0 && Reason == "Profit") || (OrderProfit() < 0 && Reason == "Loss") || Reason == "Any"))
      {
        if (OrderClose(OrderTicket(), OrderLots(), SymbolInfoDouble(Symbol(), SYMBOL_BID), 10, clrNavy) == false)
          Print("Order Close Error on ", Symbol(), " : ", GetLastError());
        else
          Print("Order on ", Symbol(), " closed");
      }

    if (Type == OP_SELL && OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      if (OrderSymbol() == Symbol() && OrderMagicNumber() == Magic && OrderType() == Type && ((OrderProfit() > 0 && Reason == "Profit") || (OrderProfit() < 0 && Reason == "Loss") || Reason == "Any"))
      {
        if (OrderClose(OrderTicket(), OrderLots(), SymbolInfoDouble(Symbol(), SYMBOL_ASK), 10, clrNavy) == false)
          Print("Order Close Error on ", Symbol(), " : ", GetLastError());
        else
          Print("Order on ", Symbol(), " closed");
      }
  }
}
//+------------------------------------------------------------------+
void ModifyOrders(int magic)
{
  //------------------------------------------------------
  double PriceComad = 0;
  double LocalStopLoss = 0;
  bool WasOrderModified;
  string CommentModify;
  //------------------------------------------------------
  // Select order
  for (i = 0; i < OrdersTotal(); i++)
  {
    if (OrderSelect(i, SELECT_BY_POS) == true)
    {
      if ((OrderSymbol() == EASymbol) && (OrderMagicNumber() == magic))
      {
        //------------------------------------------------------
        // Modify buy
        if (OrderType() == OP_BUY)
        {
          LocalStopLoss = 0.0;
          WasOrderModified = false;
          while (true)
          {
            //------------------------------------------------------
            // Break even
            if ((LocalStopLoss == 0) && (BreakEven > 0) && (UseBreakEven == true) && (Bid - OrderOpenPrice() >= (BreakEven + BreakEvenAfter) * DigitPoints) && (NormalizeDouble(OrderOpenPrice() + BreakEven * DigitPoints, _Digits) <= Bid - (StopLevel * DigitPoints)) && (OrderStopLoss() == 0 || OrderStopLoss() <= OrderOpenPrice())) //&&(OrderStopLoss()<OrderOpenPrice()))
            {
              Print("Buy Break");
              PriceComad = NormalizeDouble(OrderOpenPrice() + BreakEven * DigitPoints, _Digits);
              LocalStopLoss = BreakEven;
              CommentModify = "break even";
            }
            //------------------------------------------------------
            // Trailing stop
            //    Print(NormalizeDouble(Bid-((TrailingStop+TrailingStep)*DigitPoints),_Digits)+"   >   "+OrderStopLoss());
            if ((LocalStopLoss == 0) && (TrailingStop > 0) && (UseTrailingStop == true) && ((NormalizeDouble(Bid - ((TrailingStop + TrailingStep) * DigitPoints), _Digits) > OrderStopLoss() || OrderStopLoss() == 0)) && (OrderOpenPrice() <= NormalizeDouble(Bid - TrailingStop * DigitPoints, _Digits)))
            {
              Print("Buy Trail");
              PriceComad = NormalizeDouble(Bid - TrailingStop * DigitPoints, _Digits);
              LocalStopLoss = TrailingStop;
              CommentModify = "trailing stop";
            }
            //------------------------------------------------------
            // Modify
            if ((LocalStopLoss > 0) && (PriceComad != NormalizeDouble(OrderStopLoss(), _Digits)))
              WasOrderModified = OrderModify(OrderTicket(), 0, PriceComad, NormalizeDouble(OrderTakeProfit(), _Digits), 0, clrBlue);
            else
              break;
            //---
            if (WasOrderModified > 0)
            {
              if (SoundAlert == true)
                PlaySound(SoundModify);
              Print(ExpertName + ": modify buy by " + CommentModify + ", ticket: " + DoubleToString(OrderTicket(), 0));
              break;
            }
            else
            {
              Print("Error: ", DoubleToString(GetLastError(), 0) + " || " + ExpertName + ": receives new data and try again modify order");
            }
            //---Errors
            if ((GetLastError() == 1) || (GetLastError() == 132) || (GetLastError() == 133) || (GetLastError() == 137) || (GetLastError() == 4108) || (GetLastError() == 4109))
              break;
            //---
          } // End while(true)
        }   // End if(OrderType()
        //------------------------------------------------------
        // Modify sell
        if (OrderType() == OP_SELL)
        {
          WasOrderModified = false;
          LocalStopLoss = 0.0;
          while (true)
          {
            //------------------------------------------------------
            // Break even
            if ((LocalStopLoss == 0) && (BreakEven > 0) && (UseBreakEven == true) && (OrderOpenPrice() - Ask >= (BreakEven + BreakEvenAfter) * DigitPoints) && (NormalizeDouble(OrderOpenPrice() - BreakEven * DigitPoints, _Digits) >= Ask + (StopLevel * DigitPoints)) && (OrderStopLoss() == 0 || OrderStopLoss() >= OrderOpenPrice())) //&&(OrderStopLoss()>OrderOpenPrice()))
            {
              Print("Sell Break");
              PriceComad = NormalizeDouble(OrderOpenPrice() - BreakEven * DigitPoints, _Digits);
              LocalStopLoss = BreakEven;
              CommentModify = "break even";
            }
            //------------------------------------------------------
            // Trailing stop
            //   Print(NormalizeDouble(Ask+((TrailingStop+TrailingStep)*DigitPoints),_Digits)+"   <   "+OrderStopLoss());

            if ((LocalStopLoss == 0) && (TrailingStop > 0) && (UseTrailingStop == true) && ((NormalizeDouble(Ask + ((TrailingStop + TrailingStep) * DigitPoints), _Digits) < OrderStopLoss() || OrderStopLoss() == 0)) && (OrderOpenPrice() >= NormalizeDouble(Ask + TrailingStop * DigitPoints, _Digits)))
            {
              Print("Sell Trail");
              PriceComad = NormalizeDouble(Ask + TrailingStop * DigitPoints, _Digits);
              LocalStopLoss = TrailingStop;
              CommentModify = "trailing stop";
            }
            //------------------------------------------------------
            // Modify

            if ((LocalStopLoss > 0) && (PriceComad != NormalizeDouble(OrderStopLoss(), _Digits)))
              WasOrderModified = OrderModify(OrderTicket(), 0, PriceComad, NormalizeDouble(OrderTakeProfit(), _Digits), 0, clrRed);
            else
              break;
            //---
            if (WasOrderModified > 0)
            {
              if (SoundAlert == true)
                PlaySound(SoundModify);
              Print(ExpertName + ": modify sell by " + CommentModify + ", ticket: " + DoubleToString(OrderTicket(), 0));
              break;
            }
            else
            {
              Print("Error: ", DoubleToString(GetLastError(), 0) + " || " + ExpertName + ": receives new data and try again modify order");
            }
            //---Errors
            if ((GetLastError() == 1) || (GetLastError() == 132) || (GetLastError() == 133) || (GetLastError() == 137) || (GetLastError() == 4108) || (GetLastError() == 4109))
              break;
            //---
          } // End while(true)
        }   // End if(OrderType()
        //------------------------------------------------------
      } // End if((OrderSymbol()...
    }   // End OrderSelect(...
  }     // End for(...
  //------------------------------------------------------
}
//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double ProfitCheck()
{
  double profit = 0;
  int total = OrdersTotal();
  for (int cnt = total - 1; cnt >= 0; cnt--)
  {
    OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
    if (OrderSymbol() == Symbol())
      profit += OrderProfit() + OrderCommission() + OrderSwap();
  }
  return (profit);
}

//+------------------------------------------------------------------+
void ClosePosAll()
{
  int orderstotal = OrdersTotal();
  int pc = 0;
  long ot[100][3];
  for (int i = 0; i < orderstotal; i++)
  {
    if (!OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
      continue;

    int orderType = OrderType();
    if (orderType != OP_BUY && orderType != OP_SELL)
      continue;

    ot[pc][INDEX_TIME] = OrderOpenTime();
    ot[pc][INDEX_TICKET] = OrderTicket();
    ot[pc][INDEX_LOTS] = (long)(100 * OrderLots());
    pc++;
  }

  ArrayResize(ot, pc);
  ArraySort(ot);

  for (int i = 0; i < pc; i++)
  {
    int ticket = (int)(ot[i][INDEX_TICKET]);
    double lots = (double)(ot[i][INDEX_LOTS] / 100.0);
    Print("Closing Position Ticket:" + IntegerToString(ticket) + " Lots:" + DoubleToString(lots));

    double b = MarketInfo(OrderSymbol(), MODE_BID);

    if (!OrderClose(ticket, lots, b, 3, Red))
    {
      PrintFormat("%s %OrderClose Error %d", OrderSymbol(), GetLastError());
    }
  }
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
bool GoodTime()
{

  if (TimeToString(TimeCurrent(), TIME_MINUTES) >= Time_Start && TimeToString(TimeCurrent(), TIME_MINUTES) <= Time_End)
    return (true);

  return (false);
}
//+------------------------------------------------------------------+
double iSARMQL4(string symbol,
                int tf,
                double step,
                double maximum,
                int shift)
{
  ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
  int handle = iSAR(symbol, timeframe, step, maximum);
  if (handle < 0)
  {
    Print("The iSAR object is not created: Error", GetLastError());
    return (-1);
  }
  else
    return (CopyBufferMQL4(handle, 0, shift));
}

//+------------------------------------------------------------------+
//|                                                                  |
//+------------------------------------------------------------------+
double iMACDMQL4(string symbol,
                 int tf,
                 int fast_ema_period,
                 int slow_ema_period,
                 int signal_period,
                 int price,
                 int mode,
                 int shift)
{
  ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
  ENUM_APPLIED_PRICE applied_price = PriceMigrate(price);
  int handle = iMACD(symbol, timeframe,
                     fast_ema_period, slow_ema_period,
                     signal_period, applied_price);
  if (handle < 0)
  {
    Print("The iMACD object is not created: Error ", GetLastError());
    return (-1);
  }
  else
    return (CopyBufferMQL4(handle, mode, shift));
}
//+------------------------------------------------------------------+
ENUM_TIMEFRAMES TFMigrate(int tf)
{
  switch (tf)
  {
  case 0:
    return (PERIOD_CURRENT);
  case 1:
    return (PERIOD_M1);
  case 5:
    return (PERIOD_M5);
  case 15:
    return (PERIOD_M15);
  case 30:
    return (PERIOD_M30);
  case 60:
    return (PERIOD_H1);
  case 240:
    return (PERIOD_H4);
  case 1440:
    return (PERIOD_D1);
  case 10080:
    return (PERIOD_W1);
  case 43200:
    return (PERIOD_MN1);

  case 2:
    return (PERIOD_M2);
  case 3:
    return (PERIOD_M3);
  case 4:
    return (PERIOD_M4);
  case 6:
    return (PERIOD_M6);
  case 10:
    return (PERIOD_M10);
  case 12:
    return (PERIOD_M12);
  case 16385:
    return (PERIOD_H1);
  case 16386:
    return (PERIOD_H2);
  case 16387:
    return (PERIOD_H3);
  case 16388:
    return (PERIOD_H4);
  case 16390:
    return (PERIOD_H6);
  case 16392:
    return (PERIOD_H8);
  case 16396:
    return (PERIOD_H12);
  case 16408:
    return (PERIOD_D1);
  case 32769:
    return (PERIOD_W1);
  case 49153:
    return (PERIOD_MN1);
  default:
    return (PERIOD_CURRENT);
  }
}

double iBandsMQL4(string symbol,
                  int tf,
                  int period,
                  double deviation,
                  int bands_shift,
                  int method,
                  int mode,
                  int shift)
{
  ENUM_TIMEFRAMES timeframe = TFMigrate(tf);
  ENUM_MA_METHOD ma_method = MethodMigrate(method);
  int handle = iBands(symbol, timeframe, period,
                      bands_shift, deviation, ma_method);
  if (handle < 0)
  {
    Print("The iBands object is not created: Error", GetLastError());
    return (-1);
  }
  else
    return (CopyBufferMQL4(handle, mode, shift));
}
