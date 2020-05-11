Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4E8B31CE3BD
	for <lists+linux-pci@lfdr.de>; Mon, 11 May 2020 21:17:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730974AbgEKTRW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 May 2020 15:17:22 -0400
Received: from mga05.intel.com ([192.55.52.43]:10034 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731243AbgEKTRW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 11 May 2020 15:17:22 -0400
IronPort-SDR: S/DBmCULAShw4yKvQXaFJ2tS4/IZ/pCVCRCyUqNlUnYx5yNSzxuOkrpv8u+XoqZ5ryiuDGEqjt
 JnoghJgFjaLw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:17:21 -0700
IronPort-SDR: roRqwOjLYhkQ32MOBY1NWaG8Rq4NfXfjhv0xHiAE0sHLAo09c8dlxaMkE1RMVc64sRzQVz9coz
 nUt+Po+4mQ4w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="463494245"
Received: from unknown (HELO localhost.lm.intel.com) ([10.232.116.74])
  by fmsmga006.fm.intel.com with ESMTP; 11 May 2020 12:17:21 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     <linux-pci@vger.kernel.org>, qemu-devel@nongnu.org
Cc:     Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        virtualization@lists.linux-foundation.org,
        Christoph Hellwig <hch@lst.de>,
        Andrzej Jakowski <andrzej.jakowski@linux.intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH v2 2/2] PCI: vmd: Use Shadow MEMBAR registers for QEMU/KVM guests
Date:   Mon, 11 May 2020 15:01:29 -0400
Message-Id: <20200511190129.9313-4-jonathan.derrick@intel.com>
X-Mailer: git-send-email 2.18.1
In-Reply-To: <20200511190129.9313-1-jonathan.derrick@intel.com>
References: <20200511190129.9313-1-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

VMD device 28C0 natively assists guest passthrough of the VMD endpoint
through the use of shadow registers that provide Host Physical Addresses
to correctly assign bridge windows. These shadow registers are only
available if VMD config space register 0x70, bit 1 is set.

For existing VMD which don't natively support the shadow register, VMD
config space register 0x70 is reserved and will return 0. Future VMD
will have these registers natively in hardware, but existing VMD can
still use this feature by emulating the config space register and shadow
registers.

QEMU has been modified to emulate this config space register and the
shadow membar registers for VMDs which don't natively support this
feature. This patch updates the supported device list to allow this
feature to be used on these VMDs.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 15 ++++++++++-----
 1 file changed, 10 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index e386d4eac407..ee71d0989875 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -600,6 +600,7 @@ static irqreturn_t vmd_irq(int irq, void *data)
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
+	unsigned long features = id->driver_data;
 	int i, err;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
@@ -652,7 +653,7 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 
 	spin_lock_init(&vmd->cfg_lock);
 	pci_set_drvdata(dev, vmd);
-	err = vmd_enable_domain(vmd, (unsigned long) id->driver_data);
+	err = vmd_enable_domain(vmd, features);
 	if (err)
 		return err;
 
@@ -716,16 +717,20 @@ static int vmd_resume(struct device *dev)
 static SIMPLE_DEV_PM_OPS(vmd_dev_pm_ops, vmd_suspend, vmd_resume);
 
 static const struct pci_device_id vmd_ids[] = {
-	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),},
+	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_201D),
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_28C0),
 		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
 				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x467f),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, 0x4c3d),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{PCI_DEVICE(PCI_VENDOR_ID_INTEL, PCI_DEVICE_ID_INTEL_VMD_9A0B),
-		.driver_data = VMD_FEAT_HAS_BUS_RESTRICTIONS,},
+		.driver_data = VMD_FEAT_HAS_MEMBAR_SHADOW |
+				VMD_FEAT_HAS_BUS_RESTRICTIONS,},
 	{0,}
 };
 MODULE_DEVICE_TABLE(pci, vmd_ids);
-- 
2.18.1

