# 11. We chose a different CosmosDB API

Date: 2017-11-28

## Status

Accepted

Amends [9. We choose a CosmosDB API](0009-we-choose-a-cosmosdb-api.md)

## Context

In [ADR #9](0009-we-choose-a-cosmosdb-api.md) we decided to use the MongoDB API
for CosmosDB but as soon as we implemented the first version of the DAL logic
we realized that the MongoDB support in CosmosDB was flawed: a serious [bug](https://feedback.azure.com/forums/263030-azure-cosmos-db/suggestions/19361521-fix-bug-that-destroys-nodejs-mongodb-connection-po)
that destroyed the connection pool every ~10s made the MongoDB API impossible
to use in a production environment.

## Decision

Since at the time we were still in the early phase of development (around
August 2017), we decided to implement the DAL on top of the more mature
DocumentDB API (see [this commit](https://github.com/teamdigitale/io-functions/commit/c72b95ebb5ed038cdf62f43dc1adacbde9668d4e)).

Note that the bug has been recently fixed (October 2017), so it may be worth to
plan a migration of the DAL to the MongoDB API.

## Consequences

The DAL is implemented on top of the DocumentDB API (see [documentdb.ts](https://github.com/teamdigitale/io-functions/blob/master/lib/utils/documentdb.ts))
