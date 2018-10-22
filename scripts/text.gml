/// scr_showtext(Font, Outline, String, Id, Color, Outline Color)


i = instance_create(x,y,obj_showText_SIDEFEATURE);  // Create the Damage Box
i.fnt = argument0;                      // Font To display
i.outline = argument1;                  // Outline Type (see below for options)
i.str = string(argument2);              // Pass in the string to show
i.myid = argument3;                     // Position The string above an object
i.color = argument4;                    // Give the string a color
i.outColor = argument5;                 // Color to outline the text in

/*
OUTLINE TYPES:
0 = No Outline
1 = Outline on bottom ONLY
2 = Outline on top ONLY
3 = Outline on left ONLY
4 = Outline on right ONLY
5 = Full Outline

*/
