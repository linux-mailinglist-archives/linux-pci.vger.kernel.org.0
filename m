Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E6D2AF30F0
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388980AbfKGOMw (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 7 Nov 2019 09:12:52 -0500
Received: from mga07.intel.com ([134.134.136.100]:42406 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729162AbfKGOMw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 7 Nov 2019 09:12:52 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 07 Nov 2019 06:12:51 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,278,1569308400"; 
   d="scan'208";a="192831084"
Received: from orsmsx106.amr.corp.intel.com ([10.22.225.133])
  by orsmga007.jf.intel.com with ESMTP; 07 Nov 2019 06:12:51 -0800
Received: from orsmsx162.amr.corp.intel.com (10.22.240.85) by
 ORSMSX106.amr.corp.intel.com (10.22.225.133) with Microsoft SMTP Server (TLS)
 id 14.3.439.0; Thu, 7 Nov 2019 06:12:51 -0800
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.212]) by
 ORSMSX162.amr.corp.intel.com ([169.254.3.148]) with mapi id 14.03.0439.000;
 Thu, 7 Nov 2019 06:12:51 -0800
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
Thread-Index: AQHVlMmF1+r/rt0/GUWDTuwxcG2u7ad/+yUAgABMKgA=
Date:   Thu, 7 Nov 2019 14:12:50 +0000
Message-ID: <bfc69a54dc394ffb7580d14818047ec6a647536f.camel@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
         <20191107093952.GA13826@infradead.org>
In-Reply-To: <20191107093952.GA13826@infradead.org>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.7.176]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5A8FE26F5BC0184097BC66C30D02BAF7@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTExLTA3IGF0IDAxOjM5IC0wODAwLCBDaHJpc3RvcGggSGVsbHdpZyB3cm90
ZToNCj4gT24gV2VkLCBOb3YgMDYsIDIwMTkgYXQgMDQ6NDA6MDVBTSAtMDcwMCwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gVGhpcyBwYXRjaHNldCBvcHRpbWl6ZXMgVk1EIHBlcmZvcm1hbmNlIHRo
cm91Z2ggdGhlIHN0b3JhZ2Ugc3RhY2sgYnkgbG9jYXRpbmcNCj4gPiBjb21tb25seS1hZmZpbmVk
IE5WTWUgaW50ZXJydXB0cyBvbiB0aGUgc2FtZSBWTUQgaW50ZXJydXB0IGhhbmRsZXIgbGlzdHMu
DQo+ID4gDQo+ID4gVGhlIGN1cnJlbnQgc3RyYXRlZ3kgb2Ygcm91bmQtcm9iaW4gYXNzaWdubWVu
dCB0byBWTUQgSVJRIGxpc3RzIGNhbiBiZQ0KPiA+IHN1Ym9wdGltYWwgd2hlbiB2ZWN0b3JzIHdp
dGggZGlmZmVyZW50IGFmZmluaXRpZXMgYXJlIGFzc2lnbmVkIHRvIHRoZSBzYW1lIFZNRA0KPiA+
IElSUSBsaXN0LiBWTUQgaXMgYW4gTlZNZSBzdG9yYWdlIGRvbWFpbiBhbmQgdGhpcyBzZXQgYWxp
Z25zIHRoZSB2ZWN0b3INCj4gPiBhbGxvY2F0aW9uIGFuZCBhZmZpbml0eSBzdHJhdGVneSB3aXRo
IHRoYXQgb2YgdGhlIE5WTWUgZHJpdmVyLiBUaGlzIGludm9rZXMgdGhlDQo+ID4ga2VybmVsIHRv
IGRvIHRoZSByaWdodCB0aGluZyB3aGVuIGFmZmluaW5nIE5WTWUgc3VibWlzc2lvbiBjcHVzIHRv
IE5WTWUNCj4gPiBjb21wbGV0aW9uIHZlY3RvcnMgYXMgc2VydmljZWQgdGhyb3VnaCB0aGUgVk1E
IGludGVycnVwdCBoYW5kbGVyIGxpc3RzLg0KPiA+IA0KPiA+IFRoaXMgc2V0IGdyZWF0bHkgcmVk
dWNlZCB0YWlsIGxhdGVuY3kgd2hlbiB0ZXN0aW5nIDggdGhyZWFkcyBvZiByYW5kb20gNGsgcmVh
ZHMNCj4gPiBhZ2FpbnN0IHR3byBkcml2ZXMgYXQgcXVldWUgZGVwdGg9MTI4LiBBZnRlciBwaW5u
aW5nIHRoZSB0YXNrcyB0byByZWR1Y2UgdGVzdA0KPiA+IHZhcmlhYmlsaXR5LCB0aGUgdGVzdHMg
YWxzbyBzaG93ZWQgYSBtb2RlcmF0ZSB0YWlsIGxhdGVuY3kgcmVkdWN0aW9uLiBBDQo+ID4gb25l
LWRyaXZlIGNvbmZpZ3VyYXRpb24gYWxzbyBzaG93cyBpbXByb3ZlbWVudHMgZHVlIHRvIHRoZSBh
bGlnbm1lbnQgb2YgVk1EIElSUQ0KPiA+IGxpc3QgYWZmaW5pdGllcyB3aXRoIE5WTWUgYWZmaW5p
dGllcy4NCj4gDQo+IEhvdyBkb2VzIHRoaXMgY29tcGFyZSB0byBzaW1wbGlmeSBkaXNhYmxpbmcg
Vk1EPw0KDQpJdCdzIGEgbW9vdCBwb2ludCBzaW5jZSBLZWl0aCBwb2ludGVkIG91dCBhIGZldyBm
bGF3cyB3aXRoIHRoaXMgc2V0LA0KaG93ZXZlciBkaXNhYmxpbmcgVk1EIGlzIG5vdCBhbiBvcHRp
b24gZm9yIHVzZXJzIHdobyB3aXNoIHRvDQpwYXNzdGhyb3VnaCBWTUQNCg==
