Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id B4B141E518
	for <lists+linux-pci@lfdr.de>; Wed, 15 May 2019 00:21:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726857AbfENWVN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 14 May 2019 18:21:13 -0400
Received: from mga03.intel.com ([134.134.136.65]:20403 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726777AbfENWVE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 14 May 2019 18:21:04 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 May 2019 15:21:03 -0700
X-ExtLoop1: 1
Received: from skuppusw-desk.jf.intel.com ([10.54.74.33])
  by fmsmga007.fm.intel.com with ESMTP; 14 May 2019 15:21:02 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, keith.busch@intel.com,
        sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v3 4/5] PCI/DPC: Add Error Disconnect Recover (EDR) support
Date:   Tue, 14 May 2019 15:18:16 -0700
Message-Id: <7c2cadb48f690bf4994063623b4a093a87257f93.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1557870869.git.sathyanarayanan.kuppuswamy@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

As per PCI firmware specification v3.2 ECN
(https://members.pcisig.com/wg/PCI-SIG/document/12614), when firmware
owns Downstream Port Containment (DPC), its expected to use the "Error
Disconnect Recover" (EDR) notification to alert OSPM of a DPC event and
if OS supports EDR, its expected to handle the software state invalidation
and port recovery in OS and let firmware know the recovery status via _OST
ACPI call.

Since EDR is a hybrid service, DPC service shall be enabled in OS even
if AER is not natively enabled in OS.

Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
---
 drivers/pci/pcie/Kconfig        |  10 ++
 drivers/pci/pcie/dpc.c          | 206 ++++++++++++++++++++++++++++++++
 drivers/pci/pcie/portdrv_core.c |   9 +-
 3 files changed, 223 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/pcie/Kconfig b/drivers/pci/pcie/Kconfig
index 362eb8cfa53b..9a05015af7cd 100644
--- a/drivers/pci/pcie/Kconfig
+++ b/drivers/pci/pcie/Kconfig
@@ -150,3 +150,13 @@ config PCIE_BW
 	  This enables PCI Express Bandwidth Change Notification.  If
 	  you know link width or rate changes occur only to correct
 	  unreliable links, you may answer Y.
+
+config PCIE_EDR
+	bool "PCI Express Error Disconnect Recover support"
+	default n
+	depends on PCIE_DPC && ACPI
+	help
+	  This options adds Error Disconnect Recover support as specified
+	  in PCI firmware specification v3.2 Downstream Port Containment
+	  Related Enhancements ECN. Enable this if you want to support hybrid
+	  DPC model which uses both firmware and OS to implement DPC.
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 95810b4b0adc..131fadd29ae2 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -11,6 +11,7 @@
 #include <linux/interrupt.h>
 #include <linux/init.h>
 #include <linux/pci.h>
+#include <linux/acpi.h>
 
 #include "portdrv.h"
 #include "../pci.h"
@@ -22,8 +23,22 @@ struct dpc_dev {
 	u8			rp_log_size;
 	/* Set True if DPC is handled in firmware */
 	bool			firmware_dpc;
+	pci_ers_result_t	error_state;
+#ifdef CONFIG_ACPI
+	struct acpi_device	*adev;
+#endif
 };
 
+#ifdef CONFIG_ACPI
+
+#define EDR_PORT_ENABLE_DSM     0x0C
+#define EDR_PORT_LOCATE_DSM     0x0D
+
+static const guid_t pci_acpi_dsm_guid =
+		GUID_INIT(0xe5c937d0, 0x3553, 0x4d7a,
+			  0x91, 0x17, 0xea, 0x4d, 0x19, 0xc3, 0x43, 0x4d);
+#endif
+
 static const char * const rp_pio_error_string[] = {
 	"Configuration Request received UR Completion",	 /* Bit Position 0  */
 	"Configuration Request received CA Completion",	 /* Bit Position 1  */
@@ -297,6 +312,167 @@ static irqreturn_t dpc_irq(int irq, void *context)
 	return IRQ_HANDLED;
 }
 
+static void dpc_error_resume(struct pci_dev *dev)
+{
+	struct dpc_dev *dpc = to_dpc_dev(dev);
+
+	dpc->error_state = PCI_ERS_RESULT_RECOVERED;
+}
+
+#ifdef CONFIG_ACPI
+
+/*
+ * _DSM wrapper function to enable/disable DPC port.
+ * @dpc   : DPC device structure
+ * @enable: status of DPC port (0 or 1).
+ *
+ * returns 0 on success or errno on failure.
+ */
+static int acpi_enable_dpc_port(struct dpc_dev *dpc, bool enable)
+{
+	union acpi_object *obj;
+	int status;
+	union acpi_object argv4;
+	struct pci_dev *pdev = dpc->dev->port;
+
+	dev_dbg(&pdev->dev, "Enable DPC port, value:%d\n", enable);
+
+	argv4.type = ACPI_TYPE_INTEGER;
+	argv4.integer.value = enable;
+
+	obj = acpi_evaluate_dsm(dpc->adev->handle, &pci_acpi_dsm_guid, 1,
+				EDR_PORT_ENABLE_DSM, &argv4);
+	if (!obj)
+		return -EIO;
+
+	if (obj->type == ACPI_TYPE_INTEGER && obj->integer.value == enable)
+		status = 0;
+	else
+		status = -EIO;
+
+	ACPI_FREE(obj);
+
+	return status;
+}
+
+/*
+ * _DSM wrapper function to locate DPC port.
+ * @dpc   : DPC device structure
+ *
+ * returns pci_dev.
+ */
+static struct pci_dev *acpi_locate_dpc_port(struct dpc_dev *dpc)
+{
+	union acpi_object *obj;
+	u16 port;
+	struct pci_dev *pdev = dpc->dev->port;
+
+	dev_dbg(&pdev->dev, "Locate DPC port\n");
+
+	obj = acpi_evaluate_dsm(dpc->adev->handle, &pci_acpi_dsm_guid, 1,
+				EDR_PORT_LOCATE_DSM, NULL);
+	if (!obj)
+		return dpc->dev->port;
+
+	if (obj->type == ACPI_TYPE_INTEGER) {
+		/*
+		 * Firmware returns DPC port BDF details in following format:
+		 *	15:8 = bus
+		 *	7:3 = device
+		 *	2:0 = function
+		 */
+		port = obj->integer.value;
+		ACPI_FREE(obj);
+	} else {
+		ACPI_FREE(obj);
+		return dpc->dev->port;
+	}
+
+	return pci_get_domain_bus_and_slot(0, PCI_BUS_NUM(port), port & 0xff);
+}
+
+/*
+ * _OST wrapper function to let firmware know the status of EDR event.
+ * @dpc   : DPC device structure.
+ * @status: Status of EDR event.
+ */
+static int acpi_send_edr_status(struct dpc_dev *dpc,  u16 status)
+{
+	u32 ost_status;
+	struct pci_dev *pdev = dpc->dev->port;
+
+	dev_dbg(&pdev->dev, "Sending EDR status :%x\n", status);
+
+	ost_status =  PCI_DEVID(pdev->bus->number, pdev->devfn);
+	ost_status = (ost_status << 16) | status;
+
+	status = acpi_evaluate_ost(dpc->adev->handle,
+				   ACPI_NOTIFY_DISCONNECT_RECOVER,
+				   ost_status, NULL);
+	if (ACPI_FAILURE(status))
+		return -EINVAL;
+
+	return 0;
+}
+
+static void edr_handle_event(acpi_handle handle, u32 event, void *data)
+{
+	struct dpc_dev *dpc = (struct dpc_dev *) data;
+	struct pci_dev *pdev = dpc->dev->port;
+	u16 status, cap;
+
+	dev_info(&pdev->dev, "ACPI event %x received\n", event);
+
+	if (event != ACPI_NOTIFY_DISCONNECT_RECOVER)
+		return;
+
+	dev_info(&pdev->dev, "Valid EDR event received\n");
+
+	/*
+	 * Check if _DSM(0xD) is available, and if present locate the
+	 * port which issued EDR event.
+	 */
+	pdev = acpi_locate_dpc_port(dpc);
+	if (!pdev) {
+		pdev = dpc->dev->port;
+		dev_err(&pdev->dev, "No valid port found\n");
+		return;
+	}
+
+	dpc = to_dpc_dev(pdev);
+	dpc->error_state = PCI_ERS_RESULT_DISCONNECT;
+	cap = dpc->cap_pos;
+
+	/*
+	 * Check if the port supports DPC:
+	 *
+	 * If port supports DPC, then fall back to default error
+	 * recovery.
+	 */
+	if (cap) {
+		/* Check if there is a valid DPC trigger */
+		pci_read_config_word(pdev, cap + PCI_EXP_DPC_STATUS, &status);
+		if (!(status & PCI_EXP_DPC_STATUS_TRIGGER)) {
+			dev_err(&pdev->dev, "Invalid DPC trigger %x\n", status);
+			return;
+		}
+		dpc_process_error(dpc);
+	}
+
+	/*
+	 * If recovery is successful, send _OST(0xF, BDF << 16 | 0x80)
+	 * to firmware. If not successful, send _OST(0xF, BDF << 16 | 0x81).
+	 */
+	if (dpc->error_state == PCI_ERS_RESULT_RECOVERED)
+		status = 0x80;
+	else
+		status = 0x81;
+
+	acpi_send_edr_status(dpc, status);
+}
+
+#endif
+
 #define FLAG(x, y) (((x) & (y)) ? '+' : '-')
 static int dpc_probe(struct pcie_device *dev)
 {
@@ -305,6 +481,10 @@ static int dpc_probe(struct pcie_device *dev)
 	struct device *device = &dev->device;
 	int status;
 	u16 ctl, cap;
+#ifdef CONFIG_ACPI
+	struct acpi_device *adev = ACPI_COMPANION(&pdev->dev);
+	acpi_status astatus;
+#endif
 
 	dpc = devm_kzalloc(device, sizeof(*dpc), GFP_KERNEL);
 	if (!dpc)
@@ -313,6 +493,7 @@ static int dpc_probe(struct pcie_device *dev)
 	dpc->cap_pos = pci_find_ext_capability(pdev, PCI_EXT_CAP_ID_DPC);
 	dpc->dev = dev;
 	set_service_data(dev, dpc);
+	dpc->error_state = PCI_ERS_RESULT_NONE;
 
 	if (pcie_aer_get_firmware_first(pdev))
 		dpc->firmware_dpc = 1;
@@ -335,6 +516,30 @@ static int dpc_probe(struct pcie_device *dev)
 		}
 	}
 
+#ifdef CONFIG_ACPI
+	if (dpc->firmware_dpc) {
+		if (!adev) {
+			dev_err(device, "No valid ACPI device found\n");
+			return -ENODEV;
+		}
+
+		dpc->adev = adev;
+
+		/* Register notifier for ACPI_SYSTEM_NOTIFY events */
+		astatus = acpi_install_notify_handler(adev->handle,
+						      ACPI_SYSTEM_NOTIFY,
+						      edr_handle_event,
+						      dpc);
+
+		if (ACPI_FAILURE(astatus)) {
+			dev_err(device,
+				"Install ACPI_SYSTEM_NOTIFY handler failed\n");
+			return -EBUSY;
+		}
+
+		acpi_enable_dpc_port(dpc, true);
+	}
+#endif
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CAP, &cap);
 	pci_read_config_word(pdev, dpc->cap_pos + PCI_EXP_DPC_CTL, &ctl);
 
@@ -385,6 +590,7 @@ static struct pcie_port_service_driver dpcdriver = {
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
 	.reset_link	= dpc_reset_link,
+	.error_resume   = dpc_error_resume,
 };
 
 int __init pcie_dpc_init(void)
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 0a59ac574be1..1b54a39df795 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -250,9 +250,14 @@ static int get_port_device_capability(struct pci_dev *dev)
 		pcie_pme_interrupt_enable(dev, false);
 	}
 
+	/*
+	 * If EDR support is enabled in OS, then even if AER is not handled in
+	 * OS, DPC service can be enabled.
+	 */
 	if (pci_find_ext_capability(dev, PCI_EXT_CAP_ID_DPC) &&
-	    pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
-	    (pcie_ports_native || host->native_dpc))
+	    ((IS_ENABLED(CONFIG_PCIE_EDR) && !host->native_dpc) ||
+	    (pci_aer_available() && services & PCIE_PORT_SERVICE_AER &&
+	    (pcie_ports_native || host->native_dpc))))
 		services |= PCIE_PORT_SERVICE_DPC;
 
 	if (pci_pcie_type(dev) == PCI_EXP_TYPE_DOWNSTREAM ||
-- 
2.20.1

