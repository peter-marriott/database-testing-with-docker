#!/usr/bin/env python
__author__ = 'PSM'
__version__ = "1.0.0"

import os
from bottle import auth_basic, route, run, response, request, abort
import psycopg2
import json

postgres_host       = os.environ['APP_DB_HOST']
postgres_port       = os.environ['APP_DB_PORT']
postgres_database   = os.environ['APP_DB_DATABASE']
postgres_user       = os.environ['APP_DB_READ_WRITE_USER']
postgres_password   = os.environ['APP_DB_READ_WRITE_PASSWORD']
port                = os.environ['PORT']

@route('/')
def index():
    print 'Route / called'
    try:
        conn = psycopg2.connect(database=postgres_database,
            user=postgres_user,
            password=postgres_password,
            host=postgres_host,
            port=postgres_port)

        print 'Connected'
        cur = conn.cursor()
        results_dict = {}
        try:
            # select customerid, createdat, surname, initials, firstname, title, postcode1, postcode2, dob, sex, email, passwd from reporting.customer order by surname, firstname
            cur.execute("select customerid, customerreference, surname, initials, firstname, title, postcode1, postcode2, sex, email, passwd from reporting.customer order by surname, firstname")
            customer_list = cur.fetchall()
            print "Got {} rows".format(len(customer_list))

        except psycopg2.IntegrityError as ex:
            print 'postgres_error: {}'.format(ex.message)
            conn.rollback()
            raise

        conn.commit()
    except Exception as ex:
        print 'postgres_error: {}'.format(ex.message)
    finally:
        if cur:
            cur.close()
        if conn:
            conn.close()

    results = {
        'customer_list': customer_list
    }

    response.content_type = 'application/json'
    return json.JSONEncoder().encode(results)

run(host='0.0.0.0', port=port)
