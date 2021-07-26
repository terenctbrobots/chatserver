const request = require('supertest')
import { describe } from 'mocha'
import { app } from '../src/server'


describe('GET /', function() {
    it('responds with json', function(done) {
      request(app)
        .get('/')
        .set('Accept', 'application/json')
        .expect('Content-Type', /json/)
        .expect(200, done);
    });
  });