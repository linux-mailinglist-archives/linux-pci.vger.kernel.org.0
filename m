Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 51C56428D8C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 15:09:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235410AbhJKNLd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 09:11:33 -0400
Received: from szxga01-in.huawei.com ([45.249.212.187]:28916 "EHLO
        szxga01-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236807AbhJKNLd (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 09:11:33 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4HSfCh6mvszbn4k;
        Mon, 11 Oct 2021 21:05:04 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 21:09:29 +0800
Received: from huawei.com (10.175.104.82) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 21:09:28 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <bhelgaas@google.com>, <andy.shevchenko@gmail.com>,
        <maz@kernel.org>, <tglx@linutronix.de>,
        <song.bao.hua@hisilicon.com>, <21cnbao@gmail.com>,
        <gregkh@linuxfoundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] PCI/MSI: fix page fault when msi_populate_sysfs() failed
Date:   Mon, 11 Oct 2021 21:08:37 +0800
Message-ID: <20211011130837.766323-1-wanghai38@huawei.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.104.82]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 kwepemm600001.china.huawei.com (7.193.23.3)
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

I got a page fault report when doing fault injection test:

BUG: unable to handle page fault for address: fffffffffffffff4
...
RIP: 0010:sysfs_remove_groups+0x25/0x60
...
Call Trace:
 msi_destroy_sysfs+0x30/0xa0
 free_msi_irqs+0x11d/0x1b0
 __pci_enable_msix_range+0x67f/0x760
 pci_alloc_irq_vectors_affinity+0xe7/0x170
 vp_find_vqs_msix+0x129/0x560
 vp_find_vqs+0x52/0x230
 vp_modern_find_vqs+0x47/0xb0
 p9_virtio_probe+0xa1/0x460 [9pnet_virtio]
...
 entry_SYSCALL_64_after_hwframe+0x44/0xae

When populating msi_irqs sysfs failed in msi_capability_init() or
msix_capability_init(), dev->msi_irq_groups will point to ERR_PTR(...).
This will cause a page fault when destroying the wrong
dev->msi_irq_groups in free_msi_irqs().

Define a temp variable and assign it to dev->msi_irq_groups if
the temp variable is not PTR_ERR.

Fixes: 2f170814bdd2 ("genirq/msi: Move MSI sysfs handling from PCI to MSI core")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
Acked-by: Barry Song <song.bao.hua@hisilicon.com>
---
v1->v2: introduce temporary variable 'groups'
 drivers/pci/msi.c | 18 ++++++++++++------
 1 file changed, 12 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0099a00af361..4b4792940e86 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -535,6 +535,7 @@ static int msi_verify_entries(struct pci_dev *dev)
 static int msi_capability_init(struct pci_dev *dev, int nvec,
 			       struct irq_affinity *affd)
 {
+	const struct attribute_group **groups;
 	struct msi_desc *entry;
 	int ret;
 
@@ -558,12 +559,14 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	if (ret)
 		goto err;
 
-	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(dev->msi_irq_groups)) {
-		ret = PTR_ERR(dev->msi_irq_groups);
+	groups = msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(groups)) {
+		ret = PTR_ERR(groups);
 		goto err;
 	}
 
+	dev->msi_irq_groups = groups;
+
 	/* Set MSI enabled bits	*/
 	pci_intx_for_msi(dev, 0);
 	pci_msi_set_enable(dev, 1);
@@ -691,6 +694,7 @@ static void msix_mask_all(void __iomem *base, int tsize)
 static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 				int nvec, struct irq_affinity *affd)
 {
+	const struct attribute_group **groups;
 	void __iomem *base;
 	int ret, tsize;
 	u16 control;
@@ -730,12 +734,14 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 
 	msix_update_entries(dev, entries);
 
-	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
-	if (IS_ERR(dev->msi_irq_groups)) {
-		ret = PTR_ERR(dev->msi_irq_groups);
+	groups = msi_populate_sysfs(&dev->dev);
+	if (IS_ERR(groups)) {
+		ret = PTR_ERR(groups);
 		goto out_free;
 	}
 
+	dev->msi_irq_groups = groups;
+
 	/* Set MSI-X enabled bits and unmask the function */
 	pci_intx_for_msi(dev, 0);
 	dev->msix_enabled = 1;
-- 
2.17.1

