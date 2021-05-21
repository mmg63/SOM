%% This is a code in matlab to implement SOM algorithm (Kohonen) to
% cluster 21 font bitmap image (7 character by 3 font type).
% All fonts is showed as 9*7 binary matrices. As mentioned in this code
% every fonts is represented by one vector 63 of 63 binary(1 and 0).

clear;

%% initalize values
% import Letters matrix
Letters_Vectors;

% number of clusters
cluster_number = 25;

% max number of clusters is 21 (with random values)
% 21 clusters
[Row_sample_size, Col_sample_size] = size(samples);

% initial cluster point in dim of 63.
w = rand(cluster_number, Col_sample_size);

% initial iteration(epocs) alpha(t+1) = 0.5*alpha(t)
alpha = 0.6;

%% initial learning rate is 0.6 with decreasing 0.5 at each 100
% train the clusters
reset_couter_for_alpha = 0;

for iteration = 1 : 100
    reset_couter_for_alpha = reset_couter_for_alpha + 1; 
    for sample_X = 1 : Row_sample_size 

        % calculate distances by Euclidean distance measurance
        [m_min,m_indice] = ...
            minEuclidient(sample_X, samples, cluster_number,w);

        % update the weights of the closest cluster agent to coming
        % closer to its cluster
        w(m_indice,:) = ...
            w(m_indice,:) + (alpha * (samples(sample_X,:) - w(m_indice,:)));

    end
    if ((reset_couter_for_alpha == 30))
        alpha = 0.5 * alpha;
        reset_couter_for_alpha = 0;
    end
end

% what samples blong to what cluster
output = zeros(21, 2);

for pattern_id = 1 : Row_sample_size
    [m_min, m_indice] = ...
        minEuclidient(pattern_id, samples, cluster_number, w);
    output(pattern_id,1) = pattern_id;
    output(pattern_id,2)= m_indice;
end
transpose(pattern)
output(:,2)

%% clear temporary variables
clear alpha;
clear ans;
clear radius;
clear reset_couter_for_alpha;
clear iteration;

% fig1 = figure();
% 
% [x,y] = getpts(fig1)



