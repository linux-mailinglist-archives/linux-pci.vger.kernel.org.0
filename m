Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 63C6A263D03
	for <lists+linux-pci@lfdr.de>; Thu, 10 Sep 2020 08:14:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726228AbgIJGOJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 10 Sep 2020 02:14:09 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:26248 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725885AbgIJGOG (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 10 Sep 2020 02:14:06 -0400
X-UUID: 44dc84d835a64add95abb362eff6ee2c-20200910
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=DdQYIrzP1/L5mFOIX/0qqGKPU3qmKs8BIFxJH8I2MI4=;
        b=RMlX5EInN7tUjZy8tw0OPghGNhIASJG0fJYE78uyArprIOBg/uvoGFRJeBTjGmFt6a5a6egY+cc+EQzv2woaoioGGyeN5lO46gJQ3gUBLemSHFFM4F8gZK8MWvF7N+LrJS2dZnlf4SHUgzXZR/NRaCIJksBO0l10E8HrzuZul1s=;
X-UUID: 44dc84d835a64add95abb362eff6ee2c-20200910
Received: from mtkcas08.mediatek.inc [(172.21.101.126)] by mailgw01.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1339016614; Thu, 10 Sep 2020 14:14:01 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 10 Sep 2020 14:13:57 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 10 Sep 2020 14:13:57 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>
Subject: [PATCH v5 2/4] PCI: mediatek: Use regmap to get shared pcie-cfg base
Date:   Thu, 10 Sep 2020 14:11:13 +0800
Message-ID: <20200910061115.909-3-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200910061115.909-1-chuanjia.liu@mediatek.com>
References: <20200910061115.909-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: E56F64A01EF58C90D930F3E67FC5D757695F98DABC7DEBB4E4C0F3A62154950C2000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VXNlIHJlZ21hcCB0byBnZXQgc2hhcmVkIHBjaWUtY2ZnIGJhc2UgYW5kIGNoYW5nZQ0KdGhlIG1l
dGhvZCB0byBnZXQgcGNpZSBpcnEuDQoNCkFja2VkLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBt
ZWRpYXRlay5jb20+DQpTaWduZWQtb2ZmLWJ5OiBDaHVhbmppYSBMaXUgPGNodWFuamlhLmxpdUBt
ZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsu
YyB8IDI1ICsrKysrKysrKysrKysrKysrKy0tLS0tLS0NCiAxIGZpbGUgY2hhbmdlZCwgMTggaW5z
ZXJ0aW9ucygrKSwgNyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLmMNCmluZGV4IGNmNGMxOGYwYzI1YS4uOTg3ODQ1ZDE5OTgyIDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCisrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQpAQCAtMTQsNiArMTQsNyBAQA0KICNpbmNsdWRl
IDxsaW51eC9pcnFjaGlwL2NoYWluZWRfaXJxLmg+DQogI2luY2x1ZGUgPGxpbnV4L2lycWRvbWFp
bi5oPg0KICNpbmNsdWRlIDxsaW51eC9rZXJuZWwuaD4NCisjaW5jbHVkZSA8bGludXgvbWZkL3N5
c2Nvbi5oPg0KICNpbmNsdWRlIDxsaW51eC9tc2kuaD4NCiAjaW5jbHVkZSA8bGludXgvbW9kdWxl
Lmg+DQogI2luY2x1ZGUgPGxpbnV4L29mX2FkZHJlc3MuaD4NCkBAIC0yMyw2ICsyNCw3IEBADQog
I2luY2x1ZGUgPGxpbnV4L3BoeS9waHkuaD4NCiAjaW5jbHVkZSA8bGludXgvcGxhdGZvcm1fZGV2
aWNlLmg+DQogI2luY2x1ZGUgPGxpbnV4L3BtX3J1bnRpbWUuaD4NCisjaW5jbHVkZSA8bGludXgv
cmVnbWFwLmg+DQogI2luY2x1ZGUgPGxpbnV4L3Jlc2V0Lmg+DQogDQogI2luY2x1ZGUgIi4uL3Bj
aS5oIg0KQEAgLTIwNSw2ICsyMDcsNyBAQCBzdHJ1Y3QgbXRrX3BjaWVfcG9ydCB7DQogICogc3Ry
dWN0IG10a19wY2llIC0gUENJZSBob3N0IGluZm9ybWF0aW9uDQogICogQGRldjogcG9pbnRlciB0
byBQQ0llIGRldmljZQ0KICAqIEBiYXNlOiBJTyBtYXBwZWQgcmVnaXN0ZXIgYmFzZQ0KKyAqIEBj
Zmc6IElPIG1hcHBlZCByZWdpc3RlciBtYXAgZm9yIFBDSWUgY29uZmlnDQogICogQGZyZWVfY2s6
IGZyZWUtcnVuIHJlZmVyZW5jZSBjbG9jaw0KICAqIEBtZW06IG5vbi1wcmVmZXRjaGFibGUgbWVt
b3J5IHJlc291cmNlDQogICogQHBvcnRzOiBwb2ludGVyIHRvIFBDSWUgcG9ydCBpbmZvcm1hdGlv
bg0KQEAgLTIxMyw2ICsyMTYsNyBAQCBzdHJ1Y3QgbXRrX3BjaWVfcG9ydCB7DQogc3RydWN0IG10
a19wY2llIHsNCiAJc3RydWN0IGRldmljZSAqZGV2Ow0KIAl2b2lkIF9faW9tZW0gKmJhc2U7DQor
CXN0cnVjdCByZWdtYXAgKmNmZzsNCiAJc3RydWN0IGNsayAqZnJlZV9jazsNCiANCiAJc3RydWN0
IGxpc3RfaGVhZCBwb3J0czsNCkBAIC02NDgsNyArNjUyLDcgQEAgc3RhdGljIGludCBtdGtfcGNp
ZV9zZXR1cF9pcnEoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQsDQogCQlyZXR1cm4gZXJyOw0K
IAl9DQogDQotCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnEocGRldiwgcG9ydC0+c2xvdCk7
DQorCXBvcnQtPmlycSA9IHBsYXRmb3JtX2dldF9pcnFfYnluYW1lKHBkZXYsICJwY2llX2lycSIp
Ow0KIAlpZiAocG9ydC0+aXJxIDwgMCkNCiAJCXJldHVybiBwb3J0LT5pcnE7DQogDQpAQCAtNjc0
LDEyICs2NzgsMTEgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zdGFydHVwX3BvcnRfdjIoc3RydWN0
IG10a19wY2llX3BvcnQgKnBvcnQpDQogCWlmICghbWVtKQ0KIAkJcmV0dXJuIC1FSU5WQUw7DQog
DQotCS8qIE1UNzYyMiBwbGF0Zm9ybXMgbmVlZCB0byBlbmFibGUgTFRTU00gYW5kIEFTUE0gZnJv
bSBQQ0llIHN1YnN5cyAqLw0KLQlpZiAocGNpZS0+YmFzZSkgew0KLQkJdmFsID0gcmVhZGwocGNp
ZS0+YmFzZSArIFBDSUVfU1lTX0NGR19WMik7DQotCQl2YWwgfD0gUENJRV9DU1JfTFRTU01fRU4o
cG9ydC0+c2xvdCkgfA0KLQkJICAgICAgIFBDSUVfQ1NSX0FTUE1fTDFfRU4ocG9ydC0+c2xvdCk7
DQotCQl3cml0ZWwodmFsLCBwY2llLT5iYXNlICsgUENJRV9TWVNfQ0ZHX1YyKTsNCisJLyogTVQ3
NjIyL01UNzYyOSBwbGF0Zm9ybXMgbmVlZCB0byBlbmFibGUgTFRTU00gYW5kIEFTUE0uICovDQor
CWlmIChwY2llLT5jZmcpIHsNCisJCXZhbCA9IFBDSUVfQ1NSX0xUU1NNX0VOKHBvcnQtPnNsb3Qp
IHwNCisJCSAgICAgIFBDSUVfQ1NSX0FTUE1fTDFfRU4ocG9ydC0+c2xvdCk7DQorCQlyZWdtYXBf
dXBkYXRlX2JpdHMocGNpZS0+Y2ZnLCBQQ0lFX1NZU19DRkdfVjIsIHZhbCwgdmFsKTsNCiAJfQ0K
IA0KIAkvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMgKi8NCkBAIC05ODMsNiArOTg2LDcgQEAg
c3RhdGljIGludCBtdGtfcGNpZV9zdWJzeXNfcG93ZXJ1cChzdHJ1Y3QgbXRrX3BjaWUgKnBjaWUp
DQogCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaWUtPmRldjsNCiAJc3RydWN0IHBsYXRmb3JtX2Rl
dmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KIAlzdHJ1Y3QgcmVzb3VyY2Ug
KnJlZ3M7DQorCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY2ZnX25vZGU7DQogCWludCBlcnI7DQogDQog
CS8qIGdldCBzaGFyZWQgcmVnaXN0ZXJzLCB3aGljaCBhcmUgb3B0aW9uYWwgKi8NCkBAIC05OTUs
NiArOTk5LDEzIEBAIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3Vic3lzX3Bvd2VydXAoc3RydWN0IG10
a19wY2llICpwY2llKQ0KIAkJfQ0KIAl9DQogDQorCWNmZ19ub2RlID0gb2ZfcGFyc2VfcGhhbmRs
ZShkZXYtPm9mX25vZGUsICJtZWRpYXRlayxwY2llLWNmZyIsIDApOw0KKwlpZiAoY2ZnX25vZGUp
IHsNCisJCXBjaWUtPmNmZyA9IHN5c2Nvbl9ub2RlX3RvX3JlZ21hcChjZmdfbm9kZSk7DQorCQlp
ZiAoSVNfRVJSKHBjaWUtPmNmZykpDQorCQkJcmV0dXJuIFBUUl9FUlIocGNpZS0+Y2ZnKTsNCisJ
fQ0KKw0KIAlwY2llLT5mcmVlX2NrID0gZGV2bV9jbGtfZ2V0KGRldiwgImZyZWVfY2siKTsNCiAJ
aWYgKElTX0VSUihwY2llLT5mcmVlX2NrKSkgew0KIAkJaWYgKFBUUl9FUlIocGNpZS0+ZnJlZV9j
aykgPT0gLUVQUk9CRV9ERUZFUikNCi0tIA0KMi4xOC4wDQo=

