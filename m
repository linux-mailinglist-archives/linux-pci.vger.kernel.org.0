Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AA31A43A039
	for <lists+linux-pci@lfdr.de>; Mon, 25 Oct 2021 21:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbhJYT3a (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 25 Oct 2021 15:29:30 -0400
Received: from mga12.intel.com ([192.55.52.136]:33034 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235142AbhJYT2A (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 25 Oct 2021 15:28:00 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10148"; a="209828376"
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="209828376"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 11:34:56 -0700
X-IronPort-AV: E=Sophos;i="5.87,181,1631602800"; 
   d="scan'208";a="536694736"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.248.31])
  by fmsmga008-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Oct 2021 11:34:56 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        <linux-pci@vger.kernel.org>, jonathan.derrick@linux.dev
Subject: [PATCH v4] PCI: vmd: Clean up domain before enumeration
Date:   Mon, 25 Oct 2021 11:29:34 -0700
Message-Id: <20211025182934.185703-1-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During VT-d pass-through, the VMD driver occasionally fails to
enumerate underlying NVMe devices when repetitive reboots are
performed in the guest OS. The issue can be resolved by resetting
VMD root ports for proper enumeration and triggering secondary bus
reset which will also propagate reset through downstream bridges.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@linux.dev>
---
v3->v4: Using pci_reset_bus function for secondary bus reset instead of
        manually triggering secondary bus reset, addressing review
        comments of v3.
v2->v3: Combining two functions into one, Remove redundant definations
        and Formatting fixes

 drivers/pci/controller/vmd.c | 37 ++++++++++++++++++++++++++++++++++++
 1 file changed, 37 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a5987e52700e..79f8b86ee45b 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -498,6 +498,40 @@ static inline void vmd_acpi_begin(void) { }
 static inline void vmd_acpi_end(void) { }
 #endif /* CONFIG_ACPI */
 
+static void vmd_domain_reset(struct vmd_dev *vmd)
+{
+	u16 bus, max_buses = resource_size(&vmd->resources[0]);
+	u8 dev, functions, fn, hdr_type;
+	char __iomem *base;
+
+	for (bus = 0; bus < max_buses; bus++) {
+		for (dev = 0; dev < 32; dev++) {
+			base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
+						PCI_DEVFN(dev, 0), 0);
+
+			hdr_type = readb(base + PCI_HEADER_TYPE) &
+					 PCI_HEADER_TYPE_MASK;
+
+			functions = !!(hdr_type & 0x80) ? 8 : 1;
+			for (fn = 0; fn < functions; fn++) {
+				base = vmd->cfgbar + PCIE_ECAM_OFFSET(bus,
+						PCI_DEVFN(dev, fn), 0);
+
+				hdr_type = readb(base + PCI_HEADER_TYPE) &
+						PCI_HEADER_TYPE_MASK;
+
+				if (hdr_type != PCI_HEADER_TYPE_BRIDGE ||
+				    (readw(base + PCI_CLASS_DEVICE) !=
+				     PCI_CLASS_BRIDGE_PCI))
+					continue;
+
+				memset_io(base + PCI_IO_BASE, 0,
+					  PCI_ROM_ADDRESS1 - PCI_IO_BASE);
+			}
+		}
+	}
+}
+
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
@@ -801,6 +835,9 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	vmd_acpi_begin();
 
 	pci_scan_child_bus(vmd->bus);
+	vmd_domain_reset(vmd);
+	list_for_each_entry(child, &vmd->bus->children, node)
+		pci_reset_bus(child->self);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
 	/*
-- 
2.27.0

