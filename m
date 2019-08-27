Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2686E9F241
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2019 20:24:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730104AbfH0SYH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Aug 2019 14:24:07 -0400
Received: from mga18.intel.com ([134.134.136.126]:2324 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729779AbfH0SYH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 27 Aug 2019 14:24:07 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 27 Aug 2019 11:24:06 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.64,438,1559545200"; 
   d="scan'208";a="171282551"
Received: from orsmsx107.amr.corp.intel.com ([10.22.240.5])
  by orsmga007.jf.intel.com with ESMTP; 27 Aug 2019 11:24:06 -0700
Received: from orsmsx154.amr.corp.intel.com (10.22.226.12) by
 ORSMSX107.amr.corp.intel.com (10.22.240.5) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Tue, 27 Aug 2019 11:24:06 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.119]) by
 ORSMSX154.amr.corp.intel.com ([169.254.11.172]) with mapi id 14.03.0439.000;
 Tue, 27 Aug 2019 11:24:06 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@lst.de" <hch@lst.de>, "x86@kernel.org" <x86@kernel.org>
CC:     "joro@8bytes.org" <joro@8bytes.org>,
        "Busch, Keith" <keith.busch@intel.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "dwmw2@infradead.org" <dwmw2@infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] vmd: Stop overriding dma_map_ops
Thread-Topic: [PATCH] vmd: Stop overriding dma_map_ops
Thread-Index: AQHVXB/0iQzKFLmxFEGBMerx1QuVCqcPxk4A
Date:   Tue, 27 Aug 2019 18:24:05 +0000
Message-ID: <8cad7eb5b5b37aeb041fd0c464383bb5223e4a64.camel@intel.com>
References: <20190826150652.10316-1-hch@lst.de>
In-Reply-To: <20190826150652.10316-1-hch@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.165]
Content-Type: text/plain; charset="utf-8"
Content-ID: <CBA8577B2F8C794E8AE831CFFD893777@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTI2IGF0IDE3OjA2ICswMjAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gV2l0aCBhIGxpdHRsZSB0d2VhayB0byB0aGUgaW50ZWwtaW9tbXUgY29kZSB3ZSBzaG91
bGQgYmUgYWJsZSB0byB3b3JrDQo+IGFyb3VuZCB0aGUgVk1EIG1lc3MgZm9yIHRoZSByZXF1ZXN0
ZXIgSURzIHdpdGhvdXQgaGF2aW5nIHRvIGNyZWF0ZSBnaWFudA0KPiBhbW91bnRzIG9mIGJvaWxl
cnBsYXRlIERNQSBvcHMgd3JhcHBpbmcgY29kZS4gIFRoZSBvdGhlciBhZHZhbnRhZ2Ugb2YNCj4g
dGhpcyBzY2hlbWUgaXMgdGhhdCB3ZSBjYW4gcmVzcGVjdCB0aGUgcmVhbCBETUEgbWFza3MgZm9y
IHRoZSBhY3R1YWwNCj4gZGV2aWNlcywgYW5kIEkgYmV0IGl0IHdpbGwgb25seSBiZSBhIG1hdHRl
ciBvZiB0aW1lIHVudGlsIHdlJ2xsIHNlZSB0aGUNCj4gZmlyc3QgRE1BIGNoYWxsZW5lZ2VkIE5W
TWUgZGV2aWNlcy4NCj4gDQo+IFRoZSBvbmx5IGRvd25zaWRlIGlzIHRoYXQgd2UgY2FuJ3Qgb2Zm
ZXIgdm1kIGFzIGEgbW9kdWxlIGdpdmVuIHRoYXQNCj4gaW50ZWwtaW9tbXUgY2FsbHMgaW50byBp
dC4gIEJ1dCB0aGUgZHJpdmVyIG9ubHkgaGFzIGFib3V0IDcwMCBsaW5lcw0KPiBvZiBjb2RlLCBz
byB0aGlzIHNob3VsZCBub3QgYmUgYSBtYWpvciBpc3N1ZS4NCklmIHdlJ3JlIGdvaW5nIHRvIHJl
bW92ZSBpdHMgYWJpbGl0eSB0byBiZSBhIG1vZHVsZSwgYW5kIGdpdmVuIGl0cw0Kc21hbGwgc2l6
ZSwgY291bGQgd2UgbWFrZSB0aGlzIGRlZmF1bHQgPXk/DQoNCk90aGVyd2lzZSB3ZSByaXNrIGJy
ZWFraW5nIHBsYXRmb3JtcyB3aGljaCBoYXZlIGl0IGVuYWJsZWQgd2l0aCBPU1ZzDQp3aG8gbWlz
cyBlbmFibGluZyBpdA0KDQoNCj4gDQo+IFRoaXMgYWxzbyByZW1vdmVzIHRoZSBsZWZ0b3ZlciBi
aXRzIG9mIHRoZSBYODZfREVWX0RNQV9PUFMgZG1hX21hcF9vcHMNCj4gcmVnaXN0cnkuDQo+IA0K
PiBTaWduZWQtb2ZmLWJ5OiBDaHJpc3RvcGggSGVsbHdpZyA8aGNoQGxzdC5kZT4NCj4gDQoNCmxn
dG0gb3RoZXJ3aXNlDQoNClJldmlld2VkLWJ5OiBKb24gRGVycmljayA8am9uYXRoYW4uZGVycmlj
a0BpbnRlbC5jb20+DQo=
