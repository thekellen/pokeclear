_CinnabarLabFossilRoomScientist1Text::
	text "Hiya!"

	para "I am important"
	line "doctor!"

	para "I study here rare"
	line "antique candy!"

	para "You! Have you an"
	line "antique for me?"
	prompt

_CinnabarLabFossilRoomScientist1NoFossilsText::
	text "No! Is too bad!"
	done

_CinnabarLabFossilRoomScientist1GoForAWalkText::
	text "I take a little"
	line "time!"

	para "You go for walk a"
	line "little while!"
	done

_CinnabarLabFossilRoomScientist1FossilIsBackToLifeText::
	text "Where were you?"

	para "Your antique is"
	line "restored!"

	para "It was @"
	text_ram wStringBuffer
	text_start
	line "like I think!"
	prompt

_CinnabarLabFossilRoomScientist1SeesFossilText::
	text "Oh! That is"
	line "@"
	text_ram wNameBuffer
	text "!"

	para "It is antique of"
	line "@"
	text_ram wStringBuffer
	text ", a"
	cont "candy that is very"
	cont "rare to find!"

	para "My Restoration"
	line "Machine will make"
	cont "that candy fresh"
	cont "again!"
	done

_CinnabarLabFossilRoomScientist1TakesFossilText::
	text "So! You hurry and"
	line "give me that!"

	para "<PLAYER> handed"
	line "over @"
	text_ram wNameBuffer
	text "!"
	prompt

_CinnabarLabFossilRoomScientist1GoForAWalkText2::
	text "I take a little"
	line "time!"

	para "You go for walk a"
	line "little while!"
	done

_CinnabarLabFossilRoomScientist1ComeAgainText::
	text "Aiyah! You come"
	line "again!"
	done
