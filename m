Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F03D3307365
	for <lists+linux-pci@lfdr.de>; Thu, 28 Jan 2021 11:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231463AbhA1KGn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 28 Jan 2021 05:06:43 -0500
Received: from Mailgw01.mediatek.com ([1.203.163.78]:8081 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S231322AbhA1KGb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 28 Jan 2021 05:06:31 -0500
X-UUID: 9fed7893d48c433292e317bf762fff20-20210128
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=4IK9jdUP/+9o12Q2Z2gnHGjv+cdCrjUnCtGVYV+uXkI=;
        b=LRz9ZM4eyki9WUACnrozgwOfzqkb5E6qeQ+gmDRn6gOSDw62FGMncd7Vq3ZxsCRpTCN8kJzvdJcl57L7drNjJuW1Wrg31zWn2PcsLTu2Gc1oWqW0Vm3fkLrM2bB7CipCiSbiKhGioB/xz09wLGJsC9z4DYUp0OtKsJmo/2TaET8=;
X-UUID: 9fed7893d48c433292e317bf762fff20-20210128
Received: from mtkcas32.mediatek.inc [(172.27.4.253)] by mailgw01.mediatek.com
        (envelope-from <mingchuang.qiao@mediatek.com>)
        (mailgw01.mediatek.com ESMTP with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 86084368; Thu, 28 Jan 2021 18:05:46 +0800
Received: from MTKCAS32.mediatek.inc (172.27.4.184) by MTKMBS31N1.mediatek.inc
 (172.27.4.69) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Thu, 28 Jan
 2021 18:05:34 +0800
Received: from mcddlt001.mediatek.inc (10.19.240.15) by MTKCAS32.mediatek.inc
 (172.27.4.170) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 28 Jan 2021 18:05:34 +0800
From:   <mingchuang.qiao@mediatek.com>
To:     <bhelgaas@google.com>, <matthias.bgg@gmail.com>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <mingchuang.qiao@mediatek.com>, <haijun.liu@mediatek.com>,
        <lambert.wang@mediatek.com>, <kerun.zhu@mediatek.com>,
        <mika.westerberg@linux.intel.com>, <alex.williamson@redhat.com>,
        <rjw@rjwysocki.net>, <utkarsh.h.patel@intel.com>
Subject: [v2] PCI: Avoid unsync of LTR mechanism configuration
Date:   Thu, 28 Jan 2021 18:05:31 +0800
Message-ID: <20210128100531.2694-1-mingchuang.qiao@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: F6A356DF7791F0854E1DE6CABFFA9C33DDDF10543AF8572B337683DD4611E8382000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

RnJvbTogTWluZ2NodWFuZyBRaWFvIDxtaW5nY2h1YW5nLnFpYW9AbWVkaWF0ZWsuY29tPg0KDQpJ
biBidXMgc2NhbiBmbG93LCB0aGUgIkxUUiBNZWNoYW5pc20gRW5hYmxlIiBiaXQgb2YgREVWQ1RM
MiByZWdpc3RlciBpcw0KY29uZmlndXJlZCBpbiBwY2lfY29uZmlndXJlX2x0cigpLiBJZiBkZXZp
Y2UgYW5kIGJyaWRnZSBib3RoIHN1cHBvcnQgTFRSDQptZWNoYW5pc20sIHRoZSAiTFRSIE1lY2hh
bmlzbSBFbmFibGUiIGJpdCBvZiBkZXZpY2UgYW5kIGJyaWRnZSB3aWxsIGJlDQplbmFibGVkIGlu
IERFVkNUTDIgcmVnaXN0ZXIuIEFuZCBwY2lfZGV2LT5sdHJfcGF0aCB3aWxsIGJlIHNldCBhcyAx
Lg0KDQpJZiBQQ0llIGxpbmsgZ29lcyBkb3duIHdoZW4gZGV2aWNlIHJlc2V0cywgdGhlICJMVFIg
TWVjaGFuaXNtIEVuYWJsZSIgYml0DQpvZiBicmlkZ2Ugd2lsbCBjaGFuZ2UgdG8gMCBhY2NvcmRp
bmcgdG8gUENJZSByNS4wLCBzZWMgNy41LjMuMTYuIEhvd2V2ZXIsDQp0aGUgcGNpX2Rldi0+bHRy
X3BhdGggdmFsdWUgb2YgYnJpZGdlIGlzIHN0aWxsIDEuDQoNCkZvciBmb2xsb3dpbmcgY29uZGl0
aW9ucywgY2hlY2sgYW5kIHJlLWNvbmZpZ3VyZSAiTFRSIE1lY2hhbmlzbSBFbmFibGUiIGJpdA0K
b2YgYnJpZGdlIHRvIG1ha2UgIkxUUiBNZWNoYW5pc20gRW5hYmxlIiBiaXQgbXRhY2ggbHRyX3Bh
dGggdmFsdWUuDQogICAtYmVmb3JlIGNvbmZpZ3VyaW5nIGRldmljZSdzIExUUiBmb3IgaG90LXJl
bW92ZS9ob3QtYWRkDQogICAtYmVmb3JlIHJlc3RvcmluZyBkZXZpY2UncyBERVZDVEwyIHJlZ2lz
dGVyIHdoZW4gcmVzdG9yZSBkZXZpY2Ugc3RhdGUNCg0KU2lnbmVkLW9mZi1ieTogTWluZ2NodWFu
ZyBRaWFvIDxtaW5nY2h1YW5nLnFpYW9AbWVkaWF0ZWsuY29tPg0KLS0tDQpjaGFuZ2VzIG9mIHYy
DQogLW1vZGlmeSBwYXRjaCBkZXNjcmlwdGlvbg0KIC1yZWNvbmZpZ3VyZSBicmlkZ2UncyBMVFIg
YmVmb3JlIHJlc3RvcmluZyBkZXZpY2UgREVWQ1RMMiByZWdpc3Rlcg0KLS0tDQogZHJpdmVycy9w
Y2kvcGNpLmMgICB8IDI1ICsrKysrKysrKysrKysrKysrKysrKysrKysNCiBkcml2ZXJzL3BjaS9w
cm9iZS5jIHwgMTkgKysrKysrKysrKysrKysrKy0tLQ0KIDIgZmlsZXMgY2hhbmdlZCwgNDEgaW5z
ZXJ0aW9ucygrKSwgMyBkZWxldGlvbnMoLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL3Bj
aS5jIGIvZHJpdmVycy9wY2kvcGNpLmMNCmluZGV4IGI5ZmVjYzI1ZDIxMy4uODhiNGViNzBjMjUy
IDEwMDY0NA0KLS0tIGEvZHJpdmVycy9wY2kvcGNpLmMNCisrKyBiL2RyaXZlcnMvcGNpL3BjaS5j
DQpAQCAtMTQzNyw2ICsxNDM3LDI0IEBAIHN0YXRpYyBpbnQgcGNpX3NhdmVfcGNpZV9zdGF0ZShz
dHJ1Y3QgcGNpX2RldiAqZGV2KQ0KIAlyZXR1cm4gMDsNCiB9DQogDQorc3RhdGljIHZvaWQgcGNp
X3JlY29uZmlndXJlX2JyaWRnZV9sdHIoc3RydWN0IHBjaV9kZXYgKmRldikNCit7DQorI2lmZGVm
IENPTkZJR19QQ0lFQVNQTQ0KKwlzdHJ1Y3QgcGNpX2RldiAqYnJpZGdlOw0KKwl1MzIgY3RsOw0K
Kw0KKwlicmlkZ2UgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGRldik7DQorCWlmIChicmlkZ2UgJiYg
YnJpZGdlLT5sdHJfcGF0aCkgew0KKwkJcGNpZV9jYXBhYmlsaXR5X3JlYWRfZHdvcmQoYnJpZGdl
LCBQQ0lfRVhQX0RFVkNUTDIsICZjdGwpOw0KKwkJaWYgKCEoY3RsICYgUENJX0VYUF9ERVZDVEwy
X0xUUl9FTikpIHsNCisJCQlwY2lfZGJnKGJyaWRnZSwgInJlLWVuYWJsaW5nIExUUlxuIik7DQor
CQkJcGNpZV9jYXBhYmlsaXR5X3NldF93b3JkKGJyaWRnZSwgUENJX0VYUF9ERVZDVEwyLA0KKwkJ
CQkJCSBQQ0lfRVhQX0RFVkNUTDJfTFRSX0VOKTsNCisJCX0NCisJfQ0KKyNlbmRpZg0KK30NCisN
CiBzdGF0aWMgdm9pZCBwY2lfcmVzdG9yZV9wY2llX3N0YXRlKHN0cnVjdCBwY2lfZGV2ICpkZXYp
DQogew0KIAlpbnQgaSA9IDA7DQpAQCAtMTQ0Nyw2ICsxNDY1LDEzIEBAIHN0YXRpYyB2b2lkIHBj
aV9yZXN0b3JlX3BjaWVfc3RhdGUoc3RydWN0IHBjaV9kZXYgKmRldikNCiAJaWYgKCFzYXZlX3N0
YXRlKQ0KIAkJcmV0dXJuOw0KIA0KKwkvKg0KKwkgKiBEb3duc3RyZWFtIHBvcnRzIHJlc2V0IHRo
ZSBMVFIgZW5hYmxlIGJpdCB3aGVuIGxpbmsgZ29lcyBkb3duLg0KKwkgKiBDaGVjayBhbmQgcmUt
Y29uZmlndXJlIHRoZSBiaXQgaGVyZSBiZWZvcmUgcmVzdG9yaW5nIGRldmljZS4NCisJICogUENJ
ZSByNS4wLCBzZWMgNy41LjMuMTYuDQorCSAqLw0KKwlwY2lfcmVjb25maWd1cmVfYnJpZGdlX2x0
cihkZXYpOw0KKw0KIAljYXAgPSAodTE2ICopJnNhdmVfc3RhdGUtPmNhcC5kYXRhWzBdOw0KIAlw
Y2llX2NhcGFiaWxpdHlfd3JpdGVfd29yZChkZXYsIFBDSV9FWFBfREVWQ1RMLCBjYXBbaSsrXSk7
DQogCXBjaWVfY2FwYWJpbGl0eV93cml0ZV93b3JkKGRldiwgUENJX0VYUF9MTktDVEwsIGNhcFtp
KytdKTsNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9wcm9iZS5jIGIvZHJpdmVycy9wY2kvcHJv
YmUuYw0KaW5kZXggOTUzZjE1YWJjODUwLi40YWQxNzI1MTdmZDIgMTAwNjQ0DQotLS0gYS9kcml2
ZXJzL3BjaS9wcm9iZS5jDQorKysgYi9kcml2ZXJzL3BjaS9wcm9iZS5jDQpAQCAtMjEzMiw5ICsy
MTMyLDIyIEBAIHN0YXRpYyB2b2lkIHBjaV9jb25maWd1cmVfbHRyKHN0cnVjdCBwY2lfZGV2ICpk
ZXYpDQogCSAqIENvbXBsZXggYW5kIGFsbCBpbnRlcm1lZGlhdGUgU3dpdGNoZXMgaW5kaWNhdGUg
c3VwcG9ydCBmb3IgTFRSLg0KIAkgKiBQQ0llIHI0LjAsIHNlYyA2LjE4Lg0KIAkgKi8NCi0JaWYg
KHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQQ0lfRVhQX1RZUEVfUk9PVF9QT1JUIHx8DQotCSAgICAo
KGJyaWRnZSA9IHBjaV91cHN0cmVhbV9icmlkZ2UoZGV2KSkgJiYNCi0JICAgICAgYnJpZGdlLT5s
dHJfcGF0aCkpIHsNCisJaWYgKHBjaV9wY2llX3R5cGUoZGV2KSA9PSBQQ0lfRVhQX1RZUEVfUk9P
VF9QT1JUKSB7DQorCQlwY2llX2NhcGFiaWxpdHlfc2V0X3dvcmQoZGV2LCBQQ0lfRVhQX0RFVkNU
TDIsDQorCQkJCQkgUENJX0VYUF9ERVZDVEwyX0xUUl9FTik7DQorCQlkZXYtPmx0cl9wYXRoID0g
MTsNCisJCXJldHVybjsNCisJfQ0KKw0KKwlicmlkZ2UgPSBwY2lfdXBzdHJlYW1fYnJpZGdlKGRl
dik7DQorCWlmIChicmlkZ2UgJiYgYnJpZGdlLT5sdHJfcGF0aCkgew0KKwkJcGNpZV9jYXBhYmls
aXR5X3JlYWRfZHdvcmQoYnJpZGdlLCBQQ0lfRVhQX0RFVkNUTDIsICZjdGwpOw0KKwkJaWYgKCEo
Y3RsICYgUENJX0VYUF9ERVZDVEwyX0xUUl9FTikpIHsNCisJCQlwY2lfZGJnKGJyaWRnZSwgInJl
LWVuYWJsaW5nIExUUlxuIik7DQorCQkJcGNpZV9jYXBhYmlsaXR5X3NldF93b3JkKGJyaWRnZSwg
UENJX0VYUF9ERVZDVEwyLA0KKwkJCQkJCSBQQ0lfRVhQX0RFVkNUTDJfTFRSX0VOKTsNCisJCX0N
CisNCiAJCXBjaWVfY2FwYWJpbGl0eV9zZXRfd29yZChkZXYsIFBDSV9FWFBfREVWQ1RMMiwNCiAJ
CQkJCSBQQ0lfRVhQX0RFVkNUTDJfTFRSX0VOKTsNCiAJCWRldi0+bHRyX3BhdGggPSAxOw0KLS0g
DQoyLjE4LjANCg==

