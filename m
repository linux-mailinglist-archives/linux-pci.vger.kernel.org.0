Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B88644C4771
	for <lists+linux-pci@lfdr.de>; Fri, 25 Feb 2022 15:29:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiBYO35 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Feb 2022 09:29:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232662AbiBYO34 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Feb 2022 09:29:56 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2991322A243
        for <linux-pci@vger.kernel.org>; Fri, 25 Feb 2022 06:29:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645799364; x=1677335364;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=O6hER5E1XhrsunST4ZJLI4jCQ46zinexpzFLPxonyMY=;
  b=TG7geYYxosU33xfWYA1xG27c0dH3mIhj1pp/QgVzZpL1iXawmXBzPlbm
   7+YvCMTryEPFWE7zKGZotljKLWdJ9NEelV5UPfUkO+b2Up7qyqT9wWoLu
   Ujk8pB/wchw0EbitNARuTV6Us2ADelkooLmJoIU4ErXz9oxkN4tiEQIaQ
   3zgndBWKCsAzWNnOx7JurLccfz7BQ5InS2mtXyglCeoU1Jtr+Y8hV+F4J
   xqwms4LJXEsgt/I6EDWb31tTZwzVK8kzIWcq7hEbDikoraqCrLVTaD2yT
   SEznfYY/PdwogGB/igL52tH9AXF7fhL3wANBClQq8SKwa2y+GwKIJNUek
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10268"; a="338940156"
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="338940156"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Feb 2022 06:29:22 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,136,1643702400"; 
   d="scan'208";a="684664900"
Received: from tejas-system-product-name.iind.intel.com ([10.145.162.130])
  by fmsmga001.fm.intel.com with ESMTP; 25 Feb 2022 06:29:20 -0800
From:   Tejas Upadhyay <tejaskumarx.surendrakumar.upadhyay@intel.com>
To:     intel-gfx@lists.freedesktop.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Surendrakumar Upadhyay, TejaskumarX" 
        <tejaskumarx.surendrakumar.upadhyay@intel.com>,
        linux-pci@vger.kernel.org
Subject: [PATCH topic/core-for-CI] PCI: vmd: Prevent recursive locking on interrupt allocation
Date:   Fri, 25 Feb 2022 19:45:50 +0530
Message-Id: <20220225141550.162490-1-tejaskumarx.surendrakumar.upadhyay@intel.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIMWL_WL_HIGH,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Thomas Gleixner <tglx@linutronix.de>

Tejas reported the following recursive locking issue:

 swapper/0/1 is trying to acquire lock:
 ffff8881074fd0a0 (&md->mutex){+.+.}-{3:3}, at: msi_get_virq+0x30/0xc0

 but task is already holding lock:
 ffff8881017cd6a0 (&md->mutex){+.+.}-{3:3}, at: __pci_enable_msi_range+0xf2/0x290

 stack backtrace:
  __mutex_lock+0x9d/0x920
  msi_get_virq+0x30/0xc0
  pci_irq_vector+0x26/0x30
  vmd_msi_init+0xcc/0x210
  msi_domain_alloc+0xbf/0x150
  msi_domain_alloc_irqs_descs_locked+0x3e/0xb0
  __pci_enable_msi_range+0x155/0x290
  pci_alloc_irq_vectors_affinity+0xba/0x100
  pcie_port_device_register+0x307/0x550
  pcie_portdrv_probe+0x3c/0xd0
  pci_device_probe+0x95/0x110

This is caused by the VMD MSI code which does a lookup of the Linux
interrupt number for an VMD managed MSI[X] vector. The lookup function
tries to acquire the already held mutex.

Avoid that by caching the Linux interrupt number at initialization time
instead of looking it up over and over.

Fixes: 82ff8e6b78fc ("PCI/MSI: Use msi_get_virq() in pci_get_vector()")
Reported-by: "Surendrakumar Upadhyay, TejaskumarX" <tejaskumarx.surendrakumar.upadhyay@intel.com>
Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
Tested-by: "Surendrakumar Upadhyay, TejaskumarX" <tejaskumarx.surendrakumar.upadhyay@intel.com>
Cc: linux-pci@vger.kernel.org
Link: https://lore.kernel.org/r/87a6euub2a.ffs@tglx
---
 drivers/pci/controller/vmd.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/vmd.c b/drivers/pci/controller/vmd.c
index cc166c683638..eb05cceab964 100644
--- a/drivers/pci/controller/vmd.c
+++ b/drivers/pci/controller/vmd.c
@@ -99,11 +99,13 @@ struct vmd_irq {
  * @srcu:	SRCU struct for local synchronization.
  * @count:	number of child IRQs assigned to this vector; used to track
  *		sharing.
+ * @virq:	The underlying VMD Linux interrupt number
  */
 struct vmd_irq_list {
 	struct list_head	irq_list;
 	struct srcu_struct	srcu;
 	unsigned int		count;
+	unsigned int		virq;
 };
 
 struct vmd_dev {
@@ -253,7 +255,6 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	struct msi_desc *desc = arg->desc;
 	struct vmd_dev *vmd = vmd_from_bus(msi_desc_to_pci_dev(desc)->bus);
 	struct vmd_irq *vmdirq = kzalloc(sizeof(*vmdirq), GFP_KERNEL);
-	unsigned int index, vector;
 
 	if (!vmdirq)
 		return -ENOMEM;
@@ -261,10 +262,8 @@ static int vmd_msi_init(struct irq_domain *domain, struct msi_domain_info *info,
 	INIT_LIST_HEAD(&vmdirq->node);
 	vmdirq->irq = vmd_next_irq(vmd, desc);
 	vmdirq->virq = virq;
-	index = index_from_irqs(vmd, vmdirq->irq);
-	vector = pci_irq_vector(vmd->dev, index);
 
-	irq_domain_set_info(domain, virq, vector, info->chip, vmdirq,
+	irq_domain_set_info(domain, virq, vmdirq->irq->virq, info->chip, vmdirq,
 			    handle_untracked_irq, vmd, NULL);
 	return 0;
 }
@@ -685,7 +684,8 @@ static int vmd_alloc_irqs(struct vmd_dev *vmd)
 			return err;
 
 		INIT_LIST_HEAD(&vmd->irqs[i].irq_list);
-		err = devm_request_irq(&dev->dev, pci_irq_vector(dev, i),
+		vmd->irqs[i].virq = pci_irq_vector(dev, i);
+		err = devm_request_irq(&dev->dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
 				       vmd->name, &vmd->irqs[i]);
 		if (err)
@@ -969,7 +969,7 @@ static int vmd_suspend(struct device *dev)
 	int i;
 
 	for (i = 0; i < vmd->msix_count; i++)
-		devm_free_irq(dev, pci_irq_vector(pdev, i), &vmd->irqs[i]);
+		devm_free_irq(dev, vmd->irqs[i].virq, &vmd->irqs[i]);
 
 	return 0;
 }
@@ -981,7 +981,7 @@ static int vmd_resume(struct device *dev)
 	int err, i;
 
 	for (i = 0; i < vmd->msix_count; i++) {
-		err = devm_request_irq(dev, pci_irq_vector(pdev, i),
+		err = devm_request_irq(dev, vmd->irqs[i].virq,
 				       vmd_irq, IRQF_NO_THREAD,
 				       vmd->name, &vmd->irqs[i]);
 		if (err)
-- 
2.34.1

