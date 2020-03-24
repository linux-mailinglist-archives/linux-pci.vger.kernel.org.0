Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id AC02F1902DB
	for <lists+linux-pci@lfdr.de>; Tue, 24 Mar 2020 01:28:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727719AbgCXA0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Mar 2020 20:26:25 -0400
Received: from mga14.intel.com ([192.55.52.115]:60461 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727705AbgCXA0Y (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 23 Mar 2020 20:26:24 -0400
IronPort-SDR: fbZLikA6y2mXn087BqiIPjUr2xq1wC07P5WQBGgn8KYkSe7ya06DFXnxCzcSSnx1bzxXWyVgax
 8uDDH25Z4gjA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Mar 2020 17:26:24 -0700
IronPort-SDR: Gf1xyP4qnBd1hZFsZA40HGh+tHQKx+bVIZC+469jSVe9bkMR1hxap+O6Ct2EkoDF0peEKoLOij
 uBHnq8Jam25A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,298,1580803200"; 
   d="scan'208";a="419692240"
Received: from bhaveshm-mobl.amr.corp.intel.com (HELO localhost.localdomain) ([10.134.88.197])
  by orsmga005.jf.intel.com with ESMTP; 23 Mar 2020 17:26:22 -0700
From:   sathyanarayanan.kuppuswamy@linux.intel.com
To:     bhelgaas@google.com
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        ashok.raj@intel.com, sathyanarayanan.kuppuswamy@linux.intel.com
Subject: [PATCH v18 05/11] PCI/ERR: Remove service dependency in pcie_do_recovery()
Date:   Mon, 23 Mar 2020 17:26:02 -0700
Message-Id: <60e02b87b526cdf2930400059d98704bf0a147d1.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
References: <cover.1585000084.git.sathyanarayanan.kuppuswamy@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>

Previously we passed the PCIe service type parameter to pcie_do_recovery(),
where reset_link() looked up the underlying pci_port_service_driver and its
.reset_link() function pointer. Instead of using this roundabout way, we
can just pass the driver-specific .reset_link() callback function when
calling pcie_do_recovery() function.

This allows us to call pcie_do_recovery() from code that is not a PCIe port
service driver, e.g., Error Disconnect Recover (EDR) support.

Remove pcie_port_find_service() and pcie_port_service_driver.reset_link
since they are now unused.

Link: https://lore.kernel.org/r/152c530a3ca8780ae85c2325f97f5f35f5d3602f.1583286655.git.sathyanarayanan.kuppuswamy@linux.intel.com
Signed-off-by: Kuppuswamy Sathyanarayanan <sathyanarayanan.kuppuswamy@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 Documentation/PCI/pcieaer-howto.rst | 19 +++-------
 drivers/pci/pci.h                   |  2 +-
 drivers/pci/pcie/aer.c              | 12 +++----
 drivers/pci/pcie/dpc.c              |  3 +-
 drivers/pci/pcie/err.c              | 54 +++++------------------------
 drivers/pci/pcie/portdrv.h          |  5 ---
 drivers/pci/pcie/portdrv_core.c     | 21 -----------
 7 files changed, 19 insertions(+), 97 deletions(-)

diff --git a/Documentation/PCI/pcieaer-howto.rst b/Documentation/PCI/pcieaer-howto.rst
index 18bdefaafd1a..afbd8c1c321d 100644
--- a/Documentation/PCI/pcieaer-howto.rst
+++ b/Documentation/PCI/pcieaer-howto.rst
@@ -156,12 +156,6 @@ default reset_link function, but different upstream ports might
 have different specifications to reset pci express link, so all
 upstream ports should provide their own reset_link functions.
 
-In struct pcie_port_service_driver, a new pointer, reset_link, is
-added.
-::
-
-	pci_ers_result_t (*reset_link) (struct pci_dev *dev);
-
 Section 3.2.2.2 provides more detailed info on when to call
 reset_link.
 
@@ -212,15 +206,10 @@ error_detected(dev, pci_channel_io_frozen) to all drivers within
 a hierarchy in question. Then, performing link reset at upstream is
 necessary. As different kinds of devices might use different approaches
 to reset link, AER port service driver is required to provide the
-function to reset link. Firstly, kernel looks for if the upstream
-component has an aer driver. If it has, kernel uses the reset_link
-callback of the aer driver. If the upstream component has no aer driver
-and the port is downstream port, we will perform a hot reset as the
-default by setting the Secondary Bus Reset bit of the Bridge Control
-register associated with the downstream port. As for upstream ports,
-they should provide their own aer service drivers with reset_link
-function. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER and
-reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
+function to reset link via callback parameter of pcie_do_recovery()
+function. If reset_link is not NULL, recovery function will use it
+to reset the link. If error_detected returns PCI_ERS_RESULT_CAN_RECOVER
+and reset_link returns PCI_ERS_RESULT_RECOVERED, the error handling goes
 to mmio_enabled.
 
 helper functions
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6394e7746fb5..3e5efb83e9a2 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -548,7 +548,7 @@ static inline int pci_dev_specific_disable_acs_redir(struct pci_dev *dev)
 
 /* PCI error reporting and recovery */
 void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
-		      u32 service);
+		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev));
 
 bool pcie_wait_for_link(struct pci_dev *pdev, bool active);
 #ifdef CONFIG_PCIEASPM
diff --git a/drivers/pci/pcie/aer.c b/drivers/pci/pcie/aer.c
index 4a818b07a1af..c0540c3761dc 100644
--- a/drivers/pci/pcie/aer.c
+++ b/drivers/pci/pcie/aer.c
@@ -102,6 +102,7 @@ struct aer_stats {
 #define ERR_UNCOR_ID(d)			(d >> 16)
 
 static int pcie_aer_disable;
+static pci_ers_result_t aer_root_reset(struct pci_dev *dev);
 
 void pci_no_aer(void)
 {
@@ -1053,11 +1054,9 @@ static void handle_error_source(struct pci_dev *dev, struct aer_err_info *info)
 					info->status);
 		pci_aer_clear_device_status(dev);
 	} else if (info->severity == AER_NONFATAL)
-		pcie_do_recovery(dev, pci_channel_io_normal,
-				 PCIE_PORT_SERVICE_AER);
+		pcie_do_recovery(dev, pci_channel_io_normal, aer_root_reset);
 	else if (info->severity == AER_FATAL)
-		pcie_do_recovery(dev, pci_channel_io_frozen,
-				 PCIE_PORT_SERVICE_AER);
+		pcie_do_recovery(dev, pci_channel_io_frozen, aer_root_reset);
 	pci_dev_put(dev);
 }
 
@@ -1094,10 +1093,10 @@ static void aer_recover_work_func(struct work_struct *work)
 		cper_print_aer(pdev, entry.severity, entry.regs);
 		if (entry.severity == AER_NONFATAL)
 			pcie_do_recovery(pdev, pci_channel_io_normal,
-					 PCIE_PORT_SERVICE_AER);
+					 aer_root_reset);
 		else if (entry.severity == AER_FATAL)
 			pcie_do_recovery(pdev, pci_channel_io_frozen,
-					 PCIE_PORT_SERVICE_AER);
+					 aer_root_reset);
 		pci_dev_put(pdev);
 	}
 }
@@ -1501,7 +1500,6 @@ static struct pcie_port_service_driver aerdriver = {
 
 	.probe		= aer_probe,
 	.remove		= aer_remove,
-	.reset_link	= aer_root_reset,
 };
 
 /**
diff --git a/drivers/pci/pcie/dpc.c b/drivers/pci/pcie/dpc.c
index 5c2e9d45a269..0c45133a9a91 100644
--- a/drivers/pci/pcie/dpc.c
+++ b/drivers/pci/pcie/dpc.c
@@ -235,7 +235,7 @@ static irqreturn_t dpc_handler(int irq, void *context)
 	}
 
 	/* We configure DPC so it only triggers on ERR_FATAL */
-	pcie_do_recovery(pdev, pci_channel_io_frozen, PCIE_PORT_SERVICE_DPC);
+	pcie_do_recovery(pdev, pci_channel_io_frozen, dpc_reset_link);
 
 	return IRQ_HANDLED;
 }
@@ -321,7 +321,6 @@ static struct pcie_port_service_driver dpcdriver = {
 	.service	= PCIE_PORT_SERVICE_DPC,
 	.probe		= dpc_probe,
 	.remove		= dpc_remove,
-	.reset_link	= dpc_reset_link,
 };
 
 int __init pcie_dpc_init(void)
diff --git a/drivers/pci/pcie/err.c b/drivers/pci/pcie/err.c
index 6e52591a4722..caeb6f5d9970 100644
--- a/drivers/pci/pcie/err.c
+++ b/drivers/pci/pcie/err.c
@@ -146,50 +146,9 @@ static int report_resume(struct pci_dev *dev, void *data)
 	return 0;
 }
 
-/**
- * default_reset_link - default reset function
- * @dev: pointer to pci_dev data structure
- *
- * Invoked when performing link reset on a Downstream Port or a
- * Root Port with no aer driver.
- */
-static pci_ers_result_t default_reset_link(struct pci_dev *dev)
-{
-	int rc;
-
-	rc = pci_bus_error_reset(dev);
-	pci_printk(KERN_DEBUG, dev, "downstream link has been reset\n");
-	return rc ? PCI_ERS_RESULT_DISCONNECT : PCI_ERS_RESULT_RECOVERED;
-}
-
-static pci_ers_result_t reset_link(struct pci_dev *dev, u32 service)
-{
-	pci_ers_result_t status;
-	struct pcie_port_service_driver *driver = NULL;
-
-	driver = pcie_port_find_service(dev, service);
-	if (driver && driver->reset_link) {
-		status = driver->reset_link(dev);
-	} else if (pcie_downstream_port(dev)) {
-		status = default_reset_link(dev);
-	} else {
-		pci_printk(KERN_DEBUG, dev, "no link-reset support at upstream device %s\n",
-			pci_name(dev));
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-
-	if ((status != PCI_ERS_RESULT_RECOVERED) &&
-	    (status != PCI_ERS_RESULT_NEED_RESET)) {
-		pci_printk(KERN_DEBUG, dev, "link reset at upstream device %s failed\n",
-			pci_name(dev));
-		return PCI_ERS_RESULT_DISCONNECT;
-	}
-
-	return status;
-}
-
-void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
-		      u32 service)
+void pcie_do_recovery(struct pci_dev *dev,
+		      enum pci_channel_state state,
+		      pci_ers_result_t (*reset_link)(struct pci_dev *pdev))
 {
 	pci_ers_result_t status = PCI_ERS_RESULT_CAN_RECOVER;
 	struct pci_bus *bus;
@@ -206,9 +165,12 @@ void pcie_do_recovery(struct pci_dev *dev, enum pci_channel_state state,
 	pci_dbg(dev, "broadcast error_detected message\n");
 	if (state == pci_channel_io_frozen) {
 		pci_walk_bus(bus, report_frozen_detected, &status);
-		status = reset_link(dev, service);
-		if (status == PCI_ERS_RESULT_DISCONNECT)
+		status = reset_link(dev);
+		if ((status != PCI_ERS_RESULT_RECOVERED) &&
+		    (status != PCI_ERS_RESULT_NEED_RESET)) {
+			pci_dbg(dev, "link reset at upstream device failed\n");
 			goto failed;
+		}
 	} else {
 		pci_walk_bus(bus, report_normal_detected, &status);
 	}
diff --git a/drivers/pci/pcie/portdrv.h b/drivers/pci/pcie/portdrv.h
index 1e673619b101..64b5e081cdb2 100644
--- a/drivers/pci/pcie/portdrv.h
+++ b/drivers/pci/pcie/portdrv.h
@@ -92,9 +92,6 @@ struct pcie_port_service_driver {
 	/* Device driver may resume normal operations */
 	void (*error_resume)(struct pci_dev *dev);
 
-	/* Link Reset Capability - AER service driver specific */
-	pci_ers_result_t (*reset_link)(struct pci_dev *dev);
-
 	int port_type;  /* Type of the port this driver can handle */
 	u32 service;    /* Port service this device represents */
 
@@ -161,7 +158,5 @@ static inline int pcie_aer_get_firmware_first(struct pci_dev *pci_dev)
 }
 #endif
 
-struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
-							u32 service);
 struct device *pcie_port_find_device(struct pci_dev *dev, u32 service);
 #endif /* _PORTDRV_H_ */
diff --git a/drivers/pci/pcie/portdrv_core.c b/drivers/pci/pcie/portdrv_core.c
index 5075cb9e850c..50a9522ab07d 100644
--- a/drivers/pci/pcie/portdrv_core.c
+++ b/drivers/pci/pcie/portdrv_core.c
@@ -458,27 +458,6 @@ static int find_service_iter(struct device *device, void *data)
 	return 0;
 }
 
-/**
- * pcie_port_find_service - find the service driver
- * @dev: PCI Express port the service is associated with
- * @service: Service to find
- *
- * Find PCI Express port service driver associated with given service
- */
-struct pcie_port_service_driver *pcie_port_find_service(struct pci_dev *dev,
-							u32 service)
-{
-	struct pcie_port_service_driver *drv;
-	struct portdrv_service_data pdrvs;
-
-	pdrvs.drv = NULL;
-	pdrvs.service = service;
-	device_for_each_child(&dev->dev, &pdrvs, find_service_iter);
-
-	drv = pdrvs.drv;
-	return drv;
-}
-
 /**
  * pcie_port_find_device - find the struct device
  * @dev: PCI Express port the service is associated with
-- 
2.17.1

