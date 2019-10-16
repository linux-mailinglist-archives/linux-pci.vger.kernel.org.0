Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C601DA1EB
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2019 01:06:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731616AbfJPXGZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Oct 2019 19:06:25 -0400
Received: from mga02.intel.com ([134.134.136.20]:4571 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390020AbfJPXGY (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Oct 2019 19:06:24 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Oct 2019 16:06:24 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.67,305,1566889200"; 
   d="scan'208";a="189833614"
Received: from unknown (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.116.93])
  by orsmga008.jf.intel.com with ESMTP; 16 Oct 2019 16:06:23 -0700
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Bjorn Helgaas <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        Pawel Baldysiak <pawel.baldysiak@intel.com>,
        Artur Paszkiewicz <artur.paszkiewicz@intel.com>,
        Keith Busch <keith.busch@intel.com>,
        Dave Fugate <david.fugate@intel.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 1/3] PCI: vmd: Add helpers to access device config space
Date:   Wed, 16 Oct 2019 11:04:46 -0600
Message-Id: <1571245488-3549-2-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
References: <1571245488-3549-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This patch adds helpers to access child device config space. It uses the
fabric-view of the bus number, which requires the pci accessors to
translate out the starting bus number. This will allow internal code to
access child device config space without a struct pci_bus while minding
the accessing rules.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
Reviewed-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
---
 drivers/pci/controller/vmd.c | 36 ++++++++++++++++++++++++------------
 1 file changed, 24 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index a35d3f3..959c7c7 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -440,12 +440,10 @@ static void vmd_setup_dma_ops(struct vmd_dev *vmd)
 }
 #undef ASSIGN_VMD_DMA_OPS
 
-static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
+static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, unsigned char busn,
 				  unsigned int devfn, int reg, int len)
 {
-	char __iomem *addr = vmd->cfgbar +
-			     ((bus->number - vmd->busn_start) << 20) +
-			     (devfn << 12) + reg;
+	char __iomem *addr = vmd->cfgbar + (busn << 20) + (devfn << 12) + reg;
 
 	if ((addr - vmd->cfgbar) + len >=
 	    resource_size(&vmd->dev->resource[VMD_CFGBAR]))
@@ -458,11 +456,10 @@ static char __iomem *vmd_cfg_addr(struct vmd_dev *vmd, struct pci_bus *bus,
  * CPU may deadlock if config space is not serialized on some versions of this
  * hardware, so all config space access is done under a spinlock.
  */
-static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
-			int len, u32 *value)
+static int vmd_cfg_read(struct vmd_dev *vmd, unsigned char busn,
+			unsigned int devfn, int reg, int len, u32 *value)
 {
-	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	char __iomem *addr = vmd_cfg_addr(vmd, busn, devfn, reg, len);
 	unsigned long flags;
 	int ret = 0;
 
@@ -488,16 +485,23 @@ static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
 	return ret;
 }
 
+static int vmd_pci_read(struct pci_bus *bus, unsigned int devfn, int reg,
+			int len, u32 *value)
+{
+	struct vmd_dev *vmd = vmd_from_bus(bus);
+	return vmd_cfg_read(vmd, bus->number - vmd->busn_start, devfn,
+			    reg, len, value);
+}
+
 /*
  * VMD h/w converts non-posted config writes to posted memory writes. The
  * read-back in this function forces the completion so it returns only after
  * the config space was written, as expected.
  */
-static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
-			 int len, u32 value)
+static int vmd_cfg_write(struct vmd_dev *vmd, unsigned char busn,
+			 unsigned int devfn, int reg, int len, u32 value)
 {
-	struct vmd_dev *vmd = vmd_from_bus(bus);
-	char __iomem *addr = vmd_cfg_addr(vmd, bus, devfn, reg, len);
+	char __iomem *addr = vmd_cfg_addr(vmd, busn, devfn, reg, len);
 	unsigned long flags;
 	int ret = 0;
 
@@ -526,6 +530,14 @@ static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
 	return ret;
 }
 
+static int vmd_pci_write(struct pci_bus *bus, unsigned int devfn, int reg,
+			 int len, u32 value)
+{
+	struct vmd_dev *vmd = vmd_from_bus(bus);
+	return vmd_cfg_write(vmd, bus->number - vmd->busn_start, devfn,
+			     reg, len, value);
+}
+
 static struct pci_ops vmd_ops = {
 	.read		= vmd_pci_read,
 	.write		= vmd_pci_write,
-- 
1.8.3.1

