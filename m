Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B3F63457A88
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 02:57:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236254AbhKTCA7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 21:00:59 -0500
Received: from mga01.intel.com ([192.55.52.88]:12659 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233856AbhKTCA7 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 21:00:59 -0500
X-IronPort-AV: E=McAfee;i="6200,9189,10173"; a="258318606"
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="scan'208";a="258318606"
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Nov 2021 17:57:56 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.87,249,1631602800"; 
   d="scan'208";a="673415486"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 19 Nov 2021 17:57:56 -0800
Received: from debox1-server.jf.intel.com (debox1-server.jf.intel.com [10.54.39.121])
        by linux.intel.com (Postfix) with ESMTP id 9BD75580945;
        Fri, 19 Nov 2021 17:57:56 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     nirmal.patel@linux.intel.com, jonathan.derrick@linux.dev,
        lorenzo.pieralisi@arm.com, robh@kernel.org, kw@linux.com,
        bhelgaas@google.com, david.e.box@linux.intel.com,
        michael.a.bottini@linux.intel.com, rafael@kernel.org
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] PCI/ASPM: Add ASPM BIOS override function
Date:   Fri, 19 Nov 2021 17:57:55 -0800
Message-Id: <20211120015756.1396263-1-david.e.box@linux.intel.com>
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
to ASPM_STATE_ALL. Then, reconfigure ASPM on the link.

Signed-off-by: Michael Bottini <michael.a.bottini@linux.intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/pci/pci.h       |  2 ++
 drivers/pci/pcie/aspm.c | 18 ++++++++++++++++++
 2 files changed, 20 insertions(+)

diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 3d60cabde1a1..172ec914e988 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -562,11 +562,13 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev);
 void pcie_aspm_exit_link_state(struct pci_dev *pdev);
 void pcie_aspm_pm_state_change(struct pci_dev *pdev);
 void pcie_aspm_powersave_config_link(struct pci_dev *pdev);
+void pcie_aspm_policy_override(struct pci_dev *dev);
 #else
 static inline void pcie_aspm_init_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_exit_link_state(struct pci_dev *pdev) { }
 static inline void pcie_aspm_pm_state_change(struct pci_dev *pdev) { }
 static inline void pcie_aspm_powersave_config_link(struct pci_dev *pdev) { }
+static inline void pcie_aspm_policy_override(struct pci_dev *dev) {}
 #endif
 
 #ifdef CONFIG_PCIE_ECRC
diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
index 52c74682601a..ccb98586bf0d 100644
--- a/drivers/pci/pcie/aspm.c
+++ b/drivers/pci/pcie/aspm.c
@@ -1140,6 +1140,24 @@ int pci_disable_link_state(struct pci_dev *pdev, int state)
 }
 EXPORT_SYMBOL(pci_disable_link_state);
 
+void pcie_aspm_policy_override(struct pci_dev *pdev)
+{
+	struct pcie_link_state *link = pcie_aspm_get_link(pdev);
+
+	down_read(&pci_bus_sem);
+	mutex_lock(&aspm_lock);
+
+	if (link) {
+		link->aspm_default = ASPM_STATE_ALL;
+		pcie_config_aspm_link(link, policy_to_aspm_state(link));
+		pcie_set_clkpm(link, policy_to_clkpm_state(link));
+	}
+
+	mutex_unlock(&aspm_lock);
+	up_read(&pci_bus_sem);
+}
+EXPORT_SYMBOL(pcie_aspm_policy_override);
+
 static int pcie_aspm_set_policy(const char *val,
 				const struct kernel_param *kp)
 {
-- 
2.25.1

