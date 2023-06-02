Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B19997200B6
	for <lists+linux-pci@lfdr.de>; Fri,  2 Jun 2023 13:49:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235039AbjFBLta (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Jun 2023 07:49:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235014AbjFBLt0 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Jun 2023 07:49:26 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A548310E7;
        Fri,  2 Jun 2023 04:48:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1685706534; x=1717242534;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=BtruzGycmKqs9ry1ncyoa7VfbvISx5ML/zzcyrdoo7U=;
  b=Dif17jcG+INVFOdVOZPq6DTykGF3oT/7onDc4tC50jjBvtYh3axKZRE0
   wngS+63tHSYUwRzxGX2VCRzP/WzNMwb2jgCc05rYmZJpvVlaIaV2x/yxd
   b8cJFCUPUygBdqqiFpy9wOFP5AgTZNy486aIUn3u4fqm/dZMm1mAIj562
   Ir+fe3b3NW5GRBBM1hMtIWiGDWbmhRL1IbHqZMK6fZeSyWfjGwB/ZR3O2
   yaTC2CLIjCAft2xCpFpa8/ZM5aHOeopFt3a+s2bstyc3wRJoabZKZK/Sb
   VZjw4U9aoiqyD7584gMOfh0OaWwb9tn4hGtZeO1Hlj4LGQ0B9xXLuwlaq
   Q==;
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="358279663"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="358279663"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:29 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10728"; a="707819437"
X-IronPort-AV: E=Sophos;i="6.00,212,1681196400"; 
   d="scan'208";a="707819437"
Received: from rspatil-mobl3.gar.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.208.112])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2023 04:48:24 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-pci@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael@kernel.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [RFC PATCH v1 05/13] PCI/ASPM: Add pci_enable_link_state()
Date:   Fri,  2 Jun 2023 14:47:42 +0300
Message-Id: <20230602114751.19671-6-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
References: <20230602114751.19671-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

pci_disable_link_state() lacks a symmetric pair. Some drivers want to
disable ASPM during certain phases of their operation but then
re-enable it later on. If pci_disable_link_state() is made for the
device, there is currently no way to re-enable the states that were
disabled.

Add pci_enable_link_state() to remove ASPM states from the state
disable mask.

Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 drivers/pci/pcie/aspm.c | 44 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 2 files changed, 46 insertions(+)

diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 4727f73a2d0d..aed59ab13c46 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1165,6 +1165,50 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
+/**
+ * pci_enable_link_state - Re-enable device's link state
+ * @pdev: PCI device
+ * @state: ASPM link states to re-enable
+ *
+ * Enable device's link state that were previously disable so the link is
+ * allowed to enter the specific states. Note that if the BIOS didn't grant
+ * ASPM control to the OS, this does nothing because we can't touch the
+ * LNKCTL register.
+ *
+ * Return: 0 or a negative errno.
+ */
+int pci_enable_link_state(struct pci_dev *pdev, int state)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	if (!link)
+		return -EINVAL;
+	/*
+	 * A driver requested that ASPM be disabled on this device, but
+	 * if we don't have permission to manage ASPM (e.g., on ACPI
+	 * systems we have to observe the FADT ACPI_FADT_NO_ASPM bit and
+	 * the _OSC method), we can't honor that request.  Windows has
+	 * a similar mechanism using "PciASPMOptOut", which is also
+	 * ignored in this situation.
+	 */
+	if (aspm_disabled) {
+		pci_warn(pdev, "can't enable ASPM; OS doesn't have ASPM control\n");
+		return -EPERM;
+	}
+
+	mutex_lock(&aspm_lock);
+	link->aspm_disable &= ~pci_link_state_mask(state);
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+
+	if (state & PCIE_LINK_STATE_CLKPM)
+		link->clkpm_disable = 0;
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+	mutex_unlock(&aspm_lock);
+
+	return 0;
+}
+EXPORT_SYMBOL(pci_enable_link_state);
+
 /**
  * pci_set_default_link_state - Set the default device link state
  * @pdev: PCI device
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5597e97a086d..aec259d12ca0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1777,11 +1777,13 @@ extern bool pcie_ports_native;
 int pci_disable_link_state(struct pci_dev *pdev, int state);
 int pci_disable_link_state_locked(struct pci_dev *pdev, int state);
 #ifdef CONFIG_PCIEASPM
+int pci_enable_link_state(struct pci_dev *pdev, int state);
 int pci_set_default_link_state(struct pci_dev *pdev, int state);
 void pcie_no_aspm(void);
 bool pcie_aspm_support_enabled(void);
 bool pcie_aspm_enabled(struct pci_dev *pdev);
 #else
+static inline int pci_enable_link_state(struct pci_dev *pdev, int state) { return -EOPNOTSUPP; }
 static inline int pci_set_default_link_state(struct pci_dev *pdev, int state)
 { return 0; }
 static inline void pcie_no_aspm(void) { }
-- 
2.30.2

