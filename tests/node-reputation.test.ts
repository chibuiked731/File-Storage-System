import { describe, it, expect, beforeEach } from "vitest"

// Mock storage for node reputations
const nodeReputations = new Map()

// Mock functions to simulate contract behavior
function registerNode(node: string) {
  nodeReputations.set(node, { reputation: 0 })
  return true
}

function updateReputation(node: string, newReputation: number) {
  if (!nodeReputations.has(node)) {
    throw new Error("Node not found")
  }
  nodeReputations.set(node, { reputation: newReputation })
  return true
}

function getNodeReputation(node: string) {
  return nodeReputations.get(node)
}

describe("Node Reputation Contract", () => {
  beforeEach(() => {
    nodeReputations.clear()
  })
  
  it("should register a node", () => {
    const result = registerNode("node1")
    expect(result).toBe(true)
    const reputation = getNodeReputation("node1")
    expect(reputation).toBeDefined()
    expect(reputation.reputation).toBe(0)
  })
  
  it("should update node reputation", () => {
    registerNode("node1")
    const result = updateReputation("node1", 50)
    expect(result).toBe(true)
    const reputation = getNodeReputation("node1")
    expect(reputation.reputation).toBe(50)
  })
  
  it("should not update reputation for unregistered node", () => {
    expect(() => updateReputation("unregistered_node", 50)).toThrow("Node not found")
  })
  
  it("should get node reputation", () => {
    registerNode("node1")
    updateReputation("node1", 75)
    const reputation = getNodeReputation("node1")
    expect(reputation).toBeDefined()
    expect(reputation.reputation).toBe(75)
  })
})

