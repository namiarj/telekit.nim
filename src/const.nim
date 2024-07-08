import tables

const
  cfgAddr = "/home/tgbot/tgbot/cfg.ini"
  dbAddr = "/home/tgbot/tgbot/db.sqlite"
  debugAddr = "/var/log/tgbot/debug.log"
  noticeAddr = "/var/log/tgbot/notice.log"
  admins = @[1]
  memberCheckInterval = 60
  langs = {
    "en": "English",
    "fa": "فارسی"}.toTable()
  forcedChannels = {
    "fa": @[],
    "en": @[]}.toTable()
