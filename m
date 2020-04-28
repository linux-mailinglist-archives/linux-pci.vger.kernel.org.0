Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B0271BB2F5
	for <lists+linux-pci@lfdr.de>; Tue, 28 Apr 2020 02:33:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726282AbgD1Acu (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Apr 2020 20:32:50 -0400
Received: from mga14.intel.com ([192.55.52.115]:59646 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726257AbgD1Acu (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 27 Apr 2020 20:32:50 -0400
IronPort-SDR: t5lbXe2wPNkEx/Ok4eLR5uJKOXDOi19SLvfuei1shi8b2Hs3jKID2tCTpGauAALjvQ2hj1nLGH
 zt02tQMj0LwA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Apr 2020 17:32:50 -0700
IronPort-SDR: 34+iHEPkybRq6Oeh47PcPNcKJ8fWXXno08aPz344bOPHq5SVrhIh3DMLCn6PJmSUzsfjGxRxp6
 5ZUEZjy9VZXA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,325,1583222400"; 
   d="scan'208";a="336470353"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 27 Apr 2020 17:32:49 -0700
Received: from debox1-hc.jf.intel.com (debox1-hc.jf.intel.com [10.54.75.159])
        by linux.intel.com (Postfix) with ESMTP id C1097580820;
        Mon, 27 Apr 2020 17:32:49 -0700 (PDT)
From:   "David E. Box" <david.e.box@linux.intel.com>
To:     rjw@rjwysocki.net, lenb@kernel.org, bhelgaas@google.com,
        kbusch@kernel.org, axboe@fb.com, hch@lst.de, sagi@grimberg.me
Cc:     "David E. Box" <david.e.box@linux.intel.com>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org,
        Dan Williams <dan.j.williams@intel.com>
Subject: [PATCH 1/2] pci: Add ACPI StorageD3Enable _DSD support
Date:   Mon, 27 Apr 2020 17:32:13 -0700
Message-Id: <20200428003214.3764-2-david.e.box@linux.intel.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200428003214.3764-1-david.e.box@linux.intel.com>
References: <20200428003214.3764-1-david.e.box@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

NVMe storage power management during suspend-to-idle, particularly on
laptops, has been inconsistent with some devices working with D3 while
others must rely on NVMe APST in order for power savings to be realized.
Currently the default is to use APST unless quirked to do otherwise.
However newer platforms, like Intel Comet Lake systems, may require NVMe
drives to use D3 in order for the PCIe ports to be properly power managed.
To make it easier for drivers to choose, these platforms may supply a
special "StorageD3Enable" _DSD property under the root port that the device
is attached to. If supplied, the driver must use D3 in order for the
platform to realize the deepest power savings in suspend-to-idle.

Adds support for the _DSD to the pci/acpi layer.

Acked-by: Dan Williams <dan.j.williams@intel.com>
Link: https://docs.microsoft.com/en-us/windows-hardware/design/component-guidelines/power-management-for-storage-hardware-devices-intro
Signed-off-by: David E. Box <david.e.box@linux.intel.com>
---
 drivers/acpi/property.c |  3 +++
 drivers/pci/pci-acpi.c  | 47 +++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       |  6 ++++++
 drivers/pci/pci.h       |  4 ++++
 include/linux/pci.h     |  1 +
 5 files changed, 61 insertions(+)

diff --git a/drivers/acpi/property.c b/drivers/acpi/property.c
index e601c4511a8b..f09375ab40e4 100644
--- a/drivers/acpi/property.c
+++ b/drivers/acpi/property.c
@@ -45,6 +45,9 @@ static const guid_t prp_guids[] = {
 	/* Thunderbolt GUID for WAKE_SUPPORTED: 6c501103-c189-4296-ba72-9bf5a26ebe5d */
 	GUID_INIT(0x6c501103, 0xc189, 0x4296,
 		  0xba, 0x72, 0x9b, 0xf5, 0xa2, 0x6e, 0xbe, 0x5d),
+	/* D3 Support for storage devivce: 5025030f-842f-4ab4-a561-99a5189762d0 */
+	GUID_INIT(0x5025030f, 0x842f, 0x4ab4,
+		  0xa5, 0x61, 0x99, 0xa5, 0x18, 0x97, 0x62, 0xd0),
 };
 
 /* ACPI _DSD data subnodes GUID: dbb8e3e6-5886-4ba6-8795-1319f52a966b */
diff --git a/drivers/pci/pci-acpi.c b/drivers/pci/pci-acpi.c
index d21969fba6ab..5df249ebf022 100644
--- a/drivers/pci/pci-acpi.c
+++ b/drivers/pci/pci-acpi.c
@@ -972,6 +972,52 @@ static bool acpi_pci_bridge_d3(struct pci_dev *dev)
 	return val == 1;
 }
 
+static bool acpi_pci_storage_d3(struct pci_dev *dev)
+{
+	const struct fwnode_handle *fwnode;
+	struct acpi_device *adev;
+	struct pci_dev *root;
+	acpi_handle handle;
+	acpi_status status;
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
+	if (root == dev) {
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
+		return val == 1;
+
+	return false;
+}
+
 static bool acpi_pci_power_manageable(struct pci_dev *dev)
 {
 	struct acpi_device *adev = ACPI_COMPANION(&dev->dev);
@@ -1100,6 +1146,7 @@ static bool acpi_pci_need_resume(struct pci_dev *dev)
 
 static const struct pci_platform_pm_ops acpi_pci_platform_pm = {
 	.bridge_d3 = acpi_pci_bridge_d3,
+	.storage_d3 = acpi_pci_storage_d3,
 	.is_manageable = acpi_pci_power_manageable,
 	.set_state = acpi_pci_set_power_state,
 	.get_state = acpi_pci_get_power_state,
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index 595fcf59843f..217d89f31e8b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -871,6 +871,11 @@ static inline bool platform_pci_bridge_d3(struct pci_dev *dev)
 	return pci_platform_pm ? pci_platform_pm->bridge_d3(dev) : false;
 }
 
+static inline bool platform_pci_storage_d3(struct pci_dev *dev)
+{
+	return pci_platform_pm->storage_d3(dev);
+}
+
 /**
  * pci_raw_set_power_state - Use PCI PM registers to set the power state of
  *			     given PCI device
@@ -2903,6 +2908,7 @@ void pci_pm_init(struct pci_dev *dev)
 	dev->d3_delay = PCI_PM_D3_WAIT;
 	dev->d3cold_delay = PCI_PM_D3COLD_WAIT;
 	dev->bridge_d3 = pci_bridge_d3_possible(dev);
+	dev->storage_d3 = platform_pci_storage_d3(dev);
 	dev->d3cold_allowed = true;
 
 	dev->d1_support = false;
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 6d3f75867106..4dc4d05da810 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -53,6 +53,9 @@ int pci_bus_error_reset(struct pci_dev *dev);
  *
  * @bridge_d3: Does the bridge allow entering into D3
  *
+ * @storage_d3: 'true' if the bridge contains a storage device that must use D3
+ *		to support platform s2idle
+ *
  * @is_manageable: returns 'true' if given device is power manageable by the
  *		   platform firmware
  *
@@ -77,6 +80,7 @@ int pci_bus_error_reset(struct pci_dev *dev);
  */
 struct pci_platform_pm_ops {
 	bool (*bridge_d3)(struct pci_dev *dev);
+	bool (*storage_d3)(struct pci_dev *dev);
 	bool (*is_manageable)(struct pci_dev *dev);
 	int (*set_state)(struct pci_dev *dev, pci_power_t state);
 	pci_power_t (*get_state)(struct pci_dev *dev);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 83ce1cdf5676..cbba1555020b 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -346,6 +346,7 @@ struct pci_dev {
 	unsigned int	no_d1d2:1;	/* D1 and D2 are forbidden */
 	unsigned int	no_d3cold:1;	/* D3cold is forbidden */
 	unsigned int	bridge_d3:1;	/* Allow D3 for bridge */
+	unsigned int	storage_d3:1;	/* Storage dev must use D3 for s2idle */
 	unsigned int	d3cold_allowed:1;	/* D3cold is allowed by user */
 	unsigned int	mmio_always_on:1;	/* Disallow turning off io/mem
 						   decoding during BAR sizing */
-- 
2.20.1

