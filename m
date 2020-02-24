Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 56FF3169E39
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 07:07:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbgBXGHJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 01:07:09 -0500
Received: from mail-eopbgr130051.outbound.protection.outlook.com ([40.107.13.51]:2182
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725895AbgBXGHJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 01:07:09 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dpVmtrAuUrUtHyEWUrwxV4sfxKrmm8tENPtazFyP6JM5HTmau8XXBZE5QfSMCKPSGufK/w+HCW5frkKA8sjRm2SkwhwPaYdO1As593GpkmvTcXKEjwYXjsoXzDPlM02Pwi+cg1fX1YzNlPsqtzYEA9U5UWGVE6y9S2M80NftrIZzdTeDj1f0x5eqZCBOXegmnRFaeslAo86WS5E6uOTSsBIgOQEkbeXlkdNVCXSlGBeDQX3/19/Kkhf4i9hZMybMq5IMfbvU9p1imUYxzD+QiLBY4v9YAkpkuAIccdTVHSXmmdqxVqwccx7mUMsFYfrO0k85yh3RuGGLY6bhJM1+YA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF5IRLeilON0cG/ZwJJe34yb0pfH65qycOHgxuHlpN4=;
 b=TRFrGayvjOlm2koBpJ3Dw9cMjiWhc63DXyHC83ltiSa1IMJSpbufJa7BS5fVyVdiqLFthQ0wMDyBE8NLICyqwD4GM/j4YF01rl647GZ4IWSWuLyqDtjVRZDuZM8D29KFE1MWHnyzdWf7ZArU37VueMoJyI7pPomx6EOQ/5vdrMXS345gaKayl7jSc0qwCvvX3TmDs567ielwkK3NUIBEHzEg36X1NXwW/BOK+vRWq09/M9pR9VXS0EiluyZfI2l5/bG1tRFQ1RGvXcA5W7r0TGxkA5nPbIt5HF45ObncoSThkK/zHPLe2rLnvh8SFeEXHEKEVsPMNcEFWNyXowItrw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=mF5IRLeilON0cG/ZwJJe34yb0pfH65qycOHgxuHlpN4=;
 b=cDCZIlzVYU4rjr2sI+tYaQTN5UmcJ28FVomXIy3Ofnj7MTlTAkzjiHxCMnE3mBgB7S2VrNXsPm+Bv3dJK7/vWP0fZ2Is61ASFlMpWtsWeAzHFjs6u0MeCQHYHKXdr8S1sCUL8jhKdFZcunC/yEbRWjtHAUTn1DOJILlM6boWJsA=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6714.eurprd04.prod.outlook.com (20.179.251.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.21; Mon, 24 Feb 2020 06:07:03 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 06:07:03 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "arnd@arndb.de" <arnd@arndb.de>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "m.karthikeyan@mobiveil.co.in" <m.karthikeyan@mobiveil.co.in>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv10 00/13] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Topic: [PATCHv10 00/13] PCI: Recode Mobiveil driver and add PCIe Gen4
 driver for NXP Layerscape SoCs
Thread-Index: AQHV4iNpQqKrUDxfhEGgXrza4vQEPqglni0AgARNvwA=
Date:   Mon, 24 Feb 2020 06:07:03 +0000
Message-ID: <DB8PR04MB67475A29B09B85F9628FFCE084EC0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200221121956.GC12711@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200221121956.GC12711@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: aba7d090-696f-40c3-9c42-08d7b8efc4c6
x-ms-traffictypediagnostic: DB8PR04MB6714:|DB8PR04MB6714:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB67149074A39E8047BCBAB91184EC0@DB8PR04MB6714.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:9508;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(6029001)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(199004)(189003)(6916009)(2906002)(86362001)(81166006)(8936002)(186003)(26005)(8676002)(81156014)(478600001)(4326008)(54906003)(53546011)(6506007)(66476007)(66946007)(64756008)(316002)(5660300002)(7416002)(66556008)(71200400001)(33656002)(55016002)(76116006)(66446008)(7696005)(52536014)(9686003);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6714;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 8AzsnILkO6VbjXnbRO06sJr95cTVSKv5cqd5fKV5UagzInIyqvCuY2Qt3vacOH+q678vjh+WfSRZG3aWsN6fdgVFB5sC89niZQDmbheHW9f2EPn9Suu7e9MwlNY2Ft0bPUDjgZ5skLfLwYliApArq4wxCTJGIW/DCQPhjIEQfkx1HrS1wD4JrcDFmGz2DAtxJpYpl6pLru5SgopbgpD+8JhIn1gX6pcz0ppfgEYT52KBomOOImXDoDHoP4EU2eDlfMQqi1uZJfvqqZFvwSLq1e7P4REpY2rCOxW9QOITR4r796bMn3nd5Pxl9G4TaD9kPK/o6pSbqnh5R9UhLplt95iqoqjIKcsfszThjXaeMUQ9lOBn+wY9ePN8uqJIugzLZOyNw8KcjstXu5KMAE8gyWKejYWGwLjDPMpicYeYS44GEHIYQwgc2OCFDYZykGS3
x-ms-exchange-antispam-messagedata: 8Kz8DmlnBbRxe+iEdm4mZGT00OcogtIp6+74w+vdYFu4eMBuMsSaTjXwJ6fqbIHvBK5R0PI3dwAv1hw4tssShrT8EXsn5l5F8rkgEE//OOv9PVighcBQ+KIuYFoyK4G1IzBC2Vi3Alv7GD277+yolw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: aba7d090-696f-40c3-9c42-08d7b8efc4c6
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 06:07:03.2670
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: Fpu7ONttSKSjGjAkInRzY7y+kb58NwdjEBS0hYWoUDviBDzrsJT3yZBNhE9566cByZ0QBxj6gFrvA3ceoQM7nA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAyMMTq
MtTCMjHI1SAyMDoyMA0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBD
YzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZy
YWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3Jn
OyBhbmRyZXcubXVycmF5QGFybS5jb207DQo+IGFybmRAYXJuZGIuZGU7IG1hcmsucnV0bGFuZEBh
cm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlA
bnhwLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOw0K
PiBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxp
YW5AbnhwLmNvbT47DQo+IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJq
ZWN0OiBSZTogW1BBVENIdjEwIDAwLzEzXSBQQ0k6IFJlY29kZSBNb2JpdmVpbCBkcml2ZXIgYW5k
IGFkZCBQQ0llDQo+IEdlbjQgZHJpdmVyIGZvciBOWFAgTGF5ZXJzY2FwZSBTb0NzDQo+IA0KPiBP
biBUaHUsIEZlYiAxMywgMjAyMCBhdCAxMjowNjozMVBNICswODAwLCBaaGlxaWFuZyBIb3Ugd3Jv
dGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPg0K
PiA+IFRoaXMgcGF0Y2ggc2V0IGlzIHRvIHJlY29kZSB0aGUgTW9iaXZlaWwgZHJpdmVyIGFuZCBh
ZGQgUENJZSBzdXBwb3J0DQo+ID4gZm9yIE5YUCBMYXllcnNjYXBlIHNlcmllcyBTb0NzIGludGVn
cmF0ZWQgTW9iaXZlaWwncyBQQ0llIEdlbjQNCj4gPiBjb250cm9sbGVyLg0KPiA+DQo+ID4gSG91
IFpoaXFpYW5nICgxMyk6DQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBJbnRyb2R1Y2UgYSBuZXcgc3Ry
dWN0dXJlIG1vYml2ZWlsX3Jvb3RfcG9ydA0KPiA+ICAgUENJOiBtb2JpdmVpbDogTW92ZSB0aGUg
aG9zdCBpbml0aWFsaXphdGlvbiBpbnRvIGEgZnVuY3Rpb24NCj4gPiAgIFBDSTogbW9iaXZlaWw6
IENvbGxlY3QgdGhlIGludGVycnVwdCByZWxhdGVkIG9wZXJhdGlvbnMgaW50byBhDQo+ID4gICAg
IGZ1bmN0aW9uDQo+ID4gICBQQ0k6IG1vYml2ZWlsOiBNb2R1bGFyaXplIHRoZSBNb2JpdmVpbCBQ
Q0llIEhvc3QgQnJpZGdlIElQIGRyaXZlcg0KPiA+ICAgUENJOiBtb2JpdmVpbDogQWRkIGNhbGxi
YWNrIGZ1bmN0aW9uIGZvciBpbnRlcnJ1cHQgaW5pdGlhbGl6YXRpb24NCj4gPiAgIFBDSTogbW9i
aXZlaWw6IEFkZCBjYWxsYmFjayBmdW5jdGlvbiBmb3IgbGluayB1cCBjaGVjaw0KPiA+ICAgUENJ
OiBtb2JpdmVpbDogQWxsb3cgbW9iaXZlaWxfaG9zdF9pbml0KCkgdG8gYmUgdXNlZCB0byByZS1p
bml0IGhvc3QNCj4gPiAgIFBDSTogbW9iaXZlaWw6IEFkZCA4LWJpdCBhbmQgMTYtYml0IENTUiBy
ZWdpc3RlciBhY2Nlc3NvcnMNCj4gPiAgIFBDSTogbW9iaXZlaWw6IEFkZCBIZWFkZXIgVHlwZSBm
aWVsZCBjaGVjaw0KPiA+ICAgZHQtYmluZGluZ3M6IFBDSTogQWRkIE5YUCBMYXllcnNjYXBlIFNv
Q3MgUENJZSBHZW40IGNvbnRyb2xsZXINCj4gPiAgIFBDSTogbW9iaXZlaWw6IEFkZCBQQ0llIEdl
bjQgUkMgZHJpdmVyIGZvciBOWFAgTGF5ZXJzY2FwZSBTb0NzDQo+ID4gICBhcm02NDogZHRzOiBs
eDIxNjBhOiBBZGQgUENJZSBjb250cm9sbGVyIERUIG5vZGVzDQo+ID4gICBhcm02NDogZGVmY29u
ZmlnOiBFbmFibGUgQ09ORklHX1BDSUVfTEFZRVJTQ0FQRV9HRU40DQo+ID4NCj4gPiAgLi4uL2Jp
bmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaWUtZ2VuNC50eHQgICAgIHwgIDUyICsrDQo+ID4gIE1B
SU5UQUlORVJTICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAxMCArLQ0KPiA+
ICAuLi4vYXJtNjQvYm9vdC9kdHMvZnJlZXNjYWxlL2ZzbC1seDIxNjBhLmR0c2kgfCAxNjMgKysr
KysNCj4gPiAgYXJjaC9hcm02NC9jb25maWdzL2RlZmNvbmZpZyAgICAgICAgICAgICAgICAgIHwg
ICAxICsNCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9LY29uZmlnICAgICAgICAgICAgICAg
IHwgIDExICstDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvTWFrZWZpbGUgICAgICAgICAg
ICAgICB8ICAgMiArLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL0tjb25m
aWcgICAgICAgfCAgMzMgKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL01h
a2VmaWxlICAgICAgfCAgIDUgKw0KPiA+ICAuLi4vbW9iaXZlaWwvcGNpZS1sYXllcnNjYXBlLWdl
bjQuYyAgICAgICAgICAgfCAyNjcgKysrKysrKysrDQo+ID4gIC4uLi9wY2llLW1vYml2ZWlsLWhv
c3QuY30gICAgICAgICAgICAgICAgICAgICB8IDU2NCArKysrLS0tLS0tLS0tLS0tLS0NCj4gPiAg
Li4uL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC1wbGF0LmMgIHwgIDYxICsrDQo+
ID4gIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmMgICB8IDIzMCAr
KysrKysrDQo+ID4gIC4uLi9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgg
ICB8IDIyNiArKysrKysrDQo+ID4gIDEzIGZpbGVzIGNoYW5nZWQsIDExNzAgaW5zZXJ0aW9ucygr
KSwgNDU1IGRlbGV0aW9ucygtKSAgY3JlYXRlIG1vZGUNCj4gPiAxMDA2NDQgRG9jdW1lbnRhdGlv
bi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaWUtZ2VuNC50eHQNCj4gPiAg
Y3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZp
Zw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVp
bC9NYWtlZmlsZQ0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQNCj4gPiBkcml2ZXJzL3BjaS9jb250
cm9sbGVyL21vYml2ZWlsL3BjaWUtbGF5ZXJzY2FwZS1nZW40LmMNCj4gPiAgcmVuYW1lIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIve3BjaWUtbW9iaXZlaWwuYyA9Pg0KPiA+IG1vYml2ZWlsL3BjaWUt
bW9iaXZlaWwtaG9zdC5jfSAoNTQlKSAgY3JlYXRlIG1vZGUgMTAwNjQ0DQo+ID4gZHJpdmVycy9w
Y2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLXBsYXQuYw0KPiA+ICBjcmVhdGUg
bW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWls
LmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZl
aWwvcGNpZS1tb2JpdmVpbC5oDQo+IA0KPiBJIGRyb3BwZWQgdGhlIGxhc3QgdHdvIHBhdGNoZXMg
c2luY2UgdGhleSBtdXN0IGJlIHJlLXJvdXRlZCB2aWEgYXJtLXNvYw0KPiAoZGVmY29uZmlnIHVw
ZGF0ZSBhbmQgZHRzKSwgSSB0d2Vha2VkIG1vc3Qgb2YgY29tbWl0IGxvZ3MgYW5kIGFwcGxpZWQg
dGhlDQo+IHNlcmllcyB0byBwY2kvbW9iaXZlaWwsIHBsZWFzZSBjaGVjayBldmVyeXRoaW5nIGlz
IGluIG9yZGVyLg0KIA0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGhlbHAgb24gdGhlIGNvbW1pdCBs
b2dzIQ0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IA0KPiBUaGFua3MsDQo+IExvcmVuem8NCg==
