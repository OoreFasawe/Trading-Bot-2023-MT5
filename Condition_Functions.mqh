#include "Utility.mqh"
#include <Trade\Trade.mqh>
#include "CorrectnessChecks.mqh"


// the position of the first argument relative to the second
ENUM_RELATIVEPOSITION getRelativePosition(double val1, double val2)
{
    if (val1 > val2)
    {
        return ABOVE;
    }
    else if (val1 < val2)
    {
        return BELOW;
    }
    else
    {
        return EQUAL;
    }
}

void trade()
{
    if (iTime(NULL, TimeFrame, 0) != LastTimeBarOP2 || TradeOnNewBar == false)
    {
        if (CountSell() + CountBuy() == 0 && (SelectDirection == LongOnly || SelectDirection == Both)){
            if (ma10Data[2] <= bbDataUpper[2] && ma10Data[1] > bbDataUpper[1] && iClose(NULL, TimeFrame, 1) > ema200Data[1] && iClose(NULL, TimeFrame, 1) > pSarData[1] && iClose(NULL, TimeFrame, 2) < pSarData[2] && CheckSpread)
            {
                double SL = 0, TP = 0;
                double buff[];
                CopyBuffer(ATR_Handle, 0, 1, 1, buff);
                double atrVal = buff[0];
                int stopLevel = SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL);
                if (UseStopLoss)
                    SL = (stopLevel * _Point) < (atrVal * atrSLMulti) ? NormalizeDouble(Bid - (atrVal*atrSLMulti), _Digits) : NormalizeDouble(Bid - (stopLevel * _Point), _Digits);

                if (UseTakeProfit)
                    TP = NormalizeDouble(Ask + (atrVal*atrTPMuti), _Digits);
                
                Comment(SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL), "\n", SL, "\n", TP, "\n", NormalizeDouble(Bid - (atrVal*atrSLMulti), _Digits), "\n", NormalizeDouble(Ask + (atrVal*atrTPMuti), _Digits), "\n", "Bid: ", Bid, "\n", "Ask: ", Ask);
                for (int i = 0; i < BuyTotal; i++){
                    string description = "";
                    double lotSize = getLotSize(atrVal * atrSLMulti);
                    if(!CheckVolumeValue(lotSize, description)){
                        Print(description);
                    }
                    else if(CheckMoneyForTrade(Symbol(), lotSize, ORDER_TYPE_BUY)){
                        trade.Buy(lotSize, NULL, Ask, SL, TP, NULL);
                        if (UseTradeCooldown)
                        {
                            tradeCoolDownPeriod = true;
                            startTime = TimeCurrent();
                        }
                        //Comment("ATR3: ", iATR(NULL, TimeFrame, 3, 1), "\n", "ATR5: ", iATR(NULL, TimeFrame, 5, 1), "\n", "ATR10: ", iATR(NULL, TimeFrame, 10, 1), "\n", "ATR14: ", iATR(NULL, TimeFrame, 14, 1), "\n");
                        id++;
                    }
                }
            }
        }
        if (CountSell() + CountBuy() == 0 && (SelectDirection == ShortOnly || SelectDirection == Both))
        {
            if (ma10Data[2] >= bbDataLower[2] && ma10Data[1] < bbDataLower[1] && iClose(NULL, TimeFrame, 1) < ema200Data[1] && iClose(NULL, TimeFrame, 1) < pSarData[1] && iClose(NULL, TimeFrame, 2) > pSarData[2] && CheckSpread) 
            {
                double SL = 0, TP = 0;
                double buff[];
                CopyBuffer(ATR_Handle, 0, 1, 1, buff);
                double atrVal = buff[0];
                int stopLevel = SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL);
                if (UseStopLoss)
                    SL = (stopLevel * _Point) < (atrVal * atrSLMulti) ?  NormalizeDouble(Ask + (atrVal * atrSLMulti), _Digits) : NormalizeDouble(Ask + (stopLevel * _Point), _Digits);

                if (UseTakeProfit)
                    TP = NormalizeDouble(Bid - (atrVal * atrTPMuti), _Digits);
                
                
                Comment(SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL), "\n", SL, "\n", TP, "\n", NormalizeDouble(Ask + (atrVal * atrSLMulti), _Digits), "\n", NormalizeDouble(Bid - (atrVal * atrTPMuti), _Digits), "\n", "Bid: ", Bid, "\n", "Ask: ", Ask);
                for (int i = 0; i < SellTotal; i++){
                    string description = "";
                    double lotSize = getLotSize(atrVal * atrSLMulti);
                    if(!CheckVolumeValue(lotSize, description)){
                        Print(description);
                    }
                    else if(CheckMoneyForTrade(Symbol(), lotSize, ORDER_TYPE_SELL)){
                        trade.Sell(lotSize, NULL, Bid, SL, TP, NULL);
                        if (UseTradeCooldown)
                        {
                            tradeCoolDownPeriod = true;
                            startTime = TimeCurrent();
                        }
                        //Comment("ATR3: ", iATR(NULL, TimeFrame, 3, 1), "\n", "ATR5: ", iATR(NULL, TimeFrame, 5, 1), "\n", "ATR10: ", iATR(NULL, TimeFrame, 10, 1), "\n", "ATR14: ", iATR(NULL, TimeFrame, 14, 1), "\n");
                        id++;
                    }
                }
            }
        }
        //LastTimeBarOP2 = iTime(NULL, TimeFrame, 0);
    }
}

void monitorOpenTrades()
{
    //for 1 order at a time
    // loop through orders
    for (int i = 0; i < PositionsTotal(); i++)
    {
        ulong orderTicket = PositionGetTicket(i);
        // select each order
        if (PositionSelectByTicket(orderTicket))
        {
                // check if symbol is on a chart ea is activated on so not to affect manual trades on charts ea is not on
            if (PositionGetString(POSITION_SYMBOL) == Symbol())
            {
                
                // if buy
                if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_BUY)
                {
                    //for maximized dyanmic take profit, and reduced stoploss if possible
                    double SL = 0, TP = 0;
                    double buff[];
                    CopyBuffer(ATR_Handle, 0, 1, 1, buff);
                    double atrVal = buff[0];
                    int stopLevel = SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL);
                    if (UseStopLoss)
                        SL = PositionGetDouble(POSITION_SL);
                    if (UseTakeProfit)
                        TP = PositionGetDouble(POSITION_TP);
                    if(Ask <= SL || (ma10Data[0] < bbDataLower[1] && pSarData[0] > iClose(NULL, TimeFrame, 0))){
                        trade.PositionClose(PositionGetString(POSITION_SYMBOL), 3);
                    }


                    //for locking in profits and breakeven type functionality so winners don't become losers
                    //if trade is in profit and the distance from 
                    if(useTrailingStop && (Ask - PositionGetDouble(POSITION_PRICE_OPEN)) >= atrVal && (Ask -  SL) >= atrVal){
                        trade.PositionModify(orderTicket,NormalizeDouble(Bid - atrVal, _Digits), TP);
                    }




                    // // if trade hasn't gone 5 pips in
                    // if (OrderStopLoss() < OrderOpenPrice() || OrderStopLoss() == 0)
                    // {
                    //     if (Ask - OrderOpenPrice() >= takeProfitInPoints * _Point)
                    //     {
                    //         if (!OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice(), 0, 0, 0))
                    //         {
                    //         }
                    //     }
                    // }
                    // else
                    // {
                    //     if (Ask - OrderStopLoss() >= takeProfitInPoints * 2 * _Point)
                    //     {
                    //         OrderModify(OrderTicket(), OrderOpenPrice(), Ask - (takeProfitInPoints * _Point), 0, 0, 0);
                    //     }
                    //     // if(Close[1] < bbData[checkCandsForConsCount-2].upper){
                    //     //     OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, clrBlue);
                    //     // }
  
                }
                
                // else if sell
                else if (PositionGetInteger(POSITION_TYPE) == POSITION_TYPE_SELL)
                {
                    //for maximized dyanmic take profit, and reduced stoploss if possible
                    double SL = 0, TP = 0;
                    double buff[];
                    CopyBuffer(ATR_Handle, 0, 1, 1, buff);
                    double atrVal = buff[0];
                    int stopLevel = SymbolInfoInteger(Symbol(),SYMBOL_TRADE_STOPS_LEVEL);
                    if (UseStopLoss)
                        SL = PositionGetDouble(POSITION_SL);
                    if (UseTakeProfit)
                        TP = PositionGetDouble(POSITION_TP);
                    if(Bid >= SL || (ma10Data[0] > bbDataUpper[0] && pSarData[0] < iClose(NULL, TimeFrame, 0))){
                        trade.PositionClose(PositionGetString(POSITION_SYMBOL), 3);
                    }
                    
                    //for locking in profits and breakeven type functionality so winners don't become losers
                    if(useTrailingStop && (PositionGetDouble(POSITION_PRICE_OPEN)-Bid) >= atrVal && (SL - Bid) >= atrVal){
                        trade.PositionModify(orderTicket,NormalizeDouble(Ask + atrVal, _Digits), TP);
                    }

                    


                    // if (OrderStopLoss() > OrderOpenPrice() || OrderStopLoss() == 0)
                    // {
                    //     if (OrderOpenPrice() - Bid >= takeProfitInPoints * _Point)
                    //     {
                    //         if (!OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice(), 0, 0, 0))
                    //         {
                    //         }
                    //     }
                    // }
                    // else
                    // {
                    //     if (OrderStopLoss() - Bid >= takeProfitInPoints * 2 * _Point)
                    //     {
                    //         OrderModify(OrderTicket(), OrderOpenPrice(), Bid + (takeProfitInPoints * _Point), 0, 0, 0);
                    //     }
                    //     // if(Close[1] > bbData[checkCandsForConsCount-2].lower){
                    //     //     OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, clrBlue);
                    //     // }
                    // }
                }
            }
        }
    }
}

double getLotSize(double stoploss)
{
    double balance = AccountInfoDouble(ACCOUNT_BALANCE);
    double maxMonetaryRisk;
    double lotSizeVolume;
    if (balance < 101)
    {
        maxMonetaryRisk = 10;
    }
    else if (balance < 201)
    {
        //max monetary risk = 20;
        maxMonetaryRisk = 20;
    }
    else if (balance < 301)
    {
        //max monetary risk = 30;
        maxMonetaryRisk = 30;
    }
    else if (balance < 401)
    {
        //max monetary risk = 50;
        maxMonetaryRisk = 40;
    }
    else if(balance < 700)
    {
        //max monetary risk = 100;
        maxMonetaryRisk = 60;
    }
    else if(balance < 900){
        maxMonetaryRisk = 80;
    }
    else{
        maxMonetaryRisk = 100;
    }
    Print(SymbolInfoDouble(NULL, SYMBOL_TRADE_TICK_VALUE));
    Print(maxMonetaryRisk);
    Print((stoploss * pow(10, _Digits)));
    Print(maxMonetaryRisk/(stoploss * pow(10, _Digits)));
    lotSizeVolume = maxMonetaryRisk / ((stoploss * pow(10, _Digits)) + calculatePipDifference(SymbolInfoDouble(NULL, SYMBOL_BID), SymbolInfoDouble(NULL, SYMBOL_ASK)) * SymbolInfoDouble(NULL, SYMBOL_TRADE_TICK_VALUE));

    if (lotSizeVolume < 0.01)
        return NormalizeDouble(0.01 * lotMulti, 2);
    else
        return NormalizeDouble(lotSizeVolume * lotMulti, 2);
}

void printConditions(int one, bool two, bool three)
{
    if (one == BUYS)
    {
        display += "Condition 1(200EMA): LOOKING FOR BUYS\n";
    }
    else if (one == SELLS)
    {
        display += "Condition 1(200EMA): LOOKING FOR SELLS\n";
    }
    else
    {
        display += "Condition 1(200EMA): 200EMA in between FOOL3Bs\n";
    }

    display += two ? "Condition 2(PSAR DOT): YES\n" : "Condition 2(PSAR DOT): NO\n";
    display += three ? "Condition 3(MA/BB CROSSING): YES\n" : "Condition 3(MA/BB CROSSING): NO\n";

    Comment(display);
}

bool GoodTime()
{
    if (UseTimeFilter)
    {
        if (TimeToString(TimeCurrent(), TIME_MINUTES) >= Time_Start && TimeToString(TimeCurrent(), TIME_MINUTES) <= Time_End)
            return (true);
        return (false);
    }
    else
    {
        return true;
    }
}

double calculatePriceDifference(double p1, double p2)
{
  double priceDifference = p1 > p2 ? p1 - p2 : p2 - p1;

  return NormalizeDouble(priceDifference, _Digits);
}

double calculatePipDifference(double p1, double p2)
{
  double pipDifference = calculatePriceDifference(p1, p2) * pow(10, _Digits);

  return NormalizeDouble(pipDifference, 0);
}

// double ProfitCheck()
//   {
//    double profit=0;
//    int total  = OrdersTotal();
//    for(int cnt = total-1 ; cnt >=0 ; cnt--)
//      {
//       OrderSelect(cnt, SELECT_BY_POS, MODE_TRADES);
//       if(OrderSymbol()==Symbol())
//          profit+=OrderProfit()+OrderCommission()+OrderSwap();
//      }
//    return(profit);
//   }

// bool CheckMoneyForTrade(string symb,double lots,ENUM_ORDER_TYPE type)
//   {
// //--- Getting the opening price
//    MqlTick mqltick;
//    SymbolInfoTick(symb,mqltick);
//    double price=mqltick.ask;
//    if(type==ORDER_TYPE_SELL)
//       price=mqltick.bid;
// //--- values of the required and free margin
//    double margin,free_margin=AccountInfoDouble(ACCOUNT_MARGIN_FREE);
// //--- call of the checking function
//    if(!OrderCalcMargin(type,symb,lots,price,margin))
//      {
//       //--- something went wrong, report and return false
//       Print("Error in ",__FUNCTION__," code=",GetLastError());
//       return(false);
//      }
// //--- if there are insufficient funds to perform the operation
//    if(margin>free_margin)
//      {
//       //--- report the error and return false
//       Print("Not enough money for ",EnumToString(type)," ",lots," ",symb," Error code=",GetLastError());
//       return(false);
//      }
// //--- checking successful
//    return(true);
//   }

// extern double PERCENTAGE_RISK_PER_TRADE = 0.01;
// double BALANCE = AccountInfoDouble(ACCOUNT_BALANCE);
// double calculateLotSize(double stopLossInPips)
// {
//   double maxMonetaryRisk = BALANCE * PERCENTAGE_RISK_PER_TRADE;
//   double lotSizeVolume = maxMonetaryRisk / ((stopLossInPips + calculatePipDifference(SymbolInfoDouble(NULL, SYMBOL_BID), SymbolInfoDouble(NULL, SYMBOL_ASK) /*_SPREAD*/)) * SymbolInfoDouble(NULL, SYMBOL_TRADE_TICK_VALUE));

//   return NormalizeDouble(lotSizeVolume, 2);
// }
