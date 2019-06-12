Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A8D7C43072
	for <lists+linux-pci@lfdr.de>; Wed, 12 Jun 2019 21:52:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728209AbfFLTwk (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 12 Jun 2019 15:52:40 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:65317 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728207AbfFLTwk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 12 Jun 2019 15:52:40 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.de; i=@amazon.de; q=dns/txt; s=amazon201209;
  t=1560369158; x=1591905158;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:mime-version:
   content-transfer-encoding;
  bh=1wc8dBdFTBzzZjbP80v8BICH+RP94FRHu93Azv5nIAA=;
  b=m6jg6Z2YIexoCajgMLVih5jG5TkHXRwDQo5KMbhd4367oAfMeNch0ngz
   sQneDAmNDz/W3Pig1BPeLiNWV/Za+3DXmXxu2TwG+ud/9SkyRf7N9gHOy
   MJLe9s1Ei9j7clDKHroc3lDOeGR47vPIfvjYbC5W71uq3hJco2zE7o8Vq
   Y=;
X-IronPort-AV: E=Sophos;i="5.62,367,1554768000"; 
   d="scan'208";a="770092232"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 12 Jun 2019 19:52:36 +0000
Received: from EX13MTAUEA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id DCACA24A79C;
        Wed, 12 Jun 2019 19:52:34 +0000 (UTC)
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13MTAUEA001.ant.amazon.com (10.43.61.82) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 19:52:34 +0000
Received: from EX13D01EUB003.ant.amazon.com (10.43.166.248) by
 EX13D01EUB003.ant.amazon.com (10.43.166.248) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 12 Jun 2019 19:52:33 +0000
Received: from EX13D01EUB003.ant.amazon.com ([10.43.166.248]) by
 EX13D01EUB003.ant.amazon.com ([10.43.166.248]) with mapi id 15.00.1367.000;
 Wed, 12 Jun 2019 19:52:33 +0000
From:   "Raslan, KarimAllah" <karahmed@amazon.de>
To:     "ashok.raj@intel.com" <ashok.raj@intel.com>,
        "alex.williamson@redhat.com" <alex.williamson@redhat.com>
CC:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "keith.busch@intel.com" <keith.busch@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "mike.campin@intel.com" <mike.campin@intel.com>
Subject: Re: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
Thread-Topic: [PATCH v2 1/1] PCI/IOV: Fix incorrect cfg_size for VF > 0
Thread-Index: AQHVIVGHt8eSJLfhFECmRygagYCs76aYbhsA
Date:   Wed, 12 Jun 2019 19:52:32 +0000
Message-ID: <1560369152.22674.6.camel@amazon.de>
References: <20190612170647.43220-1-sathyanarayanan.kuppuswamy@linux.intel.com>
         <20190612121910.231368e2@x1.home>
         <0b21c76e-53f3-c35e-cebf-00719e451b11@linux.intel.com>
         <20190612125817.42909d83@x1.home> <20190612190303.GA29348@otc-nc-03>
In-Reply-To: <20190612190303.GA29348@otc-nc-03>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.164.236]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CA4404F9D46F7E45904956DC3FD32A85@amazon.com>
MIME-Version: 1.0
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE5LTA2LTEyIGF0IDEyOjAzIC0wNzAwLCBSYWosIEFzaG9rIHdyb3RlOg0KPiBP
biBXZWQsIEp1biAxMiwgMjAxOSBhdCAxMjo1ODoxN1BNIC0wNjAwLCBBbGV4IFdpbGxpYW1zb24g
d3JvdGU6DQo+ID4gDQo+ID4gT24gV2VkLCAxMiBKdW4gMjAxOSAxMTo0MTozNiAtMDcwMA0KPiA+
IHNhdGh5YW5hcmF5YW5hbiBrdXBwdXN3YW15IDxzYXRoeWFuYXJheWFuYW4ua3VwcHVzd2FteUBs
aW51eC5pbnRlbC5jb20+DQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gPiANCj4gPiA+IE9uIDYvMTIv
MTkgMTE6MTkgQU0sIEFsZXggV2lsbGlhbXNvbiB3cm90ZToNCj4gPiA+ID4gDQo+ID4gPiA+IE9u
IFdlZCwgMTIgSnVuIDIwMTkgMTA6MDY6NDcgLTA3MDANCj4gPiA+ID4gc2F0aHlhbmFyYXlhbmFu
Lmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tIHdyb3RlOg0KPiA+ID4gPiAgDQo+ID4gPiA+ID4g
DQo+ID4gPiA+ID4gRnJvbTogS3VwcHVzd2FteSBTYXRoeWFuYXJheWFuYW4gPHNhdGh5YW5hcmF5
YW5hbi5rdXBwdXN3YW15QGxpbnV4LmludGVsLmNvbT4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBD
b21taXQgOTc1YmI4YjRkYzkzICgiUENJL0lPVjogVXNlIFZGMCBjYWNoZWQgY29uZmlnIHNwYWNl
IHNpemUgZm9yDQo+ID4gPiA+ID4gb3RoZXIgVkZzIikgY2FsY3VsYXRlcyBhbmQgY2FjaGVzIHRo
ZSBjZmdfc2l6ZSBmb3IgVkYwIGRldmljZSBiZWZvcmUNCj4gPiA+ID4gPiBpbml0aWFsaXppbmcg
dGhlIHBjaWVfY2FwIG9mIHRoZSBkZXZpY2Ugd2hpY2ggcmVzdWx0cyBpbiB1c2luZyBpbmNvcnJl
Y3QNCj4gPiA+ID4gPiBjZmdfc2l6ZSBmb3IgYWxsIFZGIGRldmljZXMgPiAwLiBTbyBzZXQgcGNp
ZV9jYXAgb2YgdGhlIGRldmljZSBiZWZvcmUNCj4gPiA+ID4gPiBjYWxjdWxhdGluZyB0aGUgY2Zn
X3NpemUgb2YgVkYwIGRldmljZS4NCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBGaXhlczogOTc1YmI4
YjRkYzkzICgiUENJL0lPVjogVXNlIFZGMCBjYWNoZWQgY29uZmlnIHNwYWNlIHNpemUgZm9yDQo+
ID4gPiA+ID4gb3RoZXIgVkZzIikNCj4gPiA+ID4gPiBDYzogQXNob2sgUmFqIDxhc2hvay5yYWpA
aW50ZWwuY29tPg0KPiA+ID4gPiA+IFN1Z2dlc3RlZC1ieTogTWlrZSBDYW1waW4gPG1pa2UuY2Ft
cGluQGludGVsLmNvbT4NCj4gPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBLdXBwdXN3YW15IFNhdGh5
YW5hcmF5YW5hbiA8c2F0aHlhbmFyYXlhbmFuLmt1cHB1c3dhbXlAbGludXguaW50ZWwuY29tPg0K
PiA+ID4gPiA+IC0tLQ0KPiA+ID4gPiA+IA0KPiA+ID4gPiA+IENoYW5nZXMgc2luY2UgdjE6DQo+
ID4gPiA+ID4gICAqIEZpeGVkIGEgdHlwbyBpbiBjb21taXQgbWVzc2FnZS4NCj4gPiA+ID4gPiAN
Cj4gPiA+ID4gPiAgIGRyaXZlcnMvcGNpL2lvdi5jIHwgMSArDQo+ID4gPiA+ID4gICAxIGZpbGUg
Y2hhbmdlZCwgMSBpbnNlcnRpb24oKykNCj4gPiA+ID4gPiANCj4gPiA+ID4gPiBkaWZmIC0tZ2l0
IGEvZHJpdmVycy9wY2kvaW92LmMgYi9kcml2ZXJzL3BjaS9pb3YuYw0KPiA+ID4gPiA+IGluZGV4
IDNhYTExNWVkM2E2NS4uMjg2OTAxMWMwZTM1IDEwMDY0NA0KPiA+ID4gPiA+IC0tLSBhL2RyaXZl
cnMvcGNpL2lvdi5jDQo+ID4gPiA+ID4gKysrIGIvZHJpdmVycy9wY2kvaW92LmMNCj4gPiA+ID4g
PiBAQCAtMTYwLDYgKzE2MCw3IEBAIGludCBwY2lfaW92X2FkZF92aXJ0Zm4oc3RydWN0IHBjaV9k
ZXYgKmRldiwgaW50IGlkKQ0KPiA+ID4gPiA+ICAgCXZpcnRmbi0+ZGV2aWNlID0gaW92LT52Zl9k
ZXZpY2U7DQo+ID4gPiA+ID4gICAJdmlydGZuLT5pc192aXJ0Zm4gPSAxOw0KPiA+ID4gPiA+ICAg
CXZpcnRmbi0+cGh5c2ZuID0gcGNpX2Rldl9nZXQoZGV2KTsNCj4gPiA+ID4gPiArCXZpcnRmbi0+
cGNpZV9jYXAgPSBwY2lfZmluZF9jYXBhYmlsaXR5KHZpcnRmbiwgUENJX0NBUF9JRF9FWFApOw0K
PiA+ID4gPiA+ICAgDQo+ID4gPiA+ID4gICAJaWYgKGlkID09IDApDQo+ID4gPiA+ID4gICAJCXBj
aV9yZWFkX3ZmX2NvbmZpZ19jb21tb24odmlydGZuKTsgIA0KPiA+ID4gPiBXaHkgbm90IHJlLW9y
ZGVyIHVudGlsIGFmdGVyIHdlJ3ZlIHNldHVwIHBjaWVfY2FwPw0KPiA+ID4gPiANCj4gPiA+ID4g
aHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMTkwNjA0MTQzNjE3LjBhMjI2NTU1
QHgxLmhvbWUvVC8jICANCj4gPiA+IA0KPiA+ID4gcGNpX3JlYWRfdmZfY29uZmlnX2NvbW1vbigp
IGFsc28gY2FjaGVzIHZhbHVlcyBmb3IgcHJvcGVydGllcyBsaWtlIA0KPiA+ID4gY2xhc3MsIGhk
cl90eXBlLCBzdXNic3lzdGVtX3ZlbmRvci9kZXZpY2UuIFRoZXNlIHZhbHVlcyBhcmUgcmVhZC91
c2VkIGluIA0KPiA+ID4gcGNpX3NldHVwX2RldmljZSgpLiBTbyBpZiB3ZSBjYW4gdXNlIGNhY2hl
ZCB2YWx1ZXMgaW4gDQo+ID4gPiBwY2lfc2V0dXBfZGV2aWNlKCksIHdlIGRvbid0IGhhdmUgdG8g
cmVhZCB0aGVtIGZyb20gcmVnaXN0ZXJzIHR3aWNlIGZvciANCj4gPiA+IGVhY2ggZGV2aWNlLg0K
PiA+IA0KPiA+IFNvcnJ5LCBJIG1pc3NlZCB0aGF0IGRlcGVuZGVuY3ksIGEgYml0IHRvbyBzdWJ0
bGUuICBJdCdzIHN0aWxsIHByZXR0eQ0KPiA+IHVnbHkgdGhhdCBwY2lfc2V0dXBfZGV2aWNlKCkt
PnNldF9wY2llX3BvcnRfdHlwZSgpIGlzIHRoZSBjYW5vbmljYWwNCj4gPiBsb2NhdGlvbiBmb3Ig
c2V0dGluZyBwY2llX2NhcCBhbmQgbm93IHdlIG5lZWQgdG8ga2x1ZGdlIGl0IGVhcmxpZXIuDQo+
ID4gV2hhdCBhYm91dCB0aGUgcXVlc3Rpb24gaW4gdGhlIHNlbGYgZm9sbG93LXVwIHRvIG15IHBh
dGNoIGluIHRoZSBsaW5rDQo+ID4gYWJvdmUsIGNhbiB3ZSBzaW1wbHkgYXNzdW1lIDRLIGNvbmZp
ZyBzcGFjZSBvbiBhIFZGPyAgVGhhbmtzLA0KPiANCj4gVGhlcmUgc2hvdWxkIGJlIG5vIGlzc3Vl
IHNpbXBseSByZWFkaW5nIHRoZW0gb25jZT8gSSBkb24ndCBrbm93DQo+IHdoYXQgdGhhdCBleGFj
dCBvcHRpbWl6YXRpb24gc2F2ZXMsIHVubGVzcyBzb21lIGJyb2tlbiBWRnMgZGlkbid0DQo+IGFj
dHVhbGx5IGV4cG9zZSBhbGwgdGhlIGNhcGFiaWxpdGllcyBpbiBjb25maWcgc3BhY2UgYW5kIHRo
aXMgaGFwcGVucw0KPiB0byB3b3JrYXJvdW5kIHRoZSBwcm9ibGVtLg0KDQpUaGUgb3JpZ2luYWwg
cGF0Y2ggd2FzIHRvIHNhdmUgdGltZSB3aGVuIHlvdSBoYXZlIGh1bmRyZWRzIG9mIFZGcyBpbiB0
aGUgc3lzdGVtwqANCmFuZCBkb2luZyB0aGlzIGZvciBlYWNoIG9uZSBvZiB0aGVtIGlzIGp1c3Qg
YSB3YXN0ZSBvZiB0aW1lLg0KDQo+IA0KPiArIEthcmltDQo+IA0KPiBDaGVlcnMsDQo+IEFzaG9r
DQoKCgpBbWF6b24gRGV2ZWxvcG1lbnQgQ2VudGVyIEdlcm1hbnkgR21iSApLcmF1c2Vuc3RyLiAz
OAoxMDExNyBCZXJsaW4KR2VzY2hhZWZ0c2Z1ZWhydW5nOiBDaHJpc3RpYW4gU2NobGFlZ2VyLCBS
YWxmIEhlcmJyaWNoCkVpbmdldHJhZ2VuIGFtIEFtdHNnZXJpY2h0IENoYXJsb3R0ZW5idXJnIHVu
dGVyIEhSQiAxNDkxNzMgQgpTaXR6OiBCZXJsaW4KVXN0LUlEOiBERSAyODkgMjM3IDg3OQoKCg==

