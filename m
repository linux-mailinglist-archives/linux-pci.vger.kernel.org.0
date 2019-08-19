Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6547795203
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 01:58:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728526AbfHSX5k (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 19:57:40 -0400
Received: from mail-eopbgr80079.outbound.protection.outlook.com ([40.107.8.79]:14405
        "EHLO EUR04-VI1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728554AbfHSX5k (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 19 Aug 2019 19:57:40 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=FLA4+kM0/3TZsInFRLgn5Da/O8UlKAoi1YbaQSkuqRhRISUJPHkoG36fYEcHOdrdoRJWDmgyW1FHqbwOlETWPXGGYI2WjX6CYirJpZn+PMN2uVe8HI/l6KzNbDa4AXhGqX/Pj4LuQadmZ8M3/NLmPIGv62nP4BUH3+2pc7WFvVhN81qt6a2P5n17lGn2r+YU01R/83R7wIgn7PT+ASL7Sw86dw3ByrNXUmlLSGXizP3o774wzCQy0ALlVhM2a9ybMnzUWSF2ADpDF3CXQXliTpjoLIFI3c8z8nl0WVg01px5zH/1eE95rE0e7wOfEJLAtAiKkfSAmKIr1d3RTRAycg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrBhBatRPS0Wwy0+Zisnq+Ovf93wE82aJdkfRerVzPo=;
 b=iEm6TiEBJX9614gHJId0zz4WCUMDlR4LY1tSDaALM0KuQvaKqxD1X7tklFJ+Zx0Zz38Y5hqEQcnNRr1A7XFzK+7NAuear4BfVOZ5ZuHT+xpr1vbR/s1QFOBWNxJ3bmhXTf9+sqywtlA0LGp6IdBW/99BokKthGC1f9ltznfVXafbbYLtH1ShdmepxSBBI6iwG9cVOtLFfBaHgQdUdCel8lWn/6UF82qFdmN0gK5WpKmOO69zjdROjn5WmUlRaFBVFDTxJC5Wr37dEZ0ODbA5NVuCHyTXT6rjQKEt6wG9gAXlzBN4Vkz8he/rL8m1PrnqC2PWdQCr5qXQCFCDtz6gHg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=TrBhBatRPS0Wwy0+Zisnq+Ovf93wE82aJdkfRerVzPo=;
 b=d91wmJgITfqP7fDpFZNVvILXwFlI+hDa8Rt7ex3G9ug8vJfivJV4WyUdKKCcMqy8i11jNdEmibic/ytHML+kXLi2zCUXxQfF59DlJkJO+Blajv4S5frp2MP15A6oa6mTGtgpUuLyqdOFF79EEFW1uBxc0SircJtz3KH+marOHVA=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.18; Mon, 19 Aug 2019 23:57:32 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Mon, 19 Aug 2019
 23:57:32 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Thread-Topic: [PATCH 1/4] dt-bingings: PCI: Remove the num-lanes from Required
 properties
Thread-Index: AQHVUMWGvFlksd6l7UqMedZRUuiO6KcC5MeAgABM5VA=
Date:   Mon, 19 Aug 2019 23:57:32 +0000
Message-ID: <DB8PR04MB6747E90543E28E5B9EFE7F1684A80@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-2-Zhiqiang.Hou@nxp.com>
 <20190819192029.GS253360@google.com>
In-Reply-To: <20190819192029.GS253360@google.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [120.244.121.191]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 522c7a1c-4db0-4ae0-b0f5-08d725010041
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(5600148)(711020)(4605104)(1401327)(4618075)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(2017052603328)(7193020);SRVR:DB8PR04MB6747;
x-ms-traffictypediagnostic: DB8PR04MB6747:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6747949A12CDFAEF799BC26784A80@DB8PR04MB6747.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:873;
x-forefront-prvs: 0134AD334F
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(39860400002)(346002)(396003)(376002)(366004)(13464003)(189003)(199004)(446003)(11346002)(476003)(316002)(256004)(229853002)(6916009)(52536014)(74316002)(7736002)(486006)(71200400001)(99286004)(102836004)(6116002)(71190400001)(76176011)(7696005)(54906003)(9686003)(26005)(33656002)(2906002)(81166006)(81156014)(8676002)(6436002)(186003)(6246003)(25786009)(55016002)(6506007)(53546011)(8936002)(14454004)(66066001)(14444005)(3846002)(53936002)(478600001)(66946007)(76116006)(5660300002)(64756008)(7416002)(66476007)(305945005)(86362001)(4326008)(66446008)(66556008);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6747;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: B/v3Gn7jYgDR7snIUl5yOCKN95hKx4Q080dk0gBwIH8QshBeLV/KtuAm8wuu7F2GIQLe19bN3ZBeszxcNbcvQOyG6eQ4mYoq7Qci7BxmhnWTyrGP64Ldo0bj43beYidX92ci+MBJuV532+TcZ4IURsKuwQ0tWD900sc/tp8EL9vnIaEz5LDUOw9M35sNQj50kX5Rp8lRcV7fWlaHgMUS7toGpw168Eqe0cQ3Dz91C/0M5QdPOshVtmkd4IZ3kKW1L0sXAa8/iek2HB/5Qy89f9pqKLjpIESDFdsFsisZS8MnXSXJy7b6PUJuw8q1xcf0KxO0miZjFM5DncGtFCw4kWe/YKZD04cYVq2DgCOjGbi2zkzUgdP2Af5Bvb49cBJuQUAQkfGy/SxL0vNzmWxOdhWSHYPnsmTZvljpT930h4U=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 522c7a1c-4db0-4ae0-b0f5-08d725010041
X-MS-Exchange-CrossTenant-originalarrivaltime: 19 Aug 2019 23:57:32.4465
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qtRL9uE2T2twRkCFXuXbO9ufTdqhGss52kgeG0yTG7g2DI1vJfZIjjOLSJ7J4qud/M1/cIm654qijMPyUCzW9Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6747
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBhIGxvdCBmb3IgeW91ciBjb21tZW50cyENCg0KPiAtLS0tLU9y
aWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWlsdG86aGVsZ2Fh
c0BrZXJuZWwub3JnXQ0KPiBTZW50OiAyMDE5xOo41MIyMMjVIDM6MjANCj4gVG86IFoucS4gSG91
IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwu
b3JnOyBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbTsNCj4gamluZ29vaGFuMUBnbWFpbC5j
b207IHJvYmgrZHRAa2VybmVsLm9yZzsgbWFyay5ydXRsYW5kQGFybS5jb207DQo+IHNoYXduZ3Vv
QGtlcm5lbC5vcmc7IExlbyBMaSA8bGVveWFuZy5saUBueHAuY29tPjsNCj4gbG9yZW56by5waWVy
YWxpc2lAYXJtLmNvbTsgTS5oLiBMaWFuIDxtaW5naHVhbi5saWFuQG54cC5jb20+DQo+IFN1Ympl
Y3Q6IFJlOiBbUEFUQ0ggMS80XSBkdC1iaW5naW5nczogUENJOiBSZW1vdmUgdGhlIG51bS1sYW5l
cyBmcm9tDQo+IFJlcXVpcmVkIHByb3BlcnRpZXMNCj4gDQo+IEluIHN1YmplY3Q6DQo+IA0KPiAg
IHMvZHQtYmluZ2luZ3MvZHQtYmluZGluZ3MvDQo+IA0KPiBBbHNvLCBwb3NzaWJseQ0KPiANCj4g
ICBzL1BDSTovUENJOiBkZXNpZ253YXJlOi8NCj4gDQoNCkknbGwgZml4IHRoZW0gaW4gdjIuDQoN
ClRoYW5rcywNClpoaXFpYW5nDQo+IHNpbmNlIHRoaXMgb25seSBhcHBsaWVzIHRvIGRlc2lnbndh
cmUtcGNpZS50eHQuDQo+IA0KPiBPbiBNb24sIEF1ZyAxMiwgMjAxOSBhdCAwNDoyMjoxNkFNICsw
MDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhv
dUBueHAuY29tPg0KPiA+DQo+ID4gVGhlIG51bS1sYW5lcyBpcyBub3QgYSBtYW5kYXRvcnkgcHJv
cGVydHksIGUuZy4gb24gRlNMIExheWVyc2NhcGUNCj4gPiBTb0NzLCB0aGUgUENJZSBsaW5rIHRy
YWluaW5nIGlzIGNvbXBsZXRlZCBhdXRvbWF0aWNhbGx5IGJhc2Ugb24gdGhlDQo+ID4gc2VsZWN0
ZWQgU2VyRGVzIHByb3RvY29sLCBpdCBkb2Vzbid0IG5lZWQgdGhlIG51bS1sYW5lcyB0byBzZXQt
dXAgdGhlDQo+ID4gbGluayB3aWR0aC4NCj4gPg0KPiA+IEl0IGhhcyBiZWVuIGFkZGVkIGluIHRo
ZSBPcHRpb25hbCBwcm9wZXJ0aWVzLiBUaGlzIHBhdGNoIGlzIHRvIHJlbW92ZQ0KPiA+IGl0IGZy
b20gdGhlIFJlcXVpcmVkIHByb3BlcnRpZXMuDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBIb3Ug
WmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+IC0tLQ0KPiA+ICBEb2N1bWVudGF0
aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndhcmUtcGNpZS50eHQgfCAxIC0NCj4g
PiAgMSBmaWxlIGNoYW5nZWQsIDEgZGVsZXRpb24oLSkNCj4gPg0KPiA+IGRpZmYgLS1naXQgYS9E
b2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndhcmUtcGNpZS50eHQN
Cj4gPiBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZGVzaWdud2FyZS1w
Y2llLnR4dA0KPiA+IGluZGV4IDU1NjFhMWMwNjBkMC4uYmQ4ODBkZjM5YTc5IDEwMDY0NA0KPiA+
IC0tLSBhL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZGVzaWdud2FyZS1w
Y2llLnR4dA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
ZGVzaWdud2FyZS1wY2llLnR4dA0KPiA+IEBAIC0xMSw3ICsxMSw2IEBAIFJlcXVpcmVkIHByb3Bl
cnRpZXM6DQo+ID4gIAkgICAgIHRoZSBBVFUgYWRkcmVzcyBzcGFjZS4NCj4gPiAgICAgIChUaGUg
b2xkIHdheSBvZiBnZXR0aW5nIHRoZSBjb25maWd1cmF0aW9uIGFkZHJlc3Mgc3BhY2UgZnJvbSAi
cmFuZ2VzIg0KPiA+ICAgICAgaXMgZGVwcmVjYXRlZCBhbmQgc2hvdWxkIGJlIGF2b2lkZWQuKQ0K
PiA+IC0tIG51bS1sYW5lczogbnVtYmVyIG9mIGxhbmVzIHRvIHVzZQ0KPiA+ICBSQyBtb2RlOg0K
PiA+ICAtICNhZGRyZXNzLWNlbGxzOiBzZXQgdG8gPDM+DQo+ID4gIC0gI3NpemUtY2VsbHM6IHNl
dCB0byA8Mj4NCj4gPiAtLQ0KPiA+IDIuMTcuMQ0KPiA+DQo=
