Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CBEA254B12
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 18:46:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726825AbgH0QqB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 12:46:01 -0400
Received: from mga09.intel.com ([134.134.136.24]:41896 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727020AbgH0QqA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Aug 2020 12:46:00 -0400
IronPort-SDR: eYyH0TwhRav9kD/2TiL8b9Kwl5vALgICsbcCKAMgkyT13W3U0XlxCrNthxiH5r5jw/B3nygPfA
 pjfSxxKaoJiw==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="157550589"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="157550589"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Aug 2020 09:45:59 -0700
IronPort-SDR: ImMD13yCvWB8O00pj8iqY8/mHChXArSLmVWfinKoF3yFxpCwikQuDtkwpHerhJy9eRYUTwD+y0
 FW9qKLVi2qrw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="403460440"
Received: from irsmsx601.ger.corp.intel.com ([163.33.146.7])
  by fmsmga001.fm.intel.com with ESMTP; 27 Aug 2020 09:45:57 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 irsmsx601.ger.corp.intel.com (163.33.146.7) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 17:45:55 +0100
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 27 Aug 2020 09:45:53 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "wangxiongfeng2@huawei.com" <wangxiongfeng2@huawei.com>,
        "kw@linux.com" <kw@linux.com>,
        "hkallweit1@gmail.com" <hkallweit1@gmail.com>,
        "kai.heng.feng@canonical.com" <kai.heng.feng@canonical.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "mika.westerberg@linux.intel.com" <mika.westerberg@linux.intel.com>,
        "Mario.Limonciello@dell.com" <Mario.Limonciello@dell.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "Williams, Dan J" <dan.j.williams@intel.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "Huffman, Amber" <amber.huffman@intel.com>,
        "Wysocki, Rafael J" <rafael.j.wysocki@intel.com>
Subject: Re: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Topic: [PATCH] PCI/ASPM: Enable ASPM for links under VMD domain
Thread-Index: AQHWd7clLgwBVuAUCESee06o/u7QiKlI1l4AgAKTLgCAAJR+AIAAodyAgAAC1ICAAAYeAA==
Date:   Thu, 27 Aug 2020 16:45:53 +0000
Message-ID: <eb45485d9107440a667e598da99ad949320b77b1.camel@intel.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
         <20200825062320.GA27116@infradead.org>
         <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
         <20200827063406.GA13738@infradead.org>
         <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
         <20200827162333.GA6822@infradead.org>
In-Reply-To: <20200827162333.GA6822@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.223.90]
Content-Type: text/plain; charset="utf-8"
Content-ID: <63FD82EA9164D5498895AF11A6D56E22@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTI3IGF0IDE3OjIzICswMTAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gVGh1LCBBdWcgMjcsIDIwMjAgYXQgMDQ6MTM6NDRQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDIwLTA4LTI3IGF0IDA2OjM0ICswMDAwLCBo
Y2hAaW5mcmFkZWFkLm9yZyB3cm90ZToNCj4gPiA+IE9uIFdlZCwgQXVnIDI2LCAyMDIwIGF0IDA5
OjQzOjI3UE0gKzAwMDAsIERlcnJpY2ssIEpvbmF0aGFuIHdyb3RlOg0KPiA+ID4gPiBGZWVsIGZy
ZWUgdG8gcmV2aWV3IG15IHNldCB0byBkaXNhYmxlIHRoZSBNU0kgcmVtYXBwaW5nIHdoaWNoIHdp
bGwNCj4gPiA+ID4gbWFrZQ0KPiA+ID4gPiBpdCBwZXJmb3JtIGFzIHdlbGwgYXMgZGlyZWN0LWF0
dGFjaGVkOg0KPiA+ID4gPiANCj4gPiA+ID4gaHR0cHM6Ly9wYXRjaHdvcmsua2VybmVsLm9yZy9w
cm9qZWN0L2xpbnV4LXBjaS9saXN0Lz9zZXJpZXM9MzI1NjgxDQo+ID4gPiANCj4gPiA+IFNvIHRo
YXQgdGhlbiB3ZSBoYXZlIHRvIGRlYWwgd2l0aCB5b3VyIHNjaGVtZXMgdG8gbWFrZSBpbmRpdmlk
dWFsDQo+ID4gPiBkZXZpY2UgZGlyZWN0IGFzc2lnbm1lbnQgd29yayBpbiBhIGNvbnZvbHV0ZWQg
d2F5Pw0KPiA+IA0KPiA+IFRoYXQncyBub3QgdGhlIGludGVudCBvZiB0aGF0IHBhdGNoc2V0IC1h
dCBhbGwtLiBJdCB3YXMgdG8gYWRkcmVzcyB0aGUNCj4gPiBwZXJmb3JtYW5jZSBib3R0bGVuZWNr
cyB3aXRoIFZNRCB0aGF0IHlvdSBjb25zdGFudGx5IGNvbXBsYWluIGFib3V0LiANCj4gDQo+IEkg
a25vdy4gIEJ1dCBvbmNlIHdlIGZpeCB0aGF0IGJvdHRsZW5lY2sgd2UgZml4IHRoZSBuZXh0IGlz
c3VlLA0KPiB0aGVuIHRvIHRhY2tsZSB0aGUgbmV4dC4gIFdoaWxlIGF0IHRoZSBzYW1lIHRpbWUg
Vk1EIGJyaW5ncyB6ZXJvDQo+IGFjdHVhbCBiZW5lZml0cy4NCj4gDQoNCkp1c3QgYSBmZXcgYmVu
ZWZpdHMgYW5kIHRoZXJlIGFyZSBvdGhlciB1c2VycyB3aXRoIHVuaXF1ZSB1c2UgY2FzZXM6DQox
LiBQYXNzdGhyb3VnaCBvZiB0aGUgZW5kcG9pbnQgdG8gT1NlcyB3aGljaCBkb24ndCBuYXRpdmVs
eSBzdXBwb3J0DQpob3RwbHVnIGNhbiBlbmFibGUgaG90cGx1ZyBmb3IgdGhhdCBPUyB1c2luZyB0
aGUgZ3Vlc3QgVk1EIGRyaXZlcg0KMi4gU29tZSBoeXBlcnZpc29ycyBoYXZlIGEgbGltaXQgb24g
dGhlIG51bWJlciBvZiBkZXZpY2VzIHRoYXQgY2FuIGJlDQpwYXNzZWQgdGhyb3VnaC4gVk1EIGVu
ZHBvaW50IGlzIGEgc2luZ2xlIGRldmljZSB0aGF0IGV4cGFuZHMgdG8gbWFueS4NCjMuIEV4cGFu
c2lvbiBvZiBwb3NzaWJsZSBidXMgbnVtYmVycyBiZXlvbmQgMjU2IGJ5IHVzaW5nIG90aGVyDQpz
ZWdtZW50cy4NCjQuIEN1c3RvbSBSQUlEIExFRCBwYXR0ZXJucyBkcml2ZW4gYnkgbGVkY3RsDQoN
CkknbSBub3QgdHJ5aW5nIHRvIG1hcmtldCB0aGlzLiBKdXN0IHBvaW50aW5nIG91dCB0aGF0IHRo
aXMgaXNuJ3QNCiJicmluZ2luZyB6ZXJvIGFjdHVhbCBiZW5lZml0cyIgdG8gbWFueSB1c2Vycy4N
Cg0KDQo+ID4gPiBQbGVhc2UganVzdCBnaXZlIHVzDQo+ID4gPiBhIGRpc2FibGUgbm9iIGZvciBW
TUQsIHdoaWNoIHNvbHZlcyBfYWxsXyB0aGVzZSBwcm9ibGVtcyB3aXRob3V0DQo+ID4gPiBhZGRp
bmcNCj4gPiA+IGFueS4NCj4gPiANCj4gPiBJIGRvbid0IHNlZSB0aGUgcHVycG9zZSBvZiB0aGlz
IGxpbmUgb2YgZGlzY3Vzc2lvbi4gVk1EIGhhcyBiZWVuIGluIHRoZQ0KPiA+IGtlcm5lbCBmb3Ig
NSB5ZWFycy4gV2UgYXJlIGNvbnN0YW50bHkgd29ya2luZyBvbiBiZXR0ZXIgc3VwcG9ydC4NCj4g
DQo+IFBsZWFzZSBqdXN0IHdvcmsgd2l0aCB0aGUgcGxhdGZvcm0gcGVvcGxlIHRvIGFsbG93IHRo
ZSBob3N0IHRvIGRpc2FibGUNCj4gVk1ELiAgVGhhdCBpcyB0aGUgb25seSByZWFsbHkgdXNlZnVs
IHZhbHVlIGFkZCBoZXJlLg0KDQpDaGVlcnMNCg==
