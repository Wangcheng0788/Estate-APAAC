function [tp,tn,fp,fn] = F1_score(pre,TLabel)
%F1_SCORE 此处显示有关此函数的摘要
%   此处显示详细说明
z=size(pre,1);
tp=0;fp=0;
tn=0;fn=0;
for i=1:z
    if pre(i)==TLabel(i)
        if pre(i)==1
            tp=tp+1;
        elseif pre(i)==0
            tn=tn+1;
        end
    else
        if pre(i)==1
            fp=fp+1;
        elseif pre(i)==0
            fn=fn+1;
        end
    end
end
% accuracy=(tp+tn)/(tp+tn+fp+fn);
precision=tp/(tp+fp);
recall=tp/(tp+fn);
score=2*precision*recall/(precision+recall);
MCC=(tp*tn-fp*fn)/sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn));
end

