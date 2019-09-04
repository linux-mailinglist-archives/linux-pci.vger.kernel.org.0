Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 8035CA84A7
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 15:50:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729740AbfIDNks (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 09:40:48 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:44697 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfIDNks (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 09:40:48 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567604445; x=1599140445;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=5x9hn83lRopsKXWJe8maV1LP5ipd67707akR1DJW2PE=;
  b=tKK+A7/hYoFe5zBxwDB4WR5BIrh325buY+RVnEKpQe+O1qpmttl/ODlU
   AEd5ogQ8McTC8UhJrJQ0pps62g7Qpaf/S1ZXWdFLAdO3rVgi4bCzDgqAH
   YdoZeZG5v0Czb+bWZl3Fgt2SjZ2/mTHBivQhBEG/mEQtHGldeRaotTayD
   c=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="827211149"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Sep 2019 13:40:44 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id 768F5A1B14;
        Wed,  4 Sep 2019 13:40:43 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:40:43 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:40:42 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Wed, 4 Sep 2019 13:40:42 +0000
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
Subject: Re: [PATCH v4 7/7] PCI: dwc: Add validation that PCIe core is set to
 correct mode
Thread-Topic: [PATCH v4 7/7] PCI: dwc: Add validation that PCIe core is set to
 correct mode
Thread-Index: AQHVWDfYfXzAIUBUVEGXGWtVpGVRnqcHBMEAgABYiACAB2tuAIAM04aA
Date:   Wed, 4 Sep 2019 13:40:42 +0000
Message-ID: <dad666b23010c120b153ed59d18148a69b46cd88.camel@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
         <20190821154745.31834-3-jonnyc@amazon.com>
         <20190822111315.GN23903@e119886-lin.cambridge.arm.com>
         <f8fca74c8d252f000d60c52ead3fc41ed5d50b6d.camel@amazon.com>
         <20190827094827.GJ14582@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190827094827.GJ14582@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.154]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B9D770CF1067564A93F4CE25CC11B2EB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTI3IGF0IDEwOjQ4ICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBUaHUsIEF1ZyAyMiwgMjAxOSBhdCAwNDozMDowOVBNICswMDAwLCBDaG9jcm9uLCBKb25h
dGhhbiB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMTktMDgtMjIgYXQgMTI6MTMgKzAxMDAsIEFuZHJl
dyBNdXJyYXkgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNjo0Nzo0NVBN
ICswMzAwLCBKb25hdGhhbiBDaG9jcm9uIHdyb3RlOg0KPiA+ID4gPiBTb21lIFBDSWUgY29udHJv
bGxlcnMgY2FuIGJlIHNldCB0byBlaXRoZXIgSG9zdCBvciBFUCBhY2NvcmRpbmcNCj4gPiA+ID4g
dG8NCj4gPiA+ID4gc29tZQ0KPiA+ID4gPiBlYXJseSBib290IEZXLiBUbyBtYWtlIHN1cmUgdGhl
cmUgaXMgbm8gZGlzY3JlcGFuY3kgKGUuZy4gRlcNCj4gPiA+ID4gY29uZmlndXJlZA0KPiA+ID4g
PiB0aGUgcG9ydCB0byBFUCBtb2RlIHdoaWxlIHRoZSBEVCBzcGVjaWZpZXMgaXQgYXMgYSBob3N0
IGJyaWRnZQ0KPiA+ID4gPiBvcg0KPiA+ID4gPiB2aWNlDQo+ID4gPiA+IHZlcnNhKSwgYSBjaGVj
ayBoYXMgYmVlbiBhZGRlZCBmb3IgZWFjaCBtb2RlLg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVk
LW9mZi1ieTogSm9uYXRoYW4gQ2hvY3JvbiA8am9ubnljQGFtYXpvbi5jb20+DQo+ID4gPiA+IEFj
a2VkLWJ5OiBHdXN0YXZvIFBpbWVudGVsIDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT4N
Cj4gPiA+ID4gLS0tDQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRl
c2lnbndhcmUtZXAuYyAgIHwgOCArKysrKysrKw0KPiA+ID4gPiAgZHJpdmVycy9wY2kvY29udHJv
bGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDggKysrKysrKysNCj4gPiA+ID4gIDIg
ZmlsZXMgY2hhbmdlZCwgMTYgaW5zZXJ0aW9ucygrKQ0KPiA+ID4gPiANCj4gPiA+ID4gZGlmZiAt
LWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+
ID4gPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMN
Cj4gPiA+ID4gaW5kZXggMmJmNWEzNWMwNTcwLi4wMGU1OWExMzRiOTMgMTAwNjQ0DQo+ID4gPiA+
IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1lcC5jDQo+
ID4gPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1l
cC5jDQo+ID4gPiA+IEBAIC01MzEsNiArNTMxLDcgQEAgaW50IGR3X3BjaWVfZXBfaW5pdChzdHJ1
Y3QgZHdfcGNpZV9lcCAqZXApDQo+ID4gPiA+ICAJaW50IHJldDsNCj4gPiA+ID4gIAl1MzIgcmVn
Ow0KPiA+ID4gPiAgCXZvaWQgKmFkZHI7DQo+ID4gPiA+ICsJdTggaGRyX3R5cGU7DQo+ID4gPiA+
ICAJdW5zaWduZWQgaW50IG5iYXJzOw0KPiA+ID4gPiAgCXVuc2lnbmVkIGludCBvZmZzZXQ7DQo+
ID4gPiA+ICAJc3RydWN0IHBjaV9lcGMgKmVwYzsNCj4gPiA+ID4gQEAgLTU0Myw2ICs1NDQsMTMg
QEAgaW50IGR3X3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNpZV9lcCAqZXApDQo+ID4gPiA+ICAJ
CXJldHVybiAtRUlOVkFMOw0KPiA+ID4gPiAgCX0NCj4gPiA+ID4gIA0KPiA+ID4gPiArCWhkcl90
eXBlID0gZHdfcGNpZV9yZWFkYl9kYmkocGNpLCBQQ0lfSEVBREVSX1RZUEUpOw0KPiA+ID4gPiAr
CWlmIChoZHJfdHlwZSAhPSBQQ0lfSEVBREVSX1RZUEVfTk9STUFMKSB7DQo+ID4gPiA+ICsJCWRl
dl9lcnIocGNpLT5kZXYsICJQQ0llIGNvbnRyb2xsZXIgaXMgbm90IHNldA0KPiA+ID4gPiB0byBF
UA0KPiA+ID4gPiBtb2RlIChoZHJfdHlwZToweCV4KSFcbiIsDQo+ID4gPiA+ICsJCQloZHJfdHlw
ZSk7DQo+ID4gPiA+ICsJCXJldHVybiAtRUlPOw0KPiA+ID4gPiArCX0NCj4gPiA+ID4gKw0KPiA+
ID4gPiAgCXJldCA9IG9mX3Byb3BlcnR5X3JlYWRfdTMyKG5wLCAibnVtLWliLXdpbmRvd3MiLCAm
ZXAtDQo+ID4gPiA+ID4gbnVtX2liX3dpbmRvd3MpOw0KPiA+ID4gPiANCj4gPiA+ID4gIAlpZiAo
cmV0IDwgMCkgew0KPiA+ID4gPiAgCQlkZXZfZXJyKGRldiwgIlVuYWJsZSB0byByZWFkICpudW0t
aWItd2luZG93cyoNCj4gPiA+ID4gcHJvcGVydHlcbiIpOw0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4g
PiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4g
PiA+ID4gaW5kZXggZjkzMjUyZDBkYTViLi5kMmNhNzQ4ZTRjODUgMTAwNjQ0DQo+ID4gPiA+IC0t
LSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4g
PiA+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhv
c3QuYw0KPiA+ID4gPiBAQCAtMzIzLDYgKzMyMyw3IEBAIGludCBkd19wY2llX2hvc3RfaW5pdChz
dHJ1Y3QgcGNpZV9wb3J0ICpwcCkNCj4gPiA+ID4gIAlzdHJ1Y3QgcGNpX2J1cyAqY2hpbGQ7DQo+
ID4gPiA+ICAJc3RydWN0IHBjaV9ob3N0X2JyaWRnZSAqYnJpZGdlOw0KPiA+ID4gPiAgCXN0cnVj
dCByZXNvdXJjZSAqY2ZnX3JlczsNCj4gPiA+ID4gKwl1OCBoZHJfdHlwZTsNCj4gPiA+ID4gIAlp
bnQgcmV0Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJcmF3X3NwaW5fbG9ja19pbml0KCZwY2ktPnBw
LmxvY2spOw0KPiA+ID4gPiBAQCAtMzk2LDYgKzM5NywxMyBAQCBpbnQgZHdfcGNpZV9ob3N0X2lu
aXQoc3RydWN0IHBjaWVfcG9ydA0KPiA+ID4gPiAqcHApDQo+ID4gPiA+ICAJCX0NCj4gPiA+ID4g
IAl9DQo+ID4gPiA+ICANCj4gPiA+ID4gKwloZHJfdHlwZSA9IGR3X3BjaWVfcmVhZGJfZGJpKHBj
aSwgUENJX0hFQURFUl9UWVBFKTsNCj4gPiA+IA0KPiA+ID4gRG8gd2Uga25vdyBpZiBpdCdzIGFs
d2F5cyBzYWZlIHRvIHJlYWQgdGhlc2UgcmVnaXN0ZXJzIGF0IHRoaXMNCj4gPiA+IHBvaW50DQo+
ID4gPiBpbiB0aW1lPw0KPiA+ID4gDQo+ID4gPiBMYXRlciBpbiBkd19wY2llX2hvc3RfaW5pdCB3
ZSBjYWxsIHBwLT5vcHMtPmhvc3RfaW5pdCAtIGxvb2tpbmcNCj4gPiA+IGF0DQo+ID4gPiB0aGUN
Cj4gPiA+IGltcGxlbWVudGF0aW9ucyBvZiAuaG9zdF9pbml0IEkgY2FuIHNlZToNCj4gPiA+IA0K
PiA+ID4gIC0gcmVzZXRzIGJlaW5nIHBlcmZvcm1lZCAocWNvbV9lcF9yZXNldF9hc3NlcnQsDQo+
ID4gPiAgICBhcnRwZWM2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQsIGlteDZfcGNpZV9hc3NlcnRf
Y29yZV9yZXNldCkNCj4gPiA+ICAtIGNoYW5nZXMgdG8gY29uZmlnIHNwYWNlIHJlZ2lzdGVycyAo
a3NfcGNpZV9pbml0X2lkLA0KPiA+ID4gZHdfcGNpZV9zZXR1cF9yYykNCj4gPiA+ICAgIGluY2x1
ZGluZyBzZXR0aW5nIFBDSV9DTEFTU19ERVZJQ0UNCj4gPiA+ICAtIGFuZCBjbG9ja3MgYmVpbmcg
ZW5hYmxlZCAocWNvbV9wY2llX2luaXRfMV8wXzApDQo+ID4gPiANCj4gPiANCj4gPiBHb29kIHBv
aW50ISBUaGlzIGluZGVlZCBtaWdodCBicmVhayBob3N0IGRyaXZlcnMgd2hpY2ggYWN0dWFsbHkN
Cj4gPiBzZXR1cA0KPiA+IHRoZSByYyBpbiB0aGUga2VybmVsLCBhbmQgZG9uJ3QgZGVwZW5kIG9u
IGVhcmx5IGJvb3QgRlcuIFNvIHRoZQ0KPiA+IHZhbGlkYXRpb24gc2hvdWxkIHByb2JhYmx5IGJl
IG1vdmVkIHRvIGFmdGVyIHBwLT5vcHMtPmhvc3RfaW5pdCgpDQo+ID4gKGFuZA0KPiA+IHNpbWls
YXJseSBhZnRlciBlcC0+b3BzLT5lcF9pbml0KCkgZm9yIHRoZSBlcCBkcml2ZXIpLCByaWdodD8N
Cj4gDQo+IFllcyBJIHRoaW5rIHNvLg0KPiANCkRvbmUgYXMgcGFydCBvZiB2NS4NCj4gDQo+ID4g
DQo+ID4gPiBJJ20gbm90IHN1cmUgaWYgeW91ciBjaGFuZ2VzIHdvdWxkIGNhdXNlIGFueXRoaW5n
IHRvIGJyZWFrIGZvcg0KPiA+ID4gdGhlc2UNCj4gPiA+IG90aGVyDQo+ID4gPiBjb250cm9sbGVy
cyAob3IgZnV0dXJlIGNvbnRyb2xsZXJzKSBhcyBJIGNvdWxkbid0IHNlZSBhbnkgb3RoZXINCj4g
PiA+IHJlYWRzDQo+ID4gPiB0byB0aGUNCj4gPiA+IGNvbmZpZy4NCj4gPiA+IA0KPiA+ID4gR2l2
ZW4gdGhhdCB3ZSBhcmUgcmVhZGluZyBjb25maWcgc3BhY2Ugc2hvdWxkIGR3X3BjaWVfcmRfb3du
X2NvbmYNCj4gPiA+IGJlDQo+ID4gPiB1c2VkPw0KPiA+IA0KPiA+IFRoZSBjb25maWcgc3BhY2Ug
b2YgdGhlIERXIGNvcmUgaXMgbG9jYXRlZCBhdCB0aGUgYmVnaW5uaW5nIG9mIHRoZQ0KPiA+IERC
SQ0KPiA+IHJlZ3NwYWNlLiBGdXJ0aGVybW9yZSwgdGhpcyB3b3VsZCBicmVhayB0aGUgInN5bW1l
dHJ5IiBiZXR3ZWVuIHRoZQ0KPiA+IGhvc3QNCj4gPiBhbmQgZXAgdmFsaWRhdGlvbnMgKHNpbmNl
IHRoZSBlcCBoYXMgbm8gbm90aW9uIG9mIHJlYWRpbmcgZnJvbQ0KPiA+IGNvbmZpZw0KPiA+IHNw
YWNlIG5vciBhIC5yZWFkIGNhbGxiYWNrIGluIHN0cnVjdCBkd19wY2llX2VwX29wcykuDQo+IA0K
PiBUaGlzIGlzIHRydWUsIHRob3VnaCBnaXZlbiBob3cgZGlmZmVyZW50IHRoZSB0d28gZHJpdmVy
cyBhcmUgLSB0aGlzDQo+IGlzIG9ubHkNCj4gcmVhbGx5ICduaWNlIHRvIGhhdmUnLg0KPiANCj4g
DQo+ID4gSSBhZ3JlZSB0aGF0DQo+ID4gdGhlcmUgaXMgc29tZSBzb3J0IG9mIG92ZXJsYXAgYmV0
d2VlbiB0aGUgZHdfcGNpZV9yZWFkey93cml0ZX1fZGJpDQo+ID4gZHdfcGNpZV9yZHsvd3J9X293
bl9jb25mIEFQSXMsIHdoZW4gYWNjZXNzaW5nIHRoZSBob3N0IG1vZGUgY29uZmlnDQo+ID4gc3Bh
Y2UsIGJ1dCBJIGFzc3VtZSB0aGF0IGFueSBob3N0IGRyaXZlciB3aGljaCBzdXBwbGllcyBhIGNh
bGxiYWNrDQo+ID4gZm9yDQo+ID4gLnJkX293bl9jb25mKCkgbXVzdCBzdXBwbHkgYW4gZXF1aXZh
bGVudCAucmVhZF9kYmkoKSBvbmUgYXMgd2VsbC4NCj4gPiANCj4gPiA+IChGb3IgZXhhbXBsZSBr
aXJpbl9wY2llX3JkX293bl9jb25mIGRvZXMgc29tZXRoaW5nIHNwZWNpYWwpLg0KPiA+ID4gDQo+
ID4gDQo+ID4gVGhleSBzcGVjaWZpY2FsbHkgZGVmaW5lIGFuIGVxdWl2YWxlbnQga2lyaW5fcGNp
ZV9yZWFkX2RiaSgpLg0KPiANCj4gVGhpcyBtYXkgYWxzbyBiZSB0cnVlLiBIb3dldmVyIGdpdmVu
IHRoYXQgdGhlIGR3YyBmcmFtZXdvcmsgZ2l2ZXMNCj4gaG9zdCBkcml2ZXJzDQo+IHRoZSBhYmls
aXR5IHRvIHByb3ZpZGUgdGhlaXIgb3duIHJkX293bl9jb25mIGNhbGxiYWNrIC0gaXQncyB2ZXJ5
DQo+IHBvc3NpYmxlDQo+IHRoYXQgdGhlc2UgZHJpdmVycyBjYW4gdXNlIHRoZSBjYWxsYmFjayB0
byBoYW5kbGUgcXVpcmtzIC0gbm93IG9yIGluDQo+IHRoZQ0KPiBmdXR1cmUuIFBvdGVudGlhbGx5
IGEgcXVpcmsgdGhhdCB5b3VyIGRpcmVjdCByZWFkaW5nIHdvbid0IGhhbmRsZS4NCj4gDQo+IExv
b2tpbmcgYXQgdGhlIGV4aXN0aW5nIGRyaXZlcnMgd2hpY2ggcHJvdmlkZSBhIC5yZF9vd25fY29u
ZjoNCj4gDQo+IHBjaS1leHlub3MuYzoNCj4gIC0gVXNlcyBkd19wY2llX3JlYWQgdG8gZGlyZWN0
bHkgcmVhZCBmcm9tIHJlZ2lzdGVycywgc2FuZHdpY2gnZA0KPiBiZXR3ZWVuIHdyaXRlcw0KPiAg
ICB0byBzZXQvY2xlYXIgUENJRV9FTEJJX1NMVl9BUk1JU0MuIFRoaXMgZHJpdmVyIHByb3ZpZGVz
IGENCj4gLnJlYWRfZGJpIHdoaWNoDQo+ICAgIG1lYW5zIGR3X3BjaWVfcmVhZGJfZGJpIHByb2Jh
Ymx5IGRvZXMgdGhlIHNhbWUgdGhpbmcgYXMNCj4gcmRfb3duX2NvbmYuDQo+IA0KPiBwY2ktbWVu
c29uLmM6DQo+ICAtIFVzZXMgZHdfcGNpZV9yZWFkIHRvIGRpcmVjdGx5IHJlYWQgZnJvbSByZWdp
c3RlcnMsIGl0IHRoZW4gYXBwbGllcw0KPiBhIHJlYWQNCj4gICAgcXVpcmsgZm9yIHRoZSBQQ0lf
Q0xBU1NfREVWSUNFIHJlZ2lzdGVyLiBUaGlzIGRyaXZlciBkb2Vzbid0DQo+IHByb3ZpZGUgYQ0K
PiAgICAucmVhZF9kYmkgLSB0aHVzIGR3X3BjaWVfcmVhZGJfZGJpIHByb2JhYmx5IGRvZXMgdGhl
IHNhbWUgdGhpbmcgYXMNCj4gICAgcmRfb3duX2NvbmYgcHJvdmlkZWQgeW91IGRvbid0IHJlYWQg
dGhlIFBDSV9DTEFTU19ERVZJQ0UgcmVnaXN0ZXIuDQo+IA0KPiBwY2llLWhpc2kuYzoNCj4gIC0g
VXNlcyBkd19wY2llX3JlYWRsX2RiaSB0byByZWFkIGZyb20gcmVnaXN0ZXJzLCBidXQgdGhlIGNv
bnRyb2xsZXINCj4gb25seQ0KPiAgICBzdXBwb3J0cyAzMmJpdCBhbGlnbmVkIHJlYWRzIC0gaXQg
ZG9lc24ndCBwcm92aWRlIGEgLnJlYWRfZGJpLg0KPiBUaGlzIG1lYW5zDQo+ICAgIHRoYXQgaWYg
eW91IHVzZWQgZHdfcGNpZV9yZWFkYl9kYmkgaXQnZCBwcm9iYWJseSBicmVhayBiZWNhdXNlIHlv
dQ0KPiBjYW4ndA0KPiAgICByZWFkIDEgYnl0ZSBhdCB0aGUgb2Zmc2V0IHdoZXJlIEhFQURFUl9U
WVBFIGlzLg0KPiANCj4gcGNpZS1oaXN0Yi5jLCBwY2llLWtpcmluLmM6IGxvb2tzIGxpa2UgcGNp
LWV4eW5vcy5jDQo+IA0KPiBJdCBsb29rcyBsaWtlIHdlJ3JlIGdvaW5nIHRvIGhhdmUgdG8gYnJl
YWsgc3ltbWV0cnkuLi4NCj4gDQpEb25lIGFzIHBhcnQgb2YgdjUuDQoNClRoYW5rcyBmb3IgeW91
ciBpbnNpZ2h0ZnVsIHJldmlldy4NCg0KPiBUaGFua3MsDQo+IA0KPiBBbmRyZXcgTXVycmF5DQo+
IA0KPiA+IA0KPiA+ID4gVGhhbmtzLA0KPiA+ID4gDQo+ID4gPiBBbmRyZXcgTXVycmF5DQo+ID4g
PiANCj4gPiA+ID4gKwlpZiAoaGRyX3R5cGUgIT0gUENJX0hFQURFUl9UWVBFX0JSSURHRSkgew0K
PiA+ID4gPiArCQlkZXZfZXJyKHBjaS0+ZGV2LCAiUENJZSBjb250cm9sbGVyIGlzIG5vdCBzZXQN
Cj4gPiA+ID4gdG8gYnJpZGdlDQo+ID4gPiA+IHR5cGUgKGhkcl90eXBlOiAweCV4KSFcbiIsDQo+
ID4gPiA+ICsJCQloZHJfdHlwZSk7DQo+ID4gPiA+ICsJCXJldHVybiAtRUlPOw0KPiA+ID4gPiAr
CX0NCj4gPiA+ID4gKw0KPiA+ID4gPiAgCXBwLT5tZW1fYmFzZSA9IHBwLT5tZW0tPnN0YXJ0Ow0K
PiA+ID4gPiAgDQo+ID4gPiA+ICAJaWYgKCFwcC0+dmFfY2ZnMF9iYXNlKSB7DQo+ID4gPiA+IC0t
IA0KPiA+ID4gPiAyLjE3LjENCj4gPiA+ID4gDQo=
