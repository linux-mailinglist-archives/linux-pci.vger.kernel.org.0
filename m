Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 11AFB1A696A
	for <lists+linux-pci@lfdr.de>; Mon, 13 Apr 2020 18:08:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731231AbgDMQI2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Apr 2020 12:08:28 -0400
Received: from mga04.intel.com ([192.55.52.120]:27145 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731259AbgDMQI1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 13 Apr 2020 12:08:27 -0400
IronPort-SDR: cbHgEn7JBVX1fx3Nbm+j3xm01vEYDHkpBpMlhdAcqs4A++1QIfFXCmbxPptjeeakRCZrOZB6MW
 p9owwQvSIbFQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Apr 2020 09:08:24 -0700
IronPort-SDR: +IdGpKVquQIPGC53fqDyu0ehYjNXf1exj6H17B6VKPtrbZUcRuA7zc3U2lPTYlbrGxO4W+afW1
 Nbb47dSbwuRQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,378,1580803200"; 
   d="scan'208";a="363109124"
Received: from orsmsx105.amr.corp.intel.com ([10.22.225.132])
  by fmsmga001.fm.intel.com with ESMTP; 13 Apr 2020 09:08:24 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX105.amr.corp.intel.com (10.22.225.132) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 13 Apr 2020 09:08:23 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.99]) with mapi id 14.03.0439.000;
 Mon, 13 Apr 2020 09:08:23 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "baolu.lu@linux.intel.com" <baolu.lu@linux.intel.com>,
        "drake@endlessm.com" <drake@endlessm.com>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "joro@8bytes.org" <joro@8bytes.org>,
        "linux@endlessm.com" <linux@endlessm.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>
Subject: Re: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices and
 subdevices
Thread-Topic: [PATCH 1/1] iommu/vt-d: use DMA domain for real DMA devices
 and subdevices
Thread-Index: AQHWDqWd+ubRYvzlTkCJBotC6+FAWahyBPQAgATIvQCAAAaBgIAA31yA
Date:   Mon, 13 Apr 2020 16:08:22 +0000
Message-ID: <a83908feee589be7922b069e802770b363cb5b2f.camel@intel.com>
References: <20200409191736.6233-1-jonathan.derrick@intel.com>
         <20200409191736.6233-2-jonathan.derrick@intel.com>
         <09c98569-ed22-8886-3372-f5752334f8af@linux.intel.com>
         <CAD8Lp45dJ3-t6qqctiP1a=c44PEWZ-L04yv0r0=1Nrvwfouz1w@mail.gmail.com>
         <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
In-Reply-To: <32cc4809-7029-bc5e-5a74-abbe43596e8d@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.111]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F10BAF6423A26D44B521F52F13B7FD08@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTA0LTEzIGF0IDEwOjQ4ICswODAwLCBMdSBCYW9sdSB3cm90ZToNCj4gSGkg
RGFuaWVsLA0KPiANCj4gT24gMjAyMC80LzEzIDEwOjI1LCBEYW5pZWwgRHJha2Ugd3JvdGU6DQo+
ID4gT24gRnJpLCBBcHIgMTAsIDIwMjAgYXQgOToyMiBBTSBMdSBCYW9sdSA8YmFvbHUubHVAbGlu
dXguaW50ZWwuY29tPiB3cm90ZToNCj4gPiA+IFRoaXMgaXMgY2F1c2VkIGJ5IHRoZSBmcmFnaWxl
IHByaXZhdGUgZG9tYWluIGltcGxlbWVudGF0aW9uLiBXZSBhcmUgaW4NCj4gPiA+IHByb2Nlc3Mg
b2YgcmVtb3ZpbmcgaXQgYnkgZW5oYW5jaW5nIHRoZSBpb21tdSBzdWJzeXN0ZW0gd2l0aCBwZXIt
Z3JvdXANCj4gPiA+IGRlZmF1bHQgZG9tYWluLg0KPiA+ID4gDQo+ID4gPiBodHRwczovL3d3dy5z
cGluaWNzLm5ldC9saXN0cy9pb21tdS9tc2c0Mjk3Ni5odG1sDQo+ID4gPiANCj4gPiA+IFNvIHVs
dGltYXRlbHkgVk1EIHN1YmRldmljZXMgc2hvdWxkIGhhdmUgdGhlaXIgb3duIHBlci1kZXZpY2Ug
aW9tbXUgZGF0YQ0KPiA+ID4gYW5kIHN1cHBvcnQgcGVyLWRldmljZSBkbWEgb3BzLg0KPiA+IA0K
PiA+IEludGVyZXN0aW5nLiBUaGVyZSdzIGFsc28gdGhpcyBwYXRjaHNldCB5b3UgcG9zdGVkOg0K
PiA+IFtQQVRDSCAwMC8xOV0gW1BVTEwgUkVRVUVTVF0gaW9tbXUvdnQtZDogcGF0Y2hlcyBmb3Ig
djUuNw0KPiA+IGh0dHBzOi8vbGlzdHMubGludXhmb3VuZGF0aW9uLm9yZy9waXBlcm1haWwvaW9t
bXUvMjAyMC1BcHJpbC8wNDI5NjcuaHRtbA0KPiA+ICh0byBiZSBwdXNoZWQgb3V0IHRvIDUuOCkN
Cj4gDQo+IEJvdGggYXJlIHRyeWluZyB0byBzb2x2ZSBhIHNhbWUgcHJvYmxlbS4NCj4gDQo+IEkg
aGF2ZSBzeW5jJ2VkIHdpdGggSm9lcmcuIFRoaXMgcGF0Y2ggc2V0IHdpbGwgYmUgcmVwbGFjZWQg
d2l0aCBKb2VyZydzDQo+IHByb3Bvc2FsIGR1ZSB0byBhIHJhY2UgY29uY2VybiBiZXR3ZWVuIGRv
bWFpbiBzd2l0Y2hpbmcgYW5kIGRyaXZlcg0KPiBiaW5kaW5nLiBJIHdpbGwgcmViYXNlIGFsbCB2
dC1kIHBhdGNoZXMgaW4gdGhpcyBzZXQgb24gdG9wIG9mIEpvZXJnJ3MNCj4gY2hhbmdlLg0KPiAN
Cj4gQmVzdCByZWdhcmRzLA0KPiBiYW9sdQ0KPiANClRoYW5rcyBCYW9sdS4gSSdsbCBwaWNrIHRo
aXMgYmFjayB1cCBvbiB0b3Agb2YgdGhlIGZvci01LjggY2hhbmdlcy4NCg0KDQo+ID4gSW4gdGhl
cmUgeW91IGhhdmU6DQo+ID4gPiBpb21tdS92dC1kOiBEb24ndCBmb3JjZSAzMmJpdCBkZXZpY2Vz
IHRvIHVzZXMgRE1BIGRvbWFpbg0KPiA+IHdoaWNoIHNlZW1zIHRvIGNsYXNoIHdpdGggdGhlIGFw
cHJvYWNoIGJlaW5nIGV4cGxvcmVkIGluIHRoaXMgdGhyZWFkLg0KPiA+IA0KPiA+IEFuZDoNCj4g
PiA+IGlvbW11L3Z0LWQ6IEFwcGx5IHBlci1kZXZpY2UgZG1hX29wcw0KPiA+IFRoaXMgZWZmZWN0
aXZlbHkgc29sdmVzIHRoZSB0cmlwIHBvaW50IHRoYXQgY2F1c2VkIG1lIHRvIG9wZW4gdGhlc2UN
Cj4gPiBkaXNjdXNzaW9ucywgd2hlcmUgaW50ZWxfbWFwX3BhZ2UoKSAtPiBpb21tdV9uZWVkX21h
cHBpbmcoKSB3b3VsZA0KPiA+IGluY29ycmVjdGx5IGRldGVybWluZSB0aGF0IGEgaW50ZWwtaW9t
bXUgRE1BIG1hcHBpbmcgd2FzIG5lZWRlZCBmb3IgYQ0KPiA+IFBDSSBzdWJkZXZpY2UgcnVubmlu
ZyBpbiBpZGVudGl0eSBtb2RlLiBBZnRlciB0aGlzIHBhdGNoLCBhIFBDSQ0KPiA+IHN1YmRldmlj
ZSBpbiBpZGVudGl0eSBtb2RlIHVzZXMgdGhlIGRlZmF1bHQgc3lzdGVtIGRtYV9vcHMgYW5kDQo+
ID4gY29tcGxldGVseSBhdm9pZHMgaW50ZWwtaW9tbXUuDQo+ID4gDQo+ID4gU28gdGhhdCBzb2x2
ZXMgdGhlIGlzc3VlcyBJIHdhcyBsb29raW5nIGF0LiBKb24sIHlvdSBtaWdodCB3YW50IHRvDQo+
ID4gY2hlY2sgaWYgdGhlIHByb2JsZW1zIHlvdSBzZWUgYXJlIGxpa2V3aXNlIHNvbHZlZCBmb3Ig
eW91IGJ5IHRoZXNlDQo+ID4gcGF0Y2hlcy4NCj4gPiANCj4gPiBJIGRpZG4ndCB0cnkgSm9lcmcn
cyBpb21tdSBncm91cCByZXdvcmsgeWV0IGFzIGl0IGNvbmZsaWN0cyB3aXRoIHRob3NlDQo+ID4g
cGF0Y2hlcyBhYm92ZS4NCj4gPiANCj4gPiBEYW5pZWwNCj4gPiANCg==
