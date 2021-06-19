function [Neg_set] = ran_select(Unlabel_set,z_pos,mode)
%RAN_SELECT 此处显示有关此函数的摘要
%   此处显示详细说明
if mode==1
    
    T=[];
    zu=size(Unlabel_set,1);
    for i=1:z_pos
        t=ceil(zu*rand(1,1));
        T=[T;t];
    end
    Neg_set=Unlabel_set(T,:);
elseif mode==2
    zu=size(Unlabel_set,1);
    ra=randperm(zu);
    Unlabel_set=Unlabel_set(ra,:);
    Neg_set=Unlabel_set(1:z_pos,:);
end

end

