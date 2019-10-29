Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7CC11E83AF
	for <lists+linux-pci@lfdr.de>; Tue, 29 Oct 2019 10:00:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730394AbfJ2JAp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 29 Oct 2019 05:00:45 -0400
Received: from mail-eopbgr20046.outbound.protection.outlook.com ([40.107.2.46]:58562
        "EHLO EUR02-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1730298AbfJ2JAp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 29 Oct 2019 05:00:45 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Ybaba4wV0UIZncLSoifMfVgN5u6CIEzxgNvGeTk31M/QSz0IvJ4tRwYB9emXWBOkAp6QyRWDjtiCkegNIVhKmKeudRWp8a1IzbSEBmt+sRl0Vcucb0hTXHsmarl/LUJRteCRmnGbpHFjw1h4rLPxQZtWrfRFmXF5huF+aKJt1kaE7DGsPTt6/CsD0/dBJRWUNFGT5mg14NrkcNuBJOomNfMwWFDD1lHS2PRSZPwoNlzrIWtnaVDrog3DptlaOIZ0MkmWtsXujv+yIsevvIW6AvlfAuozQrR9kGZSuxXctuAtUNaTRk/UvDFE5+XHXQkozVtAaRoIZ1zTfy3LVdKvlw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iXRmcCbl9+3snGwvi3OUEPv2Jm8dBThEauTVsyigX8=;
 b=h3+NxiUU4+2T0PaGfM1d/hEg7YJswJzUG7d9lqTNUN3lLLpfFeHFERwYRCy1/O6hRmElSQsdCnc6XkMkc3qCHFwoC5B7o4/XBQSeZxBEUioKsjrPz9sEa9KnVxd2MVEysrGfqwbBkmaXIiyQMTewSxGciP01F7qumofwxCxjOaP9vAaW8xcZK//yJFupAARC/aoNvr3jh1zqeNNNOiCLuTSACjblz3GFv4O/waBnUQgu+UASi25eAXBJmL7aqweBKpEYfwAoVIyKEBiEXF8UxkzQKEl+9SQGBHq9o1XCdQUvQ7wqeqL7H2CujbBnMp6mnZI+U1Dz/yUMHDfG+T+8mA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+iXRmcCbl9+3snGwvi3OUEPv2Jm8dBThEauTVsyigX8=;
 b=iKh3gpHtnE/wgnVdmmv+m/qiXpHUj+n9EG0jEn8wSdupTfLzRuA4HmPmpXHq8s+421Hev1kZuUmM/p1aT6H3KcvS8GOCcq2UZ4Gv3wl8l8cT1JxA4RyH/BOovS+uSrI2Svy2tjPsL+BqXA45wwqS5h0qW1+mPO8HYEtWVWbIzVk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6363.eurprd04.prod.outlook.com (10.255.170.14) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2387.24; Tue, 29 Oct 2019 09:00:34 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::f54f:12e3:3d7c:167b]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::f54f:12e3:3d7c:167b%3]) with mapi id 15.20.2367.031; Tue, 29 Oct 2019
 09:00:34 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Rob Herring <robh@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        Christoph Hellwig <hch@infradead.org>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Heiko Stuebner <heiko@sntech.de>,
        Jingoo Han <jingoohan1@gmail.com>,
        Karthikeyan Mitran <m.karthikeyan@mobiveil.co.in>,
        Ley Foon Tan <lftan@altera.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Michal Simek <michal.simek@xilinx.com>,
        Ray Jui <rjui@broadcom.com>,
        "rfi@lists.rocketboards.org" <rfi@lists.rocketboards.org>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Scott Branden <sbranden@broadcom.com>,
        Shawn Lin <shawn.lin@rock-chips.com>,
        Simon Horman <horms@verge.net.au>,
        Srinath Mannam <srinath.mannam@broadcom.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Toan Le <toan@os.amperecomputing.com>,
        Tom Joseph <tjoseph@cadence.com>, Will Deacon <will@kernel.org>
Subject: RE: [PATCH v3 09/25] PCI: mobiveil: Use
 pci_parse_request_of_pci_ranges()
Thread-Topic: [PATCH v3 09/25] PCI: mobiveil: Use
 pci_parse_request_of_pci_ranges()
Thread-Index: AQHVja1swGHLnpSLL0anxzWa+mLdpadxUoRQ
Date:   Tue, 29 Oct 2019 09:00:34 +0000
Message-ID: <DB8PR04MB6747A5E55650DD7ED174840284610@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20191028163256.8004-1-robh@kernel.org>
 <20191028163256.8004-10-robh@kernel.org>
In-Reply-To: <20191028163256.8004-10-robh@kernel.org>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 52dec04b-13c7-43b9-4a84-08d75c4e75b7
x-ms-traffictypediagnostic: DB8PR04MB6363:
x-microsoft-antispam-prvs: <DB8PR04MB6363351F5D87EA7E86A5B18C84610@DB8PR04MB6363.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:1201;
x-forefront-prvs: 0205EDCD76
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(136003)(396003)(346002)(366004)(376002)(39860400002)(199004)(189003)(13464003)(7696005)(66946007)(66476007)(66446008)(11346002)(316002)(66556008)(64756008)(110136005)(26005)(54906003)(52536014)(478600001)(25786009)(2906002)(99286004)(33656002)(7416002)(7406005)(6506007)(76116006)(71190400001)(5660300002)(71200400001)(53546011)(14454004)(476003)(4326008)(9686003)(76176011)(256004)(6436002)(3846002)(446003)(55016002)(186003)(86362001)(14444005)(8936002)(6246003)(81166006)(305945005)(66066001)(7736002)(102836004)(486006)(81156014)(8676002)(74316002)(229853002)(6116002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6363;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: 3UWwX0buDQ8xTT6MY3jODIElA7U7kEG6E2N3JqrpUIiA/D0Pz27pJ26tcB7pHaf73w2i1QM1vw8ZY3Gs6MhnFdiH7DZJFycNUZdIu2nRWJLQkI5Ltfwyo5x6EoNKmfbMjEh2xbo9LWIUQZ6VOXku0d29ieuen8QRvs/zYWXQGQXdfKbXlTcfDX9rs5s6m1T4+5qNqKgAFubdTENbIhlWBv6hz4uKHETX8wyBhwlA3ublAaXdzkZzPR+cJTMeyJEOoCX1kHC6hILRhKkDgHrDFVnvfTLlVhZgMgRWfHvaG3spzHx7rmCA2hORAEBnVL3oh3HZ/BR9vmjpZe6MQ3wpmyKECtm7Gc8LBxYnhhDPz8S30nPS8hj8pks//5cG59/dqen2CH7TnTqMsjFVm5Bd2RZF+SpCV+EAdKXQhXNGYs6Kng7LyyCDy3bYl1kgxPyd
x-ms-exchange-transport-forked: True
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 52dec04b-13c7-43b9-4a84-08d75c4e75b7
X-MS-Exchange-CrossTenant-originalarrivaltime: 29 Oct 2019 09:00:34.3458
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: HKbTnEE4J6/rl/7uIhiao/C3kOXNqqxE12Pu7E1piG2Pd8StGznXBZ4KO3G7cS6PH0caMuJPnPCQ71hDaPdBUA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6363
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iIEhlcnJpbmcgPHJv
YmhAa2VybmVsLm9yZz4NCj4gU2VudDogMjAxOcTqMTDUwjI5yNUgMDozMw0KPiBUbzogQW5kcmV3
IE11cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPjsgQmpvcm4gSGVsZ2Fhcw0KPiA8YmhlbGdh
YXNAZ29vZ2xlLmNvbT47IExvcmVuem8gUGllcmFsaXNpIDxsb3JlbnpvLnBpZXJhbGlzaUBhcm0u
Y29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9yZzsgbGludXgtYXJtLWtlcm5lbEBs
aXN0cy5pbmZyYWRlYWQub3JnOw0KPiBiY20ta2VybmVsLWZlZWRiYWNrLWxpc3RAYnJvYWRjb20u
Y29tOyBDaHJpc3RvcGggSGVsbHdpZw0KPiA8aGNoQGluZnJhZGVhZC5vcmc+OyBHdXN0YXZvIFBp
bWVudGVsDQo+IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT47IEhlaWtvIFN0dWVibmVy
IDxoZWlrb0BzbnRlY2guZGU+Ow0KPiBaLnEuIEhvdSA8emhpcWlhbmcuaG91QG54cC5jb20+OyBK
aW5nb28gSGFuIDxqaW5nb29oYW4xQGdtYWlsLmNvbT47DQo+IEthcnRoaWtleWFuIE1pdHJhbiA8
bS5rYXJ0aGlrZXlhbkBtb2JpdmVpbC5jby5pbj47IExleSBGb29uIFRhbg0KPiA8bGZ0YW5AYWx0
ZXJhLmNvbT47IExpbnVzIFdhbGxlaWogPGxpbnVzLndhbGxlaWpAbGluYXJvLm9yZz47DQo+IGxp
bnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmc7IGxpbnV4LXJlbmVzYXMtc29jQHZnZXIu
a2VybmVsLm9yZzsNCj4gbGludXgtcm9ja2NoaXBAbGlzdHMuaW5mcmFkZWFkLm9yZzsgTWF0dGhp
YXMgQnJ1Z2dlcg0KPiA8bWF0dGhpYXMuYmdnQGdtYWlsLmNvbT47IE1pY2hhbCBTaW1layA8bWlj
aGFsLnNpbWVrQHhpbGlueC5jb20+OyBSYXkNCj4gSnVpIDxyanVpQGJyb2FkY29tLmNvbT47IHJm
aUBsaXN0cy5yb2NrZXRib2FyZHMub3JnOyBSeWRlciBMZWUNCj4gPHJ5ZGVyLmxlZUBtZWRpYXRl
ay5jb20+OyBTY290dCBCcmFuZGVuIDxzYnJhbmRlbkBicm9hZGNvbS5jb20+Ow0KPiBTaGF3biBM
aW4gPHNoYXduLmxpbkByb2NrLWNoaXBzLmNvbT47IFNpbW9uIEhvcm1hbg0KPiA8aG9ybXNAdmVy
Z2UubmV0LmF1PjsgU3JpbmF0aCBNYW5uYW0NCj4gPHNyaW5hdGgubWFubmFtQGJyb2FkY29tLmNv
bT47IFRob21hcyBQZXRhenpvbmkNCj4gPHRob21hcy5wZXRhenpvbmlAYm9vdGxpbi5jb20+OyBU
b2FuIExlDQo+IDx0b2FuQG9zLmFtcGVyZWNvbXB1dGluZy5jb20+OyBUb20gSm9zZXBoIDx0am9z
ZXBoQGNhZGVuY2UuY29tPjsNCj4gV2lsbCBEZWFjb24gPHdpbGxAa2VybmVsLm9yZz4NCj4gU3Vi
amVjdDogW1BBVENIIHYzIDA5LzI1XSBQQ0k6IG1vYml2ZWlsOiBVc2UNCj4gcGNpX3BhcnNlX3Jl
cXVlc3Rfb2ZfcGNpX3JhbmdlcygpDQo+IA0KPiBDb252ZXJ0IHRoZSBNb2JpdmVpbCBob3N0IGJy
aWRnZSB0byB1c2UgdGhlIGNvbW1vbg0KPiBwY2lfcGFyc2VfcmVxdWVzdF9vZl9wY2lfcmFuZ2Vz
KCkuDQo+IA0KPiBUaGVyZSdzIG5vIG5lZWQgdG8gYXNzaWduIHRoZSByZXNvdXJjZXMgdG8gYSB0
ZW1wb3JhcnkgbGlzdCBmaXJzdC4gSnVzdCB1c2UNCj4gYnJpZGdlLT53aW5kb3dzIGRpcmVjdGx5
IGFuZCByZW1vdmUgYWxsIHRoZSB0ZW1wb3JhcnkgbGlzdCBoYW5kbGluZy4NCj4gDQo+IENjOiBL
YXJ0aGlrZXlhbiBNaXRyYW4gPG0ua2FydGhpa2V5YW5AbW9iaXZlaWwuY28uaW4+DQo+IENjOiBI
b3UgWmhpcWlhbmcgPFpoaXFpYW5nLkhvdUBueHAuY29tPg0KPiBDYzogTG9yZW56byBQaWVyYWxp
c2kgPGxvcmVuem8ucGllcmFsaXNpQGFybS5jb20+DQo+IENjOiBCam9ybiBIZWxnYWFzIDxiaGVs
Z2Fhc0Bnb29nbGUuY29tPg0KPiBSZXZpZXdlZC1ieTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11
cnJheUBhcm0uY29tPg0KPiBTaWduZWQtb2ZmLWJ5OiBSb2IgSGVycmluZyA8cm9iaEBrZXJuZWwu
b3JnPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIHwg
MjYgKysrKysrKy0tLS0tLS0tLS0tLS0tLS0tLS0NCj4gIDEgZmlsZSBjaGFuZ2VkLCA3IGluc2Vy
dGlvbnMoKyksIDE5IGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLW1vYml2ZWlsLmMNCj4gaW5kZXggYTQ1YTY0NDdiMDFkLi40ZWFiODYyNGNlNGQgMTAwNjQ0
DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+ICsrKyBi
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jDQo+IEBAIC0xNDAsNyArMTQw
LDYgQEAgc3RydWN0IG1vYml2ZWlsX21zaSB7CQkJLyogTVNJIGluZm9ybWF0aW9uDQo+ICovDQo+
IA0KPiAgc3RydWN0IG1vYml2ZWlsX3BjaWUgew0KPiAgCXN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXY7DQo+IC0Jc3RydWN0IGxpc3RfaGVhZCByZXNvdXJjZXM7DQo+ICAJdm9pZCBfX2lvbWVt
ICpjb25maWdfYXhpX3NsYXZlX2Jhc2U7CS8qIGVuZHBvaW50IGNvbmZpZyBiYXNlICovDQo+ICAJ
dm9pZCBfX2lvbWVtICpjc3JfYXhpX3NsYXZlX2Jhc2U7CS8qIHJvb3QgcG9ydCBjb25maWcgYmFz
ZSAqLw0KPiAgCXZvaWQgX19pb21lbSAqYXBiX2Nzcl9iYXNlOwkvKiBNU0kgcmVnaXN0ZXIgYmFz
ZSAqLw0KPiBAQCAtNTc1LDYgKzU3NCw3IEBAIHN0YXRpYyB2b2lkIG1vYml2ZWlsX3BjaWVfZW5h
YmxlX21zaShzdHJ1Y3QNCj4gbW9iaXZlaWxfcGNpZSAqcGNpZSkNCj4gDQo+ICBzdGF0aWMgaW50
IG1vYml2ZWlsX2hvc3RfaW5pdChzdHJ1Y3QgbW9iaXZlaWxfcGNpZSAqcGNpZSkgIHsNCj4gKwlz
dHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UgPSBwY2lfaG9zdF9icmlkZ2VfZnJvbV9wcml2
KHBjaWUpOw0KPiAgCXUzMiB2YWx1ZSwgcGFiX2N0cmwsIHR5cGU7DQo+ICAJc3RydWN0IHJlc291
cmNlX2VudHJ5ICp3aW47DQo+IA0KPiBAQCAtNjMxLDcgKzYzMSw3IEBAIHN0YXRpYyBpbnQgbW9i
aXZlaWxfaG9zdF9pbml0KHN0cnVjdCBtb2JpdmVpbF9wY2llDQo+ICpwY2llKQ0KPiAgCXByb2dy
YW1faWJfd2luZG93cyhwY2llLCBXSU5fTlVNXzAsIDAsIDAsIE1FTV9XSU5ET1dfVFlQRSwNCj4g
SUJfV0lOX1NJWkUpOw0KPiANCj4gIAkvKiBHZXQgdGhlIEkvTyBhbmQgbWVtb3J5IHJhbmdlcyBm
cm9tIERUICovDQo+IC0JcmVzb3VyY2VfbGlzdF9mb3JfZWFjaF9lbnRyeSh3aW4sICZwY2llLT5y
ZXNvdXJjZXMpIHsNCj4gKwlyZXNvdXJjZV9saXN0X2Zvcl9lYWNoX2VudHJ5KHdpbiwgJmJyaWRn
ZS0+d2luZG93cykgew0KPiAgCQlpZiAocmVzb3VyY2VfdHlwZSh3aW4tPnJlcykgPT0gSU9SRVNP
VVJDRV9NRU0pDQo+ICAJCQl0eXBlID0gTUVNX1dJTkRPV19UWVBFOw0KPiAgCQllbHNlIGlmIChy
ZXNvdXJjZV90eXBlKHdpbi0+cmVzKSA9PSBJT1JFU09VUkNFX0lPKSBAQCAtODU3LDcNCj4gKzg1
Nyw2IEBAIHN0YXRpYyBpbnQgbW9iaXZlaWxfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2
aWNlICpwZGV2KQ0KPiAgCXN0cnVjdCBwY2lfYnVzICpjaGlsZDsNCj4gIAlzdHJ1Y3QgcGNpX2hv
c3RfYnJpZGdlICpicmlkZ2U7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gJnBkZXYtPmRldjsN
Cj4gLQlyZXNvdXJjZV9zaXplX3QgaW9iYXNlOw0KPiAgCWludCByZXQ7DQo+IA0KPiAgCS8qIGFs
bG9jYXRlIHRoZSBQQ0llIHBvcnQgKi8NCj4gQEAgLTg3NSwxMSArODc0LDggQEAgc3RhdGljIGlu
dCBtb2JpdmVpbF9wY2llX3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+
ICAJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiANCj4gLQlJTklUX0xJU1RfSEVBRCgmcGNpZS0+cmVz
b3VyY2VzKTsNCj4gLQ0KPiAgCS8qIHBhcnNlIHRoZSBob3N0IGJyaWRnZSBiYXNlIGFkZHJlc3Nl
cyBmcm9tIHRoZSBkZXZpY2UgdHJlZSBmaWxlICovDQo+IC0JcmV0ID0gZGV2bV9vZl9wY2lfZ2V0
X2hvc3RfYnJpZGdlX3Jlc291cmNlcyhkZXYsIDAsIDB4ZmYsDQo+IC0JCQkJCQkgICAgJnBjaWUt
PnJlc291cmNlcywgJmlvYmFzZSk7DQo+ICsJcmV0ID0gcGNpX3BhcnNlX3JlcXVlc3Rfb2ZfcGNp
X3JhbmdlcyhkZXYsICZicmlkZ2UtPndpbmRvd3MsIE5VTEwpOw0KPiAgCWlmIChyZXQpIHsNCj4g
IAkJZGV2X2VycihkZXYsICJHZXR0aW5nIGJyaWRnZSByZXNvdXJjZXMgZmFpbGVkXG4iKTsNCj4g
IAkJcmV0dXJuIHJldDsNCj4gQEAgLTg5MiwyNCArODg4LDE5IEBAIHN0YXRpYyBpbnQgbW9iaXZl
aWxfcGNpZV9wcm9iZShzdHJ1Y3QNCj4gcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiAgCXJldCA9
IG1vYml2ZWlsX2hvc3RfaW5pdChwY2llKTsNCj4gIAlpZiAocmV0KSB7DQo+ICAJCWRldl9lcnIo
ZGV2LCAiRmFpbGVkIHRvIGluaXRpYWxpemUgaG9zdFxuIik7DQo+IC0JCWdvdG8gZXJyb3I7DQo+
ICsJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiANCj4gIAkvKiBpbml0aWFsaXplIHRoZSBJUlEgZG9t
YWlucyAqLw0KPiAgCXJldCA9IG1vYml2ZWlsX3BjaWVfaW5pdF9pcnFfZG9tYWluKHBjaWUpOw0K
PiAgCWlmIChyZXQpIHsNCj4gIAkJZGV2X2VycihkZXYsICJGYWlsZWQgY3JlYXRpbmcgSVJRIERv
bWFpblxuIik7DQo+IC0JCWdvdG8gZXJyb3I7DQo+ICsJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiAN
Cj4gIAlpcnFfc2V0X2NoYWluZWRfaGFuZGxlcl9hbmRfZGF0YShwY2llLT5pcnEsIG1vYml2ZWls
X3BjaWVfaXNyLCBwY2llKTsNCj4gDQo+IC0JcmV0ID0gZGV2bV9yZXF1ZXN0X3BjaV9idXNfcmVz
b3VyY2VzKGRldiwgJnBjaWUtPnJlc291cmNlcyk7DQo+IC0JaWYgKHJldCkNCj4gLQkJZ290byBl
cnJvcjsNCj4gLQ0KPiAgCS8qIEluaXRpYWxpemUgYnJpZGdlICovDQo+IC0JbGlzdF9zcGxpY2Vf
aW5pdCgmcGNpZS0+cmVzb3VyY2VzLCAmYnJpZGdlLT53aW5kb3dzKTsNCj4gIAlicmlkZ2UtPmRl
di5wYXJlbnQgPSBkZXY7DQo+ICAJYnJpZGdlLT5zeXNkYXRhID0gcGNpZTsNCj4gIAlicmlkZ2Ut
PmJ1c25yID0gcGNpZS0+cm9vdF9idXNfbnI7DQo+IEBAIC05MjAsMTMgKzkxMSwxMyBAQCBzdGF0
aWMgaW50IG1vYml2ZWlsX3BjaWVfcHJvYmUoc3RydWN0DQo+IHBsYXRmb3JtX2RldmljZSAqcGRl
dikNCj4gIAlyZXQgPSBtb2JpdmVpbF9icmluZ3VwX2xpbmsocGNpZSk7DQo+ICAJaWYgKHJldCkg
ew0KPiAgCQlkZXZfaW5mbyhkZXYsICJsaW5rIGJyaW5nLXVwIGZhaWxlZFxuIik7DQo+IC0JCWdv
dG8gZXJyb3I7DQo+ICsJCXJldHVybiByZXQ7DQo+ICAJfQ0KPiANCj4gIAkvKiBzZXR1cCB0aGUg
a2VybmVsIHJlc291cmNlcyBmb3IgdGhlIG5ld2x5IGFkZGVkIFBDSWUgcm9vdCBidXMgKi8NCj4g
IAlyZXQgPSBwY2lfc2Nhbl9yb290X2J1c19icmlkZ2UoYnJpZGdlKTsNCj4gIAlpZiAocmV0KQ0K
PiAtCQlnb3RvIGVycm9yOw0KPiArCQlyZXR1cm4gcmV0Ow0KPiANCj4gIAlidXMgPSBicmlkZ2Ut
PmJ1czsNCj4gDQo+IEBAIC05MzYsOSArOTI3LDYgQEAgc3RhdGljIGludCBtb2JpdmVpbF9wY2ll
X3Byb2JlKHN0cnVjdA0KPiBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ICAJcGNpX2J1c19hZGRf
ZGV2aWNlcyhidXMpOw0KPiANCj4gIAlyZXR1cm4gMDsNCj4gLWVycm9yOg0KPiAtCXBjaV9mcmVl
X3Jlc291cmNlX2xpc3QoJnBjaWUtPnJlc291cmNlcyk7DQo+IC0JcmV0dXJuIHJldDsNCj4gIH0N
Cj4gDQo+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9pZCBtb2JpdmVpbF9wY2llX29m
X21hdGNoW10gPSB7DQo+IC0tDQo+IDIuMjAuMQ0KDQpSZXZpZXdlZC1ieTogSG91IFpoaXFpYW5n
IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCg==
