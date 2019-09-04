Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3ED11A8487
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 15:50:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730325AbfIDNdb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 09:33:31 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:39859 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725911AbfIDNdb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 09:33:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567604010; x=1599140010;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=Rwld2W66T0xhJJxjsf2d88R9a0Ebc3N5BJFmWWRTF6E=;
  b=gUk2ytLa2KubsBSP1knaN8auUbGWJROP/WD3S9SCQKaUF7cBr5srYEiY
   ygyIKuW4BX7E7Ic2aU1Hy9WA59kDVke+RtQI4ZGvLt7xFyeKMqQQcYzSM
   4Au/3uTDoQP6ZTWfQHZ++Q6OQ6k6OC9qmGmEk1qTL1UwbpvlzsfPmM/5/
   I=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="827206912"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 04 Sep 2019 13:33:22 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2a-f14f4a47.us-west-2.amazon.com (Postfix) with ESMTPS id 41975A2B36;
        Wed,  4 Sep 2019 13:33:21 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:33:21 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:33:20 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Wed, 4 Sep 2019 13:33:20 +0000
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
Subject: Re: [PATCH v4 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Thread-Topic: [PATCH v4 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Thread-Index: AQHVWDYtibrUvVzzN0eveQc9L2esEKcG16IAgBTCkoA=
Date:   Wed, 4 Sep 2019 13:33:20 +0000
Message-ID: <81d37cda067a9880a261cbddf6051f9a89a3bc76.camel@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
         <20190821153545.17635-3-jonnyc@amazon.com>
         <20190822083144.GL23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190822083144.GL23903@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.20]
Content-Type: text/plain; charset="utf-8"
Content-ID: <5AA24D7B41A5624E96942F6201DB51A8@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDA5OjMxICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNjozNTo0MlBNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IEZyb206IEFsaSBTYWlkaSA8YWxpc2FpZGlAYW1hem9uLmNvbT4NCj4g
PiANCj4gPiBUaGUgQW1hem9uJ3MgQW5uYXB1cm5hIExhYnMgcm9vdCBwb3J0cyBkb24ndCBhZHZl
cnRpc2UgYW4gQUNTDQo+ID4gY2FwYWJpbGl0eSwgYnV0IHRoZXkgZG9uJ3QgYWxsb3cgcGVlci10
by1wZWVyIHRyYW5zYWN0aW9ucyBhbmQgZG8NCj4gPiB2YWxpZGF0ZSBidXMgbnVtYmVycyB0aHJv
dWdoIHRoZSBTTU1VLiBBZGRpdGlvbmFsbHksIGl0J3Mgbm90DQo+ID4gcG9zc2libGUNCj4gPiBm
b3Igb25lIFJQIHRvIHBhc3MgdHJhZmZpYyB0byBhbm90aGVyIFJQLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsaSBTYWlkaSA8YWxpc2FpZGlAYW1hem9uLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKb25hdGhhbiBDaG9jcm9uIDxqb25ueWNAYW1hem9uLmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+DQo+ID4g
LS0tDQo+ID4gIGRyaXZlcnMvcGNpL3F1aXJrcy5jIHwgMTkgKysrKysrKysrKysrKysrKysrKw0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMTkgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1n
aXQgYS9kcml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+ID4gaW5k
ZXggMjA4YWFjZjM5MzI5Li4yMzY3MjY4MGRiYTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9w
Y2kvcXVpcmtzLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPiA+IEBAIC00MzY2
LDYgKzQzNjYsMjMgQEAgc3RhdGljIGludCBwY2lfcXVpcmtfcWNvbV9ycF9hY3Moc3RydWN0DQo+
ID4gcGNpX2RldiAqZGV2LCB1MTYgYWNzX2ZsYWdzKQ0KPiA+ICAJcmV0dXJuIHJldDsNCj4gPiAg
fQ0KPiA+ICANCj4gPiArc3RhdGljIGludCBwY2lfcXVpcmtfYWxfYWNzKHN0cnVjdCBwY2lfZGV2
ICpkZXYsIHUxNiBhY3NfZmxhZ3MpDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkgKiBBbWF6b24n
cyBBbm5hcHVybmEgTGFicyByb290IHBvcnRzIGRvbid0IGluY2x1ZGUgYW4gQUNTDQo+ID4gY2Fw
YWJpbGl0eSwNCj4gPiArCSAqIGJ1dCBkbyBpbmNsdWRlIEFDUy1saWtlIGZ1bmN0aW9uYWxpdHku
IFRoZSBoYXJkd2FyZSBkb2Vzbid0DQo+ID4gc3VwcG9ydA0KPiA+ICsJICogcGVlci10by1wZWVy
IHRyYW5zYWN0aW9ucyB2aWEgdGhlIHJvb3QgcG9ydCBhbmQgZWFjaCBoYXMgYQ0KPiA+IHVuaXF1
ZQ0KPiA+ICsJICogc2VnbWVudCBudW1iZXIuDQo+ID4gKwkgKiBBZGRpdGlvbmFsbHksIHRoZSBy
b290IHBvcnRzIGNhbm5vdCBzZW5kIHRyYWZmaWMgdG8gZWFjaA0KPiA+IG90aGVyLg0KPiANCj4g
Tml0OiBJJ2QgcHJvYmFibHkgcHV0IGEgbmV3IGxpbmUgYmV0d2VlbiB0aGUgYWJvdmUgdHdvIGxp
bmVzLCBvcg0KPiBzdGFydCB0aGUNCj4gJ0FkZGl0aW9uYWxseScgc2VudGVuY2Ugb24gdGhlIGZp
cnN0IGxpbmUuIEJ1dCBlaXRoZXIgd2F5Li4uDQo+IA0KQWRkZWQgYSBuZXdsaW5lLg0KDQo+IFJl
dmlld2VkLWJ5OiBBbmRyZXcgTXVycmF5IDxhbmRyZXcubXVycmF5QGFybS5jb20+DQo+IA0KPiAN
Cj4gPiArCSAqLw0KPiA+ICsJYWNzX2ZsYWdzICY9IH4oUENJX0FDU19SUiB8IFBDSV9BQ1NfQ1Ig
fCBQQ0lfQUNTX1NWIHwNCj4gPiBQQ0lfQUNTX1VGKTsNCj4gPiArDQo+ID4gKwlpZiAocGNpX3Bj
aWVfdHlwZShkZXYpICE9IFBDSV9FWFBfVFlQRV9ST09UX1BPUlQpDQo+ID4gKwkJcmV0dXJuIC1F
Tk9UVFk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIGFjc19mbGFncyA/IDAgOiAxOw0KPiA+ICt9DQo+
ID4gKw0KPiA+ICAvKg0KPiA+ICAgKiBTdW5yaXNlIFBvaW50IFBDSCByb290IHBvcnRzIGltcGxl
bWVudCBBQ1MsIGJ1dCB1bmZvcnR1bmF0ZWx5DQo+ID4gYXMgc2hvd24gaW4NCj4gPiAgICogdGhl
IGRhdGFzaGVldCAoSW50ZWwgMTAwIFNlcmllcyBDaGlwc2V0IEZhbWlseSBQQ0ggRGF0YXNoZWV0
LA0KPiA+IFZvbC4gMiwNCj4gPiBAQCAtNDU1OSw2ICs0NTc2LDggQEAgc3RhdGljIGNvbnN0IHN0
cnVjdCBwY2lfZGV2X2Fjc19lbmFibGVkIHsNCj4gPiAgCXsgUENJX1ZFTkRPUl9JRF9BTVBFUkUs
IDB4RTAwQSwgcGNpX3F1aXJrX3hnZW5lX2FjcyB9LA0KPiA+ICAJeyBQQ0lfVkVORE9SX0lEX0FN
UEVSRSwgMHhFMDBCLCBwY2lfcXVpcmtfeGdlbmVfYWNzIH0sDQo+ID4gIAl7IFBDSV9WRU5ET1Jf
SURfQU1QRVJFLCAweEUwMEMsIHBjaV9xdWlya194Z2VuZV9hY3MgfSwNCj4gPiArCS8qIEFtYXpv
biBBbm5hcHVybmEgTGFicyAqLw0KPiA+ICsJeyBQQ0lfVkVORE9SX0lEX0FNQVpPTl9BTk5BUFVS
TkFfTEFCUywgMHgwMDMxLCBwY2lfcXVpcmtfYWxfYWNzDQo+ID4gfSwNCj4gPiAgCXsgMCB9DQo+
ID4gIH07DQo+ID4gIA0KPiA+IC0tIA0KPiA+IDIuMTcuMQ0KPiA+IA0K
