Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DA094B2FA
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 09:24:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725980AbfFSHYZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 03:24:25 -0400
Received: from mail-eopbgr130087.outbound.protection.outlook.com ([40.107.13.87]:48430
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725854AbfFSHYZ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 03:24:25 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=phWV4UZqlLq0wa8zaGxybQZMecro+78Wz6GK8ukf0rs=;
 b=WLpQM5mMRxQAVcvc66EIcz7TfSlLqohSi+l/nCjKezeGJ9fSdcd5vT3pseOu0aSmZnAKwZsS19UlOa2H1DzjrorRTQt13BmJxFwAd4sIZXnB+E+Df2kqvv2WWBINqSPjnW1TiFV7jnMg+KU7NqyGRnibsrBvufuMQ69NVMnUYTc=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7100.eurprd04.prod.outlook.com (52.135.61.147) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.7; Wed, 19 Jun 2019 07:24:19 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.1987.014; Wed, 19 Jun 2019
 07:24:19 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
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
Subject: RE: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Thread-Topic: [PATCHv5 10/20] PCI: mobiveil: Fix the INTx process errors
Thread-Index: AQHU8QrIICRAPGaNQUWlVdR7PlC4dKaYf0EAgAKes4CAADwbgIAHg5qAgAAfn/A=
Date:   Wed, 19 Jun 2019 07:24:19 +0000
Message-ID: <DB8PR04MB674735D5F3F5F5FEE83C8EF284E50@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-11-Zhiqiang.Hou@nxp.com>
 <20190612150819.GD15747@redmoon>
 <CAKnKUHFMH6=ox=qdaUR1kNEhETDCVyu3jQZEj+taEbbMRBRuYA@mail.gmail.com>
 <20190614104351.GA29955@e121166-lin.cambridge.arm.com>
 <CAKnKUHHTAsjMoMkqaWq5z6r30JUGCpxSaYwyp8AuE3H5R0vBig@mail.gmail.com>
In-Reply-To: <CAKnKUHHTAsjMoMkqaWq5z6r30JUGCpxSaYwyp8AuE3H5R0vBig@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [223.72.64.203]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: d670e0b4-59f8-4ccc-29df-08d6f48724bd
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB7100;
x-ms-traffictypediagnostic: DB8PR04MB7100:
x-ms-exchange-purlcount: 1
x-microsoft-antispam-prvs: <DB8PR04MB7100819953FDFCCBD020DCCB84E50@DB8PR04MB7100.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:10000;
x-forefront-prvs: 0073BFEF03
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(376002)(366004)(136003)(39860400002)(346002)(396003)(54534003)(13464003)(189003)(199004)(5024004)(33656002)(66066001)(64756008)(53936002)(81156014)(55016002)(14454004)(66446008)(5660300002)(7696005)(53546011)(71200400001)(6116002)(26005)(71190400001)(2906002)(99286004)(25786009)(229853002)(6506007)(102836004)(6246003)(68736007)(8676002)(966005)(3846002)(4326008)(6436002)(7736002)(7416002)(66476007)(66556008)(8936002)(76116006)(76176011)(316002)(9686003)(66946007)(73956011)(6306002)(45080400002)(81166006)(52536014)(74316002)(110136005)(11346002)(478600001)(54906003)(446003)(486006)(14444005)(476003)(256004)(86362001)(186003)(305945005);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7100;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 09Dpd5t9IbjV8P0wYDIc1gx2048UyaLWzIv/i3X1DTX0Zjjm2IVLKWN3klz77HBC6G7bd6gRACdZBKLKQ+qvcp2F9eNk1t/iDgcUbbPuy5MAwL3sQYNixcOnnkTOvbScM2Iqmz3Mi0m6HpldrdO8yZC00iZblb3ZCc0gGcAXuVUd+RXgMOuBYegM9r4ZwD1rH/+MWEcyd3wF6PC1oSZ5kv8Ghi0z9mIA9v7wzvPUmniwyF9waYn076zIBgDdGvXanZV2b73K3W9+vY8fCU8M4UYNcSdLnt5GncssgYUZz8+UZA/PcNXLPI9Mijtu4CUPLvp0R2tbeWwUp+iL6oCeejrj4WpVjq0TV0fE0PoeF8eyk6CDX9vf0EAqijTJBW7WXXrybP/C5yZ9SuiFSNtn1ranmF64jICUdS1hsD4UODk=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d670e0b4-59f8-4ccc-29df-08d6f48724bd
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Jun 2019 07:24:19.2253
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7100
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS2FydGhpa2V5YW4sDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTog
S2FydGhpa2V5YW4gTWl0cmFuIFttYWlsdG86bS5rYXJ0aGlrZXlhbkBtb2JpdmVpbC5jby5pbl0N
Cj4gU2VudDogMjAxOeW5tDbmnIgxOeaXpSAxMzoyOQ0KPiBUbzogTG9yZW56byBQaWVyYWxpc2kg
PGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+DQo+IENjOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91
QG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1hcm0ta2VybmVs
QGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51
eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtl
cm5lbC5vcmc7DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWls
LmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNv
bT47DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5n
a2FpIEh1DQo+IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5A
bnhwLmNvbT47IFhpYW93ZWkgQmFvDQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0
OiBSZTogW1BBVENIdjUgMTAvMjBdIFBDSTogbW9iaXZlaWw6IEZpeCB0aGUgSU5UeCBwcm9jZXNz
IGVycm9ycw0KPiANCj4gT24gRnJpLCBKdW4gMTQsIDIwMTkgYXQgNDoxNCBQTSBMb3JlbnpvIFBp
ZXJhbGlzaSA8bG9yZW56by5waWVyYWxpc2lAYXJtLmNvbT4NCj4gd3JvdGU6DQo+ID4NCj4gPiBP
biBGcmksIEp1biAxNCwgMjAxOSBhdCAxMjozODo1MVBNICswNTMwLCBLYXJ0aGlrZXlhbiBNaXRy
YW4gd3JvdGU6DQo+ID4gPiBIaSBMb3JlbnpvIGFuZCBIb3UgWmhpcWlhbmcNCj4gPiA+ICBQQUJf
SU5UUF9BTUJBX01JU0NfU1RBVCBkb2VzIGhhdmUgb3RoZXIgc3RhdHVzIGluIHRoZSBoaWdoZXIg
Yml0cywNCj4gPiA+IGl0IHNob3VsZCBoYXZlIGJlZW4gbWFza2VkIGJlZm9yZSBjaGVja2luZyBm
b3IgdGhlIHN0YXR1cw0KPiA+DQo+ID4gWW91IGFyZSB0aGUgbWFpbnRhaW5lciBmb3IgdGhpcyBk
cml2ZXIsIHNvIGlmIHRoZXJlIGlzIHNvbWV0aGluZyB0byBiZQ0KPiA+IGNoYW5nZWQgeW91IG11
c3QgcG9zdCBhIHBhdGNoIHRvIHRoYXQgZXh0ZW50LCBJIGRvIG5vdCB1bmRlcnN0YW5kIHdoYXQN
Cj4gPiB0aGUgYWJvdmUgbWVhbnMsIHdyaXRlIHRoZSBjb2RlIHRvIGZpeCBpdCwgSSB3b24ndCBk
byBpdC4NCj4gPg0KPiA+IEkgYW0gZ2V0dGluZyBhIGJpdCBhbm5veWVkIHdpdGggdGhpcyBNb2Jp
dmVpbCBkcml2ZXIgc28gZWl0aGVyIHlvdQ0KPiA+IGd1eXMgc29ydCB0aGlzIG91dCBvciBJIHdp
bGwgaGF2ZSB0byByZW1vdmUgaXQgZnJvbSB0aGUga2VybmVsLg0KPiA+DQo+ID4gPiBBY2tlZC1i
eTogS2FydGhpa2V5YW4gTWl0cmFuIDxtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluPg0KPiA+
DQo+ID4gT2sgSSBhc3N1bWUgdGhpcyBtZWFucyB5b3UgdGVzdGVkIGl0IGJ1dCBhY2NvcmRpbmcg
dG8gd2hhdCB5b3Ugc2F5DQo+ID4gYWJvdmUsIGFyZSB0aGVyZSBzdGlsbCBpc3N1ZXMgd2l0aCB0
aGlzIGNvZGUgcGF0aCA/IFNob3VsZCB3ZSB1cGRhdGUNCj4gPiB0aGUgcGF0Y2ggPw0KPiBUZXN0
ZWQtYnk6IEthcnRoaWtleWFuIE1pdHJhbiA8bS5rYXJ0aGlrZXlhbkBtb2JpdmVpbC5jby5pbj4g
VGhpcyBwYXRjaA0KPiBmaXhlcyB0aGUgSU5UeCBzdGF0dXMgZXh0cmFjdGlvbiBhbmQgaGFuZGxp
bmcsIEkgZG9uJ3Qgc2VlIGFueSBuZWVkIHRvIHVwZGF0ZQ0KPiB0aGlzIHBhdGNoLg0KDQpUaGFu
a3MgYSBsb3QgZm9yIHlvdXIgdGVzdCENCg0KWmhpcWlhbmcNCg0KPiA+DQo+ID4gTW9yZW92ZXI6
DQo+ID4NCj4gPiBodHRwczovL2V1cjAxLnNhZmVsaW5rcy5wcm90ZWN0aW9uLm91dGxvb2suY29t
Lz91cmw9aHR0cHMlM0ElMkYlMkZrZXJuDQo+ID4NCj4gZWxuZXdiaWVzLm9yZyUyRlBhdGNoQ3Vs
dHVyZSZhbXA7ZGF0YT0wMiU3QzAxJTdDemhpcWlhbmcuaG91JTQwbngNCj4gcC5jb20NCj4gPiAl
N0MxNDQ1NTcwMTYzYmI0NzljYWUzNzA4ZDZmNDc3MDlmYiU3QzY4NmVhMWQzYmMyYjRjNmZhOTJj
ZDk5DQo+IGM1YzMwMTYzNQ0KPiA+ICU3QzAlN0MwJTdDNjM2OTY1MTg5NDM4NjQ3MDM2JmFtcDtz
ZGF0YT14WFE1TUNQdVhWMDhDZCUyRmkNCj4gVEJua0FtT1ZHT3NIDQo+ID4gWEZpN2UxeGN2bFlJ
d2lBJTNEJmFtcDtyZXNlcnZlZD0wDQo+ID4NCj4gPiBQbGVhc2UgcmVhZCBpdCBhbmQgbmV2ZXIg
dG9wLXBvc3QuDQo+IFRoYW5rIHlvdSB2ZXJ5IG11Y2gsIGZvciB0aGUgaW5mb3JtYXRpb24uDQo+
IA0KPiA+DQo+ID4gVGhhbmtzLA0KPiA+IExvcmVuem8NCj4gPg0KPiA+ID4gT24gV2VkLCBKdW4g
MTIsIDIwMTkgYXQgODozOCBQTSBMb3JlbnpvIFBpZXJhbGlzaQ0KPiA+ID4gPGxvcmVuem8ucGll
cmFsaXNpQGFybS5jb20+IHdyb3RlOg0KPiA+ID4gPg0KPiA+ID4gPiBPbiBGcmksIEFwciAxMiwg
MjAxOSBhdCAwODozNjoxMkFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiA+ID4gPiBGcm9t
OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+ID4gPiA+DQo+ID4gPiA+
ID4gSW4gdGhlIGxvb3AgYmxvY2ssIHRoZXJlIGlzIG5vdCBjb2RlIHRvIHVwZGF0ZSB0aGUgbG9v
cCBrZXksDQo+ID4gPiA+ID4gdGhpcyBwYXRjaCB1cGRhdGVzIHRoZSBsb29wIGtleSBieSByZS1y
ZWFkIHRoZSBJTlR4IHN0YXR1cw0KPiA+ID4gPiA+IHJlZ2lzdGVyLg0KPiA+ID4gPiA+DQo+ID4g
PiA+ID4gVGhpcyBwYXRjaCBhbHNvIGFkZCB0aGUgY2xlYXJpbmcgb2YgdGhlIGhhbmRsZWQgSU5U
eCBzdGF0dXMuDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBOb3RlOiBOZWVkIE1WIHRvIHRlc3QgdGhp
cyBmaXguDQo+ID4gPiA+DQo+ID4gPiA+IFRoaXMgbWVhbnMgSU5UWCB3ZXJlIG5ldmVyIHRlc3Rl
ZCBhbmQgY3VycmVudCBjb2RlIGhhbmRsaW5nIHRoZW0NCj4gPiA+ID4gaXMsIEFGQUlDUywgYW4g
aW5maW5pdGUgbG9vcCB3aGljaCBpcyB2ZXJ5IHZlcnkgYmFkLg0KPiA+ID4gPg0KPiA+ID4gPiBU
aGlzIGlzIGEgZ3Jvc3MgYnVnIGFuZCBtdXN0IGJlIGZpeGVkIGFzIHNvb24gYXMgcG9zc2libGUu
DQo+ID4gPiA+DQo+ID4gPiA+IEkgd2FudCBLYXJ0aGlrZXlhbiBBQ0sgYW5kIFRlc3RlZC1ieSBv
biB0aGlzIHBhdGNoLg0KPiA+ID4gPg0KPiA+ID4gPiBMb3JlbnpvDQo+ID4gPiA+DQo+ID4gPiA+
ID4gRml4ZXM6IDlhZjZiY2IxMWUxMiAoIlBDSTogbW9iaXZlaWw6IEFkZCBNb2JpdmVpbCBQQ0ll
IEhvc3QNCj4gPiA+ID4gPiBCcmlkZ2UgSVAgZHJpdmVyIikNCj4gPiA+ID4gPiBTaWduZWQtb2Zm
LWJ5OiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+ID4gPiA+IFJldmll
d2VkLWJ5OiBNaW5naHVhbiBMaWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQo+ID4gPiA+ID4g
UmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlhIExpbmdhcHBhDQo+IDxsLnN1YnJhaG1hbnlhQG1vYml2
ZWlsLmNvLmluPg0KPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IFY1Og0KPiA+ID4gPiA+ICAtIENv
cnJlY3RlZCBhbmQgcmV0b3VjaGVkIHRoZSBzdWJqZWN0IGFuZCBjaGFuZ2Vsb2cuDQo+ID4gPiA+
ID4NCj4gPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMgfCAx
MyArKysrKysrKystLS0tDQo+ID4gPiA+ID4gIDEgZmlsZSBjaGFuZ2VkLCA5IGluc2VydGlvbnMo
KyksIDQgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gPiA+ID4gaW5kZXggNGJhNDU4NDc0
ZTQyLi43OGU1NzVlNzFmNGQgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ID4gPiA+IEBAIC0zNjEsNiArMzYxLDcgQEAgc3Rh
dGljIHZvaWQgbW9iaXZlaWxfcGNpZV9pc3Ioc3RydWN0IGlycV9kZXNjDQo+ICpkZXNjKQ0KPiA+
ID4gPiA+ICAgICAgIC8qIEhhbmRsZSBJTlR4ICovDQo+ID4gPiA+ID4gICAgICAgaWYgKGludHJf
c3RhdHVzICYgUEFCX0lOVFBfSU5UWF9NQVNLKSB7DQo+ID4gPiA+ID4gICAgICAgICAgICAgICBz
aGlmdGVkX3N0YXR1cyA9IGNzcl9yZWFkbChwY2llLA0KPiA+ID4gPiA+IFBBQl9JTlRQX0FNQkFf
TUlTQ19TVEFUKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgIHNoaWZ0ZWRfc3RhdHVzICY9IFBB
Ql9JTlRQX0lOVFhfTUFTSzsNCj4gPiA+ID4gPiAgICAgICAgICAgICAgIHNoaWZ0ZWRfc3RhdHVz
ID4+PSBQQUJfSU5UWF9TVEFSVDsNCj4gPiA+ID4gPiAgICAgICAgICAgICAgIGRvIHsNCj4gPiA+
ID4gPiAgICAgICAgICAgICAgICAgICAgICAgZm9yX2VhY2hfc2V0X2JpdChiaXQsICZzaGlmdGVk
X3N0YXR1cywNCj4gPiA+ID4gPiBQQ0lfTlVNX0lOVFgpIHsgQEAgLTM3MiwxMiArMzczLDE2IEBA
IHN0YXRpYyB2b2lkDQo+IG1vYml2ZWlsX3BjaWVfaXNyKHN0cnVjdCBpcnFfZGVzYyAqZGVzYykN
Cj4gPiA+ID4gPg0KPiBkZXZfZXJyX3JhdGVsaW1pdGVkKGRldiwgInVuZXhwZWN0ZWQgSVJRLCBJ
TlQlZFxuIiwNCj4gPiA+ID4gPg0KPiBiaXQpOw0KPiA+ID4gPiA+DQo+ID4gPiA+ID4gLSAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgLyogY2xlYXIgaW50ZXJydXB0ICovDQo+ID4gPiA+ID4g
LSAgICAgICAgICAgICAgICAgICAgICAgICAgICAgY3NyX3dyaXRlbChwY2llLA0KPiA+ID4gPiA+
IC0gICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgc2hpZnRlZF9zdGF0dXMg
PDwNCj4gUEFCX0lOVFhfU1RBUlQsDQo+ID4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAgICAg
ICAgICAgLyogY2xlYXIgaW50ZXJydXB0IGhhbmRsZWQgKi8NCj4gPiA+ID4gPiArICAgICAgICAg
ICAgICAgICAgICAgICAgICAgICBjc3Jfd3JpdGVsKHBjaWUsIDEgPDwNCj4gPiA+ID4gPiArIChQ
QUJfSU5UWF9TVEFSVCArIGJpdCksDQo+ID4gPiA+ID4NCj4gUEFCX0lOVFBfQU1CQV9NSVNDX1NU
QVQpOw0KPiA+ID4gPiA+ICAgICAgICAgICAgICAgICAgICAgICB9DQo+ID4gPiA+ID4gLSAgICAg
ICAgICAgICB9IHdoaWxlICgoc2hpZnRlZF9zdGF0dXMgPj4gUEFCX0lOVFhfU1RBUlQpICE9IDAp
Ow0KPiA+ID4gPiA+ICsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgc2hpZnRlZF9z
dGF0dXMgPSBjc3JfcmVhZGwocGNpZSwNCj4gPiA+ID4gPiArDQo+IFBBQl9JTlRQX0FNQkFfTUlT
Q19TVEFUKTsNCj4gPiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgc2hpZnRlZF9zdGF0dXMg
Jj0gUEFCX0lOVFBfSU5UWF9NQVNLOw0KPiA+ID4gPiA+ICsgICAgICAgICAgICAgICAgICAgICBz
aGlmdGVkX3N0YXR1cyA+Pj0gUEFCX0lOVFhfU1RBUlQ7DQo+ID4gPiA+ID4gKyAgICAgICAgICAg
ICB9IHdoaWxlIChzaGlmdGVkX3N0YXR1cyAhPSAwKTsNCj4gPiA+ID4gPiAgICAgICB9DQo+ID4g
PiA+ID4NCj4gPiA+ID4gPiAgICAgICAvKiByZWFkIGV4dHJhIE1TSSBzdGF0dXMgcmVnaXN0ZXIg
Ki8NCj4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+IDIuMTcuMQ0KPiA+ID4gPiA+DQo+ID4gPg0KPiA+
ID4NCj4gPiA+DQo+ID4gPg0KPiANCj4gLS0NCj4gTW9iaXZlaWwgSU5DLiwgQ09ORklERU5USUFM
SVRZIE5PVElDRTogVGhpcyBlLW1haWwgbWVzc2FnZSwgaW5jbHVkaW5nIGFueQ0KPiBhdHRhY2ht
ZW50cywgaXMgZm9yIHRoZSBzb2xlIHVzZSBvZiB0aGUgaW50ZW5kZWQgcmVjaXBpZW50KHMpIGFu
ZCBtYXkgY29udGFpbg0KPiBwcm9wcmlldGFyeSBjb25maWRlbnRpYWwgb3IgcHJpdmlsZWdlZCBp
bmZvcm1hdGlvbiBvciBvdGhlcndpc2UgYmUgcHJvdGVjdGVkDQo+IGJ5IGxhdy4gQW55IHVuYXV0
aG9yaXplZCByZXZpZXcsIHVzZSwgZGlzY2xvc3VyZSBvciBkaXN0cmlidXRpb24gaXMgcHJvaGli
aXRlZC4gSWYNCj4geW91IGFyZSBub3QgdGhlIGludGVuZGVkIHJlY2lwaWVudCwgcGxlYXNlIG5v
dGlmeSB0aGUgc2VuZGVyIGFuZCBkZXN0cm95IGFsbA0KPiBjb3BpZXMgYW5kIHRoZSBvcmlnaW5h
bCBtZXNzYWdlLg0K
