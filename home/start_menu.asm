DisplayStartMenu::
	ld a, BANK(StartMenu_Item)
	ldh [hLoadedROMBank], a
	ld [rROMB], a
	ld a, [wWalkBikeSurfState] ; walking/biking/surfing
	ld [wWalkBikeSurfStateCopy], a
	ld a, SFX_START_MENU
	call PlaySound

RedisplayStartMenu::
	farcall DrawStartMenu
	farcall PrintSafariZoneSteps ; print Safari Zone info, if in Safari Zone
	call UpdateSprites
.loop
	call HandleMenuInput
	ld b, a
; check if Up pressed
	bit B_PAD_UP, a
	jr z, .checkIfDownPressed
	ld a, [wCurrentMenuItem] ; menu selection
	and a
	jr nz, .loop
	ld a, [wLastMenuItem]
	and a
	jr nz, .loop
; if the player pressed tried to go past the top item, wrap around to the bottom
	ld a, 4 ; there are 5 menu items, so the max index is 4
.wrapMenuItemId
	ld [wCurrentMenuItem], a
	call EraseMenuCursor
	jr .loop
.checkIfDownPressed
	bit B_PAD_DOWN, a
	jr z, .buttonPressed
; if the player pressed tried to go past the bottom item, wrap around to the top
	ld a, [wCurrentMenuItem]
	ld c, 5 ; there are 5 menu items
.checkIfPastBottom
	cp c
	jr nz, .loop
; the player went past the bottom, so wrap to the top
	xor a
	ld [wCurrentMenuItem], a
	call EraseMenuCursor
	jr .loop
.buttonPressed ; A, B, or Start button pressed
	call PlaceUnfilledArrowMenuCursor
	ld a, [wCurrentMenuItem]
	ld [wBattleAndStartSavedMenuItem], a ; save current menu selection
	ld a, b
	and PAD_B | PAD_START ; was the Start button or B button pressed?
	jp nz, CloseStartMenu
	call SaveScreenTilesToBuffer2 ; copy background from wTileMap to wTileMapBackup2
	ld a, [wCurrentMenuItem]
.displayMenuItem
	cp 0
	jp z, StartMenu_Item
	cp 1
	jp z, StartMenu_TrainerInfo
	cp 2
	jp z, StartMenu_SaveReset
	cp 3
	jp z, StartMenu_Option

; EXIT falls through to here
CloseStartMenu::
	call Joypad
	ldh a, [hJoyPressed]
	bit B_PAD_A, a
	jr nz, CloseStartMenu
	call LoadTextBoxTilePatterns
	jp CloseTextDisplay
