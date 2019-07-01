Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0F3C35B8B4
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 12:08:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbfGAKH4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 06:07:56 -0400
Received: from mail-eopbgr150071.outbound.protection.outlook.com ([40.107.15.71]:22404
        "EHLO EUR01-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727387AbfGAKH4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 06:07:56 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TYj83rIcor7o4yxNDKA7217f2aU8V2biWDQtPWy1AZ4=;
 b=WKAjdbOIr+xBlUyr9M8GCyMzgzyXqQB+3ZcWXozhZY5JRn5N7ghyvytXOehLkwpoesK3l8p2Li9UZXQoXkDLXYbXFrwlz3iXGte+JflAIRp147+vCNk/HxUHAHlGHNIpmgH6vOZIXaZA0jqcmiwLG9RsuKeql0nYjn+Qca8Wmtc=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6811.eurprd04.prod.outlook.com (52.133.240.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.18; Mon, 1 Jul 2019 10:07:52 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::93a:4344:1120:4ca0%6]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 10:07:52 +0000
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
Thread-Index: AQHU8Qqz/gJFKoxI7kSHS+a5VfCWFaaXDAuAgAE1ccCAABw2gIAD74cQgAOwLICAAA4C0IARXc6AgASat1A=
Date:   Mon, 1 Jul 2019 10:07:51 +0000
Message-ID: <DB8PR04MB67471CA3A4E8D76F2E0DC49484F90@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-5-Zhiqiang.Hou@nxp.com>
 <20190611165935.GA22836@redmoon>
 <AM0PR04MB67383023B81AEB33DAF9C35584EC0@AM0PR04MB6738.eurprd04.prod.outlook.com>
 <20190612130813.GA15747@redmoon>
 <AM0PR04MB6738B93C7F1B5BE433753CF584E90@AM0PR04MB6738.eurprd04.prod.outlook.com>
 <20190617093337.GD18020@e121166-lin.cambridge.arm.com>
 <AM6PR04MB67425792524FBA1C773F137984EB0@AM6PR04MB6742.eurprd04.prod.outlook.com>
 <20190628113555.GA21829@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190628113555.GA21829@e121166-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: c2896296-9e40-49e7-d650-08d6fe0bfaaa
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6811;
x-ms-traffictypediagnostic: DB8PR04MB6811:
x-microsoft-antispam-prvs: <DB8PR04MB68114992802326EC2B5B2CC384F90@DB8PR04MB6811.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1169;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(136003)(376002)(396003)(39860400002)(366004)(13464003)(54534003)(199004)(189003)(74316002)(7736002)(305945005)(99286004)(446003)(86362001)(6916009)(11346002)(7696005)(7416002)(476003)(6246003)(52536014)(14444005)(486006)(14454004)(316002)(256004)(54906003)(478600001)(5660300002)(6506007)(102836004)(66556008)(66476007)(66446008)(66946007)(76176011)(73956011)(64756008)(2906002)(68736007)(186003)(71190400001)(71200400001)(53936002)(53546011)(3846002)(6116002)(76116006)(66066001)(26005)(9686003)(25786009)(55016002)(229853002)(8676002)(81166006)(81156014)(33656002)(4326008)(6436002)(8936002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6811;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: kQW3eY0rK6v+LGcJ1c2zto1ZYi3Xz7VbhYgEYeXS0+kfyIsgMhKpac4CZnkpPMvHopsIV2dpQXCqEpMLXSaoDEcZCFx5FnR9Yh9lAQDyaNr0n2dNBALZe8t4SiY3Qft68ppOioxtFn91hPy1igx8yLhuhE01eTEaIR9SqIgU5h0GjF1jH8sbd9H7UIlwsKor5PJkdJVyAdgmNHuOL/H64K3Beja4b9UiHkKPH5Y9GM/2EkrwMDZ+GyhWlXZtS0lp8/iNzQVZ8NZzyOPnn73cIXs2prxg/5SL7UMmwMGlje7dNP3xTAKgXMWPAYlctQTmvBTWxFloV82hUH9uNg233qN442jQKPsfqpw1Fvoro5khvdyBf+sgvjtp6fuUmdASB9Yyqxq6E1xFTpV6kPO5txGKk9KLhMPDk3xbfR5wkx4=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2896296-9e40-49e7-d650-08d6fe0bfaaa
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 10:07:51.9701
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6811
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIGNvbW1lbnRzIQ0KDQo+IC0tLS0t
T3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IExvcmVuem8gUGllcmFsaXNpIDxsb3Jlbnpv
LnBpZXJhbGlzaUBhcm0uY29tPg0KPiBTZW50OiAyMDE5xOo21MIyOMjVIDE5OjM2DQo+IFRvOiBa
LnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJu
ZWwub3JnOyBsaW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRy
ZWVAdmdlci5rZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVs
Z2Fhc0Bnb29nbGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29t
Ow0KPiBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOyBzaGF3bmd1b0BrZXJuZWwub3JnOyBM
ZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3
aWxsLmRlYWNvbkBhcm0uY29tOw0KPiBNaW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBN
LmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47DQo+IFhpYW93ZWkgQmFvIDx4aWFvd2Vp
LmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjUgMDQvMjBdIFBDSTogbW9iaXZl
aWw6IFJlbW92ZSB0aGUgZmxhZw0KPiBNU0lfRkxBR19NVUxUSV9QQ0lfTVNJDQo+IA0KPiBPbiBN
b24sIEp1biAxNywgMjAxOSBhdCAxMDozNDozNUFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4g
DQo+IFsuLi5dDQo+IA0KPiA+ID4gVGhlcmUgaXMgbm90aGluZyBvYnZpb3VzLiBXcml0ZSB3aGF0
IHlvdSBhcmUgZml4aW5nIGluIHRoZSBjb21taXQNCj4gPiA+IGxvZyBhbmQgSSB3aWxsIGFwcGx5
IHRoZSBwYXRjaCwgSSB3b24ndCB3cml0ZSB0aGUgY29tbWl0IGxvZyBmb3INCj4gPiA+IHlvdS4g
QW55b25lIHNob3VsZCBiZSBhYmxlIHRvIHVuZGVyc3RhbmQgd2h5IGEgcGF0Y2ggd2FzIG5lZWRl
ZCBieQ0KPiA+ID4gcmVhZGluZyB0aGUgY29tbWl0IGxvZywgaXQgaXMgYXMgaW1wb3J0YW50IGFz
IHdyaXRpbmcgdGhlIGNvZGUgaXRzZWxmLg0KPiA+DQo+ID4gV2l0aCB0aGUgZmxhZyBNU0lfRkxB
R19NVUxUSV9QQ0lfTVNJLCB3aGVuIHRoZSBFbmRwb2ludCBhbGxvY2F0ZXMNCj4gPiBtdWx0aXBs
ZSBNU0ksIGl0IHdpbGwgdHJpZ2dlciB0aGUgIldBUk5fT04obnJfaXJxcyAhPSAxKTsiIGluDQo+
ID4gbW9iaXZlaWxfaXJxX21zaV9kb21haW5fYWxsb2MoKSwgdGhpcyBpcyB0aGUgaXNzdWUgdGhp
cyBwYXRjaCB3YW50IHRvDQo+ID4gZml4Lg0KPiANCj4gQW5kIHRoYXQncyB3cm9uZy4gTWFyYyBl
eHBsYWluZWQgd2h5IHRoaXMgY29udHJvbGxlciBkb2VzIG5vdCBzdXBwb3J0IE11bHRpDQo+IE1T
SSBhbmQgdGhhdCdzIHdoYXQgc2hvdWxkIGdvIGluIHRoZSBjb21taXQgbG9nLCB0cmlnZ2VyaW5n
IGEgV0FSTl9PTiBpcw0KPiB0aGUgbGVhc3Qgb2YgdGhlIHByb2JsZW1zIChhbmQgdGhlIFdBUk5f
T04gY2FuIGV2ZW4gYmUgcmVtb3ZlZCBhZnRlcg0KPiB0aGlzIHBhdGNoIGlzIGFwcGxpZWQpLCBp
ZiBpdCB3YXMgdXNlZCBhcyBhIGJhbmRhaWQgdG8gcHJldmVudCBhbGxvY2F0aW5nIE11bHRpDQo+
IE1TSSBpdCBpcyBldmVuIG1vcmUgYnJva2VuLg0KPg0KDQpZZXMsIEkgYWdyZWUsIHRoZSByb290
IGNhdXNlIGlzIGhhcmR3YXJlIGxpbWl0YXRpb24sIGlzIHRoZSBmb2xsb3dpbmcgY2hhbmdlbG9n
DQphY2NlcHRhYmxlPw0KDQpDaGFuZ2Vsb2c6DQpUaGUgTW9iaXZlaWwgaW50ZXJuYWwgTVNJIGNv
bnRyb2xsZXIgdXNlcyBzZXBhcmF0ZSB0YXJnZXQgYWRkcmVzcyBwZXIgTVNJLA0Kc28sIGl0IGlz
IHVuYWJsZSB0byBzdXBwb3J0IE11bHRpcGxlIE1TSSBmZWF0dXJlLCB3aGljaCByZXF1aXJlcyB0
aGUgc2FtZQ0KdGFyZ2V0IGFkZHJlc3MgYW5kIGluY3JlbWVudGFsIE1TSV9EQVRBIHZhbHVlcy4g
VGhpcyBwYXRjaCBpcyB0byByZW1vdmUNCnRoZSBmbGFnIE1TSV9GTEFHX01VTFRJX1BDSV9NU0ku
DQoNClRoYW5rcywNClpoaXFpYW5nDQogDQo+IExvcmVuem8NCj4gDQo+ID4gVGhhbmtzLA0KPiA+
IFpoaXFpYW5nDQo+ID4NCj4gPiA+DQo+ID4gPiBUaGFua3MsDQo+ID4gPiBMb3JlbnpvDQo+ID4g
Pg0KPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+IFpoaXFpYW5nDQo+ID4gPiA+DQo+ID4gPiA+ID4N
Cj4gPiA+ID4gPiBMb3JlbnpvDQo+ID4gPiA+ID4NCj4gPiA+ID4gPiA+IFN1YmJ1LCBkaWQgeW91
IHRlc3Qgd2l0aCBFbmRwb2ludCBzdXBwb3J0aW5nIG11bHRpIE1TST8NCj4gPiA+ID4gPiA+DQo+
ID4gPiA+ID4gPiBUaGFua3MsDQo+ID4gPiA+ID4gPiBaaGlxaWFuZw0KPiA+ID4gPiA+ID4NCj4g
PiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gVGhhbmtzLA0KPiA+ID4gPiA+ID4gPiBMb3Jlbnpv
DQo+ID4gPiA+ID4gPiA+DQo+ID4gPiA+ID4gPiA+ID4gRml4ZXM6IDFlOTEzZTU4MzM1ZiAoIlBD
STogbW9iaXZlaWw6IEFkZCBNU0kgc3VwcG9ydCIpDQo+ID4gPiA+ID4gPiA+ID4gU2lnbmVkLW9m
Zi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiA+ID4gPiA+ID4g
PiBSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29tPg0KPiA+
ID4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+ID4gPiA+IFY1Og0KPiA+ID4gPiA+ID4gPiA+ICAt
IENvcnJlY3RlZCB0aGUgc3ViamVjdC4NCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4gPiA+
ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYyB8IDIgKy0NCj4gPiA+ID4g
PiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQo+
ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gPiA+ID4gPiBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gPiA+ID4gPiA+ID4gaW5kZXggNTYzMjEw
ZTczMWQzLi5hMGRkMzM3YzYyMTQgMTAwNjQ0DQo+ID4gPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVy
cy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiA+ID4gPiA+ID4gPiArKysgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+ID4gPiA+ID4gPiA+IEBA
IC03MDMsNyArNzAzLDcgQEAgc3RhdGljIHN0cnVjdCBpcnFfY2hpcA0KPiA+ID4gPiA+ID4gPiA+
IG1vYml2ZWlsX21zaV9pcnFfY2hpcCA9IHsNCj4gPiA+ID4gPiA+ID4gPg0KPiA+ID4gPiA+ID4g
PiA+ICBzdGF0aWMgc3RydWN0IG1zaV9kb21haW5faW5mbyBtb2JpdmVpbF9tc2lfZG9tYWluX2lu
Zm8gPSB7DQo+ID4gPiA+ID4gPiA+ID4gIAkuZmxhZ3MJPSAoTVNJX0ZMQUdfVVNFX0RFRl9ET01f
T1BTIHwNCj4gPiA+ID4gPiA+ID4gTVNJX0ZMQUdfVVNFX0RFRl9DSElQX09QUyB8DQo+ID4gPiA+
ID4gPiA+ID4gLQkJICAgTVNJX0ZMQUdfTVVMVElfUENJX01TSSB8IE1TSV9GTEFHX1BDSV9NU0lY
KSwNCj4gPiA+ID4gPiA+ID4gPiArCQkgICBNU0lfRkxBR19QQ0lfTVNJWCksDQo+ID4gPiA+ID4g
PiA+ID4gIAkuY2hpcAk9ICZtb2JpdmVpbF9tc2lfaXJxX2NoaXAsDQo+ID4gPiA+ID4gPiA+ID4g
IH07DQo+ID4gPiA+ID4gPiA+ID4NCj4gPiA+ID4gPiA+ID4gPiAtLQ0KPiA+ID4gPiA+ID4gPiA+
IDIuMTcuMQ0KPiA+ID4gPiA+ID4gPiA+DQo=
