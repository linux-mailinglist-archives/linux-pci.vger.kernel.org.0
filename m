Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C0123FEB3E
	for <lists+linux-pci@lfdr.de>; Thu,  2 Sep 2021 11:30:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245758AbhIBJ3v (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 2 Sep 2021 05:29:51 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:60990 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S245609AbhIBJ3s (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 2 Sep 2021 05:29:48 -0400
X-UUID: 7cc0a72689114dacaceaa0d923355b0f-20210902
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=7BMKZ9QUqaKkuTBeVs3pjQYEnvqKsI6RkIvddChwTF0=;
        b=IhIvjz1RArKyF8VAlT7K6H08pIKZ8z7NgBN7UAU8zDESRIr6PjY4Rd6YNilPffz8FLe4zb5cMtPVTmJkQtVwjLC/JJH7oQ3/qHX9OexEHm8VhdZvGSEJzwYOMQ6pj2yeVKlo4ZCagCYJpCg5An1YaT3TxyvyDwuvTAMKg6NELXs=;
X-UUID: 7cc0a72689114dacaceaa0d923355b0f-20210902
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1876398628; Thu, 02 Sep 2021 17:28:45 +0800
Received: from mtkmbs10n2.mediatek.inc (172.21.101.183) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 2 Sep 2021 17:28:44 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Thu, 2 Sep 2021 17:28:44 +0800
Received: from mhfsdcap04 (10.17.3.154) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 2 Sep 2021 17:28:43 +0800
Message-ID: <93f44e07917e6e194fdf62bee98f7041e9f2d546.camel@mediatek.com>
Subject: Re: [PATCH v12 3/6] PCI: mediatek: Add new method to get irq number
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     <robh+dt@kernel.org>, <bhelgaas@google.com>,
        <matthias.bgg@gmail.com>, <lorenzo.pieralisi@arm.com>,
        <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Date:   Thu, 2 Sep 2021 17:28:44 +0800
In-Reply-To: <20210831183022.GA120514@bjorn-Precision-5520>
References: <20210831183022.GA120514@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.28.5-0ubuntu0.18.04.2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVHVlLCAyMDIxLTA4LTMxIGF0IDEzOjMwIC0wNTAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBNb24sIEF1ZyAyMywgMjAyMSBhdCAxMToyNzo1N0FNICswODAwLCBDaHVhbmppYSBMaXUg
d3JvdGU6DQo+ID4gVXNlIHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKCkgdG8gZ2V0IHRoZSBpcnEg
bnVtYmVyDQo+ID4gaWYgdGhlIHByb3BlcnR5IG9mICJpbnRlcnJ1cHQtbmFtZXMiIGlzIGRlZmlu
ZWQuDQo+IA0KPiBGcm9tIHBhdGNoIDEvNiwgSSBoYXZlIHRoZSBpbXByZXNzaW9uIHRoYXQgdGhp
cyBwYXRjaCBpcyBwYXJ0IG9mDQo+IGZpeGluZyBhbiBNU0kgaXNzdWUuICBJZiBzbywgdGhpcyBj
b21taXQgbG9nIHNob3VsZCBtZW50aW9uIHRoYXQgYXMNCj4gd2VsbC4NCg0KSGkgLEJqb3JuDQpZ
ZXPvvIxJIHdpbGwgY2hhbmdlIHRoZSBjb21taXQgbWVzc2FnZSBhcyBmb2xsb3cNCiANCkluIG9y
ZGVyIHRvIHBhcnNlIHRoZSBuZXcgZHRzIGZvcm1hdCB0aGF0IGNvbmZvcm1zIHRvIHRoZSBoYXJk
d2FyZQ0KZGVzaWduIGFuZCBmaXhlcyB0aGUgTVNJIGlzc3Vl77yMYWRkDQpwbGF0Zm9ybV9nZXRf
aXJxX2J5bmFtZV9vcHRpb25hbCB0byBnZXQgdGhlIGlycSBudW1iZXIuDQogDQo+IA0KPiA+IFNp
Z25lZC1vZmYtYnk6IENodWFuamlhIExpdSA8Y2h1YW5qaWEubGl1QG1lZGlhdGVrLmNvbT4NCj4g
PiBBY2tlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVkaWF0ZWsuY29tPg0KPiA+IC0tLQ0K
PiA+ICBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYyB8IDYgKysrKystDQo+
ID4gIDEgZmlsZSBjaGFuZ2VkLCA1IGluc2VydGlvbnMoKyksIDEgZGVsZXRpb24oLSkNCj4gPiAN
Cj4gPiBkaWZmIC0tZ2l0IGEvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMN
Cj4gPiBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+ID4gaW5kZXgg
NDI5NmQ5ZTA0MjQwLi4xOWUzNWFjNjJkNDMgMTAwNjQ0DQo+ID4gLS0tIGEvZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gPiArKysgYi9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbWVkaWF0ZWsuYw0KPiA+IEBAIC02NTQsNyArNjU0LDExIEBAIHN0YXRpYyBpbnQg
bXRrX3BjaWVfc2V0dXBfaXJxKHN0cnVjdA0KPiA+IG10a19wY2llX3BvcnQgKnBvcnQsDQo+ID4g
IAkJcmV0dXJuIGVycjsNCj4gPiAgCX0NCj4gPiAgDQo+ID4gLQlwb3J0LT5pcnEgPSBwbGF0Zm9y
bV9nZXRfaXJxKHBkZXYsIHBvcnQtPnNsb3QpOw0KPiA+ICsJaWYgKG9mX2ZpbmRfcHJvcGVydHko
ZGV2LT5vZl9ub2RlLCAiaW50ZXJydXB0LW5hbWVzIiwgTlVMTCkpDQo+ID4gKwkJcG9ydC0+aXJx
ID0gcGxhdGZvcm1fZ2V0X2lycV9ieW5hbWUocGRldiwgInBjaWVfaXJxIik7DQo+ID4gKwllbHNl
DQo+ID4gKwkJcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBwb3J0LT5zbG90KTsN
Cj4gDQo+IFRoaXMgd291bGQgYmUgdGhlIG9ubHkgaW5zdGFuY2Ugb2YgdGhpcyBwYXR0ZXJuLCB3
aGVyZSB3ZSBsb29rIGZvciBhDQo+IHByb3BlcnR5IGFuZCB1c2UgdGhlIHJlc3VsdCB0byBkZWNp
ZGUgaG93IHRvIGxvb2sgZm9yIHRoZSBJUlEuDQo+IA0KPiBkd19wY2llX2hvc3RfaW5pdCgpIGRv
ZXMgc29tZXRoaW5nIGxpa2UgdGhpczoNCj4gDQo+ICAgcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0
X2lycV9ieW5hbWVfb3B0aW9uYWwocGRldiwgInBjaWVfaXJxIik7DQo+ICAgaWYgKHBvcnQtPmly
cSA8IDApIHsNCj4gICAgIHBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgcG9ydC0+
c2xvdCk7DQo+ICAgICBpZiAocG9ydC0+aXJxIDwgMCkNCj4gICAgICAgcmV0dXJuIHBvcnQtPmly
cTsNCj4gICB9DQo+IA0KPiBXb3VsZCB0aGF0IHdvcmsgZm9yIHlvdT8gIElmIG5vdCwgdGhlIGNv
bW1pdCBsb2cgc2hvdWxkIGV4cGxhaW4gd2h5DQo+IHlvdSBjYW4ndCB1c2UgdGhlIHN0YW5kYXJk
IHBhdHRlcm4uDQo+IA0KPiBJZiB5b3UgZG8gdGhpbmdzIGRpZmZlcmVudGx5IHRoYW4gb3RoZXIg
ZHJpdmVycywgaXQgbWFrZXMgdGhpbmdzDQo+IGhhcmRlciB0byByZXZpZXcgYW5kIHNsb3dzIHRo
aW5ncyBkb3duLiAgSWYgeW91ICpoYXZlKiB0byBkbw0KPiBzb21ldGhpbmcNCj4gZGlmZmVyZW50
bHkgYW5kIGl0IGFkZHMgcmVhbCB2YWx1ZSB0byBiZSBkaWZmZXJlbnQsIHRoYXQncyBmaW5lLiAg
QnV0DQo+IHdlIHNob3VsZCBhdm9pZCB1bm5lY2Vzc2FyeSBkaWZmZXJlbmNlcy4NCg0KVGhhbmtz
IGZvciB5b3VyIGFkdmljZe+8jGl0IGlzIHZlcnkgaGVscGZ1bCB0byBtZSwgSSB3aWxsIHVzZSBz
dGFuZGFyZA0KcGF0dGVybiB0byBhdm9pZCB1bm5lY2Vzc2FyeSBkaWZmZXJlbmNlcw0KDQpUaGFu
a3MgYWdhaW4hDQpDaHVhbmppYQ0KDQo+IA0KPiA+ICAJaWYgKHBvcnQtPmlycSA8IDApDQo+ID4g
IAkJcmV0dXJuIHBvcnQtPmlycTsNCj4gPiAgDQo+ID4gLS0gDQo+ID4gMi4xOC4wDQo+ID4gDQo=

