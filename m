Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91C792A6F4C
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 21:58:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727013AbgKDU6p (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 4 Nov 2020 15:58:45 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:34141 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729809AbgKDU6n (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 4 Nov 2020 15:58:43 -0500
X-UUID: c51d949732d541fe87d0a1a64b2fa5bb-20201105
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=wUuoNNfKE+1eTR8n4GLbokBW3m4NSs3Rt+4Y39MdhxM=;
        b=tQblVnWx1Ht4vT4hd4tF1VTSqGQHoK3MiQZPcGbuMzscSv5BUnwHOqgvju8hsV5oSVI092r/fs4WrrlZxfD8uKZdpkl6/2dym0Bb6d/n2HaOcPR+78Qh3Qd0ToGH3VKzRZpjdkRrjOR5NlAalexsQSZPzNJl8TwbcShcBs7dJ5Y=;
X-UUID: c51d949732d541fe87d0a1a64b2fa5bb-20201105
Received: from mtkcas06.mediatek.inc [(172.21.101.30)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 716866443; Thu, 05 Nov 2020 04:58:41 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Thu, 5 Nov 2020 04:58:33 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Thu, 5 Nov 2020 04:58:33 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        "Ryder Lee" <ryder.lee@mediatek.com>
Subject: [PATCH v3] PCI: mediatek: Configure FC and FTS for functions other than 0
Date:   Thu, 5 Nov 2020 04:58:33 +0800
Message-ID: <c529dbfc066f4bda9b87edbdbf771f207e69b84e.1604510053.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

UENJX0ZVTkMocG9ydC0+c2xvdCA8PCAzKSIgaXMgYWx3YXlzIDAsIHNvIHByZXZpb3VzbHkNCm10
a19wY2llX3N0YXJ0dXBfcG9ydCgpIG9ubHkgY29uZmlndXJlZCBGQyBjcmVkaXRzIGFuZCBGVHMg
Zm9yDQpmdW5jdGlvbiAwLg0KDQpDb21wdXRlICJmdW5jIiBjb3JyZWN0bHkgc28gd2UgYWxzbyBj
b25maWd1cmUgZnVuY3Rpb25zIG90aGVyIHRoYW4NCjAuIFRoaXMgYWZmZWN0cyBNVDI3MDEgYW5k
IE1UNzYyMy4NCg0KQWRkcmVzc2VzLUNvdmVyaXR5LUlEOiAxNDM3MjE4ICgiV3Jvbmcgb3BlcmF0
b3IgdXNlZCIpDQpTaWduZWQtb2ZmLWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5j
b20+DQotLS0NCnYyICYgdjMgLSB1cGRhdGUgY29tbWl0IGxvZw0KLS0tDQogZHJpdmVycy9wY2kv
Y29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5z
ZXJ0aW9uKCspLCAxIGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250
cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRp
YXRlay5jDQppbmRleCBjZjRjMThmMGMyNWEuLjE5ODBiMDFjZWUzNSAxMDA2NDQNCi0tLSBhL2Ry
aXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQorKysgYi9kcml2ZXJzL3BjaS9j
b250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYw0KQEAgLTc2MCw3ICs3NjAsNyBAQCBzdGF0aWMgc3Ry
dWN0IHBjaV9vcHMgbXRrX3BjaWVfb3BzID0gew0KIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1
cF9wb3J0KHN0cnVjdCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KIHsNCiAJc3RydWN0IG10a19wY2ll
ICpwY2llID0gcG9ydC0+cGNpZTsNCi0JdTMyIGZ1bmMgPSBQQ0lfRlVOQyhwb3J0LT5zbG90IDw8
IDMpOw0KKwl1MzIgZnVuYyA9IFBDSV9GVU5DKHBvcnQtPnNsb3QpOw0KIAl1MzIgc2xvdCA9IFBD
SV9TTE9UKHBvcnQtPnNsb3QgPDwgMyk7DQogCXUzMiB2YWw7DQogCWludCBlcnI7DQotLSANCjIu
MTguMA0K

