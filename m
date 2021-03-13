Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 47523339C99
	for <lists+linux-pci@lfdr.de>; Sat, 13 Mar 2021 08:48:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232462AbhCMHnp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 13 Mar 2021 02:43:45 -0500
Received: from mailgw02.mediatek.com ([1.203.163.81]:11552 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231347AbhCMHnf (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 13 Mar 2021 02:43:35 -0500
X-UUID: 6e881b54df504d03b4ffdbc7eda23a73-20210313
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=6AvDzaCujLywxZv0HuQUXpaC1pt7o8tnO0KvyLt3jRY=;
        b=qxUPZKD6DAzjKYXlW4YpwA8P0U2sOBc3GbIChyVwIpH/CCB2cNlWtLHq4N10GOwjFwgFfroo7gPi8sKoN8N2zvASHy4UuHoNOYMQ6n/xwcKlaiEcGlzHMCKgthttW7S7r3+i+yk2i6BPC5PsIDoIZ/R+xh12s5fSMlstKpcY3eI=;
X-UUID: 6e881b54df504d03b4ffdbc7eda23a73-20210313
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw02.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 138558977; Sat, 13 Mar 2021 15:43:27 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 13 Mar
 2021 15:43:14 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 13 Mar 2021 15:43:14 +0800
Message-ID: <1615621394.25662.70.camel@mhfsdcap03>
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
Date:   Sat, 13 Mar 2021 15:43:14 +0800
In-Reply-To: <20210311123844.qzl264ungtk7b6xz@pali>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-4-jianjun.wang@mediatek.com>
         <20210311123844.qzl264ungtk7b6xz@pali>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: E944CFC7D89B26022F8489BAA6FB25D117E5943FFE0BC034D1A03F9E25BF25822000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gVGh1LCAyMDIxLTAzLTExIGF0IDEzOjM4ICswMTAwLCBQYWxpIFJvaMOhciB3cm90ZToNCj4g
T24gV2VkbmVzZGF5IDI0IEZlYnJ1YXJ5IDIwMjEgMTQ6MTE6MjggSmlhbmp1biBXYW5nIHdyb3Rl
Og0KPiA+ICtzdGF0aWMgaW50IG10a19wY2llX3N0YXJ0dXBfcG9ydChzdHJ1Y3QgbXRrX3BjaWVf
cG9ydCAqcG9ydCkNCj4gPiArew0KPiAuLi4NCj4gPiArDQo+ID4gKwkvKiBEZWxheSAxMDBtcyB0
byB3YWl0IHRoZSByZWZlcmVuY2UgY2xvY2tzIGJlY29tZSBzdGFibGUgKi8NCj4gPiArCW1zbGVl
cCgxMDApOw0KPiA+ICsNCj4gPiArCS8qIERlLWFzc2VydCBQRVJTVCMgc2lnbmFsICovDQo+ID4g
Kwl2YWwgJj0gflBDSUVfUEVfUlNUQjsNCj4gPiArCXdyaXRlbF9yZWxheGVkKHZhbCwgcG9ydC0+
YmFzZSArIFBDSUVfUlNUX0NUUkxfUkVHKTsNCj4gDQo+IEhlbGxvISBUaGlzIGlzIGEgbmV3IGRy
aXZlciB3aGljaCBpbnRyb2R1Y2UgeWV0IGFub3RoZXIgY3VzdG9tIHRpbWVvdXQNCj4gcHJpb3Ig
UEVSU1QjIHNpZ25hbCBmb3IgUENJZSBjYXJkIGlzIGRlLWFzc2VydGVkLiBUaW1lb3V0cyBmb3Ig
b3RoZXINCj4gZHJpdmVycyBJIGNvbGxlY3RlZCBpbiBvbGRlciBlbWFpbCBbMl0uDQo+IA0KPiBQ
bGVhc2UgbG9vayBhdCBteSBlbWFpbCBbMV0gYWJvdXQgUENJZSBXYXJtIFJlc2V0IGlmIHlvdSBo
YXZlIGFueSBjbHVlDQo+IGFib3V0IGl0LiBMb3JlbnpvIGFuZCBSb2IgYWxyZWFkeSBleHByZXNz
ZWQgdGhhdCB0aGlzIHRpbWVvdXQgc2hvdWxkIG5vdA0KPiBiZSBkcml2ZXIgc3BlY2lmaWMuIEJ1
dCBub2JvZHkgd2FzIGFibGUgdG8gImRlY29kZSIgYW5kICJ1bmRlcnN0YW5kIg0KPiBQQ0llIHNw
ZWMgeWV0IGFib3V0IHRoZXNlIHRpbWVvdXRzLg0KDQpIaSBQYWxpLA0KDQpJIHRoaW5rIHRoaXMg
aXMgbW9yZSBsaWtlIGEgcGxhdGZvcm0gc3BlY2lmaWMgdGltZW91dCwgd2hpY2ggaXMgdXNlZCB0
bw0Kd2FpdCBmb3IgdGhlIHJlZmVyZW5jZSBjbG9ja3MgdG8gYmVjb21lIHN0YWJsZSBhbmQgZmlu
aXNoIHRoZSByZXNldCBmbG93DQpvZiBIVyBibG9ja3MuDQoNCkhlcmUgaXMgdGhlIHN0ZXBzIHRv
IHN0YXJ0IGEgbGluayB0cmFpbmluZyBpbiB0aGlzIEhXOg0KDQoxLiBBc3NlcnQgYWxsIHJlc2V0
IHNpZ25hbHMgd2hpY2ggaW5jbHVkaW5nIHRoZSB0cmFuc2FjdGlvbiBsYXllciwgUElQRQ0KaW50
ZXJmYWNlIGFuZCBpbnRlcm5hbCBidXMgaW50ZXJmYWNlOw0KDQoyLiBEZS1hc3NlcnQgcmVzZXQg
c2lnbmFscyBleGNlcHQgdGhlIFBFUlNUIywgdGhpcyB3aWxsIG1ha2UgdGhlDQpwaHlzaWNhbCBs
YXllciBhY3RpdmUgYW5kIHN0YXJ0IHRvIG91dHB1dCB0aGUgcmVmZXJlbmNlIGNsb2NrLCBidXQg
dGhlDQpFUCBkZXZpY2UgcmVtYWlucyBpbiB0aGUgcmVzZXQgc3RhdGUuDQogICBCZWZvcmUgcmVs
ZWFzaW5nIHRoZSBQRVJTVCMgc2lnbmFsLCB0aGUgSFcgYmxvY2tzIG5lZWRzIGF0IGxlYXN0IDEw
bXMNCnRvIGZpbmlzaCB0aGUgcmVzZXQgZmxvdywgYW5kIHJlZi1jbGsgbmVlZHMgYWJvdXQgMzB1
cyB0byBiZWNvbWUgc3RhYmxlLg0KDQozLiBEZS1hc3NlcnQgUEVSU1QjIHNpZ25hbCwgd2FpdCBM
VFNTTSBlbnRlciBMMCBzdGF0ZS4NCg0KVGhpcyAxMDBtcyB0aW1lb3V0IGlzIHJlZmVyZW5jZSB0
byBUUFZQRVJMIGluIHRoZSBQQ0llIENFTSBzcGVjLiBTaW5jZQ0Kd2UgYXJlIGluIHRoZSBrZXJu
ZWwgc3RhZ2UsIHRoZSBwb3dlciBzdXBwbHkgaGFzIGFscmVhZHkgc3RhYmxlZCwgdGhpcw0KdGlt
ZW91dCBtYXkgbm90IHRha2UgdGhhdCBsb25nLg0KDQo+ID4gKw0KPiA+ICsJLyogQ2hlY2sgaWYg
dGhlIGxpbmsgaXMgdXAgb3Igbm90ICovDQo+ID4gKwllcnIgPSByZWFkbF9wb2xsX3RpbWVvdXQo
cG9ydC0+YmFzZSArIFBDSUVfTElOS19TVEFUVVNfUkVHLCB2YWwsDQo+ID4gKwkJCQkgISEodmFs
ICYgUENJRV9QT1JUX0xJTktVUCksIDIwLA0KPiA+ICsJCQkJIDUwICogVVNFQ19QRVJfTVNFQyk7
DQo+IA0KPiBJSVJDLCB5b3UgbmVlZCB0byB3YWl0IGF0IGxlYXN0IDEwMG1zIGFmdGVyIGRlLWFz
c2VydGluZyBQRVJTVCMgc2lnbmFsDQo+IGFzIGl0IGlzIHJlcXVpcmVkIGJ5IFBDSWUgc3BlY3Mg
YW5kIGFsc28gYmVjYXVzZSBleHBlcmltZW50cyBwcm92ZWQgdGhhdA0KPiBzb21lIENvbXBleCB3
aWZpIGNhcmRzIChlLmcuIFdMRTkwMFZYKSBhcmUgbm90IGRldGVjdGVkIGlmIHlvdSBkbyBub3QN
Cj4gd2FpdCB0aGlzIG1pbmltYWwgdGltZS4NCg0KWWVzLCB0aGlzIHNob3VsZCBiZSAxMDBtcywg
SSB3aWxsIGZpeCBpdCBhdCBuZXh0IHZlcnNpb24sIHRoYW5rcyBmb3INCnlvdXIgcmV2aWV3Lg0K
DQpUaGFua3MuDQo+IA0KPiA+ICsJaWYgKGVycikgew0KPiA+ICsJCXZhbCA9IHJlYWRsX3JlbGF4
ZWQocG9ydC0+YmFzZSArIFBDSUVfTFRTU01fU1RBVFVTX1JFRyk7DQo+ID4gKwkJZGV2X2Vycihw
b3J0LT5kZXYsICJQQ0llIGxpbmsgZG93biwgbHRzc20gcmVnIHZhbDogJSN4XG4iLCB2YWwpOw0K
PiA+ICsJCXJldHVybiBlcnI7DQo+ID4gKwl9DQo+IA0KPiBbMV0gLSBodHRwczovL2xvcmUua2Vy
bmVsLm9yZy9saW51eC1wY2kvMjAyMTAzMTAxMTA1MzUuemg0cG5uNHZwbXZ6d2w1cUBwYWxpLw0K
PiBbMl0gLSBodHRwczovL2xvcmUua2VybmVsLm9yZy9saW51eC1wY2kvMjAyMDA0MjQwOTI1NDYu
MjVwM2hkdGtlaG9oZTN4d0BwYWxpLw0KDQo=

