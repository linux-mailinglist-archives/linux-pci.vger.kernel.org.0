Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9A33EAFF6E
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 17:01:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfIKPBK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 11:01:10 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:1425 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727576AbfIKPBK (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 11:01:10 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568214069; x=1599750069;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Iow+uDeP1DOi3qPK52rbDWi/vuI+ELXQ/VdFiendUzw=;
  b=vrTnYpPVHL/blFdgbhsmqnM4QIjzOUnliwqVbe5J6e/awPPK263vDJuD
   nvtnSBdHvXWIKXncuU8NOHEGOjbZ5jZk0fowIUA6KgirPwT96VRdhTON7
   eMDBbkH4SIF9s+Nboo+EamwHduL8mkSUdXaRnPV1FcCq421fmoTxo8KZn
   4=;
X-IronPort-AV: E=Sophos;i="5.64,493,1559520000"; 
   d="scan'208";a="414730105"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 11 Sep 2019 15:01:08 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1d-5dd976cd.us-east-1.amazon.com (Postfix) with ESMTPS id 9785BA069E;
        Wed, 11 Sep 2019 15:01:05 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Sep 2019 15:01:05 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Sep 2019 15:01:04 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Wed, 11 Sep 2019 15:01:04 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
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
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: Re: [PATCH v5 3/7] PCI/VPD: Prevent VPD access for Amazon's Annapurna
 Labs Root Port
Thread-Topic: [PATCH v5 3/7] PCI/VPD: Prevent VPD access for Amazon's
 Annapurna Labs Root Port
Thread-Index: AQHVY/JWmKAnl7Ap+kOWWhV++Q+H9acgciOAgAYpbYA=
Date:   Wed, 11 Sep 2019 15:01:04 +0000
Message-ID: <9da57ba4eed776181555323972b4d71311ef6c80.camel@amazon.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
         <20190905140018.5139-4-jonnyc@amazon.com>
         <20190907165512.GM103977@google.com>
In-Reply-To: <20190907165512.GM103977@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.242]
Content-Type: text/plain; charset="utf-8"
Content-ID: <49F7CDFA19E7144A9E7F449853538672@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDE5LTA5LTA3IGF0IDExOjU1IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIFNlcCAwNSwgMjAxOSBhdCAwNTowMDoxN1BNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IFRoZSBBbWF6b24gQW5uYXB1cm5hIExhYnMgUENJZSBSb290IFBvcnQg
ZXhwb3NlcyB0aGUgVlBEDQo+ID4gY2FwYWJpbGl0eSwNCj4gPiBidXQgdGhlcmUgaXMgbm8gYWN0
dWFsIHN1cHBvcnQgZm9yIGl0Lg0KPiANCj4gT29wcy4gIEFub3RoZXIgb29wcyBmb3IgdGhlIGRl
dmljZSBJRCByZXVzZSBtZW50aW9uZWQgYmVsb3cuDQo+IA0KPiA+IFRyeWluZyB0byBhY2Nlc3Mg
dGhlIFZQRCAoZm9yIGV4YW1wbGUsIGFzIHBhcnQgb2YgbHNwY2kgLXZ2IG9yIHdoZW4NCj4gPiBy
ZWFkaW5nIHRoZSB2cGQgc3lzZnMgZmlsZSksIHJlc3VsdHMgaW4gdGhlIGZvbGxvd2luZyB3YXJu
aW5nDQo+ID4gcHJpbnQ6DQo+ID4gDQo+ID4gcGNpZXBvcnQgMDAwMTowMDowMC4wOiBWUEQgYWNj
ZXNzIGZhaWxlZC4gIFRoaXMgaXMgbGlrZWx5IGENCj4gPiBmaXJtd2FyZSBidWcgb24gdGhpcyBk
ZXZpY2UuICBDb250YWN0IHRoZSBjYXJkIHZlbmRvciBmb3IgYQ0KPiA+IGZpcm13YXJlIHVwZGF0
ZQ0KPiANCj4gVGhhbmtzIGZvciBub3Qgd3JhcHBpbmcgdGhlIG1lc3NhZ2UgKGtlZXBpbmcgaXQg
dG9nZXRoZXIgbWFrZXMgaXQNCj4gZWFzaWVyIHRvIGdyZXAgZm9yKS4gIA0KDQpNeSB0aG91Z2h0
cyBleGFjdGx5IDopIA0KDQo+IE1heWJlIGluZGVudCBpdCB0d28gc3BhY2VzIHNpbmNlIGl0J3Mg
cXVvdGVkDQo+IG1hdGVyaWFsLg0KPiANCldpbGwgYmUgZG9uZSBhcyBwYXJ0IG9mIHY2Lg0KDQo+
ICpJcyogdGhpcyBhIGZpcm13YXJlIGRlZmVjdD8gIEUuZy4sIGNvdWxkIGZpcm13YXJlIGRpc2Fi
bGUgdGhpcw0KPiBjYXBhYmlsaXR5IHNvIGl0IGRvZXNuJ3QgYXBwZWFyIGluIGNvbmZpZyBzcGFj
ZSwgYXMgaXQgYXBwYXJlbnRseSBjYW4NCj4gZm9yIHRoZSBNU0ktWCBjYXBhYmlsaXR5Pw0KPiAN
ClllcywgdGhlIEZXIGNvdWxkIHBvdGVudGlhbGx5IGRpc2FibGUgaXQgc28gaXQgZG9lc24ndCBh
cHBlYXIgaW4gdGhlDQpjb25maWcgc3BhY2UuDQoNCkluIHRoZW9yeSwgVlBEIHNob3VsZCBiZSBh
YmxlIHRvIHdvcmsgaWYgc29tZSBvdGhlciBlbnRpdHkgd291bGQgbGlzdGVuDQp0byB0aGUgVlBE
IHJlcXVlc3RzIGFuZCByZXNwb25kLCBidXQgdGhlcmUgYXJlIG5vIHBsYW5zIHRvIGFkZCBzdXBw
b3J0DQpmb3Igc3VjaCBhbiBlbnRpdHkuDQoNCj4gPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBD
aG9jcm9uIDxqb25ueWNAYW1hem9uLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogR3VzdGF2byBQaW1l
bnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+DQo+IA0KPiBBY2tlZC1ieTogQmpv
cm4gSGVsZ2FhcyA8YmhlbGdhYXNAZ29vZ2xlLmNvbT4NCj4gDQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcGNpL3ZwZC5jIHwgNiArKysrKysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDYgaW5zZXJ0aW9u
cygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS92cGQuYyBiL2RyaXZlcnMv
cGNpL3ZwZC5jDQo+ID4gaW5kZXggNDk2M2MyZTJiZDRjLi43OTE1ZDEwZjlhYTEgMTAwNjQ0DQo+
ID4gLS0tIGEvZHJpdmVycy9wY2kvdnBkLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS92cGQuYw0K
PiA+IEBAIC01NzEsNiArNTcxLDEyIEBADQo+ID4gREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJ
X1ZFTkRPUl9JRF9MU0lfTE9HSUMsIDB4MDA1ZiwNCj4gPiBxdWlya19ibGFja2xpc3RfdnBkKTsN
Cj4gPiAgREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9BVFRBTlNJQywgUENJ
X0FOWV9JRCwNCj4gPiAgCQlxdWlya19ibGFja2xpc3RfdnBkKTsNCj4gPiAgREVDTEFSRV9QQ0lf
RklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9RTE9HSUMsIDB4MjI2MSwNCj4gPiBxdWlya19ibGFj
a2xpc3RfdnBkKTsNCj4gPiArLyoNCj4gPiArICogVGhlIEFtYXpvbiBBbm5hcHVybmEgTGFicyAw
eDAwMzEgZGV2aWNlIGlkIGlzIHJldXNlZCBmb3Igb3RoZXINCj4gPiBub24gUm9vdCBQb3J0DQo+
ID4gKyAqIGRldmljZSB0eXBlcywgc28gdGhlIHF1aXJrIGlzIHJlZ2lzdGVyZWQgZm9yIHRoZQ0K
PiA+IFBDSV9DTEFTU19CUklER0VfUENJIGNsYXNzLg0KPiA+ICsgKi8NCj4gPiArREVDTEFSRV9Q
Q0lfRklYVVBfQ0xBU1NfRklOQUwoUENJX1ZFTkRPUl9JRF9BTUFaT05fQU5OQVBVUk5BX0xBQlMs
DQo+ID4gMHgwMDMxLA0KPiA+ICsJCQkgICAgICBQQ0lfQ0xBU1NfQlJJREdFX1BDSSwgOCwNCj4g
PiBxdWlya19ibGFja2xpc3RfdnBkKTsNCj4gPiAgDQo+ID4gIC8qDQo+ID4gICAqIEZvciBCcm9h
ZGNvbSA1NzA2LCA1NzA4LCA1NzA5IHJldi4gQSBuaWNzLCBhbnkgcmVhZCBiZXlvbmQgdGhlDQo+
ID4gLS0gDQo+ID4gMi4xNy4xDQo+ID4gDQo=
