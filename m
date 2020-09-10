Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6204E264FCA
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 21:51:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgIJTvl (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 15:51:41 -0400
Received: from mga03.intel.com ([134.134.136.65]:18236 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726794AbgIJTv2 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 10 Sep 2020 15:51:28 -0400
IronPort-SDR: qkLun57HLNNqi+/Anvgm9rXJyXHlrP37wHqMzXBf8gnFSInCpY0/2sI5ik0WjyIuQyJ+fr2RiB
 GnAnUyN65a1w==
X-IronPort-AV: E=McAfee;i="6000,8403,9740"; a="158663666"
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="158663666"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Sep 2020 12:51:11 -0700
IronPort-SDR: KshZsNOabrW+bjPtQiFlN35QYRd5Su/C13BRCGbDmWmo/+w1KoX7lWUQz4D0a0tdZtxg04nMzz
 GeAvUpAhgmFw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,413,1592895600"; 
   d="scan'208";a="334285838"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
  by orsmga008.jf.intel.com with ESMTP; 10 Sep 2020 12:51:08 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 10 Sep 2020 20:51:07 +0100
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 10 Sep 2020 12:51:06 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "refactormyself@gmail.com" <refactormyself@gmail.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Topic: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Index: AQHWd7clLgwBVuAUCESee06o/u7QiKlhsPgAgAD1HQCAABIhgIAAFHcAgAAHVwCAAAk+gA==
Date:   Thu, 10 Sep 2020 19:51:05 +0000
Message-ID: <4db0fbba635cd1ff5a3c1529d3c7fa08d0729756.camel@intel.com>
References: <20200910191740.GA806068@bjorn-Precision-5520>
In-Reply-To: <20200910191740.GA806068@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.213.168.175]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5C36C56CDB11DC4188DCEC7C1C697AEC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA5LTEwIGF0IDE0OjE3IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIFNlcCAxMCwgMjAyMCBhdCAwNjo1Mjo0OFBNICswMDAwLCBEZXJyaWNrLCBKb25h
dGhhbiB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMjAtMDktMTAgYXQgMTI6MzggLTA1MDAsIEJqb3Ju
IEhlbGdhYXMgd3JvdGU6DQo+ID4gPiBPbiBUaHUsIFNlcCAxMCwgMjAyMCBhdCAwNDozMzozOVBN
ICswMDAwLCBEZXJyaWNrLCBKb25hdGhhbiB3cm90ZToNCj4gPiA+ID4gT24gV2VkLCAyMDIwLTA5
LTA5IGF0IDIwOjU1IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gPiA+IE9uIEZy
aSwgQXVnIDIxLCAyMDIwIGF0IDA4OjMyOjIwUE0gKzA4MDAsIEthaS1IZW5nIEZlbmcgd3JvdGU6
DQo+ID4gPiA+ID4gPiBOZXcgSW50ZWwgbGFwdG9wcyB3aXRoIFZNRCBjYW5ub3QgcmVhY2ggZGVl
cGVyIHBvd2VyIHNhdmluZyBzdGF0ZSwNCj4gPiA+ID4gPiA+IHJlbmRlcnMgdmVyeSBzaG9ydCBi
YXR0ZXJ5IHRpbWUuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IEFzIEJJT1MgbWF5IG5vdCBi
ZSBhYmxlIHRvIHByb2dyYW0gdGhlIGNvbmZpZyBzcGFjZSBmb3IgZGV2aWNlcyB1bmRlcg0KPiA+
ID4gPiA+ID4gVk1EIGRvbWFpbiwgQVNQTSBuZWVkcyB0byBiZSBwcm9ncmFtbWVkIG1hbnVhbGx5
IGJ5IHNvZnR3YXJlLiBUaGlzIGlzDQo+ID4gPiA+ID4gPiBhbHNvIHRoZSBjYXNlIHVuZGVyIFdp
bmRvd3MuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFRoZSBWTUQgY29udHJvbGxlciBpdHNl
bGYgaXMgYSByb290IGNvbXBsZXggaW50ZWdyYXRlZCBlbmRwb2ludCB0aGF0DQo+ID4gPiA+ID4g
PiBkb2Vzbid0IGhhdmUgQVNQTSBjYXBhYmlsaXR5LCBzbyB3ZSBjYW4ndCBwcm9wYWdhdGUgdGhl
IEFTUE0gc2V0dGluZ3MgdG8NCj4gPiA+ID4gPiA+IGRldmljZXMgdW5kZXIgaXQuIEhlbmNlLCBz
aW1wbHkgYXBwbHkgQVNQTV9TVEFURV9BTEwgdG8gdGhlIGxpbmtzIHVuZGVyDQo+ID4gPiA+ID4g
PiBWTUQgZG9tYWluLCB1bnN1cHBvcnRlZCBzdGF0ZXMgd2lsbCBiZSBjbGVhcmVkIG91dCBhbnl3
YXkuDQo+ID4gPiA+ID4gPiANCj4gPiA+ID4gPiA+IFNpZ25lZC1vZmYtYnk6IEthaS1IZW5nIEZl
bmcgPGthaS5oZW5nLmZlbmdAY2Fub25pY2FsLmNvbT4NCj4gPiA+ID4gPiA+IC0tLQ0KPiA+ID4g
PiA+ID4gIGRyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIHwgIDMgKystDQo+ID4gPiA+ID4gPiAgZHJp
dmVycy9wY2kvcXVpcmtzLmMgICAgfCAxMSArKysrKysrKysrKw0KPiA+ID4gPiA+ID4gIGluY2x1
ZGUvbGludXgvcGNpLmggICAgIHwgIDIgKysNCj4gPiA+ID4gPiA+ICAzIGZpbGVzIGNoYW5nZWQs
IDE1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiA+ID4gPiA+IA0KPiA+ID4gPiA+
ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jIGIvZHJpdmVycy9wY2kvcGNp
ZS9hc3BtLmMNCj4gPiA+ID4gPiA+IGluZGV4IDI1M2MzMGNjMTk2Ny4uZGNjMDAyZGJjYTE5IDEw
MDY0NA0KPiA+ID4gPiA+ID4gLS0tIGEvZHJpdmVycy9wY2kvcGNpZS9hc3BtLmMNCj4gPiA+ID4g
PiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUvYXNwbS5jDQo+ID4gPiA+ID4gPiBAQCAtNjI0LDcg
KzYyNCw4IEBAIHN0YXRpYyB2b2lkIHBjaWVfYXNwbV9jYXBfaW5pdChzdHJ1Y3QgcGNpZV9saW5r
X3N0YXRlICpsaW5rLCBpbnQgYmxhY2tsaXN0KQ0KPiA+ID4gPiA+ID4gIAkJYXNwbV9jYWxjX2wx
c3NfaW5mbyhsaW5rLCAmdXByZWcsICZkd3JlZyk7DQo+ID4gPiA+ID4gPiAgDQo+ID4gPiA+ID4g
PiAgCS8qIFNhdmUgZGVmYXVsdCBzdGF0ZSAqLw0KPiA+ID4gPiA+ID4gLQlsaW5rLT5hc3BtX2Rl
ZmF1bHQgPSBsaW5rLT5hc3BtX2VuYWJsZWQ7DQo+ID4gPiA+ID4gPiArCWxpbmstPmFzcG1fZGVm
YXVsdCA9IHBhcmVudC0+ZGV2X2ZsYWdzICYgUENJX0RFVl9GTEFHU19FTkFCTEVfQVNQTSA/DQo+
ID4gPiA+ID4gPiArCQkJICAgICBBU1BNX1NUQVRFX0FMTCA6IGxpbmstPmFzcG1fZW5hYmxlZDsN
Cj4gPiA+ID4gPiANCj4gPiA+ID4gPiBUaGlzIGZ1bmN0aW9uIGlzIHJpZGljdWxvdXNseSBjb21w
bGljYXRlZCBhbHJlYWR5LCBhbmQgSSByZWFsbHkgZG9uJ3QNCj4gPiA+ID4gPiB3YW50IHRvIG1h
a2UgaXQgd29yc2UuDQo+ID4gPiA+ID4gDQo+ID4gPiA+ID4gV2hhdCBleGFjdGx5IGlzIHRoZSBQ
Q0llIHRvcG9sb2d5IGhlcmU/ICBBcHBhcmVudGx5IHRoZSBWTUQgY29udHJvbGxlcg0KPiA+ID4g
PiA+IGlzIGEgUm9vdCBDb21wbGV4IEludGVncmF0ZWQgRW5kcG9pbnQsIHNvIGl0J3MgYSBUeXBl
IDAgKG5vbi1icmlkZ2UpDQo+ID4gPiA+ID4gZGV2aWNlLiAgQW5kIGl0IGhhcyBubyBMaW5rLCBo
ZW5jZSBubyBMaW5rIENhcGFiaWxpdGllcyBvciBDb250cm9sIGFuZA0KPiA+ID4gPiA+IGhlbmNl
IG5vIEFTUE0tcmVsYXRlZCBiaXRzLiAgUmlnaHQ/DQo+ID4gPiA+IA0KPiA+ID4gPiBUaGF0J3Mg
Y29ycmVjdC4gVk1EIGlzIHRoZSBUeXBlIDAgZGV2aWNlIHByb3ZpZGluZyBjb25maWcvbW1pbw0K
PiA+ID4gPiBhcGVydHVyZXMgdG8gYW5vdGhlciBzZWdtZW50IGFuZCBNU0kvWCByZW1hcHBpbmcu
IE5vIGxpbmsgYW5kIG5vIEFTUE0NCj4gPiA+ID4gcmVsYXRlZCBiaXRzLg0KPiA+ID4gPiANCj4g
PiA+ID4gSGllcmFyY2h5IGlzIHVzdWFsbHkgc29tZXRoaW5nIGxpa2U6DQo+ID4gPiA+IA0KPiA+
ID4gPiBTZWdtZW50IDAgICAgICAgICAgIHwgVk1EIHNlZ21lbnQNCj4gPiA+ID4gUm9vdCBDb21w
bGV4IC0+IFZNRCB8IFR5cGUgMCAoUlAvQnJpZGdlOyBwaHlzaWNhbCBzbG90KSAtIFR5cGUgMQ0K
PiA+ID4gPiAgICAgICAgICAgICAgICAgICAgIHwgVHlwZSAwIChSUC9CcmlkZ2U7IHBoeXNpY2Fs
IHNsb3QpIC0gVHlwZSAxDQo+ID4gPiA+IA0KPiA+ID4gPiA+IEFuZCB0aGUgZGV2aWNlcyB1bmRl
ciB0aGUgVk1EIGNvbnRyb2xsZXI/ICBJIGd1ZXNzIHRoZXkgYXJlIHJlZ3VsYXINCj4gPiA+ID4g
PiBQQ0llIEVuZHBvaW50cywgU3dpdGNoIFBvcnRzLCBldGM/ICBPYnZpb3VzbHkgdGhlcmUncyBh
IExpbmsgaW52b2x2ZWQNCj4gPiA+ID4gPiBzb21ld2hlcmUuICBEb2VzIHRoZSBWTUQgY29udHJv
bGxlciBoYXZlIHNvbWUgbWFnaWMsIG5vbi1hcmNoaXRlY3RlZA0KPiA+ID4gPiA+IFBvcnQgb24g
dGhlIGRvd25zdHJlYW0gc2lkZT8NCj4gPiA+ID4gDQo+ID4gPiA+IENvcnJlY3Q6IFR5cGUgMCBh
bmQgVHlwZSAxIGRldmljZXMsIGFuZCBhbnkgbnVtYmVyIG9mIFN3aXRjaCBwb3J0cyBhcw0KPiA+
ID4gPiBpdCdzIHVzdWFsbHkgcGlubmVkIG91dCB0byBwaHlzaWNhbCBzbG90Lg0KPiA+ID4gPiAN
Cj4gPiA+ID4gPiBEb2VzIHRoaXMgcGF0Y2ggZW5hYmxlIEFTUE0gb24gdGhpcyBtYWdpYyBMaW5r
IGJldHdlZW4gVk1EIGFuZCB0aGUNCj4gPiA+ID4gPiBuZXh0IGRldmljZT8gIENvbmZpZ3VyaW5n
IEFTUE0gY29ycmVjdGx5IHJlcXVpcmVzIGtub3dsZWRnZSBhbmQga25vYnMNCj4gPiA+ID4gPiBm
cm9tIGJvdGggZW5kcyBvZiB0aGUgTGluaywgYW5kIGFwcGFyZW50bHkgd2UgZG9uJ3QgaGF2ZSB0
aG9zZSBmb3IgdGhlDQo+ID4gPiA+ID4gVk1EIGVuZC4NCj4gPiA+ID4gDQo+ID4gPiA+IFZNRCBp
dHNlbGYgZG9lc24ndCBoYXZlIHRoZSBsaW5rIHRvIGl0J3MgZG9tYWluLiBJdCdzIHJlYWxseSBq
dXN0IHRoZQ0KPiA+ID4gPiBjb25maWcvbW1pbyBhcGVydHVyZSBhbmQgTVNJL1ggcmVtYXBwZXIu
IFRoZSBQQ0llIGxpbmsgaXMgYmV0d2VlbiB0aGUNCj4gPiA+ID4gVHlwZSAwIGFuZCBUeXBlIDEg
ZGV2aWNlcyBvbiB0aGUgVk1EIGRvbWFpbi4gU28gZm9ydHVuYXRlbHkgdGhlIFZNRA0KPiA+ID4g
PiBpdHNlbGYgaXMgbm90IHRoZSB1cHN0cmVhbSBwYXJ0IG9mIHRoZSBsaW5rLg0KPiA+ID4gPiAN
Cj4gPiA+ID4gPiBPciBpcyBpdCBmb3IgTGlua3MgZGVlcGVyIGluIHRoZSBoaWVyYXJjaHk/ICBJ
IGFzc3VtZSB0aG9zZSBzaG91bGQNCj4gPiA+ID4gPiBqdXN0IHdvcmsgYWxyZWFkeSwgYWx0aG91
Z2ggdGhlcmUgbWlnaHQgYmUgaXNzdWVzIHdpdGggbGF0ZW5jeQ0KPiA+ID4gPiA+IGNvbXB1dGF0
aW9uLCBldGMuLCBiZWNhdXNlIHdlIG1heSBub3QgYmUgYWJsZSB0byBhY2NvdW50IGZvciB0aGUg
cGFydA0KPiA+ID4gPiA+IG9mIHRoZSBwYXRoIGFib3ZlIFZNRC4NCj4gPiA+ID4gDQo+ID4gPiA+
IFRoYXQncyBjb3JyZWN0LiBUaGlzIGlzIGZvciB0aGUgbGlua3Mgd2l0aGluIHRoZSBkb21haW4g
aXRzZWxmLCBzdWNoIGFzDQo+ID4gPiA+IGJldHdlZW4gYSB0eXBlIDAgYW5kIE5WTWUgZGV2aWNl
Lg0KPiA+ID4gDQo+ID4gPiBPSywgZ3JlYXQuICBTbyBJSVVDLCBiZWxvdyB0aGUgVk1ELCB0aGVy
ZSBpcyBhIFJvb3QgUG9ydCwgYW5kIHRoZSBSb290DQo+ID4gPiBQb3J0IGhhcyBhIGxpbmsgdG8g
c29tZSBFbmRwb2ludCBvciBTd2l0Y2gsIGUuZy4sIGFuIE5WTWUgZGV2aWNlLiAgQW5kDQo+ID4g
PiB3ZSBqdXN0IHdhbnQgdG8gZW5hYmxlIEFTUE0gb24gdGhhdCBsaW5rLg0KPiA+ID4gDQo+ID4g
PiBUaGF0IHNob3VsZCBub3QgYmUgYSBzcGVjaWFsIGNhc2U7IHdlIHNob3VsZCBiZSBhYmxlIHRv
IG1ha2UgdGhpcyBzbw0KPiA+ID4gaXQgSnVzdCBXb3Jrcy4gIEJhc2VkIG9uIHRoaXMgcGF0Y2gs
IEkgZ3Vlc3MgdGhlIHJlYXNvbiBpdCBkb2Vzbid0DQo+ID4gPiB3b3JrIGlzIGJlY2F1c2UgbGlu
ay0+YXNwbV9lbmFibGVkIGZvciB0aGF0IGxpbmsgaXNuJ3Qgc2V0IGNvcnJlY3RseS4NCj4gPiA+
IA0KPiA+ID4gU28gaXMgdGhpcyBqdXN0IGEgY29uc2VxdWVuY2Ugb2YgdXMgZGVwZW5kaW5nIG9u
IHRoZSBpbml0aWFsIExpbmsNCj4gPiA+IENvbnRyb2wgdmFsdWUgZnJvbSBCSU9TPyAgVGhhdCBz
ZWVtcyBsaWtlIHNvbWV0aGluZyB3ZSBzaG91bGRuJ3QNCj4gPiA+IHJlYWxseSBkZXBlbmQgb24u
DQpTZWVtcyBsaWtlIGEgZ29vZCBpZGVhLCB0aGF0IGl0IHNob3VsZCBpbnN0ZWFkIGJlIHF1aXJr
ZWQgaWYgQVNQTSBpcw0KZm91bmQgdW51c2FibGUgb24gYSBsaW5rLiBUaG91Z2ggSSdtIG5vdCBh
d2FyZSBvZiBob3cgbWFueSBwbGF0Zm9ybXMNCndvdWxkIHJlcXVpcmUgYSBxdWlyay4uDQoNCj4g
PiA+IA0KPiA+IFRoYXQncyB0aGUgY3J1eC4gVGhlcmUncyBhbHdheXMgcGNpZV9hc3BtPWZvcmNl
Lg0KPiA+IFNvbWV0aGluZyBJJ3ZlIHdvbmRlcmVkIGlzIGlmIHRoZXJlIGlzIGEgd2F5IHdlIGNv
dWxkICdkaXNjb3ZlcicgaWYgdGhlDQo+ID4gbGluayBpcyBBU1BNIHNhZmU/DQo+IA0KPiBTdXJl
LiAgTGluayBDYXBhYmlsaXRpZXMgaXMgc3VwcG9zZWQgdG8gdGVsbCB1cyB0aGF0LiAgSWYgYXNw
bS5jDQo+IGRlcGVuZHMgb24gdGhlIEJJT1Mgc2V0dGluZ3MsIEkgdGhpbmsgdGhhdCdzIGEgZGVz
aWduIG1pc3Rha2UuDQo+IA0KPiBCdXQgd2hhdCBDT05GSUdfUENJRUFTUE1fKiBzZXR0aW5nIGFy
ZSB5b3UgdXNpbmc/ICBUaGUgZGVmYXVsdA0KPiBpcyBDT05GSUdfUENJRUFTUE1fREVGQVVMVCwg
d2hpY2ggbGl0ZXJhbGx5IG1lYW5zICJVc2UgdGhlIEJJT1MNCj4gZGVmYXVsdHMiLiAgSWYgeW91
J3JlIHVzaW5nIHRoYXQsIGFuZCBCSU9TIGRvZXNuJ3QgZW5hYmxlIEFTUE0gYmVsb3cNCj4gVk1E
LCBJIGd1ZXNzIGFzcG0uYyB3aWxsIGxlYXZlIGl0IGRpc2FibGVkLCBhbmQgdGhhdCBzZWVtcyBs
aWtlIGl0DQo+IHdvdWxkIGJlIHRoZSBleHBlY3RlZCBiZWhhdmlvci4NCj4gDQo+IERvZXMgInBj
aWVfYXNwbT1mb3JjZSIgcmVhbGx5IGhlbHAgeW91PyAgSSBkb24ndCBzZWUgYW55IHVzZXMgb2Yg
aXQNCj4gdGhhdCBzaG91bGQgYXBwbHkgdG8geW91ciBzaXR1YXRpb24uDQo+IA0KPiBCam9ybg0K
DQpObyB5b3UncmUgcmlnaHQuIEkgZG9uJ3QgdGhpbmsgd2UgbmVlZCBwY2llX2FzcG09Zm9yY2Us
IGp1c3QgdGhlIHBvbGljeQ0KY29uZmlndXJhdGlvbi4NCg==
