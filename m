Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2DD1346D6D
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 03:14:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725996AbfFOBOg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 21:14:36 -0400
Received: from mail-eopbgr70057.outbound.protection.outlook.com ([40.107.7.57]:14660
        "EHLO EUR04-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfFOBOf (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 21:14:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=2o9r19ElmknWT/DGekY4AI4zXOQdJ5bAS0pWjfy73Ro=;
 b=kixVMxTgLjMAgOEbQn/PVxCQmiqkDkS5PGshzACqWZHhI79ySR6P+2THH8TvXrrtT96wDzikfeQO/7JB9eNbruZM1Vw6SEPiveVUG2sfUiDfJXUhpButMfMLS6M0UHj4R3Bv0n9mia9/NnLkZk4k77p3UB+sI7cDK9WsDJVHsyY=
Received: from AM0PR04MB6738.eurprd04.prod.outlook.com (20.179.253.203) by
 AM0PR04MB5043.eurprd04.prod.outlook.com (20.177.40.148) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Sat, 15 Jun 2019 01:13:48 +0000
Received: from AM0PR04MB6738.eurprd04.prod.outlook.com
 ([fe80::f41f:5455:d0b3:2527]) by AM0PR04MB6738.eurprd04.prod.outlook.com
 ([fe80::f41f:5455:d0b3:2527%4]) with mapi id 15.20.1987.013; Sat, 15 Jun 2019
 01:13:48 +0000
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
Thread-Index: AQHU8Qro+GZR0qQ8kEqE4mrq0ZGBSKaYanwAgAPhqdA=
Date:   Sat, 15 Jun 2019 01:13:48 +0000
Message-ID: <AM0PR04MB673802CE0891BC898B61EBA384E90@AM0PR04MB6738.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-20-Zhiqiang.Hou@nxp.com>
 <20190612135400.GB15747@redmoon>
In-Reply-To: <20190612135400.GB15747@redmoon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [27.186.246.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 885aab02-da50-4d5c-0893-08d6f12eb8b6
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB5043;
x-ms-traffictypediagnostic: AM0PR04MB5043:
x-microsoft-antispam-prvs: <AM0PR04MB50435ED13A44273A5A4B196984E90@AM0PR04MB5043.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1728;
x-forefront-prvs: 0069246B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(376002)(39860400002)(396003)(366004)(136003)(13464003)(54534003)(189003)(199004)(53546011)(229853002)(33656002)(6506007)(9686003)(76176011)(74316002)(71190400001)(71200400001)(7736002)(55016002)(68736007)(53936002)(478600001)(99286004)(7696005)(476003)(6116002)(3846002)(305945005)(486006)(6436002)(446003)(11346002)(2906002)(5660300002)(6246003)(25786009)(26005)(4326008)(54906003)(66446008)(64756008)(66946007)(66556008)(102836004)(7416002)(73956011)(6916009)(66476007)(316002)(76116006)(52536014)(186003)(81156014)(8676002)(86362001)(8936002)(81166006)(66066001)(14454004)(256004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5043;H:AM0PR04MB6738.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: Pyd5ytsRbfVDHMEAEPTKn8ZL6u1IC1LiOt2z3ap3oKSEwZXpArBDK2HUYAiTIyiVsb2FhgNbQ/KwzsEg0ICEEqqFB+Jb6uHoyeDWBPGEX6das6OHuZPsYYLBr47rHrtmS6j1PZQPus7D2vdyMmxRwwpSnN/qcUbrVAiFa79CP+eABudGgAKq4oCLeblgNHBW3n5brsaOPOL74ueFnHs8i77pD8NVAbIEEGLkJkDTL3geKBcZ1UuqGvE0nUuaBKqVT56adNkXADxVFxW1x+5HksoCo9R0brwzsHf8uzRKvsSFpasPjU3bOU3wIKBDf/lxJaNoIjPoXU6g31HInZKdOthjbHuoxJfIJn0WulSWTIaKRrCojqLcoVbk5QrULDfni7ALtQk10yb4Tol4lstr8D7DIehzGGSA4X0MbtqU5W4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 885aab02-da50-4d5c-0893-08d6f12eb8b6
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2019 01:13:48.7931
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5043
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSBbbWFpbHRvOmxvcmVuem8ucGllcmFsaXNpQGFybS5jb21dDQo+IFNlbnQ6
IDIwMTnE6jbUwjEyyNUgMjE6NTQNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNv
bT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxAbGlz
dHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2Vy
bmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGwuc3VicmFobWFueWFAbW9iaXZlaWwu
Y28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaQ0KPiA8bGVveWFuZy5saUBueHAuY29t
PjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207DQo+IE1pbmdr
YWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBueHAu
Y29tPjsNCj4gWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+IFN1YmplY3Q6IFJl
OiBbUEFUQ0h2NSAxOS8yMF0gUENJOiBtb2JpdmVpbDogQWRkIDgtYml0IGFuZCAxNi1iaXQgcmVn
aXN0ZXINCj4gYWNjZXNzb3JzDQo+IA0KPiBPbiBGcmksIEFwciAxMiwgMjAxOSBhdCAwODozNzow
NUFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFp
YW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVGhlcmUgYXJlIHNvbWUgOC1iaXQgYW5kIDE2LWJp
dCByZWdpc3RlcnMgaW4gUENJZSBjb25maWd1cmF0aW9uIHNwYWNlLA0KPiA+IHNvIGFkZCBhY2Nl
c3NvcnMgZm9yIHRoZW0uDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaW5naHVhbiBMaWFuIDxNaW5n
aHVhbi5MaWFuQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBh
IDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KPiA+IC0tLQ0KPiA+IFY1Og0KPiA+ICAt
IENvcnJlY3RlZCBhbmQgcmV0b3VjaGVkIHRoZSBzdWJqZWN0IGFuZCBjaGFuZ2Vsb2cuDQo+ID4g
IC0gTm8gZnVuY3Rpb25hbGl0eSBjaGFuZ2UuDQo+ID4NCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMgfCAyMCArKysrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZp
bGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+IGluZGV4IDQxMWU5Nzc5ZGExMi4uNDU2YWRmZWUz
OTNjIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVp
bC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4g
PiBAQCAtMjY4LDExICsyNjgsMzEgQEAgc3RhdGljIHUzMiBjc3JfcmVhZGwoc3RydWN0IG1vYml2
ZWlsX3BjaWUgKnBjaWUsDQo+IHUzMiBvZmYpDQo+ID4gIAlyZXR1cm4gY3NyX3JlYWQocGNpZSwg
b2ZmLCAweDQpOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHUzMiBjc3JfcmVhZHcoc3RydWN0
IG1vYml2ZWlsX3BjaWUgKnBjaWUsIHUzMiBvZmYpIHsNCj4gPiArCXJldHVybiBjc3JfcmVhZChw
Y2llLCBvZmYsIDB4Mik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB1MzIgY3NyX3JlYWRi
KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llLCB1MzIgb2ZmKSB7DQo+ID4gKwlyZXR1cm4gY3Ny
X3JlYWQocGNpZSwgb2ZmLCAweDEpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICBzdGF0aWMgdm9pZCBj
c3Jfd3JpdGVsKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llLCB1MzIgdmFsLCB1MzIgb2ZmKQ0K
PiA+IHsNCj4gPiAgCWNzcl93cml0ZShwY2llLCB2YWwsIG9mZiwgMHg0KTsNCj4gPiAgfQ0KPiA+
DQo+ID4gK3N0YXRpYyB2b2lkIGNzcl93cml0ZXcoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUs
IHUzMiB2YWwsIHUzMiBvZmYpDQo+ID4gK3sNCj4gPiArCWNzcl93cml0ZShwY2llLCB2YWwsIG9m
ZiwgMHgyKTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIHZvaWQgY3NyX3dyaXRlYihzdHJ1
Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyIHZhbCwgdTMyIG9mZikNCj4gPiArew0KPiA+ICsJ
Y3NyX3dyaXRlKHBjaWUsIHZhbCwgb2ZmLCAweDEpOw0KPiA+ICt9DQo+ID4gKw0KPiANCj4gVGhl
eSBhcmUgbm90IHVzZWQgc28geW91IHNob3VsZCBkcm9wIHRoaXMgcGF0Y2guDQoNCk5YUCBMYXll
cnNjYXBlIFBDSWUgR2VuNCBjb250cm9sbGVyIGRyaXZlciB3aWxsIHVzZSB0aGVtLCBzbyBkb24n
dCBkcm9wIGl0Lg0KDQpUaGFua3MsDQpaaGlxaWFuZw0KDQo+IA0KPiBMb3JlbnpvDQo+IA0KPiA+
ICBzdGF0aWMgYm9vbCBtb2JpdmVpbF9wY2llX2xpbmtfdXAoc3RydWN0IG1vYml2ZWlsX3BjaWUg
KnBjaWUpICB7DQo+ID4gIAlyZXR1cm4gKGNzcl9yZWFkbChwY2llLCBMVFNTTV9TVEFUVVMpICYN
Cj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
