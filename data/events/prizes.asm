PrizeDifferentMenuPtrs:
	dw PrizeMenuItems1Entries, PrizeMenuItems1Cost
	dw PrizeMenuItems2Entries, PrizeMenuItems2Cost
	dw PrizeMenuTMsEntries,  PrizeMenuTMsCost

NoThanksText:
	db "NO THANKS@"

PrizeMenuItems1Entries:
	db PROTEIN
	db MAX_POTION
	db RARE_CANDY
	db "@"

PrizeMenuItems1Cost:
	bcd2 1000
	bcd2 1500
	bcd2 2000
	db "@"

PrizeMenuItems2Entries:
	db PP_UP
	db ELIXER
	db MAX_ELIXER
	db "@"

PrizeMenuItems2Cost:
	bcd2 3000
	bcd2 4000
	bcd2 5000
	db "@"

PrizeMenuTMsEntries:
	db TM_DRAGON_RAGE
	db TM_HYPER_BEAM
	db TM_SUBSTITUTE
	db "@"

PrizeMenuTMsCost:
	bcd2 3300
	bcd2 5500
	bcd2 7700
	db "@"
