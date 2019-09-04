Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DA0F6A84AA
	for <lists+linux-pci@lfdr.de>; Wed,  4 Sep 2019 15:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729968AbfIDNlI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Sep 2019 09:41:08 -0400
Received: from smtp-fw-2101.amazon.com ([72.21.196.25]:47944 "EHLO
        smtp-fw-2101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726304AbfIDNlI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Sep 2019 09:41:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1567604467; x=1599140467;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=9oB9E5RKbz44dWfaaP/ornrMHa8i0/sjYcg4EQ72Tlk=;
  b=JaHnlaAKWHXf/zOvKW7nmgKpe7bh05Ichpz81dNk01TCIpPeftivvqDb
   Zkhar7xEjJWecPMEEggWBmSzEzwqTSk/EJJPr/XmmP+XRFzFE84guaJu6
   htqfkalOr3eI74KQNszVTM0oDNOu3sfy65i8oy69i6hAfMF9QP+mVpuzx
   A=;
X-IronPort-AV: E=Sophos;i="5.64,467,1559520000"; 
   d="scan'208";a="748981686"
Received: from iad6-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.2])
  by smtp-border-fw-out-2101.iad2.amazon.com with ESMTP; 04 Sep 2019 13:41:06 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 58B45A22D0;
        Wed,  4 Sep 2019 13:41:05 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:41:05 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 4 Sep 2019 13:41:04 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Wed, 4 Sep 2019 13:41:04 +0000
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
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "Hawa, Hanna" <hhhawa@amazon.com>,
        "Shenhar, Talel" <talel@amazon.com>,
        "Krupnik, Ronen" <ronenk@amazon.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "benh@kernel.crashing.org" <benh@kernel.crashing.org>,
        "Chocron, Jonathan" <jonnyc@amazon.com>
Subject: Re: [PATCH v4 0/7] Amazon's Annapurna Labs DT-based PCIe host
 controller driver
Thread-Topic: [PATCH v4 0/7] Amazon's Annapurna Labs DT-based PCIe host
 controller driver
Thread-Index: AQHVWDYmsL7M9uiRlE24U3td1zxmYKcYOWkAgANi9IA=
Date:   Wed, 4 Sep 2019 13:41:04 +0000
Message-ID: <ed6d45c4d1382aecc5ed5b13b6fcd09e8ed244de.camel@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
         <20190902095806.GA14841@e121166-lin.cambridge.arm.com>
In-Reply-To: <20190902095806.GA14841@e121166-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.154]
Content-Type: text/plain; charset="utf-8"
Content-ID: <FEA5FF204A922A4BB42E764D6D2044B5@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTA5LTAyIGF0IDEwOjU4ICswMTAwLCBMb3JlbnpvIFBpZXJhbGlzaSB3cm90
ZToNCj4gT24gV2VkLCBBdWcgMjEsIDIwMTkgYXQgMDY6MzU6NDBQTSArMDMwMCwgSm9uYXRoYW4g
Q2hvY3JvbiB3cm90ZToNCj4gPiBUaGlzIHNlcmllcyBhZGRzIHN1cHBvcnQgZm9yIEFtYXpvbidz
IEFubmFwdXJuYSBMYWJzIERULWJhc2VkIFBDSWUNCj4gPiBob3N0DQo+ID4gY29udHJvbGxlciBk
cml2ZXIuDQo+ID4gQWRkaXRpb25hbGx5LCBpdCBhZGRzIDMgcXVpcmtzIChBQ1MsIFZQRCBhbmQg
TVNJLVgpIGFuZCAyIGdlbmVyaWMNCj4gPiBEV0MgcGF0Y2hlcy4NCj4gPiANCj4gPiBDaGFuZ2Vz
IHNpbmNlIHYzOg0KPiA+IC0gUmVtb3ZlZCBQQVRDSCA4Lzggc2luY2UgdGhlIHVzYWdlIG9mIHRo
ZSBQQ0kgZmxhZ3Mgd2lsbCBiZQ0KPiA+IGRpc2N1c3NlZA0KPiA+ICAgaW4gdGhlIHVwY29taW5n
IExQQw0KPiA+IC0gQWxpZ24gY29tbWl0IHN1YmplY3Qgd2l0aCB0aGUgZm9sZGVyIGNvbnZlbnRp
b24NCj4gPiAtIEFkZGVkIGV4cGxhbmF0aW9uIHJlZ2FyZGluZyBFQ0FNICJvdmVybG9hZCIgbWVj
aGFuaXNtDQo+ID4gLSBTd2l0Y2hlZCB0byByZWFkL3dyaXRle19yZWxheGVkfSBBUElzDQo+ID4g
LSBNb2RpZmllZCBhIGRldl9lcnIgdG8gZGV2X2RiZw0KPiA+IC0gUmVtb3ZlZCB1bm5lY2Vzc2Fy
eSB2YXJpYWJsZQ0KPiA+IC0gUmVtb3ZlZCBkcml2ZXIgZGV0YWlscyBmcm9tIGR0LWJpbmRpbmcg
ZGVzY3JpcHRpb24NCj4gPiAtIENoYW5nZWQgdG8gU29DIHNwZWNpZmljIGNvbXBhdGlibGVzDQo+
ID4gLSBGaXhlZCB0eXBvIGluIGEgY29tbWl0IG1lc3NhZ2UNCj4gPiAtIEFkZGVkIGNvbW1lbnQg
cmVnYXJkaW5nIE1TSSBpbiB0aGUgTVNJLVggcXVpcmsNCj4gPiANCj4gPiBDaGFuZ2VzIHNpbmNl
IHYyOg0KPiA+IC0gQWRkZWQgYWxfcGNpZV9jb250cm9sbGVyX3JlYWRsL3dyaXRlbCgpIHdyYXBw
ZXJzDQo+ID4gLSBSZW9yZ2FuaXplZCBsb2NhbCB2YXJzIGluIHNldmVyYWwgZnVuY3Rpb25zIGFj
Y29yZGluZyB0byByZXZlcnNlDQo+ID4gICB0cmVlIHN0cnVjdHVyZQ0KPiA+IC0gUmVtb3ZlZCB1
bm5lY2Vzc2FyeSBjaGVjayBvZiByZXQgdmFsdWUNCj4gPiAtIENoYW5nZWQgcmV0dXJuIHR5cGUg
b2YgYWxfcGNpZV9jb25maWdfcHJlcGFyZSgpIGZyb20gaW50IHRvIHZvaWQNCj4gPiAtIFJlbW92
ZWQgY2hlY2sgaWYgbGluayBpcyB1cCBmcm9tIHByb2JlKCkgW2RvbmUgaW50ZXJuYWxseSBpbg0K
PiA+ICAgZHdfcGNpZV9yZC93cl9jb25mKCldDQo+ID4gDQo+ID4gQ2hhbmdlcyBzaW5jZSB2MToN
Cj4gPiAtIEFkZGVkIGNvbW1lbnQgcmVnYXJkaW5nIDB4MDAzMSBiZWluZyB1c2VkIGFzIGEgZGV2
X2lkIGZvciBub24NCj4gPiByb290LXBvcnQgZGV2aWNlcyBhcyB3ZWxsDQo+ID4gLSBGaXhlZCBk
aWZmZXJlbnQgbWVzc2FnZS9jb21tZW50L3ByaW50IHdvcmRpbmdzDQo+ID4gLSBBZGRlZCBwYW5p
YyBzdGFja3RyYWNlIHRvIGNvbW1pdCBtZXNzYWdlIG9mIE1TSS14IHF1aXJrIHBhdGNoDQo+ID4g
LSBDaGFuZ2VkIHRvIHBjaV93YXJuKCkgaW5zdGVhZCBvZiBkZXZfd2FybigpDQo+ID4gLSBBZGRl
ZCB1bml0X2FkZHJlc3MgYWZ0ZXIgbm9kZV9uYW1lIGluIGR0LWJpbmRpbmcNCj4gPiAtIFVwZGF0
ZWQgS2NvbmZpZyBoZWxwIGRlc2NyaXB0aW9uDQo+ID4gLSBVc2VkIEdFTk1BU0sgYW5kIEZJRUxE
X1BSRVAvR0VUIHdoZXJlIGFwcHJvcHJpYXRlDQo+ID4gLSBSZW1vdmVkIGxlZnRvdmVyIGZpZWxk
IGZyb20gc3RydWN0IGFsX3BjaWUgYW5kIG1vdmVkIGFsbCBwdHJzIHRvDQo+ID4gICB0aGUgYmVn
aW5uaW5nDQo+ID4gLSBSZS13cmFwcGVkIGZ1bmN0aW9uIGRlZmluaXRpb25zIGFuZCBpbnZvY2F0
aW9ucyB0byB1c2UgZmV3ZXINCj4gPiBsaW5lcw0KPiA+IC0gQ2hhbmdlICVwIHRvICVweCBpbiBk
YmcgcHJpbnRzIGluIHJkL3dyX2NvbmYoKSBmdW5jdGlvbnMNCj4gPiAtIFJlbW92ZWQgdmFsaWRh
dGlvbiB0aGF0IHRoZSBwb3J0IGlzIGNvbmZpZ3VyZWQgdG8gUkMgbW9kZSAoYXMNCj4gPiB0aGlz
IGlzDQo+ID4gICBhZGRlZCBnZW5lcmljYWxseSBpbiBQQVRDSCA3LzgpDQo+ID4gLSBSZW1vdmVk
IHVubmVjZXNzYXJ5IHZhcmlhYmxlIGluaXRpYWxpemF0aW9ucw0KPiA+IC0gU3d0aWNoZWQgdG8g
JXBSIGZvciBwcmludGluZyByZXNvdXJjZXMNCj4gPiANCj4gPiANCj4gPiBBbGkgU2FpZGkgKDEp
Og0KPiA+ICAgUENJOiBBZGQgQUNTIHF1aXJrIGZvciBBbWF6b24gQW5uYXB1cm5hIExhYnMgcm9v
dCBwb3J0cw0KPiA+IA0KPiA+IEpvbmF0aGFuIENob2Nyb24gKDYpOg0KPiA+ICAgUENJOiBBZGQg
QW1hem9uJ3MgQW5uYXB1cm5hIExhYnMgdmVuZG9yIElEDQo+ID4gICBQQ0kvVlBEOiBBZGQgVlBE
IHJlbGVhc2UgcXVpcmsgZm9yIEFtYXpvbidzIEFubmFwdXJuYSBMYWJzIFJvb3QNCj4gPiBQb3J0
DQo+ID4gICBQQ0k6IEFkZCBxdWlyayB0byBkaXNhYmxlIE1TSS1YIHN1cHBvcnQgZm9yIEFtYXpv
bidzIEFubmFwdXJuYQ0KPiA+IExhYnMNCj4gPiAgICAgUm9vdCBQb3J0DQo+ID4gICBkdC1iaW5k
aW5nczogUENJOiBBZGQgQW1hem9uJ3MgQW5uYXB1cm5hIExhYnMgUENJZSBob3N0IGJyaWRnZQ0K
PiA+IGJpbmRpbmcNCj4gPiAgIFBDSTogZHdjOiBhbDogQWRkIHN1cHBvcnQgZm9yIERXIGJhc2Vk
IGRyaXZlciB0eXBlDQo+ID4gICBQQ0k6IGR3YzogQWRkIHZhbGlkYXRpb24gdGhhdCBQQ0llIGNv
cmUgaXMgc2V0IHRvIGNvcnJlY3QgbW9kZQ0KPiA+IA0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5k
aW5ncy9wY2kvcGNpZS1hbC50eHQgICAgICAgfCAgNDYgKysrDQo+ID4gIE1BSU5UQUlORVJTICAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICB8ICAgMyArLQ0KPiA+ICBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL2R3Yy9LY29uZmlnICAgICAgICAgICAgfCAgMTIgKw0KPiA+ICBkcml2ZXJz
L3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFsLmMgICAgICAgICAgfCAzNjUNCj4gPiArKysrKysr
KysrKysrKysrKysNCj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndhcmUt
ZXAuYyAgIHwgICA4ICsNCj4gPiAgLi4uL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWRlc2lnbndh
cmUtaG9zdC5jIHwgICA4ICsNCj4gPiAgZHJpdmVycy9wY2kvcXVpcmtzLmMgICAgICAgICAgICAg
ICAgICAgICAgICAgIHwgIDM3ICsrDQo+ID4gIGRyaXZlcnMvcGNpL3ZwZC5jICAgICAgICAgICAg
ICAgICAgICAgICAgICAgICB8ICAxNiArDQo+ID4gIGluY2x1ZGUvbGludXgvcGNpX2lkcy5oICAg
ICAgICAgICAgICAgICAgICAgICB8ICAgMiArDQo+ID4gIDkgZmlsZXMgY2hhbmdlZCwgNDk2IGlu
c2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAgY3JlYXRlIG1vZGUgMTAwNjQ0IERvY3Vt
ZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcGNpZS0NCj4gPiBhbC50eHQNCj4gDQo+
IEhpIEpvbmF0aGFuLA0KPiANCj4gYXJlIHlvdSBnb2luZyB0byBzZW5kIGEgdjUgZm9yIHRoaXMg
c2VyaWVzID8gSWYgd2Ugc2hvdWxkIGNvbnNpZGVyDQo+IGl0IGZvciB2NS40IEkgZXhwZWN0IGl0
IHRvIGJlIG9uIHRoZSBsaXN0IHRoaXMgd2VlayBhcyBzb29uIGFzDQo+IHBvc3NpYmxlLg0KPiAN
ClllcywgSSdsbCBzZW5kIGl0IGJ5IHRvbW9ycm93Lg0KDQo+IFRoYW5rcywNCj4gTG9yZW56bw0K
