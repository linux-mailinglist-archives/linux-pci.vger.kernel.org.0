Return-Path: <linux-pci+bounces-16899-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 68A299CF240
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:59:41 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 94E48B469A4
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:39:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D76131DDC11;
	Fri, 15 Nov 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="qcIYGYNL"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A295F1D516D;
	Fri, 15 Nov 2024 16:38:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688683; cv=none; b=qZIIYdFEQCDBEmz2Ak0nil8sOalnhfUIPgKJP/NaNA8GNjXhJCdR4f7OQbf6lqX30O7h2yV1VDgZtKc6nVJ7rd3QuVfAJCyo3mwXTh7+tfVmLnA6iDwNlOG0S8KqAF7U0TetMD/m+rKkcejenwlEsolGfGfIoE84Iz3lwxy/rEs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688683; c=relaxed/simple;
	bh=owFprUiQ8V3pWLUEHKhBSc8Yr9y26u98AbYgkYoCcis=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=NzPc5YgWSs0VECDS6YwJP3y9m/NQIa1hu8yevO57iar3lPzl1dqMiPybQ7gjmWLJDWb2hsPh/xm8k6WjbOQxxvQTxvr5UqqyYIoM2MBFDZzyP/hrJDk4naA4mu2156kuHPg3xb6m9RfN+g/fJKRBdeD6Nb2htZ+cr3UNvCTCcVM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=qcIYGYNL; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D40EDC4CED7;
	Fri, 15 Nov 2024 16:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688683;
	bh=owFprUiQ8V3pWLUEHKhBSc8Yr9y26u98AbYgkYoCcis=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=qcIYGYNLO3UEKO+jMvaZIM034m/x0pQEvrKrBvvvMRIe7DADCI7mUemstxE5CtwLX
	 pUvYo6QR81+wJV3L4a9hSnPyeXFO8mTOBcqOYFSQRr6QMGC5K0VQ3leWY+1AcshEoy
	 sNnqqf9RPW56BhIdTfzcyTD3yDsRXB0jcSowfgrUseR0nZi/MzAsc8oXXkmAynFPrE
	 OCb6UNVbExyzI8Tpt4zSpijf9hihcEQkltlM3e98Ai5Q0tInV7ijDkXThHVKqj5GTp
	 tlrQxHU/7tMrPzGghjDBJ7hh6WLJTQAw3jLBh9TCLc7zEJDk0zsNRqG3JEd15Hd9Uw
	 HJcwUC5VIXSig==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:48 +0100
Subject: [PATCH v5 4/8] blk-mq: introduce blk_mq_map_hw_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-4-c472afd84d9f@kernel.org>
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

blk_mq_pci_map_queues and blk_mq_virtio_map_queues will create a CPU to
hardware queue mapping based on affinity information. These two function
share common code and only differ on how the affinity information is
retrieved. Also, those functions are located in the block subsystem
where it doesn't really fit in. They are virtio and pci subsystem
specific.

Thus introduce provide a generic mapping function which uses the
irq_get_affinity callback from bus_type.

Originally idea from Ming Lei <ming.lei@redhat.com>

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..0b65ffa5a183cc8e6697df4a16748eff15bfa8b3 100644
--- a/block/blk-mq-cpumap.c
+++ b/block/blk-mq-cpumap.c
@@ -11,6 +11,7 @@
 #include <linux/smp.h>
 #include <linux/cpu.h>
 #include <linux/group_cpus.h>
+#include <linux/device/bus.h>
 
 #include "blk.h"
 #include "blk-mq.h"
@@ -54,3 +55,39 @@ int blk_mq_hw_queue_to_node(struct blk_mq_queue_map *qmap, unsigned int index)
 
 	return NUMA_NO_NODE;
 }
+
+/**
+ * blk_mq_map_hw_queues - Create CPU to hardware queue mapping
+ * @qmap:	CPU to hardware queue map.
+ * @dev:	The device to map queues.
+ * @offset:	Queue offset to use for the device.
+ *
+ * Create a CPU to hardware queue mapping in @qmap. The struct bus_type
+ * irq_get_affinity callback will be used to retrieve the affinity.
+ */
+void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
+			  struct device *dev, unsigned int offset)
+
+{
+	const struct cpumask *mask;
+	unsigned int queue, cpu;
+
+	if (!dev->bus->irq_get_affinity)
+		goto fallback;
+
+	for (queue = 0; queue < qmap->nr_queues; queue++) {
+		mask = dev->bus->irq_get_affinity(dev, queue + offset);
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
+EXPORT_SYMBOL_GPL(blk_mq_map_hw_queues);
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 2035fad3131fb60781957095ce8a3a941dd104be..05f544a9ed873d2f96d72c18e124c94146f6943f 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -923,6 +923,8 @@ void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
+			  struct device *dev, unsigned int offset);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);

-- 
2.47.0


