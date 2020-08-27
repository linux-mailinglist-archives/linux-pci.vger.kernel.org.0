Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8D4F254A47
	for <lists+linux-pci@lfdr.de>; Thu, 27 Aug 2020 18:13:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726250AbgH0QNu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 Aug 2020 12:13:50 -0400
Received: from mga07.intel.com ([134.134.136.100]:38038 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgH0QNt (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 Aug 2020 12:13:49 -0400
IronPort-SDR: PYckOmLkhBLHb71H1llARIlQufAsujM8iKT5pjGHZn6uvzofdY8831EwykE8p81inpnztK6buF
 6AAuTFMX+e9g==
X-IronPort-AV: E=McAfee;i="6000,8403,9726"; a="220767089"
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="220767089"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP; 27 Aug 2020 09:13:49 -0700
IronPort-SDR: I/0T9QeSSiAzLcNzOUgzCWwJzVCUhDBw/R/f1qKDz74fs7YprQ4bBzPmRsV5pGC/e/87qkNItE
 fQ9K1fgzkv6w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,360,1592895600"; 
   d="scan'208";a="373772496"
Received: from irsmsx606.ger.corp.intel.com ([163.33.146.139])
  by orsmga001.jf.intel.com with ESMTP; 27 Aug 2020 09:13:47 -0700
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 IRSMSX606.ger.corp.intel.com (163.33.146.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.1713.5; Thu, 27 Aug 2020 17:13:45 +0100
Received: from fmsmsx610.amr.corp.intel.com ([10.18.126.90]) by
 fmsmsx610.amr.corp.intel.com ([10.18.126.90]) with mapi id 15.01.1713.004;
 Thu, 27 Aug 2020 09:13:44 -0700
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
Thread-Index: AQHWd7clLgwBVuAUCESee06o/u7QiKlI1l4AgAKTLgCAAJR+AIAAodyA
Date:   Thu, 27 Aug 2020 16:13:44 +0000
Message-ID: <660c8671a51eec447dc7fab22bacbc9c600508d9.camel@intel.com>
References: <20200821123222.32093-1-kai.heng.feng@canonical.com>
         <20200825062320.GA27116@infradead.org>
         <cd5aa2fef13f14b30c139d03d5256cf93c7195dc.camel@intel.com>
         <20200827063406.GA13738@infradead.org>
In-Reply-To: <20200827063406.GA13738@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.212.223.90]
Content-Type: text/plain; charset="utf-8"
Content-ID: <48C448FCBE462040A7F3805A669F8E2F@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA4LTI3IGF0IDA2OjM0ICswMDAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMjYsIDIwMjAgYXQgMDk6NDM6MjdQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gRmVlbCBmcmVlIHRvIHJldmlldyBteSBzZXQgdG8gZGlzYWJs
ZSB0aGUgTVNJIHJlbWFwcGluZyB3aGljaCB3aWxsDQo+ID4gbWFrZQ0KPiA+IGl0IHBlcmZvcm0g
YXMgd2VsbCBhcyBkaXJlY3QtYXR0YWNoZWQ6DQo+ID4gDQo+ID4gaHR0cHM6Ly9wYXRjaHdvcmsu
a2VybmVsLm9yZy9wcm9qZWN0L2xpbnV4LXBjaS9saXN0Lz9zZXJpZXM9MzI1NjgxDQo+IA0KPiBT
byB0aGF0IHRoZW4gd2UgaGF2ZSB0byBkZWFsIHdpdGggeW91ciBzY2hlbWVzIHRvIG1ha2UgaW5k
aXZpZHVhbA0KPiBkZXZpY2UgZGlyZWN0IGFzc2lnbm1lbnQgd29yayBpbiBhIGNvbnZvbHV0ZWQg
d2F5Pw0KDQpUaGF0J3Mgbm90IHRoZSBpbnRlbnQgb2YgdGhhdCBwYXRjaHNldCAtYXQgYWxsLS4g
SXQgd2FzIHRvIGFkZHJlc3MgdGhlDQpwZXJmb3JtYW5jZSBib3R0bGVuZWNrcyB3aXRoIFZNRCB0
aGF0IHlvdSBjb25zdGFudGx5IGNvbXBsYWluIGFib3V0LiANCg0KDQo+IFBsZWFzZSBqdXN0IGdp
dmUgdXMNCj4gYSBkaXNhYmxlIG5vYiBmb3IgVk1ELCB3aGljaCBzb2x2ZXMgX2FsbF8gdGhlc2Ug
cHJvYmxlbXMgd2l0aG91dA0KPiBhZGRpbmcNCj4gYW55Lg0KDQpJIGRvbid0IHNlZSB0aGUgcHVy
cG9zZSBvZiB0aGlzIGxpbmUgb2YgZGlzY3Vzc2lvbi4gVk1EIGhhcyBiZWVuIGluIHRoZQ0Ka2Vy
bmVsIGZvciA1IHllYXJzLiBXZSBhcmUgY29uc3RhbnRseSB3b3JraW5nIG9uIGJldHRlciBzdXBw
b3J0Lg0K
