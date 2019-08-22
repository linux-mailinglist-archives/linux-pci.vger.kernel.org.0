Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3DD5499815
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2019 17:25:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726536AbfHVPXz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Aug 2019 11:23:55 -0400
Received: from smtp-fw-9102.amazon.com ([207.171.184.29]:9048 "EHLO
        smtp-fw-9102.amazon.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725886AbfHVPXz (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Aug 2019 11:23:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1566487432; x=1598023432;
  h=from:to:cc:subject:date:message-id:references:
   in-reply-to:content-id:content-transfer-encoding:
   mime-version;
  bh=vTTeBmE9is5bI/Ef1pR/ByokFJE5/K4HLq3q1H2eys8=;
  b=s+DdSOmlXhfzgM6P9g0Cw27qlGavA3x5388cL89UImpjp4DKs7FhzcHJ
   ZHiM6yuiMpWaxnObtZb7z8XhZbmIWIcwcPRATdLFbuT12661zPS/YfVrn
   PkXSE1O3zPolUiNQkU9//jOadR0sOdK22MqX2yGnAD+rsLEcD4z2yfLme
   4=;
X-IronPort-AV: E=Sophos;i="5.64,417,1559520000"; 
   d="scan'208";a="696502761"
Received: from sea3-co-svc-lb6-vlan3.sea.amazon.com (HELO email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com) ([10.47.22.38])
  by smtp-border-fw-out-9102.sea19.amazon.com with ESMTP; 22 Aug 2019 15:23:48 +0000
Received: from EX13MTAUWA001.ant.amazon.com (pdx4-ws-svc-p6-lb7-vlan2.pdx.amazon.com [10.170.41.162])
        by email-inbound-relay-2b-c7131dcf.us-west-2.amazon.com (Postfix) with ESMTPS id E4BACA1D48;
        Thu, 22 Aug 2019 15:23:47 +0000 (UTC)
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13MTAUWA001.ant.amazon.com (10.43.160.58) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 15:23:47 +0000
Received: from EX13D13UWA001.ant.amazon.com (10.43.160.136) by
 EX13D13UWA001.ant.amazon.com (10.43.160.136) with Microsoft SMTP Server (TLS)
 id 15.0.1367.3; Thu, 22 Aug 2019 15:23:47 +0000
Received: from EX13D13UWA001.ant.amazon.com ([10.43.160.136]) by
 EX13D13UWA001.ant.amazon.com ([10.43.160.136]) with mapi id 15.00.1367.000;
 Thu, 22 Aug 2019 15:23:47 +0000
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
Subject: Re: [PATCH v4 6/7] PCI: dwc: al: Add support for DW based driver type
Thread-Topic: [PATCH v4 6/7] PCI: dwc: al: Add support for DW based driver
 type
Thread-Index: AQHVWDfV1ZV7WCb/5U2zCcmAPf8ak6cG8HSAgABaRwA=
Date:   Thu, 22 Aug 2019 15:23:46 +0000
Message-ID: <85d34050b79730ad4922d81bb3741d0eaf54785d.camel@amazon.com>
References: <20190821153545.17635-1-jonnyc@amazon.com>
         <20190821154745.31834-2-jonnyc@amazon.com>
         <20190822100036.GM23903@e119886-lin.cambridge.arm.com>
In-Reply-To: <20190822100036.GM23903@e119886-lin.cambridge.arm.com>
Accept-Language: en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.43.161.243]
Content-Type: text/plain; charset="utf-8"
Content-ID: <6D97A77A3D69BD49872B5285218E79F2@amazon.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDE5LTA4LTIyIGF0IDExOjAwICswMTAwLCBBbmRyZXcgTXVycmF5IHdyb3RlOg0K
PiBPbiBXZWQsIEF1ZyAyMSwgMjAxOSBhdCAwNjo0Nzo0NFBNICswMzAwLCBKb25hdGhhbiBDaG9j
cm9uIHdyb3RlOg0KPiA+IFRoaXMgZHJpdmVyIGlzIERUIGJhc2VkIGFuZCB1dGlsaXplcyB0aGUg
RGVzaWduV2FyZSBBUElzLg0KPiA+IA0KPiA+IEl0IGFsbG93cyB1c2luZyBhIHNtYWxsZXIgRUNB
TSByYW5nZSBmb3IgYSBsYXJnZXIgYnVzIHJhbmdlIC0NCj4gPiB1c3VhbGx5IGFuIGVudGlyZSBi
dXMgdXNlcyAxTUIgb2YgYWRkcmVzcyBzcGFjZSwgYnV0IHRoZSBkcml2ZXINCj4gPiBjYW4gdXNl
IGl0IGZvciBhIGxhcmdlciBudW1iZXIgb2YgYnVzZXMuIFRoaXMgaXMgYWNoaWV2ZWQgYnkgdXNp
bmcNCj4gPiBhIEhXDQo+ID4gbWVjaGFuaXNtIHdoaWNoIGFsbG93cyBjaGFuZ2luZyB0aGUgQlVT
IHBhcnQgb2YgdGhlICJmaW5hbCINCj4gPiBvdXRnb2luZw0KPiA+IGNvbmZpZyB0cmFuc2FjdGlv
bi4gVGhlcmUgYXJlIDIgSFcgcmVncywgb25lIHdoaWNoIGlzIGJhc2ljYWxseSBhDQo+ID4gYml0
bWFzayBkZXRlcm1pbmluZyB3aGljaCBiaXRzIHRvIHRha2UgZnJvbSB0aGUgQVhJIHRyYW5zYWN0
aW9uDQo+ID4gaXRzZWxmDQo+ID4gYW5kIGFub3RoZXIgd2hpY2ggaG9sZHMgdGhlIGNvbXBsZW1l
bnRhcnkgcGFydCBwcm9ncmFtbWVkIGJ5IHRoZQ0KPiA+IGRyaXZlci4NCj4gPiANCj4gPiBBbGwg
bGluayBpbml0aWFsaXphdGlvbnMgYXJlIGhhbmRsZWQgYnkgdGhlIGJvb3QgRlcuDQo+ID4gDQo+
ID4gU2lnbmVkLW9mZi1ieTogSm9uYXRoYW4gQ2hvY3JvbiA8am9ubnljQGFtYXpvbi5jb20+DQo+
ID4gUmV2aWV3ZWQtYnk6IEd1c3Rhdm8gUGltZW50ZWwgPGd1c3Rhdm8ucGltZW50ZWxAc3lub3Bz
eXMuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9LY29uZmln
ICAgfCAgMTIgKw0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFsLmMgfCAz
NjUNCj4gPiArKysrKysrKysrKysrKysrKysrKysrKysrKysNCj4gPiAgMiBmaWxlcyBjaGFuZ2Vk
LCAzNzcgaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9LY29uZmlnDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9L
Y29uZmlnDQo+ID4gaW5kZXggNmVhNzc4YWU0ODc3Li4zYzYwOTRjYmNjM2IgMTAwNjQ0DQo+ID4g
LS0tIGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2MvS2NvbmZpZw0KPiA+ICsrKyBiL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvZHdjL0tjb25maWcNCj4gPiBAQCAtMjMwLDQgKzIzMCwxNiBAQCBj
b25maWcgUENJRV9VTklQSElFUg0KPiA+ICAJICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IFBDSWUg
Y29udHJvbGxlciBzdXBwb3J0IG9uIFVuaVBoaWVyDQo+ID4gU29Dcy4NCj4gPiAgCSAgVGhpcyBk
cml2ZXIgc3VwcG9ydHMgTEQyMCBhbmQgUFhzMyBTb0NzLg0KPiA+ICANCj4gPiArY29uZmlnIFBD
SUVfQUwNCj4gPiArCWJvb2wgIkFtYXpvbiBBbm5hcHVybmEgTGFicyBQQ0llIGNvbnRyb2xsZXIi
DQo+ID4gKwlkZXBlbmRzIG9uIE9GICYmIChBUk02NCB8fCBDT01QSUxFX1RFU1QpDQo+ID4gKwlk
ZXBlbmRzIG9uIFBDSV9NU0lfSVJRX0RPTUFJTg0KPiA+ICsJc2VsZWN0IFBDSUVfRFdfSE9TVA0K
PiA+ICsJaGVscA0KPiA+ICsJICBTYXkgWSBoZXJlIHRvIGVuYWJsZSBzdXBwb3J0IG9mIHRoZSBB
bWF6b24ncyBBbm5hcHVybmEgTGFicw0KPiA+IFBDSWUNCj4gPiArCSAgY29udHJvbGxlciBJUCBv
biBBbWF6b24gU29Dcy4gVGhlIFBDSWUgY29udHJvbGxlciB1c2VzIHRoZQ0KPiA+IERlc2lnbldh
cmUNCj4gPiArCSAgY29yZSBwbHVzIEFubmFwdXJuYSBMYWJzIHByb3ByaWV0YXJ5IGhhcmR3YXJl
IHdyYXBwZXJzLiBUaGlzDQo+ID4gaXMNCj4gPiArCSAgcmVxdWlyZWQgb25seSBmb3IgRFQtYmFz
ZWQgcGxhdGZvcm1zLiBBQ1BJIHBsYXRmb3JtcyB3aXRoIHRoZQ0KPiA+ICsJICBBbm5hcHVybmEg
TGFicyBQQ0llIGNvbnRyb2xsZXIgZG9uJ3QgbmVlZCB0byBlbmFibGUgdGhpcy4NCj4gPiArDQo+
ID4gIGVuZG1lbnUNCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9kd2Mv
cGNpZS1hbC5jDQo+ID4gYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFsLmMNCj4g
PiBpbmRleCAzYWI1OGYwNTg0YTguLjFlZWRhMmY2MzcxZiAxMDA2NDQNCj4gPiAtLS0gYS9kcml2
ZXJzL3BjaS9jb250cm9sbGVyL2R3Yy9wY2llLWFsLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL2R3Yy9wY2llLWFsLmMNCj4gPiBAQCAtOTEsMyArOTEsMzY4IEBAIHN0cnVjdCBw
Y2lfZWNhbV9vcHMgYWxfcGNpZV9vcHMgPSB7DQo+ID4gIH07DQo+ID4gIA0KPiA+ICAjZW5kaWYg
LyogZGVmaW5lZChDT05GSUdfQUNQSSkgJiYgZGVmaW5lZChDT05GSUdfUENJX1FVSVJLUykgKi8N
Cj4gPiArDQo+ID4gKyNpZmRlZiBDT05GSUdfUENJRV9BTA0KPiA+ICsNCj4gPiArI2luY2x1ZGUg
PGxpbnV4L29mX3BjaS5oPg0KPiA+ICsjaW5jbHVkZSAicGNpZS1kZXNpZ253YXJlLmgiDQo+ID4g
Kw0KPiA+ICsjZGVmaW5lIEFMX1BDSUVfUkVWX0lEXzIJMg0KPiA+ICsjZGVmaW5lIEFMX1BDSUVf
UkVWX0lEXzMJMw0KPiA+ICsjZGVmaW5lIEFMX1BDSUVfUkVWX0lEXzQJNA0KPiA+ICsNCj4gPiAr
I2RlZmluZSBBWElfQkFTRV9PRkZTRVQJCTB4MA0KPiANCj4gSXMgdGhpcyByZWFsbHkgbmVlZGVk
PyBJdCBjbGVhbmx5IGRlc2NyaWJlcyBob3cgdGhlIGhhcmR3YXJlIGlzDQo+IGNvbXBvc2VkIGJ1
dA0KPiBnaXZlbiB0aGF0IGl0J3MgMCBhbmQgd2lsbCBhbHdheXMgYmUgMCwgaXQgc2VlbXMgdG8g
YWRkIHNvbWUgYmxvYXQuDQo+IA0KSSB0aGluayB0aGF0IGl0J3MgYmV0dGVyIHRvIGhhdmUgaXQg
c3BlbGxlZCBvdXQgY2xlYXJseSwgYm90aCBmb3INCmZ1dHVyZSBkZXZlbG9wZXJzIGFuZCBpbiB0
aGUgY2FzZSB3ZSBtaWdodCBuZWVkIHRvIGFjY2VzcyBvdGhlciByZWdpb25zDQpvZiB0aGUgY29u
dHJvbGxlciBpbiB0aGUgZnV0dXJlLg0KDQo+ID4gKw0KPiA+ICsjZGVmaW5lIERFVklDRV9JRF9P
RkZTRVQJMHgxNmMNCj4gPiArDQo+ID4gKyNkZWZpbmUgREVWSUNFX1JFVl9JRAkJCTB4MA0KPiA+
ICsjZGVmaW5lIERFVklDRV9SRVZfSURfREVWX0lEX01BU0sJR0VOTUFTSygzMSwgMTYpDQo+ID4g
Kw0KPiA+ICsjZGVmaW5lIERFVklDRV9SRVZfSURfREVWX0lEX1g0CQkwDQo+ID4gKyNkZWZpbmUg
REVWSUNFX1JFVl9JRF9ERVZfSURfWDgJCTINCj4gPiArI2RlZmluZSBERVZJQ0VfUkVWX0lEX0RF
Vl9JRF9YMTYJNA0KPiA+ICsNCj4gPiArI2RlZmluZSBPQl9DVFJMX1JFVjFfMl9PRkZTRVQJMHgw
MDQwDQo+ID4gKyNkZWZpbmUgT0JfQ1RSTF9SRVYzXzVfT0ZGU0VUCTB4MDAzMA0KPiA+ICsNCj4g
PiArI2RlZmluZSBDRkdfVEFSR0VUX0JVUwkJCTB4MA0KPiA+ICsjZGVmaW5lIENGR19UQVJHRVRf
QlVTX01BU0tfTUFTSwlHRU5NQVNLKDcsIDApDQo+ID4gKyNkZWZpbmUgQ0ZHX1RBUkdFVF9CVVNf
QlVTTlVNX01BU0sJR0VOTUFTSygxNSwgOCkNCj4gPiArDQo+ID4gKyNkZWZpbmUgQ0ZHX0NPTlRS
T0wJCQkweDQNCj4gPiArI2RlZmluZSBDRkdfQ09OVFJPTF9TVUJCVVNfTUFTSwkJR0VOTUFTSygx
NSwgOCkNCj4gPiArI2RlZmluZSBDRkdfQ09OVFJPTF9TRUNfQlVTX01BU0sJR0VOTUFTSygyMywg
MTYpDQo+ID4gKw0KPiA+ICtzdHJ1Y3QgYWxfcGNpZV9yZWdfb2Zmc2V0cyB7DQo+ID4gKwl1bnNp
Z25lZCBpbnQgb2JfY3RybDsNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBhbF9wY2llX3Rh
cmdldF9idXNfY2ZnIHsNCj4gPiArCXU4IHJlZ192YWw7DQo+ID4gKwl1OCByZWdfbWFzazsNCj4g
PiArCXU4IGVjYW1fbWFzazsNCj4gPiArfTsNCj4gPiArDQo+ID4gK3N0cnVjdCBhbF9wY2llIHsN
Cj4gPiArCXN0cnVjdCBkd19wY2llICpwY2k7DQo+ID4gKwl2b2lkIF9faW9tZW0gKmNvbnRyb2xs
ZXJfYmFzZTsgLyogYmFzZSBvZiBQQ0llIHVuaXQgKG5vdCBEVw0KPiA+IGNvcmUpICovDQo+ID4g
KwlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gKwlyZXNvdXJjZV9zaXplX3QgZWNhbV9zaXplOw0K
PiA+ICsJdW5zaWduZWQgaW50IGNvbnRyb2xsZXJfcmV2X2lkOw0KPiA+ICsJc3RydWN0IGFsX3Bj
aWVfcmVnX29mZnNldHMgcmVnX29mZnNldHM7DQo+ID4gKwlzdHJ1Y3QgYWxfcGNpZV90YXJnZXRf
YnVzX2NmZyB0YXJnZXRfYnVzX2NmZzsNCj4gPiArfTsNCj4gPiArDQo+ID4gKyNkZWZpbmUgUENJ
RV9FQ0FNX0RFVkZOKHgpCQkoKCh4KSAmIDB4ZmYpIDw8IDEyKQ0KPiA+ICsNCj4gPiArI2RlZmlu
ZSB0b19hbF9wY2llKHgpCQlkZXZfZ2V0X2RydmRhdGEoKHgpLT5kZXYpDQo+ID4gKw0KPiA+ICtz
dGF0aWMgaW5saW5lIHUzMiBhbF9wY2llX2NvbnRyb2xsZXJfcmVhZGwoc3RydWN0IGFsX3BjaWUg
KnBjaWUsDQo+ID4gdTMyIG9mZnNldCkNCj4gPiArew0KPiA+ICsJcmV0dXJuIHJlYWRsX3JlbGF4
ZWQocGNpZS0+Y29udHJvbGxlcl9iYXNlICsgb2Zmc2V0KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiAr
c3RhdGljIGlubGluZSB2b2lkIGFsX3BjaWVfY29udHJvbGxlcl93cml0ZWwoc3RydWN0IGFsX3Bj
aWUgKnBjaWUsDQo+ID4gdTMyIG9mZnNldCwNCj4gPiArCQkJCQkgICAgIHUzMiB2YWwpDQo+ID4g
K3sNCj4gPiArCXdyaXRlbF9yZWxheGVkKHZhbCwgcGNpZS0+Y29udHJvbGxlcl9iYXNlICsgb2Zm
c2V0KTsNCj4gPiArfQ0KPiA+ICsNCj4gPiArc3RhdGljIGludCBhbF9wY2llX3Jldl9pZF9nZXQo
c3RydWN0IGFsX3BjaWUgKnBjaWUsIHVuc2lnbmVkIGludA0KPiA+ICpyZXZfaWQpDQo+ID4gK3sN
Cj4gPiArCXUzMiBkZXZfcmV2X2lkX3ZhbDsNCj4gPiArCXUzMiBkZXZfaWRfdmFsOw0KPiA+ICsN
Cj4gPiArCWRldl9yZXZfaWRfdmFsID0gYWxfcGNpZV9jb250cm9sbGVyX3JlYWRsKHBjaWUsIEFY
SV9CQVNFX09GRlNFVA0KPiA+ICsNCj4gPiArCQkJCQkJICBERVZJQ0VfSURfT0ZGU0VUICsNCj4g
PiArCQkJCQkJICBERVZJQ0VfUkVWX0lEKTsNCj4gPiArCWRldl9pZF92YWwgPSBGSUVMRF9HRVQo
REVWSUNFX1JFVl9JRF9ERVZfSURfTUFTSywNCj4gPiBkZXZfcmV2X2lkX3ZhbCk7DQo+ID4gKw0K
PiA+ICsJc3dpdGNoIChkZXZfaWRfdmFsKSB7DQo+ID4gKwljYXNlIERFVklDRV9SRVZfSURfREVW
X0lEX1g0Og0KPiA+ICsJCSpyZXZfaWQgPSBBTF9QQ0lFX1JFVl9JRF8yOw0KPiA+ICsJCWJyZWFr
Ow0KPiA+ICsJY2FzZSBERVZJQ0VfUkVWX0lEX0RFVl9JRF9YODoNCj4gPiArCQkqcmV2X2lkID0g
QUxfUENJRV9SRVZfSURfMzsNCj4gPiArCQlicmVhazsNCj4gPiArCWNhc2UgREVWSUNFX1JFVl9J
RF9ERVZfSURfWDE2Og0KPiA+ICsJCSpyZXZfaWQgPSBBTF9QQ0lFX1JFVl9JRF80Ow0KPiA+ICsJ
CWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlkZXZfZXJyKHBjaWUtPmRldiwgIlVuc3Vw
cG9ydGVkIGRldl9pZF92YWwgKDB4JXgpXG4iLA0KPiA+ICsJCQlkZXZfaWRfdmFsKTsNCj4gPiAr
CQlyZXR1cm4gLUVJTlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlkZXZfZGJnKHBjaWUtPmRl
diwgImRldl9pZF92YWw6IDB4JXhcbiIsIGRldl9pZF92YWwpOw0KPiA+ICsNCj4gPiArCXJldHVy
biAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFsX3BjaWVfcmVnX29mZnNldHNf
c2V0KHN0cnVjdCBhbF9wY2llICpwY2llKQ0KPiA+ICt7DQo+ID4gKwlzd2l0Y2ggKHBjaWUtPmNv
bnRyb2xsZXJfcmV2X2lkKSB7DQo+ID4gKwljYXNlIEFMX1BDSUVfUkVWX0lEXzI6DQo+ID4gKwkJ
cGNpZS0+cmVnX29mZnNldHMub2JfY3RybCA9IE9CX0NUUkxfUkVWMV8yX09GRlNFVDsNCj4gPiAr
CQlicmVhazsNCj4gPiArCWNhc2UgQUxfUENJRV9SRVZfSURfMzoNCj4gPiArCWNhc2UgQUxfUENJ
RV9SRVZfSURfNDoNCj4gPiArCQlwY2llLT5yZWdfb2Zmc2V0cy5vYl9jdHJsID0gT0JfQ1RSTF9S
RVYzXzVfT0ZGU0VUOw0KPiA+ICsJCWJyZWFrOw0KPiA+ICsJZGVmYXVsdDoNCj4gPiArCQlkZXZf
ZXJyKHBjaWUtPmRldiwgIlVuc3VwcG9ydGVkIGNvbnRyb2xsZXIgcmV2X2lkOg0KPiA+IDB4JXhc
biIsDQo+ID4gKwkJCXBjaWUtPmNvbnRyb2xsZXJfcmV2X2lkKTsNCj4gPiArCQlyZXR1cm4gLUVJ
TlZBTDsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlyZXR1cm4gMDsNCj4gPiArfQ0KPiA+ICsNCj4g
PiArc3RhdGljIGlubGluZSB2b2lkIGFsX3BjaWVfdGFyZ2V0X2J1c19zZXQoc3RydWN0IGFsX3Bj
aWUgKnBjaWUsDQo+ID4gKwkJCQkJICB1OCB0YXJnZXRfYnVzLA0KPiA+ICsJCQkJCSAgdTggbWFz
a190YXJnZXRfYnVzKQ0KPiA+ICt7DQo+ID4gKwl1MzIgcmVnOw0KPiA+ICsNCj4gPiArCXJlZyA9
IEZJRUxEX1BSRVAoQ0ZHX1RBUkdFVF9CVVNfTUFTS19NQVNLLCBtYXNrX3RhcmdldF9idXMpIHwN
Cj4gPiArCSAgICAgIEZJRUxEX1BSRVAoQ0ZHX1RBUkdFVF9CVVNfQlVTTlVNX01BU0ssIHRhcmdl
dF9idXMpOw0KPiA+ICsNCj4gPiArCWFsX3BjaWVfY29udHJvbGxlcl93cml0ZWwocGNpZSwgQVhJ
X0JBU0VfT0ZGU0VUICsNCj4gPiArCQkJCSAgcGNpZS0+cmVnX29mZnNldHMub2JfY3RybCArDQo+
ID4gQ0ZHX1RBUkdFVF9CVVMsDQo+ID4gKwkJCQkgIHJlZyk7DQo+ID4gK30NCj4gPiArDQo+ID4g
K3N0YXRpYyB2b2lkIF9faW9tZW0gKmFsX3BjaWVfY29uZl9hZGRyX21hcChzdHJ1Y3QgYWxfcGNp
ZSAqcGNpZSwNCj4gPiArCQkJCQkgICB1bnNpZ25lZCBpbnQgYnVzbnIsDQo+ID4gKwkJCQkJICAg
dW5zaWduZWQgaW50IGRldmZuKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgYWxfcGNpZV90YXJnZXRf
YnVzX2NmZyAqdGFyZ2V0X2J1c19jZmcgPSAmcGNpZS0NCj4gPiA+dGFyZ2V0X2J1c19jZmc7DQo+
ID4gKwl1bnNpZ25lZCBpbnQgYnVzbnJfZWNhbSA9IGJ1c25yICYgdGFyZ2V0X2J1c19jZmctPmVj
YW1fbWFzazsNCj4gPiArCXVuc2lnbmVkIGludCBidXNucl9yZWcgPSBidXNuciAmIHRhcmdldF9i
dXNfY2ZnLT5yZWdfbWFzazsNCj4gPiArCXN0cnVjdCBwY2llX3BvcnQgKnBwID0gJnBjaWUtPnBj
aS0+cHA7DQo+ID4gKwl2b2lkIF9faW9tZW0gKnBjaV9iYXNlX2FkZHI7DQo+ID4gKw0KPiA+ICsJ
cGNpX2Jhc2VfYWRkciA9ICh2b2lkIF9faW9tZW0gKikoKHVpbnRwdHJfdClwcC0+dmFfY2ZnMF9i
YXNlICsNCj4gPiArCQkJCQkgKGJ1c25yX2VjYW0gPDwgMjApICsNCj4gPiArCQkJCQkgUENJRV9F
Q0FNX0RFVkZOKGRldmZuKSk7DQo+ID4gKw0KPiA+ICsJaWYgKGJ1c25yX3JlZyAhPSB0YXJnZXRf
YnVzX2NmZy0+cmVnX3ZhbCkgew0KPiA+ICsJCWRldl9kYmcocGNpZS0+cGNpLT5kZXYsICJDaGFu
Z2luZyB0YXJnZXQgYnVzIGJ1c251bSB2YWwNCj4gPiBmcm9tIDB4JXggdG8gMHgleFxuIiwNCj4g
PiArCQkJdGFyZ2V0X2J1c19jZmctPnJlZ192YWwsIGJ1c25yX3JlZyk7DQo+ID4gKwkJdGFyZ2V0
X2J1c19jZmctPnJlZ192YWwgPSBidXNucl9yZWc7DQo+ID4gKwkJYWxfcGNpZV90YXJnZXRfYnVz
X3NldChwY2llLA0KPiA+ICsJCQkJICAgICAgIHRhcmdldF9idXNfY2ZnLT5yZWdfdmFsLA0KPiA+
ICsJCQkJICAgICAgIHRhcmdldF9idXNfY2ZnLT5yZWdfbWFzayk7DQo+ID4gKwl9DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIHBjaV9iYXNlX2FkZHI7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBp
bnQgYWxfcGNpZV9yZF9vdGhlcl9jb25mKHN0cnVjdCBwY2llX3BvcnQgKnBwLCBzdHJ1Y3QNCj4g
PiBwY2lfYnVzICpidXMsDQo+ID4gKwkJCQkgdW5zaWduZWQgaW50IGRldmZuLCBpbnQgd2hlcmUs
IGludA0KPiA+IHNpemUsDQo+ID4gKwkJCQkgdTMyICp2YWwpDQo+ID4gK3sNCj4gPiArCXN0cnVj
dCBkd19wY2llICpwY2kgPSB0b19kd19wY2llX2Zyb21fcHAocHApOw0KPiA+ICsJc3RydWN0IGFs
X3BjaWUgKnBjaWUgPSB0b19hbF9wY2llKHBjaSk7DQo+ID4gKwl1bnNpZ25lZCBpbnQgYnVzbnIg
PSBidXMtPm51bWJlcjsNCj4gPiArCXZvaWQgX19pb21lbSAqcGNpX2FkZHI7DQo+ID4gKwlpbnQg
cmM7DQo+ID4gKw0KPiA+ICsJcGNpX2FkZHIgPSBhbF9wY2llX2NvbmZfYWRkcl9tYXAocGNpZSwg
YnVzbnIsIGRldmZuKTsNCj4gPiArDQo+ID4gKwlyYyA9IGR3X3BjaWVfcmVhZChwY2lfYWRkciAr
IHdoZXJlLCBzaXplLCB2YWwpOw0KPiA+ICsNCj4gPiArCWRldl9kYmcocGNpLT5kZXYsICIlZC1i
eXRlIGNvbmZpZyByZWFkIGZyb20gJTA0eDolMDJ4OiUwMnguJWQNCj4gPiBvZmZzZXQgMHgleCAo
cGNpX2FkZHI6IDB4JXB4KSAtIHZhbDoweCV4XG4iLA0KPiA+ICsJCXNpemUsIHBjaV9kb21haW5f
bnIoYnVzKSwgYnVzLT5udW1iZXIsDQo+ID4gKwkJUENJX1NMT1QoZGV2Zm4pLCBQQ0lfRlVOQyhk
ZXZmbiksIHdoZXJlLA0KPiA+ICsJCShwY2lfYWRkciArIHdoZXJlKSwgKnZhbCk7DQo+ID4gKw0K
PiA+ICsJcmV0dXJuIHJjOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFsX3BjaWVf
d3Jfb3RoZXJfY29uZihzdHJ1Y3QgcGNpZV9wb3J0ICpwcCwgc3RydWN0DQo+ID4gcGNpX2J1cyAq
YnVzLA0KPiA+ICsJCQkJIHVuc2lnbmVkIGludCBkZXZmbiwgaW50IHdoZXJlLCBpbnQNCj4gPiBz
aXplLA0KPiA+ICsJCQkJIHUzMiB2YWwpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkd19wY2llICpw
Y2kgPSB0b19kd19wY2llX2Zyb21fcHAocHApOw0KPiA+ICsJc3RydWN0IGFsX3BjaWUgKnBjaWUg
PSB0b19hbF9wY2llKHBjaSk7DQo+ID4gKwl1bnNpZ25lZCBpbnQgYnVzbnIgPSBidXMtPm51bWJl
cjsNCj4gPiArCXZvaWQgX19pb21lbSAqcGNpX2FkZHI7DQo+ID4gKwlpbnQgcmM7DQo+ID4gKw0K
PiA+ICsJcGNpX2FkZHIgPSBhbF9wY2llX2NvbmZfYWRkcl9tYXAocGNpZSwgYnVzbnIsIGRldmZu
KTsNCj4gPiArDQo+ID4gKwlyYyA9IGR3X3BjaWVfd3JpdGUocGNpX2FkZHIgKyB3aGVyZSwgc2l6
ZSwgdmFsKTsNCj4gPiArDQo+ID4gKwlkZXZfZGJnKHBjaS0+ZGV2LCAiJWQtYnl0ZSBjb25maWcg
d3JpdGUgdG8gJTA0eDolMDJ4OiUwMnguJWQNCj4gPiBvZmZzZXQgMHgleCAocGNpX2FkZHI6IDB4
JXB4KSAtIHZhbDoweCV4XG4iLA0KPiA+ICsJCXNpemUsIHBjaV9kb21haW5fbnIoYnVzKSwgYnVz
LT5udW1iZXIsDQo+ID4gKwkJUENJX1NMT1QoZGV2Zm4pLCBQQ0lfRlVOQyhkZXZmbiksIHdoZXJl
LA0KPiA+ICsJCShwY2lfYWRkciArIHdoZXJlKSwgdmFsKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4g
cmM7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyB2b2lkIGFsX3BjaWVfY29uZmlnX3ByZXBh
cmUoc3RydWN0IGFsX3BjaWUgKnBjaWUpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBhbF9wY2llX3Rh
cmdldF9idXNfY2ZnICp0YXJnZXRfYnVzX2NmZzsNCj4gPiArCXN0cnVjdCBwY2llX3BvcnQgKnBw
ID0gJnBjaWUtPnBjaS0+cHA7DQo+ID4gKwl1bnNpZ25lZCBpbnQgZWNhbV9idXNfbWFzazsNCj4g
PiArCXUzMiBjZmdfY29udHJvbF9vZmZzZXQ7DQo+ID4gKwl1OCBzdWJvcmRpbmF0ZV9idXM7DQo+
ID4gKwl1OCBzZWNvbmRhcnlfYnVzOw0KPiA+ICsJdTMyIGNmZ19jb250cm9sOw0KPiA+ICsJdTMy
IHJlZzsNCj4gPiArDQo+ID4gKwl0YXJnZXRfYnVzX2NmZyA9ICZwY2llLT50YXJnZXRfYnVzX2Nm
ZzsNCj4gPiArDQo+ID4gKwllY2FtX2J1c19tYXNrID0gKHBjaWUtPmVjYW1fc2l6ZSA+PiAyMCkg
LSAxOw0KPiA+ICsJaWYgKGVjYW1fYnVzX21hc2sgPiAyNTUpIHsNCj4gPiArCQlkZXZfd2Fybihw
Y2llLT5kZXYsICJFQ0FNIHdpbmRvdyBzaXplIGlzIGxhcmdlciB0aGFuDQo+ID4gMjU2TUIuIEN1
dHRpbmcgb2ZmIGF0IDI1NlxuIik7DQo+ID4gKwkJZWNhbV9idXNfbWFzayA9IDI1NTsNCj4gPiAr
CX0NCj4gPiArDQo+ID4gKwkvKiBUaGlzIHBvcnRpb24gaXMgdGFrZW4gZnJvbSB0aGUgdHJhbnNh
Y3Rpb24gYWRkcmVzcyAqLw0KPiA+ICsJdGFyZ2V0X2J1c19jZmctPmVjYW1fbWFzayA9IGVjYW1f
YnVzX21hc2s7DQo+ID4gKwkvKiBUaGlzIHBvcnRpb24gaXMgdGFrZW4gZnJvbSB0aGUgY2ZnX3Rh
cmdldF9idXMgcmVnICovDQo+ID4gKwl0YXJnZXRfYnVzX2NmZy0+cmVnX21hc2sgPSB+dGFyZ2V0
X2J1c19jZmctPmVjYW1fbWFzazsNCj4gPiArCXRhcmdldF9idXNfY2ZnLT5yZWdfdmFsID0gcHAt
PmJ1c24tPnN0YXJ0ICYgdGFyZ2V0X2J1c19jZmctDQo+ID4gPnJlZ19tYXNrOw0KPiANCj4gSWYg
SSB1bmRlcnN0YW5kIGNvcnJlY3RseSAtIHRoZXJlIGlzIGFuIG9wdGltaXNhdGlvbiBpbg0KPiBh
bF9wY2llX2NvbmZfYWRkcl9tYXANCj4gdGhhdCBwcmV2ZW50cyBhbiB1bm5lY2Vzc2FyeSB3cml0
ZSB0byB0aGUgY29udHJvbGxlciBpZiBpdCdzIGFscmVhZHkNCj4gcHJvZ3JhbW1lZA0KPiB0byB0
aGUgYnVzIHdlIHdhbnQgdG8gdGFsayB0by4gRHVlIHRvIHRoaXMgb3B0aW1pc2F0aW9uIHdlIG5l
ZWQgdG8NCj4gZW5zdXJlIHRoZQ0KPiBkZWZhdWx0IHZhbHVlcyBpbiB0YXJnZXRfYnVzX2NmZyBt
YXRjaCB3aGF0IHRoZSBoYXJkd2FyZSBpcyBpbml0aWFsbHkNCj4gcHJvZ3JhbW1lZA0KPiB0by4g
U28gdG8gYmUgb24gdGhlIHNhZmUgc2lkZSB3ZSBwcm9ncmFtIHRoZW0gYXQgdGhlIHN0YXJ0IG9m
IGRheS4NCj4gDQo+IEl0IHNvdW5kcyBsaWtlIHRoZSBjb250cm9sbGVyIGlzbid0IHJlc2V0IGFu
eXdoZXJlIHBvc3QtZmlybXdhcmU/IHNvDQo+IHdlIGhhdmUNCj4gbm8gaWRlYSB3aGF0IHZhbHVl
IHRoZSBoYXJkd2FyZSBtYXkgYmUgcHJvZ3JhbW1lZCB0bz8NCg0KV2UgZG9uJ3Qgd2FudCB0byBy
ZXNldCB0aGUgY29udHJvbGxlciBzaW5jZSB3ZSByZWx5IG9uIHRoZSBGVyB0bw0KcGVyZm9ybSB0
aGUgbGluayBjb25maWd1cmF0aW9uLiBPdGhlciB0aGFuIHRoYXQsIEkgZG9uJ3QgdGhpbmsgd2UN
CnNob3VsZCByZWx5IG9uIGFueSBjb25maWd1cmF0aW9ucyB3ZSBjYW4gZGV0ZXJtaW5lIG91cnNl
bHZlcy4NCg0KPiANCj4gDQo+ID4gKw0KPiA+ICsJYWxfcGNpZV90YXJnZXRfYnVzX3NldChwY2ll
LCB0YXJnZXRfYnVzX2NmZy0+cmVnX3ZhbCwNCj4gPiArCQkJICAgICAgIHRhcmdldF9idXNfY2Zn
LT5yZWdfbWFzayk7DQo+ID4gKw0KPiA+ICsJc2Vjb25kYXJ5X2J1cyA9IHBwLT5idXNuLT5zdGFy
dCArIDE7DQo+ID4gKwlzdWJvcmRpbmF0ZV9idXMgPSBwcC0+YnVzbi0+ZW5kOw0KPiA+ICsNCj4g
PiArCS8qIFNldCB0aGUgdmFsaWQgdmFsdWVzIG9mIHNlY29uZGFyeSBhbmQgc3Vib3JkaW5hdGUg
YnVzZXMgKi8NCj4gPiArCWNmZ19jb250cm9sX29mZnNldCA9IEFYSV9CQVNFX09GRlNFVCArIHBj
aWUtDQo+ID4gPnJlZ19vZmZzZXRzLm9iX2N0cmwgKw0KPiA+ICsJCQkgICAgIENGR19DT05UUk9M
Ow0KPiA+ICsNCj4gPiArCWNmZ19jb250cm9sID0gYWxfcGNpZV9jb250cm9sbGVyX3JlYWRsKHBj
aWUsDQo+ID4gY2ZnX2NvbnRyb2xfb2Zmc2V0KTsNCj4gPiArDQo+ID4gKwlyZWcgPSBjZmdfY29u
dHJvbCAmDQo+ID4gKwkgICAgICB+KENGR19DT05UUk9MX1NFQ19CVVNfTUFTSyB8IENGR19DT05U
Uk9MX1NVQkJVU19NQVNLKTsNCj4gPiArDQo+ID4gKwlyZWcgfD0gRklFTERfUFJFUChDRkdfQ09O
VFJPTF9TVUJCVVNfTUFTSywgc3Vib3JkaW5hdGVfYnVzKSB8DQo+ID4gKwkgICAgICAgRklFTERf
UFJFUChDRkdfQ09OVFJPTF9TRUNfQlVTX01BU0ssIHNlY29uZGFyeV9idXMpOw0KPiA+ICsNCj4g
PiArCWFsX3BjaWVfY29udHJvbGxlcl93cml0ZWwocGNpZSwgY2ZnX2NvbnRyb2xfb2Zmc2V0LCBy
ZWcpOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0aWMgaW50IGFsX3BjaWVfaG9zdF9pbml0KHN0
cnVjdCBwY2llX3BvcnQgKnBwKQ0KPiA+ICt7DQo+ID4gKwlzdHJ1Y3QgZHdfcGNpZSAqcGNpID0g
dG9fZHdfcGNpZV9mcm9tX3BwKHBwKTsNCj4gPiArCXN0cnVjdCBhbF9wY2llICpwY2llID0gdG9f
YWxfcGNpZShwY2kpOw0KPiA+ICsJaW50IHJjOw0KPiA+ICsNCj4gPiArCXJjID0gYWxfcGNpZV9y
ZXZfaWRfZ2V0KHBjaWUsICZwY2llLT5jb250cm9sbGVyX3Jldl9pZCk7DQo+ID4gKwlpZiAocmMp
DQo+ID4gKwkJcmV0dXJuIHJjOw0KPiA+ICsNCj4gPiArCXJjID0gYWxfcGNpZV9yZWdfb2Zmc2V0
c19zZXQocGNpZSk7DQo+ID4gKwlpZiAocmMpDQo+ID4gKwkJcmV0dXJuIHJjOw0KPiA+ICsNCj4g
PiArCWFsX3BjaWVfY29uZmlnX3ByZXBhcmUocGNpZSk7DQo+ID4gKw0KPiA+ICsJcmV0dXJuIDA7
DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3QgZHdfcGNpZV9ob3N0X29w
cyBhbF9wY2llX2hvc3Rfb3BzID0gew0KPiA+ICsJLnJkX290aGVyX2NvbmYgPSBhbF9wY2llX3Jk
X290aGVyX2NvbmYsDQo+ID4gKwkud3Jfb3RoZXJfY29uZiA9IGFsX3BjaWVfd3Jfb3RoZXJfY29u
ZiwNCj4gPiArCS5ob3N0X2luaXQgPSBhbF9wY2llX2hvc3RfaW5pdCwNCj4gPiArfTsNCj4gPiAr
DQo+ID4gK3N0YXRpYyBpbnQgYWxfYWRkX3BjaWVfcG9ydChzdHJ1Y3QgcGNpZV9wb3J0ICpwcCwN
Cj4gPiArCQkJICAgIHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2UgKnBkZXYpDQo+ID4gK3sNCj4gPiAr
CXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+ID4gKwlpbnQgcmV0Ow0KPiA+ICsN
Cj4gPiArCXBwLT5vcHMgPSAmYWxfcGNpZV9ob3N0X29wczsNCj4gPiArDQo+ID4gKwlyZXQgPSBk
d19wY2llX2hvc3RfaW5pdChwcCk7DQo+ID4gKwlpZiAocmV0KSB7DQo+ID4gKwkJZGV2X2Vycihk
ZXYsICJmYWlsZWQgdG8gaW5pdGlhbGl6ZSBob3N0XG4iKTsNCj4gPiArCQlyZXR1cm4gcmV0Ow0K
PiA+ICsJfQ0KPiA+ICsNCj4gPiArCXJldHVybiAwOw0KPiA+ICt9DQo+ID4gKw0KPiA+ICtzdGF0
aWMgY29uc3Qgc3RydWN0IGR3X3BjaWVfb3BzIGR3X3BjaWVfb3BzID0gew0KPiA+ICt9Ow0KPiA+
ICsNCj4gPiArc3RhdGljIGludCBhbF9wY2llX3Byb2JlKHN0cnVjdCBwbGF0Zm9ybV9kZXZpY2Ug
KnBkZXYpDQo+ID4gK3sNCj4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9ICZwZGV2LT5kZXY7DQo+
ID4gKwlzdHJ1Y3QgcmVzb3VyY2UgKmNvbnRyb2xsZXJfcmVzOw0KPiA+ICsJc3RydWN0IHJlc291
cmNlICplY2FtX3JlczsNCj4gPiArCXN0cnVjdCByZXNvdXJjZSAqZGJpX3JlczsNCj4gPiArCXN0
cnVjdCBhbF9wY2llICphbF9wY2llOw0KPiA+ICsJc3RydWN0IGR3X3BjaWUgKnBjaTsNCj4gPiAr
DQo+ID4gKwlhbF9wY2llID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCphbF9wY2llKSwgR0ZQ
X0tFUk5FTCk7DQo+ID4gKwlpZiAoIWFsX3BjaWUpDQo+ID4gKwkJcmV0dXJuIC1FTk9NRU07DQo+
ID4gKw0KPiA+ICsJcGNpID0gZGV2bV9remFsbG9jKGRldiwgc2l6ZW9mKCpwY2kpLCBHRlBfS0VS
TkVMKTsNCj4gPiArCWlmICghcGNpKQ0KPiA+ICsJCXJldHVybiAtRU5PTUVNOw0KPiA+ICsNCj4g
PiArCXBjaS0+ZGV2ID0gZGV2Ow0KPiA+ICsJcGNpLT5vcHMgPSAmZHdfcGNpZV9vcHM7DQo+ID4g
Kw0KPiA+ICsJYWxfcGNpZS0+cGNpID0gcGNpOw0KPiA+ICsJYWxfcGNpZS0+ZGV2ID0gZGV2Ow0K
PiA+ICsNCj4gPiArCWRiaV9yZXMgPSBwbGF0Zm9ybV9nZXRfcmVzb3VyY2VfYnluYW1lKHBkZXYs
IElPUkVTT1VSQ0VfTUVNLA0KPiA+ICJkYmkiKTsNCj4gPiArCXBjaS0+ZGJpX2Jhc2UgPSBkZXZt
X3BjaV9yZW1hcF9jZmdfcmVzb3VyY2UoZGV2LCBkYmlfcmVzKTsNCj4gPiArCWlmIChJU19FUlIo
cGNpLT5kYmlfYmFzZSkpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgImNvdWxkbid0IHJlbWFwIGRi
aSBiYXNlICVwUlxuIiwgZGJpX3Jlcyk7DQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIocGNpLT5kYmlf
YmFzZSk7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZWNhbV9yZXMgPSBwbGF0Zm9ybV9nZXRfcmVz
b3VyY2VfYnluYW1lKHBkZXYsIElPUkVTT1VSQ0VfTUVNLA0KPiA+ICJjb25maWciKTsNCj4gPiAr
CWlmICghZWNhbV9yZXMpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgImNvdWxkbid0IGZpbmQgJ2Nv
bmZpZycgcmVnIGluIERUXG4iKTsNCj4gPiArCQlyZXR1cm4gLUVOT0VOVDsNCj4gPiArCX0NCj4g
PiArCWFsX3BjaWUtPmVjYW1fc2l6ZSA9IHJlc291cmNlX3NpemUoZWNhbV9yZXMpOw0KPiANCj4g
SW5zdGVhZCBvZiBnZXR0aW5nIHRoZSBlY2FtX3NpemUgZnJvbSB0aGUgZGV2aWNlIHRyZWUgaGVy
ZSwgeW91IGNvdWxkDQo+IGp1c3QgdXNlDQo+IGFsX3BjaWUtPnBjaS0+cHAuY2ZnMF9zaXplIGlu
c3RlYWQuIEkuZS4gaW4gYWxfcGNpZV9jb25maWdfcHJlcGFyZS4uLg0KPiANCj4gCWVjYW1fYnVz
X21hc2sgPSAocGNpZS0+cGNpLT5wcC5jZmcwX3NpemUgPj4gMTkpIC0gMTsNCj4gDQo+IFRob3Vn
aCB5b3UgY291bGQgYXJndWUgdGhhdCBhY2Nlc3Npbmcgc29tZXRoaW5nIHByaXZhdGUgdG8gdGhl
IGR3Yw0KPiBob3N0IGRyaXZlcg0KPiB1bm5lY2Vzc2FyaWx5IGluY3JlYXNlcyB0aGUgY291cGxp
bmcgYmV0d2VlbiB0aGUgdHdvIGFuZCBtYWtlcyB0aGUgQUwNCj4gZHJpdmVyDQo+IG1vcmUgZnJh
Z2lsZS4gQnV0IGp1c3QgYW4gb2JzZXJ2YXRpb24gSSB0aG91Z2h0IEknZCBwb2ludCBvdXQuDQo+
IA0KSW4gdGhpcyBzcGVjaWZpYyBjYXNlLCBJIHByZWZlcnJlZCBub3QgdG8gaW5jcmVhc2UgdGhl
IGNvdXBsaW5nLA0KZXNwZWNpYWxseSBzaW5jZSB0aGUgaW50ZXJuYWwgY2ZnMF9zaXplIGZpZWxk
IGhhcyBiZWVuIHNoaWZ0ZWQgcmlnaHQgYnkNCjEsIHdoaWNoIG1ha2VzIGl0IGEgYml0IGxlc3Mg
Y29tcHJlaGVuc2libGUuIEkgZGlkIG1ha2UgdXNlIG9mIHBwLQ0KPnZhX2NmZzBfYmFzZSwgc2lu
Y2UgaXQgaXMgbW9yZSBzdHJhaWdodGZvcndhcmQgKGFuZCB3YXMgYWxyZWFkeSBpbiB1c2UNCmJ5
IGFub3RoZXIgZHJpdmVyKS4NCg0KPiA+IEV2ZW4gd2l0aG91dCBhbnkgbW9yZSBjaGFuZ2VzIHRv
IHRoaXMgcGF0Y2g6DQo+IA0KPiBSZXZpZXdlZC1ieTogQW5kcmV3IE11cnJheSA8YW5kcmV3Lm11
cnJheUBhcm0uY29tPg0KPiANCj4gPiArDQo+ID4gKwljb250cm9sbGVyX3JlcyA9IHBsYXRmb3Jt
X2dldF9yZXNvdXJjZV9ieW5hbWUocGRldiwNCj4gPiBJT1JFU09VUkNFX01FTSwNCj4gPiArCQkJ
CQkJICAgICAgImNvbnRyb2xsZXIiKTsNCj4gPiArCWFsX3BjaWUtPmNvbnRyb2xsZXJfYmFzZSA9
IGRldm1faW9yZW1hcF9yZXNvdXJjZShkZXYsDQo+ID4gY29udHJvbGxlcl9yZXMpOw0KPiA+ICsJ
aWYgKElTX0VSUihhbF9wY2llLT5jb250cm9sbGVyX2Jhc2UpKSB7DQo+ID4gKwkJZGV2X2Vycihk
ZXYsICJjb3VsZG4ndCByZW1hcCBjb250cm9sbGVyIGJhc2UgJXBSXG4iLA0KPiA+ICsJCQljb250
cm9sbGVyX3Jlcyk7DQo+ID4gKwkJcmV0dXJuIFBUUl9FUlIoYWxfcGNpZS0+Y29udHJvbGxlcl9i
YXNlKTsNCj4gPiArCX0NCj4gPiArDQo+ID4gKwlkZXZfZGJnKGRldiwgIkZyb20gRFQ6IGRiaV9i
YXNlOiAlcFIsIGNvbnRyb2xsZXJfYmFzZTogJXBSXG4iLA0KPiA+ICsJCWRiaV9yZXMsIGNvbnRy
b2xsZXJfcmVzKTsNCj4gPiArDQo+ID4gKwlwbGF0Zm9ybV9zZXRfZHJ2ZGF0YShwZGV2LCBhbF9w
Y2llKTsNCj4gPiArDQo+ID4gKwlyZXR1cm4gYWxfYWRkX3BjaWVfcG9ydCgmcGNpLT5wcCwgcGRl
dik7DQo+ID4gK30NCj4gPiArDQo+ID4gK3N0YXRpYyBjb25zdCBzdHJ1Y3Qgb2ZfZGV2aWNlX2lk
IGFsX3BjaWVfb2ZfbWF0Y2hbXSA9IHsNCj4gPiArCXsgLmNvbXBhdGlibGUgPSAiYW1hem9uLGFs
LWFscGluZS12Mi1wY2llIiwNCj4gPiArCX0sDQo+ID4gKwl7IC5jb21wYXRpYmxlID0gImFtYXpv
bixhbC1hbHBpbmUtdjMtcGNpZSIsDQo+ID4gKwl9LA0KPiA+ICsJe30sDQo+ID4gK307DQo+ID4g
Kw0KPiA+ICtzdGF0aWMgc3RydWN0IHBsYXRmb3JtX2RyaXZlciBhbF9wY2llX2RyaXZlciA9IHsN
Cj4gPiArCS5kcml2ZXIgPSB7DQo+ID4gKwkJLm5hbWUJPSAiYWwtcGNpZSIsDQo+ID4gKwkJLm9m
X21hdGNoX3RhYmxlID0gYWxfcGNpZV9vZl9tYXRjaCwNCj4gPiArCQkuc3VwcHJlc3NfYmluZF9h
dHRycyA9IHRydWUsDQo+ID4gKwl9LA0KPiA+ICsJLnByb2JlID0gYWxfcGNpZV9wcm9iZSwNCj4g
PiArfTsNCj4gPiArYnVpbHRpbl9wbGF0Zm9ybV9kcml2ZXIoYWxfcGNpZV9kcml2ZXIpOw0KPiA+
ICsNCj4gPiArI2VuZGlmIC8qIENPTkZJR19QQ0lFX0FMKi8NCj4gPiAtLSANCj4gPiAyLjE3LjEN
Cj4gPiANCg==
