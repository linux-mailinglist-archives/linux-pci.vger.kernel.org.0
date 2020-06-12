Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BC9611F7E33
	for <lists+linux-pci@lfdr.de>; Fri, 12 Jun 2020 22:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726372AbgFLUsR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Jun 2020 16:48:17 -0400
Received: from mga18.intel.com ([134.134.136.126]:65310 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726268AbgFLUsR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Jun 2020 16:48:17 -0400
IronPort-SDR: /AMq4vIQzi9x+yFRB0xvCw+2uMzbdjv32tZNHVO/FNrRD9hr/sv+WwBvo5YK2M/S98CvRFSAS4
 Esp0RiNvz2KQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jun 2020 13:48:15 -0700
IronPort-SDR: 4NjQm8C+pO5dahmYLr9aLSNxsQI3iPrulmY0iZIV1TRQ+RfaIf8wugJooB1goa9bH+hO+N2gkq
 l4xr+WQwfPhw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,504,1583222400"; 
   d="scan'208";a="448426985"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga005.jf.intel.com with ESMTP; 12 Jun 2020 13:48:14 -0700
Received: from debox1-desk2.jf.intel.com (debox1-desk2.jf.intel.com [10.54.75.16])
        by linux.intel.com (Postfix) with ESMTP id DE0F95803C5;
        Fri, 12 Jun 2020 13:48:14 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     shyjumon.n@intel.com, rjw@rjwysocki.net, lenb@kernel.org,
        bhelgaas@google.com, dan.j.williams@intel.com, kbusch@kernel.org,
        axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-nvme@lists.infradead.org
Subject: [PATCH V2 1/2] PCI: Add ACPI StorageD3Enable _DSD support
Date:   Fri, 12 Jun 2020 13:48:19 -0700
Message-Id: <20200612204820.20111-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

StorageD3Enable is a boolean property that indicates that the platform
wants to use D3 for PCIe storage drives during suspend-to-idle. It is a
BIOS work around that is currently in use on shipping systems like some
Intel Comet Lake platforms. It is meant to change default driver policy for
suspend that may cause higher power consumption.

Add the DSD property for recognition by fwnode calls and provide an
exported symbol for device drivers to use to read the property as needed.

Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 59 +++++++++++++++++++++++++++++++++++++++++
 include/linux/pci.h     |  2 ++
 3 files changed, 64 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e601c4511a8b..c2e2ae774a19 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
 	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
 	GUID_INIT(0x6c501103, 0xc189, 0x4296,
 		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
+	/* Storage device needs D3 GUID: 5025030f-842f-4ab4-a561-99a5189762d0 */
+	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
+		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d21969fba6ab..732df524e09c 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -972,6 +972,65 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return val == 1;
 }
 
+/**
+ * pci_acpi_storage_d3 - whether root port requests D3 for idle suspend
+ * @pdev: PCI device to check
+ *
+ * Returns true if the ACPI companion device contains the "StorageD3Enable"
+ * _DSD property and the value is 1. This indicates that the root port is
+ * used by a storage device and the platform is requesting D3 for the
+ * device during suspend to idle in order to support platform pm.
+ */
+bool pci_acpi_storage_d3(struct pci_dev *dev)
+{
+	const struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	struct pci_dev *root;
+	acpi_handle handle;
+	acpi_status status;
+	bool ret = false;
+	u8 val;
+
+	/*
+	 * Look for _DSD property specifying that the storage device on
+	 * the port must use D3 to support deep platform power savings during
+	 * suspend-to-idle
+	 */
+	root = pci_find_pcie_root_port(dev);
+	if (!root)
+		return false;
+
+	adev = ACPI_COMPANION(&root->dev);
+	if (!adev) {
+		/*
+		 * It is possible that the ACPI companion is not yet bound
+		 * for the root port so look it up manually here.
+		 */
+		if (!adev && !pci_dev_is_added(root))
+			adev = acpi_pci_find_companion(&root->dev);
+	}
+
+	if (!adev)
+		return false;
+
+	status = acpi_get_handle(adev->handle, "PXSX", &handle);
+	if (ACPI_FAILURE(status))
+		return false;
+
+	adev = acpi_bus_get_acpi_device(handle);
+	if (!adev)
+		return false;
+
+	fwnode = acpi_fwnode_handle(adev);
+	if (!fwnode_property_read_u8(fwnode, "StorageD3Enable", &val))
+		ret = (val == 1);
+
+	acpi_bus_put_acpi_device(adev);
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(pci_acpi_storage_d3);
+
 static bool acpi_pci_power_manageable(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..396fcb269a60 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2318,10 +2318,12 @@ struct irq_domain *pci_host_bridge_acpi_msi_domain(struct pci_bus *bus);
 void
 pci_msi_register_fwnode_provider(struct fwnode_handle *(*fn)(struct device *));
 bool pci_pr3_present(struct pci_dev *pdev);
+bool pci_acpi_storage_d3(struct pci_dev *dev);
 #else
 static inline struct irq_domain *
 pci_host_bridge_acpi_msi_domain(struct pci_bus *bus) { return NULL; }
 static inline bool pci_pr3_present(struct pci_dev *pdev) { return false; }
+static inline bool pci_acpi_storage_d3(struct pci_dev *dev) { return false; }
 #endif
 
 #ifdef CONFIG_EEH
-- 
2.20.1

