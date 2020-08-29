Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5684E25672D
	for <lists+linux-pci@lfdr.de>; Sat, 29 Aug 2020 13:42:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728087AbgH2LmX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 29 Aug 2020 07:42:23 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:10345 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728022AbgH2Ljw (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sat, 29 Aug 2020 07:39:52 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 3ED9D451245007F87673;
        Sat, 29 Aug 2020 19:22:31 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS414-HUB.china.huawei.com (10.3.19.214) with Microsoft SMTP Server id
 14.3.487.0; Sat, 29 Aug 2020 19:22:21 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>
CC:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <linuxarm@huawei.com>
Subject: [PATCH V2 1/2] lspci: Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition
Date:   Sat, 29 Aug 2020 18:58:41 +0800
Message-ID: <1598698722-126013-2-git-send-email-liudongdong3@huawei.com>
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

Adjust PCI_EXP_DEV2_* to PCI_EXP_DEVCTL2_* macro definition to keep the
same style between the Linux kernel source [1] and lspci.

[1] https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/tree/include/uapi/linux/pci_regs.h#n651

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 lib/header.h | 26 ++++++++++++++------------
 ls-caps.c    | 20 ++++++++++----------
 2 files changed, 24 insertions(+), 22 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 472816e..b5d8863 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -873,6 +873,13 @@
 #define  PCI_EXP_RTSTA_PME_STATUS  0x00010000 /* PME Status */
 #define  PCI_EXP_RTSTA_PME_PENDING 0x00020000 /* PME is Pending */
 #define PCI_EXP_DEVCAP2			0x24	/* Device capabilities 2 */
+#define  PCI_EXP_DEVCAP2_TIMEOUT_RANGE(x)	((x) & 0xf) /* Completion Timeout Ranges Supported */
+#define  PCI_EXP_DEVCAP2_TIMEOUT_DIS	0x0010	/* Completion Timeout Disable Supported */
+#define  PCI_EXP_DEVCAP2_ARI		0x0020	/* ARI Forwarding Supported */
+#define  PCI_EXP_DEVCAP2_ATOMICOP_ROUTING	0x0040	/* AtomicOp Routing Supported */
+#define  PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP	0x0080	/* 32bit AtomicOp Completer Supported */
+#define  PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP	0x0100	/* 64bit AtomicOp Completer Supported */
+#define  PCI_EXP_DEVCAP2_128BIT_CAS_COMP	0x0200	/* 128bit CAS Completer Supported */
 #define  PCI_EXP_DEVCAP2_NROPRPRP	0x0400 /* No RO-enabled PR-PR Passing */
 #define  PCI_EXP_DEVCAP2_LTR		0x0800	/* LTR supported */
 #define  PCI_EXP_DEVCAP2_TPH_COMP(x)	(((x) >> 12) & 3) /* TPH Completer Supported */
@@ -887,18 +894,13 @@
 #define  PCI_EXP_DEVCAP2_EPR_INIT	0x04000000 /* Emergency Power Reduction Initialization Required */
 #define  PCI_EXP_DEVCAP2_FRS		0x80000000 /* FRS supported */
 #define PCI_EXP_DEVCTL2			0x28	/* Device Control */
-#define  PCI_EXP_DEV2_TIMEOUT_RANGE(x)	((x) & 0xf) /* Completion Timeout Ranges Supported */
-#define  PCI_EXP_DEV2_TIMEOUT_VALUE(x)	((x) & 0xf) /* Completion Timeout Value */
-#define  PCI_EXP_DEV2_TIMEOUT_DIS	0x0010	/* Completion Timeout Disable Supported */
-#define  PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN	0x0040	/* AtomicOp RequesterEnable */
-#define  PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK	0x0080	/* AtomicOp Egress Blocking */
-#define  PCI_EXP_DEV2_ARI		0x0020	/* ARI Forwarding */
-#define  PCI_EXP_DEVCAP2_ATOMICOP_ROUTING	0x0040	/* AtomicOp Routing Supported */
-#define  PCI_EXP_DEVCAP2_32BIT_ATOMICOP_COMP	0x0080	/* 32bit AtomicOp Completer Supported */
-#define  PCI_EXP_DEVCAP2_64BIT_ATOMICOP_COMP	0x0100	/* 64bit AtomicOp Completer Supported */
-#define  PCI_EXP_DEVCAP2_128BIT_CAS_COMP	0x0200	/* 128bit CAS Completer Supported */
-#define  PCI_EXP_DEV2_LTR		0x0400	/* LTR enabled */
-#define  PCI_EXP_DEV2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
+#define  PCI_EXP_DEVCTL2_TIMEOUT_VALUE(x)	((x) & 0xf) /* Completion Timeout Value */
+#define  PCI_EXP_DEVCTL2_TIMEOUT_DIS	0x0010	/* Completion Timeout Disable */
+#define  PCI_EXP_DEVCTL2_ARI		0x0020	/* ARI Forwarding */
+#define  PCI_EXP_DEVCTL2_ATOMICOP_REQUESTER_EN	0x0040	/* AtomicOp RequesterEnable */
+#define  PCI_EXP_DEVCTL2_ATOMICOP_EGRESS_BLOCK	0x0080	/* AtomicOp Egress Blocking */
+#define  PCI_EXP_DEVCTL2_LTR		0x0400	/* LTR enabled */
+#define  PCI_EXP_DEVCTL2_OBFF(x)		(((x) >> 13) & 3) /* OBFF enabled */
 #define PCI_EXP_DEVSTA2			0x2a	/* Device Status */
 #define PCI_EXP_LNKCAP2			0x2c	/* Link Capabilities */
 #define  PCI_EXP_LNKCAP2_SPEED(x)	(((x) >> 1) & 0x7f)
diff --git a/ls-caps.c b/ls-caps.c
index a09b0cf..a068fd3 100644
--- a/ls-caps.c
+++ b/ls-caps.c
@@ -1085,8 +1085,8 @@ static void cap_express_dev2(struct device *d, int where, int type)
 
   l = get_conf_long(d, where + PCI_EXP_DEVCAP2);
   printf("\t\tDevCap2: Completion Timeout: %s, TimeoutDis%c NROPrPrP%c LTR%c",
-        cap_express_dev2_timeout_range(PCI_EXP_DEV2_TIMEOUT_RANGE(l)),
-        FLAG(l, PCI_EXP_DEV2_TIMEOUT_DIS),
+        cap_express_dev2_timeout_range(PCI_EXP_DEVCAP2_TIMEOUT_RANGE(l)),
+        FLAG(l, PCI_EXP_DEVCAP2_TIMEOUT_DIS),
 	FLAG(l, PCI_EXP_DEVCAP2_NROPRPRP),
         FLAG(l, PCI_EXP_DEVCAP2_LTR));
   printf("\n\t\t\t 10BitTagComp%c 10BitTagReq%c OBFF %s, ExtFmt%c EETLPPrefix%c",
@@ -1115,7 +1115,7 @@ static void cap_express_dev2(struct device *d, int where, int type)
     printf(" %s", cap_express_devcap2_tphcomp(PCI_EXP_DEVCAP2_TPH_COMP(l)));
 
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
-    printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEV2_ARI));
+    printf(" ARIFwd%c\n", FLAG(l, PCI_EXP_DEVCAP2_ARI));
   else
     printf("\n");
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
@@ -1135,12 +1135,12 @@ static void cap_express_dev2(struct device *d, int where, int type)
 
   w = get_conf_word(d, where + PCI_EXP_DEVCTL2);
   printf("\t\tDevCtl2: Completion Timeout: %s, TimeoutDis%c LTR%c OBFF %s,",
-	cap_express_dev2_timeout_value(PCI_EXP_DEV2_TIMEOUT_VALUE(w)),
-	FLAG(w, PCI_EXP_DEV2_TIMEOUT_DIS),
-	FLAG(w, PCI_EXP_DEV2_LTR),
-	cap_express_devctl2_obff(PCI_EXP_DEV2_OBFF(w)));
+	cap_express_dev2_timeout_value(PCI_EXP_DEVCTL2_TIMEOUT_VALUE(w)),
+	FLAG(w, PCI_EXP_DEVCTL2_TIMEOUT_DIS),
+	FLAG(w, PCI_EXP_DEVCTL2_LTR),
+	cap_express_devctl2_obff(PCI_EXP_DEVCTL2_OBFF(w)));
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_DOWNSTREAM)
-    printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEV2_ARI));
+    printf(" ARIFwd%c\n", FLAG(w, PCI_EXP_DEVCTL2_ARI));
   else
     printf("\n");
   if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
@@ -1150,10 +1150,10 @@ static void cap_express_dev2(struct device *d, int where, int type)
       printf("\t\t\t AtomicOpsCtl:");
       if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_ENDPOINT ||
           type == PCI_EXP_TYPE_ROOT_INT_EP || type == PCI_EXP_TYPE_LEG_END)
-        printf(" ReqEn%c", FLAG(w, PCI_EXP_DEV2_ATOMICOP_REQUESTER_EN));
+        printf(" ReqEn%c", FLAG(w, PCI_EXP_DEVCTL2_ATOMICOP_REQUESTER_EN));
       if (type == PCI_EXP_TYPE_ROOT_PORT || type == PCI_EXP_TYPE_UPSTREAM ||
           type == PCI_EXP_TYPE_DOWNSTREAM)
-        printf(" EgressBlck%c", FLAG(w, PCI_EXP_DEV2_ATOMICOP_EGRESS_BLOCK));
+        printf(" EgressBlck%c", FLAG(w, PCI_EXP_DEVCTL2_ATOMICOP_EGRESS_BLOCK));
       printf("\n");
     }
 }
-- 
1.9.1

