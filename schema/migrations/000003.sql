-- Copyright 2022 Google LLC
--
-- Licensed under the Apache License, Version 2.0 (the "License");
-- you may not use this file except in compliance with the License.
-- You may obtain a copy of the License at
--
--     https://www.apache.org/licenses/LICENSE-2.0
--
-- Unless required by applicable law or agreed to in writing, software
-- distributed under the License is distributed on an "AS IS" BASIS,
-- WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
-- See the License for the specific language governing permissions and
-- limitations under the License.
--

CREATE TABLE game_items
(
  itemUUID STRING(36) NOT NULL,
  item_name STRING(MAX) NOT NULL,
  item_value NUMERIC NOT NULL,
  available_time TIMESTAMP NOT NULL,
  duration int64
)PRIMARY KEY (itemUUID);

CREATE TABLE player_items
(
  playerItemUUID STRING(36) NOT NULL,
  playerUUID STRING(36) NOT NULL,
  itemUUID STRING(36) NOT NULL,
  price NUMERIC NOT NULL,
  source STRING(MAX) NOT NULL,
  game_session STRING(36) NOT NULL,
  acquire_time TIMESTAMP NOT NULL DEFAULT (CURRENT_TIMESTAMP()),
  expires_time TIMESTAMP,
  visible BOOL NOT NULL DEFAULT(true),
  FOREIGN KEY (itemUUID) REFERENCES game_items (itemUUID),
  FOREIGN KEY (game_session) REFERENCES games (gameUUID)
) PRIMARY KEY (playerUUID, playerItemUUID),
    INTERLEAVE IN PARENT players ON DELETE CASCADE;

CREATE TABLE player_ledger_entries (
  playerUUID STRING(36) NOT NULL,
  source STRING(MAX) NOT NULL,
  game_session STRING(36) NOT NULL,
  amount NUMERIC NOT NULL,
  entryDate TIMESTAMP NOT NULL OPTIONS (allow_commit_timestamp=true),
  FOREIGN KEY (game_session) REFERENCES games (gameUUID)
) PRIMARY KEY (playerUUID, entryDate DESC),
  INTERLEAVE IN PARENT players ON DELETE CASCADE;
