Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id C6968265C6
	for <lists+linux-pci@lfdr.de>; Wed, 22 May 2019 16:31:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729362AbfEVOb3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 22 May 2019 10:31:29 -0400
Received: from mail-oln040092255066.outbound.protection.outlook.com ([40.92.255.66]:29856
        "EHLO APC01-HK2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728835AbfEVOb3 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 22 May 2019 10:31:29 -0400
Received: from HK2APC01FT049.eop-APC01.prod.protection.outlook.com
 (10.152.248.51) by HK2APC01HT047.eop-APC01.prod.protection.outlook.com
 (10.152.249.52) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.20.1922.16; Wed, 22 May
 2019 14:31:23 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM (10.152.248.53) by
 HK2APC01FT049.mail.protection.outlook.com (10.152.249.218) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.1922.16 via Frontend Transport; Wed, 22 May 2019 14:31:23 +0000
Received: from PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::1c5e:7ea0:b90c:65c9]) by PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 ([fe80::1c5e:7ea0:b90c:65c9%10]) with mapi id 15.20.1922.016; Wed, 22 May
 2019 14:31:23 +0000
From:   Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "corbet@lwn.net" <corbet@lwn.net>,
        Nicholas Johnson <nicholas.johnson-opensource@outlook.com.au>
Subject: [PATCH v6 4/4] PCI: Add pci=hpmemprefsize parameter to set MMIO_PREF
 size independently
Thread-Topic: [PATCH v6 4/4] PCI: Add pci=hpmemprefsize parameter to set
 MMIO_PREF size independently
Thread-Index: AQHVEKsHwCqlldYoMk6d0urRHVeKyg==
Date:   Wed, 22 May 2019 14:31:23 +0000
Message-ID: <PS2P216MB0642C49BBB4594197AE1C07C80000@PS2P216MB0642.KORP216.PROD.OUTLOOK.COM>
References: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
In-Reply-To: <20190522222928.2964-1-nicholas.johnson-opensource@outlook.com.au>
Accept-Language: en-AU, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-clientproxiedby: SYBPR01CA0209.ausprd01.prod.outlook.com
 (2603:10c6:10:16::29) To PS2P216MB0642.KORP216.PROD.OUTLOOK.COM
 (2603:1096:300:1c::16)
x-incomingtopheadermarker: OriginalChecksum:2A4859F7C8B715DA7ADA99596C0698E9012A0B0C69BFDB5F30E7CB48A19DA3FF;UpperCasedChecksum:6568E58DD8E9C9342E6324D7C0697A8C333EEDB1F9970289F8698CDC1FFCB3D8;SizeAsReceived:7925;Count:50
x-ms-exchange-messagesentrepresentingtype: 1
x-mailer: git-send-email 2.19.1
x-tmn:  [VWHQ7I6Ekcvs30bkRjrumcJvj8YCVFrLQEh9ZdwS4OoB8v9HHOGo96hn/fxG6Y5jRtZK7LOK18Y=]
x-microsoft-original-message-id: <20190522222928.2964-5-nicholas.johnson-opensource@outlook.com.au>
x-ms-publictraffictype: Email
x-incomingheadercount: 50
x-eopattributedmessage: 0
x-ms-exchange-slblob-mailprops: LtmIgUwM0qRgu7a18JoWELM9szmhVHsD3EF14rrkFiPtQC+gjKyJ1EfWf5MwespRaa9DFaS5UHgkm7DnYY9kCz1TyJsXGIwyvw0G6qStU3SfPiApj0TXaR7cVWoSCDu+jTGWvpVscq9k/VzIY60BjnAhbYxfBuGHZllfIzujgNEEtJys3Iv7jmEn/EpDGF+pFO70nKxDy2PIW23kGgUZ3Nqpbo+yoVMBipojJ1WmQd0P0a2xaqMtynK4+4AVFUZfH1otoVphf7HUHV7pVqK2G5nWJtJnO76GU9SHfLAFOTIdkJ5QsvQ/c0gA5+mhAUAag+v/Jwz+5DBPHvhX8RXrgsz6lfp9Pan8Kcri0HH4NCvBxab0ocsnLfbDx1KghjXmze3rEtVjMVK5UnHZ9whCBqzZqUlCQWW7XGls2mGP/AR5yDtkQcW5wen4Lp/46mdYsluknw6VSF6SjeTmepuMRH4UL3JogyQYEgJu4ANzkhiMZJ5mucB4yf4Xe8sJThofibvmY24RCrxhyaKAvLD3bOZWL4xeTV9qmqRoi5kqFGvxCTkCfX6Fe7vcq6EfctFhaCrPxmJ/e0qh0W8TsQ5tBN7Y6uEixOCL3FKvorcvhzu5tHGlIGj3b1DQva7QF+RcskHHTMiDBCz+6emcR9mt6fIOplujy+F5FkxUq3hCUGBEpW1nT4f6c+TwYK6K0d1EUg/ytHXygSIarMsGD6d3cqhibgsOcfE5kLE59tBGlar32m6yBq9BRlVZ/tzBKq5rWOabCS4BWx4j7HyT3yePGg==
x-microsoft-antispam: BCL:0;PCL:0;RULEID:(2390118)(5050001)(7020095)(20181119110)(201702061078)(5061506573)(5061507331)(1603103135)(2017031320274)(201702181274)(2017031322404)(2017031323274)(2017031324274)(1601125500)(1603101475)(1701031045);SRVR:HK2APC01HT047;
x-ms-traffictypediagnostic: HK2APC01HT047:
x-microsoft-antispam-message-info: WlKi5JPdSeJ4guVYVSnb4IUijRmHVeQPUwCQLZwzAp5S10/TL2WZLBQ2WeeWr6mJi3wxO6OTzF4uaYUxpgOG1ANd6kEVDcnwaO6Pls8YrHNpWjyjZKSR4w/ChcwQHUAU4GMMIwXmsDOAXlAX8hEQ7qdiBh1CQTGLoiTetIkoiHDgiFwpwJ8xaxa2dcanfUXJ
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-OriginatorOrg: outlook.com
X-MS-Exchange-CrossTenant-RMS-PersistedConsumerOrg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-Network-Message-Id: b73a84f9-8bfb-4185-b3c7-08d6dec229c3
X-MS-Exchange-CrossTenant-rms-persistedconsumerorg: 00000000-0000-0000-0000-000000000000
X-MS-Exchange-CrossTenant-originalarrivaltime: 22 May 2019 14:31:23.0181
 (UTC)
X-MS-Exchange-CrossTenant-fromentityheader: Internet
X-MS-Exchange-CrossTenant-id: 84df9e7f-e9f6-40af-b435-aaaaaaaaaaaa
X-MS-Exchange-Transport-CrossTenantHeadersStamped: HK2APC01HT047
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIGtlcm5lbCBwYXJhbWV0ZXIgcGNpPWhwbWVtcHJlZnNpemU9bm5bS01HXSB0byBjb250cm9s
IE1NSU9fUFJFRiBzaXplDQpmb3IgUENJIGhvdHBsdWcgYnJpZGdlcy4NCg0KQ2hhbmdlIGJlaGF2
aW91ciBvZiBwY2k9aHBtZW1zaXplPW5uW0tNR10gdG8gbm90IHNldCBNTUlPX1BSRUYgc2l6ZSBp
Zg0KaHBtZW1wcmVmIGhhcyBiZWVuIHNwZWNpZmllZCwgcmF0aGVyIHRoYW4gY29udHJvbGxpbmcg
Ym90aCBNTUlPIGFuZA0KTU1JT19QUkVGIHNpemVzIHVuY29uZGl0aW9uYWxseS4NCg0KVXBkYXRl
IGtlcm5lbC1wYXJhbWV0ZXJzIGRvY3VtZW50YXRpb24gdG8gcmVmbGVjdCB0aGUgYWJvdmUgY2hh
bmdlcy4NCg0KVGhlIGVmZmVjdCBvZiB0aGUgYWJvdmUgY2hhbmdlcyBpcyB0byBhbGxvdyBmb3Ig
TU1JTyBhbmQgTU1JT19QUkVGIHRvIGJlDQpzcGVjaWZpZWQgaW5kZXBlbmRlbnRseSwgd2hpbHN0
IGVuc3VyaW5nIG5vIGNoYW5nZXMgaW4gZnVuY3Rpb25hbGl0eSBhcmUNCm5vdGljZWQgYnkgdGhl
IHVzZXIgaWYgdXBkYXRpbmcga2VybmVsIHZlcnNpb24gd2l0aCBocG1lbXNpemUgc3BlY2lmaWVk
Lg0KDQpTaWduZWQtb2ZmLWJ5OiBOaWNob2xhcyBKb2huc29uIDxuaWNob2xhcy5qb2huc29uLW9w
ZW5zb3VyY2VAb3V0bG9vay5jb20uYXU+DQotLS0NCiAuLi4vYWRtaW4tZ3VpZGUva2VybmVsLXBh
cmFtZXRlcnMudHh0ICAgICAgICAgfCAgNyArKysrKy0NCiBkcml2ZXJzL3BjaS9wY2kuYyAgICAg
ICAgICAgICAgICAgICAgICAgICAgICAgfCAxOCArKysrKysrKysrLS0tDQogZHJpdmVycy9wY2kv
c2V0dXAtYnVzLmMgICAgICAgICAgICAgICAgICAgICAgIHwgMjUgKysrKysrKysrKystLS0tLS0t
LQ0KIGluY2x1ZGUvbGludXgvcGNpLmggICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAzICsr
LQ0KIDQgZmlsZXMgY2hhbmdlZCwgMzcgaW5zZXJ0aW9ucygrKSwgMTYgZGVsZXRpb25zKC0pDQoN
CmRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2FkbWluLWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJz
LnR4dCBiL0RvY3VtZW50YXRpb24vYWRtaW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQpp
bmRleCAxMzhmNjY2NGIuLmZkZWNmZjA2YyAxMDA2NDQNCi0tLSBhL0RvY3VtZW50YXRpb24vYWRt
aW4tZ3VpZGUva2VybmVsLXBhcmFtZXRlcnMudHh0DQorKysgYi9Eb2N1bWVudGF0aW9uL2FkbWlu
LWd1aWRlL2tlcm5lbC1wYXJhbWV0ZXJzLnR4dA0KQEAgLTM0MzksNyArMzQzOSwxMiBAQA0KIAkJ
CQlyZXNlcnZlZCBmb3IgaG90cGx1ZyBicmlkZ2UncyBJTyB3aW5kb3cuDQogCQkJCURlZmF1bHQg
c2l6ZSBpcyAyNTYgYnl0ZXMuDQogCQlocG1lbXNpemU9bm5bS01HXQlUaGUgZml4ZWQgYW1vdW50
IG9mIGJ1cyBzcGFjZSB3aGljaCBpcw0KLQkJCQlyZXNlcnZlZCBmb3IgaG90cGx1ZyBicmlkZ2Un
cyBtZW1vcnkgd2luZG93Lg0KKwkJCQlyZXNlcnZlZCBmb3IgaG90cGx1ZyBicmlkZ2UncyBNTUlP
IHdpbmRvdy4gSWYNCisJCQkJaHBtZW1wcmVmc2l6ZSBpcyBub3Qgc3BlY2lmaWVkLCB0aGVuIHRo
ZSBzYW1lDQorCQkJCXNpemUgaXMgYXBwbGllZCB0byBob3RwbHVnIGJyaWRnZSdzIE1NSU9fUFJF
Rg0KKwkJCQl3aW5kb3cuIERlZmF1bHQgc2l6ZSBpcyAyIG1lZ2FieXRlcy4NCisJCWhwbWVtcHJl
ZnNpemU9bm5bS01HXQlUaGUgZml4ZWQgYW1vdW50IG9mIGJ1cyBzcGFjZSB3aGljaCBpcw0KKwkJ
CQlyZXNlcnZlZCBmb3IgaG90cGx1ZyBicmlkZ2UncyBNTUlPX1BSRUYgd2luZG93Lg0KIAkJCQlE
ZWZhdWx0IHNpemUgaXMgMiBtZWdhYnl0ZXMuDQogCQlocGJ1c3NpemU9bm4JVGhlIG1pbmltdW0g
YW1vdW50IG9mIGFkZGl0aW9uYWwgYnVzIG51bWJlcnMNCiAJCQkJcmVzZXJ2ZWQgZm9yIGJ1c2Vz
IGJlbG93IGEgaG90cGx1ZyBicmlkZ2UuDQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvcGNpLmMg
Yi9kcml2ZXJzL3BjaS9wY2kuYw0KaW5kZXggOGFiYzg0M2IxLi4wZTYyOTIwMDkgMTAwNjQ0DQot
LS0gYS9kcml2ZXJzL3BjaS9wY2kuYw0KKysrIGIvZHJpdmVycy9wY2kvcGNpLmMNCkBAIC04NSwx
MCArODUsMTIgQEAgdW5zaWduZWQgbG9uZyBwY2lfY2FyZGJ1c19pb19zaXplID0gREVGQVVMVF9D
QVJEQlVTX0lPX1NJWkU7DQogdW5zaWduZWQgbG9uZyBwY2lfY2FyZGJ1c19tZW1fc2l6ZSA9IERF
RkFVTFRfQ0FSREJVU19NRU1fU0laRTsNCiANCiAjZGVmaW5lIERFRkFVTFRfSE9UUExVR19JT19T
SVpFCQkoMjU2KQ0KLSNkZWZpbmUgREVGQVVMVF9IT1RQTFVHX01FTV9TSVpFCSgyKjEwMjQqMTAy
NCkNCisjZGVmaW5lIERFRkFVTFRfSE9UUExVR19NTUlPX1NJWkUJKDIqMTAyNCoxMDI0KQ0KKyNk
ZWZpbmUgREVGQVVMVF9IT1RQTFVHX01NSU9fUFJFRl9TSVpFCSgyKjEwMjQqMTAyNCkNCiAvKiBw
Y2k9aHBtZW1zaXplPW5uTSxocGlvc2l6ZT1ubiBjYW4gb3ZlcnJpZGUgdGhpcyAqLw0KIHVuc2ln
bmVkIGxvbmcgcGNpX2hvdHBsdWdfaW9fc2l6ZSAgPSBERUZBVUxUX0hPVFBMVUdfSU9fU0laRTsN
Ci11bnNpZ25lZCBsb25nIHBjaV9ob3RwbHVnX21lbV9zaXplID0gREVGQVVMVF9IT1RQTFVHX01F
TV9TSVpFOw0KK3Vuc2lnbmVkIGxvbmcgcGNpX2hvdHBsdWdfbW1pb19zaXplID0gREVGQVVMVF9I
T1RQTFVHX01NSU9fU0laRTsNCit1bnNpZ25lZCBsb25nIHBjaV9ob3RwbHVnX21taW9fcHJlZl9z
aXplID0gREVGQVVMVF9IT1RQTFVHX01NSU9fUFJFRl9TSVpFOw0KIA0KICNkZWZpbmUgREVGQVVM
VF9IT1RQTFVHX0JVU19TSVpFCTENCiB1bnNpZ25lZCBsb25nIHBjaV9ob3RwbHVnX2J1c19zaXpl
ID0gREVGQVVMVF9IT1RQTFVHX0JVU19TSVpFOw0KQEAgLTYxOTgsNiArNjIwMCw4IEBAIEVYUE9S
VF9TWU1CT0wocGNpX2ZpeHVwX2NhcmRidXMpOw0KIA0KIHN0YXRpYyBpbnQgX19pbml0IHBjaV9z
ZXR1cChjaGFyICpzdHIpDQogew0KKwlib29sIG1taW9fcHJlZl9zcGVjaWZpZWQgPSBmYWxzZTsN
CisNCiAJd2hpbGUgKHN0cikgew0KIAkJY2hhciAqayA9IHN0cmNocihzdHIsICcsJyk7DQogCQlp
ZiAoaykNCkBAIC02MjMyLDcgKzYyMzYsMTUgQEAgc3RhdGljIGludCBfX2luaXQgcGNpX3NldHVw
KGNoYXIgKnN0cikNCiAJCQl9IGVsc2UgaWYgKCFzdHJuY21wKHN0ciwgImhwaW9zaXplPSIsIDkp
KSB7DQogCQkJCXBjaV9ob3RwbHVnX2lvX3NpemUgPSBtZW1wYXJzZShzdHIgKyA5LCAmc3RyKTsN
CiAJCQl9IGVsc2UgaWYgKCFzdHJuY21wKHN0ciwgImhwbWVtc2l6ZT0iLCAxMCkpIHsNCi0JCQkJ
cGNpX2hvdHBsdWdfbWVtX3NpemUgPSBtZW1wYXJzZShzdHIgKyAxMCwgJnN0cik7DQorCQkJCXBj
aV9ob3RwbHVnX21taW9fc2l6ZSA9DQorCQkJCQltZW1wYXJzZShzdHIgKyAxMCwgJnN0cik7DQor
CQkJCWlmICghbW1pb19wcmVmX3NwZWNpZmllZCkNCisJCQkJCXBjaV9ob3RwbHVnX21taW9fcHJl
Zl9zaXplID0NCisJCQkJCQlwY2lfaG90cGx1Z19tbWlvX3NpemU7DQorCQkJfSBlbHNlIGlmICgh
c3RybmNtcChzdHIsICJocG1lbXByZWZzaXplPSIsIDE0KSkgew0KKwkJCQltbWlvX3ByZWZfc3Bl
Y2lmaWVkID0gdHJ1ZTsNCisJCQkJcGNpX2hvdHBsdWdfbW1pb19wcmVmX3NpemUgPQ0KKwkJCQkJ
bWVtcGFyc2Uoc3RyICsgMTQsICZzdHIpOw0KIAkJCX0gZWxzZSBpZiAoIXN0cm5jbXAoc3RyLCAi
aHBidXNzaXplPSIsIDEwKSkgew0KIAkJCQlwY2lfaG90cGx1Z19idXNfc2l6ZSA9DQogCQkJCQlz
aW1wbGVfc3RydG91bChzdHIgKyAxMCwgJnN0ciwgMCk7DQpkaWZmIC0tZ2l0IGEvZHJpdmVycy9w
Y2kvc2V0dXAtYnVzLmMgYi9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYw0KaW5kZXggOGUxYmM3ZWU3
Li40NGMzN2RkYTkgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9zZXR1cC1idXMuYw0KKysrIGIv
ZHJpdmVycy9wY2kvc2V0dXAtYnVzLmMNCkBAIC0xMTg3LDcgKzExODcsOCBAQCB2b2lkIF9fcGNp
X2J1c19zaXplX2JyaWRnZXMoc3RydWN0IHBjaV9idXMgKmJ1cywgc3RydWN0IGxpc3RfaGVhZCAq
cmVhbGxvY19oZWFkKQ0KIHsNCiAJc3RydWN0IHBjaV9kZXYgKmRldjsNCiAJdW5zaWduZWQgbG9u
ZyBtYXNrLCBwcmVmbWFzaywgdHlwZTIgPSAwLCB0eXBlMyA9IDA7DQotCXJlc291cmNlX3NpemVf
dCBhZGRpdGlvbmFsX21lbV9zaXplID0gMCwgYWRkaXRpb25hbF9pb19zaXplID0gMDsNCisJcmVz
b3VyY2Vfc2l6ZV90IGFkZGl0aW9uYWxfaW9fc2l6ZSA9IDAsIGFkZGl0aW9uYWxfbW1pb19zaXpl
ID0gMCwNCisJCWFkZGl0aW9uYWxfbW1pb19wcmVmX3NpemUgPSAwOw0KIAlzdHJ1Y3QgcmVzb3Vy
Y2UgKmJfcmVzOw0KIAlpbnQgcmV0Ow0KIA0KQEAgLTEyMjEsNyArMTIyMiw4IEBAIHZvaWQgX19w
Y2lfYnVzX3NpemVfYnJpZGdlcyhzdHJ1Y3QgcGNpX2J1cyAqYnVzLCBzdHJ1Y3QgbGlzdF9oZWFk
ICpyZWFsbG9jX2hlYWQpDQogCQlwY2lfYnJpZGdlX2NoZWNrX3JhbmdlcyhidXMpOw0KIAkJaWYg
KGJ1cy0+c2VsZi0+aXNfaG90cGx1Z19icmlkZ2UpIHsNCiAJCQlhZGRpdGlvbmFsX2lvX3NpemUg
ID0gcGNpX2hvdHBsdWdfaW9fc2l6ZTsNCi0JCQlhZGRpdGlvbmFsX21lbV9zaXplID0gcGNpX2hv
dHBsdWdfbWVtX3NpemU7DQorCQkJYWRkaXRpb25hbF9tbWlvX3NpemUgPSBwY2lfaG90cGx1Z19t
bWlvX3NpemU7DQorCQkJYWRkaXRpb25hbF9tbWlvX3ByZWZfc2l6ZSA9IHBjaV9ob3RwbHVnX21t
aW9fcHJlZl9zaXplOw0KIAkJfQ0KIAkJLyogRmFsbCB0aHJvdWdoICovDQogCWRlZmF1bHQ6DQpA
QCAtMTIzOSw5ICsxMjQxLDkgQEAgdm9pZCBfX3BjaV9idXNfc2l6ZV9icmlkZ2VzKHN0cnVjdCBw
Y2lfYnVzICpidXMsIHN0cnVjdCBsaXN0X2hlYWQgKnJlYWxsb2NfaGVhZCkNCiAJCWlmIChiX3Jl
c1syXS5mbGFncyAmIElPUkVTT1VSQ0VfTUVNXzY0KSB7DQogCQkJcHJlZm1hc2sgfD0gSU9SRVNP
VVJDRV9NRU1fNjQ7DQogCQkJcmV0ID0gcGJ1c19zaXplX21lbShidXMsIHByZWZtYXNrLCBwcmVm
bWFzaywNCi0JCQkJICBwcmVmbWFzaywgcHJlZm1hc2ssDQotCQkJCSAgcmVhbGxvY19oZWFkID8g
MCA6IGFkZGl0aW9uYWxfbWVtX3NpemUsDQotCQkJCSAgYWRkaXRpb25hbF9tZW1fc2l6ZSwgcmVh
bGxvY19oZWFkKTsNCisJCQkJcHJlZm1hc2ssIHByZWZtYXNrLA0KKwkJCQlyZWFsbG9jX2hlYWQg
PyAwIDogYWRkaXRpb25hbF9tbWlvX3ByZWZfc2l6ZSwNCisJCQkJYWRkaXRpb25hbF9tbWlvX3By
ZWZfc2l6ZSwgcmVhbGxvY19oZWFkKTsNCiANCiAJCQkvKg0KIAkJCSAqIElmIHN1Y2Nlc3NmdWws
IGFsbCBub24tcHJlZmV0Y2hhYmxlIHJlc291cmNlcw0KQEAgLTEyNjMsOSArMTI2NSw5IEBAIHZv
aWQgX19wY2lfYnVzX3NpemVfYnJpZGdlcyhzdHJ1Y3QgcGNpX2J1cyAqYnVzLCBzdHJ1Y3QgbGlz
dF9oZWFkICpyZWFsbG9jX2hlYWQpDQogCQlpZiAoIXR5cGUyKSB7DQogCQkJcHJlZm1hc2sgJj0g
fklPUkVTT1VSQ0VfTUVNXzY0Ow0KIAkJCXJldCA9IHBidXNfc2l6ZV9tZW0oYnVzLCBwcmVmbWFz
aywgcHJlZm1hc2ssDQotCQkJCQkgcHJlZm1hc2ssIHByZWZtYXNrLA0KLQkJCQkJIHJlYWxsb2Nf
aGVhZCA/IDAgOiBhZGRpdGlvbmFsX21lbV9zaXplLA0KLQkJCQkJIGFkZGl0aW9uYWxfbWVtX3Np
emUsIHJlYWxsb2NfaGVhZCk7DQorCQkJCXByZWZtYXNrLCBwcmVmbWFzaywNCisJCQkJcmVhbGxv
Y19oZWFkID8gMCA6IGFkZGl0aW9uYWxfbW1pb19wcmVmX3NpemUsDQorCQkJCWFkZGl0aW9uYWxf
bW1pb19wcmVmX3NpemUsIHJlYWxsb2NfaGVhZCk7DQogDQogCQkJLyoNCiAJCQkgKiBJZiBzdWNj
ZXNzZnVsLCBvbmx5IG5vbi1wcmVmZXRjaGFibGUgcmVzb3VyY2VzDQpAQCAtMTI3NCw3ICsxMjc2
LDggQEAgdm9pZCBfX3BjaV9idXNfc2l6ZV9icmlkZ2VzKHN0cnVjdCBwY2lfYnVzICpidXMsIHN0
cnVjdCBsaXN0X2hlYWQgKnJlYWxsb2NfaGVhZCkNCiAJCQlpZiAocmV0ID09IDApDQogCQkJCW1h
c2sgPSBwcmVmbWFzazsNCiAJCQllbHNlDQotCQkJCWFkZGl0aW9uYWxfbWVtX3NpemUgKz0gYWRk
aXRpb25hbF9tZW1fc2l6ZTsNCisJCQkJYWRkaXRpb25hbF9tbWlvX3NpemUgKz0NCisJCQkJCWFk
ZGl0aW9uYWxfbW1pb19wcmVmX3NpemU7DQogDQogCQkJdHlwZTIgPSB0eXBlMyA9IElPUkVTT1VS
Q0VfTUVNOw0KIAkJfQ0KQEAgLTEyOTQsOCArMTI5Nyw4IEBAIHZvaWQgX19wY2lfYnVzX3NpemVf
YnJpZGdlcyhzdHJ1Y3QgcGNpX2J1cyAqYnVzLCBzdHJ1Y3QgbGlzdF9oZWFkICpyZWFsbG9jX2hl
YWQpDQogCQkgKiBwcmVmZXRjaGFibGUgcmVzb3VyY2UgaW4gYSA2NC1iaXQgcHJlZmV0Y2hhYmxl
IHdpbmRvdy4NCiAJCSAqLw0KIAkJcGJ1c19zaXplX21lbShidXMsIG1hc2ssIElPUkVTT1VSQ0Vf
TUVNLCB0eXBlMiwgdHlwZTMsDQotCQkJCXJlYWxsb2NfaGVhZCA/IDAgOiBhZGRpdGlvbmFsX21l
bV9zaXplLA0KLQkJCQlhZGRpdGlvbmFsX21lbV9zaXplLCByZWFsbG9jX2hlYWQpOw0KKwkJCXJl
YWxsb2NfaGVhZCA/IDAgOiBhZGRpdGlvbmFsX21taW9fc2l6ZSwNCisJCQlhZGRpdGlvbmFsX21t
aW9fc2l6ZSwgcmVhbGxvY19oZWFkKTsNCiAJCWJyZWFrOw0KIAl9DQogfQ0KZGlmZiAtLWdpdCBh
L2luY2x1ZGUvbGludXgvcGNpLmggYi9pbmNsdWRlL2xpbnV4L3BjaS5oDQppbmRleCA0YTVhODRk
N2IuLjcwMTVmMGIwZiAxMDA2NDQNCi0tLSBhL2luY2x1ZGUvbGludXgvcGNpLmgNCisrKyBiL2lu
Y2x1ZGUvbGludXgvcGNpLmgNCkBAIC0xOTcyLDcgKzE5NzIsOCBAQCBleHRlcm4gdTggcGNpX2Rm
bF9jYWNoZV9saW5lX3NpemU7DQogZXh0ZXJuIHU4IHBjaV9jYWNoZV9saW5lX3NpemU7DQogDQog
ZXh0ZXJuIHVuc2lnbmVkIGxvbmcgcGNpX2hvdHBsdWdfaW9fc2l6ZTsNCi1leHRlcm4gdW5zaWdu
ZWQgbG9uZyBwY2lfaG90cGx1Z19tZW1fc2l6ZTsNCitleHRlcm4gdW5zaWduZWQgbG9uZyBwY2lf
aG90cGx1Z19tbWlvX3NpemU7DQorZXh0ZXJuIHVuc2lnbmVkIGxvbmcgcGNpX2hvdHBsdWdfbW1p
b19wcmVmX3NpemU7DQogZXh0ZXJuIHVuc2lnbmVkIGxvbmcgcGNpX2hvdHBsdWdfYnVzX3NpemU7
DQogDQogLyogQXJjaGl0ZWN0dXJlLXNwZWNpZmljIHZlcnNpb25zIG1heSBvdmVycmlkZSB0aGVz
ZSAod2VhaykgKi8NCi0tIA0KMi4yMC4xDQoNCg==
