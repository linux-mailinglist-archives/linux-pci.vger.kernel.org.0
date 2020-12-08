Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 90F012D2010
	for <lists+linux-pci@lfdr.de>; Tue,  8 Dec 2020 02:30:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgLHB2Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 20:28:25 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8458 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725972AbgLHB2Z (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 7 Dec 2020 20:28:25 -0500
X-UUID: cbde4ff5a2bd49f9aa694092eee3d9d8-20201208
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=waqy4i20W1JDrFc1FePMwNNNYqRij3lkjq7dJ8MpdPc=;
        b=R0ZbsB59pC+hzCPr5avn/YkLYFt3BcHa107agaAtFR/xZ2QGQk4WwMxZCwgkfOdcifx/ZH0PByHWdF3c36v17TrCKXm69idOYRWeyFLt+bJKjZ7C7l5T5YeYI6XbMLMNT94uszckr7XT2UashZesO5UUPlCuFAOdtHPpZc5gaKk=;
X-UUID: cbde4ff5a2bd49f9aa694092eee3d9d8-20201208
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 389684248; Tue, 08 Dec 2020 09:27:39 +0800
Received: from MTKCAS36.mediatek.inc (172.27.4.186) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 8 Dec
 2020 09:27:33 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS36.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 8 Dec 2020 09:27:32 +0800
Message-ID: <1607390856.14736.77.camel@mhfsdcap03>
Subject: Re: [v4,2/3] PCI: mediatek: Add new generation controller support
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Bjorn Helgaas <helgaas@kernel.org>
CC:     Lukas Wunner <lukas@wunner.de>, Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Sj Huang" <sj.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>
Date:   Tue, 8 Dec 2020 09:27:36 +0800
In-Reply-To: <20201204183052.GA1929838@bjorn-Precision-5520>
References: <20201204183052.GA1929838@bjorn-Precision-5520>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E51732604C4D2E44E18A7FAC374C6508F9E0AEBD30C5B828F9E6F2145E867B3A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gRnJpLCAyMDIwLTEyLTA0IGF0IDEyOjMwIC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0K
PiBPbiBGcmksIERlYyAwNCwgMjAyMCBhdCAwODozOTowOUFNICswMTAwLCBMdWthcyBXdW5uZXIg
d3JvdGU6DQo+ID4gT24gTW9uLCBOb3YgMzAsIDIwMjAgYXQgMTE6MzA6MDVBTSAtMDYwMCwgQmpv
cm4gSGVsZ2FhcyB3cm90ZToNCj4gPiA+IE9uIE1vbiwgTm92IDIzLCAyMDIwIGF0IDAyOjQ1OjEz
UE0gKzA4MDAsIEppYW5qdW4gV2FuZyB3cm90ZToNCj4gPiA+ID4gT24gVGh1LCAyMDIwLTExLTE5
IGF0IDE0OjI4IC0wNjAwLCBCam9ybiBIZWxnYWFzIHdyb3RlOg0KPiA+ID4gPiA+ID4gK3N0YXRp
YyBpbnQgbXRrX3BjaWVfc2V0dXAoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQpDQo+ID4gPiA+
ID4gPiArew0KPiA+IFsuLi5dDQo+ID4gPiA+ID4gPiArCS8qIFRyeSBsaW5rIHVwICovDQo+ID4g
PiA+ID4gPiArCWVyciA9IG10a19wY2llX3N0YXJ0dXBfcG9ydChwb3J0KTsNCj4gPiA+ID4gPiA+
ICsJaWYgKGVycikgew0KPiA+ID4gPiA+ID4gKwkJZGV2X25vdGljZShkZXYsICJQQ0llIGxpbmsg
ZG93blxuIik7DQo+ID4gPiA+ID4gPiArCQlnb3RvIGVycl9zZXR1cDsNCj4gPiA+ID4gPiANCj4g
PiA+ID4gPiBHZW5lcmFsbHkgaXQgc2hvdWxkIG5vdCBiZSBhIGZhdGFsIGVycm9yIGlmIHRoZSBs
aW5rIGlzIG5vdCB1cCBhdA0KPiA+ID4gPiA+IHByb2JlLXRpbWUuICBZb3UgbWF5IGJlIGFibGUg
dG8gaG90LWFkZCBhIGRldmljZSwgb3IgdGhlIGRldmljZSBtYXkNCj4gPiA+ID4gPiBoYXZlIHNv
bWUgZXh0ZXJuYWwgcG93ZXIgY29udHJvbCB0aGF0IHdpbGwgcG93ZXIgaXQgdXAgbGF0ZXIuDQo+
ID4gPiA+IA0KPiA+ID4gPiBUaGlzIGlzIGZvciB0aGUgcG93ZXIgc2F2aW5nIHJlcXVpcmVtZW50
LiBJZiB0aGVyZSBpcyBubyBkZXZpY2UNCj4gPiA+ID4gY29ubmVjdGVkIHdpdGggdGhlIFBDSWUg
c2xvdCwgdGhlIFBDSWUgTUFDIGFuZCBQSFkgc2hvdWxkIGJlIHBvd2VyZWQNCj4gPiA+ID4gb2Zm
Lg0KPiA+ID4gPiANCj4gPiA+ID4gSXMgdGhlcmUgYW55IHN0YW5kYXJkIGZsb3cgdG8gc3VwcG9y
dCBwb3dlciBkb3duIHRoZSBoYXJkd2FyZSBhdA0KPiA+ID4gPiBwcm9iZS10aW1lIGlmIG5vIGRl
dmljZSBpcyBjb25uZWN0ZWQgYW5kIHBvd2VyIGl0IHVwIHdoZW4gaG90LWFkZCBhDQo+ID4gPiA+
IGRldmljZT8NCj4gPiA+IA0KPiA+ID4gVGhhdCdzIGEgZ29vZCBxdWVzdGlvbi4gIEkgYXNzdW1l
IHRoaXMgbG9va3MgbGlrZSBhIHN0YW5kYXJkIFBDSWUNCj4gPiA+IGhvdC1hZGQgZXZlbnQ/DQo+
ID4gPiANCj4gPiA+IFdoZW4geW91IGhvdC1hZGQgYSBkZXZpY2UsIGRvZXMgdGhlIFJvb3QgUG9y
dCBnZW5lcmF0ZSBhIFByZXNlbmNlDQo+ID4gPiBEZXRlY3QgQ2hhbmdlZCBpbnRlcnJ1cHQ/ICBU
aGUgcGNpZWhwIGRyaXZlciBzaG91bGQgZmllbGQgdGhhdA0KPiA+ID4gaW50ZXJydXB0IGFuZCB0
dXJuIG9uIHBvd2VyIHRvIHRoZSBzbG90IHZpYSB0aGUgUG93ZXIgQ29udHJvbGxlcg0KPiA+ID4g
Q29udHJvbCBiaXQgaW4gdGhlIFNsb3QgQ29udHJvbCByZWdpc3Rlci4NCj4gPiA+IA0KPiA+ID4g
RG9lcyB5b3VyIGhhcmR3YXJlIHJlcXVpcmUgc29tZXRoaW5nIG1vcmUgdGhhbiB0aGF0IHRvIGNv
bnRyb2wgdGhlIE1BQw0KPiA+ID4gYW5kIFBIWSBwb3dlcj8NCj4gPiANCj4gPiBQb3dlciBzYXZp
bmcgb2YgdW51c2VkIFBDSWUgcG9ydHMgaXMgZ2VuZXJhbGx5IGFjaGlldmVkIHRocm91Z2ggdGhl
DQo+ID4gcnVudGltZSBQTSBmcmFtZXdvcmsuICBXaGVuIGEgUENJZSBwb3J0IHJ1bnRpbWUgc3Vz
cGVuZHMsIHRoZSBQQ0llDQo+ID4gY29yZSB3aWxsIHRyYW5zaXRpb24gaXQgdG8gRDNob3QuICBP
biB0b3Agb2YgdGhhdCwgdGhlIHBsYXRmb3JtDQo+ID4gbWF5IGJlIGFibGUgdG8gdHJhbnNpdGlv
biB0aGUgcG9ydCB0byBEM2NvbGQuICBDdXJyZW50bHkgb25seSB0aGUNCj4gPiBBQ1BJIHBsYXRm
b3JtIHN1cHBvcnRzIHRoYXQuICBDb25jZWl2YWJseSwgZGV2aWNldHJlZS1iYXNlZCBzeXN0ZW1z
DQo+ID4gbWF5IHdhbnQgdG8gZGlzYWJsZSBjZXJ0YWluIGNsb2NrcyBvciByZWd1bGF0b3JzIHdo
ZW4gYSBQQ0llIHBvcnQNCj4gPiBydW50aW1lIHN1c3BlbmRzLiAgSSB0aGluayB3ZSBkbyBub3Qg
c3VwcG9ydCB0aGF0IHlldCBidXQgaXQgY291bGQNCj4gPiBiZSBhZGRlZCB0byBkcml2ZXJzL3Bj
aS9wY2llL3BvcnRkcnYqLg0KPiA+IA0KPiA+IEEgaG90cGx1ZyBwb3J0IGlzIGV4cGVjdGVkIHRv
IHNpZ25hbCBQREMgYW5kIERMTFNDIGludGVycnVwdHMgZXZlbg0KPiA+IHdoZW4gaW4gRDNob3Qu
ICBBdCBsZWFzdCB0aGF0J3Mgb3VyIGV4cGVyaWVuY2Ugd2l0aCBUaHVuZGVyYm9sdC4NCj4gPiBU
byBzdXBwb3J0IGhvdHBsdWcgaW50ZXJydXB0cyBpbiBEM2NvbGQsIHNvbWUgZXh0ZXJuYWwgbWVj
aGFuaXNtDQo+ID4gKHN1Y2ggYXMgYSBQTUUpIGlzIG5lY2Vzc2FyeSB0byB3YWtlIHVwIHRoZSBw
b3J0IG9uIGhvdHBsdWcuDQo+ID4gVGhpcyBpcyBhbHNvIHN1cHBvcnRlZCB3aXRoIHJlY2VudCBU
aHVuZGVyYm9sdCBzeXN0ZW1zLg0KPiA+IA0KPiA+IEJlY2F1c2Ugd2UndmUgc2VlbiB2YXJpb3Vz
IGluY29tcGF0aWJpbGl0aWVzIHdoZW4gcnVudGltZSBzdXNwZW5kaW5nDQo+ID4gUENJZSBwb3J0
cywgY2VydGFpbiBjb25kaXRpb25zIG11c3QgYmUgc2F0aXNmaWVkIGZvciBydW50aW1lIFBNDQo+
ID4gdG8gYmUgZW5hYmxlZC4gIFRoZXkncmUgZW5jb2RlZCBpbiBwY2lfYnJpZGdlX2QzX3Bvc3Np
YmxlKCkuDQo+ID4gR2VuZXJhbGx5LCBob3RwbHVnIHBvcnRzIG9ubHkgcnVudGltZSBzdXNwZW5k
IGlmIHRoZXkgYmVsb25nIHRvDQo+ID4gYSBUaHVuZGVyYm9sdCBjb250cm9sbGVyIG9yIGlmIHRo
ZSBBQ1BJIHBsYXRmb3JtIGV4cGxpY2l0bHkgYWxsb3dzDQo+ID4gcnVudGltZSBQTSAodGhyb3Vn
aCBwcmVzZW5jZSBvZiBhIF9QUjMgbWV0aG9kIG9yIGEgZGV2aWNlIHByb3BlcnR5KS4NCj4gPiBO
b24taG90cGx1ZyBwb3J0cyBydW50aW1lIHN1c3BlbmQgaWYgdGhlIEJJT1MgaXMgbmV3ZXIgdGhh
biAyMDE1DQo+ID4gKGFzIHNwZWNpZmllZCBieSBETUkpLg0KPiA+IA0KPiA+IE9idmlvdXNseSwg
dGhpcyBwb2xpY3kgaXMgdmVyeSB4ODYtZm9jdXNzZWQgYmVjYXVzZSBib3RoIFRodW5kZXJib2x0
DQo+ID4gYW5kIERNSSBhcmUgb25seSByZWFsbHkgYSB0aGluZyBvbiB4ODYuICBUaGF0J3MgYWJv
dXQgdG8gY2hhbmdlIHRob3VnaA0KPiA+IGJlY2F1c2UgQXBwbGUncyBuZXcgYXJtNjQtYmFzZWQg
TWFjcyBoYXZlIFRodW5kZXJib2x0IGludGVncmF0ZWQgaW50bw0KPiA+IHRoZSBTb0MgYW5kIGFy
bTY0IFNvQ3MgYXJlIG1ha2luZyBpbnJvYWRzIGluIHRoZSBkYXRhY2VudGVyLCB3aGljaCBpcw0K
PiA+IGFuIGltcG9ydGFudCB1c2UgY2FzZSBmb3IgUENJZSBob3RwbHVnIChob3Qtc3dhcHBhYmxl
IE5WTWUgZHJpdmVzKS4NCj4gPiBTbyB3ZSBtYXkgaGF2ZSB0byBhbWVuZCBwY2lfYnJpZGdlX2Qz
X3Bvc3NpYmxlKCkgdG8gd2hpdGVsaXN0DQo+ID4gUENJZSBwb3J0cyBmb3IgcnVudGltZSBQTSBv
biBzcGVjaWZpYyBhcmNoZXMgb3Igc3lzdGVtcy4NCj4gDQo+IFRoYW5rcyBmb3IgYWxsIHRoaXMg
dmVyeSB1c2VmdWwgaW5mb3JtYXRpb24hDQo+IA0KPiBNeSBpbnRlcnByZXRhdGlvbiBmb3IgdGhl
IG1lZGlhdGVrIHNpdHVhdGlvbjoNCj4gDQo+ICAgLSBJIGFzc3VtZSB0aGlzIHBhdGNoIGxlYXZl
cyBvciBwdXRzIHRoZSBSb290IFBvcnQgaW4gRDNjb2xkIGlmIG5vDQo+ICAgICBkb3duc3RyZWFt
IGRldmljZXMgYXJlIHByZXNlbnQuDQo+IA0KPiAgIC0gSSBkb24ndCBzZWUgYW55IHN1cHBvcnQg
Zm9yIFBNRSBvciBzaW1pbGFyIG1lY2hhbmlzbXMgdG8gc2lnbmFsIGENCj4gICAgIGhvdC1hZGQg
d2hpbGUgdGhlIFJQIGlzIGluIEQzY29sZC4NCj4gDQo+ICAgLSBTbyBJIGFzc3VtZSB5b3UgZG9u
J3Qgc3VwcG9ydCBob3QtYWRkIGlmIHRoZSBzbG90IHdhcyBlbXB0eSBhdA0KPiAgICAgYm9vdCBh
bmQgdGhhdCdzIGFjY2VwdGFibGUgZm9yIHlvdXIgcGxhdGZvcm0uDQoNClllcywgdGhlIGhhcmR3
YXJlIG9mIFJvb3QgUG9ydCB3aWxsIGJlIHRvdGFsbHkgcG93ZXJlZCBvZmYgYnkgZ2F0aW5nIGl0
cw0KTVRDTU9TIGFuZCBjbG9ja3MgaWYgdGhlIHNsb3QgaXMgZW1wdHkgYXQgYm9vdCB0aW1lLiBC
ZWNhdXNlIHdlIGFyZQ0KZm9jdXMgb24gdGhlIHNjZW5hcmlvIG9mIHBvd2VyIHNhdmluZywgaXQn
cyBhY2NlcHRhYmxlIGlmIHdlIGRvbid0DQpzdXBwb3J0IGhvdC1hZGQuDQoNClRoYW5rcy4NCg0K

