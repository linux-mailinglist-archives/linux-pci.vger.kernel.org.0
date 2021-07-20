Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A63A63D0390
	for <lists+linux-pci@lfdr.de>; Tue, 20 Jul 2021 23:04:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230051AbhGTUXf (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 20 Jul 2021 16:23:35 -0400
Received: from mga06.intel.com ([134.134.136.31]:37762 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234164AbhGTULc (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 20 Jul 2021 16:11:32 -0400
X-IronPort-AV: E=McAfee;i="6200,9189,10051"; a="272440828"
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="272440828"
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:51:42 -0700
X-IronPort-AV: E=Sophos;i="5.84,256,1620716400"; 
   d="scan'208";a="415371391"
Received: from unknown (HELO localhost.ch.intel.com) ([10.2.248.31])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Jul 2021 13:51:41 -0700
From:   Nirmal Patel <nirmal.patel@linux.intel.com>
To:     Nirmal Patel <nirmal.patel@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>,
        <linux-pci@vger.kernel.org>
Subject: [PATCH v2 1/2] PCI: vmd: Trigger secondary bus reset
Date:   Tue, 20 Jul 2021 13:50:08 -0700
Message-Id: <20210720205009.111806-2-nirmal.patel@linux.intel.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
References: <20210720205009.111806-1-nirmal.patel@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

During VT-d passthrough repetitive reboot tests, it was determined that the VMD
domain needed to be reset in order to allow downstream devices to reinitialize
properly. This is done using a secondary bus reset at each of the VMD root
ports and any bridges in the domain.

Signed-off-by: Nirmal Patel <nirmal.patel@linux.intel.com>
Reviewed-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 46 ++++++++++++++++++++++++++++++++++++
 1 file changed, 46 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e3fcdfec58b3..6e1c60048774 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -15,6 +15,7 @@
 #include <linux/srcu.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 
 #include <asm/irqdomain.h>
 #include <asm/device.h>
@@ -447,6 +448,49 @@ static struct pci_ops vmd_ops = {
 	.write		= vmd_pci_write,
 };
 
+#define PCI_HEADER_TYPE_MASK 0x7f
+#define PCI_CLASS_BRIDGE_PCI 0x0604
+#define DEVICE_SPACE (8 * 4096)
+#define VMD_DEVICE_BASE(vmd, device) ((vmd)->cfgbar + (device) * DEVICE_SPACE)
+#define VMD_FUNCTION_BASE(vmd, device, fn) ((vmd)->cfgbar + (device) * (DEVICE_SPACE + (fn*4096)))
+static void vmd_domain_sbr(struct vmd_dev *vmd)
+{
+	char __iomem *base;
+	u16 ctl;
+	int dev_seq;
+	int max_devs = resource_size(&vmd->resources[0]) * 32;
+
+	/*
+	* Subdevice config space may or many not be mapped linearly using 4k config
+	* space.
+	*/
+	for (dev_seq = 0; dev_seq < max_devs; dev_seq++) {
+		base = VMD_DEVICE_BASE(vmd, dev_seq);
+		if (readw(base + PCI_VENDOR_ID) != PCI_VENDOR_ID_INTEL)
+			continue;
+
+		if ((readb(base + PCI_HEADER_TYPE) & PCI_HEADER_TYPE_MASK) !=
+		    PCI_HEADER_TYPE_BRIDGE)
+			continue;
+
+		if (readw(base + PCI_CLASS_DEVICE) != PCI_CLASS_BRIDGE_PCI)
+			continue;
+
+		/* pci_reset_secondary_bus() */
+		ctl = readw(base + PCI_BRIDGE_CONTROL);
+		ctl |= PCI_BRIDGE_CTL_BUS_RESET;
+		writew(ctl, base + PCI_BRIDGE_CONTROL);
+		readw(base + PCI_BRIDGE_CONTROL);
+		msleep(2);
+
+		ctl &= ~PCI_BRIDGE_CTL_BUS_RESET;
+		writew(ctl, base + PCI_BRIDGE_CONTROL);
+		readw(base + PCI_BRIDGE_CONTROL);
+
+	}
+	ssleep(1);
+}
+
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
@@ -747,6 +791,8 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
+	vmd_domain_sbr(vmd);
+
 	pci_scan_child_bus(vmd->bus);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
-- 
2.27.0

