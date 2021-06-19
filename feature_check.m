filepath_drug=fullfile('/Users','xiaozhu0788','Desktop','TEST CODE',...
    'COMPARISON','drug_descriptors');
filepath_target=fullfile('/Users','xiaozhu0788','Desktop','TEST CODE',...
    'COMPARISON','target_descriptors');

D_list=cell(12,1);zDlist=size(D_list,1);
D_list{1,1}='Atom_count';
D_list{2,1}='Atompair_finger';
D_list{3,1}='Estate_finger';
D_list{4,1}='extend_finger';
D_list{5,1}='fingerprint';
D_list{6,1}='Graphonly_finger';
D_list{7,1}='klek_count';
D_list{8,1}='Klekotroth_finger';
D_list{9,1}='Maccs_finger';
D_list{10,1}='pubchem_finger';
D_list{11,1}='sub_count';
D_list{12,1}='substru_finger';

T_list=cell(6,1);zTlist=size(T_list,1);
T_list{1,1}='AAC';
T_list{2,1}='AAP';
T_list{3,1}='APAAC';
T_list{4,1}='CTD';
T_list{5,1}='DPC';
T_list{6,1}='QSO';