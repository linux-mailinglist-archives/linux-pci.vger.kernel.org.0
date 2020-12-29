Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B4A302E6D55
	for <lists+linux-pci@lfdr.de>; Tue, 29 Dec 2020 03:35:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727864AbgL2Ceo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 28 Dec 2020 21:34:44 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:41074 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727826AbgL2Cen (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 28 Dec 2020 21:34:43 -0500
X-UUID: 7e4adf016599424f95b76465ffa6663b-20201229
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=keG+UZI1nHMs3AUBoM6od8/3vuSNYBtw8VtXwPXWDYA=;
        b=IkNVSgNxJlyLjOj5/s3Jo3i78cllbAWcnj2yvUshOdm0ANvHIN38UQ+FhmXvRQBZSShCtee3rPFa4ZRZSKeTl7ZZ2+TTcJ5U5wCAQyMov2dm0tdZZT7ab7a8a9NKZ3UnrjM1Ba5TWtl6bvEgcdcdcYTW+IW7eJFc9x5HF38OTDs=;
X-UUID: 7e4adf016599424f95b76465ffa6663b-20201229
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 773697067; Tue, 29 Dec 2020 10:34:59 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 29 Dec
 2020 10:34:52 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 29 Dec 2020 10:34:51 +0800
Message-ID: <1609209225.14736.192.camel@mhfsdcap03>
Subject: Re: [v6,3/4] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Marc Zyngier <maz@kernel.org>
CC:     <youlin.pei@mediatek.com>, <devicetree@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        <qizhong.cheng@mediatek.com>, <chuanjia.liu@mediatek.com>,
        <linux-pci@vger.kernel.org>, Ryder Lee <ryder.lee@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        <linux-kernel@vger.kernel.org>, <sin_jieyang@mediatek.com>,
        Sj Huang <sj.huang@mediatek.com>, <drinkcat@chromium.org>,
        <linux-mediatek@lists.infradead.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Date:   Tue, 29 Dec 2020 10:33:45 +0800
In-Reply-To: <87bleeotg6.wl-maz@kernel.org>
References: <20201225100308.27052-1-jianjun.wang@mediatek.com>
         <20201225100308.27052-4-jianjun.wang@mediatek.com>
         <87ft3tpu67.wl-maz@kernel.org> <1609156917.14736.171.camel@mhfsdcap03>
         <87bleeotg6.wl-maz@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: AED3668C56EDB0F3703E356D8124B20403CF04091783540A584164C9C947DE562000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIwLTEyLTI4IGF0IDE1OjEyICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+
IE9uIE1vbiwgMjggRGVjIDIwMjAgMTI6MDE6NTcgKzAwMDAsDQo+IEppYW5qdW4gV2FuZyA8amlh
bmp1bi53YW5nQG1lZGlhdGVrLmNvbT4gd3JvdGU6DQo+ID4gDQo+ID4gT24gRnJpLCAyMDIwLTEy
LTI1IGF0IDE5OjIyICswMDAwLCBNYXJjIFp5bmdpZXIgd3JvdGU6DQo+IA0KPiBEcm9wcGVkCTxQ
cm9qZWN0X0dsb2JhbF9DaHJvbWVfVXBzdHJlYW1fR3JvdXBAbWVkaWF0ZWsuY29tPiwgYXMgaXQN
Cj4gYm91bmNlczoNCj4gDQo+IDxQcm9qZWN0X0dsb2JhbF9DaHJvbWVfVXBzdHJlYW1fR3JvdXBA
bWVkaWF0ZWsuY29tPjogaG9zdA0KPiAgICAgbWFpbGd3MDEubWVkaWF0ZWsuY29tWzIxNi4yMDAu
MjQwLjE4NF0gc2FpZDogNTUwIFJlbGF5aW5nIG1haWwgdG8NCj4gICAgIHByb2plY3RfZ2xvYmFs
X2Nocm9tZV91cHN0cmVhbV9ncm91cEBtZWRpYXRlay5jb20gaXMgbm90IGFsbG93ZWQgKGluIHJl
cGx5DQo+ICAgICB0byBSQ1BUIFRPIGNvbW1hbmQpDQo+IA0KPiBQbGVhc2UgbWFrZSBzdXJlIHlv
dSBkb24ndCBDYyBlbWFpbCBhZGRyZXNzZXMgdGhhdCBjYW5ub3QgYWNjZXB0IGVtYWlsDQo+IGZv
cm0gdGhlIG91dHNpZGUgd29ybGQuDQoNCkFwb2xvZ3ksIHRoZXkgYXJlIHRlYW0gbWVtYmVycyBv
ZiBtdDgxOTIgcHJvamVjdCwgd2hvIHdhbnQgdG8ga25vdyB0aGUNCnN0YXR1cyBvZiB0aGlzIHBh
dGNoLiBJIHdpbGwgcmVwbGFjZSB3aXRoIHRoZSBzcGVjaWZpZWQgZW1haWwgYWRkcmVzcyBhdA0K
bmV4dCB0aW1lLCBpbnN0ZWFkIG9mIHRoaXMgZ3JvdXAgYWRkcmVzcy4NCg0KPiBbLi4uXQ0KPiAN
Cj4gPiA+ID4gKy8qKg0KPiA+ID4gPiArICogc3RydWN0IG10a19wY2llX21zaSAtIE1TSSBpbmZv
cm1hdGlvbiBmb3IgZWFjaCBzZXQNCj4gPiA+ID4gKyAqIEBiYXNlOiBJTyBtYXBwZWQgcmVnaXN0
ZXIgYmFzZQ0KPiA+ID4gPiArICogQGlycTogTVNJIHNldCBJbnRlcnJ1cHQgbnVtYmVyDQo+ID4g
PiA+ICsgKiBAaW5kZXg6IE1TSSBzZXQgbnVtYmVyDQo+ID4gPiA+ICsgKiBAbXNnX2FkZHI6IE1T
SSBtZXNzYWdlIGFkZHJlc3MNCj4gPiA+ID4gKyAqIEBkb21haW46IElSUSBkb21haW4NCj4gPiA+
ID4gKyAqLw0KPiA+ID4gPiArc3RydWN0IG10a19wY2llX21zaSB7DQo+ID4gPiA+ICsJdm9pZCBf
X2lvbWVtICpiYXNlOw0KPiA+ID4gPiArCXVuc2lnbmVkIGludCBpcnE7DQo+ID4gPiA+ICsJaW50
IGluZGV4Ow0KPiA+ID4gPiArCXBoeXNfYWRkcl90IG1zZ19hZGRyOw0KPiA+ID4gPiArCXN0cnVj
dCBpcnFfZG9tYWluICpkb21haW47DQo+ID4gPiA+ICt9Ow0KPiA+ID4gDQo+ID4gPiBUaGlzIGxv
b2tzIG9kZC4gWW91IHNlZW0gdG8gc2F5IHRoYXQgdGhpcyBjb3ZlcnMgYSBzZXQgaWYgTVNJcywg
YW5kDQo+ID4gPiB5ZXQgdGhlIGlycSBmaWVsZCBoZXJlIGNsZWFybHkgaXNuJ3QgcGFydCBvZiBh
IHNldC4gSXMgdGhhdCBwZXIgTVNJDQo+ID4gPiBpbnN0ZWFkPyBFaXRoZXIgd2F5LCBzb21ldGhp
bmcgaXMgbm90IHF1aXRlIGFzIGl0IHNob3VsZCBiZS4NCj4gPiA+IA0KPiA+IA0KPiA+IEFwcHJl
Y2lhdGUgYWxsIHRoZXNlIGNvbW1lbnRzLCBwbGVhc2UgYWxsb3cgbWUgdG8gZXhwbGFpbiB0aGUg
TVNJDQo+ID4gaW50ZXJydXB0IGRlc2lnbiBpbiB0aGlzIEhXLg0KPiA+IA0KPiA+IFRoZSBIVyBk
ZXNpZ24gb2YgTVNJIGludGVycnVwdHMgd2lsbCBiZSBsaWtlIHRoZSBmb2xsb3dpbmc6DQo+ID4g
DQo+ID4gICAgICAgICAgICAgICAgICAgKy0tLS0tKw0KPiA+ICAgICAgICAgICAgICAgICAgIHwg
R0lDIHwNCj4gPiAgICAgICAgICAgICAgICAgICArLS0tLS0rDQo+ID4gICAgICAgICAgICAgICAg
ICAgICAgXg0KPiA+ICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAg
ICAgICB8W3BvcnQtPmlycV0NCj4gPiAgICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAg
ICAgICAgICstKy0rLSstKy0rLSstKy0rDQo+ID4gICAgICAgICAgICAgIHwwfDF8MnwzfDR8NXw2
fDd8W1BDSWUgaW50Y10NCj4gPiAgICAgICAgICAgICAgKy0rLSstKy0rLSstKy0rLSsNCj4gPiAg
ICAgICAgICAgICAgIF4gXiAgICAgICAgICAgXg0KPiA+ICAgICAgICAgICAgICAgfCB8ICAgIC4u
LiAgICB8W21zaV9pbmZvLT5pcnFdDQo+ID4gICAgICAgKy0tLS0tLS0rICstLS0tLS0rICAgICst
LS0tLS0tLS0tLSsNCj4gPiAgICAgICB8ICAgICAgICAgICAgICAgIHwgICAgICAgICAgICAgICAg
fA0KPiA+ICstKy0rLS0tKy0tKy0tKyAgKy0rLSstLS0rLS0rLS0rICArLSstKy0tLSstLSstLSsN
Cj4gPiB8MHwxfC4uLnwzMHwzMXwgIHwwfDF8Li4ufDMwfDMxfCAgfDB8MXwuLi58MzB8MzF8W01T
SSBzZXRzXQ0KPiA+ICstKy0rLS0tKy0tKy0tKyAgKy0rLSstLS0rLS0rLS0rICArLSstKy0tLSst
LSstLSsNCj4gPiAgXiBeICAgICAgXiAgXiAgICBeIF4gICAgICBeICBeICAgIF4gXiAgICAgIF4g
IF4NCj4gPiAgfCB8ICAgICAgfCAgfCAgICB8IHwgICAgICB8ICB8ICAgIHwgfCAgICAgIHwgIHwg
W01TSSBpcnFdDQo+ID4gIHwgfCAgICAgIHwgIHwgICAgfCB8ICAgICAgfCAgfCAgICB8IHwgICAg
ICB8ICB8DQo+ID4gDQo+ID4gICAoTVNJIFNFVDApICAgICAgIChNU0kgU0VUMSkgIC4uLiAgIChN
U0kgU0VUNykNCj4gPiANCj4gDQo+IFRoYW5rcywgdGhhdCdzIHJlYWxseSBoZWxwZnVsLiBZb3Ug
c2hvdWxkIGNvbnNpZGVyIGFkZGluZyB0aGlzIHRvIHRoZQ0KPiBkcml2ZXIgY29kZSwgYXMgcGFy
dCBvZiB0aGUgZG9jdW1lbnRhdGlvbi4NCg0KU3VyZSwgSSB3aWxsIGFkZCB0aGlzIHRvIHRoZSBk
cml2ZXIgZG9jdW1lbnRhdGlvbiBpbiB0aGUgbmV4dCB2ZXJzaW9uLg0KDQo+IA0KPiA+IEluIHNv
ZnR3YXJlIHBhcnRzLCB0aGUgcG9ydC0+bXNpX3RvcF9kb21haW4gaXMgY3JlYXRlZCB0byBtYWlu
dGFpbnMgOA0KPiA+IE1TSSBJUlFzIGZyb20gdGhlIFBDSWUgaW50YyBsYXllciwgaXRzIGhhcmR3
YXJlIElSUSB3aWxsIGJlIG1hcHBlZCB0bw0KPiA+IG1zaV9pbmZvLT5pcnEgYnkgaXJxX2NyZWF0
ZV9tYXBwaW5nLg0KPiA+IA0KPiA+IFRoZSBwb3J0LT5tc2lfZG9tYWluIGNvbnRhaW5zIDI1NiBN
U0kgSVJRcyBpbiB0b3RhbCwgaXQgY29uc2lzdCBvZiA4IE1TSQ0KPiA+IHNldHMsIGFuZCBlYWNo
IE1TSSBzZXQgY29udGFpbnMgMzIgTVNJIElSUXMuDQo+ID4gDQo+ID4gVGhlIHN0cnVjdHVyZSBv
ZiBtdGtfcGNpZV9tc2kgaXMgdXNlZCB0byBkZXNjcmliZSB0aGUgTVNJIHNldCwgSSB0aGluaw0K
PiA+IGl0IHdpbGwgYmUgbW9yZSBjb252ZW5pZW50IGFuZCBjb21wbHkgd2l0aCB0aGUgSFcgZGVz
aWduIHdoZW4gdXNlIHRoaXMNCj4gPiBzdHJ1Y3R1cmUsIHdlIGNhbiBnZXQgdGhlIGluZm9ybWF0
aW9uIG9mIE1TSSBzZXQgZGlyZWN0bHksIGluc3RlYWQgb2YNCj4gPiBjYWxjdWxhdGVkIGJ5IHBv
cnQtPmJhc2UuDQo+ID4gDQo+ID4gV2hlbiBhIE1TSSBpbnRlcnJ1cHQgaXMgcmVjZWl2ZWQsIHRo
ZSBpbnRlcnJ1cHQgaGFuZGxlIGZsb3cgd2lsbCBiZSBsaWtlDQo+ID4gdGhlIGZvbGxvd2luZzoN
Cj4gPiANCj4gPiAgICAgICAgICAgICAgIG10a19wY2llX2lycV9oYW5kbGVyIChwb3J0LT5pcnEp
DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgfA0KPiA+ICAgICAgICAgICAgICAgICAgICAg
ICAgIHwoZmluZCBtYXBwaW5nIGluIG1zaV90b3BfZG9tYWluKQ0KPiA+ICAgICAgICAgICAgICAg
ICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB2DQo+ID4gICAgICAgICAg
ICAgICAgIG10a19wY2llX21zaV9oYW5kbGVyIChtc2lfaW5mby0+aXJxKQ0KPiA+ICAgICAgICAg
ICAgICAgICAgICAgICAgIHwNCj4gPiAgICAgICAgICAgICAgICAgICAgICAgICB8KGZpbmQgbWFw
cGluZyBpbiBtc2lfZG9tYWluKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAg
ICAgICAgICAgICAgICAgICAgICAgICB2DQo+ID4gICAgICAgICAgICAgICAgICBoYW5kbGVfZWRn
ZV9pcnEgIChNU0kgaXJxKQ0KPiA+ICAgICAgICAgICAgICAgICAgICAgICAgIHwNCj4gPiAgICAg
ICAgICAgICAgICAgICAgICAgICB8DQo+ID4gICAgICAgICAgICAgICAgICAgICAgICAgdg0KPiA+
ICAgICAgICAgICAgIChkaXNwYXRjaCB0byBkZXZpY2UgaGFuZGxlcikNCj4gPiANCj4gPiBZZXMs
IEkgaGFkIHRvIGFkbWl0IHRoYXQgaXQncyBub3QgYSBxdWl0ZSBnb29kIHNvbHV0aW9uIG9mIGly
cWRvbWFpbnMsDQo+ID4gc2luY2UgdGhlIGxvY2FsIGlycSBkb21haW4gaXMgcGFydGlhbCBjb3Vw
bGVkIHdpdGggdGhlIHN0YW5kYXJkIFBDSSBNU0kNCj4gPiBpcnFkb21haW4uDQo+ID4gDQo+ID4g
U2hvdWxkIEkgbmVlZCB0byBjcmVhdGUgYW5vdGhlciBpcnFkb21haW4gdG8gbWFpbnRhaW4gdGhl
IE1TSSBzZXRzDQo+ID4gbGF5ZXIsIGFuZCBzZXQgaXQgYXMgdGhlIHBhcmVudCBkb21haW4gb2Yg
UENJIE1TSSBkb21haW4/IEkgcmVhbGx5IG5lZWQNCj4gPiB5b3VyIHN1Z2dlc3Rpb25zLCB0aGFu
a3MgYSBsb3QuDQo+IA0KPiA8cmFudD4NCj4gTXkgZmlyc3Qgc3VnZ2VzdGlvbiB3b3VsZCBiZSB0
byBnbyBiYWNrIHRvIHdob2V2ZXIgcHV0IHRoaXMgSFcgYmxvY2sNCj4gdG9nZXRoZXIgYW5kIG1h
a2Ugc3VyZSB0aGV5IG5ldmVyIHdyaXRlIGEgbGluZSBvZiBSVEwgZXZlciBhZ2Fpbi4NCj4gUHJv
Z3JhbW1pbmcgdXNpbmcgY29weS9wYXN0ZSBpcyBiYWQgZW5vdWdoLCBidXQgZG9pbmcgdGhlIHNh
bWUgdGhpbmcNCj4gd2l0aCBIVyBpcyBqdXN0IHRlcnJpYmxlLg0KPiA8L3JhbnQ+DQo+IA0KPiBJ
ZGVhbGx5LCB5b3Ugd291bGQgbW9kZWwgdGhlIHdob2xlIHRoaW5nIGFzIDggZGlzdGluY3QgTVNJ
DQo+IGNvbnRyb2xsZXJzLCBhcyB0aGF0IGlzIGVmZmVjdGl2ZWx5IHdoYXQgdGhleSBhcmUuIEV2
aWRlbnRseSwgdGhpcw0KPiB3b3VsZCBjYXVzZSBhbGwga2luZCBvZiBpc3N1ZXMgd2hlbiBhc3Nv
Y2lhdGluZyBQQ0kgZGV2aWNlcyB3aXRoIHRoZWlyDQo+IE1TSSBkb21haW4sIHNvIGxldCdzIG5v
dCBkbyB0aGF0Lg0KPiANCj4gU28gd2hhdCB3ZSB3YW50IGlzIHRvIGhhdmUgYSBzaW5nbGUgTVNJ
IGRvbWFpbiAod2l0aCAyNTYgZW50cmllcywNCj4gaGVuY2UgY292ZXJpbmcgYWxsIHNldHMpLCBh
bmQgY29tcHV0ZSB0aGUgaHdpcnEgZnJvbSB0aGUgbGV2ZWwgYmVsb3csDQo+IGRlcGVuZGluZyBv
biB0aGUgaW50ZXJydXB0IFBDSWUgaW50ZXJydXB0LCBhbmQgdGhlIGluZGV4IG9mIHRoZSBNU0kg
aW4NCj4gdGhlIHN0YXR1cyByZWdpc3RlciBmb3IgdGhpcyBQQ0llIGludGVycnVwdC4gSSB0aGlu
ayB5b3UgaGF2ZSBtb3N0IG9mDQo+IHRoZSBpbmZvcm1hdGlvbiBhbHJlYWR5LCB5b3UganVzdCBu
ZWVkIHRvIHNpbXBsaWZ5IHRoZSB3YXkgeW91IGtlZXANCj4gdHJhY2sgb2YgaXQsIGFuZCBtYXli
ZSBjb21lIHVwIHdpdGggYmV0dGVyIG5hbWVzIGZvciB0aGUgdmFyaW91cw0KPiBibG9ja3MuDQo+
IA0KPiBJIGV4cGVjdCB5b3Ugd291bGQgbmVlZCBzb21ldGhpbmcgbGlrZSB0aGlzOg0KPiANCj4g
c3RydWN0IG10a19tc2lfc2V0IHsNCj4gCXZvaWQgX19pb21lbQkJKmJhc2U7DQo+IAlwaHlzX2Fk
ZHJfdAkJbXNnX2FkZHI7DQo+IH07DQo+IA0KPiBzdHJ1Y3QgbXRrX3BjaWVfcG9ydCB7DQo+IFsu
Li5dDQo+IAlpbnQgCQkJYmFzZV9pcnE7DQo+IAlzdHJ1Y3QgbXRrX21zaV9zZXQJbXNpX3NldHNb
OF07DQo+IFsuLi5dDQo+IH07DQo+IA0KPiBUaGUgYXNzdW1wdGlvbiBpcyB0aGF0IHlvdSBjYW4g
YnVpbGQgdGhlIGJvdHRvbSBNU0kgZG9tYWluIGh3aXJxIGFzOg0KPiANCj4gICAgIGh3aXJxID0g
c2V0X2lkeCAqIDMyICsgc2V0X3N0YXR1c19iaXQ7DQo+IA0KPiBGcm9tIHRoYXQsIHlvdSBjYW4g
ZGlyZWN0bHkgZ28gYmFjayBmcm9tIGEgaHdpcnEgdG8gYSBzZXQsIGFuZCBpbmRleA0KPiB0aGUg
bXNpX3NldHNbXSBhcnJheSB0byBmaW5kIHRoZSByZWxldmFudCBpbmZvcm1hdGlvbi4NCj4gDQo+
IEFub3RoZXIgYXNzdW1wdGlvbiBpcyB0aGF0IGFsbCA4IGNhc2NhZGUgaW50ZXJydXB0cyBhcmUg
Y29udGlndW91cw0KPiAod2hpY2ggaXMgcHJldHR5IGVhc3kgdG8gZ3VhcmFudGVlKSwgbWVhbmlu
ZyB0aGF0IHlvdSBjYW4gZGlyZWN0bHkgdXNlDQo+IHRoZSBQQ0llIGludGVycnVwdCB0byBjb21w
dXRlIHRoZSBzZXQgbnVtYmVyLg0KPiANCj4gV2l0aCBhbGwgdGhhdCwgeW91IGNhbiBkaXJlY3Rs
eSBrZWVwIGEgcG9pbnRlciBmcm9tIHRoZSBib3R0b20gTVNJDQo+IGRvbWFpbiBpcnFfZGF0YSBz
dHJ1Y3R1cmVzIHRvIHRoZSBtdGtfcGNpZV9wb3J0IHN0cnVjdHVyZSwgcHJvdmlkaW5nDQo+IHlv
dSB3aXRoIGFsbCB0aGUgaW5mb3JtYXRpb24geW91IG5lZWQuDQo+IA0KPiBPbmNlIHlvdSB3aWxs
IGhhdmUgbW92ZWQgdGhlIHZhcmlvdXMgYml0cyBhdCB0aGUgcmlnaHQgcGxhY2UsIGFuZCB1c2Vk
DQo+IHRoZSBlc3RhYmxpc2hlZCBNU0kgYWJzdHJhY3Rpb25zLCB0aGluZ3Mgc2hvdWxkIGp1c3Qg
d29yay4NCg0KVGhhbmtzIGZvciB5b3VyIHF1aWNrIHJlcGx5LCBJIHdpbGwgbWFrZSB0aGUgY2hh
bmdlcyBhcyB0aGlzIHN1Z2dlc3Rpb24NCmluIHRoZSBuZXh0IHZlcnNpb24uDQo+IA0KPiBbLi4u
XQ0KPiANCj4gPiA+ID4gK3N0YXRpYyB2b2lkIG10a19pbnR4X2VvaShzdHJ1Y3QgaXJxX2RhdGEg
KmRhdGEpDQo+ID4gPiA+ICt7DQo+ID4gPiA+ICsJc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQg
PSBpcnFfZGF0YV9nZXRfaXJxX2NoaXBfZGF0YShkYXRhKTsNCj4gPiA+ID4gKwl1bnNpZ25lZCBs
b25nIGh3aXJxOw0KPiA+ID4gPiArDQo+ID4gPiA+ICsJLyoqDQo+ID4gPiA+ICsJICogQXMgYW4g
ZW11bGF0ZWQgbGV2ZWwgSVJRLCBpdHMgaW50ZXJydXB0IHN0YXR1cyB3aWxsIHJlbWFpbg0KPiA+
ID4gPiArCSAqIHVudGlsIHRoZSBjb3JyZXNwb25kaW5nIGRlLWFzc2VydCBtZXNzYWdlIGlzIHJl
Y2VpdmVkOyBoZW5jZSB0aGF0DQo+ID4gPiA+ICsJICogdGhlIHN0YXR1cyBjYW4gb25seSBiZSBj
bGVhcmVkIHdoZW4gdGhlIGludGVycnVwdCBoYXMgYmVlbiBzZXJ2aWNlZC4NCj4gPiA+ID4gKwkg
Ki8NCj4gPiA+ID4gKwlod2lycSA9IGRhdGEtPmh3aXJxICsgUENJRV9JTlRYX1NISUZUOw0KPiA+
ID4gPiArCXdyaXRlbChCSVQoaHdpcnEpLCBwb3J0LT5iYXNlICsgUENJRV9JTlRfU1RBVFVTX1JF
Ryk7DQo+ID4gPiANCj4gPiA+IEFsbCBvZiB0aGlzIGlzIHRoZSBkZXNjcmlwdGlvbiBvZiBhIGxl
dmVsIGludGVycnVwdCwgc28gdGhpcyBpcyBwcmV0dHkNCj4gPiA+IG11Y2ggZGV2b2lkIG9mIGFu
eSBpbmZvcm1hdGlvbiBhcyB0byAqd2h5KiB5b3UgbmVlZCB0byB3cml0ZSB0byBjbGVhcg0KPiA+
ID4gdGhpcyBiaXQuIFdoYXQgaGFwcGVucyBpZiB0aGUgaW50ZXJydXB0IGlzIHN0aWxsIGFzc2Vy
dGVkIGJlY2F1c2UNCj4gPiA+IG5vdGhpbmcgaGFzIGhhbmRsZWQgaXQ/IFdpdGhvdXQgYW55IGZ1
cnRoZXIgaW5mb3JtYXRpb24sIHRoaXMgbG9va3MNCj4gPiA+IHRlcnJpYmx5IHdyb25nLg0KPiA+
IA0KPiA+IFNvcnJ5LCB0aGlzIGNvbW1lbnQgc2hvdWxkIGJlIHVzZWQgdG8gZGVzY3JpYmUgdGhl
IG10a19pbnR4X2VvaQ0KPiA+IGZ1bmN0aW9uLCBpdCBjYXVzZSBtaXN1bmRlcnN0YW5kaW5ncyBh
dCB0aGlzIHBsYWNlLiBJIGp1c3Qgd2FudCB0byBhZGQNCj4gPiB0aGUgY29tbWVudCB0byBleHBs
YWluIHRoYXQgd2h5IHRoaXMgaW50ZXJydXB0IG5lZWRzIHRvIGJlIGFja2VkIGF0IHRoZQ0KPiA+
IGVuZCBvZiBpbnRlcnJ1cHQuIEkgd2lsbCBtb3ZlIGl0IHRvIHRoZSBmcm9udCBvZiBtdGtfaW50
eF9lb2kgaW4gdGhlDQo+ID4gbmV4dCB2ZXJzaW9uLg0KPiANCj4gSXMgaXQgYW4gYWNrIG9yIGFu
IGVvaT8gVGhlc2UgYXJlIHR3byBkaWZmZXJlbnQgdGhpbmdzLCBhbmQgcmVhbGx5DQo+IGRlcGVu
ZHMgb24geW91ciBIVy4gUGxlYXNlIGZpbmQgb3V0IHdoaWNoIG9uZSBpdCBpcywgYW5kIHdlIHdp
bGwgd29yaw0KPiBvdXQgYSB3YXkgdG8gaGFuZGxlIGl0Lg0KDQpBY3R1YWxseSwgaXQncyBhbiBh
Y2sgd2hpY2ggdXNlZCB0byBjbGVhciB0aGUgaW50ZXJydXB0IHN0YXR1cy4NCg0KV2hlbiB3ZSBy
ZWNlaXZlIGFuIElOVHggYXNzZXJ0IG1lc3NhZ2UgZnJvbSB0aGUgRVAgZGV2aWNlLCB0aGUNCmNv
cnJlc3BvbmRpbmcgYml0IG9mIFBDSUVfSU5UX1NUQVRVU19SRUcgd2lsbCBiZSBzZXQsIGFuZCBp
dCBjYW4gbm90IGJlDQpjbGVhcmVkIHVudGlsIHRoZSBFUCBkZXZpY2UgaGFuZGxlciBjbGVhciBp
dHMgZGV2aWNlIHN0YXR1cyBhbmQgdGhlbiB3ZQ0KcmVjZWl2ZXMgdGhlIElOVHggZGUtYXNzZXJ0
IG1lc3NhZ2UuDQoNClNvIEkgc2V0IGhhbmRsZV9mYXN0ZW9pX2lycSBhcyBpdHMgaXJxIGhhbmRs
ZXIsIGFuZCB0cnkgdG8gdXNlIGlycV9lb2kNCmNhbGxiYWNrIHRvIG1ha2Ugc3VyZSBpdCB3aWxs
IGJlIGNhbGxlZCBhZnRlciBkZXZpY2UgaGFuZGxlci4NCg0KW3NuaXBdDQo+ICtzdGF0aWMgaW50
IG10a19wY2llX2ludHhfbWFwKHN0cnVjdCBpcnFfZG9tYWluICpkb21haW4sIHVuc2lnbmVkIGlu
dA0KaXJxLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICBpcnFfaHdfbnVtYmVyX3QgaHdp
cnEpDQo+ICt7DQo+ICsgICAgIGlycV9zZXRfY2hpcF9hbmRfaGFuZGxlcl9uYW1lKGlycSwgJm10
a19pbnR4X2lycV9jaGlwLA0KPiArICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICAgICBo
YW5kbGVfZmFzdGVvaV9pcnEsICJJTlR4Iik7DQo+ICsgICAgIGlycV9zZXRfY2hpcF9kYXRhKGly
cSwgZG9tYWluLT5ob3N0X2RhdGEpOw0KPiArDQo+ICsgICAgIHJldHVybiAwOw0KPiArfQ0KPiAr
DQo+ICtzdGF0aWMgY29uc3Qgc3RydWN0IGlycV9kb21haW5fb3BzIGludHhfZG9tYWluX29wcyA9
IHsNCj4gKyAgICAgLm1hcCA9IG10a19wY2llX2ludHhfbWFwLA0KPiArfTsNCg0KPiANCj4gVGhh
bmtzLA0KPiANCj4gCU0uDQo+IA0KDQo=

