Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A236C4288B0
	for <lists+linux-pci@lfdr.de>; Mon, 11 Oct 2021 10:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234889AbhJKIZD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Oct 2021 04:25:03 -0400
Received: from szxga08-in.huawei.com ([45.249.212.255]:25118 "EHLO
        szxga08-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235058AbhJKIZC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Oct 2021 04:25:02 -0400
Received: from dggemv704-chm.china.huawei.com (unknown [172.30.72.56])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4HSWwQ6fQ1z1DHVw;
        Mon, 11 Oct 2021 16:21:26 +0800 (CST)
Received: from kwepemm600001.china.huawei.com (7.193.23.3) by
 dggemv704-chm.china.huawei.com (10.3.19.47) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.8; Mon, 11 Oct 2021 16:23:01 +0800
Received: from huawei.com (10.175.104.82) by kwepemm600001.china.huawei.com
 (7.193.23.3) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2308.8; Mon, 11 Oct
 2021 16:23:00 +0800
From:   Wang Hai <wanghai38@huawei.com>
To:     <bhelgaas@google.com>, <maz@kernel.org>, <tglx@linutronix.de>,
        <song.bao.hua@hisilicon.com>, <gregkh@linuxfoundation.org>
CC:     <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI/MSI: fix page fault when msi_populate_sysfs() failed
Date:   Mon, 11 Oct 2021 16:40:49 +0800
Message-ID: <20211011084049.53643-1-wanghai38@huawei.com>
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
 virtio_dev_probe+0x1ed/0x2e0
 really_probe+0x1c7/0x400
 __driver_probe_device+0xa4/0x120
 driver_probe_device+0x32/0xe0
 __driver_attach+0xbf/0x130
 bus_for_each_dev+0xbb/0x110
 driver_attach+0x27/0x30
 bus_add_driver+0x1d9/0x270
 driver_register+0xa9/0x180
 register_virtio_driver+0x31/0x50
 p9_virtio_init+0x3c/0x1000 [9pnet_virtio]
 do_one_initcall+0x7b/0x380
 do_init_module+0x5f/0x21e
 load_module+0x265c/0x2c60
 __do_sys_finit_module+0xb0/0xf0
 __x64_sys_finit_module+0x1a/0x20
 do_syscall_64+0x34/0xb0
 entry_SYSCALL_64_after_hwframe+0x44/0xae

When populating msi_irqs sysfs failed in msi_capability_init() or
msix_capability_init(), dev->msi_irq_groups will point to ERR_PTR(...).
This will cause a page fault when destroying the wrong
dev->msi_irq_groups in free_msi_irqs().

Fix this by setting dev->msi_irq_groups to NULL when msi_populate_sysfs()
failed.

Fixes: 2f170814bdd2 ("genirq/msi: Move MSI sysfs handling from PCI to MSI core")
Reported-by: Hulk Robot <hulkci@huawei.com>
Signed-off-by: Wang Hai <wanghai38@huawei.com>
---
 drivers/pci/msi.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/msi.c b/drivers/pci/msi.c
index 0099a00af361..6f75db9f3be7 100644
--- a/drivers/pci/msi.c
+++ b/drivers/pci/msi.c
@@ -561,6 +561,7 @@ static int msi_capability_init(struct pci_dev *dev, int nvec,
 	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
 	if (IS_ERR(dev->msi_irq_groups)) {
 		ret = PTR_ERR(dev->msi_irq_groups);
+		dev->msi_irq_groups = NULL;
 		goto err;
 	}
 
@@ -733,6 +734,7 @@ static int msix_capability_init(struct pci_dev *dev, struct msix_entry *entries,
 	dev->msi_irq_groups = msi_populate_sysfs(&dev->dev);
 	if (IS_ERR(dev->msi_irq_groups)) {
 		ret = PTR_ERR(dev->msi_irq_groups);
+		dev->msi_irq_groups = NULL;
 		goto out_free;
 	}
 
-- 
2.17.1

