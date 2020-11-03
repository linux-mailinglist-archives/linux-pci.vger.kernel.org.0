Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DB6682A5A6F
	for <lists+linux-pci@lfdr.de>; Wed,  4 Nov 2020 00:10:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729490AbgKCXKV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 3 Nov 2020 18:10:21 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:59143 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728415AbgKCXKU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 3 Nov 2020 18:10:20 -0500
X-UUID: b397e3c3c9864c158a4c3f24dda5955c-20201104
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=YSxMnqGbz4l5hYXgU6bg34RyZNddCK+MyndOJMEH3FI=;
        b=efIp3+vk3ddB1R7qmjqQGRrpGJotehsk3rS4qhA3YgC0bfwKxyGdZO3bxtqzzxOUaWTntdRTy6qVY6TiWpv3zJMRyGJBsW9AAE7rFLc7zfcP8LptwgTwqdLlyHihJG9clqgPoBP/FEwF/N30MFOtzsnh92zYgFzgKy1tDQ6Nz5w=;
X-UUID: b397e3c3c9864c158a4c3f24dda5955c-20201104
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 723300426; Wed, 04 Nov 2020 07:10:15 +0800
Received: from MTKCAS06.mediatek.inc (172.21.101.30) by
 mtkmbs08n1.mediatek.inc (172.21.101.55) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 4 Nov 2020 07:10:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by MTKCAS06.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 4 Nov 2020 07:10:13 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH v2] PCI: mediatek: Fix wrong operator used
Date:   Wed, 4 Nov 2020 07:10:11 +0800
Message-ID: <21f722bb80c440b69dd350b48f86cd7d076a8adf.1604443256.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

U29DcyBsaWtlIE1UMjcwMSBhbmQgTVQ3NjIzIHVzZSBtdGtfcGNpZV9zdGFydHVwX3BvcnQoKSB0
byBjb21wdXRlICJmdW5jIiwNCmJ1dCBmcm9tIHRoZSBjb2RlLCB0aGUgcmVzdWx0IHdlIGdldCBp
cyBpbmNvcnJlY3QuDQoNCgkjZGVmaW5lIFBDSV9GVU5DKGRldmZuKSAgICAgICAgICgoZGV2Zm4p
ICYgMHgwNykNCg0KCWZ1bmMgPSBQQ0lfRlVOQyhwb3J0LT5zbG90IDw8IDMpDQoNClRoZSAiZnVu
YyIgaXMgYWx3YXlzIDAsIHdoaWNoIHJlc3VsdHMgaW4gb3RoZXIgZnVuY3Rpb25zIG1heSBub3Qg
aGF2ZSBiZWVuDQpjb25maWd1cmVkIGNvcnJlY3RseS4gKGkuZS4gRkMgY3JlZGl0cyBhbmQgRlRT
KQ0KDQpBZGRyZXNzZXMtQ292ZXJpdHktSUQ6IDE0MzcyMTggKCJXcm9uZyBvcGVyYXRvciB1c2Vk
IikNClNpZ25lZC1vZmYtYnk6IFJ5ZGVyIExlZSA8cnlkZXIubGVlQG1lZGlhdGVrLmNvbT4NCi0t
LQ0KVjIgLSByZXZpc2UgY29tbWl0IGxvZw0KLS0tDQogZHJpdmVycy9wY2kvY29udHJvbGxlci9w
Y2llLW1lZGlhdGVrLmMgfCAyICstDQogMSBmaWxlIGNoYW5nZWQsIDEgaW5zZXJ0aW9uKCspLCAx
IGRlbGV0aW9uKC0pDQoNCmRpZmYgLS1naXQgYS9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3BjaWUt
bWVkaWF0ZWsuYyBiL2RyaXZlcnMvcGNpL2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQppbmRl
eCBjZjRjMThmMGMyNWEuLjE5ODBiMDFjZWUzNSAxMDA2NDQNCi0tLSBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQorKysgYi9kcml2ZXJzL3BjaS9jb250cm9sbGVyL3Bj
aWUtbWVkaWF0ZWsuYw0KQEAgLTc2MCw3ICs3NjAsNyBAQCBzdGF0aWMgc3RydWN0IHBjaV9vcHMg
bXRrX3BjaWVfb3BzID0gew0KIHN0YXRpYyBpbnQgbXRrX3BjaWVfc3RhcnR1cF9wb3J0KHN0cnVj
dCBtdGtfcGNpZV9wb3J0ICpwb3J0KQ0KIHsNCiAJc3RydWN0IG10a19wY2llICpwY2llID0gcG9y
dC0+cGNpZTsNCi0JdTMyIGZ1bmMgPSBQQ0lfRlVOQyhwb3J0LT5zbG90IDw8IDMpOw0KKwl1MzIg
ZnVuYyA9IFBDSV9GVU5DKHBvcnQtPnNsb3QpOw0KIAl1MzIgc2xvdCA9IFBDSV9TTE9UKHBvcnQt
PnNsb3QgPDwgMyk7DQogCXUzMiB2YWw7DQogCWludCBlcnI7DQotLSANCjIuMTguMA0K

