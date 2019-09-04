Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1E981A8499
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 15:50:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730070AbfIDNgW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 09:36:22 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:52794 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727741AbfIDNgW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 09:36:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567604179; x=1599140179;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=iCBEigcARKJVVUjNYvwnlk00blXXTDT27ht3MXdVXoM=;
  b=nYOlgtmTHtN8WKWuyP84JHyL2Pm7Nmrwh9Xyq8U1suCvpFvJOh1JDg+s
   NRcjoSevt113jda64qtTULsqBA9jFkE2K3UJRqwWvJlyIDT9i0HgolhMG
   Wc3Grhait1MgfFdUByWHctCEexUhhsLv2+HJzHHFP64H6b08/ChWu66bU
   o=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="419418402"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-9ec21598.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 04 Sep 2019 13:36:18 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-9ec21598.us-east-1.amazon.com (Postfix) with ESMTPS id 7A23CA260E;
        Wed,  4 Sep 2019 13:36:14 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:36:13 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:36:13 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Wed, 4 Sep 2019 13:36:12 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "andrew.murray@arm.com" <andrew.murray@arm.com>
CC:     "babu.moger@oracle.com" <babu.moger@oracle.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Thread-Index: AQHVWDYx1otPgAUY7UaMxbVyR8qrcqcHDLyAgAAwyQCAAAjMgIAUVK8A
Date:   Wed, 4 Sep 2019 13:36:12 +0000
Message-ID: <0e53d9536ede1bff2e178192256392779d1d0455.camel@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
         <20190821153545.17635-4-jonnyc@amazon.com>
         <20190822114146.GP23903@e119886-lin.cambridge.arm.com>
         <5a2c0097471e933d6f6a3964ac9fba9520994991.camel@amazon.com>
         <20190822150752.GQ23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190822150752.GQ23903@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.218]
Content-Type: text/plain; charset="utf-8"
Content-ID: <F8D533018B5CCC46BBB150C25C9E2DC2@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDE2OjA3ICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBUaHUsIEF1ZyAyMiwgMjAxOSBhdCAwMjozNjoyNFBNICswMDAwLCBDaG9jcm9uLCBKb25h
dGhhbiB3cm90ZToNCj4gPiBPbiBUaHUsIDIwMTktMDgtMjIgYXQgMTI6NDEgKzAxMDAsIEFuZHJl
dyBNdXJyYXkgd3JvdGU6DQo+ID4gPiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNjozNTo0M1BN
ICswMzAwLCBKb25hdGhhbiBDaG9jcm9uIHdyb3RlOg0KPiA+ID4gPiBUaGUgQW1hem9uIEFubmFw
dXJuYSBMYWJzIFBDSWUgUm9vdCBQb3J0IGV4cG9zZXMgdGhlIFZQRA0KPiA+ID4gPiBjYXBhYmls
aXR5LA0KPiA+ID4gPiBidXQgdGhlcmUgaXMgbm8gYWN0dWFsIHN1cHBvcnQgZm9yIGl0Lg0KPiA+
ID4gPiANCj4gPiA+ID4gVGhlIHJlYXNvbiBmb3Igbm90IHVzaW5nIHRoZSBhbHJlYWR5IGV4aXN0
aW5nDQo+ID4gPiA+IHF1aXJrX2JsYWNrbGlzdF92cGQoKQ0KPiA+ID4gPiBpcyB0aGF0LCBhbHRo
b3VnaCB0aGlzIGZhaWxzIHBjaV92cGRfcmVhZC93cml0ZSwgdGhlICd2cGQnDQo+ID4gPiA+IHN5
c2ZzDQo+ID4gPiA+IGVudHJ5IHN0aWxsIGV4aXN0cy4gV2hlbiBydW5uaW5nIGxzcGNpIC12diwg
Zm9yIGV4YW1wbGUsIHRoaXMNCj4gPiA+ID4gcmVzdWx0cyBpbiB0aGUgZm9sbG93aW5nIGVycm9y
Og0KPiA+ID4gPiANCj4gPiA+ID4gcGNpbGliOiBzeXNmc19yZWFkX3ZwZDogcmVhZCBmYWlsZWQ6
IElucHV0L291dHB1dCBlcnJvcg0KPiA+ID4gDQo+ID4gPiBPaCB0aGF0J3Mgbm90IG5pY2UuIEl0
J3MgcHJvYmFibHkgdHJpZ2dlcmVkIGJ5IHRoZSAtRUlPIGluDQo+ID4gPiBwY2lfdnBkX3JlYWQu
DQo+ID4gPiBBIHF1aWNrIHNlYXJjaCBvbmxpbmUgc2VlbXMgdG8gc2hvdyB0aGF0IG90aGVyIHBl
b3BsZSBoYXZlDQo+ID4gPiBleHBlcmllbmNlZA0KPiA+ID4gdGhpcyB0b28gLSB0aG91Z2ggZnJv
bSBhcyBmYXIgYXMgSSBjYW4gdGVsbCB0aGlzIGp1c3QgZ2l2ZXMgeW91IGENCj4gPiA+IHdhcm5p
bmcgYW5kIHBjaWxpYiB3aWxsIGNvbnRpbm51ZSB0byBnaXZlIG90aGVyIG91dHB1dD8NCj4gPiA+
IA0KPiA+IA0KPiA+IENvcnJlY3QuDQo+ID4gDQo+ID4gPiBJIGd1ZXNzIGV2ZXJ5IHZwZCBibGFj
a2xpc3QnZCBkcml2ZXIgd2lsbCBoYXZlIHRoZSBzYW1lIGlzc3VlLg0KPiA+ID4gQW5kDQo+ID4g
PiBmb3INCj4gPiA+IHRoaXMgcmVhc29uIEkgZG9uJ3QgdGhpbmsgdGhhdCB0aGlzIHBhdGNoIGlz
IHRoZSByaWdodCBzb2x1dGlvbiAtDQo+ID4gPiBhcw0KPiA+ID4gb3RoZXJ3aXNlIGFsbCB0aGUg
b3RoZXIgYmxhY2tsaXN0ZWQgZHJpdmVycyBjb3VsZCBmb2xsb3cgeW91cg0KPiA+ID4gbGVhZC4N
Cj4gPiA+IA0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCBnb2luZyBmb3J3YXJkLCB0aGV5IHNob3Vs
ZCBmb2xsb3cgbXkgbGVhZCwgSSBqdXN0DQo+ID4gZGlkbid0DQo+ID4gd2FudCB0byBwb3NzaWJs
eSBicmVhayBhbnkgYXNzdW1wdGlvbnMgb3RoZXIgdmVuZG9ycycgdG9vbHMgbWlnaHQNCj4gPiBo
YXZlDQo+ID4gcmVnYXJkaW5nIHRoZSBleGlzdGVuY2Uvbm9uLWV4aXN0ZW5jZSBvZiB0aGUgdnBk
IHN5c2ZzIGVudHJ5Lg0KPiA+IA0KPiA+ID4gSSBkb24ndCB0aGluayB5b3UgbmVlZCB0byBmaXgg
dGhpcyBzcGVjaWZpY2FsbHkgZm9yIHRoZSBBTCBkcml2ZXINCj4gPiA+IGFuZA0KPiA+ID4gc28N
Cj4gPiA+IEknZCBzdWdnZXN0IHRoYXQgeW91IGNhbiBwcm9iYWJseSBkcm9wIHRoaXMgcGF0Y2gu
IChJZGVhbGx5DQo+ID4gPiBwY2l1dGlscw0KPiA+ID4gY291bGQgYmUgdXBkYXRlZCB0byBub3Qg
d2FybiBmb3IgdGhpcyBzcGVjaWZpYyB1c2UtY2FzZSkuDQo+ID4gPiANCj4gPiANCj4gPiBJIGRv
bid0IHRoaW5rIHRoYXQgc29sdXRpb24gc2hvdWxkIGJlIGltcGxlbWVudGVkIGluIHBjaXR1aWxz
LiBJdA0KPiA+IHJpZ2h0ZnVsbHkgd2FybnMgd2hlbiBpdCBmYWlscyB0byByZWFkIGZyb20gdGhl
IHZwZCBzeXNmcyBmaWxlIC0gaXQNCj4gPiBmaXJzdCAnb3BlbidzIHRoZSBmaWxlIHdoaWNoIHN1
Y2NlZWRzLCBhbmQgdGhlbiBmYWlscyB3aGVuIHRyeWluZw0KPiA+IHRvDQo+ID4gJ3JlYWQnIGZy
b20gaXQuDQo+IA0KPiBJbmRlZWQgLSB0aGlzIGlzIGNvcnJlY3QuDQo+IA0KPiA+IEkgZG9uJ3Qg
dGhpbmsgdGhhdCBpdCBzaG91bGQgc3BlY2lmaWNhbGx5ICJtYXNrIiBvdXQNCj4gPiAtRUlPLCBz
aW5jZSBpdCBzaG91bGRuJ3QgaGF2ZSB0byAia25vdyIgdGhhdCB0aGUgdW5kZXJseWluZyByZWFz
b24NCj4gPiBpcyBhDQo+IA0KPiBZb3UncmUgcHJvYmFibHkgcmlnaHQgLSBJIGd1ZXNzIHRoZSBr
ZXJuZWwgc2hvdWxkIGRvY3VtZW50IHNvbWV3aGVyZQ0KPiAoQUJJL3Rlc3Rpbmcvc3lzZnMtYnVz
LXBjaT8pIHdoYXQgdGhlIGtlcm5lbCBkb2VzIHdoZW4gc3VjaCBhIHF1aXJrDQo+IGV4aXN0cywN
Cj4gdGhlbiB1c2Vyc3BhY2UgY2FuIGNvbmZvcm0uIEZvciBleGFtcGxlIGlmIC1FSU8gY2Fubm90
IGJlIHJldHVybmVkDQo+IGFueQ0KPiBvdGhlciB3YXkgdGhlbiBpdCB3b3VsZCBiZSBPSyBmb3Ig
cGNpdXRpbHMgdG8gbWFzayBpdCBvdXQgLSBidXQgaXRzDQo+IGFtYmlnaW91cyBhdCB0aGUgbW9t
ZW50Lg0KPiANCj4gPiBWUEQgcXVpcmsgKG9yIG1vcmUgcHJlY2lzZWx5IHZwZC0+bGVuID09IDAp
LiBGdXJ0aGVybW9yZSwgaXQgaXMNCj4gPiBwb3NzaWJsZSB0aGF0IHRoaXMgZXJyb3IgY29kZSB3
b3VsZCBiZSByZXR1cm5lZCBmb3Igc29tZSBvdGhlcg0KPiA+IHJlYXNvbg0KPiA+IChub3Qgc3Vy
ZSBpZiBjdXJyZW50bHkgdGhpcyBvY2N1cnMpLg0KPiA+IA0KPiA+IEkgdGhpbmsgdGhhdCBpZiB0
aGUgZGV2aWNlIGRvZXNuJ3QgcHJvcGVybHkgc3VwcG9ydCB2cGQsIHRoZSBrZXJuZWwNCj4gPiBz
aG91bGRuJ3QgZXhwb3NlIHRoZSAiZW1wdHkiIHN5c2ZzIGZpbGUgaW4gdGhlIGZpcnN0IHBsYWNl
Lg0KPiA+IA0KPiA+IEluIHRoZSBsb25nIHJ1biwgcXVpcmtfYmxhY2tsaXN0X3ZwZCgpIHNob3Vs
ZCBwcm9iYWJseSBiZSBtb2RpZmllZA0KPiA+IHRvDQo+ID4gZG8gd2hhdCBvdXIgcXVpcmsgZG9l
cyBvciBzb21ldGhpbmcgc2ltaWxhciAoYW5kIHRoZW4gdGhlIGFsIHF1aXJrDQo+ID4gY2FuDQo+
ID4gYmUgcmVtb3ZlZCkuIFdoYXQgZG8geW91IHRoaW5rPw0KPiANCj4gV2hlbiBJIGZpcnN0IHNh
dyB5b3VyIHF1aXJrLCBJIGRpZCB3b25kZXIgd2h5IHF1aXJrX2JsYWNrbGlzdF92cGQNCj4gZG9l
c24ndA0KPiBkbyB3aGF0IHlvdXIgcXVpcmsgZG9lcy4gUGVyaGFwcyB0aGVyZSBpc24ndCBhIHJl
YXNvbi4gSXQgd2FzIGZpcnN0DQo+IGludHJvZHVjZWQgaW4gMjAxNjoNCj4gDQo+IDdjMjAwNzhh
ODE5NyAoIlBDSTogUHJldmVudCBWUEQgYWNjZXNzIGZvciBidWdneSBkZXZpY2VzIikNCj4gDQo+
IFNvbWUgbWF5IGFyZ3VlIHRoYXQgYWN0dWFsbHkgYmVjYXVzZSB5b3VyIGhhcmR3YXJlIGhhcyBh
IFZQRA0KPiBjYXBhYmlsaXR5DQo+IGl0IHNob3VsZCBoYXZlIHRoZSBzeXNmcyBmaWxlIC0gYnV0
IHRoZSBjYXBhYmlsaXR5IGRvZXNuJ3Qgd29yayBhbmQNCj4gc28NCj4gdGhlIHN5c2ZzIGZpbGUg
c2hvdWxkIHJldHVybiBhbiBlcnJvci4NCj4gDQo+IEknZCBiZSBrZWVuIHRvIGNoYW5nZSBxdWly
a19ibGFja2xpc3RfdnBkIC0gQmFidSwgQmpvcm4gYW55DQo+IG9iamVjdGlvbnM/DQo+IA0KU2lu
Y2UgdGhlIG1lcmdlIHdpbmRvdyBpcyBjbG9zaW5nIGFuZCBJIGRvbid0IHdhbnQgdG8gYWZmZWN0
IGFueSBvdGhlcg0KUENJZSBjb250cm9sbGVycyB3aXRob3V0IGhhdmluZyB0aGVpciBtYWludGFp
bmVycyB0ZXN0aW5nIHRoaXMgY2hhbmdlLA0KSSdsbCByZW1vdmUgdGhpcyBmdW5jdGlvbiBhbmQg
cmVnaXN0ZXIgb3VyIGRldmljZV9pZCB3aXRoIHRoZSBleGlzdGluZw0KcXVpcmtfYmxhY2tsaXN0
X3ZwZC4gVGhpcyB3aWxsIGJlIHBhcnQgb2YgdjUuDQoNCkknbGwgdGhlbiBzdWJtaXQgYSBzZXBh
cmF0ZSBwYXRjaCAoZm9yIHRoZSBuZXh0IGtlcm5lbCB2ZXJzaW9uKSB3aGljaA0KY2hhbmdlcyB0
aGUgcXVpcmtfYmxhY2tsaXN0X3ZwZCB0byBkbyB3aGF0IEkgb3JpZ2luYWxseSBpbnRlbmRlZC4N
Cg0KPiBUaGFua3MsDQo+IA0KPiBBbmRyZXcgTXVycmF5DQo+IA0KPiA+IA0KPiA+ID4gVGhhbmtz
LA0KPiA+ID4gDQo+ID4gPiBBbmRyZXcgTXVycmF5DQo+ID4gPiANCj4gPiA+ID4gDQo+ID4gPiA+
IFRoaXMgcXVpcmsgcmVtb3ZlcyB0aGUgc3lzZnMgZW50cnksIHdoaWNoIGF2b2lkcyB0aGUgZXJy
b3INCj4gPiA+ID4gcHJpbnQuDQo+ID4gPiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb25h
dGhhbiBDaG9jcm9uIDxqb25ueWNAYW1hem9uLmNvbT4NCj4gPiA+ID4gUmV2aWV3ZWQtYnk6IEd1
c3Rhdm8gUGltZW50ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3BzeXMuY29tPg0KPiA+ID4gPiAt
LS0NCj4gPiA+ID4gIGRyaXZlcnMvcGNpL3ZwZC5jIHwgMTYgKysrKysrKysrKysrKysrKw0KPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE2IGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS92cGQuYyBiL2RyaXZlcnMvcGNpL3ZwZC5jDQo+ID4g
PiA+IGluZGV4IDQ5NjNjMmUyYmQ0Yy4uYzIzYThlYzA4ZGI5IDEwMDY0NA0KPiA+ID4gPiAtLS0g
YS9kcml2ZXJzL3BjaS92cGQuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS92cGQuYw0KPiA+
ID4gPiBAQCAtNjQ0LDQgKzY0NCwyMCBAQCBzdGF0aWMgdm9pZA0KPiA+ID4gPiBxdWlya19jaGVs
c2lvX2V4dGVuZF92cGQoc3RydWN0DQo+ID4gPiA+IHBjaV9kZXYgKmRldikNCj4gPiA+ID4gIERF
Q0xBUkVfUENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQ0hFTFNJTywgUENJX0FOWV9JRCwN
Cj4gPiA+ID4gIAkJCXF1aXJrX2NoZWxzaW9fZXh0ZW5kX3ZwZCk7DQo+ID4gPiA+ICANCj4gPiA+
ID4gK3N0YXRpYyB2b2lkIHF1aXJrX2FsX3ZwZF9yZWxlYXNlKHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJaWYgKGRldi0+dnBkKSB7DQo+ID4gPiA+ICsJCXBjaV92
cGRfcmVsZWFzZShkZXYpOw0KPiA+ID4gPiArCQlkZXYtPnZwZCA9IE5VTEw7DQo+ID4gPiA+ICsJ
CXBjaV93YXJuKGRldiwgRldfQlVHICJSZWxlYXNpbmcgVlBEIGNhcGFiaWxpdHkNCj4gPiA+ID4g
KE5vDQo+ID4gPiA+IHN1cHBvcnQgZm9yIFZQRCByZWFkL3dyaXRlIHRyYW5zYWN0aW9ucylcbiIp
Ow0KPiA+ID4gPiArCX0NCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiArLyoNCj4gPiA+
ID4gKyAqIFRoZSAwMDMxIGRldmljZSBpZCBpcyByZXVzZWQgZm9yIG90aGVyIG5vbiBSb290IFBv
cnQgZGV2aWNlDQo+ID4gPiA+IHR5cGVzLA0KPiA+ID4gPiArICogdGhlcmVmb3JlIHRoZSBxdWly
ayBpcyByZWdpc3RlcmVkIGZvciB0aGUNCj4gPiA+ID4gUENJX0NMQVNTX0JSSURHRV9QQ0kNCj4g
PiA+ID4gY2xhc3MuDQo+ID4gPiA+ICsgKi8NCj4gPiA+ID4gK0RFQ0xBUkVfUENJX0ZJWFVQX0NM
QVNTX0ZJTkFMKFBDSV9WRU5ET1JfSURfQU1BWk9OX0FOTkFQVVJOQV9MDQo+ID4gPiA+IEFCUywN
Cj4gPiA+ID4gMHgwMDMxLA0KPiA+ID4gPiArCQkJICAgICAgUENJX0NMQVNTX0JSSURHRV9QQ0ks
IDgsDQo+ID4gPiA+IHF1aXJrX2FsX3ZwZF9yZWxlYXNlKTsNCj4gPiA+ID4gKw0KPiA+ID4gPiAg
I2VuZGlmDQo+ID4gPiA+IC0tIA0KPiA+ID4gPiAyLjE3LjENCj4gPiA+ID4gDQo=
