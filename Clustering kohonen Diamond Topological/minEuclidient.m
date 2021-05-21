function [min_indice_row, min_indice_col ] = ...
    minEuclidient(patternID, mx_Pattern, clusterNumber, mx_Cluster )
    
    
    [cluster_x,cluster_y, cluster_z] = size(mx_Cluster);
    D = zeros(cluster_x,cluster_y);
    % calculate distances by Euclidean distance measurance
    for clusterID_row = 1 : cluster_x
        for clusterID_col = 1 : cluster_y
            temp = (reshape(mx_Cluster(clusterID_row, clusterID_col,:),1,63) - mx_Pattern(patternID,:)).^2;
            D(clusterID_row,clusterID_col) = sum(temp);
    
        end
    end
    % find minimum and indices of the minimum value in matrix
    [minvalue_col, min_indices] = min(D);
    [minvalue_row, min_indice_col] = min(min(D));
    min_indice_row = min_indices(min_indice_col);
    
    clear temp;
    
end

