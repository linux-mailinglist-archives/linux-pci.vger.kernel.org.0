Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1A5F128895A
	for <lists+linux-pci@lfdr.de>; Fri,  9 Oct 2020 14:53:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731912AbgJIMxS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 9 Oct 2020 08:53:18 -0400
Received: from Mailgw01.mediatek.com ([1.203.163.78]:59394 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1730626AbgJIMxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 9 Oct 2020 08:53:18 -0400
X-UUID: a376a1e9fa824645901f0280285af74a-20201009
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=T0Q1hS1atV6ZgjZZgJ8HAejic+x9fuXgQyfpLTiToJ0=;
        b=udTpYlCAxRu1ZXH9avMz0tCdhfuip4oF76AtWAWYp3Uy1VX7wq2/e1QBIMoswzmEI+0yUhH732CdaukDapLTuLCl7OwmevUgEnVrz5eyVaoSo0Gf77BAM7OUV0NCmS17HI+9RBi9jHJz1mOc41KZexaS7LGv3HyqAERPDND9qmk=;
X-UUID: a376a1e9fa824645901f0280285af74a-20201009
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1499188204; Fri, 09 Oct 2020 20:53:07 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Fri, 9 Oct
 2020 20:53:04 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 9 Oct 2020 20:53:04 +0800
Message-ID: <1602247986.31946.7.camel@mhfsdcap03>
Subject: Re: [PATCH v6 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base and irq
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Rob Herring <robh@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>
Date:   Fri, 9 Oct 2020 20:53:06 +0800
In-Reply-To: <20200930152317.GA2891120@bogus>
References: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
         <20200914112659.7091-3-chuanjia.liu@mediatek.com>
         <20200930152317.GA2891120@bogus>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 3F21F7E52E8679CF364EFB6F4570F032D594BEA8EFFEA4739B3B03C72BF09E392000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIwLTA5LTMwIGF0IDEwOjIzIC0wNTAwLCBSb2IgSGVycmluZyB3cm90ZToNCj4g
T24gTW9uLCBTZXAgMTQsIDIwMjAgYXQgMDc6MjY6NTdQTSArMDgwMCwgQ2h1YW5qaWEgTGl1IHdy
b3RlOg0KPiA+IEFkZCBuZXcgbWV0aG9kIHRvIGdldCBzaGFyZWQgcGNpZS1jZmcgYmFzZSBhbmQg
cGNpZSBpcnEgZm9yDQo+ID4gbmV3IGR0cyBmb3JtYXQuDQo+ID4gDQo+ID4gU2lnbmVkLW9mZi1i
eTogQ2h1YW5qaWEgTGl1IDxjaHVhbmppYS5saXVAbWVkaWF0ZWsuY29tPg0KPiA+IEFja2VkLWJ5
OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+ID4gLS0tDQo+ID4gIGRyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jIHwgMjMgKysrKysrKysrKysrKysrKysr
KysrKy0NCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDIyIGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24o
LSkNCj4gPiANCj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLmMgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+IGlu
ZGV4IGNmNGMxOGYwYzI1YS4uNWI5MTVlYjBjZjFlIDEwMDY0NA0KPiA+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29u
dHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gPiBAQCAtMTQsNiArMTQsNyBAQA0KPiA+ICAjaW5j
bHVkZSA8bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPg0KPiA+ICAjaW5jbHVkZSA8bGludXgv
aXJxZG9tYWluLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCj4gPiArI2luY2x1
ZGUgPGxpbnV4L21mZC9zeXNjb24uaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L21zaS5oPg0KPiA+
ICAjaW5jbHVkZSA8bGludXgvbW9kdWxlLmg+DQo+ID4gICNpbmNsdWRlIDxsaW51eC9vZl9hZGRy
ZXNzLmg+DQo+ID4gQEAgLTIzLDYgKzI0LDcgQEANCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BoeS9w
aHkuaD4NCj4gPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiA+ICAjaW5j
bHVkZSA8bGludXgvcG1fcnVudGltZS5oPg0KPiA+ICsjaW5jbHVkZSA8bGludXgvcmVnbWFwLmg+
DQo+ID4gICNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiA+ICANCj4gPiAgI2luY2x1ZGUgIi4u
L3BjaS5oIg0KPiA+IEBAIC0yMDUsNiArMjA3LDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0K
PiA+ICAgKiBzdHJ1Y3QgbXRrX3BjaWUgLSBQQ0llIGhvc3QgaW5mb3JtYXRpb24NCj4gPiAgICog
QGRldjogcG9pbnRlciB0byBQQ0llIGRldmljZQ0KPiA+ICAgKiBAYmFzZTogSU8gbWFwcGVkIHJl
Z2lzdGVyIGJhc2UNCj4gPiArICogQGNmZzogSU8gbWFwcGVkIHJlZ2lzdGVyIG1hcCBmb3IgUENJ
ZSBjb25maWcNCj4gPiAgICogQGZyZWVfY2s6IGZyZWUtcnVuIHJlZmVyZW5jZSBjbG9jaw0KPiA+
ICAgKiBAbWVtOiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSByZXNvdXJjZQ0KPiA+ICAgKiBAcG9y
dHM6IHBvaW50ZXIgdG8gUENJZSBwb3J0IGluZm9ybWF0aW9uDQo+ID4gQEAgLTIxMyw2ICsyMTYs
NyBAQCBzdHJ1Y3QgbXRrX3BjaWVfcG9ydCB7DQo+ID4gIHN0cnVjdCBtdGtfcGNpZSB7DQo+ID4g
IAlzdHJ1Y3QgZGV2aWNlICpkZXY7DQo+ID4gIAl2b2lkIF9faW9tZW0gKmJhc2U7DQo+ID4gKwlz
dHJ1Y3QgcmVnbWFwICpjZmc7DQo+ID4gIAlzdHJ1Y3QgY2xrICpmcmVlX2NrOw0KPiA+ICANCj4g
PiAgCXN0cnVjdCBsaXN0X2hlYWQgcG9ydHM7DQo+ID4gQEAgLTY0OCw3ICs2NTIsMTEgQEAgc3Rh
dGljIGludCBtdGtfcGNpZV9zZXR1cF9pcnEoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQsDQo+
ID4gIAkJcmV0dXJuIGVycjsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlwb3J0LT5pcnEgPSBwbGF0
Zm9ybV9nZXRfaXJxKHBkZXYsIHBvcnQtPnNsb3QpOw0KPiA+ICsJaWYgKG9mX2ZpbmRfcHJvcGVy
dHkoZGV2LT5vZl9ub2RlLCAiaW50ZXJydXB0LW5hbWVzIiwgTlVMTCkpDQo+ID4gKwkJcG9ydC0+
aXJxID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwgInBjaWVfaXJxIik7DQo+IA0KPiBO
b3QgcmVhbGx5IGFueSBwb2ludCBpbiBoYXZpbmcgYSBuYW1lIHdpdGggYSBzaW5nbGUgaW50ZXJy
dXB0Lg0KPiANCj4gPiArCWVsc2UNCj4gPiArCQlwb3J0LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJx
KHBkZXYsIHBvcnQtPnNsb3QpOw0KPiANCj4gV2l0aCB0aGUgbmV3IGJpbmRpbmcsIHNsb3QgaXMg
YWx3YXlzIDAsIHJpZ2h0PyBUaGVuIHlvdSBkb24ndCBuZWVkIGFueSANCj4gY2hhbmdlIGhlcmUu
DQpJbiB0aGUgbmV3IGJpbmRpbmcsIFBDSWUxIHNsb3QgbnVtYmVyIGlzIDEuDQpCZWNhdXNlIHNv
bWUgc2V0dGluZyBpbiB0aGUgZHJpdmVyIGlzIGJhc2VkIG9uIHNsb3QgbnVtYmVyIHRvIGRldGVy
bWluZQ0Kb2Zmc2V0LCB0aGlzIGlzIHRvIHJlZHVjZSBkcml2ZXIgY2hhbmdlcyBhbmQgYmUgY29t
cGF0aWJsZSB3aXRoIG5ldyBhbmQNCm9sZCBEVFMgZm9ybWF0Lg0KPiANCj4gPiArDQo+ID4gIAlp
ZiAocG9ydC0+aXJxIDwgMCkNCj4gPiAgCQlyZXR1cm4gcG9ydC0+aXJxOw0KPiA+ICANCj4gPiBA
QCAtNjgwLDYgKzY4OCwxMCBAQCBzdGF0aWMgaW50IG10a19wY2llX3N0YXJ0dXBfcG9ydF92Mihz
dHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCkNCj4gPiAgCQl2YWwgfD0gUENJRV9DU1JfTFRTU01f
RU4ocG9ydC0+c2xvdCkgfA0KPiA+ICAJCSAgICAgICBQQ0lFX0NTUl9BU1BNX0wxX0VOKHBvcnQt
PnNsb3QpOw0KPiA+ICAJCXdyaXRlbCh2YWwsIHBjaWUtPmJhc2UgKyBQQ0lFX1NZU19DRkdfVjIp
Ow0KPiA+ICsJfSBlbHNlIGlmIChwY2llLT5jZmcpIHsNCj4gPiArCQl2YWwgPSBQQ0lFX0NTUl9M
VFNTTV9FTihwb3J0LT5zbG90KSB8DQo+ID4gKwkJICAgICAgUENJRV9DU1JfQVNQTV9MMV9FTihw
b3J0LT5zbG90KTsNCj4gPiArCQlyZWdtYXBfdXBkYXRlX2JpdHMocGNpZS0+Y2ZnLCBQQ0lFX1NZ
U19DRkdfVjIsIHZhbCwgdmFsKTsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gIAkvKiBBc3NlcnQgYWxs
IHJlc2V0IHNpZ25hbHMgKi8NCj4gPiBAQCAtOTgzLDYgKzk5NSw3IEBAIHN0YXRpYyBpbnQgbXRr
X3BjaWVfc3Vic3lzX3Bvd2VydXAoc3RydWN0IG10a19wY2llICpwY2llKQ0KPiA+ICAJc3RydWN0
IGRldmljZSAqZGV2ID0gcGNpZS0+ZGV2Ow0KPiA+ICAJc3RydWN0IHBsYXRmb3JtX2RldmljZSAq
cGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiA+ICAJc3RydWN0IHJlc291cmNlICpy
ZWdzOw0KPiA+ICsJc3RydWN0IGRldmljZV9ub2RlICpjZmdfbm9kZTsNCj4gPiAgCWludCBlcnI7
DQo+ID4gIA0KPiA+ICAJLyogZ2V0IHNoYXJlZCByZWdpc3RlcnMsIHdoaWNoIGFyZSBvcHRpb25h
bCAqLw0KPiA+IEBAIC05OTUsNiArMTAwOCwxNCBAQCBzdGF0aWMgaW50IG10a19wY2llX3N1YnN5
c19wb3dlcnVwKHN0cnVjdCBtdGtfcGNpZSAqcGNpZSkNCj4gPiAgCQl9DQo+ID4gIAl9DQo+ID4g
IA0KPiA+ICsJY2ZnX25vZGUgPSBvZl9maW5kX2NvbXBhdGlibGVfbm9kZShOVUxMLCBOVUxMLA0K
PiA+ICsJCQkJCSAgICJtZWRpYXRlayxnZW5lcmljLXBjaWVjZmciKTsNCj4gPiArCWlmIChjZmdf
bm9kZSkgew0KPiA+ICsJCXBjaWUtPmNmZyA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChjZmdfbm9k
ZSk7DQo+ID4gKwkJaWYgKElTX0VSUihwY2llLT5jZmcpKQ0KPiA+ICsJCQlyZXR1cm4gUFRSX0VS
UihwY2llLT5jZmcpOw0KPiA+ICsJfQ0KPiA+ICsNCj4gPiAgCXBjaWUtPmZyZWVfY2sgPSBkZXZt
X2Nsa19nZXQoZGV2LCAiZnJlZV9jayIpOw0KPiA+ICAJaWYgKElTX0VSUihwY2llLT5mcmVlX2Nr
KSkgew0KPiA+ICAJCWlmIChQVFJfRVJSKHBjaWUtPmZyZWVfY2spID09IC1FUFJPQkVfREVGRVIp
DQo+ID4gLS0gDQo+ID4gMi4xOC4wDQoNCg==

