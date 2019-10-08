Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 00AEACF075
	for <lists+linux-pci@lfdr.de>; Tue,  8 Oct 2019 03:26:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729413AbfJHB0V (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Oct 2019 21:26:21 -0400
Received: from mail-eopbgr40078.outbound.protection.outlook.com ([40.107.4.78]:38686
        "EHLO EUR03-DB5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729327AbfJHB0V (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Oct 2019 21:26:21 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n4IVedDv+aY0SN8PlCLNUWq4ximfboWNIm3uZKER1FIJ9Povj688j7pPmeNK/yR6XflyK8RYaBV2hwss8SlMUYV3TVjk/HhaX3yVQEB/ocgQ4264Fqs3pF0bY/McUX6BUr4n4TeAaa37NsM/jkPHHbyyEXYv+zz2R193Aei61GJ+eLoWEvG5ZG9GXsoh4AfDwuQpIBNxef8K9LTfqkF3CanCGosxbxxFyYP1+PixyJmik6BDJh5RYdOApEdZ1NmT+DMP/g6vlZTPAhwDYgBzyGlDQuu5lX4mUVHjzNMcu7vBbmG5u7B/5XzQ91hSouCnmxEoZkW41SkJPqrA/H9ITw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2kpPk9ZS/dex92xd1QfUtScy86W9EeJ3jcvgP9YRH4=;
 b=Cs2BRBWkqWWGPfvlJGud0B4WfH1sML2eN8pRVLOhneUCTtrNzytnzewG/gCOTdtlHiyFDBj6LjaRnGPDWtzBvk6QAwtD+It9PbQ7F72UfpbapsG0QkwdrjFRY/MgPHMd8K7/fCP3Nzi79/wZValBO9oRUj7TA0UXb5Jg3FYySYIBoeahtsd6Cc+a33ecqY/SZpu7V2clDy2XkIXhOYxv4pZgeMiNfZ6XzqOAN4zmOv9Dvb5YQ3eN2mBpw+R8lKMVX0LpfJzOJCDAwIYbo07iwJeul9GIs/cBc9izTU56e11EuqEEDSuGZ3mgroj8nhaoGBf2TIAOCsATcrxFwEPuGA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=q2kpPk9ZS/dex92xd1QfUtScy86W9EeJ3jcvgP9YRH4=;
 b=eM3HEeM78oaSojLbmMayvVlxIJSWLa5oHgsbkjti711FSamvxarbIeeHqEitJgVMs8Yfquu1ZX7ioYAFBSnw2nNMm+kBffWzZ8QEgmwOes9phYwnjCVgSdufTU8NOojDkVNSiMfjR3iIzOhG3LJlS6S06ZqlIeYgbdycwO0SFR0=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB3027.eurprd04.prod.outlook.com (10.173.254.142) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2327.24; Tue, 8 Oct 2019 01:26:15 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::5dd3:ddc9:411a:db41]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::5dd3:ddc9:411a:db41%3]) with mapi id 15.20.2305.023; Tue, 8 Oct 2019
 01:26:15 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Rob Herring <robh@kernel.org>
CC:     "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>, "kishon@ti.com" <kishon@ti.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of the
 layerscape
Thread-Topic: [PATCH 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of the
 layerscape
Thread-Index: AQHVbDZrgKqekKwvukSM1HLkRzBd6adE4qCAgAszjUA=
Date:   Tue, 8 Oct 2019 01:26:15 +0000
Message-ID: <AM5PR04MB3299504E1D4869B3B727233EF59A0@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
 <20190916021742.22844-3-xiaowei.bao@nxp.com> <20190930222221.GA13251@bogus>
In-Reply-To: <20190930222221.GA13251@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: e091f15a-e021-45e3-78b7-08d74b8e8360
x-ms-office365-filtering-ht: Tenant
x-ms-traffictypediagnostic: AM5PR04MB3027:|AM5PR04MB3027:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB3027750193C63263A0FA7D6FF59A0@AM5PR04MB3027.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:3513;
x-forefront-prvs: 01842C458A
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(39860400002)(346002)(136003)(396003)(366004)(376002)(13464003)(199004)(189003)(305945005)(66446008)(64756008)(9686003)(6436002)(102836004)(76176011)(53546011)(229853002)(6506007)(14444005)(256004)(8936002)(7416002)(14454004)(33656002)(81166006)(81156014)(4326008)(44832011)(54906003)(66476007)(478600001)(66556008)(74316002)(316002)(8676002)(6246003)(55016002)(52536014)(6116002)(86362001)(25786009)(26005)(71190400001)(71200400001)(7696005)(7736002)(486006)(2906002)(76116006)(11346002)(446003)(5660300002)(66066001)(66946007)(6916009)(3846002)(186003)(99286004)(476003);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB3027;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: h60ZB8SyCsbiZS7fR5mZBGidta7AyWVW3ecNkZkAvguh9E/XRBTtnO0z9mHAfjBm3SvBOawNQyq9RTdmvasPuf6fhXkf2r+0wd0dN0eY+JJ1x3YB9xujiKp1pmZXjf7c2LkEPuh3Vp/zAQ/CYAsw77aE5g3N55TSnhiTrUIkz8n1HADguF7yrqcMlaflRQbnIUZrr2Oi5mSX8C1xc0LmKw+t5FENF+vRHOnQ3uqpCWdLrh6600+Dv7oKlfM53AbIkHG68tDP3LYmNkE2UQDasGYLqohTdZjGvKvoPhtcjDEwRvGWpbLzUfolme4eWPHbcJZQM3iGZHCUKYWrdyIYQ5HXlB57C6NoFFnkJKTDsGFkMZ5iEmjlK61s8Y4foAUbTscrAMkuCqXb4qCsi9BE2hQbSwIFEwJwUrvC0zKKgoo=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: e091f15a-e021-45e3-78b7-08d74b8e8360
X-MS-Exchange-CrossTenant-originalarrivaltime: 08 Oct 2019 01:26:15.7141
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: o9YVkN61QqdIMK+AtiLFE44Y5H5IBhVOnV8ZJ5PAWDBByGZwDw9KlbYxWrUfRcvujntcb9EChU1W3vtl+Wsk8g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB3027
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqMTDUwjHI1SA2OjIyDQo+IFRvOiBYaWFvd2Vp
IEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4gQ2M6IFoucS4gSG91IDx6aGlxaWFuZy5ob3VA
bnhwLmNvbT47IGJoZWxnYWFzQGdvb2dsZS5jb207DQo+IG1hcmsucnV0bGFuZEBhcm0uY29tOyBz
aGF3bmd1b0BrZXJuZWwub3JnOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGtpc2hv
bkB0aS5jb207IGxvcmVuem8ucGllcmFsaXNpQGFybS5jb207IE0uaC4gTGlhbg0KPiA8bWluZ2h1
YW4ubGlhbkBueHAuY29tPjsgYW5kcmV3Lm11cnJheUBhcm0uY29tOyBNaW5na2FpIEh1DQo+IDxt
aW5na2FpLmh1QG54cC5jb20+OyBsaW51eC1wY2lAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1h
cm0ta2VybmVsQGxpc3RzLmluZnJhZGVhZC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3Jn
Ow0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnDQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
Mi82XSBkdC1iaW5kaW5nczogQWRkIERUIGJpbmRpbmcgZm9yIFBDSUUgR0VONCBFUCBvZiB0aGUN
Cj4gbGF5ZXJzY2FwZQ0KPiANCj4gT24gTW9uLCBTZXAgMTYsIDIwMTkgYXQgMTA6MTc6MzhBTSAr
MDgwMCwgWGlhb3dlaSBCYW8gd3JvdGU6DQo+ID4gQWRkIHRoZSBkb2N1bWVudGF0aW9uIGZvciB0
aGUgRGV2aWNlIFRyZWUgYmluZGluZyBvZiB0aGUgbGF5ZXJzY2FwZQ0KPiA+IFBDSWUgR0VONCBj
b250cm9sbGVyIHdpdGggRVAgbW9kZS4NCj4gPg0KPiA+IFNpZ25lZC1vZmYtYnk6IFhpYW93ZWkg
QmFvIDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vYmluZGluZ3MvcGNp
L2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dCAgICAgICAgICB8IDI4DQo+ICsrKysrKysrKysrKysr
KysrKysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDI3IGluc2VydGlvbnMoKyksIDEgZGVsZXRp
b24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQNCj4gPiBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJl
ZS9iaW5kaW5ncy9wY2kvbGF5ZXJzY2FwZS1wY2llLWdlbjQudHh0DQo+ID4gYi9Eb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1nZW40LnR4dA0KPiA+
IGluZGV4IGI0MGZiNWQuLjQxNGE4NmMgMTAwNjQ0DQo+ID4gLS0tIGEvRG9jdW1lbnRhdGlvbi9k
ZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9sYXllcnNjYXBlLXBjaWUtZ2VuNC50eHQNCj4gPiArKysg
Yi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2xheWVyc2NhcGUtcGNpZS1n
ZW40LnR4dA0KPiA+IEBAIC0zLDYgKzMsOCBAQCBOWFAgTGF5ZXJzY2FwZSBQQ0llIEdlbjQgY29u
dHJvbGxlciAgVGhpcyBQQ0llDQo+ID4gY29udHJvbGxlciBpcyBiYXNlZCBvbiB0aGUgTW9iaXZl
aWwgUENJZSBJUCBhbmQgdGh1cyBpbmhlcml0cyBhbGwgIHRoZQ0KPiA+IGNvbW1vbiBwcm9wZXJ0
aWVzIGRlZmluZWQgaW4gbW9iaXZlaWwtcGNpZS50eHQuDQo+ID4NCj4gPiArSE9TVCBNT0RFDQo+
ID4gKz09PT09PT09PQ0KPiA+ICBSZXF1aXJlZCBwcm9wZXJ0aWVzOg0KPiA+ICAtIGNvbXBhdGli
bGU6IHNob3VsZCBjb250YWluIHRoZSBwbGF0Zm9ybSBpZGVudGlmaWVyIHN1Y2ggYXM6DQo+ID4g
ICAgImZzbCxseDIxNjBhLXBjaWUiDQo+ID4gQEAgLTIzLDcgKzI1LDIwIEBAIFJlcXVpcmVkIHBy
b3BlcnRpZXM6DQo+ID4gIC0gbXNpLXBhcmVudCA6IFNlZSB0aGUgZ2VuZXJpYyBNU0kgYmluZGlu
ZyBkZXNjcmliZWQgaW4NCj4gPiAgICBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
aW50ZXJydXB0LWNvbnRyb2xsZXIvbXNpLnR4dC4NCj4gPg0KPiA+IC1FeGFtcGxlOg0KPiA+ICtE
RVZJQ0UgTU9ERQ0KPiA+ICs9PT09PT09PT0NCj4gPiArUmVxdWlyZWQgcHJvcGVydGllczoNCj4g
PiArLSBjb21wYXRpYmxlOiBzaG91bGQgY29udGFpbiB0aGUgcGxhdGZvcm0gaWRlbnRpZmllciBz
dWNoIGFzOg0KPiA+ICsgICJmc2wsbHgyMTYwYS1wY2llLWVwIg0KPiA+ICstIHJlZzogYmFzZSBh
ZGRyZXNzZXMgYW5kIGxlbmd0aHMgb2YgdGhlIFBDSWUgY29udHJvbGxlciByZWdpc3RlciBibG9j
a3MuDQo+ID4gKyAgInJlZ3MiOiBQQ0llIGNvbnRyb2xsZXIgcmVnaXN0ZXJzLg0KPiA+ICsgICJh
ZGRyX3NwYWNlIiBFUCBkZXZpY2UgQ1BVIGFkZHJlc3MuDQo+ID4gKy0gYXBpby13aW5zOiBudW1i
ZXIgb2YgcmVxdWVzdGVkIGFwaW8gb3V0Ym91bmQgd2luZG93cy4NCj4gPiArDQo+ID4gK09wdGlv
bmFsIFByb3BlcnR5Og0KPiA+ICstIG1heC1mdW5jdGlvbnM6IE1heGltdW0gbnVtYmVyIG9mIGZ1
bmN0aW9ucyB0aGF0IGNhbiBiZSBjb25maWd1cmVkDQo+IChkZWZhdWx0IDEpLg0KPiA+ICsNCj4g
PiArUkMgRXhhbXBsZToNCj4gPg0KPiA+ICAJcGNpZUAzNDAwMDAwIHsNCj4gPiAgCQljb21wYXRp
YmxlID0gImZzbCxseDIxNjBhLXBjaWUiOw0KPiA+IEBAIC01MCwzICs2NSwxNCBAQCBFeGFtcGxl
Og0KPiA+ICAJCQkJPDAwMDAgMCAwIDMgJmdpYyAwIDAgR0lDX1NQSSAxMTENCj4gSVJRX1RZUEVf
TEVWRUxfSElHSD4sDQo+ID4gIAkJCQk8MDAwMCAwIDAgNCAmZ2ljIDAgMCBHSUNfU1BJIDExMg0K
PiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsNCj4gPiAgCX07DQo+ID4gKw0KPiA+ICtFUCBFeGFtcGxl
Og0KPiA+ICsNCj4gPiArCXBjaWVfZXBAMzQwMDAwMCB7DQo+IA0KPiBwY2llLWVuZHBvaW50QC4u
Lg0KPiANCj4gPiArCQljb21wYXRpYmxlID0gImZzbCxseDIxNjBhLXBjaWUtZXAiOw0KPiA+ICsJ
CXJlZyA9IDwweDAwIDB4MDM0MDAwMDAgMHgwIDB4MDAxMDAwMDANCj4gPiArCQkgICAgICAgMHg4
MCAweDAwMDAwMDAwIDB4OCAweDAwMDAwMDAwPjsNCj4gPiArCQlyZWctbmFtZXMgPSAicmVncyIs
ICJhZGRyX3NwYWNlIjsNCj4gPiArCQlhcGlvLXdpbnMgPSA8OD47DQo+ID4gKwkJc3RhdHVzID0g
ImRpc2FibGVkIjsNCj4gDQo+IERvbid0IHNob3cgc3RhdHVzIGluIGV4YW1wbGVzLg0KDQpTb3Jy
eSwgSSB3aWxsIGFkZCBpdCwgdGhhbmtzDQoNClRoYW5rcw0KWGlhb3dlaQ0KDQo+IA0KPiA+ICsJ
fTsNCj4gPiAtLQ0KPiA+IDIuOS41DQo+ID4NCg==
