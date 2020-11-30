Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CCB122C8C8E
	for <lists+linux-pci@lfdr.de>; Mon, 30 Nov 2020 19:20:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729421AbgK3SUP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 13:20:15 -0500
Received: from mga17.intel.com ([192.55.52.151]:56796 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727692AbgK3SUO (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 30 Nov 2020 13:20:14 -0500
IronPort-SDR: FepOsq3Q86AJGB4QAwLSxw9M1P3xKZUG+FPKrrCmbaOrxtLHJbyZZxA+1S38d4grrsBCA/7MmC
 KYK0qPyisyhQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9821"; a="152517672"
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="152517672"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Nov 2020 10:19:33 -0800
IronPort-SDR: XS1ISZYLRuHr2DP6wa+hnr2WbMlBroaPLFVMDoyVIDoBZGj3fB2+pzVl69W66H0oG/Gb4RGpz7
 zALQS1ilcxMg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,382,1599548400"; 
   d="scan'208";a="314662861"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by fmsmga008.fm.intel.com with ESMTP; 30 Nov 2020 10:19:33 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Nov 2020 10:19:33 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Mon, 30 Nov 2020 10:19:32 -0800
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Mon, 30 Nov 2020 10:19:32 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>,
        "David.Laight@ACULAB.COM" <David.Laight@ACULAB.COM>
CC:     "heiko@sntech.de" <heiko@sntech.de>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "kw@linux.com" <kw@linux.com>, "robh@kernel.org" <robh@kernel.org>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "thomas.petazzoni@bootlin.com" <thomas.petazzoni@bootlin.com>,
        "toan@os.amperecomputing.com" <toan@os.amperecomputing.com>,
        "rjui@broadcom.com" <rjui@broadcom.com>,
        "Jonathan.Cameron@huawei.com" <Jonathan.Cameron@huawei.com>,
        "jonnyc@amazon.com" <jonnyc@amazon.com>,
        "bcm-kernel-feedback-list@broadcom.com" 
        <bcm-kernel-feedback-list@broadcom.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "nsaenzjulienne@suse.de" <nsaenzjulienne@suse.de>,
        "wangzhou1@hisilicon.com" <wangzhou1@hisilicon.com>,
        "rrichter@marvell.com" <rrichter@marvell.com>,
        "will@kernel.org" <will@kernel.org>,
        "shawn.lin@rock-chips.com" <shawn.lin@rock-chips.com>,
        "linux-rpi-kernel@lists.infradead.org" 
        <linux-rpi-kernel@lists.infradead.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-rockchip@lists.infradead.org" 
        <linux-rockchip@lists.infradead.org>,
        "paulus@samba.org" <paulus@samba.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>
Subject: Re: [PATCH v6 4/5] PCI: vmd: Update type of the __iomem pointers
Thread-Topic: [PATCH v6 4/5] PCI: vmd: Update type of the __iomem pointers
Thread-Index: AQHWxqR5T+KTElL2ckS1iiGCxL3tTang6SEAgACKCACAABBbgA==
Date:   Mon, 30 Nov 2020 18:19:32 +0000
Message-ID: <f562dfc0043763ad6df3574dc9b7f0440687e66e.camel@intel.com>
References: <20201130172058.GA1088391@bjorn-Precision-5520>
In-Reply-To: <20201130172058.GA1088391@bjorn-Precision-5520>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.22.254.132]
Content-Type: text/plain; charset="utf-8"
Content-ID: <D6FB06213AE4BE4191D81BA8794047FC@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDExOjIwIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBNb24sIE5vdiAzMCwgMjAyMCBhdCAwOTowNjo1NkFNICswMDAwLCBEYXZpZCBMYWlnaHQg
d3JvdGU6DQo+ID4gRnJvbTogS3J6eXN6dG9mIFdpbGN6eW5za2kNCj4gPiA+IFNlbnQ6IDI5IE5v
dmVtYmVyIDIwMjAgMjM6MDgNCj4gPiA+IA0KPiA+ID4gVXNlICJ2b2lkIF9faW9tZW0iIGluc3Rl
YWQgImNoYXIgX19pb21lbSIgcG9pbnRlciB0eXBlIHdoZW4gd29ya2luZyB3aXRoDQo+ID4gPiB0
aGUgYWNjZXNzb3IgZnVuY3Rpb25zICh3aXRoIG5hbWVzIGxpa2UgcmVhZGIoKSBvciB3cml0ZWwo
KSwgZXRjLikgdG8NCj4gPiA+IGJldHRlciBtYXRjaCBhIGdpdmVuIGFjY2Vzc29yIGZ1bmN0aW9u
IHNpZ25hdHVyZSB3aGVyZSBjb21tb25seSB0aGUNCj4gPiA+IGFkZHJlc3MgcG9pbnRpbmcgdG8g
YW4gSS9PIG1lbW9yeSByZWdpb24gd291bGQgYmUgYSAidm9pZCBfX2lvbWVtIg0KPiA+ID4gcG9p
bnRlci4NCj4gPiANCj4gPiBJU1RNIHRoYXQgaXMgaGVhZGluZyBpbiB0aGUgd3JvbmcgZGlyZWN0
aW9uLg0KPiA+IA0KPiA+IEkgdGhpbmsgKGZvcm0gdGhlIHZhcmlhYmxlIG5hbWVzIGV0YykgdGhh
dCB0aGVzZSBhcmUgcG9pbnRlcnMNCj4gPiB0byBzcGVjaWZpYyByZWdpc3RlcnMuDQo+ID4gDQo+
ID4gU28gd2hhdCB5b3Ugb3VnaHQgdG8gaGF2ZSBpcyBhIHR5cGUgZm9yIHRoYXQgcmVnaXN0ZXIg
YmxvY2suDQo+ID4gVHlwaWNhbGx5IHRoaXMgaXMgYWN0dWFsbHkgYSBzdHJ1Y3R1cmUgLSB0byBn
aXZlIHNvbWUgdHlwZQ0KPiA+IGNoZWNraW5nIHRoYXQgdGhlIG9mZnNldHMgYXJlIGJlaW5nIHVz
ZWQgd2l0aCB0aGUgY29ycmVjdA0KPiA+IGJhc2UgYWRkcmVzcy4NCj4gDQo+IEluIHRoaXMgY2Fz
ZSwgImNmZ2JhciIgaXMgbm90IHJlYWxseSBhIHBvaW50ZXIgdG8gYSByZWdpc3RlcjsgaXQncyB0
aGUNCj4gYWRkcmVzcyBvZiBtZW1vcnktbWFwcGVkIGNvbmZpZyBzcGFjZS4gIFRoZSBWTUQgaGFy
ZHdhcmUgdHVybnMNCj4gYWNjZXNzZXMgdG8gdGhhdCBzcGFjZSBpbnRvIFBDSSBjb25maWcgdHJh
bnNhY3Rpb25zIG9uIGl0cyBzZWNvbmRhcnkNCj4gc2lkZS4gIHhnZW5lX3BjaWVfZ2V0X2NmZ19i
YXNlKCkgYW5kIGJyY21fcGNpZV9tYXBfY29uZigpIGFyZSBzaW1pbGFyDQo+IHNpdHVhdGlvbnMg
YW5kIHVzZSAidm9pZCAqIi4NCj4gDQo+IEJqb3JuDQoNClllcyBpdCdzIGp1c3QgdGhlIHBhc3N0
aHJvdWdoIHdpbmRvdyBmb3IgUENJIGNvbmZpZyBidXMgb3BzLg0KDQpSZXZpZXdlZC1ieTogSm9u
IERlcnJpY2sgPGpvbmF0aGFuLmRlcnJpY2tAaW50ZWwuY29tPg0K
