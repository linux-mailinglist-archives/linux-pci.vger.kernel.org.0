Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id F1373EE2C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2019 03:12:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfD3BMr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Apr 2019 21:12:47 -0400
Received: from mail-eopbgr00077.outbound.protection.outlook.com ([40.107.0.77]:51212
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729238AbfD3BMr (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Apr 2019 21:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=FubN0aNsVXAU9Q8kCGaDTTrgP0G31k56QmtkO7tSaKI=;
 b=CeVPWMhFlxYhmFyOSIXBfpDDfFJXQCNVQodumPAfDxvUxVfVBr7DS6q4Wkn0Wcl7Tb67AAFKfTgJjf3sv0BCK6q+ah4iZV7z6LRfwVdLWVHJs4KsMYfUymnJI8EU+NGyuqz48fLJc+oYptnLo25CxKqtjjmk9De1Y3GwVD3ZjGc=
Received: from VI1PR04MB5792.eurprd04.prod.outlook.com (20.178.204.10) by
 VI1PR04MB5904.eurprd04.prod.outlook.com (20.178.205.78) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.1835.13; Tue, 30 Apr 2019 01:12:41 +0000
Received: from VI1PR04MB5792.eurprd04.prod.outlook.com
 ([fe80::3830:3e3d:cf09:ba7]) by VI1PR04MB5792.eurprd04.prod.outlook.com
 ([fe80::3830:3e3d:cf09:ba7%2]) with mapi id 15.20.1835.018; Tue, 30 Apr 2019
 01:12:40 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Subrahmanya Lingappa <l.subrahmanya@mobiveil.co.in>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "catalin.marinas@arm.com" <catalin.marinas@arm.com>,
        "will.deacon@arm.com" <will.deacon@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: RE: [EXT] Re: [PATCHv5 1/6] PCI: mobiveil: Refactor Mobiveil PCIe
 Host Bridge IP driver
Thread-Topic: [EXT] Re: [PATCHv5 1/6] PCI: mobiveil: Refactor Mobiveil PCIe
 Host Bridge IP driver
Thread-Index: AQHU8RVxwCgqbmUIs0+mzKQDP7R+kqZK3O0AgAkbXEA=
Date:   Tue, 30 Apr 2019 01:12:40 +0000
Message-ID: <VI1PR04MB5792C90E4DE2D75863DCDD49843A0@VI1PR04MB5792.eurprd04.prod.outlook.com>
References: <20190412095332.41370-1-Zhiqiang.Hou@nxp.com>
 <20190412095332.41370-2-Zhiqiang.Hou@nxp.com>
 <CAFZiPx3AygiX7tDL0DTVB-JYd+7SZ9NL6ZE0RH-=n0Z=VqhyLw@mail.gmail.com>
In-Reply-To: <CAFZiPx3AygiX7tDL0DTVB-JYd+7SZ9NL6ZE0RH-=n0Z=VqhyLw@mail.gmail.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.68]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: f2c43d56-9806-454b-57e2-08d6cd08f12d
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600141)(711020)(4605104)(4618075)(2017052603328)(7193020);SRVR:VI1PR04MB5904;
x-ms-traffictypediagnostic: VI1PR04MB5904:
x-microsoft-antispam-prvs: <VI1PR04MB59048FE8177E88F98C2FF845843A0@VI1PR04MB5904.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 00235A1EEF
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(346002)(39860400002)(376002)(366004)(136003)(396003)(54534003)(13464003)(189003)(199004)(6116002)(97736004)(53936002)(52536014)(71190400001)(71200400001)(5660300002)(76176011)(64756008)(66556008)(66476007)(4326008)(76116006)(7416002)(73956011)(7696005)(66446008)(66946007)(9686003)(6916009)(7736002)(99286004)(68736007)(74316002)(305945005)(14454004)(316002)(229853002)(25786009)(6436002)(86362001)(476003)(256004)(186003)(486006)(26005)(53546011)(5024004)(14444005)(8676002)(102836004)(81156014)(11346002)(8936002)(446003)(81166006)(66066001)(6246003)(6506007)(478600001)(55016002)(54906003)(2906002)(33656002)(3846002);DIR:OUT;SFP:1101;SCL:1;SRVR:VI1PR04MB5904;H:VI1PR04MB5792.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: EJeYmGiHM67Ds61Mh6BX08XWHFqD6r2c38e7adr76HL2muJz60nB4gc8KB/JBLklzAB4mvGBOwzo4rX5qT+OqXeSi/RAex++5mSq7IvXYcyg3P0V06iCd+XUWnthKiK1zYeVygogbYpF9s+Wm0/oPj+xHLLex/NpLeHJGQByHAO0SmKeazgulersiwt0RsbPxsd9bcEnQGrgHUqhiabI0PRpoMcYqN9UxgQv9cnXHfQAJrD/8et1jD/toBBJKQvs0ZLYVwxSa/Ffwcy78ya24kzLgiX9GBuUMVnuC5lcx5uVWu1NXu3JZ5DdmecQN+rx6B6+QcVAEDTfP2gh847ycdaVEF+UbY8V/K9Wr2+0RiILKkJm8b049uyUEvqdF4uIgzXnw4mlFow41bUXaEo8/dufq1fD5yjEtWdZaAKI76w=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: f2c43d56-9806-454b-57e2-08d6cd08f12d
X-MS-Exchange-CrossTenant-originalarrivaltime: 30 Apr 2019 01:12:40.6975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-Transport-CrossTenantHeadersStamped: VI1PR04MB5904
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgU3ViYnUsDQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogU3VicmFo
bWFueWEgTGluZ2FwcGEgW21haWx0bzpsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluXQ0KPiBT
ZW50OiAyMDE55bm0NOaciDI05pelIDEzOjM2DQo+IFRvOiBaLnEuIEhvdSA8emhpcWlhbmcuaG91
QG54cC5jb20+DQo+IENjOiBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOyBsaW51eC1hcm0ta2Vy
bmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7DQo+IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOyBs
aW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnOw0KPiBiaGVsZ2Fhc0Bnb29nbGUuY29tOyByb2Jo
K2R0QGtlcm5lbC5vcmc7IG1hcmsucnV0bGFuZEBhcm0uY29tOw0KPiBzaGF3bmd1b0BrZXJuZWwu
b3JnOyBMZW8gTGkgPGxlb3lhbmcubGlAbnhwLmNvbT47DQo+IGxvcmVuem8ucGllcmFsaXNpQGFy
bS5jb207IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOw0KPiB3aWxsLmRlYWNvbkBhcm0uY29tOyBN
aW5na2FpIEh1IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4NCj4gPG1pbmdodWFuLmxp
YW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBTdWJqZWN0
OiBbRVhUXSBSZTogW1BBVENIdjUgMS82XSBQQ0k6IG1vYml2ZWlsOiBSZWZhY3RvciBNb2JpdmVp
bCBQQ0llIEhvc3QNCj4gQnJpZGdlIElQIGRyaXZlcg0KPiANCj4gV0FSTklORzogVGhpcyBlbWFp
bCB3YXMgY3JlYXRlZCBvdXRzaWRlIG9mIE5YUC4gRE8gTk9UIENMSUNLIGxpbmtzIG9yDQo+IGF0
dGFjaG1lbnRzIHVubGVzcyB5b3UgcmVjb2duaXplIHRoZSBzZW5kZXIgYW5kIGtub3cgdGhlIGNv
bnRlbnQgaXMgc2FmZS4NCj4gDQo+IA0KPiANCj4gWlEsDQo+IA0KPiBPbiBGcmksIEFwciAxMiwg
MjAxOSBhdCAzOjIyIFBNIFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4gd3JvdGU6DQo+
ID4NCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+
ID4gUmVmYWN0b3IgdGhlIE1vYml2ZWlsIFBDSWUgSG9zdCBCcmlkZ2UgSVAgZHJpdmVyIHRvIG1h
a2UNCj4gPiBpdCBlYXNpZXIgdG8gYWRkIHN1cHBvcnQgZm9yIGJvdGggUkMgYW5kIEVQIG1vZGUg
ZHJpdmVyLg0KPiA+IFRoaXMgcGF0Y2ggbW92ZWQgdGhlIE1vYml2ZWlsIGRyaXZlciB0byBhbiBu
ZXcgZGlyZWN0b3J5DQo+ID4gJ2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwnIGFuZCBy
ZWZhY3RvciBpdCBhY2NvcmRpbmcNCj4gPiB0byB0aGUgUkMgYW5kIEVQIGFic3RyYWN0aW9uLg0K
PiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNv
bT4NCj4gPiBSZXZpZXdlZC1ieTogTWluZ2h1YW4gTGlhbiA8TWluZ2h1YW4uTGlhbkBueHAuY29t
Pg0KPiA+IFJldmlld2VkLWJ5OiBTdWJyYWhtYW55YSBMaW5nYXBwYSA8bC5zdWJyYWhtYW55YUBt
b2JpdmVpbC5jby5pbj4NCj4gPiAtLS0NCj4gPiBWNToNCj4gPiAgLSBSZWdlbmVyYXRlZCB0aGlz
IHBhdGNoIG9uIHRoZSBuZXcgYmFzZS4NCj4gPiAgLSBSZXRvdWNoZWQgdGhlIGNoYW5nZWxvZy4N
Cj4gPiAgLSBVcGRhdGVkIHRoZSBDb3B5cmlnaHQuDQo+ID4NCj4gPiAgTUFJTlRBSU5FUlMgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgICAyICstDQo+ID4gIGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvS2NvbmZpZyAgICAgICAgICAgICAgICB8ICAxMSArLQ0KPiA+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL01ha2VmaWxlICAgICAgICAgICAgICAgfCAgIDIgKy0NCj4gPiAgZHJp
dmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9LY29uZmlnICAgICAgIHwgIDI0ICsNCj4gPiAg
ZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9NYWtlZmlsZSAgICAgIHwgICA0ICsNCj4g
PiAgLi4uL3BjaWUtbW9iaXZlaWwtaG9zdC5jfSAgICAgICAgICAgICAgICAgICAgIHwgNTcwICsr
Ky0tLS0tLS0tLS0tLS0tLQ0KPiA+ICAuLi4vY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2
ZWlsLXBsYXQuYyAgfCAgNTYgKysNCj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL21vYml2ZWlsL3Bj
aWUtbW9iaXZlaWwuYyAgIHwgMjQ4ICsrKysrKysrDQo+ID4gIC4uLi9wY2kvY29udHJvbGxlci9t
b2JpdmVpbC9wY2llLW1vYml2ZWlsLmggICB8IDIxMSArKysrKysrDQo+ID4gIDkgZmlsZXMgY2hh
bmdlZCwgNjM2IGluc2VydGlvbnMoKyksIDQ5MiBkZWxldGlvbnMoLSkNCj4gPiAgY3JlYXRlIG1v
ZGUgMTAwNjQ0IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvbW9iaXZlaWwvS2NvbmZpZw0KPiA+ICBj
cmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9NYWtlZmls
ZQ0KPiA+ICByZW5hbWUgZHJpdmVycy9wY2kvY29udHJvbGxlci97cGNpZS1tb2JpdmVpbC5jID0+
DQo+IG1vYml2ZWlsL3BjaWUtbW9iaXZlaWwtaG9zdC5jfSAoNTMlKQ0KPiA+ICBjcmVhdGUgbW9k
ZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsLXBs
YXQuYw0KPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2Jp
dmVpbC9wY2llLW1vYml2ZWlsLmMNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IGRyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvbW9iaXZlaWwvcGNpZS1tb2JpdmVpbC5oDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvTUFJTlRBSU5FUlMgYi9NQUlOVEFJTkVSUw0KPiA+IGluZGV4IDFlNjQyNzlmMzM4YS4uMTAx
M2U3NGIxNGYyIDEwMDY0NA0KPiA+IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRB
SU5FUlMNCj4gPiBAQCAtMTE4NzcsNyArMTE4NzcsNyBAQCBNOiAgICAgIFN1YnJhaG1hbnlhIExp
bmdhcHBhDQo+IDxsLnN1YnJhaG1hbnlhQG1vYml2ZWlsLmNvLmluPg0KPiA+ICBMOiAgICAgbGlu
dXgtcGNpQHZnZXIua2VybmVsLm9yZw0KPiA+ICBTOiAgICAgU3VwcG9ydGVkDQo+ID4gIEY6ICAg
ICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL21vYml2ZWlsLXBjaWUudHh0
DQo+ID4gLUY6ICAgICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+
ICtGOiAgICAgZHJpdmVycy9wY2kvY29udHJvbGxlci9tb2JpdmVpbC9wY2llLW1vYml2ZWlsKg0K
PiA+DQo+IA0KPiBQbGVhc2UgYWRkIHlvdXJzZWxmIGFzIGNvLW1haW50YWluZXIgb2YgdGhlIG1v
Yml2ZWlsIGRyaXZlci4NCg0KVGhhbmtzIGZvciB5b3VyIGludml0ZSwgd2lsbCBhZGQgaW4gdjYu
DQoNClJlZ2FyZHMsDQpaaGlxaWFuZw0K
