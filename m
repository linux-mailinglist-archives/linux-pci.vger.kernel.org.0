Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE875BD35
	for <lists+linux-pci@lfdr.de>; Mon,  1 Jul 2019 15:43:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729027AbfGANnX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 1 Jul 2019 09:43:23 -0400
Received: from mail-eopbgr140137.outbound.protection.outlook.com ([40.107.14.137]:30679
        "EHLO EUR01-VE1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1729148AbfGANnX (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 1 Jul 2019 09:43:23 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=SILICOMLTD.onmicrosoft.com; s=selector1-SILICOMLTD-onmicrosoft-com;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=+4Dwe9wnlRxLdeM2BWT3PbZtSB05kpQb+fL6WTl4ey0=;
 b=aFFB0HudiPne1LEJx2ISGFXQPrk7HAjjw1mtRXTZ5aGGcqyhuqlprqITGW5x13Y3XT2tNbC+Npe1m+FOBKqcY+5IZSvCe8j6ykfADaq7sa40Cq6HbZF7fIFMehFPjxmiFbYeqzvH3H+YyLgmmuVIiHBszQduGe/817w+QFIuUls=
Received: from HE1PR04MB3001.eurprd04.prod.outlook.com (10.170.255.147) by
 HE1PR04MB3244.eurprd04.prod.outlook.com (10.170.251.156) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.2032.20; Mon, 1 Jul 2019 13:43:19 +0000
Received: from HE1PR04MB3001.eurprd04.prod.outlook.com
 ([fe80::5d1d:2a74:3402:c417]) by HE1PR04MB3001.eurprd04.prod.outlook.com
 ([fe80::5d1d:2a74:3402:c417%7]) with mapi id 15.20.2032.019; Mon, 1 Jul 2019
 13:43:18 +0000
From:   Stephen Douthit <stephend@silicom-usa.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC:     Stephen Douthit <stephend@silicom-usa.com>,
        "linux-pm@vger.kernel.org" <linux-pm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: [PATCH] intel_idle: prevent SKX boot failure when C6 & SERIRQ enabled
Thread-Topic: [PATCH] intel_idle: prevent SKX boot failure when C6 & SERIRQ
 enabled
Thread-Index: AQHVMBLwGSwv5ZM4JUOLcUCRmpTlRQ==
Date:   Mon, 1 Jul 2019 13:43:18 +0000
Message-ID: <20190701134255.25959-1-stephend@silicom-usa.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: BN8PR15CA0049.namprd15.prod.outlook.com
 (2603:10b6:408:80::26) To HE1PR04MB3001.eurprd04.prod.outlook.com
 (2603:10a6:7:1f::19)
authentication-results: spf=none (sender IP is )
 smtp.mailfrom=stephend@silicom-usa.com; 
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.21.0
x-originating-ip: [96.82.2.57]
x-ms-publictraffictype: Email
x-ms-office365-filtering-correlation-id: a1ccafec-2e82-440a-211a-08d6fe2a1311
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(7020095)(4652040)(8989299)(4534185)(4627221)(201703031133081)(201702281549075)(8990200)(5600148)(711020)(4605104)(1401327)(2017052603328)(7193020);SRVR:HE1PR04MB3244;
x-ms-traffictypediagnostic: HE1PR04MB3244:
x-microsoft-antispam-prvs: <HE1PR04MB3244322595CB285BA67069DA94F90@HE1PR04MB3244.eurprd04.prod.outlook.com>
x-ms-oob-tlc-oobclassifiers: OLM:7691;
x-forefront-prvs: 00851CA28B
x-forefront-antispam-report: SFV:NSPM;SFS:(10019020)(366004)(39850400004)(346002)(396003)(136003)(376002)(199004)(189003)(6512007)(73956011)(6436002)(66446008)(64756008)(1076003)(52116002)(66556008)(66476007)(66946007)(5660300002)(53936002)(305945005)(7736002)(54906003)(110136005)(66066001)(6116002)(3846002)(99286004)(6486002)(71190400001)(316002)(68736007)(71200400001)(2906002)(86362001)(4326008)(36756003)(26005)(14454004)(25786009)(50226002)(14444005)(476003)(2616005)(256004)(186003)(8676002)(6506007)(102836004)(8936002)(81166006)(478600001)(81156014)(386003)(486006);DIR:OUT;SFP:1102;SCL:1;SRVR:HE1PR04MB3244;H:HE1PR04MB3001.eurprd04.prod.outlook.com;FPR:;SPF:None;LANG:en;PTR:InfoNoRecords;A:1;MX:1;
received-spf: None (protection.outlook.com: silicom-usa.com does not designate
 permitted sender hosts)
x-ms-exchange-senderadcheck: 1
x-microsoft-antispam-message-info: KCwrAyhxHzauGbe11zX76HsGW9PP5jlfLf8U9lKPXCX2EkxGjjyifCfj+wNzSSxzTleE2MvLsU92rHyNWhY+/CXDD/J3oco/ZsVPhtQl0YQUukxE+JvfZtils1lyAZhW2Mam44Z/kCM43TbkU9UVHb/T2NwTdBGuQqvhBPTETAelcnzChNtFu8go8AYEEQGE6jdttp8nrg5aA8yugof9EiCIfmLLQzvLqEV7IbXb/KifH2tx+GSac/ixFl9axatUIm0/Vq36WYW4OYIPo5AqQ9kcwg+CFyBHzuW3Pc5fB7mdCxQ3k5A6dnrrY2YIjMydDvlOk/6/mnf1LBxUnOFm3i9/I2QSp1klam16XwRQb2K3L24N6bpHX8GLFHKOpHyXFh0dyCtoZ0eAJros7uTdb1Zf/2K7h1FVnduSJt8IjO4=
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: silicom-usa.com
X-MS-Exchange-CrossTenant-Network-Message-Id: a1ccafec-2e82-440a-211a-08d6fe2a1311
X-MS-Exchange-CrossTenant-originalarrivaltime: 01 Jul 2019 13:43:18.8332
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Hosted
X-MS-Exchange-CrossTenant-id: c9e326d8-ce47-4930-8612-cc99d3c87ad1
X-MS-Exchange-CrossTenant-mailboxtype: HOSTED
X-MS-Exchange-CrossTenant-userprincipalname: stephend@silicom-usa.com
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HE1PR04MB3244
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SW50ZXJydXB0cyBhcmUgZ2V0dGluZyBtaXNyb3V0ZWQgYW5kL29yIGRyb3BwZWQgb24gU0tMWUxB
S0VfWCBiYXNlZCBELTIxMDBzDQp3aGVuIEM2IGFuZCBTRVJJUlEgYXJlIGVuYWJsZWQuICBJJ3Zl
IG9ubHkgc2VlbiB0aGlzIGlzc3VlIG9uIHN5c3RlbXMNCnVzaW5nIFNFUklSUXMgKGluIG15IGNh
c2UgZm9yIGEgTFBDIGJhc2VkIFVBUlQgcHJvdmlkaW5nIHRoZSBzZXJpYWwNCmNvbnNvbGUgZm9y
IGEgaGVhZGxlc3Mgc2VydmVyKS4NCg0KT25lIGZhaWx1cmUgbW9kZSBpcyAiZG9fSVJROiA4LjMz
IE5vIGlycSBoYW5kbGVyIGZvciB2ZWN0b3IiIGdldHRpbmcNCnByaW50ZWQgaW4gdGhlIGtlcm5l
bCBsb2dzLiBUaGUgY29yZSBnZXR0aW5nIHRoZSB1bmhhbmRsZWQgaXJxIGlzIHR5cGljYWxseQ0K
dGhlIG9uZSBoYW5kbGluZyB0aGUgVUFSVCBTRVJJUlEuICBJJ3ZlIHNlZW4gaXQgb24gb3RoZXIg
Y29yZXMsIGJ1dCBJDQpoYXZlbid0IGNvbmZpcm1lZCBpZiB0aGF0J3MgYmVjYXVzZSB0aGUgVUFS
VCBpcnEgaGFuZGxlciB3YXMgbW92ZWQgdG8NCmFub3RoZXIgY29yZSBhdCBzb21lIHBvaW50LiAg
VGhlIHZlY3RvciB2YXJpZXMgZnJvbSAzMy0zNiwgYnV0IGl0J3MgbW9zdA0Kb2Z0ZW4gMzMuDQoN
ClRoZSBvdGhlciBmYWlsdXJlIG1vZGUgaXMgdGhlIHN5c3RlbSBoYW5naW5nLiAgU29tZXRpbWVz
IGZvcmNpbmcgc29tZSBub24NClNFUklSUSBpbnRlcnJ1cHQgdG8gZmlyZSAoYnkgcGx1Z2dpbmcv
dW5wbHVnZ2luZyBhIG5ldHdvcmsvVVNCIGNhYmxlKSBjYW4NCmdldCB0aGUgc3lzdGVtIG91dCBv
ZiB0aGlzIHN0YXRlLiAgR2VuZXJhdGluZyBtb3JlIFNFUklSUXMgdmlhIHRoZSBVQVJUDQp3aWxs
IG5vdCB1bnN0aWNrIHRoZSBzeXN0ZW0uDQoNCkJvdGggZmFpbHVyZXMgc2VlbWVkIHRvIG9jY3Vy
IHdoZW4gdHJhbnNpdGlvbiB0byBhIGxvdyBsb2FkIHN0YXRlLCB3aGljaA0KaXMgd2h5IEkgc3Rh
cnRlZCBwbGF5aW5nIGFyb3VuZCB3aXRoIHBvd2VyIG1hbmFnZW1lbnQgb3B0aW9ucyBhbmQgZm91
bmQNCnRoYXQgYm9vdGluZyB3aXRoICJpbnRlbF9pZGxlLm1heF9jc3RhdGU9MiIgZml4ZWQgdGhl
IGlzc3VlLg0KDQpUaGlzIHBhdGNoIG9ubHkgZGlzYWJsZXMgQzYgaWYgaXQncyBhYmxlIHRvIGRl
dGVybWluZSB0aGF0IFNFUklSUXMgYXJlDQplbmFibGVkIGJ5IGNoZWNraW5nIHRoZSBlbmFibGUg
Yml0IGluIHRoZSBMUEMgY29udHJvbGxlcnMgUENJIGNvbmZpZyBzcGFjZS4NCg0KU2lnbmVkLW9m
Zi1ieTogU3RlcGhlbiBEb3V0aGl0IDxzdGVwaGVuZEBzaWxpY29tLXVzYS5jb20+DQotLS0NCiBk
cml2ZXJzL2lkbGUvaW50ZWxfaWRsZS5jIHwgMzUgKysrKysrKysrKysrKysrKysrKysrKysrKysr
KysrKysrKy0NCiBpbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCAgIHwgIDEgKw0KIDIgZmlsZXMgY2hh
bmdlZCwgMzUgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigtKQ0KDQpkaWZmIC0tZ2l0IGEvZHJp
dmVycy9pZGxlL2ludGVsX2lkbGUuYyBiL2RyaXZlcnMvaWRsZS9pbnRlbF9pZGxlLmMNCmluZGV4
IGI4NjQ3YjVjM2Q0ZC4uMzUzZjZhOWIxODE4IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9pZGxlL2lu
dGVsX2lkbGUuYw0KKysrIGIvZHJpdmVycy9pZGxlL2ludGVsX2lkbGUuYw0KQEAgLTYxLDEyICs2
MSwxMyBAQA0KICNpbmNsdWRlIDxsaW51eC9ub3RpZmllci5oPg0KICNpbmNsdWRlIDxsaW51eC9j
cHUuaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxlcGFyYW0uaD4NCisjaW5jbHVkZSA8bGludXgv
cGNpLmg+DQogI2luY2x1ZGUgPGFzbS9jcHVfZGV2aWNlX2lkLmg+DQogI2luY2x1ZGUgPGFzbS9p
bnRlbC1mYW1pbHkuaD4NCiAjaW5jbHVkZSA8YXNtL213YWl0Lmg+DQogI2luY2x1ZGUgPGFzbS9t
c3IuaD4NCiANCi0jZGVmaW5lIElOVEVMX0lETEVfVkVSU0lPTiAiMC40LjEiDQorI2RlZmluZSBJ
TlRFTF9JRExFX1ZFUlNJT04gIjAuNC4yIg0KIA0KIHN0YXRpYyBzdHJ1Y3QgY3B1aWRsZV9kcml2
ZXIgaW50ZWxfaWRsZV9kcml2ZXIgPSB7DQogCS5uYW1lID0gImludGVsX2lkbGUiLA0KQEAgLTEz
MDYsNiArMTMwNywzNSBAQCBzdGF0aWMgdm9pZCBza2xoX2lkbGVfc3RhdGVfdGFibGVfdXBkYXRl
KHZvaWQpDQogCXNrbF9jc3RhdGVzWzVdLmRpc2FibGVkID0gMTsJLyogQzgtU0tMICovDQogCXNr
bF9jc3RhdGVzWzZdLmRpc2FibGVkID0gMTsJLyogQzktU0tMICovDQogfQ0KKy8qDQorICogc2t4
X2lkbGVfc3RhdGVfdGFibGVfdXBkYXRlKCkNCisgKg0KKyAqIE9uIFNLWCAobW9kZWwgMHg1NSkg
U29DcyBkaXNhYmxlIEM2IGlmIFNFUklSUSBpcyBlbmFibGVkDQorICovDQorc3RhdGljIHZvaWQg
c2t4X2lkbGVfc3RhdGVfdGFibGVfdXBkYXRlKHZvaWQpDQorew0KKyNkZWZpbmUgU0NOVF9PRkYg
MHg2NA0KKyNkZWZpbmUgU0NOVF9FTiAoMSA8PCA3KQ0KKwlzdHJ1Y3QgcGNpX2RldiAqcGRldiA9
IHBjaV9nZXRfZGV2aWNlKFBDSV9WRU5ET1JfSURfSU5URUwsDQorCQkJCQkgICAgICBQQ0lfREVW
SUNFX0lEX0lOVEVMX1NLWF9MUEMsDQorCQkJCQkgICAgICBOVUxMKTsNCisJdTggcmVnOw0KKw0K
KwkvKg0KKwkgKiBDaGVjayBiaXQgNyBvZiB0aGUgU2VyaWFsIElSUSBDb250cm9sIChTQ05UKSBy
ZWdpc3RlciAoMHg2NCkgaW4gdGhlDQorCSAqIExQQyBjb250cm9sbGVyLiAgSWYgaXQncyBzZXQg
c2VyaWFsIElSUXMgYXJlIGVuYWJsZWQsIGFuZCB3ZSBuZWVkIHRvDQorCSAqIGRpc2FibGUgQzYg
dG8gcHJldmVudCBoYW5ncy4NCisJICovDQorCWlmICghcGRldikNCisJCXJldHVybjsNCisJaWYg
KHBjaV9yZWFkX2NvbmZpZ19ieXRlKHBkZXYsIFNDTlRfT0ZGLCAmcmVnKSkNCisJCXJldHVybjsN
CisJaWYgKCEocmVnICYgU0NOVF9FTikpDQorCQlyZXR1cm47DQorDQorCXByX2RlYnVnKCJTRVJJ
UlEgZW5hYmxlZCBvbiBTS1gsIGRpc2FibGluZyBDNiB0byBhdm9pZCBoYW5nc1xuIik7DQorCXNr
eF9jc3RhdGVzWzJdLmRpc2FibGVkID0gMTsJLyogQzYtU0tYICovDQorfQ0KIC8qDQogICogaW50
ZWxfaWRsZV9zdGF0ZV90YWJsZV91cGRhdGUoKQ0KICAqDQpAQCAtMTMyNiw2ICsxMzU2LDkgQEAg
c3RhdGljIHZvaWQgaW50ZWxfaWRsZV9zdGF0ZV90YWJsZV91cGRhdGUodm9pZCkNCiAJY2FzZSBJ
TlRFTF9GQU02X1NLWUxBS0VfREVTS1RPUDoNCiAJCXNrbGhfaWRsZV9zdGF0ZV90YWJsZV91cGRh
dGUoKTsNCiAJCWJyZWFrOw0KKwljYXNlIElOVEVMX0ZBTTZfU0tZTEFLRV9YOg0KKwkJc2t4X2lk
bGVfc3RhdGVfdGFibGVfdXBkYXRlKCk7DQorCQlicmVhazsNCiAJfQ0KIH0NCiANCmRpZmYgLS1n
aXQgYS9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaCBiL2luY2x1ZGUvbGludXgvcGNpX2lkcy5oDQpp
bmRleCA3MGU4NjE0OGNiMWUuLjAyYmFjOGRlMDNmZCAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGlu
dXgvcGNpX2lkcy5oDQorKysgYi9pbmNsdWRlL2xpbnV4L3BjaV9pZHMuaA0KQEAgLTI5OTcsNiAr
Mjk5Nyw3IEBADQogI2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVMXzg0NDYwR1gJMHg4NGVhDQog
I2RlZmluZSBQQ0lfREVWSUNFX0lEX0lOVEVMX0lYUDRYWAkweDg1MDANCiAjZGVmaW5lIFBDSV9E
RVZJQ0VfSURfSU5URUxfSVhQMjgwMAkweDkwMDQNCisjZGVmaW5lIFBDSV9ERVZJQ0VfSURfSU5U
RUxfU0tYX0xQQwkweGExYzgNCiAjZGVmaW5lIFBDSV9ERVZJQ0VfSURfSU5URUxfUzIxMTUyQkIJ
MHhiMTUyDQogDQogI2RlZmluZSBQQ0lfVkVORE9SX0lEX1NDQUxFTVAJCTB4ODY4Ng0KLS0gDQoy
LjIxLjANCg0K
