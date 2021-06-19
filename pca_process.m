function [fea_T,MEAN_SET,coef] = pca_process(MEAN_SET,thre)
if thre==0      % original features
    fea_T=size(MEAN_SET,2);
    MEAN_SET=MEAN_SET;
    coef=0;
elseif thre==1  % new features after pca
    [coef,score,latent]=pca(MEAN_SET,'Centered','off');
    MEAN_SET=score;
    fea_T=size(MEAN_SET,2);
else
    % pca process with "thre"
    [coef,score,latent]=pca(MEAN_SET,'Centered','off');
    MEAN_SET=score;
    sum_latent=sum(latent);
    z_latent=size(latent,1);
    Q=0;
    fea_T=0;
    for i=1:z_latent
        if Q/sum_latent>=thre
            fea_T=i;        % 1~fea_T is the princomp part of the all the features
            break;
        else
            Q=Q+latent(i,1);
        end
    end

end

