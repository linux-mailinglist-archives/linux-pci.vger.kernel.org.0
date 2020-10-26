Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2261B29971B
	for <lists+linux-pci@lfdr.de>; Mon, 26 Oct 2020 20:36:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1775692AbgJZTgV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 26 Oct 2020 15:36:21 -0400
Received: from mga12.intel.com ([192.55.52.136]:27389 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1785110AbgJZTgV (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 26 Oct 2020 15:36:21 -0400
IronPort-SDR: WL2mNzc+x8YJa2yuVMC2xKAXRjFH8oc06/YysF26DBOP6WprVqTcQvbCwk0Gnd3WUBjdQbFCuf
 jB77ASAwcQ9Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9786"; a="147261000"
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="147261000"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 12:36:20 -0700
IronPort-SDR: hxQrIVZOOkPrVw/ctLJkat+hOineT5Zsb+NgAX7BrqgiKFj8fpYBpTWlmjpcYcxHgjqjaCl8Y/
 amNSP6bquDgQ==
X-IronPort-AV: E=Sophos;i="5.77,420,1596524400"; 
   d="scan'208";a="355290387"
Received: from dhrubajy-mobl.amr.corp.intel.com (HELO skuppusw-mobl5.amr.corp.intel.com) ([10.254.101.53])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Oct 2020 12:36:19 -0700
From:   Kuppuswamy Sathyanarayanan 
        <sathyanarayanan.kuppuswamy@linux.intel.com>
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        knsathya@kernel.org
Subject: [PATCH v7 2/2] PCI/ERR: Split the fatal and non-fatal error recovery handling
Date:   Mon, 26 Oct 2020 12:36:14 -0700
Message-Id: <b2cf7277e5fa0a692f4a7bb781fa75c2a00763f6.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <546d346644654915877365b19ea534378db0894d.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <546d346644654915877365b19ea534378db0894d.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com>
In-Reply-To: <546d346644654915877365b19ea534378db0894d.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <546d346644654915877365b19ea534378db0894d.1602788209.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Commit bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
merged fatal and non-fatal error recovery paths, and also made
recovery code depend on hotplug handler for "remove affected
device + rescan" support. But this change also complicated the
error recovery path and which in turn led to the following
issues.

1. We depend on hotplug handler for removing the affected
devices/drivers on DLLSC LINK down event (on DPC event
trigger) and DPC handler for handling the error recovery. Since
both handlers operate on same set of affected devices, it leads
to race condition, which in turn leads to  NULL pointer
exceptions or error recovery failures.You can find more details
about this issue in following link.

https://lore.kernel.org/linux-pci/20201007113158.48933-1-haifeng.zhao@intel.com/T/#t

2. For non-hotplug capable devices fatal (DPC) error recovery
is currently broken. Current fatal error recovery implementation
relies on PCIe hotplug (pciehp) handler for detaching and
re-enumerating the affected devices/drivers. So when dealing with
non-hotplug capable devices, recovery code does not restore the state
of the affected devices correctly. You can find more details about
this issue in the following links.

https://lore.kernel.org/linux-pci/20200527083130.4137-1-Zhiqiang.Hou@nxp.com/
https://lore.kernel.org/linux-pci/12115.1588207324@famine/
https://lore.kernel.org/linux-pci/0e6f89cd6b9e4a72293cc90fafe93487d7c2d295.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com/

In order to fix the above two issues, we should stop relying on hotplug
handler for cleaning the affected devices/drivers and let error recovery
handler own this functionality. So this patch reverts Commit bdb5ac85777d
("PCI/ERR: Handle fatal error recovery") and re-introduce the  "remove
affected device + rescan"  functionality in fatal error recovery handler.

Also holding pci_lock_rescan_remove() will prevent the race between hotplug
and DPC handler.

Fixes: bdb5ac85777d ("PCI/ERR: Handle fatal error recovery")
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Reviewed-by: Sinan Kaya <okaya@kernel.org>
---
 Changes since v6:
  * Renamed pcie_do_nonfatal_recovery() to pcie_nonfatal_recovery().
  * Renamed pcie_do_fatal_recovery() to pcie_fatal_recovery().
  * Addressed some format issues.

 Changes since v5:
  * Fixed static/non-static declartion issue.

 Changes since v4:
  * Added new interfaces for error recovery (pcie_do_fatal_recovery()
    and pcie_do_nonfatal_recovery()).

 Documentation/PCI/pci-error-recovery.rst | 47 ++++++++++------
 Documentation/PCI/pcieaer-howto.rst      |  2 +-
 drivers/pci/pci.h                        |  7 ++-
 drivers/pci/pcie/aer.c                   | 10 ++--
 drivers/pci/pcie/dpc.c                   |  2 +-
 drivers/pci/pcie/edr.c                   |  2 +-
 drivers/pci/pcie/err.c                   | 70 ++++++++++++++++++------
 7 files changed, 95 insertions(+), 45 deletions(-)

diff --git a/Documentation/PCI/pci-error-recovery.rst b/Documentation/PCI/pci-error-recovery.rst
index 84ceebb08cac..830c8af5838b 100644
--- a/Documentation/PCI/pci-error-recovery.rst
+++ b/Documentation/PCI/pci-error-recovery.rst
@@ -115,7 +115,7 @@ The actual steps taken by a platform to recover from a PCI error
 event will be platform-dependent, but will follow the general
 sequence described below.
 
-STEP 0: Error Event
+STEP 0: Error Event: ERR_NONFATAL
 -------------------
 A PCI bus error is detected by the PCI hardware.  On powerpc, the slot
 is isolated, in that all I/O is blocked: all reads return 0xffffffff,
@@ -160,10 +160,10 @@ particular, if the platform doesn't isolate slots), and recovery
 proceeds to STEP 2 (MMIO Enable).
 
 If any driver requested a slot reset (by returning PCI_ERS_RESULT_NEED_RESET),
-then recovery proceeds to STEP 4 (Slot Reset).
+then recovery proceeds to STEP 3 (Slot Reset).
 
 If the platform is unable to recover the slot, the next step
-is STEP 6 (Permanent Failure).
+is STEP 5 (Permanent Failure).
 
 .. note::
 
@@ -198,7 +198,7 @@ reset or some such, but not restart operations. This callback is made if
 all drivers on a segment agree that they can try to recover and if no automatic
 link reset was performed by the HW. If the platform can't just re-enable IOs
 without a slot reset or a link reset, it will not call this callback, and
-instead will have gone directly to STEP 3 (Link Reset) or STEP 4 (Slot Reset)
+instead will have gone directly to STEP 3 (Slot Reset)
 
 .. note::
 
@@ -233,18 +233,12 @@ The driver should return one of the following result codes:
 
 The next step taken depends on the results returned by the drivers.
 If all drivers returned PCI_ERS_RESULT_RECOVERED, then the platform
-proceeds to either STEP3 (Link Reset) or to STEP 5 (Resume Operations).
+proceeds to STEP 4 (Resume Operations).
 
 If any driver returned PCI_ERS_RESULT_NEED_RESET, then the platform
-proceeds to STEP 4 (Slot Reset)
+proceeds to STEP 3 (Slot Reset)
 
-STEP 3: Link Reset
-------------------
-The platform resets the link.  This is a PCI-Express specific step
-and is done whenever a fatal error has been detected that can be
-"solved" by resetting the link.
-
-STEP 4: Slot Reset
+STEP 3: Slot Reset
 ------------------
 
 In response to a return value of PCI_ERS_RESULT_NEED_RESET, the
@@ -322,7 +316,7 @@ PCI card types::
 	+		pdev->needs_freset = 1;
 	+
 
-Platform proceeds either to STEP 5 (Resume Operations) or STEP 6 (Permanent
+Platform proceeds either to STEP 4 (Resume Operations) or STEP 5 (Permanent
 Failure).
 
 .. note::
@@ -332,7 +326,7 @@ Failure).
    However, it probably should.
 
 
-STEP 5: Resume Operations
+STEP 4: Resume Operations
 -------------------------
 The platform will call the resume() callback on all affected device
 drivers if all drivers on the segment have returned
@@ -344,7 +338,7 @@ a result code.
 At this point, if a new error happens, the platform will restart
 a new error recovery sequence.
 
-STEP 6: Permanent Failure
+STEP 5: Permanent Failure
 -------------------------
 A "permanent failure" has occurred, and the platform cannot recover
 the device.  The platform will call error_detected() with a
@@ -367,6 +361,27 @@ errors. See the discussion in powerpc/eeh-pci-error-recovery.txt
 for additional detail on real-life experience of the causes of
 software errors.
 
+STEP 0: Error Event: ERR_FATAL
+--------------------
+PCI bus error is detected by the PCI hardware. On powerpc, the slot is
+isolated, in that all I/O is blocked: all reads return 0xffffffff, all
+writes are ignored.
+
+STEP 1: Remove devices
+---------------------
+Platform removes the devices depending on the error agent, it could be
+this port for all subordinates or upstream component (likely downstream
+port)
+
+STEP 2: Reset link
+---------------------
+The platform resets the link.  This is a PCI-Express specific step and is
+done whenever a fatal error has been detected that can be "solved" by
+resetting the link.
+
+STEP 3: Re-enumerate the devices
+---------------------
+Initiates the re-enumeration.
 
 Conclusion; General Remarks
 ---------------------------
diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 0b36b9ebfa4b..d6376cfc8920 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -206,7 +206,7 @@ error_detected(dev, pci_channel_io_frozen) to all drivers within
 a hierarchy in question. Then, performing link reset at upstream is
 necessary. As different kinds of devices might use different approaches
 to reset link, AER port service driver is required to provide the
-function to reset link via callback parameter of pcie_do_recovery()
+function to reset link via callback parameter of pcie_fatal_recovery()
 function. If reset_link is not NULL, recovery function will use it
 to reset the link. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER
 and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index fa12f7cbc1a0..a4a243a607d4 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -555,9 +555,10 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 #endif
 
 /* PCI error reporting and recovery */
-pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			pci_channel_state_t state,
-			pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
+pci_ers_result_t pcie_nonfatal_recovery(struct pci_dev *dev);
+
+pci_ers_result_t pcie_fatal_recovery(struct pci_dev *dev,
+		pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 65dff5f3457a..5dc8caf470bd 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -947,9 +947,9 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 		if (pcie_aer_is_native(dev))
 			pcie_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
-		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
+		pcie_nonfatal_recovery(dev);
 	else if (info->severity == AER_FATAL)
-		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
+		pcie_fatal_recovery(dev, aer_root_reset);
 	pci_dev_put(dev);
 }
 
@@ -985,11 +985,9 @@ static void aer_recover_work_func(struct work_struct *work)
 		}
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
-			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 aer_root_reset);
+			pcie_nonfatal_recovery(pdev);
 		else if (entry.severity == AER_FATAL)
-			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 aer_root_reset);
+			pcie_fatal_recovery(pdev, aer_root_reset);
 		pci_dev_put(pdev);
 	}
 }
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index daa9a4153776..90c6d6f0c3fc 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -233,7 +233,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	dpc_process_error(pdev);
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
+	pcie_fatal_recovery(pdev, dpc_reset_link);
 
 	return IRQ_HANDLED;
 }
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
index a6b9b479b97a..86218ada8fb9 100644
--- a/drivers/pci/pcie/edr.c
+++ b/drivers/pci/pcie/edr.c
@@ -183,7 +183,7 @@ static void edr_handle_event(acpi_handle handle, u32 event, void *data)
 	 * or ERR_NONFATAL, since the link is already down, use the FATAL
 	 * error recovery path for both cases.
 	 */
-	estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
+	estate = pcie_fatal_recovery(edev, dpc_reset_link);
 
 send_ost:
 
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 315a4d559c4c..ce4e409865dc 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -79,11 +79,6 @@ static int report_error_detected(struct pci_dev *dev,
 	return 0;
 }
 
-static int report_frozen_detected(struct pci_dev *dev, void *data)
-{
-	return report_error_detected(dev, pci_channel_io_frozen, data);
-}
-
 static int report_normal_detected(struct pci_dev *dev, void *data)
 {
 	return report_error_detected(dev, pci_channel_io_normal, data);
@@ -146,9 +141,59 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
-			pci_channel_state_t state,
+pci_ers_result_t pcie_fatal_recovery(struct pci_dev *dev,
 			pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
+{
+	struct pci_dev *udev;
+	struct pci_bus *parent;
+	struct pci_dev *pdev, *temp;
+	pci_ers_result_t result;
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE)
+		udev = dev;
+	else
+		udev = dev->bus->self;
+
+	parent = udev->subordinate;
+	pci_walk_bus(parent, pci_dev_set_disconnected, NULL);
+
+	pci_lock_rescan_remove();
+	pci_dev_get(dev);
+	list_for_each_entry_safe_reverse(pdev, temp, &parent->devices,
+					 bus_list) {
+		pci_stop_and_remove_bus_device(pdev);
+	}
+
+	result = reset_link(udev);
+
+	if (dev->hdr_type == PCI_HEADER_TYPE_BRIDGE) {
+		/*
+		 * If the error is reported by a bridge, we think this error
+		 * is related to the downstream link of the bridge, so we
+		 * do error recovery on all subordinates of the bridge instead
+		 * of the bridge and clear the error status of the bridge.
+		 */
+		pci_aer_clear_fatal_status(dev);
+		if (pcie_aer_is_native(dev))
+			pcie_clear_device_status(dev);
+	}
+
+	if (result == PCI_ERS_RESULT_RECOVERED) {
+		if (pcie_wait_for_link(udev, true))
+			pci_rescan_bus(udev->bus);
+		pci_info(dev, "Device recovery from fatal error successful\n");
+	} else {
+		pci_uevent_ers(dev, PCI_ERS_RESULT_DISCONNECT);
+		pci_info(dev, "Device recovery from fatal error failed\n");
+	}
+
+	pci_dev_put(dev);
+	pci_unlock_rescan_remove();
+
+	return result;
+}
+
+pci_ers_result_t pcie_nonfatal_recovery(struct pci_dev *dev)
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -164,16 +209,7 @@ pci_ers_result_t pcie_do_recovery(struct pci_dev *dev,
 	bus = dev->subordinate;
 
 	pci_dbg(dev, "broadcast error_detected message\n");
-	if (state == pci_channel_io_frozen) {
-		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev);
-		if (status != PCI_ERS_RESULT_RECOVERED) {
-			pci_warn(dev, "link reset failed\n");
-			goto failed;
-		}
-	} else {
-		pci_walk_bus(bus, report_normal_detected, &status);
-	}
+	pci_walk_bus(bus, report_normal_detected, &status);
 
 	if (status == PCI_ERS_RESULT_CAN_RECOVER) {
 		status = PCI_ERS_RESULT_RECOVERED;
-- 
2.17.1

