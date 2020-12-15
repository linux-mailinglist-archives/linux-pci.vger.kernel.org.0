Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 718872DB2D6
	for <lists+linux-pci@lfdr.de>; Tue, 15 Dec 2020 18:42:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731125AbgLORbm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Dec 2020 12:31:42 -0500
Received: from smtprelay-out1.synopsys.com ([149.117.87.133]:46030 "EHLO
        smtprelay-out1.synopsys.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731099AbgLORbk (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 15 Dec 2020 12:31:40 -0500
Received: from mailhost.synopsys.com (mdc-mailhost1.synopsys.com [10.225.0.209])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        by smtprelay-out1.synopsys.com (Postfix) with ESMTPS id 1B761C04D1;
        Tue, 15 Dec 2020 17:30:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=synopsys.com; s=mail;
        t=1608053439; bh=QhfdybhEKKsdh03ZRqoA38J1K4xZmvB7mprbfS+QAtg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:In-Reply-To:
         References:From;
        b=lpnzoeb3aLciSQsSXIEOo5WyivchZBcY7eFPXAXiyeo5ld/YAXbjJnLbkzxjU9yQZ
         Xqt+rYXYGRYjQRQB8wt7XDjlp4GlambRN8YRHJWIBJ2/pnrvKRqDCaptShfTOc8d+o
         W2zO5h/ZbIIBiOqmQyulAPYhR7VnVTbNtHZA5FvMWVDSb7f5mZlRI8vlry4CVFy+Xv
         WUv3cWPaZRhhqjdta62qM27tBaELCUeMPRCuXsTj71FBTWsm3Z5TUOdwSHj4GuE7MN
         780h1sqWS6ZXIS1MlOCiqES27O2yeKCm52DCgNnnAlpGIhD/ROgkq0g6+qflb1WAkC
         V6G3Hkp2xTgpQ==
Received: from de02dwia024.internal.synopsys.com (de02dwia024.internal.synopsys.com [10.225.19.81])
        by mailhost.synopsys.com (Postfix) with ESMTP id 9F3D5A005C;
        Tue, 15 Dec 2020 17:30:37 +0000 (UTC)
X-SNPS-Relay: synopsys.com
From:   Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Gustavo Pimentel <Gustavo.Pimentel@synopsys.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 04/15] PCI: Add pci_find_vsec_capability() to find a specific VSEC
Date:   Tue, 15 Dec 2020 18:30:13 +0100
Message-Id: <cc4b62f333342df8e029b175079203cfe2bd095c.1608053262.git.gustavo.pimentel@synopsys.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
In-Reply-To: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
References: <cover.1608053262.git.gustavo.pimentel@synopsys.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add pci_find_vsec_capability() that crawls through the device config
space searching in all Vendor-Specific Extended Capabilities for a
particular capability ID.

Vendor-Specific Extended Capability (VSEC) is a PCIe capability (acts
like a wrapper) specified by PCI-SIG that allows the vendor to create
their own and specific capability in the device config space.

Signed-off-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
---
 drivers/pci/pci.c             | 29 +++++++++++++++++++++++++++++
 include/linux/pci.h           |  1 +
 include/uapi/linux/pci_regs.h |  5 +++++
 3 files changed, 35 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 6d4d5a2..235d0b2 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -623,6 +623,35 @@ u64 pci_get_dsn(struct pci_dev *dev)
 }
 EXPORT_SYMBOL_GPL(pci_get_dsn);
 
+/**
+ * pci_find_vsec_capability - Find a vendor-specific extended capability
+ * @dev: PCI device to query
+ * @cap: vendor-specific capability id code
+ *
+ * Returns the address of the vendor-specific structure that matches the
+ * requested capability id code within the device's PCI configuration space
+ * or 0 if it does not find a match.
+ */
+int pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id)
+{
+	u32 header;
+	int vsec;
+
+	vsec = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_VNDR);
+	while (vsec) {
+		if (pci_read_config_dword(dev, vsec + 0x4,
+					  &header) == PCIBIOS_SUCCESSFUL &&
+		    PCI_VSEC_CAP_ID(header) == vsec_cap_id)
+			break;
+
+		vsec = pci_find_next_ext_capability(dev, vsec,
+						    PCI_EXT_CAP_ID_VNDR);
+	}
+
+	return vsec;
+}
+EXPORT_SYMBOL_GPL(pci_find_vsec_capability);
+
 static int __pci_find_next_ht_cap(struct pci_dev *dev, int pos, int ht_cap)
 {
 	int rc, ttl = PCI_FIND_CAP_TTL;
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 22207a7..effecb0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1067,6 +1067,7 @@ int pci_find_capability(struct pci_dev *dev, int cap);
 int pci_find_next_capability(struct pci_dev *dev, u8 pos, int cap);
 int pci_find_ext_capability(struct pci_dev *dev, int cap);
 int pci_find_next_ext_capability(struct pci_dev *dev, int pos, int cap);
+int pci_find_vsec_capability(struct pci_dev *dev, int vsec_cap_id);
 int pci_find_ht_capability(struct pci_dev *dev, int ht_cap);
 int pci_find_next_ht_capability(struct pci_dev *dev, int pos, int ht_cap);
 struct pci_bus *pci_find_next_bus(const struct pci_bus *from);
diff --git a/include/uapi/linux/pci_regs.h b/include/uapi/linux/pci_regs.h
index a95d55f..f5d17be 100644
--- a/include/uapi/linux/pci_regs.h
+++ b/include/uapi/linux/pci_regs.h
@@ -730,6 +730,11 @@
 #define PCI_EXT_CAP_DSN_SIZEOF	12
 #define PCI_EXT_CAP_MCAST_ENDPOINT_SIZEOF 40
 
+/* Vendor-Specific Extended Capabilities */
+#define PCI_VSEC_CAP_ID(header)		(header & 0x0000ffff)
+#define PCI_VSEC_CAP_REV(header)	((header >> 16) & 0xf)
+#define PCI_VSEC_CAP_LEN(header)	((header >> 20) & 0xffc)
+
 /* Advanced Error Reporting */
 #define PCI_ERR_UNCOR_STATUS	4	/* Uncorrectable Error Status */
 #define  PCI_ERR_UNC_UND	0x00000001	/* Undefined */
-- 
2.7.4

