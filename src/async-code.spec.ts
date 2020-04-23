function fetchData(callback: (data: any) => any) {
  setTimeout(() => {
    callback({ saludos: 'dante' })
  }, 2000)
}

test('the data should be and object', done => {
  function callback(data) {
    try {
      expect(data).toEqual({ saludos: 'dante' })
      done()
    } catch (error) {
      done(error)
    }
  }

  fetchData(callback)
})

function fetchDataPromise(fail: boolean = false) {
  return new Promise((resolve: any, reject) => {
    fail ? reject('this is an error') : resolve('peanut butter')
  })
}

test('the data is peanut butter', () => {
  // | Has to return, otherwise this fails
  return fetchDataPromise().then(data => {
    expect(data).toBe('peanut butter')
  })
})

test('the fetch fails with an error', () => {
  expect.assertions(1)
  return fetchDataPromise(true)
    .then(res => {
      console.log('Dante: res', res)
      expect(res).toBe('peanut butter')
    })
    .catch(e => expect(e).toMatch('error'))
})

test('the data is peanut butter', () => {
  return expect(fetchDataPromise()).resolves.toBe('peanut butter')
})

test('should throw the promise', () => {
  return expect(fetchDataPromise(true)).rejects.toMatch('err') // This doesn't matter
})
