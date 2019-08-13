Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8DEB8AD0D
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 05:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726537AbfHMDOE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 23:14:04 -0400
Received: from mail-eopbgr50057.outbound.protection.outlook.com ([40.107.5.57]:48518
        "EHLO EUR03-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726236AbfHMDOD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 23:14:03 -0400
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=UYHHNw/ERwlBKgVzekAq+lvsEO+XdErYxo74vcsceI8HL4FdzwJFLB0dgfQGAHoT7Y0S/3UZpwscdTZ4I2wd9pmjWyXKjwMyZ66fINpU2GILMICTMUreqSTj6o5nGCU5t7tnIrSCHFu12Q3mud7Y61RDA7RLj6BX8wVSsD9tNDyn0KcoKvJg7vWA1cI3PGryEvIMfyeW19XkDCnSlmH1e7/MQq8XSF7gcXuByISfPhacTvznxlDfWPJEMkk0ZlDiqH2thQy+TBn93nI/DeLA+++iMHIoIKmwIFZI6tRkp8/hmphhrwwj1dW7SfKcDXM0oxtaTr1BOYBXE6dEXNSfLA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfK0ZpSYRGeeg1/42168EGdVq2TCBpMjOCukbPSec7U=;
 b=Td8j5ODsXvXOtvJRMwk1fUExY7tPDRq6PnTGoVXPDtodhMImrS/gK2KPJzfwIEs8h404RXaDEhM32mpZovKB2EuULfiXWhyFIYJ9yZjVJsvEbJ+nTVSeSX/8wh/EmJNE2vIFhC7Nk17ADsmQwfsWc0xebONRqu3hTNUlUOXzID/THCqNQJyYw9hvvmfjponnjhVfE9YphJi4rQ3C5Ha922Y/R0RrQCtMeJJ6IGRjUJctark8WIA4X2zE5/UqWLjqO7k14L35XtDFHsyFLeV2LRc+j/0VHXviBL1OJEW6CzC9n7sSey0CZWRkTdWN5PEpzgTroPXg47GmpJYJUCchrg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=XfK0ZpSYRGeeg1/42168EGdVq2TCBpMjOCukbPSec7U=;
 b=oQ84aTYZP2AmvD6cPI95EHrSRKjeKpuTOQyK0V4vyTed1QchRF1yZys6Ch/zhoE4fmiYxDC+Z6e4rmssCSzvT80QnL1mqYQXen6kNf8yffsZMfdOdYL7TeXO8vuF060eEBuWyzPZp+x3mpUxC87TRjn6oLZ9TNnK0jZ77QVpInA=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6585.eurprd04.prod.outlook.com (20.179.248.139) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2157.18; Tue, 13 Aug 2019 03:13:59 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::19ec:cddf:5e07:37eb%3]) with mapi id 15.20.2157.015; Tue, 13 Aug 2019
 03:13:59 +0000
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
Subject: RE: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Thread-Topic: [PATCH 3/4] ARM: dts: ls1021a: Remove num-lanes property from
 PCIe nodes
Thread-Index: AQHVUMWMZFwmX+djskari+UjmO8phab3MD4AgAE4UHA=
Date:   Tue, 13 Aug 2019 03:13:59 +0000
Message-ID: <DB8PR04MB6747BDBA924A9014E64197F784D20@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20190812042435.25102-1-Zhiqiang.Hou@nxp.com>
 <20190812042435.25102-4-Zhiqiang.Hou@nxp.com>
 <20190812083527.GU56241@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190812083527.GU56241@e119886-lin.cambridge.arm.com>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: acad5889-4908-4b90-5c86-08d71f9c48d0
x-ms-office365-filtering-ht: Tenant
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(4618075)(2017052603328)(7193020);SRVR:DB8PR04MB6585;
x-ms-traffictypediagnostic: DB8PR04MB6585:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB658569E4529A1F89164968BB84D20@DB8PR04MB6585.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:6108;
x-forefront-prvs: 01283822F8
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(396003)(366004)(136003)(346002)(39860400002)(13464003)(189003)(199004)(6246003)(81156014)(86362001)(66066001)(7416002)(8936002)(478600001)(52536014)(26005)(446003)(76176011)(2906002)(6116002)(8676002)(6506007)(53546011)(186003)(4326008)(3846002)(476003)(81166006)(53936002)(102836004)(25786009)(486006)(7696005)(11346002)(33656002)(7736002)(99286004)(66446008)(305945005)(74316002)(64756008)(55016002)(71200400001)(66556008)(66476007)(256004)(14454004)(76116006)(54906003)(66946007)(71190400001)(6916009)(229853002)(9686003)(5660300002)(6436002)(316002);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6585;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: k4oIoevuL9UhzaFg0lQScTUfkziugb7Ior6Q3iYbfKHdFebYDBl9G6luMfBuNJIVsFR4sAR8Uq5/SDGB4fXzRCvPTUwOdFuTpftg/m8mavMCraumm4eW8bTNw1n2wp+tCsoffat9G4UFU3wSEr8P/FXo3p7sccGi8wW/T47aWgG1iWR5OeQzM1tk/tZqup5n5FTi5JBhTmCEgIICPYxmAoPuIDE9RQy/CJDTdG7nj5iwp7QTUGYJwIxCnOh2mq4GQP+bDf9iT36OYribKFPU8swF/m54Zc6OOIcx53dRiT0fKK4kMK4jjlZu9fMDyqFc5YCb+UrPcTM1LbtwVlfTyilPIrlID1HGBLR+3ycVxaQZQ2qIyQwaNl6+4h3IyZjYX64ibkI6oegYKNVNxeUY9eqx7jGnnR98LGixRSIEqls=
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: acad5889-4908-4b90-5c86-08d71f9c48d0
X-MS-Exchange-CrossTenant-originalarrivaltime: 13 Aug 2019 03:13:59.1589
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: qMPicJ/vcZPE0+biDeCW1ZUqebWJ1UNhqm42N1lfmbq1nupQRMyiU9zC23gjkeA3NrEZTuM9VDgi5Q6J2a6vKg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6585
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQpSZWdhcmRzLA0K
WmhpcWlhbmcNCg0KPiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBBbmRyZXcg
TXVycmF5IDxhbmRyZXcubXVycmF5QGFybS5jb20+DQo+IFNlbnQ6IDIwMTnE6jjUwjEyyNUgMTY6
MzUNCj4gVG86IFoucS4gSG91IDx6aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gQ2M6IGxpbnV4LXBj
aUB2Z2VyLmtlcm5lbC5vcmc7IGRldmljZXRyZWVAdmdlci5rZXJuZWwub3JnOw0KPiBsaW51eC1r
ZXJuZWxAdmdlci5rZXJuZWwub3JnOyBndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbTsNCj4g
amluZ29vaGFuMUBnbWFpbC5jb207IGJoZWxnYWFzQGdvb2dsZS5jb207IHJvYmgrZHRAa2VybmVs
Lm9yZzsNCj4gbWFyay5ydXRsYW5kQGFybS5jb207IHNoYXduZ3VvQGtlcm5lbC5vcmc7IExlbyBM
aQ0KPiA8bGVveWFuZy5saUBueHAuY29tPjsgbG9yZW56by5waWVyYWxpc2lAYXJtLmNvbTsgTS5o
LiBMaWFuDQo+IDxtaW5naHVhbi5saWFuQG54cC5jb20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0gg
My80XSBBUk06IGR0czogbHMxMDIxYTogUmVtb3ZlIG51bS1sYW5lcyBwcm9wZXJ0eQ0KPiBmcm9t
IFBDSWUgbm9kZXMNCj4gDQo+IE9uIE1vbiwgQXVnIDEyLCAyMDE5IGF0IDA0OjIyOjI3QU0gKzAw
MDAsIFoucS4gSG91IHdyb3RlOg0KPiA+IEZyb206IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91
QG54cC5jb20+DQo+ID4NCj4gPiBPbiBGU0wgTGF5ZXJzY2FwZSBTb0NzLCB0aGUgbnVtYmVyIG9m
IGxhbmVzIGFzc2lnbmVkIHRvIFBDSWUNCj4gPiBjb250cm9sbGVyIGlzIG5vdCBmaXhlZCwgaXQg
aXMgZGV0ZXJtaW5lZCBieSB0aGUgc2VsZWN0ZWQgU2VyRGVzDQo+ID4gcHJvdG9jb2wgaW4gdGhl
IFJDVyAoUmVzZXQgQ29uZmlndXJhdGlvbiBXb3JkKSwgYW5kIHRoZSBQQ0llIGxpbmsNCj4gPiB0
cmFpbmluZyBpcyBjb21wbGV0ZWQgYXV0b21hdGljYWxseSBiYXNlIG9uIHRoZSBzZWxlY3RlZCBT
ZXJEZXMNCj4gPiBwcm90b2NvbCwgYW5kIHRoZSBsaW5rIHdpZHRoIHNldC11cCBpcyB1cGRhdGVk
IGJ5IGhhcmR3YXJlLiBTbyB0aGUNCj4gPiBudW0tbGFuZXMgaXMgbm90IG5lZWRlZCB0byBzcGVj
aWZ5IHRoZSBsaW5rIHdpZHRoLg0KPiA+DQo+ID4gVGhlIGN1cnJlbnQgbnVtLWxhbmVzIGluZGlj
YXRlcyB0aGUgbWF4IGxhbmVzIFBDSWUgY29udHJvbGxlciBjYW4NCj4gPiBzdXBwb3J0IHVwIHRv
LCBpbnN0ZWFkIG9mIHRoZSBsYW5lcyBhc3NpZ25lZCB0byB0aGUgUENJZSBjb250cm9sbGVyLg0K
PiA+IFRoaXMgY2FuIHJlc3VsdCBpbiBQQ0llIGxpbmsgdHJhaW5pbmcgZmFpbCBhZnRlciBob3Qt
cmVzZXQuIFNvIHJlbW92ZQ0KPiA+IHRoZSBudW0tbGFuZXMgdG8gYXZvaWQgc2V0LXVwIHRvIGlu
Y29ycmVjdCBsaW5rIHdpZHRoLg0KPiA+DQo+ID4gU2lnbmVkLW9mZi1ieTogSG91IFpoaXFpYW5n
IDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4gPiAgYXJjaC9hcm0vYm9vdC9kdHMv
bHMxMDIxYS5kdHNpIHwgMiAtLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMiBkZWxldGlvbnMoLSkN
Cj4gPg0KPiA+IGRpZmYgLS1naXQgYS9hcmNoL2FybS9ib290L2R0cy9sczEwMjFhLmR0c2kNCj4g
PiBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEuZHRzaSBpbmRleCA0NjRkZjQyOTBmZmMuLjJm
Njk3N2FkYTQ0Nw0KPiA+IDEwMDY0NA0KPiA+IC0tLSBhL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAy
MWEuZHRzaQ0KPiA+ICsrKyBiL2FyY2gvYXJtL2Jvb3QvZHRzL2xzMTAyMWEuZHRzaQ0KPiA+IEBA
IC04NzQsNyArODc0LDYgQEANCj4gPiAgCQkJI2FkZHJlc3MtY2VsbHMgPSA8Mz47DQo+ID4gIAkJ
CSNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICAJCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+IC0J
CQludW0tbGFuZXMgPSA8ND47DQo+ID4gIAkJCW51bS12aWV3cG9ydCA9IDw2PjsNCj4gPiAgCQkJ
YnVzLXJhbmdlID0gPDB4MCAweGZmPjsNCj4gPiAgCQkJcmFuZ2VzID0gPDB4ODEwMDAwMDAgMHgw
IDB4MDAwMDAwMDAgMHg0MCAweDAwMDEwMDAwIDB4MA0KPiAweDAwMDEwMDAwICAgLyogZG93bnN0
cmVhbSBJL08gKi8NCj4gPiBAQCAtODk5LDcgKzg5OCw2IEBADQo+ID4gIAkJCSNhZGRyZXNzLWNl
bGxzID0gPDM+Ow0KPiA+ICAJCQkjc2l6ZS1jZWxscyA9IDwyPjsNCj4gPiAgCQkJZGV2aWNlX3R5
cGUgPSAicGNpIjsNCj4gPiAtCQkJbnVtLWxhbmVzID0gPDQ+Ow0KPiA+ICAJCQludW0tdmlld3Bv
cnQgPSA8Nj47DQo+ID4gIAkJCWJ1cy1yYW5nZSA9IDwweDAgMHhmZj47DQo+ID4gIAkJCXJhbmdl
cyA9IDwweDgxMDAwMDAwIDB4MCAweDAwMDAwMDAwIDB4NDggMHgwMDAxMDAwMCAweDANCj4gMHgw
MDAxMDAwMCAgIC8qIGRvd25zdHJlYW0gSS9PICovDQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV3
IE11cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPg0KPiANCj4gPiAtLQ0KPiA+IDIuMTcuMQ0K
PiA+DQo=
