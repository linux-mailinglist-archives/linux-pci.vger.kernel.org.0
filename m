Return-Path: <linux-pci+bounces-16459-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id C1C589C445D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:03:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 819A4282C41
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:03:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B91421AAE08;
	Mon, 11 Nov 2024 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="tPlOtI08"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 862901AA7B9;
	Mon, 11 Nov 2024 18:02:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348159; cv=none; b=Mv8WaBF0jXj7EUa2ZCGMwXaW27TWl6GU/Ap1dOhpJMkDzIw13Nw4OGdHWaHn1kArq2tHZkXx15wya2tEpfWGpQh/aVXeQPseyJaIMD5wedXrT7IfouxDNrSkBEXAr/qSX4l/2El+SwQS3edBPChRBYZbuJTPa54PYxzPoGllzWk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348159; c=relaxed/simple;
	bh=mmnW/WydfD4NJklSfBY8igdZzRggi919xcCji69VW74=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=JPzXYOjam4DgFYhLpKuht86yZjDqy85L7DaV33rlT0xOn75+YZ4p2ylx4wruaAVuE1SC4BVHJdYVZVACNWYPUR3l4ZR7j7LWcuQ2f8UnWYzXSzXm9QC/QlimBG7jF78OJkn757fKW8VRvrjPSZtIJ75VJj/gWQ3qRpJNxLlcP1s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=tPlOtI08; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 87634C4CED4;
	Mon, 11 Nov 2024 18:02:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348159;
	bh=mmnW/WydfD4NJklSfBY8igdZzRggi919xcCji69VW74=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=tPlOtI08aSykS4NmAVqpbM8hhEvo0QiryvDpT6Sf5GHxpL3KfeHVAMbJcJ+MHBrqy
	 N4gCKMIYqZHJ6Z7M4He4Y63XkzmkedQxh7TGOCcjK24LT46buYjv4ve2qrkKH37Aj/
	 wIp7iKpG2kx782hJbGC9qF6mAlrKh+D/H3/+uoThs1bH43Sj5/TbTmQdbd10FGh4bF
	 tmPOVZQIvNr0083uWg5Ju/a+LFNWsqqdSZPe9hamw82MJw1D1nq9B8jZ2t7uxQfKOp
	 f9Z/qbpyL2uNWnI8/mVF+ZTG1NlefJDT0jqAuu/qqsvIm4ThmocQLD7aBHSDu/0zRE
	 6ONSqWBsmM15A==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:09 +0100
Subject: [PATCH v2 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-1-f360ddad231a@kernel.org>
References: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
In-Reply-To: <20241111-refactor-blk-affinity-helpers-v2-0-f360ddad231a@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <dwagner@suse.de>, Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
hardware queue mapping based on affinity information. These two function
share common code and only differ on how the affinity information is
retrieved. Also, those functions are located in the block subsystem
where it doesn't really fit in. They are virtio and pci subsystem
specific.

Introduce a new callback in struct bus_type to get the affinity mask.
The callbacks can then be populated by the subsystem directly.

All but one driver use the subsystem default affinity masks. hisi_sas v2
depends on a driver specific mapping, thus use the optional argument
get_queue_affinity to retrieve the mapping.

Original-by : Ming Lei <ming.lei@redhat.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c      | 40 ++++++++++++++++++++++++++++++++++++++++
 drivers/pci/pci-driver.c   | 16 ++++++++++++++++
 drivers/virtio/virtio.c    | 12 ++++++++++++
 include/linux/blk-mq.h     |  5 +++++
 include/linux/device/bus.h |  3 +++
 5 files changed, 76 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..4dd703f5ee647fd1ba0b14ca11ddfdefa98a9a25 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -54,3 +54,43 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	return NUMA_NO_NODE;
 }
+
+/**
+ * blk_mq_hctx_map_queues - Create CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map.
+ * @dev:	The device to map queues.
+ * @offset:	Queue offset to use for the device.
+ * @get_irq_affinity:	Optional callback to retrieve queue affinity.
+ *
+ * Create a CPU to hardware queue mapping in @qmap. For each queue
+ * @get_queue_affinity will be called. If @get_queue_affinity is not
+ * provided, then the bus_type irq_get_affinity callback will be
+ * used to retrieve the affinity.
+ */
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    struct device *dev, unsigned int offset,
+			    get_queue_affinity_fn *get_irq_affinity)
+{
+	const struct cpumask *mask = NULL;
+	unsigned int queue, cpu;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		if (get_irq_affinity)
+			mask = get_irq_affinity(dev, queue + offset);
+		else if (dev->bus->irq_get_affinity)
+			mask = dev->bus->irq_get_affinity(dev, queue + offset);
+
+		if (!mask)
+			goto fallback;
+
+		for_each_cpu(cpu, mask)
+			qmap->mq_map[cpu] = qmap->queue_offset + queue;
+	}
+
+	return;
+
+fallback:
+	WARN_ON_ONCE(qmap->nr_queues > 1);
+	blk_mq_clear_mq_map(qmap);
+}
+EXPORT_SYMBOL_GPL(blk_mq_hctx_map_queues);
diff --git a/drivers/pci/pci-driver.c b/drivers/pci/pci-driver.c
index 35270172c833186995aebdda6f95ab3ffd7c67a0..59e5f430a380285162a87bd1a9b392bba8066450 100644
--- a/drivers/pci/pci-driver.c
+++ b/drivers/pci/pci-driver.c
@@ -1670,6 +1670,21 @@ static void pci_dma_cleanup(struct device *dev)
 		iommu_device_unuse_default_domain(dev);
 }
 
+/**
+ * pci_device_irq_get_affinity - get affinity mask queue mapping for PCI device
+ * @dev: ptr to dev structure
+ * @irq_vec: interrupt vector number
+ *
+ * This function returns for a queue the affinity mask for a PCI device.
+ */
+static const struct cpumask *pci_device_irq_get_affinity(struct device *dev,
+					unsigned int irq_vec)
+{
+	struct pci_dev *pdev = to_pci_dev(dev);
+
+	return pci_irq_get_affinity(pdev, irq_vec);
+}
+
 const struct bus_type pci_bus_type = {
 	.name		= "pci",
 	.match		= pci_bus_match,
@@ -1677,6 +1692,7 @@ const struct bus_type pci_bus_type = {
 	.probe		= pci_device_probe,
 	.remove		= pci_device_remove,
 	.shutdown	= pci_device_shutdown,
+	.irq_get_affinity = pci_device_irq_get_affinity,
 	.dev_groups	= pci_dev_groups,
 	.bus_groups	= pci_bus_groups,
 	.drv_groups	= pci_drv_groups,
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index b9095751e43bb7db5fc991b0cc0979d2e86f7b9b..86390db7e74befa17c9fa146ab6b454bbae3b7f5 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -377,6 +377,17 @@ static void virtio_dev_remove(struct device *_d)
 	of_node_put(dev->dev.of_node);
 }
 
+static const struct cpumask *virtio_irq_get_affinity(struct device *_d,
+						     unsigned int irq_veq)
+{
+	struct virtio_device *dev = dev_to_virtio(_d);
+
+	if (!dev->config->get_vq_affinity)
+		return NULL;
+
+	return dev->config->get_vq_affinity(dev, irq_veq);
+}
+
 static const struct bus_type virtio_bus = {
 	.name  = "virtio",
 	.match = virtio_dev_match,
@@ -384,6 +395,7 @@ static const struct bus_type virtio_bus = {
 	.uevent = virtio_uevent,
 	.probe = virtio_dev_probe,
 	.remove = virtio_dev_remove,
+	.irq_get_affinity = virtio_irq_get_affinity,
 };
 
 int __register_virtio_driver(struct virtio_driver *driver, struct module *owner)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131fb60781957095ce8a3a941dd104be..6b40af77bf44afa7112d274b731b591f2a67d68c 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -922,7 +922,12 @@ int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
+typedef const struct cpumask *(get_queue_affinity_fn)(struct device *dev,
+						      unsigned int queue);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    struct device *dev, unsigned int offset,
+			    get_queue_affinity_fn *get_queue_affinity);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
diff --git a/include/linux/device/bus.h b/include/linux/device/bus.h
index cdc4757217f9bb4b36b5c3b8a48bab45737e44c5..b18658bce2c3819fc1cbeb38fb98391d56ec3317 100644
--- a/include/linux/device/bus.h
+++ b/include/linux/device/bus.h
@@ -48,6 +48,7 @@ struct fwnode_handle;
  *		will never get called until they do.
  * @remove:	Called when a device removed from this bus.
  * @shutdown:	Called at shut-down time to quiesce the device.
+ * @irq_get_affinity:	Get IRQ affinity mask for the device on this bus.
  *
  * @online:	Called to put the device back online (after offlining it).
  * @offline:	Called to put the device offline for hot-removal. May fail.
@@ -87,6 +88,8 @@ struct bus_type {
 	void (*sync_state)(struct device *dev);
 	void (*remove)(struct device *dev);
 	void (*shutdown)(struct device *dev);
+	const struct cpumask *(*irq_get_affinity)(struct device *dev,
+			unsigned int irq_vec);
 
 	int (*online)(struct device *dev);
 	int (*offline)(struct device *dev);

-- 
2.47.0


