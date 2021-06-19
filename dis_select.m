function [NEG,seq] = dis_select(POS,Unlabel,mode)
%DIS_SELECT 此处显示有关此函数的摘要
%   此处显示详细说明

    [z,s]=size(POS);
    zu=size(Unlabel,1);
    if mode==1
        y=1:s;
    elseif mode==2
        y=2:s;
    end
% % %     t=2*z;
% % %     qs=ceil(zu/t);
% % % %     Q=cell(1,qs);
% % %     cen=mean(POS(:,y));
% % %     seq=[];
% % %     for i=1:qs
% % %         Q=Unlabel(((i-1)*t+1):min(zu,i*t),:);
% % %         [m,n]=size(Q);
% % %         T=zeros(m,2);
% % %         for j=1:m
% % %             T(j,:)=[Q(j,1),sqrt(sum((Q(j,y)-cen).^2))];
% % %         end
% % %         [p,q]=sort(T(:,2));
% % %         T=T(q,:);
% % %         if m<=z
% % %             seq=[seq;T];
% % %         else
% % %             seq=[seq;T((m-z+1):m,:)];
% % %         end
% % %     end
% % %     [p,q]=sort(seq(:,2));
% % %     seq=seq(q,:);
% % %     [m,n]=size(seq);
% % %     NEG=[seq((m-z+1):m,1),Unlabel((m-z+1):m,y)];
% % %     
% % %     
    cen=mean(POS(:,y));
    T=zeros(zu,2);
    for i=1:zu
        T(i,1)=i;
        T(i,2)=sqrt(sum((Unlabel(i,y)-cen).^2));
    end
    [p,q]=sort(T(:,2));
    T=T(q,:);
    seq=q((zu-z+1):zu);
    NEG=[seq,Unlabel(seq,y)];
end

