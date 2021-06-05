from flask import Flask, render_template, request
import sqlite3
import json

app = Flask('__name__')
app.config['SEND_FILE_MAX_AGE_DEFAULT'] = 0


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/createevent')
def createevent(methods=['GET', 'POST']):

    name = request.args.get('name')
    print(name)

    link = request.args.get('link')
    print(link)

    starttime = request.args.get('starttime')
    print(starttime)

    conn = sqlite3.connect('database/events.db')

    cursorcurrentid = conn.execute("SELECT currentID from CURRENT")
    for row in cursorcurrentid:
        print("CurrentID is ", row[0])
        currentId = str(row[0])

    conn.execute("""INSERT INTO EVENTS (id, name, link, starttime) \
      VALUES (?, ?, ?, ?)""", (currentId, name, link, starttime))

    newcurrentid = str(int(currentId) + 1)
    conn.execute("UPDATE CURRENT set currentID = ? where currentID = ?",
                 (newcurrentid, currentId))

    conn.commit()
    conn.close()

    return 'thisreturnstatementdoesntmatter'


if __name__ == '__main__':
    # ! Remove debug = True after development
    app.run(debug=True, host='0.0.0.0')
