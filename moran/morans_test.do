*shp2dta using s_06se12, database(usdb) coordinates(uscoord) genid(id)

use mcaid.dta , clear
merge 1:m NAME using  usdb.dta

duplicates drop NAME , force 

rename *, lower

summarize lat
scalar lat = r(max) - r(min)
su lon 
scalar lat = r(max) - r(min)
scalar distance = sqrt( lat^2 + lon^2) 

di distance

*spmap experimental using uscoord, id(id) fcolor(Blues)  ndlabel("NO DATA") clmethod(unique)

spatwmat , name(wtm)  xcoord(lat) ycoord(lon) band(0 500) standardize

encode status , ge(stt)

ge mcaid_expansion = (stt>1)

spatgsa  mcaid_expansion , weights(wtm) moran twotail
