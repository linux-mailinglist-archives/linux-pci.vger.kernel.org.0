Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0238FAFF63
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 16:59:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728181AbfIKO7h (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 10:59:37 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:54436 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727664AbfIKO7h (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 10:59:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568213975; x=1599749975;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=u6EU8uXluBy1WwbVaGF9KQF2I1+9FTA5oCOzCj4QLXw=;
  b=VISY/u1bcbhBLqh2zqBghinVRNjjmC1mkqHaR4zmsyZjPM5jH978pk5T
   p1l0EgBnuG12s0v6LuoW94KhN/o5W6O+Mto9cRywtqwsn8YY8RKBQXzDY
   jYaw3cIYEoLNYGQjXnG7/E20a0ToE6St+0LFHkuc4ptAODgRJBoFymzxS
   s=;
X-IronPort-AV: E=Sophos;i="5.64,493,1559520000"; 
   d="scan'208";a="414729891"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 11 Sep 2019 14:59:34 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan3.iad.amazon.com [10.40.159.166])
        by email-inbound-relay-1e-97fdccfd.us-east-1.amazon.com (Postfix) with ESMTPS id 67A65A2394;
        Wed, 11 Sep 2019 14:59:30 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Sep 2019 14:59:30 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Sep 2019 14:59:29 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Wed, 11 Sep 2019 14:59:29 +0000
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
Subject: Re: [PATCH v5 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Thread-Topic: [PATCH v5 2/7] PCI: Add ACS quirk for Amazon Annapurna Labs root
 ports
Thread-Index: AQHVY/JSuAMshExLD0+MpUtn91R2FacgcggAgAYpFoA=
Date:   Wed, 11 Sep 2019 14:59:29 +0000
Message-ID: <329373c70adfe37fc5288b9fac9e438447412693.camel@amazon.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
         <20190905140018.5139-3-jonnyc@amazon.com>
         <20190907165450.GL103977@google.com>
In-Reply-To: <20190907165450.GL103977@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.242]
Content-Type: text/plain; charset="utf-8"
Content-ID: <B2C6FB38101F0A46B25E85B086EEBD98@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDE5LTA5LTA3IGF0IDExOjU0IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBUaHUsIFNlcCAwNSwgMjAxOSBhdCAwNTowMDoxNlBNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IEZyb206IEFsaSBTYWlkaSA8YWxpc2FpZGlAYW1hem9uLmNvbT4NCj4g
PiANCj4gPiBUaGUgQW1hem9uJ3MgQW5uYXB1cm5hIExhYnMgcm9vdCBwb3J0cyBkb24ndCBhZHZl
cnRpc2UgYW4gQUNTDQo+ID4gY2FwYWJpbGl0eSwgYnV0IHRoZXkgZG9uJ3QgYWxsb3cgcGVlci10
by1wZWVyIHRyYW5zYWN0aW9ucyBhbmQgZG8NCj4gPiB2YWxpZGF0ZSBidXMgbnVtYmVycyB0aHJv
dWdoIHRoZSBTTU1VLiBBZGRpdGlvbmFsbHksIGl0J3Mgbm90DQo+ID4gcG9zc2libGUNCj4gPiBm
b3Igb25lIFJQIHRvIHBhc3MgdHJhZmZpYyB0byBhbm90aGVyIFJQLg0KPiA+IA0KPiA+IFNpZ25l
ZC1vZmYtYnk6IEFsaSBTYWlkaSA8YWxpc2FpZGlAYW1hem9uLmNvbT4NCj4gPiBTaWduZWQtb2Zm
LWJ5OiBKb25hdGhhbiBDaG9jcm9uIDxqb25ueWNAYW1hem9uLmNvbT4NCj4gPiBSZXZpZXdlZC1i
eTogR3VzdGF2byBQaW1lbnRlbCA8Z3VzdGF2by5waW1lbnRlbEBzeW5vcHN5cy5jb20+DQo+ID4g
UmV2aWV3ZWQtYnk6IEFuZHJldyBNdXJyYXkgPGFuZHJldy5tdXJyYXlAYXJtLmNvbT4NCj4gDQo+
IEFja2VkLWJ5OiBCam9ybiBIZWxnYWFzIDxiaGVsZ2Fhc0Bnb29nbGUuY29tPg0KPiANCj4gQnV0
IHBsZWFzZSB0d2VhayBpdCBhcyBiZWxvdyAuLi4NCj4gDQpXaWxsIGJlIHBhcnQgb2YgdjYuDQoN
Cj4gPiAtLS0NCj4gPiAgZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAyMCArKysrKysrKysrKysrKysr
KysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgMjAgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRp
ZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+
ID4gaW5kZXggZGVkNjA3NTdhNTczLi44ZmU3NjU1OTI5NDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJp
dmVycy9wY2kvcXVpcmtzLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPiA+IEBA
IC00NDE4LDYgKzQ0MTgsMjQgQEAgc3RhdGljIGludCBwY2lfcXVpcmtfcWNvbV9ycF9hY3Moc3Ry
dWN0DQo+ID4gcGNpX2RldiAqZGV2LCB1MTYgYWNzX2ZsYWdzKQ0KPiA+ICAJcmV0dXJuIHJldDsN
Cj4gPiAgfQ0KPiA+ICANCj4gPiArc3RhdGljIGludCBwY2lfcXVpcmtfYWxfYWNzKHN0cnVjdCBw
Y2lfZGV2ICpkZXYsIHUxNiBhY3NfZmxhZ3MpDQo+ID4gK3sNCj4gPiArCS8qDQo+ID4gKwkgKiBB
bWF6b24ncyBBbm5hcHVybmEgTGFicyByb290IHBvcnRzIGRvbid0IGluY2x1ZGUgYW4gQUNTDQo+
ID4gY2FwYWJpbGl0eSwNCj4gPiArCSAqIGJ1dCBkbyBpbmNsdWRlIEFDUy1saWtlIGZ1bmN0aW9u
YWxpdHkuIFRoZSBoYXJkd2FyZSBkb2Vzbid0DQo+ID4gc3VwcG9ydA0KPiA+ICsJICogcGVlci10
by1wZWVyIHRyYW5zYWN0aW9ucyB2aWEgdGhlIHJvb3QgcG9ydCBhbmQgZWFjaCBoYXMgYQ0KPiA+
IHVuaXF1ZQ0KPiA+ICsJICogc2VnbWVudCBudW1iZXIuDQo+ID4gKwkgKg0KPiA+ICsJICogQWRk
aXRpb25hbGx5LCB0aGUgcm9vdCBwb3J0cyBjYW5ub3Qgc2VuZCB0cmFmZmljIHRvIGVhY2gNCj4g
PiBvdGhlci4NCj4gPiArCSAqLw0KPiA+ICsJYWNzX2ZsYWdzICY9IH4oUENJX0FDU19SUiB8IFBD
SV9BQ1NfQ1IgfCBQQ0lfQUNTX1NWIHwNCj4gPiBQQ0lfQUNTX1VGKTsNCj4gDQo+IFRoZXJlIGFy
ZSBzZXZlcmFsIHF1aXJrcyB0aGF0IHVzZSB0aGlzIHNhbWUgc2V0IG9mIGJpdHMsIGJ1dCB0aGV5
DQo+IGRvbid0IHVzZSB0aGUgc2FtZSBvcmRlciwgd2hpY2ggaXMgYSBuZWVkbGVzcyBkaWZmZXJl
bmNlLg0KPiANCj4gQ2FuIHlvdSByZW9yZGVyIHRoZW0gaW4gdGhlIGJpdCAwIC4uLiBiaXQgNyBv
cmRlcj8gIEkuZS4sDQo+IA0KPiAgICAgUENJX0FDU19TViB8IFBDSV9BQ1NfUlIgfCBQQ0lfQUNT
X0NSIHwgUENJX0FDU19VRg0KPiANCkRvbmUuDQoNCj4gPiArCWlmIChwY2lfcGNpZV90eXBlKGRl
dikgIT0gUENJX0VYUF9UWVBFX1JPT1RfUE9SVCkNCj4gPiArCQlyZXR1cm4gLUVOT1RUWTsNCj4g
DQo+IFRoaXMgY291bGQgZ28gZmlyc3QgKGFib3ZlIHRoZSBjb21tZW50KSBzbyBhbGwgdGhlIGFj
c19mbGFncyBzdHVmZiBpcw0KPiB0b2dldGhlci4NCj4gDQpEb25lLg0KDQo+ID4gKwlyZXR1cm4g
YWNzX2ZsYWdzID8gMCA6IDE7DQo+ID4gK30NCj4gPiArDQo+ID4gIC8qDQo+ID4gICAqIFN1bnJp
c2UgUG9pbnQgUENIIHJvb3QgcG9ydHMgaW1wbGVtZW50IEFDUywgYnV0IHVuZm9ydHVuYXRlbHkN
Cj4gPiBhcyBzaG93biBpbg0KPiA+ICAgKiB0aGUgZGF0YXNoZWV0IChJbnRlbCAxMDAgU2VyaWVz
IENoaXBzZXQgRmFtaWx5IFBDSCBEYXRhc2hlZXQsDQo+ID4gVm9sLiAyLA0KPiA+IEBAIC00NjEx
LDYgKzQ2MjksOCBAQCBzdGF0aWMgY29uc3Qgc3RydWN0IHBjaV9kZXZfYWNzX2VuYWJsZWQgew0K
PiA+ICAJeyBQQ0lfVkVORE9SX0lEX0FNUEVSRSwgMHhFMDBBLCBwY2lfcXVpcmtfeGdlbmVfYWNz
IH0sDQo+ID4gIAl7IFBDSV9WRU5ET1JfSURfQU1QRVJFLCAweEUwMEIsIHBjaV9xdWlya194Z2Vu
ZV9hY3MgfSwNCj4gPiAgCXsgUENJX1ZFTkRPUl9JRF9BTVBFUkUsIDB4RTAwQywgcGNpX3F1aXJr
X3hnZW5lX2FjcyB9LA0KPiA+ICsJLyogQW1hem9uIEFubmFwdXJuYSBMYWJzICovDQo+ID4gKwl7
IFBDSV9WRU5ET1JfSURfQU1BWk9OX0FOTkFQVVJOQV9MQUJTLCAweDAwMzEsIHBjaV9xdWlya19h
bF9hY3MNCj4gPiB9LA0KPiA+ICAJeyAwIH0NCj4gPiAgfTsNCj4gPiAgDQo+ID4gLS0gDQo+ID4g
Mi4xNy4xDQo+ID4gDQo=
