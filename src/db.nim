import norm/[model, sqlite]


type
  User* = ref object of Model
    lang*: string 
    lastActive*: float 
    lastCheck*: float
    star*: Natural
    state*: string
    userId*: int


let db = open(dbAddr, "", "", "")
db.createTables(User())


func newUser(userId: int, state = "", star = 0, lastActive = 0.0): User =
  result = User(userId: userId, state: state, star: star, lastActive: lastActive)


proc insertUser(userId: int): User =
  var insertUser = newUser(userId)
  db.insert(insertUser)
  result = insertUser


proc getUser(userId: int): User =
  var selectedUser = User()
  try:
    db.select(selectedUser, "User.userId = ?", userId)
    result = selectedUser
  except NotFoundError:
    result = insertUser(userId)
