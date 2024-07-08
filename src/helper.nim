import times

template acheck(body: untyped) =
  try: asyncCheck body
  except: warn(getCurrentExceptionMsg())


template check(body: untyped) =
  try: body
  except: warn(getCurrentExceptionMsg())


template qcheck(body: untyped) =
  try: body
  except: quit(getCurrentExceptionMsg())


template deleteThisMessage(b: Telebot, m: Message) = acheck b.deleteMessage(m.chat.id, m.messageId)


template isAdmin(uid: int): untyped = uid in admins


proc isMember(b: Telebot, uid: int, lang = "fa"): Future[bool] {.gcsafe, async.} =
  if uid.isAdmin: return true
  var u = getUser(uid)
  let now = epochTime()
  if now - u.lastCheck < memberCheckInterval: return true
  for channel in forcedChannels[lang]:
    try: 
      let m = await b.getChatMember(channel, uid)
      if m.status == "left": return false
    except:
      warn("getChatMember failed")
      return false
  u.lastCheck = now
  db.update(u)
  return true


template editMenu(b: Telebot, cq: CallbackQuery, txt: string, kb: KeyboardMarkup, ct = "") =
  acheck b.answerCallbackQuery(cq.id, ct)
  acheck b.editMessageText(txt, cq.message.chat.id, cq.message.messageId, replyMarkup = kb)


template sendMenu(b: Telebot, cid: int, txt: string, kb: KeyboardMarkup) =
  acheck b.sendMessage(cid, txt, replyMarkup = kb)


template sendReply(b: Telebot, cid: int, mid: int, txt: string) =
  acheck b.sendMessage(cid, txt, replyParameters = ReplyParameters(messageId: mid))
