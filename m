Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E994B6749D6
	for <lists+linux-pci@lfdr.de>; Fri, 20 Jan 2023 04:15:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229643AbjATDPa (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 19 Jan 2023 22:15:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjATDP1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 19 Jan 2023 22:15:27 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A28AA261;
        Thu, 19 Jan 2023 19:15:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674184524; x=1705720524;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=3A41ulQohixwTgT6L4o7J7F70vSedHPX3bhHUcBklsE=;
  b=dV8QpJ1I+daQiUjFiAVQP8efZM2VsZUAg8N/v65Xaig+pciVCRZ4TCJ/
   PimUzHy8Djm7v30dZ4SP/9Wt1JL0qIl58pROIn5piDv4BiQ7Fjo4QCkA4
   ea+0p3m9aLCa5bDFM43cPtuNQ0LdOMi+yxV6941TpaREsb0Bii137jXu1
   +fhn1KpgD5wSdzqenL+32MR+NjzXOiIAKVQvxv3+0ObfTK1P/MPsI6Xq0
   e8JuLfy8wjTr+tSY85rhp4sqC8NlxPidyb5ZmQAzjMdB4R+tLQlXmfMbJ
   Ukd7MAofz4v8gulpNm9KdapwKZkwvjljsCqW8GxFXJQ2Uxz8SHqp/K70u
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="390012679"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="390012679"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Jan 2023 19:15:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10595"; a="638009307"
X-IronPort-AV: E=Sophos;i="5.97,230,1669104000"; 
   d="scan'208";a="638009307"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga006.jf.intel.com with ESMTP; 19 Jan 2023 19:15:23 -0800
Received: from debox1-desk4.intel.com (unknown [10.212.255.207])
        by linux.intel.com (Postfix) with ESMTP id E1A63580AA4;
        Thu, 19 Jan 2023 19:15:22 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     david.e.box@linux.intel.com, nirmal.patel@linux.intel.com,
        jonathan.derrick@linux.dev, lorenzo.pieralisi@arm.com,
        hch@infradead.org, kw@linux.com, robh@kernel.org,
        bhelgaas@google.com, michael.a.bottini@intel.com,
        rafael@kernel.org, me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V10 1/4] PCI/ASPM: Add pci_enable_link_state()
Date:   Thu, 19 Jan 2023 19:15:19 -0800
Message-Id: <20230120031522.2304439-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230120031522.2304439-1-david.e.box@linux.intel.com>
References: <20230120031522.2304439-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
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
 V10
  - No change
 V9
  - No change
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
index adffd65e84b4..ea601e6fbbda 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1685,10 +1685,15 @@ extern bool pcie_ports_native;
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
@@ -1697,6 +1702,8 @@ static inline int pci_disable_link_state(struct pci_dev *pdev, int state)
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

