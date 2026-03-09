clear all

cap cd "D:\Dropbox\STATA - VCONTROL"



net install vcontrol, from("D:\Dropbox\STATA - VCONTROL\installation") replace
*help vcontrol

vcontrol tidytuesday


return list


vcontrol tidytuesday, update replace
