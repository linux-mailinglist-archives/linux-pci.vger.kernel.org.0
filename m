Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7DBBD139748
	for <lists+linux-pci@lfdr.de>; Mon, 13 Jan 2020 18:13:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728641AbgAMRNm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Jan 2020 12:13:42 -0500
Received: from mga06.intel.com ([134.134.136.31]:19815 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727331AbgAMRNm (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Jan 2020 12:13:42 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga104.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 13 Jan 2020 09:13:39 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,429,1571727600"; 
   d="scan'208";a="217466080"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga008.jf.intel.com with ESMTP; 13 Jan 2020 09:13:39 -0800
Received: from orsmsx113.amr.corp.intel.com (10.22.240.9) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Jan 2020 09:13:39 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX113.amr.corp.intel.com ([169.254.9.100]) with mapi id 14.03.0439.000;
 Mon, 13 Jan 2020 09:13:39 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "hch@lst.de" <hch@lst.de>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 0/5] Clean up VMD DMA Map Ops
Thread-Topic: [PATCH v3 0/5] Clean up VMD DMA Map Ops
Thread-Index: AQHVyA0Lu7RxyhVCQkiZlD/A0y0JB6fpCjsAgABVXYA=
Date:   Mon, 13 Jan 2020 17:13:38 +0000
Message-ID: <7b55519959391b7102c54341c6f6f23b2d24dabb.camel@intel.com>
References: <1578676873-6206-1-git-send-email-jonathan.derrick@intel.com>
         <20200113120806.GA15462@e121166-lin.cambridge.arm.com>
In-Reply-To: <20200113120806.GA15462@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.159]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AB7891C721585418C2B64760AC9A88B@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTG9yZW56bywNCg0KT24gTW9uLCAyMDIwLTAxLTEzIGF0IDEyOjA4ICswMDAwLCBMb3Jlbnpv
IFBpZXJhbGlzaSB3cm90ZToNCj4gT24gRnJpLCBKYW4gMTAsIDIwMjAgYXQgMTA6MjE6MDhBTSAt
MDcwMCwgSm9uIERlcnJpY2sgd3JvdGU6DQo+ID4gdjIgU2V0OiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1pb21tdS8xNTc4NTgwMjU2LTM0ODMtMS1naXQtc2VuZC1lbWFpbC1qb25hdGhh
bi5kZXJyaWNrQGludGVsLmNvbS9ULyN0DQo+ID4gdjEgU2V0OiBodHRwczovL2xvcmUua2VybmVs
Lm9yZy9saW51eC1pb21tdS8yMDIwMDEwNzEzNDEyNS5HRDMwNzUwQDhieXRlcy5vcmcvVC8jdA0K
PiA+IA0KPiA+IFZNRCBjdXJyZW50bHkgd29ya3Mgd2l0aCBWVC1kIGVuYWJsZWQgYnkgcG9pbnRp
bmcgRE1BIGFuZCBJT01NVSBhY3Rpb25zIGF0IHRoZQ0KPiA+IFZNRCBlbmRwb2ludC4gVGhlIHBy
b2JsZW0gd2l0aCB0aGlzIGFwcHJvYWNoIGlzIHRoYXQgdGhlIFZNRCBlbmRwb2ludCdzDQo+ID4g
ZGV2aWNlLXNwZWNpZmljIGF0dHJpYnV0ZXMsIHN1Y2ggYXMgdGhlIERNQSBNYXNrIEJpdHMsIGFy
ZSB1c2VkIGluc3RlYWQuDQo+ID4gDQo+ID4gVGhpcyBzZXQgY2xlYW5zIHVwIFZNRCBieSByZW1v
dmluZyB0aGUgb3ZlcnJpZGUgdGhhdCByZWRpcmVjdHMgRE1BIG1hcA0KPiA+IG9wZXJhdGlvbnMg
dG8gdGhlIFZNRCBlbmRwb2ludC4gSW5zdGVhZCBpdCBpbnRyb2R1Y2VzIGEgbmV3IERNQSBhbGlh
cyBtZWNoYW5pc20NCj4gPiBpbnRvIHRoZSBleGlzdGluZyBETUEgYWxpYXMgaW5mcmFzdHJ1Y3R1
cmUuDQo+ID4gDQo+ID4gdjEgYWRkZWQgYSBwb2ludGVyIGluIHN0cnVjdCBwY2lfZGV2IHRoYXQg
cG9pbnRlZCB0byB0aGUgRE1BIGFsaWFzJyBzdHJ1Y3QNCj4gPiBwY2lfZGV2IGFuZCBkaWQgdGhl
IG5lY2Vzc2FyeSBETUEgYWxpYXMgYW5kIElPTU1VIG1vZGlmaWNhdGlvbnMuDQo+ID4gDQo+ID4g
djIgaW50cm9kdWNlZCBhIG5ldyB3ZWFrIGZ1bmN0aW9uIHRvIHJlZmVyZW5jZSB0aGUgJ0RpcmVj
dCBETUEgQWxpYXMnLCBhbmQNCj4gPiByZW1vdmVkIHRoZSBuZWVkIHRvIGFkZCBhIHBvaW50ZXIg
aW4gc3RydWN0IGRldmljZSBvciBwY2lfZGV2LiBXZWFrIGZ1bmN0aW9ucw0KPiA+IGFyZSBnZW5l
cmFsbHkgZnJvd25lZCB1cG9uIHdoZW4gaXQncyBhIHNpbmdsZSBhcmNoaXRlY3R1cmUgaW1wbGVt
ZW50YXRpb24sIHNvIEkNCj4gPiBhbSBvcGVuIHRvIGFsdGVybmF0aXZlcy4NCj4gPiANCj4gPiB2
MyByZWZlcmVuY2VzIHRoZSBwY2lfZGV2IHJhdGhlciB0aGFuIHRoZSBzdHJ1Y3QgZGV2aWNlIGZv
ciB0aGUgUENJDQo+ID4gJ0RpcmVjdCBETUEgQWxpYXMnIChwY2lfZGlyZWN0X2RtYV9hbGlhcygp
KS4gVGhpcyByZXZpc2lvbiBhbHNvIGFsbG93cw0KPiA+IHBjaV9mb3JfZWFjaF9kbWFfYWxpYXMo
KSB0byBjYWxsIGFueSBETUEgYWxpYXNlcyBmb3IgdGhlIERpcmVjdCBETUEgYWxpYXMNCj4gPiBk
ZXZpY2UsIHRob3VnaCBJIGRvbid0IGV4cGVjdCB0aGUgVk1EIGVuZHBvaW50IHRvIG5lZWQgaW50
cmEtYnVzIERNQSBhbGlhc2VzLg0KPiA+IA0KPiA+IENoYW5nZXMgZnJvbSB2MjoNCj4gPiBVc2Vz
IHN0cnVjdCBwY2lfZGV2IGZvciBQQ0kgRGV2aWNlICdEaXJlY3QgRE1BIGFsaWFzaW5nJyAocGNp
X2RpcmVjdF9kbWFfYWxpYXMpDQo+ID4gQWxsb3dzIHBjaV9mb3JfZWFjaF9kbWFfYWxpYXMgdG8g
aXRlcmF0ZSBvdmVyIHRoZSBhbGlhcyBtYXNrIG9mIHRoZSAnRGlyZWN0IERNQSBhbGlhcycNCj4g
PiANCj4gPiBDaGFuZ2VzIGZyb20gdjE6DQo+ID4gUmVtb3ZlZCAxLzUgJiAyLzUgbWlzYyBmaXgg
cGF0Y2hlcyB0aGF0IHdlcmUgbWVyZ2VkDQo+ID4gVXNlcyBDaHJpc3RvcGgncyBzdGFnaW5nL2Ns
ZWFudXAgcGF0Y2hlcw0KPiA+IEludHJvZHVjZSB3ZWFrIGZ1bmN0aW9uIHJhdGhlciB0aGFuIGlu
Y2x1ZGluZyBwb2ludGVyIGluIHN0cnVjdCBkZXZpY2Ugb3IgcGNpX2Rldi4NCj4gPiANCj4gPiBC
YXNlZCBvbiBKb2VyZydzIG5leHQ6DQo+ID4gaHR0cHM6Ly9naXQua2VybmVsLm9yZy9wdWIvc2Nt
L2xpbnV4L2tlcm5lbC9naXQvam9yby9pb21tdS5naXQvDQo+ID4gDQo+ID4gSm9uIERlcnJpY2sg
KDUpOg0KPiA+ICAgeDg2L3BjaTogQWRkIGEgdG9fcGNpX3N5c2RhdGEgaGVscGVyDQo+ID4gICB4
ODYvUENJOiBFeHBvc2UgVk1EJ3MgUENJIERldmljZSBpbiBwY2lfc3lzZGF0YQ0KPiA+ICAgUENJ
OiBJbnRyb2R1Y2UgcGNpX2RpcmVjdF9kbWFfYWxpYXMoKQ0KPiA+ICAgUENJOiB2bWQ6IFN0b3Ag
b3ZlcnJpZGluZyBkbWFfbWFwX29wcw0KPiA+ICAgeDg2L3BjaTogUmVtb3ZlIFg4Nl9ERVZfRE1B
X09QUw0KPiA+IA0KPiA+ICBhcmNoL3g4Ni9LY29uZmlnICAgICAgICAgICAgICAgfCAgIDMgLQ0K
PiA+ICBhcmNoL3g4Ni9pbmNsdWRlL2FzbS9kZXZpY2UuaCAgfCAgMTAgLS0tDQo+ID4gIGFyY2gv
eDg2L2luY2x1ZGUvYXNtL3BjaS5oICAgICB8ICAzMSArKysrLS0tLS0NCj4gPiAgYXJjaC94ODYv
cGNpL2NvbW1vbi5jICAgICAgICAgIHwgIDQ1ICsrLS0tLS0tLS0tLQ0KPiA+ICBkcml2ZXJzL2lv
bW11L2ludGVsLWlvbW11LmMgICAgfCAgMTggKysrLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9LY29uZmlnIHwgICAxIC0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci92bWQuYyAg
IHwgMTUyICstLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tLS0tDQo+ID4gIGRy
aXZlcnMvcGNpL3BjaS5jICAgICAgICAgICAgICB8ICAxOSArKysrKy0NCj4gPiAgZHJpdmVycy9w
Y2kvc2VhcmNoLmMgICAgICAgICAgIHwgICA3ICsrDQo+ID4gIGluY2x1ZGUvbGludXgvcGNpLmgg
ICAgICAgICAgICB8ICAgMSArDQo+ID4gIDEwIGZpbGVzIGNoYW5nZWQsIDYxIGluc2VydGlvbnMo
KyksIDIyNiBkZWxldGlvbnMoLSkNCj4gDQo+IEpvbiwgQ2hyaXN0b3BoLA0KPiANCj4gQUZBSUNT
IHRoaXMgc2VyaWVzIHN1cGVyc2VkZXMvb3ZlcnJpZGVzOg0KPiANCj4gaHR0cHM6Ly9wYXRjaHdv
cmsua2VybmVsLm9yZy9wYXRjaC8xMTExNDgzMS8NCj4gDQo+IFBsZWFzZSBsZXQgbWUga25vdyBp
ZiB0aGF0J3MgY29ycmVjdCwgYWN0dWFsbHkgSSB3YXMgd2FpdGluZyB0bw0KPiBzZWUgY29uc2Vu
c3VzIG9uIHRoZSBwYXRjaCBhYm92ZSBidXQgaWYgdGhpcyBzZXJpZXMgc3VwZXJzZWRlcw0KPiBp
dCBJIHdvdWxkIGRyb3AgaXQgZnJvbSB0aGUgUENJIHJldmlldyBxdWV1ZS4NCj4gDQo+IFRoYW5r
cywNCj4gTG9yZW56bw0KDQpJdCBkb2VzIHN1cGVyY2VkZSBpdCAod2l0aCBDaHJpc3RvcGgncyBi
bGVzc2luZykuIEJ5IHRoZSB3YXksIEkgaGF2ZQ0KYmVlbiBiYXNpbmcgb24gSm9lcmcncyByZXBv
ICBkdWUgdG8gdGhlIHYxL1JGQyBJT01NVSBtb2RpZmNhdGlvbnMuIEFzDQp0aGVyZSdzIG1vcmUg
cGNpIHdvcmsgYXQgdGhpcyBwb2ludCwgc2hvdWxkIEkgYmFzZSBpdCBvbiBCam9ybidzIHJlcG8N
Cmluc3RlYWQ/DQo=
