Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F446309FC
	for <lists+linux-pci@lfdr.de>; Sat, 19 Nov 2022 03:21:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234148AbiKSCVa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 18 Nov 2022 21:21:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59158 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234848AbiKSCU7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 18 Nov 2022 21:20:59 -0500
Received: from mga01.intel.com (mga01.intel.com [192.55.52.88])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D02879376;
        Fri, 18 Nov 2022 18:14:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668824082; x=1700360082;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=P2Oru1XWgSLoubaeIvYnvzBTX/eKLDmi6dShF0lVLzs=;
  b=VMAgmBtbG2v4sbFJ2nNRE1UtkOGZ6Ufs/e81kSE272CcVXBTYKGOrV9r
   DaSijxFMYwJPwd7c3IhaeyxaaOe7opkeixa6/G3mV5PJlfn3R94tWcDk4
   GPjjDNc0fyR2b28GzURSEdEaTWSh5Mz0JrepAoDnTxoAlx9BqFXz3Mc7K
   WN5J4XoowEB+gE4uJBeWH5gllyQJOUi1S9WaqX8I6POsu4ua1QRkSXZdY
   eV915kf5HnBKawS2MDnnRk5VJQgvQFit0hPQVaWyFcWEsiq9Oz9kEHklb
   h+d22FPZmrySeDid0/XuQVzLqhweWP6Q9pXcSBRnsw5UJRX72kYnLcYTB
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="340126977"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="340126977"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Nov 2022 18:14:12 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10535"; a="765371057"
X-IronPort-AV: E=Sophos;i="5.96,175,1665471600"; 
   d="scan'208";a="765371057"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga004.jf.intel.com with ESMTP; 18 Nov 2022 18:14:12 -0800
Received: from debox1-desk4.lan (unknown [10.252.138.169])
        by linux.intel.com (Postfix) with ESMTP id C8545580DDF;
        Fri, 18 Nov 2022 18:14:11 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@intel.com, rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V8 RESEND 1/4] PCI/ASPM: Add pci_enable_link_state()
Date:   Fri, 18 Nov 2022 18:14:08 -0800
Message-Id: <20221119021411.1383248-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20221119021411.1383248-1-david.e.box@linux.intel.com>
References: <20221119021411.1383248-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Michael Bottini <michael.a.bottini@linux.intel.com>

Add pci_enable_link_state() to allow devices to change the default BIOS
configured states. Clears the BIOS default settings then sets the new
states and reconfigures the link under the semaphore. Also add
PCIE_LINK_STATE_ALL macro for convenience for callers that want to enable
all link states.

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 V8
  - No change

 V7
  - Fix description as suggested by Bjorn
  - Rename function to pci_enable_link_state

 V6
  - No change
 V5
  - Rename to pci_enable_default_link_state and model after
    pci_disable_link_state() as suggested by Bjorn.
  - Add helper PCIE_LINK_STATE_ALL which sets bits for all links states and
    clock pm.
  - Clarify commit language to indicate the function changes the default
    link states (not ASPM policy).
 V4
  - Refactor vmd_enable_apsm() to exit early, making the lines shorter
    and more readable. Suggested by Christoph.
 V3
  - No changes
 V2
  - Use return status to print pci_info message if ASPM cannot be enabled.
  - Add missing static declaration, caught by lkp@intel.com

 drivers/pci/pcie/aspm.c | 54 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  7 ++++++
 2 files changed, 61 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 53a1fa306e1e..339c686a5094 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1181,6 +1181,60 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
+/**
+ * pci_enable_link_state - Clear and set the default device link state so that
+ * the link may be allowed to enter the specified states. Note that if the
+ * BIOS didn't grant ASPM control to the OS, this does nothing because we can't
+ * touch the LNKCTL register. Also note that this does not enable states
+ * disabled by pci_disable_link_state(). Return 0 or a negative errno.
+ *
+ * @pdev: PCI device
+ * @state: Mask of ASPM link states to enable
+ */
+int pci_enable_link_state(struct pci_dev *pdev, int state)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	if (!link)
+		return -EINVAL;
+	/*
+	 * A driver requested that ASPM be enabled on this device, but
+	 * if we don't have permission to manage ASPM (e.g., on ACPI
+	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
+	 * the _OSC method), we can't honor that request.
+	 */
+	if (aspm_disabled) {
+		pci_warn(pdev, "can't override BIOS ASPM; OS doesn't have ASPM control\n");
+		return -EPERM;
+	}
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+	link->aspm_default = 0;
+	if (state & PCIE_LINK_STATE_L0S)
+		link->aspm_default |= ASPM_STATE_L0S;
+	if (state & PCIE_LINK_STATE_L1)
+		/* L1 PM substates require L1 */
+		link->aspm_default |= ASPM_STATE_L1 | ASPM_STATE_L1SS;
+	if (state & PCIE_LINK_STATE_L1_1)
+		link->aspm_default |= ASPM_STATE_L1_1;
+	if (state & PCIE_LINK_STATE_L1_2)
+		link->aspm_default |= ASPM_STATE_L1_2;
+	if (state & PCIE_LINK_STATE_L1_1_PCIPM)
+		link->aspm_default |= ASPM_STATE_L1_1_PCIPM;
+	if (state & PCIE_LINK_STATE_L1_2_PCIPM)
+		link->aspm_default |= ASPM_STATE_L1_2_PCIPM;
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+
+	link->clkpm_default = (state & PCIE_LINK_STATE_CLKPM) ? 1 : 0;
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_enable_link_state);
+
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
 {
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 2bda4a4e47e8..8c35f15e6012 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1651,10 +1651,15 @@ extern bool pcie_ports_native;
 #define PCIE_LINK_STATE_L1_2		BIT(4)
 #define PCIE_LINK_STATE_L1_1_PCIPM	BIT(5)
 #define PCIE_LINK_STATE_L1_2_PCIPM	BIT(6)
+#define PCIE_LINK_STATE_ALL		(PCIE_LINK_STATE_L0S | PCIE_LINK_STATE_L1 |\
+					 PCIE_LINK_STATE_CLKPM | PCIE_LINK_STATE_L1_1 |\
+					 PCIE_LINK_STATE_L1_2 | PCIE_LINK_STATE_L1_1_PCIPM |\
+					 PCIE_LINK_STATE_L1_2_PCIPM)
 
 #ifdef CONFIG_PCIEASPM
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
+int pci_enable_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
@@ -1663,6 +1668,8 @@ static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline int pci_disable_link_state_locked(struct pci_dev *pdev, int state)
 { return 0; }
+static inline int pci_enable_link_state(struct pci_dev *pdev, int state)
+{ return 0; }
 static inline void pcie_no_aspm(void) { }
 static inline bool pcie_aspm_support_enabled(void) { return false; }
 static inline bool pcie_aspm_enabled(struct pci_dev *pdev) { return false; }
-- 
2.34.1

