Return-Path: <linux-pci+bounces-13149-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 227109779FC
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 09:44:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C795A1F27162
	for <lists+linux-pci@lfdr.de>; Fri, 13 Sep 2024 07:44:07 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A3B8A1BF31D;
	Fri, 13 Sep 2024 07:42:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b="xRrlIvUH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail.nearlyone.de (mail.nearlyone.de [49.12.199.46])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 05A761BDAAA;
	Fri, 13 Sep 2024 07:42:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=49.12.199.46
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726213356; cv=none; b=VSBQRA9oEAC1s5Wec1agwmhxjNXWa9mvIln1aLT1F/RZFMfbJc9utEJadm12aqaG8fe1/G//Da6sOYOQwi42V72pOYXp9yEMaAA6HWj8bVWUjp1DJtXCgg2G0O0r9fRcrzN/kMtiQvBwtvBmJOPaZAH0maWbS/Erfcn4GK6oYgc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726213356; c=relaxed/simple;
	bh=eCJukDXL2Y1Ub+Nm2VqcZDoMNddAeDg6igtqXvl9GQ4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=UJF/pFhryctMxXL8gV5R8IyI7yKjKbhaaR9ZLlajEKy5nPakZCWKiABNioqiCyBHwzr/gXI0RRxswgYv615gxWgK97QRXLmeGqFSrNB9umWtDzNOKiFmvV/4VwxIELbNM911pKcI1o7/WCybUE3uzFvTFS/Q20SbagFOdC84U5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org; spf=pass smtp.mailfrom=monom.org; dkim=pass (2048-bit key) header.d=monom.org header.i=@monom.org header.b=xRrlIvUH; arc=none smtp.client-ip=49.12.199.46
Authentication-Results: smtp.subspace.kernel.org; dmarc=fail (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=monom.org
Received: from [127.0.0.1] (localhost [127.0.0.1]) by localhost (Mailerdaemon) with ESMTPSA id 61DF8DAD44;
	Fri, 13 Sep 2024 09:42:32 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=monom.org; s=dkim;
	t=1726213353; h=from:subject:date:message-id:to:cc:mime-version:content-type:
	 content-transfer-encoding:in-reply-to:references;
	bh=S+QrFbJLNgdRlN6vTE2pZTkLQB59UGMjI7x5XrFCe8A=;
	b=xRrlIvUHUIy22fU/5q8MWNIoMLMBZ+JZT/XA49X/E6xxFO3ogxl+7HbQ7a1zewF6rlRep4
	VuZgy/zrZYXUyfgiOAw6aYWgBePPDGmUNuFc1ciVOcmWDAqIwZw2etzZJkfCbEjHgL+x3U
	Vz2RY9+8Ucatj+NjEylGa/3XUcDx0nwfS2Xk0STXN9hfE6Y04QAbBYsAdB8A/htJk2EQWb
	xAx+BoNjGf8haOauVqEj0oRbMx87zo88BjKZHH+u+aqCF/s7X+7qtRvVHgJD0eUsVzdBdn
	Zd5s3ttyDcfHS3Y8HtikSmlVxP30zTPICIw8D+fFKxofNxldkW17xru2VSghXg==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 13 Sep 2024 09:42:03 +0200
Subject: [PATCH 5/6] virtio: blk/scsi: replace blk_mq_virtio_map_queues
 with blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240913-refactor-blk-affinity-helpers-v1-5-8e058f77af12@suse.de>
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
 20240912-do-not-overwrite-pci-mapping-v1-1-85724b6cec49@suse.de
X-Mailer: b4 0.14.0
X-Last-TLS-Session-Version: TLSv1.3

From: Daniel Wagner <dwagner@suse.de>

Replace all users of blk_mq_virtio_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_virtio_map_queues.

Signed-off-by: Daniel Wagner <dwagner@suse.de>
---
 drivers/block/virtio_blk.c | 4 ++--
 drivers/scsi/virtio_scsi.c | 4 ++--
 2 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/block/virtio_blk.c b/drivers/block/virtio_blk.c
index 194417abc105..c3f4d1bdc0ef 100644
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
+			blk_mq_hctx_map_queues(&set->map[i], vblk->vdev, 0,
+					       virtio_get_blk_mq_affinity);
 	}
 }
 
diff --git a/drivers/scsi/virtio_scsi.c b/drivers/scsi/virtio_scsi.c
index 8471f38b730e..4104db7a6dff 100644
--- a/drivers/scsi/virtio_scsi.c
+++ b/drivers/scsi/virtio_scsi.c
@@ -29,7 +29,6 @@
 #include <scsi/scsi_tcq.h>
 #include <scsi/scsi_devinfo.h>
 #include <linux/seqlock.h>
-#include <linux/blk-mq-virtio.h>
 
 #include "sd.h"
 
@@ -746,7 +745,8 @@ static void virtscsi_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(map);
 		else
-			blk_mq_virtio_map_queues(map, vscsi->vdev, 2);
+			blk_mq_hctx_map_queues(map, vscsi->vdev, 2,
+					      virtio_get_blk_mq_affinity);
 	}
 }
 

-- 
2.46.0


