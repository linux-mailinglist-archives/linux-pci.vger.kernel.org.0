Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1970A94994
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2019 18:16:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726661AbfHSQQE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Aug 2019 12:16:04 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:30008 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726168AbfHSQQE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Aug 2019 12:16:04 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566231362; x=1597767362;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=TYuFaPEuksP2j0uaq5dLdH1JEy1QpE6+JJ35uNwdI0o=;
  b=fcRsVnA1yriH8nMbSFidwpSYoDPmTbZu6VW6KLZlVr6kqSkQvFNgDqeE
   g+66g0BZ4It1AhLHl7UHf1K032ZVDF2M9psFatzZ7kMhDFBHVhZm2wZXm
   lq/+oDwGQeh6rCY8WrxWOrLlh3bZwE66HLe6mFz5pHTTqSnaP1N7TKU1b
   8=;
X-IronPort-AV: E=Sophos;i="5.64,405,1559520000"; 
   d="scan'208";a="695188101"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 19 Aug 2019 16:15:37 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan3.pdx.amazon.com [10.170.41.166])
        by email-inbound-relay-2a-d0be17ee.us-west-2.amazon.com (Postfix) with ESMTPS id E4415A20F7;
        Mon, 19 Aug 2019 16:15:36 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 19 Aug 2019 16:15:36 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Mon, 19 Aug 2019 16:15:36 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Mon, 19 Aug 2019 16:15:35 +0000
From:   "Chocron, Jonathan" <jonnyc@amazon.com>
To:     "robh@kernel.org" <robh@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
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
Subject: Re: [PATCH v3 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs PCIe
 host bridge binding
Thread-Topic: [PATCH v3 5/8] dt-bindings: PCI: Add Amazon's Annapurna Labs
 PCIe host bridge binding
Thread-Index: AQHVQTjX5ibJ8twrf0Koy9tsFtVyC6b5VbUAgAAV1QCAAEJVgIAJIliA
Date:   Mon, 19 Aug 2019 16:15:35 +0000
Message-ID: <11670a7a6225345f9b212aaebfaf2a4fccd4ac38.camel@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
         <20190723092711.11786-1-jonnyc@amazon.com> <20190813153046.GA31480@bogus>
         <06c198ff2f8f9b1b29283a7b8764ab776c1e574b.camel@amazon.com>
         <CAL_Jsq+ME-faxK8o7rq8gyYC8cjtr+yZOz8A47zKMrjYAtmumw@mail.gmail.com>
In-Reply-To: <CAL_Jsq+ME-faxK8o7rq8gyYC8cjtr+yZOz8A47zKMrjYAtmumw@mail.gmail.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.211]
Content-Type: text/plain; charset="utf-8"
Content-ID: <45963A67871B4947814C1218B9E95A99@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDE0OjQ2IC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBBdWcgMTMsIDIwMTkgYXQgMTA6NDkgQU0gQ2hvY3JvbiwgSm9uYXRoYW4gPGpvbm55
Y0BhbWF6b24uY29tDQo+ID4gd3JvdGU6DQo+ID4gDQo+ID4gT24gVHVlLCAyMDE5LTA4LTEzIGF0
IDA5OjMwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4gPiA+IE9uIFR1ZSwgSnVsIDIzLCAy
MDE5IGF0IDEyOjI3OjA4UE0gKzAzMDAsIEpvbmF0aGFuIENob2Nyb24gd3JvdGU6DQo+ID4gPiA+
IERvY3VtZW50IEFtYXpvbidzIEFubmFwdXJuYSBMYWJzIFBDSWUgaG9zdCBicmlkZ2UuDQo+ID4g
PiA+IA0KPiA+ID4gPiBTaWduZWQtb2ZmLWJ5OiBKb25hdGhhbiBDaG9jcm9uIDxqb25ueWNAYW1h
em9uLmNvbT4NCj4gPiA+ID4gLS0tDQo+ID4gPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9w
Y2kvcGNpZS1hbC50eHQgICAgICAgfCA0NQ0KPiA+ID4gPiArKysrKysrKysrKysrKysrKysrDQo+
ID4gPiA+ICBNQUlOVEFJTkVSUyAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgfCAg
MyArLQ0KPiA+ID4gPiAgMiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0
aW9uKC0pDQo+ID4gPiA+ICBjcmVhdGUgbW9kZSAxMDA2NDQgRG9jdW1lbnRhdGlvbi9kZXZpY2V0
cmVlL2JpbmRpbmdzL3BjaS9wY2llLQ0KPiA+ID4gPiBhbC50eHQNCj4gPiA+ID4gDQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9Eb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3BjaWUt
YWwudHh0DQo+ID4gPiA+IGIvRG9jdW1lbnRhdGlvbi9kZXZpY2V0cmVlL2JpbmRpbmdzL3BjaS9w
Y2llLWFsLnR4dA0KPiA+ID4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0NA0KPiA+ID4gPiBpbmRleCAw
MDAwMDAwMDAwMDAuLjg5ODc2MTkwZWI1YQ0KPiA+ID4gPiAtLS0gL2Rldi9udWxsDQo+ID4gPiA+
ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcGNpZS1hbC50eHQN
Cj4gPiA+ID4gQEAgLTAsMCArMSw0NSBAQA0KPiA+ID4gPiArKiBBbWF6b24gQW5uYXB1cm5hIExh
YnMgUENJZSBob3N0IGJyaWRnZQ0KPiA+ID4gPiArDQo+ID4gPiA+ICtBbWF6b24ncyBBbm5hcHVy
bmEgTGFicyBQQ0llIEhvc3QgQ29udHJvbGxlciBpcyBiYXNlZCBvbiB0aGUNCj4gPiA+ID4gU3lu
b3BzeXMgRGVzaWduV2FyZQ0KPiA+ID4gPiArUENJIGNvcmUuDQo+ID4gPiA+ICtJdCBzaGFyZXMg
Y29tbW9uIGZ1bmN0aW9ucyB3aXRoIHRoZSBQQ0llIERlc2lnbldhcmUgY29yZQ0KPiA+ID4gPiBk
cml2ZXINCj4gPiA+ID4gYW5kIGluaGVyaXRzDQo+ID4gPiANCj4gPiA+IERyaXZlciBkZXRhaWxz
IGFyZSBpcnJlbGV2YW50IHRvIHRoZSBiaW5kaW5nLg0KPiA+ID4gDQo+ID4gDQo+ID4gV2lsbCBy
ZW1vdmUuDQo+ID4gDQo+ID4gPiA+ICtjb21tb24gcHJvcGVydGllcyBkZWZpbmVkIGluDQo+ID4g
PiA+IERvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZGVzaWdud2FyZS1wY2ll
LnR4dC4NCj4gPiA+ID4gK1Byb3BlcnRpZXMgb2YgdGhlIGhvc3QgY29udHJvbGxlciBub2RlIHRo
YXQgZGlmZmVyIGZyb20gaXQNCj4gPiA+ID4gYXJlOg0KPiA+ID4gPiArDQo+ID4gPiA+ICstIGNv
bXBhdGlibGU6DQo+ID4gPiA+ICsgICBVc2FnZTogcmVxdWlyZWQNCj4gPiA+ID4gKyAgIFZhbHVl
IHR5cGU6IDxzdHJpbmdsaXN0Pg0KPiA+ID4gPiArICAgRGVmaW5pdGlvbjogVmFsdWUgc2hvdWxk
IGNvbnRhaW4NCj4gPiA+ID4gKyAgICAgICAgICAgICAgICAgICAtICJhbWF6b24sYWwtcGNpZSIN
Cj4gPiA+IA0KPiA+ID4gTmVlZHMgdG8gYmUgU29DIHNwZWNpZmljLg0KPiA+ID4gDQo+ID4gDQo+
ID4gSSdtIG5vdCBzdXJlIEkgZm9sbG93LiBUaGUgUENJZSBjb250cm9sbGVyIGNhbiBiZSBpbXBs
ZW1lbnRlZCBpbg0KPiA+IGRpZmZlcmVudCBTb0NzLiBDb3VsZCB5b3UgcGxlYXNlIGNsYXJpZnk/
DQo+IA0KPiBBbGwgdGhlIGZlYXR1cmVzLCBidWdzLCBhbmQgaW50ZWdyYXRpb24gd2lsbCBiZSBl
eGFjdGx5IHRoZSBzYW1lIG9uDQo+IGFsbCBTb0NzIGFuZCB5b3Ugd2lsbCBuZXZlciBuZWVkIHRv
IGRpc3Rpbmd1aXNoPw0KPiANCj4gVGhpcyBpcyBzdGFuZGFyZCBjb252ZW50aW9uIGZvciBjb21w
YXRpYmxlIHN0cmluZ3MgYW5kIGhvdyB5b3UgYXZvaWQNCj4gdXBkYXRpbmcgdGhlIERUIChwYXJ0
IG9mIGZpcm13YXJlKSB3aGVuIHlvdSBmaW5kIHNvbWUgZGlmZmVyZW5jZSB0aGUNCj4gT1MgbmVl
ZHMgdG8gaGFuZGxlIGRvd24gdGhlIHJvYWQuDQo+IA0KPiBJZiB0aGUgbmV4dCBTb0MgaXMgJ3Ro
ZSBzYW1lJywgdGhlbiB5b3UgZG86DQo+IA0KPiBjb21wYXRpYmxlID0gImFtYXpvbixuZXdzb2Mt
cGNpZSIsICJhbWF6b24sb2xkc29jLXBjaWUiOw0KPiANCkdvdCBpdC4gU28gY3VycmVudGx5IHRo
ZSByZWxldmFudCBTb0MgY29tcGF0aWJsZXMgd2lsbCBiZToNCiJhbWF6b24sYWwtYWxwaW5lLXYy
LXBjaWUiDQoiYW1hem9uLGFsLWFscGluZS12My1wY2llIg0KDQpTaWRlbm90ZTogSW4gdGhlIGRy
aXZlciBJJ2xsIGFkZCB0aGVtIHRvIHRoZSBvZl9kZXZpY2VfaWQgbWF0Y2ggdGFibGUNCndpdGgg
YW4gZW1wdHkgLmRhdGEgZmllbGQgZm9yIGJvdGguIFNvdW5kcyBzYW5lPw0KDQpJJ2xsIHVwZGF0
ZSBhbGwgdGhpcyBhcyBwYXJ0IG9mIHY0Lg0KDQo+IFJvYg0K
