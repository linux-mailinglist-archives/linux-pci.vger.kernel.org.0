Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35BDA249D2E
	for <lists+linux-pci@lfdr.de>; Wed, 19 Aug 2020 14:02:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728344AbgHSMCm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Aug 2020 08:02:42 -0400
Received: from mga17.intel.com ([192.55.52.151]:31808 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728207AbgHSL7X (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Aug 2020 07:59:23 -0400
IronPort-SDR: sllUySao0ywIFGadz6FChHZ5kXMZ1jlEoYJ3CXav293cTSsiOLhp7NguaCLg7rwhDaXo1PINc2
 yeIt0AnqYgqw==
X-IronPort-AV: E=McAfee;i="6000,8403,9717"; a="135160298"
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="135160298"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 04:59:18 -0700
IronPort-SDR: I3mHLQ458sXJ0BmYOldWmReT6cu6jLc8dWFPPmytU/IVfDO5Txqt/4xqIVVqL59Ae4TeKNhd5G
 rbNr1Ov53rHQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,331,1592895600"; 
   d="scan'208";a="336938694"
Received: from black.fi.intel.com ([10.237.72.28])
  by orsmga007.jf.intel.com with ESMTP; 19 Aug 2020 04:59:14 -0700
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id 07C2F7C5; Wed, 19 Aug 2020 14:59:07 +0300 (EEST)
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     linux-usb@vger.kernel.org
Cc:     Michael Jamet <michael.jamet@intel.com>,
        Yehezkel Bernat <YehezkelShB@gmail.com>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Andreas Noever <andreas.noever@gmail.com>,
        Rajmohan Mani <rajmohan.mani@intel.com>,
        Dana Alkattan <dana.alkattan@intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Len Brown <lenb@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-acpi@vger.kernel.org, linux-pci@vger.kernel.org
Subject: [PATCH 18/19] thunderbolt: Create device links from ACPI description
Date:   Wed, 19 Aug 2020 14:59:04 +0300
Message-Id: <20200819115905.59834-19-mika.westerberg@linux.intel.com>
X-Mailer: git-send-email 2.28.0
In-Reply-To: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
References: <20200819115905.59834-1-mika.westerberg@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The new way to describe relationship between tunneled ports and USB4 NHI
(Native Host Interface) is with ACPI _DSD looking like below for a PCIe
downstream port:

    Scope (\_SB.PCI0)
    {
        Device (NHI0) { } // Thunderbolt NHI

        Device (DSB0) // Hotplug downstream port
        {
            Name (_DSD, Package () {
                ToUUID("daffd814-6eba-4d8c-8a91-bc9bbf4aa301"),
                Package () {
                    Package () {"usb4-host-interface", \_SB.PCI0.NHI0},
                    ...
                }
            })
        }
    }

This is "documented" in these [1] USB-IF slides and being used on
systems that ship with Windows.

The _DSD can be added to tunneled USB3 and PCIe ports, and is needed to
make sure the USB4 NHI is resumed before any of the tunneled ports so
the protocol tunnels get established properly before the actual port
itself is resumed. Othwerwise the USB/PCI core find the link may not be
established and starts tearing down the device stack.

This parses the ACPI description each time NHI is probed and tries to
find devices that has the property and it references the NHI in
question. For each matching device a device link from that device to the
NHI is created.

Since USB3 ports themselves do not get runtime suspended with the parent
device (hub) we do not add the link from the USB3 port to USB4 NHI but
instead we add the link from the xHCI device. This makes the device link
usable for runtime PM as well.

[1] https://www.usb.org/sites/default/files/D1T2-2%20-%20USB4%20on%20Windows.pdf

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
---
 drivers/thunderbolt/Makefile |   2 +
 drivers/thunderbolt/acpi.c   | 117 +++++++++++++++++++++++++++++++++++
 drivers/thunderbolt/nhi.c    |   1 +
 drivers/thunderbolt/tb.h     |   6 ++
 4 files changed, 126 insertions(+)
 create mode 100644 drivers/thunderbolt/acpi.c

diff --git a/drivers/thunderbolt/Makefile b/drivers/thunderbolt/Makefile
index 4ab5bfad7bfd..754a529aa132 100644
--- a/drivers/thunderbolt/Makefile
+++ b/drivers/thunderbolt/Makefile
@@ -4,4 +4,6 @@ thunderbolt-objs := nhi.o nhi_ops.o ctl.o tb.o switch.o cap.o path.o tunnel.o ee
 thunderbolt-objs += domain.o dma_port.o icm.o property.o xdomain.o lc.o tmu.o usb4.o
 thunderbolt-objs += nvm.o retimer.o quirks.o
 
+thunderbolt-${CONFIG_ACPI} += acpi.o
+
 obj-${CONFIG_USB4_KUNIT_TEST} += test.o
diff --git a/drivers/thunderbolt/acpi.c b/drivers/thunderbolt/acpi.c
new file mode 100644
index 000000000000..a5f988a9f948
--- /dev/null
+++ b/drivers/thunderbolt/acpi.c
@@ -0,0 +1,117 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * ACPI support
+ *
+ * Copyright (C) 2020, Intel Corporation
+ * Author: Mika Westerberg <mika.westerberg@linux.intel.com>
+ */
+
+#include <linux/acpi.h>
+
+#include "tb.h"
+
+static acpi_status tb_acpi_add_link(acpi_handle handle, u32 level, void *data,
+				    void **return_value)
+{
+	struct fwnode_reference_args args;
+	struct fwnode_handle *fwnode;
+	struct tb_nhi *nhi = data;
+	struct acpi_device *adev;
+	struct pci_dev *pdev;
+	struct device *dev;
+	int ret;
+
+	if (acpi_bus_get_device(handle, &adev))
+		return AE_OK;
+
+	fwnode = acpi_fwnode_handle(adev);
+	ret = fwnode_property_get_reference_args(fwnode, "usb4-host-interface",
+						 NULL, 0, 0, &args);
+	if (ret)
+		return AE_OK;
+
+	/* It needs to reference this NHI */
+	if (nhi->pdev->dev.fwnode != args.fwnode)
+		goto out_put;
+
+	/*
+	 * Try to find physical device walking upwards to the hierarcy.
+	 * We need to do this because the xHCI driver might not yet be
+	 * bound so the USB3 SuperSpeed ports are not yet created.
+	 */
+	dev = acpi_get_first_physical_node(adev);
+	while (!dev) {
+		adev = adev->parent;
+		if (!adev)
+			break;
+		dev = acpi_get_first_physical_node(adev);
+	}
+
+	if (!dev)
+		goto out_put;
+
+	/*
+	 * Check that the device is PCIe. This is because USB3
+	 * SuperSpeed ports have this property and they are not power
+	 * managed with the xHCI and the SuperSpeed hub so we create the
+	 * link from xHCI instead.
+	 */
+	while (!dev_is_pci(dev))
+		dev = dev->parent;
+
+	if (!dev)
+		goto out_put;
+
+	/*
+	 * Check that this actually matches the type of device we
+	 * expect. It should either be xHCI or PCIe root/downstream
+	 * port.
+	 */
+	pdev = to_pci_dev(dev);
+	if (pdev->class == PCI_CLASS_SERIAL_USB_XHCI ||
+	    (pci_is_pcie(pdev) &&
+		(pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT ||
+		 pci_pcie_type(pdev) == PCI_EXP_TYPE_DOWNSTREAM))) {
+		const struct device_link *link;
+
+		link = device_link_add(&pdev->dev, &nhi->pdev->dev,
+				       DL_FLAG_AUTOREMOVE_SUPPLIER |
+				       DL_FLAG_PM_RUNTIME);
+		if (link) {
+			dev_dbg(&nhi->pdev->dev, "created link from %s\n",
+				dev_name(&pdev->dev));
+		} else {
+			dev_warn(&nhi->pdev->dev, "device link creation from %s failed\n",
+				 dev_name(&pdev->dev));
+		}
+	}
+
+out_put:
+	fwnode_handle_put(args.fwnode);
+	return AE_OK;
+}
+
+/**
+ * tb_acpi_add_links() - Add device links based on ACPI description
+ * @nhi: Pointer to NHI
+ *
+ * Goes over ACPI namespace finding tunneled ports that reference to
+ * @nhi ACPI node. For each reference a device link is added. The link
+ * is automatically removed by the driver core.
+ */
+void tb_acpi_add_links(struct tb_nhi *nhi)
+{
+	acpi_status status;
+
+	if (!has_acpi_companion(&nhi->pdev->dev))
+		return;
+
+	/*
+	 * Find all devices that have usb4-host-controller interface
+	 * property that references to this NHI.
+	 */
+	status = acpi_walk_namespace(ACPI_TYPE_DEVICE, ACPI_ROOT_OBJECT, 32,
+				     tb_acpi_add_link, NULL, nhi, NULL);
+	if (ACPI_FAILURE(status))
+		dev_warn(&nhi->pdev->dev, "failed to enumerate tunneled ports\n");
+}
diff --git a/drivers/thunderbolt/nhi.c b/drivers/thunderbolt/nhi.c
index e499fe78756b..bd24e8254336 100644
--- a/drivers/thunderbolt/nhi.c
+++ b/drivers/thunderbolt/nhi.c
@@ -1199,6 +1199,7 @@ static int nhi_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	}
 
 	tb_apple_add_links(nhi);
+	tb_acpi_add_links(nhi);
 
 	tb = icm_probe(nhi);
 	if (!tb)
diff --git a/drivers/thunderbolt/tb.h b/drivers/thunderbolt/tb.h
index 847accd91bfa..dbcfa24caaf1 100644
--- a/drivers/thunderbolt/tb.h
+++ b/drivers/thunderbolt/tb.h
@@ -967,4 +967,10 @@ int usb4_usb3_port_release_bandwidth(struct tb_port *port, int *upstream_bw,
 
 void tb_check_quirks(struct tb_switch *sw);
 
+#ifdef CONFIG_ACPI
+void tb_acpi_add_links(struct tb_nhi *nhi);
+#else
+static inline void tb_acpi_add_links(struct tb_nhi *nhi) { }
+#endif
+
 #endif
-- 
2.28.0

