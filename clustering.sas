data grocery;
infile "/home/zlei50/STAT 448/grocersales2009.csv" dlm="," missover firstobs=2;
input Beer Blades CarbonatedBeverages Cigarette Coffee
ColdCereal Deodorant Diapers FacialTissue FrozenDinner
FrozenPizza Hotdog HouseCleaner LaundryDetergent
MargarineButter Mayonnaise Milk MustardKetchup
PaperTowel PeanutButter Photography Razors SaltySnack
Shampoo Soup SpaghettiSauce SugarSubstitute ToiletTissue
Toothbrush Toothpaste Yogurt;
run;

proc sgscatter data = grocery ;
matrix Beer CarbonatedBeverages Cigarette Diapers FacialTissue FrozenDinner FrozenPizza Hotdog HouseCleaner Mayonnaise PeanutButter Photography Razors SugarSubstitute;
run;

proc corr data=grocery ;
var Beer CarbonatedBeverages Cigarette Diapers FacialTissue FrozenDinner FrozenPizza Hotdog HouseCleaner Mayonnaise PeanutButter Photography Razors SugarSubstitute;
run;

proc univariate data=grocery ;
var Beer CarbonatedBeverages Cigarette Diapers FacialTissue FrozenDinner FrozenPizza Hotdog HouseCleaner Mayonnaise PeanutButter Photography Razors SugarSubstitute ;
ods select ExtremeObs;
run;

proc sgscatter data=grocery;
matrix Beer CarbonatedBeverages;
Run;

proc sgscatter data=grocery;
matrix Diapers FacialTissue;
Run;
