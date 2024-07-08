tgbot: src
	nim c -d:ssl -d:release --mm:markAndSweep -o tgbot src/tgbot.nim
