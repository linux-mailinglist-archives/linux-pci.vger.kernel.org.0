Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id DC6B58BEF1
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 18:49:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726986AbfHMQtC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 13 Aug 2019 12:49:02 -0400
Received: from smtp-fw-4101.amazon.com ([72.21.198.25]:14867 "EHLO
        smtp-fw-4101.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbfHMQtC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 13 Aug 2019 12:49:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1565714941; x=1597250941;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=dDOBz4vnkONayUHCFyTxOXbi2aI1o2S0rcTQvTWaqjY=;
  b=LZOR6+sJtjQLG57YytRl4+N2RHm+Sjz5oQbVWHsQ3HxeTq1CZHDJ5C7S
   NgG1tevExwjDSHxDN1fPk35UJ65fUGcXT1tvHHbPD5PsY/tFDUrHJz+lF
   o4fJAhUuoXEaALe9YHfc9fqpnf0WE3Ia5M5vdPo8IgmTRSBKgDu3S9uw8
   I=;
X-IronPort-AV: E=Sophos;i="5.64,382,1559520000"; 
   d="scan'208";a="779080235"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-4101.iad4.amazon.com with ESMTP; 13 Aug 2019 16:48:58 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-4e24fd92.us-west-2.amazon.com (Postfix) with ESMTPS id E2E06A24B4;
        Tue, 13 Aug 2019 16:48:57 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 13 Aug 2019 16:48:57 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 13 Aug 2019 16:48:57 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Tue, 13 Aug 2019 16:48:56 +0000
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
Thread-Index: AQHVQTjX5ibJ8twrf0Koy9tsFtVyC6b5VbUAgAAV1QA=
Date:   Tue, 13 Aug 2019 16:48:56 +0000
Message-ID: <06c198ff2f8f9b1b29283a7b8764ab776c1e574b.camel@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
         <20190723092711.11786-1-jonnyc@amazon.com> <20190813153046.GA31480@bogus>
In-Reply-To: <20190813153046.GA31480@bogus>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.67]
Content-Type: text/plain; charset="utf-8"
Content-ID: <BB54D34F35A0854085A24351C45F19EB@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTEzIGF0IDA5OjMwIC0wNjAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gVHVlLCBKdWwgMjMsIDIwMTkgYXQgMTI6Mjc6MDhQTSArMDMwMCwgSm9uYXRoYW4gQ2hvY3Jv
biB3cm90ZToNCj4gPiBEb2N1bWVudCBBbWF6b24ncyBBbm5hcHVybmEgTGFicyBQQ0llIGhvc3Qg
YnJpZGdlLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENob2Nyb24gPGpvbm55
Y0BhbWF6b24uY29tPg0KPiA+IC0tLQ0KPiA+ICAuLi4vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kv
cGNpZS1hbC50eHQgICAgICAgfCA0NQ0KPiA+ICsrKysrKysrKysrKysrKysrKysNCj4gPiAgTUFJ
TlRBSU5FUlMgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIHwgIDMgKy0NCj4gPiAg
MiBmaWxlcyBjaGFuZ2VkLCA0NyBpbnNlcnRpb25zKCspLCAxIGRlbGV0aW9uKC0pDQo+ID4gIGNy
ZWF0ZSBtb2RlIDEwMDY0NCBEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3Bj
aWUtDQo+ID4gYWwudHh0DQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvcGNpZS1hbC50eHQNCj4gPiBiL0RvY3VtZW50YXRpb24vZGV2
aWNldHJlZS9iaW5kaW5ncy9wY2kvcGNpZS1hbC50eHQNCj4gPiBuZXcgZmlsZSBtb2RlIDEwMDY0
NA0KPiA+IGluZGV4IDAwMDAwMDAwMDAwMC4uODk4NzYxOTBlYjVhDQo+ID4gLS0tIC9kZXYvbnVs
bA0KPiA+ICsrKyBiL0RvY3VtZW50YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvcGNpZS1h
bC50eHQNCj4gPiBAQCAtMCwwICsxLDQ1IEBADQo+ID4gKyogQW1hem9uIEFubmFwdXJuYSBMYWJz
IFBDSWUgaG9zdCBicmlkZ2UNCj4gPiArDQo+ID4gK0FtYXpvbidzIEFubmFwdXJuYSBMYWJzIFBD
SWUgSG9zdCBDb250cm9sbGVyIGlzIGJhc2VkIG9uIHRoZQ0KPiA+IFN5bm9wc3lzIERlc2lnbldh
cmUNCj4gPiArUENJIGNvcmUuDQo+ID4gK0l0IHNoYXJlcyBjb21tb24gZnVuY3Rpb25zIHdpdGgg
dGhlIFBDSWUgRGVzaWduV2FyZSBjb3JlIGRyaXZlcg0KPiA+IGFuZCBpbmhlcml0cw0KPiANCj4g
RHJpdmVyIGRldGFpbHMgYXJlIGlycmVsZXZhbnQgdG8gdGhlIGJpbmRpbmcuDQo+IA0KV2lsbCBy
ZW1vdmUuDQoNCj4gPiArY29tbW9uIHByb3BlcnRpZXMgZGVmaW5lZCBpbg0KPiA+IERvY3VtZW50
YXRpb24vZGV2aWNldHJlZS9iaW5kaW5ncy9wY2kvZGVzaWdud2FyZS1wY2llLnR4dC4NCj4gPiAr
UHJvcGVydGllcyBvZiB0aGUgaG9zdCBjb250cm9sbGVyIG5vZGUgdGhhdCBkaWZmZXIgZnJvbSBp
dCBhcmU6DQo+ID4gKw0KPiA+ICstIGNvbXBhdGlibGU6DQo+ID4gKwlVc2FnZTogcmVxdWlyZWQN
Cj4gPiArCVZhbHVlIHR5cGU6IDxzdHJpbmdsaXN0Pg0KPiA+ICsJRGVmaW5pdGlvbjogVmFsdWUg
c2hvdWxkIGNvbnRhaW4NCj4gPiArCQkJLSAiYW1hem9uLGFsLXBjaWUiDQo+IA0KPiBOZWVkcyB0
byBiZSBTb0Mgc3BlY2lmaWMuDQo+IA0KSSdtIG5vdCBzdXJlIEkgZm9sbG93LiBUaGUgUENJZSBj
b250cm9sbGVyIGNhbiBiZSBpbXBsZW1lbnRlZCBpbg0KZGlmZmVyZW50IFNvQ3MuIENvdWxkIHlv
dSBwbGVhc2UgY2xhcmlmeT8NCg0KPiA+ICsNCj4gPiArLSByZWc6DQo+ID4gKwlVc2FnZTogcmVx
dWlyZWQNCj4gPiArCVZhbHVlIHR5cGU6IDxwcm9wLWVuY29kZWQtYXJyYXk+DQo+ID4gKwlEZWZp
bml0aW9uOiBSZWdpc3RlciByYW5nZXMgYXMgbGlzdGVkIGluIHRoZSByZWctbmFtZXMgcHJvcGVy
dHkNCj4gPiArDQo+ID4gKy0gcmVnLW5hbWVzOg0KPiA+ICsJVXNhZ2U6IHJlcXVpcmVkDQo+ID4g
KwlWYWx1ZSB0eXBlOiA8c3RyaW5nbGlzdD4NCj4gPiArCURlZmluaXRpb246IE11c3QgaW5jbHVk
ZSB0aGUgZm9sbG93aW5nIGVudHJpZXMNCj4gPiArCQkJLSAiY29uZmlnIglQQ0llIEVDQU0gc3Bh
Y2UNCj4gPiArCQkJLSAiY29udHJvbGxlciIJQUwgcHJvcHJpZXRhcnkgcmVnaXN0ZXJzDQo+ID4g
KwkJCS0gImRiaSIJCURlc2lnbndhcmUgUENJZSByZWdpc3RlcnMNCj4gPiArDQo+ID4gK0V4YW1w
bGU6DQo+ID4gKw0KPiA+ICsJcGNpZS1leHRlcm5hbDA6IHBjaWVAZmI2MDAwMDAgew0KPiA+ICsJ
CWNvbXBhdGlibGUgPSAiYW1hem9uLGFsLXBjaWUiOw0KPiA+ICsJCXJlZyA9IDwweDAgMHhmYjYw
MDAwMCAweDAgMHgwMDEwMDAwMA0KPiA+ICsJCSAgICAgICAweDAgMHhmZDgwMDAwMCAweDAgMHgw
MDAxMDAwMA0KPiA+ICsJCSAgICAgICAweDAgMHhmZDgxMDAwMCAweDAgMHgwMDAwMTAwMD47DQo+
ID4gKwkJcmVnLW5hbWVzID0gImNvbmZpZyIsICJjb250cm9sbGVyIiwgImRiaSI7DQo+ID4gKwkJ
YnVzLXJhbmdlID0gPDAgMjU1PjsNCj4gPiArCQlkZXZpY2VfdHlwZSA9ICJwY2kiOw0KPiA+ICsJ
CSNhZGRyZXNzLWNlbGxzID0gPDM+Ow0KPiA+ICsJCSNzaXplLWNlbGxzID0gPDI+Ow0KPiA+ICsJ
CSNpbnRlcnJ1cHQtY2VsbHMgPSA8MT47DQo+ID4gKwkJaW50ZXJydXB0cyA9IDxHSUNfU1BJIDQ5
IElSUV9UWVBFX0xFVkVMX0hJR0g+Ow0KPiA+ICsJCWludGVycnVwdC1tYXAtbWFzayA9IDwweDAw
IDAgMCA3PjsNCj4gPiArCQlpbnRlcnJ1cHQtbWFwID0gPDB4MDAwMCAwIDAgMSAmZ2ljIEdJQ19T
UEkgNDENCj4gPiBJUlFfVFlQRV9MRVZFTF9ISUdIPjsgLyogSU5UYSAqLw0KPiA+ICsJCXJhbmdl
cyA9IDwweDAyMDAwMDAwIDB4MCAweGMwMDEwMDAwIDB4MCAweGMwMDEwMDAwIDB4MA0KPiA+IDB4
MDdmZjAwMDA+Ow0KPiA+ICsJfTsNCj4gPiBkaWZmIC0tZ2l0IGEvTUFJTlRBSU5FUlMgYi9NQUlO
VEFJTkVSUw0KPiA+IGluZGV4IDVhNjEzN2RmM2YwZS4uMjljY2ExNGEwNWE2IDEwMDY0NA0KPiA+
IC0tLSBhL01BSU5UQUlORVJTDQo+ID4gKysrIGIvTUFJTlRBSU5FUlMNCj4gPiBAQCAtMTIyMDEs
MTAgKzEyMjAxLDExIEBAIFQ6CWdpdA0KPiA+IGdpdDovL2dpdC5rZXJuZWwub3JnL3B1Yi9zY20v
bGludXgva2VybmVsL2dpdC9scGllcmFsaXNpL3BjaS5naXQvDQo+ID4gIFM6CVN1cHBvcnRlZA0K
PiA+ICBGOglkcml2ZXJzL3BjaS9jb250cm9sbGVyLw0KPiA+ICANCj4gPiAtUENJRSBEUklWRVIg
Rk9SIEFOTkFQVVJOQSBMQUJTDQo+ID4gK1BDSUUgRFJJVkVSIEZPUiBBTUFaT04gQU5OQVBVUk5B
IExBQlMNCj4gPiAgTToJSm9uYXRoYW4gQ2hvY3JvbiA8am9ubnljQGFtYXpvbi5jb20+DQo+ID4g
IEw6CWxpbnV4LXBjaUB2Z2VyLmtlcm5lbC5vcmcNCj4gPiAgUzoJTWFpbnRhaW5lZA0KPiA+ICtG
OglEb2N1bWVudGF0aW9uL2RldmljZXRyZWUvYmluZGluZ3MvcGNpL3BjaWUtYWwudHh0DQo+ID4g
IEY6CWRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvZHdjL3BjaWUtYWwuYw0KPiA+ICANCj4gPiAgUENJ
RSBEUklWRVIgRk9SIEFNTE9HSUMgTUVTT04NCj4gPiAtLSANCj4gPiAyLjE3LjENCj4gPiANCg==
