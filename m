Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2A7B39670F
	for <lists+linux-pci@lfdr.de>; Tue, 20 Aug 2019 19:06:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726981AbfHTRGb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Aug 2019 13:06:31 -0400
Received: from smtp-fw-6001.amazon.com ([52.95.48.154]:64402 "EHLO
        smtp-fw-6001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725983AbfHTRGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 20 Aug 2019 13:06:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566320789; x=1597856789;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=YJjIocAV+IL9quJYWRpdUgSNThKwIjLU4ZEqaEMMnvs=;
  b=wAdH3h6KPsRQksGcPF1F9wteYFrDzo44mUToSKqckDQdPVPyQKYLQNnt
   P+aN9IO3ql4dO94ER+7QYG3MmCe09GfMVCEqYTBmwZI1Q/C8bjnSRdn0B
   OHauU6RK9vD8+5Oqqxli9xaTaVD6OUKtj07EuAWrPxrzmVQwsPXzJN97O
   I=;
X-IronPort-AV: E=Sophos;i="5.64,408,1559520000"; 
   d="scan'208";a="410508110"
Received: from iad6-co-svc-p1-lb1-vlan3.amazon.com (HELO email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com) ([10.124.125.6])
  by smtp-border-fw-out-6001.iad6.amazon.com with ESMTP; 20 Aug 2019 17:06:27 +0000
Received: from EX13MTAUWA001.ant.amazon.com (iad55-ws-svc-p15-lb9-vlan2.iad.amazon.com [10.40.159.162])
        by email-inbound-relay-1a-7d76a15f.us-east-1.amazon.com (Postfix) with ESMTPS id 3900BA2B56;
        Tue, 20 Aug 2019 17:06:23 +0000 (UTC)
Received: from EX13D13UWA002.ant.amazon.com (10.43.160.172) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.118) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 20 Aug 2019 17:06:23 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA002.ant.amazon.com (10.43.160.172) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Tue, 20 Aug 2019 17:06:23 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Tue, 20 Aug 2019 17:06:22 +0000
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
Thread-Index: AQHVQTimDPnKzgVgWUSS3N+Jgc+2EKcC9ACAgAFXUQCAAAlbgIAAHBCA
Date:   Tue, 20 Aug 2019 17:06:22 +0000
Message-ID: <87417da8ccea10b84c1a968700ef2ff783c751be.camel@amazon.com>
References: <20190723092529.11310-1-jonnyc@amazon.com>
         <20190723092529.11310-5-jonnyc@amazon.com>
         <20190819182339.GD23903@e119886-lin.cambridge.arm.com>
         <5a079a466f74a866f1b17447eacb15d396478902.camel@amazon.com>
         <20190820152554.GG23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190820152554.GG23903@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.137]
Content-Type: text/plain; charset="utf-8"
Content-ID: <7336197540915E45909FB7458801E810@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDE5LTA4LTIwIGF0IDE2OjI1ICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBUdWUsIEF1ZyAyMCwgMjAxOSBhdCAwMjo1MjozMFBNICswMDAwLCBDaG9jcm9uLCBKb25h
dGhhbiB3cm90ZToNCj4gPiBPbiBNb24sIDIwMTktMDgtMTkgYXQgMTk6MjMgKzAxMDAsIEFuZHJl
dyBNdXJyYXkgd3JvdGU6DQo+ID4gPiBPbiBUdWUsIEp1bCAyMywgMjAxOSBhdCAxMjoyNToyOVBN
ICswMzAwLCBKb25hdGhhbiBDaG9jcm9uIHdyb3RlOg0KPiA+ID4gPiBUaGUgUm9vdCBQb3J0IChp
ZGVudGlmaWVkIGJ5IFsxYzM2OjAwMzJdKSBkb2Vzbid0IHN1cHBvcnQgTVNJLQ0KPiA+ID4gPiBY
LiBPbg0KPiA+ID4gPiBzb21lDQo+ID4gPiANCj4gPiA+IFNob3VsZG4ndCB0aGlzIHJlYWQgWzFj
MzY6MDAzMV0/DQo+ID4gPiANCj4gPiANCj4gPiBJbmRlZWQuIFRoYW5rcyBmb3IgY2F0Y2hpbmcg
dGhpcy4NCj4gPiANCj4gPiA+IA0KPiA+ID4gPiBwbGF0Zm9ybXMgaXQgaXMgY29uZmlndXJlZCB0
byBub3QgYWR2ZXJ0aXNlIHRoZSBjYXBhYmlsaXR5IGF0DQo+ID4gPiA+IGFsbCwNCj4gPiA+ID4g
d2hpbGUNCj4gPiA+ID4gb24gb3RoZXJzIGl0IChtaXN0YWtlbmx5KSBkb2VzLiBUaGlzIGNhdXNl
cyBhIHBhbmljIGR1cmluZw0KPiA+ID4gPiBpbml0aWFsaXphdGlvbiBieSB0aGUgcGNpZXBvcnQg
ZHJpdmVyLCBzaW5jZSBpdCB0cmllcyB0bw0KPiA+ID4gPiBjb25maWd1cmUNCj4gPiA+ID4gdGhl
DQo+ID4gPiA+IE1TSS1YIGNhcGFiaWxpdHkuIFNwZWNpZmljYWxseSwgd2hlbiB0cnlpbmcgdG8g
YWNjZXNzIHRoZSBNU0ktWA0KPiA+ID4gPiB0YWJsZQ0KPiA+ID4gPiBhICJub24tZXhpc3Rpbmcg
YWRkciIgZXhjZXB0aW9uIG9jY3Vycy4NCj4gPiA+ID4gDQo+ID4gPiA+IEV4YW1wbGUgc3RhY2t0
cmFjZSBzbmlwcGV0Og0KPiA+ID4gPiANCj4gPiA+ID4gWyAgICAxLjYzMjM2M10gU0Vycm9yIElu
dGVycnVwdCBvbiBDUFUyLCBjb2RlIDB4YmYwMDAwMDAgLS0NCj4gPiA+ID4gU0Vycm9yDQo+ID4g
PiA+IFsgICAgMS42MzIzNjRdIENQVTogMiBQSUQ6IDEgQ29tbTogc3dhcHBlci8wIE5vdCB0YWlu
dGVkIDUuMi4wLQ0KPiA+ID4gPiByYzEtDQo+ID4gPiA+IEpvbm55LTE0ODQ3LWdlNzZmMWQ0YTE4
MjgtZGlydHkgIzMzDQo+ID4gPiA+IFsgICAgMS42MzIzNjVdIEhhcmR3YXJlIG5hbWU6IEFubmFw
dXJuYSBMYWJzIEFscGluZSBWMyBFVlAgKERUKQ0KPiA+ID4gPiBbICAgIDEuNjMyMzY1XSBwc3Rh
dGU6IDgwMDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPKQ0KPiA+ID4gPiBbICAgIDEuNjMyMzY2
XSBwYyA6IF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKzB4NGU0LzB4NjA4DQo+ID4gPiA+IFsgICAg
MS42MzIzNjddIGxyIDogX19wY2lfZW5hYmxlX21zaXhfcmFuZ2UrMHg0OTgvMHg2MDgNCj4gPiA+
ID4gWyAgICAxLjYzMjM2N10gc3AgOiBmZmZmZmY4MDExN2RiNzAwDQo+ID4gPiA+IFsgICAgMS42
MzIzNjhdIHgyOTogZmZmZmZmODAxMTdkYjcwMCB4Mjg6IDAwMDAwMDAwMDAwMDAwMDENCj4gPiA+
ID4gWyAgICAxLjYzMjM3MF0geDI3OiAwMDAwMDAwMDAwMDAwMDAxIHgyNjogMDAwMDAwMDAwMDAw
MDAwMA0KPiA+ID4gPiBbICAgIDEuNjMyMzcyXSB4MjU6IGZmZmZmZmQzZTlkOGMwYjAgeDI0OiAw
MDAwMDAwMDAwMDAwMDAwDQo+ID4gPiA+IFsgICAgMS42MzIzNzNdIHgyMzogMDAwMDAwMDAwMDAw
MDAwMCB4MjI6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiA+ID4gWyAgICAxLjYzMjM3NV0geDIxOiAw
MDAwMDAwMDAwMDAwMDAxIHgyMDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiBbICAgIDEuNjMy
Mzc2XSB4MTk6IGZmZmZmZmQzZTlkOGMwMDAgeDE4OiBmZmZmZmZmZmZmZmZmZmZmDQo+ID4gPiA+
IFsgICAgMS42MzIzNzhdIHgxNzogMDAwMDAwMDAwMDAwMDAwMCB4MTY6IDAwMDAwMDAwMDAwMDAw
MDANCj4gPiA+ID4gWyAgICAxLjYzMjM3OV0geDE1OiBmZmZmZmY4MDExNjQ5NmM4IHgxNDogZmZm
ZmZmZDNlOTg0NDUwMw0KPiA+ID4gPiBbICAgIDEuNjMyMzgwXSB4MTM6IGZmZmZmZmQzZTk4NDQ1
MDIgeDEyOiAwMDAwMDAwMDAwMDAwMDM4DQo+ID4gPiA+IFsgICAgMS42MzIzODJdIHgxMTogZmZm
ZmZmZmZmZmZmZmYwMCB4MTA6IDAwMDAwMDAwMDAwMDAwNDANCj4gPiA+ID4gWyAgICAxLjYzMjM4
NF0geDkgOiBmZmZmZmY4MDExNjVlMjcwIHg4IDogZmZmZmZmODAxMTY1ZTI2OA0KPiA+ID4gPiBb
ICAgIDEuNjMyMzg1XSB4NyA6IDAwMDAwMDAwMDAwMDAwMDIgeDYgOiAwMDAwMDAwMDAwMDAwMGIy
DQo+ID4gPiA+IFsgICAgMS42MzIzODddIHg1IDogZmZmZmZmZDNlOWQ4YzJjMCB4NCA6IDAwMDAw
MDAwMDAwMDAwMDANCj4gPiA+ID4gWyAgICAxLjYzMjM4OF0geDMgOiAwMDAwMDAwMDAwMDAwMDAw
IHgyIDogMDAwMDAwMDAwMDAwMDAwMA0KPiA+ID4gPiBbICAgIDEuNjMyMzkwXSB4MSA6IDAwMDAw
MDAwMDAwMDAwMDAgeDAgOiBmZmZmZmZkM2U5ODQ0NjgwDQo+ID4gPiA+IFsgICAgMS42MzIzOTJd
IEtlcm5lbCBwYW5pYyAtIG5vdCBzeW5jaW5nOiBBc3luY2hyb25vdXMgU0Vycm9yDQo+ID4gPiA+
IEludGVycnVwdA0KPiA+ID4gPiBbICAgIDEuNjMyMzkzXSBDUFU6IDIgUElEOiAxIENvbW06IHN3
YXBwZXIvMCBOb3QgdGFpbnRlZCA1LjIuMC0NCj4gPiA+ID4gcmMxLQ0KPiA+ID4gPiBKb25ueS0x
NDg0Ny1nZTc2ZjFkNGExODI4LWRpcnR5ICMzMw0KPiA+ID4gPiBbICAgIDEuNjMyMzk0XSBIYXJk
d2FyZSBuYW1lOiBBbm5hcHVybmEgTGFicyBBbHBpbmUgVjMgRVZQIChEVCkNCj4gPiA+ID4gWyAg
ICAxLjYzMjM5NF0gQ2FsbCB0cmFjZToNCj4gPiA+ID4gWyAgICAxLjYzMjM5NV0gIGR1bXBfYmFj
a3RyYWNlKzB4MC8weDE0MA0KPiA+ID4gPiBbICAgIDEuNjMyMzk1XSAgc2hvd19zdGFjaysweDE0
LzB4MjANCj4gPiA+ID4gWyAgICAxLjYzMjM5Nl0gIGR1bXBfc3RhY2srMHhhOC8weGNjDQo+ID4g
PiA+IFsgICAgMS42MzIzOTZdICBwYW5pYysweDE0MC8weDMzNA0KPiA+ID4gPiBbICAgIDEuNjMy
Mzk3XSAgbm1pX3BhbmljKzB4NmMvMHg3MA0KPiA+ID4gPiBbICAgIDEuNjMyMzk4XSAgYXJtNjRf
c2Vycm9yX3BhbmljKzB4NzQvMHg4OA0KPiA+ID4gPiBbICAgIDEuNjMyMzk4XSAgX19wdGVfZXJy
b3IrMHgwLzB4MjgNCj4gPiA+ID4gWyAgICAxLjYzMjM5OV0gIGVsMV9lcnJvcisweDg0LzB4ZjgN
Cj4gPiA+ID4gWyAgICAxLjYzMjQwMF0gIF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKzB4NGU0LzB4
NjA4DQo+ID4gPiA+IFsgICAgMS42MzI0MDBdICBwY2lfYWxsb2NfaXJxX3ZlY3RvcnNfYWZmaW5p
dHkrMHhkYy8weDE1MA0KPiA+ID4gPiBbICAgIDEuNjMyNDAxXSAgcGNpZV9wb3J0X2RldmljZV9y
ZWdpc3RlcisweDJiOC8weDRlMA0KPiA+ID4gPiBbICAgIDEuNjMyNDAyXSAgcGNpZV9wb3J0ZHJ2
X3Byb2JlKzB4MzQvMHhmMA0KPiA+ID4gPiANCj4gPiA+ID4gU2lnbmVkLW9mZi1ieTogSm9uYXRo
YW4gQ2hvY3JvbiA8am9ubnljQGFtYXpvbi5jb20+DQo+ID4gPiA+IFJldmlld2VkLWJ5OiBHdXN0
YXZvIFBpbWVudGVsIDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT4NCj4gPiA+ID4gLS0t
DQo+ID4gPiA+ICBkcml2ZXJzL3BjaS9xdWlya3MuYyB8IDE1ICsrKysrKysrKysrKysrKw0KPiA+
ID4gPiAgMSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKykNCj4gPiA+ID4gDQo+ID4gPiA+
IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9xdWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5j
DQo+ID4gPiA+IGluZGV4IDIzNjcyNjgwZGJhNy4uMTFmODQzYWE5NmIzIDEwMDY0NA0KPiA+ID4g
PiAtLS0gYS9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPiA+ID4gPiArKysgYi9kcml2ZXJzL3BjaS9x
dWlya3MuYw0KPiA+ID4gPiBAQCAtMjkyNSw2ICsyOTI1LDIxIEBADQo+ID4gPiA+IERFQ0xBUkVf
UENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRUQU5TSUMsIDB4MTBhMSwNCj4gPiA+ID4g
IAkJCXF1aXJrX21zaV9pbnR4X2Rpc2FibGVfcWNhX2J1Zyk7DQo+ID4gPiA+ICBERUNMQVJFX1BD
SV9GSVhVUF9GSU5BTChQQ0lfVkVORE9SX0lEX0FUVEFOU0lDLCAweGUwOTEsDQo+ID4gPiA+ICAJ
CQlxdWlya19tc2lfaW50eF9kaXNhYmxlX3FjYV9idWcpOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsv
Kg0KPiA+ID4gPiArICogQW1hem9uJ3MgQW5uYXB1cm5hIExhYnMgMWMzNjowMDMxIFJvb3QgUG9y
dHMgZG9uJ3Qgc3VwcG9ydA0KPiA+ID4gPiBNU0ktDQo+ID4gPiA+IFgsIHNvIGl0DQo+ID4gPiA+
ICsgKiBzaG91bGQgYmUgZGlzYWJsZWQgb24gcGxhdGZvcm1zIHdoZXJlIHRoZSBkZXZpY2UNCj4g
PiA+ID4gKG1pc3Rha2VubHkpDQo+ID4gPiA+IGFkdmVydGlzZXMgaXQuDQo+ID4gPiA+ICsgKg0K
PiA+ID4gPiArICogVGhlIDAwMzEgZGV2aWNlIGlkIGlzIHJldXNlZCBmb3Igb3RoZXIgbm9uIFJv
b3QgUG9ydCBkZXZpY2UNCj4gPiA+ID4gdHlwZXMsDQo+ID4gPiA+ICsgKiB0aGVyZWZvcmUgdGhl
IHF1aXJrIGlzIHJlZ2lzdGVyZWQgZm9yIHRoZQ0KPiA+ID4gPiBQQ0lfQ0xBU1NfQlJJREdFX1BD
SQ0KPiA+ID4gPiBjbGFzcy4NCj4gPiA+ID4gKyAqLw0KPiA+ID4gPiArc3RhdGljIHZvaWQgcXVp
cmtfYWxfbXNpX2Rpc2FibGUoc3RydWN0IHBjaV9kZXYgKmRldikNCj4gPiA+ID4gK3sNCj4gPiA+
ID4gKwlkZXYtPm5vX21zaSA9IDE7DQo+ID4gPiA+ICsJcGNpX3dhcm4oZGV2LCAiRGlzYWJsaW5n
IE1TSS1YXG4iKTsNCj4gPiA+IA0KPiA+ID4gVGhpcyB3aWxsIGRpc2FibGUgYm90aCBNU0kgYW5k
IE1TSS1YIHN1cHBvcnQgLSBpcyB0aGlzIHJlYWxseSB0aGUNCj4gPiA+IGludGVudGlvbg0KPiA+
ID4gaGVyZT8gRG8gdGhlIHJvb3QgcG9ydHMgc3VwcG9ydCBNU0kgYW5kIGxlZ2FjeSwgb3IganVz
dCBsZWdhY3k/DQo+ID4gPiANCj4gPiANCj4gPiBUaGUgSFcgc2hvdWxkIHN1cHBvcnQgTVNJLCBi
dXQgd2UgY3VycmVudGx5IGRvbid0IGhhdmUgYSB1c2UgY2FzZQ0KPiA+IGZvcg0KPiA+IGl0IHNv
IGl0IGhhc24ndCBiZWVuIHRlc3RlZCBhbmQgdGhlcmVmb3JlIHdlIGFyZSBva2F5IHdpdGgNCj4g
PiBkaXNhYmxpbmcNCj4gPiBpdC4NCj4gDQo+IE9LIC0gdGhlbiB0aGUgY29tbWl0IG1lc3NhZ2Ug
YW5kIGNvbW1lbnQgKGZvciBxdWlya19hbF9tc2lfZGlzYWJsZSkNCj4gc2hvdWxkDQo+IHByb2Jh
Ymx5IGJlIHVwZGF0ZWQgdG8gcmVmbGVjdCB0aGlzLiANCg0KSWYgeW91IG1lYW4gdGhhdCB3ZSBz
aG91bGQgZXhwbGljaXRseSBzdGF0ZSB0aGF0IE1TSSBpcyBwb3NzaWJseQ0Kc3VwcG9ydGVkIHRo
ZW4gSSBkb24ndCB0aGluayBpdCBpcyB2ZXJ5IHJlbGV2YW50IGhlcmUuIElmIHdlIGRlY2lkZSB0
bw0KdGVzdCBhbmQgZW5hYmxlIGl0IGluIHRoZSBmdXR1cmUsIHRoZW4gdGhlIG5ldyBxdWlyayAo
d2hpY2ggd291bGQgb25seQ0KZGlzYWJsZSBNU0kteCkgd291bGQgcmVmbGVjdCB0aGUgZmFjdCB0
aGF0IE1TSSB3b3Jrcy4gU291bmRzIG9rPw0KDQo+IEVzcGVjaWFsbHkgZ2l2ZW4gdGhhdCB0aGUg
ZGV2aWNlIGlkDQo+IG1heSBiZSB1c2VkIG9uIG90aGVyIGRldmljZSB0eXBlcyAtIGltcGx5aW5n
IHRoYXQgYSB1c2UtY2FzZSBmb3IgdGhpcw0KPiBtYXkgbGF0ZXIgYXJpc2UuDQo+IA0KTm90IHN1
cmUgSSB1bmRlcnN0b29kIHRoYXQgbGFzdCBsaW5lLiBUaGlzIHBhdGNoIGlzIHJlbGV2YW50IG9u
bHkgZm9yDQp0aGUgQlJJREdFIGNsYXNzIDB4MDAzMSBkZXZpY2UuIFRoZSBvdGhlciBkZXZpY2Ug
dHlwZXMsIHdoaWNoIChzYWRseSkNCmhhcHBlbiB0byByZS11c2UgdGhlIGRldl9pZCwgaGF2ZSBh
cmUgdG90YWxseSBkaWZmZXJlbnQgYW5kIHNob3VsZG4ndA0KYmUgbWl4ZWQgaW4gaGVyZS4NCg0K
PiA+IA0KPiA+IEZvciBmdXR1cmUga25vd2xlZGdlLCBob3cgY2FuIGp1c3QgTVNJLVggYmUgZGlz
YWJsZWQ/DQo+ID4gSSBzZWUgdGhhdCBpbiBwY2llX3BvcnRfZW5hYmxlX2lycV92ZWMoKSwgdGhl
IHBjaWVwb3J0IGRyaXZlciBjYWxscw0KPiA+IHBjaV9hbGxvY19pcnFfdmVjdG9ycygpIHdpdGgg
UENJX0lSUV9NU0lYIHwgUENJX0lSUV9NU0kuIEFuZA0KPiA+IGludGVybmFsbHksIGJvdGggX19w
Y2lfZW5hYmxlX21zaXhfcmFuZ2UoKSBhbmQNCj4gPiBfX3BjaV9lbmFibGVfbXNpX3JhbmdlKCkN
Cj4gPiB1c2UgcGNpX21zaV9zdXBwb3J0ZWQoKSB3aGljaCBkb2Vzbid0IGRpZmZlcmVudGlhdGUg
YmV0d2VlbiBNU0kgYW5kDQo+ID4gTVNJLXguDQo+IA0KPiBUaGUgZG9jdW1lbnRhdGlvbiBbMV0g
d291bGQgc3VnZ2VzdCB0aGF0IG9uY2UgdXBvbiBhIHRpbWUNCj4gcGNpX2Rpc2FibGVfbXNpeA0K
PiB3YXMgdXNlZCAtIGJ1dCBub3cgc2hvdWxkIGxldCBwY2lfYWxsb2NfaXJxX3ZlY3RvcnMgY2Fw
IHRoZSBtYXgNCj4gbnVtYmVyDQo+IG9mIHZlY3RvcnMuIEhvd2V2ZXIgaW4geW91ciBjYXNlIGl0
J3MgdGhlIFBDSWUgcG9ydCBkcml2ZXIgdGhhdCBpcw0KPiBhdHRlbXB0aW5nDQo+IHRvIGFsbG9j
YXRlIE1TSS1YJ3MgYW5kIHNvIHRoZSBzb2x1dGlvbiBpc24ndCBhbiBvYnZpb3VzIG9uZS4NCj4g
DQo+IFNldHRpbmcgZGV2LT5tc2l4X2VuYWJsZWQgdG8gZmFsc2UgKGkuZS4gdGhyb3VnaCBwY2lf
ZGlzYWJsZV9tc2l4KQ0KPiB3b3VsZA0KPiByZXN1bHQgaW4gYW4gdW4tbmVjZXNzYXJ5IFdBUk5f
T05fT05DRS4gDQoNClBlciBteSB1bmRlcnN0YW5kaW5nLCBpdCBzZWVtcyB0aGF0IGRldi0+bXNp
eF9lbmFibGVkIGluZGljYXRlcyBpZiB0aGUNCk1TSS1YIGNhcGFiaWxpdHkgaGFzIGFscmVhZHkg
YmVlbiBlbmFibGVkIG9yIG5vdCwgYW5kIG5vdCBhcyBhbg0KaW5kaWNhdGlvbiBpZiBpdCBpcyBz
dXBwb3J0ZWQgYnkgdGhlIGRldmljZS4gSWYgdGhhdCBpcyB0aGUgY2FzZSwgdGhlbg0Kbm90IHN1
cmUgcGNpX2Rpc2FibGVfbXNpeCgpIHdvdWxkIHJlc3VsdCBpbiB0aGUgZGVzaXJlZCBlZmZlY3Qu
DQoNCj4gSSB0aGluayB5b3UnZCBuZWVkIHRvIGVuc3VyZQ0KPiBkZXZpLT5tc2l4X2NhcCBpcyBO
VUxMICh3aGljaCBtYWtlcyBzZW5zZSBhcyB5b3VyIGhhcmR3YXJlIHNob3VsZG4ndA0KPiBiZQ0K
PiBleHBvc2luZyB0aGlzIGNhcGFiaWxpdHkpLg0KPiANCj4gSSBndWVzcyB0aGUgcmlnaHQgd2F5
IG9mIGFjaGlldmluZyB0aGlzIHdvdWxkIGJlIHRocm91Z2ggYSBxdWlyaywNCj4gdGhvdWdoIHlv
dSdkDQo+IGJlIHRoZSBmaXJzdCB0byBkbyB0aGlzIGFuZCB5b3UnZCBoYXZlIHRvIGVuc3VyZSB0
aGUgcXVpcmsgcnVucw0KPiBiZWZvcmUNCj4gYW55b25lIHRlc3RzIGZvciBtc2l4X2NhcC4NCj4g
DQo+IFRoYXQncyBteSB2aWV3LCB0aG91Z2ggb3RoZXJzIG1heSBoYXZlIGRpZmZlcmVudCBzdWdn
ZXN0aW9ucy4NCj4gDQpJIHRoaW5rIHRoYXQgbWF5YmUgYSBkZXYtPm5vX21zaXggZmllbGQgc2hv
dWxkIGJlIGFkZGVkIGFuZCB0aGVuIGENCmNvcnJlc3BvbmRpbmcgcGNpX21zaXhfc3VwcG9ydGVk
KCkgZnVuY3Rpb24gYXMgd2VsbC4gSSdkIGJlIGdsYWQgdG8NCnRha2UgaXQgb2ZmbGluZSBvciBv
biBhIGRlZGljYXRlZCB0aHJlYWQsIGJ1dCBpdCBzaG91bGRuJ3QgYmxvY2sgdGhpcw0KcGF0Y2hz
ZXQuDQoNCj4gWzFdIERvY3VtZW50YXRpb24vUENJL21zaS1ob3d0by5yc3QNCj4gDQo+IFRoYW5r
cywNCj4gDQo+IEFuZHJldyBNdXJyYXkNCj4gDQo+ID4gDQo+ID4gPiBUaGFua3MsDQo+ID4gPiAN
Cj4gPiA+IEFuZHJldyBNdXJyYXkNCj4gPiA+IA0KPiA+ID4gPiArfQ0KPiA+ID4gPiArREVDTEFS
RV9QQ0lfRklYVVBfQ0xBU1NfRklOQUwoUENJX1ZFTkRPUl9JRF9BTUFaT05fQU5OQVBVUk5BX0wN
Cj4gPiA+ID4gQUJTLA0KPiA+ID4gPiAweDAwMzEsDQo+ID4gPiA+ICsJCQkgICAgICBQQ0lfQ0xB
U1NfQlJJREdFX1BDSSwgOCwNCj4gPiA+ID4gcXVpcmtfYWxfbXNpX2Rpc2FibGUpOw0KPiA+ID4g
PiAgI2VuZGlmIC8qIENPTkZJR19QQ0lfTVNJICovDQo+ID4gPiA+ICANCj4gPiA+ID4gIC8qDQo+
ID4gPiA+IC0tIA0KPiA+ID4gPiAyLjE3LjENCj4gPiA+ID4gDQo=
