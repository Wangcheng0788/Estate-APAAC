



if dis==0
        Neg_set=ran_select(Unlabel_set,z_pos,2);
%         Neg_set=Neg_set(:,2:(dim+1));
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

% for flag=1:thre
%     flag
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
        
% % %         [pre,acc,dec]=svmpredict(TLABEL,TEST,model{i,1},strcat(['-q']));
% % %         pos_dec=[pos_dec;dec(1:z_ptest,:)];
% % %         pos_pre=[pos_pre;pre(1:z_ptest,:)];
% % %         neg_dec=[neg_dec;dec((z_ptest+1):(z_ptest+z_ntest),:)];
% % %         neg_pre=[neg_pre;pre((z_ptest+1):(z_ptest+z_ntest),:)];
    end
% % %     z_pd=size(pos_dec,1);
% % %     z_nd=size(neg_dec,1);
% % %     DEC=[pos_dec;neg_dec];
% % %     PRE=[pos_pre;neg_pre];
% % %     D_Label=[ones(z_pd,1);zeros(z_nd,1)];
% % %     
% % %     [tp,tn,fp,fn]=F1_score(PRE,D_Label);
% % %     score(flag,1)=2*(tp/(tp+fp))*(tp/(tp+fn))/((tp/(tp+fp))+(tp/(tp+fn)));
% % %     precision(flag,1)=tp/(tp+fp);
% % %     recall(flag,1)=tp/(tp+fn);
% % %     MCC(flag,1)=(tp*tn-fp*fn)/sqrt((tp+fp)*(tp+fn)*(tn+fp)*(tn+fn));
% % %     ACC(flag,1)=(tp+tn)/(tp+fp+tn+fn);
% % %     [auc(flag,1),xx(flag,:),yy(flag,:),tp,tn,fp,fn]=AUC_cal(DEC,D_Label);
% end


    
    
    
    