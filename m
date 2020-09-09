Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1FF14262821
	for <lists+linux-pci@lfdr.de>; Wed,  9 Sep 2020 09:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729691AbgIIHKs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Sep 2020 03:10:48 -0400
Received: from rtits2.realtek.com ([211.75.126.72]:48150 "EHLO
        rtits2.realtek.com.tw" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729305AbgIIHKl (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Sep 2020 03:10:41 -0400
Authenticated-By: 
X-SpamFilter-By: ArmorX SpamTrap 5.69 with qID 0897AKaD4024324, This message is accepted by code: ctloc85258
Received: from mail.realtek.com (rtexmb05.realtek.com.tw[172.21.6.98])
        by rtits2.realtek.com.tw (8.15.2/2.66/5.86) with ESMTPS id 0897AKaD4024324
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Wed, 9 Sep 2020 15:10:20 +0800
Received: from RTEXDAG02.realtek.com.tw (172.21.6.101) by
 RTEXMB05.realtek.com.tw (172.21.6.98) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1779.2; Wed, 9 Sep 2020 15:10:20 +0800
Received: from RTEXMB01.realtek.com.tw (172.21.6.94) by
 RTEXDAG02.realtek.com.tw (172.21.6.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2044.4; Wed, 9 Sep 2020 15:10:19 +0800
Received: from RTEXMB01.realtek.com.tw ([fe80::3d72:efbe:f42a:2926]) by
 RTEXMB01.realtek.com.tw ([fe80::3d72:efbe:f42a:2926%13]) with mapi id
 15.01.2044.004; Wed, 9 Sep 2020 15:10:19 +0800
From:   =?big5?B?p2Sp/rzhIFJpY2t5?= <ricky_wu@realtek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "ulf.hansson@linaro.org" <ulf.hansson@linaro.org>,
        "rui_feng@realsil.com.cn" <rui_feng@realsil.com.cn>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "puranjay12@gmail.com" <puranjay12@gmail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "vailbhavgupta40@gamail.com" <vailbhavgupta40@gamail.com>
Subject: RE: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix driving parameter
Thread-Topic: [PATCH v5 2/2] misc: rtsx: Add power saving functions and fix
 driving parameter
Thread-Index: AQHWhP62uKuuQJQ5k0+R6Z2U1e37UKlezqwAgAES/lA=
Date:   Wed, 9 Sep 2020 07:10:19 +0000
Message-ID: <a5abd0d6029646ff8faae61cc4a4dd55@realtek.com>
References: <20200907100731.7722-1-ricky_wu@realtek.com>
 <20200908222834.GA646416@bjorn-Precision-5520>
In-Reply-To: <20200908222834.GA646416@bjorn-Precision-5520>
Accept-Language: zh-TW, en-US
Content-Language: zh-TW
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [172.22.88.99]
Content-Type: text/plain; charset="big5"
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

PiAtLS0tLU9yaWdpbmFsIE1lc3NhZ2UtLS0tLQ0KPiBGcm9tOiBCam9ybiBIZWxnYWFzIFttYWls
dG86aGVsZ2Fhc0BrZXJuZWwub3JnXQ0KPiBTZW50OiBXZWRuZXNkYXksIFNlcHRlbWJlciAwOSwg
MjAyMCA2OjI5IEFNDQo+IFRvOiCnZKn+vOEgUmlja3kNCj4gQ2M6IGFybmRAYXJuZGIuZGU7IGdy
ZWdraEBsaW51eGZvdW5kYXRpb24ub3JnOyBiaGVsZ2Fhc0Bnb29nbGUuY29tOw0KPiB1bGYuaGFu
c3NvbkBsaW5hcm8ub3JnOyBydWlfZmVuZ0ByZWFsc2lsLmNvbS5jbjsgbGludXgta2VybmVsQHZn
ZXIua2VybmVsLm9yZzsNCj4gcHVyYW5qYXkxMkBnbWFpbC5jb207IGxpbnV4LXBjaUB2Z2VyLmtl
cm5lbC5vcmc7DQo+IHZhaWxiaGF2Z3VwdGE0MEBnYW1haWwuY29tDQo+IFN1YmplY3Q6IFJlOiBb
UEFUQ0ggdjUgMi8yXSBtaXNjOiBydHN4OiBBZGQgcG93ZXIgc2F2aW5nIGZ1bmN0aW9ucyBhbmQg
Zml4IGRyaXZpbmcNCj4gcGFyYW1ldGVyDQo+IA0KPiBPbiBNb24sIFNlcCAwNywgMjAyMCBhdCAw
NjowNzozMVBNICswODAwLCByaWNreV93dUByZWFsdGVrLmNvbSB3cm90ZToNCj4gPiBGcm9tOiBS
aWNreSBXdSA8cmlja3lfd3VAcmVhbHRlay5jb20+DQo+ID4NCj4gPiB2NDoNCj4gPiBzcGxpdCBw
b3dlciBkb3duIGZsb3cgYW5kIHBvd2VyIHNhdmluZyBmdW5jdGlvbiB0byB0d28gcGF0Y2gNCj4g
Pg0KPiA+IHY1Og0KPiA+IGZpeCB1cCBtb2RpZmllZCBjaGFuZ2UgdW5kZXIgdGhlIC0tLSBsaW5l
DQo+IA0KPiBIZWhlLCB0aGlzIGNhbWUgb3V0ICphYm92ZSogdGhlICItLS0iIGxpbmUgOikNCj4g
DQo+ID4gQWRkIHJ0czUyMmEgTDEgc3ViLXN0YXRlIHN1cHBvcnQNCj4gPiBTYXZlIG1vcmUgcG93
ZXIgb24gcnRzNTIyNyBydHM1MjQ5IHJ0czUyNWEgcnRzNTI2MA0KPiA+IEZpeCBydHM1MjYwIGRy
aXZpbmcgcGFyYW1ldGVyDQo+ID4NCj4gPiBTaWduZWQtb2ZmLWJ5OiBSaWNreSBXdSA8cmlja3lf
d3VAcmVhbHRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0
czUyMjcuYyAgfCAxMTIgKysrKysrKysrKysrKysrKysrKysrLQ0KPiA+ICBkcml2ZXJzL21pc2Mv
Y2FyZHJlYWRlci9ydHM1MjQ5LmMgIHwgMTQ1DQo+ICsrKysrKysrKysrKysrKysrKysrKysrKysr
KystDQo+ID4gIGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0czUyNjAuYyAgfCAgMjggKysrLS0t
DQo+ID4gIGRyaXZlcnMvbWlzYy9jYXJkcmVhZGVyL3J0c3hfcGNyLmggfCAgMTcgKysrKw0KPiA+
ICA0IGZpbGVzIGNoYW5nZWQsIDI4MyBpbnNlcnRpb25zKCspLCAxOSBkZWxldGlvbnMoLSkNCj4g
Pg0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjI3LmMNCj4g
Yi9kcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjI3LmMNCj4gPiBpbmRleCA3NDczOTFlM2Zi
NWQuLjg4NTkwMTE2NzJjYiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL21pc2MvY2FyZHJlYWRl
ci9ydHM1MjI3LmMNCj4gPiArKysgYi9kcml2ZXJzL21pc2MvY2FyZHJlYWRlci9ydHM1MjI3LmMN
Cj4gPiBAQCAtNzIsMTUgKzcyLDgwIEBAIHN0YXRpYyB2b2lkIHJ0czUyMjdfZmV0Y2hfdmVuZG9y
X3NldHRpbmdzKHN0cnVjdA0KPiBydHN4X3BjciAqcGNyKQ0KPiA+DQo+ID4gIAlwY2lfcmVhZF9j
b25maWdfZHdvcmQocGRldiwgUENSX1NFVFRJTkdfUkVHMiwgJnJlZyk7DQo+ID4gIAlwY3JfZGJn
KHBjciwgIkNmZyAweCV4OiAweCV4XG4iLCBQQ1JfU0VUVElOR19SRUcyLCByZWcpOw0KPiA+ICsJ
aWYgKHJ0c3hfY2hlY2tfbW1jX3N1cHBvcnQocmVnKSkNCj4gPiArCQlwY3ItPmV4dHJhX2NhcHMg
fD0gRVhUUkFfQ0FQU19OT19NTUM7DQo+ID4gIAlwY3ItPnNkMzBfZHJpdmVfc2VsXzN2MyA9IHJ0
c3hfcmVnX3RvX3NkMzBfZHJpdmVfc2VsXzN2MyhyZWcpOw0KPiA+ICAJaWYgKHJ0c3hfcmVnX2No
ZWNrX3JldmVyc2Vfc29ja2V0KHJlZykpDQo+ID4gIAkJcGNyLT5mbGFncyB8PSBQQ1JfUkVWRVJT
RV9TT0NLRVQ7DQo+ID4gIH0NCj4gPg0KPiA+ICtzdGF0aWMgdm9pZCBydHM1MjI3X2luaXRfZnJv
bV9jZmcoc3RydWN0IHJ0c3hfcGNyICpwY3IpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBwY2lfZGV2
ICpwZGV2ID0gcGNyLT5wY2k7DQo+ID4gKwlpbnQgbDFzczsNCj4gPiArCXUzMiBsdmFsOw0KPiA+
ICsJc3RydWN0IHJ0c3hfY3Jfb3B0aW9uICpvcHRpb24gPSAmcGNyLT5vcHRpb247DQo+ID4gKw0K
PiA+ICsJbDFzcyA9IHBjaV9maW5kX2V4dF9jYXBhYmlsaXR5KHBkZXYsIFBDSV9FWFRfQ0FQX0lE
X0wxU1MpOw0KPiA+ICsJaWYgKCFsMXNzKQ0KPiA+ICsJCXJldHVybjsNCj4gPiArDQo+ID4gKwlw
Y2lfcmVhZF9jb25maWdfZHdvcmQocGRldiwgbDFzcyArIFBDSV9MMVNTX0NUTDEsICZsdmFsKTsN
Cj4gDQo+IFRoaXMgbG9va3MgYSBsaXR0bGUgcHJvYmxlbWF0aWMuICBQQ0lfTDFTU19DVEwxIGlz
IGFuIGFyY2hpdGVjdGVkDQo+IHJlZ2lzdGVyIGluIHRoZSBBU1BNIEwxIFBNIFN1YnN0YXRlcyBj
YXBhYmlsaXR5LCBhbmQgaXRzIHZhbHVlIG1heQ0KPiBjaGFuZ2UgYXQgcnVudGltZSBiZWNhdXNl
IGRyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIG1hbmFnZXMgaXQuDQo+IA0KPiBJdCBsb29rcyBsaWtl
IHRoZSBjb2RlIGJlbG93IGRvZXMgZGV2aWNlLXNwZWNpZmljIGNvbmZpZ3VyYXRpb24gYmFzZWQN
Cj4gb24gdGhlIGN1cnJlbnQgUENJX0wxU1NfQ1RMMSB2YWx1ZS4gIEJ1dCB3aGF0IGhhcHBlbnMg
aWYgYXNwbS5jDQo+IGNoYW5nZXMgUENJX0wxU1NfQ1RMMSBsYXRlcj8NCj4gDQoNCldlIGFyZSBn
b2luZyB0byBtYWtlIHN1cmUgYW5kIHNldCB0aGUgYmVzdCBjb25maWd1cmF0aW9uIG9uIHRoZSBj
dXJyZW50IHRpbWUsIA0KaWYgaG9zdCBjaGFuZ2UgdGhlIGNhcGFiaWxpdHkgbGF0ZXIsIGl0IGRv
ZXNuJ3QgYWZmZWN0IGZ1bmN0aW9uLCBvbmx5IGFmZmVjdCBhIGxpdHRsZSBwb3dlciBzYXZpbmcg
ICANCg0KPiA+ICsJaWYgKENIS19QQ0lfUElEKHBjciwgMHg1MjJBKSkgew0KPiA+ICsJCWlmICgw
ID09IChsdmFsICYgMHgwRikpDQo+ID4gKwkJCXJ0c3hfcGNpX2VuYWJsZV9vb2JzX3BvbGxpbmco
cGNyKTsNCj4gPiArCQllbHNlDQo+ID4gKwkJCXJ0c3hfcGNpX2Rpc2FibGVfb29ic19wb2xsaW5n
KHBjcik7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKGx2YWwgJiBQQ0lfTDFTU19DVEwxX0FT
UE1fTDFfMSkNCj4gPiArCQlydHN4X3NldF9kZXZfZmxhZyhwY3IsIEFTUE1fTDFfMV9FTik7DQo+
ID4gKwllbHNlDQo+ID4gKwkJcnRzeF9jbGVhcl9kZXZfZmxhZyhwY3IsIEFTUE1fTDFfMV9FTik7
DQo+ID4gKw0KPiA+ICsJaWYgKGx2YWwgJiBQQ0lfTDFTU19DVEwxX0FTUE1fTDFfMikNCj4gPiAr
CQlydHN4X3NldF9kZXZfZmxhZyhwY3IsIEFTUE1fTDFfMl9FTik7DQo+ID4gKwllbHNlDQo+ID4g
KwkJcnRzeF9jbGVhcl9kZXZfZmxhZyhwY3IsIEFTUE1fTDFfMl9FTik7DQo+ID4gKw0KPiA+ICsJ
aWYgKGx2YWwgJiBQQ0lfTDFTU19DVEwxX1BDSVBNX0wxXzEpDQo+ID4gKwkJcnRzeF9zZXRfZGV2
X2ZsYWcocGNyLCBQTV9MMV8xX0VOKTsNCj4gPiArCWVsc2UNCj4gPiArCQlydHN4X2NsZWFyX2Rl
dl9mbGFnKHBjciwgUE1fTDFfMV9FTik7DQo+ID4gKw0KPiA+ICsJaWYgKGx2YWwgJiBQQ0lfTDFT
U19DVEwxX1BDSVBNX0wxXzIpDQo+ID4gKwkJcnRzeF9zZXRfZGV2X2ZsYWcocGNyLCBQTV9MMV8y
X0VOKTsNCj4gPiArCWVsc2UNCj4gPiArCQlydHN4X2NsZWFyX2Rldl9mbGFnKHBjciwgUE1fTDFf
Ml9FTik7DQo+ID4gKw0KPiA+ICsJaWYgKG9wdGlvbi0+bHRyX2VuKSB7DQo+ID4gKwkJdTE2IHZh
bDsNCj4gPiArDQo+ID4gKwkJcGNpZV9jYXBhYmlsaXR5X3JlYWRfd29yZChwY3ItPnBjaSwgUENJ
X0VYUF9ERVZDVEwyLCAmdmFsKTsNCj4gDQo+IFNhbWUgdGhpbmcgaGVyZS4gIEkgZG9uJ3QgdGhp
bmsgdGhlIFBDSSBjb3JlIGN1cnJlbnRseSBjaGFuZ2VzDQo+IFBDSV9FWFBfREVWQ1RMMiBhZnRl
ciBib290LCBidXQgaXQncyBub3QgYSBnb29kIGlkZWEgdG8gYXNzdW1lIGl0J3MNCj4gZ29pbmcg
dG8gYmUgY29uc3RhbnQuDQo+IA0KDQpUaGUgc2FtZSByZXBseQ0KDQo+ID4gKwkJaWYgKHZhbCAm
IFBDSV9FWFBfREVWQ1RMMl9MVFJfRU4pIHsNCj4gPiArCQkJb3B0aW9uLT5sdHJfZW5hYmxlZCA9
IHRydWU7DQo+ID4gKwkJCW9wdGlvbi0+bHRyX2FjdGl2ZSA9IHRydWU7DQo+ID4gKwkJCXJ0c3hf
c2V0X2x0cl9sYXRlbmN5KHBjciwgb3B0aW9uLT5sdHJfYWN0aXZlX2xhdGVuY3kpOw0KPiA+ICsJ
CX0gZWxzZSB7DQo+ID4gKwkJCW9wdGlvbi0+bHRyX2VuYWJsZWQgPSBmYWxzZTsNCj4gPiArCQl9
DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJaWYgKHJ0c3hfY2hlY2tfZGV2X2ZsYWcocGNyLCBBU1BN
X0wxXzFfRU4gfCBBU1BNX0wxXzJfRU4NCj4gPiArCQkJCXwgUE1fTDFfMV9FTiB8IFBNX0wxXzJf
RU4pKQ0KPiA+ICsJCW9wdGlvbi0+Zm9yY2VfY2xrcmVxXzAgPSBmYWxzZTsNCj4gPiArCWVsc2UN
Cj4gPiArCQlvcHRpb24tPmZvcmNlX2Nsa3JlcV8wID0gdHJ1ZTsNCj4gPiArDQo+ID4gK30NCj4g
DQo+IC0tLS0tLVBsZWFzZSBjb25zaWRlciB0aGUgZW52aXJvbm1lbnQgYmVmb3JlIHByaW50aW5n
IHRoaXMgZS1tYWlsLg0K
