Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A99A833FF0D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Mar 2021 06:49:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229512AbhCRFsi (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 18 Mar 2021 01:48:38 -0400
Received: from mailgw02.mediatek.com ([1.203.163.81]:42576 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229586AbhCRFsP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 18 Mar 2021 01:48:15 -0400
X-UUID: d92e5c71f2914813ad85043615339670-20210318
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=/KcYFvhsJArJ3/t55wAeGyd65YjMgQvBBf9+aHmFNFA=;
        b=uBIS7mpLD+f+a20uQowQ0YLNirPdUDySth+u9Ew6aEkljuRnDlWu+8E5V/98beVKfomotmQa6i3eiZkoTt/FLiEibyUoWYl4664f374+bMaIq0n1XaLNJU0FA0cAbG8lUmfU5ji5iGtrXkRhP9vgNet0qlgYk7eu3tp46eNbL8k=;
X-UUID: d92e5c71f2914813ad85043615339670-20210318
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 720661032; Thu, 18 Mar 2021 13:48:10 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N2.mediatek.inc
 (172.27.4.87) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 18 Mar
 2021 13:48:08 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 18 Mar 2021 13:48:07 +0800
Message-ID: <1616046487.31760.16.camel@mhfsdcap03>
Subject: Re: [v8,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Pali =?ISO-8859-1?Q?Roh=E1r?= <pali@kernel.org>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, <maz@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        "Sj Huang" <sj.huang@mediatek.com>, <youlin.pei@mediatek.com>,
        <chuanjia.liu@mediatek.com>, <qizhong.cheng@mediatek.com>,
        <sin_jieyang@mediatek.com>, <drinkcat@chromium.org>,
        <Rex-BC.Chen@mediatek.com>, <anson.chuang@mediatek.com>
Date:   Thu, 18 Mar 2021 13:48:07 +0800
In-Reply-To: <20210318000211.ykjsfavfc7suu2sb@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-4-jianjun.wang@mediatek.com>
         <20210311123844.qzl264ungtk7b6xz@pali>
         <1615621394.25662.70.camel@mhfsdcap03>
         <20210318000211.ykjsfavfc7suu2sb@pali>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 35ECDF3533BA98CB7C3ABD2BE2E14BD4CA98B92D80A84EDF57D37D9FD169DF3A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTE4IGF0IDAxOjAyICswMTAwLCBQYWxpIFJvaMOhciB3cm90ZToNCj4g
T24gU2F0dXJkYXkgMTMgTWFyY2ggMjAyMSAxNTo0MzoxNCBKaWFuanVuIFdhbmcgd3JvdGU6DQo+
ID4gT24gVGh1LCAyMDIxLTAzLTExIGF0IDEzOjM4ICswMTAwLCBQYWxpIFJvaMOhciB3cm90ZToN
Cj4gPiA+IE9uIFdlZG5lc2RheSAyNCBGZWJydWFyeSAyMDIxIDE0OjExOjI4IEppYW5qdW4gV2Fu
ZyB3cm90ZToNCj4gPiA+ID4gK3N0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0KHN0cnVj
dCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KPiA+ID4gPiArew0KPiA+ID4gLi4uDQo+ID4gPiA+ICsN
Cj4gPiA+ID4gKwkvKiBEZWxheSAxMDBtcyB0byB3YWl0IHRoZSByZWZlcmVuY2UgY2xvY2tzIGJl
Y29tZSBzdGFibGUgKi8NCj4gPiA+ID4gKwltc2xlZXAoMTAwKTsNCj4gPiA+ID4gKw0KPiA+ID4g
PiArCS8qIERlLWFzc2VydCBQRVJTVCMgc2lnbmFsICovDQo+ID4gPiA+ICsJdmFsICY9IH5QQ0lF
X1BFX1JTVEI7DQo+ID4gPiA+ICsJd3JpdGVsX3JlbGF4ZWQodmFsLCBwb3J0LT5iYXNlICsgUENJ
RV9SU1RfQ1RSTF9SRUcpOw0KPiA+ID4gDQo+ID4gPiBIZWxsbyEgVGhpcyBpcyBhIG5ldyBkcml2
ZXIgd2hpY2ggaW50cm9kdWNlIHlldCBhbm90aGVyIGN1c3RvbSB0aW1lb3V0DQo+ID4gPiBwcmlv
ciBQRVJTVCMgc2lnbmFsIGZvciBQQ0llIGNhcmQgaXMgZGUtYXNzZXJ0ZWQuIFRpbWVvdXRzIGZv
ciBvdGhlcg0KPiA+ID4gZHJpdmVycyBJIGNvbGxlY3RlZCBpbiBvbGRlciBlbWFpbCBbMl0uDQo+
ID4gPiANCj4gPiA+IFBsZWFzZSBsb29rIGF0IG15IGVtYWlsIFsxXSBhYm91dCBQQ0llIFdhcm0g
UmVzZXQgaWYgeW91IGhhdmUgYW55IGNsdWUNCj4gPiA+IGFib3V0IGl0LiBMb3JlbnpvIGFuZCBS
b2IgYWxyZWFkeSBleHByZXNzZWQgdGhhdCB0aGlzIHRpbWVvdXQgc2hvdWxkIG5vdA0KPiA+ID4g
YmUgZHJpdmVyIHNwZWNpZmljLiBCdXQgbm9ib2R5IHdhcyBhYmxlIHRvICJkZWNvZGUiIGFuZCAi
dW5kZXJzdGFuZCINCj4gPiA+IFBDSWUgc3BlYyB5ZXQgYWJvdXQgdGhlc2UgdGltZW91dHMuDQo+
ID4gDQo+ID4gSGkgUGFsaSwNCj4gPiANCj4gPiBJIHRoaW5rIHRoaXMgaXMgbW9yZSBsaWtlIGEg
cGxhdGZvcm0gc3BlY2lmaWMgdGltZW91dCwgd2hpY2ggaXMgdXNlZCB0bw0KPiA+IHdhaXQgZm9y
IHRoZSByZWZlcmVuY2UgY2xvY2tzIHRvIGJlY29tZSBzdGFibGUgYW5kIGZpbmlzaCB0aGUgcmVz
ZXQgZmxvdw0KPiA+IG9mIEhXIGJsb2Nrcy4NCj4gPiANCj4gPiBIZXJlIGlzIHRoZSBzdGVwcyB0
byBzdGFydCBhIGxpbmsgdHJhaW5pbmcgaW4gdGhpcyBIVzoNCj4gPiANCj4gPiAxLiBBc3NlcnQg
YWxsIHJlc2V0IHNpZ25hbHMgd2hpY2ggaW5jbHVkaW5nIHRoZSB0cmFuc2FjdGlvbiBsYXllciwg
UElQRQ0KPiA+IGludGVyZmFjZSBhbmQgaW50ZXJuYWwgYnVzIGludGVyZmFjZTsNCj4gPiANCj4g
PiAyLiBEZS1hc3NlcnQgcmVzZXQgc2lnbmFscyBleGNlcHQgdGhlIFBFUlNUIywgdGhpcyB3aWxs
IG1ha2UgdGhlDQo+ID4gcGh5c2ljYWwgbGF5ZXIgYWN0aXZlIGFuZCBzdGFydCB0byBvdXRwdXQg
dGhlIHJlZmVyZW5jZSBjbG9jaywgYnV0IHRoZQ0KPiA+IEVQIGRldmljZSByZW1haW5zIGluIHRo
ZSByZXNldCBzdGF0ZS4NCj4gPiAgICBCZWZvcmUgcmVsZWFzaW5nIHRoZSBQRVJTVCMgc2lnbmFs
LCB0aGUgSFcgYmxvY2tzIG5lZWRzIGF0IGxlYXN0IDEwbXMNCj4gPiB0byBmaW5pc2ggdGhlIHJl
c2V0IGZsb3csIGFuZCByZWYtY2xrIG5lZWRzIGFib3V0IDMwdXMgdG8gYmVjb21lIHN0YWJsZS4N
Cj4gPiANCj4gPiAzLiBEZS1hc3NlcnQgUEVSU1QjIHNpZ25hbCwgd2FpdCBMVFNTTSBlbnRlciBM
MCBzdGF0ZS4NCj4gPiANCj4gPiBUaGlzIDEwMG1zIHRpbWVvdXQgaXMgcmVmZXJlbmNlIHRvIFRQ
VlBFUkwgaW4gdGhlIFBDSWUgQ0VNIHNwZWMuIFNpbmNlDQo+ID4gd2UgYXJlIGluIHRoZSBrZXJu
ZWwgc3RhZ2UsIHRoZSBwb3dlciBzdXBwbHkgaGFzIGFscmVhZHkgc3RhYmxlZCwgdGhpcw0KPiA+
IHRpbWVvdXQgbWF5IG5vdCB0YWtlIHRoYXQgbG9uZy4NCj4gDQo+IEkgdGhpbmsgdGhhdCB0aGlz
IGlzIG5vdCBwbGF0Zm9ybSBzcGVjaWZpYyB0aW1lb3V0IG9yIHBsYXRmb3JtIHNwZWNpZmljDQo+
IHN0ZXBzLiBUaGlzIG1hdGNoZXMgZ2VuZXJpYyBzdGVwcyBhcyBkZWZpbmVkIGluIFBDSWUgQ0VN
IHNwZWMsIHNlY3Rpb24NCj4gMi4yLjEuIEluaXRpYWwgUG93ZXItVXAgKEczIHRvIFMwKS4NCj4g
DQo+IFdoYXQgaXMgcGxhdGZvcm0gc3BlY2lmaWMgaXMganVzdCBob3cgdG8gYWNoaWV2ZSB0aGVz
ZSBzdGVwcy4NCj4gDQo+IEFtIEkgcmlnaHQ/DQo+IA0KPiAuLi4NCj4gDQo+IFRQVlBFUkwgaXMg
b25lIG9mIG15IHRpbWVvdXQgY2FuZGlkYXRlcyBhcyBtaW5pbWFsIHJlcXVpcmVkIHRpbWVvdXQg
Zm9yDQo+IFdhcm0gUmVzZXQuIEkgaGF2ZSB3cm90ZSBpdCBpbiBlbWFpbDoNCj4gDQo+IGh0dHBz
Oi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIwMDQzMDA4MjI0NS54Ymx2Yjd4ZWFtbTRl
MzM2QHBhbGkvDQo+IA0KPiBCdXQgSSdtIG5vdCBzdXJlIGFzIHNwZWNpYWxseSBpbiBub25lIGRp
YWdyYW0gaXMgZGVzY3JpYmVkIGp1c3Qgd2FybQ0KPiByZXNldCBhcyBkZWZpbmVkIGluIG1QQ0ll
IENFTSAoMy4yLjQuMy4gUEVSU1QjIFNpZ25hbCkuDQo+IA0KPiAuLi4NCj4gDQo+IEFueXdheSwg
SSB3b3VsZCBzdWdnZXN0IHRvIGRlZmluZSBjb25zdGFudHMgZm9yIHRob3NlIHRpbWVvdXRzLiBJ
IGd1ZXNzDQo+IHRoYXQgaW4gZnV0dXJlIHdlIGNvdWxkIGJlIGFibGUgdG8gZGVmaW5lICJnZW5l
cmljIiB0aW1lb3V0IGNvbnN0YW50cw0KPiB3aGljaCB3b3VsZCBub3QgYmUgaW4gcHJpdmF0ZSBk
cml2ZXIgc2VjdGlvbiwgYnV0IGluIHNvbWUgY29tbW9uIGhlYWRlcg0KPiBmaWxlLg0KDQpJIGFn
cmVlIHdpdGggdGhpcywgYnV0IEknbSBub3Qgc3VyZSBpZiB3ZSByZWFsbHkgbmVlZCB0aGF0IGxv
bmcgdGltZSBpbg0KdGhlIGtlcm5lbCBzdGFnZSwgYmVjYXVzZSB0aGUgcG93ZXIgc3VwcGx5IGhh
cyBhbHJlYWR5IHN0YWJsZSBhbmQgaXQncw0KcmVhbGx5IGltcGFjdCB0aGUgYm9vdCB0aW1lLCBl
c3BlY2lhbGx5IHdoZW4gdGhlIHBsYXRmb3JtIGhhdmUgbXVsdGkNCnBvcnRzIGFuZCBub3QgY29u
bmVjdCBhbnkgRVAgZGV2aWNlLCB3ZSBuZWVkIHRvIHdhaXQgMjAwbXMgZm9yIGVhY2ggcG9ydA0K
d2hlbiBzeXN0ZW0gYm9vdHVwLg0KDQpGb3IgdGhpcyBQQ0llIGNvbnRyb2xsZXIgZHJpdmVyLCBJ
IHdvdWxkIGxpa2UgdG8gY2hhbmdlIHRoZSB0aW1lb3V0DQp2YWx1ZSB0byAxMG1zIHRvIGNvbXBs
eSB3aXRoIHRoZSBIVyBkZXNpZ24sIGFuZCBzYXZlIHNvbWUgYm9vdCB0aW1lLg0KDQo+IA0KPiA+
ID4gPiArDQo+ID4gPiA+ICsJLyogQ2hlY2sgaWYgdGhlIGxpbmsgaXMgdXAgb3Igbm90ICovDQo+
ID4gPiA+ICsJZXJyID0gcmVhZGxfcG9sbF90aW1lb3V0KHBvcnQtPmJhc2UgKyBQQ0lFX0xJTktf
U1RBVFVTX1JFRywgdmFsLA0KPiA+ID4gPiArCQkJCSAhISh2YWwgJiBQQ0lFX1BPUlRfTElOS1VQ
KSwgMjAsDQo+ID4gPiA+ICsJCQkJIDUwICogVVNFQ19QRVJfTVNFQyk7DQo+ID4gPiANCj4gPiA+
IElJUkMsIHlvdSBuZWVkIHRvIHdhaXQgYXQgbGVhc3QgMTAwbXMgYWZ0ZXIgZGUtYXNzZXJ0aW5n
IFBFUlNUIyBzaWduYWwNCj4gPiA+IGFzIGl0IGlzIHJlcXVpcmVkIGJ5IFBDSWUgc3BlY3MgYW5k
IGFsc28gYmVjYXVzZSBleHBlcmltZW50cyBwcm92ZWQgdGhhdA0KPiA+ID4gc29tZSBDb21wZXgg
d2lmaSBjYXJkcyAoZS5nLiBXTEU5MDBWWCkgYXJlIG5vdCBkZXRlY3RlZCBpZiB5b3UgZG8gbm90
DQo+ID4gPiB3YWl0IHRoaXMgbWluaW1hbCB0aW1lLg0KPiA+IA0KPiA+IFllcywgdGhpcyBzaG91
bGQgYmUgMTAwbXMsIEkgd2lsbCBmaXggaXQgYXQgbmV4dCB2ZXJzaW9uLCB0aGFua3MgZm9yDQo+
ID4geW91ciByZXZpZXcuDQo+IA0KPiBJbiBwYXN0IEJqb3JuIHN1Z2dlc3RlZCB0byB1c2UgbXNs
ZWVwKFBDSV9QTV9EM0NPTERfV0FJVCk7IG1hY3JvIGZvcg0KPiB0aGlzIHN0ZXAgZHVyaW5nIHJl
dmlld2luZyBhYXJkdmFyayBkcml2ZXIuDQo+IA0KPiBodHRwczovL2xvcmUua2VybmVsLm9yZy9s
aW51eC1wY2kvMjAxOTA0MjYxNjEwNTAuR0ExODk5NjRAZ29vZ2xlLmNvbS8NCj4gDQo+IEFuZCBu
ZXh0IGl0ZXJhdGlvbiB1c2VkIHRoaXMgUENJX1BNX0QzQ09MRF9XQUlUIG1hY3JvIGluc3RlYWQg
b2YgMTAwOg0KPiANCj4gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGludXgtcGNpLzIwMTkwNTIy
MjEzMzUxLjIxMzY2LTItcmVwa0B0cmlwbGVmYXUubHQvDQoNClN1cmUsIEkgd2lsbCB1c2UgUENJ
X1BNX0QzQ09MRF9XQUlUIG1hY3JvIGluc3RlYWQgaW4gdGhlIG5leHQgdmVyc2lvbi4NCg0KVGhh
bmtzLg0KDQo+IA0KPiA+IFRoYW5rcy4NCj4gPiA+IA0KPiA+ID4gPiArCWlmIChlcnIpIHsNCj4g
PiA+ID4gKwkJdmFsID0gcmVhZGxfcmVsYXhlZChwb3J0LT5iYXNlICsgUENJRV9MVFNTTV9TVEFU
VVNfUkVHKTsNCj4gPiA+ID4gKwkJZGV2X2Vycihwb3J0LT5kZXYsICJQQ0llIGxpbmsgZG93biwg
bHRzc20gcmVnIHZhbDogJSN4XG4iLCB2YWwpOw0KPiA+ID4gPiArCQlyZXR1cm4gZXJyOw0KPiA+
ID4gPiArCX0NCj4gPiA+IA0KPiA+ID4gWzFdIC0gaHR0cHM6Ly9sb3JlLmtlcm5lbC5vcmcvbGlu
dXgtcGNpLzIwMjEwMzEwMTEwNTM1LnpoNHBubjR2cG12endsNXFAcGFsaS8NCj4gPiA+IFsyXSAt
IGh0dHBzOi8vbG9yZS5rZXJuZWwub3JnL2xpbnV4LXBjaS8yMDIwMDQyNDA5MjU0Ni4yNXAzaGR0
a2Vob2hlM3h3QHBhbGkvDQo+ID4gDQoNCg==

