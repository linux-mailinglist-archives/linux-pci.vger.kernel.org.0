Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E98833E85B
	for <lists+linux-pci@lfdr.de>; Wed, 17 Mar 2021 05:20:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229498AbhCQEUU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 17 Mar 2021 00:20:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229537AbhCQEUP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 17 Mar 2021 00:20:15 -0400
X-Greylist: delayed 388 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 16 Mar 2021 21:20:14 PDT
Received: from bmailout1.hostsharing.net (bmailout1.hostsharing.net [IPv6:2a01:37:1000::53df:5f64:0])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28AFC06174A
        for <linux-pci@vger.kernel.org>; Tue, 16 Mar 2021 21:20:14 -0700 (PDT)
Received: from h08.hostsharing.net (h08.hostsharing.net [IPv6:2a01:37:1000::53df:5f1c:0])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client CN "*.hostsharing.net", Issuer "RapidSSL TLS DV RSA Mixed SHA256 2020 CA-1" (verified OK))
        by bmailout1.hostsharing.net (Postfix) with ESMTPS id 09FEF30000CC4;
        Wed, 17 Mar 2021 05:13:43 +0100 (CET)
Received: by h08.hostsharing.net (Postfix, from userid 100393)
        id F17634F33A; Wed, 17 Mar 2021 05:13:42 +0100 (CET)
Date:   Wed, 17 Mar 2021 05:13:42 +0100
From:   Lukas Wunner <lukas@wunner.de>
To:     sathyanarayanan.kuppuswamy@linux.intel.com
Cc:     bhelgaas@google.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, ashok.raj@intel.com,
        dan.j.williams@intel.com, kbusch@kernel.org, knsathya@kernel.org,
        Sinan Kaya <okaya@kernel.org>
Subject: Re: [PATCH v2 1/1] PCI: pciehp: Skip DLLSC handling if DPC is
 triggered
Message-ID: <20210317041342.GA19198@wunner.de>
References: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <59cb30f5e5ac6d65427ceaadf1012b2ba8dbf66c.1615606143.git.sathyanarayanan.kuppuswamy@linux.intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Fri, Mar 12, 2021 at 07:32:08PM -0800, sathyanarayanan.kuppuswamy@linux.intel.com wrote:
> +	if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
> +		ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
> +			  slot_name(ctrl));
> +		ret = IRQ_HANDLED;
> +		goto out;
> +	}

Two problems here:

(1) If recovery fails, the link will *remain* down, so there'll be
    no Link Up event.  You've filtered the Link Down event, thus the
    slot will remain in ON_STATE even though the device in the slot is
    no longer accessible.  That's not good, the slot should be brought
    down in this case.

(2) If recovery succeeds, there's a race where pciehp may call
    is_dpc_reset_active() *after* dpc_reset_link() has finished.
    So both the DPC Trigger Status bit as well as pdev->dpc_reset_active
    will be cleared.  Thus, the Link Up event is not filtered by pciehp
    and the slot is brought down and back up even though DPC recovery
    was succesful, which seems undesirable.

The only viable solution I see is to wait until DPC has completed.
Sinan (+cc) proposed something along those lines a couple years back:

https://patchwork.ozlabs.org/project/linux-pci/patch/20180818065126.77912-1-okaya@kernel.org/

Included below please find my suggestion for how to fix this.
I've sort of combined yours and Sinan's approach, but I'm
using a waitqueue (Sinan used polling) and I'm using atomic bitops
on pdev->priv_flags (you're using an atomic_t instead, which needs
additionally space in struct pci_dev).  Note: It's compile-tested
only, I don't have any DPC-capable hardware at my disposal.

Would this work for you?  If so, I can add a commit message to the
patch and submit it properly.  Let me know what you think.  Thanks!

-- >8 --
Subject: [PATCH] PCI: pciehp: Ignore Link Down/Up caused by DPC

Signed-off-by: Lukas Wunner <lukas@wunner.de>
---
 drivers/pci/hotplug/pciehp_hpc.c | 11 +++++++++
 drivers/pci/pci.h                |  4 ++++
 drivers/pci/pcie/dpc.c           | 51 ++++++++++++++++++++++++++++++++++++++--
 3 files changed, 64 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index fb3840e..bcc018e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -707,6 +707,17 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 	}
 
 	/*
+	 * Ignore Link Down/Up caused by Downstream Port Containment
+	 * if recovery from the error succeeded.
+	 */
+	if ((events & PCI_EXP_SLTSTA_DLLSC) && pci_dpc_recovered(pdev) &&
+	    ctrl->state == ON_STATE) {
+		atomic_and(~PCI_EXP_SLTSTA_DLLSC, &ctrl->pending_events);
+		if (pciehp_check_link_active(ctrl) > 0)
+			events &= ~PCI_EXP_SLTSTA_DLLSC;
+	}
+
+	/*
 	 * Disable requests have higher priority than Presence Detect Changed
 	 * or Data Link Layer State Changed events.
 	 */
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 9684b46..e5ae5e8 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -392,6 +392,8 @@ static inline bool pci_dev_is_disconnected(const struct pci_dev *dev)
 
 /* pci_dev priv_flags */
 #define PCI_DEV_ADDED 0
+#define PCI_DPC_RECOVERED 1
+#define PCI_DPC_RECOVERING 2
 
 static inline void pci_dev_assign_added(struct pci_dev *dev, bool added)
 {
@@ -446,10 +448,12 @@ struct rcec_ea {
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
+bool pci_dpc_recovered(struct pci_dev *pdev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) {}
 static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 static inline void pci_dpc_init(struct pci_dev *pdev) {}
+static inline bool pci_dpc_recovered(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e05aba8..7328d9c4 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -71,6 +71,44 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
 }
 
+static bool dpc_completed(struct pci_dev *pdev)
+{
+	u16 status;
+
+	pci_read_config_word(pdev, pdev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
+	if (status & PCI_EXP_DPC_STATUS_TRIGGER)
+		return false;
+
+	if (test_bit(PCI_DPC_RECOVERING, &pdev->priv_flags))
+		return false;
+
+	return true;
+}
+
+static DECLARE_WAIT_QUEUE_HEAD(dpc_completed_waitqueue);
+
+bool pci_dpc_recovered(struct pci_dev *pdev)
+{
+	struct pci_host_bridge *host;
+
+	if (!pdev->dpc_cap)
+		return false;
+
+	/*
+	 * If DPC is owned by firmware and EDR is not supported, there is
+	 * no race between hotplug and DPC recovery handler. So return
+	 * false.
+	 */
+	host = pci_find_host_bridge(pdev->bus);
+	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
+		return false;
+
+	wait_event_timeout(dpc_completed_waitqueue, dpc_completed(pdev),
+			   msecs_to_jiffies(5000));
+
+	return test_and_clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
+}
+
 static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -91,8 +129,12 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
+	pci_ers_result_t ret;
 	u16 cap;
 
+	clear_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
+	set_bit(PCI_DPC_RECOVERING, &pdev->priv_flags);
+
 	/*
 	 * DPC disables the Link automatically in hardware, so it has
 	 * already been reset by the time we get here.
@@ -114,10 +156,15 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 
 	if (!pcie_wait_for_link(pdev, true)) {
 		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
-		return PCI_ERS_RESULT_DISCONNECT;
+		ret = PCI_ERS_RESULT_DISCONNECT;
+	} else {
+		set_bit(PCI_DPC_RECOVERED, &pdev->priv_flags);
+		ret = PCI_ERS_RESULT_RECOVERED;
 	}
 
-	return PCI_ERS_RESULT_RECOVERED;
+	clear_bit(PCI_DPC_RECOVERING, &pdev->priv_flags);
+	wake_up_all(&dpc_completed_waitqueue);
+	return ret;
 }
 
 static void dpc_process_rp_pio_error(struct pci_dev *pdev)
-- 
2.30.1
