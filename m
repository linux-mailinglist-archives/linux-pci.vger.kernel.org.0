Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 972E1135C40
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jan 2020 16:08:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732121AbgAIPIO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 9 Jan 2020 10:08:14 -0500
Received: from mga02.intel.com ([134.134.136.20]:65212 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729054AbgAIPIN (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 9 Jan 2020 10:08:13 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 09 Jan 2020 07:08:13 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,414,1571727600"; 
   d="scan'208";a="216325838"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga008.jf.intel.com with ESMTP; 09 Jan 2020 07:08:13 -0800
Received: from orsmsx114.amr.corp.intel.com (10.22.240.10) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 9 Jan 2020 07:08:12 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.147]) by
 ORSMSX114.amr.corp.intel.com ([169.254.8.106]) with mapi id 14.03.0439.000;
 Thu, 9 Jan 2020 07:08:12 -0800
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
Subject: Re: [RFC 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Topic: [RFC 4/5] PCI: vmd: Stop overriding dma_map_ops
Thread-Index: AQHVwEr2z5uOBWDiDkm1r7T32HJ+B6fi+c6AgAAI7gA=
Date:   Thu, 9 Jan 2020 15:08:11 +0000
Message-ID: <a75078a7a12f17c37782afd55bb97fece63752d5.camel@intel.com>
References: <1577823863-3303-1-git-send-email-jonathan.derrick@intel.com>
         <1577823863-3303-5-git-send-email-jonathan.derrick@intel.com>
         <20200109143613.GC22656@lst.de>
In-Reply-To: <20200109143613.GC22656@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.4.146]
Content-Type: text/plain; charset="utf-8"
Content-ID: <103EAB059B28094091CCBFEC61F26E7D@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTA5IGF0IDE1OjM2ICswMTAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gVHVlLCBEZWMgMzEsIDIwMTkgYXQgMDE6MjQ6MjJQTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gRGV2aWNlcyBvbiB0aGUgVk1EIGRvbWFpbiB1c2UgdGhlIFZNRCBlbmRw
b2ludCdzIHJlcXVlc3Rlci1pZCBhbmQgaGF2ZQ0KPiA+IGJlZW4gcmVseWluZyBvbiB0aGUgVk1E
IGVuZHBvaW50J3MgZG1hIG9wZXJhdGlvbnMuIFRoZSBkb3duc2lkZSBvZiB0aGlzDQo+ID4gd2Fz
IHRoYXQgVk1EIGRvbWFpbiBkZXZpY2VzIHdvdWxkIHVzZSB0aGUgVk1EIGVuZHBvaW50J3MgYXR0
cmlidXRlcyB3aGVuDQo+ID4gZG9pbmcgRE1BIGFuZCBJT01NVSBtYXBwaW5nLiBXZSBjYW4gYmUg
c21hcnRlciBhYm91dCB0aGlzIGJ5IG9ubHkgdXNpbmcNCj4gPiB0aGUgVk1EIGVuZHBvaW50IHdo
ZW4gbWFwcGluZyBhbmQgcHJvdmlkaW5nIHRoZSBjb3JyZWN0IGNoaWxkIGRldmljZSdzDQo+ID4g
YXR0cmlidXRlcyBkdXJpbmcgZG1hIG9wZXJhdGlvbnMuDQo+ID4gDQo+ID4gVGhpcyBwYXRjaCBh
ZGRzIGEgbmV3IGRtYSBhbGlhcyBtZWNoYW5pc20gYnkgYWRkaW5nIGEgaGludCB0byBhIHBjaV9k
ZXYNCj4gPiB0byBwb2ludCB0byBhIHNpbmd1bGFyIERNQSByZXF1ZXN0ZXIncyBwY2lfZGV2LiBU
aGlzIGludGVncmF0ZXMgaW50byB0aGUNCj4gPiBleGlzdGluZyBkbWEgYWxpYXMgaW5mcmFzdHJ1
Y3R1cmUgdG8gcmVkdWNlIHRoZSBpbXBhY3Qgb2YgdGhlIGNoYW5nZXMNCj4gPiByZXF1aXJlZCB0
byBzdXBwb3J0IHRoaXMgbW9kZS4NCj4gDQo+IElmIHdlIHdhbnQgdG8gbGlmdCB0aGlzIGNoZWNr
IGludG8gY29tbW9uIGNvZGUgSSB0aGluayBpdCBzaG91bGQgZ28NCj4gaW50byBzdHJ1Y3QgZGV2
aWNlLCBhcyB0aGF0IGlzIHdoYXQgRE1BIG9wZXJhdGVzIG9uIG5vcm1hbGx5Lg0KSSB0aG91Z2h0
IGFib3V0IHRoYXQgdG9vLCBidXQgdGhlIGRtYSBhbGlhcyBtZWNoYW5pc20gd2FzIGluIHBjaV9k
ZXYuIEkNCmNhbiBwcmVwYXJlIGEgbmV3IHZlcnNpb24gd2l0aCBzdHJ1Y3QgZGV2aWNlLg0KDQo+
ICAgVGhhdA0KPiBiZWluZyBzYWlkIGdpdmVuIHRoYXQgdGhpcyBpbnNhbmUgaGFjayBvbmx5IGV4
aXN0cyBmb3IgYnJhaW5kYW1hZ2UgaW4NCj4gSW50ZWwgaGFyZHdhcmUgSSdkIHJhdGhlciBrZWVw
IGl0IGFzIGlzb2xhdGVkIGFzIHBvc3NpYmxlLiANCmptaG8gYnV0IHRoZSBmb290cHJpbnQgb2Yg
dGhlIG5ldyBzZXQgaXMgcHJldHR5IG1pbmltYWwgYW5kIHJlbW92ZXMgYQ0KbG90IG9mIGR1Ymlv
dXMgY29kZSBpbiB2bWQuYy4NCg==
