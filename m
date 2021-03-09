Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2BB32331F4E
	for <lists+linux-pci@lfdr.de>; Tue,  9 Mar 2021 07:35:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229607AbhCIGfK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 9 Mar 2021 01:35:10 -0500
Received: from mga04.intel.com ([192.55.52.120]:33424 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229639AbhCIGep (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 9 Mar 2021 01:34:45 -0500
IronPort-SDR: QCsQncgDzmKNB3QlLH0q7aWmz/HkWvOESNf02j7guQ9GomTRnEHPvfasNndOoF2S0HoOAAkO5g
 kUqgaPHx/sdw==
X-IronPort-AV: E=McAfee;i="6000,8403,9917"; a="185786611"
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="185786611"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 22:34:21 -0800
IronPort-SDR: Khmg2CBJtlh2yd/r9ZqbXhdKdmfQioUWS+VNX2SjUXYMB6aozVv1kjxRorHet0Q5e1R7yNj1wh
 VV0d+UlH6qJg==
X-IronPort-AV: E=Sophos;i="5.81,234,1610438400"; 
   d="scan'208";a="409604778"
Received: from aemorris-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.212.166.56])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Mar 2021 22:34:21 -0800
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, dan.j.williams@intel.com,
        keith.busch@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v1 1/1] PCI: pciehp: Skip DLLSC handling if DPC is triggered
Date:   Mon,  8 Mar 2021 22:34:10 -0800
Message-Id: <61a4f8aec9b7121bfef47bc5b941c2c94b0cfae1.1615271492.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

When hotplug and DPC are both enabled on a Root port or
Downstream Port, during DPC events that cause a DLLSC link
down/up events, such events must be suppressed to let the DPC
driver own the recovery path.

When DPC is present and enabled, hardware will put the port in
containment state to allow SW to recover from the error condition
in the seamless manner. But, during the DPC error recovery process,
since the link is in disabled state, it will also raise the DLLSC
event. In Linux kernel architecture, DPC events are handled by DPC
driver and DLLSC events are handled by hotplug driver. If a hotplug
driver is allowed to handle such DLLSC event (triggered by DPC
containment), then we will have a race condition between error
recovery handler (in DPC driver) and hotplug handler in recovering
the contained port. Allowing such a race leads to a lot of stability
issues while recovering the  device. So skip DLLSC handling in the
hotplug driver when the PCIe port associated with the hotplug event is
in DPC triggered state and let the DPC driver be responsible for the
port recovery.

Following is the sample dmesg log which shows the contention
between hotplug handler and error recovery handler. In this
case, hotplug handler won the race and error recovery
handler reported failure.

[  724.974237] pcieport 0000:97:02.0: pciehp: Slot(4): Link Down
[  724.974266] pcieport 0000:97:02.0: DPC: containment event, status:0x1f01 source:0x0000
[  724.974269] pcieport 0000:97:02.0: DPC: unmasked uncorrectable error detected
[  724.974275] pcieport 0000:97:02.0: PCIe Bus Error: severity=Uncorrected (Non-Fatal), type=Transaction Layer, (Requester ID)
[  724.974283] pcieport 0000:97:02.0:   device [8086:347a] error status/mask=00004000/00100020
[  724.974288] pcieport 0000:97:02.0:    [14] CmpltTO                (First)
[  724.999181] pci 0000:98:00.0: AER: can't recover (no error_detected callback)
[  724.999227] pci 0000:98:00.0: Removing from iommu group 181
[  726.063125] pcieport 0000:97:02.0: pciehp: Slot(4): Card present
[  726.221117] pcieport 0000:97:02.0: DPC: Data Link Layer Link Active not set in 1000 msec
[  726.221122] pcieport 0000:97:02.0: AER: subordinate device reset failed
[  726.221162] pcieport 0000:97:02.0: AER: device recovery failed
[  727.227176] pci 0000:98:00.0: [8086:0953] type 00 class 0x010802
[  727.227202] pci 0000:98:00.0: reg 0x10: [mem 0x00000000-0x00003fff 64bit]
[  727.227234] pci 0000:98:00.0: reg 0x30: [mem 0x00000000-0x0000ffff pref]
[  727.227246] pci 0000:98:00.0: Max Payload Size set to 256 (was 128, max 256)
[  727.227251] pci 0000:98:00.0: enabling Extended Tags
[  727.227736] pci 0000:98:00.0: Adding to iommu group 181
[  727.231150] pci 0000:98:00.0: BAR 6: assigned [mem 0xd1000000-0xd100ffff pref]
[  727.231156] pci 0000:98:00.0: BAR 0: assigned [mem 0xd1010000-0xd1013fff 64bit]
[  727.231170] pcieport 0000:97:02.0: PCI bridge to [bus 98]
[  727.231174] pcieport 0000:97:02.0:   bridge window [io  0xc000-0xcfff]
[  727.231181] pcieport 0000:97:02.0:   bridge window [mem 0xd1000000-0xd10fffff]
[  727.231186] pcieport 0000:97:02.0:   bridge window [mem 0x206000000000-0x2060001fffff 64bit pref]
[  727.231555] nvme nvme1: pci function 0000:98:00.0
[  727.231581] nvme 0000:98:00.0: enabling device (0140 -> 0142)
[  737.141132] nvme nvme1: 31/0/0 default/read/poll queues
[  737.146211]  nvme1n2: p1

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Dan Williams <dan.j.williams@intel.com>
Reviewed-by: Raj Ashok <ashok.raj@intel.com>
---
 drivers/pci/hotplug/pciehp_hpc.c | 18 +++++++++++++++++
 drivers/pci/pci.h                |  2 ++
 drivers/pci/pcie/dpc.c           | 33 ++++++++++++++++++++++++++++++--
 include/linux/pci.h              |  1 +
 4 files changed, 52 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/hotplug/pciehp_hpc.c b/drivers/pci/hotplug/pciehp_hpc.c
index fb3840e222ad..8e7916abc60e 100644
--- a/drivers/pci/hotplug/pciehp_hpc.c
+++ b/drivers/pci/hotplug/pciehp_hpc.c
@@ -691,6 +691,24 @@ static irqreturn_t pciehp_ist(int irq, void *dev_id)
 		goto out;
 	}
 
+	/*
+	 * If the DLLSC link up/down event is generated due to DPC containment
+	 * in the PCIe port, skip the DLLSC event handling and let the DPC driver
+	 * own the port recovery. Allowing both hotplug DLLSC event handler and DPC
+	 * event trigger handler attempt recovery on the same port leads to stability
+	 * issues. if DPC recovery is successful, is_dpc_reset_active() will return
+	 * false and the hotplug handler will not suppress the DLLSC event. If DPC
+	 * recovery fails and the link is left in disabled state, once the user
+	 * changes the faulty card, the hotplug handler can still handle the PRESENCE
+	 * change event and bring the device back up.
+	 */
+	if ((events == PCI_EXP_SLTSTA_DLLSC) && is_dpc_reset_active(pdev)) {
+		ctrl_info(ctrl, "Slot(%s): DLLSC event(DPC), skipped\n",
+			  slot_name(ctrl));
+		ret = IRQ_HANDLED;
+		goto out;
+	}
+
 	/* Check Attention Button Pressed */
 	if (events & PCI_EXP_SLTSTA_ABP) {
 		ctrl_info(ctrl, "Slot(%s): Attention button pressed\n",
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index ef7c4661314f..cee7095483bd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -446,10 +446,12 @@ void pci_restore_dpc_state(struct pci_dev *dev);
 void pci_dpc_init(struct pci_dev *pdev);
 void dpc_process_error(struct pci_dev *pdev);
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev);
+bool is_dpc_reset_active(struct pci_dev *pdev);
 #else
 static inline void pci_save_dpc_state(struct pci_dev *dev) {}
 static inline void pci_restore_dpc_state(struct pci_dev *dev) {}
 static inline void pci_dpc_init(struct pci_dev *pdev) {}
+static inline bool is_dpc_reset_active(struct pci_dev *pdev) { return false; }
 #endif
 
 #ifdef CONFIG_PCIEPORTBUS
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index e05aba86a317..ad51109921af 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -71,6 +71,30 @@ void pci_restore_dpc_state(struct pci_dev *dev)
 	pci_write_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_CTL, *cap);
 }
 
+bool is_dpc_reset_active(struct pci_dev *dev)
+{
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
+	u16 status;
+
+	if (!dev->dpc_cap)
+		return false;
+
+	/*
+	 * If DPC is owned by firmware and EDR is not supported, there is
+	 * no race between hotplug and DPC recovery handler. So return
+	 * false.
+	 */
+	if (!host->native_dpc && !IS_ENABLED(CONFIG_PCIE_EDR))
+		return false;
+
+	if (atomic_read_acquire(&dev->dpc_reset_active))
+		return true;
+
+	pci_read_config_word(dev, dev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
+
+	return !!(status & PCI_EXP_DPC_STATUS_TRIGGER);
+}
+
 static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 {
 	unsigned long timeout = jiffies + HZ;
@@ -91,6 +115,7 @@ static int dpc_wait_rp_inactive(struct pci_dev *pdev)
 
 pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 {
+	pci_ers_result_t status = PCI_ERS_RESULT_RECOVERED;
 	u16 cap;
 
 	/*
@@ -109,15 +134,19 @@ pci_ers_result_t dpc_reset_link(struct pci_dev *pdev)
 	if (pdev->dpc_rp_extensions && dpc_wait_rp_inactive(pdev))
 		return PCI_ERS_RESULT_DISCONNECT;
 
+	atomic_inc_return_acquire(&pdev->dpc_reset_active);
+
 	pci_write_config_word(pdev, cap + PCI_EXP_DPC_STATUS,
 			      PCI_EXP_DPC_STATUS_TRIGGER);
 
 	if (!pcie_wait_for_link(pdev, true)) {
 		pci_info(pdev, "Data Link Layer Link Active not set in 1000 msec\n");
-		return PCI_ERS_RESULT_DISCONNECT;
+		status = PCI_ERS_RESULT_DISCONNECT;
 	}
 
-	return PCI_ERS_RESULT_RECOVERED;
+	atomic_dec_return_release(&pdev->dpc_reset_active);
+
+	return status;
 }
 
 static void dpc_process_rp_pio_error(struct pci_dev *pdev)
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 86c799c97b77..3314f616520d 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -479,6 +479,7 @@ struct pci_dev {
 	u16		dpc_cap;
 	unsigned int	dpc_rp_extensions:1;
 	u8		dpc_rp_log_size;
+	atomic_t	dpc_reset_active;	/* DPC trigger is active */
 #endif
 #ifdef CONFIG_PCI_ATS
 	union {
-- 
2.25.1

