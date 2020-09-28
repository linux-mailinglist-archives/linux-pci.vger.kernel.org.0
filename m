Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D737727A52E
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 03:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726414AbgI1BZ5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 21:25:57 -0400
Received: from mga14.intel.com ([192.55.52.115]:32173 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726409AbgI1BZ5 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 21:25:57 -0400
IronPort-SDR: LuC7DXGoeENcva7ZSIWLg+3NA4sZ2mQP6G3HF9ijVq8GMa/+euOVGkO09+wtSrp+e3LiZ8BUQN
 MdBvzjZE0lrQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="161157206"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="161157206"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:26:12 -0700
IronPort-SDR: yUWfGBEbpNt5wMtto1oMM9mTi2Txc0EB4QxLz8s6EB/cNc3ZaOQIuYOqtX+rOVaqiYUI5z5wnB
 AATOQHZSb58w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488360779"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2020 18:26:11 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 2/2] PCI: Add a reset quirk for VMD
Date:   Sun, 27 Sep 2020 21:05:57 -0400
Message-Id: <20200928010557.5324-3-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200928010557.5324-1-jonathan.derrick@intel.com>
References: <20200928010557.5324-1-jonathan.derrick@intel.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD domains should be reset in-between special attachment such as VFIO
users. VMD does not offer a reset however the subdevice domain itself
can be reset starting at the Root Bus. Add a Secondary Bus Reset on each
of the individual root port devices immediately downstream of the VMD
root bus.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c |  3 ++-
 drivers/pci/quirks.c         | 48 ++++++++++++++++++++++++++++++++++++
 2 files changed, 50 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 676acff3622f..fdc1a206f73e 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -14,6 +14,7 @@
 #include <linux/srcu.h>
 #include <linux/rculist.h>
 #include <linux/rcupdate.h>
+#include <linux/delay.h>
 
 #include <asm/irqdomain.h>
 #include <asm/device.h>
@@ -814,7 +815,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!vmd->cfgbar)
 		return -ENOMEM;
 
-	vmd_domain_reset_sbr(dev);
+	vmd_domain_reset_sbr(vmd);
 	pci_set_master(dev);
 	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
 	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
diff --git a/drivers/pci/quirks.c b/drivers/pci/quirks.c
index 8f409d442bc0..f6a9c2b2625a 100644
--- a/drivers/pci/quirks.c
+++ b/drivers/pci/quirks.c
@@ -3801,6 +3801,49 @@ static int reset_ivb_igd(struct pci_dev *dev, int probe)
 	return 0;
 }
 
+/* Issues SBR to VMD domain to clear PCI configuration */
+static int reset_vmd_sbr(struct pci_dev *dev, int probe)
+{
+	char __iomem *cfgbar, *base;
+	int rp;
+	u16 ctl;
+
+	if (probe)
+		return 0;
+
+	if (dev->dev.driver)
+		return 0;
+
+	cfgbar = pci_iomap(dev, 0, 0);
+	if (!cfgbar)
+		return -ENOMEM;
+
+	/*
+	 * Subdevice config space is mapped linearly using 4k config space
+	 * increments. Use increments of 0x8000 to locate root ports devices.
+	 */
+	for (rp = 0; rp < 4; rp++) {
+		base = cfgbar + rp * 0x8000;
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
+	pci_iounmap(dev, cfgbar);
+	return 0;
+}
+
 /* Device-specific reset method for Chelsio T4-based adapters */
 static int reset_chelsio_generic_dev(struct pci_dev *dev, int probe)
 {
@@ -3976,6 +4019,11 @@ static const struct pci_dev_reset_methods pci_dev_reset_methods[] = {
 		reset_ivb_igd },
 	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_IVB_M2_VGA,
 		reset_ivb_igd },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, 0x467f, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, 0x4c3d, reset_vmd_sbr },
+	{ PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B, reset_vmd_sbr },
 	{ PCI_VENDOR_ID_SAMSUNG, 0xa804, nvme_disable_and_flr },
 	{ PCI_VENDOR_ID_INTEL, 0x0953, delay_250ms_after_flr },
 	{ PCI_VENDOR_ID_CHELSIO, PCI_ANY_ID,
-- 
2.18.1

