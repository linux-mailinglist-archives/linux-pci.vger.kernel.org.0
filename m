Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 772D53327E4
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 14:57:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231339AbhCIN4z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 08:56:55 -0500
Received: from szxga05-in.huawei.com ([45.249.212.191]:13079 "EHLO
        szxga05-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhCIN4l (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 9 Mar 2021 08:56:41 -0500
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga05-in.huawei.com (SkyGuard) with ESMTP id 4DvxXJ2xZTzNkQc;
        Tue,  9 Mar 2021 21:54:24 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Tue, 9 Mar 2021 21:56:35 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <mj@ucw.cz>, <helgaas@kernel.org>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH V2 1/2] lspci: Decode VF 10-Bit Tag Requester
Date:   Tue, 9 Mar 2021 21:35:18 +0800
Message-ID: <1615296919-76476-2-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
References: <1615296919-76476-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Decode VF 10-Bit Tag Requester Supported and Enable bit
in SR-IOV Capabilities Register.

Sample output:
  IOVCap: Migration- 10BitTagReq- Interrupt Message Number: 000
  IOVCtl: Enable+ Migration- Interrupt- MSE+ ARIHierarchy- 10BitTagReq-

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 lib/header.h | 2 ++
 ls-ecaps.c   | 8 ++++----
 2 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/lib/header.h b/lib/header.h
index 170e5c1..bff49c2 100644
--- a/lib/header.h
+++ b/lib/header.h
@@ -1126,6 +1126,7 @@
 /* Single Root I/O Virtualization */
 #define PCI_IOV_CAP		0x04	/* SR-IOV Capability Register */
 #define  PCI_IOV_CAP_VFM	0x00000001 /* VF Migration Capable */
+#define  PCI_IOV_CAP_VF_10BIT_TAG_REQ 0x00000004 /* VF 10-Bit Tag Requester Supported */
 #define  PCI_IOV_CAP_IMN(x)	((x) >> 21) /* VF Migration Interrupt Message Number */
 #define PCI_IOV_CTRL		0x08	/* SR-IOV Control Register */
 #define  PCI_IOV_CTRL_VFE	0x0001	/* VF Enable */
@@ -1133,6 +1134,7 @@
 #define  PCI_IOV_CTRL_VFMIE	0x0004	/* VF Migration Interrupt Enable */
 #define  PCI_IOV_CTRL_MSE	0x0008	/* VF MSE */
 #define  PCI_IOV_CTRL_ARI	0x0010	/* ARI Capable Hierarchy */
+#define  PCI_IOV_CTRL_VF_10BIT_TAG_REQ_EN 0x0020 /* VF 10-Bit Tag Requester Enable */
 #define PCI_IOV_STATUS		0x0a	/* SR-IOV Status Register */
 #define  PCI_IOV_STATUS_MS	0x0001	/* VF Migration Status */
 #define PCI_IOV_INITIALVF	0x0c	/* Number of VFs that are initially associated */
diff --git a/ls-ecaps.c b/ls-ecaps.c
index 99c55ff..1cea315 100644
--- a/ls-ecaps.c
+++ b/ls-ecaps.c
@@ -369,13 +369,13 @@ cap_sriov(struct device *d, int where)
     return;
 
   l = get_conf_long(d, where + PCI_IOV_CAP);
-  printf("\t\tIOVCap:\tMigration%c, Interrupt Message Number: %03x\n",
-	FLAG(l, PCI_IOV_CAP_VFM), PCI_IOV_CAP_IMN(l));
+  printf("\t\tIOVCap:\tMigration%c 10BitTagReq%c Interrupt Message Number: %03x\n",
+	FLAG(l, PCI_IOV_CAP_VFM), FLAG(l, PCI_IOV_CAP_VF_10BIT_TAG_REQ), PCI_IOV_CAP_IMN(l));
   w = get_conf_word(d, where + PCI_IOV_CTRL);
-  printf("\t\tIOVCtl:\tEnable%c Migration%c Interrupt%c MSE%c ARIHierarchy%c\n",
+  printf("\t\tIOVCtl:\tEnable%c Migration%c Interrupt%c MSE%c ARIHierarchy%c 10BitTagReq%c\n",
 	FLAG(w, PCI_IOV_CTRL_VFE), FLAG(w, PCI_IOV_CTRL_VFME),
 	FLAG(w, PCI_IOV_CTRL_VFMIE), FLAG(w, PCI_IOV_CTRL_MSE),
-	FLAG(w, PCI_IOV_CTRL_ARI));
+	FLAG(w, PCI_IOV_CTRL_ARI), FLAG(w, PCI_IOV_CTRL_VF_10BIT_TAG_REQ_EN));
   w = get_conf_word(d, where + PCI_IOV_STATUS);
   printf("\t\tIOVSta:\tMigration%c\n", FLAG(w, PCI_IOV_STATUS_MS));
   w = get_conf_word(d, where + PCI_IOV_INITIALVF);
-- 
1.9.1

