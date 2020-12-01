Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 841562C958E
	for <lists+linux-pci@lfdr.de>; Tue,  1 Dec 2020 04:07:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727205AbgLADHd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 30 Nov 2020 22:07:33 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:27005 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725859AbgLADHd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 30 Nov 2020 22:07:33 -0500
X-UUID: 7464e83b8bdc40c49f65b53555b423d8-20201201
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=2aXVN+zVHNxxltuwnwGBJajzVvMc3w46iOtEkP3tAkc=;
        b=fb2t/M/VJUhauyRALv1pYceOCzyqIjsT/M++V0qELJcw/YxNKaIiTtbLhF99+GVIxxC0aCov9WcEm4RVRu17Dtilvc8kdAjQhY/izNJNEsfVh9ILb6XuuZCAeSZRaKewo+FG130KcNfyeRwAwfSzRyw9ggF8LWjnO7+xk0TXRG4=;
X-UUID: 7464e83b8bdc40c49f65b53555b423d8-20201201
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1228097533; Tue, 01 Dec 2020 11:06:45 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 1 Dec
 2020 11:06:44 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 1 Dec 2020 11:06:43 +0800
Message-ID: <1606792003.14736.63.camel@mhfsdcap03>
Subject: Re: [v4,2/3] PCI: mediatek: Add new generation controller support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <davem@davemloft.net>, <linux-pci@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sj Huang <sj.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, Lukas Wunner <lukas@wunner.de>
Date:   Tue, 1 Dec 2020 11:06:43 +0800
In-Reply-To: <20201130173005.GA1088958@bjorn-Precision-5520>
References: <20201130173005.GA1088958@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: FC451FC4603DE65A509FD6378268318300EC02B2017977A484F41EC915355B5E2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTExLTMwIGF0IDExOjMwIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBbK2NjIEx1a2FzLCBwY2llaHAgcG93ZXIgY29udHJvbCBxdWVzdGlvbl0NCj4gDQo+IE9uIE1v
biwgTm92IDIzLCAyMDIwIGF0IDAyOjQ1OjEzUE0gKzA4MDAsIEppYW5qdW4gV2FuZyB3cm90ZToN
Cj4gPiBPbiBUaHUsIDIwMjAtMTEtMTkgYXQgMTQ6MjggLTA2MDAsIEJqb3JuIEhlbGdhYXMgd3Jv
dGU6DQo+ID4gPiAiQWRkIG5ldyBnZW5lcmF0aW9uIiByZWFsbHkgY29udGFpbnMgbm8gaW5mb3Jt
YXRpb24uICBBbmQgIm1lZGlhdGVrIg0KPiA+ID4gaXMgYWxyZWFkeSB1c2VkIGZvciB0aGUgcGNp
ZS1tZWRpYXRlay5jIGRyaXZlciwgc28gd2Ugc2hvdWxkIGhhdmUgYQ0KPiA+ID4gbmV3IHRhZyBm
b3IgdGhpcyBuZXcgZHJpdmVyLiAgSW5jbHVkZSB1c2VmdWwgaW5mb3JtYXRpb24gaW4gdGhlDQo+
ID4gPiBzdWJqZWN0LCBlLmcuLA0KPiA+ID4gDQo+ID4gPiAgIFBDSTogbWVkaWF0ZWstZ2VuMzog
QWRkIE1lZGlhVGVrIEdlbjMgZHJpdmVyIGZvciBNVDgxOTINCj4gDQo+ID4gPiA+ICtzdGF0aWMg
aW50IG10a19wY2llX3NldHVwKHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+ID4gPiAr
ew0KPiA+ID4gPiArCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBvcnQtPmRldjsNCj4gPiA+ID4gKwlz
dHJ1Y3QgcGxhdGZvcm1fZGV2aWNlICpwZGV2ID0gdG9fcGxhdGZvcm1fZGV2aWNlKGRldik7DQo+
ID4gPiA+ICsJc3RydWN0IHJlc291cmNlICpyZWdzOw0KPiA+ID4gPiArCWludCBlcnI7DQo+ID4g
PiA+ICsNCj4gPiA+ID4gKwlyZWdzID0gcGxhdGZvcm1fZ2V0X3Jlc291cmNlX2J5bmFtZShwZGV2
LCBJT1JFU09VUkNFX01FTSwgInBjaWUtbWFjIik7DQo+ID4gPiA+ICsJcG9ydC0+YmFzZSA9IGRl
dm1faW9yZW1hcF9yZXNvdXJjZShkZXYsIHJlZ3MpOw0KPiA+ID4gPiArCWlmIChJU19FUlIocG9y
dC0+YmFzZSkpIHsNCj4gPiA+ID4gKwkJZGV2X25vdGljZShkZXYsICJmYWlsZWQgdG8gbWFwIHJl
Z2lzdGVyIGJhc2VcbiIpOw0KPiA+ID4gPiArCQlyZXR1cm4gUFRSX0VSUihwb3J0LT5iYXNlKTsN
Cj4gPiA+ID4gKwl9DQo+ID4gPiA+ICsNCj4gPiA+ID4gKwlwb3J0LT5yZWdfYmFzZSA9IHJlZ3Mt
PnN0YXJ0Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyogRG9uJ3QgdG91Y2ggdGhlIGhhcmR3YXJl
IHJlZ2lzdGVycyBiZWZvcmUgcG93ZXIgdXAgKi8NCj4gPiA+ID4gKwllcnIgPSBtdGtfcGNpZV9w
b3dlcl91cChwb3J0KTsNCj4gPiA+ID4gKwlpZiAoZXJyKQ0KPiA+ID4gPiArCQlyZXR1cm4gZXJy
Ow0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyogVHJ5IGxpbmsgdXAgKi8NCj4gPiA+ID4gKwllcnIg
PSBtdGtfcGNpZV9zdGFydHVwX3BvcnQocG9ydCk7DQo+ID4gPiA+ICsJaWYgKGVycikgew0KPiA+
ID4gPiArCQlkZXZfbm90aWNlKGRldiwgIlBDSWUgbGluayBkb3duXG4iKTsNCj4gPiA+ID4gKwkJ
Z290byBlcnJfc2V0dXA7DQo+ID4gPiANCj4gPiA+IEdlbmVyYWxseSBpdCBzaG91bGQgbm90IGJl
IGEgZmF0YWwgZXJyb3IgaWYgdGhlIGxpbmsgaXMgbm90IHVwIGF0DQo+ID4gPiBwcm9iZS10aW1l
LiAgWW91IG1heSBiZSBhYmxlIHRvIGhvdC1hZGQgYSBkZXZpY2UsIG9yIHRoZSBkZXZpY2UgbWF5
DQo+ID4gPiBoYXZlIHNvbWUgZXh0ZXJuYWwgcG93ZXIgY29udHJvbCB0aGF0IHdpbGwgcG93ZXIg
aXQgdXAgbGF0ZXIuDQo+ID4gDQo+ID4gVGhpcyBpcyBmb3IgdGhlIHBvd2VyIHNhdmluZyByZXF1
aXJlbWVudC4gSWYgdGhlcmUgaXMgbm8gZGV2aWNlDQo+ID4gY29ubmVjdGVkIHdpdGggdGhlIFBD
SWUgc2xvdCwgdGhlIFBDSWUgTUFDIGFuZCBQSFkgc2hvdWxkIGJlIHBvd2VyZWQNCj4gPiBvZmYu
DQo+ID4gDQo+ID4gSXMgdGhlcmUgYW55IHN0YW5kYXJkIGZsb3cgdG8gc3VwcG9ydCBwb3dlciBk
b3duIHRoZSBoYXJkd2FyZSBhdA0KPiA+IHByb2JlLXRpbWUgaWYgbm8gZGV2aWNlIGlzIGNvbm5l
Y3RlZCBhbmQgcG93ZXIgaXQgdXAgd2hlbiBob3QtYWRkIGENCj4gPiBkZXZpY2U/DQo+IA0KPiBU
aGF0J3MgYSBnb29kIHF1ZXN0aW9uLiAgSSBhc3N1bWUgdGhpcyBsb29rcyBsaWtlIGEgc3RhbmRh
cmQgUENJZQ0KPiBob3QtYWRkIGV2ZW50Pw0KPiANCj4gV2hlbiB5b3UgaG90LWFkZCBhIGRldmlj
ZSwgZG9lcyB0aGUgUm9vdCBQb3J0IGdlbmVyYXRlIGEgUHJlc2VuY2UNCj4gRGV0ZWN0IENoYW5n
ZWQgaW50ZXJydXB0PyAgVGhlIHBjaWVocCBkcml2ZXIgc2hvdWxkIGZpZWxkIHRoYXQNCj4gaW50
ZXJydXB0IGFuZCB0dXJuIG9uIHBvd2VyIHRvIHRoZSBzbG90IHZpYSB0aGUgUG93ZXIgQ29udHJv
bGxlcg0KPiBDb250cm9sIGJpdCBpbiB0aGUgU2xvdCBDb250cm9sIHJlZ2lzdGVyLg0KPiANCj4g
RG9lcyB5b3VyIGhhcmR3YXJlIHJlcXVpcmUgc29tZXRoaW5nIG1vcmUgdGhhbiB0aGF0IHRvIGNv
bnRyb2wgdGhlIE1BQw0KPiBhbmQgUEhZIHBvd2VyPw0KPiANCj4gQmpvcm4NCg0KVGhlIGhhcmR3
YXJlIHN1cHBvcnQgdG8gZ2VuZXJhdGUgYSBQcmVzZW5jZSBEZXRlY3QgQ2hhbmdlZCBpbnRlcnJ1
cHQNCndoZW4gaG90LWFkZCBhIGRldmljZS4NCg0KQnV0IGl0IHNlZW1zIHRoYXQgd2Ugc2hvdWxk
IGtlZXAgdGhlIFBIWSdzIHBvd2VyIGFuZCBjbG9ja3MgdG8gZW5zdXJlDQp0aGUgZGF0YSBsaW5r
IGxheWVyIHN0YXRlIGNoYW5nZSBjYW4gYmUgZGV0ZWN0ZWQsIGFuZCBrZWVwIHRoZSBNQUMgbGF5
ZXINCmFjdGl2ZSBmb3Igcm91dGluZyB0aGUgaW50ZXJydXB0IGV2ZW50IHRvIHBjaWVocCBkcml2
ZXIgaGFuZGxlci4NCg0KRm9yIHRoZSBwb3dlciBzYXZpbmcgcmVxdWlyZW1lbnQsIHRoZSBtb2R1
bGVzIHRoYXQgaXMgbm90IHVzZWQgd2hlbg0KcHJvYmUtdGltZSBtdXN0IGJlIHBvd2VyZWQgb2Zm
LCBzbyBJIHRoaW5rIHdlIG1heSBub3Qgc3VwcG9ydCBob3QtcGx1Zw0KaW4gdGhpcyBjYXNlLg0K
DQpUaGFua3MNCg==

