import asyncdispatch, logging, parsecfg, strutils
import telebot
include "const", "string", "update"

qcheck:
  const fmtStr = "[$time] [$levelname] "
  addHandler(newConsoleLogger(fmtStr=fmtStr)) 
  addHandler(newRollingFileLogger(debugAddr, fmtStr=fmtStr))
  addHandler(newFileLogger(noticeAddr, levelThreshold=lvlNotice, fmtStr=fmtStr))

check:
  let
    cfg = loadConfig(cfgAddr)
    token = cfg.getSectionValue("bot", "token").strip()
    url = cfg.getSectionValue("bot", "url").strip()
    webhook = cfg.getSectionValue("bot", "webhook").strip()
    b = newTeleBot(token)
    cmds = @[
      static BotCommand(command: "start", description: "Start"),
      static BotCommand(command: "guide", description: "Guide",
      static BotCommand(command: "privacy", description: "Privacy"),
    ]
  asyncCheck b.setMyCommands(cmds)
  b.onCommand("guide", guideCmd)
  b.onCommand("privacy", privacyCmd)
  b.onCommand("start", startCmd)
  b.onUnknownCommand(unknownCmd)
  b.onUpdate(update)
  b.startWebhook(url, webhook)
