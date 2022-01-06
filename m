Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54C57486D51
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jan 2022 23:43:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245211AbiAFWnQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 6 Jan 2022 17:43:16 -0500
Received: from mga02.intel.com ([134.134.136.20]:40617 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S245174AbiAFWnQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 6 Jan 2022 17:43:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1641508996; x=1673044996;
  h=from:to:cc:subject:date:message-id;
  bh=J0lYaPKiO3Z2fUqHbeBLy4j704xQ/+PqCtoBeTZQGlQ=;
  b=STg+x+QLdY4/6V77pNZ/IbgMQtmbG2e4tdzkFD3EOWLA0ZtQhE8wF713
   0vYKzSV3DP9lEvLjHdaUuKKHuPC1b9JMac8VNliw4RNc9cuXqr2QMpJgL
   Ji4K3gYXwPwwMHcRSSRMaAmTFXHElXy1JkNcDl0gDvNqOMFmUSzHf9SjC
   GSxE0nFch0SgWmoJ330QqKceOMqwkNNKJPnNHkuho6E5bbN8AyKtKe8HY
   NqTikBBTTd84/GcHt/NunMTmfi+tj9eOvSyCXHXtYW9SYBsO8STLv3Pdl
   QqVODRjzR2RYxB6iEHjULxZTeKzdNsLbYjE25jxJ/6oLhcd6bPwVmzp33
   Q==;
X-IronPort-AV: E=McAfee;i="6200,9189,10217"; a="230095719"
X-IronPort-AV: E=Sophos;i="5.88,268,1635231600"; 
   d="scan'208";a="230095719"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jan 2022 14:43:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,267,1635231600"; 
   d="scan'208";a="489092865"
Received: from brillo-chrome.jf.intel.com ([10.54.77.27])
  by orsmga002.jf.intel.com with ESMTP; 06 Jan 2022 14:43:12 -0800
From:   Sanrio Alvares <sanrio.alvares@intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     mika.westerberg@linux.intel.com,
        Sanrio Alvares <sanrio.alvares@intel.com>
Subject: [PATCH] PCI / thunderbolt: Add quirk to handle incorrect Supported Link Speeds
Date:   Thu,  6 Jan 2022 22:42:40 +0000
Message-Id: <20220106224240.31052-1-sanrio.alvares@intel.com>
X-Mailer: git-send-email 2.17.1
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In PCIe config space the "Supported Link Speeds" Vector value is 0x07,
in all downstream ports for Intel Titan Ridge. Which means link
supports Gen1, Gen2 and Gen3. While actually max link speed is 2.5GT/s
so the value of this vector should be 0x01.

As a consequence of reporting >2.5GT/s, we need to delay the full 1s
which makes resuming longer than needed.

Signed-off-by: Sanrio Alvares <sanrio.alvares@intel.com>
Reviewed-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pci.c    |  4 ++++
 drivers/pci/quirks.c | 14 ++++++++++++++
 include/linux/pci.h  |  1 +
 3 files changed, 19 insertions(+)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 3d2fb394986a..92401552d385 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6136,6 +6136,10 @@ enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev)
 {
 	u32 lnkcap2, lnkcap;
 
+	/* Use overridden value of Supported Link Speed */
+	if (dev->supported_link_speed)
+		return dev->supported_link_speed;
+
 	/*
 	 * Link Capabilities 2 was added in PCIe r3.0, sec 7.8.18.  The
 	 * implementation note there recommends using the Supported Link
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 003950c738d2..f1c11a3bb56c 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5293,6 +5293,20 @@ static void quirk_intel_qat_vf_cap(struct pci_dev *pdev)
 }
 DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x443, quirk_intel_qat_vf_cap);
 
+/*
+ * Intel Titan Ridge returns incorrect Supported Link Speeds Vector
+ * when max Link Speed is 2.5GT/s. This results in an extra 1s delay during
+ * resume_noirq with pcie tunneling enabled. Override that value:
+ */
+void quirk_intel_tbt_supported_link_speeds(struct pci_dev *pdev)
+{
+	pci_info(pdev, "applying Supported Link Speeds quirk\n");
+	pdev->supported_link_speed = PCIE_SPEED_2_5GT;
+}
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15e7, quirk_intel_tbt_supported_link_speeds);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ea, quirk_intel_tbt_supported_link_speeds);
+DECLARE_PCI_FIXUP_EARLY(PCI_VENDOR_ID_INTEL, 0x15ef, quirk_intel_tbt_supported_link_speeds);
+
 /*
  * FLR may cause the following to devices to hang:
  *
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 18a75c8e615c..633e81e9fe3b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -502,6 +502,7 @@ struct pci_dev {
 	struct pci_p2pdma __rcu *p2pdma;
 #endif
 	u16		acs_cap;	/* ACS Capability offset */
+	u8		supported_link_speed; /* Override Supported Link Speed value from device */
 	phys_addr_t	rom;		/* Physical address if not from BAR */
 	size_t		romlen;		/* Length if not from BAR */
 	char		*driver_override; /* Driver name to force a match */
-- 
2.17.1

