Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 40E8027A567
	for <lists+linux-pci@lfdr.de>; Mon, 28 Sep 2020 04:22:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726442AbgI1CWU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 27 Sep 2020 22:22:20 -0400
Received: from mga14.intel.com ([192.55.52.115]:35903 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726412AbgI1CWU (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 27 Sep 2020 22:22:20 -0400
IronPort-SDR: 8btNvyr0olyUbDywPGtkMk91bczF82ffYT59CiIirt2SmirVzLtVqoygJKATSRvNC56sWQS6iG
 2Ch22TgO66WQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9757"; a="161157203"
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="161157203"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Sep 2020 18:26:11 -0700
IronPort-SDR: cnqO0/LlJjLqAnSTFrA91kx+VuIgMWE0tYl5aCNTSP9wJ16gD7xit3T7Y6PiYuyDCAOlKJ0qaE
 y7K9Negje+wQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.77,312,1596524400"; 
   d="scan'208";a="488360774"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.36])
  by orsmga005.jf.intel.com with ESMTP; 27 Sep 2020 18:26:11 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>
Cc:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/2] PCI: vmd: Reset the VMD subdevice domain on probe
Date:   Sun, 27 Sep 2020 21:05:56 -0400
Message-Id: <20200928010557.5324-2-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200928010557.5324-1-jonathan.derrick@intel.com>
References: <20200928010557.5324-1-jonathan.derrick@intel.com>
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
 drivers/pci/controller/vmd.c | 31 +++++++++++++++++++++++++++++++
 1 file changed, 31 insertions(+)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 50b3520d261d..676acff3622f 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -445,6 +445,36 @@ static struct pci_ops vmd_ops = {
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
+	 * increments. Use increments of 0x8000 to locate root ports devices.
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
@@ -784,6 +814,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (!vmd->cfgbar)
 		return -ENOMEM;
 
+	vmd_domain_reset_sbr(dev);
 	pci_set_master(dev);
 	if (dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(64)) &&
 	    dma_set_mask_and_coherent(&dev->dev, DMA_BIT_MASK(32)))
-- 
2.18.1

