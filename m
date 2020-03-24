Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 067DF1902E0
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727758AbgCXA02 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:28 -0400
Received: from mga14.intel.com ([192.55.52.115]:60463 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727742AbgCXA01 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:27 -0400
IronPort-SDR: NXPLyKp+Ohj/E8cPzcSy0l0zSxVR/qUygaeISug3L7geAdAxePNgs2rQa9XNad190wZ2Vg4JOP
 RsuhNoIW6c0A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:27 -0700
IronPort-SDR: EGZxa4H8721AOoGwFkPjiIPv9xj1GUTUM/iNdl70P6C4TzhI4DH2GlOrKnNSyTz3eORwrbZEFL
 aSlqr5B/ctew==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692259"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:26 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com,
        Len Brown <lenb@kernel.org>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: [PATCH v18 10/11] PCI/DPC: Add Error Disconnect Recover (EDR) support
Date:   Mon, 23 Mar 2020 17:26:07 -0700
Message-Id: <90f91fe6d25c13f9d2255d2ce97ca15be307e1bb.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Error Disconnect Recover (EDR) is a feature that allows ACPI firmware to
notify OSPM that a device has been disconnected due to an error condition
(ACPI v6.3, sec 5.6.6).  OSPM advertises its support for EDR on PCI devices
via _OSC (see [1], sec 4.5.1, table 4-4).  The OSPM EDR notify handler
should invalidate software state associated with disconnected devices and
may attempt to recover them.  OSPM communicates the status of recovery to
the firmware via _OST (sec 6.3.5.2).

For PCIe, firmware may use Downstream Port Containment (DPC) to support
EDR.  Per [1], sec 4.5.1, table 4-6, even if firmware has retained control
of DPC, OSPM may read/write DPC control and status registers during the EDR
notification processing window, i.e., from the time it receives an EDR
notification until it clears the DPC Trigger Status.

Note that per [1], sec 4.5.1 and 4.5.2.4,

  1. If the OS supports EDR, it should advertise that to firmware by
     setting OSC_PCI_EDR_SUPPORT in _OSC Support.

  2. If the OS sets OSC_PCI_EXPRESS_DPC_CONTROL in _OSC Control to request
     control of the DPC capability, it must also set OSC_PCI_EDR_SUPPORT in
     _OSC Support.

Add an EDR notify handler to attempt recovery.

[1] Downstream Port Containment Related Enhancements ECN, Jan 28, 2019,
    affecting PCI Firmware Specification, Rev. 3.2
    https://members.pcisig.com/wg/PCI-SIG/document/12888
Link: https://lore.kernel.org/r/9ae1d3285beeb81bbf85571a89b8f3d4451eae8f.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Link: https://lore.kernel.org/r/246aa05acca8f0a7e6d20a65ab05af0027f60118.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
[bhelgaas: squash add/enable patches into one]
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Cc: Len Brown <lenb@kernel.org>
Cc: "Rafael J. Wysocki" <rjw@rjwysocki.net>
---
 drivers/acpi/pci_root.c   |  15 +++
 drivers/pci/pci-acpi.c    |   2 +
 drivers/pci/pcie/Kconfig  |  10 ++
 drivers/pci/pcie/Makefile |   1 +
 drivers/pci/pcie/edr.c    | 251 ++++++++++++++++++++++++++++++++++++++
 drivers/pci/probe.c       |   1 +
 include/linux/acpi.h      |   6 +-
 include/linux/pci-acpi.h  |   8 ++
 include/linux/pci.h       |   1 +
 9 files changed, 293 insertions(+), 2 deletions(-)
 create mode 100644 drivers/pci/pcie/edr.c

diff --git a/drivers/acpi/pci_root.c b/drivers/acpi/pci_root.c
index d1e666ef3fcc..0cb9df5462c3 100644
--- a/drivers/acpi/pci_root.c
+++ b/drivers/acpi/pci_root.c
@@ -131,6 +131,7 @@ static struct pci_osc_bit_struct pci_osc_support_bit[] = {
 	{ OSC_PCI_CLOCK_PM_SUPPORT, "ClockPM" },
 	{ OSC_PCI_SEGMENT_GROUPS_SUPPORT, "Segments" },
 	{ OSC_PCI_MSI_SUPPORT, "MSI" },
+	{ OSC_PCI_EDR_SUPPORT, "EDR" },
 	{ OSC_PCI_HPX_TYPE_3_SUPPORT, "HPX-Type3" },
 };
 
@@ -141,6 +142,7 @@ static struct pci_osc_bit_struct pci_osc_control_bit[] = {
 	{ OSC_PCI_EXPRESS_AER_CONTROL, "AER" },
 	{ OSC_PCI_EXPRESS_CAPABILITY_CONTROL, "PCIeCapability" },
 	{ OSC_PCI_EXPRESS_LTR_CONTROL, "LTR" },
+	{ OSC_PCI_EXPRESS_DPC_CONTROL, "DPC" },
 };
 
 static void decode_osc_bits(struct acpi_pci_root *root, char *msg, u32 word,
@@ -440,6 +442,8 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 		support |= OSC_PCI_ASPM_SUPPORT | OSC_PCI_CLOCK_PM_SUPPORT;
 	if (pci_msi_enabled())
 		support |= OSC_PCI_MSI_SUPPORT;
+	if (IS_ENABLED(CONFIG_PCIE_EDR))
+		support |= OSC_PCI_EDR_SUPPORT;
 
 	decode_osc_support(root, "OS supports", support);
 	status = acpi_pci_osc_support(root, support);
@@ -487,6 +491,15 @@ static void negotiate_os_control(struct acpi_pci_root *root, int *no_aspm,
 			control |= OSC_PCI_EXPRESS_AER_CONTROL;
 	}
 
+	/*
+	 * Per the Downstream Port Containment Related Enhancements ECN to
+	 * the PCI Firmware Spec, r3.2, sec 4.5.1, table 4-5,
+	 * OSC_PCI_EXPRESS_DPC_CONTROL indicates the OS supports both DPC
+	 * and EDR.
+	 */
+	if (IS_ENABLED(CONFIG_PCIE_DPC) && IS_ENABLED(CONFIG_PCIE_EDR))
+		control |= OSC_PCI_EXPRESS_DPC_CONTROL;
+
 	requested = control;
 	status = acpi_pci_osc_control_set(handle, &control,
 					  OSC_PCI_EXPRESS_CAPABILITY_CONTROL);
@@ -916,6 +929,8 @@ struct pci_bus *acpi_pci_root_create(struct acpi_pci_root *root,
 		host_bridge->native_pme = 0;
 	if (!(root->osc_control_set & OSC_PCI_EXPRESS_LTR_CONTROL))
 		host_bridge->native_ltr = 0;
+	if (!(root->osc_control_set & OSC_PCI_EXPRESS_DPC_CONTROL))
+		host_bridge->native_dpc = 0;
 
 	/*
 	 * Evaluate the "PCI Boot Configuration" _DSM Function.  If it
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index 1bf8765c41bd..fec50d4af415 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -1203,6 +1203,7 @@ static void pci_acpi_setup(struct device *dev)
 
 	pci_acpi_optimize_delay(pci_dev, adev->handle);
 	pci_acpi_set_untrusted(pci_dev);
+	pci_acpi_add_edr_notifier(pci_dev);
 
 	pci_acpi_add_pm_notifier(adev, pci_dev);
 	if (!adev->wakeup.flags.valid)
@@ -1230,6 +1231,7 @@ static void pci_acpi_cleanup(struct device *dev)
 	if (!adev)
 		return;
 
+	pci_acpi_remove_edr_notifier(pci_dev);
 	pci_acpi_remove_pm_notifier(adev);
 	if (adev->wakeup.flags.valid) {
 		acpi_device_power_remove_dependent(adev, dev);
diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 6e3c04b46fb1..772b1f4cb19e 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -140,3 +140,13 @@ config PCIE_BW
 	  This enables PCI Express Bandwidth Change Notification.  If
 	  you know link width or rate changes occur only to correct
 	  unreliable links, you may answer Y.
+
+config PCIE_EDR
+	bool "PCI Express Error Disconnect Recover support"
+	depends on PCIE_DPC && ACPI
+	help
+	  This option adds Error Disconnect Recover support as specified
+	  in the Downstream Port Containment Related Enhancements ECN to
+	  the PCI Firmware Specification r3.2.  Enable this if you want to
+	  support hybrid DPC model which uses both firmware and OS to
+	  implement DPC.
diff --git a/drivers/pci/pcie/Makefile b/drivers/pci/pcie/Makefile
index efb9d2e71e9e..68da9280ff11 100644
--- a/drivers/pci/pcie/Makefile
+++ b/drivers/pci/pcie/Makefile
@@ -13,3 +13,4 @@ obj-$(CONFIG_PCIE_PME)		+= pme.o
 obj-$(CONFIG_PCIE_DPC)		+= dpc.o
 obj-$(CONFIG_PCIE_PTM)		+= ptm.o
 obj-$(CONFIG_PCIE_BW)		+= bw_notification.o
+obj-$(CONFIG_PCIE_EDR)		+= edr.o
diff --git a/drivers/pci/pcie/edr.c b/drivers/pci/pcie/edr.c
new file mode 100644
index 000000000000..a4378d758599
--- /dev/null
+++ b/drivers/pci/pcie/edr.c
@@ -0,0 +1,251 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * PCI Error Disconnect Recover support
+ * Author: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
+ *
+ * Copyright (C) 2020 Intel Corp.
+ */
+
+#define dev_fmt(fmt) "EDR: " fmt
+
+#include <linux/pci.h>
+#include <linux/pci-acpi.h>
+
+#include "portdrv.h"
+#include "../pci.h"
+
+#define EDR_PORT_DPC_ENABLE_DSM		0x0C
+#define EDR_PORT_LOCATE_DSM		0x0D
+#define EDR_OST_SUCCESS			0x80
+#define EDR_OST_FAILED			0x81
+
+/*
+ * _DSM wrapper function to enable/disable DPC
+ * @pdev   : PCI device structure
+ *
+ * returns 0 on success or errno on failure.
+ */
+static int acpi_enable_dpc(struct pci_dev *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	union acpi_object *obj, argv4, req;
+	int status;
+
+	/*
+	 * Some firmware implementations will return default values for
+	 * unsupported _DSM calls. So checking acpi_evaluate_dsm() return
+	 * value for NULL condition is not a complete method for finding
+	 * whether given _DSM function is supported or not. So use
+	 * explicit func 0 call to find whether given _DSM function is
+	 * supported or not.
+	 */
+        status = acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+				1ULL << EDR_PORT_DPC_ENABLE_DSM);
+        if (!status)
+                return 0;
+
+	status = 0;
+	req.type = ACPI_TYPE_INTEGER;
+	req.integer.value = 1;
+
+	argv4.type = ACPI_TYPE_PACKAGE;
+	argv4.package.count = 1;
+	argv4.package.elements = &req;
+
+	/*
+	 * Per Downstream Port Containment Related Enhancements ECN to PCI
+	 * Firmware Specification r3.2, sec 4.6.12, EDR_PORT_DPC_ENABLE_DSM is
+	 * optional.  Return success if it's not implemented.
+	 */
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+				EDR_PORT_DPC_ENABLE_DSM, &argv4);
+	if (!obj)
+		return 0;
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		pci_err(pdev, FW_BUG "Enable DPC _DSM returned non integer\n");
+		status = -EIO;
+	}
+
+	if (obj->integer.value != 1) {
+		pci_err(pdev, "Enable DPC _DSM failed to enable DPC\n");
+		status = -EIO;
+	}
+
+	ACPI_FREE(obj);
+
+	return status;
+}
+
+/*
+ * _DSM wrapper function to locate DPC port
+ * @pdev   : Device which received EDR event
+ *
+ * Returns pci_dev or NULL.  Caller is responsible for dropping a reference
+ * on the returned pci_dev with pci_dev_put().
+ */
+static struct pci_dev *acpi_dpc_port_get(struct pci_dev *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	union acpi_object *obj;
+	u16 port;
+	bool status;
+
+	/*
+	 * Some firmware implementations will return default values for
+	 * unsupported _DSM calls. So checking acpi_evaluate_dsm() return
+	 * value for NULL condition is not a complete method for finding
+	 * whether given _DSM function is supported or not. So use
+	 * explicit func 0 call to find whether given _DSM function is
+	 * supported or not.
+	 */
+        status = acpi_check_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+				1ULL << EDR_PORT_LOCATE_DSM);
+        if (!status)
+		return pci_dev_get(pdev);
+
+	obj = acpi_evaluate_dsm(adev->handle, &pci_acpi_dsm_guid, 5,
+				EDR_PORT_LOCATE_DSM, NULL);
+	if (!obj)
+		return pci_dev_get(pdev);
+
+	if (obj->type != ACPI_TYPE_INTEGER) {
+		ACPI_FREE(obj);
+		pci_err(pdev, FW_BUG "Locate Port _DSM returned non integer\n");
+		return NULL;
+	}
+
+	/*
+	 * Firmware returns DPC port BDF details in following format:
+	 *	15:8 = bus
+	 *	 7:3 = device
+	 *	 2:0 = function
+	 */
+	port = obj->integer.value;
+
+	ACPI_FREE(obj);
+
+	return pci_get_domain_bus_and_slot(pci_domain_nr(pdev->bus),
+					   PCI_BUS_NUM(port), port & 0xff);
+}
+
+/*
+ * _OST wrapper function to let firmware know the status of EDR event
+ * @pdev   : Device used to send _OST
+ * @edev   : Device which experienced EDR event
+ * @status : Status of EDR event
+ */
+static int acpi_send_edr_status(struct pci_dev *pdev, struct pci_dev *edev,
+				u16 status)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	u32 ost_status;
+
+	pci_dbg(pdev, "Status for %s: %#x\n", pci_name(edev), status);
+
+	ost_status = PCI_DEVID(edev->bus->number, edev->devfn) << 16;
+	ost_status |= status;
+
+	status = acpi_evaluate_ost(adev->handle, ACPI_NOTIFY_DISCONNECT_RECOVER,
+				   ost_status, NULL);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void edr_handle_event(acpi_handle handle, u32 event, void *data)
+{
+	struct pci_dev *pdev = data, *edev;
+	pci_ers_result_t estate = PCI_ERS_RESULT_DISCONNECT;
+	u16 status;
+
+	pci_info(pdev, "ACPI event %#x received\n", event);
+
+	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
+		return;
+
+	/* Locate the port which issued EDR event */
+	edev = acpi_dpc_port_get(pdev);
+	if (!edev) {
+		pci_err(pdev, "Firmware failed to locate DPC port\n");
+		return;
+	}
+
+	pci_dbg(pdev, "Reported EDR dev: %s\n", pci_name(edev));
+
+	/* If port does not support DPC, just send the OST */
+	if (!edev->dpc_cap) {
+		pci_err(edev, FW_BUG "This device doesn't support DPC\n");
+		goto send_ost;
+	}
+
+	/* Check if there is a valid DPC trigger */
+	pci_read_config_word(edev, edev->dpc_cap + PCI_EXP_DPC_STATUS, &status);
+	if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
+		pci_err(edev, "Invalid DPC trigger %#010x\n", status);
+		goto send_ost;
+	}
+
+	dpc_process_error(edev);
+	pci_aer_raw_clear_status(edev);
+
+	/*
+	 * Irrespective of whether the DPC event is triggered by ERR_FATAL
+	 * or ERR_NONFATAL, since the link is already down, use the FATAL
+	 * error recovery path for both cases.
+	 */
+	estate = pcie_do_recovery(edev, pci_channel_io_frozen, dpc_reset_link);
+
+send_ost:
+
+	/*
+	 * If recovery is successful, send _OST(0xF, BDF << 16 | 0x80)
+	 * to firmware. If not successful, send _OST(0xF, BDF << 16 | 0x81).
+	 */
+	if (estate == PCI_ERS_RESULT_RECOVERED) {
+		pci_dbg(edev, "DPC port successfully recovered\n");
+		acpi_send_edr_status(pdev, edev, EDR_OST_SUCCESS);
+	} else {
+		pci_dbg(edev, "DPC port recovery failed\n");
+		acpi_send_edr_status(pdev, edev, EDR_OST_FAILED);
+	}
+
+	pci_dev_put(edev);
+}
+
+void pci_acpi_add_edr_notifier(struct pci_dev *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	acpi_status status;
+
+	if (!adev) {
+		pci_dbg(pdev, "No valid ACPI node, skipping EDR init\n");
+		return;
+	}
+
+	status = acpi_install_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
+					     edr_handle_event, pdev);
+	if (ACPI_FAILURE(status)) {
+		pci_err(pdev, "Failed to install notify handler\n");
+		return;
+	}
+
+	if (acpi_enable_dpc(pdev))
+		acpi_remove_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
+					   edr_handle_event);
+	else
+		pci_dbg(pdev, "Notify handler installed\n");
+}
+
+void pci_acpi_remove_edr_notifier(struct pci_dev *pdev)
+{
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+
+	if (!adev)
+		return;
+
+	acpi_remove_notify_handler(adev->handle, ACPI_SYSTEM_NOTIFY,
+				   edr_handle_event);
+	pci_dbg(pdev, "Notify handler removed\n");
+}
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index c6f91f886818..f67c007edcae 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -598,6 +598,7 @@ static void pci_init_host_bridge(struct pci_host_bridge *bridge)
 	bridge->native_shpc_hotplug = 1;
 	bridge->native_pme = 1;
 	bridge->native_ltr = 1;
+	bridge->native_dpc = 1;
 }
 
 struct pci_host_bridge *pci_alloc_host_bridge(size_t priv)
diff --git a/include/linux/acpi.h b/include/linux/acpi.h
index 0f24d701fbdc..b7d3caf6f205 100644
--- a/include/linux/acpi.h
+++ b/include/linux/acpi.h
@@ -530,8 +530,9 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_CLOCK_PM_SUPPORT		0x00000004
 #define OSC_PCI_SEGMENT_GROUPS_SUPPORT		0x00000008
 #define OSC_PCI_MSI_SUPPORT			0x00000010
+#define OSC_PCI_EDR_SUPPORT			0x00000080
 #define OSC_PCI_HPX_TYPE_3_SUPPORT		0x00000100
-#define OSC_PCI_SUPPORT_MASKS			0x0000011f
+#define OSC_PCI_SUPPORT_MASKS			0x0000019f
 
 /* PCI Host Bridge _OSC: Capabilities DWORD 3: Control Field */
 #define OSC_PCI_EXPRESS_NATIVE_HP_CONTROL	0x00000001
@@ -540,7 +541,8 @@ extern bool osc_pc_lpi_support_confirmed;
 #define OSC_PCI_EXPRESS_AER_CONTROL		0x00000008
 #define OSC_PCI_EXPRESS_CAPABILITY_CONTROL	0x00000010
 #define OSC_PCI_EXPRESS_LTR_CONTROL		0x00000020
-#define OSC_PCI_CONTROL_MASKS			0x0000003f
+#define OSC_PCI_EXPRESS_DPC_CONTROL		0x00000080
+#define OSC_PCI_CONTROL_MASKS			0x000000bf
 
 #define ACPI_GSB_ACCESS_ATTRIB_QUICK		0x00000002
 #define ACPI_GSB_ACCESS_ATTRIB_SEND_RCV         0x00000004
diff --git a/include/linux/pci-acpi.h b/include/linux/pci-acpi.h
index 62b7fdcc661c..2d155bfb8fbf 100644
--- a/include/linux/pci-acpi.h
+++ b/include/linux/pci-acpi.h
@@ -112,6 +112,14 @@ extern const guid_t pci_acpi_dsm_guid;
 #define RESET_DELAY_DSM			0x08
 #define FUNCTION_DELAY_DSM		0x09
 
+#ifdef CONFIG_PCIE_EDR
+void pci_acpi_add_edr_notifier(struct pci_dev *pdev);
+void pci_acpi_remove_edr_notifier(struct pci_dev *pdev);
+#else
+static inline void pci_acpi_add_edr_notifier(struct pci_dev *pdev) { }
+static inline void pci_acpi_remove_edr_notifier(struct pci_dev *pdev) { }
+#endif /* CONFIG_PCIE_EDR */
+
 #else	/* CONFIG_ACPI */
 static inline void acpi_pci_add_bus(struct pci_bus *bus) { }
 static inline void acpi_pci_remove_bus(struct pci_bus *bus) { }
diff --git a/include/linux/pci.h b/include/linux/pci.h
index a0b7e7a53741..7ed7c088c952 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -515,6 +515,7 @@ struct pci_host_bridge {
 	unsigned int	native_shpc_hotplug:1;	/* OS may use SHPC hotplug */
 	unsigned int	native_pme:1;		/* OS may use PCIe PME */
 	unsigned int	native_ltr:1;		/* OS may use PCIe LTR */
+	unsigned int	native_dpc:1;		/* OS may use PCIe DPC */
 	unsigned int	preserve_config:1;	/* Preserve FW resource setup */
 
 	/* Resource alignment requirements */
-- 
2.17.1

