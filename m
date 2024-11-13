Return-Path: <linux-pci+bounces-16664-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2FA7B9C74F0
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:59:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E92EDB3620C
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:28:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D621420408C;
	Wed, 13 Nov 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ek8erP6u"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A4BDE20402F;
	Wed, 13 Nov 2024 14:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508002; cv=none; b=g2EANU0ee7Yf12kaZtJX3VBmQmHeHvykrVr7o6a0KczchCzW4OErR/TaOUwkOyxpNAApTVnjf4SaYodSw7FxBhtc39lSGzoPPJFI7VOMjeaM7xxptRl6B+EQzclnYBM+osMYhUO8j7eqUtz80gz+5sf41pOY74PtYgS004JTDcw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508002; c=relaxed/simple;
	bh=ofx9glE+KKfPfE3vbCUElyASjdPTiaZBTdjXeeRdot8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=kQMkh2C/pNN5wS3AGR1C693IKohHd9xa09qwbTzgPh12R+xDx/PhQweU/8KC3Pa68Cw/+o/5aO2gjW4Om7A5bt11abTP5rXs2pDr9x82zcGoXOQvDFATPXbojwfdP1n8Wo1AnCPk7rspiJ+uASLy4GMzu+Ui60x73CskGI8DQ9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ek8erP6u; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 98734C4CEE0;
	Wed, 13 Nov 2024 14:26:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508002;
	bh=ofx9glE+KKfPfE3vbCUElyASjdPTiaZBTdjXeeRdot8=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ek8erP6ujKVuchhURI/oUFZn12QoJ5X9uu8bOqQj6pi3xEWDjxi8WTIWaQwTB+2N/
	 MsQd+9NV0PGoCY1U8OFjhKaEPdasIHqYhxTdXZpX1LIRMxciFe7Mlz/YmCSZb/zlpY
	 oHkPamuOtIRmSmd0NOEd8FoTyOIpgVncnIVlhZnHnwXRIi7kWkJGFGHG/zFXbLc4wj
	 x9KdJ76gmPMyj8Q0RxGKU2fntpNCu3rb7WWJZGq5zIKbtgojQgvHIFZ6w6fOPa/21Y
	 eb0sxTMsUmABqtDJWEvAo+MomikiM2fnIC+u32CzJmU26TlWtKuuUkLl1HMBWsHdfX
	 WjpwEz896Ed8Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:19 +0100
Subject: [PATCH v4 05/10] blk-mq: introduce blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-5-dd3baa1e267f@kernel.org>
References: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
In-Reply-To: <20241113-refactor-blk-affinity-helpers-v4-0-dd3baa1e267f@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, John Garry <john.g.garry@oracle.com>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>, 
 Hannes Reinecke <hare@suse.de>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
hardware queue mapping based on affinity information. These two function
share common code and only differ on how the affinity information is
retrieved. Also, those functions are located in the block subsystem
where it doesn't really fit in. They are virtio and pci subsystem
specific.

Thus introduce provide a generic mapping function which uses the
irq_get_affinity callback from bus_type.

Originally idea from Ming Lei <ming.lei@redhat.com>

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 43 +++++++++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 45 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..3506f1c25a02d331d28212a2a97fb269cb21e738 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/device/bus.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -54,3 +55,45 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	return NUMA_NO_NODE;
 }
+
+/**
+ * blk_mq_hctx_map_queues - Create CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map.
+ * @dev:	The device to map queues.
+ * @offset:	Queue offset to use for the device.
+ *
+ * Create a CPU to hardware queue mapping in @qmap. The struct bus_type
+ * irq_get_affinity callback will be used to retrieve the affinity.
+ */
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    struct device *dev, unsigned int offset)
+
+{
+	const struct cpumask *(*irq_get_affinity)(struct device *dev,
+						  unsigned int irq_vec);
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	if (dev->driver->irq_get_affinity)
+		irq_get_affinity = dev->driver->irq_get_affinity;
+	else if (dev->bus->irq_get_affinity)
+		irq_get_affinity = dev->bus->irq_get_affinity;
+	else
+		goto fallback;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		mask = irq_get_affinity(dev, queue + offset);
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
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131fb60781957095ce8a3a941dd104be..1a85fdcb443c154390cd29f2b1f2a807bf10bfe3 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -923,6 +923,8 @@ void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_hctx_map_queues(struct blk_mq_queue_map *qmap,
+			    struct device *dev, unsigned int offset);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);

-- 
2.47.0


