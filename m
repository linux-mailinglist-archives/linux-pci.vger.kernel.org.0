Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 9685614F20E
	for <lists+linux-pci@lfdr.de>; Fri, 31 Jan 2020 19:19:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725939AbgAaSTy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 31 Jan 2020 13:19:54 -0500
Received: from mta-02.yadro.com ([89.207.88.252]:44006 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725909AbgAaSTy (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 31 Jan 2020 13:19:54 -0500
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id 5E03A4799F;
        Fri, 31 Jan 2020 18:19:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        mime-version:content-transfer-encoding:content-id:content-type
        :content-type:content-language:accept-language:in-reply-to
        :references:message-id:date:date:subject:subject:from:from
        :received:received:received:received; s=mta-01; t=1580494789; x=
        1582309190; bh=li+iEcIhxaz7h8HHAIAbNlpMHnUclLWfX3cpJFvfVws=; b=s
        CbkFKDMTf32PUkhEBFFDqngflvw2jULvYzRS0D+ebzvz+g95YhLNBaC9fL3k5u27
        +hyPs9CA5CpJA4medZf9enCkLaFrCgv8TCbAKSvpps9PZAWO/zyuHTr7RkJt/kSA
        xAAVKwZmM72O5zhTSGcAeWtJE1soLUVN7UlVJsRiKQ=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id N12tiDiumCTb; Fri, 31 Jan 2020 21:19:49 +0300 (MSK)
Received: from T-EXCH-01.corp.yadro.com (t-exch-01.corp.yadro.com [172.17.10.101])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 03D3247996;
        Fri, 31 Jan 2020 21:19:48 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (172.17.10.102) by
 T-EXCH-01.corp.yadro.com (172.17.10.101) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Fri, 31 Jan 2020 21:19:48 +0300
Received: from T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23]) by
 T-EXCH-02.corp.yadro.com ([fe80::19dd:9b61:5447:ff23%14]) with mapi id
 15.01.0669.032; Fri, 31 Jan 2020 21:19:48 +0300
From:   Sergei Miroshnichenko <s.miroshnichenko@yadro.com>
To:     "helgaas@kernel.org" <helgaas@kernel.org>
CC:     "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux@yadro.com" <linux@yadro.com>, "sr@denx.de" <sr@denx.de>
Subject: Re: [PATCH v7 16/26] PCI: Ignore PCIBIOS_MIN_MEM
Thread-Topic: [PATCH v7 16/26] PCI: Ignore PCIBIOS_MIN_MEM
Thread-Index: AQHV1rj3MLBuXSpu+0eGhF8XhxKbvKgDsP4AgAE1ToA=
Date:   Fri, 31 Jan 2020 18:19:48 +0000
Message-ID: <f3d10ec4adea2b91c38c2c53a66632fefc2a6e46.camel@yadro.com>
References: <20200130235244.GA149020@google.com>
In-Reply-To: <20200130235244.GA149020@google.com>
Accept-Language: en-US, ru-RU
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-originating-ip: [172.17.15.136]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8170170828265F4DA485B8B0FFD3B0C5@yadro.com>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIwLTAxLTMwIGF0IDE3OjUyIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIEphbiAyOSwgMjAyMCBhdCAwNjoyOToyN1BNICswMzAwLCBTZXJnZWkgTWlyb3No
bmljaGVua28NCj4gd3JvdGU6DQo+ID4gQkFScyBhbmQgYnJpZGdlIHdpbmRvd3MgYXJlIG9ubHkg
YWxsb3dlZCB0byBiZSBhc3NpZ25lZCB0byB0aGVpcg0KPiA+IHBhcmVudCBidXMncyBicmlkZ2Ug
d2luZG93cywgZ29pbmcgdXAgdG8gdGhlIHJvb3QgY29tcGxleCdzDQo+ID4gcmVzb3VyY2VzLg0K
PiA+IFNvIGFkZGl0aW9uYWwgbGltaXRhdGlvbnMgb24gQkFSIGFkZHJlc3MgYXJlIG5vdCBuZWVk
ZWQsIGFuZCB0aGUNCj4gPiBQQ0lCSU9TX01JTl9NRU0gY2FuIGJlIGlnbm9yZWQuDQo+IA0KPiBU
aGlzIGlzIHRoZW9yZXRpY2FsbHkgdHJ1ZSwgYnV0IEkgZG9uJ3QgdGhpbmsgd2UgaGF2ZSByZWxp
YWJsZQ0KPiBpbmZvcm1hdGlvbiBhYm91dCB0aGUgaG9zdCBicmlkZ2Ugd2luZG93cyBpbiBhbGwg
Y2FzZXMsIHNvDQo+IFBDSUJJT1NfTUlOX01FTS9fSU8gaXMgc29tZXRoaW5nIG9mIGFuIGFwcHJv
eGltYXRpb24uDQo+IA0KPiA+IEJlc2lkZXMsIHRoZSB2YWx1ZSBvZiBQQ0lCSU9TX01JTl9NRU0g
cmVwb3J0ZWQgYnkgdGhlIEJJT1MgMS4zIG9uDQo+ID4gU3VwZXJtaWNybyBIMTFTU0wtaSB2aWEg
ZTgyMF9fc2V0dXBfcGNpX2dhcCgpOg0KPiA+IA0KPiA+ICAgW21lbSAweGViZmYxMDAwLTB4ZmU5
ZmZmZmZdIGF2YWlsYWJsZSBmb3IgUENJIGRldmljZXMNCj4gPiANCj4gPiBpcyBvbmx5IHN1aXRh
YmxlIGZvciBhIHNpbmdsZSBSQyBvdXQgb2YgZm91cjoNCj4gPiANCj4gPiAgIHBjaV9idXMgMDAw
MDowMDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweGVjMDAwMDAwLTB4ZWZmZmZmZmYNCj4gPiB3
aW5kb3ddDQo+ID4gICBwY2lfYnVzIDAwMDA6MjA6IHJvb3QgYnVzIHJlc291cmNlIFttZW0gMHhl
YjgwMDAwMC0weGViZWZmZmZmDQo+ID4gd2luZG93XQ0KPiA+ICAgcGNpX2J1cyAwMDAwOjQwOiBy
b290IGJ1cyByZXNvdXJjZSBbbWVtIDB4ZWIyMDAwMDAtMHhlYjVmZmZmZg0KPiA+IHdpbmRvd10N
Cj4gPiAgIHBjaV9idXMgMDAwMDo2MDogcm9vdCBidXMgcmVzb3VyY2UgW21lbSAweGU4YjAwMDAw
LTB4ZWFmZmZmZmYNCj4gPiB3aW5kb3ddDQo+ID4gDQo+ID4gLCB3aGljaCBtYWtlcyB0aGUgQU1E
IEVQWUMgNzI1MSB1bmFibGUgdG8gYm9vdCB3aXRoIHRoaXMgbW92YWJsZQ0KPiA+IEJBUnMNCj4g
PiBwYXRjaHNldC4NCj4gDQo+IFNvbWV0aGluZydzIHdyb25nIGlmIHRoaXMgc3lzdGVtIGJvb3Rl
ZCBiZWZvcmUgdGhpcyBwYXRjaCBzZXQgYnV0IG5vdA0KPiBhZnRlci4gIFdlIHNob3VsZG4ndCBi
ZSBkb2luZyAqYW55dGhpbmcqIHdpdGggdGhlIEJBUnMgdW50aWwgd2UgbmVlZA0KPiB0bywgaS5l
LiwgdW50aWwgd2UgaG90LWFkZCBhIGRldmljZSB3aGVyZSB3ZSBoYXZlIHRvIG1vdmUgdGhpbmdz
IHRvDQo+IGZpbmQgc3BhY2UgZm9yIGl0Lg0KPiANCg0KVGhlIG9uZSBicmVha2luZyBib290IG9u
IHRoaXMgc3lzdGVtIGluaXRpYWxseSB3YXMgMTcvMjYgb2YgdGhpcw0KcGF0Y2hzZXQ6ICJQQ0k6
IGhvdHBsdWc6IElnbm9yZSB0aGUgTUVNIEJBUiBvZmZzZXRzIGZyb20NCkJJT1MvYm9vdGxvYWRl
ciINCg0KQmVmb3JlIGl0IHRoZSBrZXJuZWwganVzdCB0b29rIEJBUnMgcHJlLWFzc2lnbmVkIGJ5
IEJJT1MuIEluIHRoZSBzYW1lDQp0aW1lLCB0aGUgc2FtZSBCSU9TIHJlcG9ydHMgMHhlYmZmMTAw
MC0weGZlOWZmZmZmIGFzIGF2YWlsYWJsZSBmb3IgUENJDQpkZXZpY2VzLCBidXQgdGhlIHJlYWwg
cm9vdCBicmlkZ2Ugd2luZG93cyBhcmUgMHhlOGIwMDAwMC0weGVmZmZmZmZmIGluDQp0b3RhbCAo
YW5kIGFsc28gNjQtYml0IHdpbmRvd3MpIC0gd2hpY2ggYXJlIGFsc28gcmVwb3J0ZWQgYnkgdGhl
IHNhbWUNCkJJT1MuIFNvIHRoZSBrZXJuZWwgd2FzIG9ubHkgYWJsZSB0byBoYW5ibGUgdGhlIDB4
ZWMwMDAwMDAtMHhlZmZmZmZmZg0Kcm9vdCBidXMuDQoNCldpdGggdGhhdCBwYXRjaCByZXZlcnRl
ZCB0aGUga2VybmVsIHdhcyBhYmxlIHRvIGJvb3QsIGJ1dCB1bmFibGUgdG8NCnJlc2NhbiAtIHRv
IHJlYXNzaWduIEJBUnMgYWN0dWFsbHkuDQoNCj4gKEFuZCB3ZSBkb24ndCB3YW50IGEgYmlzZWN0
aW9uIGhvbGUgd2hlcmUgdGhpcyBzeXN0ZW0gY2FuJ3QgYm9vdA0KPiB1bnRpbA0KPiB0aGlzIHBh
dGNoIGlzIGFwcGxpZWQsIGJ1dCBJIGFzc3VtZSB0aGF0J3Mgb2J2aW91cy4pDQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IFNlcmdlaSBNaXJvc2huaWNoZW5rbyA8cy5taXJvc2huaWNoZW5rb0B5YWRy
by5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZlcnMvcGNpL3NldHVwLXJlcy5jIHwgNSArKystLQ0K
PiA+ICAxIGZpbGUgY2hhbmdlZCwgMyBpbnNlcnRpb25zKCspLCAyIGRlbGV0aW9ucygtKQ0KPiA+
IA0KPiA+IGRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9zZXR1cC1yZXMuYyBiL2RyaXZlcnMvcGNp
L3NldHVwLXJlcy5jDQo+ID4gaW5kZXggYTdkODE4MTZkMWVhLi40MDQzYWFiMDIxZGQgMTAwNjQ0
DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kvc2V0dXAtcmVzLmMNCj4gPiArKysgYi9kcml2ZXJzL3Bj
aS9zZXR1cC1yZXMuYw0KPiA+IEBAIC0yNDYsMTIgKzI0NiwxMyBAQCBzdGF0aWMgaW50IF9fcGNp
X2Fzc2lnbl9yZXNvdXJjZShzdHJ1Y3QNCj4gPiBwY2lfYnVzICpidXMsIHN0cnVjdCBwY2lfZGV2
ICpkZXYsDQo+ID4gIAkJaW50IHJlc25vLCByZXNvdXJjZV9zaXplX3Qgc2l6ZSwgcmVzb3VyY2Vf
c2l6ZV90IGFsaWduKQ0KPiA+ICB7DQo+ID4gIAlzdHJ1Y3QgcmVzb3VyY2UgKnJlcyA9IGRldi0+
cmVzb3VyY2UgKyByZXNubzsNCj4gPiAtCXJlc291cmNlX3NpemVfdCBtaW47DQo+ID4gKwlyZXNv
dXJjZV9zaXplX3QgbWluID0gMDsNCj4gPiAgCWludCByZXQ7DQo+ID4gIAlyZXNvdXJjZV9zaXpl
X3Qgc3RhcnQgPSAocmVzb3VyY2Vfc2l6ZV90KS0xOw0KPiA+ICAJcmVzb3VyY2Vfc2l6ZV90IGVu
ZCA9IDA7DQo+ID4gIA0KPiA+IC0JbWluID0gKHJlcy0+ZmxhZ3MgJiBJT1JFU09VUkNFX0lPKSA/
IFBDSUJJT1NfTUlOX0lPIDoNCj4gPiBQQ0lCSU9TX01JTl9NRU07DQo+ID4gKwlpZiAoIXBjaV9j
YW5fbW92ZV9iYXJzKQ0KPiA+ICsJCW1pbiA9IChyZXMtPmZsYWdzICYgSU9SRVNPVVJDRV9JTykg
PyBQQ0lCSU9TX01JTl9JTyA6DQo+ID4gUENJQklPU19NSU5fTUVNOw0KPiANCj4gSSBkb24ndCB1
bmRlcnN0YW5kIHRoZSBjb25uZWN0aW9uIGhlcmUuICBQQ0lCSU9TX01JTl9NRU0gYW5kDQo+IFBD
SUJJT1NfTUlOX0lPIGFyZSBiYXNpY2FsbHkgd2F5cyB0byBzYXkgIndlIGNhbid0IHB1dCBQQ0kg
cmVzb3VyY2VzDQo+IGJlbG93IHRoaXMgYWRkcmVzcyIuDQo+IA0KPiBPbiBBQ1BJIHN5c3RlbXMs
IHRoZSBkZXZpY2VzIGluIHRoZSBBQ1BJIG5hbWVzcGFjZSBhcmUgc3VwcG9zZWQgdG8NCj4gdGVs
bCB0aGUgT1Mgd2hhdCByZXNvdXJjZXMgdGhleSB1c2UsIGFuZCBvYnZpb3VzbHkgdGhlIE9TIHNo
b3VsZCBub3QNCj4gYXNzaWduIHRob3NlIHJlc291cmNlcyB0byBhbnl0aGluZyBlbHNlLiAgSWYg
TGludXggaGFuZGxlZCBhbGwgdGhvc2UNCj4gQUNQSSByZXNvdXJjZXMgY29ycmVjdGx5IGFuZCBp
biB0aGUgYWJzZW5jZSBvZiBmaXJtd2FyZSBkZWZlY3RzLCB3ZQ0KPiBzaG91bGRuJ3QgbmVlZCBQ
Q0lCSU9TX01JTl9NRU0vX0lPIGF0IGFsbC4gIEJ1dCBuZWl0aGVyIG9mIHRob3NlIGlzDQo+IGN1
cnJlbnRseSB0cnVlLg0KPiANCj4gSXQncyB0cnVlIHRoYXQgd2Ugc2hvdWxkIGJlIHNtYXJ0ZXIg
YWJvdXQgUENJQklPU19NSU5fTUVNL19JTywgYnV0IEkNCj4gZG9uJ3QgdGhpbmsgdGhhdCBoYXMg
YW55dGhpbmcgdG8gZG8gd2l0aCB3aGV0aGVyIHdlIHN1cHBvcnQgKm1vdmluZyoNCj4gQkFScy4g
IFdlIGhhdmUgdG8gYXZvaWQgdGhlIGFkZHJlc3Mgc3BhY2UgdGhhdCdzIGFscmVhZHkgaW4gdXNl
IGluDQo+ICphbGwqIGNhc2VzLg0KPiANCg0KVGhpcyBpcyBjb25uZWN0ZWQgdG8gdGhlIGFwcHJv
YWNoIG9mIHRoaXMgZmVhdHVyZTogcmVsZWFzaW5nLA0KcmVjYWxjdWxhdGluZyBhbmQgcmVhc3Np
Z25pbmcgdGhlIEJBUnMgYW5kIGJyaWRnZSB3aW5kb3dzLiBJZiBtb3ZhYmxlDQpCQVJzIGFyZSBk
aXNhYmxlZCwgdGhpcyBidWcgZG9lc24ndCByZXByb2R1Y2UuIEFuZCB0aGUgYnVnIGRvZXNuJ3Qg
bGV0DQp0aGUgc3lzdGVtIGJvb3Qgd2hlbiBCQVJzIGFyZSBhbGxvd2VkIHRvIG1vdmUuIFRoYXQn
cyB3aHkgSSd2ZSB0aWVkDQp0aGVzZSB0b2dldGhlci4NCg0KVGhpcyBsaW5lIHNldHRpbmcgdGhl
ICJtaW4iIHRvIFBDSUJJT1NfTUlOXyogaXMgdGhlcmUgdW50b3VjaGVkIHNpbmNlDQp0aGUgZmly
c3Qga2VybmVsIGdpdCBjb21taXQgaW4gMjAwNSAtIGNvdWxkIGl0IGJlIHRoYXQgYWxsIHN5c3Rl
bXMgYXJlDQpqdXN0IGZpbmUgbm93LCBoYXZpbmcgdGhlaXIgcm9vdCBicmlkZ2Ugd2luZG93cyBz
ZXQgdXAgY29ycmVjdGx5Pw0KDQpCZXN0IHJlZ2FyZHMsDQpTZXJnZQ0KDQo+ID4gIAlpZiAocGNp
X2Nhbl9tb3ZlX2JhcnMgJiYgZGV2LT5zdWJvcmRpbmF0ZSAmJiByZXNubyA+PQ0KPiA+IFBDSV9C
UklER0VfUkVTT1VSQ0VTKSB7DQo+ID4gIAkJc3RydWN0IHBjaV9idXMgKmNoaWxkX2J1cyA9IGRl
di0+c3Vib3JkaW5hdGU7DQo+ID4gLS0gDQo+ID4gMi4yNC4xDQo+ID4gDQo=
