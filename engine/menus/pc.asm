ActivatePC::
	call SaveScreenTilesToBuffer2
	ld a, SFX_TURN_ON_PC
	call PlaySound
	ld hl, TurnedOnPC1Text
	call PrintText
	call WaitForSoundToFinish
	ld hl, wMiscFlags
	set BIT_USING_GENERIC_PC, [hl]
	call LoadScreenTilesFromBuffer2
	call Delay3
PCMainMenu:
	farcall DisplayPCMainMenu
	ld hl, wMiscFlags
	set BIT_NO_MENU_BUTTON_SOUND, [hl]
	call HandleMenuInput
	bit B_PAD_B, a
	jp nz, LogOff
	; POKECLEAR: Simplified menu - only BILL's PC (items), optional OAK's PC, and LOG OFF
	ld a, [wMaxMenuItem]
	cp 1
	jr nz, .hasOaksPC ; if not 1 menu item (just BILL's PC + LOG OFF)
	ld a, [wCurrentMenuItem]
	and a
	jp z, BillsPC ; menu item 0 = BILL's PC (item storage)
	jp LogOff     ; menu item 1 = LOG OFF
.hasOaksPC
	cp 2
	jr nz, .hasLeaguePC ; if not 2 menu items (BILL's PC + OAK's PC + LOG OFF)
	ld a, [wCurrentMenuItem]
	and a
	jp z, BillsPC ; menu item 0 = BILL's PC (item storage)
	cp 1
	jp z, OaksPC  ; menu item 1 = OAK's PC
	jp LogOff     ; menu item 2 = LOG OFF
.hasLeaguePC
	; 3 menu items (BILL's PC + OAK's PC + LEAGUE + LOG OFF)
	ld a, [wCurrentMenuItem]
	and a
	jp z, BillsPC    ; menu item 0 = BILL's PC (item storage)
	cp 1
	jp z, OaksPC     ; menu item 1 = OAK's PC
	cp 2
	jp z, PKMNLeague ; menu item 2 = PKMN LEAGUE
	jp LogOff        ; menu item 3 = LOG OFF
OaksPC:
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
	farcall OpenOaksPC
	jr ReloadMainMenu
PKMNLeague:
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
	farcall PKMNLeaguePC
	jr ReloadMainMenu
BillsPC:
	ld a, SFX_ENTER_PC
	call PlaySound
	call WaitForSoundToFinish
	CheckEvent EVENT_MET_BILL
	jr nz, .billsPC ;if you've met bill, use that bill's instead of someone's
	ld hl, AccessedSomeonesPCText
	jr .printText
.billsPC
	ld hl, AccessedBillsPCText
.printText
	call PrintText
	farcall PlayerPC
ReloadMainMenu:
	xor a
	ld [wDoNotWaitForButtonPressAfterDisplayingText], a
	call ReloadMapData
	call UpdateSprites
	jp PCMainMenu
LogOff:
	ld a, SFX_TURN_OFF_PC
	call PlaySound
	call WaitForSoundToFinish
	ld hl, wMiscFlags
	res BIT_USING_GENERIC_PC, [hl]
	res BIT_NO_MENU_BUTTON_SOUND, [hl]
	ret

TurnedOnPC1Text:
	text_far _TurnedOnPC1Text
	text_end

AccessedBillsPCText:
	text_far _AccessedBillsPCText
	text_end

AccessedSomeonesPCText:
	text_far _AccessedSomeonesPCText
	text_end

AccessedMyPCText:
	text_far _AccessedMyPCText
	text_end

; removes one of the specified item ID [hItemToRemoveID] from bag (if existent)
RemoveItemByID::
	ld hl, wBagItems
	ldh a, [hItemToRemoveID]
	ld b, a
	xor a
	ldh [hItemToRemoveIndex], a
.loop
	ld a, [hli]
	cp -1 ; reached terminator?
	ret z
	cp b
	jr z, .foundItem
	inc hl
	ldh a, [hItemToRemoveIndex]
	inc a
	ldh [hItemToRemoveIndex], a
	jr .loop
.foundItem
	ld a, $1
	ld [wItemQuantity], a
	ldh a, [hItemToRemoveIndex]
	ld [wWhichPokemon], a
	ld hl, wNumBagItems
	jp RemoveItemFromInventory
