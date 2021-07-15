Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id F30593C9E3F
	for <lists+linux-pci@lfdr.de>; Thu, 15 Jul 2021 14:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232170AbhGOMMO (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Jul 2021 08:12:14 -0400
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37266 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229973AbhGOMMO (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 15 Jul 2021 08:12:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1626350960;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1Nw+X27P2N0k1f/4Z+RbTJx7kTAVQrNvB7dNv3jx6hA=;
        b=ROLTUe4T4vYG6nPx6ZXHZfP0BixWBspAwN0nMKIvyGJ0rm7CW1Kn+E4FgePH4vygdzhwSb
        1EZuQ5kclLvsSRGNTprVUMKZJPN7WzJZkh7UFAf3lMp9DGEfnQTVHmWZvOeKsyZYAB3bxi
        WHSWNJJj9dXdfl2CwPJJGXOgU8xPIjE=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-400-5BQR0uGEN8iA2aClCvUJZA-1; Thu, 15 Jul 2021 08:09:12 -0400
X-MC-Unique: 5BQR0uGEN8iA2aClCvUJZA-1
Received: from smtp.corp.redhat.com (int-mx01.intmail.prod.int.phx2.redhat.com [10.5.11.11])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DDDB1804301;
        Thu, 15 Jul 2021 12:09:10 +0000 (UTC)
Received: from localhost (ovpn-12-61.pek2.redhat.com [10.72.12.61])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 74E3718A50;
        Thu, 15 Jul 2021 12:09:06 +0000 (UTC)
From:   Ming Lei <ming.lei@redhat.com>
To:     Jens Axboe <axboe@kernel.dk>, Christoph Hellwig <hch@lst.de>,
        linux-block@vger.kernel.org, linux-nvme@lists.infradead.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sagi Grimberg <sagi@grimberg.me>,
        Daniel Wagner <dwagner@suse.de>,
        Wen Xiong <wenxiong@us.ibm.com>,
        John Garry <john.garry@huawei.com>,
        Hannes Reinecke <hare@suse.de>,
        Keith Busch <kbusch@kernel.org>, Ming Lei <ming.lei@redhat.com>
Subject: [PATCH V4 2/3] blk-mq: mark if one queue map uses managed irq
Date:   Thu, 15 Jul 2021 20:08:43 +0800
Message-Id: <20210715120844.636968-3-ming.lei@redhat.com>
In-Reply-To: <20210715120844.636968-1-ming.lei@redhat.com>
References: <20210715120844.636968-1-ming.lei@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.11
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Retrieve this info via the field 'irq_affinity_managed' of 'struct
device' in queue map helpers.

Signed-off-by: Ming Lei <ming.lei@redhat.com>
---
 block/blk-mq-pci.c     | 1 +
 block/blk-mq-rdma.c    | 3 +++
 block/blk-mq-virtio.c  | 1 +
 include/linux/blk-mq.h | 3 ++-
 4 files changed, 7 insertions(+), 1 deletion(-)

diff --git a/block/blk-mq-pci.c b/block/blk-mq-pci.c
index b595a94c4d16..aa0bdb80d0ce 100644
--- a/block/blk-mq-pci.c
+++ b/block/blk-mq-pci.c
@@ -37,6 +37,7 @@ int blk_mq_pci_map_queues(struct blk_mq_queue_map *qmap, struct pci_dev *pdev,
 		for_each_cpu(cpu, mask)
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
+	qmap->use_managed_irq = pdev->dev.irq_affinity_managed;
 
 	return 0;
 
diff --git a/block/blk-mq-rdma.c b/block/blk-mq-rdma.c
index 14f968e58b8f..7b10d8bd2a37 100644
--- a/block/blk-mq-rdma.c
+++ b/block/blk-mq-rdma.c
@@ -36,6 +36,9 @@ int blk_mq_rdma_map_queues(struct blk_mq_queue_map *map,
 			map->mq_map[cpu] = map->queue_offset + queue;
 	}
 
+	/* So far RDMA doesn't use managed irq */
+	map->use_managed_irq = false;
+
 	return 0;
 
 fallback:
diff --git a/block/blk-mq-virtio.c b/block/blk-mq-virtio.c
index 7b8a42c35102..b57a0aa6d900 100644
--- a/block/blk-mq-virtio.c
+++ b/block/blk-mq-virtio.c
@@ -38,6 +38,7 @@ int blk_mq_virtio_map_queues(struct blk_mq_queue_map *qmap,
 		for_each_cpu(cpu, mask)
 			qmap->mq_map[cpu] = qmap->queue_offset + queue;
 	}
+	qmap->use_managed_irq = vdev->dev.irq_affinity_managed;
 
 	return 0;
 fallback:
diff --git a/include/linux/blk-mq.h b/include/linux/blk-mq.h
index 1d18447ebebc..d54a795ec971 100644
--- a/include/linux/blk-mq.h
+++ b/include/linux/blk-mq.h
@@ -192,7 +192,8 @@ struct blk_mq_hw_ctx {
 struct blk_mq_queue_map {
 	unsigned int *mq_map;
 	unsigned int nr_queues;
-	unsigned int queue_offset;
+	unsigned int queue_offset:31;
+	unsigned int use_managed_irq:1;
 };
 
 /**
-- 
2.31.1

