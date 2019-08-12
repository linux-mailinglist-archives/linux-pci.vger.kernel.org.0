Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0951D8A544
	for <lists+linux-pci@lfdr.de>; Mon, 12 Aug 2019 20:05:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726452AbfHLSFO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 14:05:14 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:35137 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726236AbfHLSFO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 12 Aug 2019 14:05:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565633112; x=1597169112;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dbWryusZX9U4GcVeFcVYbuGVGtsLpyzYEjzDFjd/2f4=;
  b=mOTSxTWjUzsxuYpIONEPcAIZ/X8gKKw9l5ZXlELlkSSuqCq/sEZ5+IO0
   KrG/CV5077FnMOQS1NNCrvhd9OAi5eGwEk4SQNmqfwimlJ0+2U/6t5fxe
   VIhCIvJm/mXVaKf0kzor0ZCW+sMZmKZ8/m2UpWVzEblDg4JESWrSZtKKm
   g=;
X-IronPort-AV: E=Sophos;i="5.64,378,1559520000"; 
   d="scan'208";a="819146222"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-1e-c7c08562.us-east-1.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 12 Aug 2019 18:05:09 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1e-c7c08562.us-east-1.amazon.com (Postfix) with ESMTPS id 50412240AAC;
        Mon, 12 Aug 2019 18:05:08 +0000 (UTC)
Received: from EX13D13UWA003.ant.amazon.com (10.43.160.181) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 12 Aug 2019 18:05:08 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA003.ant.amazon.com (10.43.160.181) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 12 Aug 2019 18:05:07 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Mon, 12 Aug 2019 18:05:07 +0000
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
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: Re: [PATCH v3 8/8] PCI: dw: Add support for
 PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags
Thread-Topic: [PATCH v3 8/8] PCI: dw: Add support for
 PCI_PROBE_ONLY/PCI_REASSIGN_ALL_BUS flags
Thread-Index: AQHVQTjgJY6X9sfi40Wq6J7sfEVWx6bv+jIAgAEbEoCAABisgIAGwI8A
Date:   Mon, 12 Aug 2019 18:05:07 +0000
Message-ID: <6e2efdfb6d07526f934fcbeb0e6b9518c849b8a8.camel@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
         <20190723092711.11786-4-jonnyc@amazon.com>
         <20190807163654.GC16214@e121166-lin.cambridge.arm.com>
         <67c58ded2177beca030450c25d742d35890eb48a.camel@amazon.com>
         <20190808105821.GB30230@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190808105821.GB30230@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.211]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B6A4A488E9E42C4AB6B760FA7F1FB027@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTA4IGF0IDExOjU4ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gU2lkZSBub3RlLCBydW46DQo+IA0KPiBnaXQgbG9nIC0tb25lbGluZSBvbiBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3YyBleGlzdGluZyBmaWxlcyBhbmQNCj4gbWFrZSBzdXJlIGNvbW1p
dCBzdWJqZWN0cyBhcmUgaW4gbGluZSB3aXRoIHRob3NlLg0KPiANCj4gRWcgUENJOiBkdzogc2hv
dWxkIGJlIFBDSTogZHdjOg0KPiANCkRvbmUuDQoNCj4gT24gVGh1LCBBdWcgMDgsIDIwMTkgYXQg
MDk6MzA6MDVBTSArMDAwMCwgQ2hvY3JvbiwgSm9uYXRoYW4gd3JvdGU6DQo+ID4gT24gV2VkLCAy
MDE5LTA4LTA3IGF0IDE3OjM2ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90ZToNCj4gPiA+
IE9uIFR1ZSwgSnVsIDIzLCAyMDE5IGF0IDEyOjI3OjExUE0gKzAzMDAsIEpvbmF0aGFuIENob2Ny
b24gd3JvdGU6DQo+ID4gPiA+IFRoaXMgYmFzaWNhbGx5IGFsaWducyB0aGUgdXNhZ2Ugb2YgUENJ
X1BST0JFX09OTFkgYW5kDQo+ID4gPiA+IFBDSV9SRUFTU0lHTl9BTExfQlVTIGluIGR3X3BjaWVf
aG9zdF9pbml0KCkgd2l0aCB0aGUgbG9naWMgaW4NCj4gPiA+ID4gcGNpX2hvc3RfY29tbW9uX3By
b2JlKCkuDQo+ID4gPiA+IA0KPiA+ID4gPiBOb3cgaXQgd2lsbCBiZSBwb3NzaWJsZSB0byBjb250
cm9sIHZpYSB0aGUgZGV2aWNldHJlZSB3aGV0aGVyDQo+ID4gPiA+IHRvDQo+ID4gPiA+IGp1c3QN
Cj4gPiA+ID4gcHJvYmUgdGhlIFBDSSBidXMgKGluIGNhc2VzIHdoZXJlIEZXIGFscmVhZHkgY29u
ZmlndXJlZCBpdCkgb3INCj4gPiA+ID4gdG8NCj4gPiA+ID4gZnVsbHkNCj4gPiA+ID4gY29uZmln
dXJlIGl0Lg0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2hvY3Jv
biA8am9ubnljQGFtYXpvbi5jb20+DQo+ID4gPiA+IC0tLQ0KPiA+ID4gPiAgLi4uL3BjaS9jb250
cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUtaG9zdC5jIHwgMjMNCj4gPiA+ID4gKysrKysrKysr
KysrKysrLS0tLQ0KPiA+ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE5IGluc2VydGlvbnMoKyksIDQg
ZGVsZXRpb25zKC0pDQo+ID4gPiA+IA0KPiA+ID4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4gPiBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gaW5kZXgg
ZDJjYTc0OGU0Yzg1Li4wYTI5NGQ4YWEyMWEgMTAwNjQ0DQo+ID4gPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtZGVzaWdud2FyZS1ob3N0LmMNCj4gPiA+ID4gKysrIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvcGNpZS1kZXNpZ253YXJlLWhvc3QuYw0KPiA+ID4g
PiBAQCAtMzQyLDYgKzM0Miw4IEBAIGludCBkd19wY2llX2hvc3RfaW5pdChzdHJ1Y3QgcGNpZV9w
b3J0ICpwcCkNCj4gPiA+ID4gIAlpZiAoIWJyaWRnZSkNCj4gPiA+ID4gIAkJcmV0dXJuIC1FTk9N
RU07DQo+ID4gPiA+ICANCj4gPiA+ID4gKwlvZl9wY2lfY2hlY2tfcHJvYmVfb25seSgpOw0KPiA+
ID4gPiArDQo+ID4gPiA+ICAJcmV0ID0gZGV2bV9vZl9wY2lfZ2V0X2hvc3RfYnJpZGdlX3Jlc291
cmNlcyhkZXYsIDAsDQo+ID4gPiA+IDB4ZmYsDQo+ID4gPiA+ICAJCQkJCSZicmlkZ2UtPndpbmRv
d3MsICZwcC0NCj4gPiA+ID4gPiBpb19iYXNlKTsNCj4gPiA+ID4gDQo+ID4gPiA+ICAJaWYgKHJl
dCkNCj4gPiA+ID4gQEAgLTQ3NCw2ICs0NzYsMTAgQEAgaW50IGR3X3BjaWVfaG9zdF9pbml0KHN0
cnVjdCBwY2llX3BvcnQNCj4gPiA+ID4gKnBwKQ0KPiA+ID4gPiAgDQo+ID4gPiA+ICAJcHAtPnJv
b3RfYnVzX25yID0gcHAtPmJ1c24tPnN0YXJ0Ow0KPiA+ID4gPiAgDQo+ID4gPiA+ICsJLyogRG8g
bm90IHJlYXNzaWduIGJ1cyBudW1zIGlmIHByb2JlIG9ubHkgKi8NCj4gPiA+ID4gKwlpZiAoIXBj
aV9oYXNfZmxhZyhQQ0lfUFJPQkVfT05MWSkpDQo+ID4gPiA+ICsJCXBjaV9hZGRfZmxhZ3MoUENJ
X1JFQVNTSUdOX0FMTF9CVVMpOw0KPiA+ID4gDQo+ID4gPiBUaGlzIGNoYW5nZXMgdGhlIGRlZmF1
bHQgZm9yIGJ1cyByZWFzc2lnbm1lbnQgb24gYWxsIERXQyBob3N0DQo+ID4gPiAodGhhdA0KPiA+
ID4gYXJlDQo+ID4gPiAhUENJX1BST0JFX09OTFkpLCB3ZSBzaG91bGQgZHJvcCB0aGlzIGxpbmUs
IGl0IGNhbiB0cmlnZ2VyDQo+ID4gPiByZWdyZXNzaW9ucy4NCj4gPiA+IA0KPiA+IA0KPiA+IFdp
bGwgYmUgZHJvcHBlZCBhcyBwYXJ0IG9mIHY0LiBUaGVyZSBtaWdodCBhbHNvIGJlIGEgYmVoYXZp
b3JhbA0KPiA+IGRpZmZlcmVuY2UgYmVsb3cgd2hlcmUgSSBhZGRlZCB0aGUgaWYNCj4gPiAocGNp
X2hhc19mbGFnKFBDSV9QUk9CRV9PTkxZKSkuDQo+ID4gSXMgdGhhdCBzdGlsbCBvaz8NCj4gDQo+
IFRoYXQncyB0cnVlIGJ1dCBJIGRvdWJ0IGFueSBEV0MgaG9zdCBoYXMgYSBEVCBmaXJtd2FyZSB3
aXRoDQo+ICJsaW51eCxwY2ktcHJvYmUtb25seSIgaW4gaXQuDQo+IA0KPiBJdCBpcyB0cmlhbCBh
bmQgZXJyb3IgSSBhbSBhZnJhaWQsIHBsZWFzZSBtYWtlIHN1cmUgYWxsIERXQw0KPiBtYWludGFp
bmVycyBhcmUgY29waWVkIGluLg0KPiANCj4gPiBBcyBJIHBvaW50ZWQgb3V0IGluIHRoZSBjb3Zl
ciBsZXR0ZXIsIHNpbmNlIFBDSV9QUk9CRV9PTkxZIGlzIGENCj4gPiBzeXN0ZW0NCj4gPiB3aWRl
IGZsYWcsIGRvZXMgaXQgbWFrZSBzZW5zZSB0byBjYWxsIG9mX3BjaV9jaGVja19wcm9iZV9vbmx5
KCkNCj4gPiBoZXJlLA0KPiA+IGluIHRoZSBjb250ZXh0IG9mIGEgc3BlY2lmaWMgZHJpdmVyIChp
bmNsdWRpbmcgdGhlIGV4aXN0aW5nDQo+ID4gaW52b2NhdGlvbg0KPiA+IGluIHBjaV9ob3N0X2Nv
bW1vbl9wcm9iZSgpKSwgYXMgb3Bwb3NlZCB0byBhIHBsYXRmb3JtL2FyY2ggY29udGV4dD8NCj4g
DQo+IEl0IGlzIGFuIG9uZ29pbmcgZGlzY3Vzc2lvbiB0byBkZWZpbmUgaG93IHdlIHNob3VsZCBo
YW5kbGUNCj4gUENJX1BST0JFX09OTFkuIEFkZGluZyB0aGlzIGNvZGUgaW50byBEV0MgSSBkbyBu
b3QgdGhpbmsgaXQNCj4gd291bGQgaHVydCBidXQgaWYgd2UgY2FuIHBvc3Rwb25lIGl0IGZvciB0
aGUgbmV4dCAodjUuNSkgbWVyZ2UNCj4gd2luZG93IGFmdGVyIHdlIGRlYmF0ZSB0aGlzIGF0IExQ
QyB3aXRoaW4gdGhlIFBDSSBtaWNyb2NvbmZlcmVuY2UNCj4gaXQgd291bGQgYmUgZ3JlYXQuDQo+
IA0KVGhlIHByZWNlZGluZyBwYXRjaGVzIGFyZSBtb3JlIHVyZ2VudCwgc28gSSdtIGZpbmUgd2l0
aCBwb3N0cG9uaW5nIHRoaXMNCnBhdGNoIHRvIHRoZSBuZXh0IG1lcmdlIHdpbmRvdyAoSSdsbCBk
cm9wIGl0IGZyb20gdjQpLg0KDQo+IFBsZWFzZSBzeW5jIHdpdGggQmVuamFtaW4gYXMgYSBmaXJz
dCBzdGVwLCBJIHRydXN0IGhlIHdvdWxkIGFzaw0KPiB5b3UgdG8gZG8gdGhlIHJpZ2h0IHRoaW5n
Lg0KPiANCk9mIGNvdXJzZSwgSSdsbCBzeW5jIHdpdGggaGltLiBCdXQgYWdhaW4sIGxldCdzIG5v
dCBoYXZlIHRoaXMgcGF0Y2gNCmRlbGF5IHRoZSBvdGhlcnMgcGxlYXNlLg0KDQo+ID4gPiBJZiB3
ZSBzdGlsbCB3YW50IHRvIG1lcmdlIGl0IGFzIGEgc2VwYXJhdGUgY2hhbmdlIHdlIG11c3QgdGVz
dCBpdA0KPiA+ID4gb24NCj4gPiA+IGFsbA0KPiA+ID4gRFdDIGhvc3QgYnJpZGdlcyB0byBtYWtl
IHN1cmUgaXQgZG9lcyBub3QgdHJpZ2dlciBhbnkgaXNzdWVzIHdpdGgNCj4gPiA+IGN1cnJlbnQg
c2V0LXVwcywgdGhhdCdzIG5vdCBnb2luZyB0byBiZSBlYXN5IHRob3VnaC4NCj4gPiA+IA0KPiA+
IA0KPiA+IEp1c3Qgb3V0IG9mIGN1cmlvc2l0eSwgaG93IGFyZSBzdWNoIGV4aGF1c3RpdmUgdGVz
dHMgYWNoaWV2ZWQgd2hlbg0KPiA+IGENCj4gPiBwYXRjaCByZXF1aXJlcyB0aGVtPw0KPiANCj4g
Q0MgRFdDIGhvc3QgYnJpZGdlIG1haW50YWluZXJzIGFuZCBhc2sgdGhlbSB0byB0ZXN0IGl0LiBJ
IGRvIG5vdCBoYXZlDQo+IHRoZSBIVyAoYW5kIEZXKSByZXF1aXJlZCwgSSBhbSBzb3JyeSwgdGhh
dCdzIHRoZSBvbmx5IG9wdGlvbiBJIGNhbg0KPiBnaXZlDQo+IHlvdS4gLW5leHQgY292ZXJhZ2Ug
d291bGQgaGVscCB0b28gYnV0IHRvIGEgbWlub3IgZXh0ZW50Lg0KPiANClRoYW5rcyBmb3IgdGhl
IGluZm8hDQoNCj4gVGhhbmtzLA0KPiBMb3JlbnpvDQo+IA0KPiA+IA0KPiA+ID4gTG9yZW56bw0K
PiA+ID4gDQo+ID4gPiA+ICsNCj4gPiA+ID4gIAlicmlkZ2UtPmRldi5wYXJlbnQgPSBkZXY7DQo+
ID4gPiA+ICAJYnJpZGdlLT5zeXNkYXRhID0gcHA7DQo+ID4gPiA+ICAJYnJpZGdlLT5idXNuciA9
IHBwLT5yb290X2J1c19ucjsNCj4gPiA+ID4gQEAgLTQ5MCwxMSArNDk2LDIwIEBAIGludCBkd19w
Y2llX2hvc3RfaW5pdChzdHJ1Y3QgcGNpZV9wb3J0DQo+ID4gPiA+ICpwcCkNCj4gPiA+ID4gIAlp
ZiAocHAtPm9wcy0+c2Nhbl9idXMpDQo+ID4gPiA+ICAJCXBwLT5vcHMtPnNjYW5fYnVzKHBwKTsN
Cj4gPiA+ID4gIA0KPiA+ID4gPiAtCXBjaV9idXNfc2l6ZV9icmlkZ2VzKHBwLT5yb290X2J1cyk7
DQo+ID4gPiA+IC0JcGNpX2J1c19hc3NpZ25fcmVzb3VyY2VzKHBwLT5yb290X2J1cyk7DQo+ID4g
PiA+ICsJLyoNCj4gPiA+ID4gKwkgKiBXZSBpbnNlcnQgUENJIHJlc291cmNlcyBpbnRvIHRoZSBp
b21lbV9yZXNvdXJjZSBhbmQNCj4gPiA+ID4gKwkgKiBpb3BvcnRfcmVzb3VyY2UgdHJlZXMgaW4g
ZWl0aGVyDQo+ID4gPiA+IHBjaV9idXNfY2xhaW1fcmVzb3VyY2VzKCkNCj4gPiA+ID4gKwkgKiBv
ciBwY2lfYnVzX2Fzc2lnbl9yZXNvdXJjZXMoKS4NCj4gPiA+ID4gKwkgKi8NCj4gPiA+ID4gKwlp
ZiAocGNpX2hhc19mbGFnKFBDSV9QUk9CRV9PTkxZKSkgew0KPiA+ID4gPiArCQlwY2lfYnVzX2Ns
YWltX3Jlc291cmNlcyhwcC0+cm9vdF9idXMpOw0KPiA+ID4gPiArCX0gZWxzZSB7DQo+ID4gPiA+
ICsJCXBjaV9idXNfc2l6ZV9icmlkZ2VzKHBwLT5yb290X2J1cyk7DQo+ID4gPiA+ICsJCXBjaV9i
dXNfYXNzaWduX3Jlc291cmNlcyhwcC0+cm9vdF9idXMpOw0KPiA+ID4gPiAgDQo+ID4gPiA+IC0J
bGlzdF9mb3JfZWFjaF9lbnRyeShjaGlsZCwgJnBwLT5yb290X2J1cy0+Y2hpbGRyZW4sDQo+ID4g
PiA+IG5vZGUpDQo+ID4gPiA+IC0JCXBjaWVfYnVzX2NvbmZpZ3VyZV9zZXR0aW5ncyhjaGlsZCk7
DQo+ID4gPiA+ICsJCWxpc3RfZm9yX2VhY2hfZW50cnkoY2hpbGQsICZwcC0+cm9vdF9idXMtDQo+
ID4gPiA+ID5jaGlsZHJlbiwNCj4gPiA+ID4gbm9kZSkNCj4gPiA+ID4gKwkJCXBjaWVfYnVzX2Nv
bmZpZ3VyZV9zZXR0aW5ncyhjaGlsZCk7DQo+ID4gPiA+ICsJfQ0KPiA+ID4gPiAgDQo+ID4gPiA+
ICAJcGNpX2J1c19hZGRfZGV2aWNlcyhwcC0+cm9vdF9idXMpOw0KPiA+ID4gPiAgCXJldHVybiAw
Ow0KPiA+ID4gPiAtLSANCj4gPiA+ID4gMi4xNy4xDQo+ID4gPiA+IA0K
