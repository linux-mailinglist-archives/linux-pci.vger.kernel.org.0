Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BFA8268A25
	for <lists+linux-pci@lfdr.de>; Mon, 14 Sep 2020 13:36:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726051AbgINLeu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Sep 2020 07:34:50 -0400
Received: from mailgw02.mediatek.com ([210.61.82.184]:22296 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726073AbgINLaC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Sep 2020 07:30:02 -0400
X-UUID: 5c344bdaea7e46d1a3e6460f3ba4e3eb-20200914
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=XMZxyn6b3FBsdxBCB2TKGC6CA3eMv9x5H8CXbCfu32I=;
        b=tdSssHe0vC8uxtuVngFo+Sy24zPxQTg7Ki1MaG5Byc3ddCwz2aoufOlxh3pJoxVTYT7pM8Z80xJn2G2rdTYmAvoLvr71KSkY5ViHITMVv8+K4TQYt0usLLjHZXlvv/ipvrD0qlMGjuet/CDT7FcDbY1+kHkR8PQ0+jPAWW6RknQ=;
X-UUID: 5c344bdaea7e46d1a3e6460f3ba4e3eb-20200914
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chuanjia.liu@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1284806705; Mon, 14 Sep 2020 19:29:43 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Mon, 14 Sep 2020 19:29:39 +0800
Received: from localhost.localdomain (10.17.3.153) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 14 Sep 2020 19:29:40 +0800
From:   Chuanjia Liu <chuanjia.liu@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <yong.wu@mediatek.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Ryder Lee <ryder.lee@mediatek.com>,
        Chuanjia Liu <chuanjia.liu@mediatek.com>
Subject: [PATCH v6 2/4] PCI: mediatek: Add new method to get shared pcie-cfg base and irq
Date:   Mon, 14 Sep 2020 19:26:57 +0800
Message-ID: <20200914112659.7091-3-chuanjia.liu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
References: <20200914112659.7091-1-chuanjia.liu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

QWRkIG5ldyBtZXRob2QgdG8gZ2V0IHNoYXJlZCBwY2llLWNmZyBiYXNlIGFuZCBwY2llIGlycSBm
b3INCm5ldyBkdHMgZm9ybWF0Lg0KDQpTaWduZWQtb2ZmLWJ5OiBDaHVhbmppYSBMaXUgPGNodWFu
amlhLmxpdUBtZWRpYXRlay5jb20+DQpBY2tlZC1ieTogUnlkZXIgTGVlIDxyeWRlci5sZWVAbWVk
aWF0ZWsuY29tPg0KLS0tDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMg
fCAyMyArKysrKysrKysrKysrKysrKysrKysrLQ0KIDEgZmlsZSBjaGFuZ2VkLCAyMiBpbnNlcnRp
b25zKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9s
bGVyL3BjaWUtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRl
ay5jDQppbmRleCBjZjRjMThmMGMyNWEuLjViOTE1ZWIwY2YxZSAxMDA2NDQNCi0tLSBhL2RyaXZl
cnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KQEAgLTE0LDYgKzE0LDcgQEANCiAjaW5jbHVkZSA8bGlu
dXgvaXJxY2hpcC9jaGFpbmVkX2lycS5oPg0KICNpbmNsdWRlIDxsaW51eC9pcnFkb21haW4uaD4N
CiAjaW5jbHVkZSA8bGludXgva2VybmVsLmg+DQorI2luY2x1ZGUgPGxpbnV4L21mZC9zeXNjb24u
aD4NCiAjaW5jbHVkZSA8bGludXgvbXNpLmg+DQogI2luY2x1ZGUgPGxpbnV4L21vZHVsZS5oPg0K
ICNpbmNsdWRlIDxsaW51eC9vZl9hZGRyZXNzLmg+DQpAQCAtMjMsNiArMjQsNyBAQA0KICNpbmNs
dWRlIDxsaW51eC9waHkvcGh5Lmg+DQogI2luY2x1ZGUgPGxpbnV4L3BsYXRmb3JtX2RldmljZS5o
Pg0KICNpbmNsdWRlIDxsaW51eC9wbV9ydW50aW1lLmg+DQorI2luY2x1ZGUgPGxpbnV4L3JlZ21h
cC5oPg0KICNpbmNsdWRlIDxsaW51eC9yZXNldC5oPg0KIA0KICNpbmNsdWRlICIuLi9wY2kuaCIN
CkBAIC0yMDUsNiArMjA3LDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KICAqIHN0cnVjdCBt
dGtfcGNpZSAtIFBDSWUgaG9zdCBpbmZvcm1hdGlvbg0KICAqIEBkZXY6IHBvaW50ZXIgdG8gUENJ
ZSBkZXZpY2UNCiAgKiBAYmFzZTogSU8gbWFwcGVkIHJlZ2lzdGVyIGJhc2UNCisgKiBAY2ZnOiBJ
TyBtYXBwZWQgcmVnaXN0ZXIgbWFwIGZvciBQQ0llIGNvbmZpZw0KICAqIEBmcmVlX2NrOiBmcmVl
LXJ1biByZWZlcmVuY2UgY2xvY2sNCiAgKiBAbWVtOiBub24tcHJlZmV0Y2hhYmxlIG1lbW9yeSBy
ZXNvdXJjZQ0KICAqIEBwb3J0czogcG9pbnRlciB0byBQQ0llIHBvcnQgaW5mb3JtYXRpb24NCkBA
IC0yMTMsNiArMjE2LDcgQEAgc3RydWN0IG10a19wY2llX3BvcnQgew0KIHN0cnVjdCBtdGtfcGNp
ZSB7DQogCXN0cnVjdCBkZXZpY2UgKmRldjsNCiAJdm9pZCBfX2lvbWVtICpiYXNlOw0KKwlzdHJ1
Y3QgcmVnbWFwICpjZmc7DQogCXN0cnVjdCBjbGsgKmZyZWVfY2s7DQogDQogCXN0cnVjdCBsaXN0
X2hlYWQgcG9ydHM7DQpAQCAtNjQ4LDcgKzY1MiwxMSBAQCBzdGF0aWMgaW50IG10a19wY2llX3Nl
dHVwX2lycShzdHJ1Y3QgbXRrX3BjaWVfcG9ydCAqcG9ydCwNCiAJCXJldHVybiBlcnI7DQogCX0N
CiANCi0JcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBwb3J0LT5zbG90KTsNCisJ
aWYgKG9mX2ZpbmRfcHJvcGVydHkoZGV2LT5vZl9ub2RlLCAiaW50ZXJydXB0LW5hbWVzIiwgTlVM
TCkpDQorCQlwb3J0LT5pcnEgPSBwbGF0Zm9ybV9nZXRfaXJxX2J5bmFtZShwZGV2LCAicGNpZV9p
cnEiKTsNCisJZWxzZQ0KKwkJcG9ydC0+aXJxID0gcGxhdGZvcm1fZ2V0X2lycShwZGV2LCBwb3J0
LT5zbG90KTsNCisNCiAJaWYgKHBvcnQtPmlycSA8IDApDQogCQlyZXR1cm4gcG9ydC0+aXJxOw0K
IA0KQEAgLTY4MCw2ICs2ODgsMTAgQEAgc3RhdGljIGludCBtdGtfcGNpZV9zdGFydHVwX3BvcnRf
djIoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQpDQogCQl2YWwgfD0gUENJRV9DU1JfTFRTU01f
RU4ocG9ydC0+c2xvdCkgfA0KIAkJICAgICAgIFBDSUVfQ1NSX0FTUE1fTDFfRU4ocG9ydC0+c2xv
dCk7DQogCQl3cml0ZWwodmFsLCBwY2llLT5iYXNlICsgUENJRV9TWVNfQ0ZHX1YyKTsNCisJfSBl
bHNlIGlmIChwY2llLT5jZmcpIHsNCisJCXZhbCA9IFBDSUVfQ1NSX0xUU1NNX0VOKHBvcnQtPnNs
b3QpIHwNCisJCSAgICAgIFBDSUVfQ1NSX0FTUE1fTDFfRU4ocG9ydC0+c2xvdCk7DQorCQlyZWdt
YXBfdXBkYXRlX2JpdHMocGNpZS0+Y2ZnLCBQQ0lFX1NZU19DRkdfVjIsIHZhbCwgdmFsKTsNCiAJ
fQ0KIA0KIAkvKiBBc3NlcnQgYWxsIHJlc2V0IHNpZ25hbHMgKi8NCkBAIC05ODMsNiArOTk1LDcg
QEAgc3RhdGljIGludCBtdGtfcGNpZV9zdWJzeXNfcG93ZXJ1cChzdHJ1Y3QgbXRrX3BjaWUgKnBj
aWUpDQogCXN0cnVjdCBkZXZpY2UgKmRldiA9IHBjaWUtPmRldjsNCiAJc3RydWN0IHBsYXRmb3Jt
X2RldmljZSAqcGRldiA9IHRvX3BsYXRmb3JtX2RldmljZShkZXYpOw0KIAlzdHJ1Y3QgcmVzb3Vy
Y2UgKnJlZ3M7DQorCXN0cnVjdCBkZXZpY2Vfbm9kZSAqY2ZnX25vZGU7DQogCWludCBlcnI7DQog
DQogCS8qIGdldCBzaGFyZWQgcmVnaXN0ZXJzLCB3aGljaCBhcmUgb3B0aW9uYWwgKi8NCkBAIC05
OTUsNiArMTAwOCwxNCBAQCBzdGF0aWMgaW50IG10a19wY2llX3N1YnN5c19wb3dlcnVwKHN0cnVj
dCBtdGtfcGNpZSAqcGNpZSkNCiAJCX0NCiAJfQ0KIA0KKwljZmdfbm9kZSA9IG9mX2ZpbmRfY29t
cGF0aWJsZV9ub2RlKE5VTEwsIE5VTEwsDQorCQkJCQkgICAibWVkaWF0ZWssZ2VuZXJpYy1wY2ll
Y2ZnIik7DQorCWlmIChjZmdfbm9kZSkgew0KKwkJcGNpZS0+Y2ZnID0gc3lzY29uX25vZGVfdG9f
cmVnbWFwKGNmZ19ub2RlKTsNCisJCWlmIChJU19FUlIocGNpZS0+Y2ZnKSkNCisJCQlyZXR1cm4g
UFRSX0VSUihwY2llLT5jZmcpOw0KKwl9DQorDQogCXBjaWUtPmZyZWVfY2sgPSBkZXZtX2Nsa19n
ZXQoZGV2LCAiZnJlZV9jayIpOw0KIAlpZiAoSVNfRVJSKHBjaWUtPmZyZWVfY2spKSB7DQogCQlp
ZiAoUFRSX0VSUihwY2llLT5mcmVlX2NrKSA9PSAtRVBST0JFX0RFRkVSKQ0KLS0gDQoyLjE4LjAN
Cg==

