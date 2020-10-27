Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9CBFF29A9E4
	for <lists+linux-pci@lfdr.de>; Tue, 27 Oct 2020 11:41:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2898674AbgJ0KlA (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 27 Oct 2020 06:41:00 -0400
Received: from casper.infradead.org ([90.155.50.34]:37504 "EHLO
        casper.infradead.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2898508AbgJ0Kk5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 27 Oct 2020 06:40:57 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=KlzPY9vg25KLuvhfk+bBCH8bxcpI80B4G13ok9fipjQ=; b=kJigX4tDZPqJ/+PbHE2cYWwrGK
        6zek3pdtvGgT6HeBGfnF/d5gKLV8MbMTxSZoq/sHeGEZh74rKfdUeDoiGZuUMtaKDbwTeK3S5kFOy
        tVPG8UEA1XZ4tCaBrRpow9xQiGlal3GaND7FBssyL0leAyCj4n4idUOf8WTM1o0qakoJhWMtdVbma
        Z6f3sEiaKA6s2kWuz1CPzoUFy3+VjEAec0PQm/qTwOTnQdJ2bl6MNf4/bGJ9tFjAzFCCWCRc181lT
        CxutKxa+trkU0vpWXXPxu+S/K3QgWh4gt4ufNX+HGfZWH1XAOfu//vCv+PAMkcBxMpFDkO1IRrfFc
        op6XypOw==;
Received: from hch by casper.infradead.org with local (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kXMP6-0002BU-PK; Tue, 27 Oct 2020 10:40:37 +0000
Date:   Tue, 27 Oct 2020 10:40:36 +0000
From:   Christoph Hellwig <hch@infradead.org>
To:     Sherry Sun <sherry.sun@nxp.com>
Cc:     hch@infradead.org, gregkh@linuxfoundation.org,
        sudeep.dutt@intel.com, ashutosh.dixit@intel.com, arnd@arndb.de,
        kishon@ti.com, lorenzo.pieralisi@arm.com,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-imx@nxp.com, fugang.duan@nxp.com
Subject: Re: [PATCH V4 1/2] misc: vop: change the way of allocating vring and
 device page
Message-ID: <20201027104036.GA7054@infradead.org>
References: <20201026085335.30048-1-sherry.sun@nxp.com>
 <20201026085335.30048-2-sherry.sun@nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20201026085335.30048-2-sherry.sun@nxp.com>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by casper.infradead.org. See http://www.infradead.org/rpr.html
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

This looks much better, but we need to be careful to restore the
original vm_start / vm_end.  What do you think about the version below,
which also simplifies vop_mmap a lot (completely untested):

---
From 2de72bf7444ee187a7576962d746d482c5bdd593 Mon Sep 17 00:00:00 2001
From: Sherry Sun <sherry.sun@nxp.com>
Date: Mon, 26 Oct 2020 16:53:34 +0800
Subject: misc: vop: change the way of allocating vring and device page

Allocate vrings use dma_alloc_coherent is a common way in kernel. As the
memory interacted between two systems should use consistent memory to
avoid caching effects, same as device page memory.

The orginal way use __get_free_pages and dma_map_single to allocate and
map vring, but not use dma_sync_single_for_cpu/device api to sync the
changes of vring between EP and RC, which will cause memory
synchronization problem for those devices which don't support hardware
dma coherent.

Also change to use dma_mmap_coherent for mmap callback to map the device
page and vring memory to userspace.

Signed-off-by: Joakim Zhang <qiangqing.zhang@nxp.com>
Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/misc/mic/bus/vop_bus.h    |   2 +
 drivers/misc/mic/host/mic_boot.c  |   9 ++
 drivers/misc/mic/host/mic_main.c  |  43 +++-------
 drivers/misc/mic/vop/vop_vringh.c | 135 ++++++++++++------------------
 4 files changed, 77 insertions(+), 112 deletions(-)

diff --git a/drivers/misc/mic/bus/vop_bus.h b/drivers/misc/mic/bus/vop_bus.h
index 4fa02808c1e27d..e21c06aeda7a31 100644
--- a/drivers/misc/mic/bus/vop_bus.h
+++ b/drivers/misc/mic/bus/vop_bus.h
@@ -75,6 +75,7 @@ struct vop_driver {
  *                 node to add/remove/configure virtio devices.
  * @get_dp: Get access to the virtio device page used by the self
  *          node to add/remove/configure virtio devices.
+ * @dp_mmap: Map the virtio device page to userspace.
  * @send_intr: Send an interrupt to the peer node on a specified doorbell.
  * @remap: Map a buffer with the specified DMA address and length.
  * @unmap: Unmap a buffer previously mapped.
@@ -92,6 +93,7 @@ struct vop_hw_ops {
 	void (*ack_interrupt)(struct vop_device *vpdev, int num);
 	void __iomem * (*get_remote_dp)(struct vop_device *vpdev);
 	void * (*get_dp)(struct vop_device *vpdev);
+	int (*dp_mmap)(struct vop_device *vpdev, struct vm_area_struct *vma);
 	void (*send_intr)(struct vop_device *vpdev, int db);
 	void __iomem * (*remap)(struct vop_device *vpdev,
 				  dma_addr_t pa, size_t len);
diff --git a/drivers/misc/mic/host/mic_boot.c b/drivers/misc/mic/host/mic_boot.c
index 8cb85b8b3e199b..44ed918b49b4d2 100644
--- a/drivers/misc/mic/host/mic_boot.c
+++ b/drivers/misc/mic/host/mic_boot.c
@@ -89,6 +89,14 @@ static void *__mic_get_dp(struct vop_device *vpdev)
 	return mdev->dp;
 }
 
+static int __mic_dp_mmap(struct vop_device *vpdev, struct vm_area_struct *vma)
+{
+	struct mic_device *mdev = vpdev_to_mdev(&vpdev->dev);
+
+	return dma_mmap_coherent(&mdev->pdev->dev, vma, mdev->dp,
+				 mdev->dp_dma_addr, MIC_DP_SIZE);
+}
+
 static void __iomem *__mic_get_remote_dp(struct vop_device *vpdev)
 {
 	return NULL;
@@ -120,6 +128,7 @@ static struct vop_hw_ops vop_hw_ops = {
 	.ack_interrupt = __mic_ack_interrupt,
 	.next_db = __mic_next_db,
 	.get_dp = __mic_get_dp,
+	.dp_mmap = __mic_dp_mmap,
 	.get_remote_dp = __mic_get_remote_dp,
 	.send_intr = __mic_send_intr,
 	.remap = __mic_ioremap,
diff --git a/drivers/misc/mic/host/mic_main.c b/drivers/misc/mic/host/mic_main.c
index ea4608527ea04d..fab87a72a9a4a5 100644
--- a/drivers/misc/mic/host/mic_main.c
+++ b/drivers/misc/mic/host/mic_main.c
@@ -10,6 +10,7 @@
 #include <linux/module.h>
 #include <linux/pci.h>
 #include <linux/poll.h>
+#include <linux/dma-mapping.h>
 
 #include <linux/mic_common.h>
 #include "../common/mic_dev.h"
@@ -45,33 +46,6 @@ MODULE_DEVICE_TABLE(pci, mic_pci_tbl);
 /* ID allocator for MIC devices */
 static struct ida g_mic_ida;
 
-/* Initialize the device page */
-static int mic_dp_init(struct mic_device *mdev)
-{
-	mdev->dp = kzalloc(MIC_DP_SIZE, GFP_KERNEL);
-	if (!mdev->dp)
-		return -ENOMEM;
-
-	mdev->dp_dma_addr = mic_map_single(mdev,
-		mdev->dp, MIC_DP_SIZE);
-	if (mic_map_error(mdev->dp_dma_addr)) {
-		kfree(mdev->dp);
-		dev_err(&mdev->pdev->dev, "%s %d err %d\n",
-			__func__, __LINE__, -ENOMEM);
-		return -ENOMEM;
-	}
-	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev->dp_dma_addr);
-	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev->dp_dma_addr >> 32);
-	return 0;
-}
-
-/* Uninitialize the device page */
-static void mic_dp_uninit(struct mic_device *mdev)
-{
-	mic_unmap_single(mdev, mdev->dp_dma_addr, MIC_DP_SIZE);
-	kfree(mdev->dp);
-}
-
 /**
  * mic_ops_init: Initialize HW specific operation tables.
  *
@@ -227,11 +201,16 @@ static int mic_probe(struct pci_dev *pdev,
 
 	pci_set_drvdata(pdev, mdev);
 
-	rc = mic_dp_init(mdev);
-	if (rc) {
-		dev_err(&pdev->dev, "mic_dp_init failed rc %d\n", rc);
+	mdev->dp = dma_alloc_coherent(&pdev->dev, MIC_DP_SIZE,
+				      &mdev->dp_dma_addr, GFP_KERNEL);
+	if (!mdev->dp) {
+		dev_err(&pdev->dev, "failed to allocate device page\n");
 		goto smpt_uninit;
 	}
+
+	mdev->ops->write_spad(mdev, MIC_DPLO_SPAD, mdev->dp_dma_addr);
+	mdev->ops->write_spad(mdev, MIC_DPHI_SPAD, mdev->dp_dma_addr >> 32);
+
 	mic_bootparam_init(mdev);
 	mic_create_debug_dir(mdev);
 
@@ -244,7 +223,7 @@ static int mic_probe(struct pci_dev *pdev,
 	return 0;
 cleanup_debug_dir:
 	mic_delete_debug_dir(mdev);
-	mic_dp_uninit(mdev);
+	dma_free_coherent(&pdev->dev, MIC_DP_SIZE, mdev->dp, mdev->dp_dma_addr);
 smpt_uninit:
 	mic_smpt_uninit(mdev);
 free_interrupts:
@@ -283,7 +262,7 @@ static void mic_remove(struct pci_dev *pdev)
 
 	cosm_unregister_device(mdev->cosm_dev);
 	mic_delete_debug_dir(mdev);
-	mic_dp_uninit(mdev);
+	dma_free_coherent(&pdev->dev, MIC_DP_SIZE, mdev->dp, mdev->dp_dma_addr);
 	mic_smpt_uninit(mdev);
 	mic_free_interrupts(mdev, pdev);
 	iounmap(mdev->aper.va);
diff --git a/drivers/misc/mic/vop/vop_vringh.c b/drivers/misc/mic/vop/vop_vringh.c
index 7014ffe88632e5..6835648d577d57 100644
--- a/drivers/misc/mic/vop/vop_vringh.c
+++ b/drivers/misc/mic/vop/vop_vringh.c
@@ -298,9 +298,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		mutex_init(&vvr->vr_mutex);
 		vr_size = PAGE_ALIGN(round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4) +
 			sizeof(struct _mic_vring_info));
-		vr->va = (void *)
-			__get_free_pages(GFP_KERNEL | __GFP_ZERO,
-					 get_order(vr_size));
+		vr->va = dma_alloc_coherent(vop_dev(vdev), vr_size, &vr_addr,
+					    GFP_KERNEL);
 		if (!vr->va) {
 			ret = -ENOMEM;
 			dev_err(vop_dev(vdev), "%s %d err %d\n",
@@ -310,15 +309,6 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		vr->len = vr_size;
 		vr->info = vr->va + round_up(vring_size(num, MIC_VIRTIO_RING_ALIGN), 4);
 		vr->info->magic = cpu_to_le32(MIC_MAGIC + vdev->virtio_id + i);
-		vr_addr = dma_map_single(&vpdev->dev, vr->va, vr_size,
-					 DMA_BIDIRECTIONAL);
-		if (dma_mapping_error(&vpdev->dev, vr_addr)) {
-			free_pages((unsigned long)vr->va, get_order(vr_size));
-			ret = -ENOMEM;
-			dev_err(vop_dev(vdev), "%s %d err %d\n",
-				__func__, __LINE__, ret);
-			goto err;
-		}
 		vqconfig[i].address = cpu_to_le64(vr_addr);
 
 		vring_init(&vr->vr, num, vr->va, MIC_VIRTIO_RING_ALIGN);
@@ -339,11 +329,9 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 		dev_dbg(&vpdev->dev,
 			"%s %d index %d va %p info %p vr_size 0x%x\n",
 			__func__, __LINE__, i, vr->va, vr->info, vr_size);
-		vvr->buf = (void *)__get_free_pages(GFP_KERNEL,
-					get_order(VOP_INT_DMA_BUF_SIZE));
-		vvr->buf_da = dma_map_single(&vpdev->dev,
-					  vvr->buf, VOP_INT_DMA_BUF_SIZE,
-					  DMA_BIDIRECTIONAL);
+		vvr->buf = dma_alloc_coherent(vop_dev(vdev),
+					      VOP_INT_DMA_BUF_SIZE,
+					      &vvr->buf_da, GFP_KERNEL);
 	}
 
 	snprintf(irqname, sizeof(irqname), "vop%dvirtio%d", vpdev->index,
@@ -382,10 +370,8 @@ static int vop_virtio_add_device(struct vop_vdev *vdev,
 	for (j = 0; j < i; j++) {
 		struct vop_vringh *vvr = &vdev->vvr[j];
 
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[j].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+		dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr->vring.va,
+				  le64_to_cpu(vqconfig[j].address));
 	}
 	return ret;
 }
@@ -433,17 +419,12 @@ static void vop_virtio_del_device(struct vop_vdev *vdev)
 	for (i = 0; i < vdev->dd->num_vq; i++) {
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
-		dma_unmap_single(&vpdev->dev,
-				 vvr->buf_da, VOP_INT_DMA_BUF_SIZE,
-				 DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->buf,
-			   get_order(VOP_INT_DMA_BUF_SIZE));
+		dma_free_coherent(vop_dev(vdev), VOP_INT_DMA_BUF_SIZE,
+				  vvr->buf, vvr->buf_da);
 		vringh_kiov_cleanup(&vvr->riov);
 		vringh_kiov_cleanup(&vvr->wiov);
-		dma_unmap_single(&vpdev->dev, le64_to_cpu(vqconfig[i].address),
-				 vvr->vring.len, DMA_BIDIRECTIONAL);
-		free_pages((unsigned long)vvr->vring.va,
-			   get_order(vvr->vring.len));
+		dma_free_coherent(vop_dev(vdev), vvr->vring.len, vvr->vring.va,
+				  le64_to_cpu(vqconfig[i].address));
 	}
 	/*
 	 * Order the type update with previous stores. This write barrier
@@ -1042,13 +1023,27 @@ static __poll_t vop_poll(struct file *f, poll_table *wait)
 	return mask;
 }
 
-static inline int
-vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
-		 unsigned long *size, unsigned long *pa)
+/*
+ * Maps the device page and virtio rings to user space for readonly access.
+ */
+static int vop_mmap(struct file *f, struct vm_area_struct *vma)
 {
-	struct vop_device *vpdev = vdev->vpdev;
-	unsigned long start = MIC_DP_SIZE;
-	int i;
+	struct vop_vdev *vdev = f->private_data;
+	struct mic_vqconfig *vqconfig = mic_vq_config(vdev->dd);
+	unsigned long orig_start = vma->vm_start;
+	unsigned long orig_end = vma->vm_end;
+	int err, i;
+	
+	if (!vdev->vpdev->hw_ops->dp_mmap)
+		return -EINVAL;
+	if (vma->vm_pgoff)
+		return -EINVAL;
+	if (vma->vm_flags & VM_WRITE)
+		return -EACCES;
+
+	err = vop_vdev_inited(vdev);
+	if (err)
+		return err;
 
 	/*
 	 * MMAP interface is as follows:
@@ -1057,58 +1052,38 @@ vop_query_offset(struct vop_vdev *vdev, unsigned long offset,
 	 * 0x1000				first vring
 	 * 0x1000 + size of 1st vring		second vring
 	 * ....
+	 *
+	 * We manipulate vm_start/vm_end to trick dma_mmap_coherent into
+	 * performing partial mappings, which is a bit of a hack, but safe
+	 * while we are under mmap_lock().  Eventually this needs to be
+	 * replaced by a proper DMA layer API.
 	 */
-	if (!offset) {
-		*pa = virt_to_phys(vpdev->hw_ops->get_dp(vpdev));
-		*size = MIC_DP_SIZE;
-		return 0;
-	}
+	vma->vm_end = vma->vm_start + MIC_DP_SIZE;
+	err = vdev->vpdev->hw_ops->dp_mmap(vdev->vpdev, vma);
+	if (err)
+		goto out;
 
 	for (i = 0; i < vdev->dd->num_vq; i++) {
 		struct vop_vringh *vvr = &vdev->vvr[i];
 
-		if (offset == start) {
-			*pa = virt_to_phys(vvr->vring.va);
-			*size = vvr->vring.len;
-			return 0;
-		}
-		start += vvr->vring.len;
-	}
-	return -1;
-}
-
-/*
- * Maps the device page and virtio rings to user space for readonly access.
- */
-static int vop_mmap(struct file *f, struct vm_area_struct *vma)
-{
-	struct vop_vdev *vdev = f->private_data;
-	unsigned long offset = vma->vm_pgoff << PAGE_SHIFT;
-	unsigned long pa, size = vma->vm_end - vma->vm_start, size_rem = size;
-	int i, err;
+		vma->vm_start = vma->vm_end;
+		vma->vm_end += vvr->vring.len;
 
-	err = vop_vdev_inited(vdev);
-	if (err)
-		goto ret;
-	if (vma->vm_flags & VM_WRITE) {
-		err = -EACCES;
-		goto ret;
-	}
-	while (size_rem) {
-		i = vop_query_offset(vdev, offset, &size, &pa);
-		if (i < 0) {
-			err = -EINVAL;
-			goto ret;
-		}
-		err = remap_pfn_range(vma, vma->vm_start + offset,
-				      pa >> PAGE_SHIFT, size,
-				      vma->vm_page_prot);
+		err = -EINVAL;
+		if (vma->vm_end > orig_end)
+			goto out;
+		err = dma_mmap_coherent(vop_dev(vdev), vma, vvr->vring.va,
+					le64_to_cpu(vqconfig[i].address),
+					vvr->vring.len);
 		if (err)
-			goto ret;
-		size_rem -= size;
-		offset += size;
+			goto out;
 	}
-ret:
+out:
+	/*
+	 * Restore the original vma parameters.
+	 */
+	vma->vm_start = orig_start;
+	vma->vm_end = orig_end;
 	return err;
 }
 
-- 
2.28.0

