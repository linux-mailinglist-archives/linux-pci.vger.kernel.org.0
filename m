Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 94D6E4478CE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Nov 2021 04:17:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236689AbhKHDTx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 7 Nov 2021 22:19:53 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:55234 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229757AbhKHDTx (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 7 Nov 2021 22:19:53 -0500
X-UUID: 4f2a8221be0a4be7bab5bd0f0dc5c3c7-20211108
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=84PdMly+vcryJAJZDzAQe575ojQCAqKQN4WPuKV+zz4=;
        b=hvrfFZUbuyEu11x6aAPwv77vj01uqPEr+55P5ReHIpgTsLztYH4/6wYZxCP0sxH64E5psZ2KZPyHuhxMwmTuEW/KqcjyW57OmN3OLBEXAKQ0mNP+hsX4YV/mZE+v/c9PKv12XcewWVNLjqn5CBXnirnh+LvxKmwXIg6DLX1qbKI=;
X-UUID: 4f2a8221be0a4be7bab5bd0f0dc5c3c7-20211108
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1310208741; Mon, 08 Nov 2021 11:17:06 +0800
Received: from mtkmbs10n1.mediatek.inc (172.21.101.34) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Mon, 8 Nov 2021 11:17:05 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkmbs10n1.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.2.792.15 via Frontend
 Transport; Mon, 8 Nov 2021 11:17:05 +0800
Message-ID: <98d237693bc618cba62e93495b7b3379c18ac6b5.camel@mediatek.com>
Subject: Re: Distinguish mediatek drivers
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>,
        Ryder Lee <ryder.lee@mediatek.com>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        "Fan Fei" <ffclaire1224@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-mediatek@lists.infradead.org>, <linux-pci@vger.kernel.org>
Date:   Mon, 8 Nov 2021 11:17:05 +0800
In-Reply-To: <20211105202913.GA944432@bhelgaas>
References: <20211105202913.GA944432@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgQmpvcm4sDQoNClRoYW5rcyBmb3IgdGhlIHJlbWluZGVyLCBJIHdpbGwgc2VuZCBwYXRjaGVz
IHRvIHVwZGF0ZSB0aGVzZSBlbnRyaWVzLg0KDQpUaGFua3MuDQoNCk9uIEZyaSwgMjAyMS0xMS0w
NSBhdCAxNToyOSAtMDUwMCwgQmpvcm4gSGVsZ2FhcyB3cm90ZToNCj4gV2UgaGF2ZSB0d28gTWVk
aWFUZWsgZHJpdmVyczogcGNpZS1tZWRpYXRlay5jLCB3aGljaCBjbGFpbXM6DQo+IA0KPiAgIC5j
b21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcwMS1wY2llIg0KPiAgIC5jb21wYXRpYmxlID0gIm1l
ZGlhdGVrLG10NzYyMy1wY2llIg0KPiAgIC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10MjcxMi1w
Y2llIg0KPiAgIC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10NzYyMi1wY2llIg0KPiAgIC5jb21w
YXRpYmxlID0gIm1lZGlhdGVrLG10NzYyOS1wY2llIg0KPiANCj4gYW5kIHBjaWUtbWVkaWF0ZWst
Z2VuMy5jLCB3aGljaCBjbGFpbXM6DQo+IA0KPiAgIC5jb21wYXRpYmxlID0gIm1lZGlhdGVrLG10
ODE5Mi1wY2llIg0KPiANCj4gVGhlIEtjb25maWcgdGV4dCBkb2VzIG5vdCBkaXN0aW5ndWlzaCB0
aGVtLiAgQ2FuIHNvbWVib2R5IHVwZGF0ZQ0KPiB0aGVzZQ0KPiBlbnRyaWVzIHNvIHRoZXkgZG8/
ICBJdCdzIG5pY2UgaWYgd2UgY2FuIG1lbnRpb24gbW9kZWwgbnVtYmVycyBvcg0KPiBwcm9kdWN0
IG5hbWVzIHRoYXQgYSB1c2VyIHdvdWxkIHJlY29nbml6ZS4NCj4gDQo+ICAgY29uZmlnIFBDSUVf
TUVESUFURUsNCj4gICAgICAgICB0cmlzdGF0ZSAiTWVkaWFUZWsgUENJZSBjb250cm9sbGVyIg0K
PiAgICAgICAgIGRlcGVuZHMgb24gQVJDSF9NRURJQVRFSyB8fCBDT01QSUxFX1RFU1QNCj4gICAg
ICAgICBkZXBlbmRzIG9uIE9GDQo+ICAgICAgICAgZGVwZW5kcyBvbiBQQ0lfTVNJX0lSUV9ET01B
SU4NCj4gICAgICAgICBoZWxwDQo+ICAgICAgICAgICBTYXkgWSBoZXJlIGlmIHlvdSB3YW50IHRv
IGVuYWJsZSBQQ0llIGNvbnRyb2xsZXIgc3VwcG9ydCBvbg0KPiAgICAgICAgICAgTWVkaWFUZWsg
U29Dcy4NCj4gDQo+ICAgY29uZmlnIFBDSUVfTUVESUFURUtfR0VOMw0KPiAgICAgICAgIHRyaXN0
YXRlICJNZWRpYVRlayBHZW4zIFBDSWUgY29udHJvbGxlciINCj4gICAgICAgICBkZXBlbmRzIG9u
IEFSQ0hfTUVESUFURUsgfHwgQ09NUElMRV9URVNUDQo+ICAgICAgICAgZGVwZW5kcyBvbiBQQ0lf
TVNJX0lSUV9ET01BSU4NCj4gICAgICAgICBoZWxwDQo+ICAgICAgICAgICBBZGRzIHN1cHBvcnQg
Zm9yIFBDSWUgR2VuMyBNQUMgY29udHJvbGxlciBmb3IgTWVkaWFUZWsNCj4gU29Dcy4NCj4gICAg
ICAgICAgIFRoaXMgUENJZSBjb250cm9sbGVyIGlzIGNvbXBhdGlibGUgd2l0aCBHZW4zLCBHZW4y
IGFuZCBHZW4xDQo+IHNwZWVkLA0KPiAgICAgICAgICAgYW5kIHN1cHBvcnQgdXAgdG8gMjU2IE1T
SSBpbnRlcnJ1cHQgbnVtYmVycyBmb3INCj4gICAgICAgICAgIG11bHRpLWZ1bmN0aW9uIGRldmlj
ZXMuDQo+IA0KPiAgICAgICAgICAgU2F5IFkgaGVyZSBpZiB5b3Ugd2FudCB0byBlbmFibGUgR2Vu
MyBQQ0llIGNvbnRyb2xsZXINCj4gc3VwcG9ydCBvbg0KPiAgICAgICAgICAgTWVkaWFUZWsgU29D
cy4NCj4gDQo+IEJvdGggZHJpdmVycyBhcmUgYWxzbyBuYW1lZCAibXRrLXBjaWUiIGFuZCB1c2Ug
dGhlIHNhbWUgaW50ZXJuYWwNCj4gIm10a18iIHByZWZpeCBvbiBzdHJ1Y3RzIGFuZCBmdW5jdGlv
bnMuICBOb3QgYSAqaHVnZSogcHJvYmxlbSwgYnV0DQo+IG5vdA0KPiByZWFsbHkgaWRlYWwgZWl0
aGVyLg0KPiANCj4gQmpvcm4NCg==

