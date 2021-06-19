

% clear


dr_i=3;
ta_i=3;

thre=1;

fold=5;

dis=0;  % dis==1 indicate distance-based negative screening
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
    Neg_set=Neg_set(:,2:160);

end


RESULT=[];
H=zeros(100,1);
% tic
for flag=1
    flag
% x=randperm(z_pos);
% y=randperm(z_unlabel);
for c=8%-10:10
    c;
    for gamma=2%-10:10
% gamma
model_generate_0618;

x=randperm(z_pos);
y=randperm(z_unlabel);

vali_size=size(POST,1);

x=x(1:vali_size);
y=y(1:vali_size);
X=Pos_set(x,:);
Y=Unlabel_set(y,:);

Vali=[X;Y];
% Vali=TEST;
VLabel=[ones(vali_size,1);zeros(vali_size,1)];

Vpre=cell(5,1);Vacc=cell(5,1);Vdec=cell(5,1);
VAUC=zeros(5,1);
VF1_score=zeros(5,1);
Vprecision=zeros(5,1);
Vrecall=zeros(5,1);
VMCC=zeros(5,1);
VACC=zeros(5,1);
xx0=zeros(1,10001);
yy0=zeros(1,10001);
for q=1:5
    [Vpre{q,1},Vacc{q,1},Vdec{q,1}]=svmpredict(VLabel,Vali,model{q,1},strcat(['-q']));
    [VAUC(q,1),xx,yy,tp1,tn1,fp1,tn1]=AUC_cal(Vdec{q,1},VLabel);
    [VF1_score(q,1),Vprecision(q,1),Vrecall(q,1),VMCC(q,1)]=F1_score_para(Vpre{q,1},VLabel);
    VACC(q,1)=Vacc{q,1}(1,1)/100;
    xx0=xx0+xx;
    yy0=yy0+yy;
end
xx0=xx0/5;
yy0=yy0/5;
RESULT=[RESULT;[c,gamma,mean(VAUC),mean(VF1_score),mean(Vprecision),mean(Vrecall),mean(VMCC)],mean(VACC)];
    end
end
H(flag,1)=VAUC(1,1);%mean(VAUC);
end
%     toc

% % % pre_unl=cell(5,1);acc_unl=cell(5,1);dec_unl=cell(5,1);
% % % for i=1:5
% % % [pre_unl{i,1},acc_unl{i,1},dec_unl{i,1}]=svmpredict(zeros(z_unlabel,1),Unlabel_set,model{i,1},strcat(['-q']));
% % % end
% % % dec=zeros(z_unlabel,1);
% % % for i=1:5
% % % dec=dec+dec_unl{i,1};
% % % end
% % % dec=dec/5;
% % % 
% % % [a,b]=sort(dec);
% % % M_UNL=UNL_DT_pair(b,:);
% % % Q_UNL=M_UNL((z_unlabel-9):z_unlabel,:)
% % % 
% % % save([NAME,'_unlabel_dis_dec'],'dec_unl');
% % % save([NAME,'_unlabel_dis_acc'],'acc_unl');
% % % save([NAME,'_unlabel_dis_pre'],'pre_unl');
% % % save([NAME,'_DT_pair_dis'],'Q_UNL');
% % % save([NAME,'_DT_pair_name'],'UNL_DT_pair');
plot(xx0,yy0);
