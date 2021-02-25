Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 72549324936
	for <lists+linux-pci@lfdr.de>; Thu, 25 Feb 2021 04:09:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232661AbhBYDIv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 24 Feb 2021 22:08:51 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:47792 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S236943AbhBYDIn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 24 Feb 2021 22:08:43 -0500
X-UUID: eda43ca6ea854848ba867daa97936520-20210225
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=y3Z6bXHSxYt/XefMUF2Ej5G5MK26sx3R7f8iqkwRjHQ=;
        b=jC1XbRF1m0o5uKo5iFZVsMOIgh9gvq2o7nw1zhyf32jZxNmJKrY8uMkMk117O57oBFiD5UO3o+nhmXp99xlmYX7Ui/faFixobcblX+SaLEUU2N4sM7hpp/XlxYa8QcEJ9odZaeHOLj0Oz/l6FShIGYepHrNH+O1yAwdeoPhj1N8=;
X-UUID: eda43ca6ea854848ba867daa97936520-20210225
Received: from mtkcas34.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <jianjun.wang@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 792184379; Thu, 25 Feb 2021 11:07:40 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 25 Feb
 2021 11:07:28 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 25 Feb 2021 11:07:27 +0800
Message-ID: <1614222447.25750.6.camel@mhfsdcap03>
Subject: Re: [v8,3/7] PCI: mediatek-gen3: Add MediaTek Gen3 driver for MT8192
From:   Jianjun Wang <jianjun.wang@mediatek.com>
To:     Krzysztof =?UTF-8?Q?Wilczy=C5=84ski?= <kw@linux.com>
CC:     Bjorn Helgaas <helgaas@kernel.org>,
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
Date:   Thu, 25 Feb 2021 11:07:27 +0800
In-Reply-To: <YDZWUGcKet/lNWlF@rocinante>
References: <20210224061132.26526-1-jianjun.wang@mediatek.com>
         <20210224061132.26526-4-jianjun.wang@mediatek.com>
         <YDZWUGcKet/lNWlF@rocinante>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-TM-SNTS-SMTP: 2527535507F0EF02A04F06AA3D3F45EB233404E3E614B1CDEF1DCB52D726076A2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

SGkgS3J6eXN6dG9mLA0KDQpUaGFua3MgZm9yIHlvdXIgcmV2aWV3LCBJIHdpbGwgZml4IHRoZXNl
IGF0IG5leHQgdmVyc2lvbi4NCg0KVGhhbmtzLg0KDQpPbiBXZWQsIDIwMjEtMDItMjQgYXQgMTQ6
MzYgKzAxMDAsIEtyenlzenRvZiBXaWxjennFhHNraSB3cm90ZToNCj4gSGkgSmlhbmp1biwNCj4g
DQo+IFRoYW5rIHlvdSBmb3IgYWxsIHRoZSB3b3JrIGhlcmUhDQo+IA0KPiBbLi4uXQ0KPiA+ICsg
KiBzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAtIFBDSWUgcG9ydCBpbmZvcm1hdGlvbg0KPiA+ICsgKiBA
ZGV2OiBwb2ludGVyIHRvIFBDSWUgZGV2aWNlDQo+ID4gKyAqIEBiYXNlOiBJTyBtYXBwZWQgcmVn
aXN0ZXIgYmFzZQ0KPiA+ICsgKiBAcmVnX2Jhc2U6IFBoeXNpY2FsIHJlZ2lzdGVyIGJhc2UNCj4g
PiArICogQG1hY19yZXNldDogbWFjIHJlc2V0IGNvbnRyb2wNCj4gPiArICogQHBoeV9yZXNldDog
cGh5IHJlc2V0IGNvbnRyb2wNCj4gPiArICogQHBoeTogUEhZIGNvbnRyb2xsZXIgYmxvY2sNCj4g
PiArICogQGNsa3M6IFBDSWUgY2xvY2tzDQo+ID4gKyAqIEBudW1fY2xrczogUENJZSBjbG9ja3Mg
Y291bnQgZm9yIHRoaXMgcG9ydA0KPiANCj4gSXQgd291bGQgYmUgIk1BQyIgYW5kICJQSFkiIGlu
IHRoZSBhYm92ZS4NCj4gDQo+IFsuLi5dDQo+ID4gKyAqIG10a19wY2llX2NvbmZpZ190bHBfaGVh
ZGVyDQo+ID4gKyAqIEBidXM6IFBDSSBidXMgdG8gcXVlcnkNCj4gPiArICogQGRldmZuOiBkZXZp
Y2UvZnVuY3Rpb24gbnVtYmVyDQo+ID4gKyAqIEB3aGVyZTogb2Zmc2V0IGluIGNvbmZpZyBzcGFj
ZQ0KPiA+ICsgKiBAc2l6ZTogZGF0YSBzaXplIGluIFRMUCBoZWFkZXINCj4gPiArICoNCj4gPiAr
ICogU2V0IGJ5dGUgZW5hYmxlIGZpZWxkIGFuZCBkZXZpY2UgaW5mb3JtYXRpb24gaW4gY29uZmln
dXJhdGlvbiBUTFAgaGVhZGVyLg0KPiANCj4gVGhlIGtlcm5lbC1kb2MgYWJvdmUgbWlnaHQgYmUg
bWlzc2luZyBicmllZiBmdW5jdGlvbiBkZXNjcmlwdGlvbi4gIFNlZQ0KPiB0aGUgZm9sbG93aW5n
IGZvciBtb3JlIGNvbmNyZXRlIGV4YW1wbGU6DQo+IA0KPiAgIGh0dHBzOi8vd3d3Lmtlcm5lbC5v
cmcvZG9jL2h0bWwvbGF0ZXN0L2RvYy1ndWlkZS9rZXJuZWwtZG9jLmh0bWwjZnVuY3Rpb24tZG9j
dW1lbnRhdGlvbg0KPiANCj4gWy4uLl0NCj4gPiArc3RhdGljIGludCBtdGtfcGNpZV9zZXRfdHJh
bnNfdGFibGUoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQsDQo+ID4gKwkJCQkgICAgcmVzb3Vy
Y2Vfc2l6ZV90IGNwdV9hZGRyLA0KPiA+ICsJCQkJICAgIHJlc291cmNlX3NpemVfdCBwY2lfYWRk
ciwNCj4gPiArCQkJCSAgICByZXNvdXJjZV9zaXplX3Qgc2l6ZSwNCj4gPiArCQkJCSAgICB1bnNp
Z25lZCBsb25nIHR5cGUsIGludCBudW0pDQo+ID4gK3sNCj4gPiArCXZvaWQgX19pb21lbSAqdGFi
bGU7DQo+ID4gKwl1MzIgdmFsOw0KPiA+ICsNCj4gPiArCWlmIChudW0gPj0gUENJRV9NQVhfVFJB
TlNfVEFCTEVTKSB7DQo+ID4gKwkJZGV2X2Vycihwb3J0LT5kZXYsICJub3QgZW5vdWdoIHRyYW5z
bGF0ZSB0YWJsZVslZF0gZm9yIGFkZHI6ICUjbGx4LCBsaW1pdGVkIHRvIFslZF1cbiIsDQo+IA0K
PiBUaGUgd29yZGluZyBvZiB0aGlzIGVycm9yIG1lc3NhZ2UgaXMgYSBsaXR0bGUgY29uZnVzaW5n
Lg0KPiANCj4gPiArCQkJbnVtLCAodW5zaWduZWQgbG9uZyBsb25nKSBjcHVfYWRkciwNCj4gDQo+
IE5vIHNwYWNlIGJldHdlZW4gdGhlIGJyYWNrZXQgYW5kIHRoZSB2YXJpYWJsZSBuYW1lLg0KPiAN
Cj4gWy4uLl0NCj4gPiArCWVyciA9IHBoeV9pbml0KHBvcnQtPnBoeSk7DQo+ID4gKwlpZiAoZXJy
KSB7DQo+ID4gKwkJZGV2X2VycihkZXYsICJmYWlsZWQgdG8gaW5pdGlhbGl6ZSBQQ0llIHBoeVxu
Iik7DQo+ID4gKwkJZ290byBlcnJfcGh5X2luaXQ7DQo+ID4gKwl9DQo+ID4gKw0KPiA+ICsJZXJy
ID0gcGh5X3Bvd2VyX29uKHBvcnQtPnBoeSk7DQo+ID4gKwlpZiAoZXJyKSB7DQo+ID4gKwkJZGV2
X2VycihkZXYsICJmYWlsZWQgdG8gcG93ZXIgb24gUENJZSBwaHlcbiIpOw0KPiA+ICsJCWdvdG8g
ZXJyX3BoeV9vbjsNCj4gPiArCX0NCj4gWy4uLl0NCj4gDQo+IEl0IHdvdWxkIGJlICJQSFkiIGlu
IHRoZSBlcnJvciBtZXNzYWdlcyBhYm92ZS4NCj4gDQo+IFsuLi5dDQo+ID4gKwlpZiAoZXJyKSB7
DQo+ID4gKwkJZGV2X2VycihkZXYsICJjbG9jayBpbml0IGZhaWxlZFxuIik7DQo+ID4gKwkJZ290
byBlcnJfY2xrX2luaXQ7DQo+ID4gKwl9DQo+IFsuLi5dDQo+IA0KPiBBIG5pdHBpY2ssIHNvIGZl
ZWwgZnJlZSB0byBpZ25vcmUgaXQsIG9mIGNvdXJzZS4gIFdoYXQgYWJvdXQgImZhaWxlZCB0bw0K
PiBpbml0aWFsaXplIGNsb2NrIiB0byBrZWVwIHRoZSBzdHlsZSBjb25zaXN0ZW50Lg0KPiANCj4g
Wy4uLl0NCj4gPiArCWVyciA9IG10a19wY2llX3N0YXJ0dXBfcG9ydChwb3J0KTsNCj4gPiArCWlm
IChlcnIpIHsNCj4gPiArCQlkZXZfZXJyKGRldiwgIlBDSWUgc3RhcnR1cCBmYWlsZWRcbiIpOw0K
PiBbLi4uXQ0KPiANCj4gQWxzbyBhIG5pdHBpY2suICBXaGF0IGFib3V0ICJmYWlsZWQgdG8gYnJp
bmcgUENJZSBsaW5rIHVwIj8NCj4gDQo+IEtyenlzenRvZg0KDQo=

