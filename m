Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7ABB25672E
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 13:42:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727061AbgH2LmZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Aug 2020 07:42:25 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10346 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728070AbgH2LjH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Aug 2020 07:39:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 443CCF781AEC5776F0EC;
        Sat, 29 Aug 2020 19:22:31 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 29 Aug 2020 19:22:21 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 2/2] lspci: Decode 10-Bit Tag Requester Enable
Date:   Sat, 29 Aug 2020 18:58:42 +0800
Message-ID: <1598698722-126013-3-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1598698722-126013-1-git-send-email-liudongdong3@huawei.com>
References: <1598698722-126013-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Decode 10-Bit Tag Requester Enable bit in Device Control 2 Register.

Sample output changes:

  - DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- OBFF Disabled, ARIFwd-
  + DevCtl2: Completion Timeout: 50us to 50ms, TimeoutDis- LTR- 10BitTagReq- OBFF Disabled, ARIFwd-

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 lib/header.h | 1 +
 ls-caps.c    | 3 ++-
 2 files changed, 3 insertions(+), 1 deletion(-)

diff --git a/lib/header.h b/lib/header.h
index b5d8863..9491d14 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -900,6 +900,7 @@
 #define  PCI_EXP_DEVCTL2_ATOMICOP_REQUESTER_EN	0x0040	/* AtomicOp RequesterEnable */
 #define  PCI_EXP_DEVCTL2_ATOMICOP_EGRESS_BLOCK	0x0080	/* AtomicOp Egress Blocking */
 #define  PCI_EXP_DEVCTL2_LTR		0x0400	/* LTR enabled */
+#define  PCI_EXP_DEVCTL2_10BIT_TAG_REQ	0x1000 /* 10 Bit Tag Requester enabled */
 #define  PCI_EXP_DEVCTL2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
 #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
diff --git a/ls-caps.c b/ls-caps.c
index a068fd3..b616a4b 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1134,10 +1134,11 @@ static void cap_express_dev2(struct device *d, int where, int type)
     }
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
-  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c OBFF %s,",
+  printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c 10BitTagReq%c OBFF %s,",
 	cap_express_dev2_timeout_value(PCI_EXP_DEVCTL2_TIMEOUT_VALUE(w)),
 	FLAG(w, PCI_EXP_DEVCTL2_TIMEOUT_DIS),
 	FLAG(w, PCI_EXP_DEVCTL2_LTR),
+	FLAG(w, PCI_EXP_DEVCTL2_10BIT_TAG_REQ),
 	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
     printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEVCTL2_ARI));
-- 
1.9.1

