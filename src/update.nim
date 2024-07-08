include db, helper, menu, cmd, cq

proc update(b: Telebot, u: Update): Future[bool] {.gcsafe, async.} =
  if u.callbackQuery != nil:
    let cq = u.callbackQuery
    if await b.isMember(cq.fromUser.id):
      acheck b.handleCQ(cq)
    else:
      if cq.data == "joined": acheck b.answerCallbackQuery(cq.id, NOJOIN)
      else: b.editMenu(cq, JOIN, forceMenu(), NOJOIN)

  elif u.message != nil and u.message.chat.kind != "group":
    let m = u.message
    if await b.isMember(m.fromUser.id): discard
    else: acheck b.sendForceJoin(m.chat.id)

  return true
