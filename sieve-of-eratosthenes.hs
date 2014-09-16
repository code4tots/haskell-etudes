{--

A seductive one-liner is

    sieve (p:ns) = p:[n | n <- ns, rem n p /= 0]
    primes = sieve [2..]

However, this is really trial division.

From searching on the internet, it appears that
a purely functional sieve of eratosthenes is rather
difficult to do.

As such, here, I use stateful monad.

Even though the performance with ghc -O2 is ok,
runghc runs rather slowly.

Kyumins-iMac:haskell-etudes math4tots$ ghc -O2 sieve-of-eratosthenes.hs && time ./sieve-of-eratosthenes
[1 of 1] Compiling Main             ( sieve-of-eratosthenes.hs, sieve-of-eratosthenes.o )
Linking sieve-of-eratosthenes ...
1999993

real    0m0.109s
user    0m0.100s
sys 0m0.003s

Kyumins-iMac:haskell-etudes math4tots$ time runghc sieve-of-eratosthenes.hs 
1999993

real    0m1.934s
user    0m1.893s
sys 0m0.041s


--}

import Control.Monad (forM_, when)
import Data.Array.ST (
    runSTUArray,
    readArray,
    writeArray,
    newArray)
import Data.Array.Unboxed ((!), UArray)

sieve :: Int -> UArray Int Bool
sieve n = runSTUArray $ do
    let r = floor . sqrt $ fromIntegral n
    sieve <- newArray (0, n) True
    forM_ [2 .. r] $ \i -> do
        isPrime <- readArray sieve i
        when isPrime $ do
            let i2 = i * i
            forM_ [i2, i2+i .. n] $ \j -> do
                writeArray sieve j False
    return sieve

primesTo :: Int -> [Int]
primesTo n = [p | p <- [2..n], s ! p] where s = sieve n

main :: IO ()
main = print $ last $ primesTo 2000000
