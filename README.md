Generate multiple named parameter combinations from a single struct that contains arrays.

Example:
```my_struct.Color = ["red", "green"];
my_struct.LineWidth = 0.5:0.5:2;
out = unfold_named_parameter_struct(my_struct);
xy = rand(10,4);
axis = axes;
hold(axis, "on");
plot(axis, xy(:,1), xy(:,2), out{1}{:}) % 'Color','red','LineWidth',0.5
plot(axis, xy(:,3), xy(:,4), out{8}{:}) % 'Color','green','LineWidth',2
hold(axis, "off");
```
