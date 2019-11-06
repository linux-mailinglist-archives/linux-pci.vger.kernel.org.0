Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E0504F1CAA
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2019 18:42:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728769AbfKFRmH (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 12:42:07 -0500
Received: from mga18.intel.com ([134.134.136.126]:23992 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728983AbfKFRmH (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 12:42:07 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 06 Nov 2019 09:42:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,275,1569308400"; 
   d="scan'208";a="192539730"
Received: from mton-linux-test2.lm.intel.com (HELO nsgsw-rhel7p6.lm.intel.com) ([10.232.117.44])
  by orsmga007.jf.intel.com with ESMTP; 06 Nov 2019 09:42:06 -0800
From:   Jon Derrick <jonathan.derrick@intel.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Keith Busch <kbusch@kernel.org>,
        Bjorn Helgaas <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>,
        Jon Derrick <jonathan.derrick@intel.com>
Subject: [PATCH 3/3] PCI: vmd: Use managed irq affinities
Date:   Wed,  6 Nov 2019 04:40:08 -0700
Message-Id: <1573040408-3831-4-git-send-email-jonathan.derrick@intel.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
References: <1573040408-3831-1-git-send-email-jonathan.derrick@intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Using managed IRQ affinities sets up the VMD affinities identically to
the child devices when those devices vector counts are limited by VMD.
This promotes better affinity handling as interrupts won't necessarily
need to pass context between non-local CPUs. One pre-vector is reserved
for the slow interrupt and not considered in the affinity algorithm.

Signed-off-by: Jon Derrick <jonathan.derrick@intel.com>
---
 drivers/pci/controller/vmd.c | 18 +++++-------------
 1 file changed, 5 insertions(+), 13 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index 7aca925..be92076 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -157,22 +157,11 @@ static void vmd_irq_disable(struct irq_data *data)
 	raw_spin_unlock_irqrestore(&list_lock, flags);
 }
 
-/*
- * XXX: Stubbed until we develop acceptable way to not create conflicts with
- * other devices sharing the same vector.
- */
-static int vmd_irq_set_affinity(struct irq_data *data,
-				const struct cpumask *dest, bool force)
-{
-	return -EINVAL;
-}
-
 static struct irq_chip vmd_msi_controller = {
 	.name			= "VMD-MSI",
 	.irq_enable		= vmd_irq_enable,
 	.irq_disable		= vmd_irq_disable,
 	.irq_compose_msi_msg	= vmd_compose_msi_msg,
-	.irq_set_affinity	= vmd_irq_set_affinity,
 };
 
 static irq_hw_number_t vmd_get_hwirq(struct msi_domain_info *info,
@@ -722,6 +711,9 @@ static irqreturn_t vmd_irq(int irq, void *data)
 static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 {
 	struct vmd_dev *vmd;
+	struct irq_affinity affd = {
+		.pre_vectors = 1,
+	};
 	int i, err;
 
 	if (resource_size(&dev->resource[VMD_CFGBAR]) < (1 << 20))
@@ -749,8 +741,8 @@ static int vmd_probe(struct pci_dev *dev, const struct pci_device_id *id)
 	if (vmd->msix_count < 0)
 		return -ENODEV;
 
-	vmd->msix_count = pci_alloc_irq_vectors(dev, 1, vmd->msix_count,
-					PCI_IRQ_MSIX);
+	vmd->msix_count = pci_alloc_irq_vectors_affinity(dev, 1, vmd->msix_count,
+					PCI_IRQ_MSIX | PCI_IRQ_AFFINITY, &affd);
 	if (vmd->msix_count < 0)
 		return vmd->msix_count;
 
-- 
1.8.3.1

