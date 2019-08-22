Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6577E99934
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 18:31:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732847AbfHVQam (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 12:30:42 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:26625 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389939AbfHVQal (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 12:30:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566491439; x=1598027439;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=KkV09y4B5mkQruE6IbrnT1eGI+VPuKeLj/rJNcIegm0=;
  b=JyL+sIxw2Ou59y95gkhjxSnsrZGFbos0da1tiK0HJCawM1LTp3bBz1Rp
   RWkCG2nQcTyK0NAxxweZjot70odCr6PipvoMo8aKfU1pI7nYwlwkBQ19V
   Pfp4SIBJefJtNTpywSLzCCIZHqpSYqHE57ujTBLzUxwGYJ12gaebq0PQJ
   s=;
X-IronPort-AV: E=Sophos;i="5.64,417,1559520000"; 
   d="scan'208";a="822736964"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-27fb8269.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 22 Aug 2019 16:30:33 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-27fb8269.us-east-1.amazon.com (Postfix) with ESMTPS id D0D8DA276C;
        Thu, 22 Aug 2019 16:30:32 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 16:30:10 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 16:30:09 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Thu, 22 Aug 2019 16:30:09 +0000
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
Thread-Index: AQHVWDfYfXzAIUBUVEGXGWtVpGVRnqcHBMEAgABYiAA=
Date:   Thu, 22 Aug 2019 16:30:09 +0000
Message-ID: <f8fca74c8d252f000d60c52ead3fc41ed5d50b6d.camel@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
         <20190821154745.31834-3-jonnyc@amazon.com>
         <20190822111315.GN23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190822111315.GN23903@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.137]
Content-Type: text/plain; charset="utf-8"
Content-ID: <28A81580BA6B964C814E165BCC9FC5A6@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDEyOjEzICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNjo0Nzo0NVBNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IFNvbWUgUENJZSBjb250cm9sbGVycyBjYW4gYmUgc2V0IHRvIGVpdGhl
ciBIb3N0IG9yIEVQIGFjY29yZGluZyB0bw0KPiA+IHNvbWUNCj4gPiBlYXJseSBib290IEZXLiBU
byBtYWtlIHN1cmUgdGhlcmUgaXMgbm8gZGlzY3JlcGFuY3kgKGUuZy4gRlcNCj4gPiBjb25maWd1
cmVkDQo+ID4gdGhlIHBvcnQgdG8gRVAgbW9kZSB3aGlsZSB0aGUgRFQgc3BlY2lmaWVzIGl0IGFz
IGEgaG9zdCBicmlkZ2Ugb3INCj4gPiB2aWNlDQo+ID4gdmVyc2EpLCBhIGNoZWNrIGhhcyBiZWVu
IGFkZGVkIGZvciBlYWNoIG1vZGUuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4g
Q2hvY3JvbiA8am9ubnljQGFtYXpvbi5jb20+DQo+ID4gQWNrZWQtYnk6IEd1c3Rhdm8gUGltZW50
ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYyAgIHwgOCArKysrKysrKw0K
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwg
OCArKysrKysrKw0KPiA+ICAyIGZpbGVzIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253
YXJlLWVwLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2Fy
ZS1lcC5jDQo+ID4gaW5kZXggMmJmNWEzNWMwNTcwLi4wMGU1OWExMzRiOTMgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWVwLmMNCj4g
PiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtZXAuYw0K
PiA+IEBAIC01MzEsNiArNTMxLDcgQEAgaW50IGR3X3BjaWVfZXBfaW5pdChzdHJ1Y3QgZHdfcGNp
ZV9lcCAqZXApDQo+ID4gIAlpbnQgcmV0Ow0KPiA+ICAJdTMyIHJlZzsNCj4gPiAgCXZvaWQgKmFk
ZHI7DQo+ID4gKwl1OCBoZHJfdHlwZTsNCj4gPiAgCXVuc2lnbmVkIGludCBuYmFyczsNCj4gPiAg
CXVuc2lnbmVkIGludCBvZmZzZXQ7DQo+ID4gIAlzdHJ1Y3QgcGNpX2VwYyAqZXBjOw0KPiA+IEBA
IC01NDMsNiArNTQ0LDEzIEBAIGludCBkd19wY2llX2VwX2luaXQoc3RydWN0IGR3X3BjaWVfZXAg
KmVwKQ0KPiA+ICAJCXJldHVybiAtRUlOVkFMOw0KPiA+ICAJfQ0KPiA+ICANCj4gPiArCWhkcl90
eXBlID0gZHdfcGNpZV9yZWFkYl9kYmkocGNpLCBQQ0lfSEVBREVSX1RZUEUpOw0KPiA+ICsJaWYg
KGhkcl90eXBlICE9IFBDSV9IRUFERVJfVFlQRV9OT1JNQUwpIHsNCj4gPiArCQlkZXZfZXJyKHBj
aS0+ZGV2LCAiUENJZSBjb250cm9sbGVyIGlzIG5vdCBzZXQgdG8gRVANCj4gPiBtb2RlIChoZHJf
dHlwZToweCV4KSFcbiIsDQo+ID4gKwkJCWhkcl90eXBlKTsNCj4gPiArCQlyZXR1cm4gLUVJTzsN
Cj4gPiArCX0NCj4gPiArDQo+ID4gIAlyZXQgPSBvZl9wcm9wZXJ0eV9yZWFkX3UzMihucCwgIm51
bS1pYi13aW5kb3dzIiwgJmVwLQ0KPiA+ID5udW1faWJfd2luZG93cyk7DQo+ID4gIAlpZiAocmV0
IDwgMCkgew0KPiA+ICAJCWRldl9lcnIoZGV2LCAiVW5hYmxlIHRvIHJlYWQgKm51bS1pYi13aW5k
b3dzKg0KPiA+IHByb3BlcnR5XG4iKTsNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+IGluZGV4IGY5MzI1MmQwZGE1
Yi4uZDJjYTc0OGU0Yzg1IDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
ZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jDQo+ID4gQEAgLTMyMyw2ICszMjMsNyBAQCBp
bnQgZHdfcGNpZV9ob3N0X2luaXQoc3RydWN0IHBjaWVfcG9ydCAqcHApDQo+ID4gIAlzdHJ1Y3Qg
cGNpX2J1cyAqY2hpbGQ7DQo+ID4gIAlzdHJ1Y3QgcGNpX2hvc3RfYnJpZGdlICpicmlkZ2U7DQo+
ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKmNmZ19yZXM7DQo+ID4gKwl1OCBoZHJfdHlwZTsNCj4gPiAg
CWludCByZXQ7DQo+ID4gIA0KPiA+ICAJcmF3X3NwaW5fbG9ja19pbml0KCZwY2ktPnBwLmxvY2sp
Ow0KPiA+IEBAIC0zOTYsNiArMzk3LDEzIEBAIGludCBkd19wY2llX2hvc3RfaW5pdChzdHJ1Y3Qg
cGNpZV9wb3J0ICpwcCkNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4gIA0KPiA+ICsJaGRyX3R5cGUg
PSBkd19wY2llX3JlYWRiX2RiaShwY2ksIFBDSV9IRUFERVJfVFlQRSk7DQo+IA0KPiBEbyB3ZSBr
bm93IGlmIGl0J3MgYWx3YXlzIHNhZmUgdG8gcmVhZCB0aGVzZSByZWdpc3RlcnMgYXQgdGhpcyBw
b2ludA0KPiBpbiB0aW1lPw0KPiANCj4gTGF0ZXIgaW4gZHdfcGNpZV9ob3N0X2luaXQgd2UgY2Fs
bCBwcC0+b3BzLT5ob3N0X2luaXQgLSBsb29raW5nIGF0DQo+IHRoZQ0KPiBpbXBsZW1lbnRhdGlv
bnMgb2YgLmhvc3RfaW5pdCBJIGNhbiBzZWU6DQo+IA0KPiAgLSByZXNldHMgYmVpbmcgcGVyZm9y
bWVkIChxY29tX2VwX3Jlc2V0X2Fzc2VydCwNCj4gICAgYXJ0cGVjNl9wY2llX2Fzc2VydF9jb3Jl
X3Jlc2V0LCBpbXg2X3BjaWVfYXNzZXJ0X2NvcmVfcmVzZXQpDQo+ICAtIGNoYW5nZXMgdG8gY29u
ZmlnIHNwYWNlIHJlZ2lzdGVycyAoa3NfcGNpZV9pbml0X2lkLA0KPiBkd19wY2llX3NldHVwX3Jj
KQ0KPiAgICBpbmNsdWRpbmcgc2V0dGluZyBQQ0lfQ0xBU1NfREVWSUNFDQo+ICAtIGFuZCBjbG9j
a3MgYmVpbmcgZW5hYmxlZCAocWNvbV9wY2llX2luaXRfMV8wXzApDQo+IA0KR29vZCBwb2ludCEg
VGhpcyBpbmRlZWQgbWlnaHQgYnJlYWsgaG9zdCBkcml2ZXJzIHdoaWNoIGFjdHVhbGx5IHNldHVw
DQp0aGUgcmMgaW4gdGhlIGtlcm5lbCwgYW5kIGRvbid0IGRlcGVuZCBvbiBlYXJseSBib290IEZX
LiBTbyB0aGUNCnZhbGlkYXRpb24gc2hvdWxkIHByb2JhYmx5IGJlIG1vdmVkIHRvIGFmdGVyIHBw
LT5vcHMtPmhvc3RfaW5pdCgpIChhbmQNCnNpbWlsYXJseSBhZnRlciBlcC0+b3BzLT5lcF9pbml0
KCkgZm9yIHRoZSBlcCBkcml2ZXIpLCByaWdodD8NCg0KPiBJJ20gbm90IHN1cmUgaWYgeW91ciBj
aGFuZ2VzIHdvdWxkIGNhdXNlIGFueXRoaW5nIHRvIGJyZWFrIGZvciB0aGVzZQ0KPiBvdGhlcg0K
PiBjb250cm9sbGVycyAob3IgZnV0dXJlIGNvbnRyb2xsZXJzKSBhcyBJIGNvdWxkbid0IHNlZSBh
bnkgb3RoZXIgcmVhZHMNCj4gdG8gdGhlDQo+IGNvbmZpZy4NCj4gDQo+IEdpdmVuIHRoYXQgd2Ug
YXJlIHJlYWRpbmcgY29uZmlnIHNwYWNlIHNob3VsZCBkd19wY2llX3JkX293bl9jb25mIGJlDQo+
IHVzZWQ/DQoNClRoZSBjb25maWcgc3BhY2Ugb2YgdGhlIERXIGNvcmUgaXMgbG9jYXRlZCBhdCB0
aGUgYmVnaW5uaW5nIG9mIHRoZSBEQkkNCnJlZ3NwYWNlLiBGdXJ0aGVybW9yZSwgdGhpcyB3b3Vs
ZCBicmVhayB0aGUgInN5bW1ldHJ5IiBiZXR3ZWVuIHRoZSBob3N0DQphbmQgZXAgdmFsaWRhdGlv
bnMgKHNpbmNlIHRoZSBlcCBoYXMgbm8gbm90aW9uIG9mIHJlYWRpbmcgZnJvbSBjb25maWcNCnNw
YWNlIG5vciBhIC5yZWFkIGNhbGxiYWNrIGluIHN0cnVjdCBkd19wY2llX2VwX29wcykuIEkgYWdy
ZWUgdGhhdA0KdGhlcmUgaXMgc29tZSBzb3J0IG9mIG92ZXJsYXAgYmV0d2VlbiB0aGUgZHdfcGNp
ZV9yZWFkey93cml0ZX1fZGJpDQpkd19wY2llX3Jkey93cn1fb3duX2NvbmYgQVBJcywgd2hlbiBh
Y2Nlc3NpbmcgdGhlIGhvc3QgbW9kZSBjb25maWcNCnNwYWNlLCBidXQgSSBhc3N1bWUgdGhhdCBh
bnkgaG9zdCBkcml2ZXIgd2hpY2ggc3VwcGxpZXMgYSBjYWxsYmFjayBmb3INCi5yZF9vd25fY29u
ZigpIG11c3Qgc3VwcGx5IGFuIGVxdWl2YWxlbnQgLnJlYWRfZGJpKCkgb25lIGFzIHdlbGwuDQoN
Cj4gKEZvciBleGFtcGxlIGtpcmluX3BjaWVfcmRfb3duX2NvbmYgZG9lcyBzb21ldGhpbmcgc3Bl
Y2lhbCkuDQo+IA0KVGhleSBzcGVjaWZpY2FsbHkgZGVmaW5lIGFuIGVxdWl2YWxlbnQga2lyaW5f
cGNpZV9yZWFkX2RiaSgpLg0KDQo+IFRoYW5rcywNCj4gDQo+IEFuZHJldyBNdXJyYXkNCj4gDQo+
ID4gKwlpZiAoaGRyX3R5cGUgIT0gUENJX0hFQURFUl9UWVBFX0JSSURHRSkgew0KPiA+ICsJCWRl
dl9lcnIocGNpLT5kZXYsICJQQ0llIGNvbnRyb2xsZXIgaXMgbm90IHNldCB0byBicmlkZ2UNCj4g
PiB0eXBlIChoZHJfdHlwZTogMHgleCkhXG4iLA0KPiA+ICsJCQloZHJfdHlwZSk7DQo+ID4gKwkJ
cmV0dXJuIC1FSU87DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICAJcHAtPm1lbV9iYXNlID0gcHAtPm1l
bS0+c3RhcnQ7DQo+ID4gIA0KPiA+ICAJaWYgKCFwcC0+dmFfY2ZnMF9iYXNlKSB7DQo+ID4gLS0g
DQo+ID4gMi4xNy4xDQo+ID4gDQo=
