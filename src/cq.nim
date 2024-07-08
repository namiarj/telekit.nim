proc handleCQ(b: Telebot, cq: CallbackQuery): Future[bool] {.gcsafe, async.} =
  case cq.data:
  of "start", "joined":
    b.editMenu(cq, START_TXT, startMenu())
  else: acheck b.answerCallbackQuery(cq.id, "Not implemented!")
  return true
