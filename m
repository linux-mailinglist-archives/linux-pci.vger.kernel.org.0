Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5888B46D89
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 03:30:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbfFOBaq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Jun 2019 21:30:46 -0400
Received: from mail-eopbgr20057.outbound.protection.outlook.com ([40.107.2.57]:28132
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725942AbfFOBap (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 14 Jun 2019 21:30:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=o5vkisYtIbqfiEurLs2+ppk6v+mAxXEQWvAbFwxNFuU=;
 b=IpdANU259x0WXBAeHHucRtfyiAG2tS0brmyNbTxxfwH6+XqILTAq8oDLg6BUnFdTvI3bkZaNsnG9nIhY4QRfCrpXATzVWkSiW1SdbEuGkh72/Z8oLccg7QMzki2W5Zw42Tcz7Tm+KQlXe++45LKr4oScPQMdcDLEb32mx0KSrPg=
Received: from AM0PR04MB6738.eurprd04.prod.outlook.com (20.179.253.203) by
 AM0PR04MB6435.eurprd04.prod.outlook.com (20.179.252.216) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.13; Sat, 15 Jun 2019 01:30:39 +0000
Received: from AM0PR04MB6738.eurprd04.prod.outlook.com
 ([fe80::f41f:5455:d0b3:2527]) by AM0PR04MB6738.eurprd04.prod.outlook.com
 ([fe80::f41f:5455:d0b3:2527%4]) with mapi id 15.20.1987.013; Sat, 15 Jun 2019
 01:30:39 +0000
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
Subject: RE: [PATCHv5 04/20] PCI: mobiveil: Remove the flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Topic: [PATCHv5 04/20] PCI: mobiveil: Remove the flag
 MSI_FLAG_MULTI_PCI_MSI
Thread-Index: AQHU8Qqz/gJFKoxI7kSHS+a5VfCWFaaXDAuAgAE1ccCAABw2gIAD74cQ
Date:   Sat, 15 Jun 2019 01:30:39 +0000
Message-ID: <AM0PR04MB6738B93C7F1B5BE433753CF584E90@AM0PR04MB6738.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-5-Zhiqiang.Hou@nxp.com>
 <20190611165935.GA22836@redmoon>
 <AM0PR04MB67383023B81AEB33DAF9C35584EC0@AM0PR04MB6738.eurprd04.prod.outlook.com>
 <20190612130813.GA15747@redmoon>
In-Reply-To: <20190612130813.GA15747@redmoon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [27.186.246.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 72482e0c-a4f1-4742-33f9-08d6f131132a
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:AM0PR04MB6435;
x-ms-traffictypediagnostic: AM0PR04MB6435:
x-microsoft-antispam-prvs: <AM0PR04MB6435EA726739A59C5404F5F184E90@AM0PR04MB6435.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6430;
x-forefront-prvs: 0069246B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39830400003)(346002)(366004)(376002)(136003)(396003)(13464003)(189003)(199004)(9686003)(229853002)(71200400001)(6916009)(7416002)(33656002)(6246003)(4326008)(68736007)(6436002)(54906003)(7736002)(55016002)(5660300002)(86362001)(66066001)(71190400001)(14444005)(74316002)(316002)(256004)(52536014)(3846002)(186003)(6116002)(76176011)(53936002)(81166006)(8936002)(81156014)(26005)(305945005)(11346002)(478600001)(76116006)(8676002)(2906002)(7696005)(99286004)(25786009)(66946007)(486006)(66476007)(66556008)(64756008)(66446008)(476003)(446003)(6506007)(53546011)(14454004)(73956011)(102836004);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB6435;H:AM0PR04MB6738.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: UC6yGMSti6YC2w9oNSY5c2/z0Ewd7EqfVnw5srjUcpVg/wur88nLy6nEHJtuO1KY2ONfyfRDsyv3FpoeVhABldoI/JuBozb0PxEWCurKCVm/VVJYEIjBzJK0alFNVdmiI6Kh9JLg38s5sRSvG6JMyFsaM9jl021Rt0gbPd2vqh8WHiVybp+oL8BhBmrPuZ79a9IfNTygrleQ06UI4rrLDPa2jSdRBDtch4RWlhpuTIPH6sar6fUzimZe/4vxFbrJR6pEu3wvFQQyRRf0+X3eG9+KkYWPDjlK1ovOjJSEyeJRTVd+9ll9K98qJfE1IB4bT8zN6UredEawQhbzQWT/OtNKO61VPjPhRQW8w3uCBpZ3TLt1QwS6p/LVD1mlAOM7N74QyBhGugBdEeE2xQ8z+YBSuXqSL9co3qW6LlQ5ByA=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 72482e0c-a4f1-4742-33f9-08d6f131132a
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2019 01:30:39.5848
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB6435
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSBbbWFpbHRvOmxvcmVuem8ucGllcmFsaXNpQGFybS5jb21dDQo+IFNlbnQ6
IDIwMTnlubQ25pyIMTLml6UgMjE6MDgNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhw
LmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4LWFybS1rZXJuZWxA
bGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7IGxpbnV4
LWtlcm5lbEB2Z2VyLmtlcm5lbC5vcmc7DQo+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRA
a2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IGwuc3VicmFobWFueWFAbW9iaXZl
aWwuY28uaW47IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBMaQ0KPiA8bGVveWFuZy5saUBueHAu
Y29tPjsgY2F0YWxpbi5tYXJpbmFzQGFybS5jb207IHdpbGwuZGVhY29uQGFybS5jb207DQo+IE1p
bmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbiA8bWluZ2h1YW4ubGlhbkBu
eHAuY29tPjsNCj4gWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFvQG54cC5jb20+DQo+IFN1YmplY3Q6
IFJlOiBbUEFUQ0h2NSAwNC8yMF0gUENJOiBtb2JpdmVpbDogUmVtb3ZlIHRoZSBmbGFnDQo+IE1T
SV9GTEFHX01VTFRJX1BDSV9NU0kNCj4gDQo+IE9uIFdlZCwgSnVuIDEyLCAyMDE5IGF0IDExOjM0
OjUxQU0gKzAwMDAsIFoucS4gSG91IHdyb3RlOg0KPiA+IEhpIExvcmVuem8sDQo+ID4NCj4gPiBU
aGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQo+ID4NCj4gPiA+IC0tLS0tT3JpZ2luYWwg
TWVzc2FnZS0tLS0tDQo+ID4gPiBGcm9tOiBMb3JlbnpvIFBpZXJhbGlzaSA8bG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbT4NCj4gPiA+IFNlbnQ6IDIwMTnlubQ25pyIMTLml6UgMTowMA0KPiA+ID4g
VG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gPiA+IENjOiBsaW51eC1wY2lA
dmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+
ID4gPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVs
Lm9yZzsNCj4gPiA+IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFy
ay5ydXRsYW5kQGFybS5jb207DQo+ID4gPiBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOyBz
aGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkNCj4gPiA+IDxsZW95YW5nLmxpQG54cC5jb20+OyBj
YXRhbGluLm1hcmluYXNAYXJtLmNvbTsNCj4gd2lsbC5kZWFjb25AYXJtLmNvbTsNCj4gPiA+IE1p
bmdrYWkgSHUgPG1pbmdrYWkuaHVAbnhwLmNvbT47IE0uaC4gTGlhbg0KPiA8bWluZ2h1YW4ubGlh
bkBueHAuY29tPjsNCj4gPiA+IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiA+
ID4gU3ViamVjdDogUmU6IFtQQVRDSHY1IDA0LzIwXSBQQ0k6IG1vYml2ZWlsOiBSZW1vdmUgdGhl
IGZsYWcNCj4gPiA+IE1TSV9GTEFHX01VTFRJX1BDSV9NU0kNCj4gPiA+DQo+ID4gPiBPbiBGcmks
IEFwciAxMiwgMjAxOSBhdCAwODozNTozNkFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiA+
ID4gRnJvbTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiA+ID4NCj4g
PiA+ID4gVGhlIGN1cnJlbnQgY29kZSBkb2VzIG5vdCBzdXBwb3J0IG11bHRpcGxlIE1TSXMsIHNv
IHJlbW92ZSB0aGUNCj4gPiA+ID4gY29ycmVzcG9uZGluZyBmbGFnIGZyb20gdGhlIG1zaV9kb21h
aW5faW5mbyBzdHJ1Y3R1cmUuDQo+ID4gPg0KPiA+ID4gUGxlYXNlIGV4cGxhaW4gbWUgd2hhdCdz
IHRoZSBwcm9ibGVtIGJlZm9yZSByZW1vdmluZyBtdWx0aSBNU0kgc3VwcG9ydC4NCj4gPg0KPiA+
IE5YUCBMWDIgUENJZSB1c2UgdGhlIEdJQy1JVFMgaW5zdGVhZCBvZiBNb2JpdmVpbCBJUCBpbnRl
cm5hbCBNU0kNCj4gPiBjb250cm9sbGVyLCBzbywgSSBkaWRuJ3QgZW5jb3VudGVyIHByb2JsZW0u
DQo+IA0KPiBXZWxsLCB5b3Ugc2VudCBhIHBhdGNoIHRvIGZpeCBhbiBpc3N1ZSwgZXhwbGFpbiBt
ZSB0aGUgaXNzdWUgeW91IGFyZSBmaXhpbmcgdGhlbiwNCj4gYWthIHdoYXQgaGF2ZSB5b3Ugc2Vu
dCB0aGlzIHBhdGNoIGZvciA/DQoNCkkgZGlkIG5vdCBmYWNlIGlzc3VlLCBhcyBJIGhhdmUgZXhw
bGFpbmVkIE5YUCBkb2VzIG5vdCB1c2UgdGhlIE1vYml2ZWlsIElQJ3MgTVNJIGNvbnRyb2xsZXIu
DQpCdXQgb2J2aW91c2x5IHRoZSBNU0kgYWxsb2NhdGUgZnVuY3Rpb24gZG9lcyBub3Qgc3VwcG9y
dCBtdWx0aXBsZSBNU0ksIHNvIEkgc3VibWl0dGVkIHRoaXMgcGF0Y2guDQoNClRoYW5rcywNClpo
aXFpYW5nDQoNCj4gDQo+IExvcmVuem8NCj4gDQo+ID4gU3ViYnUsIGRpZCB5b3UgdGVzdCB3aXRo
IEVuZHBvaW50IHN1cHBvcnRpbmcgbXVsdGkgTVNJPw0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IFpo
aXFpYW5nDQo+ID4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBMb3JlbnpvDQo+ID4gPg0K
PiA+ID4gPiBGaXhlczogMWU5MTNlNTgzMzVmICgiUENJOiBtb2JpdmVpbDogQWRkIE1TSSBzdXBw
b3J0IikNCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VA
bnhwLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IE1pbmdodWFuIExpYW4gPE1pbmdodWFuLkxp
YW5AbnhwLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+IFY1Og0KPiA+ID4gPiAgLSBDb3JyZWN0
ZWQgdGhlIHN1YmplY3QuDQo+ID4gPiA+DQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVy
L3BjaWUtbW9iaXZlaWwuYyB8IDIgKy0NCj4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGluc2Vy
dGlvbigrKSwgMSBkZWxldGlvbigtKQ0KPiA+ID4gPg0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gYi9kcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ID4gPiBpbmRleCA1NjMyMTBlNzMxZDMu
LmEwZGQzMzdjNjIxNCAxMDA2NDQNCj4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gQEAgLTcwMyw3ICs3MDMsNyBAQCBzdGF0aWMgc3RydWN0
IGlycV9jaGlwIG1vYml2ZWlsX21zaV9pcnFfY2hpcCA9DQo+ID4gPiA+IHsNCj4gPiA+ID4NCj4g
PiA+ID4gIHN0YXRpYyBzdHJ1Y3QgbXNpX2RvbWFpbl9pbmZvIG1vYml2ZWlsX21zaV9kb21haW5f
aW5mbyA9IHsNCj4gPiA+ID4gIAkuZmxhZ3MJPSAoTVNJX0ZMQUdfVVNFX0RFRl9ET01fT1BTIHwN
Cj4gPiA+IE1TSV9GTEFHX1VTRV9ERUZfQ0hJUF9PUFMgfA0KPiA+ID4gPiAtCQkgICBNU0lfRkxB
R19NVUxUSV9QQ0lfTVNJIHwgTVNJX0ZMQUdfUENJX01TSVgpLA0KPiA+ID4gPiArCQkgICBNU0lf
RkxBR19QQ0lfTVNJWCksDQo+ID4gPiA+ICAJLmNoaXAJPSAmbW9iaXZlaWxfbXNpX2lycV9jaGlw
LA0KPiA+ID4gPiAgfTsNCj4gPiA+ID4NCj4gPiA+ID4gLS0NCj4gPiA+ID4gMi4xNy4xDQo+ID4g
PiA+DQo=
