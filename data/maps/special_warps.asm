; Format: (size 2 bytes)
; 00: target map ID
; 01: which dungeon warp in the source map was used
DungeonWarpList:
	db SEAFOAM_ISLANDS_B1F, 1
	db SEAFOAM_ISLANDS_B1F, 2
	db SEAFOAM_ISLANDS_B2F, 1
	db SEAFOAM_ISLANDS_B2F, 2
	db SEAFOAM_ISLANDS_B3F, 1
	db SEAFOAM_ISLANDS_B3F, 2
	db SEAFOAM_ISLANDS_B4F, 1
	db SEAFOAM_ISLANDS_B4F, 2
	db VICTORY_ROAD_2F,     2
	db POKEMON_MANSION_1F,  1
	db POKEMON_MANSION_1F,  2
	db POKEMON_MANSION_2F,  3
	db -1 ; end


MACRO fly_warp
	event_displacement \1_WIDTH, \2, \3
	db ((\3) & $01) ;sub-block Y
	db ((\2) & $01) ;sub-block X
ENDM

DungeonWarpData:
	fly_warp SEAFOAM_ISLANDS_B1F, 18,  7
	fly_warp SEAFOAM_ISLANDS_B1F, 23,  7
	fly_warp SEAFOAM_ISLANDS_B2F, 19,  7
	fly_warp SEAFOAM_ISLANDS_B2F, 22,  7
	fly_warp SEAFOAM_ISLANDS_B3F, 18,  7
	fly_warp SEAFOAM_ISLANDS_B3F, 19,  7
	fly_warp SEAFOAM_ISLANDS_B4F,  4, 14
	fly_warp SEAFOAM_ISLANDS_B4F,  5, 14
	fly_warp VICTORY_ROAD_2F,     22, 16
	fly_warp POKEMON_MANSION_1F,  16, 14
	fly_warp POKEMON_MANSION_1F,  16, 14
	fly_warp POKEMON_MANSION_2F,  18, 14


MACRO special_warp_spec
	db \1
	fly_warp \1, \2, \3
	db \4
ENDM

NewGameWarp:
	special_warp_spec REDS_HOUSE_2F, 3, 6, REDS_HOUSE_2
TradeCenterPlayerWarp:
	special_warp_spec TRADE_CENTER,  3, 4, CLUB
TradeCenterFriendWarp:
	special_warp_spec TRADE_CENTER,  6, 4, CLUB
ColosseumPlayerWarp:
	special_warp_spec COLOSSEUM,     3, 4, CLUB
ColosseumFriendWarp:
	special_warp_spec COLOSSEUM,     6, 4, CLUB


MACRO fly_warp_spec
	db \1, 0
	dw \2
ENDM

FlyWarpDataPtr:
	fly_warp_spec PALLET_TOWN,            .PalletTown
	fly_warp_spec VIRIDIAN_CITY,          .ViridianCity
	fly_warp_spec VIRIDIAN_POKECENTER,    .ViridianPokecenter
	fly_warp_spec PEWTER_CITY,            .PewterCity
	fly_warp_spec PEWTER_POKECENTER,      .PewterPokecenter
	fly_warp_spec CERULEAN_CITY,          .CeruleanCity
	fly_warp_spec CERULEAN_POKECENTER,    .CeruleanPokecenter
	fly_warp_spec MT_MOON_POKECENTER,     .MtMoonPokecenter
	fly_warp_spec ROCK_TUNNEL_POKECENTER, .RockTunnelPokecenter
	fly_warp_spec LAVENDER_TOWN,          .LavenderTown
	fly_warp_spec LAVENDER_POKECENTER,    .LavenderPokecenter
	fly_warp_spec VERMILION_CITY,         .VermilionCity
	fly_warp_spec VERMILION_POKECENTER,   .VermilionPokecenter
	fly_warp_spec CELADON_CITY,           .CeladonCity
	fly_warp_spec CELADON_POKECENTER,     .CeladonPokecenter
	fly_warp_spec FUCHSIA_CITY,           .FuchsiaCity
	fly_warp_spec FUCHSIA_POKECENTER,     .FuchsiaPokecenter
	fly_warp_spec CINNABAR_ISLAND,        .CinnabarIsland
	fly_warp_spec CINNABAR_POKECENTER,    .CinnabarPokecenter
	fly_warp_spec INDIGO_PLATEAU,         .IndigoPlateau
	fly_warp_spec SAFFRON_CITY,           .SaffronCity
	fly_warp_spec SAFFRON_POKECENTER,     .SaffronPokecenter
	fly_warp_spec ROUTE_4,                .Route4
	fly_warp_spec ROUTE_10,               .Route10
	db -1 ; terminator

.PalletTown:          fly_warp PALLET_TOWN,            5,  6
.ViridianCity:        fly_warp VIRIDIAN_CITY,         23, 26
.ViridianPokecenter:  fly_warp VIRIDIAN_POKECENTER,    3,  7
.PewterCity:          fly_warp PEWTER_CITY,           13, 26
.PewterPokecenter:    fly_warp PEWTER_POKECENTER,      3,  7
.CeruleanCity:        fly_warp CERULEAN_CITY,         19, 18
.CeruleanPokecenter:  fly_warp CERULEAN_POKECENTER,    3,  7
.MtMoonPokecenter:    fly_warp MT_MOON_POKECENTER,     3,  7
.RockTunnelPokecenter: fly_warp ROCK_TUNNEL_POKECENTER, 3,  7
.LavenderTown:        fly_warp LAVENDER_TOWN,          3,  6
.LavenderPokecenter:  fly_warp LAVENDER_POKECENTER,    3,  7
.VermilionCity:       fly_warp VERMILION_CITY,        11,  4
.VermilionPokecenter: fly_warp VERMILION_POKECENTER,   3,  7
.CeladonCity:         fly_warp CELADON_CITY,          41, 10
.CeladonPokecenter:   fly_warp CELADON_POKECENTER,     3,  7
.FuchsiaCity:         fly_warp FUCHSIA_CITY,          19, 28
.FuchsiaPokecenter:   fly_warp FUCHSIA_POKECENTER,     3,  7
.CinnabarIsland:      fly_warp CINNABAR_ISLAND,       11, 12
.CinnabarPokecenter:  fly_warp CINNABAR_POKECENTER,    3,  7
.IndigoPlateau:       fly_warp INDIGO_PLATEAU,         9,  6
.SaffronCity:         fly_warp SAFFRON_CITY,           9, 30
.SaffronPokecenter:   fly_warp SAFFRON_POKECENTER,     3,  7
.Route4:              fly_warp ROUTE_4,               11,  6
.Route10:             fly_warp ROUTE_10,              11, 20
