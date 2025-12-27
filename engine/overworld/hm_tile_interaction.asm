; HM tile interaction system for Pokemon-less hack
; Allows using Cut/Surf/Strength by pressing A on tiles with required badges

CheckHMTileInteraction_::
; Check if player pressed A on a tile that can be interacted with via HM moves
; Returns: carry set if an HM move was triggered
	; First get the tile in front of player
	predef GetTileAndCoordsInFrontOfPlayer

	; Try Cut
	call TryCutTile
	ret c

	; Try Surf
	call TrySurfTile
	ret c

	; Try Strength (boulder sprite check)
	call TryStrengthTile
	ret c

	; No HM triggered
	and a
	ret

TryCutTile:
; Check if tile is cuttable and player has Cascade Badge
	ld a, [wCurMapTileset]
	and a ; OVERWORLD
	jr z, .overworld
	cp GYM
	jr nz, .notCuttable
	ld a, [wTileInFrontOfPlayer]
	cp $50 ; gym cut tree
	jr z, .isCuttable
	jr .notCuttable
.overworld
	ld a, [wTileInFrontOfPlayer]
	cp $3d ; cut tree
	jr z, .isCuttable
	cp $52 ; grass
	jr z, .isCuttable
.notCuttable
	and a
	ret
.isCuttable
	; Check badge
	ld a, [wObtainedBadges]
	bit BIT_CASCADEBADGE, a
	jr z, .notCuttable
	; Use Cut
	predef UsedCut
	ld a, [wActionResultOrTookBattleTurn]
	and a
	jr z, .notCuttable
	scf
	ret

TrySurfTile:
; Check if tile is water and player has Soul Badge
	ld a, [wWalkBikeSurfState]
	cp 2 ; already surfing?
	jr z, .notWater

	call IsNextTileShoreOrWater
	jr c, .notWater

	; Check badge
	ld a, [wObtainedBadges]
	bit BIT_SOULBADGE, a
	jr z, .notWater

	; Check if surfing allowed
	farcall IsSurfingAllowed
	ld hl, wStatusFlags1
	bit BIT_SURF_ALLOWED, [hl]
	res BIT_SURF_ALLOWED, [hl]
	jr z, .notWater

	; Use Surf
	ld a, SURFBOARD
	ld [wCurItem], a
	ld [wPseudoItemID], a
	call UseItem
	ld a, [wActionResultOrTookBattleTurn]
	and a
	jr z, .notWater
	scf
	ret
.notWater
	and a
	ret

TryStrengthTile:
; Check if there's a boulder sprite in front and player has Rainbow Badge
	; Check badge first
	ld a, [wObtainedBadges]
	bit BIT_RAINBOWBADGE, a
	jr z, .noBoulder

	; Check for boulder sprite
	xor a
	ldh [hSpriteIndex], a
	call IsSpriteInFrontOfPlayer
	ldh a, [hSpriteIndex]
	and a
	jr z, .noBoulder

	; Check if it's a boulder
	call GetSpriteMovementByte2Pointer
	ld a, [hl]
	cp BOULDER_MOVEMENT_BYTE_2
	jr nz, .noBoulder

	; Activate Strength
	predef PrintStrengthText
	scf
	ret
.noBoulder
	and a
	ret
