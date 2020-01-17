Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1D7DF14109C
	for <lists+linux-pci@lfdr.de>; Fri, 17 Jan 2020 19:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727519AbgAQSRz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 17 Jan 2020 13:17:55 -0500
Received: from mga04.intel.com ([192.55.52.120]:46975 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726970AbgAQSRz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 17 Jan 2020 13:17:55 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga104.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 17 Jan 2020 10:17:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,331,1574150400"; 
   d="scan'208";a="373726753"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga004.jf.intel.com with ESMTP; 17 Jan 2020 10:17:54 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX102.amr.corp.intel.com ([169.254.3.133]) with mapi id 14.03.0439.000;
 Fri, 17 Jan 2020 10:17:54 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Topic: [PATCH v3 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Index: AQHVyA0OR8Dpn/C2UE++GgtBXKYjuafqZnOAgAVUbYA=
Date:   Fri, 17 Jan 2020 18:17:53 +0000
Message-ID: <b36cf7bfc6ca5898ab3e6095439962af2381d533.camel@intel.com>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
         <1578676873-6206-5-git-send-email-jonathan.derrick@intel.com>
         <20200114085425.GD32024@lst.de>
In-Reply-To: <20200114085425.GD32024@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.151]
Content-Type: text/plain; charset="utf-8"
Content-ID: <AB75532F4FA3C140A9F5CACAACBCEEF6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTAxLTE0IGF0IDA5OjU0ICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gRnJpLCBKYW4gMTAsIDIwMjAgYXQgMTA6MjE6MTJBTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gRGV2aWNlcyBvbiB0aGUgVk1EIGRvbWFpbiB1c2UgdGhlIFZNRCBlbmRw
b2ludCdzIHJlcXVlc3RlciBJRCBhbmQgaGF2ZQ0KPiA+IGJlZW4gcmVseWluZyBvbiB0aGUgVk1E
IGVuZHBvaW50J3MgRE1BIG9wZXJhdGlvbnMuIFRoZSBwcm9ibGVtIHdpdGggdGhpcw0KPiA+IHdh
cyB0aGF0IFZNRCBkb21haW4gZGV2aWNlcyB3b3VsZCB1c2UgdGhlIFZNRCBlbmRwb2ludCdzIGF0
dHJpYnV0ZXMgd2hlbg0KPiA+IGRvaW5nIERNQSBhbmQgSU9NTVUgbWFwcGluZy4gV2UgY2FuIGJl
IHNtYXJ0ZXIgYWJvdXQgdGhpcyBieSBvbmx5IHVzaW5nDQo+ID4gdGhlIFZNRCBlbmRwb2ludCB3
aGVuIG1hcHBpbmcgYW5kIHByb3ZpZGluZyB0aGUgY29ycmVjdCBjaGlsZCBkZXZpY2Uncw0KPiA+
IGF0dHJpYnV0ZXMgZHVyaW5nIERNQSBvcGVyYXRpb25zLg0KPiA+IA0KPiA+IFRoaXMgcGF0Y2gg
bW9kaWZpZXMgSW50ZWwtSU9NTVUgdG8gY2hlY2sgZm9yIGEgJ0RpcmVjdCBETUEgQWxpYXMnIGFu
ZA0KPiA+IHJlZmVyIHRvIGl0IGZvciBtYXBwaW5nLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6
IEpvbiBEZXJyaWNrIDxqb25hdGhhbi5kZXJyaWNrQGludGVsLmNvbT4NCj4gPiAtLS0NCj4gPiAg
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jICAgIHwgIDE4ICsrKy0tDQo+ID4gIGRyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvS2NvbmZpZyB8ICAgMSAtDQo+ID4gIGRyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvdm1kLmMgICB8IDE1MCAtLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0t
LQ0KPiA+ICAzIGZpbGVzIGNoYW5nZWQsIDEzIGluc2VydGlvbnMoKyksIDE1NiBkZWxldGlvbnMo
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jDQo+ID4gaW5kZXggNzE2MzQ3ZTIuLjdjYTgwN2Eg
MTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jDQo+ID4gKysrIGIv
ZHJpdmVycy9pb21tdS9pbnRlbC1pb21tdS5jDQo+ID4gQEAgLTgwNCwxNCArODA0LDE0IEBAIHN0
YXRpYyBzdHJ1Y3QgaW50ZWxfaW9tbXUgKmRldmljZV90b19pb21tdShzdHJ1Y3QgZGV2aWNlICpk
ZXYsIHU4ICpidXMsIHU4ICpkZXZmDQo+ID4gIA0KPiA+ICAJaWYgKGRldl9pc19wY2koZGV2KSkg
ew0KPiA+ICAJCXN0cnVjdCBwY2lfZGV2ICpwZl9wZGV2Ow0KPiA+ICsJCXN0cnVjdCBwY2lfZGV2
ICpkbWFfYWxpYXM7DQo+ID4gIA0KPiA+ICAJCXBkZXYgPSB0b19wY2lfZGV2KGRldik7DQo+ID4g
IA0KPiA+IC0jaWZkZWYgQ09ORklHX1g4Ng0KPiA+IC0JCS8qIFZNRCBjaGlsZCBkZXZpY2VzIGN1
cnJlbnRseSBjYW5ub3QgYmUgaGFuZGxlZCBpbmRpdmlkdWFsbHkgKi8NCj4gPiAtCQlpZiAoaXNf
dm1kKHBkZXYtPmJ1cykpDQo+ID4gLQkJCXJldHVybiBOVUxMOw0KPiA+IC0jZW5kaWYNCj4gDQo+
IERvbid0IHdlIG5lZWQgdGhpcyBzYW5pdHkgY2hlY2sgdG8gcHJldmVudCBhc3NpbmduaW5nIHZt
ZCBzdWJkZXZpY2VzPw0KSSBkb24ndCB0aGluayBpdCdzIG5lY2Vzc2FyeSBub3cuIFRoZSBuZXcg
Y29kZSByZXN1bHRzIGluIHRoZSBjaGlsZA0KZGV2aWNlcyBiZWluZyBhc3NpZ25lZCB0aGUgc2Ft
ZSBJT01NVSBncm91cCBhcyB0aGUgVk1EIGVuZHBvaW50Lg0KKEFGQUlLKSBZb3UgaGF2ZSB0byBh
c3NpZ24gYWxsIGRldmljZXMgaW4gYSBncm91cCB3aGVuIGRvaW5nDQphc3NpZ25tZW50LCBzbyBi
eSB1bmJpbmRpbmcgdGhlIFZNRCBlbmRwb2ludCBpbiBvcmRlciB0byBhc3NpZ24gaXQsIHlvdQ0K
d291bGQgbG9zZSB0aGUgY2hpbGQgZGV2aWNlcyBpbiB0aGUgaG9zdC4NCg0KDQo+IA0KPiA+ICsJ
CS8qIERNQSBhbGlhc2VkIGRldmljZXMgdXNlIHRoZSBETUEgYWxpYXMncyBJT01NVSAqLw0KPiA+
ICsJCWRtYV9hbGlhcyA9IHBjaV9kaXJlY3RfZG1hX2FsaWFzKHBkZXYpOw0KPiA+ICsJCWlmIChk
bWFfYWxpYXMpDQo+ID4gKwkJCXBkZXYgPSBkbWFfYWxpYXM7DQo+ID4gIA0KPiA+ICAJCS8qIFZG
cyBhcmVuJ3QgbGlzdGVkIGluIHNjb3BlIHRhYmxlczsgd2UgbmVlZCB0byBsb29rIHVwDQo+ID4g
IAkJICogdGhlIFBGIGluc3RlYWQgdG8gZmluZCB0aGUgSU9NTVUuICovDQo+ID4gQEAgLTI1MjEs
NiArMjUyMSwxNCBAQCBzdHJ1Y3QgZG1hcl9kb21haW4gKmZpbmRfZG9tYWluKHN0cnVjdCBkZXZp
Y2UgKmRldikNCj4gPiAgCQkgICAgIGRldi0+YXJjaGRhdGEuaW9tbXUgPT0gRFVNTVlfREVWSUNF
X0RPTUFJTl9JTkZPKSkNCj4gPiAgCQlyZXR1cm4gTlVMTDsNCj4gPiAgDQo+ID4gKwlpZiAoZGV2
X2lzX3BjaShkZXYpKSB7DQo+ID4gKwkJc3RydWN0IHBjaV9kZXYgKnBkZXYgPSB0b19wY2lfZGV2
KGRldik7DQo+ID4gKwkJc3RydWN0IHBjaV9kZXYgKmRtYV9hbGlhcyA9IHBjaV9kaXJlY3RfZG1h
X2FsaWFzKHBkZXYpOw0KPiA+ICsNCj4gPiArCQlpZiAoZG1hX2FsaWFzKQ0KPiA+ICsJCQlkZXYg
PSAmZG1hX2FsaWFzLT5kZXY7DQo+IA0KPiBJbnN0ZWFkIG9mIGFsbCB0aGVzZSBkdXBsaWNhdGUg
Y2FsbHMsIHNob3VsZG4ndCBwY2lfZGlyZWN0X2RtYV9hbGlhcyBiZQ0KPiByZXBsYWNlZCB3aXRo
IGEgcGNpX3JlYWxfZG1hX2RldiBoZWxwZXIgdGhhdCBlaXRoZXIgcmV0dXJucyB0aGUNCj4gZG1h
IHBhcmVudCBpZiBpdCBleGnRlXRzLCBvciB0aGUgYWN0dWFsIGRldmljZT8NCj4gDQo+IEFsc28g
SSB0aGluayB0aGlzIHBhdGNoIHNob3VsZCBiZSBzcGxpdCAtIG9uZSBmb3IgaW50ZWwtaW9tbXUg
dGhhdA0KPiBqdXN0IGFkZHMgdGhlIHJlYWwgZGV2aWNlIGNoZWNrcywgYW5kIHRoZW4gb25lIHRo
YXQgd2lyZXMgdXAgdm1kIHRvDQo+IHRoZSBuZXcgbWVjaGFuaXNtIGFuZCB0aGVuIHJlbW92ZXMg
YWxsIHRoZSBjcnVmdC4NCg0KDQpUaGFua3MgZm9yIHRoZSByZXZpZXcuIEknbGwgd29yayBvbiB0
aGUgc3VnZ2VzdGlvbg0K
