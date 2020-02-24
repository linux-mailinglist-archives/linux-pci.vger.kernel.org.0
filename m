Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BA721169DE1
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2020 06:48:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725809AbgBXFsW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 24 Feb 2020 00:48:22 -0500
Received: from mail-eopbgr00040.outbound.protection.outlook.com ([40.107.0.40]:26734
        "EHLO EUR02-AM5-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725535AbgBXFsW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 24 Feb 2020 00:48:22 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DowBEgTDsq2a8/yg6VJW1vG/kDPMyd1wwgOjpO9kG2q6mwYiZOoZ/3VT27B4Tw0xC2hQczu1WnNGxBTfHWc5RKelpMlQbvMlO7g55hKUT+RLtaIYizrNBTn1Dy78vLbfIQfPkI3OYh4XCB/uYSvjflb1itqQXH+QI5MW68YBTRL2dpJjArY3pK4fwtKQLAA4BNYK39SPO800th2DAkm9CYatyB4SBUxvtLjCJMl2GhhQPEFvHHE0FoavHtpc6hjj0M8LhjCYKOKoNQ+Cj9trrIJKQVHBYM5GrpzYcMirOWzY5blQ8zcKJYeBd6M4E9TZtOHnfbDjuuh+ucZuh5Wmcw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF5IvoMW37y1paGdqZKB/NbHIQLMgR4YAw7kzgIwR8s=;
 b=oFLZTz5EokUXTnbeYk8lDiim/igOMeWlY4WXm2+nQ4v3ReweU/K9u96bZH+iXrM4MPmEVyB8mITZ/ZlnIswZDiBvkRMqOLenoP/5aC0YObhxO+ZRxBpasfAnsz2QOiHM0b9Qiz4zW9ZqsG7tiOrffjAE367NNfVAJjnX7d+To/SLJHCPp7SRedDKmPRueUdUAF/A+OT0bB4O2IdPuhTUUs31OKs6rJgnm5NmzYTS4muQa9oe/cKwutZqnSHP0vJCTN7Fjat7I028ZHoAyc8CWnUA6D3RmC1gUDEuhJtBR0cup7ixgSNxPWmmcwf9OY16t2xzsNhJ2XBZy9jqGKeYeg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DF5IvoMW37y1paGdqZKB/NbHIQLMgR4YAw7kzgIwR8s=;
 b=FEnlHzX2GCDGOCphlkQgK/y+7TZL8oaisLeLp0UkhsE1qabF1oYLRICBNMFB3TbdneHyYXFu+mIgwfQu6b2vsEr7TG9c6PRDluB1LZepowKFQX0ZvzVwRKnDVWHPKcZ/wQpv/MkVGXavKfDpGgt5KYeqIrA5A3A0CsCiBjb23sk=
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com (20.179.250.159) by
 DB8PR04MB6539.eurprd04.prod.outlook.com (20.179.249.18) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2750.22; Mon, 24 Feb 2020 05:48:18 +0000
Received: from DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa]) by DB8PR04MB6747.eurprd04.prod.outlook.com
 ([fe80::104b:e88b:b0d3:cdaa%4]) with mapi id 15.20.2750.021; Mon, 24 Feb 2020
 05:48:18 +0000
From:   "Z.q. Hou" <zhiqiang.hou@nxp.com>
To:     Andrew Murray <amurray@thegoodpenguin.co.uk>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
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
Subject: RE: [PATCHv10 02/13] PCI: mobiveil: Move the host initialization into
 a function
Thread-Topic: [PATCHv10 02/13] PCI: mobiveil: Move the host initialization
 into a function
Thread-Index: AQHV4iNxBRBtqBpne0O4q1Ka1OVSgqgkX24AgAWHfIA=
Date:   Mon, 24 Feb 2020 05:48:18 +0000
Message-ID: <DB8PR04MB6747EA1C744B582F17BA777884EC0@DB8PR04MB6747.eurprd04.prod.outlook.com>
References: <20200213040644.45858-1-Zhiqiang.Hou@nxp.com>
 <20200213040644.45858-3-Zhiqiang.Hou@nxp.com>
 <20200220171906.GE19388@big-machine>
In-Reply-To: <20200220171906.GE19388@big-machine>
Accept-Language: zh-CN, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=zhiqiang.hou@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: ebb54685-de75-45fb-acc7-08d7b8ed263f
x-ms-traffictypediagnostic: DB8PR04MB6539:|DB8PR04MB6539:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <DB8PR04MB6539E12423C62EFE2D30CF9A84EC0@DB8PR04MB6539.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 032334F434
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(376002)(39860400002)(136003)(346002)(366004)(396003)(199004)(189003)(6916009)(55016002)(9686003)(33656002)(2906002)(186003)(26005)(478600001)(8676002)(8936002)(53546011)(7416002)(4326008)(86362001)(66946007)(7696005)(81156014)(81166006)(76116006)(71200400001)(66556008)(66446008)(5660300002)(316002)(52536014)(54906003)(66476007)(64756008)(6506007);DIR:OUT;SFP:1101;SCL:1;SRVR:DB8PR04MB6539;H:DB8PR04MB6747.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: YYicvfKG4W4O72Vm2NbyqCf7wcLh/lK/hXDQE2NUHbGdyo/Gz+Y5dPcq7/YvIc4ELELwK6r0AmD7BDes7CBS+OB/KlEiqDB9AcN5lYyrnovp6KUcoGKvStUc/mU9WZWlVvpyZGQp4RRS5aX8TvTgkCUPAw2ZAwLHB2lPki2wIY+lYuQcSDKwb9HGYsXA8j5ZPg3kjiK+CvRJawe497hmr3AKgxYRADf6wzxYJdNE5CRevvXpy2tsHBV6z7OMePRP9oL/EToednEDbsd+kstCVgcBUhB58vF+/JnRdjRgednX33QMk1DIqzj8HmHuB4WUwDqhdOcNaMcnBKMHTe7KK+5KnMEgPqAyiCXUYVuSrC794F/GBa/RaxIVt59PFdz7ixxlItuQd7Axob+cIhrKO6JRWCJY7sDAogQkTisckEo+8Z5ROBdVSVvp5blW/OgS
x-ms-exchange-antispam-messagedata: dV5cCrx/uQhTjLVr2GHwl1gtLsO1FFsQnccFNGfPsheh6VpHN+byOUhgGtMvFj8EqPz+OASRAZVGQ8Rm/+KgztTcZ9yanHD22JLkx48EWt703SSWTWzx01NxJMKQQvYTGL1lLzEIsACMQQ2AjAmziA==
Content-Type: text/plain; charset="gb2312"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb54685-de75-45fb-acc7-08d7b8ed263f
X-MS-Exchange-CrossTenant-originalarrivaltime: 24 Feb 2020 05:48:18.3472
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: oL+9tLkyYKlvn5d5SztAJHLSWMjxP9Aalfw7UUeJmw5UAWrYxnm0lSbwI88qBBkaNdsvmIBjCCBMD+0go/UpLw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DB8PR04MB6539
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQW5kcmV3LA0KDQpUaGFua3MgYSBsb3QgZm9yIHlvdXIgcmV2aWV3IQ0KDQo+IC0tLS0tT3Jp
Z2luYWwgTWVzc2FnZS0tLS0tDQo+IEZyb206IEFuZHJldyBNdXJyYXkgPGFtdXJyYXlAdGhlZ29v
ZHBlbmd1aW4uY28udWs+DQo+IFNlbnQ6IDIwMjDE6jLUwjIxyNUgMToxOQ0KPiBUbzogWi5xLiBI
b3UgPHpoaXFpYW5nLmhvdUBueHAuY29tPg0KPiBDYzogbGludXgtcGNpQHZnZXIua2VybmVsLm9y
ZzsgbGludXgtYXJtLWtlcm5lbEBsaXN0cy5pbmZyYWRlYWQub3JnOw0KPiBkZXZpY2V0cmVlQHZn
ZXIua2VybmVsLm9yZzsgbGludXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gYmhlbGdhYXNA
Z29vZ2xlLmNvbTsgcm9iaCtkdEBrZXJuZWwub3JnOyBhbmRyZXcubXVycmF5QGFybS5jb207DQo+
IGFybmRAYXJuZGIuZGU7IG1hcmsucnV0bGFuZEBhcm0uY29tOyBsLnN1YnJhaG1hbnlhQG1vYml2
ZWlsLmNvLmluOw0KPiBzaGF3bmd1b0BrZXJuZWwub3JnOyBtLmthcnRoaWtleWFuQG1vYml2ZWls
LmNvLmluOyBMZW8gTGkNCj4gPGxlb3lhbmcubGlAbnhwLmNvbT47IGxvcmVuem8ucGllcmFsaXNp
QGFybS5jb207DQo+IGNhdGFsaW4ubWFyaW5hc0Bhcm0uY29tOyB3aWxsLmRlYWNvbkBhcm0uY29t
OyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1QG54cC5jb20+OyBNLmguIExpYW4gPG1pbmdodWFu
LmxpYW5AbnhwLmNvbT47IFhpYW93ZWkgQmFvDQo+IDx4aWFvd2VpLmJhb0BueHAuY29tPg0KPiBT
dWJqZWN0OiBSZTogW1BBVENIdjEwIDAyLzEzXSBQQ0k6IG1vYml2ZWlsOiBNb3ZlIHRoZSBob3N0
IGluaXRpYWxpemF0aW9uDQo+IGludG8gYSBmdW5jdGlvbg0KPiANCj4gT24gVGh1LCBGZWIgMTMs
IDIwMjAgYXQgMTI6MDY6MzNQTSArMDgwMCwgWmhpcWlhbmcgSG91IHdyb3RlOg0KPiA+IEZyb206
IEhvdSBaaGlxaWFuZyA8WmhpcWlhbmcuSG91QG54cC5jb20+DQo+ID4NCj4gPiBNb3ZlIHRoZSBo
b3N0IGluaXRpYWxpemF0aW9uIHJlbGF0ZWQgb3BlcmF0aW9ucyBpbnRvIGEgbmV3IHJvdXRpbmUN
Cj4gPiBzdWNoIHRoYXQgaXQgY2FuIGJlIHJldXNlZCBieSBvdGhlciBpbmNvbWluZyBwbGF0Zm9y
bSdzIFBDSWUgaG9zdA0KPiA+IGRyaXZlciwgaW4gd2hpY2ggdGhlIE1vYml2ZWlsIEdQRVggaXMg
aW50ZWdyYXRlZC4NCj4gPg0KPiA+IENoYW5nZSB0aGUgc3ViamVjdCBhbmQgY2hhbmdlIGxvZyBz
bGlnaHRseS4NCj4gPiBDaGFuZ2UgdGhlIGZ1bmN0aW9uIG1vYml2ZWlsX3BjaWVfaG9zdF9wcm9i
ZSB0byBzdGF0aWMuDQo+ID4gQWRkIGJhY2sgdGhlIGNvbW1lbnRzIHRoYXQgd2FzIGxvc3QgaW4g
djkuDQo+IA0KPiBBcmUgdGhlc2UgdGhyZWUgbGluZXMgYWJvdmUgc3VwcG9zZWQgdG8gYmUgaW4g
dGhlIGhpc3RvcnkgYmVsb3cgdGhlDQo+IC0tLSA/DQoNCkp1c3QgcmVtb3ZlIHRoZXNlIDMgbGlu
ZXMuDQoNClRoYW5rcywNClpoaXFpYW5nDQoNCj4gDQo+IFBlcmhhcHMgTG9yZW56byBjYW4gY2hh
bmdlIHRoYXQgd2hlbiBoZSBhcHBsaWVzIGl0Lg0KPiANCj4gUmV2aWV3ZWQtYnk6IEFuZHJldyBN
dXJyYXkgPGFtdXJyYXlAdGhlZ29vZHBlbmd1aW4uY28udWs+DQo+IA0KPiA+DQo+ID4gU2lnbmVk
LW9mZi1ieTogSG91IFpoaXFpYW5nIDxaaGlxaWFuZy5Ib3VAbnhwLmNvbT4NCj4gPiAtLS0NCj4g
PiBWMTA6DQo+ID4gIC0gUmVmaW5lZCB0aGUgc3ViamVjdCBhbmQgY2hhbmdlIGxvZy4NCj4gPiAg
LSBDaGFuZ2VkIHRoZSBtb2JpdmVpbF9wY2llX2hvc3RfcHJvYmUoKSB0byBhIHN0YXRpYyBmdW5j
dGlvbi4NCj4gPiAgLSBBZGRlZCBiYWNrIHRoZSBsb3N0IGNvbW1lbnRzLg0KPiA+DQo+ID4gIGRy
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tb2JpdmVpbC5jIHwgMzkNCj4gPiArKysrKysrKysr
KysrKystLS0tLS0tLS0tLQ0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjMgaW5zZXJ0aW9ucygrKSwg
MTYgZGVsZXRpb25zKC0pDQo+ID4NCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1t
b2JpdmVpbC5jDQo+ID4gaW5kZXggZDRkZTU2MGNkNzExLi4wMWRmMDRlYTViNDggMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1vYml2ZWlsLmMNCj4gPiArKysg
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbW9iaXZlaWwuYw0KPiA+IEBAIC04NzMsMjcg
Kzg3MywxNSBAQCBzdGF0aWMgaW50IG1vYml2ZWlsX3BjaWVfaW5pdF9pcnFfZG9tYWluKHN0cnVj
dA0KPiBtb2JpdmVpbF9wY2llICpwY2llKQ0KPiA+ICAJcmV0dXJuIDA7DQo+ID4gIH0NCj4gPg0K
PiA+IC1zdGF0aWMgaW50IG1vYml2ZWlsX3BjaWVfcHJvYmUoc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldikNCj4gPiArc3RhdGljIGludCBtb2JpdmVpbF9wY2llX2hvc3RfcHJvYmUoc3RydWN0
IG1vYml2ZWlsX3BjaWUgKnBjaWUpDQo+ID4gIHsNCj4gPiAtCXN0cnVjdCBtb2JpdmVpbF9wY2ll
ICpwY2llOw0KPiA+ICsJc3RydWN0IG1vYml2ZWlsX3Jvb3RfcG9ydCAqcnAgPSAmcGNpZS0+cnA7
DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2UgPSBycC0+YnJpZGdlOw0KPiA+
ICsJc3RydWN0IGRldmljZSAqZGV2ID0gJnBjaWUtPnBkZXYtPmRldjsNCj4gPiAgCXN0cnVjdCBw
Y2lfYnVzICpidXM7DQo+ID4gIAlzdHJ1Y3QgcGNpX2J1cyAqY2hpbGQ7DQo+ID4gLQlzdHJ1Y3Qg
cGNpX2hvc3RfYnJpZGdlICpicmlkZ2U7DQo+ID4gLQlzdHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRl
di0+ZGV2Ow0KPiA+IC0Jc3RydWN0IG1vYml2ZWlsX3Jvb3RfcG9ydCAqcnA7DQo+ID4gIAlpbnQg
cmV0Ow0KPiA+DQo+ID4gLQkvKiBhbGxvY2F0ZSB0aGUgUENJZSBwb3J0ICovDQo+ID4gLQlicmlk
Z2UgPSBkZXZtX3BjaV9hbGxvY19ob3N0X2JyaWRnZShkZXYsIHNpemVvZigqcGNpZSkpOw0KPiA+
IC0JaWYgKCFicmlkZ2UpDQo+ID4gLQkJcmV0dXJuIC1FTk9NRU07DQo+ID4gLQ0KPiA+IC0JcGNp
ZSA9IHBjaV9ob3N0X2JyaWRnZV9wcml2KGJyaWRnZSk7DQo+ID4gLQlycCA9ICZwY2llLT5ycDsN
Cj4gPiAtCXJwLT5icmlkZ2UgPSBicmlkZ2U7DQo+ID4gLQ0KPiA+IC0JcGNpZS0+cGRldiA9IHBk
ZXY7DQo+ID4gLQ0KPiA+ICAJcmV0ID0gbW9iaXZlaWxfcGNpZV9wYXJzZV9kdChwY2llKTsNCj4g
PiAgCWlmIChyZXQpIHsNCj4gPiAgCQlkZXZfZXJyKGRldiwgIlBhcnNpbmcgRFQgZmFpbGVkLCBy
ZXQ6ICV4XG4iLCByZXQpOyBAQCAtOTU2LDYNCj4gPiArOTQ0LDI1IEBAIHN0YXRpYyBpbnQgbW9i
aXZlaWxfcGNpZV9wcm9iZShzdHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2KQ0KPiA+ICAJcmV0
dXJuIDA7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgaW50IG1vYml2ZWlsX3BjaWVfcHJvYmUo
c3RydWN0IHBsYXRmb3JtX2RldmljZSAqcGRldikgew0KPiA+ICsJc3RydWN0IG1vYml2ZWlsX3Bj
aWUgKnBjaWU7DQo+ID4gKwlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2U7DQo+ID4gKwlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSAmcGRldi0+ZGV2Ow0KPiA+ICsNCj4gPiArCS8qIGFsbG9jYXRl
IHRoZSBQQ0llIHBvcnQgKi8NCj4gPiArCWJyaWRnZSA9IGRldm1fcGNpX2FsbG9jX2hvc3RfYnJp
ZGdlKGRldiwgc2l6ZW9mKCpwY2llKSk7DQo+ID4gKwlpZiAoIWJyaWRnZSkNCj4gPiArCQlyZXR1
cm4gLUVOT01FTTsNCj4gPiArDQo+ID4gKwlwY2llID0gcGNpX2hvc3RfYnJpZGdlX3ByaXYoYnJp
ZGdlKTsNCj4gPiArCXBjaWUtPnJwLmJyaWRnZSA9IGJyaWRnZTsNCj4gPiArDQo+ID4gKwlwY2ll
LT5wZGV2ID0gcGRldjsNCj4gPiArDQo+ID4gKwlyZXR1cm4gbW9iaXZlaWxfcGNpZV9ob3N0X3By
b2JlKHBjaWUpOyB9DQo+ID4gKw0KPiA+ICBzdGF0aWMgY29uc3Qgc3RydWN0IG9mX2RldmljZV9p
ZCBtb2JpdmVpbF9wY2llX29mX21hdGNoW10gPSB7DQo+ID4gIAl7LmNvbXBhdGlibGUgPSAibWJ2
bCxncGV4NDAtcGNpZSIsfSwNCj4gPiAgCXt9LA0KPiA+IC0tDQo+ID4gMi4xNy4xDQo+ID4NCg==
