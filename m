Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 598AE4C331
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:41:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfFSVlq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:41:46 -0400
Received: from mga11.intel.com ([192.55.52.93]:10387 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730596AbfFSVlq (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:41:46 -0400
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 19 Jun 2019 14:41:45 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.63,394,1557212400"; 
   d="scan'208";a="170683464"
Received: from megha-z97x-ud7-th.sc.intel.com ([143.183.85.162])
  by orsmga002.jf.intel.com with ESMTP; 19 Jun 2019 14:41:44 -0700
From:   Megha Dey <megha.dey@linux.intel.com>
To:     bhelgaas@google.com, linux-pci@vger.kernel.org
Cc:     ashok.raj@intel.com, jacob.jun.pan@linux.intel.com,
        megha.dey@intel.com, Megha Dey <megha.dey@linux.intel.com>
Subject: [RFC V1 4/6] PCI/MSI: Introduce new structure to manage MSI-x entries
Date:   Wed, 19 Jun 2019 15:03:42 -0700
Message-Id: <1560981824-3966-5-git-send-email-megha.dey@linux.intel.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
References: <1560981824-3966-1-git-send-email-megha.dey@linux.intel.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This is a preparatory patch to introduce disabling of MSI-X vectors
belonging to a particular group. In this patch, we introduce a new
structure msix_sysfs, which manages sysfs entries for dynamically
allocated MSI-X vectors belonging to a particular group.

Cc: Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc: Ashok Raj <ashok.raj@intel.com>
Signed-off-by: Megha Dey <megha.dey@linux.intel.com>
---
 drivers/pci/msi.c   | 12 +++++++++++-
 drivers/pci/probe.c |  1 +
 include/linux/pci.h |  9 +++++++++
 3 files changed, 21 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index fd7fa6e..e947243 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -479,10 +479,11 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 	struct device_attribute *msi_dev_attr;
 	struct attribute_group *msi_irq_group;
 	const struct attribute_group **msi_irq_groups;
+	struct msix_sysfs *msix_sysfs_entry;
 	struct msi_desc *entry;
 	int ret = -ENOMEM;
 	int num_msi = 0;
-	int count = 0;
+	int count = 0, group = -1;
 	int i;
 
 	/* Determine how many msi entries we have */
@@ -509,6 +510,8 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 				goto error_attrs;
 			msi_dev_attr->attr.mode = S_IRUGO;
 			msi_dev_attr->show = msi_mode_show;
+			if (!i)
+				group = entry->group_id;
 			++count;
 		}
 	}
@@ -524,6 +527,13 @@ static int populate_msi_sysfs(struct pci_dev *pdev)
 		goto error_irq_group;
 	msi_irq_groups[0] = msi_irq_group;
 
+	msix_sysfs_entry = kzalloc(sizeof(*msix_sysfs_entry) * 2, GFP_KERNEL);
+	msix_sysfs_entry->msi_irq_group = msi_irq_group;
+	msix_sysfs_entry->group_id = group;
+	msix_sysfs_entry->vecs_in_grp = count;
+	INIT_LIST_HEAD(&msix_sysfs_entry->list);
+	list_add_tail(&msix_sysfs_entry->list, &pdev->msix_sysfs);
+
 	if (!pdev->msix_enabled)
 		ret = sysfs_create_group(&pdev->dev.kobj, msi_irq_group);
 	else
diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 491c1cf..bb20ef6 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -2435,6 +2435,7 @@ struct pci_dev *pci_alloc_dev(struct pci_bus *bus)
 	idr_init(dev->grp_idr);
 
 	INIT_LIST_HEAD(&dev->bus_list);
+	INIT_LIST_HEAD(&dev->msix_sysfs);
 	dev->dev.type = &pci_dev_type;
 	dev->bus = pci_bus_get(bus);
 
diff --git a/include/linux/pci.h b/include/linux/pci.h
index c56462c..73385c0 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -471,6 +471,7 @@ struct pci_dev {
 	struct idr	*grp_idr;       /* IDR to assign group to MSI-X vecs */
 	unsigned long	*entry;         /* Bitmap to represent MSI-X entries */
 	bool		one_shot;	/* If true, oneshot MSI-X allocation */
+	struct list_head	msix_sysfs; /* sysfs entries for MSI-X group */
 };
 
 static inline struct pci_dev *pci_physfn(struct pci_dev *dev)
@@ -1390,6 +1391,14 @@ struct msix_entry {
 	u16	entry;	/* Driver uses to specify entry, OS writes */
 };
 
+/* Manage sysfs entries for dynamically allocated MSI-X vectors */
+struct msix_sysfs {
+	struct	attribute_group *msi_irq_group;
+	struct	list_head list;
+	int	group_id;
+	int	vecs_in_grp;
+};
+
 #ifdef CONFIG_PCI_MSI
 int pci_msi_vec_count(struct pci_dev *dev);
 void pci_disable_msi(struct pci_dev *dev);
-- 
2.7.4

