Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C085221429C
	for <lists+linux-pci@lfdr.de>; Sat,  4 Jul 2020 03:45:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726484AbgGDBpQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 3 Jul 2020 21:45:16 -0400
Received: from mga04.intel.com ([192.55.52.120]:62052 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726469AbgGDBpQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 3 Jul 2020 21:45:16 -0400
IronPort-SDR: Jk5AaNYK7w8GQ/scfRd/m1C5QKmKhzb7qCNm/lnuFbum1w/M0+L9JZSezGvrG8ZDK4wr4SoOZa
 i9iK916RLtng==
X-IronPort-AV: E=McAfee;i="6000,8403,9671"; a="144731807"
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="scan'208";a="144731807"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Jul 2020 18:45:00 -0700
IronPort-SDR: A5iMvIiTmP0FG82eYS/NVc4RsyQXwhEYQIFE0oBujpMS+sGJMMmvYMx2KUEiMKeU9CtM86Whns
 ub+zFtV7SLsg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,309,1589266800"; 
   d="scan'208";a="456052921"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga005.jf.intel.com with ESMTP; 03 Jul 2020 18:45:00 -0700
Received: from orsmsx157.amr.corp.intel.com (10.22.240.23) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Fri, 3 Jul 2020 18:44:59 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.209]) by
 ORSMSX157.amr.corp.intel.com ([169.254.9.81]) with mapi id 14.03.0439.000;
 Fri, 3 Jul 2020 18:44:59 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "andriy.shevchenko@linux.intel.com" 
        <andriy.shevchenko@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "Kalakota, SushmaX" <sushmax.kalakota@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Thread-Topic: [PATCH] PCI: vmd: Keep fwnode allocated through VMD irqdomain
 life
Thread-Index: AQHWSw+RDEde7kWBZ0WSf8C7+Aw2bqjqNSwAgAaBuYCAAKzvAIAAc8gAgAVQzwA=
Date:   Sat, 4 Jul 2020 01:44:59 +0000
Message-ID: <225256cc0ef63a3e149bcac97999d06381c52830.camel@intel.com>
References: <20200630163332.GA3437879@bjorn-Precision-5520>
In-Reply-To: <20200630163332.GA3437879@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.209.66.51]
Content-Type: text/plain; charset="utf-8"
Content-ID: <E595C0834969F540B48B6ECCD80F4362@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTA2LTMwIGF0IDExOjMzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUdWUsIEp1biAzMCwgMjAyMCBhdCAxMjozOTowOFBNICswMzAwLCBBbmR5IFNoZXZjaGVu
a28gd3JvdGU6DQo+ID4gT24gTW9uLCBKdW4gMjksIDIwMjAgYXQgMDY6MjA6MTFQTSAtMDUwMCwg
Qmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gPiA+IE9uIFRodSwgSnVuIDI1LCAyMDIwIGF0IDAyOjU4
OjIzUE0gLTA1MDAsIEJqb3JuIEhlbGdhYXMgd3JvdGU6DQo+ID4gPiA+IFsrY2MgVGhvbWFzXQ0K
PiA+ID4gPiANCj4gPiA+ID4gT24gVGh1LCBKdW4gMjUsIDIwMjAgYXQgMTI6MjQ6NDlQTSAtMDQw
MCwgSm9uIERlcnJpY2sgd3JvdGU6DQo+ID4gPiA+ID4gRnJvbTogQW5keSBTaGV2Y2hlbmtvIDxh
bmRyaXkuc2hldmNoZW5rb0BsaW51eC5pbnRlbC5jb20+DQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4g
VGhlIFZNRCBkb21haW4gZG9lcyBub3Qgc3Vic2NyaWJlIHRvIEFDUEksIGFuZCBzbyBkb2VzIG5v
dCBvcGVyYXRlIG9uDQo+ID4gPiA+ID4gaXQncyBpcnFkb21haW4gZndub2RlLiBJdCB3YXMgZnJl
ZWluZyB0aGUgaGFuZGxlIGFmdGVyIGFsbG9jYXRpb24gb2YgdGhlDQo+ID4gPiA+ID4gZG9tYWlu
LiBBcyBvZiAxODFlOWQ0ZWZhZjZhIChpcnFkb21haW46IE1ha2UgX19pcnFfZG9tYWluX2FkZCgp
IGxlc3MNCj4gPiA+ID4gPiBPRi1kZXBlbmRlbnQpLCB0aGUgZndub2RlIGlzIHB1dCBkdXJpbmcg
aXJxX2RvbWFpbl9yZW1vdmUgY2F1c2luZyBhIHBhZ2UNCj4gPiA+ID4gPiBmYXVsdC4gVGhpcyBw
YXRjaCBrZWVwcyBWTUQncyBmd25vZGUgYWxsb2NhdGVkIHRocm91Z2ggdGhlIGxpZmV0aW1lIG9m
DQo+ID4gPiA+ID4gdGhlIFZNRCBpcnFkb21haW4uDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gRml4
ZXM6IGFlOTA0Y2FmZDU5ZCAoIlBDSS92bWQ6IENyZWF0ZSBuYW1lZCBpcnEgZG9tYWluIikNCj4g
PiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBBbmR5IFNoZXZjaGVua28gPGFuZHJpeS5zaGV2Y2hlbmtv
QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gPiBDby1kZXZlbG9wZWQtYnk6IEFuZHkgU2hldmNo
ZW5rbyA8YW5kcml5LnNoZXZjaGVua29AbGludXguaW50ZWwuY29tPg0KPiA+ID4gPiA+IFNpZ25l
ZC1vZmYtYnk6IEpvbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gPiA+
ID4gPiAtLS0NCj4gPiA+ID4gPiBIaSBMb3JlbnpvLCBCam9ybiwNCj4gPiA+ID4gPiANCj4gPiA+
ID4gPiBQbGVhc2UgdGFrZSB0aGlzIHBhdGNoIGZvciB2NS44IGZpeGVzLiBJdCBmaXhlcyBhbiBp
c3N1ZSBkdXJpbmcgVk1EDQo+ID4gPiA+ID4gdW5sb2FkLg0KPiA+ID4gPiANCj4gPiA+ID4gSSB0
ZW50YXRpdmVseSBhcHBsaWVkIHRoaXMgdG8gZm9yLWxpbnVzIGZvciB2NS44Lg0KPiA+ID4gPiAN
Cj4gPiA+ID4gQnV0IEkgd291bGQgbGlrZSB0byBjbGFyaWZ5IHRoZSBjb21taXQgbG9nLiAgSXQg
c2F5cyB0aGlzIGZpeGVzDQo+ID4gPiA+IFRob21hcycgYWU5MDRjYWZkNTlkICgiUENJL3ZtZDog
Q3JlYXRlIG5hbWVkIGlycSBkb21haW4iKS4gIFRoYXQNCj4gPiA+ID4gYXBwZWFyZWQgaW4gdjQu
MTMsIHdoaWNoIHN1Z2dlc3RzIHRoYXQgdGhpcyBwYXRjaCBzaG91bGQgYmUgYmFja3BvcnRlZA0K
PiA+ID4gPiB0byB2NC4xMyBhbmQgbGF0ZXIuDQo+ID4gPiANCj4gPiA+IEkgZGlkbid0IHdvcmQg
dGhpcyBjb3JyZWN0bHkuICBXaGF0IEkgbWVhbnQgd2FzICJJIHdpbGwgY29uc2lkZXINCj4gPiA+
IGFwcGx5aW5nIHRoaXMgYWZ0ZXIgdGhlIGNvbW1pdCBsb2cgaXMgY2xhcmlmaWVkLiIgIEp1c3Qg
RllJIHRoYXQgdGhpcw0KPiA+ID4gaXNuJ3QgcmVzb2x2ZWQgeWV0Lg0KPiA+ID4gDQo+ID4gPiBT
aW5jZSB0aGlzIGlzIHByb3Bvc2VkIGZvciB2NS44LCBJIHJlYWxseSB3YW50IHRvIHVuZGVyc3Rh
bmQgdGhpcw0KPiA+ID4gYmV0dGVyIGJlZm9yZSBhc2tpbmcgTGludXMgdG8gcHVsbCBpdCBhcyBh
IGZpeC4NCj4gPiANCj4gPiBUaGUgcHJvYmxlbSBoZXJlIGlzIGluIHRoZSBvcmlnaW5hbCBwYXRj
aCB3aGljaCByZWxpZXMgb24gdGhlDQo+ID4ga25vd2xlZGdlIHRoYXQgZndub2RlIGlzICh3YXMp
IG5vdCB1c2VkIGFueWhvdyBzcGVjaWZpY2FsbHkgZm9yIEFDUEkNCj4gPiBjYXNlLiBUaGF0IHNh
aWQsIGl0IG1ha2VzIGZ3bm9kZSBhIGRhbmdsaW5nIHBvaW50ZXIgd2hpY2ggSQ0KPiA+IHBlcnNv
bmFsbHkgY29uc2lkZXIgYXMgYSBtaW5lIGxlZnQgZm9yIG90aGVycy4gVGhhdCdzIHdoeSB0aGUg
Rml4ZXMNCj4gPiByZWZlcnMgdG8gdGhlIGluaXRpYWwgY29tbWl0LiBUaGUgbGF0dGVyIGp1c3Qg
aGFzIGJlZW4gYmxhc3RlZCBvbg0KPiA+IHRoYXQgbWluZS4NCj4gDQo+IElJVUMsIHlvdSdyZSBz
YXlpbmcgdGhpcyBwYXR0ZXJuOg0KPiANCj4gICBmd25vZGUgPSBpcnFfZG9tYWluX2FsbG9jX25h
bWVkX2lkX2Z3bm9kZSguLi4pDQo+ICAgaXJxX2RvbWFpbiA9IHBjaV9tc2lfY3JlYXRlX2lycV9k
b21haW4oZndub2RlLCAuLi4pDQo+ICAgaXJxX2RvbWFpbl9mcmVlX2Z3bm9kZShmd25vZGUpDQo+
IA0KPiBsZWF2ZXMgYSBkYW5nbGluZyBmd25vZGUgcG9pbnRlci4gIFRoYXQgZG9lcyBsb29rIHN1
c3BpY2lvdXMgYmVjYXVzZQ0KPiBfX2lycV9kb21haW5fYWRkKCkgc2F2ZXMgZndub2RlOg0KPiAN
Cj4gICBpcnFfZG9tYWluID0gcGNpX21zaV9jcmVhdGVfaXJxX2RvbWFpbihmd25vZGUsIC4uLikN
Cj4gICAgIG1zaV9jcmVhdGVfaXJxX2RvbWFpbihmd25vZGUsIC4uLikNCj4gICAgICAgaXJxX2Rv
bWFpbl9jcmVhdGVfaGllcmFyY2h5KC4uLiwgZndub2RlLCAuLi4pDQo+IAlpcnFfZG9tYWluX2Ny
ZWF0ZV9saW5lYXIoZndub2RlLCAuLi4pDQo+IAkgIF9faXJxX2RvbWFpbl9hZGQoZndub2RlLCAu
Li4pDQo+IAkgICAgZG9tYWluLT5md25vZGUgPSBmd25vZGUNCj4gDQo+IGFuZCBpcnFfZG9tYWlu
X2ZyZWVfZndub2RlKCkgZnJlZXMgaXQuICBCdXQgSSdtIGNvbmZ1c2VkIGJlY2F1c2UgdGhlcmUN
Cj4gYXJlIHNldmVyYWwgb3RoZXIgaW5zdGFuY2VzIG9mIHRoaXMgcGF0dGVybjoNCj4gDQo+ICAg
YnJpZGdlX3Byb2JlKCkgICAgICAgICAgICAgICAgICAgICAgIyBhcmNoL21pcHMvcGNpL3BjaS14
dGFsay1icmlkZ2UuYw0KPiAgIG1wX2lycWRvbWFpbl9jcmVhdGUoKQ0KPiAgIGFyY2hfaW5pdF9t
c2lfZG9tYWluKCkNCj4gICBhcmNoX2NyZWF0ZV9yZW1hcF9tc2lfaXJxX2RvbWFpbigpDQo+ICAg
ZG1hcl9nZXRfaXJxX2RvbWFpbigpDQo+ICAgaHBldF9jcmVhdGVfaXJxX2RvbWFpbigpDQo+ICAg
Li4uDQo+IA0KPiBBcmUgdGhleSBhbGwgd3Jvbmc/ICBJIGRlZmluaXRlbHkgdGhpbmsgaXQncyBh
IGJhZCBpZGVhIHRvIGtlZXAgYSBjb3B5DQo+IG9mIGEgcG9pbnRlciBhZnRlciB3ZSBmcmVlIHRo
ZSBkYXRhIGl0IHBvaW50cyB0by4gIEJ1dCBpZiB0aGV5J3JlIGFsbA0KPiB3cm9uZywgSSBkb24n
dCB3YW50IHRvIGZpeCBqdXN0IG9uZSBhbmQgbGVhdmUgYWxsIHRoZSBvdGhlcnMuDQo+IA0KPiBU
aG9tYXMsIGNhbiB5b3UgZW5saWdodGVuIHVzPw0KPiANCg0KSSBzZWUgdGhhdCBzdHJ1Y3QgaXJx
Y2hpcF9md2lkIGNvbnRhaW5zIHRoZSBhY3R1YWwgZndub2RlIHN0cnVjdHVyZSBhbmQNCndoZW4g
dGhhdCBpcyBmcmVlZCwgaXQncyBjYXVzZXMgdGhlIGlzc3VlLg0KDQpJJ20gbm90aWNpbmcgaW4g
ZWFjaCBjYWxsZXIgb2YgaXJxX2RvbWFpbl9mcmVlX2Z3bm9kZSwgd2UgaGF2ZSB0aGUNCmRvbWFp
biBpdHNlbGYgYXZhaWxhYmxlLiBJdCBzZWVtcyBsaWtlIGl0IHNob3VsZCBiZSB1cCB0byB0aGUg
Y2FsbGVyIHRvDQpkZWFsIHdpdGggdGhlIGZ3bm9kZSBwb2ludGVyLCBidXQgd2UgY291bGQganVz
dCBkbzoNCg0KZGlmZiAtLWdpdCBhL2tlcm5lbC9pcnEvaXJxZG9tYWluLmMgYi9rZXJuZWwvaXJx
L2lycWRvbWFpbi5jDQppbmRleCBhNGMyYzkxNTUxMWQuLjYxZjAwNzAyODVmZiAxMDA2NDQNCi0t
LSBhL2tlcm5lbC9pcnEvaXJxZG9tYWluLmMNCisrKyBiL2tlcm5lbC9pcnEvaXJxZG9tYWluLmMN
CkBAIC0xMDEsNyArMTAxLDcgQEAgRVhQT1JUX1NZTUJPTF9HUEwoX19pcnFfZG9tYWluX2FsbG9j
X2Z3bm9kZSk7DQogICoNCiAgKiBGcmVlIGEgZndub2RlX2hhbmRsZSBhbGxvY2F0ZWQgd2l0aCBp
cnFfZG9tYWluX2FsbG9jX2Z3bm9kZS4NCiAgKi8NCi12b2lkIGlycV9kb21haW5fZnJlZV9md25v
ZGUoc3RydWN0IGZ3bm9kZV9oYW5kbGUgKmZ3bm9kZSkNCit2b2lkIGlycV9kb21haW5fZnJlZV9m
d25vZGUoc3RydWN0IGlycV9kb21haW4gKmRvbWFpbiwgc3RydWN0DQpmd25vZGVfaGFuZGxlICpm
d25vZGUpDQogew0KICAgICAgICBzdHJ1Y3QgaXJxY2hpcF9md2lkICpmd2lkOw0KIA0KQEAgLTEw
OSw2ICsxMDksNyBAQCB2b2lkIGlycV9kb21haW5fZnJlZV9md25vZGUoc3RydWN0IGZ3bm9kZV9o
YW5kbGUNCipmd25vZGUpDQogICAgICAgICAgICAgICAgcmV0dXJuOw0KIA0KICAgICAgICBmd2lk
ID0gY29udGFpbmVyX29mKGZ3bm9kZSwgc3RydWN0IGlycWNoaXBfZndpZCwgZndub2RlKTsNCisg
ICAgICAgZG9tYWluLT5md25vZGUgPSBOVUxMOw0KICAgICAgICBrZnJlZShmd2lkLT5uYW1lKTsN
CiAgICAgICAga2ZyZWUoZndpZCk7DQogfQ0KDQoNCg0KPiA+IElmIHlvdSB0aGluayB0aGF0J3Mg
ZmluZSB0byBoYXZlIHN1Y2ggdHJpY2ssIGZlZWwgZnJlZSB0byB1cGRhdGUgRml4ZXMgdGFnLg0K
PiA+IA0KPiA+ID4gPiBCdXQgaXQncyBub3QgY2xlYXIgdG8gbWUgdGhhdCBhZTkwNGNhZmQ1OWQg
aXMgYWN0dWFsbHkgYnJva2VuLCBzaW5jZQ0KPiA+ID4gPiB0aGUgbG9nIGFsc28gc2F5cyB0aGUg
cHJvYmxlbSBhcHBlYXJlZCBhZnRlciAxODFlOWQ0ZWZhZjYgKCJpcnFkb21haW46DQo+ID4gPiA+
IE1ha2UgX19pcnFfZG9tYWluX2FkZCgpIGxlc3MgT0YtZGVwZW5kZW50IiksIHdoaWNoIHdlIGp1
c3QgbWVyZ2VkIGZvcg0KPiA+ID4gPiB2NS44LXJjMS4NCj4gPiA+ID4gDQo+ID4gPiA+IEFuZCBv
YnZpb3VzbHksIGZyZWVpbmcgdGhlIGZ3bm9kZSBkb2Vzbid0ICpjYXVzZSogYSBwYWdlIGZhdWx0
LiAgQQ0KPiA+ID4gPiB1c2UtYWZ0ZXItZnJlZSBtaWdodCBjYXVzZSBhIGZhdWx0LCBidXQgaXQn
cyBub3QgY2xlYXIgd2hlcmUgdGhhdA0KPiA+ID4gPiBoYXBwZW5zLiAgSSBndWVzcyBmd25vZGUg
aXMgdXNlZCBpbiB0aGUgaW50ZXJ2YWwgYmV0d2VlbjoNCj4gPiA+ID4gDQo+ID4gPiA+ICAgdm1k
X2VuYWJsZV9kb21haW4NCj4gPiA+ID4gICAgIHBjaV9tc2lfY3JlYXRlX2lycV9kb21haW4NCj4g
PiA+ID4gDQo+ID4gPiA+ICAgLi4uICAgICAgICA8LS0gZndub2RlIHVzZWQgaGVyZSBzb21ld2hl
cmUNCj4gPiA+ID4gDQo+ID4gPiA+ICAgdm1kX3JlbW92ZQ0KPiA+ID4gPiAgICAgdm1kX2NsZWFu
dXBfc3JjdQ0KPiA+ID4gPiAgICAgICBpcnFfZG9tYWluX2ZyZWVfZndub2RlDQo+ID4gPiA+IA0K
PiA+ID4gPiBCdXQgSSBjYW4ndCB0ZWxsIGhvdyAxODFlOWQ0ZWZhZjZhIGFuZC9vciBhZTkwNGNh
ZmQ1OWQgYXJlIHJlbGF0ZWQgdG8NCj4gPiA+ID4gdGhhdC4NCj4gPiA+ID4gDQo+ID4gPiA+ID4g
IGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCA4ICsrKysrKy0tDQo+ID4gPiA+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCA2IGluc2VydGlvbnMoKyksIDIgZGVsZXRpb25zKC0pDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgYi9k
cml2ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jDQo+ID4gPiA+ID4gaW5kZXggZTM4NmQ0ZWFjNDA3
Li5lYmVjMGE2ZTc3ZWQgMTAwNjQ0DQo+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvY29udHJv
bGxlci92bWQuYw0KPiA+ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMN
Cj4gPiA+ID4gPiBAQCAtNTQ2LDkgKzU0NiwxMCBAQCBzdGF0aWMgaW50IHZtZF9lbmFibGVfZG9t
YWluKHN0cnVjdCB2bWRfZGV2ICp2bWQsIHVuc2lnbmVkIGxvbmcgZmVhdHVyZXMpDQo+ID4gPiA+
ID4gIA0KPiA+ID4gPiA+ICAJdm1kLT5pcnFfZG9tYWluID0gcGNpX21zaV9jcmVhdGVfaXJxX2Rv
bWFpbihmbiwgJnZtZF9tc2lfZG9tYWluX2luZm8sDQo+ID4gPiA+ID4gIAkJCQkJCSAgICB4ODZf
dmVjdG9yX2RvbWFpbik7DQo+ID4gPiA+ID4gLQlpcnFfZG9tYWluX2ZyZWVfZndub2RlKGZuKTsN
Cj4gPiA+ID4gPiAtCWlmICghdm1kLT5pcnFfZG9tYWluKQ0KPiA+ID4gPiA+ICsJaWYgKCF2bWQt
PmlycV9kb21haW4pIHsNCj4gPiA+ID4gPiArCQlpcnFfZG9tYWluX2ZyZWVfZndub2RlKGZuKTsN
Cj4gPiA+ID4gPiAgCQlyZXR1cm4gLUVOT0RFVjsNCj4gPiA+ID4gPiArCX0NCj4gPiA+ID4gPiAg
DQo+ID4gPiA+ID4gIAlwY2lfYWRkX3Jlc291cmNlKCZyZXNvdXJjZXMsICZ2bWQtPnJlc291cmNl
c1swXSk7DQo+ID4gPiA+ID4gIAlwY2lfYWRkX3Jlc291cmNlX29mZnNldCgmcmVzb3VyY2VzLCAm
dm1kLT5yZXNvdXJjZXNbMV0sIG9mZnNldFswXSk7DQo+ID4gPiA+ID4gQEAgLTU1OSw2ICs1NjAs
NyBAQCBzdGF0aWMgaW50IHZtZF9lbmFibGVfZG9tYWluKHN0cnVjdCB2bWRfZGV2ICp2bWQsIHVu
c2lnbmVkIGxvbmcgZmVhdHVyZXMpDQo+ID4gPiA+ID4gIAlpZiAoIXZtZC0+YnVzKSB7DQo+ID4g
PiA+ID4gIAkJcGNpX2ZyZWVfcmVzb3VyY2VfbGlzdCgmcmVzb3VyY2VzKTsNCj4gPiA+ID4gPiAg
CQlpcnFfZG9tYWluX3JlbW92ZSh2bWQtPmlycV9kb21haW4pOw0KPiA+ID4gPiA+ICsJCWlycV9k
b21haW5fZnJlZV9md25vZGUoZm4pOw0KPiA+ID4gPiA+ICAJCXJldHVybiAtRU5PREVWOw0KPiA+
ID4gPiA+ICAJfQ0KPiA+ID4gPiA+ICANCj4gPiA+ID4gPiBAQCAtNjcyLDYgKzY3NCw3IEBAIHN0
YXRpYyB2b2lkIHZtZF9jbGVhbnVwX3NyY3Uoc3RydWN0IHZtZF9kZXYgKnZtZCkNCj4gPiA+ID4g
PiAgc3RhdGljIHZvaWQgdm1kX3JlbW92ZShzdHJ1Y3QgcGNpX2RldiAqZGV2KQ0KPiA+ID4gPiA+
ICB7DQo+ID4gPiA+ID4gIAlzdHJ1Y3Qgdm1kX2RldiAqdm1kID0gcGNpX2dldF9kcnZkYXRhKGRl
dik7DQo+ID4gPiA+ID4gKwlzdHJ1Y3QgZndub2RlX2hhbmRsZSAqZm4gPSB2bWQtPmlycV9kb21h
aW4tPmZ3bm9kZTsNCj4gPiA+ID4gPiAgDQo+ID4gPiA+ID4gIAlzeXNmc19yZW1vdmVfbGluaygm
dm1kLT5kZXYtPmRldi5rb2JqLCAiZG9tYWluIik7DQo+ID4gPiA+ID4gIAlwY2lfc3RvcF9yb290
X2J1cyh2bWQtPmJ1cyk7DQo+ID4gPiA+ID4gQEAgLTY3OSw2ICs2ODIsNyBAQCBzdGF0aWMgdm9p
ZCB2bWRfcmVtb3ZlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gPiA+ID4gIAl2bWRfY2xlYW51
cF9zcmN1KHZtZCk7DQo+ID4gPiA+ID4gIAl2bWRfZGV0YWNoX3Jlc291cmNlcyh2bWQpOw0KPiA+
ID4gPiA+ICAJaXJxX2RvbWFpbl9yZW1vdmUodm1kLT5pcnFfZG9tYWluKTsNCj4gPiA+ID4gPiAr
CWlycV9kb21haW5fZnJlZV9md25vZGUoZm4pOw0KPiA+ID4gPiA+ICB9DQo+ID4gPiA+ID4gIA0K
PiA+ID4gPiA+ICAjaWZkZWYgQ09ORklHX1BNX1NMRUVQDQo+ID4gPiA+ID4gLS0gDQo+ID4gPiA+
ID4gMi4xOC4xDQo+ID4gPiA+ID4gDQo+ID4gDQo+ID4gLS0gDQo+ID4gV2l0aCBCZXN0IFJlZ2Fy
ZHMsDQo+ID4gQW5keSBTaGV2Y2hlbmtvDQo+ID4gDQo+ID4gDQo=
