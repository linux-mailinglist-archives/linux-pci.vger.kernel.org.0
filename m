Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0FC383FC181
	for <lists+linux-pci@lfdr.de>; Tue, 31 Aug 2021 05:31:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231959AbhHaDcY (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Aug 2021 23:32:24 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:57642 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229983AbhHaDcX (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Aug 2021 23:32:23 -0400
X-UUID: 28d8e3b791bd4d13a91a10de81bdef3a-20210831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=i4ol5vbanD813f/B2tnhhHkAIPJlnC/VEEVt1TAFHhI=;
        b=Nf9ll2G683B/PC68VzwDAXf23DlS16J6bAEC4tvJLaUk8r27D3V3DJcudrdqv/Omhb1+m/E9jLUMnrFXfVXE2wmXO0Yg+0fjbYdre+0dByF8RDlM1IkriZPPN4nfN+V1lUZ/+HKJtsmVOHuB+TV15Ceb/gzQRWBrVYiZogbKbcE=;
X-UUID: 28d8e3b791bd4d13a91a10de81bdef3a-20210831
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 215663490; Tue, 31 Aug 2021 11:31:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb02.mediatek.inc
 (172.21.101.103) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 31 Aug
 2021 11:31:23 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 31 Aug 2021 11:31:22 +0800
Message-ID: <ccf767340afe13a6d273ad8fbc29c6bc966d6314.camel@mediatek.com>
Subject: Re: [PATCH v12 2/6] PCI: mediatek: Add new method to get shared
 pcie-cfg base address
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Tue, 31 Aug 2021 11:31:24 +0800
In-Reply-To: <20210830214317.GA27606@bjorn-Precision-5520>
References: <20210830214317.GA27606@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTA4LTMwIGF0IDE2OjQzIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAzMCwgMjAyMSBhdCAwMzowOTo0NFBNICswODAwLCBDaHVhbmppYSBMaXUg
d3JvdGU6DQo+ID4gT24gRnJpLCAyMDIxLTA4LTI3IGF0IDExOjQ2IC0wNTAwLCBCam9ybiBIZWxn
YWFzIHdyb3RlOg0KPiA+ID4gT24gTW9uLCBBdWcgMjMsIDIwMjEgYXQgMTE6Mjc6NTZBTSArMDgw
MCwgQ2h1YW5qaWEgTGl1IHdyb3RlOg0KPiA+ID4gPiBAQCAtOTk1LDYgKzEwMDQsMTQgQEAgc3Rh
dGljIGludCBtdGtfcGNpZV9zdWJzeXNfcG93ZXJ1cChzdHJ1Y3QNCj4gPiA+ID4gbXRrX3BjaWUg
KnBjaWUpDQo+ID4gPiA+ICAJCQlyZXR1cm4gUFRSX0VSUihwY2llLT5iYXNlKTsNCj4gPiA+ID4g
IAl9DQo+ID4gPiA+ICANCj4gPiA+ID4gKwljZmdfbm9kZSA9IG9mX2ZpbmRfY29tcGF0aWJsZV9u
b2RlKE5VTEwsIE5VTEwsDQo+ID4gPiA+ICsJCQkJCSAgICJtZWRpYXRlayxnZW5lcmljLQ0KPiA+
ID4gPiBwY2llY2ZnIik7DQo+ID4gPiA+ICsJaWYgKGNmZ19ub2RlKSB7DQo+ID4gPiA+ICsJCXBj
aWUtPmNmZyA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChjZmdfbm9kZSk7DQo+ID4gPiANCj4gPiA+
IE90aGVyIGRyaXZlcnMgaW4gZHJpdmVycy9wY2kvY29udHJvbGxlci8gdXNlDQo+ID4gPiBzeXNj
b25fcmVnbWFwX2xvb2t1cF9ieV9waGFuZGxlKCkgKGo3MjFlLCBkcmE3eHgsIGtleXN0b25lLA0K
PiA+ID4gbGF5ZXJzY2FwZSwgYXJ0cGVjNikgb3Igc3lzY29uX3JlZ21hcF9sb29rdXBfYnlfY29t
cGF0aWJsZSgpDQo+ID4gPiAoaW14NiwNCj4gPiA+IGtpcmluLCB2My1zZW1pKS4NCj4gPiA+IA0K
PiA+ID4gWW91IHNob3VsZCBkbyBpdCB0aGUgc2FtZSB3YXkgdW5sZXNzIHRoZXJlJ3MgYSBuZWVk
IHRvIGJlDQo+ID4gPiBkaWZmZXJlbnQuDQo+ID4gDQo+ID4gSSBoYXZlIHVzZWQgcGhhbmRsZSwg
YnV0IFJvYiBzdWdnZXN0ZWQgdG8gc2VhcmNoIGZvciB0aGUgbm9kZSBieSANCj4gPiBjb21wYXRp
YmxlLg0KPiA+IFRoZSByZWFzb24gd2h5IHN5c2Nvbl9yZWdtYXBfbG9va3VwX2J5X2NvbXBhdGli
bGUoKSBpcyBub3QgDQo+ID4gdXNlZCBoZXJlIGlzIHRoYXQgdGhlIHBjaWVjZmcgbm9kZSBpcyBv
cHRpb25hbCwgYW5kIHRoZXJlIGlzIG5vDQo+ID4gbmVlZCB0bw0KPiA+IHJldHVybiBlcnJvciB3
aGVuIHRoZSBub2RlIGlzIG5vdCBzZWFyY2hlZC4NCj4gDQo+IEhvdyBhYm91dCB0aGlzPw0KPiAN
Cj4gICByZWdtYXAgPSBzeXNjb25fcmVnbWFwX2xvb2t1cF9ieV9jb21wYXRpYmxlKCJtZWRpYXRl
ayxnZW5lcmljLQ0KPiBwY2llY2ZnIik7DQo+ICAgaWYgKCFJU19FUlIocmVnbWFwKSkNCj4gICAg
IHBjaWUtPmNmZyA9IHJlZ21hcDsNCg0KSGkgQmpvcm4sDQoNCldlIG5lZWQgdG8gZGVhbCB3aXRo
IHRocmVlIHNpdHVhdGlvbnMNCjEpIE5vIGVycm9yDQoyKSBUaGUgZXJyb3Igb2YgdGhlIG5vZGUg
bm90IGZvdW5kLCBkb24ndCBkbyBhbnl0aGluZyANCjMpIE90aGVyIGVycm9ycywgcmV0dXJuIGVy
cm9ycw0KDQpJIGd1ZXNzIHlvdSBtZWFuDQoNCnJlZ21hcCA9IHN5c2Nvbl9yZWdtYXBfbG9va3Vw
X2J5X2NvbXBhdGlibGUoIm1lZGlhdGVrLGdlbmVyaWMtDQpwY2llY2ZnIik7DQogIGlmICghSVNf
RVJSKHJlZ21hcCkpDQogICAgICBwY2llLT5jZmcgPSByZWdtYXA7DQogIGVsc2UgaWYgKElTX0VS
UihyZWdtYXApICYmIFBUUl9FUlIocmVnbWFwKSAhPSAtRU5PREVWKQ0KICAgICAgcmV0dXJuIFBU
Ul9FUlIocmVnbWFwKTsNCg0KSSdtIG5vdCBzdXJlIGlmIHdlIG5lZWQgdGhpcywgaXQgc2VlbXMg
YSBsaXR0bGUgd2VpcmQgYW5kIHRoZXJlIGFyZQ0KbWFueSBkcml2ZXJzIGluIG90aGVyIHN1YnN5
c3RlbXMgdGhhdCB1c2Ugc3lzY29uX25vZGVfdG9fcmVnbWFwKCkuDQoNClRoYW5rcw0KQ2h1YW5q
aWENCg==

