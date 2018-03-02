create table users(
	id bigint not null primary key auto_increment,
	name varchar(245),
	email varchar(245),
	passwd varchar(245),
	role varchar(45)
);

create table groups(
	id bigint not null primary key auto_increment,
	name varchar(245)
);

create table groups_users(
	id bigint not null primary key auto_increment,
	user_id bigint not null,
	group_id bigint not null,
	role varchar(45),
	foreign key (user_id) references users(id) on update cascade on delete cascade,
	foreign key (group_id) references groups(id) on update cascade on delete cascade
);

create table games(
	id bigint not null primary key auto_increment,
	team_a varchar(245),
	team_b varchar(245),
	result_a int,
	result_b int
);

create table guessings(
	id bigint not null primary key auto_increment,
	result_a int,
	result_b int,
	score int,
	game_id bigint,
	group_id bigint,
	user_id bigint,
	foreign key (game_id) references games (id) on update cascade on delete cascade,
	foreign key (group_id) references groups (id) on update cascade on delete cascade,
	foreign key (user_id) references users (id) on update cascade on delete cascade
);

create table comments(
	id bigint not null primary key auto_increment,
	comment text,
	guessing_id bigint,
	user_id bigint,
	foreign key (guessing_id) references guessings (id) on update cascade on delete cascade,
	foreign key (user_id) references users (id) on update cascade on delete cascade
);