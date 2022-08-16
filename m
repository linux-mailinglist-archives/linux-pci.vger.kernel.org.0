Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 110325958FF
	for <lists+linux-pci@lfdr.de>; Tue, 16 Aug 2022 12:53:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234003AbiHPKxX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 16 Aug 2022 06:53:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230172AbiHPKxE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 16 Aug 2022 06:53:04 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 539AA2C641
        for <linux-pci@vger.kernel.org>; Tue, 16 Aug 2022 03:20:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660645232; x=1692181232;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=HJfYgK5NM8XnPZRlYHb+V1fcgMGYYKdU4fQLCC4Lhm8=;
  b=lM6uscP/5nUm7Iw+pA6VJ7dy16sbRDLnapliFSfzx4AQNW2isW0QK6wt
   NMrrYdEQmaaWrYQVcrvnosm9xSlr1MtcHNKxq9L4Q91JmML4wr4PpBHNQ
   pExCHhbB2D3ntSxONF/aH2gF0d2Z6qpRsBm/1eOqsgsB24/ZOk69lx4cg
   b68iaUTMHvPN2JxfOLPT7MGCcOy71zvjYhoMzvrk9JQp1OnWnVPbQu/NV
   GonbWaq80nDa690ynAcEWbNBrEfIVg+gfxlj+Bi7u8YGJ8EwB19Mbtb+u
   m/d0j5NHK+htQf5zcD3HmEkcWJf4ylQnpFBjPeKQTeb5sV7vmsDNja0ho
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10440"; a="290934009"
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="290934009"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2022 03:20:32 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,240,1654585200"; 
   d="scan'208";a="639981362"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga001.jf.intel.com with ESMTP; 16 Aug 2022 03:20:30 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id E19262D5; Tue, 16 Aug 2022 13:20:42 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Russell Currey <ruscur@russell.cc>, oohall@gmail.com,
        Paul Menzel <pmenzel@molgen.mpg.de>,
        Lukas Wunner <lukas@wunner.de>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH] PCI/DPC: Quirk PIO log size for certain Intel PCIe root ports
Date:   Tue, 16 Aug 2022 13:20:42 +0300
Message-Id: <20220816102042.69125-1-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There is a BIOS bug on Intel Tiger Lake and Alder Lake systems that
accidentally clears the root port PIO log size even though it should be 4.
Fix the affected root ports by forcing the log size to be 4 if it is set
to 0. The BIOS for the next generation CPUs should have this fixed.

Link: https://bugzilla.kernel.org/show_bug.cgi?id=209943
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/pci/pcie/dpc.c | 13 ++++++++-----
 drivers/pci/quirks.c   | 37 +++++++++++++++++++++++++++++++++++++
 2 files changed, 45 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3e9afee02e8d..ab06c801a2c1 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -335,11 +335,14 @@ void pci_dpc_init(struct pci_dev *pdev)
 		return;
 
 	pdev->dpc_rp_extensions = true;
-	pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
-	if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
-		pci_err(pdev, "RP PIO log size %u is invalid\n",
-			pdev->dpc_rp_log_size);
-		pdev->dpc_rp_log_size = 0;
+	/* If not already set by the quirk in quirks.c */
+	if (!pdev->dpc_rp_log_size) {
+		pdev->dpc_rp_log_size = (cap & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8;
+		if (pdev->dpc_rp_log_size < 4 || pdev->dpc_rp_log_size > 9) {
+			pci_err(pdev, "RP PIO log size %u is invalid\n",
+				pdev->dpc_rp_log_size);
+			pdev->dpc_rp_log_size = 0;
+		}
 	}
 }
 
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 4944798e75b5..260d8b50f68d 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -5956,3 +5956,40 @@ DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56b1, aspm_l1_acceptable_latency
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c0, aspm_l1_acceptable_latency);
 DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x56c1, aspm_l1_acceptable_latency);
 #endif
+
+#ifdef CONFIG_PCIE_DPC
+/*
+ * Intel Tiger Lake and Alder Lake BIOS has a bug that clears the DPC
+ * log size of the integrated Thunderbolt PCIe root ports so we quirk
+ * them here.
+ */
+static void dpc_log_size(struct pci_dev *dev)
+{
+	u16 dpc_cap, val;
+
+	dpc_cap = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC);
+	if (!dpc_cap)
+		return;
+
+	pci_read_config_word(dev, dpc_cap + PCI_EXP_DPC_CAP, &val);
+	if (!(val & PCI_EXP_DPC_CAP_RP_EXT))
+		return;
+
+	if (!((val & PCI_EXP_DPC_RP_PIO_LOG_SIZE) >> 8)) {
+		pci_info(dev, "quirking RP PIO log size\n");
+		dev->dpc_rp_log_size = 4;
+	}
+}
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x461f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x462f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x463f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x466e, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a23, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a25, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a27, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a29, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2b, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2d, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a2f, dpc_log_size);
+DECLARE_PCI_FIXUP_HEADER(PCI_VENDOR_ID_INTEL, 0x9a31, dpc_log_size);
+#endif
-- 
2.35.1

