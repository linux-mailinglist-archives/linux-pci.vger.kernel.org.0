Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 29B0785E49
	for <lists+linux-pci@lfdr.de>; Thu,  8 Aug 2019 11:30:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731038AbfHHJaR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 8 Aug 2019 05:30:17 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:4839 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732181AbfHHJaN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 8 Aug 2019 05:30:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565256611; x=1596792611;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=H6vDmx9vvVlk5WxZM6IaoYwjJBRNa46HZWqBzpGVwGM=;
  b=uoQyvRFsm8JYXGiFctvhJYp/bdb4SQ1tyBvuV6+T1x2SavDevMbdmCR6
   TPReYL7qoOWhQpMrA4ZqzFSp0ptvQnDY1IHtvR7e3iGmXrnxX8UbtEOJQ
   E1VWBn/jDTXXu9bySJGSGKerV4QETC8PmN0vLd6HdDj1RTVylrA4D7Kh2
   U=;
X-IronPort-AV: E=Sophos;i="5.64,360,1559520000"; 
   d="scan'208";a="408669705"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 08 Aug 2019 09:30:10 +0000
Received: from EX13MTAUWC001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-38ae4ad2.us-east-1.amazon.com (Postfix) with ESMTPS id 5B842A248C;
        Thu,  8 Aug 2019 09:30:07 +0000 (UTC)
Received: from EX13D02UWC004.ant.amazon.com (10.43.162.236) by
 EX13MTAUWC001.ant.amazon.com (10.43.162.135) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Aug 2019 09:30:05 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D02UWC004.ant.amazon.com (10.43.162.236) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 8 Aug 2019 09:30:05 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Thu, 8 Aug 2019 09:30:05 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "Woodhouse, David" <dwmw@amazon.co.uk>,
        "Hanoch, Uri" <hanochu@amazon.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "Wasserstrom, Barak" <barakw@amazon.com>,
        "Saidi, Ali" <alisaidi@amazon.com>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 8/8] PCI: dw: Add support for
 PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags
Thread-Topic: [PATCH v3 8/8] PCI: dw: Add support for
 PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags
Thread-Index: AQHVQTjgJY6X9sfi40Wq6J7sfEVWx6bv+jIAgAEbEoA=
Date:   Thu, 8 Aug 2019 09:30:05 +0000
Message-ID: <67c58ded2177beca030450c25d742d35890eb48a.camel@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
         <20190723092711.11786-4-jonnyc@amazon.com>
         <20190807163654.GC16214@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190807163654.GC16214@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.8]
Content-Type: text/plain; charset="utf-8"
Content-ID: <02523ED388245240977776EA8FACEFCD@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDE5LTA4LTA3IGF0IDE3OjM2ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gVHVlLCBKdWwgMjMsIDIwMTkgYXQgMTI6Mjc6MTFQTSArMDMwMCwgSm9uYXRoYW4g
Q2hvY3JvbiB3cm90ZToNCj4gPiBUaGlzIGJhc2ljYWxseSBhbGlnbnMgdGhlIHVzYWdlIG9mIFBD
SV9QUk9CRV9PTkxZIGFuZA0KPiA+IFBDSV9SRUFTU0lHTl9BTExfQlVTIGluIGR3X3BjaWVfaG9z
dF9pbml0KCkgd2l0aCB0aGUgbG9naWMgaW4NCj4gPiBwY2lfaG9zdF9jb21tb25fcHJvYmUoKS4N
Cj4gPiANCj4gPiBOb3cgaXQgd2lsbCBiZSBwb3NzaWJsZSB0byBjb250cm9sIHZpYSB0aGUgZGV2
aWNldHJlZSB3aGV0aGVyIHRvDQo+ID4ganVzdA0KPiA+IHByb2JlIHRoZSBQQ0kgYnVzIChpbiBj
YXNlcyB3aGVyZSBGVyBhbHJlYWR5IGNvbmZpZ3VyZWQgaXQpIG9yIHRvDQo+ID4gZnVsbHkNCj4g
PiBjb25maWd1cmUgaXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2hvY3Jv
biA8am9ubnljQGFtYXpvbi5jb20+DQo+ID4gLS0tDQo+ID4gIC4uLi9wY2kvY29udHJvbGxlci9k
d2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYyB8IDIzDQo+ID4gKysrKysrKysrKysrKysrLS0tLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKSwgNCBkZWxldGlvbnMoLSkNCj4g
PiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLWhvc3QuYw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNp
Z253YXJlLWhvc3QuYw0KPiA+IGluZGV4IGQyY2E3NDhlNGM4NS4uMGEyOTRkOGFhMjFhIDEwMDY0
NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1o
b3N0LmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtaG9zdC5jDQo+ID4gQEAgLTM0Miw2ICszNDIsOCBAQCBpbnQgZHdfcGNpZV9ob3N0X2luaXQo
c3RydWN0IHBjaWVfcG9ydCAqcHApDQo+ID4gIAlpZiAoIWJyaWRnZSkNCj4gPiAgCQlyZXR1cm4g
LUVOT01FTTsNCj4gPiAgDQo+ID4gKwlvZl9wY2lfY2hlY2tfcHJvYmVfb25seSgpOw0KPiA+ICsN
Cj4gPiAgCXJldCA9IGRldm1fb2ZfcGNpX2dldF9ob3N0X2JyaWRnZV9yZXNvdXJjZXMoZGV2LCAw
LCAweGZmLA0KPiA+ICAJCQkJCSZicmlkZ2UtPndpbmRvd3MsICZwcC0NCj4gPiA+aW9fYmFzZSk7
DQo+ID4gIAlpZiAocmV0KQ0KPiA+IEBAIC00NzQsNiArNDc2LDEwIEBAIGludCBkd19wY2llX2hv
c3RfaW5pdChzdHJ1Y3QgcGNpZV9wb3J0ICpwcCkNCj4gPiAgDQo+ID4gIAlwcC0+cm9vdF9idXNf
bnIgPSBwcC0+YnVzbi0+c3RhcnQ7DQo+ID4gIA0KPiA+ICsJLyogRG8gbm90IHJlYXNzaWduIGJ1
cyBudW1zIGlmIHByb2JlIG9ubHkgKi8NCj4gPiArCWlmICghcGNpX2hhc19mbGFnKFBDSV9QUk9C
RV9PTkxZKSkNCj4gPiArCQlwY2lfYWRkX2ZsYWdzKFBDSV9SRUFTU0lHTl9BTExfQlVTKTsNCj4g
DQo+IFRoaXMgY2hhbmdlcyB0aGUgZGVmYXVsdCBmb3IgYnVzIHJlYXNzaWdubWVudCBvbiBhbGwg
RFdDIGhvc3QgKHRoYXQNCj4gYXJlDQo+ICFQQ0lfUFJPQkVfT05MWSksIHdlIHNob3VsZCBkcm9w
IHRoaXMgbGluZSwgaXQgY2FuIHRyaWdnZXINCj4gcmVncmVzc2lvbnMuDQo+IA0KV2lsbCBiZSBk
cm9wcGVkIGFzIHBhcnQgb2YgdjQuIFRoZXJlIG1pZ2h0IGFsc28gYmUgYSBiZWhhdmlvcmFsDQpk
aWZmZXJlbmNlIGJlbG93IHdoZXJlIEkgYWRkZWQgdGhlIGlmIChwY2lfaGFzX2ZsYWcoUENJX1BS
T0JFX09OTFkpKS4NCklzIHRoYXQgc3RpbGwgb2s/DQoNCkFzIEkgcG9pbnRlZCBvdXQgaW4gdGhl
IGNvdmVyIGxldHRlciwgc2luY2UgUENJX1BST0JFX09OTFkgaXMgYSBzeXN0ZW0NCndpZGUgZmxh
ZywgZG9lcyBpdCBtYWtlIHNlbnNlIHRvIGNhbGwgb2ZfcGNpX2NoZWNrX3Byb2JlX29ubHkoKSBo
ZXJlLA0KaW4gdGhlIGNvbnRleHQgb2YgYSBzcGVjaWZpYyBkcml2ZXIgKGluY2x1ZGluZyB0aGUg
ZXhpc3RpbmcgaW52b2NhdGlvbg0KaW4gcGNpX2hvc3RfY29tbW9uX3Byb2JlKCkpLCBhcyBvcHBv
c2VkIHRvIGEgcGxhdGZvcm0vYXJjaCBjb250ZXh0Pw0KDQoNCj4gSWYgd2Ugc3RpbGwgd2FudCB0
byBtZXJnZSBpdCBhcyBhIHNlcGFyYXRlIGNoYW5nZSB3ZSBtdXN0IHRlc3QgaXQgb24NCj4gYWxs
DQo+IERXQyBob3N0IGJyaWRnZXMgdG8gbWFrZSBzdXJlIGl0IGRvZXMgbm90IHRyaWdnZXIgYW55
IGlzc3VlcyB3aXRoDQo+IGN1cnJlbnQgc2V0LXVwcywgdGhhdCdzIG5vdCBnb2luZyB0byBiZSBl
YXN5IHRob3VnaC4NCj4gDQpKdXN0IG91dCBvZiBjdXJpb3NpdHksIGhvdyBhcmUgc3VjaCBleGhh
dXN0aXZlIHRlc3RzIGFjaGlldmVkIHdoZW4gYQ0KcGF0Y2ggcmVxdWlyZXMgdGhlbT8NCg0KPiBM
b3JlbnpvDQo+IA0KPiA+ICsNCj4gPiAgCWJyaWRnZS0+ZGV2LnBhcmVudCA9IGRldjsNCj4gPiAg
CWJyaWRnZS0+c3lzZGF0YSA9IHBwOw0KPiA+ICAJYnJpZGdlLT5idXNuciA9IHBwLT5yb290X2J1
c19ucjsNCj4gPiBAQCAtNDkwLDExICs0OTYsMjAgQEAgaW50IGR3X3BjaWVfaG9zdF9pbml0KHN0
cnVjdCBwY2llX3BvcnQgKnBwKQ0KPiA+ICAJaWYgKHBwLT5vcHMtPnNjYW5fYnVzKQ0KPiA+ICAJ
CXBwLT5vcHMtPnNjYW5fYnVzKHBwKTsNCj4gPiAgDQo+ID4gLQlwY2lfYnVzX3NpemVfYnJpZGdl
cyhwcC0+cm9vdF9idXMpOw0KPiA+IC0JcGNpX2J1c19hc3NpZ25fcmVzb3VyY2VzKHBwLT5yb290
X2J1cyk7DQo+ID4gKwkvKg0KPiA+ICsJICogV2UgaW5zZXJ0IFBDSSByZXNvdXJjZXMgaW50byB0
aGUgaW9tZW1fcmVzb3VyY2UgYW5kDQo+ID4gKwkgKiBpb3BvcnRfcmVzb3VyY2UgdHJlZXMgaW4g
ZWl0aGVyIHBjaV9idXNfY2xhaW1fcmVzb3VyY2VzKCkNCj4gPiArCSAqIG9yIHBjaV9idXNfYXNz
aWduX3Jlc291cmNlcygpLg0KPiA+ICsJICovDQo+ID4gKwlpZiAocGNpX2hhc19mbGFnKFBDSV9Q
Uk9CRV9PTkxZKSkgew0KPiA+ICsJCXBjaV9idXNfY2xhaW1fcmVzb3VyY2VzKHBwLT5yb290X2J1
cyk7DQo+ID4gKwl9IGVsc2Ugew0KPiA+ICsJCXBjaV9idXNfc2l6ZV9icmlkZ2VzKHBwLT5yb290
X2J1cyk7DQo+ID4gKwkJcGNpX2J1c19hc3NpZ25fcmVzb3VyY2VzKHBwLT5yb290X2J1cyk7DQo+
ID4gIA0KPiA+IC0JbGlzdF9mb3JfZWFjaF9lbnRyeShjaGlsZCwgJnBwLT5yb290X2J1cy0+Y2hp
bGRyZW4sIG5vZGUpDQo+ID4gLQkJcGNpZV9idXNfY29uZmlndXJlX3NldHRpbmdzKGNoaWxkKTsN
Cj4gPiArCQlsaXN0X2Zvcl9lYWNoX2VudHJ5KGNoaWxkLCAmcHAtPnJvb3RfYnVzLT5jaGlsZHJl
biwNCj4gPiBub2RlKQ0KPiA+ICsJCQlwY2llX2J1c19jb25maWd1cmVfc2V0dGluZ3MoY2hpbGQp
Ow0KPiA+ICsJfQ0KPiA+ICANCj4gPiAgCXBjaV9idXNfYWRkX2RldmljZXMocHAtPnJvb3RfYnVz
KTsNCj4gPiAgCXJldHVybiAwOw0KPiA+IC0tIA0KPiA+IDIuMTcuMQ0KPiA+IA0K
