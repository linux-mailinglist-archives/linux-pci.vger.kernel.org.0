Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3E81442D3B3
	for <lists+linux-pci@lfdr.de>; Thu, 14 Oct 2021 09:31:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229970AbhJNHdt (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Oct 2021 03:33:49 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:35608 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S230155AbhJNHds (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Oct 2021 03:33:48 -0400
X-UUID: 576858e89f6c4d31a4b93ffb4cf17062-20211014
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=9lY6LHEh9lVFUboaWig5Y2+eb27e6WH0vW234KZQ/6c=;
        b=EPZzf81URHg+bP0asUlZxBa24o/BLm7g5gEnTu01YRzdCVUFslpyKCO0ajsNvaKk0elZZjN2gRAa4yrjPZI5sIEwzWKmDZ9ZURbbCuPgRjZ9ZpYrhpv28UR1gMxS0APWKSFOQQsfPCCEXfs9yKKUbuR3NZKSEqsK8CPBio1yNB8=;
X-UUID: 576858e89f6c4d31a4b93ffb4cf17062-20211014
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 2089272284; Thu, 14 Oct 2021 15:31:38 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 14 Oct 2021 15:31:37 +0800
Received: from mhfsdcap04 (10.17.3.154) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 14 Oct 2021 15:31:36 +0800
Message-ID: <cb8ba624881fa4f57ea6a1d4c30fcb472f709a4f.camel@mediatek.com>
Subject: Re: [PATCH v2] PCI: mediatek-gen3: Disable DVFSRC voltage request
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <qizhong.cheng@mediatek.com>, <Ryan-JH.Yu@mediatek.com>,
        Tzung-Bi Shih <tzungbi@google.com>
Date:   Thu, 14 Oct 2021 15:31:36 +0800
In-Reply-To: <20211013183515.GA1907868@bhelgaas>
References: <20211013183515.GA1907868@bhelgaas>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gV2VkLCAyMDIxLTEwLTEzIGF0IDEzOjM1IC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBXZWQsIE9jdCAxMywgMjAyMSBhdCAwMzo1MzoyOFBNICswODAwLCBKaWFuanVuIFdhbmcg
d3JvdGU6DQo+ID4gV2hlbiB0aGUgRFZGU1JDIGZlYXR1cmUgaXMgbm90IGltcGxlbWVudGVkLCB0
aGUgTUFDIGxheWVyIHdpbGwNCj4gPiBhc3NlcnQgYSB2b2x0YWdlIHJlcXVlc3Qgc2lnbmFsIHdo
ZW4gZXhpdCBmcm9tIHRoZSBMMXNzIHN0YXRlLA0KPiA+IGJ1dCBjYW5ub3QgcmVjZWl2ZSB0aGUg
dm9sdGFnZSByZWFkeSBzaWduYWwsIHdoaWNoIHdpbGwgY2F1c2UNCj4gPiB0aGUgbGluayB0byBm
YWlsIHRvIGV4aXQgdGhlIEwxc3Mgc3RhdGUgY29ycmVjdGx5Lg0KPiA+IA0KPiA+IERpc2FibGUg
RFZGU1JDIHZvbHRhZ2UgcmVxdWVzdCBieSBkZWZhdWx0LCB3ZSBuZWVkIHRvIGZpbmQNCj4gPiBh
IGNvbW1vbiB3YXkgdG8gZW5hYmxlIGl0IGluIHRoZSBmdXR1cmUuDQo+IA0KPiBSZXdyYXAgY29t
bWl0IGxvZyB0byBmaWxsIDc1IGNvbHVtbnMuDQo+IA0KPiBEb2VzICJMMXNzIiBhYm92ZSByZWZl
ciB0byBMMS4xIGFuZCBMMS4yPyAgSWYgc28sIHBsZWFzZSBzYXkgdGhhdA0KPiBleHBsaWNpdGx5
IG9yIHNheSBzb21ldGhpbmcgbGlrZSAiTDEgUE0gU3Vic3RhdGVzIiAodGhlIHRlcm0gdXNlZCBp
bg0KPiB0aGUgUENJZSBzcGVjKSBzbyBpdCdzIGNsZWFyLg0KPiANCj4gVGhpcyBzZWVtcyBvbiB0
aGUgYm91bmRhcnkgb2YgUENJZS1zcGVjaWZpZWQgdGhpbmdzIGFuZCBNZWRpYXRlaw0KPiBpbXBs
ZW1lbnRhdGlvbiBkZXRhaWxzLCBzbyBJJ20gbm90IHN1cmUgd2hhdCAiRFZGU1JDLCIgIk1BQywi
IGFuZA0KPiAidm9sdGFnZSByZXF1ZXN0IHNpZ25hbCIgbWVhbi4gIFNpbmNlIEkgZG9uJ3QgcmVj
b2duaXplIHRob3NlIHRlcm1zLA0KPiBJJ20gZ3Vlc3NpbmcgdGhleSBhcmUgTWVkaWF0ZWstc3Bl
Y2lmaWMgdGhpbmdzLg0KPiANCj4gQnV0IGlmIHRoZXkgYXJlIHRoaW5ncyBzcGVjaWZpZWQgYnkg
dGhlIFBDSWUgc3BlYywgcGxlYXNlIHVzZSB0aGUNCj4gZXhhY3QgbmFtZXMgdXNlZCBpbiB0aGUg
c3BlYy4NCg0KSGkgQmpvcm4sDQoNClllcywgdGhlIERWRlNSQyAoZHluYW1pYyB2b2x0YWdlIGFu
ZCBmcmVxdWVuY3kgc2NhbGluZyByZXNvdXJjZQ0KY29sbGVjdG9yKSBpcyBhIHByb3ByaWV0YXJ5
IGhhcmR3YXJlIG9mIE1lZGlhdGVrLCB3aGljaCBpcyB1c2VkIHRvDQpjb2xsZWN0IHRoZSByZXF1
ZXN0cyBmcm9tIHN5c3RlbSBhbmQgdHVybiBpbnRvIHRoZSBkZWNpc2lvbiBvZiBtaW5pbXVtDQpW
Y29yZSB2b2x0YWdlIGFuZCBtaW5pbXVtIERSQU0gZnJlcXVlbmN5IHRvIGZ1bGZpbGwgdGhvc2Ug
cmVxdWVzdHMsIGFuZA0KdGhlICJ2b2x0YWdlIHJlcXVlc3Qgc2lnbmFsIiBpcyB0aGUgaGFyZHdh
cmUgc2lnbmFsIHdoaWNoIGZyb20gdGhlIFBDSWUNCmhhcmR3YXJlIHRvIHRoZSBEVkZTUkMgbW9k
dWxlIHRvIHJlcXVlc3QgYSBzcGVjaWZpYyBWY29yZSB2b2x0YWdlLg0KDQpJIHdpbGwgYWRkIGl0
cyBmdWxsIG5hbWUgaW4gdGhlIG5leHQgdmVyc2lvbiwgdGhhbmtzIGZvciB5b3VyIHJldmlldy4N
Cg0KVGhhbmtzLg0KPiANCj4gPiBTaWduZWQtb2ZmLWJ5OiBKaWFuanVuIFdhbmcgPGppYW5qdW4u
d2FuZ0BtZWRpYXRlay5jb20+DQo+ID4gUmV2aWV3ZWQtYnk6IFR6dW5nLUJpIFNoaWggPHR6dW5n
YmlAZ29vZ2xlLmNvbT4NCj4gPiBUZXN0ZWQtYnk6IFFpemhvbmcgQ2hlbmcgPHFpemhvbmcuY2hl
bmdAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0KPiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbWVkaWF0ZWstZ2VuMy5jIHwgOCArKysrKysrKw0KPiA+ICAxIGZpbGUgY2hhbmdlZCwgOCBp
bnNlcnRpb25zKCspDQo+ID4gDQo+ID4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xs
ZXIvcGNpZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tZWRpYXRlay1nZW4zLmMNCj4gPiBpbmRleCBmM2FlYjhkNGVhY2EuLjc5ZmIxMmZjYTZhOSAx
MDA2NDQNCj4gPiAtLS0gYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWstZ2Vu
My5jDQo+ID4gKysrIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLWdlbjMu
Yw0KPiA+IEBAIC03OSw2ICs3OSw5IEBADQo+ID4gICNkZWZpbmUgUENJRV9JQ01EX1BNX1JFRwkJ
MHgxOTgNCj4gPiAgI2RlZmluZSBQQ0lFX1RVUk5fT0ZGX0xJTksJCUJJVCg0KQ0KPiA+ICANCj4g
PiArI2RlZmluZSBQQ0lFX01JU0NfQ1RSTF9SRUcJCTB4MzQ4DQo+ID4gKyNkZWZpbmUgUENJRV9E
SVNBQkxFX0RWRlNSQ19WTFRfUkVRCUJJVCgxKQ0KPiA+ICsNCj4gPiAgI2RlZmluZSBQQ0lFX1RS
QU5TX1RBQkxFX0JBU0VfUkVHCTB4ODAwDQo+ID4gICNkZWZpbmUgUENJRV9BVFJfU1JDX0FERFJf
TVNCX09GRlNFVAkweDQNCj4gPiAgI2RlZmluZSBQQ0lFX0FUUl9UUlNMX0FERFJfTFNCX09GRlNF
VAkweDgNCj4gPiBAQCAtMjk3LDYgKzMwMCwxMSBAQCBzdGF0aWMgaW50IG10a19wY2llX3N0YXJ0
dXBfcG9ydChzdHJ1Y3QNCj4gPiBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+ICAJdmFsICY9IH5Q
Q0lFX0lOVFhfRU5BQkxFOw0KPiA+ICAJd3JpdGVsX3JlbGF4ZWQodmFsLCBwb3J0LT5iYXNlICsg
UENJRV9JTlRfRU5BQkxFX1JFRyk7DQo+ID4gIA0KPiA+ICsJLyogRGlzYWJsZSBEVkZTUkMgdm9s
dGFnZSByZXF1ZXN0ICovDQo+ID4gKwl2YWwgPSByZWFkbF9yZWxheGVkKHBvcnQtPmJhc2UgKyBQ
Q0lFX01JU0NfQ1RSTF9SRUcpOw0KPiA+ICsJdmFsIHw9IFBDSUVfRElTQUJMRV9EVkZTUkNfVkxU
X1JFUTsNCj4gPiArCXdyaXRlbF9yZWxheGVkKHZhbCwgcG9ydC0+YmFzZSArIFBDSUVfTUlTQ19D
VFJMX1JFRyk7DQo+ID4gKw0KPiA+ICAJLyogQXNzZXJ0IGFsbCByZXNldCBzaWduYWxzICovDQo+
ID4gIAl2YWwgPSByZWFkbF9yZWxheGVkKHBvcnQtPmJhc2UgKyBQQ0lFX1JTVF9DVFJMX1JFRyk7
DQo+ID4gIAl2YWwgfD0gUENJRV9NQUNfUlNUQiB8IFBDSUVfUEhZX1JTVEIgfCBQQ0lFX0JSR19S
U1RCIHwNCj4gPiBQQ0lFX1BFX1JTVEI7DQo+ID4gLS0gDQo+ID4gMi4yNS4xDQo+ID4gDQo=

