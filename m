Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93F342D1D92
	for <lists+linux-pci@lfdr.de>; Mon,  7 Dec 2020 23:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgLGWmI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 7 Dec 2020 17:42:08 -0500
Received: from mga02.intel.com ([134.134.136.20]:23634 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726069AbgLGWmI (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 7 Dec 2020 17:42:08 -0500
IronPort-SDR: HS/YNYGFeuejmo8g9Ykz7DIqasDZ84Ri7jjykuglsJVtKa8trEASbBkm24g9Q3Pa2VqAatYZm3
 RWZtGupvTqUQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9828"; a="160838009"
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="160838009"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2020 14:40:22 -0800
IronPort-SDR: xPTMDMx1SlfzkWP70pupkHEMQKieL+U8m5CFyDgDA1f0vDHbJW1yqHKxoXkISOz4B7evwd2s/Y
 YEwPHYy3z3ug==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.78,400,1599548400"; 
   d="scan'208";a="407353583"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 07 Dec 2020 14:40:22 -0800
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id 3599E580816;
        Mon,  7 Dec 2020 14:40:22 -0800 (PST)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     bhelgaas@google.com, rafael@kernel.org, len.brown@intel.com
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>
Subject: [PATCH v2 2/2] PCI: Disable PTM during suspend to save power
Date:   Mon,  7 Dec 2020 14:39:51 -0800
Message-Id: <20201207223951.19667-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20201207223951.19667-1-david.e.box@linux.intel.com>
References: <20201207223951.19667-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

There are systems (for example, Intel based mobile platforms since Coffee
Lake) where the power drawn while suspended can be significantly reduced by
disabling Precision Time Measurement (PTM) on PCIe root ports as this
allows the port to enter a lower-power PM state and the SoC to reach a
lower-power idle state. To save this power, disable the PTM feature on root
ports during pci_prepare_to_sleep() and pci_finish_runtime_suspend().  The
feature will be returned to its previous state during restore and error
recovery.

Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=209361
Reported-by: Len Brown <len.brown@intel.com>
Suggested-by: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
Changes from V1:

	- Add pci_disable_ptm() to ptm.c
	- Move ptm disabling from pci_save_ptm_state() to
	  pci_prepare_to_sleep() and pci_finish_runtime_suspend() as
	  suggested by Rafael.
	- Comment change suggested by Rafael

 drivers/pci/pci.c      | 25 ++++++++++++++++++++++++-
 drivers/pci/pci.h      |  2 ++
 drivers/pci/pcie/ptm.c | 17 +++++++++++++++++
 3 files changed, 43 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 12ba6351c05b..71dd5d7cbded 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -2608,12 +2608,24 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
+	/*
+	 * There are systems (for example, Intel mobile chips since Coffee
+	 * Lake) where the power drawn while suspended can be significantly
+	 * reduced by disabling PTM on PCIe root ports as this allows the
+	 * port to enter a lower-power PM state and the SoC to reach a
+	 * lower-power idle state as a whole.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		pci_disable_ptm(dev);
+
 	pci_enable_wake(dev, target_state, wakeup);
 
 	error = pci_set_power_state(dev, target_state);
 
-	if (error)
+	if (error) {
 		pci_enable_wake(dev, target_state, false);
+		pci_restore_ptm_state(dev);
+	}
 
 	return error;
 }
@@ -2651,12 +2663,23 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 
 	dev->runtime_d3cold = target_state == PCI_D3cold;
 
+	/*
+	 * There are systems (for example, Intel mobile chips since Coffee
+	 * Lake) where the power drawn while suspended can be significantly
+	 * reduced by disabling PTM on PCIe root ports as this allows the
+	 * port to enter a lower-power PM state and the SoC to reach a
+	 * lower-power idle state as a whole.
+	 */
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+		pci_disable_ptm(dev);
+
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
 	error = pci_set_power_state(dev, target_state);
 
 	if (error) {
 		pci_enable_wake(dev, target_state, false);
+		pci_restore_ptm_state(dev);
 		dev->runtime_d3cold = false;
 	}
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 62cdacba5954..4a478ca7e3b5 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -519,9 +519,11 @@ static inline int pci_iov_bus_range(struct pci_bus *bus)
 #ifdef CONFIG_PCIE_PTM
 void pci_save_ptm_state(struct pci_dev *dev);
 void pci_restore_ptm_state(struct pci_dev *dev);
+void pci_disable_ptm(struct pci_dev *dev);
 #else
 static inline void pci_save_ptm_state(struct pci_dev *dev) {}
 static inline void pci_restore_ptm_state(struct pci_dev *dev) {}
+static inline void pci_disable_ptm(struct pci_dev *dev) {}
 #endif
 
 unsigned long pci_cardbus_resource_alignment(struct resource *);
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 6b24a1c9327a..95d4eef2c9e8 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -29,6 +29,23 @@ static void pci_ptm_info(struct pci_dev *dev)
 		 dev->ptm_root ? " (root)" : "", clock_desc);
 }
 
+void pci_disable_ptm(struct pci_dev *dev)
+{
+	int ptm;
+	u16 ctrl;
+
+	if (!pci_is_pcie(dev))
+		return;
+
+	ptm = pci_find_ext_capability(dev, PCI_EXT_CAP_ID_PTM);
+	if (!ptm)
+		return;
+
+	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
+	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
+	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+}
+
 void pci_save_ptm_state(struct pci_dev *dev)
 {
 	int ptm;
-- 
2.20.1

