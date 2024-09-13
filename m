Return-Path: <linux-pci+bounces-13145-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3BD7D9779E3
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 09:42:48 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5F2181C22330
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 07:42:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A51941BD01D;
	Fri, 13 Sep 2024 07:42:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="g9k0uXMD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D317E1B9847;
	Fri, 13 Sep 2024 07:42:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213352; cv=none; b=HjHDydTwV7ScL4VaAxq15T8ZYoeYF5/k1FFm/0w70Uqze1kr1DOsdmTq26UHkeXxObny9JcJFIIF8u802TvHRWb+mOVRaLYoaCgjey36uAOgbGM2YnQ1V52bIjAiJ7bHkrZJLI7sIo579Noa1AHAbdDllxljsAmwCXO9jS+pDY0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213352; c=relaxed/simple;
	bh=iSgue7/2lVBI93cC0NUABTZFK9oyhsYZ13HmAxW4f0s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=SQi76i4JSiEdmcNnyl22i7EYAAc5EdEbsQDJiCJUf9r8Zhku/lWakpf9edCoYVkCoNrJK6WftkISwCZYeye6f8KUOmYodyRrnak2gpugMrJP7LkJwy0gYUl09fHf3GUwvs1cGKkH4qexuEph7X7xeVA4XORWKELWs8osy917K9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=g9k0uXMD; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 1ADB0DACFB;
	Fri, 13 Sep 2024 09:42:26 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213346; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=vG3gSuOvrRnVYL3Q0mMe0eJlgwAG8lQwl7lw4ED2gbg=;
	b=g9k0uXMDSENB6diCbjm1KZhN5LwDWlSOwahO2toKe6DiIZaObeAf9tVewDu7h0N8pXaR72
	IwVKKYpm0Ls/1Y+eEX9Exr4HKYGHiyQaCgA32jPLDIGn9H7ZBkw8kSrvrkgFIa9fdxsLAY
	hKgPAPTi+QqEsQKblQ7sz+fml4wPuzTUgC7rVChbEVBtdDHH0d6HlRKav3Id2MEv0HjNSY
	Lq+DzfALt7nMGnP6E9g0XBlnCxORsXzkv9T+ATgoaidnCRKsmh80aVMC/bBWqwuGNCb8eQ
	QqGmOyBOx9KAs+BFHIR5yUJjKj/YjC/HLWVi209z3Eo+c7Pfp+X57XsY7u1S3Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 13 Sep 2024 09:41:59 +0200
Subject: [PATCH 1/6] blk-mq: introduce blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-1-8e058f77af12@suse.de>
References: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
In-Reply-To: <20240913-refactor-blk-affinity-helpers-v1-0-8e058f77af12@suse.de>
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
 Daniel Wagner <dwagner@suse.de>, 
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de, 
 Ming Lei <ming.lei@redhat.com>
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3

From: Ming Lei <ming.lei@redhat.com>

blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
hardware queue mapping based on affinity information. These two
function share code which only differs on how the affinity information
is retrieved. Also there is the hisi_sas which open codes the same loop.

Thus introduce a new helper function for creating these mappings which
takes an callback function for fetching the affinity mask. Also
introduce common helper function for PCI and virtio devices to retrieve
affinity masks.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
[dwagner: - removed fallback mapping
          - added affinity helpers (moved to pci/virtio)
          - updated commit message]
Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 block/blk-mq-cpumap.c   | 35 +++++++++++++++++++++++++++++++++++
 drivers/pci/pci.c       | 20 ++++++++++++++++++++
 drivers/virtio/virtio.c | 31 +++++++++++++++++++++++++++++++
 include/linux/blk-mq.h  |  5 +++++
 include/linux/pci.h     | 11 +++++++++++
 include/linux/virtio.h  | 13 +++++++++++++
 6 files changed, 115 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd521..c4993c0f822e 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -54,3 +54,38 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	return NUMA_NO_NODE;
 }
+
+/**
+ * blk_mq_hctx_map_queues - Create CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map.
+ * @dev_off:	Offset to use for the device.
+ * @dev_data:	Device data passed to get_queue_affinity().
+ * @get_queue_affinity:	Callback to retrieve queue affinity.
+ *
+ * Create a CPU to hardware queue mapping in @qmap. For each queue
+ * @get_queue_affinity will be called to retrieve the affinity for given
+ * queue.
+ */
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    void *dev_data, int dev_off,
+			    get_queue_affinty_fn *get_queue_affinity)
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		mask = get_queue_affinity(dev_data, dev_off, queue);
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
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e3a49f66982d..84f9c16b813b 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6370,6 +6370,26 @@ int pci_set_vga_state(struct pci_dev *dev, bool decode,
 	return 0;
 }
 
+#ifdef CONFIG_BLK_MQ_PCI
+/**
+ * pci_get_blk_mq_affinity - get affinity mask queue mapping for PCI device
+ * @dev_data:	Pointer to struct pci_dev.
+ * @offset:	Offset to use for the pci irq vector
+ * @queue:	Queue index
+ *
+ * This function returns for a queue the affinity mask for a PCI device.
+ * It is usually used as callback for blk_mq_hctx_map_queues().
+ */
+const struct cpumask *pci_get_blk_mq_affinity(void *dev_data, int offset,
+					      int queue)
+{
+	struct pci_dev *pdev = dev_data;
+
+	return pci_irq_get_affinity(pdev, offset + queue);
+}
+EXPORT_SYMBOL_GPL(pci_get_blk_mq_affinity);
+#endif
+
 #ifdef CONFIG_ACPI
 bool pci_pr3_present(struct pci_dev *pdev)
 {
diff --git a/drivers/virtio/virtio.c b/drivers/virtio/virtio.c
index a9b93e99c23a..21667309ca9a 100644
--- a/drivers/virtio/virtio.c
+++ b/drivers/virtio/virtio.c
@@ -592,6 +592,37 @@ int virtio_device_restore(struct virtio_device *dev)
 EXPORT_SYMBOL_GPL(virtio_device_restore);
 #endif
 
+const struct cpumask *virtio_get_vq_affinity(struct virtio_device *dev,
+		int index)
+{
+	if (!dev->config->get_vq_affinity)
+		return NULL;
+
+	return dev->config->get_vq_affinity(dev, index);
+}
+EXPORT_SYMBOL_GPL(virtio_get_vq_affinity);
+
+#ifdef CONFIG_BLK_MQ_VIRTIO
+/**
+ * virtio_get_blk_mq_affinity - get affinity mask queue mapping for
+ * virtio device
+ * @dev_data:	Pointer to struct virtio_device.
+ * @offset:	Offset to use for the virtio irq vector
+ * @queue:	Queue index
+ *
+ * This function returns for a queue the affinity mask for a virtio device.
+ * It is usually used as callback for blk_mq_hctx_map_queues().
+ */
+const struct cpumask *virtio_get_blk_mq_affinity(void *dev_data,
+						 int offset, int queue)
+{
+	struct virtio_device *vdev = dev_data;
+
+	return virtio_get_vq_affinity(vdev, offset + queue);
+}
+EXPORT_SYMBOL_GPL(virtio_get_blk_mq_affinity);
+#endif
+
 static int virtio_init(void)
 {
 	if (bus_register(&virtio_bus) != 0)
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 8d304b1d16b1..b9881a8794af 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -929,7 +929,12 @@ void blk_mq_freeze_queue_wait(struct request_queue *q);
 int blk_mq_freeze_queue_wait_timeout(struct request_queue *q,
 				     unsigned long timeout);
 
+typedef const struct cpumask *(get_queue_affinty_fn)(void *dev_data,
+		int dev_off, int queue_idx);
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    void *dev_data, int dev_off,
+			    get_queue_affinty_fn *get_queue_affinity);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 4cf89a4b4cbc..97f4797b5060 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -1633,6 +1633,17 @@ resource_size_t pcibios_window_alignment(struct pci_bus *bus,
 int pci_set_vga_state(struct pci_dev *pdev, bool decode,
 		      unsigned int command_bits, u32 flags);
 
+#ifdef CONFIG_BLK_MQ_PCI
+const struct cpumask *pci_get_blk_mq_affinity(void *dev_data,
+		int offset, int queue);
+#else
+static inline const struct cpumask *pci_get_blk_mq_affinity(void *dev_data,
+		int offset, int queue)
+{
+	return cpu_possible_mask;
+}
+#endif
+
 /*
  * Virtual interrupts allow for more interrupts to be allocated
  * than the device has interrupts for. These are not programmed
diff --git a/include/linux/virtio.h b/include/linux/virtio.h
index ecc5cb7b8c91..49d4f7353e5c 100644
--- a/include/linux/virtio.h
+++ b/include/linux/virtio.h
@@ -170,6 +170,19 @@ int virtio_device_restore(struct virtio_device *dev);
 void virtio_reset_device(struct virtio_device *dev);
 
 size_t virtio_max_dma_size(const struct virtio_device *vdev);
+const struct cpumask *virtio_get_vq_affinity(struct virtio_device *dev,
+					     int index);
+
+#ifdef CONFIG_BLK_MQ_VIRTIO
+const struct cpumask *virtio_get_blk_mq_affinity(void *dev_data,
+						 int offset, int queue);
+#else
+static inline const struct cpumask *virtio_get_blk_mq_affinity(void *dev_data,
+							       int offset, int queue)
+{
+	return cpu_possible_mask;
+}
+#endif
 
 #define virtio_device_for_each_vq(vdev, vq) \
 	list_for_each_entry(vq, &vdev->vqs, list)

-- 
2.46.0


