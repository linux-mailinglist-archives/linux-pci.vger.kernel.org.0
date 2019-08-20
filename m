Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B223095BF1
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 12:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbfHTKEh (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 06:04:37 -0400
Received: from mail-eopbgr60045.outbound.protection.outlook.com ([40.107.6.45]:38905
        "EHLO EUR04-DB3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728414AbfHTKEg (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Aug 2019 06:04:36 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R9379zKZKFO6jhCLEAF0Kt9SLHA2NxAYSz7hAk9aQlc0aBh4SYXb/d/I78ghYlQEx/YFSnGcgTRdjM/D+62y+XGqca+ltN4Aj68/VUS+F+A04OHULd4uEJyfDnp7o4UC1u/MuBwun9kSAfc55Zm+xSJR53xrFWYm617oUuXmRdF1XMxUUiCdlci7gPBxmuJZxptsZ5DHBz930miUaySADPkhEHNcmnKgi1/qHHk4fXYnM7GOH5RWmCNUyhHS48VzB0gBcvt2dij3AC/BPKNXTClndzx0cN0x9yVToqOdWxZPC6fsfpbxNE49YkdzHfUQUwrEl9NKpwTq2W7vZ6sMTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUkkHLdkPYjkT3+IceX3OfRMUvJFriToSzqQ6I4MFM8=;
 b=Km2vArAuOCX8z64TcXtLRHf0ASl9EksZSF2CAbXCXAfeY40PoTYTqb+zrLHq1vkf7yWMRk8SstHjsIg1jwNC/aDWmWRx/ML9Uy4aIRgtmYzRiEJZBzLI8NghgppOwceQtiWu721bCHSFxkvbzgtTpEFpROgoiC++I8pSO/QnYqz7YEX1LVZQ6aazSTdfSRChwa0VNgvS1CbJiFKerkwPcUbciTAHtlj/+HE8t/mO/T8bqUsQlB7J/FxKaRP4W6XxZtIa2qGoYRaxM2fA8OA+cRgkKX0ApWgwnO8Sjo9ZCTW04t6SZ34krl1bme/jlQ2Uw1oIRgr8CI29oo81yP833w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=xUkkHLdkPYjkT3+IceX3OfRMUvJFriToSzqQ6I4MFM8=;
 b=ZpAapkEMJXU8Ww7Fh2M8NqhHNnh8nEu5wQmevIkpqgk7VetzIRX6W1mujd/XXVO6yqmljGwEuwE5d5ZiPTE8axSW1cQjUDgVVk6OE5IYguLWFx0qC0OQ1GV0CjCvNGNIvlJWLy3tmOKm6kxGBpyIM1Ymn8DUb+5hjtPgutMV71U=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6714.eurprd04.prod.outlook.com (20.179.251.79) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2178.16; Tue, 20 Aug 2019 10:04:29 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2178.018; Tue, 20 Aug 2019
 10:04:29 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <andrew.murray@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Leo Li <leoyang.li@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "M.h. Lian" <minghuan.lian@nxp.com>
Subject: RE: [PATCHv2 1/4] dt-bindings: PCI: designware: Remove the num-lanes
 from Required properties
Thread-Topic: [PATCHv2 1/4] dt-bindings: PCI: designware: Remove the num-lanes
 from Required properties
Thread-Index: AQHVVyjlrdLaxDNDsUGTjgUCHNzTaacDw1wAgAALe3A=
Date:   Tue, 20 Aug 2019 10:04:29 +0000
Message-ID: <DB8PR04MB6747E55FD982EE4C856DF30D84AB0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190820073022.24217-1-Zhiqiang.Hou@nxp.com>
 <20190820073022.24217-2-Zhiqiang.Hou@nxp.com>
 <20190820092251.GE23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190820092251.GE23903@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: 011e555e-4751-4824-3849-08d72555ca4c
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6714;
x-ms-traffictypediagnostic: DB8PR04MB6714:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB671406C16F3421F99FDD8CB384AB0@DB8PR04MB6714.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 013568035E
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(366004)(39860400002)(346002)(136003)(396003)(376002)(199004)(13464003)(54534003)(189003)(7416002)(6916009)(478600001)(76176011)(7696005)(4326008)(74316002)(86362001)(52536014)(5660300002)(33656002)(6116002)(66066001)(6246003)(14444005)(7736002)(256004)(305945005)(14454004)(53936002)(64756008)(71200400001)(71190400001)(55016002)(8936002)(76116006)(9686003)(316002)(81166006)(2906002)(3846002)(81156014)(6436002)(446003)(102836004)(54906003)(11346002)(26005)(186003)(486006)(476003)(25786009)(66476007)(229853002)(66446008)(66556008)(99286004)(66946007)(8676002)(6506007)(53546011);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6714;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: 7h3dGIif/DSXPtreM+T+Fs4V/iFRAXBlpj4XvscP/xKAsxHOU4Z3S7O0AUTbrf6ck4JiJn/ZGedTWoXc4MLen272VCf4cgPACNrnZ+1E7ey8gYqTPylA4bo91i5jC6IteMOZhRnVpKvmRCEdIOQ8g7/l2MXW4kSn235NMoI4Lsm6VF8akUHn/vdJoRFsoBeLTo4GKhJzm8FJv7dnwP6APGi4upoyGmN2SChpgV0hV87v4fL1/WY7XXhmwRxLwehW4qKuxO5AfWUnVvpM4+FMYSPQg4Cu33fxIlApm52OeO5esi3ZcvrISHwCPXLw84hEzS5i/dMjgB+VOAvuExFd7V+BEkczyLvTSs0GVJd1aNF6gLsXaRlEuAZKKz/0nLEVmvp8Wt+DdrWpnr0PK1NiGDJQnOJluNlCO4P/tL954Vo=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 011e555e-4751-4824-3849-08d72555ca4c
X-MS-Exchange-CrossTenant-originalarrivaltime: 20 Aug 2019 10:04:29.1425
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: jjFBG2YJ6R8FluCwj0KSZuC59wzmFTfXrRAK2oCDQ/jE4UguoTnlGEEgkCAMuGvwuv9ckiV0JcoJ3vUr/630HQ==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6714
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpUaGFua3MsDQpa
aGlxaWFuZw0KDQo+IC0tLS0tT3JpZ2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBN
dXJyYXkgPGFuZHJldy5tdXJyYXlAYXJtLmNvbT4NCj4gU2VudDogMjAxOcTqONTCMjDI1SAxNzoy
Mw0KPiBUbzogWi5xLiBIb3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgZGV2aWNldHJlZUB2Z2VyLmtlcm5lbC5vcmc7DQo+IGxpbnV4LWtl
cm5lbEB2Z2VyLmtlcm5lbC5vcmc7IGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tOw0KPiBq
aW5nb29oYW4xQGdtYWlsLmNvbTsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwu
b3JnOw0KPiBtYXJrLnJ1dGxhbmRAYXJtLmNvbTsgc2hhd25ndW9Aa2VybmVsLm9yZzsgTGVvIExp
DQo+IDxsZW95YW5nLmxpQG54cC5jb20+OyBsb3JlbnpvLnBpZXJhbGlzaUBhcm0uY29tOyBNLmgu
IExpYW4NCj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT4NCj4gU3ViamVjdDogUmU6IFtQQVRDSHYy
IDEvNF0gZHQtYmluZGluZ3M6IFBDSTogZGVzaWdud2FyZTogUmVtb3ZlIHRoZQ0KPiBudW0tbGFu
ZXMgZnJvbSBSZXF1aXJlZCBwcm9wZXJ0aWVzDQo+IA0KPiBPbiBUdWUsIEF1ZyAyMCwgMjAxOSBh
dCAwNzoyODo0M0FNICswMDAwLCBaLnEuIEhvdSB3cm90ZToNCj4gPiBGcm9tOiBIb3UgWmhpcWlh
bmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiA+DQo+ID4gVGhlIG51bS1sYW5lcyBpcyBub3Qg
YSBtYW5kYXRvcnkgcHJvcGVydHksIGUuZy4gb24gRlNMIExheWVyc2NhcGUNCj4gPiBTb0NzLCB0
aGUgUENJZSBsaW5rIHRyYWluaW5nIGlzIGNvbXBsZXRlZCBhdXRvbWF0aWNhbGx5IGJhc2Ugb24g
dGhlDQo+ID4gc2VsZWN0ZWQgU2VyRGVzIHByb3RvY29sLCBpdCBkb2Vzbid0IG5lZWQgdGhlIG51
bS1sYW5lcyB0byBzZXQtdXAgdGhlDQo+ID4gbGluayB3aWR0aC4NCj4gPg0KPiA+IEl0IGlzIHBy
ZXZpb3VzbHkgaW4gYm90aCBSZXF1aXJlZCBhbmQgT3B0aW9uYWwgcHJvcGVydGllcywgbGV0J3MN
Cj4gPiByZW1vdmUgaXQgZnJvbSB0aGUgUmVxdWlyZWQgcHJvcGVydGllcy4NCj4gPg0KPiA+IFNp
Z25lZC1vZmYtYnk6IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4gLS0t
DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29t
Pg0KPiANCj4gDQo+ID4gVjI6DQo+ID4gIC0gUmV3b3JkZWQgdGhlIGNoYW5nZSBsb2cgYW5kIHN1
YmplY3QuDQo+ID4gIC0gRml4ZWQgYSB0eXBvIGluIHN1YmplY3QuDQo+ID4NCj4gPiAgRG9jdW1l
bnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9kZXNpZ253YXJlLXBjaWUudHh0IHwgMSAt
DQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxIGRlbGV0aW9uKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0
IGEvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9kZXNpZ253YXJlLXBjaWUu
dHh0DQo+ID4gYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndh
cmUtcGNpZS50eHQNCj4gPiBpbmRleCA1NTYxYTFjMDYwZDAuLmJkODgwZGYzOWE3OSAxMDA2NDQN
Cj4gPiAtLS0gYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL2Rlc2lnbndh
cmUtcGNpZS50eHQNCj4gPiArKysgYi9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3Mv
cGNpL2Rlc2lnbndhcmUtcGNpZS50eHQNCj4gPiBAQCAtMTEsNyArMTEsNiBAQCBSZXF1aXJlZCBw
cm9wZXJ0aWVzOg0KPiA+ICAJICAgICB0aGUgQVRVIGFkZHJlc3Mgc3BhY2UuDQo+ID4gICAgICAo
VGhlIG9sZCB3YXkgb2YgZ2V0dGluZyB0aGUgY29uZmlndXJhdGlvbiBhZGRyZXNzIHNwYWNlIGZy
b20NCj4gInJhbmdlcyINCj4gPiAgICAgIGlzIGRlcHJlY2F0ZWQgYW5kIHNob3VsZCBiZSBhdm9p
ZGVkLikNCj4gPiAtLSBudW0tbGFuZXM6IG51bWJlciBvZiBsYW5lcyB0byB1c2UNCj4gPiAgUkMg
bW9kZToNCj4gPiAgLSAjYWRkcmVzcy1jZWxsczogc2V0IHRvIDwzPg0KPiA+ICAtICNzaXplLWNl
bGxzOiBzZXQgdG8gPDI+DQo+ID4gLS0NCj4gPiAyLjE3LjENCj4gPg0K
