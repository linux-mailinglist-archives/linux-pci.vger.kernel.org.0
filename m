Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1526E47F71
	for <lists+linux-pci@lfdr.de>; Mon, 17 Jun 2019 12:16:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726754AbfFQKQd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 17 Jun 2019 06:16:33 -0400
Received: from mail-eopbgr130079.outbound.protection.outlook.com ([40.107.13.79]:2126
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726665AbfFQKQc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 17 Jun 2019 06:16:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=BW6L11scjUfsI0pCZmhuuLV+QBTvlOxF3DQPT34Pp3k=;
 b=ImgGxpQ7VvJEAxagnUpgTwvHuG7Oc9ctbCAeyLgbLlcGgxdWpbhOa8RMPKtpccaUR81EiMo6B9f8Gxd6eheEGUq+7zbnD+fuXLYSrrAfx4l4cxfJSwrydKQomDzt/qj6j0lGJhpZcSPMV0qCtL2WGLRAQGx0vvqRMo0PY6ZHjrI=
Received: from AM6PR04MB6742.eurprd04.prod.outlook.com (20.179.246.158) by
 AM6PR04MB3974.eurprd04.prod.outlook.com (52.135.160.143) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.11; Mon, 17 Jun 2019 10:16:28 +0000
Received: from AM6PR04MB6742.eurprd04.prod.outlook.com
 ([fe80::cdfd:dd0c:dcaf:95b1]) by AM6PR04MB6742.eurprd04.prod.outlook.com
 ([fe80::cdfd:dd0c:dcaf:95b1%7]) with mapi id 15.20.1987.014; Mon, 17 Jun 2019
 10:16:28 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "l.subrahmanya@mobiveil.co.in" <l.subrahmanya@mobiveil.co.in>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv5 19/20] PCI: mobiveil: Add 8-bit and 16-bit register
 accessors
Thread-Topic: [PATCHv5 19/20] PCI: mobiveil: Add 8-bit and 16-bit register
 accessors
Thread-Index: AQHU8Qro+GZR0qQ8kEqE4mrq0ZGBSKaYanwAgAPhqdCAA6/2gIAADLiQ
Date:   Mon, 17 Jun 2019 10:16:28 +0000
Message-ID: <AM6PR04MB6742900B101D8DA6359FA7D384EB0@AM6PR04MB6742.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-20-Zhiqiang.Hou@nxp.com>
 <20190612135400.GB15747@redmoon>
 <AM0PR04MB673802CE0891BC898B61EBA384E90@AM0PR04MB6738.eurprd04.prod.outlook.com>
 <20190617092901.GB18020@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190617092901.GB18020@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 2918e8af-3919-4a95-bea7-08d6f30cdc6e
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM6PR04MB3974;
x-ms-traffictypediagnostic: AM6PR04MB3974:
x-microsoft-antispam-prvs: <AM6PR04MB3974BD7699D6403BFF6A1C5884EB0@AM6PR04MB3974.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0071BFA85B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(376002)(346002)(366004)(136003)(396003)(13464003)(54534003)(189003)(199004)(25786009)(6436002)(186003)(66476007)(66556008)(66446008)(26005)(66946007)(66066001)(446003)(76116006)(73956011)(476003)(11346002)(71190400001)(71200400001)(7736002)(4326008)(74316002)(256004)(33656002)(64756008)(52536014)(7416002)(99286004)(102836004)(53546011)(55016002)(5660300002)(6916009)(6506007)(486006)(86362001)(478600001)(68736007)(81166006)(9686003)(53936002)(316002)(54906003)(3846002)(81156014)(8676002)(229853002)(2906002)(6116002)(6246003)(76176011)(8936002)(7696005)(14454004)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM6PR04MB3974;H:AM6PR04MB6742.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kMlCdLivJz4tbKWJajWKXM+KJyuUm6ssYqYYrIU7lnq5KWQn+QLZL9B9YL3NEBqA7ZSUtVED0s68pFxHYK/1jnHb0zWPapucWMITvMPHn9aEVWgRPYVR2UDjKS1ekPl2cjEdPU6S3B8FEeoHAWh6TnakCyPDASvhb0BCxVdRrw+gYOMFaHy7Y5eqUWzcVlO9w2cmt1Q415HacDkvIj2oCDXD5pkGrXeOQZAfozOSTvJoKtAyXSUL10gEc+YoRWeqm2k/jZAnTGN/Q6W4q8QT3wgVn5yWn8S7F/s6R/POC4K/VrUdAtNOCXadpmL0PTNZCHK70V0u1Mz0hPkEat1ZisoTy/xhfkvX/QPaNi6nRBbK6N5WxE2S4z97xhk4DiL34iIwVGh2GqECOlCJTfIGZo6xo9BZxBJ0Z5ceaMO90HI=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2918e8af-3919-4a95-bea7-08d6f30cdc6e
X-MS-Exchange-CrossTenant-originalarrivaltime: 17 Jun 2019 10:16:28.1806
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM6PR04MB3974
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gU2VudDogMjAxOeW5
tDbmnIgxN+aXpSAxNzoyOQ0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0K
PiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5p
bmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVs
QHZnZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwu
b3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5p
bjsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpDQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gTWluZ2thaSBI
dSA8bWluZ2thaS5odUBueHAuY29tPjsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+
Ow0KPiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQ
QVRDSHY1IDE5LzIwXSBQQ0k6IG1vYml2ZWlsOiBBZGQgOC1iaXQgYW5kIDE2LWJpdCByZWdpc3Rl
cg0KPiBhY2Nlc3NvcnMNCj4gDQo+IE9uIFNhdCwgSnVuIDE1LCAyMDE5IGF0IDAxOjEzOjQ4QU0g
KzAwMDAsIFoucS4gSG91IHdyb3RlOg0KPiA+IEhpIExvcmVuem8sDQo+ID4NCj4gPiA+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSBbbWFp
bHRvOmxvcmVuem8ucGllcmFsaXNpQGFybS5jb21dDQo+ID4gPiBTZW50OiAyMDE55bm0NuaciDEy
5pelIDIxOjU0DQo+ID4gPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiA+
ID4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMu
aW5mcmFkZWFkLm9yZzsNCj4gPiA+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiA+ID4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtk
dEBrZXJuZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsNCj4gPiA+IGwuc3VicmFobWFueWFA
bW9iaXZlaWwuY28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaQ0KPiA+ID4gPGxlb3lh
bmcubGlAbnhwLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBh
cm0uY29tOw0KPiA+ID4gTWluZ2thaSBIdSA8bWluZ2thaS5odUBueHAuY29tPjsgTS5oLiBMaWFu
DQo+IDxtaW5naHVhbi5saWFuQG54cC5jb20+Ow0KPiA+ID4gWGlhb3dlaSBCYW8gPHhpYW93ZWku
YmFvQG54cC5jb20+DQo+ID4gPiBTdWJqZWN0OiBSZTogW1BBVENIdjUgMTkvMjBdIFBDSTogbW9i
aXZlaWw6IEFkZCA4LWJpdCBhbmQgMTYtYml0DQo+ID4gPiByZWdpc3RlciBhY2Nlc3NvcnMNCj4g
PiA+DQo+ID4gPiBPbiBGcmksIEFwciAxMiwgMjAxOSBhdCAwODozNzowNUFNICswMDAwLCBaLnEu
IEhvdSB3cm90ZToNCj4gPiA+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhw
LmNvbT4NCj4gPiA+ID4NCj4gPiA+ID4gVGhlcmUgYXJlIHNvbWUgOC1iaXQgYW5kIDE2LWJpdCBy
ZWdpc3RlcnMgaW4gUENJZSBjb25maWd1cmF0aW9uDQo+ID4gPiA+IHNwYWNlLCBzbyBhZGQgYWNj
ZXNzb3JzIGZvciB0aGVtLg0KPiA+ID4gPg0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogTWluZ2h1
YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29tPg0KPiA+ID4gPiBSZXZpZXdlZC1ieTogU3Vi
cmFobWFueWEgTGluZ2FwcGEgPGwuc3VicmFobWFueWFAbW9iaXZlaWwuY28uaW4+DQo+ID4gPiA+
IC0tLQ0KPiA+ID4gPiBWNToNCj4gPiA+ID4gIC0gQ29ycmVjdGVkIGFuZCByZXRvdWNoZWQgdGhl
IHN1YmplY3QgYW5kIGNoYW5nZWxvZy4NCj4gPiA+ID4gIC0gTm8gZnVuY3Rpb25hbGl0eSBjaGFu
Z2UuDQo+ID4gPiA+DQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZl
aWwuYyB8IDIwICsrKysrKysrKysrKysrKysrKysrDQo+ID4gPiA+ICAxIGZpbGUgY2hhbmdlZCwg
MjAgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ID4gPiBpbmRleCA0MTFlOTc3OWRhMTIuLjQ1NmFk
ZmVlMzkzYyAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2ll
LW1vYml2ZWlsLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1v
Yml2ZWlsLmMNCj4gPiA+ID4gQEAgLTI2OCwxMSArMjY4LDMxIEBAIHN0YXRpYyB1MzIgY3NyX3Jl
YWRsKHN0cnVjdCBtb2JpdmVpbF9wY2llDQo+ID4gPiA+ICpwY2llLA0KPiA+ID4gdTMyIG9mZikN
Cj4gPiA+ID4gIAlyZXR1cm4gY3NyX3JlYWQocGNpZSwgb2ZmLCAweDQpOyAgfQ0KPiA+ID4gPg0K
PiA+ID4gPiArc3RhdGljIHUzMiBjc3JfcmVhZHcoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUs
IHUzMiBvZmYpIHsNCj4gPiA+ID4gKwlyZXR1cm4gY3NyX3JlYWQocGNpZSwgb2ZmLCAweDIpOyB9
DQo+ID4gPiA+ICsNCj4gPiA+ID4gK3N0YXRpYyB1MzIgY3NyX3JlYWRiKHN0cnVjdCBtb2JpdmVp
bF9wY2llICpwY2llLCB1MzIgb2ZmKSB7DQo+ID4gPiA+ICsJcmV0dXJuIGNzcl9yZWFkKHBjaWUs
IG9mZiwgMHgxKTsgfQ0KPiA+ID4gPiArDQo+ID4gPiA+ICBzdGF0aWMgdm9pZCBjc3Jfd3JpdGVs
KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llLCB1MzIgdmFsLCB1MzINCj4gPiA+ID4gb2ZmKSB7
DQo+ID4gPiA+ICAJY3NyX3dyaXRlKHBjaWUsIHZhbCwgb2ZmLCAweDQpOw0KPiA+ID4gPiAgfQ0K
PiA+ID4gPg0KPiA+ID4gPiArc3RhdGljIHZvaWQgY3NyX3dyaXRldyhzdHJ1Y3QgbW9iaXZlaWxf
cGNpZSAqcGNpZSwgdTMyIHZhbCwgdTMyDQo+ID4gPiA+ICtvZmYpIHsNCj4gPiA+ID4gKwljc3Jf
d3JpdGUocGNpZSwgdmFsLCBvZmYsIDB4Mik7DQo+ID4gPiA+ICt9DQo+ID4gPiA+ICsNCj4gPiA+
ID4gK3N0YXRpYyB2b2lkIGNzcl93cml0ZWIoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUsIHUz
MiB2YWwsIHUzMg0KPiA+ID4gPiArb2ZmKSB7DQo+ID4gPiA+ICsJY3NyX3dyaXRlKHBjaWUsIHZh
bCwgb2ZmLCAweDEpOw0KPiA+ID4gPiArfQ0KPiA+ID4gPiArDQo+ID4gPg0KPiA+ID4gVGhleSBh
cmUgbm90IHVzZWQgc28geW91IHNob3VsZCBkcm9wIHRoaXMgcGF0Y2guDQo+ID4NCj4gPiBOWFAg
TGF5ZXJzY2FwZSBQQ0llIEdlbjQgY29udHJvbGxlciBkcml2ZXIgd2lsbCB1c2UgdGhlbSwgc28g
ZG9uJ3QNCj4gPiBkcm9wIGl0Lg0KPiANCj4gWW91IGFkZCBmdW5jdGlvbnMgd2hlbiB0aGV5IGFy
ZSBuZWVkZWQsIHNvIGRyb3AgdGhpcyBwYXRjaCBhbmQgc3F1YXNoIGl0IHRvDQo+IHRoZSBwYXRj
aCB0aGF0IHVzZSB0aGVzZSBmdW5jdGlvbnMuDQo+DQoNClllcywgYWdyZWUsIHBsZWFzZSBkcm9w
IGl0IGZyb20gdGhpcyBwYXRjaCBzZXQuDQogDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IExvcmVu
em8NCj4gDQo+ID4gVGhhbmtzLA0KPiA+IFpoaXFpYW5nDQo+ID4NCj4gPiA+DQo+ID4gPiBMb3Jl
bnpvDQo+ID4gPg0KPiA+ID4gPiAgc3RhdGljIGJvb2wgbW9iaXZlaWxfcGNpZV9saW5rX3VwKHN0
cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKSAgew0KPiA+ID4gPiAgCXJldHVybiAoY3NyX3JlYWRs
KHBjaWUsIExUU1NNX1NUQVRVUykgJg0KPiA+ID4gPiAtLQ0KPiA+ID4gPiAyLjE3LjENCj4gPiA+
ID4NCg==
