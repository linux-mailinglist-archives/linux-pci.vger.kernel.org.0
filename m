Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 141F55422E5
	for <lists+linux-pci@lfdr.de>; Wed,  8 Jun 2022 08:50:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbiFHBDJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Jun 2022 21:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1453997AbiFGXQP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Jun 2022 19:16:15 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64307212C88;
        Tue,  7 Jun 2022 14:08:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1654636138; x=1686172138;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=9huLQR7ICWOJUddFIOk14WmEoo8MBEsiYlRTIituFZg=;
  b=LGlvfpO0zn629aNvXDvf0h8HTmu1cwCRCP3KAJCZbCmIv4ILCJwDV/tm
   aRbTu8XMchu7/8d7jQMSFDHDyqDfL4dVDMRAJaOzEa0Sqk5EclMwbevxs
   ICYDUGE+CtloxgljOSBQy02jY+DUL2Prlf70yEq4rnnWgq9C4B74BZZ4d
   C7q7x2K6yA81W5FDP0CUb4mPFsF4hJO7EVmPBl7x7PUg2T53HID4ZLtNF
   DAXoWVsXTexN3SAbhyu5+/33kErwNSpvhTiyW4tASz0Y+Nj66Xd7I3i6c
   Bu2E2bCUlY7ihZIX9c+59YykYOiPFXwBQx5+/u/3Eh5A4cOTmihbPccaL
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10371"; a="274284824"
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="274284824"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Jun 2022 14:08:55 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.91,284,1647327600"; 
   d="scan'208";a="682952350"
Received: from linux.intel.com ([10.54.29.200])
  by fmsmga002.fm.intel.com with ESMTP; 07 Jun 2022 14:08:55 -0700
Received: from rjingar-desk5.amr.corp.intel.com (unknown [10.209.92.238])
        by linux.intel.com (Postfix) with ESMTP id BACD2580A8B;
        Tue,  7 Jun 2022 14:08:54 -0700 (PDT)
From:   Rajvi Jingar <rajvi.jingar@linux.intel.com>
To:     rafael.j.wysocki@intel.com, bhelgaas@google.com
Cc:     rajvi.jingar@linux.intel.com, david.e.box@linux.intel.com,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v6 2/2] PCI/PM: disable PTM on all devices
Date:   Tue,  7 Jun 2022 14:08:52 -0700
Message-Id: <20220607210852.475863-2-rajvi.jingar@linux.intel.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220607210852.475863-1-rajvi.jingar@linux.intel.com>
References: <20220607210852.475863-1-rajvi.jingar@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On receiving a PTM Request from a downstream device, if PTM is disabled
on the root port, as per PCIe specification, such request would cause
an Unsupported Request error. So disable PTM for any downstream devices.
PTM state needs to be saved before disabling it to be restored later.

set ptm_enabled from 'struct pci_dev' to 0 in pci_ptm_disable() and
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
---
 drivers/pci/pci-driver.c | 21 ++++++++++++++++++++-
 drivers/pci/pci.c        | 26 +++++++++++---------------
 drivers/pci/pcie/ptm.c   |  1 +
 3 files changed, 32 insertions(+), 16 deletions(-)

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
index cfaf40a540a8..0df9b783621e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -1669,7 +1669,13 @@ int pci_save_state(struct pci_dev *dev)
 	pci_save_ltr_state(dev);
 	pci_save_dpc_state(dev);
 	pci_save_aer_state(dev);
-	pci_save_ptm_state(dev);
+	/*
+	 * PCI PM core disables PTM during suspend and saves PTM state before
+	 * that to be able to restore the ptm state restored later. So PCI core
+	 * needs this check to avoid double save.
+	 */
+	if (dev->ptm_enabled)
+		pci_save_ptm_state(dev);
 	return pci_save_vc_state(dev);
 }
 EXPORT_SYMBOL(pci_save_state);
@@ -2710,24 +2716,12 @@ int pci_prepare_to_sleep(struct pci_dev *dev)
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
@@ -2775,8 +2769,10 @@ int pci_finish_runtime_suspend(struct pci_dev *dev)
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

