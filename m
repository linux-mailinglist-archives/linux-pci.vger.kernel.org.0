Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id EA2B4B0F31
	for <lists+linux-pci@lfdr.de>; Thu, 12 Sep 2019 14:55:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731793AbfILMzW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 12 Sep 2019 08:55:22 -0400
Received: from smtp-fw-6002.amazon.com ([52.95.49.90]:8077 "EHLO
        smtp-fw-6002.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731788AbfILMzV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 12 Sep 2019 08:55:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568292920; x=1599828920;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=JaTc1chxleSvN0x3nLvZo/SABEUOWMYq1A/rnNqsaT4=;
  b=YeGFHRYBi45tZnZ60d3PV/lsoNjBzQLhV1oMLlPSQ1Dryg356CXU/POa
   wyTEmDdJT61Nca8cfJirhtiiW7F64w5n3iXjcXNH6bEKVSKkHBGCBJU3V
   EzL+H84cESac8/S2iB8EXrWxPB/y8qF/aJpQrfAsKz+eRkGyNF0u8rR4g
   0=;
X-IronPort-AV: E=Sophos;i="5.64,497,1559520000"; 
   d="scan'208";a="420817483"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6002.iad6.amazon.com with ESMTP; 12 Sep 2019 12:55:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-e34f1ddc.us-east-1.amazon.com (Postfix) with ESMTPS id D7F13A2041;
        Thu, 12 Sep 2019 12:55:05 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 12:55:04 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 12 Sep 2019 12:55:04 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Thu, 12 Sep 2019 12:55:04 +0000
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
Subject: Re: [PATCH v5 6/7] PCI: dwc: al: Add support for DW based driver type
Thread-Topic: [PATCH v5 6/7] PCI: dwc: al: Add support for DW based driver
 type
Thread-Index: AQHVY/KBlxXPHSUOKEWpD0aDO6n+D6cgcleAgAeYWQA=
Date:   Thu, 12 Sep 2019 12:55:04 +0000
Message-ID: <a8903f853cd37c23d3325e69b25e9e86942f5322.camel@amazon.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
         <20190905140144.7933-2-jonnyc@amazon.com>
         <20190907165557.GO103977@google.com>
In-Reply-To: <20190907165557.GO103977@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.218]
Content-Type: text/plain; charset="utf-8"
Content-ID: <67282EFB11D78B4C8D3EA9391B0AB75F@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDE5LTA5LTA3IGF0IDExOjU1IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBzL0FkZCBzdXBwb3J0IGZvciBEVyBiYXNlZCBkcml2ZXIgdHlwZS9BZGQgQW1hem9uIEFubmFw
dXJuYSBMYWJzIFBDSWUNCj4gY29udHJvbGxlciBkcml2ZXIvDQo+IA0KQWNrLg0KDQo+IE9uIFRo
dSwgU2VwIDA1LCAyMDE5IGF0IDA1OjAxOjQzUE0gKzAzMDAsIEpvbmF0aGFuIENob2Nyb24gd3Jv
dGU6DQo+ID4gVGhpcyBkcml2ZXIgaXMgRFQgYmFzZWQgYW5kIHV0aWxpemVzIHRoZSBEZXNpZ25X
YXJlIEFQSXMuDQo+ID4gDQo+ID4gSXQgYWxsb3dzIHVzaW5nIGEgc21hbGxlciBFQ0FNIHJhbmdl
IGZvciBhIGxhcmdlciBidXMgcmFuZ2UgLQ0KPiA+IHVzdWFsbHkgYW4gZW50aXJlIGJ1cyB1c2Vz
IDFNQiBvZiBhZGRyZXNzIHNwYWNlLCBidXQgdGhlIGRyaXZlcg0KPiA+IGNhbiB1c2UgaXQgZm9y
IGEgbGFyZ2VyIG51bWJlciBvZiBidXNlcy4gVGhpcyBpcyBhY2hpZXZlZCBieSB1c2luZw0KPiA+
IGEgSFcNCj4gPiBtZWNoYW5pc20gd2hpY2ggYWxsb3dzIGNoYW5naW5nIHRoZSBCVVMgcGFydCBv
ZiB0aGUgImZpbmFsIg0KPiA+IG91dGdvaW5nDQo+ID4gY29uZmlnIHRyYW5zYWN0aW9uLiBUaGVy
ZSBhcmUgMiBIVyByZWdzLCBvbmUgd2hpY2ggaXMgYmFzaWNhbGx5IGENCj4gPiBiaXRtYXNrIGRl
dGVybWluaW5nIHdoaWNoIGJpdHMgdG8gdGFrZSBmcm9tIHRoZSBBWEkgdHJhbnNhY3Rpb24NCj4g
PiBpdHNlbGYNCj4gPiBhbmQgYW5vdGhlciB3aGljaCBob2xkcyB0aGUgY29tcGxlbWVudGFyeSBw
YXJ0IHByb2dyYW1tZWQgYnkgdGhlDQo+ID4gZHJpdmVyLg0KPiA+IA0KPiA+IEFsbCBsaW5rIGlu
aXRpYWxpemF0aW9ucyBhcmUgaGFuZGxlZCBieSB0aGUgYm9vdCBGVy4NCj4gPiANCj4gPiBTaWdu
ZWQtb2ZmLWJ5OiBKb25hdGhhbiBDaG9jcm9uIDxqb25ueWNAYW1hem9uLmNvbT4NCj4gPiBSZXZp
ZXdlZC1ieTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+
DQo+ID4gUmV2aWV3ZWQtYnk6IEFuZHJldyBNdXJyYXkgPGFuZHJldy5tdXJyYXlAYXJtLmNvbT4N
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZyAgIHwgIDEy
ICsNCj4gPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1hbC5jIHwgMzY1DQo+ID4g
KysrKysrKysrKysrKysrKysrKysrKysrKysrDQo+ID4gIDIgZmlsZXMgY2hhbmdlZCwgMzc3IGlu
c2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxl
ci9kd2MvS2NvbmZpZw0KPiA+IGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZw0K
PiA+IGluZGV4IDRmYWRhMmU5MzI4NS4uMGJhOTg4YjViNWJjIDEwMDY0NA0KPiA+IC0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gQEAgLTI1Niw0ICsyNTYsMTYgQEAgY29uZmlnIFBD
SUVfVU5JUEhJRVINCj4gPiAgCSAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCBQQ0llIGNvbnRyb2xs
ZXIgc3VwcG9ydCBvbiBVbmlQaGllcg0KPiA+IFNvQ3MuDQo+ID4gIAkgIFRoaXMgZHJpdmVyIHN1
cHBvcnRzIExEMjAgYW5kIFBYczMgU29Dcy4NCj4gPiAgDQo+ID4gK2NvbmZpZyBQQ0lFX0FMDQo+
ID4gKwlib29sICJBbWF6b24gQW5uYXB1cm5hIExhYnMgUENJZSBjb250cm9sbGVyIg0KPiA+ICsJ
ZGVwZW5kcyBvbiBPRiAmJiAoQVJNNjQgfHwgQ09NUElMRV9URVNUKQ0KPiA+ICsJZGVwZW5kcyBv
biBQQ0lfTVNJX0lSUV9ET01BSU4NCj4gPiArCXNlbGVjdCBQQ0lFX0RXX0hPU1QNCj4gPiArCWhl
bHANCj4gPiArCSAgU2F5IFkgaGVyZSB0byBlbmFibGUgc3VwcG9ydCBvZiB0aGUgQW1hem9uJ3Mg
QW5uYXB1cm5hIExhYnMNCj4gPiBQQ0llDQo+ID4gKwkgIGNvbnRyb2xsZXIgSVAgb24gQW1hem9u
IFNvQ3MuIFRoZSBQQ0llIGNvbnRyb2xsZXIgdXNlcyB0aGUNCj4gPiBEZXNpZ25XYXJlDQo+ID4g
KwkgIGNvcmUgcGx1cyBBbm5hcHVybmEgTGFicyBwcm9wcmlldGFyeSBoYXJkd2FyZSB3cmFwcGVy
cy4gVGhpcw0KPiA+IGlzDQo+ID4gKwkgIHJlcXVpcmVkIG9ubHkgZm9yIERULWJhc2VkIHBsYXRm
b3Jtcy4gQUNQSSBwbGF0Zm9ybXMgd2l0aCB0aGUNCj4gPiArCSAgQW5uYXB1cm5hIExhYnMgUENJ
ZSBjb250cm9sbGVyIGRvbid0IG5lZWQgdG8gZW5hYmxlIHRoaXMuDQo+IA0KPiBJbnRlcmVzdGlu
Zy4gIEhvdyBkbyB5b3UgZGVhbCB3aXRoIHRoZSBmdW5reSBFQ0FNIHNwYWNlIG9uIEFDUEkNCj4g
cGxhdGZvcm1zPyAgT2gsIG5ldmVyIG1pbmQsIEkgc2VlLCBpdCdzIHRoZSBwY2llLWFsLmMgRUNB
TSBvcHMgcXVpcmsNCj4gdGhhdCdzIGFscmVhZHkgaW4gdGhlIHRyZWUuDQo+IA0KPiBCam9ybg0K
