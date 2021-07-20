Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3828E3CF251
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 05:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239019AbhGTCWH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 19 Jul 2021 22:22:07 -0400
Received: from mailgw01.mediatek.com ([60.244.123.138]:56484 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S238258AbhGTCTE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 19 Jul 2021 22:19:04 -0400
X-UUID: d03943b525674c34ba6f5a4f6dc3276c-20210720
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:MIME-Version:Content-Type:References:In-Reply-To:Date:CC:To:From:Subject:Message-ID; bh=Oix+NKONo3dc98HO65gjSGiue5LNvnVPNsPdxoehHC0=;
        b=qLWHGOLye72IHuvgDNrvZDRZTx7oqfgxPPBK6n93kWohTEF/p3qJEAqac1XprwzjvardCfHm5gHlw4wR1yl1tWk/nQuupgsTCieQTvCFBUL9tfNhpQV0Ymw6cUb209krQw4dwxFZcX3t08kX8gddoFxebhrMHJmsO5UTsgvh3o0=;
X-UUID: d03943b525674c34ba6f5a4f6dc3276c-20210720
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 498812155; Tue, 20 Jul 2021 10:59:40 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs02n2.mediatek.inc (172.21.101.101) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Tue, 20 Jul 2021 10:59:39 +0800
Received: from [10.17.3.153] (10.17.3.153) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 20 Jul 2021 10:59:38 +0800
Message-ID: <1626749978.2466.14.camel@mhfsdcap03>
Subject: Re: [PATCH v11 2/4] PCI: mediatek: Add new method to get shared
 pcie-cfg base address and parse node
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     <robh+dt@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        "Matthias Brugger" <matthias.bgg@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <bhelgaas@google.com>, <matthias.bgg@gmail.com>,
        <lorenzo.pieralisi@arm.com>, <ryder.lee@mediatek.com>,
        <jianjun.wang@mediatek.com>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>
Date:   Tue, 20 Jul 2021 10:59:38 +0800
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

T24gTW9uLCAyMDIxLTA3LTE5IGF0IDE1OjM0ICswODAwLCBDaHVhbmppYSBMaXUgd3JvdGU6DQo+
IEZvciB0aGUgbmV3IGR0cyBmb3JtYXQsIGFkZCBhIG5ldyBtZXRob2QgdG8gZ2V0DQo+IHNoYXJl
ZCBwY2llLWNmZyBiYXNlIGFkZHJlc3MgYW5kIHBhcnNlIG5vZGUuDQo+IA0KPiBTaWduZWQtb2Zm
LWJ5OiBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBtZWRpYXRlay5jb20+DQo+IEFja2VkLWJ5
OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQo+IC0tLQ0KPiAgZHJpdmVycy9w
Y2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMgfCA1MiArKysrKysrKysrKysrKysrKysrLS0t
LS0tLQ0KPiAgMSBmaWxlIGNoYW5nZWQsIDM5IGluc2VydGlvbnMoKyksIDEzIGRlbGV0aW9ucygt
KQ0KPiANCj4gZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRl
ay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCj4gaW5kZXggMjVi
ZWU2OTM4MzRmLi45MjhlMDk4M2E5MDAgMTAwNjQ0DQo+IC0tLSBhL2RyaXZlcnMvcGNpL2NvbnRy
b2xsZXIvcGNpZS1tZWRpYXRlay5jDQo+ICsrKyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNp
ZS1tZWRpYXRlay5jDQo+IEBAIC0xNCw2ICsxNCw3IEBADQo+ICAjaW5jbHVkZSA8bGludXgvaXJx
Y2hpcC9jaGFpbmVkX2lycS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L2lycWRvbWFpbi5oPg0KPiAg
I2luY2x1ZGUgPGxpbnV4L2tlcm5lbC5oPg0KPiArI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24u
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9tc2kuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9tb2R1bGUu
aD4NCj4gICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQo+IEBAIC0yMyw2ICsyNCw3IEBA
DQo+ICAjaW5jbHVkZSA8bGludXgvcGh5L3BoeS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BsYXRm
b3JtX2RldmljZS5oPg0KPiAgI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCj4gKyNpbmNs
dWRlIDxsaW51eC9yZWdtYXAuaD4NCj4gICNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KPiAgDQo+
ICAjaW5jbHVkZSAiLi4vcGNpLmgiDQo+IEBAIC0yMDcsNiArMjA5LDcgQEAgc3RydWN0IG10a19w
Y2llX3BvcnQgew0KPiAgICogc3RydWN0IG10a19wY2llIC0gUENJZSBob3N0IGluZm9ybWF0aW9u
DQo+ICAgKiBAZGV2OiBwb2ludGVyIHRvIFBDSWUgZGV2aWNlDQo+ICAgKiBAYmFzZTogSU8gbWFw
cGVkIHJlZ2lzdGVyIGJhc2UNCj4gKyAqIEBjZmc6IElPIG1hcHBlZCByZWdpc3RlciBtYXAgZm9y
IFBDSWUgY29uZmlnDQo+ICAgKiBAZnJlZV9jazogZnJlZS1ydW4gcmVmZXJlbmNlIGNsb2NrDQo+
ICAgKiBAbWVtOiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSByZXNvdXJjZQ0KPiAgICogQHBvcnRz
OiBwb2ludGVyIHRvIFBDSWUgcG9ydCBpbmZvcm1hdGlvbg0KPiBAQCAtMjE1LDYgKzIxOCw3IEBA
IHN0cnVjdCBtdGtfcGNpZV9wb3J0IHsNCj4gIHN0cnVjdCBtdGtfcGNpZSB7DQo+ICAJc3RydWN0
IGRldmljZSAqZGV2Ow0KPiAgCXZvaWQgX19pb21lbSAqYmFzZTsNCj4gKwlzdHJ1Y3QgcmVnbWFw
ICpjZmc7DQo+ICAJc3RydWN0IGNsayAqZnJlZV9jazsNCj4gIA0KPiAgCXN0cnVjdCBsaXN0X2hl
YWQgcG9ydHM7DQo+IEBAIC02NTAsNyArNjU0LDExIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc2V0
dXBfaXJxKHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0LA0KPiAgCQlyZXR1cm4gZXJyOw0KPiAg
CX0NCj4gIA0KPiAtCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgcG9ydC0+c2xv
dCk7DQo+ICsJaWYgKG9mX2ZpbmRfcHJvcGVydHkoZGV2LT5vZl9ub2RlLCAiaW50ZXJydXB0LW5h
bWVzIiwgTlVMTCkpDQo+ICsJCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKHBk
ZXYsICJwY2llX2lycSIpOw0KPiArCWVsc2UNCj4gKwkJcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0
X2lycShwZGV2LCBwb3J0LT5zbG90KTsNCj4gKw0KPiAgCWlmIChwb3J0LT5pcnEgPCAwKQ0KPiAg
CQlyZXR1cm4gcG9ydC0+aXJxOw0KPiAgDQo+IEBAIC02ODIsNiArNjkwLDEwIEBAIHN0YXRpYyBp
bnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0X3YyKHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0K
PiAgCQl2YWwgfD0gUENJRV9DU1JfTFRTU01fRU4ocG9ydC0+c2xvdCkgfA0KPiAgCQkgICAgICAg
UENJRV9DU1JfQVNQTV9MMV9FTihwb3J0LT5zbG90KTsNCj4gIAkJd3JpdGVsKHZhbCwgcGNpZS0+
YmFzZSArIFBDSUVfU1lTX0NGR19WMik7DQo+ICsJfSBlbHNlIGlmIChwY2llLT5jZmcpIHsNCj4g
KwkJdmFsID0gUENJRV9DU1JfTFRTU01fRU4ocG9ydC0+c2xvdCkgfA0KPiArCQkgICAgICBQQ0lF
X0NTUl9BU1BNX0wxX0VOKHBvcnQtPnNsb3QpOw0KPiArCQlyZWdtYXBfdXBkYXRlX2JpdHMocGNp
ZS0+Y2ZnLCBQQ0lFX1NZU19DRkdfVjIsIHZhbCwgdmFsKTsNCj4gIAl9DQo+ICANCj4gIAkvKiBB
c3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMgKi8NCj4gQEAgLTk4NSw2ICs5OTcsNyBAQCBzdGF0aWMg
aW50IG10a19wY2llX3N1YnN5c19wb3dlcnVwKHN0cnVjdCBtdGtfcGNpZSAqcGNpZSkNCj4gIAlz
dHJ1Y3QgZGV2aWNlICpkZXYgPSBwY2llLT5kZXY7DQo+ICAJc3RydWN0IHBsYXRmb3JtX2Rldmlj
ZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KPiAgCXN0cnVjdCByZXNvdXJjZSAq
cmVnczsNCj4gKwlzdHJ1Y3QgZGV2aWNlX25vZGUgKmNmZ19ub2RlOw0KPiAgCWludCBlcnI7DQo+
ICANCj4gIAkvKiBnZXQgc2hhcmVkIHJlZ2lzdGVycywgd2hpY2ggYXJlIG9wdGlvbmFsICovDQo+
IEBAIC05OTUsNiArMTAwOCwxNCBAQCBzdGF0aWMgaW50IG10a19wY2llX3N1YnN5c19wb3dlcnVw
KHN0cnVjdCBtdGtfcGNpZSAqcGNpZSkNCj4gIAkJCXJldHVybiBQVFJfRVJSKHBjaWUtPmJhc2Up
Ow0KPiAgCX0NCj4gIA0KPiArCWNmZ19ub2RlID0gb2ZfZmluZF9jb21wYXRpYmxlX25vZGUoTlVM
TCwgTlVMTCwNCj4gKwkJCQkJICAgIm1lZGlhdGVrLGdlbmVyaWMtcGNpZWNmZyIpOw0KPiArCWlm
IChjZmdfbm9kZSkgew0KPiArCQlwY2llLT5jZmcgPSBzeXNjb25fbm9kZV90b19yZWdtYXAoY2Zn
X25vZGUpOw0KPiArCQlpZiAoSVNfRVJSKHBjaWUtPmNmZykpDQo+ICsJCQlyZXR1cm4gUFRSX0VS
UihwY2llLT5jZmcpOw0KPiArCX0NCj4gKw0KPiAgCXBjaWUtPmZyZWVfY2sgPSBkZXZtX2Nsa19n
ZXQoZGV2LCAiZnJlZV9jayIpOw0KPiAgCWlmIChJU19FUlIocGNpZS0+ZnJlZV9jaykpIHsNCj4g
IAkJaWYgKFBUUl9FUlIocGNpZS0+ZnJlZV9jaykgPT0gLUVQUk9CRV9ERUZFUikNCj4gQEAgLTEw
MjcsMjIgKzEwNDgsMjcgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zZXR1cChzdHJ1Y3QgbXRrX3Bj
aWUgKnBjaWUpDQo+ICAJc3RydWN0IGRldmljZSAqZGV2ID0gcGNpZS0+ZGV2Ow0KPiAgCXN0cnVj
dCBkZXZpY2Vfbm9kZSAqbm9kZSA9IGRldi0+b2Zfbm9kZSwgKmNoaWxkOw0KPiAgCXN0cnVjdCBt
dGtfcGNpZV9wb3J0ICpwb3J0LCAqdG1wOw0KPiAtCWludCBlcnI7DQo+ICsJaW50IGVyciwgc2xv
dDsNCj4gKw0KPiArCXNsb3QgPSBvZl9nZXRfcGNpX2RvbWFpbl9ucihkZXYtPm9mX25vZGUpOw0K
PiArCWlmIChzbG90IDwgMCkgew0KPiArCQlmb3JfZWFjaF9hdmFpbGFibGVfY2hpbGRfb2Zfbm9k
ZShub2RlLCBjaGlsZCkgew0KPiArCQkJZXJyID0gb2ZfcGNpX2dldF9kZXZmbihjaGlsZCk7DQo+
ICsJCQlpZiAoZXJyIDwgMCkgew0KPiArCQkJCWRldl9lcnIoZGV2LCAiZmFpbGVkIHRvIGdldCBk
ZXZmbjogJWRcbiIsIGVycik7DQo+ICsJCQkJZ290byBlcnJvcl9wdXRfbm9kZTsNCj4gKwkJCX0N
Cj4gIA0KPiAtCWZvcl9lYWNoX2F2YWlsYWJsZV9jaGlsZF9vZl9ub2RlKG5vZGUsIGNoaWxkKSB7
DQo+IC0JCWludCBzbG90Ow0KPiArCQkJc2xvdCA9IFBDSV9TTE9UKGVycik7DQo+ICANCj4gLQkJ
ZXJyID0gb2ZfcGNpX2dldF9kZXZmbihjaGlsZCk7DQo+IC0JCWlmIChlcnIgPCAwKSB7DQo+IC0J
CQlkZXZfZXJyKGRldiwgImZhaWxlZCB0byBwYXJzZSBkZXZmbjogJWRcbiIsIGVycik7DQo+IC0J
CQlnb3RvIGVycm9yX3B1dF9ub2RlOw0KPiArCQkJZXJyID0gbXRrX3BjaWVfcGFyc2VfcG9ydChw
Y2llLCBjaGlsZCwgc2xvdCk7DQo+ICsJCQlpZiAoZXJyKQ0KPiArCQkJCWdvdG8gZXJyb3JfcHV0
X25vZGU7DQo+ICAJCX0NCj4gLQ0KPiAtCQlzbG90ID0gUENJX1NMT1QoZXJyKTsNCj4gLQ0KPiAt
CQllcnIgPSBtdGtfcGNpZV9wYXJzZV9wb3J0KHBjaWUsIGNoaWxkLCBzbG90KTsNCj4gKwl9IGVs
c2Ugew0KPiArCQllcnIgPSBtdGtfcGNpZV9wYXJzZV9wb3J0KHBjaWUsIG5vZGUsIHNsb3QpOw0K
PiAgCQlpZiAoZXJyKQ0KPiAtCQkJZ290byBlcnJvcl9wdXRfbm9kZTsNCj4gKwkJCXJldHVybiBl
cnI7DQoNCkhp77yMUm9iDQpJIGNoYW5nZWQgdGhpcyBpbiB0aGUgdjkgdmVyc2lvbjoNCldoZW4g
dGhlIG5ldyBkdHMgZm9ybWF0IGlzIHVzZWQsIG9mX25vZGVfZ2V0KCkgaXMgbm90IGNhbGxlZC4N
ClNvIHdoZW4gbXRrX3BjaWVfcGFyc2VfcG9ydCBmYWlscywgb2Zfbm9kZV9wdXQgZG9uJ3QgbmVl
ZCB0byBiZSBjYWxsZWQuDQppZiB5b3Ugc3RpbGwgb2sgZm9yIHRoaXMsIEkgd2lsbCBhZGQgUi1i
IGluIG5leHQgdmVyc2lvbi4NCg0KQmVzdCBSZWdhcmRzDQo+ICAJfQ0KPiAgDQo+ICAJZXJyID0g
bXRrX3BjaWVfc3Vic3lzX3Bvd2VydXAocGNpZSk7DQoNCg==

