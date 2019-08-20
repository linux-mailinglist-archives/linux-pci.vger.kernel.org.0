Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 0083F96302
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 16:52:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729260AbfHTOwg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 10:52:36 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:37585 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729155AbfHTOwg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 10:52:36 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566312754; x=1597848754;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=4RMdJ7g4RwqnmOdCpj3+2vRIufVWRdzPriy16h+7m+M=;
  b=s1IgUD9L3NlIp8TEiqMaa7HsObyN0DqcGTbkmnpXp6S/iI6pGHTxF0Ef
   sumuyRNnGRpktRWDQMByA0MFggmKa7ETbjVk5Vfv5+IkbspNnLq8FO+FP
   AWdzyrH6tCgq3r5ErYBWTnTapwgP/ATDFlgeYXveKQjLpznCypVgE8AHo
   E=;
X-IronPort-AV: E=Sophos;i="5.64,408,1559520000"; 
   d="scan'208";a="821673870"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-baacba05.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 20 Aug 2019 14:52:31 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-baacba05.us-west-2.amazon.com (Postfix) with ESMTPS id CF698A21AD;
        Tue, 20 Aug 2019 14:52:30 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 20 Aug 2019 14:52:30 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 20 Aug 2019 14:52:30 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Tue, 20 Aug 2019 14:52:30 +0000
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
Subject: Re: [PATCH v3 4/8] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Thread-Topic: [PATCH v3 4/8] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Thread-Index: AQHVQTimDPnKzgVgWUSS3N+Jgc+2EKcC9ACAgAFXUQA=
Date:   Tue, 20 Aug 2019 14:52:30 +0000
Message-ID: <5a079a466f74a866f1b17447eacb15d396478902.camel@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
         <20190723092529.11310-5-jonnyc@amazon.com>
         <20190819182339.GD23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190819182339.GD23903@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.160.245]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6E462D656BB32E4AB53CACA361AFD37D@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDE5LTA4LTE5IGF0IDE5OjIzICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBUdWUsIEp1bCAyMywgMjAxOSBhdCAxMjoyNToyOVBNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IFRoZSBSb290IFBvcnQgKGlkZW50aWZpZWQgYnkgWzFjMzY6MDAzMl0p
IGRvZXNuJ3Qgc3VwcG9ydCBNU0ktWC4gT24NCj4gPiBzb21lDQo+IA0KPiBTaG91bGRuJ3QgdGhp
cyByZWFkIFsxYzM2OjAwMzFdPw0KPiANCkluZGVlZC4gVGhhbmtzIGZvciBjYXRjaGluZyB0aGlz
Lg0KDQo+IA0KPiA+IHBsYXRmb3JtcyBpdCBpcyBjb25maWd1cmVkIHRvIG5vdCBhZHZlcnRpc2Ug
dGhlIGNhcGFiaWxpdHkgYXQgYWxsLA0KPiA+IHdoaWxlDQo+ID4gb24gb3RoZXJzIGl0IChtaXN0
YWtlbmx5KSBkb2VzLiBUaGlzIGNhdXNlcyBhIHBhbmljIGR1cmluZw0KPiA+IGluaXRpYWxpemF0
aW9uIGJ5IHRoZSBwY2llcG9ydCBkcml2ZXIsIHNpbmNlIGl0IHRyaWVzIHRvIGNvbmZpZ3VyZQ0K
PiA+IHRoZQ0KPiA+IE1TSS1YIGNhcGFiaWxpdHkuIFNwZWNpZmljYWxseSwgd2hlbiB0cnlpbmcg
dG8gYWNjZXNzIHRoZSBNU0ktWA0KPiA+IHRhYmxlDQo+ID4gYSAibm9uLWV4aXN0aW5nIGFkZHIi
IGV4Y2VwdGlvbiBvY2N1cnMuDQo+ID4gDQo+ID4gRXhhbXBsZSBzdGFja3RyYWNlIHNuaXBwZXQ6
DQo+ID4gDQo+ID4gWyAgICAxLjYzMjM2M10gU0Vycm9yIEludGVycnVwdCBvbiBDUFUyLCBjb2Rl
IDB4YmYwMDAwMDAgLS0gU0Vycm9yDQo+ID4gWyAgICAxLjYzMjM2NF0gQ1BVOiAyIFBJRDogMSBD
b21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNS4yLjAtcmMxLQ0KPiA+IEpvbm55LTE0ODQ3LWdl
NzZmMWQ0YTE4MjgtZGlydHkgIzMzDQo+ID4gWyAgICAxLjYzMjM2NV0gSGFyZHdhcmUgbmFtZTog
QW5uYXB1cm5hIExhYnMgQWxwaW5lIFYzIEVWUCAoRFQpDQo+ID4gWyAgICAxLjYzMjM2NV0gcHN0
YXRlOiA4MDAwMDAwNSAoTnpjdiBkYWlmIC1QQU4gLVVBTykNCj4gPiBbICAgIDEuNjMyMzY2XSBw
YyA6IF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKzB4NGU0LzB4NjA4DQo+ID4gWyAgICAxLjYzMjM2
N10gbHIgOiBfX3BjaV9lbmFibGVfbXNpeF9yYW5nZSsweDQ5OC8weDYwOA0KPiA+IFsgICAgMS42
MzIzNjddIHNwIDogZmZmZmZmODAxMTdkYjcwMA0KPiA+IFsgICAgMS42MzIzNjhdIHgyOTogZmZm
ZmZmODAxMTdkYjcwMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDENCj4gPiBbICAgIDEuNjMyMzcwXSB4
Mjc6IDAwMDAwMDAwMDAwMDAwMDEgeDI2OiAwMDAwMDAwMDAwMDAwMDAwDQo+ID4gWyAgICAxLjYz
MjM3Ml0geDI1OiBmZmZmZmZkM2U5ZDhjMGIwIHgyNDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsg
ICAgMS42MzIzNzNdIHgyMzogMDAwMDAwMDAwMDAwMDAwMCB4MjI6IDAwMDAwMDAwMDAwMDAwMDAN
Cj4gPiBbICAgIDEuNjMyMzc1XSB4MjE6IDAwMDAwMDAwMDAwMDAwMDEgeDIwOiAwMDAwMDAwMDAw
MDAwMDAwDQo+ID4gWyAgICAxLjYzMjM3Nl0geDE5OiBmZmZmZmZkM2U5ZDhjMDAwIHgxODogZmZm
ZmZmZmZmZmZmZmZmZg0KPiA+IFsgICAgMS42MzIzNzhdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4
MTY6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiBbICAgIDEuNjMyMzc5XSB4MTU6IGZmZmZmZjgwMTE2
NDk2YzggeDE0OiBmZmZmZmZkM2U5ODQ0NTAzDQo+ID4gWyAgICAxLjYzMjM4MF0geDEzOiBmZmZm
ZmZkM2U5ODQ0NTAyIHgxMjogMDAwMDAwMDAwMDAwMDAzOA0KPiA+IFsgICAgMS42MzIzODJdIHgx
MTogZmZmZmZmZmZmZmZmZmYwMCB4MTA6IDAwMDAwMDAwMDAwMDAwNDANCj4gPiBbICAgIDEuNjMy
Mzg0XSB4OSA6IGZmZmZmZjgwMTE2NWUyNzAgeDggOiBmZmZmZmY4MDExNjVlMjY4DQo+ID4gWyAg
ICAxLjYzMjM4NV0geDcgOiAwMDAwMDAwMDAwMDAwMDAyIHg2IDogMDAwMDAwMDAwMDAwMDBiMg0K
PiA+IFsgICAgMS42MzIzODddIHg1IDogZmZmZmZmZDNlOWQ4YzJjMCB4NCA6IDAwMDAwMDAwMDAw
MDAwMDANCj4gPiBbICAgIDEuNjMyMzg4XSB4MyA6IDAwMDAwMDAwMDAwMDAwMDAgeDIgOiAwMDAw
MDAwMDAwMDAwMDAwDQo+ID4gWyAgICAxLjYzMjM5MF0geDEgOiAwMDAwMDAwMDAwMDAwMDAwIHgw
IDogZmZmZmZmZDNlOTg0NDY4MA0KPiA+IFsgICAgMS42MzIzOTJdIEtlcm5lbCBwYW5pYyAtIG5v
dCBzeW5jaW5nOiBBc3luY2hyb25vdXMgU0Vycm9yDQo+ID4gSW50ZXJydXB0DQo+ID4gWyAgICAx
LjYzMjM5M10gQ1BVOiAyIFBJRDogMSBDb21tOiBzd2FwcGVyLzAgTm90IHRhaW50ZWQgNS4yLjAt
cmMxLQ0KPiA+IEpvbm55LTE0ODQ3LWdlNzZmMWQ0YTE4MjgtZGlydHkgIzMzDQo+ID4gWyAgICAx
LjYzMjM5NF0gSGFyZHdhcmUgbmFtZTogQW5uYXB1cm5hIExhYnMgQWxwaW5lIFYzIEVWUCAoRFQp
DQo+ID4gWyAgICAxLjYzMjM5NF0gQ2FsbCB0cmFjZToNCj4gPiBbICAgIDEuNjMyMzk1XSAgZHVt
cF9iYWNrdHJhY2UrMHgwLzB4MTQwDQo+ID4gWyAgICAxLjYzMjM5NV0gIHNob3dfc3RhY2srMHgx
NC8weDIwDQo+ID4gWyAgICAxLjYzMjM5Nl0gIGR1bXBfc3RhY2srMHhhOC8weGNjDQo+ID4gWyAg
ICAxLjYzMjM5Nl0gIHBhbmljKzB4MTQwLzB4MzM0DQo+ID4gWyAgICAxLjYzMjM5N10gIG5taV9w
YW5pYysweDZjLzB4NzANCj4gPiBbICAgIDEuNjMyMzk4XSAgYXJtNjRfc2Vycm9yX3BhbmljKzB4
NzQvMHg4OA0KPiA+IFsgICAgMS42MzIzOThdICBfX3B0ZV9lcnJvcisweDAvMHgyOA0KPiA+IFsg
ICAgMS42MzIzOTldICBlbDFfZXJyb3IrMHg4NC8weGY4DQo+ID4gWyAgICAxLjYzMjQwMF0gIF9f
cGNpX2VuYWJsZV9tc2l4X3JhbmdlKzB4NGU0LzB4NjA4DQo+ID4gWyAgICAxLjYzMjQwMF0gIHBj
aV9hbGxvY19pcnFfdmVjdG9yc19hZmZpbml0eSsweGRjLzB4MTUwDQo+ID4gWyAgICAxLjYzMjQw
MV0gIHBjaWVfcG9ydF9kZXZpY2VfcmVnaXN0ZXIrMHgyYjgvMHg0ZTANCj4gPiBbICAgIDEuNjMy
NDAyXSAgcGNpZV9wb3J0ZHJ2X3Byb2JlKzB4MzQvMHhmMA0KPiA+IA0KPiA+IFNpZ25lZC1vZmYt
Ynk6IEpvbmF0aGFuIENob2Nyb24gPGpvbm55Y0BhbWF6b24uY29tPg0KPiA+IFJldmlld2VkLWJ5
OiBHdXN0YXZvIFBpbWVudGVsIDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT4NCj4gPiAt
LS0NCj4gPiAgZHJpdmVycy9wY2kvcXVpcmtzLmMgfCAxNSArKysrKysrKysrKysrKysNCj4gPiAg
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEv
ZHJpdmVycy9wY2kvcXVpcmtzLmMgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPiA+IGluZGV4IDIz
NjcyNjgwZGJhNy4uMTFmODQzYWE5NmIzIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMvcGNpL3F1
aXJrcy5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gPiBAQCAtMjkyNSw2ICsy
OTI1LDIxIEBADQo+ID4gREVDTEFSRV9QQ0lfRklYVVBfRklOQUwoUENJX1ZFTkRPUl9JRF9BVFRB
TlNJQywgMHgxMGExLA0KPiA+ICAJCQlxdWlya19tc2lfaW50eF9kaXNhYmxlX3FjYV9idWcpOw0K
PiA+ICBERUNMQVJFX1BDSV9GSVhVUF9GSU5BTChQQ0lfVkVORE9SX0lEX0FUVEFOU0lDLCAweGUw
OTEsDQo+ID4gIAkJCXF1aXJrX21zaV9pbnR4X2Rpc2FibGVfcWNhX2J1Zyk7DQo+ID4gKw0KPiA+
ICsvKg0KPiA+ICsgKiBBbWF6b24ncyBBbm5hcHVybmEgTGFicyAxYzM2OjAwMzEgUm9vdCBQb3J0
cyBkb24ndCBzdXBwb3J0IE1TSS0NCj4gPiBYLCBzbyBpdA0KPiA+ICsgKiBzaG91bGQgYmUgZGlz
YWJsZWQgb24gcGxhdGZvcm1zIHdoZXJlIHRoZSBkZXZpY2UgKG1pc3Rha2VubHkpDQo+ID4gYWR2
ZXJ0aXNlcyBpdC4NCj4gPiArICoNCj4gPiArICogVGhlIDAwMzEgZGV2aWNlIGlkIGlzIHJldXNl
ZCBmb3Igb3RoZXIgbm9uIFJvb3QgUG9ydCBkZXZpY2UNCj4gPiB0eXBlcywNCj4gPiArICogdGhl
cmVmb3JlIHRoZSBxdWlyayBpcyByZWdpc3RlcmVkIGZvciB0aGUgUENJX0NMQVNTX0JSSURHRV9Q
Q0kNCj4gPiBjbGFzcy4NCj4gPiArICovDQo+ID4gK3N0YXRpYyB2b2lkIHF1aXJrX2FsX21zaV9k
aXNhYmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gK3sNCj4gPiArCWRldi0+bm9fbXNpID0g
MTsNCj4gPiArCXBjaV93YXJuKGRldiwgIkRpc2FibGluZyBNU0ktWFxuIik7DQo+IA0KPiBUaGlz
IHdpbGwgZGlzYWJsZSBib3RoIE1TSSBhbmQgTVNJLVggc3VwcG9ydCAtIGlzIHRoaXMgcmVhbGx5
IHRoZQ0KPiBpbnRlbnRpb24NCj4gaGVyZT8gRG8gdGhlIHJvb3QgcG9ydHMgc3VwcG9ydCBNU0kg
YW5kIGxlZ2FjeSwgb3IganVzdCBsZWdhY3k/DQo+IA0KVGhlIEhXIHNob3VsZCBzdXBwb3J0IE1T
SSwgYnV0IHdlIGN1cnJlbnRseSBkb24ndCBoYXZlIGEgdXNlIGNhc2UgZm9yDQppdCBzbyBpdCBo
YXNuJ3QgYmVlbiB0ZXN0ZWQgYW5kIHRoZXJlZm9yZSB3ZSBhcmUgb2theSB3aXRoIGRpc2FibGlu
Zw0KaXQuDQoNCkZvciBmdXR1cmUga25vd2xlZGdlLCBob3cgY2FuIGp1c3QgTVNJLVggYmUgZGlz
YWJsZWQ/DQpJIHNlZSB0aGF0IGluIHBjaWVfcG9ydF9lbmFibGVfaXJxX3ZlYygpLCB0aGUgcGNp
ZXBvcnQgZHJpdmVyIGNhbGxzDQpwY2lfYWxsb2NfaXJxX3ZlY3RvcnMoKSB3aXRoIFBDSV9JUlFf
TVNJWCB8IFBDSV9JUlFfTVNJLiBBbmQNCmludGVybmFsbHksIGJvdGggX19wY2lfZW5hYmxlX21z
aXhfcmFuZ2UoKSBhbmQgX19wY2lfZW5hYmxlX21zaV9yYW5nZSgpDQp1c2UgcGNpX21zaV9zdXBw
b3J0ZWQoKSB3aGljaCBkb2Vzbid0IGRpZmZlcmVudGlhdGUgYmV0d2VlbiBNU0kgYW5kDQpNU0kt
eC4NCg0KPiBUaGFua3MsDQo+IA0KPiBBbmRyZXcgTXVycmF5DQo+IA0KPiA+ICt9DQo+ID4gK0RF
Q0xBUkVfUENJX0ZJWFVQX0NMQVNTX0ZJTkFMKFBDSV9WRU5ET1JfSURfQU1BWk9OX0FOTkFQVVJO
QV9MQUJTLA0KPiA+IDB4MDAzMSwNCj4gPiArCQkJICAgICAgUENJX0NMQVNTX0JSSURHRV9QQ0ks
IDgsDQo+ID4gcXVpcmtfYWxfbXNpX2Rpc2FibGUpOw0KPiA+ICAjZW5kaWYgLyogQ09ORklHX1BD
SV9NU0kgKi8NCj4gPiAgDQo+ID4gIC8qDQo+ID4gLS0gDQo+ID4gMi4xNy4xDQo+ID4gDQo=
