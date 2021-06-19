

DRUG_list_ORI=importdata('DT_pairs_D.csv');
DRUG_list=unique(DRUG_list_ORI);

TARGET_list_ORI=importdata('DT_pairs_T.csv');
TARGET_list=unique(TARGET_list_ORI);

z_drug=size(DRUG_list,1);
z_target=size(TARGET_list,1);

Drug=DRUG_list;
Target=TARGET_list;

descriptor_drug=importdata('Drug_0428.csv');      % EState-fingerprinter for drug
descriptor_target=importdata('AAseq.csv');  % APAAC for target

z_dim_drug=size(descriptor_drug.data,2);    % number of dimension with drug
z_dim_target=size(descriptor_target.data,2);    % number of dimension with target

z_pos=size(DRUG_list_ORI,1);
z_unlabel=z_drug*z_target-z_pos;


DATA=zeros(z_target,z_drug);
for i=1:z_pos
    loc_D=find(strcmp(DRUG_list,DRUG_list_ORI{i,1}));
    loc_T=find(strcmp(TARGET_list,TARGET_list_ORI{i,1}));
%     if DATA(loc_T,loc_D)==1
%         m=0;
%     end
    DATA(loc_T,loc_D)=1;
   
end
z_pos=sum(DATA(:));

Pos_set=zeros(z_pos,z_dim_drug+z_dim_target+1);
Unlabel_set=zeros(z_unlabel,z_dim_drug+z_dim_target+1);
k1=1;k2=1;
TA_DR_UN=cell(z_unlabel,2);
TA_DR_PO=cell(z_pos,2);
for i=1:z_target
    loc_t=find((strcmp(descriptor_target.textdata(:,1),Target{i,1})));
    A=descriptor_target.data(loc_t-1,:);
    for j=1:z_drug
        loc_d=find(strcmp(descriptor_drug.textdata(:,1),Drug{j,1}));
        B=descriptor_drug.data(loc_d-1,:);
        if DATA(i,j)==1
            Pos_set(k1,:)=[k1,B,A];
            TA_DR_PO{k1,1}=Target{i,1};
            TA_DR_PO{k1,2}=Drug{j,1};
            k1=k1+1;
        else
            Unlabel_set(k2,:)=[k2,B,A];
            TA_DR_UN{k2,1}=Target{i,1};
            TA_DR_UN{k2,2}=Drug{j,1};
            k2=k2+1;
        end
    end
end
dim=z_dim_drug+z_dim_target;
% toc



% for i=1:z_drug
%     loc=find(strcmp(descriptor_drug.textdata(:,1),['AUTOGEN_',Drug{i,1}]));
%     Drug{i,2}=descriptor_drug.data(loc-1,:);
% end
% for j=1:z_target
%     loc=find(strcmp(descriptor_target.textdata(:,1),Target{j,1}));
%     Target{j,2}=descriptor_target.data(loc-1,:);
% end
% 
% 
% z_pos=size(Ori_pos,1);
% for i=1:z_pos
%     Pos_set(i,:)=[i,Drug{Ori_pos(i,1),2},Target{Ori_pos(i,2),2}];
% end
% z_unl=size(Ori_neg,1);
% for i=1:z_unl
%     Unlabel_set(i,:)=[i,Drug{Ori_neg(i,1),2},Target{Ori_neg(i,2),2}];
% % end
% save([NAME,'_pos_',num2str(dr_i),'_',num2str(ta_i)],'Pos_set');
% % A=Unlabel_set(1:40000,:);
% % B=Unlabel_set(40001:80000,:);
% % C=Unlabel_set(80001:120000,:);
% % D=Unlabel_set(120001:160000,:);
% % E=Unlabel_set(160001:200000,:);
% % F=Unlabel_set(200001:240000,:);
% % G=Unlabel_set(240001:292554,:);
% 
% save([NAME,'_unlabel_',num2str(dr_i),'_',num2str(ta_i)],'Unlabel_set');
