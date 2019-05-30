Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9C9FA302D3
	for <lists+linux-pci@lfdr.de>; Thu, 30 May 2019 21:33:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726079AbfE3TdW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 May 2019 15:33:22 -0400
Received: from mx0b-0016f401.pphosted.com ([67.231.156.173]:34802 "EHLO
        mx0b-0016f401.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725440AbfE3TdW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 30 May 2019 15:33:22 -0400
Received: from pps.filterd (m0045851.ppops.net [127.0.0.1])
        by mx0b-0016f401.pphosted.com (8.16.0.27/8.16.0.27) with SMTP id x4UJS8vt003443;
        Thu, 30 May 2019 12:33:09 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=marvell.com; h=from : to : cc :
 subject : date : message-id : references : in-reply-to : content-type :
 content-id : content-transfer-encoding : mime-version; s=pfpt0818;
 bh=OJx9uEAFGDakxz9rH+HnEJR0XDvzdMKtFwLyr1NBxI0=;
 b=t44/xSRCQ0EP+a0VaaxX8LQONozuniZP4GFsaBKLRNsnDZ4SRbqaKWi3YY98ZZ7UO1k1
 ZqhRiubwZloChwNWwVEzMOQB0t0K7UrdPK9ZStUln3KG/KmVBQvfjgm8ZIxqLImfB4RO
 lt54Hz4VsXBwGvVNG9knSH6h9oPln1QcKNfVa+AHWUtkBJpV/3nqTYMRVPA4GMUPXiAP
 bPg0/sXyKhjRnccOR+oll+VQFuzrHy8G5juLr8mmhDv6cdBpah8TD5x5zcTgYG4zi4Ay
 VB28uUQhVPWtgWQo9JW98bY7QmLBvhUwyhYYim2ERCLp7JfYVv0NtoYWlDNGI5aFajUO qQ== 
Received: from sc-exch03.marvell.com ([199.233.58.183])
        by mx0b-0016f401.pphosted.com with ESMTP id 2st448c7tb-2
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-SHA384 bits=256 verify=NOT);
        Thu, 30 May 2019 12:33:07 -0700
Received: from SC-EXCH03.marvell.com (10.93.176.83) by SC-EXCH03.marvell.com
 (10.93.176.83) with Microsoft SMTP Server (TLS) id 15.0.1367.3; Thu, 30 May
 2019 12:33:05 -0700
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (104.47.36.50) by
 SC-EXCH03.marvell.com (10.93.176.83) with Microsoft SMTP Server (TLS) id
 15.0.1367.3 via Frontend Transport; Thu, 30 May 2019 12:33:05 -0700
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=marvell.onmicrosoft.com; s=selector2-marvell-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=OJx9uEAFGDakxz9rH+HnEJR0XDvzdMKtFwLyr1NBxI0=;
 b=G7Q3LC0ITTJmBxHSNi8HShnLIIJClZ4ZGMLIWzrRnbXTgxHFkDkKu7/hNbZFZUl9fi7hyeHwfqgFjQV0trl5Cm8+tsIsJwBTHXIHktgcZrFpJ6Pg40RPoCZ3/SW6sN/cVsASfxuRkUtYfPs+6CGFMUYytzVq+hvCPnJe3NuoqwQ=
Received: from MN2PR18MB2719.namprd18.prod.outlook.com (20.178.255.156) by
 MN2PR18MB2816.namprd18.prod.outlook.com (20.179.20.16) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1922.16; Thu, 30 May 2019 19:33:01 +0000
Received: from MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16]) by MN2PR18MB2719.namprd18.prod.outlook.com
 ([fe80::7150:ff4e:d634:ac16%4]) with mapi id 15.20.1922.024; Thu, 30 May 2019
 19:33:01 +0000
From:   Himanshu Madhani <hmadhani@marvell.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     Andrew Vasquez <andrewv@marvell.com>,
        Girish Basrur <gbasrur@marvell.com>,
        Giridhar Malavali <gmalavali@marvell.com>,
        Myron Stowe <mstowe@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Quinn Tran <quinn.tran@qlogic.com>,
        Linux PCI <linux-pci@vger.kernel.org>
Subject: Re: [EXT] VPD access Blocked by commit
 0d5370d1d85251e5893ab7c90a429464de2e140b
Thread-Topic: [EXT] VPD access Blocked by commit
 0d5370d1d85251e5893ab7c90a429464de2e140b
Thread-Index: AQHVFx5+vAYaj+BnZUm07pDffOoQVQ==
Date:   Thu, 30 May 2019 19:33:01 +0000
Message-ID: <D8764654-E2A0-43B8-97D9-6644F2BC8D0E@marvell.com>
References: <B5B745A3-96B4-46ED-8F3F-D3636A96057F@marvell.com>
 <CAErSpo5qy6WuUe9cz1vTBBnc5P_uZaPzc-Yqbag2eBBxzi+ENg@mail.gmail.com>
 <CAErSpo45bCV7geSPAwBjy5fdQqzDcX61Ybksk65c=intfTWFZQ@mail.gmail.com>
In-Reply-To: <CAErSpo45bCV7geSPAwBjy5fdQqzDcX61Ybksk65c=intfTWFZQ@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-mailer: Apple Mail (2.3445.104.11)
x-originating-ip: [73.93.153.35]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f7618e83-711b-41ae-6256-08d6e535a11b
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:MN2PR18MB2816;
x-ms-traffictypediagnostic: MN2PR18MB2816:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <MN2PR18MB2816FD9471B0B55EBDA3A5F5D6180@MN2PR18MB2816.namprd18.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 00531FAC2C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(979002)(39860400002)(376002)(366004)(346002)(396003)(136003)(199004)(38334002)(40224003)(189003)(4326008)(66446008)(64756008)(91956017)(82746002)(186003)(76176011)(5660300002)(66556008)(99286004)(66066001)(66476007)(73956011)(15650500001)(8676002)(6512007)(6246003)(14444005)(66946007)(53546011)(256004)(26005)(316002)(53936002)(2906002)(6916009)(6506007)(83716004)(6116002)(71200400001)(229853002)(25786009)(305945005)(7736002)(11346002)(14454004)(966005)(33656002)(57306001)(81166006)(6436002)(6486002)(8936002)(50226002)(6306002)(81156014)(102836004)(476003)(2616005)(86362001)(68736007)(478600001)(446003)(36756003)(76116006)(3846002)(54906003)(71190400001)(486006)(969003)(989001)(999001)(1009001)(1019001);DIR:OUT;SFP:1101;SCL:1;SRVR:MN2PR18MB2816;H:MN2PR18MB2719.namprd18.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: marvell.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: e6SPKF5ThKri6c2v7SSP84UVNObddS5Kwbw1jaum9SDi3vvTOBYe0P1DckrJuNSZjvQnbB/Eg7lxjjZNEHNPrH5hiBlyuMWqlUiaVYIo8H9wAOrY2SuqTYRewYZ/dFBnQj95iYvkaAuX2jX/aPEtmyPoqlR8BPR+crVD6zibAw0qdtp1i+0qwShnP4NmORMy547BGahCcypZKMxrpo3okn3JoZ3G6SydVsLDw5KsvdM2DyAHMa+hxChAgp7oWh0TnL9PhlsmwVW0OuQMX1MCsx1FDsiBYyW32kcxcEHbE4EADLfulSCcx6KUByXT7G/C8tsUtQW4afhBmbAInCAJvT34ZeS+rkcHmqHwNIU9OUTE+ECBQ8Z8E5IurUW3LHTomkQiOf4Inc4kukrSCw1UcLi2HVePlkD68rv35cpiLv0=
Content-Type: text/plain; charset="utf-8"
Content-ID: <70CB53A067074B4AAFDBDAD1A6BB1796@namprd18.prod.outlook.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-MS-Exchange-CrossTenant-Network-Message-Id: f7618e83-711b-41ae-6256-08d6e535a11b
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 May 2019 19:33:01.6378
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 70e1fb47-1155-421d-87fc-2e58f638b6e0
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: hmadhani@marvell.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR18MB2816
X-OriginatorOrg: marvell.com
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:,, definitions=2019-05-30_12:,,
 signatures=0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sIA0KDQpUaGFuayB5b3UgZm9yIHJlc3BvbmRpbmcgdG8gbXkgcXVlc3Rpb24uDQoN
Cj4gT24gTWF5IDIxLCAyMDE5LCBhdCAxOjExIFBNLCBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bn
b29nbGUuY29tPiB3cm90ZToNCj4gDQo+IEV4dGVybmFsIEVtYWlsDQo+IA0KPiAtLS0tLS0tLS0t
LS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LS0tDQo+IFtmaXggbGludXgtcGNpLCByZW1vdmUgZXRoYW4uemhhbyAoYm91bmNlcyldDQo+IA0K
PiBGcm9tOiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiBEYXRlOiBUdWUs
IE1heSAyMSwgMjAxOSBhdCAzOjAyIFBNDQo+IFRvOiBIaW1hbnNodSBNYWRoYW5pDQo+IENjOiBl
dGhhbi56aGFvQG9yYWNsZS5jb20sIEFuZHJldyBWYXNxdWV6LCBHaXJpc2ggQmFzcnVyLCBHaXJp
ZGhhcg0KPiBNYWxhdmFsaSwgTXlyb24gU3Rvd2UsIDxsaW51eC1wY2lAa2VybmVsLm9yZz4sIExp
bnV4IEtlcm5lbCBNYWlsaW5nDQo+IExpc3QsIFF1aW5uIFRyYW4NCj4gDQo+PiBbK2NjIE15cm9u
LCBRdWlubiwgbGludXgtcGNpLCBsaW51eC1rZXJuZWxdDQo+PiANCj4+IEZyb206IEhpbWFuc2h1
IE1hZGhhbmkgPGhtYWRoYW5pQG1hcnZlbGwuY29tPg0KPj4gRGF0ZTogRnJpLCBNYXkgMTcsIDIw
MTkgYXQgNToyMSBQTQ0KPj4gVG86IGV0aGFuLnpoYW9Ab3JhY2xlLmNvbSwgYmhlbGdhYXNAZ29v
Z2xlLmNvbQ0KPj4gQ2M6IEFuZHJldyBWYXNxdWV6LCBHaXJpc2ggQmFzcnVyLCBHaXJpZGhhciBN
YWxhdmFsaQ0KPj4gDQo+Pj4gSGkgRXRoYW4sDQo+Pj4gDQo+Pj4gT3VyIE9FTSBwYXJ0bmVycyBy
ZXBvcnRlZCB0byB1cyB0aGF0IFZQRCBhY2Nlc3Mgd2l0aCBsYXRlc3QgZGlzdHJvcyB3ZXJlIHJl
dHVybmluZyBJL08gZXJyb3IgZm9yIHRoZW0uIFRoZXkgaW5kaWNhdGVkIHRoaXMgdG8gYmUgaXNz
dWUgb25seSB3aXRoIG5ld2VyIGtlcm5lbHMuDQo+Pj4gDQo+Pj4gT25lIG9mIHRoZSBkaXN0cm8g
dmVuZG9yIHBvaW50ZWQgb3V0IHBhdGNoIHBvc3RlZCBieSB5b3UgdG8gYmUgcmVhc29uIGZvciBJ
TyBlcnJvciB0cnlpbmcgdG8gVlBELiBUaGUgcGF0Y2ggbG9va3MgbGlrZSBibG9ja3MgYWNjZXNz
IHRvIFZQRCBieSBibGFja2xpc3RpbmcgSVNQLg0KPj4+IA0KPj4+IGh0dHBzOi8vZ2l0Lmtlcm5l
bC5vcmcvcHViL3NjbS9saW51eC9rZXJuZWwvZ2l0L3RvcnZhbGRzL2xpbnV4LmdpdC9jb21taXQv
P2lkPTBkNTM3MGQxZDg1MjUxZTU4OTNhYjdjOTBhNDI5NDY0ZGUyZTE0MGLvu78NCj4+PiANCj4+
PiBJIHNldHVwIFBDSWUgYW5hbHl6ZXIgdG8gcmVwcm9kdWNlIHRoaXMgaW4gb3VyIGxhYiB0byBy
b290IGNhdXNlIGl0IGFuZCBkaXNjb3ZlcmVkIHRoYXQgYWZ0ZXIgcmV2ZXJ0aW5nIHRoZSBwYXRj
aC4gIEkgYW0gYWJsZSB0byBnZXQgVlBEIGRhdGEgb2theSB3aXRoIHVwc3RyZWFtIDUuMS4wIGFu
ZCBJIHVzZWQgUkhFTDguDQo+Pj4gDQo+Pj4gSSBhbHNvIHVzZWQgICJsc3BjaSIgYW5kICJjYXQi
IHRvIGR1bXAgb3V0IFZQRCBkYXRhIGFuZCBkbyBub3Qgc2VlIGFueSBpc3N1ZS4NCj4+PiANCj4+
PiAjIGxzcGNpIC12dnYgLXMgMDM6MDAuMA0KPj4+IDAzOjAwLjAgRmlicmUgQ2hhbm5lbDogUUxv
Z2ljIENvcnAuIElTUDI3MjItYmFzZWQgMTYvMzJHYiBGaWJyZSBDaGFubmVsIHRvIFBDSWUgQWRh
cHRlciAocmV2IDAxKQ0KPj4+ICAgICAgICAgICAgICAgIFN1YnN5c3RlbTogUUxvZ2ljIENvcnAu
IFFMRTI3NDIgRHVhbCBQb3J0IDMyR2IgRmlicmUgQ2hhbm5lbCB0byBQQ0llIEFkYXB0ZXINCj4+
PiAgICAgICAgICAgICAgICBQaHlzaWNhbCBTbG90OiAxNQ0KPj4+ICAgICAgICAgICAgICAgIENv
bnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lOVi0gVkdBU25vb3At
IFBhckVycisgU3RlcHBpbmctIFNFUlIrIEZhc3RCMkItIERpc0lOVHgtDQo+Pj4gICAgICAgICAg
ICAgICAgU3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZh
c3QgPlRBYm9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQ0KPj4+ICAg
ICAgICAgICAgICAgIExhdGVuY3k6IDAsIENhY2hlIExpbmUgU2l6ZTogNjQgYnl0ZXMNCj4+PiAg
ICAgICAgICAgICAgICBJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJUlEgNjcNCj4+PiAgICAg
ICAgICAgICAgICBOVU1BIG5vZGU6IDANCj4+PiAgICAgICAgICAgICAgICBSZWdpb24gMDogTWVt
b3J5IGF0IGZiZTA1MDAwICg2NC1iaXQsIHByZWZldGNoYWJsZSkgW3NpemU9NEtdDQo+Pj4gICAg
ICAgICAgICAgICAgUmVnaW9uIDI6IE1lbW9yeSBhdCBmYmUwMjAwMCAoNjQtYml0LCBwcmVmZXRj
aGFibGUpIFtzaXplPThLXQ0KPj4+ICAgICAgICAgICAgICAgIFJlZ2lvbiA0OiBNZW1vcnkgYXQg
ZmJkMDAwMDAgKDY0LWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0NCj4+PiAgICAgICAgICAg
ICAgICBFeHBhbnNpb24gUk9NIGF0IGZiNTQwMDAwIFtkaXNhYmxlZF0gW3NpemU9MjU2S10NCj4+
PiAgICAgICAgICAgICAgICBDYXBhYmlsaXRpZXM6IFs0NF0gUG93ZXIgTWFuYWdlbWVudCB2ZXJz
aW9uIDMNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRmxhZ3M6IFBNRUNsay0g
RFNJLSBEMS0gRDItIEF1eEN1cnJlbnQ9MG1BIFBNRShEMC0sRDEtLEQyLSxEM2hvdC0sRDNjb2xk
LSkNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgU3RhdHVzOiBEMCBOb1NvZnRS
c3QrIFBNRS1FbmFibGUtIERTZWw9MCBEU2NhbGU9MCBQTUUtDQo+Pj4gICAgICAgICAgICAgICAg
Q2FwYWJpbGl0aWVzOiBbNGNdIEV4cHJlc3MgKHYyKSBFbmRwb2ludCwgTVNJIDAwDQo+Pj4gICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgIERldkNhcDogICAgICAgICAgICAgICAgTWF4UGF5
bG9hZCAyMDQ4IGJ5dGVzLCBQaGFudEZ1bmMgMCwgTGF0ZW5jeSBMMHMgPDR1cywgTDEgPDF1cw0K
Pj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRXh0VGFn
LSBBdHRuQnRuLSBBdHRuSW5kLSBQd3JJbmQtIFJCRSsgRkxSZXNldCsgU2xvdFBvd2VyTGltaXQg
MC4wMDBXDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIERldkN0bDogIFJlcG9y
dCBlcnJvcnM6IENvcnJlY3RhYmxlKyBOb24tRmF0YWwrIEZhdGFsKyBVbnN1cHBvcnRlZCsNCj4+
PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFJseGRPcmQt
IEV4dFRhZy0gUGhhbnRGdW5jLSBBdXhQd3ItIE5vU25vb3ArIEZMUmVzZXQtDQo+Pj4gICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBNYXhQYXlsb2FkIDI1NiBi
eXRlcywgTWF4UmVhZFJlcSA0MDk2IGJ5dGVzDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgIERldlN0YTogQ29yckVycisgVW5jb3JyRXJyLSBGYXRhbEVyci0gVW5zdXBwUmVxKyBB
dXhQd3ItIFRyYW5zUGVuZC0NCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgTG5r
Q2FwOiBQb3J0ICMwLCBTcGVlZCA4R1QvcywgV2lkdGggeDgsIEFTUE0gTDBzIEwxLCBFeGl0IExh
dGVuY3kgTDBzIDw1MTJucywgTDEgPDJ1cw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgQ2xvY2tQTS0gU3VycHJpc2UtIExMQWN0UmVwLSBCd05vdC0g
QVNQTU9wdENvbXArDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIExua0N0bDog
IEFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRlcyBEaXNhYmxlZC0gQ29tbUNsaysNCj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEV4dFN5bmNoLSBDbG9j
a1BNLSBBdXRXaWREaXMtIEJXSW50LSBBdXRCV0ludC0NCj4+PiAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgTG5rU3RhOiAgU3BlZWQgOEdUL3MsIFdpZHRoIHg4LCBUckVyci0gVHJhaW4t
IFNsb3RDbGsrIERMQWN0aXZlLSBCV01nbXQtIEFCV01nbXQtDQo+Pj4gICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgIERldkNhcDI6IENvbXBsZXRpb24gVGltZW91dDogUmFuZ2UgQiwgVGlt
ZW91dERpcyssIExUUi0sIE9CRkYgTm90IFN1cHBvcnRlZA0KPj4+ICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQt
IDEyOGJpdENBUy0NCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgRGV2Q3RsMjog
Q29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtLCBMVFItLCBPQkZG
IERpc2FibGVkDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBBdG9taWNPcHNDdGw6IFJlcUVuLQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBMbmtDdGwyOiBUYXJnZXQgTGluayBTcGVlZDogOEdUL3MsIEVudGVyQ29tcGxpYW5jZS0g
U3BlZWREaXMtDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBUcmFuc21pdCBNYXJnaW46IE5vcm1hbCBPcGVyYXRpbmcgUmFuZ2UsIEVudGVyTW9kaWZp
ZWRDb21wbGlhbmNlLSBDb21wbGlhbmNlU09TLQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgQ29tcGxpYW5jZSBEZS1lbXBoYXNpczogLTZkQg0KPj4+
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhh
c2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25Db21wbGV0ZSssIEVxdWFsaXphdGlvblBoYXNl
MSsNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEVx
dWFsaXphdGlvblBoYXNlMissIEVxdWFsaXphdGlvblBoYXNlMyssIExpbmtFcXVhbGl6YXRpb25S
ZXF1ZXN0LQ0KPj4+ICAgICAgICAgICAgICAgIENhcGFiaWxpdGllczogWzg4XSBWaXRhbCBQcm9k
dWN0IERhdGENCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgUHJvZHVjdCBOYW1l
OiBRTG9naWMgMzJHYiAyLXBvcnQgRkMgdG8gUENJZSBHZW4zIHg4IEFkYXB0ZXINCj4+PiAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgUmVhZC1vbmx5IGZpZWxkczoNCj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtQTl0gUGFydCBudW1iZXI6
IFFMRTI3NDINCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgIFtTTl0gU2VyaWFsIG51bWJlcjogUkZEMTcwNlIyMjYxMQ0KPj4+ICAgICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgW0VDXSBFbmdpbmVlcmluZyBjaGFuZ2Vz
OiBCSzMyMTA0MDgtMDUgMDQNCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICAgIFtWOV0gVmVuZG9yIHNwZWNpZmljOiAwMTAxODkNCj4+PiAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIFtSVl0gUmVzZXJ2ZWQ6IGNoZWNr
c3VtIGdvb2QsIDAgYnl0ZShzKSByZXNlcnZlZA0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBFbmQNCj4+PiAgICAgICAgICAgICAgICBDYXBhYmlsaXRpZXM6IFs5MF0gTVNJLVg6
IEVuYWJsZSsgQ291bnQ9MTYgTWFza2VkLQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICBWZWN0b3IgdGFibGU6IEJBUj0yIG9mZnNldD0wMDAwMDAwMA0KPj4+ICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBQQkE6IEJBUj0yIG9mZnNldD0wMDAwMTAwMA0KPj4+ICAgICAg
ICAgICAgICAgIENhcGFiaWxpdGllczogWzljXSBWZW5kb3IgU3BlY2lmaWMgSW5mb3JtYXRpb246
IExlbj0wYyA8Pz4NCj4+PiAgICAgICAgICAgICAgICBDYXBhYmlsaXRpZXM6IFsxMDAgdjFdIEFk
dmFuY2VkIEVycm9yIFJlcG9ydGluZw0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICBVRVN0YTogICBETFAtIFNERVMtIFRMUC0gRkNQLSBDbXBsdFRPLSBDbXBsdEFicnQtIFVueENt
cGx0LSBSeE9GLSBNYWxmVExQLSBFQ1JDLSBVbnN1cFJlcS0gQUNTVmlvbC0NCj4+PiAgICAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgVUVNc2s6IERMUC0gU0RFUy0gVExQLSBGQ1AtIENtcGx0
VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAtIEVDUkMtIFVuc3VwUmVxLSBB
Q1NWaW9sLQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBVRVN2cnQ6IERMUCsg
U0RFUysgVExQLSBGQ1ArIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YrIE1hbGZU
TFArIEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICBDRVN0YTogICBSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91
dC0gTm9uRmF0YWxFcnItDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIENFTXNr
OiBSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gTm9uRmF0YWxFcnIr
DQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIEFFUkNhcDogICAgICAgICAgICAg
ICBGaXJzdCBFcnJvciBQb2ludGVyOiAwMCwgRUNSQ0dlbkNhcCsgRUNSQ0dlbkVuLSBFQ1JDQ2hr
Q2FwKyBFQ1JDQ2hrRW4tDQo+Pj4gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgICAgICBNdWx0SGRyUmVjQ2FwLSBNdWx0SGRyUmVjRW4tIFRMUFBmeFByZXMtIEhkckxv
Z0NhcC0NCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgSGVhZGVyTG9nOiAwMDAw
MDAwMCAwMDAwMDAwMCAwMDAwMDAwMCAwMDAwMDAwMA0KPj4+ICAgICAgICAgICAgICAgIENhcGFi
aWxpdGllczogWzE1NCB2MV0gQWx0ZXJuYXRpdmUgUm91dGluZy1JRCBJbnRlcnByZXRhdGlvbiAo
QVJJKQ0KPj4+ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBBUklDYXA6IE1GVkMtIEFD
Uy0sIE5leHQgRnVuY3Rpb246IDENCj4+PiAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAg
QVJJQ3RsOiAgIE1GVkMtIEFDUy0sIEZ1bmN0aW9uIEdyb3VwOiAwDQo+Pj4gICAgICAgICAgICAg
ICAgQ2FwYWJpbGl0aWVzOiBbMWMwIHYxXSAjMTkNCj4+PiAgICAgICAgICAgICAgICBDYXBhYmls
aXRpZXM6IFsxZjQgdjFdIFZlbmRvciBTcGVjaWZpYyBJbmZvcm1hdGlvbjogSUQ9MDAwMSBSZXY9
MSBMZW49MDE0IDw/Pg0KPj4+ICAgICAgICAgICAgICAgIEtlcm5lbCBkcml2ZXIgaW4gdXNlOiBx
bGEyeHh4DQo+Pj4gICAgICAgICAgICAgICAgS2VybmVsIG1vZHVsZXM6IHFsYTJ4eHgNCj4+PiAN
Cj4+PiAjIGNhdCAvc3lzL2J1cy9wY2kvZGV2aWNlcy8wMDAwXDowM1w6MDAuMC92cGQNCj4+PiBS
RkQxNzA2UjIyNjExRUNCSzMyMTA0MDgtMDUgMDRWOTAxMDE4OVJW77+9eA0KPj4+IA0KPj4+IENh
biB5b3Ugc2hhcmUgc29tZSBtb3JlIGluc2lnaHQgaW50byB3aGVyZSB5b3UgZW5jb3VudGVyZWQg
aXNzdWU/IEkgYW0gaW4gcHJvY2VzcyBvZiByZXZlcnRpbmcgdGhpcyBwYXRjaCBmcm9tIHVwc3Ry
ZWFtIGtlcm5lbCBidXQgd2FudGVkIHRvIHJlYWNoIG91dCBhbmQgZmluZCBvdXQgaWYgeW91IHN0
aWxsIGhhdmUgc2V0dXAgdG8gcHJvdmlkZSBtb3JlIGNvbnRleHQuDQo+PiANCj4+IDBkNTM3MGQx
ZDg1MiAoIlBDSTogUHJldmVudCBWUEQgYWNjZXNzIGZvciBRTG9naWMgSVNQMjcyMiIpIHByZXZl
bnRlZA0KPj4gYSBwYW5pYyB3aGlsZSByZWFkaW5nIFZQRCwgc28gd2UgY2FuJ3Qgc2ltcGx5IHJl
dmVydCBpdC4NCj4+IA0KPj4gU2luY2UgeW91IGRvbid0IHNlZSBhIHBhbmljIHdoaWxlIHJlYWRp
bmcgVlBEIGZyb20gdGhhdCBkZXZpY2UsIGl0J3MNCj4+IHBvc3NpYmxlIHRoYXQgYSBRTG9naWMg
ZmlybXdhcmUgY2hhbmdlIGZpeGVkIHRoZSBWUEQgZm9ybWF0IHNvIExpbnV4DQo+PiBubyBsb25n
ZXIgcmVhZHMgdGhlIGFyZWEgdGhhdCBjYXVzZWQgdGhlIHByb2JsZW0uICBPciBwb3NzaWJseSB5
b3VyDQo+PiBzeXN0ZW0gZG9lc24ndCBoYW5kbGUgdGhlIGNvbmZpZyByZWFkIGVycm9yIHRoZSBz
YW1lIHdheSBFdGhhbidzIEhQDQo+PiBETDM4MCBkb2VzLiAgVW5mb3J0dW5hdGVseSB3ZSBkb24n
dCBoYXZlIGFuIGFjdHVhbCBQQ0llIGFuYWx5emVyIHRyYWNlDQo+PiBmcm9tIEV0aGFuJ3Mgc3lz
dGVtLCBzbyB3ZSBkb24ndCBrbm93IGV4YWN0bHkgd2hhdCBoYXBwZW5lZCBvbiBQQ0llLg0KPj4g
DQo+PiBJIHN1Z2dlc3QgdGhhdCB5b3UgY2FwdHVyZSB0aGUgZW50aXJlIFZQRCBhcmVhIGFuZCBo
ZXhkdW1wIGl0LCBlLmcuLA0KPj4gd2l0aCAieHhkIiwgYW5kIGxvb2sgYXQgaXRzIHN0cnVjdHVy
ZS4gIHBjaV92cGRfc2l6ZSgpIHBhcnNlcyBpdCBhbmQNCj4+IGNvbXB1dGVzIHRoZSB2YWxpZCBz
aXplIGJhc2VkIG9uIGEgUENJX1ZQRF9TVElOX0VORCB0YWcsIGFuZA0KPj4gcGNpX3ZwZF9yZWFk
KCkgc2hvdWxkIG5vdCByZWFkIHBhc3QgdGhhdCBzaXplLg0KPj4gDQo+PiBBbmQgeW91ICpkbyog
aGF2ZSBhbiBhbmFseXplciB0cmFjZS4gIElmIG5ldyBRTG9naWMgZmlybXdhcmUgZml4ZWQgdGhl
DQo+PiBWUEQgZm9ybWF0LCB0aGUgdHJhY2Ugc2hvdWxkIHNob3cgdGhhdCBMaW51eCByZWFkIG9u
bHkgdGhlIHZhbGlkIHBhcnQNCj4+IG9mIFZQRCwgYW5kIHRoZXJlIHNob3VsZCBiZSBubyBlcnJv
cnMgaW4gdGhlIHRyYWNlLiAgVGhlbiBpdCBtaWdodA0KPj4ganVzdCBiZSBhIHF1ZXN0aW9uIG9m
IHR3ZWFraW5nIHRoZSBxdWlyayBzbyBpdCBhbGxvd3MgVlBEIHJlYWRzIGlmIHRoZQ0KPj4gZmly
bXdhcmUgaXMgbmV3IGVub3VnaC4NCj4+IA0KPj4gQnV0IGlmIHRoZSB0cmFjZSBkb2VzIHNob3cg
Y29uZmlnIHJlYWRzIHdpdGggZXJyb3JzLCB0aGVuIGl0IG1pZ2h0IGJlDQo+PiB0aGF0IHlvdXIg
c3lzdGVtIGp1c3QgdG9sZXJhdGVzIHRoZSBlcnJvcnMgd2hpbGUgdGhlIERMMzgwIGRpZCBub3Qu
DQo+PiBUaGVuIHdlJ2QgaGF2ZSB0byBmaWd1cmUgb3V0IGV4YWN0bHkgd2hhdCB0aGUgZXJyb3Ig
d2FzIGFuZCBob3cgdG8NCj4+IGRlYWwgd2l0aCBpdCBzbyB0aGluZ3Mgd29yayBvbiBib3RoIHlv
dXIgc3lzdGVtIGFuZCBFdGhhbidzLg0KPj4gDQo+PiBCam9ybg0KDQoNCkkgaGF2ZSB2ZXJpZmll
ZCBhZnRlciByZXZlcnRpbmcgcGF0Y2ggb24gSFAgREwzODAgR2VuMTAgaGFyZHdhcmUgYnkgY2Fw
dHVyaW5nIFBDSWUgdHJhY2UNCg0KSGVyZeKAmXMgc25pcHBldCBmcm9tIGRtaWRlY29kZSBvdXRw
dXQgDQoNClN5c3RlbSBJbmZvcm1hdGlvbjoNCk1hbnVmYWN0dXJlcjogSFBFDQpQcm9kdWN0IE5h
bWU6IFByb0xpYW50IERMMzgwIEdlbjEwDQpGYW1pbHk6IFByb0xpYW50DQogICAgICAgIA0KV2Ug
YXJlIGFibGUgdG8gc3VjY2Vzc2Z1bGx5IHJlYWQgVlBEIGNvbmZpZyBkYXRhIHVzaW5nIGxzcGNp
IGFuZCBjYXQgY29tbWFuZA0KDQojIGxzcGNpIC1kMTA3NzoNCjEzOjAwLjAgRmlicmUgQ2hhbm5l
bDogUUxvZ2ljIENvcnAuIElTUDI3MjItYmFzZWQgMTYvMzJHYiBGaWJyZSBDaGFubmVsIHRvIFBD
SWUgQWRhcHRlciAocmV2IDAxKQ0KMTM6MDAuMSBGaWJyZSBDaGFubmVsOiBRTG9naWMgQ29ycC4g
SVNQMjcyMi1iYXNlZCAxNi8zMkdiIEZpYnJlIENoYW5uZWwgdG8gUENJZSBBZGFwdGVyIChyZXYg
MDEpDQpbcm9vdEBSOCB+XSMgbHNwY2kgLXZ2diAtcyAxMzowMC4wDQoxMzowMC4wIEZpYnJlIENo
YW5uZWw6IFFMb2dpYyBDb3JwLiBJU1AyNzIyLWJhc2VkIDE2LzMyR2IgRmlicmUgQ2hhbm5lbCB0
byBQQ0llIEFkYXB0ZXIgKHJldiAwMSkNCglTdWJzeXN0ZW06IFFMb2dpYyBDb3JwLiBRTEUyNzQy
IER1YWwgUG9ydCAzMkdiIEZpYnJlIENoYW5uZWwgdG8gUENJZSBBZGFwdGVyDQoJUGh5c2ljYWwg
U2xvdDogMw0KCUNvbnRyb2w6IEkvTy0gTWVtKyBCdXNNYXN0ZXIrIFNwZWNDeWNsZS0gTWVtV0lO
Vi0gVkdBU25vb3AtIFBhckVycisgU3RlcHBpbmctIFNFUlIrIEZhc3RCMkItIERpc0lOVHgtDQoJ
U3RhdHVzOiBDYXArIDY2TUh6LSBVREYtIEZhc3RCMkItIFBhckVyci0gREVWU0VMPWZhc3QgPlRB
Ym9ydC0gPFRBYm9ydC0gPE1BYm9ydC0gPlNFUlItIDxQRVJSLSBJTlR4LQ0KCUxhdGVuY3k6IDAs
IENhY2hlIExpbmUgU2l6ZTogNjQgYnl0ZXMNCglJbnRlcnJ1cHQ6IHBpbiBBIHJvdXRlZCB0byBJ
UlEgMjgNCglOVU1BIG5vZGU6IDANCglSZWdpb24gMDogTWVtb3J5IGF0IGRlNjA1MDAwICg2NC1i
aXQsIHByZWZldGNoYWJsZSkgW3NpemU9NEtdDQoJUmVnaW9uIDI6IE1lbW9yeSBhdCBkZTYwMjAw
MCAoNjQtYml0LCBwcmVmZXRjaGFibGUpIFtzaXplPThLXQ0KCVJlZ2lvbiA0OiBNZW1vcnkgYXQg
ZGU1MDAwMDAgKDY0LWJpdCwgcHJlZmV0Y2hhYmxlKSBbc2l6ZT0xTV0NCglbdmlydHVhbF0gRXhw
YW5zaW9uIFJPTSBhdCBkZTgwMDAwMCBbZGlzYWJsZWRdIFtzaXplPTI1NktdDQoJQ2FwYWJpbGl0
aWVzOiBbNDRdIFBvd2VyIE1hbmFnZW1lbnQgdmVyc2lvbiAzDQoJCUZsYWdzOiBQTUVDbGstIERT
SS0gRDEtIEQyLSBBdXhDdXJyZW50PTBtQSBQTUUoRDAtLEQxLSxEMi0sRDNob3QtLEQzY29sZC0p
DQoJCVN0YXR1czogRDAgTm9Tb2Z0UnN0KyBQTUUtRW5hYmxlLSBEU2VsPTAgRFNjYWxlPTAgUE1F
LQ0KCUNhcGFiaWxpdGllczogWzRjXSBFeHByZXNzICh2MikgRW5kcG9pbnQsIE1TSSAwMA0KCQlE
ZXZDYXA6CU1heFBheWxvYWQgMjA0OCBieXRlcywgUGhhbnRGdW5jIDAsIExhdGVuY3kgTDBzIDw0
dXMsIEwxIDwxdXMNCgkJCUV4dFRhZy0gQXR0bkJ0bi0gQXR0bkluZC0gUHdySW5kLSBSQkUrIEZM
UmVzZXQrIFNsb3RQb3dlckxpbWl0IDI1LjAwMFcNCgkJRGV2Q3RsOglSZXBvcnQgZXJyb3JzOiBD
b3JyZWN0YWJsZSsgTm9uLUZhdGFsKyBGYXRhbCsgVW5zdXBwb3J0ZWQrDQoJCQlSbHhkT3JkKyBF
eHRUYWctIFBoYW50RnVuYy0gQXV4UHdyLSBOb1Nub29wKyBGTFJlc2V0LQ0KCQkJTWF4UGF5bG9h
ZCAyNTYgYnl0ZXMsIE1heFJlYWRSZXEgNDA5NiBieXRlcw0KCQlEZXZTdGE6CUNvcnJFcnIrIFVu
Y29yckVyci0gRmF0YWxFcnItIFVuc3VwcFJlcSsgQXV4UHdyLSBUcmFuc1BlbmQtDQoJCUxua0Nh
cDoJUG9ydCAjMCwgU3BlZWQgOEdUL3MsIFdpZHRoIHg4LCBBU1BNIEwwcyBMMSwgRXhpdCBMYXRl
bmN5IEwwcyA8NTEybnMsIEwxIDwydXMNCgkJCUNsb2NrUE0tIFN1cnByaXNlLSBMTEFjdFJlcC0g
QndOb3QtIEFTUE1PcHRDb21wKw0KCQlMbmtDdGw6CUFTUE0gRGlzYWJsZWQ7IFJDQiA2NCBieXRl
cyBEaXNhYmxlZC0gQ29tbUNsaysNCgkJCUV4dFN5bmNoLSBDbG9ja1BNLSBBdXRXaWREaXMtIEJX
SW50LSBBdXRCV0ludC0NCgkJTG5rU3RhOglTcGVlZCA4R1QvcywgV2lkdGggeDgsIFRyRXJyLSBU
cmFpbi0gU2xvdENsaysgRExBY3RpdmUtIEJXTWdtdC0gQUJXTWdtdC0NCgkJRGV2Q2FwMjogQ29t
cGxldGlvbiBUaW1lb3V0OiBSYW5nZSBCLCBUaW1lb3V0RGlzKywgTFRSLSwgT0JGRiBOb3QgU3Vw
cG9ydGVkDQoJCQkgQXRvbWljT3BzQ2FwOiAzMmJpdC0gNjRiaXQtIDEyOGJpdENBUy0NCgkJRGV2
Q3RsMjogQ29tcGxldGlvbiBUaW1lb3V0OiA1MHVzIHRvIDUwbXMsIFRpbWVvdXREaXMtLCBMVFIt
LCBPQkZGIERpc2FibGVkDQoJCQkgQXRvbWljT3BzQ3RsOiBSZXFFbi0NCgkJTG5rQ3RsMjogVGFy
Z2V0IExpbmsgU3BlZWQ6IDhHVC9zLCBFbnRlckNvbXBsaWFuY2UtIFNwZWVkRGlzLQ0KCQkJIFRy
YW5zbWl0IE1hcmdpbjogTm9ybWFsIE9wZXJhdGluZyBSYW5nZSwgRW50ZXJNb2RpZmllZENvbXBs
aWFuY2UtIENvbXBsaWFuY2VTT1MtDQoJCQkgQ29tcGxpYW5jZSBEZS1lbXBoYXNpczogLTZkQg0K
CQlMbmtTdGEyOiBDdXJyZW50IERlLWVtcGhhc2lzIExldmVsOiAtNmRCLCBFcXVhbGl6YXRpb25D
b21wbGV0ZSssIEVxdWFsaXphdGlvblBoYXNlMSsNCgkJCSBFcXVhbGl6YXRpb25QaGFzZTIrLCBF
cXVhbGl6YXRpb25QaGFzZTMrLCBMaW5rRXF1YWxpemF0aW9uUmVxdWVzdC0NCglDYXBhYmlsaXRp
ZXM6IFs4OF0gVml0YWwgUHJvZHVjdCBEYXRhDQoJCVByb2R1Y3QgTmFtZTogUUxvZ2ljIDMyR2Ig
Mi1wb3J0IEZDIHRvIFBDSWUgR2VuMyB4OCBBZGFwdGVyDQoJCVJlYWQtb25seSBmaWVsZHM6DQoJ
CQlbUE5dIFBhcnQgbnVtYmVyOiBRTEUyNzQyDQoJCQlbU05dIFNlcmlhbCBudW1iZXI6IEFGRDE1
MzNZMDI5OTkNCgkJCVtFQ10gRW5naW5lZXJpbmcgY2hhbmdlczogQkszMjEwNDA3LTA1IDAzDQoJ
CQlbVjldIFZlbmRvciBzcGVjaWZpYzogMDEwMTg5DQoJCQlbUlZdIFJlc2VydmVkOiBjaGVja3N1
bSBnb29kLCAwIGJ5dGUocykgcmVzZXJ2ZWQNCgkJRW5kDQoJQ2FwYWJpbGl0aWVzOiBbOTBdIE1T
SS1YOiBFbmFibGUrIENvdW50PTE2IE1hc2tlZC0NCgkJVmVjdG9yIHRhYmxlOiBCQVI9MiBvZmZz
ZXQ9MDAwMDAwMDANCgkJUEJBOiBCQVI9MiBvZmZzZXQ9MDAwMDEwMDANCglDYXBhYmlsaXRpZXM6
IFs5Y10gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBMZW49MGMgPD8+DQoJQ2FwYWJpbGl0
aWVzOiBbMTAwIHYxXSBBZHZhbmNlZCBFcnJvciBSZXBvcnRpbmcNCgkJVUVTdGE6CURMUC0gU0RF
Uy0gVExQLSBGQ1AtIENtcGx0VE8tIENtcGx0QWJydC0gVW54Q21wbHQtIFJ4T0YtIE1hbGZUTFAt
IEVDUkMtIFVuc3VwUmVxLSBBQ1NWaW9sLQ0KCQlVRU1zazoJRExQLSBTREVTLSBUTFAtIEZDUC0g
Q21wbHRUTy0gQ21wbHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBS
ZXEtIEFDU1Zpb2wtDQoJCVVFU3ZydDoJRExQLSBTREVTKyBUTFAtIEZDUC0gQ21wbHRUTy0gQ21w
bHRBYnJ0LSBVbnhDbXBsdC0gUnhPRi0gTWFsZlRMUC0gRUNSQy0gVW5zdXBSZXEtIEFDU1Zpb2wt
DQoJCUNFU3RhOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGltZW91dC0gTm9u
RmF0YWxFcnItDQoJCUNFTXNrOglSeEVyci0gQmFkVExQLSBCYWRETExQLSBSb2xsb3Zlci0gVGlt
ZW91dC0gTm9uRmF0YWxFcnIrDQoJCUFFUkNhcDoJRmlyc3QgRXJyb3IgUG9pbnRlcjogMDAsIEVD
UkNHZW5DYXArIEVDUkNHZW5Fbi0gRUNSQ0Noa0NhcCsgRUNSQ0Noa0VuLQ0KCQkJTXVsdEhkclJl
Y0NhcC0gTXVsdEhkclJlY0VuLSBUTFBQZnhQcmVzLSBIZHJMb2dDYXAtDQoJCUhlYWRlckxvZzog
MDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDAgMDAwMDAwMDANCglDYXBhYmlsaXRpZXM6IFsxNTQg
djFdIEFsdGVybmF0aXZlIFJvdXRpbmctSUQgSW50ZXJwcmV0YXRpb24gKEFSSSkNCgkJQVJJQ2Fw
OglNRlZDLSBBQ1MtLCBOZXh0IEZ1bmN0aW9uOiAxDQoJCUFSSUN0bDoJTUZWQy0gQUNTLSwgRnVu
Y3Rpb24gR3JvdXA6IDANCglDYXBhYmlsaXRpZXM6IFsxYzAgdjFdICMxOQ0KCUNhcGFiaWxpdGll
czogWzFmNCB2MV0gVmVuZG9yIFNwZWNpZmljIEluZm9ybWF0aW9uOiBJRD0wMDAxIFJldj0xIExl
bj0wMTQgPD8+DQoJS2VybmVsIGRyaXZlciBpbiB1c2U6IHFsYTJ4eHgNCglLZXJuZWwgbW9kdWxl
czogcWxhMnh4eA0KDQpXZSBhbHNvIHZlcmlmaWVkIHRoaXMgc2FtZSBjb25maWd1cmF0aW9uIG9u
IGEgU3VwZXJNaWNybyBYMTBTUkEtRiBzZXJ2ZXIgKHdoaWNoIGkgaGFkIHNlbnQgaW4gZWFybGll
ciBlbWFpbCnigJkNCmFuZCB3ZXJlIGFibGUgdG8gdmVyaWZ5IHRoYXQgdGhlIFZQRCByZWFkIHdh
cyBnb29kIGFuZCB0aGVyZSB3ZXJlIG5vIGVycm9ycyBvbiBQQ0llIHRyYWNlLiBHaXZlbiB0aGlz
IGluZm9ybWF0aW9uLCBQbGVhc2UgY29uc2lkZXIgcmV2ZXJ0aW5nIHRoZSBwYXRjaCB1bnRpbCB3
ZSBmdXJ0aGVyIGRlYnVnIHRoZSBpc3N1ZSBhbmQgcmVzb2x2ZSBhcyBpdCBpcw0KYWZmZWN0aW5n
IGdlbmVyYWwgYXZhaWxhYmlsaXR5IG9mIG91ciBhZGFwdGVyLg0KDQpUaGFua3MsDQpIaW1hbnNo
dQ==
