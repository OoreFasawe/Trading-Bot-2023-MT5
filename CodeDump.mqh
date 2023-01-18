
//code not using but don't wanna throw away just yet

void trade1()
{
    // Print("Mine");
    //"||======== MA crossing BB check ========||";
    int beforeIdx = -1;
    int afterIdx = -1;
    int pSarIdx = -1;
    bool seenPSARDot = false;
    ENUM_TRADETYPE condOne = NONE;
    bool condTwo = false;
    bool condThree = false;
    // Comment("ma10: ", ma10Data[checkCandsForConsCount-1], "\n", "bb3Up: ", bbData[checkCandsForConsCount-1].upper, "\n", "bb3Down: ", bbData[checkCandsForConsCount-1].lower, "\n", "pSARData: ", pSarData[checkCandsForConsCount-1]);
    if (marketScanType == BUYS && CountSell() + CountBuy() == 0 && (SelectDirection == ShortOnly || SelectDirection == Both))
    {
        condOne = BUYS;
        beforeIdx = -1;
        afterIdx = -1;
        pSarIdx = -1;
        for (int i = BB_Period; i > 0; i--)
        {

            if (ma10Data[i] > ema200Data[i] && bbData[i].lower > ema200Data[i])
            {
                if (getRelativePosition(ma10Data[i], bbData[i].lower) == BELOW && getRelativePosition(ma10Data[i + 1], bbData[i + 1].lower) == BELOW)
                {
                    beforeIdx = i;
                }
                else if (getRelativePosition(ma10Data[i], bbData[i].upper) == ABOVE)
                {
                    afterIdx = i;
                }
                if (getRelativePosition(pSarData[i], iLow(NULL, TimeFrame, i)) == BELOW && !seenPSARDot)
                {
                    pSarIdx = i;
                    seenPSARDot = true;
                }
            }
        }

        if (pSarIdx > 0)
        {
            condTwo = true;
            if (beforeIdx > 0 && afterIdx > 0)
            {
                if (beforeIdx >= afterIdx && pSarIdx >= afterIdx)
                {
                    // trade: drawing lines for now for testing in strategy tester
                    condThree = true;
                    if (UseTradeCooldown)
                    {
                        tradeCoolDownPeriod = true;
                        startTime = TimeCurrent();
                    }
                    double SL = 0, TP = 0;
                    double OrderTP = NormalizeDouble(takeProfitInPoints * Point, _Digits);
                    double OrderSL = NormalizeDouble(stopLossInPoints * Point, _Digits);
                    double atrVal = NormalizeDouble(iATR(NULL, TimeFrame, 3, 1), _Digits);

                    if (UseFixedStopLoss == true)
                        SL = NormalizeDouble(Bid - OrderSL, _Digits);
                    else
                        SL = NormalizeDouble(Bid - atrVal, _Digits);

                    if(UseTakeProfit)
                        TP = NormalizeDouble(Ask + takeProfitInPoints * Point, _Digits);

                    OrderSend(NULL, OP_BUY, getLotSize(), Ask, 5, SL, TP, NULL, id, 0, Green);
                    id++;
                }
                else
                {
                    // Comment("CROSSOVER IN REVERSE ORDER");
                }
            }
            else
            {
                // Comment("NO VALID CROSSOVER");
            }
        }
        else
        {
            // Comment("NO DOT BELOW YET")
        }
    }
    else if (marketScanType == SELLS && CountSell() + CountBuy() == 0 && (SelectDirection == ShortOnly || SelectDirection == Both))
    {
        condOne = SELLS;
        beforeIdx = -1;
        afterIdx = -1;
        pSarIdx = -1;
        for (int i = BB_Period; i > 0; i--)
        {
            if (ma10Data[i] < ema200Data[i] && bbData[i].upper < ema200Data[i])
            {
                if (getRelativePosition(ma10Data[i], bbData[i].upper) == ABOVE && getRelativePosition(ma10Data[i + 1], bbData[i + 1].upper) == ABOVE)
                {
                    beforeIdx = i;
                }
                else if (getRelativePosition(ma10Data[i], bbData[i].lower) == BELOW)
                {
                    afterIdx = i;
                }
                if (getRelativePosition(pSarData[i], iHigh(NULL, TimeFrame, i)) == ABOVE && !seenPSARDot)
                {
                    pSarIdx = i;
                    seenPSARDot = true;
                }
            }
        }

        if (pSarIdx > 0)
        {
            condTwo = true;
            if (beforeIdx > 0 && afterIdx > 0)
            {
                if (beforeIdx >= afterIdx && pSarIdx >= afterIdx)
                {
                    // trade: drawing lines for now for testing in strategy tester
                    condThree = true;
                    if (UseTradeCooldown)
                    {
                        tradeCoolDownPeriod = true;
                        startTime = TimeCurrent();
                    }

                    double SL = 0, TP = 0;
                    double OrderTP = NormalizeDouble(takeProfitInPoints * Point, _Digits);
                    double OrderSL = NormalizeDouble(stopLossInPoints * Point, _Digits);
                    double atrVal = NormalizeDouble(iATR(NULL, TimeFrame, 3, 1), _Digits);

                    if (UseFixedStopLoss == true)
                        SL = NormalizeDouble(Ask + OrderSL, _Digits);
                    else
                        SL = NormalizeDouble(Ask + atrVal, _Digits);

                    if ((takeProfitInPoints > 0) && (UseTakeProfit == true))
                        TP = NormalizeDouble(Bid - OrderTP, _Digits);

                    OrderSend(NULL, OP_SELL, getLotSize(), Bid, 5, SL, TP, NULL, id, 0, Red);
                    id++;
                }
                else
                {
                    // Comment("CROSSOVER IN REVERSE ORDER");
                }
            }
            else
            {
                // Comment("NO VALID CROSSOVER");
            }
        }
        else
        {
            // Comment("NO DOT ABOVE YET")
        }
    }
    printConditions(display, condOne, condTwo, condThree);
}