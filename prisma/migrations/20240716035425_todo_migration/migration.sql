-- CreateTable
CREATE TABLE "TodoModel" (
    "id" INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT,
    "name" TEXT NOT NULL,
    "cycleDays" INTEGER NOT NULL,
    "lastTime" DATETIME
);
