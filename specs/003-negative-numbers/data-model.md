# Phase 1: Data Model & Contracts

## Entities

No new data entities are being introduced for this feature. 

The core state alteration applies to the existing `CalculatorState`'s `display` property:

- `CalculatorState`
  - `display`: (String) Will now accurately support parsing of strings prepended with a minus symbol `"-"`.

## Operations

Operations remain mathematically sound as Dart's `double` handles negative arithmetic inherently well. No new `Operation` instances are needed, just UI affordances.

## API Contracts
N/A (Local client-side execution)
