function [POS_Train,POS_Test] = Fold_div(Pos_set,mode,para)
%FOLD_DIV 此处显示有关此函数的摘要
%   此处显示详细说明
% if isempty(para)==1
%     para=1;
% end
% para=1, return 0.8-train,0.2-test;
% para=0, return 0.2/0.2/0.2/0.2/0.2 for train and test
POS_Train=cell(1,mode);
% UNL_Train=cell(1,mode);
POS_Test=cell(1,mode);
% UNL_Test=cell(1,mode);
z_pos=size(Pos_set,1);
ranp=randperm(z_pos);
Pos_set=Pos_set(ranp,:);
% imshow
% z_unl=size(Unlabel_set,1);
z_fp=ceil(z_pos/mode);
if para==1
    
    for i=1:mode
        seq_p=((i-1)*z_fp+1):min(z_pos,i*z_fp);
        POS_Train{1,i}=Pos_set(setdiff(1:z_pos,seq_p),:);
        POS_Test{1,i}=Pos_set(seq_p,:);
    end
elseif para==0
    for i=1:mode
        seq_p=((i-1)*z_fp+1):min(z_pos,i*z_fp);
        POS_Train{1,i}=Pos_set(seq_p,:);
    end
end
end

