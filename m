Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 6264FB0021
	for <lists+linux-pci@lfdr.de>; Wed, 11 Sep 2019 17:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbfIKPeO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 11 Sep 2019 11:34:14 -0400
Received: from smtp-fw-33001.amazon.com ([207.171.190.10]:29999 "EHLO
        smtp-fw-33001.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726510AbfIKPeO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 11 Sep 2019 11:34:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1568216051; x=1599752051;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=WQXSQ0Cev8//CLvZS7s8tZJd4oNMkW+7xKPF+ie/BIo=;
  b=qYEsGesvs+FYy2n37zdxm3qINz4M4BJD5NifPioHRkdjDKbX1ZbgcHOL
   Lzh68YcppcywTRebyGy+02umPw2q5Lmi6RHF/aDumKf1hT1Rjq9hqbmH3
   JAFdw+O8Bv81PhwkkRIZbItEfIKFlv7XqkKTV1EPc3tlvTonTHZO7IR4r
   w=;
X-IronPort-AV: E=Sophos;i="5.64,493,1559520000"; 
   d="scan'208";a="830483508"
Received: from sea3-co-svc-lb6-vlan2.sea.amazon.com (HELO email-inbound-relay-2b-c300ac87.us-west-2.amazon.com) ([10.47.22.34])
  by smtp-border-fw-out-33001.sea14.amazon.com with ESMTP; 11 Sep 2019 15:34:07 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c300ac87.us-west-2.amazon.com (Postfix) with ESMTPS id BAB0BA2065;
        Wed, 11 Sep 2019 15:34:06 +0000 (UTC)
Received: from EX13D13UWA004.ant.amazon.com (10.43.160.251) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Sep 2019 15:34:06 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA004.ant.amazon.com (10.43.160.251) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Wed, 11 Sep 2019 15:34:05 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Wed, 11 Sep 2019 15:34:05 +0000
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
Subject: Re: [PATCH v5 4/7] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Thread-Topic: [PATCH v5 4/7] PCI: Add quirk to disable MSI-X support for
 Amazon's Annapurna Labs Root Port
Thread-Index: AQHVY/JaOBZaYJV9jkiI9qHnR5K48KcgckYAgAYyggA=
Date:   Wed, 11 Sep 2019 15:34:05 +0000
Message-ID: <78bffb5e8bc742010a57f82334b9f35dcb9faae4.camel@amazon.com>
References: <20190905140018.5139-1-jonnyc@amazon.com>
         <20190905140018.5139-5-jonnyc@amazon.com>
         <20190907165542.GN103977@google.com>
In-Reply-To: <20190907165542.GN103977@google.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.162.177]
Content-Type: text/plain; charset="utf-8"
Content-ID: <A9B365D9E9D4A84F8D9729300207CDFD@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU2F0LCAyMDE5LTA5LTA3IGF0IDExOjU1IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBzL0FkZCBxdWlyayB0byBkaXNhYmxlL0Rpc2FibGUvIGluIHN1YmplY3QNCj4gDQo+IE9uIFRo
dSwgU2VwIDA1LCAyMDE5IGF0IDA1OjAwOjE4UE0gKzAzMDAsIEpvbmF0aGFuIENob2Nyb24gd3Jv
dGU6DQo+ID4gVGhlIFJvb3QgUG9ydCAoaWRlbnRpZmllZCBieSBbMWMzNjowMDMxXSkgZG9lc24n
dCBzdXBwb3J0IE1TSS1YLiBPbg0KPiA+IHNvbWUNCj4gPiBwbGF0Zm9ybXMgaXQgaXMgY29uZmln
dXJlZCB0byBub3QgYWR2ZXJ0aXNlIHRoZSBjYXBhYmlsaXR5IGF0IGFsbCwNCj4gPiB3aGlsZQ0K
PiA+IG9uIG90aGVycyBpdCAobWlzdGFrZW5seSkgZG9lcy4gVGhpcyBjYXVzZXMgYSBwYW5pYyBk
dXJpbmcNCj4gPiBpbml0aWFsaXphdGlvbiBieSB0aGUgcGNpZXBvcnQgZHJpdmVyLCBzaW5jZSBp
dCB0cmllcyB0byBjb25maWd1cmUNCj4gPiB0aGUNCj4gPiBNU0ktWCBjYXBhYmlsaXR5LiBTcGVj
aWZpY2FsbHksIHdoZW4gdHJ5aW5nIHRvIGFjY2VzcyB0aGUgTVNJLVgNCj4gPiB0YWJsZQ0KPiA+
IGEgIm5vbi1leGlzdGluZyBhZGRyIiBleGNlcHRpb24gb2NjdXJzLg0KPiANCj4gTVNJLVggY29u
ZmlndXJhdGlvbiBpcyBhbGwgaW4gbWVtb3J5IHNwYWNlIChub3QgY29uZmlnIHNwYWNlKSwgc28g
SQ0KPiBndWVzcyB0aGlzIGRldmljZSBoYXMgYSBCQVIgKG1heWJlIG1vcmUpIGFuZCB0aGUgTVNJ
LVggdGFibGUgYWNjZXNzDQo+IHdvdWxkIGJlIHRvIHNvbWV0aGluZyBpbiB0aGF0IEJBUj8gIE9y
IGlzIHRoZXJlIGp1bmsgaW4gdGhlDQo+IGNhcGFiaWxpdHkNCj4gc28gd2UgdHJ5IHRvIGFjY2Vz
cyBzb21ldGhpbmcgY29tcGxldGVseSBvdXRzaWRlIHRoZSBCQVI/ICBbSSB3b25kZXINCj4gaWYN
Cj4gaXQnZCBiZSB3b3J0aCBhZGRpbmcgc29tZSB2YWxpZGF0aW9uIHRvIG1ha2Ugc3VyZSB0aGUg
VGFibGUgYW5kIFBCQQ0KPiBhcmVhcyBhcmUgY29udGFpbmVkIGluIHRoZSBCQVI/XQ0KPiANClRo
ZXJlIGlzIG5vIGFjdHVhbCBtZW1vcnkgYWxsb2NhdGVkIGZvciB0aGUgTVNJLVggdGFibGUgYmVo
aW5kIHRoZSBCQVIsDQpzbyBpdCBhdHRlbXB0cyB0byBhY2Nlc3Mgbm9uIGV4aXN0aW5nIHJlZ3Ms
IHJlc3VsdGluZyBpbiB0aGUgU0Vycm9yLg0KDQo+IFRoZSByZWFzb24gSSdtIGN1cmlvdXMgYWJv
dXQgYWxsIHRoaXMgaXMgYmVjYXVzZSBvbiB0aGUgUENJIHNpZGUgdGhpcw0KPiBpcyBwcm9iYWJs
eSBhbiBVbnN1cHBvcnRlZCBSZXF1ZXN0IG9yIHNpbWlsYXIgZXJyb3IsIGFuZCBvbiAqbW9zdCoN
Cj4gcGxhdGZvcm1zLCB0aGlzIGRvZXMgbm90IGNhdXNlIGEgcGFuaWMuICBJZiBpdCB3YXMgYSBy
ZWFkLCB0aGUgcmVhZA0KPiB1c3VhbGx5IGdldHMgfjAgZGF0YSwgYW5kIHdyaXRlcyBhcmUgZHJv
cHBlZC4NCj4gDQpJJ20gbm90IGVudGlyZWx5IHN1cmUgaG93IHRoaXMgaXMgaW1wbGVtZW50ZWQg
aW4gdGhlIEhXIChpLmUuIGFjY2Vzc2luZw0KdGhlIEhvc3QgY29udHJvbGxlcidzIG1lbW9yeSBz
cGFjZSksIGJ1dCBJIGFzc3VtZSB0aGF0IGFuIEFYSSBlcnJvcg0KcmV0dXJucywgd2hpY2ggdHJh
bnNsYXRlcyB0byB0aGUgU2Vycm9yLiBJIGNhbiB2ZXJpZnkgd2l0aCBvdXIgSFcNCmVuZ2luZWVy
cyBpZiB5b3UgdGhpbmsgaXQgaXMgYmxvY2tpbmcuDQoNCj4gU28gbXkgY29uY2VybiBpcyB0aGF0
IHdlJ2xsIGF2b2lkIHRoaXMgcGFuaWMgYnkgZGlzYWJsaW5nIE1TSSwgYnV0DQo+IHdlJ2xsIHNl
ZSBvdGhlciBwYW5pY3MgaW4gb3RoZXIgcGxhY2VzLg0KPiANCj4gPiBFeGFtcGxlIHN0YWNrdHJh
Y2Ugc25pcHBldDoNCj4gDQo+IFtSZW1vdmUgdGhlIHRpbWVzdGFtcHMgc2luY2UgdGhleSdyZSBu
b3QgcmVhbGx5IHJlbGV2YW50IGFuZCBpbmRlbnQNCj4gdGhlIHF1b3RlIGEgY291cGxlIHNwYWNl
c10NCj4gDQpBY2suDQoNCj4gPiBbICAgIDEuNjMyMzYzXSBTRXJyb3IgSW50ZXJydXB0IG9uIENQ
VTIsIGNvZGUgMHhiZjAwMDAwMCAtLSBTRXJyb3INCj4gPiBbICAgIDEuNjMyMzY0XSBDUFU6IDIg
UElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRlZCA1LjIuMC1yYzEtDQo+ID4gSm9ubnkt
MTQ4NDctZ2U3NmYxZDRhMTgyOC1kaXJ0eSAjMzMNCj4gPiBbICAgIDEuNjMyMzY1XSBIYXJkd2Fy
ZSBuYW1lOiBBbm5hcHVybmEgTGFicyBBbHBpbmUgVjMgRVZQIChEVCkNCj4gPiBbICAgIDEuNjMy
MzY1XSBwc3RhdGU6IDgwMDAwMDA1IChOemN2IGRhaWYgLVBBTiAtVUFPKQ0KPiA+IFsgICAgMS42
MzIzNjZdIHBjIDogX19wY2lfZW5hYmxlX21zaXhfcmFuZ2UrMHg0ZTQvMHg2MDgNCj4gPiBbICAg
IDEuNjMyMzY3XSBsciA6IF9fcGNpX2VuYWJsZV9tc2l4X3JhbmdlKzB4NDk4LzB4NjA4DQo+ID4g
WyAgICAxLjYzMjM2N10gc3AgOiBmZmZmZmY4MDExN2RiNzAwDQo+ID4gWyAgICAxLjYzMjM2OF0g
eDI5OiBmZmZmZmY4MDExN2RiNzAwIHgyODogMDAwMDAwMDAwMDAwMDAwMQ0KPiA+IFsgICAgMS42
MzIzNzBdIHgyNzogMDAwMDAwMDAwMDAwMDAwMSB4MjY6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiBb
ICAgIDEuNjMyMzcyXSB4MjU6IGZmZmZmZmQzZTlkOGMwYjAgeDI0OiAwMDAwMDAwMDAwMDAwMDAw
DQo+ID4gWyAgICAxLjYzMjM3M10geDIzOiAwMDAwMDAwMDAwMDAwMDAwIHgyMjogMDAwMDAwMDAw
MDAwMDAwMA0KPiA+IFsgICAgMS42MzIzNzVdIHgyMTogMDAwMDAwMDAwMDAwMDAwMSB4MjA6IDAw
MDAwMDAwMDAwMDAwMDANCj4gPiBbICAgIDEuNjMyMzc2XSB4MTk6IGZmZmZmZmQzZTlkOGMwMDAg
eDE4OiBmZmZmZmZmZmZmZmZmZmZmDQo+ID4gWyAgICAxLjYzMjM3OF0geDE3OiAwMDAwMDAwMDAw
MDAwMDAwIHgxNjogMDAwMDAwMDAwMDAwMDAwMA0KPiA+IFsgICAgMS42MzIzNzldIHgxNTogZmZm
ZmZmODAxMTY0OTZjOCB4MTQ6IGZmZmZmZmQzZTk4NDQ1MDMNCj4gPiBbICAgIDEuNjMyMzgwXSB4
MTM6IGZmZmZmZmQzZTk4NDQ1MDIgeDEyOiAwMDAwMDAwMDAwMDAwMDM4DQo+ID4gWyAgICAxLjYz
MjM4Ml0geDExOiBmZmZmZmZmZmZmZmZmZjAwIHgxMDogMDAwMDAwMDAwMDAwMDA0MA0KPiA+IFsg
ICAgMS42MzIzODRdIHg5IDogZmZmZmZmODAxMTY1ZTI3MCB4OCA6IGZmZmZmZjgwMTE2NWUyNjgN
Cj4gPiBbICAgIDEuNjMyMzg1XSB4NyA6IDAwMDAwMDAwMDAwMDAwMDIgeDYgOiAwMDAwMDAwMDAw
MDAwMGIyDQo+ID4gWyAgICAxLjYzMjM4N10geDUgOiBmZmZmZmZkM2U5ZDhjMmMwIHg0IDogMDAw
MDAwMDAwMDAwMDAwMA0KPiA+IFsgICAgMS42MzIzODhdIHgzIDogMDAwMDAwMDAwMDAwMDAwMCB4
MiA6IDAwMDAwMDAwMDAwMDAwMDANCj4gPiBbICAgIDEuNjMyMzkwXSB4MSA6IDAwMDAwMDAwMDAw
MDAwMDAgeDAgOiBmZmZmZmZkM2U5ODQ0NjgwDQo+ID4gWyAgICAxLjYzMjM5Ml0gS2VybmVsIHBh
bmljIC0gbm90IHN5bmNpbmc6IEFzeW5jaHJvbm91cyBTRXJyb3INCj4gPiBJbnRlcnJ1cHQNCj4g
PiBbICAgIDEuNjMyMzkzXSBDUFU6IDIgUElEOiAxIENvbW06IHN3YXBwZXIvMCBOb3QgdGFpbnRl
ZCA1LjIuMC1yYzEtDQo+ID4gSm9ubnktMTQ4NDctZ2U3NmYxZDRhMTgyOC1kaXJ0eSAjMzMNCj4g
PiBbICAgIDEuNjMyMzk0XSBIYXJkd2FyZSBuYW1lOiBBbm5hcHVybmEgTGFicyBBbHBpbmUgVjMg
RVZQIChEVCkNCj4gPiBbICAgIDEuNjMyMzk0XSBDYWxsIHRyYWNlOg0KPiA+IFsgICAgMS42MzIz
OTVdICBkdW1wX2JhY2t0cmFjZSsweDAvMHgxNDANCj4gPiBbICAgIDEuNjMyMzk1XSAgc2hvd19z
dGFjaysweDE0LzB4MjANCj4gPiBbICAgIDEuNjMyMzk2XSAgZHVtcF9zdGFjaysweGE4LzB4Y2MN
Cj4gPiBbICAgIDEuNjMyMzk2XSAgcGFuaWMrMHgxNDAvMHgzMzQNCj4gPiBbICAgIDEuNjMyMzk3
XSAgbm1pX3BhbmljKzB4NmMvMHg3MA0KPiA+IFsgICAgMS42MzIzOThdICBhcm02NF9zZXJyb3Jf
cGFuaWMrMHg3NC8weDg4DQo+ID4gWyAgICAxLjYzMjM5OF0gIF9fcHRlX2Vycm9yKzB4MC8weDI4
DQo+ID4gWyAgICAxLjYzMjM5OV0gIGVsMV9lcnJvcisweDg0LzB4ZjgNCj4gPiBbICAgIDEuNjMy
NDAwXSAgX19wY2lfZW5hYmxlX21zaXhfcmFuZ2UrMHg0ZTQvMHg2MDgNCj4gPiBbICAgIDEuNjMy
NDAwXSAgcGNpX2FsbG9jX2lycV92ZWN0b3JzX2FmZmluaXR5KzB4ZGMvMHgxNTANCj4gPiBbICAg
IDEuNjMyNDAxXSAgcGNpZV9wb3J0X2RldmljZV9yZWdpc3RlcisweDJiOC8weDRlMA0KPiA+IFsg
ICAgMS42MzI0MDJdICBwY2llX3BvcnRkcnZfcHJvYmUrMHgzNC8weGYwDQo+ID4gDQo+ID4gTm90
aWNlIHRoYXQgdGhpcyBxdWlyayBhbHNvIGRpc2FibGVzIE1TSSAod2hpY2ggbWF5IHdvcmssIGJ1
dA0KPiA+IGhhc24ndA0KPiA+IGJlZW4gdGVzdGVkIG5vciBoYXMgYSBjdXJyZW50IHVzZSBjYXNl
KSwgc2luY2UgY3VycmVudGx5IHRoZXJlIGlzDQo+ID4gbm8NCj4gPiBzdGFuZGFyZCB3YXkgdG8g
ZGlzYWJsZSBvbmx5IE1TSS1YLg0KPiA+IA0KPiA+IFNpZ25lZC1vZmYtYnk6IEpvbmF0aGFuIENo
b2Nyb24gPGpvbm55Y0BhbWF6b24uY29tPg0KPiA+IFJldmlld2VkLWJ5OiBHdXN0YXZvIFBpbWVu
dGVsIDxndXN0YXZvLnBpbWVudGVsQHN5bm9wc3lzLmNvbT4NCj4gPiBSZXZpZXdlZC1ieTogQW5k
cmV3IE11cnJheSA8YW5kcmV3Lm11cnJheUBhcm0uY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJz
L3BjaS9xdWlya3MuYyB8IDE4ICsrKysrKysrKysrKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdl
ZCwgMTggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9x
dWlya3MuYyBiL2RyaXZlcnMvcGNpL3F1aXJrcy5jDQo+ID4gaW5kZXggOGZlNzY1NTkyOTQzLi41
YThlYTVmZGVhZTcgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvcXVpcmtzLmMNCj4gPiAr
KysgYi9kcml2ZXJzL3BjaS9xdWlya3MuYw0KPiA+IEBAIC0yOTc3LDYgKzI5NzcsMjQgQEANCj4g
PiBERUNMQVJFX1BDSV9GSVhVUF9GSU5BTChQQ0lfVkVORE9SX0lEX0FUVEFOU0lDLCAweDEwYTEs
DQo+ID4gIAkJCXF1aXJrX21zaV9pbnR4X2Rpc2FibGVfcWNhX2J1Zyk7DQo+ID4gIERFQ0xBUkVf
UENJX0ZJWFVQX0ZJTkFMKFBDSV9WRU5ET1JfSURfQVRUQU5TSUMsIDB4ZTA5MSwNCj4gPiAgCQkJ
cXVpcmtfbXNpX2ludHhfZGlzYWJsZV9xY2FfYnVnKTsNCj4gPiArDQo+ID4gKy8qDQo+ID4gKyAq
IEFtYXpvbidzIEFubmFwdXJuYSBMYWJzIDFjMzY6MDAzMSBSb290IFBvcnRzIGRvbid0IHN1cHBv
cnQgTVNJLQ0KPiA+IFgsIHNvIGl0DQo+ID4gKyAqIHNob3VsZCBiZSBkaXNhYmxlZCBvbiBwbGF0
Zm9ybXMgd2hlcmUgdGhlIGRldmljZSAobWlzdGFrZW5seSkNCj4gPiBhZHZlcnRpc2VzIGl0Lg0K
PiA+ICsgKg0KPiA+ICsgKiBOb3RpY2UgdGhhdCB0aGlzIHF1aXJrIGFsc28gZGlzYWJsZXMgTVNJ
ICh3aGljaCBtYXkgd29yaywgYnV0DQo+ID4gaGFzbid0IGJlZW4NCj4gPiArICogdGVzdGVkKSwg
c2luY2UgY3VycmVudGx5IHRoZXJlIGlzIG5vIHN0YW5kYXJkIHdheSB0byBkaXNhYmxlDQo+ID4g
b25seSBNU0ktWC4NCj4gPiArICoNCj4gPiArICogVGhlIDAwMzEgZGV2aWNlIGlkIGlzIHJldXNl
ZCBmb3Igb3RoZXIgbm9uIFJvb3QgUG9ydCBkZXZpY2UNCj4gPiB0eXBlcywNCj4gPiArICogdGhl
cmVmb3JlIHRoZSBxdWlyayBpcyByZWdpc3RlcmVkIGZvciB0aGUgUENJX0NMQVNTX0JSSURHRV9Q
Q0kNCj4gPiBjbGFzcy4NCj4gPiArICovDQo+ID4gK3N0YXRpYyB2b2lkIHF1aXJrX2FsX21zaV9k
aXNhYmxlKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQo+ID4gK3sNCj4gPiArCWRldi0+bm9fbXNpID0g
MTsNCj4gPiArCXBjaV93YXJuKGRldiwgIkRpc2FibGluZyBNU0kvTVNJLVhcbiIpOw0KPiA+ICt9
DQo+ID4gK0RFQ0xBUkVfUENJX0ZJWFVQX0NMQVNTX0ZJTkFMKFBDSV9WRU5ET1JfSURfQU1BWk9O
X0FOTkFQVVJOQV9MQUJTLA0KPiA+IDB4MDAzMSwNCj4gPiArCQkJICAgICAgUENJX0NMQVNTX0JS
SURHRV9QQ0ksIDgsDQo+ID4gcXVpcmtfYWxfbXNpX2Rpc2FibGUpOw0KPiA+ICAjZW5kaWYgLyog
Q09ORklHX1BDSV9NU0kgKi8NCj4gPiAgDQo+ID4gIC8qDQo+ID4gLS0gDQo+ID4gMi4xNy4xDQo+
ID4gDQo=
