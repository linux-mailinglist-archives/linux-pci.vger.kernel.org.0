Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E84544059
	for <lists+linux-pci@lfdr.de>; Thu,  9 Jun 2022 02:10:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235329AbiFIAKX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 8 Jun 2022 20:10:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235264AbiFIAKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 8 Jun 2022 20:10:21 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6598A34662;
        Wed,  8 Jun 2022 17:10:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654733411; x=1686269411;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=Y9+IS1gO54BIHDcDJFlgsbwaELjLugQXja76ti6srj8=;
  b=LA+OvDS5+v+si6XCRWBzBMdU2kTnX2bL6S2jJBB6fkm5LFEv5B1h9IbU
   gMOLNnn1xhBVcyJZksq2abKHmu1eVItcfmagOAaE8/6ahCTveZNAwIFDU
   SEDf/cyIW8zJhfG9CZ5nz5QSOGuOfSYPvsT280Msi/iwGhklAvtzDp4Qo
   D3c/TUDcPpr5gX+6xEqhn3PoAxz5X3WJpiyyDSnjsxuej7c5lPlOcCpHX
   C4jTMPFjQtxru836y15WLT0rW/J7dX+m0km/msa1df8mm7GvYHZxUjWMC
   cxKKsoT8bLa/rGK5n7REOZ6+fIK/363IhZxG9/QnlCy+VYC9Oc0JBzOxu
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10372"; a="341185153"
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="341185153"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2022 17:10:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,287,1647327600"; 
   d="scan'208";a="670854669"
Received: from linux.intel.com ([10.54.29.200])
  by FMSMGA003.fm.intel.com with ESMTP; 08 Jun 2022 17:10:09 -0700
Received: from rjingar-desk5.amr.corp.intel.com (unknown [10.251.26.11])
        by linux.intel.com (Postfix) with ESMTP id 3EB53580BBE;
        Wed,  8 Jun 2022 17:10:09 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v7 2/2] PCI/PM: Disable PTM on all devices
Date:   Wed,  8 Jun 2022 17:10:07 -0700
Message-Id: <20220609001007.533242-2-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220609001007.533242-1-rajvi.jingar@linux.intel.com>
References: <20220609001007.533242-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On receiving a PTM Request from a downstream device, if PTM is disabled
on the root port, as per PCIe specification, such request would cause
an Unsupported Request error. So disable PTM for any downstream devices.
PTM state needs to be saved before disabling it to be restored later.

Set ptm_enabled from 'struct pci_dev' to 0 in pci_ptm_disable() and
it is used in pci_save_state() before saving PTM state to avoid
double save.

Fixes: a697f072f5da ("PCI: Disable PTM during suspend to save power")
Signed-off-by: Rajvi Jingar <rajvi.jingar@linux.intel.com>
Suggested-by: David E. Box <david.e.box@linux.intel.com>
---
 v1 -> v2: add Fixes tag in commit message
 v2 -> v3: move changelog after "---" marker
 v3 -> v4: add "---" marker after changelog
 v4 -> v5: move pci_disable_ptm() out of the pci_dev->state_saved check.
	   disable PTM for all devices, not just root ports.
 v5 -> v6: move pci_disable_ptm() to pci_pm_suspend()
	   set pci_dev->ptm_enabled to 0 in pci_ptm_disable() and it is
	   used in pci_save_state() before saving PTM state to avoid
	   double save.
 v6 -> v7: add #ifdef CONFIG_PCIE_PTM in pci_save_state() before saving
	   PTM state
---
 drivers/pci/pci-driver.c | 21 ++++++++++++++++++++-
 drivers/pci/pci.c        | 28 +++++++++++++---------------
 drivers/pci/pcie/ptm.c   |  1 +
 3 files changed, 34 insertions(+), 16 deletions(-)

diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 1f64de3e5280..db4d7835d7ae 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -803,14 +803,33 @@ static int pci_pm_suspend(struct device *dev)
 		pci_dev_adjust_pme(pci_dev);
 	}
 
+	/*
+	 * If a PTM Requester is put in a low-power state, a PTM Responder
+	 * upstream from it may also be put in a low-power state. Putting a
+	 * Port in D1, D2, or D3hot does not prohibit it from sending or
+	 * responding to PTM Requests. We want to disable PTM on Responders
+	 * when they are in a low-power state. Per 6.21.3, a PTM Requester
+	 * must not be enabled when the upstream PTM Responder is disabled.
+	 * Therefore, we must disable all PTM on all downstream PTM
+	 * Requesters before disabling it on the PTM Responder, e.g., a Root
+	 * Port.
+	 *
+	 * Also, to restore the PTM state, it needs to be saved before
+	 * disabling it for all devices.
+	 */
+	pci_save_ptm_state(pci_dev);
+	pci_disable_ptm(pci_dev);
+
 	if (pm->suspend) {
 		pci_power_t prev = pci_dev->current_state;
 		int error;
 
 		error = pm->suspend(dev);
 		suspend_report_result(dev, pm->suspend, error);
-		if (error)
+		if (error) {
+			pci_restore_ptm_state(pci_dev);
 			return error;
+		}
 
 		if (!pci_dev->state_saved && pci_dev->current_state != PCI_D0
 		    && pci_dev->current_state != PCI_UNKNOWN) {
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a8..3e9dcb1bbffa 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1669,7 +1669,15 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
-	pci_save_ptm_state(dev);
+#ifdef CONFIG_PCIE_PTM
+	/*
+	 * PCI PM core disables PTM during suspend and saves PTM state before
+	 * that to be able to restore the ptm state restored later. So PCI core
+	 * needs this check to avoid double save.
+	 */
+	if (dev->ptm_enabled)
+		pci_save_ptm_state(dev);
+#endif
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -2710,24 +2718,12 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
 	if (target_state == PCI_POWER_ERROR)
 		return -EIO;
 
-	/*
-	 * There are systems (for example, Intel mobile chips since Coffee
-	 * Lake) where the power drawn while suspended can be significantly
-	 * reduced by disabling PTM on PCIe root ports as this allows the
-	 * port to enter a lower-power PM state and the SoC to reach a
-	 * lower-power idle state as a whole.
-	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
-		pci_disable_ptm(dev);
-
 	pci_enable_wake(dev, target_state, wakeup);
 
 	error = pci_set_power_state(dev, target_state);
 
-	if (error) {
+	if (error)
 		pci_enable_wake(dev, target_state, false);
-		pci_restore_ptm_state(dev);
-	}
 
 	return error;
 }
@@ -2775,8 +2771,10 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
 	 * port to enter a lower-power PM state and the SoC to reach a
 	 * lower-power idle state as a whole.
 	 */
-	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT)
+	if (pci_pcie_type(dev) == PCI_EXP_TYPE_ROOT_PORT) {
+		pci_save_ptm_state(dev);
 		pci_disable_ptm(dev);
+	}
 
 	__pci_enable_wake(dev, target_state, pci_dev_run_wake(dev));
 
diff --git a/drivers/pci/pcie/ptm.c b/drivers/pci/pcie/ptm.c
index 368a254e3124..746e29779c27 100644
--- a/drivers/pci/pcie/ptm.c
+++ b/drivers/pci/pcie/ptm.c
@@ -44,6 +44,7 @@ void pci_disable_ptm(struct pci_dev *dev)
 	pci_read_config_word(dev, ptm + PCI_PTM_CTRL, &ctrl);
 	ctrl &= ~(PCI_PTM_CTRL_ENABLE | PCI_PTM_CTRL_ROOT);
 	pci_write_config_word(dev, ptm + PCI_PTM_CTRL, ctrl);
+	dev->ptm_enabled = 0;
 }
 
 void pci_save_ptm_state(struct pci_dev *dev)
-- 
2.25.1

