Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7342D460CDC
	for <lists+linux-pci@lfdr.de>; Mon, 29 Nov 2021 03:54:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345348AbhK2C5W (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 28 Nov 2021 21:57:22 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:37634 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241220AbhK2CzW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 28 Nov 2021 21:55:22 -0500
X-UUID: f399f2cd5e844e9183bd30ec6b1d518e-20211129
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=kD09jtn2dVIcl3Vsg9OLSofmPvBwrfGGIswuDPvN4T0=;
        b=U4YMdNp9oXuxWqgFZ5KGoPSBeqdJ6XDmfM79WmZb3Aq2M/Ti6HE8ikAWh6MYLorGRDhdGLFYyBPP/T7yWE9mCOAcUD3kJQLtMqBNyozkLQOqvyS+KGj7yQZdRMtI35bii46MFyNIEerW9L5vXxlrbyD4gy/LcjB/zUOKlSa1rik=;
X-UUID: f399f2cd5e844e9183bd30ec6b1d518e-20211129
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1824327397; Mon, 29 Nov 2021 10:52:01 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 29 Nov 2021 10:52:00 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 29 Nov 2021 10:51:59 +0800
Message-ID: <253e497abbcff425428ac8b7f30cebce718a63c9.camel@mediatek.com>
Subject: Re: [PATCH v3] PCI: mediatek-gen3: Disable DVFSRC voltage request
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <qizhong.cheng@mediatek.com>, <Ryan-JH.Yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Date:   Mon, 29 Nov 2021 10:51:59 +0800
In-Reply-To: <b18f74b8831492c4a75f45fa778c359fd80184d0.camel@mediatek.com>
References: <20211015063602.29058-1-jianjun.wang@mediatek.com>
         <b18f74b8831492c4a75f45fa778c359fd80184d0.camel@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFpbnRhaW5lcnMsDQoNCkp1c3QgZ2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2gsIGlzIHRo
ZXJlIGFueXRoaW5nIEkgbmVlZCB0byBkbyB0byBnZXQNCnRoaXMgcGF0Y2ggbWVyZ2VkPw0KDQpU
aGFua3MuDQoNCk9uIFR1ZSwgMjAyMS0xMS0wOSBhdCAxNDoxMCArMDgwMCwgSmlhbmp1biBXYW5n
IHdyb3RlOg0KPiANCj4gT24gRnJpLCAyMDIxLTEwLTE1IGF0IDE0OjM2ICswODAwLCBKaWFuanVu
IFdhbmcgd3JvdGU6DQo+ID4gV2hlbiB0aGUgRFZGU1JDIChkeW5hbWljIHZvbHRhZ2UgYW5kIGZy
ZXF1ZW5jeSBzY2FsaW5nIHJlc291cmNlDQo+ID4gY29sbGVjdG9yKQ0KPiA+IGZlYXR1cmUgaXMg
bm90IGltcGxlbWVudGVkLCB0aGUgUENJZSBoYXJkd2FyZSB3aWxsIGFzc2VydCBhIHZvbHRhZ2UN
Cj4gPiByZXF1ZXN0DQo+ID4gc2lnbmFsIHdoZW4gZXhpdCBmcm9tIHRoZSBMMSBQTSBTdWJzdGF0
ZXMgdG8gcmVxdWVzdCBhIHNwZWNpZmljDQo+ID4gVmNvcmUNCj4gPiB2b2x0YWdlLCBidXQgY2Fu
bm90IHJlY2VpdmUgdGhlIHZvbHRhZ2UgcmVhZHkgc2lnbmFsLCB3aGljaCB3aWxsDQo+ID4gY2F1
c2UNCj4gPiB0aGUgbGluayB0byBmYWlsIHRvIGV4aXQgdGhlIEwxIFBNIFN1YnN0YXRlcy4NCj4g
PiANCj4gPiBEaXNhYmxlIERWRlNSQyB2b2x0YWdlIHJlcXVlc3QgYnkgZGVmYXVsdCwgd2UgbmVl
ZCB0byBmaW5kIGEgY29tbW9uDQo+ID4gd2F5IHRvDQo+ID4gZW5hYmxlIGl0IGluIHRoZSBmdXR1
cmUuDQo+ID4gDQo+ID4gRml4ZXM6IGQzYmY3NWI1NzliOSAoIlBDSTogbWVkaWF0ZWstZ2VuMzog
QWRkIE1lZGlhVGVrIEdlbjMgZHJpdmVyDQo+ID4gZm9yIE1UODE5MiIpDQo+ID4gU2lnbmVkLW9m
Zi1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdAbWVkaWF0ZWsuY29tPg0KPiA+IFJldmll
d2VkLWJ5OiBUenVuZy1CaSBTaGloIDx0enVuZ2JpQGdvb2dsZS5jb20+DQo+ID4gVGVzdGVkLWJ5
OiBRaXpob25nIENoZW5nIDxxaXpob25nLmNoZW5nQG1lZGlhdGVrLmNvbT4NCj4gPiAtLS0NCj4g
PiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYyB8IDggKysrKysr
KysNCj4gPiAgMSBmaWxlIGNoYW5nZWQsIDggaW5zZXJ0aW9ucygrKQ0KPiA+IA0KPiA+IGRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4g
Yi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2VuMy5jDQo+ID4gaW5kZXgg
ZjNhZWI4ZDRlYWNhLi43OWZiMTJmY2E2YTkgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiA+ICsrKyBiL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBAQCAtNzksNiArNzksOSBAQA0KPiA+
ICAjZGVmaW5lIFBDSUVfSUNNRF9QTV9SRUcJCTB4MTk4DQo+ID4gICNkZWZpbmUgUENJRV9UVVJO
X09GRl9MSU5LCQlCSVQoNCkNCj4gPiAgDQo+ID4gKyNkZWZpbmUgUENJRV9NSVNDX0NUUkxfUkVH
CQkweDM0OA0KPiA+ICsjZGVmaW5lIFBDSUVfRElTQUJMRV9EVkZTUkNfVkxUX1JFUQlCSVQoMSkN
Cj4gPiArDQo+ID4gICNkZWZpbmUgUENJRV9UUkFOU19UQUJMRV9CQVNFX1JFRwkweDgwMA0KPiA+
ICAjZGVmaW5lIFBDSUVfQVRSX1NSQ19BRERSX01TQl9PRkZTRVQJMHg0DQo+ID4gICNkZWZpbmUg
UENJRV9BVFJfVFJTTF9BRERSX0xTQl9PRkZTRVQJMHg4DQo+ID4gQEAgLTI5Nyw2ICszMDAsMTEg
QEAgc3RhdGljIGludCBtdGtfcGNpZV9zdGFydHVwX3BvcnQoc3RydWN0DQo+ID4gbXRrX3BjaWVf
cG9ydCAqcG9ydCkNCj4gPiAgCXZhbCAmPSB+UENJRV9JTlRYX0VOQUJMRTsNCj4gPiAgCXdyaXRl
bF9yZWxheGVkKHZhbCwgcG9ydC0+YmFzZSArIFBDSUVfSU5UX0VOQUJMRV9SRUcpOw0KPiA+ICAN
Cj4gPiArCS8qIERpc2FibGUgRFZGU1JDIHZvbHRhZ2UgcmVxdWVzdCAqLw0KPiA+ICsJdmFsID0g
cmVhZGxfcmVsYXhlZChwb3J0LT5iYXNlICsgUENJRV9NSVNDX0NUUkxfUkVHKTsNCj4gPiArCXZh
bCB8PSBQQ0lFX0RJU0FCTEVfRFZGU1JDX1ZMVF9SRVE7DQo+ID4gKwl3cml0ZWxfcmVsYXhlZCh2
YWwsIHBvcnQtPmJhc2UgKyBQQ0lFX01JU0NfQ1RSTF9SRUcpOw0KPiA+ICsNCj4gPiAgCS8qIEFz
c2VydCBhbGwgcmVzZXQgc2lnbmFscyAqLw0KPiA+ICAJdmFsID0gcmVhZGxfcmVsYXhlZChwb3J0
LT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcpOw0KPiA+ICAJdmFsIHw9IFBDSUVfTUFDX1JTVEIg
fCBQQ0lFX1BIWV9SU1RCIHwgUENJRV9CUkdfUlNUQiB8DQo+ID4gUENJRV9QRV9SU1RCOw0KPiAN
Cj4gX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX19fX18NCj4gTGlu
dXgtbWVkaWF0ZWsgbWFpbGluZyBsaXN0DQo+IExpbnV4LW1lZGlhdGVrQGxpc3RzLmluZnJhZGVh
ZC5vcmcNCj4gaHR0cDovL2xpc3RzLmluZnJhZGVhZC5vcmcvbWFpbG1hbi9saXN0aW5mby9saW51
eC1tZWRpYXRlaw0K

