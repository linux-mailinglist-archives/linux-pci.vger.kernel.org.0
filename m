Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B5E13D97BC
	for <lists+linux-pci@lfdr.de>; Wed, 28 Jul 2021 23:47:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231126AbhG1Vrz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Jul 2021 17:47:55 -0400
Received: from mga11.intel.com ([192.55.52.93]:64842 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230156AbhG1Vrz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 28 Jul 2021 17:47:55 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10059"; a="209641815"
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="209641815"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 14:47:52 -0700
X-IronPort-AV: E=Sophos;i="5.84,276,1620716400"; 
   d="scan'208";a="517804907"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.248.31])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Jul 2021 14:47:51 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH v3] PCI: vmd: Issue secondary bus reset and vmd domain window reset
Date:   Wed, 28 Jul 2021 14:46:39 -0700
Message-Id: <20210728214639.7204-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to properly re-initialize the VMD domain during repetitive driver
attachment or reboot tests, ensure that the VMD root ports are
re-initialized to a blank state that can be re-enumerated appropriately
by the PCI core. This is performed by re-initializing all of the bridge
windows to ensure that PCI core enumeration does not detect potentially
invalid bridge windows and misinterpret them as firmware-assigned windows,
when they simply may be invalid bridge window information from a previous
boot.

During VT-d passthrough repetitive reboot tests, it was determined that
the VMD domain needed to be reset in order to allow downstream devices
to reinitialize properly. This is done using setting secondary bus
reset bit of each of the VMD root port and will propagate reset through
downstream bridges.

v2->v3: Combining two functions into one, Remove redundant definations
        and Formatting fixes

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 63 ++++++++++++++++++++++++++++++++++++
 1 file changed, 63 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e3fcdfec58b3..e2c0de700e61 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -15,6 +15,9 @@
 #include <linux/srcu.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
+#include <linux/pci_regs.h>
+#include <linux/pci_ids.h>
 
 #include <asm/irqdomain.h>
 #include <asm/device.h>
@@ -447,6 +450,64 @@ static struct pci_ops vmd_ops = {
 	.write		= vmd_pci_write,
 };
 
+static void vmd_domain_reset(struct vmd_dev *vmd)
+{
+	char __iomem *base;
+	char __iomem *addr;
+	u16 ctl;
+	int dev_seq;
+	int max_devs = 32;
+	int max_buses = resource_size(&vmd->resources[0]);
+	int bus_seq;
+	u8 functions;
+	u8 fn_seq;
+	u8 hdr_type;
+
+	for(bus_seq = 0; bus_seq < max_buses; bus_seq++) {
+		for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
+			base = vmd->cfgbar
+					+ PCIE_ECAM_OFFSET(bus_seq,
+					   PCI_DEVFN(dev_seq, 0), PCI_VENDOR_ID);
+
+			if (readw(base) != PCI_VENDOR_ID_INTEL)
+				continue;
+
+			hdr_type = readb(base + PCI_HEADER_TYPE) & PCI_HEADER_TYPE_MASK;
+			if (hdr_type != PCI_HEADER_TYPE_BRIDGE)
+				continue;
+
+			functions = !!(hdr_type & 0x80) ? 8 : 1;
+			for (fn_seq = 0; fn_seq < functions; fn_seq++)
+			{
+				addr = vmd->cfgbar
+						+ PCIE_ECAM_OFFSET(0x0,
+						   PCI_DEVFN(dev_seq, fn_seq), PCI_VENDOR_ID);
+				if (readw(addr) != PCI_VENDOR_ID_INTEL)
+					continue;
+
+				memset_io((vmd->cfgbar +
+				 PCIE_ECAM_OFFSET(0x0,PCI_DEVFN(dev_seq, fn_seq),PCI_IO_BASE)),
+				 0, PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+			}
+
+			if (readw(base + PCI_CLASS_DEVICE) != PCI_CLASS_BRIDGE_PCI)
+				continue;
+
+			/* pci_reset_secondary_bus() */
+			ctl = readw(base + PCI_BRIDGE_CONTROL);
+			ctl |= PCI_BRIDGE_CTL_BUS_RESET;
+			writew(ctl, base + PCI_BRIDGE_CONTROL);
+			readw(base + PCI_BRIDGE_CONTROL);
+			msleep(2);
+
+			ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+			writew(ctl, base + PCI_BRIDGE_CONTROL);
+			readw(base + PCI_BRIDGE_CONTROL);
+		}
+	}
+	ssleep(1);
+}
+
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
@@ -747,6 +808,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
+	vmd_domain_reset(vmd);
+
 	pci_scan_child_bus(vmd->bus);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
-- 
2.27.0

