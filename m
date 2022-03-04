Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 862274CCB4E
	for <lists+linux-pci@lfdr.de>; Fri,  4 Mar 2022 02:30:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235856AbiCDBbY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Mar 2022 20:31:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234473AbiCDBbX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Mar 2022 20:31:23 -0500
Received: from gate2.alliedtelesis.co.nz (gate2.alliedtelesis.co.nz [IPv6:2001:df5:b000:5::4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D86E4616E
        for <linux-pci@vger.kernel.org>; Thu,  3 Mar 2022 17:30:36 -0800 (PST)
Received: from svr-chch-seg1.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 15AB12C0B90;
        Fri,  4 Mar 2022 01:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1646357430;
        bh=WxWNOPjRdYh/JVu+ZBp7sF5khIVMCO6Kbl2Q4xhS05I=;
        h=From:To:CC:Subject:Date:References:In-Reply-To:From;
        b=H/hL4xEraAETeTp3XP76WqXjt5cbu8Y6dcynjlOoSwP5GZ1CID+jTJlLBMmubTmq8
         yXH6XRf5cBvqNIi9Yb8J/xAeOaY48h/diDQZgJeGRvYAGXSGJ/RzU97XwXRJyCxYg7
         GbZnyBV9Ftiaz3Wkx8b5u+fB6ULERNP8lZjA0YjpPu23jhZrpuwGOxXhIksplkBPOj
         62NBRduDnMBy0yIkuYG4fZWfnEr7MTKzVLwUiHfEUsz0XYrtEDrcfeBgkUd8fZ/5k7
         rnt3uDwWOpeHLTYTlOoPm2RoDPi1H/CSNFwtdfRa/GUlKLtGneIO9GKjSeYj0+VBUf
         kamMqNze3wX9A==
Received: from svr-chch-ex1.atlnz.lc (Not Verified[2001:df5:b000:bc8::77]) by svr-chch-seg1.atlnz.lc with Trustwave SEG (v8,2,6,11305)
        id <B62216bb50001>; Fri, 04 Mar 2022 14:30:29 +1300
Received: from svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8)
 by svr-chch-ex1.atlnz.lc (2001:df5:b000:bc8:409d:36f5:8899:92e8) with
 Microsoft SMTP Server (TLS) id 15.0.1497.28; Fri, 4 Mar 2022 14:30:29 +1300
Received: from svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8]) by
 svr-chch-ex1.atlnz.lc ([fe80::409d:36f5:8899:92e8%12]) with mapi id
 15.00.1497.028; Fri, 4 Mar 2022 14:30:29 +1300
From:   Chris Packham <Chris.Packham@alliedtelesis.co.nz>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Mark Tomlinson <Mark.Tomlinson@alliedtelesis.co.nz>
CC:     "ray.jui@broadcom.com" <ray.jui@broadcom.com>,
        "sbranden@broadcom.com" <sbranden@broadcom.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "robh@kernel.org" <robh@kernel.org>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
Thread-Topic: [PATCH v4] PCI: Reduce warnings on possible RW1C corruption
Thread-Index: AQHYL2duvQH9Acig/EShRiGLv00N8w==
Date:   Fri, 4 Mar 2022 01:30:29 +0000
Message-ID: <679ac5f4-d6b7-5c94-39d5-441c68576911@alliedtelesis.co.nz>
References: <20200820221142.GA1571008@bjorn-Precision-5520>
In-Reply-To: <20200820221142.GA1571008@bjorn-Precision-5520>
Accept-Language: en-NZ, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-messagesentrepresentingtype: 1
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.32.1.11]
Content-Type: text/plain; charset="utf-8"
Content-ID: <8674ECF46E283A43A0823E9CE0923816@atlnz.lc>
Content-Transfer-Encoding: base64
MIME-Version: 1.0
X-SEG-SpamProfiler-Analysis: v=2.3 cv=c43Vvi1l c=1 sm=1 tr=0 a=Xf/6aR1Nyvzi7BryhOrcLQ==:117 a=xqWC_Br6kY4A:10 a=oKJsc7D3gJEA:10 a=IkcTkHD0fZMA:10 a=o8Y5sQTvuykA:10 a=VwQbUJbxAAAA:8 a=73XRR-X3sCTW9Fgc-S8A:9 a=QEXdDO2ut3YA:10 a=XuX4-iSP0wQA:10 a=AjGcO6oz07-iQ99wixmX:22
X-SEG-SpamProfiler-Score: 0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQWxsLA0KDQpPbiAyMS8wOC8yMCAxMDoxMSwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gT24g
VGh1LCBBdWcgMDYsIDIwMjAgYXQgMDQ6MTQ6NTVQTSArMTIwMCwgTWFyayBUb21saW5zb24gd3Jv
dGU6DQo+PiBGb3IgaGFyZHdhcmUgdGhhdCBvbmx5IHN1cHBvcnRzIDMyLWJpdCB3cml0ZXMgdG8g
UENJIHRoZXJlIGlzIHRoZQ0KPj4gcG9zc2liaWxpdHkgb2YgY2xlYXJpbmcgUlcxQyAod3JpdGUt
b25lLXRvLWNsZWFyKSBiaXRzLiBBIHJhdGUtbGltaXRlZA0KPj4gbWVzc2FnZXMgd2FzIGludHJv
ZHVjZWQgYnkgZmIyNjU5MjMwMTIwLCBidXQgcmF0ZS1saW1pdGluZyBpcyBub3QgdGhlDQo+PiBi
ZXN0IGNob2ljZSBoZXJlLiBTb21lIGRldmljZXMgbWF5IG5vdCBzaG93IHRoZSB3YXJuaW5ncyB0
aGV5IHNob3VsZCBpZg0KPj4gYW5vdGhlciBkZXZpY2UgaGFzIGp1c3QgcHJvZHVjZWQgYSBidW5j
aCBvZiB3YXJuaW5ncy4gQWxzbywgdGhlIG51bWJlcg0KPj4gb2YgbWVzc2FnZXMgY2FuIGJlIGEg
bnVpc2FuY2Ugb24gZGV2aWNlcyB3aGljaCBhcmUgb3RoZXJ3aXNlIHdvcmtpbmcNCj4+IGZpbmUu
DQo+Pg0KPj4gVGhpcyBwYXRjaCBjaGFuZ2VzIHRoZSByYXRlbGltaXQgdG8gYSBzaW5nbGUgd2Fy
bmluZyBwZXIgYnVzLiBUaGlzDQo+PiBlbnN1cmVzIG5vIGJ1cyBpcyAnc3RhcnZlZCcgb2YgZW1p
dHRpbmcgYSB3YXJuaW5nIGFuZCBhbHNvIHRoYXQgdGhlcmUNCj4+IGlzbid0IGEgY29udGludW91
cyBzdHJlYW0gb2Ygd2FybmluZ3MuIEl0IHdvdWxkIGJlIHByZWZlcmFibGUgdG8gaGF2ZSBhDQo+
PiB3YXJuaW5nIHBlciBkZXZpY2UsIGJ1dCB0aGUgcGNpX2RldiBzdHJ1Y3R1cmUgaXMgbm90IGF2
YWlsYWJsZSBoZXJlLCBhbmQNCj4+IGEgbG9va3VwIGZyb20gZGV2Zm4gd291bGQgYmUgZmFyIHRv
byBzbG93Lg0KPj4NCj4+IFN1Z2dlc3RlZC1ieTogQmpvcm4gSGVsZ2FhcyA8aGVsZ2Fhc0BrZXJu
ZWwub3JnPg0KPj4gRml4ZXM6IGZiMjY1OTIzMDEyMCAoIlBDSTogV2FybiBvbiBwb3NzaWJsZSBS
VzFDIGNvcnJ1cHRpb24gZm9yIHN1Yi0zMiBiaXQgY29uZmlnIHdyaXRlcyIpDQo+PiBTaWduZWQt
b2ZmLWJ5OiBNYXJrIFRvbWxpbnNvbiA8bWFyay50b21saW5zb25AYWxsaWVkdGVsZXNpcy5jby5u
ej4NCj4gQXBwbGllZCB3aXRoIGNvbGxlY3RlZCByZXZpZXdzL2Fja3MgdG8gcGNpL2VudW1lcmF0
aW9uIGZvciB2NS4xMCwNCj4gdGhhbmtzIQ0KDQpXaGF0ZXZlciBoYXBwZW5lZCB0byB0aGlzIGNo
YW5nZT8NCg0KSSdtIGp1c3QgZ29pbmcgdGhyb3VnaCBvdXIgcXVldWUgb2YgcGF0Y2hlcyB0aGF0
IGhhdmUgYmVlbiBzZW50IHVwc3RyZWFtIA0KYW5kIGV4cGVjdGVkIHRoaXMgb25lIHRvIGJlIGdv
bmUgYWZ0ZXIgd2UgcHVsbGVkIHY1LjEwLiBMb29raW5nIGF0IA0KTGludXMncyB0cmVlIEkgZG9u
J3Qgc2VlIGl0IGV2ZXIgaGF2aW5nIGJlZW4gYXBwbGllZC4gSSBjb3VsZG4ndCBzZWUgDQphbnl0
aGluZyBvbiB0aGUgcmVsZXZhbnQgbWFpbGluZyBsaXN0cyBzdWdnZXN0aW5nIHRoYXQgdGhlcmUg
d2FzIGEgDQpwcm9ibGVtIHdpdGggdGhpcyBjaGFuZ2Ugc28gSSdtIGp1c3Qgd29uZGVyaW5nIHdo
YXQncyBoYXBwZW5lZCB0byBpdD8NCg0KPj4gLS0tDQo+PiBjaGFuZ2VzIGluIHY0Og0KPj4gICAt
IFVzZSBiaXRmaWVsZCByYXRoZXIgdGhhbiBib29sIHRvIHNhdmUgbWVtb3J5ICh3YXMgbWVhbnQg
dG8gYmUgaW4gdjMpLg0KPj4NCj4+ICAgZHJpdmVycy9wY2kvYWNjZXNzLmMgfCA5ICsrKysrKy0t
LQ0KPj4gICBpbmNsdWRlL2xpbnV4L3BjaS5oICB8IDEgKw0KPj4gICAyIGZpbGVzIGNoYW5nZWQs
IDcgaW5zZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCj4+DQo+PiBkaWZmIC0tZ2l0IGEvZHJp
dmVycy9wY2kvYWNjZXNzLmMgYi9kcml2ZXJzL3BjaS9hY2Nlc3MuYw0KPj4gaW5kZXggNzljNGEy
ZWYyNjlhLi5iNDUyNDY3ZmQxMzMgMTAwNjQ0DQo+PiAtLS0gYS9kcml2ZXJzL3BjaS9hY2Nlc3Mu
Yw0KPj4gKysrIGIvZHJpdmVycy9wY2kvYWNjZXNzLmMNCj4+IEBAIC0xNjAsOSArMTYwLDEyIEBA
IGludCBwY2lfZ2VuZXJpY19jb25maWdfd3JpdGUzMihzdHJ1Y3QgcGNpX2J1cyAqYnVzLCB1bnNp
Z25lZCBpbnQgZGV2Zm4sDQo+PiAgIAkgKiB3cml0ZSBoYXBwZW4gdG8gaGF2ZSBhbnkgUlcxQyAo
d3JpdGUtb25lLXRvLWNsZWFyKSBiaXRzIHNldCwgd2UNCj4+ICAgCSAqIGp1c3QgaW5hZHZlcnRl
bnRseSBjbGVhcmVkIHNvbWV0aGluZyB3ZSBzaG91bGRuJ3QgaGF2ZS4NCj4+ICAgCSAqLw0KPj4g
LQlkZXZfd2Fybl9yYXRlbGltaXRlZCgmYnVzLT5kZXYsICIlZC1ieXRlIGNvbmZpZyB3cml0ZSB0
byAlMDR4OiUwMng6JTAyeC4lZCBvZmZzZXQgJSN4IG1heSBjb3JydXB0IGFkamFjZW50IFJXMUMg
Yml0c1xuIiwNCj4+IC0JCQkgICAgIHNpemUsIHBjaV9kb21haW5fbnIoYnVzKSwgYnVzLT5udW1i
ZXIsDQo+PiAtCQkJICAgICBQQ0lfU0xPVChkZXZmbiksIFBDSV9GVU5DKGRldmZuKSwgd2hlcmUp
Ow0KPj4gKwlpZiAoIWJ1cy0+dW5zYWZlX3dhcm4pIHsNCj4+ICsJCWRldl93YXJuKCZidXMtPmRl
diwgIiVkLWJ5dGUgY29uZmlnIHdyaXRlIHRvICUwNHg6JTAyeDolMDJ4LiVkIG9mZnNldCAlI3gg
bWF5IGNvcnJ1cHQgYWRqYWNlbnQgUlcxQyBiaXRzXG4iLA0KPj4gKwkJCSBzaXplLCBwY2lfZG9t
YWluX25yKGJ1cyksIGJ1cy0+bnVtYmVyLA0KPj4gKwkJCSBQQ0lfU0xPVChkZXZmbiksIFBDSV9G
VU5DKGRldmZuKSwgd2hlcmUpOw0KPj4gKwkJYnVzLT51bnNhZmVfd2FybiA9IDE7DQo+PiArCX0N
Cj4+ICAgDQo+PiAgIAltYXNrID0gfigoKDEgPDwgKHNpemUgKiA4KSkgLSAxKSA8PCAoKHdoZXJl
ICYgMHgzKSAqIDgpKTsNCj4+ICAgCXRtcCA9IHJlYWRsKGFkZHIpICYgbWFzazsNCj4+IGRpZmYg
LS1naXQgYS9pbmNsdWRlL2xpbnV4L3BjaS5oIGIvaW5jbHVkZS9saW51eC9wY2kuaA0KPj4gaW5k
ZXggMzRjMWM0ZjQ1Mjg4Li44NTIxMWE3ODdmOGIgMTAwNjQ0DQo+PiAtLS0gYS9pbmNsdWRlL2xp
bnV4L3BjaS5oDQo+PiArKysgYi9pbmNsdWRlL2xpbnV4L3BjaS5oDQo+PiBAQCAtNjI2LDYgKzYy
Niw3IEBAIHN0cnVjdCBwY2lfYnVzIHsNCj4+ICAgCXN0cnVjdCBiaW5fYXR0cmlidXRlCSpsZWdh
Y3lfaW87CS8qIExlZ2FjeSBJL08gZm9yIHRoaXMgYnVzICovDQo+PiAgIAlzdHJ1Y3QgYmluX2F0
dHJpYnV0ZQkqbGVnYWN5X21lbTsJLyogTGVnYWN5IG1lbSAqLw0KPj4gICAJdW5zaWduZWQgaW50
CQlpc19hZGRlZDoxOw0KPj4gKwl1bnNpZ25lZCBpbnQJCXVuc2FmZV93YXJuOjE7CS8qIHdhcm5l
ZCBhYm91dCBSVzFDIGNvbmZpZyB3cml0ZSAqLw0KPj4gICB9Ow0KPj4gICANCj4+ICAgI2RlZmlu
ZSB0b19wY2lfYnVzKG4pCWNvbnRhaW5lcl9vZihuLCBzdHJ1Y3QgcGNpX2J1cywgZGV2KQ0KPj4g
LS0gDQo+PiAyLjI4LjANCj4+
