Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0AD0B46E66
	for <lists+linux-pci@lfdr.de>; Sat, 15 Jun 2019 07:03:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725943AbfFOFDj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 Jun 2019 01:03:39 -0400
Received: from mail-eopbgr130073.outbound.protection.outlook.com ([40.107.13.73]:28202
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725927AbfFOFDj (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 15 Jun 2019 01:03:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FOcSy+KiGQxIKss8QBtUtIp7nlP5xib/WpLVin7l/p4=;
 b=JWn4GhSPLRKcg14cq/O92KsQzcS5gC7JBW6G0s3siTnHgEhI+4PmelWRDx9EK1UIJkAwtJWfTcRouMdfsleZ2VfeVBkDHOsrooyLViQLMjJwo55JIULKCi1O2qFt0I2i8No20eb4p01/2xmjiBUWakOXRZCXF0QfBnwr5kveWAo=
Received: from AM0PR04MB6738.eurprd04.prod.outlook.com (20.179.253.203) by
 AM0PR04MB5412.eurprd04.prod.outlook.com (20.178.112.11) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1987.12; Sat, 15 Jun 2019 05:03:33 +0000
Received: from AM0PR04MB6738.eurprd04.prod.outlook.com
 ([fe80::f41f:5455:d0b3:2527]) by AM0PR04MB6738.eurprd04.prod.outlook.com
 ([fe80::f41f:5455:d0b3:2527%4]) with mapi id 15.20.1987.013; Sat, 15 Jun 2019
 05:03:33 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: RE: [PATCHv5 18/20] PCI: mobiveil: Disable IB and OB windows set by
 bootloader
Thread-Topic: [PATCHv5 18/20] PCI: mobiveil: Disable IB and OB windows set by
 bootloader
Thread-Index: AQHU8Qrl2X2dZdmZtkqqPC5pUtT6KKaYlFaAgAPP00A=
Date:   Sat, 15 Jun 2019 05:03:33 +0000
Message-ID: <AM0PR04MB67383C84D946045874B0F14A84E90@AM0PR04MB6738.eurprd04.prod.outlook.com>
References: <20190412083635.33626-1-Zhiqiang.Hou@nxp.com>
 <20190412083635.33626-19-Zhiqiang.Hou@nxp.com>
 <20190612162347.GF15747@redmoon>
In-Reply-To: <20190612162347.GF15747@redmoon>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [27.186.246.136]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 341e3ca0-801d-4e28-e2a9-08d6f14ed131
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:AM0PR04MB5412;
x-ms-traffictypediagnostic: AM0PR04MB5412:
x-microsoft-antispam-prvs: <AM0PR04MB54128FFFE8C2D58F82C0BE9384E90@AM0PR04MB5412.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:2887;
x-forefront-prvs: 0069246B74
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(39860400002)(366004)(376002)(346002)(136003)(396003)(13464003)(199004)(189003)(53936002)(55016002)(229853002)(9686003)(6436002)(7696005)(53546011)(76176011)(6506007)(102836004)(6246003)(3846002)(2906002)(186003)(6116002)(99286004)(4326008)(446003)(11346002)(316002)(110136005)(54906003)(25786009)(486006)(26005)(476003)(71190400001)(71200400001)(66946007)(76116006)(73956011)(66476007)(66556008)(64756008)(66446008)(7736002)(256004)(305945005)(74316002)(52536014)(5660300002)(14444005)(66066001)(7416002)(68736007)(14454004)(86362001)(2501003)(33656002)(81166006)(8676002)(81156014)(8936002)(478600001);DIR:OUT;SFP:1101;SCL:1;SRVR:AM0PR04MB5412;H:AM0PR04MB6738.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: V+xKVAJVpNRfIsDDhlRJqz23pIbyf3nUHQ65YngXDGeLKBdT58s29Xm9Cu60jbuGfyrp3H79n18cqHYmPJytmB8b16j0j/AvD3WIku8plQzyg756Dw4gkc7eDwga0+UfMoyiKzAzogz6ZZoChisVWInyxzohRUchca0XwVk60TlA05reZ6/iz8Ey6Wj5nzVzXNu+jiCDsj95O/YkMluwf1yxB2q0UU3H7GCPZbkNwRdINjzMUIY7/7ntZSNboJ1PmcEhjY/PihDhF/K0pdxTvkhKhEPUitIpHxt3wD1Ce8Up4ashroluizEd3e6cO8X0hTlo7EudfUGz+i61CaGVXy/9eusEOJTJRjZKQFv1JQIF2kJmgI057W5y64eG+ZoFouMXcZSUbKKqpR5B0uX7o1kWRgsyZ9zbVorllM1DVNE=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 341e3ca0-801d-4e28-e2a9-08d6f14ed131
X-MS-Exchange-CrossTenant-originalarrivaltime: 15 Jun 2019 05:03:33.8084
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: zhiqiang.hou@nxp.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM0PR04MB5412
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBMb3Jl
bnpvIFBpZXJhbGlzaSBbbWFpbHRvOmxvcmVuem8ucGllcmFsaXNpQGFybS5jb21dDQo+IFNlbnQ6
IDIwMTnE6jbUwjEzyNUgMDoyNA0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29t
PjsgYmhlbGdhYXNAZ29vZ2xlLmNvbQ0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsg
bGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZnZXIu
a2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gcm9iaCtkdEBrZXJu
ZWwub3JnOyBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgbC5zdWJyYWhtYW55YUBtb2JpdmVpbC5jby5p
bjsNCj4gc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExpIDxsZW95YW5nLmxpQG54cC5jb20+Ow0K
PiBjYXRhbGluLm1hcmluYXNAYXJtLmNvbTsgd2lsbC5kZWFjb25AYXJtLmNvbTsgTWluZ2thaSBI
dQ0KPiA8bWluZ2thaS5odUBueHAuY29tPjsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5j
b20+OyBYaWFvd2VpIEJhbw0KPiA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6
IFtQQVRDSHY1IDE4LzIwXSBQQ0k6IG1vYml2ZWlsOiBEaXNhYmxlIElCIGFuZCBPQiB3aW5kb3dz
IHNldA0KPiBieSBib290bG9hZGVyDQo+IA0KPiBPbiBGcmksIEFwciAxMiwgMjAxOSBhdCAwODoz
NzowMEFNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpo
aXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gRGlzYWJsZSBhbGwgaW5ib3VuZCBhbmQgb3V0
Ym91bmQgd2luZG93cyBiZWZvcmUgc2V0IHVwIHRoZSB3aW5kb3dzIGluDQo+ID4ga2VybmVsLCBp
biBjYXNlIHRyYW5zYWN0aW9ucyBtYXRjaCB0aGUgd2luZG93IHNldCBieSBib290bG9hZGVyLg0K
PiANCj4gVGhlcmUgbXVzdCBiZSBubyBQQ0kgdHJhbnNhY3Rpb25zIG9uZ29pbmcgYXQgYm9vdGxv
YWRlcjwtPk9TIGhhbmRvdmVyLg0KPg0KDQpZZXMsIGV4YWN0Lg0KIA0KPiBUaGUgYm9vdGxvYWRl
ciBuZWVkcyBmaXhpbmcgYW5kIHRoaXMgcGF0Y2ggc2hvdWxkIGJlIGRyb3BwZWQsIHRoZSBob3N0
IGJyaWRnZQ0KPiBkcml2ZXIgYXNzdW1lcyB0aGUgaG9zdCBicmlkZ2Ugc3RhdGUgaXMgZGlzYWJs
ZWQsDQoNClRoZSBob3N0IGJyaWRnZSBkcml2ZXIgc2hvdWxkIG5vdCBhc3N1bWVzIHRoZSBob3N0
IHN0YXRlIGlzIGRpc2FibGVkLCBhY3R1YWxseQ0KdS1ib290IGVuYWJsZS9pbml0aWFsaXplIHRo
ZSBob3N0IGFuZCB3aXRob3V0IGRpc2FibGluZyBpdCB3aGVuIHRyYW5zZmVyIHRoZSANCmNvbnRy
b2wgdG8gTGludXguDQoNCj4gaXQgd2lsbCBwcm9ncmFtIHRoZSBicmlkZ2UNCj4gYXBlcnR1cmVz
IGZyb20gc2NyYXRjaCB3aXRoIG5vIG9uZ29pbmcgdHJhbnNhY3Rpb25zLCBhbnl0aGluZyBkZXZp
YXRpbmcgZnJvbQ0KPiB0aGlzIGJlaGF2aW91ciBpcyBhIGJvb3Rsb2FkZXIgYnVnIGFuZCBhIHJl
Y2lwZSBmb3IgZGlzYXN0ZXIuDQoNClRoZSBwb2ludCBvZiB0aGlzIHBhdGNoIGlzIG5vdCB0byBm
aXggdGhlIG9uZ29pbmcgdHJhbnNhY3Rpb24gaXNzdWUsIGl0IGlzIHRvIGF2b2lkDQphIHBvdGVu
dGlhbCBpc3N1ZSB3aGljaCBpcyBjYXVzZWQgYnkgdGhlIG91dGJvdW5kIHdpbmRvdyBlbmFibGVk
IGJ5IGJvb3Rsb2FkZXINCm92ZXJsYXBwaW5nIHdpdGggTGludXggZW5hYmxlZC4NCg0KVGhhbmtz
LA0KWmhpcWlhbmcNCiANCj4gTG9yZW56bw0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3UgWmhp
cWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IFJldmlld2VkLWJ5OiBNaW5naHVhbiBM
aWFuIDxNaW5naHVhbi5MaWFuQG54cC5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFN1YnJhaG1hbnlh
IExpbmdhcHBhIDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KPiA+IC0tLQ0KPiA+IFY1
Og0KPiA+ICAtIE5vIGZ1bmN0aW9uYWxpdHkgY2hhbmdlLg0KPiA+DQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIHwgMjUgKysrKysrKysrKysrKysrKysrKysrKysr
Kw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjUgaW5zZXJ0aW9ucygrKQ0KPiA+DQo+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ID4gYi9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+IGluZGV4IDhkYzg3YzdhNjAw
ZS4uNDExZTk3NzlkYTEyIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1tb2JpdmVpbC5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1v
Yml2ZWlsLmMNCj4gPiBAQCAtNTY1LDYgKzU2NSwyNCBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX2Jy
aW5ndXBfbGluayhzdHJ1Y3QNCj4gbW9iaXZlaWxfcGNpZSAqcGNpZSkNCj4gPiAgCXJldHVybiAt
RVRJTUVET1VUOw0KPiA+ICB9DQo+ID4NCj4gPiArc3RhdGljIHZvaWQgbW9iaXZlaWxfcGNpZV9k
aXNhYmxlX2liX3dpbihzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSwNCj4gPiAraW50IGlkeCkg
ew0KPiA+ICsJdTMyIHZhbDsNCj4gPiArDQo+ID4gKwl2YWwgPSBjc3JfcmVhZGwocGNpZSwgUEFC
X1BFWF9BTUFQX0NUUkwoaWR4KSk7DQo+ID4gKwl2YWwgJj0gfigxIDw8IEFNQVBfQ1RSTF9FTl9T
SElGVCk7DQo+ID4gKwljc3Jfd3JpdGVsKHBjaWUsIHZhbCwgUEFCX1BFWF9BTUFQX0NUUkwoaWR4
KSk7IH0NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIG1vYml2ZWlsX3BjaWVfZGlzYWJsZV9vYl93
aW4oc3RydWN0IG1vYml2ZWlsX3BjaWUgKnBjaWUsDQo+ID4gK2ludCBpZHgpIHsNCj4gPiArCXUz
MiB2YWw7DQo+ID4gKw0KPiA+ICsJdmFsID0gY3NyX3JlYWRsKHBjaWUsIFBBQl9BWElfQU1BUF9D
VFJMKGlkeCkpOw0KPiA+ICsJdmFsICY9IH4oMSA8PCBXSU5fRU5BQkxFX1NISUZUKTsNCj4gPiAr
CWNzcl93cml0ZWwocGNpZSwgdmFsLCBQQUJfQVhJX0FNQVBfQ1RSTChpZHgpKTsgfQ0KPiA+ICsN
Cj4gPiAgc3RhdGljIHZvaWQgbW9iaXZlaWxfcGNpZV9lbmFibGVfbXNpKHN0cnVjdCBtb2JpdmVp
bF9wY2llICpwY2llKSAgew0KPiA+ICAJcGh5c19hZGRyX3QgbXNnX2FkZHIgPSBwY2llLT5wY2ll
X3JlZ19iYXNlOyBAQCAtNTg1LDYgKzYwMywxMyBAQA0KPiA+IHN0YXRpYyBpbnQgbW9iaXZlaWxf
aG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2llICpwY2llKSAgew0KPiA+ICAJdTMyIHZhbHVl
LCBwYWJfY3RybCwgdHlwZTsNCj4gPiAgCXN0cnVjdCByZXNvdXJjZV9lbnRyeSAqd2luOw0KPiA+
ICsJaW50IGk7DQo+ID4gKw0KPiA+ICsJLyogRGlzYWJsZSBhbGwgaW5ib3VuZC9vdXRib3VuZCB3
aW5kb3dzICovDQo+ID4gKwlmb3IgKGkgPSAwOyBpIDwgcGNpZS0+YXBpb193aW5zOyBpKyspDQo+
ID4gKwkJbW9iaXZlaWxfcGNpZV9kaXNhYmxlX29iX3dpbihwY2llLCBpKTsNCj4gPiArCWZvciAo
aSA9IDA7IGkgPCBwY2llLT5wcGlvX3dpbnM7IGkrKykNCj4gPiArCQltb2JpdmVpbF9wY2llX2Rp
c2FibGVfaWJfd2luKHBjaWUsIGkpOw0KPiA+DQo+ID4gIAkvKiBzZXR1cCBidXMgbnVtYmVycyAq
Lw0KPiA+ICAJdmFsdWUgPSBjc3JfcmVhZGwocGNpZSwgUENJX1BSSU1BUllfQlVTKTsNCj4gPiAt
LQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
