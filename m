Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 09838996DC
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 16:36:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389257AbfHVOgc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 10:36:32 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:29634 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389256AbfHVOgc (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 10:36:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566484590; x=1598020590;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Yvp8LjaYWUxeQilicZ38jo3c+L9KmT9UXROdt/YTVSE=;
  b=UPabgX6oETFS37AjnRE+mf2NqDpIIE6h6ASUYuaIOVt7mkFHB0BuGAxe
   zsksD8uwXaStzMo6F8gfJY5HS6UpC55z6PMdgJv8h1rVS7GvoqtJjGQnq
   yKALBh7bGOKa3NIA+s4h9fZdWZY5coo4TYYQdTcr2BjkYsLi/uC+c+C7d
   Y=;
X-IronPort-AV: E=Sophos;i="5.64,416,1559520000"; 
   d="scan'208";a="411121470"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 22 Aug 2019 14:36:29 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 26B442413D5;
        Thu, 22 Aug 2019 14:36:25 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 14:36:25 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 14:36:25 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Thu, 22 Aug 2019 14:36:25 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: Re: [PATCH v4 3/7] PCI/VPD: Add VPD release quirk for Amazon's
 Annapurna Labs Root Port
Thread-Topic: [PATCH v4 3/7] PCI/VPD: Add VPD release quirk for Amazon's
 Annapurna Labs Root Port
Thread-Index: AQHVWDYx1otPgAUY7UaMxbVyR8qrcqcHDLyAgAAwyQA=
Date:   Thu, 22 Aug 2019 14:36:24 +0000
Message-ID: <5a2c0097471e933d6f6a3964ac9fba9520994991.camel@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
         <20190821153545.17635-4-jonnyc@amazon.com>
         <20190822114146.GP23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190822114146.GP23903@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <4BEB828D57473A42AE30BC33D5008F5B@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDEyOjQxICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNjozNTo0M1BNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IFRoZSBBbWF6b24gQW5uYXB1cm5hIExhYnMgUENJZSBSb290IFBvcnQg
ZXhwb3NlcyB0aGUgVlBEDQo+ID4gY2FwYWJpbGl0eSwNCj4gPiBidXQgdGhlcmUgaXMgbm8gYWN0
dWFsIHN1cHBvcnQgZm9yIGl0Lg0KPiA+IA0KPiA+IFRoZSByZWFzb24gZm9yIG5vdCB1c2luZyB0
aGUgYWxyZWFkeSBleGlzdGluZyBxdWlya19ibGFja2xpc3RfdnBkKCkNCj4gPiBpcyB0aGF0LCBh
bHRob3VnaCB0aGlzIGZhaWxzIHBjaV92cGRfcmVhZC93cml0ZSwgdGhlICd2cGQnIHN5c2ZzDQo+
ID4gZW50cnkgc3RpbGwgZXhpc3RzLiBXaGVuIHJ1bm5pbmcgbHNwY2kgLXZ2LCBmb3IgZXhhbXBs
ZSwgdGhpcw0KPiA+IHJlc3VsdHMgaW4gdGhlIGZvbGxvd2luZyBlcnJvcjoNCj4gPiANCj4gPiBw
Y2lsaWI6IHN5c2ZzX3JlYWRfdnBkOiByZWFkIGZhaWxlZDogSW5wdXQvb3V0cHV0IGVycm9yDQo+
IA0KPiBPaCB0aGF0J3Mgbm90IG5pY2UuIEl0J3MgcHJvYmFibHkgdHJpZ2dlcmVkIGJ5IHRoZSAt
RUlPIGluDQo+IHBjaV92cGRfcmVhZC4NCj4gQSBxdWljayBzZWFyY2ggb25saW5lIHNlZW1zIHRv
IHNob3cgdGhhdCBvdGhlciBwZW9wbGUgaGF2ZQ0KPiBleHBlcmllbmNlZA0KPiB0aGlzIHRvbyAt
IHRob3VnaCBmcm9tIGFzIGZhciBhcyBJIGNhbiB0ZWxsIHRoaXMganVzdCBnaXZlcyB5b3UgYQ0K
PiB3YXJuaW5nIGFuZCBwY2lsaWIgd2lsbCBjb250aW5udWUgdG8gZ2l2ZSBvdGhlciBvdXRwdXQ/
DQo+IA0KQ29ycmVjdC4NCg0KPiBJIGd1ZXNzIGV2ZXJ5IHZwZCBibGFja2xpc3QnZCBkcml2ZXIg
d2lsbCBoYXZlIHRoZSBzYW1lIGlzc3VlLiBBbmQNCj4gZm9yDQo+IHRoaXMgcmVhc29uIEkgZG9u
J3QgdGhpbmsgdGhhdCB0aGlzIHBhdGNoIGlzIHRoZSByaWdodCBzb2x1dGlvbiAtIGFzDQo+IG90
aGVyd2lzZSBhbGwgdGhlIG90aGVyIGJsYWNrbGlzdGVkIGRyaXZlcnMgY291bGQgZm9sbG93IHlv
dXIgbGVhZC4NCj4gDQpJIHRoaW5rIHRoYXQgZ29pbmcgZm9yd2FyZCwgdGhleSBzaG91bGQgZm9s
bG93IG15IGxlYWQsIEkganVzdCBkaWRuJ3QNCndhbnQgdG8gcG9zc2libHkgYnJlYWsgYW55IGFz
c3VtcHRpb25zIG90aGVyIHZlbmRvcnMnIHRvb2xzIG1pZ2h0IGhhdmUNCnJlZ2FyZGluZyB0aGUg
ZXhpc3RlbmNlL25vbi1leGlzdGVuY2Ugb2YgdGhlIHZwZCBzeXNmcyBlbnRyeS4NCg0KPiBJIGRv
bid0IHRoaW5rIHlvdSBuZWVkIHRvIGZpeCB0aGlzIHNwZWNpZmljYWxseSBmb3IgdGhlIEFMIGRy
aXZlciBhbmQNCj4gc28NCj4gSSdkIHN1Z2dlc3QgdGhhdCB5b3UgY2FuIHByb2JhYmx5IGRyb3Ag
dGhpcyBwYXRjaC4gKElkZWFsbHkgcGNpdXRpbHMNCj4gY291bGQgYmUgdXBkYXRlZCB0byBub3Qg
d2FybiBmb3IgdGhpcyBzcGVjaWZpYyB1c2UtY2FzZSkuDQo+IA0KSSBkb24ndCB0aGluayB0aGF0
IHNvbHV0aW9uIHNob3VsZCBiZSBpbXBsZW1lbnRlZCBpbiBwY2l0dWlscy4gSXQNCnJpZ2h0ZnVs
bHkgd2FybnMgd2hlbiBpdCBmYWlscyB0byByZWFkIGZyb20gdGhlIHZwZCBzeXNmcyBmaWxlIC0g
aXQNCmZpcnN0ICdvcGVuJ3MgdGhlIGZpbGUgd2hpY2ggc3VjY2VlZHMsIGFuZCB0aGVuIGZhaWxz
IHdoZW4gdHJ5aW5nIHRvDQoncmVhZCcgZnJvbSBpdC4gSSBkb24ndCB0aGluayB0aGF0IGl0IHNo
b3VsZCBzcGVjaWZpY2FsbHkgIm1hc2siIG91dA0KLUVJTywgc2luY2UgaXQgc2hvdWxkbid0IGhh
dmUgdG8gImtub3ciIHRoYXQgdGhlIHVuZGVybHlpbmcgcmVhc29uIGlzIGENClZQRCBxdWlyayAo
b3IgbW9yZSBwcmVjaXNlbHkgdnBkLT5sZW4gPT0gMCkuIEZ1cnRoZXJtb3JlLCBpdCBpcw0KcG9z
c2libGUgdGhhdCB0aGlzIGVycm9yIGNvZGUgd291bGQgYmUgcmV0dXJuZWQgZm9yIHNvbWUgb3Ro
ZXIgcmVhc29uDQoobm90IHN1cmUgaWYgY3VycmVudGx5IHRoaXMgb2NjdXJzKS4NCg0KSSB0aGlu
ayB0aGF0IGlmIHRoZSBkZXZpY2UgZG9lc24ndCBwcm9wZXJseSBzdXBwb3J0IHZwZCwgdGhlIGtl
cm5lbA0Kc2hvdWxkbid0IGV4cG9zZSB0aGUgImVtcHR5IiBzeXNmcyBmaWxlIGluIHRoZSBmaXJz
dCBwbGFjZS4NCg0KSW4gdGhlIGxvbmcgcnVuLCBxdWlya19ibGFja2xpc3RfdnBkKCkgc2hvdWxk
IHByb2JhYmx5IGJlIG1vZGlmaWVkIHRvDQpkbyB3aGF0IG91ciBxdWlyayBkb2VzIG9yIHNvbWV0
aGluZyBzaW1pbGFyIChhbmQgdGhlbiB0aGUgYWwgcXVpcmsgY2FuDQpiZSByZW1vdmVkKS4gV2hh
dCBkbyB5b3UgdGhpbms/DQoNCj4gVGhhbmtzLA0KPiANCj4gQW5kcmV3IE11cnJheQ0KPiANCj4g
PiANCj4gPiBUaGlzIHF1aXJrIHJlbW92ZXMgdGhlIHN5c2ZzIGVudHJ5LCB3aGljaCBhdm9pZHMg
dGhlIGVycm9yIHByaW50Lg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENob2Ny
b24gPGpvbm55Y0BhbWF6b24uY29tPg0KPiA+IFJldmlld2VkLWJ5OiBHdXN0YXZvIFBpbWVudGVs
IDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT4NCj4gPiAtLS0NCj4gPiAgZHJpdmVycy9w
Y2kvdnBkLmMgfCAxNiArKysrKysrKysrKysrKysrDQo+ID4gIDEgZmlsZSBjaGFuZ2VkLCAxNiBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3ZwZC5jIGIv
ZHJpdmVycy9wY2kvdnBkLmMNCj4gPiBpbmRleCA0OTYzYzJlMmJkNGMuLmMyM2E4ZWMwOGRiOSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS92cGQuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNp
L3ZwZC5jDQo+ID4gQEAgLTY0NCw0ICs2NDQsMjAgQEAgc3RhdGljIHZvaWQgcXVpcmtfY2hlbHNp
b19leHRlbmRfdnBkKHN0cnVjdA0KPiA+IHBjaV9kZXYgKmRldikNCj4gPiAgREVDTEFSRV9QQ0lf
RklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9DSEVMU0lPLCBQQ0lfQU5ZX0lELA0KPiA+ICAJCQlx
dWlya19jaGVsc2lvX2V4dGVuZF92cGQpOw0KPiA+ICANCj4gPiArc3RhdGljIHZvaWQgcXVpcmtf
YWxfdnBkX3JlbGVhc2Uoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gPiArew0KPiA+ICsJaWYgKGRl
di0+dnBkKSB7DQo+ID4gKwkJcGNpX3ZwZF9yZWxlYXNlKGRldik7DQo+ID4gKwkJZGV2LT52cGQg
PSBOVUxMOw0KPiA+ICsJCXBjaV93YXJuKGRldiwgRldfQlVHICJSZWxlYXNpbmcgVlBEIGNhcGFi
aWxpdHkgKE5vDQo+ID4gc3VwcG9ydCBmb3IgVlBEIHJlYWQvd3JpdGUgdHJhbnNhY3Rpb25zKVxu
Iik7DQo+ID4gKwl9DQo+ID4gK30NCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAqIFRoZSAwMDMxIGRl
dmljZSBpZCBpcyByZXVzZWQgZm9yIG90aGVyIG5vbiBSb290IFBvcnQgZGV2aWNlDQo+ID4gdHlw
ZXMsDQo+ID4gKyAqIHRoZXJlZm9yZSB0aGUgcXVpcmsgaXMgcmVnaXN0ZXJlZCBmb3IgdGhlIFBD
SV9DTEFTU19CUklER0VfUENJDQo+ID4gY2xhc3MuDQo+ID4gKyAqLw0KPiA+ICtERUNMQVJFX1BD
SV9GSVhVUF9DTEFTU19GSU5BTChQQ0lfVkVORE9SX0lEX0FNQVpPTl9BTk5BUFVSTkFfTEFCUywN
Cj4gPiAweDAwMzEsDQo+ID4gKwkJCSAgICAgIFBDSV9DTEFTU19CUklER0VfUENJLCA4LA0KPiA+
IHF1aXJrX2FsX3ZwZF9yZWxlYXNlKTsNCj4gPiArDQo+ID4gICNlbmRpZg0KPiA+IC0tIA0KPiA+
IDIuMTcuMQ0KPiA+IA0K
