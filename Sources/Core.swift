import Kitura
import KituraNet
import Foundation
import CryptoSwift
import SwityRequest

/**
 * Need to fix the http and p2p requests by
 * packaging our own siwft lib...
 */

class Blockchain: Chain {
    /** Setup the chains array */
    var Chain: [Block]

    /** Setup the current transactions index array */
    var Current_Transaction: [Transaction]

    /** Setup the current joined nodes name */
    var Nodes: Set<String>

    init( ) {
        /** Init with empty transations history */
        /** Set chain to zero... */
        chain = []

        /** Remove all previous transactions and clear them */
        Current_Transaction = []

        /** Set the current joined node name to zero */
        Nodes = set()

        /** Generate the Genesis hash for initialisation */
        /** Set index to 1 to identify it is the first block */
        /** Set proof to 100 for initial purposes... can be set later on */
        self.newBlock( Previous_Hash: "1", proof: "100" )
    }

    /** Add a new method for mining new blocks. Check if prev_hash is a string */
    /** Set proof to and int64 and return all values to the identifier ['Block'] */
    @discardableResult
    func newBlock( Previous_Hash: String?, proof: Int64 ) -> Block {

        /** Add local components for a single block */
        /** The block sets itselfe as an int64 with the next higher layered index */
        let Block = Block( index: Int64 ( self.chain.count + 1 /* last_index + 1 */ ),

                    /** Add the current timestamp */
                    Timestamp: Date( ),

                    /** Add the transactions value */
                    Transactions: self.Current_Transaction,
                    
                    /** Add the proof value [( 0 || 1 )] */
                    Proof: proof,

                    /** Set the last previous mined block */
                    Previous_Hash: Previous_Hash ?? self.hash( block: self.last_block )
        )

        /** Clear the current transaction list just to make sure */
        self.Current_Transaction = []

        /** Simply append the genesis block to the cleared chain */
        self.chain.append( Block ) 
        return Block
    }

    @discardableResult
    func newTransaction( sender: String, recipient: String, amount: Int64 ) -> Int64 {
        /**
         * Add components to the new Transactions value
         * ['Sender']: sets as string
         * ['Recipient']: sets as string
         * Need to redo it by implementing unique user id's setted as base64 hash idk lets c xD
         *
         * ['Amount']: Int64
         */
        let transaction = Transaction( sender: sender, recipient: recipient, amount: amount )

        /** Append new transaction to the chain */
        self.Current_Transaction.append( Transaction )

        /* Return the last block with an new layered index [ last_index + 1 ] **/
        return self.last_block.index + 1
    }

    /** set last block as the last mined block in the chain */
    var last_block: Block {
        return self.chain[ self.chain.count - 1]
    }

    /** Setup the hash function as string */
    /** Mark! Need to redo it by adding own hashing lib */
    func hash( block: Block ) -> String {
        /** Set the formatted output as JSON */
        let encoder = JSONencoder()

        if #available( OSX 10.13, * ) {
            /** Check for inconsistent OS's to preformat the output */
            /** Otherwise the output will be pretty wakky and inconsistent xD */
            encoder.outputFormatting = .sortedKeys
        }
