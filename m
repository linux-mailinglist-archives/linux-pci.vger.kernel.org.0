Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DBFE92BB972
	for <lists+linux-pci@lfdr.de>; Fri, 20 Nov 2020 23:55:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729072AbgKTWvx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 20 Nov 2020 17:51:53 -0500
Received: from mga04.intel.com ([192.55.52.120]:15001 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728905AbgKTWvx (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 20 Nov 2020 17:51:53 -0500
IronPort-SDR: j7HHFGPrzctiqlqAwMBZBoWSQegDhz3FV5EbGgwuKnjfWVZCRwWgJqizAlvf+ERrvUXtszbthH
 raj9mO3R81SA==
X-IronPort-AV: E=McAfee;i="6000,8403,9811"; a="168985724"
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="168985724"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:53 -0800
IronPort-SDR: KJWkTdg/0ZxrSljrgwAKFzta6h6KhK6aYrsu8/4RD+eV6zhTy2YBvLOtSoSpUIr/LqI85VCrVe
 LYU9RD/80nGA==
X-IronPort-AV: E=Sophos;i="5.78,357,1599548400"; 
   d="scan'208";a="357852064"
Received: from sabakhle-mobl1.amr.corp.intel.com (HELO jderrick-mobl.amr.corp.intel.com) ([10.213.165.80])
  by orsmga008-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 20 Nov 2020 14:51:52 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     <linux-pci@vger.kernel.org>, Bjorn Helgaas <helgaas@kernel.org>,
        Nirmal Patel <nirmal.patel@intel.com>,
        Sushma Kalakota <sushmax.kalakota@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/5] PCI: vmd: Reset the VMD subdevice domain on probe
Date:   Fri, 20 Nov 2020 15:51:40 -0700
Message-Id: <20201120225144.15138-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20201120225144.15138-1-jonathan.derrick@intel.com>
References: <20201120225144.15138-1-jonathan.derrick@intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The VMD subdevice domain resource requirements may have changed
in-between module loads. Generic PCI resource assignment code may rely
on existing resource configuration rather than the VMD preference of
re-examining the domain. Add a Secondary Bus Reset to the VMD subdevice
domain during driver attachment to clear the PCI config space of the
subdevices.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 32 ++++++++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index c31e4d5..c7b5614 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -14,6 +14,7 @@
 #include <linux/srcu.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 
 #include <asm/irqdomain.h>
 #include <asm/device.h>
@@ -424,6 +425,36 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	.write		= vmd_pci_write,
 };
 
+static void vmd_domain_reset_sbr(struct vmd_dev *vmd)
+{
+	char __iomem *base;
+	int rp;
+	u16 ctl;
+
+	/*
+	 * Subdevice config space is mapped linearly using 4k config space
+	 * increments. Use increments of 0x8000 to locate root port devices.
+	 */
+	for (rp = 0; rp < 4; rp++) {
+		base = vmd->cfgbar + rp * 0x8000;
+		if (readl(base + PCI_COMMAND) == 0xFFFFFFFF)
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
+	}
+
+	ssleep(1);
+}
+
 static void vmd_attach_resources(struct vmd_dev *vmd)
 {
 	vmd->dev->resource[VMD_MEMBAR1].child = &vmd->resources[1];
@@ -707,6 +738,7 @@ static int vmd_enable_domain(struct vmd_dev *vmd, unsigned long features)
 	if (vmd->irq_domain)
 		dev_set_msi_domain(&vmd->bus->dev, vmd->irq_domain);
 
+	vmd_domain_reset_sbr(vmd);
 	pci_scan_child_bus(vmd->bus);
 	pci_assign_unassigned_bus_resources(vmd->bus);
 
-- 
1.8.3.1

