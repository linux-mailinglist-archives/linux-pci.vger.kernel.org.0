Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16AB244A6A5
	for <lists+linux-pci@lfdr.de>; Tue,  9 Nov 2021 07:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243141AbhKIGNT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Nov 2021 01:13:19 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:32902 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S243125AbhKIGNS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Nov 2021 01:13:18 -0500
X-UUID: 39f6ff7cd48c4bdc882e8d7e7d2d8f13-20211109
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=5TI9MaGiDCo3zWSVU3oXZEG4tuaeM8OHObYDQ9ZAnOk=;
        b=Kfl539Brdhh7+cW/qaVcd7GMd7/nntItxF2+s2Y9pIhSQjych/qZCQfOTFFAc9PbhuK+WFT0gOcmjift7ECFLS4YW0wm5qbNd6BadR5nglAbz6yCLkr8WD63RdNNZc9wqEfibPEZQAfthpglFQszOzDQU1hHb7MwAY4v/ripQ0E=;
X-UUID: 39f6ff7cd48c4bdc882e8d7e7d2d8f13-20211109
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1300365504; Tue, 09 Nov 2021 14:10:28 +0800
Received: from mtkexhb02.mediatek.inc (172.21.101.103) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Tue, 9 Nov 2021 14:10:27 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkexhb02.mediatek.inc (172.21.101.103) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 9 Nov 2021 14:10:26 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n2.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.3 via Frontend
 Transport; Tue, 9 Nov 2021 14:10:26 +0800
Message-ID: <b18f74b8831492c4a75f45fa778c359fd80184d0.camel@mediatek.com>
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
Date:   Tue, 9 Nov 2021 14:10:25 +0800
In-Reply-To: <20211015063602.29058-1-jianjun.wang@mediatek.com>
References: <20211015063602.29058-1-jianjun.wang@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgTWFpbnRhaW5lcnMsDQoNCkp1c3QgZ2VudGxlIHBpbmcgZm9yIHRoaXMgcGF0Y2gsIGlmIHRo
ZXJlIGlzIGFueXRoaW5nIEkgbmVlZCB0byBtb2RpZnksDQpwbGVhc2Uga2luZGx5IGxldCBtZSBr
bm93Lg0KDQpUaGFua3MuDQoNCk9uIEZyaSwgMjAyMS0xMC0xNSBhdCAxNDozNiArMDgwMCwgSmlh
bmp1biBXYW5nIHdyb3RlOg0KPiBXaGVuIHRoZSBEVkZTUkMgKGR5bmFtaWMgdm9sdGFnZSBhbmQg
ZnJlcXVlbmN5IHNjYWxpbmcgcmVzb3VyY2UNCj4gY29sbGVjdG9yKQ0KPiBmZWF0dXJlIGlzIG5v
dCBpbXBsZW1lbnRlZCwgdGhlIFBDSWUgaGFyZHdhcmUgd2lsbCBhc3NlcnQgYSB2b2x0YWdlDQo+
IHJlcXVlc3QNCj4gc2lnbmFsIHdoZW4gZXhpdCBmcm9tIHRoZSBMMSBQTSBTdWJzdGF0ZXMgdG8g
cmVxdWVzdCBhIHNwZWNpZmljIFZjb3JlDQo+IHZvbHRhZ2UsIGJ1dCBjYW5ub3QgcmVjZWl2ZSB0
aGUgdm9sdGFnZSByZWFkeSBzaWduYWwsIHdoaWNoIHdpbGwNCj4gY2F1c2UNCj4gdGhlIGxpbmsg
dG8gZmFpbCB0byBleGl0IHRoZSBMMSBQTSBTdWJzdGF0ZXMuDQo+IA0KPiBEaXNhYmxlIERWRlNS
QyB2b2x0YWdlIHJlcXVlc3QgYnkgZGVmYXVsdCwgd2UgbmVlZCB0byBmaW5kIGEgY29tbW9uDQo+
IHdheSB0bw0KPiBlbmFibGUgaXQgaW4gdGhlIGZ1dHVyZS4NCj4gDQo+IEZpeGVzOiBkM2JmNzVi
NTc5YjkgKCJQQ0k6IG1lZGlhdGVrLWdlbjM6IEFkZCBNZWRpYVRlayBHZW4zIGRyaXZlcg0KPiBm
b3IgTVQ4MTkyIikNCj4gU2lnbmVkLW9mZi1ieTogSmlhbmp1biBXYW5nIDxqaWFuanVuLndhbmdA
bWVkaWF0ZWsuY29tPg0KPiBSZXZpZXdlZC1ieTogVHp1bmctQmkgU2hpaCA8dHp1bmdiaUBnb29n
bGUuY29tPg0KPiBUZXN0ZWQtYnk6IFFpemhvbmcgQ2hlbmcgPHFpemhvbmcuY2hlbmdAbWVkaWF0
ZWsuY29tPg0KPiAtLS0NCj4gIGRyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1n
ZW4zLmMgfCA4ICsrKysrKysrDQo+ICAxIGZpbGUgY2hhbmdlZCwgOCBpbnNlcnRpb25zKCspDQo+
IA0KPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdl
bjMuYw0KPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4g
aW5kZXggZjNhZWI4ZDRlYWNhLi43OWZiMTJmY2E2YTkgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gKysrIGIvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMuYw0KPiBAQCAtNzksNiArNzksOSBAQA0KPiAg
I2RlZmluZSBQQ0lFX0lDTURfUE1fUkVHCQkweDE5OA0KPiAgI2RlZmluZSBQQ0lFX1RVUk5fT0ZG
X0xJTksJCUJJVCg0KQ0KPiAgDQo+ICsjZGVmaW5lIFBDSUVfTUlTQ19DVFJMX1JFRwkJMHgzNDgN
Cj4gKyNkZWZpbmUgUENJRV9ESVNBQkxFX0RWRlNSQ19WTFRfUkVRCUJJVCgxKQ0KPiArDQo+ICAj
ZGVmaW5lIFBDSUVfVFJBTlNfVEFCTEVfQkFTRV9SRUcJMHg4MDANCj4gICNkZWZpbmUgUENJRV9B
VFJfU1JDX0FERFJfTVNCX09GRlNFVAkweDQNCj4gICNkZWZpbmUgUENJRV9BVFJfVFJTTF9BRERS
X0xTQl9PRkZTRVQJMHg4DQo+IEBAIC0yOTcsNiArMzAwLDExIEBAIHN0YXRpYyBpbnQgbXRrX3Bj
aWVfc3RhcnR1cF9wb3J0KHN0cnVjdA0KPiBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiAgCXZhbCAm
PSB+UENJRV9JTlRYX0VOQUJMRTsNCj4gIAl3cml0ZWxfcmVsYXhlZCh2YWwsIHBvcnQtPmJhc2Ug
KyBQQ0lFX0lOVF9FTkFCTEVfUkVHKTsNCj4gIA0KPiArCS8qIERpc2FibGUgRFZGU1JDIHZvbHRh
Z2UgcmVxdWVzdCAqLw0KPiArCXZhbCA9IHJlYWRsX3JlbGF4ZWQocG9ydC0+YmFzZSArIFBDSUVf
TUlTQ19DVFJMX1JFRyk7DQo+ICsJdmFsIHw9IFBDSUVfRElTQUJMRV9EVkZTUkNfVkxUX1JFUTsN
Cj4gKwl3cml0ZWxfcmVsYXhlZCh2YWwsIHBvcnQtPmJhc2UgKyBQQ0lFX01JU0NfQ1RSTF9SRUcp
Ow0KPiArDQo+ICAJLyogQXNzZXJ0IGFsbCByZXNldCBzaWduYWxzICovDQo+ICAJdmFsID0gcmVh
ZGxfcmVsYXhlZChwb3J0LT5iYXNlICsgUENJRV9SU1RfQ1RSTF9SRUcpOw0KPiAgCXZhbCB8PSBQ
Q0lFX01BQ19SU1RCIHwgUENJRV9QSFlfUlNUQiB8IFBDSUVfQlJHX1JTVEIgfA0KPiBQQ0lFX1BF
X1JTVEI7DQo=

