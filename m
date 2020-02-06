Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 176831544E4
	for <lists+linux-pci@lfdr.de>; Thu,  6 Feb 2020 14:29:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727450AbgBFN3U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Feb 2020 08:29:20 -0500
Received: from mail-eopbgr60085.outbound.protection.outlook.com ([40.107.6.85]:3519
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726765AbgBFN3T (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Feb 2020 08:29:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ifzecEYQn+8J3YGv8Jy5F+B7/4V43ww0HU1fnn5+mlAHVsxQ45bQ7sBV8WBvaZ2/EnV79zHC2UiWIP9tnSVMyR7MNht5swZwf3vTRh7IaXQjKCV/HmtOA6WHEdw4VwDp85knfGXyf5VVuILUWkpJq7O1AGsrtI+sgfwOZSZC3snbj36R9By0hDMQt2MUCbRr6boTIYp2XnLWtF1AEL7BM/TnG5aWJmYsht3BRDU2nWvTabMYAJd5uJCMRIUSAaX1uSQhuim+2KynHEdxzpCcg5CLuDrjdJe/wd96+meHSRDi4gme2BTMIdi8DCx9o2o1Wte4vWnnrPbBb2xTY/84NA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdUVzgacKsKE++hXfr1TEhut7HVEjJRQ6E91xo0qgOQ=;
 b=MS79au2ZHqrlzVqSADwDPVtzLqvzIYPQd0EExkOqNh0vpZWjmWsWLZSuHUDMlhCM2rRJr47vT/VD52XNb9Gc5f0ZTkJJTD21VMnRpj2E8LkktqrviaFyMB5HKm5AaJqoPqAYr6ac6n00BZRNJO+jzb6MQk0kDQRVxTQ9wRD6xJZhlRUWepRDYVDQmUqiGP3Da25p7pb2WSkyVendL07hdjWDV3iNTjcIbVPE+xYbdRpOq5fNyX8Bq1lxE8IO7HGD6vL/bWAMc69DkaqsQEXDmGYhqw4ZpnljFsqPkzsE3Wd8GWyXVFMkljwJsmpxdHsvdwoEDax5+/MTpJCvn1MrdA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JdUVzgacKsKE++hXfr1TEhut7HVEjJRQ6E91xo0qgOQ=;
 b=bMljqCE0aP9DV7m0JsYfjQwRlPrtfiLMC6qeO7i9gdXjsyo6y08A0AuPoi6GmS4H2+uhfDoFO9tmVU6NWJBzTJLuRSuzhv3hmdRw24d9h4axYQkLc+GHQ/Q479/xbN6w46w1QojIsQ0pk+9BjAQNYf61a5xv4vmIUtzX+h56uIg=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB7132.eurprd04.prod.outlook.com (52.135.63.80) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2707.23; Thu, 6 Feb 2020 13:27:35 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2686.035; Thu, 6 Feb 2020
 13:27:35 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
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
Subject: RE: [PATCHv9 07/12] PCI: mobiveil: Make mobiveil_host_init() can be
 used to re-init host
Thread-Topic: [PATCHv9 07/12] PCI: mobiveil: Make mobiveil_host_init() can be
 used to re-init host
Thread-Index: AQHVn1UI5X66mCiBEUKLNXyo0B8tkKfoyhCAgCRXidA=
Date:   Thu, 6 Feb 2020 13:27:35 +0000
Message-ID: <DB8PR04MB67474190FF9D4CA48AE5704D841D0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191120034451.30102-1-Zhiqiang.Hou@nxp.com>
 <20191120034451.30102-8-Zhiqiang.Hou@nxp.com>
 <20200113112655.GM42593@e119886-lin.cambridge.arm.com>
In-Reply-To: <20200113112655.GM42593@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [92.121.68.129]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 92ea9e8d-6f67-4a6b-cb24-08d7ab08544b
x-ms-traffictypediagnostic: DB8PR04MB7132:|DB8PR04MB7132:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB7132E8D1D542555622A14E19841D0@DB8PR04MB7132.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:5516;
x-forefront-prvs: 0305463112
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(346002)(366004)(136003)(39840400004)(189003)(199004)(54906003)(71200400001)(316002)(7696005)(52536014)(76116006)(66946007)(64756008)(66446008)(66476007)(66556008)(7416002)(26005)(186003)(5660300002)(86362001)(55016002)(4326008)(9686003)(33656002)(478600001)(2906002)(8676002)(53546011)(6506007)(8936002)(81156014)(81166006)(6916009);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB7132;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: kb7Jgd5g1ZgKZ6n2gcnnQBLemFsvvceDWIm7XxMfKxrRWvNdpUA0uTEGLw/IVJ6pS+WmALL8j4jPb2z5kSLhS7G21BRyFdzk05aRvMnNuOItl1OzMtZk1YTirnYPACuvPAxbS6qmEtqBaC74TAZfvz0gqgLqVcNHtyyxhxoBt3MqQFrbgEvsMfD2GOPS01/dJWI17nyxTd/VbWIY4uB74iBXUBs3O98r+2+cQovblqUPHZ6ur7pI2lUSUVydxUebe16ZPDwObrAyK1qNs8mYjH39JvK7RbaQh6xRit4J9hbxrnBXHmEik90I+im+Hn2XLWi6kdnkB/x1Pw1M2cuQVZb3QmHo1KXHXxpX2lFm9oa5OiT6x8mhJOi8NDU6x60Jv5OIkuaXWzb5jHrwlV0fdBu+U0BvZ5EoHgfJQ+9OioZPCykBA6LrUeb7k25Vjui8
x-ms-exchange-antispam-messagedata: BHQ5nyBqUqSzzLB5dkmYEBLK2R2AkCxqASEw32WfNgV2ZPj+gdCCTE0c5K55NdDIsIQnpR7VFmc8TVkKH+91YVqk+hW1/6oMqYePEtGsDLramDnUIJbYz8A/N0kwGhiw3M3tv0/gJhsOma3qVykOaA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 92ea9e8d-6f67-4a6b-cb24-08d7ab08544b
X-MS-Exchange-CrossTenant-originalarrivaltime: 06 Feb 2020 13:27:35.6906
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: 8w2uVYHw7N5VA8w2X0EWDAtgMXMOg+8Yw/oQYaM0EiuoFen7wQvA4/35pMJf9jQniXvFZKRL4LrfvWDj7QT8aQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB7132
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgY29tbWVudHMhDQoNCj4gLS0tLS1P
cmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJh
eUBhcm0uY29tPg0KPiBTZW50OiAyMDIwxOox1MIxM8jVIDE5OjI3DQo+IFRvOiBaLnEuIEhvdSA8
emhpcWlhbmcuaG91QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1hcm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5r
ZXJuZWwub3JnOyBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29n
bGUuY29tOyByb2JoK2R0QGtlcm5lbC5vcmc7IGFybmRAYXJuZGIuZGU7DQo+IG1hcmsucnV0bGFu
ZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJu
ZWwub3JnOyBtLmthcnRoaWtleWFuQG1vYml2ZWlsLmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcu
bGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5h
c0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1
QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFv
DQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0OiBSZTogW1BBVENIdjkgMDcvMTJd
IFBDSTogbW9iaXZlaWw6IE1ha2UgbW9iaXZlaWxfaG9zdF9pbml0KCkgY2FuIGJlDQo+IHVzZWQg
dG8gcmUtaW5pdCBob3N0DQo+IA0KPiBPbiBXZWQsIE5vdiAyMCwgMjAxOSBhdCAwMzo0NjowM0FN
ICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5n
LkhvdUBueHAuY29tPg0KPiA+DQo+ID4gTWFrZSB0aGUgbW9iaXZlaWxfaG9zdF9pbml0KCkgZnVu
Y3Rpb24gY2FuIGJlIHVzZWQgdG8gcmUtaW5pdA0KPiANCj4gUGVyaGFwcyByZXdvcmQgdG8gIkFs
bG93IHRoZSBtb2JpdmVpbF9ob3N0X2luaXQoKSBmdW5jdGlvbiB0byBiZSB1c2VkIHRvIC4uLg0K
PiANCg0KVGhhbmtzIGEgbG90IGZvciB5b3VyIHN1Z2dlc3Rpb24sIHdpbGwgY2hhbmdlIGluIHYx
MC4NCg0KVGhhbmtzLA0KWmhpcWlhbmcNCg0KPiA+IGhvc3QgY29udHJvbGxlcidzIFBBQiBhbmQg
R1BFWCBDU1IgcmVnaXN0ZXIgYmxvY2ssIGFzIE5YUCBpbnRlZ3JhdGVkDQo+ID4gTW9iaXZlaWwg
SVAgaGFzIHRvIHJlc2V0IGFuZCB0aGVuIHJlLWluaXQgdGhlIFBBQiBhbmQgR1BFWCBDU1INCj4g
PiByZWdpc3RlcnMgdXBvbiBob3QtcmVzZXQuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3Ug
WmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBTdWJyYWht
YW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5pbj4NCj4gPiAtLS0NCj4g
PiBWOToNCj4gPiAgLSBObyBjaGFuZ2UNCj4gPg0KPiA+ICAuLi4vY29udHJvbGxlci9tb2JpdmVp
bC9wY2llLW1vYml2ZWlsLWhvc3QuYyAgfCAxOSArKysrKysrKysrKystLS0tLS0tDQo+ID4gIC4u
Li9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8ICAxICsNCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCAxMyBpbnNlcnRpb25zKCspLCA3IGRlbGV0aW9ucygtKQ0KPiA+DQo+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2Jp
dmVpbC1ob3N0LmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1t
b2JpdmVpbC1ob3N0LmMNCj4gPiBpbmRleCAzY2Q5M2RmNmZlNmUuLjliYzNkYTAzNjcyMCAxMDA2
NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZl
aWwtaG9zdC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2ll
LW1vYml2ZWlsLWhvc3QuYw0KPiA+IEBAIC0yMjEsMTggKzIyMSwyMyBAQCBzdGF0aWMgdm9pZCBt
b2JpdmVpbF9wY2llX2VuYWJsZV9tc2koc3RydWN0DQo+IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+
ID4gIAl3cml0ZWxfcmVsYXhlZCgxLCBwY2llLT5hcGJfY3NyX2Jhc2UgKyBNU0lfRU5BQkxFX09G
RlNFVCk7ICB9DQo+ID4NCj4gPiAtc3RhdGljIGludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0
IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+ID4gK2ludCBtb2JpdmVpbF9ob3N0X2luaXQoc3RydWN0
IG1vYml2ZWlsX3BjaWUgKnBjaWUsIGJvb2wgcmVpbml0KQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3Qg
cm9vdF9wb3J0ICpycCA9ICZwY2llLT5ycDsNCj4gPiAgCXN0cnVjdCBwY2lfaG9zdF9icmlkZ2Ug
KmJyaWRnZSA9IHJwLT5icmlkZ2U7DQo+ID4gIAl1MzIgdmFsdWUsIHBhYl9jdHJsLCB0eXBlOw0K
PiA+ICAJc3RydWN0IHJlc291cmNlX2VudHJ5ICp3aW47DQo+ID4NCj4gPiAtCS8qIHNldHVwIGJ1
cyBudW1iZXJzICovDQo+ID4gLQl2YWx1ZSA9IG1vYml2ZWlsX2Nzcl9yZWFkbChwY2llLCBQQ0lf
UFJJTUFSWV9CVVMpOw0KPiA+IC0JdmFsdWUgJj0gMHhmZjAwMDAwMDsNCj4gPiAtCXZhbHVlIHw9
IDB4MDBmZjAxMDA7DQo+ID4gLQltb2JpdmVpbF9jc3Jfd3JpdGVsKHBjaWUsIHZhbHVlLCBQQ0lf
UFJJTUFSWV9CVVMpOw0KPiA+ICsJcGNpZS0+aWJfd2luc19jb25maWd1cmVkID0gMDsNCj4gPiAr
CXBjaWUtPm9iX3dpbnNfY29uZmlndXJlZCA9IDA7DQo+IA0KPiBUaGlzIHdvcmtzIHNvIGxvbmcg
YXMgdGhlIG51bWJlciBvZiBicmlkZ2UtPndpbmRvd3MgbmV2ZXIgcmVkdWNlcy4gSSB0aGluaw0K
PiB0aGlzIGFzc3VtcHRpb24gaG9sZHMgdHJ1ZS4NCj4gDQo+IFRoYW5rcywNCj4gDQo+IEFuZHJl
dyBNdXJyYXkNCj4gDQo+ID4gKw0KPiA+ICsJaWYgKCFyZWluaXQpIHsNCj4gPiArCQkvKiBzZXR1
cCBidXMgbnVtYmVycyAqLw0KPiA+ICsJCXZhbHVlID0gbW9iaXZlaWxfY3NyX3JlYWRsKHBjaWUs
IFBDSV9QUklNQVJZX0JVUyk7DQo+ID4gKwkJdmFsdWUgJj0gMHhmZjAwMDAwMDsNCj4gPiArCQl2
YWx1ZSB8PSAweDAwZmYwMTAwOw0KPiA+ICsJCW1vYml2ZWlsX2Nzcl93cml0ZWwocGNpZSwgdmFs
dWUsIFBDSV9QUklNQVJZX0JVUyk7DQo+ID4gKwl9DQo+ID4NCj4gPiAgCS8qDQo+ID4gIAkgKiBw
cm9ncmFtIEJ1cyBNYXN0ZXIgRW5hYmxlIEJpdCBpbiBDb21tYW5kIFJlZ2lzdGVyIGluIFBBQiBD
b25maWcNCj4gPiBAQCAtNTY5LDcgKzU3NCw3IEBAIGludCBtb2JpdmVpbF9wY2llX2hvc3RfcHJv
YmUoc3RydWN0IG1vYml2ZWlsX3BjaWUNCj4gKnBjaWUpDQo+ID4gIAkgKiBjb25maWd1cmUgYWxs
IGluYm91bmQgYW5kIG91dGJvdW5kIHdpbmRvd3MgYW5kIHByZXBhcmUgdGhlIFJDIGZvcg0KPiA+
ICAJICogY29uZmlnIGFjY2Vzcw0KPiA+ICAJICovDQo+ID4gLQlyZXQgPSBtb2JpdmVpbF9ob3N0
X2luaXQocGNpZSk7DQo+ID4gKwlyZXQgPSBtb2JpdmVpbF9ob3N0X2luaXQocGNpZSwgZmFsc2Up
Ow0KPiA+ICAJaWYgKHJldCkgew0KPiA+ICAJCWRldl9lcnIoZGV2LCAiRmFpbGVkIHRvIGluaXRp
YWxpemUgaG9zdFxuIik7DQo+ID4gIAkJcmV0dXJuIHJldDsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4gaW5kZXggOTVk
MmU3YzgwOWI4Li4zNzExNmMyYTE5ZmUgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLmgNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL21vYml2ZWlsL3BjaWUtbW9iaXZlaWwuaA0KPiA+IEBAIC0xNjYsNiArMTY2LDcg
QEAgc3RydWN0IG1vYml2ZWlsX3BjaWUgeyAgfTsNCj4gPg0KPiA+ICBpbnQgbW9iaXZlaWxfcGNp
ZV9ob3N0X3Byb2JlKHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKTsNCj4gPiAraW50IG1vYml2
ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwgYm9vbCByZWluaXQpOw0K
PiA+ICBib29sIG1vYml2ZWlsX3BjaWVfbGlua191cChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNp
ZSk7ICBpbnQNCj4gPiBtb2JpdmVpbF9icmluZ3VwX2xpbmsoc3RydWN0IG1vYml2ZWlsX3BjaWUg
KnBjaWUpOyAgdm9pZA0KPiA+IHByb2dyYW1fb2Jfd2luZG93cyhzdHJ1Y3QgbW9iaXZlaWxfcGNp
ZSAqcGNpZSwgaW50IHdpbl9udW0sIHU2NA0KPiA+IGNwdV9hZGRyLA0KPiA+IC0tDQo+ID4gMi4x
Ny4xDQo+ID4NCg==
