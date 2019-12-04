Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id BB57811221D
	for <lists+linux-pci@lfdr.de>; Wed,  4 Dec 2019 05:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbfLDEen (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Dec 2019 23:34:43 -0500
Received: from mail-eopbgr130053.outbound.protection.outlook.com ([40.107.13.53]:16871
        "EHLO EUR01-HE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726856AbfLDEem (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 3 Dec 2019 23:34:42 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=IY7Kq/HuUqMwhYDsJcsonuGfvjyrRbbCdHXi09S7JYXBD7SVK7Hrg5Qd7JdrxIZ+ORwCeo19WO/rJqs+RkxZ8b+6hmzuiyxxjI0C34ct2ydsyYQqcE/BMcNdAP9yJa5RDlIdzTTpekyl9yR55ryq0tML1R5AKo9EP7knghv2Q+l3e2tz7V9WZ5u0msJPta2FVnt+lxJzFJjGPlHL9c4riQKdBaQXzI8JVD00Sx+ujbbO4PmmWYKmuaySzQR5QOPqEwe4psfPs3C197LIz1kAOQDVLCiEXWn7BXbKbZgJ3PvqzCf/64R/VEdvIdKb8dm8+DXrJkRMjRnCBr5yJabpNg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDDxceR3uRvOzGYFEYr79tOoXGobJFa7RaZ+4G2YSSg=;
 b=ag7/J/gYsq9BvCzvDYwvtBDQZqFJUNmITsnCVK7I7RCY+yI08hJ7JXtmWWNe9XrAUyJMA4XrX5+A0HpfiaLBH5pbtYe3JtRovHDt5DsmbmiyJR/KYrUOuIjpIUCkyhrZY9C16+0vufFVig6qFK5I0bdI2l+5+Q7im0cxl5nhSwP1v6mdZy1ySfO5+Pq+RgC/b9GHabdSIz1M2bCqZzIwZW75ndwh3XikWuTEq7rX22+IWXnG7Zbvq9ELx3sX3u/xFzucEsV8loDeekuzQTEsIUt12wpY+SiZWpl5LA/xY/30XtsJwQz2nl00ucjYNaBNAwAqwp2sAk+UyJPkJUyDQQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nxp.com; dmarc=pass action=none header.from=nxp.com; dkim=pass
 header.d=nxp.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nxp.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=jDDxceR3uRvOzGYFEYr79tOoXGobJFa7RaZ+4G2YSSg=;
 b=IPfmYZoOtBMvbNnTraDZcqUnHN7ooigy1MMa5alBMuY5FfzUUZSuAt3dp6KlOLTQoBAjhLJu7pfWz518+eeFC8R0SOKfCtHyK1VGv/ovMAOG4Rhq2xqfPjKZjDGImBQH13NUuNP+8PvdMqWhYpFG9yA8+MDMJCKYjEFkAaN9q8U=
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com (10.173.255.158) by
 AM5PR04MB2962.eurprd04.prod.outlook.com (10.167.170.17) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2495.22; Wed, 4 Dec 2019 04:34:32 +0000
Received: from AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::a8a6:8d0d:aca4:7bf1]) by AM5PR04MB3299.eurprd04.prod.outlook.com
 ([fe80::a8a6:8d0d:aca4:7bf1%7]) with mapi id 15.20.2495.014; Wed, 4 Dec 2019
 04:34:32 +0000
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Robin Murphy <robin.murphy@arm.com>, Marc Zyngier <maz@kernel.org>
CC:     Roy Zang <roy.zang@nxp.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Z.q. Hou" <zhiqiang.hou@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "M.h. Lian" <minghuan.lian@nxp.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "frowand.list@gmail.com" <frowand.list@gmail.com>,
        Mingkai Hu <mingkai.hu@nxp.com>
Subject: RE: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Topic: [PATCH] PCI: layerscape: Add the SRIOV support in host side
Thread-Index: AQHVqP2nw3AoM5GAtUqPe+h1Ib8VVaemy2EAgADUbVCAAK4bgIAAOn2AgADDy0A=
Date:   Wed, 4 Dec 2019 04:34:32 +0000
Message-ID: <AM5PR04MB3299BFC34A4666B7A9C12B13F55D0@AM5PR04MB3299.eurprd04.prod.outlook.com>
References: <20191202104506.27916-1-xiaowei.bao@nxp.com>
 <606a00a2edcf077aa868319e0daa4dbc@www.loen.fr>
 <AM5PR04MB3299A5A504DEFEF3E137A27CF5420@AM5PR04MB3299.eurprd04.prod.outlook.com>
 <3dcdf44eb76390730658e3f4d932620c@www.loen.fr>
 <8f56c2d9-ab01-a91e-902f-a61def0e8ce8@arm.com>
In-Reply-To: <8f56c2d9-ab01-a91e-902f-a61def0e8ce8@arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=xiaowei.bao@nxp.com; 
x-originating-ip: [119.31.174.73]
x-ms-publictraffictype: Email
x-ms-office365-filtering-ht: Tenant
x-ms-office365-filtering-correlation-id: 06e807cf-2547-4f6b-0f07-08d778734263
x-ms-traffictypediagnostic: AM5PR04MB2962:|AM5PR04MB2962:
x-ms-exchange-transport-forked: True
x-microsoft-antispam-prvs: <AM5PR04MB296233C559F9BCDDFC21E507F55D0@AM5PR04MB2962.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:8882;
x-forefront-prvs: 0241D5F98C
x-forefront-antispam-report: SFV:NSPM;SFS:(10009020)(4636009)(346002)(396003)(39860400002)(366004)(376002)(136003)(189003)(199004)(13464003)(102836004)(26005)(81156014)(81166006)(7696005)(76176011)(6506007)(52536014)(44832011)(53546011)(71190400001)(71200400001)(3846002)(11346002)(446003)(66476007)(76116006)(5660300002)(256004)(229853002)(25786009)(7416002)(64756008)(66446008)(66946007)(186003)(478600001)(66556008)(6116002)(54906003)(305945005)(110136005)(7736002)(99286004)(74316002)(4326008)(6436002)(33656002)(14454004)(316002)(9686003)(6246003)(55016002)(8676002)(8936002)(2906002)(86362001)(14444005);DIR:OUT;SFP:1101;SCL:1;SRVR:AM5PR04MB2962;H:AM5PR04MB3299.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;MX:1;A:1;
received-spf: None (protection.outlook.com: nxp.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam: BCL:0;
x-microsoft-antispam-message-info: wyPbGT6JER8o1dLsljRCwJQlAqd389IoRhyINsHSVGy1Y/nsfI7qB+am2T/lqutkYawT8QKa9XWYpK8Ll8PsZvSWRvzSrVmC2CxCQf5RLhThBtsCcn0Jlp++m87RvUx82t1PLKTAylaYfILwASnZkYMf9lfPri155YHWqpS+IR27MKZq1PGnT2V4abhSSWzZasg63UcJGaVFL6u5KPrjcBeKXgvmxkr1d0Zls3qg45YZNTNrJsc95mmxVFjcUQ9uBT1k9WjI3xj8JGpjLyK6IbfKdMn70Hz136Xk34t1wQRO0Uddt3AFtO1DwNiPqc6hIvSJRcn9vSKkqnf/fTllqEiYx9X5Ed9i8S8MvWkRuJ/x6jjdxeHQ0/NhSpsKyvFYGkCMg2tZrSSsRS+R55lVUEzTJO0DI5TzQPm7szaOK7WpMFXgzt2d4ei4QyR6LJj0JXpk455N00HEnuL8JBAiohP1SGveJu5aGLN5i/unNE9UsUFPYrQhmurmPmGJUCvh
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: nxp.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 06e807cf-2547-4f6b-0f07-08d778734263
X-MS-Exchange-CrossTenant-originalarrivaltime: 04 Dec 2019 04:34:32.4975
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: 686ea1d3-bc2b-4c6f-a92c-d99c5c301635
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: g5jKYx8HkUNFNWlk4gaw6/JM2hgLm9n/xoDGz6z9Gqq7Sb0ECCw6PB6u1rDMBO9IRaAtdd0kYLFpIoRjpj9z8Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: AM5PR04MB2962
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

DQoNCj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gRnJvbTogUm9iaW4gTXVycGh5IDxy
b2Jpbi5tdXJwaHlAYXJtLmNvbT4NCj4gU2VudDogMjAxOeW5tDEy5pyIM+aXpSAyMzoyMA0KPiBU
bzogTWFyYyBaeW5naWVyIDxtYXpAa2VybmVsLm9yZz47IFhpYW93ZWkgQmFvIDx4aWFvd2VpLmJh
b0BueHAuY29tPg0KPiBDYzogUm95IFphbmcgPHJveS56YW5nQG54cC5jb20+OyBsb3JlbnpvLnBp
ZXJhbGlzaUBhcm0uY29tOw0KPiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgtcGNp
QHZnZXIua2VybmVsLm9yZzsgWi5xLiBIb3UNCj4gPHpoaXFpYW5nLmhvdUBueHAuY29tPjsgbGlu
dXgta2VybmVsQHZnZXIua2VybmVsLm9yZzsgTS5oLiBMaWFuDQo+IDxtaW5naHVhbi5saWFuQG54
cC5jb20+OyByb2JoK2R0QGtlcm5lbC5vcmc7DQo+IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5m
cmFkZWFkLm9yZzsgYmhlbGdhYXNAZ29vZ2xlLmNvbTsNCj4gYW5kcmV3Lm11cnJheUBhcm0uY29t
OyBmcm93YW5kLmxpc3RAZ21haWwuY29tOyBNaW5na2FpIEh1DQo+IDxtaW5na2FpLmh1QG54cC5j
b20+DQo+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogbGF5ZXJzY2FwZTogQWRkIHRoZSBTUklP
ViBzdXBwb3J0IGluIGhvc3Qgc2lkZQ0KPiANCj4gT24gMDMvMTIvMjAxOSAxMTo1MSBhbSwgTWFy
YyBaeW5naWVyIHdyb3RlOg0KPiA+IE9uIDIwMTktMTItMDMgMDE6NDIsIFhpYW93ZWkgQmFvIHdy
b3RlOg0KPiA+Pj4gLS0tLS1PcmlnaW5hbCBNZXNzYWdlLS0tLS0NCj4gPj4+IEZyb206IE1hcmMg
WnluZ2llciA8bWF6QG1pc3RlcmpvbmVzLm9yZz4NCj4gPj4+IFNlbnQ6IDIwMTnlubQxMuaciDLm
l6UgMjA6NDgNCj4gPj4+IFRvOiBYaWFvd2VpIEJhbyA8eGlhb3dlaS5iYW9AbnhwLmNvbT4NCj4g
Pj4+IENjOiByb2JoK2R0QGtlcm5lbC5vcmc7IGZyb3dhbmQubGlzdEBnbWFpbC5jb207IE0uaC4g
TGlhbg0KPiA+Pj4gPG1pbmdodWFuLmxpYW5AbnhwLmNvbT47IE1pbmdrYWkgSHUgPG1pbmdrYWku
aHVAbnhwLmNvbT47IFJveQ0KPiBaYW5nDQo+ID4+PiA8cm95LnphbmdAbnhwLmNvbT47IGxvcmVu
em8ucGllcmFsaXNpQGFybS5jb207DQo+ID4+PiBhbmRyZXcubXVycmF5QGFybS5jb207IGJoZWxn
YWFzQGdvb2dsZS5jb207DQo+ID4+PiBkZXZpY2V0cmVlQHZnZXIua2VybmVsLm9yZzsgbGludXgt
a2VybmVsQHZnZXIua2VybmVsLm9yZzsNCj4gPj4+IGxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmc7
IGxpbnV4LWFybS1rZXJuZWxAbGlzdHMuaW5mcmFkZWFkLm9yZzsNCj4gPj4+IFoucS4gSG91IDx6
aGlxaWFuZy5ob3VAbnhwLmNvbT4NCj4gPj4+IFN1YmplY3Q6IFJlOiBbUEFUQ0hdIFBDSTogbGF5
ZXJzY2FwZTogQWRkIHRoZSBTUklPViBzdXBwb3J0IGluIGhvc3QNCj4gPj4+IHNpZGUNCj4gPj4+
DQo+ID4+PiBPbiAyMDE5LTEyLTAyIDEwOjQ1LCBYaWFvd2VpIEJhbyB3cm90ZToNCj4gPj4+ID4g
R0lDIGdldCB0aGUgbWFwIHJlbGF0aW9ucyBvZiBkZXZpZCBhbmQgc3RyZWFtIGlkIGZyb20gdGhl
IG1zaS1tYXANCj4gPj4+ID4gcHJvcGVydHkgb2YgRFRTLCBvdXIgcGxhdGZvcm0gYWRkIHRoaXMg
cHJvcGVydHkgaW4gdS1ib290IGJhc2Ugb24NCj4gPj4+ID4gdGhlIFBDSWUgZGV2aWNlIGluIHRo
ZSBidXMsIGJ1dCBpZiBlbmFibGUgdGhlIHZmIGRldmljZSBpbiBrZXJuZWwsDQo+ID4+PiA+IHRo
ZSB2ZiBkZXZpY2UgbXNpLW1hcCB3aWxsIG5vdCBzZXQsIHNvIHRoZSB2ZiBkZXZpY2UgY2FuJ3Qg
d29yaywNCj4gPj4+ID4gdGhpcyBwYXRjaCBwdXJwb3NlIGlzIHRoYXQgbWFuYWdlIHRoZSBzdHJl
YW0gaWQgYW5kIGRldmljZSBpZCBtYXANCj4gPj4+ID4gcmVsYXRpb25zIGR5bmFtaWNhbGx5IGlu
IGtlcm5lbCwgYW5kIG1ha2UgdGhlIG5ldyBQQ0llIGRldmljZSB3b3JrIGluDQo+IGtlcm5lbC4N
Cj4gPj4+ID4NCj4gPj4+ID4gU2lnbmVkLW9mZi1ieTogWGlhb3dlaSBCYW8gPHhpYW93ZWkuYmFv
QG54cC5jb20+DQo+ID4+PiA+IC0tLQ0KPiA+Pj4gPsKgIGRyaXZlcnMvb2YvaXJxLmPCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqAgfMKgIDkgKysr
DQo+ID4+PiA+wqAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpLWxheWVyc2NhcGUuYyB8
IDk0DQo+ID4+PiA+ICsrKysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4+PiA+wqAgZHJp
dmVycy9wY2kvcHJvYmUuY8KgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDC
oMKgwqDCoCB8wqAgNiArKw0KPiA+Pj4gPsKgIGRyaXZlcnMvcGNpL3JlbW92ZS5jwqDCoMKgwqDC
oMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB8wqAgNiArKw0KPiA+Pj4gPsKg
IDQgZmlsZXMgY2hhbmdlZCwgMTE1IGluc2VydGlvbnMoKykNCj4gPj4+ID4NCj4gPj4+ID4gZGlm
ZiAtLWdpdCBhL2RyaXZlcnMvb2YvaXJxLmMgYi9kcml2ZXJzL29mL2lycS5jIGluZGV4DQo+ID4+
PiA+IGEyOTZlYWYuLjc5MWU2MDkgMTAwNjQ0DQo+ID4+PiA+IC0tLSBhL2RyaXZlcnMvb2YvaXJx
LmMNCj4gPj4+ID4gKysrIGIvZHJpdmVycy9vZi9pcnEuYw0KPiA+Pj4gPiBAQCAtNTc2LDYgKzU3
NiwxMSBAQCB2b2lkIF9faW5pdCBvZl9pcnFfaW5pdChjb25zdCBzdHJ1Y3QNCj4gPj4+ID5vZl9k
ZXZpY2VfaWQNCj4gPj4+ID4gKm1hdGNoZXMpDQo+ID4+PiA+wqDCoMKgwqDCoCB9DQo+ID4+PiA+
wqAgfQ0KPiA+Pj4gPg0KPiA+Pj4gPiArdTMyIF9fd2VhayBsc19wY2llX3N0cmVhbWlkX2ZpeChz
dHJ1Y3QgZGV2aWNlICpkZXYsIHUzMiByaWQpIHsNCj4gPj4+ID4gK8KgwqDCoCByZXR1cm4gcmlk
Ow0KPiA+Pj4gPiArfQ0KPiA+Pj4gPiArDQo+ID4+PiA+wqAgc3RhdGljIHUzMiBfX29mX21zaV9t
YXBfcmlkKHN0cnVjdCBkZXZpY2UgKmRldiwgc3RydWN0DQo+ID4+PiA+ZGV2aWNlX25vZGUgICoq
bnAsDQo+ID4+PiA+wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoCB1MzIgcmlkX2lu
KQ0KPiA+Pj4gPsKgIHsNCj4gPj4+ID4gQEAgLTU5MCw2ICs1OTUsMTAgQEAgc3RhdGljIHUzMiBf
X29mX21zaV9tYXBfcmlkKHN0cnVjdCBkZXZpY2UNCj4gPj4+ID4qZGV2LCAgc3RydWN0IGRldmlj
ZV9ub2RlICoqbnAsDQo+ID4+PiA+wqDCoMKgwqDCoMKgwqDCoMKgIGlmICghb2ZfbWFwX3JpZChw
YXJlbnRfZGV2LT5vZl9ub2RlLCByaWRfaW4sICJtc2ktbWFwIiwNCj4gPj4+ID7CoMKgwqDCoMKg
wqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgICJtc2ktbWFwLW1hc2siLCBucCwgJnJpZF9vdXQpKQ0K
PiA+Pj4gPsKgwqDCoMKgwqDCoMKgwqDCoMKgwqDCoMKgIGJyZWFrOw0KPiA+Pj4gPiArDQo+ID4+
PiA+ICvCoMKgwqAgaWYgKHJpZF9vdXQgPT0gcmlkX2luKQ0KPiA+Pj4gPiArwqDCoMKgwqDCoMKg
wqAgcmlkX291dCA9IGxzX3BjaWVfc3RyZWFtaWRfZml4KHBhcmVudF9kZXYsIHJpZF9pbik7DQo+
ID4+Pg0KPiA+Pj4gT3ZlciBteSBkZWFkIGJvZHkuIEdldCB5b3VyIGZpcm13YXJlIHRvIHByb3Bl
cmx5IHByb2dyYW0gdGhlIExVVCBzbw0KPiA+Pj4gdGhhdCBpdCBwcmVzZW50cyB0aGUgSVRTIHdp
dGggYSByZWFzb25hYmxlIHRvcG9sb2d5LiBUaGVyZSBpcw0KPiA+Pj4gYWJzb2x1dGVseSBubyB3
YXkgdGhpcyBraW5kIG9mIGNoYW5nZSBtYWtlcyBpdCBpbnRvIHRoZSBrZXJuZWwuDQo+ID4+DQo+
ID4+IFNvcnJ5IGZvciB0aGlzLCBJIGtub3cgaXQgaXMgbm90IHJlYXNvbmFibGUsIGJ1dCBJIGhh
dmUgbm8gb3RoZXIgd2F5LA0KPiA+PiBhcyBJIGtub3csIEFSTSBnZXQgdGhlIG1hcHBpbmcgb2Yg
c3RyZWFtIElEIHRvIHJlcXVlc3QgSUQgZnJvbSB0aGUNCj4gPj4gbXNpLW1hcCBwcm9wZXJ0eSBv
ZiBEVFMsIGlmIGFkZCBhIG5ldyBkZXZpY2Ugd2hpY2ggbmVlZCB0aGUgc3RyZWFtIElEDQo+ID4+
IGFuZCB0cnkgdG8gZ2V0IGl0IGZyb20gdGhlIG1zaS1tYXAgb2YgRFRTLCBpdCB3aWxsIGZhaWxl
ZCBhbmQgbm90DQo+ID4+IHdvcmssIHllcz8gU28gY291bGQgeW91IGdpdmUgbWUgYSBiZXR0ZXIg
YWR2aWNlIHRvIGZpeCB0aGlzIGlzc3VlLCBJDQo+ID4+IHdvdWxkIHJlYWxseSBhcHByZWNpYXRl
IGFueSBjb21tZW50cyBvciBzdWdnZXN0aW9ucywgdGhhbmtzIGEgbG90Lg0KPiA+DQo+ID4gV2h5
IGNhbid0IGZpcm13YXJlIGV4cG9zZSBhbiBtc2ktbWFwL21zaS1tYXAtbWFzayB0aGF0IGhhcyBh
IGxhcmdlDQo+ID4gZW5vdWdoIHJhbmdlIHRvIGVuc3VyZSBtYXBwaW5nIG9mIFZGcz8gV2hhdCBh
cmUgdGhlIGxpbWl0YXRpb25zIG9mIHRoZQ0KPiA+IExVVCB0aGF0IHdvdWxkIHByZXZlbnQgdGhp
cyBmcm9tIGJlaW5nIGNvbmZpZ3VyZWQgYmVmb3JlIHRoZSBrZXJuZWwNCj4gPiBib290cz8NCg0K
VGhhbmtzIGZvciB5b3VyIGNvbW1lbnRzLCB5ZXMsIHRoaXMgaXMgdGhlIHJvb3QgY2F1c2UsIHdl
IG9ubHkgaGF2ZSAxNiBzdHJlYW0NCklEcyBmb3IgUENJZSBkb21haW4sIHRoaXMgaXMgdGhlIGhh
cmR3YXJlIGxpbWl0YXRpb24sIGlmIHRoZXJlIGhhdmUgZW5vdWdoIHN0cmVhbQ0KSURzLCB3ZSBj
YW4gZXhwb3NlIGFuIG1zaS1tYXAvbXNpLW1hcC1tYXNrIGZvciBhbGwgUENJZSBkZXZpY2VzIGlu
IHN5c3RlbSwNCnVuZm9ydHVuYXRlbHksIHRoZSBzdHJlYW0gSURzIGlzIG5vdCBlbm91Z2gsIEkg
dGhpbmsgb3RoZXIgQVJNIHZlbmRvciBoYXZlIHNhbWUNCmlzc3VlIHRoYXQgdGhleSBkb24ndCBo
YXZlIGVub3VnaCBzdHJlYW0gSURzLg0KDQpUaGFua3MNClhpYW93ZWkgIA0KDQo+IA0KPiBGdXJ0
aGVybW9yZSwgbm90ZSB0aGF0IHRoaXMgYXR0ZW1wdCBpc24ndCBkb2luZyBhbnl0aGluZyBmb3Ig
dGhlIFNNTVUNCj4gU3RyZWFtIElEcywgc28gdGhlIG1vbWVudCBhbnlvbmUgdHJpZXMgdG8gYXNz
aWduIHRob3NlIFZGcyB0aGV5J3JlIHN0aWxsIGdvaW5nDQo+IHRvIGdvIGJhbmcgYW55d2F5LiBB
bnkgZmlybXdhcmUtYmFzZWQgZml4dXAgZm9yIElEIG1hcHBpbmdzLCBjb25maWcgc3BhY2UNCj4g
YWRkcmVzc2VzLCBldGMuIG5lZWRzIHRvIGJlIFNSLUlPVi1hd2FyZSBhbmQgYWNjb3VudCBmb3Ig
YWxsICpwb3NzaWJsZSoNCj4gQkRGcy4NCj4gDQo+IE9uIExTMjA4NSBhdCBsZWFzdCwgSUlSQyB5
b3UgY2FuIGNvbmZpZ3VyZSBhIHNpbmdsZSBMVVQgZW50cnkgdG8ganVzdCB0cmFuc2xhdGUNCj4g
dGhlIEJ1czpEZXZpY2UgaWRlbnRpZmllciBhbmQgcGFzcyBzb21lIG9yIGFsbCBvZiB0aGUgRnVu
Y3Rpb24gYml0cyBzdHJhaWdodA0KPiB0aHJvdWdoIGFzIHRoZSBMU0JzIG9mIHRoZSBTdHJlYW0g
SUQsIHNvIEkgZG9uJ3QgYmVsaWV2ZSB0aGUgcmVsYXRpdmVseSBsaW1pdGVkDQo+IG51bWJlciBv
ZiBMVVQgcmVnaXN0ZXJzIHNob3VsZCBiZSB0b28gbXVjaCBvZiBhbiBpc3N1ZS4gRm9yIGV4YW1w
bGUsIGxhc3QNCj4gdGltZSBJIGhhY2tlZCBvbiB0aGF0IEkgYXBwYXJlbnRseSBoYWQgaXQgc2V0
IHVwIHN0YXRpY2FsbHkgbGlrZSB0aGlzOg0KPiANCj4gJnBjaWUzIHsNCj4gCS8qIFNxdWFzaCA4
OjU6MyBCREYgZG93biB0byAyOjI6MyAqLw0KPiAJbXNpLW1hcC1tYXNrID0gPDB4MDMxZj47DQo+
IAltc2ktbWFwID0gPDB4MDAwICZpdHMgMHgwMCAweDIwPiwNCj4gCQkgIDwweDEwMCAmaXRzIDB4
MjAgMHgyMD4sDQo+IAkJICA8MHgyMDAgJml0cyAweDQwIDB4MjA+LA0KPiAJCSAgPDB4MzAwICZp
dHMgMHg2MCAweDIwPjsNCj4gfTsNCg0KVGhhbmtzIFJvYmluLCB0aGlzIGlzIGEgZWZmZWN0aXZl
IHdheSwgYnV0IHdlIG9ubHkgaGF2ZSB0b3RhbCAxNiBzdHJlYW0gSURzIGZvciBQQ0llIGRvbWFp
biwNCmFuZCBvbmx5IGFzc2lnbiA0IHN0cmVhbSBJRHMgZm9yIGVhY2ggUENJZSBjb250cm9sbGVy
IGlmIHRoZSBib2FyZCBoYXZlIDQgUENJZSBjb250cm9sbGVycywNCnRoaXMgaXMgdGhlIHJvb3Qg
Y2F1c2UsIEkgc3VibWl0dGVkIHRoaXMgcGF0Y2ggdG8gZHluYW1pY2FsbHkgbWFuYWdlIHRoZXNl
IHN0cmVhbSBJRHMsIA0Kc28gdGhhdCBpdCBsb29rcyBsaWtlIGVhY2ggUENJZSBjb250cm9sbGVy
IGhhcyAxNiBzdHJlYW0gSURzLiBJIGNhbiBkeW5hbWljYWxseSBhbGxvY2F0ZSBhbmQgDQpyZWxl
YXNlIHRoZXNlIHN0cmVhbSBJRHMgYmFzZWQgb24gdGhlIFBDSWUgZGV2aWNlcyBpbiB0aGUgY3Vy
cmVudCBzeXN0ZW0uIElmIHVzZSB5b3VyIG1ldGhvZCwNCndlIHN1cHBvcnQgdXAgdG8gNCBQQ0ll
IGRldmljZXMoMiBQRnMgYW5kIDIgVkZzKSwgaXQgd2lsbCBub3QgYWNoaWV2ZSBvdXIgcHVycG9z
ZS4NCg0KVGhhbmtzIA0KWGlhb3dlaQ0KDQo+IA0KPiBSb2Jpbi4NCg==
