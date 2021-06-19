
% clear

dr_i=3;
ta_i=3;

thre=1;

fold=5;

dis=1;  % dis==1 indicate distance-based negative screening
% dis=0;  % dis==0 indicate random-selection negative screening

NAME='GPCR';
% NAME='Ion_channel';
% NAME='Nuclear_receptor';
% NAME='Enzyme';

opt_Po_Un_gener;

Pos_set=Pos_set(:,2:(dim+1));
Unlabel_set=Unlabel_set(:,2:(dim+1));


if dis==1
    Neg_set=dis_select(Pos_set,Unlabel_set,1);
    Neg_set=Neg_set(:,2:(dim+1));
else
    if dis==0
        Neg_set=ran_select(Unlabel_set,z_pos,2);
%         Neg_set=Neg_set(:,2:(dim+1));
    end
end
auc=zeros(thre,1);
score=zeros(thre,1);
precision=zeros(thre,1);
recall=zeros(thre,1);
MCC=zeros(thre,1);
ACC=zeros(thre,1);

model=cell(fold,1);

xx=zeros(thre,10001);
yy=zeros(thre,10001);
auc=0;aupr=0;
f1=0;
precision=0;
recall=0;
MCC=0;
RESULT=[];
T_AUC=zeros(thre,1);
T_AUPR=zeros(thre,1);
xx=zeros(1,10001);xxpr=zeros(1,10001);
yy=zeros(1,10001);yypr=zeros(1,10001);
for flag=1:thre
    flag;
    for c=2
        c;
        for gamma=-2%-10:10
            gamma;
            auc=0;aupr=0;
            f1=0;
            precision=0;
            recall=0;
            MCC=0;
% % %     if dis==0
% % %         Neg_set=ran_select(Unlabel_set,z_pos,2);
% % % %         Neg_set=Neg_set(:,2:(dim+1));
% % %     end
    
    [pos_train,pos_test]=Fold_div(Pos_set,fold,1);
    [neg_train,neg_test]=Fold_div(Neg_set,fold,1);
    pos_dec=[];neg_dec=[];
    pos_pre=[];neg_pre=[];
    
    for i=1:fold
        POS=pos_train{1,i};POST=pos_test{1,i};
        z_ptrain=size(POS,1);z_ptest=size(POST,1);
        
        NEG=neg_train{1,i};NEGT=neg_test{1,i};
        z_ntrain=size(NEG,1);z_ntest=size(NEGT,1);
        
        TRAIN=[POS;NEG];
        LABEL=[ones(z_ptrain,1);zeros(z_ntrain,1)];
        
        TEST=[POST;NEGT];
        TLABEL=[ones(z_ptest,1);zeros(z_ntest,1)];
        
        model{i,1}=svmtrain(LABEL,TRAIN,strcat(['-t 2 -c ',num2str(2^(c)), ' -g ',num2str(2^(gamma)),' -w1 1 -w-1 1 -h 0 -q']));
        
%         x=randperm(z_pos);y=randperm(z_unlabel);
%         vali_size=size(POST,1);
%         x=x(1:vali_size);y=y(1:vali_size);
%         X=Pos_set(x,:);Y=Unlabel_set(y,:);
        
        [pre,acc,dec]=svmpredict(TLABEL,[POST;NEGT],model{i,1},strcat(['-q']));
        
        
        
%         AUC_cal(dec,TLABEL);
        [auc0,xx0,yy0,aupr0,xxpr0,yypr0]=AUC_AUPR(dec,TLABEL);
        auc=auc+auc0;aupr=aupr+aupr0;
        xx=xx+xx0;yy=yy+yy0;
        xxpr=xxpr+xxpr0;yypr=yypr+yypr0;
        [f0,pre0,rec0,mcc0]=F1_score_para(pre,TLABEL);
        f1=f1+f0;
        precision=precision+pre0;
        recall=recall+rec0;
        MCC=MCC+mcc0;
%         pos_dec=[pos_dec;dec(1:z_ptest,:)];
%         pos_pre=[pos_pre;pre(1:z_ptest,:)];
%         neg_dec=[neg_dec;dec((z_ptest+1):(z_ptest+z_ntest),:)];
%         neg_pre=[neg_pre;pre((z_ptest+1):(z_ptest+z_ntest),:)];
    end
    auc=auc/5;
    f1=f1/5;
    aupr=aupr/5;
    xx=xx/5;yy=yy/5;
    xxpr=xxpr/5;yypr=yypr/5;
    precision=precision/5;
    recall=recall/5;
    MCC=MCC/5;
    RESULT=[RESULT;[c,gamma,auc,aupr,f1,precision,recall,MCC]];
%     
        end
    end
    T_AUC(flag,1)=auc;
    T_AUPR(flag,1)=aupr;
%     auc=0;aupr=0;
end

% Total_M=[precision,recall,ACC,score,MCC,auc];
% 
% save([NAME,'_',num2str(dr_i),'_',num2str(ta_i),'_',num2str(dis),'_total'],'Total_M');
% save([NAME,'_',num2str(dr_i),'_',num2str(ta_i),'_',num2str(dis),'_xx'],'xx');
% save([NAME,'_',num2str(dr_i),'_',num2str(ta_i),'_',num2str(dis),'_yy'],'yy');
    
        
    
pre=zeros(z_unlabel,fold);
dec=zeros(z_unlabel,fold);
F_pre=zeros(z_unlabel,1);
F_dec=zeros(z_unlabel,1);

for i=1:fold
    i
    [pre(:,i),acc,dec(:,i)]=svmpredict(zeros(z_unlabel,1),Unlabel_set,model{i,1},strcat('-q'));
    F_pre=F_pre+pre(:,i);
    F_dec=F_dec+dec(:,i);
end

[m,n]=sort(F_dec);

MM_dec=F_dec(n,:)/fold;
TA_DR_UN=TA_DR_UN(n,:);
TA_DR_UN(z_unlabel:-1:(z_unlabel-4),:)
MM_dec(z_unlabel:-1:(z_unlabel-4))
% save([NAME,'_',num2str(dr_i),'_',num2str(ta_i),'_','Unlabel_decision'],'MM_dec');
% save([NAME,'_',num2str(dr_i),'_',num2str(ta_i),'_','Unlabel_DTpairs'],'TA_DR_UN');
% save([NAME,'_',num2str(dr_i),'_',num2str(ta_i),'_','Positive_DTpairs'],'TA_DR_PO');
    
    
    
    
    
    