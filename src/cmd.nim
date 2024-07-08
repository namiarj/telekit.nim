proc unknownCmd(b: Telebot, c: Command): Future[bool] {.gcsafe, async.} =
  let
    m = c.message
    cid = m.chat.id
    mid = m.messageId
  b.sendReply(cid, mid, UNKNOWN)
  return true


proc guideCmd(b: Telebot, c: Command): Future[bool] {.gcsafe, async.} =
  let
    m = c.message
    cid = m.chat.id
  b.sendMenu(cid, GUIDE_TXT, guideMenu())
  b.deleteThisMessage(m)
  return true


proc privacyCmd(b: Telebot, c: Command): Future[bool] {.gcsafe, async.} =
  let
    m = c.message
    cid = m.chat.id
  acheck b.sendMessage(cid, "PRIVACY")
  b.deleteThisMessage(m)
  return true


proc startCmd(b: Telebot, c: Command): Future[bool] {.gcsafe, async.} =
  let
    m = c.message
    cid = m.chat.id
    uid = m.fromUser.id
  if await b.isMember(uid): acheck b.sendStartMenu(cid)
  else: acheck b.sendForceJoin(cid)
  return true
