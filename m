Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5552C1A6968
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 18:08:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731260AbgDMQI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 12:08:28 -0400
Received: from mga09.intel.com ([134.134.136.24]:46949 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731231AbgDMQI0 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Apr 2020 12:08:26 -0400
IronPort-SDR: 3E/O2tx9Jc0h95g8fqadsGBaX6/hpDn2vaks8l2OnpZsL6SVy3txS1Uyno+XwAUV6wwhF6vqKG
 koDg30+dVFlg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 09:08:17 -0700
IronPort-SDR: AtFFhp8S7rumfycaYYh+yKRUS57LlGaHKanXMToLuDp8lsQWCJ+C9Rc5oGIx5Ek+dW6G0z+zaq
 pNw/I478q4gw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="363109095"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2020 09:08:16 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX105.amr.corp.intel.com ([169.254.2.15]) with mapi id 14.03.0439.000;
 Mon, 13 Apr 2020 09:08:16 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "drake@endlessm.com" <drake@endlessm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
Thread-Topic: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices
 and subdevices
Thread-Index: AQHWDqWd+ubRYvzlTkCJBotC6+FAWah1UvmAgAJgjoA=
Date:   Mon, 13 Apr 2020 16:08:16 +0000
Message-ID: <3dc512548fbd40bd00c14ee237eaf293e3d1ecde.camel@intel.com>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
         <20200409191736.6233-2-jonathan.derrick@intel.com>
         <CAD8Lp442LO1Sq5xpKOaRUKLsEyGbou4TiHQrDdnMbCOV-TG0+g@mail.gmail.com>
In-Reply-To: <CAD8Lp442LO1Sq5xpKOaRUKLsEyGbou4TiHQrDdnMbCOV-TG0+g@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <9B343A591B4C844FB4371E1F47CE2845@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU3VuLCAyMDIwLTA0LTEyIGF0IDExOjUwICswODAwLCBEYW5pZWwgRHJha2Ugd3JvdGU6DQo+
IEhpIEpvbiwNCj4gDQo+IFRoYW5rcyBmb3IgcGlja2luZyB0aGlzIHVwLiBBcG9sb2dpZXMgZm9y
IG15IGFic2VuY2UgaGVyZSAtIEkgd2Fzbid0DQo+IGFibGUgdG8gd29yayBvbiB0aGlzIHJlY2Vu
dGx5LCBidXQgSSdtIGJhY2sgYWdhaW4gbm93Lg0KPiANCj4gT24gRnJpLCBBcHIgMTAsIDIwMjAg
YXQgMzozMiBBTSBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlja0BpbnRlbC5jb20+IHdyb3Rl
Og0KPiA+IFRoaXMgYmVjb21lcyBwcm9ibGVtYXRpYyBpZiB0aGUgcmVhbCBETUEgZGV2aWNlIGFu
ZCB0aGUgc3ViZGV2aWNlcyBoYXZlDQo+ID4gZGlmZmVyZW50IGFkZHJlc3NpbmcgY2FwYWJpbGl0
aWVzIGFuZCBzb21lIHJlcXVpcmUgdHJhbnNsYXRpb24uIEluc3RlYWQgd2UgY2FuDQo+ID4gcHV0
IHRoZSByZWFsIERNQSBkZXYgYW5kIGFueSBzdWJkZXZpY2VzIG9uIHRoZSBETUEgZG9tYWluLiBU
aGlzIGNoYW5nZSBhc3NpZ25zDQo+ID4gc3ViZGV2aWNlcyB0byB0aGUgRE1BIGRvbWFpbiwgYW5k
IG1vdmVzIHRoZSByZWFsIERNQSBkZXZpY2UgdG8gdGhlIERNQSBkb21haW4NCj4gPiBpZiBuZWNl
c3NhcnkuDQo+IA0KPiBIYXZlIHlvdSB0ZXN0ZWQgdGhpcyB3aXRoIHRoZSByZWFsIERNQSBkZXZp
Y2UgaW4gaWRlbnRpdHkgbW9kZT8NCj4gSXQgaXMgbm90IHF1aXRlIHdvcmtpbmcgZm9yIG1lLiAo
QWdhaW4sIEknbSBub3QgdXNpbmcgVk1EIGhlcmUsIGJ1dA0KPiBoYXZlIGxvb2tlZCBjbG9zZWx5
IGFuZCBiZWxpZXZlIHdlJ3JlIHdvcmtpbmcgdW5kZXIgdGhlIHNhbWUNCj4gY29uc3RyYWludHMp
DQoNCkl0IGRvZXMgd29yayBmb3IgbWUgd2hlbiByZWFsIERNQSBkZXZpY2Ugc3RhcnRzIGluIElk
ZW50aXR5LCBidXQgbXkNCidyZWFsIERNQSBkZXZpY2UnIGRvZXNuJ3QgZG8gdGhlIERNQS4gSXQg
anVzdCBwcm92aWRlcyB0aGUgc291cmNlLWlkLg0KDQpEb2VzIHlvdXIgJ3JlYWwgRE1BIGRldmlj
ZScgZG8gRE1BPw0KSSBzdXBwb3NlIHRoYXQgY291bGQgYmUgdGhlIHJlYXNvbi4gWW91IHdvdWxk
bid0IHdhbnQgdG8gY2hhbmdlIHRoZQ0KZG9tYWluIG9uIHRoZSBsaXZlIGRldmljZSB1c2luZyB0
aGUgbWV0aG9kIEkgcHJvcG9zZWQuDQoNCj4gDQo+IEZpcnN0LCB0aGUgcmVhbCBETUEgZGV2aWNl
IGdldHMgYWRkZWQgdG8gdGhlIGdyb3VwOg0KPiAgcGNpIDAwMDA6MDA6MTcuMDogQWRkaW5nIHRv
IGlvbW11IGdyb3VwIDkNCj4gKGl0J3MgaW4gSURFTlRJVFkgbW9kZSBoZXJlKQ0KPiANCj4gVGhl
biBsYXRlciwgdGhlIGZpcnN0IHN1YmRldmljZSBjb21lcyBhbG9uZywgYW5kIHRoZXNlIGFyZSB0
aGUgcmVzdWx0czoNCj4gIHBjaSAxMDAwMDowMDowMC4wOiBbODA4NjowMmQ3XSB0eXBlIDAwIGNs
YXNzIDB4MDEwNjAxDQo+ICBwY2kgMTAwMDA6MDA6MDAuMDogcmVnIDB4MTA6IFttZW0gMHhhZTFh
MDAwMC0weGFlMWE3ZmZmXQ0KPiAgcGNpIDEwMDAwOjAwOjAwLjA6IHJlZyAweDE0OiBbbWVtIDB4
YWUxYTgwMDAtMHhhZTFhODBmZl0NCj4gIHBjaSAxMDAwMDowMDowMC4wOiByZWcgMHgxODogW2lv
ICAweDMwOTAtMHgzMDk3XQ0KPiAgcGNpIDEwMDAwOjAwOjAwLjA6IHJlZyAweDFjOiBbaW8gIDB4
MzA4MC0weDMwODNdDQo+ICBwY2kgMTAwMDA6MDA6MDAuMDogcmVnIDB4MjA6IFtpbyAgMHgzMDYw
LTB4MzA3Zl0NCj4gIHBjaSAxMDAwMDowMDowMC4wOiByZWcgMHgyNDogW21lbSAweGFlMTAwMDAw
LTB4YWUxMDNmZmZdDQo+ICBwY2kgMTAwMDA6MDA6MDAuMDogUE1FIyBzdXBwb3J0ZWQgZnJvbSBE
M2hvdA0KPiAgcGNpIDEwMDAwOjAwOjAwLjA6IEFkZGluZyB0byBpb21tdSBncm91cCA5DQo+ICBw
Y2kgMTAwMDA6MDA6MDAuMDogRE1BUjogRmFpbGVkIHRvIGdldCBhIHByaXZhdGUgZG9tYWluLg0K
PiANCj4gVGhhdCBmaW5hbCBtZXNzYWdlIGlzIGFkZGVkIGJ5IHlvdXIgcGF0Y2ggYW5kIGluZGlj
YXRlcyB0aGF0IGl0J3Mgbm90IHdvcmtpbmcuDQo+IA0KPiBUaGlzIGlzIGJlY2F1c2UgdGhlIHN1
YmRldmljZSBnb3QgYWRkZWQgdG8gdGhlIGlvbW11IGdyb3VwIGJlZm9yZSB0aGUNCj4gY29kZSB5
b3UgYWRkZWQgdHJpZWQgdG8gY2hhbmdlIHRvIHRoZSBETUEgZG9tYWluLg0KPiANCj4gSXQgZmly
c3QgZ2V0cyBhZGRlZCB0byB0aGUgZ3JvdXAgdGhyb3VnaCB0aGlzIGNhbGwgcGF0aDoNCj4gICAg
IGludGVsX2lvbW11X2FkZF9kZXZpY2UNCj4gLT4gaW9tbXVfZ3JvdXBfZ2V0X2Zvcl9kZXYNCj4g
LT4gaW9tbXVfZ3JvdXBfYWRkX2RldmljZQ0KPiANCj4gVGhlbiwgY29udGludWluZyB3aXRoaW4g
aW50ZWxfaW9tbXVfYWRkX2RldmljZSB3ZSBnZXQgdG8gdGhlIGNvZGUgeW91DQo+IGFkZGVkLCB3
aGljaCB0cmllcyB0byBtb3ZlIHRoZSByZWFsIERNQSBkZXYgdG8gRE1BIG1vZGUgaW5zdGVhZC4g
SXQNCj4gY2FsbHM6DQo+IA0KPiAgICBpbnRlbF9pb21tdV9yZXF1ZXN0X2RtYV9kb21haW5fZm9y
X2Rldg0KPiAtPiBpb21tdV9yZXF1ZXN0X2RtYV9kb21haW5fZm9yX2Rldg0KPiAtPiByZXF1ZXN0
X2RlZmF1bHRfZG9tYWluX2Zvcl9kZXYNCj4gDQo+IFdoaWNoIGZhaWxzIGhlcmU6DQo+ICAgICAv
KiBEb24ndCBjaGFuZ2UgbWFwcGluZ3Mgb2YgZXhpc3RpbmcgZGV2aWNlcyAqLw0KPiAgICAgcmV0
ID0gLUVCVVNZOw0KPiAgICAgaWYgKGlvbW11X2dyb3VwX2RldmljZV9jb3VudChncm91cCkgIT0g
MSkNCj4gICAgICAgICBnb3RvIG91dDsNCj4gDQo+IGJlY2F1c2Ugd2UgYWxyZWFkeSBoYXZlIDIg
ZGV2aWNlcyBpbiB0aGUgZ3JvdXAgKHRoZSByZWFsIERNQSBkZXYsIHBsdXMNCj4gdGhlIHN1YmRl
dmljZSB3ZSdyZSBpbiB0aGUgcHJvY2VzcyBvZiBoYW5kbGluZyBub3cpLg0KPiANCg0KWW91J3Jl
IHJpZ2h0LiBJIHNlZSB0aGUgbWVzc2FnZSB0b28sIGJ1dCBpdCBzdGlsbCB3b3JrcyBmb3IgbWUu
DQoNCj4gTmV4dCBJJ2xsIGxvb2sgaW50byB0aGUgaW9tbXUgZ3JvdXAgcmV3b3JrIHRoYXQgQmFv
bHUgbWVudGlvbmVkLg0KPiANCj4gVGhhbmtzLA0KPiBEYW5pZWwNCg==
