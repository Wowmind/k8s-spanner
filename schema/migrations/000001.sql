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

CREATE TABLE players (
	playerUUID STRING(36) NOT NULL,
	player_name STRING(64) NOT NULL,
	email STRING(MAX) NOT NULL,
	password_hash BYTES(60) NOT NULL,
	created TIMESTAMP,
	updated TIMESTAMP,
	stats JSON,
	account_balance NUMERIC NOT NULL DEFAULT (0.00),
	is_logged_in BOOL,
	last_login TIMESTAMP,
	valid_email BOOL,
	current_game STRING(36)
) PRIMARY KEY (playerUUID);

CREATE UNIQUE INDEX PlayerAuthentication ON players(email) STORING(password_hash);
CREATE UNIQUE INDEX PlayerName ON players(player_name);
CREATE INDEX PlayerGame ON players(current_game);
