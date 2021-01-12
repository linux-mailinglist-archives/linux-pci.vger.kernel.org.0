Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C02822F2920
	for <lists+linux-pci@lfdr.de>; Tue, 12 Jan 2021 08:47:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731984AbhALHrC (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 12 Jan 2021 02:47:02 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:16999 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728301AbhALHrC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 12 Jan 2021 02:47:02 -0500
X-UUID: 24e798f4b0ea4cce96fdcb61e9f4df16-20210112
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=QbDUDErbElo9ALLdM2zsuGqQjEHnckJhZ/HcIVbACVo=;
        b=YnEnpfKLUzlzFsCJU57SyXdYsE9u2kGaw4zQUU9hv5NepmInCSsBPM61BKKX8vgB0pkh70SVJHN3TWjDORay/xscQayvc2dRqgnlDKDNnmfUzi16AgOXyeJQSR1ugktU6VjlKgL0sDvGvJgXdUcoQLK0v5WSX+OZMt7FeaIyzXE=;
X-UUID: 24e798f4b0ea4cce96fdcb61e9f4df16-20210112
Received: from mtkcas36.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <mingchuang.qiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 297226364; Tue, 12 Jan 2021 15:35:33 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 12 Jan
 2021 15:35:27 +0800
Received: from mcddlt001.mediatek.inc (10.19.240.15) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Tue, 12 Jan 2021 15:35:26 +0800
From:   <mingchuang.qiao@mediatek.com>
To:     <bhelgaas@google.com>, <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <mingchuang.qiao@mediatek.com>, <haijun.liu@mediatek.com>,
        <lambert.wang@mediatek.com>, <kerun.zhu@mediatek.com>
Subject: [PATCH] pci: avoid unsync of LTR mechanism configuration
Date:   Tue, 12 Jan 2021 15:27:39 +0800
Message-ID: <20210112072739.31624-1-mingchuang.qiao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: 138AEC170CF7C40068F5BD0D97B5ACAE2C5FB55A940A1E8A4148BCCA5D1A30852000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogTWluZ2NodWFuZyBRaWFvIDxtaW5nY2h1YW5nLnFpYW9AbWVkaWF0ZWsuY29tPg0KDQpJ
biBwY2kgYnVzIHNjYW4gZmxvdywgdGhlIExUUiBtZWNoYW5pc20gZW5hYmxlIGJpdCBvZiBERVZD
VEwyIHJlZ2lzdGVyDQppcyBjb25maWd1cmVkIGluIHBjaV9jb25maWd1cmVfbHRyKCkuIElmIGRl
dmljZSBhbmQgaXQncyBicmlkZ2UgYm90aA0Kc3VwcG9ydCBMVFIgbWVjaGFuaXNtLCBMVFIgbWVj
aGFuaXNtIG9mIGRldmljZSBhbmQgaXQncyBicmlkZ2Ugd2lsbA0KYmUgZW5hYmxlZCBpbiBERVZD
VEwyIHJlZ2lzdGVyLiBBbmQgdGhlIGZsYWcgcGNpX2Rldi0+bHRyX3BhdGggd2lsbA0KYmUgc2V0
IGFzIDEuDQoNCkZvciBzb21lIHBjaWUgcHJvZHVjdHMsIHBjaWUgbGluayBiZWNvbWVzIGRvd24g
d2hlbiBkZXZpY2UgcmVzZXQuIEFuZCB0aGVuDQp0aGUgTFRSIG1lY2hhbmlzbSBlbmFibGUgYml0
IG9mIGJyaWRnZSB3aWxsIGJlY29tZSAwIGJhc2VkIG9uIGRlc2NyaXB0aW9uDQppbiBQQ0lFIHI0
LjAsIHNlYyA3LjguMTYuIEhvd2V2ZXIsIHRoZSBwY2lfZGV2LT5sdHJfcGF0aCB2YWx1ZSBvZiBi
cmlkZ2UNCmlzIHN0aWxsIDEuIFJlbW92ZSBhbmQgcmVzY2FuIGZsb3cgY291bGQgYmUgdHJpZ2dl
cmVkIHRvIHJlY292ZXIgYWZ0ZXINCmRldmljZSByZXNldC4gSW4gdGhlIGJ1cyByZXNjYW4gZmxv
dywgdGhlIExUUiBtZWNoYW5pc20gb2YgZGV2aWNlIHdpbGwgYmUNCmVuYWJsZWQgaW4gcGNpX2Nv
bmZpZ3VyZV9sdHIoKSBkdWUgdG8gbHRyX3BhdGggb2YgaXRzIGJyaWRnZSBpcyBzdGlsbCAxLg0K
DQpXaGVuIGRldmljZSdzIExUUiBtZWNoYW5pc20gaXMgZW5hYmxlZCwgZGV2aWNlIHdpbGwgc2Vu
ZCBMVFIgbWVzc2FnZSB0bw0KYnJpZGdlLiBCcmlkZ2UgcmVjZWl2ZXMgdGhlIGRldmljZSdzIExU
UiBtZXNzYWdlIGFuZCBmb3VuZCBicmlkZ2UncyBMVFINCm1lY2hhbmlzbSBpcyBkaXNhYmxlZC4g
VGhlbiB0aGUgYnJpZGdlIHdpbGwgZ2VuZXJhdGUgdW5zdXBwb3J0ZWQgcmVxdWVzdA0KYW5kIG90
aGVyIGVycm9yIGhhbmRsaW5nIGZsb3cgd2lsbCBiZSB0cmlnZ2VyZWQgc3VjaCBhcyBBRVIgTm9u
LUZhdGFsDQplcnJvciBoYW5kbGluZy4NCg0KVGhpcyBwYXRjaCBpcyB1c2VkIHRvIGF2b2lkIHRo
aXMgdW5zdXBwb3J0ZWQgcmVxdWVzdCBhbmQgbWFrZSB0aGUgYnJpZGdlJ3MNCmx0cl9wYXRoIHZh
bHVlIGlzIGFsaWduZWQgd2l0aCBERVZDVEwyIHJlZ2lzdGVyIHZhbHVlLiBDaGVjayBicmlkZ2UN
CnJlZ2lzdGVyIHZhbHVlIGlmIGFsaWduZWQgd2l0aCBsdHJfcGF0aCBpbiBwY2lfY29uZmlndXJl
X2x0cigpLiBJZg0KcmVnaXN0ZXIgdmFsdWUgaXMgZGlzYWJsZSBhbmQgdGhlIGx0cl9wYXRoIGlz
IDEsIHdlIG5lZWQgY29uZmlndXJlDQp0aGUgcmVnaXN0ZXIgdmFsdWUgYXMgZW5hYmxlLg0KDQpT
aWduZWQtb2ZmLWJ5OiBNaW5nY2h1YW5nIFFpYW8gPG1pbmdjaHVhbmcucWlhb0BtZWRpYXRlay5j
b20+DQotLS0NCiBkcml2ZXJzL3BjaS9wcm9iZS5jIHwgMTggKysrKysrKysrKysrKysrLS0tDQog
MSBmaWxlIGNoYW5nZWQsIDE1IGluc2VydGlvbnMoKyksIDMgZGVsZXRpb25zKC0pDQoNCmRpZmYg
LS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJvYmUuYw0KaW5kZXgg
OTUzZjE1YWJjODUwLi40OTM1NWNmNGFmNTQgMTAwNjQ0DQotLS0gYS9kcml2ZXJzL3BjaS9wcm9i
ZS5jDQorKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQpAQCAtMjEzMiw5ICsyMTMyLDIxIEBAIHN0
YXRpYyB2b2lkIHBjaV9jb25maWd1cmVfbHRyKHN0cnVjdCBwY2lfZGV2ICpkZXYpDQogCSAqIENv
bXBsZXggYW5kIGFsbCBpbnRlcm1lZGlhdGUgU3dpdGNoZXMgaW5kaWNhdGUgc3VwcG9ydCBmb3Ig
TFRSLg0KIAkgKiBQQ0llIHI0LjAsIHNlYyA2LjE4Lg0KIAkgKi8NCi0JaWYgKHBjaV9wY2llX3R5
cGUoZGV2KSA9PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUIHx8DQotCSAgICAoKGJyaWRnZSA9IHBj
aV91cHN0cmVhbV9icmlkZ2UoZGV2KSkgJiYNCi0JICAgICAgYnJpZGdlLT5sdHJfcGF0aCkpIHsN
CisJaWYgKHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUKSB7DQor
CQlwY2llX2NhcGFiaWxpdHlfc2V0X3dvcmQoZGV2LCBQQ0lfRVhQX0RFVkNUTDIsDQorCQkJCQkg
UENJX0VYUF9ERVZDVEwyX0xUUl9FTik7DQorCQlkZXYtPmx0cl9wYXRoID0gMTsNCisJCXJldHVy
bjsNCisJfQ0KKw0KKwlicmlkZ2UgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGRldik7DQorCWlmIChi
cmlkZ2UgJiYgYnJpZGdlLT5sdHJfcGF0aCkgew0KKwkJcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdv
cmQoYnJpZGdlLCBQQ0lfRVhQX0RFVkNUTDIsICZjdGwpOw0KKwkJaWYgKCEoY3RsICYgUENJX0VY
UF9ERVZDVEwyX0xUUl9FTikpIHsNCisJCQlwY2llX2NhcGFiaWxpdHlfc2V0X3dvcmQoYnJpZGdl
LCBQQ0lfRVhQX0RFVkNUTDIsDQorCQkJCQkJIFBDSV9FWFBfREVWQ1RMMl9MVFJfRU4pOw0KKwkJ
fQ0KKw0KIAkJcGNpZV9jYXBhYmlsaXR5X3NldF93b3JkKGRldiwgUENJX0VYUF9ERVZDVEwyLA0K
IAkJCQkJIFBDSV9FWFBfREVWQ1RMMl9MVFJfRU4pOw0KIAkJZGV2LT5sdHJfcGF0aCA9IDE7DQot
LSANCjIuMTguMA0K

