Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A030E1AD179
	for <lists+linux-pci@lfdr.de>; Thu, 16 Apr 2020 22:50:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727802AbgDPUuJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Apr 2020 16:50:09 -0400
Received: from mga03.intel.com ([134.134.136.65]:8503 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgDPUuJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Apr 2020 16:50:09 -0400
IronPort-SDR: E5mqK2WsVS/QOzxswCbW9IJJB4W7nG03D8zEo5UdJ7zoPhPf3gaXTJSn8kjqgdTAJ+JLWEZH3k
 JR1YeTCBlKGQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Apr 2020 13:50:08 -0700
IronPort-SDR: tsbdtrwfkw7tAIEmfJ7QQq9Y8UJvaBOkEdHc7PiHXgj3Z453E22m+g3EVTagYeF+1joRL63P1b
 +8AJB7h+m1+g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,392,1580803200"; 
   d="scan'208";a="253990956"
Received: from orsmsx109.amr.corp.intel.com ([10.22.240.7])
  by orsmga003.jf.intel.com with ESMTP; 16 Apr 2020 13:50:08 -0700
Received: from orsmsx101.amr.corp.intel.com ([169.254.8.204]) by
 ORSMSX109.amr.corp.intel.com ([169.254.11.20]) with mapi id 14.03.0439.000;
 Thu, 16 Apr 2020 13:50:07 -0700
From:   "Derrick, Jonathan" <jonathan.derrick@intel.com>
To:     "sathyanarayanan.kuppuswamy@linux.intel.com" 
        <sathyanarayanan.kuppuswamy@linux.intel.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "sbobroff@linux.ibm.com" <sbobroff@linux.ibm.com>,
        "olof@lixom.net" <olof@lixom.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "ruscur@russell.cc" <ruscur@russell.cc>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "kbusch@kernel.org" <kbusch@kernel.org>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "oohall@gmail.com" <oohall@gmail.com>,
        "fred@fredlawl.com" <fred@fredlawl.com>
Subject: Re: [PATCH] PCI/DPC: Allow Non-ACPI Native ports to use DPC
Thread-Topic: [PATCH] PCI/DPC: Allow Non-ACPI Native ports to use DPC
Thread-Index: AQHWFCtm3704heDSeUKO5orBCIsVJKh8qWeAgAAE0YA=
Date:   Thu, 16 Apr 2020 20:50:06 +0000
Message-ID: <94fcbe2c950f9cff45c759b8598af985235ab932.camel@intel.com>
References: <1587067157-2291-1-git-send-email-jonathan.derrick@intel.com>
         <4c2bf639-5510-fb17-2f02-73e7016d8f70@linux.intel.com>
In-Reply-To: <4c2bf639-5510-fb17-2f02-73e7016d8f70@linux.intel.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-originating-ip: [10.255.0.232]
Content-Type: text/plain; charset="utf-8"
Content-ID: <44EB88A81E54FA42BD81D638AD184FCD@intel.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTA0LTE2IGF0IDEzOjMyIC0wNzAwLCBLdXBwdXN3YW15LCBTYXRoeWFuYXJh
eWFuYW4gd3JvdGU6DQo+IEhpLA0KPiANCj4gT24gNC8xNi8yMCAxMjo1OSBQTSwgSm9uIERlcnJp
Y2sgd3JvdGU6DQo+ID4gU29tZSBwbGF0Zm9ybXMgaGF2ZSBhIG1peCBvZiBwb3J0cyB3aG9zZSBj
YXBhYmlsaXRpZXMgY2FuIGJlIG5lZ290aWF0ZWQNCj4gPiBieSBfT1NDLCBhbmQgc29tZSBwb3J0
cyB3aGljaCBhcmUgbm90IGRlc2NyaWJlZCBieSBBQ1BJIGFuZCBpbnN0ZWFkDQo+ID4gbWFuYWdl
ZCBieSBOYXRpdmUgZHJpdmVycy4gVGhlIGV4aXN0aW5nIEZpcm13YXJlLUZpcnN0IEhFU1QgbW9k
ZWwgY2FuDQo+ID4gaW5jb3JyZWN0bHkgdGFnIHRoZXNlIE5hdGl2ZSwgTm9uLUFDUEkgcG9ydHMg
YXMgRmlybXdhcmUtRmlyc3QgY2FwYWJsZQ0KPiA+IHBvcnRzIGJ5IGFkdmVydGlzaW5nIHRoZSBI
RVNUIEdsb2JhbCBmbGFnIGFuZCBzcGVjaWZ5aW5nIHRoZSB0eXBlIGFuZA0KPiA+IGNsYXNzIChh
ZXJfaGVzdF9wYXJzZSkuDQo+ID4gDQo+ID4gVGhpcyB1bHRpbWF0ZWx5IGNhbiBsZWFkIHRvIGJh
ZCBzaXR1YXRpb25zIGlmIHRoZSBCSU9TIG9yIHBvcnQgZmlybXdhcmUNCj4gPiBsZWF2ZXMgRFBD
IHByZWNvbmZpZ3VyZWQgYW5kIHRoZSBMaW51eCBEUEMgZHJpdmVyIGlzIHVuYWJsZSB0byBiaW5k
IHRvDQo+ID4gdGhlIHBvcnQgdG8gaGFuZGxlIERQQyBldmVudHMuDQo+ID4gDQo+ID4gVGhpcyBw
YXRjaCBhZGRzIHRoZSBjaGVjayBmb3IgTmF0aXZlIERQQyBpbiB0aGUgcG9ydCdzIGhvc3QgYnJp
ZGdlIGluDQo+ID4gb3JkZXIgdG8gYWxsb3cgRFBDIHNlcnZpY2VzIHRvIGJpbmQgdG8gdGhlIHBv
cnQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9uIERlcnJpY2sgPGpvbmF0aGFuLmRlcnJp
Y2tAaW50ZWwuY29tPg0KPiA+IC0tLQ0KPiA+ICAgZHJpdmVycy9wY2kvcGNpZS9kcGMuYyB8IDQg
KysrLQ0KPiA+ICAgMSBmaWxlIGNoYW5nZWQsIDMgaW5zZXJ0aW9ucygrKSwgMSBkZWxldGlvbigt
KQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wY2llL2RwYy5jIGIvZHJpdmVy
cy9wY2kvcGNpZS9kcGMuYw0KPiA+IGluZGV4IDc2MjE3MDQuLmExZTM1NWQgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvcGNpZS9kcGMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL3BjaWUv
ZHBjLmMNCj4gPiBAQCAtMjgxLDEwICsyODEsMTIgQEAgc3RhdGljIGludCBkcGNfcHJvYmUoc3Ry
dWN0IHBjaWVfZGV2aWNlICpkZXYpDQo+ID4gICB7DQo+ID4gICAJc3RydWN0IHBjaV9kZXYgKnBk
ZXYgPSBkZXYtPnBvcnQ7DQo+ID4gICAJc3RydWN0IGRldmljZSAqZGV2aWNlID0gJmRldi0+ZGV2
aWNlOw0KPiA+ICsJc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqaG9zdCA9IHBjaV9maW5kX2hvc3Rf
YnJpZGdlKHBkZXYtPmJ1cyk7DQo+ID4gICAJaW50IHN0YXR1czsNCj4gPiAgIAl1MTYgY3RsLCBj
YXA7DQo+ID4gICANCj4gPiAtCWlmIChwY2llX2Flcl9nZXRfZmlybXdhcmVfZmlyc3QocGRldikg
JiYgIXBjaWVfcG9ydHNfZHBjX25hdGl2ZSkNCj4gPiArCWlmIChwY2llX2Flcl9nZXRfZmlybXdh
cmVfZmlyc3QocGRldikgJiYgIXBjaWVfcG9ydHNfZHBjX25hdGl2ZSAmJg0KPiBGb3Igb3RoZXIg
UENJZSBzZXJ2aWNlcywgdGhpcyBjaGVjayBpcyBhZGRlZCBpbiANCj4gZ2V0X3BvcnRfZGV2aWNl
X2NhcGFiaWxpdHkoKS4NCj4gV2h5IG5vdCBhZGQgaXQgdGhlcmUgZm9yIERQQyBhcyB3ZWxsID8N
Cg0KU3VyZS4gTG9va2luZyBhdCB0aGlzLCBpdCBzZWVtcyBsaWtlIGl0IG5lZWRzIHNvbWUgbW9y
ZSBkZS10YW5nbGluZyB0bw0KZml0IGludG8gbXkgbW9kZWwuDQoNCj4gPiArCSAgICAhaG9zdC0+
bmF0aXZlX2RwYykNCj4gPiAgIAkJcmV0dXJuIC1FTk9UU1VQUDsNCj4gPiAgIA0KPiA+ICAgCXN0
YXR1cyA9IGRldm1fcmVxdWVzdF90aHJlYWRlZF9pcnEoZGV2aWNlLCBkZXYtPmlycSwgZHBjX2ly
cSwNCj4gPiANCg==
