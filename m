Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E22CA169DFA
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 06:50:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726628AbgBXFuW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 00:50:22 -0500
Received: from mail-eopbgr00061.outbound.protection.outlook.com ([40.107.0.61]:47367
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgBXFuW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 00:50:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BA9ceZ08sOmOZjnswOwbkzyitxblHeI1dfNWw3TsxW/guw6Hd2ZZGuIDfr3igJOa6b0DpYVatNaCZM61+aSDLN/9DsMjipO2TC1u2lJZk4mv3tmkYJWgGiwfAukc7NJgF/wBbsD18ZI25dqVzK+SbInTvOCY5vymbOtdzsJYO5lN1Ko6+ZoQdhZkFDF/WvOuDiD2iITtHLUkr8fKzbmznYXDfFnpXZjKZcyA5iBOJ3wt/MqEzOsJBzPbT5DspEgS23GD+ank6so98xNqa1RWcT9+FOB9uqKzDPVrg+B4V/bC1Rgk2TB6icRRkB8T0/BRVtzR5OOdmFLjA66OQ0KiXg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3CZPU1botBRsYh0o78tuBpIGo+Bjl00w2xZvprdUDc=;
 b=C1XMiJfEv0+gWY7qFV7NBsXURuRjc5ftNtekX0w57GoPPvszlsnTOVjUTZ9BUNxz13Ugq3Ib8DWXjK7awoQDf2cMVH3KH/+I5G6zS65MZdApHouadc3zf8DquVRIzOcwwTZ2jP2cCpgTP2YL+z0JoM97Z9yA8VF8lGdLdcxIKtaZi34hfQpt1WrsmrdQxr9fz/Dd4vRJ7a+cOdmK7JvsXBZ2JmONCn8NwSbroHOedDVBfIUHk0nLv9PFG1tkDxRO/rom+WDYPPiCDW8vY7J2dSfK7ajzEDv3k4qmbQOcM3J9f4KBGiySXuFs1S+Z3Ht2CupfTny5EihirFUIlGeKiQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=Q3CZPU1botBRsYh0o78tuBpIGo+Bjl00w2xZvprdUDc=;
 b=Dj8h/CYFXEzlIW7RHySis27Tk5QwoHoAGNBtVXFc0bUtylcDt1mK3C+XnNZW/f2ybIx/NeJNiq+6KC7EMQ3FYzh8A8skBRbMWx7pcXFLFqKU+e+GagnEv6SMuBWNGBTPIK9tiw9lDFd3EwQXEE6A18Jf/0PN/2MoRQX0dP8MPyc=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6539.eurprd04.prod.outlook.com (20.179.249.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Mon, 24 Feb 2020 05:50:18 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 05:50:18 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <amurray@thegoodpenguin.co.uk>
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
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [PATCHv10 08/13] PCI: mobiveil: Add 8-bit and 16-bit CSR register
 accessors
Thread-Topic: [PATCHv10 08/13] PCI: mobiveil: Add 8-bit and 16-bit CSR
 register accessors
Thread-Index: AQHV4iOIUG4IkPYooEWqcxwqVxT/96gkYk8AgAWF8FA=
Date:   Mon, 24 Feb 2020 05:50:18 +0000
Message-ID: <DB8PR04MB6747E9173765F4113350ABF584EC0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-9-Zhiqiang.Hou@nxp.com>
 <20200220172924.GI19388@big-machine>
In-Reply-To: <20200220172924.GI19388@big-machine>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 1cdc7755-7a3f-4777-d0a2-08d7b8ed6dde
x-ms-traffictypediagnostic: DB8PR04MB6539:|DB8PR04MB6539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB653947BF72067D32B434FA2284EC0@DB8PR04MB6539.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6790;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(6916009)(55016002)(9686003)(33656002)(2906002)(186003)(26005)(478600001)(8676002)(8936002)(53546011)(7416002)(4326008)(86362001)(66946007)(7696005)(81156014)(81166006)(76116006)(71200400001)(66556008)(66446008)(5660300002)(316002)(52536014)(54906003)(66476007)(64756008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6539;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: PlfQmhJKn61tZVNzLvADKFdXANXk5X1aNI8YI7/8XwNYPMFtadhsnprKPXh0tB+IoZICXz+bH5biY9ovavPgm463jPcUOQbOJae7mNYQNJbHhQv9++uyTYrHVh9d59o1zAXxBnth9hSMcsXjrhYGwdnNwOZ1svz3UkARULKmMOZ8m8d9K91KcbdClYsvCDIPZwmyF2KKRqX3Xx6EEgDx3LEzG6cM0v5cFwqAPI+ydNAIv/qrmFUa0yGlNgLDhUzxsvvj3D4/Mof9zvx/77PqiXD4qgfztELG/AfiJPyVIVSqSOr3ZW2NiRxHbwDINLWYXkYAfk5i9GLMG6bk470o0JqZFPVoXg7ROXniuWoxWDOZbzd9e+V7vY3aVzZuCFlTMfuog9i3s1zi55G/2wK6kFL1eJ39lOHnPyjnfd5F0EU5dk/fZ6nuuFVVAB+tkIOy
x-ms-exchange-antispam-messagedata: /VfORrmy+1rVjvAFT01H/yHE3S7EPA1k45EhCNDGKWvKn4cJ/uGX19qJ8XomrYvnRX6Q9r+vqLf+1/qZB+Tu0EnaB8NGujVb3upMWTCTsSUJXfQE8rb9+Dox1+hkGHIWgJkgXyVYdUoaa35dT5o/zw==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1cdc7755-7a3f-4777-d0a2-08d7b8ed6dde
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 05:50:18.5303
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 5Lue6is+3JaOGPMQXsNZQ/tXA63EpPDcuKLqfNNnm0NEaxLPIdSxVP96+YaABEjnGID64LKNTz+0FRYYrtCecQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6539
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpUaGFua3MsDQpa
aGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBN
dXJyYXkgPGFtdXJyYXlAdGhlZ29vZHBlbmd1aW4uY28udWs+DQo+IFNlbnQ6IDIwMjDE6jLUwjIx
yNUgMToyOQ0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQu
b3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2Vy
bmVsLm9yZzsNCj4gYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBhbmRy
ZXcubXVycmF5QGFybS5jb207DQo+IGFybmRAYXJuZGIuZGU7IG1hcmsucnV0bGFuZEBhcm0uY29t
OyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBt
LmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNv
bT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29t
OyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1QG54cC5jb20+
OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvDQo+IDx4aWFv
d2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjEwIDA4LzEzXSBQQ0k6IG1v
Yml2ZWlsOiBBZGQgOC1iaXQgYW5kIDE2LWJpdCBDU1INCj4gcmVnaXN0ZXIgYWNjZXNzb3JzDQo+
IA0KPiBPbiBUaHUsIEZlYiAxMywgMjAyMCBhdCAxMjowNjozOVBNICswODAwLCBaaGlxaWFuZyBI
b3Ugd3JvdGU6DQo+ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4N
Cj4gPg0KPiA+IFRoZXJlIGFyZSBzb21lIDgtYml0IGFuZCAxNi1iaXQgcmVnaXN0ZXJzIGluIFBD
SWUgY29uZmlndXJhdGlvbiBzcGFjZSwNCj4gPiBzbyBhZGQgdGhlc2UgYWNjZXNzb3JzIGFjY29y
ZGluZ2x5Lg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5I
b3VAbnhwLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlh
bkBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJy
YWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gDQo+IFJldmlld2VkLWJ5OiBBbmRyZXcgTXVycmF5
IDxhbXVycmF5QHRoZWdvb2RwZW5ndWluLmNvLnVrPg0KPiANCj4gPiAtLS0NCj4gPiBWMTA6DQo+
ID4gIC0gQ2hhbmdlZCB0aGUgcmV0dXJuIHR5cGVzIHRvIHJlZmxlY3QgdGhlIHNpemUgb2YgdGhl
IGFjY2Vzcy4NCj4gPg0KPiA+ICAuLi4vcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2Jp
dmVpbC5oICAgfCAyMw0KPiArKysrKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2Vk
LCAyMyBpbnNlcnRpb25zKCspDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gaW5kZXggNjIzYzVmMGM0NDQxLi43
MmM2MmI0ZDhmN2IgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2Jp
dmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21v
Yml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KPiA+IEBAIC0xODIsMTAgKzE4MiwzMyBAQCBzdGF0aWMg
aW5saW5lIHUzMiBtb2JpdmVpbF9jc3JfcmVhZGwoc3RydWN0DQo+IG1vYml2ZWlsX3BjaWUgKnBj
aWUsIHUzMiBvZmYpDQo+ID4gIAlyZXR1cm4gbW9iaXZlaWxfY3NyX3JlYWQocGNpZSwgb2ZmLCAw
eDQpOyAgfQ0KPiA+DQo+ID4gK3N0YXRpYyBpbmxpbmUgdTE2IG1vYml2ZWlsX2Nzcl9yZWFkdyhz
dHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyDQo+ID4gK29mZikgew0KPiA+ICsJcmV0dXJu
IG1vYml2ZWlsX2Nzcl9yZWFkKHBjaWUsIG9mZiwgMHgyKTsgfQ0KPiA+ICsNCj4gPiArc3RhdGlj
IGlubGluZSB1OCBtb2JpdmVpbF9jc3JfcmVhZGIoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUs
IHUzMg0KPiA+ICtvZmYpIHsNCj4gPiArCXJldHVybiBtb2JpdmVpbF9jc3JfcmVhZChwY2llLCBv
ZmYsIDB4MSk7IH0NCj4gPiArDQo+ID4gKw0KPiA+ICBzdGF0aWMgaW5saW5lIHZvaWQgbW9iaXZl
aWxfY3NyX3dyaXRlbChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTMyIHZhbCwNCj4gPiAg
CQkJCSAgICAgICB1MzIgb2ZmKQ0KPiA+ICB7DQo+ID4gIAltb2JpdmVpbF9jc3Jfd3JpdGUocGNp
ZSwgdmFsLCBvZmYsIDB4NCk7ICB9DQo+ID4NCj4gPiArc3RhdGljIGlubGluZSB2b2lkIG1vYml2
ZWlsX2Nzcl93cml0ZXcoc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUsIHUxNiB2YWwsDQo+ID4g
KwkJCQkgICAgICAgdTMyIG9mZikNCj4gPiArew0KPiA+ICsJbW9iaXZlaWxfY3NyX3dyaXRlKHBj
aWUsIHZhbCwgb2ZmLCAweDIpOyB9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW5saW5lIHZvaWQgbW9i
aXZlaWxfY3NyX3dyaXRlYihzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgdTggdmFsLA0KPiA+
ICsJCQkJICAgICAgIHUzMiBvZmYpDQo+ID4gK3sNCj4gPiArCW1vYml2ZWlsX2Nzcl93cml0ZShw
Y2llLCB2YWwsIG9mZiwgMHgxKTsgfQ0KPiA+ICsNCj4gPiAgI2VuZGlmIC8qIF9QQ0lFX01PQklW
RUlMX0ggKi8NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
