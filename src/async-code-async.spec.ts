describe('local test', () => {
  async function fetchData(fail: boolean = false) {
    if (!fail) {
      return 'mr peanutbutter'
    }

    throw new Error('error Shit code')
  }

  test('the data is peanut butter', async () => {
    const data = await fetchData()
    expect(data).toBe('mr peanutbutter')
  })

  test('the fetch fails with an error', async () => {
    expect.hasAssertions()
    try {
      await fetchData(true)
    } catch (e) {
      console.log('Dante: e', e)
      expect(e).toMatch('error')
    }
  })
})
