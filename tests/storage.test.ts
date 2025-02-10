import { describe, it, expect, beforeEach } from "vitest"

// Mock storage for files
const files = new Map()
let nextFileId = 1

// Mock functions to simulate contract behavior
function storeFile(owner: string, name: string, hash: string) {
  const fileId = nextFileId++
  files.set(fileId, { owner, name, hash })
  return fileId
}

function getFile(fileId: number) {
  return files.get(fileId)
}

describe("Storage Contract", () => {
  beforeEach(() => {
    files.clear()
    nextFileId = 1
  })
  
  it("should store a file", () => {
    const fileId = storeFile("owner1", "test.txt", "hash123")
    expect(fileId).toBe(1)
    const file = getFile(fileId)
    expect(file).toBeDefined()
    expect(file.name).toBe("test.txt")
    expect(file.owner).toBe("owner1")
    expect(file.hash).toBe("hash123")
  })
  
  it("should retrieve a stored file", () => {
    const fileId = storeFile("owner1", "test.txt", "hash123")
    const file = getFile(fileId)
    expect(file).toBeDefined()
    expect(file.name).toBe("test.txt")
    expect(file.owner).toBe("owner1")
    expect(file.hash).toBe("hash123")
  })
  
  it("should return undefined for non-existent file", () => {
    const file = getFile(999)
    expect(file).toBeUndefined()
  })
})

