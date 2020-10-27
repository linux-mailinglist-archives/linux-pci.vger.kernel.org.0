Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D464429BE91
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 17:57:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1813570AbgJ0QwB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 12:52:01 -0400
Received: from mailgw01.mediatek.com ([210.61.82.183]:38302 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S1813584AbgJ0QwA (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 12:52:00 -0400
X-UUID: 303739ed48c74eee8c36ddd921644957-20201028
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Transfer-Encoding:Content-Type:MIME-Version:Message-ID:Date:Subject:CC:To:From; bh=U7XynagizbrPxo62KttFyy3xZCzKkCXP4tL+OC/Qsws=;
        b=MfAM/CSQ6SiWwRphiqmGCn7qL8XVuK7B11Djfb8lb+cv5qCDCI3Purc8b9KqgufEWZDLJ0jqM36v8CxoIKHb3BqxQzF24Wu9UyYjV8PaY58u1YJ+TZLJQgeVWnNi6Qfd2a/eWAGn9ytyJhn7MsmBs3OCYbwzSEA2Fe/6jM3Oqq8=;
X-UUID: 303739ed48c74eee8c36ddd921644957-20201028
Received: from mtkexhb01.mediatek.inc [(172.21.101.102)] by mailgw01.mediatek.com
        (envelope-from <ryder.lee@mediatek.com>)
        (Cellopoint E-mail Firewall v4.1.14 Build 0819 with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1890579906; Wed, 28 Oct 2020 00:51:52 +0800
Received: from mtkcas07.mediatek.inc (172.21.101.84) by
 mtkmbs08n2.mediatek.inc (172.21.101.56) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Wed, 28 Oct 2020 00:51:49 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas07.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Wed, 28 Oct 2020 00:51:49 +0800
From:   Ryder Lee <ryder.lee@mediatek.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
CC:     <linux-pci@vger.kernel.org>, <linux-mediatek@lists.infradead.org>,
        Ryder Lee <ryder.lee@mediatek.com>
Subject: [PATCH] pci: mediatek: fix wrong operator used
Date:   Wed, 28 Oct 2020 00:51:48 +0800
Message-ID: <2418edb8c8c81bc646ce9c508939dc27e848dcd7.1603817008.git.ryder.lee@mediatek.com>
X-Mailer: git-send-email 2.18.0
MIME-Version: 1.0
Content-Type: text/plain
X-TM-SNTS-SMTP: BA7EE0B2AC46DCA966E61E9FE1D7ED14540C86DBFE74E0B1D2CF6F77BF31C2952000:8
X-MTK:  N
Content-Transfer-Encoding: base64
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Rml4IHRoZSBpc3N1ZSByZXBvcnRlZCBieSBDb3Zlcml0eToNCldyb25nIG9wZXJhdG9yIHVzZWQg
KENPTlNUQU5UX0VYUFJFU1NJT05fUkVTVUxUKSBvcGVyYXRvcl9jb25mdXNpb246DQoocG9ydC0+
c2xvdCA8PCAzKSAmIDcgaXMgYWx3YXlzIDAgcmVnYXJkbGVzcyBvZiB0aGUgdmFsdWVzIG9mIGl0
cyBvcGVyYW5kcy4NClRoaXMgb2NjdXJzIGFzIGFuIGluaXRpYWxpemVyLg0KDQpTaWduZWQtb2Zm
LWJ5OiBSeWRlciBMZWUgPHJ5ZGVyLmxlZUBtZWRpYXRlay5jb20+DQotLS0NCiBkcml2ZXJzL3Bj
aS9jb250cm9sbGVyL3BjaWUtbWVkaWF0ZWsuYyB8IDIgKy0NCiAxIGZpbGUgY2hhbmdlZCwgMSBp
bnNlcnRpb24oKyksIDEgZGVsZXRpb24oLSkNCg0KZGlmZiAtLWdpdCBhL2RyaXZlcnMvcGNpL2Nv
bnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jIGIvZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1l
ZGlhdGVrLmMNCmluZGV4IGNmNGMxOGYwYzI1YS4uMTk4MGIwMWNlZTM1IDEwMDY0NA0KLS0tIGEv
ZHJpdmVycy9wY2kvY29udHJvbGxlci9wY2llLW1lZGlhdGVrLmMNCisrKyBiL2RyaXZlcnMvcGNp
L2NvbnRyb2xsZXIvcGNpZS1tZWRpYXRlay5jDQpAQCAtNzYwLDcgKzc2MCw3IEBAIHN0YXRpYyBz
dHJ1Y3QgcGNpX29wcyBtdGtfcGNpZV9vcHMgPSB7DQogc3RhdGljIGludCBtdGtfcGNpZV9zdGFy
dHVwX3BvcnQoc3RydWN0IG10a19wY2llX3BvcnQgKnBvcnQpDQogew0KIAlzdHJ1Y3QgbXRrX3Bj
aWUgKnBjaWUgPSBwb3J0LT5wY2llOw0KLQl1MzIgZnVuYyA9IFBDSV9GVU5DKHBvcnQtPnNsb3Qg
PDwgMyk7DQorCXUzMiBmdW5jID0gUENJX0ZVTkMocG9ydC0+c2xvdCk7DQogCXUzMiBzbG90ID0g
UENJX1NMT1QocG9ydC0+c2xvdCA8PCAzKTsNCiAJdTMyIHZhbDsNCiAJaW50IGVycjsNCi0tIA0K
Mi4xOC4wDQo=

