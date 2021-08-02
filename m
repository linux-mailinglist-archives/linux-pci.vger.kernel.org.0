Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2843DD0F4
	for <lists+linux-pci@lfdr.de>; Mon,  2 Aug 2021 09:07:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232306AbhHBHHg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 2 Aug 2021 03:07:36 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:58432 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S229500AbhHBHHg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 2 Aug 2021 03:07:36 -0400
X-UUID: 63fb95fb88ef46a9a61516fd821c764e-20210802
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=21ZQL0O+AYNYOVFc0STZ7qW2KMKVaTPFPt6AU1g4ZHY=;
        b=WX6FnVSFJdUXjVhxXqOCRqwFQMaxZI7xH8q6uVRPDecNMKc8lNp+iGETgUqb/ZyFIE/O1EIFMttw7fS6uLyrQ2EcmRuLfnSrXhc3C2TfcQ6/C3ogCIisvzPSISmKORffyO0id1ZmeqbF8/dl3sRb3MOGcKzSdHF5FEfLtS8jHqE=;
X-UUID: 63fb95fb88ef46a9a61516fd821c764e-20210802
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 17423531; Mon, 02 Aug 2021 15:07:24 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs06n1.mediatek.inc (172.21.101.129) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 2 Aug 2021 15:07:23 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 2 Aug 2021 15:07:22 +0800
Message-ID: <1627888042.1118.2.camel@mhfsdcap03>
Subject: Re: [PATCH v11 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <ryder.lee@mediatek.com>, <jianjun.wang@mediatek.com>,
        <yong.wu@mediatek.com>, Frank Wunderlich <frank-w@public-files.de>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <chuanjia.liu@mediatek.com>
Date:   Mon, 2 Aug 2021 15:07:22 +0800
In-Reply-To: <20210719073456.28666-3-chuanjia.liu@mediatek.com>
References: <20210719073456.28666-1-chuanjia.liu@mediatek.com>
         <20210719073456.28666-3-chuanjia.liu@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Mailer: Evolution 3.10.4-0ubuntu2 
MIME-Version: 1.0
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

T24gTW9uLCAyMDIxLTA3LTE5IGF0IDE1OjM0ICswODAwLCBDaHVhbmppYSBMaXUgd3JvdGU6DQoN
CkdlbnRseSBwaW5nLi4uDQo+IEZvciB0aGUgbmV3IGR0cyBmb3JtYXQsIGFkZCBhIG5ldyBtZXRo
b2QgdG8gZ2V0DQo+IHNoYXJlZCBwY2llLWNmZyBiYXNlIGFkZHJlc3MgYW5kIHBhcnNlIG5vZGUu
DQo+IA0KPiBTaWduZWQtb2ZmLWJ5OiBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBtZWRpYXRl
ay5jb20+DQo+IEFja2VkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+
IC0tLQ0KPiAgZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMgfCA1MiArKysr
KysrKysrKysrKysrKysrLS0tLS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMo
KyksIDEzIGRlbGV0aW9ucygtKQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlh
dGVrLmMNCj4gaW5kZXggMjViZWU2OTM4MzRmLi45MjhlMDk4M2E5MDAgMTAwNjQ0DQo+IC0tLSBh
L2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+ICsrKyBiL2RyaXZlcnMv
cGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+IEBAIC0xNCw2ICsxNCw3IEBADQo+ICAj
aW5jbHVkZSA8bGludXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4
L2lycWRvbWFpbi5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiArI2luY2x1ZGUg
PGxpbnV4L21mZC9zeXNjb24uaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tc2kuaD4NCj4gICNpbmNs
dWRlIDxsaW51eC9tb2R1bGUuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+
IEBAIC0yMyw2ICsyNCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvcGh5L3BoeS5oPg0KPiAgI2lu
Y2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1
bnRpbWUuaD4NCj4gKyNpbmNsdWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gICNpbmNsdWRlIDxsaW51
eC9yZXNldC5oPg0KPiAgDQo+ICAjaW5jbHVkZSAiLi4vcGNpLmgiDQo+IEBAIC0yMDcsNiArMjA5
LDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KPiAgICogc3RydWN0IG10a19wY2llIC0gUENJ
ZSBob3N0IGluZm9ybWF0aW9uDQo+ICAgKiBAZGV2OiBwb2ludGVyIHRvIFBDSWUgZGV2aWNlDQo+
ICAgKiBAYmFzZTogSU8gbWFwcGVkIHJlZ2lzdGVyIGJhc2UNCj4gKyAqIEBjZmc6IElPIG1hcHBl
ZCByZWdpc3RlciBtYXAgZm9yIFBDSWUgY29uZmlnDQo+ICAgKiBAZnJlZV9jazogZnJlZS1ydW4g
cmVmZXJlbmNlIGNsb2NrDQo+ICAgKiBAbWVtOiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSByZXNv
dXJjZQ0KPiAgICogQHBvcnRzOiBwb2ludGVyIHRvIFBDSWUgcG9ydCBpbmZvcm1hdGlvbg0KPiBA
QCAtMjE1LDYgKzIxOCw3IEBAIHN0cnVjdCBtdGtfcGNpZV9wb3J0IHsNCj4gIHN0cnVjdCBtdGtf
cGNpZSB7DQo+ICAJc3RydWN0IGRldmljZSAqZGV2Ow0KPiAgCXZvaWQgX19pb21lbSAqYmFzZTsN
Cj4gKwlzdHJ1Y3QgcmVnbWFwICpjZmc7DQo+ICAJc3RydWN0IGNsayAqZnJlZV9jazsNCj4gIA0K
PiAgCXN0cnVjdCBsaXN0X2hlYWQgcG9ydHM7DQo+IEBAIC02NTAsNyArNjU0LDExIEBAIHN0YXRp
YyBpbnQgbXRrX3BjaWVfc2V0dXBfaXJxKHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0LA0KPiAg
CQlyZXR1cm4gZXJyOw0KPiAgCX0NCj4gIA0KPiAtCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9p
cnEocGRldiwgcG9ydC0+c2xvdCk7DQo+ICsJaWYgKG9mX2ZpbmRfcHJvcGVydHkoZGV2LT5vZl9u
b2RlLCAiaW50ZXJydXB0LW5hbWVzIiwgTlVMTCkpDQo+ICsJCXBvcnQtPmlycSA9IHBsYXRmb3Jt
X2dldF9pcnFfYnluYW1lKHBkZXYsICJwY2llX2lycSIpOw0KPiArCWVsc2UNCj4gKwkJcG9ydC0+
aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBwb3J0LT5zbG90KTsNCj4gKw0KPiAgCWlmIChw
b3J0LT5pcnEgPCAwKQ0KPiAgCQlyZXR1cm4gcG9ydC0+aXJxOw0KPiAgDQo+IEBAIC02ODIsNiAr
NjkwLDEwIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0X3YyKHN0cnVjdCBtdGtf
cGNpZV9wb3J0ICpwb3J0KQ0KPiAgCQl2YWwgfD0gUENJRV9DU1JfTFRTU01fRU4ocG9ydC0+c2xv
dCkgfA0KPiAgCQkgICAgICAgUENJRV9DU1JfQVNQTV9MMV9FTihwb3J0LT5zbG90KTsNCj4gIAkJ
d3JpdGVsKHZhbCwgcGNpZS0+YmFzZSArIFBDSUVfU1lTX0NGR19WMik7DQo+ICsJfSBlbHNlIGlm
IChwY2llLT5jZmcpIHsNCj4gKwkJdmFsID0gUENJRV9DU1JfTFRTU01fRU4ocG9ydC0+c2xvdCkg
fA0KPiArCQkgICAgICBQQ0lFX0NTUl9BU1BNX0wxX0VOKHBvcnQtPnNsb3QpOw0KPiArCQlyZWdt
YXBfdXBkYXRlX2JpdHMocGNpZS0+Y2ZnLCBQQ0lFX1NZU19DRkdfVjIsIHZhbCwgdmFsKTsNCj4g
IAl9DQo+ICANCj4gIAkvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMgKi8NCj4gQEAgLTk4NSw2
ICs5OTcsNyBAQCBzdGF0aWMgaW50IG10a19wY2llX3N1YnN5c19wb3dlcnVwKHN0cnVjdCBtdGtf
cGNpZSAqcGNpZSkNCj4gIAlzdHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2llLT5kZXY7DQo+ICAJc3Ry
dWN0IHBsYXRmb3JtX2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiAg
CXN0cnVjdCByZXNvdXJjZSAqcmVnczsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNmZ19ub2Rl
Ow0KPiAgCWludCBlcnI7DQo+ICANCj4gIAkvKiBnZXQgc2hhcmVkIHJlZ2lzdGVycywgd2hpY2gg
YXJlIG9wdGlvbmFsICovDQo+IEBAIC05OTUsNiArMTAwOCwxNCBAQCBzdGF0aWMgaW50IG10a19w
Y2llX3N1YnN5c19wb3dlcnVwKHN0cnVjdCBtdGtfcGNpZSAqcGNpZSkNCj4gIAkJCXJldHVybiBQ
VFJfRVJSKHBjaWUtPmJhc2UpOw0KPiAgCX0NCj4gIA0KPiArCWNmZ19ub2RlID0gb2ZfZmluZF9j
b21wYXRpYmxlX25vZGUoTlVMTCwgTlVMTCwNCj4gKwkJCQkJICAgIm1lZGlhdGVrLGdlbmVyaWMt
cGNpZWNmZyIpOw0KPiArCWlmIChjZmdfbm9kZSkgew0KPiArCQlwY2llLT5jZmcgPSBzeXNjb25f
bm9kZV90b19yZWdtYXAoY2ZnX25vZGUpOw0KPiArCQlpZiAoSVNfRVJSKHBjaWUtPmNmZykpDQo+
ICsJCQlyZXR1cm4gUFRSX0VSUihwY2llLT5jZmcpOw0KPiArCX0NCj4gKw0KPiAgCXBjaWUtPmZy
ZWVfY2sgPSBkZXZtX2Nsa19nZXQoZGV2LCAiZnJlZV9jayIpOw0KPiAgCWlmIChJU19FUlIocGNp
ZS0+ZnJlZV9jaykpIHsNCj4gIAkJaWYgKFBUUl9FUlIocGNpZS0+ZnJlZV9jaykgPT0gLUVQUk9C
RV9ERUZFUikNCj4gQEAgLTEwMjcsMjIgKzEwNDgsMjcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9z
ZXR1cChzdHJ1Y3QgbXRrX3BjaWUgKnBjaWUpDQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gcGNp
ZS0+ZGV2Ow0KPiAgCXN0cnVjdCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZSwgKmNo
aWxkOw0KPiAgCXN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0LCAqdG1wOw0KPiAtCWludCBlcnI7
DQo+ICsJaW50IGVyciwgc2xvdDsNCj4gKw0KPiArCXNsb3QgPSBvZl9nZXRfcGNpX2RvbWFpbl9u
cihkZXYtPm9mX25vZGUpOw0KPiArCWlmIChzbG90IDwgMCkgew0KPiArCQlmb3JfZWFjaF9hdmFp
bGFibGVfY2hpbGRfb2Zfbm9kZShub2RlLCBjaGlsZCkgew0KPiArCQkJZXJyID0gb2ZfcGNpX2dl
dF9kZXZmbihjaGlsZCk7DQo+ICsJCQlpZiAoZXJyIDwgMCkgew0KPiArCQkJCWRldl9lcnIoZGV2
LCAiZmFpbGVkIHRvIGdldCBkZXZmbjogJWRcbiIsIGVycik7DQo+ICsJCQkJZ290byBlcnJvcl9w
dXRfbm9kZTsNCj4gKwkJCX0NCj4gIA0KPiAtCWZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9u
b2RlKG5vZGUsIGNoaWxkKSB7DQo+IC0JCWludCBzbG90Ow0KPiArCQkJc2xvdCA9IFBDSV9TTE9U
KGVycik7DQo+ICANCj4gLQkJZXJyID0gb2ZfcGNpX2dldF9kZXZmbihjaGlsZCk7DQo+IC0JCWlm
IChlcnIgPCAwKSB7DQo+IC0JCQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBwYXJzZSBkZXZmbjog
JWRcbiIsIGVycik7DQo+IC0JCQlnb3RvIGVycm9yX3B1dF9ub2RlOw0KPiArCQkJZXJyID0gbXRr
X3BjaWVfcGFyc2VfcG9ydChwY2llLCBjaGlsZCwgc2xvdCk7DQo+ICsJCQlpZiAoZXJyKQ0KPiAr
CQkJCWdvdG8gZXJyb3JfcHV0X25vZGU7DQo+ICAJCX0NCj4gLQ0KPiAtCQlzbG90ID0gUENJX1NM
T1QoZXJyKTsNCj4gLQ0KPiAtCQllcnIgPSBtdGtfcGNpZV9wYXJzZV9wb3J0KHBjaWUsIGNoaWxk
LCBzbG90KTsNCj4gKwl9IGVsc2Ugew0KPiArCQllcnIgPSBtdGtfcGNpZV9wYXJzZV9wb3J0KHBj
aWUsIG5vZGUsIHNsb3QpOw0KPiAgCQlpZiAoZXJyKQ0KPiAtCQkJZ290byBlcnJvcl9wdXRfbm9k
ZTsNCj4gKwkJCXJldHVybiBlcnI7DQo+ICAJfQ0KPiAgDQo+ICAJZXJyID0gbXRrX3BjaWVfc3Vi
c3lzX3Bvd2VydXAocGNpZSk7DQoNCg==

