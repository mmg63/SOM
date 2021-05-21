%% This is a code in matlab to implement SOM algorithm (Kohonen) to
% cluster 21 font bitmap image (7 character by 3 font type).
% All fonts is showed as 9*7 binary matrices. As mentioned in this code
% every fonts is represented by one vector 63 of 63 binary(1 and 0).

clear;
%% initalize values
% import Letters matrix
Letters_Vectors;

%---------- set initial values -----------------

% number of clusters
cluster_number = 25;

% max number of clusters is 21 (with random values)
% 25 clusters
[Row_sample_size, Col_sample_size] = size(samples);

w = rand(5,5,Col_sample_size);

%% initial learning rate is 0.6 with decreasing 0.5 at each 100

% initial radius (topological architecture)
radius = 3;

% iteration(epocs) alpha(t+1) = 0.5*alpha(t)
alpha = 0.6;

%  --------------------------------------------

reset_couter_for_alpha = 0;
% initial learning rate is 0.6 with decreasing 0.5 at each 140
% train the clusters
for iteration = 1 : 900
    reset_couter_for_alpha = reset_couter_for_alpha + 1; 
    for sample_X = 1 : Row_sample_size 

        % calculate distances by Euclidean distance measurance
        [m_indice_row, m_indice_col] = ...
            minEuclidient(sample_X, samples, cluster_number,w);

        % update the weights of the closest cluster agent to coming closer to its cluster
        w(m_indice_row, m_indice_col,:) = ...
            reshape(w(m_indice_row, m_indice_col, :),1,63) + ...
            (alpha * (samples(sample_X,:) - ...
            reshape(w(m_indice_row, m_indice_col,:),1,63)));

        if (m_indice_row > 1)
            w(m_indice_row - 1, m_indice_col, :) = ...
                reshape(w(m_indice_row - 1, m_indice_col, :),1,63) + ...
                (alpha * (samples(sample_X,:) - ...
                reshape(w(m_indice_row - 1, m_indice_col,:),1,63)));
        end
        
        if (m_indice_row < 5)
            w(m_indice_row + 1, m_indice_col, :) = ...
                reshape(w(m_indice_row + 1, m_indice_col, :),1,63) + ...
                (alpha * (samples(sample_X,:) - ...
                reshape(w(m_indice_row + 1, m_indice_col, :),1,63)));
        end
        
         if (m_indice_col > 1)
            w(m_indice_row, m_indice_col - 1, :) = ...
                reshape(w(m_indice_row, m_indice_col - 1, :),1,63) + ...
                (alpha * (samples(sample_X,:) - ...
                reshape(w(m_indice_row, m_indice_col - 1, :),1,63)));
        end
       
         if (m_indice_col < 5)
            w(m_indice_row, m_indice_col + 1, :) = ...
                reshape(w(m_indice_row, m_indice_col + 1, :),1,63) + ...
                (alpha * (samples(sample_X,:) - ...
                reshape(w(m_indice_row, m_indice_col + 1, :),1,63)));
        end
    end
    
    if ((reset_couter_for_alpha == 140))
        alpha = 0.5 * alpha;
        reset_couter_for_alpha = 0;
    end
    if ((iteration == 200)|| (iteration == 500))
        radius = radius - 1;
    end
end

% what samples blong to what cluster
output = zeros(5, 5,21);

for pattern_id = 1 : Row_sample_size
    [min_row,min_col] = ...
        minEuclidient(pattern_id, samples, cluster_number, w);
    output(min_row,min_col,pattern_id) = pattern_id;
end
output


%% clear temporary variables
clear alpha;
clear ans;
clear radius;
clear reset_couter_for_alpha;
clear iteration;



