-- SC IT 마스터 웹 프로그램 Step Project : 인터넷 뱅킹

-- 고객 정보 테이블
create table customer (
	custid		varchar2(20) primary key,	--고객 아이디
	password	varchar2(20) not null,		--비밀번호
	name		varchar2(30) not null,		--고객 이름
	email		varchar2(30),				--고객 이메일
	division	varchar2(30) not null,		--고객구분 : personal(개인), company(기업)
	idno		varchar2(20) unique,	 	--식별번호 (개인: 주민번호, 법인: 사업자 번호)	
	address		varchar2(100)				--주소
);

create table board2 (
	boardnum	number(5) primary key,
	id			varchar2(20) not null,
	title		varchar2(100) not null,
	content		varchar2(2000) not null,
	inputdate	date default sysdate,
	hits		number(5) default 0
);
create sequence board2_seq

create table reply2 (
	replynum	number(5) primary key,
	boardnum	number(5),
	id			varchar2(20) not null,
	text		varchar2(200) not null,
	inputdate	date default sysdate,
	FOREIGN KEY (boardnum) REFERENCES board2(boardnum)
);
create sequence reply2_seq

-- 테스트용 고객 데이터 
insert into customer values ('aaa','aaa', '홍길동', 'aaa@aaa.com', 'personal', '801230-1234567', '서울시');
