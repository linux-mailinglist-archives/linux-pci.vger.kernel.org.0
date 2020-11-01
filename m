Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6459B2A20A7
	for <lists+linux-pci@lfdr.de>; Sun,  1 Nov 2020 18:54:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727087AbgKARyb (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 1 Nov 2020 12:54:31 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:44588 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727024AbgKARya (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 1 Nov 2020 12:54:30 -0500
X-UUID: 30b0bc9f02f942c0af83a2f2a99bce60-20201102
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=WsQvKHHWSLI7xF1JzIgcRmub4R8wiDN5c/q+ZOqQmyE=;
        b=AkjdE5XrtjDDYnMDqjkVFruHTDFUA++eVqDg90UpavXqCy8kcB6I1x/e9GsnpxKdZBSQdNjY/C73R/PRHfdNS5XF8sa50vZHC3QHD8IAVoyGmyJHNDPhDsGXS/myvxOohv17gSCLNbK8DS8I2xMWCFDdpGMmSWkVYhoH/6+EU5k=;
X-UUID: 30b0bc9f02f942c0af83a2f2a99bce60-20201102
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1826245141; Mon, 02 Nov 2020 01:54:23 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Nov 2020 01:54:20 +0800
Received: from [172.21.77.33] (172.21.77.33) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Nov 2020 01:54:20 +0800
Message-ID: <1604253261.22363.0.camel@mtkswgap22>
Subject: Re: [PATCH] pci: mediatek: fix warning in msi.h
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <frank-w@public-files.de>, <linux-mediatek@lists.infradead.org>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Frank Wunderlich <linux@fw-web.de>,
        <linux-kernel@vger.kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
Date:   Mon, 2 Nov 2020 01:54:21 +0800
In-Reply-To: <87lfflti8q.wl-maz@kernel.org>
References: <20201031140330.83768-1-linux@fw-web.de>
         <878sbm9icl.fsf@nanos.tec.linutronix.de>
         <EC02022C-64CF-4F4B-A0A2-215A0A49E826@public-files.de>
         <87lfflti8q.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.2.3-0ubuntu6 
MIME-Version: 1.0
X-TM-SNTS-SMTP: DFEE9065E4A27B1C12B5A3B4E528B0D7B43E8E7FB97307B71B385155CFFD21FE2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gU3VuLCAyMDIwLTExLTAxIGF0IDExOjQzICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIFN1biwgMDEgTm92IDIwMjAgMDk6MjU6MDQgKzAwMDAsDQo+IEZyYW5rIFd1bmRlcmxpY2gg
PGZyYW5rLXdAcHVibGljLWZpbGVzLmRlPiB3cm90ZToNCj4gPiANCj4gPiBBbSAzMS4gT2t0b2Jl
ciAyMDIwIDIyOjQ5OjE0IE1FWiBzY2hyaWViIFRob21hcyBHbGVpeG5lciA8dGdseEBsaW51dHJv
bml4LmRlPjoNCj4gPiANCj4gPiA+VGhhdCdzIG5vdCBhIGZpeC4gSXQncyBqdXN0IHN1cHJlc3Np
bmcgdGhlIHdhcm5pbmcuDQo+ID4gDQo+ID4gT2sgc29ycnkNCj4gPiANCj4gPiA+U28gaXQgbmVl
ZHMgdG8gYmUgZmlndXJlZCBvdXQgd2h5IHRoZSBkb21haW4gYXNzb2NpYXRpb24gaXMgbm90IHRo
ZXJlLg0KPiA+IA0KPiA+IEl0IGxvb2tzIGxpa2UgZm9yIG10NzYyMyB0aGVyZSBpcyBubyBtc2kg
ZG9tYWluIHNldHVwIChkb25lIHZpYQ0KPiA+IG10a19wY2llX3NldHVwX2lycSBjYWxsYmFjayAr
IG10a19wY2llX2luaXRfaXJxX2RvbWFpbikgaW4gbXRrIHBjaWUNCj4gPiBkcml2ZXIuDQo+IA0K
PiBEb2VzIHRoaXMgbWVhbiB0aGF0IHRoaXMgU29DIG5ldmVyIGhhbmRsZWQgTVNJcyB0aGUgZmly
c3QgcGxhY2U/IFdoaWNoDQo+IHdvdWxkIGV4cGxhaW4gdGhlIHdhcm5pbmcsIGFzIHRoZXJlIGlz
IG5vIE1TSSBkb21haW4gcmVnaXN0ZXJlZCBmb3INCj4gdGhlIGRldmljZSwgYW5kIHdlIGVuZC11
cCBmYWxsaW5nIGJhY2sgdG8gYXJjaF9zZXR1cF9tc2lfaXJxcygpLg0KPiANCj4gSWYgdGhpcyBz
eXN0ZW0gdHJ1bHkgaXMgdW5hYmxlIHRvIGhhbmRsZSBNU0lzLCBvbmUgcG90ZW50aWFsDQo+IHdv
cmthcm91bmQgd291bGQgYmUgdG8gcmVnaXN0ZXIgYSBQQ0ktTVNJIGRvbWFpbiB0aGF0IHdvdWxk
IGFsd2F5cw0KPiBmYWlsIGl0cyBhbGxvY2F0aW9uIHdpdGggLUVOT1NQQy4gSXQgaXMgcmVhbGx5
IHVnbHksIGJ1dCB3b3VsZCBrZWVwDQo+IHRoZSBob3Jyb3IgbG9jYWxpc2VkLiBTZWUgdGhlIHBh
dGNobGV0IGJlbG93LCB3aGljaCBJIGNhbid0IHRlc3QuDQo+IA0KPiBJZiB0aGlzIHNpdHVhdGlv
biBpcyBtb3JlIGNvbW1vbiB0aGFuIHdlIGV4cGVjdCwgd2UgbWF5IG5lZWQgc29tZXRoaW5nDQo+
IGluIGNvcmUgY29kZSBpbnN0ZWFkLg0KPiANCj4gCU0uDQo+IA0KWWVhLCBtdDc2MjMgKG10a19w
Y2llX3NvY192MSkgZG9lcyBub3Qgc3VwcG9ydCBNU0ksIHNvIHRoYXQncyBhIHdheSB0bw0KaGFu
ZGxlIGl0Lg0KDQpARnJhbmssIGNvdWxkIHlvdSBoZWxwIHRvIHRlc3QgaXQ/DQoNClJ5ZGVyDQoN
Cj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jIGIv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gaW5kZXggY2Y0YzE4ZjBj
MjVhLi41Mjc1OGI1NDZkNDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIv
cGNpZS1tZWRpYXRlay5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRp
YXRlay5jDQo+IEBAIC0xNTEsNiArMTUxLDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQ7DQo+ICBz
dHJ1Y3QgbXRrX3BjaWVfc29jIHsNCj4gIAlib29sIG5lZWRfZml4X2NsYXNzX2lkOw0KPiAgCWJv
b2wgbmVlZF9maXhfZGV2aWNlX2lkOw0KPiArCWJvb2wgbm9fbXNpOw0KPiAgCXVuc2lnbmVkIGlu
dCBkZXZpY2VfaWQ7DQo+ICAJc3RydWN0IHBjaV9vcHMgKm9wczsNCj4gIAlpbnQgKCpzdGFydHVw
KShzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCk7DQo+IEBAIC00MzUsNiArNDM2LDkgQEAgc3Rh
dGljIGludCBtdGtfcGNpZV9pcnFfZG9tYWluX2FsbG9jKHN0cnVjdCBpcnFfZG9tYWluICpkb21h
aW4sIHVuc2lnbmVkIGludCB2aXINCj4gIAlzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCA9IGRv
bWFpbi0+aG9zdF9kYXRhOw0KPiAgCXVuc2lnbmVkIGxvbmcgYml0Ow0KPiAgDQo+ICsJaWYgKHBv
cnQtPnBjaWUtPnNvYy0+bm9fbXNpKQ0KPiArCQlyZXR1cm4gLUVOT1NQQzsNCj4gKw0KPiAgCVdB
Uk5fT04obnJfaXJxcyAhPSAxKTsNCj4gIAltdXRleF9sb2NrKCZwb3J0LT5sb2NrKTsNCj4gIA0K
PiBAQCAtOTY2LDExICs5NzAsMTMgQEAgc3RhdGljIGludCBtdGtfcGNpZV9wYXJzZV9wb3J0KHN0
cnVjdCBtdGtfcGNpZSAqcGNpZSwNCj4gIAlwb3J0LT5zbG90ID0gc2xvdDsNCj4gIAlwb3J0LT5w
Y2llID0gcGNpZTsNCj4gIA0KPiAtCWlmIChwY2llLT5zb2MtPnNldHVwX2lycSkgew0KPiArCWlm
IChwY2llLT5zb2MtPnNldHVwX2lycSkNCj4gIAkJZXJyID0gcGNpZS0+c29jLT5zZXR1cF9pcnEo
cG9ydCwgbm9kZSk7DQo+IC0JCWlmIChlcnIpDQo+IC0JCQlyZXR1cm4gZXJyOw0KPiAtCX0NCj4g
KwllbHNlDQo+ICsJCWVyciA9IG10a19wY2llX2FsbG9jYXRlX21zaV9kb21haW5zKHBvcnQpOw0K
PiArDQo+ICsJaWYgKGVycikNCj4gKwkJcmV0dXJuIGVycjsNCj4gIA0KPiAgCUlOSVRfTElTVF9I
RUFEKCZwb3J0LT5saXN0KTsNCj4gIAlsaXN0X2FkZF90YWlsKCZwb3J0LT5saXN0LCAmcGNpZS0+
cG9ydHMpOw0KPiBAQCAtMTE3Myw2ICsxMTc5LDcgQEAgc3RhdGljIGNvbnN0IHN0cnVjdCBkZXZf
cG1fb3BzIG10a19wY2llX3BtX29wcyA9IHsNCj4gIH07DQo+ICANCj4gIHN0YXRpYyBjb25zdCBz
dHJ1Y3QgbXRrX3BjaWVfc29jIG10a19wY2llX3NvY192MSA9IHsNCj4gKwkubm9fbXNpID0gdHJ1
ZSwNCj4gIAkub3BzID0gJm10a19wY2llX29wcywNCj4gIAkuc3RhcnR1cCA9IG10a19wY2llX3N0
YXJ0dXBfcG9ydCwNCj4gIH07DQo+IA0KDQo=

