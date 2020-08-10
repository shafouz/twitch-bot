require 'json'
# https://decapi.me/bttv/emotes/arcadum
bttv = %w[HeckPls gloryDab gloryEZ gloryGoogly gloryBobble gloryBang Fiyayaball OneMoPls TootNodders TootNopers POGGERS OMEGALUL PepePls Clap headBang HYPERHEADBANG PepeHands gachiGASM Pepega KKool Thonk widepeepoHappyRightHeart pepeJAM monkaHmm COGGERS gachiBASS EZ pepeD ricardoFlick pepeLaugh blobDance monkaSHAKE nymnCorn weirdChamp peepoRun Libido rooSlam WideBall peepoArrive peepoLeave YAPPP DESKCHAN peepoWTF NODDERS NOPERS GuyLeave modCheck SHITTERS]
# https://decapi.me/ffz/emotes/arcadum
ffz = %w[peepoFat Pogey SmileW PepegaPhone PogYou OkayChamp monkaTOS PauseChamp widepeepoHappy PogU HYPERS Kapp Pog LULW]
channel_emotes = %w[gloryFist gloryScheme gloryBustin glory20 gloryT gloryGasm gloryWHOA gloryM gloryAC1 gloryAC2 gloryP gloryOne gloryBlush gloryHeck gloryAngry gloryCheer gloryCry gloryMonkaS gloryPog glory7 gloryHi glorySip gloryShrug gloryTongue gloryLick gloryTorl gloryHack gloryD gloryComfy glorySmug gloryLong gloryAYAYANO gloryL gloryOwO gloryDun gloryGeon gloryDad gloryDy gloryEZ gloryKeK gloryTragic gloryYum gloryHeart gloryHug glorySuffer gloryFireball gloryHB gloryHH]
global = %w[R) ;P :P ;) :/ <3 :O B) O_o :Z >( :D :( :) CTC FootGoal FootYellow FootBall BlackLivesMatter ExtraLife VirtualHug BOP PorscheWIN SingsNote SingsMic TwitchSings SoonerLater HolidayTree HolidaySanta HolidayPresent HolidayOrnament HolidayLog HolidayCookie GunRun PixelBob FBPenalty FBChallenge FBCatch FBBlock FBSpiral FBPass FBRun GenderFluidPride NonBinaryPride MaxLOL IntersexPride TwitchRPG PansexualPride AsexualPride TransgenderPride GayPride LesbianPride BisexualPride PinkMercy MercyWing2 MercyWing1 PartyHat EarthDay TombRaid PopCorn FBtouchdown PurpleStar GreenTeam RedTeam TPFufun TwitchVotes DarkMode HSWP HSCheers PowerUpL PowerUpR LUL EntropyWins TPcrunchyroll TwitchUnity Squid4 Squid3 Squid2 Squid1 CrreamAwk CarlSmile TwitchLit TehePelo TearGlove SabaPing PunOko KonCha Kappu InuyoFace BigPhish BegWan ThankEgg MorphinTime TheIlluminati TBAngel MVGame NinjaGrumpy PartyTime RlyTho UWot YouDontSay KAPOW ItsBoshyTime CoolStoryBob TriHard SuperVinlin FreakinStinkin Poooound CurseLit BatChest BrainSlug PrimeMe StrawBeary RaccAttack UncleNox WTRuck TooSpicy Jebaited DogFace BlargNaut TakeNRG GivePLZ imGlitch pastaThat copyThis UnSane DatSheffy TheTarFu PicoMause TinyFace DrinkPurple DxCat RuleFive VoteNay VoteYea PJSugar DoritosChip OpieOP FutureMan ChefFrank StinkyCheese NomNom SmoocherZ cmonBruh KappaWealth MikeHogu VoHiYo KomodoHype SeriousSloth OSFrog OhMyDog KappaClaus KappaRoss MingLee SeemsGood twitchRaid bleedPurple duDudu riPepperonis NotLikeThis DendiFace CoolCat KappaPride ShadyLulu ArgieB8 CorgiDerp PraiseIt TTours mcaT NotATK HeyGuys Mau5 PRChase WutFace BuddhaBar PermaSmug panicBasket BabyRage HassaanChop TheThing EleGiggle RitzMitz YouWHY PipeHype BrokeBack ANELE PanicVis GrammarKing PeoplesChamp SoBayed BigBrother Keepo Kippa RalpherZ TF2John ThunBeast WholeWheat DAESuppy FailFish HotPokket 4Head ResidentSleeper FUNgineer PMSTwin PogChamp ShazBotstix BibleThump AsianGlow DBstyle BloodTrail HassanChop OneHand FrankerZ SMOrc ArsonNoSexy PunchTrees SSSsss Kreygasm KevinTurtle PJSalt SwiftRage DansGame GingerPower BCWarrior MrDestructoid JonCarnage Kappa RedCoat TheRinger StoneLightning OptimizePrime JKanStyle]
moon_emotes = %w[moon2GUNCH moon2SERF moon2LL moon2EE moon2CV moon2GN moon2JIMBO moon24 moon23 moon22 moon21 moon2SUFFER moon2S moon2COOM moon2CUTE moon2SH moon2DEV moon2JR moon2DODGE moon2PREGIGI moon2LOLE moon2PREGARIO moon2BOO moon2CR moon2SMERG moon2EZ moon2SMUG moon2BRAIN moon2BED moon2B moon2Y moon2POGGYWOGGY moon2DUMB moon2VERYSCARED moon2COFFEE moon2PEEPEEGA moon2C moon2D moon2SECRETEMOTE moon2DOIT moon2N moon2A moon2WUT moon2ME moon2AY moon2G moon2PH moon2SP moon2O moon2CD moon2H moon2MD moon2MM moon2M moon2E moon2W moon2SPY moon2L moon2T moon2GUMS]

emotes = bttv.concat(ffz, channel_emotes, global, moon_emotes)
emote_count = []

emotes.each do |e|
  count = 0
  file = File.open("logger.log", 'r')
  file.grep(/\s:#{Regexp.quote(e)}(\s|$)/) {|e| count += 1}
  emote_count << {e => count}
  file.close
  puts "emote:#{e}, count:#{count}"
end

# sort the array and gets the top 7 emotes used
emote_count.sort_by! {|emote| emote.values.first }
sliced = emote_count[-7, 7]
File.write("emotes/emote_count.json", emote_count.to_json)
File.write("emotes/top_emotes.json", sliced.to_json)
