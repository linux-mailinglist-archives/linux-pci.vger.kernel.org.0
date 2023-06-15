Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BF47730F40
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jun 2023 08:26:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243722AbjFOG0N (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jun 2023 02:26:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237795AbjFOG0J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jun 2023 02:26:09 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6607A26AF;
        Wed, 14 Jun 2023 23:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1686810362; x=1718346362;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2iuy8KyO3OHv0vuu9wEkAYWlBpQgmQ6Sr/z3577fngY=;
  b=msjafntMeg2VN/WtOYKToZMnuVtSIzA6r6Dg2BeiUQ83HNeTenyyHcOS
   YkwZC+Z7I8a2Kf0MleV6pwWYqvOARb9TTLYG0DXm668kS9tz07kk0l1Yo
   bmEMKCCQmySVnzW//tPyDJ0NJjR/01lIrBUtX9XdiuUEJpFlBd54VpAeR
   hl8vZ8AK8fjs1VDsZ2Esm+SQh1J6OpCkm5ng+HUnbZNsdFLSfKleJ/RpY
   f5TPG4zamtPIfY3msJWXgG6VhFwWQc9ijxMAvEkbW44HHuo3FK9fTTqo1
   1V5R37gA5/AduPR2sU+906PB7+3/hw5OcImAX4PMJRrn1xeC1xdPbZs9u
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="361303658"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="361303658"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:26:02 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10741"; a="742121918"
X-IronPort-AV: E=Sophos;i="6.00,244,1681196400"; 
   d="scan'208";a="742121918"
Received: from akcopko-mobl2.amr.corp.intel.com (HELO skuppusw-desk1.amr.corp.intel.com) ([10.212.220.19])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 14 Jun 2023 23:26:01 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
Subject: [PATCH v1] PCI: pciehp: Make sure DPC trigger status is reset in PDC handler
Date:   Wed, 14 Jun 2023 23:25:59 -0700
Message-Id: <20230615062559.1268404-1-sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During the EDR-based DPC recovery process, for devices with persistent
issues, the firmware may choose not to handle the DPC error and leave
the port in DPC triggered state. In such scenarios, if the user
replaces the faulty device with a new one, the OS is expected to clear
the DPC trigger status in the hotplug error handler to enable the new
device enumeration. More details about this issue can be found in PCIe
firmware specification, r3.3, sec titled "DPC Event Handling"
Implementation note.

Similar issue might also happen if the DPC or EDR recovery handler
exits before clearing the trigger status. To fix this issue, clear the
DPC trigger status in PDC interrupt handler.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reported-by: Thatchanamurthy Satish <Satish.Thatchanamurt@Dell.com>
---
 drivers/pci/hotplug/pciehp_hpc.c |  6 +++++
 drivers/pci/pci.h                |  4 ++++
 drivers/pci/pcie/dpc.c           | 40 ++++++++++++++++++++++++++++++++
 3 files changed, 50 insertions(+)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index f8c70115b691..03f8f18a6cf5 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -735,6 +735,12 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 				      PCI_EXP_SLTCTL_ATTN_IND_ON);
 	}
 
+	/* Clear DPC trigger status */
+	if ((events & PCI_EXP_SLTSTA_PDC) && pci_dpc_is_triggered(pdev)) {
+		ctrl_dbg(ctrl, "Slot(%s): Clear DPC trigger\n", slot_name(ctrl));
+		pci_dpc_reset_trigger(pdev);
+	}
+
 	/*
 	 * Ignore Link Down/Up events caused by Downstream Port Containment
 	 * if recovery from the error succeeded.
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 2475098f6518..bbe70e9ab747 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -426,11 +426,15 @@ void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
 bool pci_dpc_recovered(struct pci_dev *pdev);
+bool pci_dpc_is_triggered(struct pci_dev *pdev);
+void pci_dpc_reset_trigger(struct pci_dev *pdev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) {}
 static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 static inline void pci_dpc_init(struct pci_dev *pdev) {}
 static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
+static inline bool pci_dpc_is_triggered(struct pci_dev *pdev) { return false; }
+static inline void pci_dpc_reset_trigger(struct pci_dev *pdev) {}
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 3ceed8e3de41..ccdc90d37f6d 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -88,6 +88,46 @@ static bool dpc_completed(struct pci_dev *pdev)
 	return true;
 }
 
+/**
+ * pci_dpc_is_triggered - Check for DPC trigger status
+ * @pdev: PCI device
+ *
+ * It is called from the PCIe hotplug driver to check for DPC
+ * trigger status.
+ *
+ * Return True if DPC is triggered or false for other cases.
+ */
+bool pci_dpc_is_triggered(struct pci_dev *pdev)
+{
+	u16 status;
+
+	if (!pdev->dpc_cap)
+		return false;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
+
+	if ((!PCI_POSSIBLE_ERROR(status)) && (status & PCI_EXP_DPC_STATUS_TRIGGER))
+		return true;
+
+	return false;
+}
+
+/**
+ * pci_reset_trigger - Clear DPC trigger status
+ * @pdev: PCI device
+ *
+ * It is called from the PCIe hotplug driver to clean the DPC
+ * trigger status in the PDC interrupt handler.
+ */
+void pci_dpc_reset_trigger(struct pci_dev *pdev)
+{
+	if (!pdev->dpc_cap)
+		return;
+
+	pci_write_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS,
+			      PCI_EXP_DPC_STATUS_TRIGGER);
+}
+
 /**
  * pci_dpc_recovered - whether DPC triggered and has recovered successfully
  * @pdev: PCI device
-- 
2.34.1

