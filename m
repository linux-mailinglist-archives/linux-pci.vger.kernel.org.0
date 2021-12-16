Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 916D1476A07
	for <lists+linux-pci@lfdr.de>; Thu, 16 Dec 2021 06:56:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231534AbhLPF4H (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 16 Dec 2021 00:56:07 -0500
Received: from mga05.intel.com ([192.55.52.43]:1908 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231509AbhLPF4G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 16 Dec 2021 00:56:06 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10199"; a="325691356"
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="325691356"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 15 Dec 2021 21:56:01 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,210,1635231600"; 
   d="scan'208";a="568219972"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga008.fm.intel.com with ESMTP; 15 Dec 2021 21:56:01 -0800
Received: from debox1-desk4.intel.com (unknown [10.209.86.221])
        by linux.intel.com (Postfix) with ESMTP id AA555580D42;
        Wed, 15 Dec 2021 21:56:00 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, hch@infradead.org, kw@linux.com,
        robh@kernel.org, bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org,
        me@adhityamohan.in
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH V4 1/2] PCI/ASPM: Add ASPM BIOS override function
Date:   Wed, 15 Dec 2021 21:55:59 -0800
Message-Id: <20211216055600.2425362-1-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Michael Bottini <michael.a.bottini@linux.intel.com>

Devices that appear under the Intel VMD host bridge are not visible to BIOS
and therefore not programmed by BIOS with ASPM settings. For these devices,
it is necessary for the driver to configure ASPM. Since ASPM settings are
adjustable at runtime by module parameter, use the same mechanism to allow
drivers to override the default (in this case never configured) BIOS policy
to ASPM_STATE_ALL. Then, reconfigure ASPM on the link. Do not override if
ASPM control is disabled.

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
V4
 - No changes.
V3
 - Fix missing semicolon in static inline function.

V2
 - Change return type to int so caller can determine if override was
   successful.
 - Return immediately if link is not found so that lock it not
   unecessarily taken, suggested by kw@linux.com.
 - Don't override if aspm_disabled is true.

 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 19 +++++++++++++++++++
 2 files changed, 21 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..c9c55d43cd8a 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -562,11 +562,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+int pcie_aspm_policy_override(struct pci_dev *dev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline int pcie_aspm_policy_override(struct pci_dev *dev) { return -EINVAL; }
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 52c74682601a..e2c61e14e724 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1140,6 +1140,25 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
+int pcie_aspm_policy_override(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	if (!link || aspm_disabled)
+		return -EINVAL;
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+	link->aspm_default = ASPM_STATE_ALL;
+	pcie_config_aspm_link(link, policy_to_aspm_state(link));
+	pcie_set_clkpm(link, policy_to_clkpm_state(link));
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+
+	return 0;
+}
+EXPORT_SYMBOL(pcie_aspm_policy_override);
+
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
 {
-- 
2.25.1

