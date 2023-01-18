#include "Utility.mqh"

// retrieve MA value
double getMAValue(int ma_period, int ma_shift, ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE ma_apply, int shift)
{
    return iMA(NULL, TimeFrame, ma_period, ma_shift, ma_method, ma_apply, shift);
}

// retrieve bollinger band value
double getBBValueOffMA(double &ma_array[], int bb_period, double bb_deviation, int bb_shift, int bb_mode, int shift)
{
    return iBandsOnArray(ma_array, 0, bb_period, bb_deviation, bb_shift, bb_mode, shift);
}

// retrieve PSAR value
double getPSARValue(double p_step, double p_maximum, int shift)
{
    return iSAR(NULL, TimeFrame, p_step, p_maximum, shift);
}

// input set of ma data into array
void setMAdataOnArray(double &ma_array[], int ma_arrSize, int ma_period, int ma_shift, ENUM_MA_METHOD ma_method, ENUM_APPLIED_PRICE ma_apply)
{
    for (int i = 0; i < ma_arrSize; i++)
    {
        ma_array[i] = getMAValue(ma_period, ma_shift, ma_method, ma_apply, i);
    }
}

// input set of bollinger band data into array
void setBBDataOnArrayOffMAData(BBand &bb_array[], double &ma_array[], int bb_arrSize, int bb_period, double bb_deviation, int bb_shift)
{
    double arrCopy[];
    ArrayResize(arrCopy, bb_arrSize);
    for (int i = 0; i < bb_arrSize; i++)
    {
        arrCopy[i] = ma_array[i];
    }
    ArraySetAsSeries(arrCopy, true);
    for (int i = 0; i < bb_arrSize; i++)
    {
        bbData[i].upper = iBandsOnArray(arrCopy, 0, bb_period, bb_deviation, bb_shift, MODE_UPPER, i);
        bbData[i].lower = iBandsOnArray(arrCopy, 0, bb_period, bb_deviation, bb_shift, MODE_LOWER, i);
    }
    // Comment(bbData[checkCandsForConsCount - 1].upper, "\n", bbData[checkCandsForConsCount - 1].lower);
}

// input set of psar data into array
void setPSARDataOnArray(double &pSAR_array[], int pSAR_arrSize, double p_step, double p_maximum)
{
    for (int i = 0; i < pSAR_arrSize; i++)
    {
        pSAR_array[i] = getPSARValue(p_step, p_maximum, i);
    }
}

// trade determinant
ENUM_TRADETYPE getTradeType(double &ma_array[], int ma_arrSize)
{

    bool lookForBuys = true;
    bool lookForSells = true;
    for (int i = BB_Period; i > 0; i--)
    {
        // both are set to false for consolidating markets where ema passes through candle
        if (iLow(NULL, TimeFrame, i) < ma_array[i] && iHigh(NULL, TimeFrame, i) > ma_array[i])
        {
            lookForBuys = false;
            lookForSells = false;
        }
        // if any of the 16 candles to track are below the ema, we're looking for sells, so set the opposite to false
        else if (iHigh(NULL, TimeFrame, i) < ma_array[i])
        {
            lookForBuys = false;
        }
        // if candles are above 200 ema, we're looking for buys,
        else if (iLow(NULL, TimeFrame, i) > ma_array[i])
        {
            lookForSells = false;
        }
    }

    if (lookForBuys)
    {
        return BUYS;
    }
    else if (lookForSells)
    {
        return SELLS;
    }
    else
    {
        return NONE;
    }
}

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

void trade2()
{
    // Print("Previous guy's");
    // Comment(bbData[checkCandsForConsCount - 3].upper, "\n", bbData[checkCandsForConsCount - 3].lower, "\n",bbData[checkCandsForConsCount - 4].upper, "\n", bbData[checkCandsForConsCount - 4].lower);

    if (iTime(NULL, 0, 0) != LastTimeBarOP2 || TradeOnNewBar == false)
    {
        if (CountSell() + CountBuy() == 0 && (SelectDirection == LongOnly || SelectDirection == Both))
            
            if (((ma10Data[2-rT] <= bbData[2-rT].upper && ma10Data[3-rT] <= bbData[3-rT].upper) && ma10Data[1-rT] > bbData[1-rT].upper && iClose(NULL, TimeFrame, 1-rT) > ema200Data[1-rT] && iClose(NULL, TimeFrame, 1-rT) > pSarData[1-rT] && iClose(NULL, TimeFrame, 2-rT) < pSarData[2-rT] && CheckSpread)
            || ((ma10Data[2-rT] <= bbData[2-rT].upper && ma10Data[3-rT] <= bbData[3-rT].upper) && ma10Data[1-rT] > bbData[1-rT].upper && iClose(NULL, TimeFrame, 1-rT) > ema200Data[1-rT] && iClose(NULL, TimeFrame, 2-rT) > pSarData[2] && iClose(NULL, TimeFrame, 3-rT) < pSarData[3-rT] && CheckSpread))
            {

                double SL = 0, TP = 0;
                double OrderTP = NormalizeDouble(takeProfitInPoints * Point, _Digits);
                double OrderSL = NormalizeDouble(stopLossInPoints * Point, _Digits);
                double atrVal = NormalizeDouble(iATR(NULL, TimeFrame, 3, 1), _Digits);

                if (UseFixedStopLoss == true)
                    SL = NormalizeDouble(Bid - OrderSL, _Digits);
                else
                    SL = NormalizeDouble(Bid - (atrVal*atrSLMulti), _Digits);

                if ((takeProfitInPoints > 0) && (UseTakeProfit == true)){
                    if(UseFixedTakeProfit)
                        TP = NormalizeDouble(Ask + OrderTP, _Digits);
                    else
                        TP = NormalizeDouble(Ask + (atrVal*atrTPMuti), _Digits);
                }

                for (int i = 0; i < BuyTotal; i++)
                    if (!OrderSend(Symbol(), OP_BUY, NormalizeDouble(getLotSize(atrVal), 2), Ask, Slippage, SL, TP, "Buy", id, 0, clrBlue))
                    {
                    }
                    else
                    {
                        if (UseTradeCooldown)
                        {
                            tradeCoolDownPeriod = true;
                            startTime = TimeCurrent();
                        }
                        Comment("ATR3: ", iATR(NULL, TimeFrame, 3, 1), "\n", "ATR5: ", iATR(NULL, TimeFrame, 5, 1), "\n", "ATR10: ", iATR(NULL, TimeFrame, 10, 1), "\n", "ATR14: ", iATR(NULL, TimeFrame, 14, 1), "\n");
                        id++;
                    }
            }

        if (CountSell() + CountBuy() == 0 && (SelectDirection == ShortOnly || SelectDirection == Both))
        {
            if (((ma10Data[2-rT] >= bbData[2-rT].lower && ma10Data[3-rT] >= bbData[3-rT].lower) && ma10Data[1-rT] < bbData[1-rT].lower && iClose(NULL, TimeFrame, 1-rT) < ema200Data[1-rT] && iClose(NULL, TimeFrame, 1-rT) < pSarData[1-rT] && iClose(NULL, TimeFrame, 2-rT) > pSarData[2-rT] && CheckSpread) 
            || ((ma10Data[2-rT] >= bbData[2-rT].lower && ma10Data[3-rT] >= bbData[3-rT].lower) && ma10Data[1-rT] < bbData[1-rT].lower && iClose(NULL, TimeFrame, 1-rT) < ema200Data[1-rT] && iClose(NULL, TimeFrame, 2-rT) < pSarData[2-rT] && iClose(NULL, TimeFrame, 3-rT) > pSarData[3-rT] && CheckSpread))
            {
                double SL = 0, TP = 0;
                double OrderTP = NormalizeDouble(takeProfitInPoints * Point, _Digits);
                double OrderSL = NormalizeDouble(stopLossInPoints * Point, _Digits);
                double atrVal = NormalizeDouble(iATR(NULL, TimeFrame, 3, 1), _Digits);

                if (UseFixedStopLoss)
                    SL = NormalizeDouble(Ask + OrderSL, _Digits);
                else
                    SL = NormalizeDouble(Ask + (atrVal * atrSLMulti), _Digits);

                if ((UseTakeProfit)){
                    if(UseFixedTakeProfit)
                        TP = NormalizeDouble(Bid - OrderTP, _Digits);     
                    else
                        TP = NormalizeDouble(Bid - (atrVal * atrTPMuti), _Digits);
                }

                    

                for (int i = 0; i < SellTotal; i++)
                {
                    if (!OrderSend(Symbol(), OP_SELL, NormalizeDouble(getLotSize(atrVal), 2), Bid, Slippage, SL, TP, "Sell", id, 0, clrRed))
                    {
                    }
                    else
                    {
                        if (UseTradeCooldown)
                        {
                            tradeCoolDownPeriod = true;
                            startTime = TimeCurrent();
                        }
                        Comment("ATR3: ", iATR(NULL, TimeFrame, 3, 1), "\n", "ATR5: ", iATR(NULL, TimeFrame, 5, 1), "\n", "ATR10: ", iATR(NULL, TimeFrame, 10, 1), "\n", "ATR14: ", iATR(NULL, TimeFrame, 14, 1), "\n");
                        id++;
                    }
                }
                LastTimeBarOP2 = iTime(NULL, 0, 0);
            }
        }
    }
}



void monitorOpenTrades()
{
    // loop through orders
    for (int i = 0; i < OrdersTotal(); i++)
    {
        // select each order
        if (OrderSelect(i, SELECT_BY_POS, MODE_TRADES))
        {
            // check if symbol is on a chart ea is activated on so not to affect manual trades on charts ea is not on
            if (OrderSymbol() == Symbol())
            {
                // if buy
                if (OrderType() == OP_BUY)
                {
                    // if trade hasn't gone 5 pips in
                    if (OrderStopLoss() < OrderOpenPrice() || OrderStopLoss() == 0)
                    {
                        if (Ask - OrderOpenPrice() >= takeProfitInPoints * Point)
                        {
                            if (!OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice(), 0, 0, 0))
                            {
                            }
                        }
                    }
                    else
                    {
                        if (Ask - OrderStopLoss() >= takeProfitInPoints * 2 * Point)
                        {
                            OrderModify(OrderTicket(), OrderOpenPrice(), Ask - (takeProfitInPoints * Point), 0, 0, 0);
                        }
                        // if(Close[1] < bbData[checkCandsForConsCount-2].upper){
                        //     OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_ASK), 5, clrBlue);
                        // }
                    }
                }
                // else if sell
                else if (OrderType() == OP_SELL)
                {
                    if (OrderStopLoss() > OrderOpenPrice() || OrderStopLoss() == 0)
                    {
                        if (OrderOpenPrice() - Bid >= takeProfitInPoints * Point)
                        {
                            if (!OrderModify(OrderTicket(), OrderOpenPrice(), OrderOpenPrice(), 0, 0, 0))
                            {
                            }
                        }
                    }
                    else
                    {
                        if (OrderStopLoss() - Bid >= takeProfitInPoints * 2 * Point)
                        {
                            OrderModify(OrderTicket(), OrderOpenPrice(), Bid + (takeProfitInPoints * Point), 0, 0, 0);
                        }
                        // if(Close[1] > bbData[checkCandsForConsCount-2].lower){
                        //     OrderClose(OrderTicket(), OrderLots(), MarketInfo(OrderSymbol(), MODE_BID), 5, clrBlue);
                        // }
                    }
                }
            }
        }
    }
}

double getLotSize(double stoploss)
{
    double balance = AccountInfoDouble(ACCOUNT_BALANCE);
    if(UseFixedStopLoss){
        if (balance < 200)
        {
            return 0.1;
        }
        else if (balance < 300)
        {
            return 0.2;
        }
        else if (balance < 500)
        {
            return 0.3;
        }
        else if (balance < 1000)
        {
            return 0.5;
        }
        else
        {
            return 1;
        }
    }
    else{
        double maxMonetaryRisk;
        double lotSizeVolume;
        if (balance < 200)
        {
            maxMonetaryRisk = 10;
        }
        else if (balance < 300)
        {
            //max monetary risk = 20;
            maxMonetaryRisk = 20;
        }
        else if (balance < 500)
        {
            //max monetary risk = 30;
            maxMonetaryRisk = 30;
        }
        else if (balance < 1000)
        {
            //max monetary risk = 50;
            maxMonetaryRisk = 50;
        }
        else
        {
            //max monetary risk = 100;
            maxMonetaryRisk = 100;
        }

        lotSizeVolume = NormalizeDouble(maxMonetaryRisk / ((stoploss * pow(10, _Digits)) * SymbolInfoDouble(NULL, SYMBOL_TRADE_TICK_VALUE)), 2);

        if (lotSizeVolume < 0.01)
            return 0.01;
        else
            return lotSizeVolume;
    }
}

void printConditions(string display, int one, bool two, bool three)
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
