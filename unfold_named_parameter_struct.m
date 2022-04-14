function output = unfold_named_parameter_struct(input_struct)
arguments
    input_struct struct {mustBeNonempty}
end
%unfold_parameter_options Generate multiple named parameter combinations 
% from a single struct that contains arrays
%   Input
%         input_struct: struct with scalar and non-scalar fields
%
%   Output
%         output: cell array where each element is one combination of
%         elements from non-scalar fields of input_struct
%
%   Example
%         my_struct.Color = ["red", "green"];
%         my_struct.LineWidth = 0.5:0.5:2;
%         out = unfold_named_parameter_struct(my_struct);
%         xy = rand(10,4);
%         axis = axes;
%         hold(axis, "on");
%         plot(axis, xy(:,1), xy(:,2), out{1}{:}) % 'Color','red','LineWidth',0.5
%         plot(axis, xy(:,3), xy(:,4), out{8}{:}) % 'Color','green','LineWidth',2
%         hold(axis, "off");
structs = expand_struct(input_struct);
output = arrayfun(@(s) namedargs2cell(s), structs, 'UniformOutput', false);


%% Helper functions
    function structs = expand_struct(original_struct)
        structs(1) = original_struct;
        names = fieldnames(original_struct);
        for field_number=1:length(names)
            name = names{field_number};
            structs = resolve_field(structs, name);
        end
    end


    function result = resolve_field(structs, field)
        if isscalar(structs(1).(field))
            result = structs;
            return
        else
            % For every field entry iterate over all structs. Example:
            % field = [1 2], then copy all original structs but set
            % field to 1. Next iteration do the same but set field to
            % 2.
            field_length = length(structs(1).(field));
            struct_count = length(structs);
            for i=1:field_length
                for j=1:struct_count
                    st_new = structs(j);
                    st_new.(field) = structs(j).(field)(i);
                    index = j + (i-1)*struct_count;
                    result(index) = st_new;
                end
            end
        end
    end
end