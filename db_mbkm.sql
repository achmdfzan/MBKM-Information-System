/*==============================================================*/
/* DBMS name:      MySQL 5.0                                    */
/* Created on:     19/05/2022 09:14:23                          */
/*==============================================================*/


alter table KONTRAKMATKUL 
   drop foreign key FK_KONTRAKM_KONTRAKMA_TMATKUL;

alter table KONTRAKMATKUL 
   drop foreign key FK_KONTRAKM_KONTRAKMA_TMAHASIS;

alter table KONTRAKMBKM 
   drop foreign key FK_KONTRAKM_KONTRAKMB_TMAHASIS;

alter table KONTRAKMBKM 
   drop foreign key FK_KONTRAKM_KONTRAKMB_TPROGRAM;

alter table TMAHASISWA 
   drop foreign key FK_TMAHASIS_MEMBIMBIN_TPEMBIMB;


alter table KONTRAKMATKUL 
   drop foreign key FK_KONTRAKM_KONTRAKMA_TMATKUL;

alter table KONTRAKMATKUL 
   drop foreign key FK_KONTRAKM_KONTRAKMA_TMAHASIS;

drop table if exists KONTRAKMATKUL;


alter table KONTRAKMBKM 
   drop foreign key FK_KONTRAKM_KONTRAKMB_TMAHASIS;

alter table KONTRAKMBKM 
   drop foreign key FK_KONTRAKM_KONTRAKMB_TPROGRAM;

drop table if exists KONTRAKMBKM;


alter table TMAHASISWA 
   drop foreign key FK_TMAHASIS_MEMBIMBIN_TPEMBIMB;

drop table if exists TMAHASISWA;

drop table if exists TMATKUL;

drop table if exists TPEMBIMBING;

drop table if exists TPROGRAMMBKM;

/*==============================================================*/
/* Table: KONTRAKMATKUL                                         */
/*==============================================================*/
create table KONTRAKMATKUL
(
   KODE_MK              varchar(10) not null  comment '',
   NIM                  varchar(10) not null  comment '',
   NILAI                float  comment '',
   ID_KONTRAKMATKUL     int not null  comment '',
   primary key (ID_KONTRAKMATKUL)
);

/*==============================================================*/
/* Table: KONTRAKMBKM                                           */
/*==============================================================*/
create table KONTRAKMBKM
(
   NIM                  varchar(10) not null  comment '',
   ID_PROGRAM           varchar(10) not null  comment '',
   STATUS               varchar(20) not null  comment '',
   ID_KONTRAKMBKM       int not null  comment '',
   primary key (ID_KONTRAKMBKM)
);

/*==============================================================*/
/* Table: TMAHASISWA                                            */
/*==============================================================*/
create table TMAHASISWA
(
   NIP                  varchar(20) not null  comment '',
   NIM                  varchar(10) not null  comment '',
   NAMA_MAHASISWA       varchar(50) not null  comment '',
   PRODI                varchar(50) not null  comment '',
   EMAIL_MAHASISWA      varchar(50) not null  comment '',
   SEMESTER_MAHASISWA   int not null  comment '',
   SKS_AKUMULATIF       int not null  comment '',
   IPK_MAHASISWA        float not null  comment '',
   primary key (NIM)
);

/*==============================================================*/
/* Table: TMATKUL                                               */
/*==============================================================*/
create table TMATKUL
(
   KODE_MK              varchar(10) not null  comment '',
   NAMA_MK              varchar(50) not null  comment '',
   SKS_MK               int not null  comment '',
   SEMESTER_MK          int not null  comment '',
   primary key (KODE_MK)
);

/*==============================================================*/
/* Table: TPEMBIMBING                                           */
/*==============================================================*/
create table TPEMBIMBING
(
   NIP                  varchar(20) not null  comment '',
   NAMA_PEMBIMBING      varchar(50) not null  comment '',
   EMAIL_PEMBIMBING     varchar(50) not null  comment '',
   primary key (NIP)
);

/*==============================================================*/
/* Table: TPROGRAMMBKM                                          */
/*==============================================================*/
create table TPROGRAMMBKM
(
   ID_PROGRAM           varchar(10) not null  comment '',
   NAMA_PROGRAM         varchar(10) not null  comment '',
   JENIS_PROGRAM        varchar(10) not null  comment '',
   DURASI               int not null  comment '',
   SKS_PROGRAM          int not null  comment '',
   primary key (ID_PROGRAM)
);

alter table KONTRAKMATKUL add constraint FK_KONTRAKM_KONTRAKMA_TMATKUL foreign key (KODE_MK)
      references TMATKUL (KODE_MK) on delete restrict on update restrict;

alter table KONTRAKMATKUL add constraint FK_KONTRAKM_KONTRAKMA_TMAHASIS foreign key (NIM)
      references TMAHASISWA (NIM) on delete restrict on update restrict;

alter table KONTRAKMBKM add constraint FK_KONTRAKM_KONTRAKMB_TMAHASIS foreign key (NIM)
      references TMAHASISWA (NIM) on delete restrict on update restrict;

alter table KONTRAKMBKM add constraint FK_KONTRAKM_KONTRAKMB_TPROGRAM foreign key (ID_PROGRAM)
      references TPROGRAMMBKM (ID_PROGRAM) on delete restrict on update restrict;

alter table TMAHASISWA add constraint FK_TMAHASIS_MEMBIMBIN_TPEMBIMB foreign key (NIP)
      references TPEMBIMBING (NIP) on delete restrict on update restrict;

