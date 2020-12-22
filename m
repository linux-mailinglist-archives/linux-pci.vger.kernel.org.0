Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 07D5B2E0756
	for <lists+linux-pci@lfdr.de>; Tue, 22 Dec 2020 09:39:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726138AbgLVIjJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 22 Dec 2020 03:39:09 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:21857 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726016AbgLVIjJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 22 Dec 2020 03:39:09 -0500
X-UUID: 64f217b91d514130a255023e82a56a98-20201222
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=YLfMy68wBB6UlNustrhsqE6gJYC3N0UvKOcE4aN9Y+k=;
        b=VaN4Cy8Rsgdt8m3E+NW3DBk5X+RJNigwT5q0LkDBbPNHO6Fn/wEt1LIvYhyI8zzwfbAwoUHFX/ULirsOEcUGiCC2A72ajK0Y8VQqwOz2WhLbo5Xp8VeKTm4rbFXt5qPbY6tvnquxpz1jT8UmkfVS4bx4kPJNi62d1foZQW/nWFI=;
X-UUID: 64f217b91d514130a255023e82a56a98-20201222
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1489639674; Tue, 22 Dec 2020 16:38:20 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31DR.mediatek.inc
 (172.27.6.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 22 Dec
 2020 16:38:16 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 22 Dec 2020 16:38:15 +0800
Message-ID: <1608626297.14736.113.camel@mhfsdcap03>
Subject: Re: [v5,2/3] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Nicolas Boichat <drinkcat@chromium.org>
CC:     <youlin.pei@mediatek.com>,
        Devicetree List <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <qizhong.cheng@mediatek.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-pci@vger.kernel.org>, lkml <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        "Bjorn Helgaas" <bhelgaas@google.com>,
        Sj Huang <sj.huang@mediatek.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        "moderated list:ARM/Mediatek SoC support" 
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <sin_jieyang@mediatek.com>,
        "David S . Miller" <davem@davemloft.net>,
        linux-arm Mailing List <linux-arm-kernel@lists.infradead.org>
Date:   Tue, 22 Dec 2020 16:38:17 +0800
In-Reply-To: <CANMq1KB3UXg8QKwuv3mFaodx-s_AXSrOWp6C+RN7LaA69nsTyg@mail.gmail.com>
References: <20201202133813.6917-1-jianjun.wang@mediatek.com>
         <20201202133813.6917-3-jianjun.wang@mediatek.com>
         <CANMq1KCSWf4PDMVhxFiLHOHe3dFqZbq1gzn4ph8aApVMX56MDg@mail.gmail.com>
         <1608608319.14736.97.camel@mhfsdcap03>
         <CANMq1KB3UXg8QKwuv3mFaodx-s_AXSrOWp6C+RN7LaA69nsTyg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 00173604EC7CD22A602B7873EB32C70165C8892601EF854DADCCF59B40BAB8542000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIwLTEyLTIyIGF0IDExOjU1ICswODAwLCBOaWNvbGFzIEJvaWNoYXQgd3JvdGU6
DQo+IE9uIFR1ZSwgRGVjIDIyLCAyMDIwIGF0IDExOjM4IEFNIEppYW5qdW4gV2FuZyA8amlhbmp1
bi53YW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4NCj4gPiBPbiBNb24sIDIwMjAtMTItMjEg
YXQgMTA6MTggKzA4MDAsIE5pY29sYXMgQm9pY2hhdCB3cm90ZToNCj4gPiA+IE9uIFdlZCwgRGVj
IDIsIDIwMjAgYXQgOTozOSBQTSBKaWFuanVuIFdhbmcgPGppYW5qdW4ud2FuZ0BtZWRpYXRlay5j
b20+IHdyb3RlOg0KPiA+ID4gPiBbc25pcF0NCj4gPiA+ID4gK3N0YXRpYyBpcnFfaHdfbnVtYmVy
X3QgbXRrX3BjaWVfbXNpX2dldF9od2lycShzdHJ1Y3QgbXNpX2RvbWFpbl9pbmZvICppbmZvLA0K
PiA+ID4gPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgbXNp
X2FsbG9jX2luZm9fdCAqYXJnKQ0KPiA+ID4gPiArew0KPiA+ID4gPiArICAgICAgIHN0cnVjdCBt
c2lfZGVzYyAqZW50cnkgPSBhcmctPmRlc2M7DQo+ID4gPiA+ICsgICAgICAgc3RydWN0IG10a19w
Y2llX3BvcnQgKnBvcnQgPSBpbmZvLT5jaGlwX2RhdGE7DQo+ID4gPiA+ICsgICAgICAgaW50IGh3
aXJxOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAgbXV0ZXhfbG9jaygmcG9ydC0+bG9jayk7
DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAgICAgICBod2lycSA9IGJpdG1hcF9maW5kX2ZyZWVfcmVn
aW9uKHBvcnQtPm1zaV9pcnFfaW5fdXNlLCBQQ0lFX01TSV9JUlFTX05VTSwNCj4gPiA+ID4gKyAg
ICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgIG9yZGVyX2Jhc2VfMihlbnRyeS0+
bnZlY191c2VkKSk7DQo+ID4gPiA+ICsgICAgICAgaWYgKGh3aXJxIDwgMCkgew0KPiA+ID4gPiAr
ICAgICAgICAgICAgICAgbXV0ZXhfdW5sb2NrKCZwb3J0LT5sb2NrKTsNCj4gPiA+ID4gKyAgICAg
ICAgICAgICAgIHJldHVybiAtRU5PU1BDOw0KPiA+ID4gPiArICAgICAgIH0NCj4gPiA+ID4gKw0K
PiA+ID4gPiArICAgICAgIG11dGV4X3VubG9jaygmcG9ydC0+bG9jayk7DQo+ID4gPiA+ICsNCj4g
PiA+ID4gKyAgICAgICByZXR1cm4gaHdpcnE7DQo+ID4gPg0KPiA+ID4gQ29kZSBpcyBnb29kLCBi
dXQgSSBoYWQgdG8gbG9vayB0d2ljZSB0byBtYWtlIHN1cmUgdGhlIG11dGV4IGlzDQo+ID4gPiB1
bmxvY2tlZC4gSXMgdGhlIGZvbGxvd2luZyBtYXJnaW5hbGx5IGJldHRlcj8NCj4gPiA+DQo+ID4g
PiBod2lycSA9IC4uLjsNCj4gPiA+DQo+ID4gPiBtdXRleF91bmxvY2soJnBvcnQtPmxvY2spOw0K
PiA+ID4NCj4gPiA+IGlmIChod2lycSA8IDApDQo+ID4gPiAgICByZXR1cm4gLUVOT1NQQzsNCj4g
PiA+DQo+ID4gPiByZXR1cm4gaHdpcnE7DQo+ID4NCj4gPiBJbXByZXNzaXZlLCBJIHdpbGwgZml4
IGl0IGluIHRoZSBuZXh0IHZlcnNpb24sIGFuZCBJIHRoaW5rIHRoZSBod2lycSBjYW4NCj4gPiBi
ZSByZXR1cm5lZCBkaXJlY3RseSBzaW5jZSBpdCB3aWxsIGJlIGEgbmVnYXRpdmUgdmFsdWUgaWYN
Cj4gPiBiaXRtYXBfZmluZF9mcmVlX3JlZ2lvbiBpcyBmYWlsZWQuIFRoZSBjb2RlIHdpbGwgYmUg
bGlrZSB0aGUgZm9sbG93aW5nOg0KPiA+DQo+ID4gaHdpcnEgPSAuLi47DQo+ID4NCj4gPiBtdXRl
eF91bmxvY2soJnBvcnQtPmxvY2spOw0KPiA+DQo+ID4gcmV0dXJuIGh3aXJxOw0KPiANCj4gU0cs
IGFzIGxvbmcgYXMgeW91J3JlIG9rYXkgd2l0aCByZXR1cm5pbmcgLUVOT01FTSBpbnN0ZWFkIG9m
IC1FTk9TUEMuDQo+IA0KPiBCdXQgbm93IEknbSBoYXZpbmcgZG91YnQgaWYgbmVnYXRpdmUgcmV0
dXJuIHZhbHVlcyBhcmUgb2ssIGFzDQo+IGlycV9od19udW1iZXJfdCBpcyB1bnNpZ25lZCBsb25n
Lg0KPiANCj4gbXNpX2RvbWFpbl9hbGxvYw0KPiAoaHR0cHM6Ly9lbGl4aXIuYm9vdGxpbi5jb20v
bGludXgvbGF0ZXN0L3NvdXJjZS9rZXJuZWwvaXJxL21zaS5jI0wxNDMpDQo+IHVzZXMgaXQgdG8g
Y2FsbCBpcnFfZmluZF9tYXBwaW5nDQo+IChodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51
eC9sYXRlc3Qvc291cmNlL2tlcm5lbC9pcnEvaXJxZG9tYWluLmMjTDg4MikNCj4gd2l0aG91dCBj
aGVjaywgYW5kIEknbSBub3QgY29udmluY2VkIGlycV9maW5kX21hcHBpbmcgd2lsbCBlcnJvciBv
dXQNCj4gZ3JhY2VmdWxseS4uLg0KPiANCkkgc2VlLCBpdCBzZWVtcyB0aGUgbXNpX2RvbWFpbl9h
bGxvYyBmdW5jdGlvbiBhc3N1bWUgdGhlIGdldF9od2lycQ0KY2FsbGJhY2sgYWx3YXlzIHN1Y2Nl
c3MsIG1heWJlIEkgc2hvdWxkIGFsbG9jYXRlIHRoZSByZWFsIGh3aXJxIGluIHRoZQ0KbXNpX3By
ZXBhcmUNCihodHRwczovL2VsaXhpci5ib290bGluLmNvbS9saW51eC9sYXRlc3Qvc291cmNlL2tl
cm5lbC9pcnEvbXNpLmMjTDMwNCkNCmFuZCBzZXQgaXQgdG8gYXJnLT5od2lycSwgYW5kIG92ZXJy
aWRlIHRoZSBzZXRfZGVzYw0KKGh0dHBzOi8vZWxpeGlyLmJvb3RsaW4uY29tL2xpbnV4L2xhdGVz
dC9zb3VyY2UvZHJpdmVycy9wY2kvbXNpLmMjTDE0MDUpDQp0byBwcmV2ZW50IHRoZSBtb2RpZnkg
b2YgYXJnLT5od2lycS4NCg0KPiA+ID4NCj4gPiA+ID4gK30NCj4gPiA+ID4gKw0KPiA+ID4gPiBb
c25pcF0NCj4gPiA+ID4gK3N0YXRpYyB2b2lkIG10a19wY2llX21zaV9oYW5kbGVyKHN0cnVjdCBp
cnFfZGVzYyAqZGVzYykNCj4gPiA+ID4gK3sNCj4gPiA+ID4gKyAgICAgICBzdHJ1Y3QgbXRrX3Bj
aWVfbXNpICptc2lfaW5mbyA9IGlycV9kZXNjX2dldF9oYW5kbGVyX2RhdGEoZGVzYyk7DQo+ID4g
PiA+ICsgICAgICAgc3RydWN0IGlycV9jaGlwICppcnFjaGlwID0gaXJxX2Rlc2NfZ2V0X2NoaXAo
ZGVzYyk7DQo+ID4gPiA+ICsgICAgICAgdW5zaWduZWQgbG9uZyBtc2lfZW5hYmxlLCBtc2lfc3Rh
dHVzOw0KPiA+ID4gPiArICAgICAgIHVuc2lnbmVkIGludCB2aXJxOw0KPiA+ID4gPiArICAgICAg
IGlycV9od19udW1iZXJfdCBiaXQsIGh3aXJxOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsgICAgICAg
Y2hhaW5lZF9pcnFfZW50ZXIoaXJxY2hpcCwgZGVzYyk7DQo+ID4gPiA+ICsNCj4gPiA+ID4gKyAg
ICAgICBtc2lfZW5hYmxlID0gcmVhZGwobXNpX2luZm8tPmJhc2UgKyBQQ0lFX01TSV9FTkFCTEVf
T0ZGU0VUKTsNCj4gPiA+ID4gKyAgICAgICB3aGlsZSAoKG1zaV9zdGF0dXMgPSByZWFkbChtc2lf
aW5mby0+YmFzZSArIFBDSUVfTVNJX1NUQVRVU19PRkZTRVQpKSkgew0KPiA+ID4gPiArICAgICAg
ICAgICAgICAgbXNpX3N0YXR1cyAmPSBtc2lfZW5hYmxlOw0KPiA+ID4NCj4gPiA+IEkgZG9uJ3Qg
a25vdyBtdWNoIGFib3V0IE1TSSwgYnV0IHdoYXQgaGFwcGVucyBpZiB5b3UgaGF2ZSBhIGJpdCB0
aGF0DQo+ID4gPiBpcyBzZXQgaW4gUENJRV9NU0lfU1RBVFVTX09GRlNFVCByZWdpc3RlciwgYnV0
IG5vdCBpbiBtc2lfZW5hYmxlPw0KPiA+DQo+ID4gSWYgdGhlIGJpdCB0aGF0IGluIFBDSUVfTVNJ
X1NUQVRVU19PRkZTRVQgcmVnaXN0ZXIgaXMgc2V0IGJ1dCBub3QgaW4NCj4gPiBtc2lfZW5hYmxl
LCBpdCBtdXN0IGJlIGFuIGFibm9ybWFsIHVzYWdlIG9mIE1TSSBvciBzb21ldGhpbmcgZ29lcyB3
cm9uZywNCj4gPiBpdCBzaG91bGQgYmUgaWdub3JlZCBpbiBjYXNlIHdlIGNhbiBub3QgZmluZCB0
aGUgY29ycmVzcG9uZGluZyBoYW5kbGVyLg0KPiA+DQo+ID4gPiBTb3VuZHMgbGlrZSB5b3UnbGwg
anVzdCBzcGluLWxvb3AgZm9yZXZlciB3aXRob3V0IGFja25vd2xlZGdpbmcgdGhlDQo+ID4gPiBp
bnRlcnJ1cHQuDQo+ID4NCj4gPiBUaGUgaW50ZXJydXB0IHdpbGwgYmUgYWNrbm93bGVkZ2VkIGlu
IHRoZSBpcnFfYWNrIGNhbGxiYWNrIG9mDQo+ID4gbXRrX21zaV9pcnFfY2hpcCwgd2hpY2ggYmVs
b25ncyB0byB0aGUgbXNpX2RvbWFpbi4NCj4gDQo+IExldCdzIHRyeSB0byBnbyB0aHJvdWdoIGl0
IChhbmQgcGxlYXNlIGV4cGxhaW4gdG8gbWUgaWYgSSBnZXQgdGhpcyB3cm9uZykuDQo+IA0KPiBT
YXkgd2UgaGF2ZToNCj4gDQo+IG1zaV9lbmFibGUgPSBbUENJRV9NU0lfRU5BQkxFX09GRlNFVF0g
PSAweDE7DQo+IA0KPiB3aGlsZSBsb29wOg0KPiANCj4gbXNpX3N0YXR1cyA9IFtQQ0lFX01TSV9T
VEFUVVNfT0ZGU0VUXSA9IDB4MzsNCj4gbXNpX3N0YXR1cyAmPSBtc2lfZW5hYmxlID0+IG1zaV9z
dGF0dXMgPSAweDMgJiAweDEgPSAweDE7DQo+IGZvcl9lYWNoX3NldF9iaXQobXNpX3N0YXR1cykg
ew0KPiAgICBkbyBzb21ldGhpbmcgdGhhdCBwcmVzdW1hYmx5IHdpbGwgZGlzYWJsZSB0aGUgTVNJ
IGludGVycnVwdCBzdGF0dXM/DQoNClllcywgdGhlIGNvcnJlc3BvbmRpbmcgaW50ZXJydXB0IHN0
YXR1cyB3aWxsIGJlIGNsZWFyZWQuDQoNCj4gfQ0KPiAobmV4dCBsb29wIGl0ZXJhdGlvbikNCj4g
DQo+IG1zaV9zdGF0dXMgPSBbUENJRV9NU0lfU1RBVFVTX09GRlNFVF0gPSAweDI7DQo+IG1zaV9z
dGF0dXMgJj0gbXNpX2VuYWJsZSA9PiBtc2lfc3RhdHVzID0gMHgyICYgMHgxID0gMHgwOw0KPiBm
b3JfZWFjaF9zZXRfYml0KG1zaV9zdGF0dXMpID0+IGRvZXMgbm90aGluZy4NCj4gDQo+IG1zaV9z
dGF0dXMgPSBbUENJRV9NU0lfU1RBVFVTX09GRlNFVF0gPSAweDI7DQo+IChpbmZpbml0ZSBsb29w
KQ0KPiANCj4gQmFzaWNhbGx5LCBJJ20gd29uZGVyaW5nIGlmIHlvdSBzaG91bGQgcmVwbGFjZSB0
aGUgd2hpbGUgY29uZGl0aW9uDQo+IHN0YXRlbWVudCB3aXRoOg0KPiANCj4gd2hpbGUgKChtc2lf
c3RhdHVzID0gcmVhZGwobXNpX2luZm8tPmJhc2UgKyBQQ0lFX01TSV9TVEFUVVNfT0ZGU0VUKSAm
DQo+IG1zaV9lbmFibGUpKQ0KPiANCg0KWWVzLCBpdCB3aWxsIGJlIGEgZGVhZCBsb29wIGlmIHdl
IHJlY2VpdmUgYW4gYWJub3JtYWwgaW50ZXJydXB0IHN0YXR1cywNCkkgd2lsbCBmaXggaXQgaW4g
dGhlIG5leHQgdmVyc2lvbiwgdGhhbmtzIGZvciB5b3VyIGtpbmRseSByZXZpZXcuDQoNCj4gX19f
X19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGludXgtbWVk
aWF0ZWsgbWFpbGluZyBsaXN0DQo+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVhZC5vcmcN
Cj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51eC1tZWRp
YXRlaw0KDQo=

