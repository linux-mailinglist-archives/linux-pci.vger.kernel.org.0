Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 686A21580B8
	for <lists+linux-pci@lfdr.de>; Mon, 10 Feb 2020 18:10:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728071AbgBJRKB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 10 Feb 2020 12:10:01 -0500
Received: from mga14.intel.com ([192.55.52.115]:2424 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727628AbgBJRKB (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 10 Feb 2020 12:10:01 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Feb 2020 09:10:00 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,425,1574150400"; 
   d="scan'208";a="221621078"
Received: from orsmsx102.amr.corp.intel.com ([10.22.225.129])
  by orsmga007.jf.intel.com with ESMTP; 10 Feb 2020 09:10:00 -0800
Received: from orsmsx151.amr.corp.intel.com (10.22.226.38) by
 ORSMSX102.amr.corp.intel.com (10.22.225.129) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Mon, 10 Feb 2020 09:10:00 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.110]) by
 ORSMSX151.amr.corp.intel.com ([169.254.7.116]) with mapi id 14.03.0439.000;
 Mon, 10 Feb 2020 09:09:59 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@lst.de" <hch@lst.de>
CC:     "Shevchenko, Andriy" <andriy.shevchenko@intel.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Baldysiak, Pawel" <pawel.baldysiak@intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "mr.nuke.me@gmail.com" <mr.nuke.me@gmail.com>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "okaya@kernel.org" <okaya@kernel.org>
Subject: Re: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Thread-Topic: [RFC 0/9] PCIe Hotplug Slot Emulation driver
Thread-Index: AQHV3hK/y2Hxis+abEWPqwm+8JRaDqgUibyAgACHXACAAB+igIAAAw0A
Date:   Mon, 10 Feb 2020 17:09:59 +0000
Message-ID: <8a787f85964c66e8c6efde51f439db26fecfc5c6.camel@intel.com>
References: <1581120007-5280-1-git-send-email-jonathan.derrick@intel.com>
         <20200210070115.GA7748@lst.de>
         <3a4de58ad83a88f90f372e162c39d09eeebd8043.camel@intel.com>
         <20200210165857.GA19419@lst.de>
In-Reply-To: <20200210165857.GA19419@lst.de>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.232.115.25]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F4DD63D01A5CA14E92E60D721897DEF6@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTAyLTEwIGF0IDE3OjU4ICswMTAwLCBoY2hAbHN0LmRlIHdyb3RlOg0KPiBP
biBNb24sIEZlYiAxMCwgMjAyMCBhdCAwMzowNTo0N1BNICswMDAwLCBEZXJyaWNrLCBKb25hdGhh
biB3cm90ZToNCj4gPiA+IFRoZSBjb2RlIHNlZW1zIGxpa2Ugb25lIGdpYW50IGhhY2sgdG8gbWUu
ICBXaGF0IGlzIHRoZSByZWFsIGxpZmUNCj4gPiA+IHVzZSBjYXNlIGZvciB0aGlzPyAgQW5vdGhl
ciBJbnRlbCBjaGlwc2V0IGZ1Y2t1cCBsaWtlIHZtZCBvciB0aGUgYWhjaQ0KPiA+ID4gcmVtYXBw
aW5nPw0KPiA+ID4gDQo+ID4gRXhhY3RseSBhcyB0aGUgY292ZXIgbGV0dGVyIGRlc2NyaWJlcy4g
QW4gaW50ZXJwb3NlciBiZWluZyB1c2VkIG9uIGENCj4gPiBub24taG90cGx1ZyBzbG90Lg0KPiAN
Cj4gVGhhdCBpc24ndCBhIHVzZSBhIGNhc2UsIHRoYXQgadGVIGEgZGVzY3JpcHRpb24gb2YgdGhl
IGltcGxlbWVudGF0aW9uLg0KPiBXaHkgd291bGQgeW91IHdhbnQgdGhpcyBjb2RlPw0KSXQgYWxs
b3dzIG5vbi1ob3RwbHVnIHNsb3RzIHRvIHRha2UgYWR2YW50YWdlIG9mIHRoZSBrZXJuZWwncyBy
b2J1c3QNCmhvdHBsdWcgZWNvc3lzdGVtLCBpZiB0aGUgcGxhdGZvcm0gY29uZmlndXJhdGlvbiBj
YW4gdG9sZXJhdGUgdGhlDQpldmVudHMuIFRoaXMgY291bGQgYWxzbyByZWR1Y2UgQk9NIGNvc3Qg
YnkgZWxpbWluYXRpbmcgc29tZSBzbG90DQpjb250cm9sbGVycy4gU2F5IHlvdSBoYWQgc29tZXRo
aW5nIHRoYXQgb25seSBuZWVkZWQgdG8gYmUgaG90cGx1Z2dlZA0KdmVyeSBpbmZyZXF1ZW50bHks
IGxpa2UgUkFJRGVkIE9TIGRyaXZlcywgdmVyc3VzIHNvbWV0aGluZyBuZWVkaW5nIHRvDQpiZSBo
b3RwbHVnZ2VkIHZlcnkgZnJlcXVlbnRseSBsaWtlIGRhdGEgZHJpdmVzLg0KDQoNCkdyYW50ZWQg
aXQgcHJvYmFibHkgY291bGQgYmUgZml0IGludG8gcGNpZWhwX3BvbGwsIGJ1dCBpdCBzZWVtZWQg
dG8NCmhhdmUgYSBkaWZmZXJlbnQgb2JqZWN0aXZlIChlbXVsYXRpbmcgc2xvdCkNCg==
