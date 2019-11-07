Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7C565F33BB
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 16:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729989AbfKGPrL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 10:47:11 -0500
Received: from mga11.intel.com ([192.55.52.93]:14171 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388539AbfKGPrK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 10:47:10 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 07:47:10 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="377460293"
Received: from orsmsx104.amr.corp.intel.com ([10.22.225.131])
  by orsmga005.jf.intel.com with ESMTP; 07 Nov 2019 07:47:10 -0800
Received: from orsmsx124.amr.corp.intel.com (10.22.240.120) by
 ORSMSX104.amr.corp.intel.com (10.22.225.131) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 07:47:09 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX124.amr.corp.intel.com ([169.254.2.2]) with mapi id 14.03.0439.000;
 Thu, 7 Nov 2019 07:47:09 -0800
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "hch@infradead.org" <hch@infradead.org>
CC:     "kbusch@kernel.org" <kbusch@kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "helgaas@kernel.org" <helgaas@kernel.org>
Subject: Re: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Thread-Topic: [PATCH 0/3] PCI: vmd: Reducing tail latency by affining to the
 storage stack
Thread-Index: AQHVlMmF1+r/rt0/GUWDTuwxcG2u7ad/+yUAgABMKgCAABfJAIAAALSAgAAAowCAAAFRgA==
Date:   Thu, 7 Nov 2019 15:47:09 +0000
Message-ID: <784d25a41399472e80a0b384f88eccab29b01cc1.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <20191107093952.GA13826@infradead.org>
         <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
         <20191107153736.GA16006@infradead.org>
         <c0d62e0f1f8d1d6f31b2a63757aad471ced1df28.camel@intel.com>
         <20191107154224.GA26224@infradead.org>
In-Reply-To: <20191107154224.GA26224@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.7.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <EE327CD813ACD54B915AA50D61E40A50@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDA3OjQyIC0wODAwLCBoY2hAaW5mcmFkZWFkLm9yZyB3cm90
ZToNCj4gT24gVGh1LCBOb3YgMDcsIDIwMTkgYXQgMDM6NDA6MTVQTSArMDAwMCwgRGVycmljaywg
Sm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gVGh1LCAyMDE5LTExLTA3IGF0IDA3OjM3IC0wODAwLCBo
Y2hAaW5mcmFkZWFkLm9yZyB3cm90ZToNCj4gPiA+IE9uIFRodSwgTm92IDA3LCAyMDE5IGF0IDAy
OjEyOjUwUE0gKzAwMDAsIERlcnJpY2ssIEpvbmF0aGFuIHdyb3RlOg0KPiA+ID4gPiA+IEhvdyBk
b2VzIHRoaXMgY29tcGFyZSB0byBzaW1wbGlmeSBkaXNhYmxpbmcgVk1EPw0KPiA+ID4gPiANCj4g
PiA+ID4gSXQncyBhIG1vb3QgcG9pbnQgc2luY2UgS2VpdGggcG9pbnRlZCBvdXQgYSBmZXcgZmxh
d3Mgd2l0aCB0aGlzIHNldCwNCj4gPiA+ID4gaG93ZXZlciBkaXNhYmxpbmcgVk1EIGlzIG5vdCBh
biBvcHRpb24gZm9yIHVzZXJzIHdobyB3aXNoIHRvDQo+ID4gPiA+IHBhc3N0aHJvdWdoIFZNRA0K
PiA+ID4gDQo+ID4gPiBBbmQgd2h5IHdvdWxkIHlvdSBldmVyIHBhc3MgdGhyb3VnaCB2bWQgaW5z
dGVhZCBvZiB0aGUgYWN0dWFsIGRldmljZT8NCj4gPiA+IFRoYXQganVzdCBtYWtlcyB0aGluZ3Mg
Z28gc2xvd2VyIGFuZCBhZGRzIHplcm8gdmFsdWUuDQo+ID4gDQo+ID4gQWJpbGl0eSB0byB1c2Ug
cGh5c2ljYWwgUm9vdCBQb3J0cy9EU1BzL2V0YyBpbiBhIGd1ZXN0LiBTbG93ZXIgaXMNCj4gPiBh
Y2NlcHRhYmxlIGZvciBtYW55IHVzZXJzIGlmIGl0IGZpdHMgd2l0aGluIGEgcGVyZm9ybWFuY2Ug
d2luZG93DQo+IA0KPiBXaGF0IGlzIHRoZSBhY3R1YWwgdXNlIGNhc2U/ICBXaGF0IGRvZXMgaXQg
ZW5hYmxlIHRoYXQgb3RoZXJ3aXNlIGRvZXNuJ3QNCj4gd29yayBhbmQgaXMgYWN0dWFsbHkgdXNl
ZnVsPyAgQW5kIHJlYWwgdXNlIGNhc2VzIHBsZWFzZSBhbmQgbm8gbWFya2V0aW5nDQo+IG11bWJs
ZSBqdW1ibGUuDQoNCkEgY2xvdWQgc2VydmljZSBwcm92aWRlciBtaWdodCBoYXZlIHNldmVyYWwg
Vk1zIG9uIGEgc2luZ2xlIHN5c3RlbSBhbmQNCndpc2ggdG8gcHJvdmlkZSBzdXJwcmlzZSBob3Rw
bHVnIGZ1bmN0aW9uYWxpdHkgd2l0aGluIHRoZSBndWVzdHMgc28NCnRoYXQgdGhleSBkb24ndCBu
ZWVkIHRvIGJyaW5nIHRoZSB3aG9sZSBzZXJ2ZXIgZG93biBvciBtaWdyYXRlIFZNcyBpbg0Kb3Jk
ZXIgdG8gc3dhcCBkaXNrcy4NCg==
