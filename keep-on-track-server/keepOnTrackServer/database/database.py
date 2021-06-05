import sqlite3 as sql

conn = sql.connect('database/events.db')

conn.execute('''CREATE TABLE EVENTS
          (id INT PRIMARY KEY     NOT NULL,
          name           TEXT    NOT NULL,
          link TEXT NOT NULL,
          starttime TEXT NOT NULL);''')

conn.execute('''CREATE TABLE CURRENT
          (currentID INT  NOT NULL);''')

conn.execute("INSERT INTO CURRENT (currentID) \
      VALUES (1)")

conn.commit()

conn.close()