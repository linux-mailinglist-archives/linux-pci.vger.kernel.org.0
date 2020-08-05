Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7AEB723CC0B
	for <lists+linux-pci@lfdr.de>; Wed,  5 Aug 2020 18:20:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726150AbgHEQUY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 5 Aug 2020 12:20:24 -0400
Received: from mga03.intel.com ([134.134.136.65]:30229 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgHEQTB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 5 Aug 2020 12:19:01 -0400
IronPort-SDR: 2XbTS2kB3fOc3keHoebohIZNJJeFr98UcB34vgWu/TDyPJFAEJ8QyCokMwO0FDefLneA4ml4Lz
 VShh1TPF84Zw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="152543216"
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="152543216"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Aug 2020 09:09:27 -0700
IronPort-SDR: NzEq8Brw9liqr+zd2Tt6UTA5tLga8mubiiINwL+Wv1lubEonP/1CVbILeUkRN/BzMsBxRJ+AiP
 75JLtvQ+oSHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,438,1589266800"; 
   d="scan'208";a="437219139"
Received: from orsmsx604.amr.corp.intel.com ([10.22.229.17])
  by orsmga004.jf.intel.com with ESMTP; 05 Aug 2020 09:09:27 -0700
Received: from orsmsx604.amr.corp.intel.com (10.22.229.17) by
 ORSMSX604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Wed, 5 Aug 2020 09:09:26 -0700
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 orsmsx604.amr.corp.intel.com (10.22.229.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.1713.5
 via Frontend Transport; Wed, 5 Aug 2020 09:09:26 -0700
Received: from orsmsx103.amr.corp.intel.com ([169.254.5.158]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.213]) with mapi id 14.03.0439.000;
 Wed, 5 Aug 2020 09:09:26 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "vaibhavgupta40@gmail.com" <vaibhavgupta40@gmail.com>,
        "vicamo.yang@canonical.com" <vicamo.yang@canonical.com>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: Re: [PATCH] PCI: vmd: Allow VMD PM to use PCI core PM code
Thread-Topic: [PATCH] PCI: vmd: Allow VMD PM to use PCI core PM code
Thread-Index: AQHWZ2DMvLKu8hekmkeNJCwhOBvOzqkqG1GAgAAQ2AA=
Date:   Wed, 5 Aug 2020 16:09:25 +0000
Message-ID: <72baf0c27345c4fc70e1413580573da5234d14d4.camel@intel.com>
References: <20200805150907.GA510270@bjorn-Precision-5520>
In-Reply-To: <20200805150907.GA510270@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.27.177]
Content-Type: text/plain; charset="utf-8"
Content-ID: <07BE3392C5FAAE4A9D0A7125D4278A4A@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTA4LTA1IGF0IDEwOjA5IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBbK2NjIFZhaWJoYXYsIFJhZmFlbCBmb3Igc3VzcGVuZC9yZXN1bWUgcXVlc3Rpb25dDQo+IA0K
PiBPbiBGcmksIEp1bCAzMSwgMjAyMCBhdCAwMToxNTo0NFBNIC0wNDAwLCBKb24gRGVycmljayB3
cm90ZToNCj4gPiBUaGUgcGNpX3NhdmVfc3RhdGUgY2FsbCBpbiB2bWRfc3VzcGVuZCBjYW4gYmUg
cGVyZm9ybWVkIGJ5DQo+ID4gcGNpX3BtX3N1c3BlbmRfaXJxLiBUaGlzIGFsbG93cyB0aGUgY2Fs
bCB0byBwY2lfcHJlcGFyZV90b19zbGVlcCBpbnRvDQo+ID4gQVNQTSBmbG93Lg0KPiANCj4gQWRk
ICIoKSIgYWZ0ZXIgZnVuY3Rpb24gbmFtZXMgc28gdGhleSBkb24ndCBsb29rIGxpa2UgRW5nbGlz
aCB3b3Jkcy4NCj4gDQo+IFdoYXQgaXMgdGhpcyAiQVNQTSBmbG93Ij8gDQooRm9yZ2l2ZSBteSBt
aXN1bmRlcnN0YW5kaW5nKQ0KDQo+ICBUaGUgb25seSBBU1BNLXJlbGF0ZWQgY29kZSBzaG91bGQg
YmUNCj4gY29uZmlndXJhdGlvbiAoZW5hYmxlL2Rpc2FibGUgQVNQTSkgKHdoaWNoIGhhcHBlbnMg
YXQNCj4gZW51bWVyYXRpb24tdGltZSwgbm90IHN1c3BlbmQvcmVzdW1lIHRpbWUpIGFuZCBzYXZl
L3Jlc3RvcmUgaWYgd2UgdHVybg0KPiB0aGUgZGV2aWNlIG9mZiBhbmQgd2UgaGF2ZSB0byByZWNv
bmZpZ3VyZSBpdCB3aGVuIHdlIHR1cm4gaXQgb24gYWdhaW4uDQpTbyBpbiB0aGUgc3VzcGVuZCBw
YXRoIHdlIGdhaW4gcGNpX3ByZXBhcmVfdG9fc2xlZXAoKSBieSBub3QgcHJlLXNhdmluZyANCnN0
YXRlLg0KDQpUaGUgYmlnIGNvbXBvbmVudCBoZXJlIGlzIHRoYXQgd2UgYXJlIGEgTm9uLUFDUEkg
ZGV2aWNlL2RvbWFpbiBvbiBhbg0KQUNQSSBQTSBtYW5hZ2VhYmxlIHN5c3RlbSwgc28gSSdtIG5v
dCBjZXJ0YWluIGlmIHdlJ3JlIG1pc3Npbmcgc29tZQ0KcGxhdGZvcm0gY3JpdGljYWwgZWxlbWVu
dHMgaGVyZSBpbiBwY2lfcGxhdGZvcm1fcG93ZXJfKiBmdW5jdGlvbnMuDQoNCj4gPiBUaGUgcGNp
X3Jlc3RvcmVfc3RhdGUgY2FsbCBpbiB2bWRfcmVzdW1lIHdhcyByZXN0b3Jpbmcgc3RhdGUgYWZ0
ZXINCj4gPiBwY2lfcG1fcmVzdW1lLT5wY2lfcmVzdG9yZV9zdGFuZGFyZF9jb25maWcgaGFkIGFs
cmVhZHkgcmVzdG9yZWQgc3RhdGUuDQo+ID4gSXQncyBhbHNvIGJlZW4gc3VzcGVjdGVkIHRoYXQg
dGhlIGNvbmZpZyBzdGF0ZSBzaG91bGQgYmUgcmVzdG9yZWQgYmVmb3JlDQo+ID4gcmUtcmVxdWVz
dGluZyBJUlFzLg0KPiA+IA0KPiA+IFJlbW92ZSB0aGUgcGNpX3tzYXZlLHJlc3RvcmV9X3N0YXRl
IGNhbGxzIGluIHZtZF97c3VzcGVuZCxyZXN1bWV9IGluDQo+ID4gb3JkZXIgdG8gYWxsb3cgcHJv
cGVyIGZsb3cgdGhyb3VnaCBQQ0kgY29yZSBwb3dlciBtYW5hZ2VtZW50IEFTUE0gY29kZS4NCj4g
PiANCj4gPiBDYzogS2FpLUhlbmcgRmVuZyA8a2FpLmhlbmcuZmVuZ0BjYW5vbmljYWwuY29tPg0K
PiA+IENjOiBZb3UtU2hlbmcgWWFuZyA8dmljYW1vLnlhbmdAY2Fub25pY2FsLmNvbT4NCj4gPiBT
aWduZWQtb2ZmLWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+DQo+
ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMgfCAyIC0tDQo+ID4gIDEg
ZmlsZSBjaGFuZ2VkLCAyIGRlbGV0aW9ucygtKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL3ZtZC5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYw0K
PiA+IGluZGV4IDc2ZDhhY2JlZTdkNS4uMTVjMWQ4NWQ4NzgwIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvdm1kLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3ZtZC5jDQo+ID4gQEAgLTcxOSw3ICs3MTksNiBAQCBzdGF0aWMgaW50IHZtZF9zdXNwZW5k
KHN0cnVjdCBkZXZpY2UgKmRldikNCj4gPiAgCWZvciAoaSA9IDA7IGkgPCB2bWQtPm1zaXhfY291
bnQ7IGkrKykNCj4gPiAgCQlkZXZtX2ZyZWVfaXJxKGRldiwgcGNpX2lycV92ZWN0b3IocGRldiwg
aSksICZ2bWQtPmlycXNbaV0pOw0KPiA+ICANCj4gPiAtCXBjaV9zYXZlX3N0YXRlKHBkZXYpOw0K
PiANCj4gVGhlIFZNRCBkcml2ZXIgdXNlcyBnZW5lcmljIFBNLCBub3QgbGVnYWN5IFBDSSBQTSwg
c28gSSB0aGluayByZW1vdmluZw0KPiB0aGUgc2F2ZS9yZXN0b3JlIHN0YXRlIGZyb20geW91ciBz
dXNwZW5kL3Jlc3VtZSBmdW5jdGlvbnMgaXMgdGhlIHJpZ2h0DQo+IHRoaW5nIHRvIGRvLiAgWW91
IHNob3VsZCBvbmx5IG5lZWQgdG8gZG8gVk1ELXNwZWNpZmljIHRoaW5ncyB0aGVyZS4NCj4gDQo+
IEknbSBub3QgZXZlbiBzdXJlIHlvdSBuZWVkIHRvIGZyZWUvcmVxdWVzdCB0aGUgSVJRcyBpbiB5
b3VyDQo+IHN1c3BlbmQvcmVzdW1lLiAgTWF5YmUgUmFmYWVsIG9yIFZhaWJoYXYga25vdy4NClRo
ZSBoaXN0b3J5IG9uIHRoYXQgd2FzIGR1ZSB0byB0b28gbWFueSBWTUQgaW5zdGFuY2VzIGNvbnN1
bWluZyB0b28NCm1hbnkgSVJRcyBmb3IgdGhlIHN1c3BlbmQgcGF0aCB3aGVuIG1vdmluZyBJUlFz
IGZyb20gQ1BVcyBiZWluZw0Kb2ZmbGluZWQ6DQoNCmNvbW1pdCBlMmIxODIwYmQ1ZDA5NjJkNmYy
NzFiMGQ0N2MzYTBlMzg2NDdkZjJmDQpBdXRob3I6IFNjb3R0IEJhdWVyIDxzY290dC5iYXVlckBp
bnRlbC5jb20+DQpEYXRlOiAgIEZyaSBBdWcgMTEgMTQ6NTQ6MzIgMjAxNyAtMDYwMA0KDQogICAg
UENJOiB2bWQ6IEZyZWUgdXAgSVJRcyBvbiBzdXNwZW5kIHBhdGgNCiAgICANCiAgICBGcmVlIHVw
IHRoZSBJUlFzIHdlIHJlcXVlc3Qgb24gdGhlIHN1c3BlbmQgcGF0aCBhbmQgcmVhbGxvY2F0ZSB0
aGVtIG9uIHRoZQ0KICAgIHJlc3VtZSBwYXRoLg0KICAgIA0KICAgIEZpeGVzIHRoaXMgZXJyb3I6
DQogICAgDQogICAgICBDUFUgMTExIGRpc2FibGUgZmFpbGVkOiBDUFUgaGFzIDkgdmVjdG9ycyBh
c3NpZ25lZCBhbmQgdGhlcmUgYXJlIG9ubHkgMCBhdmFpbGFibGUuDQogICAgICBFcnJvciB0YWtp
bmcgQ1BVMTExIGRvd246IC0zNA0KICAgICAgTm9uLWJvb3QgQ1BVcyBhcmUgbm90IGRpc2FibGVk
DQogICAgICBFbmFibGluZyBub24tYm9vdCBDUFVzIC4uLg0KDQo+IA0KPiBJIGp1c3QgdGhpbmsg
dGhlIGp1c3RpZmljYXRpb24gaW4gdGhlIGNvbW1pdCBsb2cgaXMgd3JvbmcuDQo+IA0KPiA+ICAJ
cmV0dXJuIDA7DQo+ID4gIH0NCj4gPiAgDQo+ID4gQEAgLTczNyw3ICs3MzYsNiBAQCBzdGF0aWMg
aW50IHZtZF9yZXN1bWUoc3RydWN0IGRldmljZSAqZGV2KQ0KPiA+ICAJCQlyZXR1cm4gZXJyOw0K
PiA+ICAJfQ0KPiA+ICANCj4gPiAtCXBjaV9yZXN0b3JlX3N0YXRlKHBkZXYpOw0KPiA+ICAJcmV0
dXJuIDA7DQo+ID4gIH0NCj4gPiAgI2VuZGlmDQo+ID4gLS0gDQo+ID4gMi4xOC4xDQo+ID4gDQo=
