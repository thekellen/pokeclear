GetMonName::
	push hl
	ldh a, [hLoadedROMBank]
	push af
	ld a, BANK(MonsterNames)
	ldh [hLoadedROMBank], a
	ld [rROMB], a
	ld a, [wNamedObjectIndex]
	dec a
	ld hl, MonsterNames
	ld c, NAME_LENGTH - 1
	ld b, 0
	call AddNTimes
	ld de, wNameBuffer
	push de
	ld bc, NAME_LENGTH - 1
	call CopyData
	ld hl, wNameBuffer + NAME_LENGTH - 1
	ld [hl], '@'
	pop de
	pop af
	ldh [hLoadedROMBank], a
	ld [rROMB], a
	pop hl
	ret

GetItemName::
; given an item ID at [wNamedObjectIndex], store the name of the item in wNameBuffer
	push hl
	push bc
	ld a, [wNamedObjectIndex]
	cp HM01 ; is this a TM/HM?
	jr nc, .Machine

	ld [wNameListIndex], a
	ld a, ITEM_NAME
	ld [wNameListType], a
	ld a, BANK(ItemNames)
	ld [wPredefBank], a
	call GetName
	jr .Finish

.Machine
	call GetMachineName
.Finish
	ld de, wNameBuffer
	pop bc
	pop hl
	ret

GetMachineName::
; copies the name of the TM/HM in [wNamedObjectIndex] to wNameBuffer
	push hl
	push de
	push bc
	ld a, [wNamedObjectIndex]
	push af
	cp TM01 ; is this a TM? [not HM]
	jr nc, .WriteTMName
; if HM, write HM name with number
	add NUM_HMS
	ld [wNamedObjectIndex], a
.WriteTMName
	ld hl, TechnicalPrefix
	ld bc, 3
.WriteName
	ld de, wNameBuffer
	call CopyData
	ld a, [wNamedObjectIndex]
	sub TM01 - 1
	ld b, '0'
.FirstDigit
	sub 10
	jr c, .SecondDigit
	inc b
	jr .FirstDigit
.SecondDigit
	add 10
	push af
	ld a, b
	ld [de], a
	inc de
	pop af
	ld b, '0'
	add b
	ld [de], a
	inc de
	ld a, '@'
	ld [de], a
	pop af
	ld [wNamedObjectIndex], a
	pop bc
	pop de
	pop hl
	ret

TechnicalPrefix::
	db "M&M"

; sets carry if item is HM, clears carry if item is not HM
; Input: a = item ID
IsItemHM::
	cp HM01
	jr c, .notHM
	cp TM01
	ret
.notHM
	and a
	ret

; sets carry if move is an HM, clears carry if move is not an HM
; Input: a = move ID
IsMoveHM::
	ld hl, HMMoves
	ld de, 1
	jp IsInArray

HMMoves::
INCLUDE "data/moves/hm_moves.asm"

GetMoveName::
	push hl
	ld a, MOVE_NAME
	ld [wNameListType], a
	ld a, [wNamedObjectIndex]
	ld [wNameListIndex], a
	ld a, BANK(MoveNames)
	ld [wPredefBank], a
	call GetName
	ld de, wNameBuffer
	pop hl
	ret
