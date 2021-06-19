function [auc,xx,yy,tp,tn,fp,fn] = AUC_cal(dec,LABEL)
%AUC_CAL 此处显示有关此函数的摘要
%   此处显示详细说明
myNumb = length(-5:.001:5);
    TruPos = zeros(1,myNumb); TruNeg = zeros(1,myNumb);
    FalPos = zeros(1,myNumb); FalNeg = zeros(1,myNumb);
    countMan = 0;
    for moveit = -5:.001:5
        countMan = countMan + 1;
        TruPos(countMan) = sum(sign(dec + moveit)==1 & LABEL==1);
        FalPos(countMan) = sum(sign(dec + moveit)==1 & LABEL==0);
        TruNeg(countMan) = sum(sign(dec + moveit)==-1 & LABEL==0);
        FalNeg(countMan) = sum(sign(dec + moveit)==-1 & LABEL==1);
    end
    tp=TruPos;tn=TruNeg;
    fp=FalPos;fn=FalNeg;
    xx = FalPos/max(FalPos);
    yy = TruPos/max(TruPos);
    areaUnderROC = 0;
    old = [0 0];
    for bb = 1:myNumb
        new = [xx(bb) yy(bb)];
        if new(1) == old(1) & new(2) > old(2)
            old = new;
        elseif new(1) > old(1) & new(2) > old(2)
            areaUnderROC = areaUnderROC + ((old(2) + new(2))/2) * (new(1) - old(1));
            old = new;
        elseif new(1) > old(1) & new(2) == old(2)
            areaUnderROC = areaUnderROC + old(2) * (new(1) - old(1));
            old = new;
        end
    end
    auc=areaUnderROC;
    
    
    xFDRPR = TruPos/max(TruPos);
yFDR = FalPos./(FalPos + TruPos);
yPR = 1 - yFDR;
% subplot(1,3,2);plot(xFDRPR,yFDR);
% subplot(1,3,3);plot(xFDRPR,yPR);

%area under precision accuracy curve: (actually it's a code for area under the FDR curve, so
%in the last line we do "1 - result".
            xxPR = TruPos/max(TruPos);
            yyPR = FalPos./(FalPos + TruPos + .000000001*(FalPos==0 & TruPos==0));
            xRun = 0;
            addToSum = 0;
            myXa = 0;
                for myCounta = 1:myNumb
                    if xxPR(myCounta) > xRun & myCounta > 1
                        myXb = xxPR(myCounta);
                        addToSum = addToSum + (myXb - myXa)*(yyPR(myCounta - 1) + yyPR(myCounta))/2;
                        myXa = myXb;
                        xRun = xxPR(myCounta);
                    elseif xxPR(myCounta) > xRun & myCounta == 1
                        myXa = xxPR(1);
                        xRun = xxPR(myCounta);
                    end
                end
            AUPR = 1 - addToSum;
%             plot(xxPR,1-yyPR)
end

