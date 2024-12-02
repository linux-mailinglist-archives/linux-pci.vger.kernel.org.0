Return-Path: <linux-pci+bounces-17536-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id A58DC9E0437
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 15:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6BC6B282594
	for <lists+linux-pci@lfdr.de>; Mon,  2 Dec 2024 14:01:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 78DF1205AB7;
	Mon,  2 Dec 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="uvJ6nEla"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44253202F96;
	Mon,  2 Dec 2024 14:00:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733148037; cv=none; b=rcekcw/28V0Duo75i1L6i+THr1E7ZpoLW9CccXIZ3fIcXfJU7d5FUT9LatjtgQOfeOqWhhCsB3ZtHVkH1tj0luNKsSLFQQ4L6Awn42q/46NsNbqR1scOfaAK/+jg0NKJBZSrnKc4fxFNXMPHxMfv1tUOJBShJ1rgdReOpiJnffo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733148037; c=relaxed/simple;
	bh=oiRZfIMzG93CdE5+W1Yfh1LVTVWiPOGwTq77sR/QFhQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=YpqzDhsfmrL+GRDjDkSMPmBGy/XhCqvSXieBBSV5mAA9qqj11sa8zVuS2LaVam2TeqVrT6uST7VJmyVbU7wG7IECxV4Mt8TCWHQnhrW5g30Z/z7qBuP3V17cfD28D4filWh0hC0Luj4zEgzQB5d8DAt6d6Cymo6Cm3/FsIte4ME=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=uvJ6nEla; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B5E27C4CED1;
	Mon,  2 Dec 2024 14:00:36 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1733148037;
	bh=oiRZfIMzG93CdE5+W1Yfh1LVTVWiPOGwTq77sR/QFhQ=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=uvJ6nElaC/JBzCm2r6Q7yHyEoaBl9uNq8v1eit7MP25eKm26wgrZsfcqX9HPT7QzU
	 /RpfoUS+NWdHwqlZKQg/RduaYDLq3eLPM2YXVppR5OCgw4HB2/0WlKsnuwVXh2gWnz
	 x2TDK0d+6df/Lhyfq+SldGhQFl7l2059sgnhjwVxdTY6qtJKI/0nW3aEb/lZsuOn9y
	 l8ks3asmw50yvQ2c3/6pEH+1PwuPOlfkRX+eAvq39zF40YHbMnhGJR6ftlz14xsnzL
	 tB8I58g1b+oNF8itfATtXVpuxPkGkUb6aN1ZB8ZCXNRNcnDsQ6Xg0QXKpOZUi1Wa6h
	 SipYF94hZI1Lw==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 02 Dec 2024 15:00:12 +0100
Subject: [PATCH v6 4/8] blk-mq: introduce blk_mq_map_hw_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241202-refactor-blk-affinity-helpers-v6-4-27211e9c2cd5@kernel.org>
References: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
In-Reply-To: <20241202-refactor-blk-affinity-helpers-v6-0-27211e9c2cd5@kernel.org>
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
Reviewed-by: Ming Lei <ming.lei@redhat.com>
Reviewed-by: John Garry <john.g.garry@oracle.com>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 block/blk-mq-cpumap.c  | 37 +++++++++++++++++++++++++++++++++++++
 include/linux/blk-mq.h |  2 ++
 2 files changed, 39 insertions(+)

diff --git a/block/blk-mq-cpumap.c b/block/blk-mq-cpumap.c
index 9638b25fd52124f0173e968ebdca5f1fe0b42ad9..ad8d6a363f24ae11968b42f7bcfd6a719a0499b7 100644
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
+ * @qmap:	CPU to hardware queue map
+ * @dev:	The device to map queues
+ * @offset:	Queue offset to use for the device
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
index c596e0e4cb751ab00f2150cf086fcdc5ad32b02e..769eab6247d4921e574e0828ab41a580a5a9f2fe 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -921,6 +921,8 @@ void blk_mq_unfreeze_queue_non_owner(struct request_queue *q);
 void blk_freeze_queue_start_non_owner(struct request_queue *q);
 
 void blk_mq_map_queues(struct blk_mq_queue_map *qmap);
+void blk_mq_map_hw_queues(struct blk_mq_queue_map *qmap,
+			  struct device *dev, unsigned int offset);
 void blk_mq_update_nr_hw_queues(struct blk_mq_tag_set *set, int nr_hw_queues);
 
 void blk_mq_quiesce_queue_nowait(struct request_queue *q);

-- 
2.47.0


