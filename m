Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CAA6353345
	for <lists+linux-pci@lfdr.de>; Sat,  3 Apr 2021 11:25:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236412AbhDCJQ2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 3 Apr 2021 05:16:28 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14688 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236815AbhDCJQ1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 3 Apr 2021 05:16:27 -0400
Received: from DGGEMS408-HUB.china.huawei.com (unknown [172.30.72.59])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4FCB6t1hDGznWv0;
        Sat,  3 Apr 2021 17:13:42 +0800 (CST)
Received: from linux-ioko.site (10.78.228.23) by
 DGGEMS408-HUB.china.huawei.com (10.3.19.208) with Microsoft SMTP Server id
 14.3.498.0; Sat, 3 Apr 2021 17:16:17 +0800
From:   Dongdong Liu <liudongdong3@huawei.com>
To:     <helgaas@kernel.org>, <linux-pci@vger.kernel.org>
Subject: [PATCH 1/4] PCI: Add 10-Bit Tag register definitions
Date:   Sat, 3 Apr 2021 16:54:16 +0800
Message-ID: <1617440059-2478-2-git-send-email-liudongdong3@huawei.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
References: <1617440059-2478-1-git-send-email-liudongdong3@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.78.228.23]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add 10-Bit Tag register definitions for use in subsequen patches.
See the PCIe 5.0 spec section 7.5.3.15 and 9.3.3.2.

Signed-off-by: Dongdong Liu <liudongdong3@huawei.com>
---
 include/uapi/linux/pci_regs.h | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index e709ae8..cf1ddb8 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -648,6 +648,8 @@
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP64	0x00000100 /* 64b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_ATOMIC_COMP128	0x00000200 /* 128b AtomicOp completion */
 #define  PCI_EXP_DEVCAP2_LTR		0x00000800 /* Latency tolerance reporting */
+#define  PCI_EXP_DEVCAP2_10BIT_TAG_COMP 0x00010000 /* 10-Bit Tag Completer Supported */
+#define  PCI_EXP_DEVCAP2_10BIT_TAG_REQ  0x00020000 /* 10-Bit Tag Requester Supported */
 #define  PCI_EXP_DEVCAP2_OBFF_MASK	0x000c0000 /* OBFF support mechanism */
 #define  PCI_EXP_DEVCAP2_OBFF_MSG	0x00040000 /* New message signaling */
 #define  PCI_EXP_DEVCAP2_OBFF_WAKE	0x00080000 /* Re-use WAKE# for OBFF */
@@ -661,6 +663,7 @@
 #define  PCI_EXP_DEVCTL2_IDO_REQ_EN	0x0100	/* Allow IDO for requests */
 #define  PCI_EXP_DEVCTL2_IDO_CMP_EN	0x0200	/* Allow IDO for completions */
 #define  PCI_EXP_DEVCTL2_LTR_EN		0x0400	/* Enable LTR mechanism */
+#define  PCI_EXP_DEVCTL2_10BIT_TAG_REQ_EN 0x1000 /* 10-Bit Tag Requester Enable */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGA_EN	0x2000	/* Enable OBFF Message type A */
 #define  PCI_EXP_DEVCTL2_OBFF_MSGB_EN	0x4000	/* Enable OBFF Message type B */
 #define  PCI_EXP_DEVCTL2_OBFF_WAKE_EN	0x6000	/* OBFF using WAKE# signaling */
@@ -931,6 +934,7 @@
 /* Single Root I/O Virtualization */
 #define PCI_SRIOV_CAP		0x04	/* SR-IOV Capabilities */
 #define  PCI_SRIOV_CAP_VFM	0x00000001  /* VF Migration Capable */
+#define  PCI_SRIOV_CAP_VF_10BIT_TAG_REQ	0x00000004 /* VF 10-Bit Tag Requester Supported */
 #define  PCI_SRIOV_CAP_INTR(x)	((x) >> 21) /* Interrupt Message Number */
 #define PCI_SRIOV_CTRL		0x08	/* SR-IOV Control */
 #define  PCI_SRIOV_CTRL_VFE	0x0001	/* VF Enable */
@@ -938,6 +942,7 @@
 #define  PCI_SRIOV_CTRL_INTR	0x0004	/* VF Migration Interrupt Enable */
 #define  PCI_SRIOV_CTRL_MSE	0x0008	/* VF Memory Space Enable */
 #define  PCI_SRIOV_CTRL_ARI	0x0010	/* ARI Capable Hierarchy */
+#define  PCI_SRIOV_CTRL_VF_10BIT_TAG_REQ_EN 0x0020 /* VF 10-Bit Tag Requester Enable */
 #define PCI_SRIOV_STATUS	0x0a	/* SR-IOV Status */
 #define  PCI_SRIOV_STATUS_VFM	0x0001	/* VF Migration Status */
 #define PCI_SRIOV_INITIAL_VF	0x0c	/* Initial VFs */
-- 
1.9.1

