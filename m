Return-Path: <linux-pci+bounces-16668-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 9C4539C748B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 3338AB3930B
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:30:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EB0AC206955;
	Wed, 13 Nov 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="hT05r/4A"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8E521E1322;
	Wed, 13 Nov 2024 14:26:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508012; cv=none; b=eR+YRHPiTb87F4jSt08sHd3DALJuZgxAcDroupnQldj7CF69As8NAbnLci7HVAh0GO5YkDiqy7XfYu1D8gwMQjB5xfe3Bq4WvRtIrs0pGPk1HVJCAb0JCBP7yJPdh4q5wZE/XQhQD3o/Q5aoCaqSlYltzFdLj8J5h79WGiRuEIQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508012; c=relaxed/simple;
	bh=isXEskRzOrDBOyqDhvTRJ3NN+y1s+4Y0sHaHLEiBMKs=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=RGB2FJeUmVMfLh7KDIofos06Y2gXe98BOq+6S43eaEHFwJgevxt3kUmvIMlPrJrKjxli3pGs5rDPeX8vfztHVwxO2kydqHuGQ9F0IfX5OUgEEUiVIfXHce3PQJTw0XgYcFOV2zb4EKfxyvm8fvm7Zw9/zH7KgsUrmspXEB9Uh7I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=hT05r/4A; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0434CC4CEDA;
	Wed, 13 Nov 2024 14:26:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508012;
	bh=isXEskRzOrDBOyqDhvTRJ3NN+y1s+4Y0sHaHLEiBMKs=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=hT05r/4Akowv5UVtw0lSdIZdgwiRCwwLCv37jl9XxNv88QiC9l9qLh04+1MhTwjMF
	 Q89DwJCvIqL4gy/gXSKsNyyLM3FgbQxKhkK9aX5TO7ZeP0QUjec5UtDvY8Aykt9C3c
	 sk0v58pnjGGhYWio6I0GJQimNu2fjyQlUOafzmBPOQ0Mkw76PluwMximYB/rL4kDWZ
	 JYV2sgYUvNtfCacR5AcE5D98hyOOHDNAV8O3boZcrPtV6YATTPNPW/mkFTRBlgMZg4
	 izs2ObNZN1IydzY0qO2la2uDSTTzlDgTB405FCkvadf9pPpINSKwX/MyT5gCJTMlVB
	 m8og4rB5WzOQQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:23 +0100
Subject: [PATCH v4 09/10] virtio: blk/scsi: replace
 blk_mq_virtio_map_queues with blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-9-dd3baa1e267f@kernel.org>
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

Replace all users of blk_mq_virtio_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_virtio_map_queues.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/block/virtio_blk.c | 4 ++--
 drivers/scsi/virtio_scsi.c | 3 +--
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 0e99a4714928478c1ba81777b8e98448eb5b992a..fd997e3381526eb3d7a21eda296b3a8a2998c696 100644
--- a/drivers/block/virtio_blk.c
+++ b/drivers/block/virtio_blk.c
@@ -13,7 +13,6 @@
 #include <linux/string_helpers.h>
 #include <linux/idr.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-virtio.h>
 #include <linux/numa.h>
 #include <linux/vmalloc.h>
 #include <uapi/linux/virtio_ring.h>
@@ -1186,7 +1185,8 @@ static void virtblk_map_queues(struct blk_mq_tag_set *set)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(&set->map[i]);
 		else
-			blk_mq_virtio_map_queues(&set->map[i], vblk->vdev, 0);
+			blk_mq_hctx_map_queues(&set->map[i],
+					       &vblk->vdev->dev, 0);
 	}
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8471f38b730e205eb57052305c154260864bee95..dcb83c15f90825bd7bdb3a5f541108b934a308f3 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -29,7 +29,6 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
-#include <linux/blk-mq-virtio.h>
 
 #include "sd.h"
 
@@ -746,7 +745,7 @@ static void virtscsi_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(map);
 		else
-			blk_mq_virtio_map_queues(map, vscsi->vdev, 2);
+			blk_mq_hctx_map_queues(map, &vscsi->vdev->dev, 2);
 	}
 }
 

-- 
2.47.0


