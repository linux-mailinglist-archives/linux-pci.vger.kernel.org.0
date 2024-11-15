Return-Path: <linux-pci+bounces-16903-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BDBF89CF1C5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:41:25 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 432BB1F210C4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:41:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D6F7E1E285A;
	Fri, 15 Nov 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="BBgurO4o"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9F75C1E2847;
	Fri, 15 Nov 2024 16:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688693; cv=none; b=qVXuO4YlOciYw8EwcJ8ocGUPbLUd+QUtdlJqrVI2tO8kl11GjITX92xeyhgg6p/w58YLPvqeOusgDuvpnOTL6nJhLpTC6ROKpQBkmCxlezIFzOZjOBDs8xbGlbF1Y/xic8Y9zRbHaiSISkhfynQHxvy2QX1nACrOS6kmRkIJ+Fs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688693; c=relaxed/simple;
	bh=BgQfHLSyHthatLD+HxapCxTxAdxlPMnbJAVKOVCApgQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LC3cK+/8FllR5uxvyA1MYs27KYUX2o58v6X/YZvBKmHVMqjduJ0WYvNTSckmBIW3R1vg9EHIqCL+XpPbnxLHYf+r4900ML1/hKkTdJnc6v9CLnUGolfwzZ4smQFA92riDbNIIfDvw0uYouO+HjbAHClyr+jkWXJ3gaeX1CZjMu0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=BBgurO4o; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D80BBC4CED0;
	Fri, 15 Nov 2024 16:38:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688693;
	bh=BgQfHLSyHthatLD+HxapCxTxAdxlPMnbJAVKOVCApgQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=BBgurO4oDoZZvyVE2K9IUtvT5eb28xNBSFLyGZnyHNbDqeM31c4CpnbIkKYh9Z/BZ
	 eNnRR/4XdrRFFbkUvYsbkTe6j2h/jkKWFnKJ+D32QYLKkGb1XGDyccQUuVq2MQUFua
	 plfzORwa9Mu0wRZq0arljETGGXVbBRrVFVxY+z8IadXgWJ5Uo1ZVvi8aSkhUmysKj7
	 7nQYg0jPOOYSA0QXJ1hvFMmVeefFQgmYYwiYYrA+QJTvPuQd7XBiJiB/WBDnYw4XJ2
	 WRXFolCFlObPXgwUYtO4jhtjjXhQFF92fXGAHdY17cS722wFwE3lA0TPCIuLjEmU28
	 JBcq0ARu8VtbQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:52 +0100
Subject: [PATCH v5 8/8] blk-mq: remove unused queue mapping helpers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-8-c472afd84d9f@kernel.org>
References: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
In-Reply-To: <20241115-refactor-blk-affinity-helpers-v5-0-c472afd84d9f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>, Ming Lei <ming.lei@redhat.com>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

There are no users left of the pci and virtio queue mapping helpers.
Thus remove them.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/Makefile                |  2 --
 block/blk-mq-pci.c            | 46 -------------------------------------------
 block/blk-mq-virtio.c         | 46 -------------------------------------------
 include/linux/blk-mq-pci.h    | 11 -----------
 include/linux/blk-mq-virtio.h | 11 -----------
 5 files changed, 116 deletions(-)

diff --git a/block/Makefile b/block/Makefile
index ddfd21c1a9ffc9c4f49efca9875bd8a1cbf81e4d..33748123710b368a1a3a7b099bbd90d27b24c69b 100644
--- a/block/Makefile
+++ b/block/Makefile
@@ -27,8 +27,6 @@ bfq-y				:= bfq-iosched.o bfq-wf2q.o bfq-cgroup.o
 obj-$(CONFIG_IOSCHED_BFQ)	+= bfq.o
 
 obj-$(CONFIG_BLK_DEV_INTEGRITY) += bio-integrity.o blk-integrity.o t10-pi.o
-obj-$(CONFIG_BLK_MQ_PCI)	+= blk-mq-pci.o
-obj-$(CONFIG_BLK_MQ_VIRTIO)	+= blk-mq-virtio.o
 obj-$(CONFIG_BLK_DEV_ZONED)	+= blk-zoned.o
 obj-$(CONFIG_BLK_WBT)		+= blk-wbt.o
 obj-$(CONFIG_BLK_DEBUG_FS)	+= blk-mq-debugfs.o
diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
deleted file mode 100644
index d47b5c73c9eb715be7627a2952ad0ef921dd5bc6..0000000000000000000000000000000000000000
--- a/block/blk-mq-pci.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2016 Christoph Hellwig.
- */
-#include <linux/kobject.h>
-#include <linux/blkdev.h>
-#include <linux/blk-mq-pci.h>
-#include <linux/pci.h>
-#include <linux/module.h>
-
-#include "blk-mq.h"
-
-/**
- * blk_mq_pci_map_queues - provide a default queue mapping for PCI device
- * @qmap:	CPU to hardware queue map.
- * @pdev:	PCI device associated with @set.
- * @offset:	Offset to use for the pci irq vector
- *
- * This function assumes the PCI device @pdev has at least as many available
- * interrupt vectors as @set has queues.  It will then query the vector
- * corresponding to each queue for it's affinity mask and built queue mapping
- * that maps a queue to the CPUs that have irq affinity for the corresponding
- * vector.
- */
-void blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
-			   int offset)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = pci_irq_get_affinity(pdev, queue + offset);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
-
-	return;
-
-fallback:
-	WARN_ON_ONCE(qmap->nr_queues > 1);
-	blk_mq_clear_mq_map(qmap);
-}
-EXPORT_SYMBOL_GPL(blk_mq_pci_map_queues);
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
deleted file mode 100644
index 68d0945c0b08a2be116125f46c3a56fcdb02aea8..0000000000000000000000000000000000000000
--- a/block/blk-mq-virtio.c
+++ /dev/null
@@ -1,46 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Copyright (c) 2016 Christoph Hellwig.
- */
-#include <linux/device.h>
-#include <linux/blk-mq-virtio.h>
-#include <linux/virtio_config.h>
-#include <linux/module.h>
-#include "blk-mq.h"
-
-/**
- * blk_mq_virtio_map_queues - provide a default queue mapping for virtio device
- * @qmap:	CPU to hardware queue map.
- * @vdev:	virtio device to provide a mapping for.
- * @first_vec:	first interrupt vectors to use for queues (usually 0)
- *
- * This function assumes the virtio device @vdev has at least as many available
- * interrupt vectors as @set has queues.  It will then query the vector
- * corresponding to each queue for it's affinity mask and built queue mapping
- * that maps a queue to the CPUs that have irq affinity for the corresponding
- * vector.
- */
-void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
-		struct virtio_device *vdev, int first_vec)
-{
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
-
-	if (!vdev->config->get_vq_affinity)
-		goto fallback;
-
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = vdev->config->get_vq_affinity(vdev, first_vec + queue);
-		if (!mask)
-			goto fallback;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
-
-	return;
-
-fallback:
-	blk_mq_map_queues(qmap);
-}
-EXPORT_SYMBOL_GPL(blk_mq_virtio_map_queues);
diff --git a/include/linux/blk-mq-pci.h b/include/linux/blk-mq-pci.h
deleted file mode 100644
index ca544e1d3508f34ab6e198b0bb17efe88de4d14d..0000000000000000000000000000000000000000
--- a/include/linux/blk-mq-pci.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_BLK_MQ_PCI_H
-#define _LINUX_BLK_MQ_PCI_H
-
-struct blk_mq_queue_map;
-struct pci_dev;
-
-void blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
-			   int offset);
-
-#endif /* _LINUX_BLK_MQ_PCI_H */
diff --git a/include/linux/blk-mq-virtio.h b/include/linux/blk-mq-virtio.h
deleted file mode 100644
index 13226e9b22dd53e4289d506d49c52671de036ee8..0000000000000000000000000000000000000000
--- a/include/linux/blk-mq-virtio.h
+++ /dev/null
@@ -1,11 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0 */
-#ifndef _LINUX_BLK_MQ_VIRTIO_H
-#define _LINUX_BLK_MQ_VIRTIO_H
-
-struct blk_mq_queue_map;
-struct virtio_device;
-
-void blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
-		struct virtio_device *vdev, int first_vec);
-
-#endif /* _LINUX_BLK_MQ_VIRTIO_H */

-- 
2.47.0


