Return-Path: <linux-pci+bounces-16901-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2B4569CF201
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 17:47:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E5465B4820A
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 16:40:28 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A37EC1E1C2D;
	Fri, 15 Nov 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Zav2spHy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 721F91E1C18;
	Fri, 15 Nov 2024 16:38:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731688688; cv=none; b=HST/ZNMKLsYqiMkr8SOIqmDMgq2tJS4LB2K6OrDvjzqpAsoV15K6cleA5xNPvj1X6W2RvmP7sijIK6Pg9BqcFasKtUJ2b/IpNzuNXOHUF2J6XEy1zZ8pZDAAWUtvj6dhxzrCtorNbpI3QPYZ+lahMTuv2pEwh3SEept63vZeHKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731688688; c=relaxed/simple;
	bh=m5ZePzB+8Us6IHpc+rOQfkqZOqDq9hBJk0c2xvTeUYk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Od8AZRpl0fZ0mgy02KtnDbRdnz0UWwFDUJRsNLxwkvehNW43CH/lptT0P2g5T6dnp8bY380r0X+FMA9xDvIvPOB9NvJ7SqLMJT9WhBl0owIyCfiIY/P49u+YcREaadsuKAu1vAjmHLxUERRy/dfEt8OR0N9lFuPiRDX48L8/+zI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Zav2spHy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EE57DC4CECF;
	Fri, 15 Nov 2024 16:38:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731688688;
	bh=m5ZePzB+8Us6IHpc+rOQfkqZOqDq9hBJk0c2xvTeUYk=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Zav2spHy2oydWn1j23aX40bEOyjGgndZ/33nDDLz7/7RvQdILhf/DL/GBhGOWpjhw
	 zCYWQxUApVKhCgWpE1S52CpcX/z6NmLysW3zmqKQLF2rBSPLbjOn+halZrOV/UN/J8
	 Bf4xFWAX61pyN/VXpDfOSHG/vYMfJy+cAOk25QxhVUfmlLGhUs5uoIVwgCXU/mDZpS
	 hFuc1p+1GjarhLWyffI4O4Absl0x8cSW5NykaerveENndMhXRSGBGQ+TayFGuWSTRg
	 Xldv8vwG/ZEniTKtXEz1svZXbzABJRDT4NW1175hFuxRpKHyoFxv3qFjic1Y4ZCDgs
	 5SUivOAd5kcOQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Fri, 15 Nov 2024 17:37:50 +0100
Subject: [PATCH v5 6/8] nvme: replace blk_mq_pci_map_queues with
 blk_mq_map_hw_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241115-refactor-blk-affinity-helpers-v5-6-c472afd84d9f@kernel.org>
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

Replace all users of blk_mq_pci_map_queues with the more generic
blk_mq_map_hw_queues. This in preparation to retire
blk_mq_pci_map_queues.

Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Hannes Reinecke <hare@suse.de>
Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/nvme/host/fc.c  | 1 -
 drivers/nvme/host/pci.c | 3 +--
 2 files changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/nvme/host/fc.c b/drivers/nvme/host/fc.c
index b81af7919e94c421387033bf8361a9cf8a867486..094be164ffdc0fb79050cfb92c32dfaee8d15622 100644
--- a/drivers/nvme/host/fc.c
+++ b/drivers/nvme/host/fc.c
@@ -16,7 +16,6 @@
 #include <linux/nvme-fc.h>
 #include "fc.h"
 #include <scsi/scsi_transport_fc.h>
-#include <linux/blk-mq-pci.h>
 
 /* *************************** Data Structures/Defines ****************** */
 
diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 4b9fda0b1d9a33af4d7030b72532835b205e9cbb..be1ab319131dbb9735993e26dfe4813fb13182f6 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -8,7 +8,6 @@
 #include <linux/async.h>
 #include <linux/blkdev.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/blk-integrity.h>
 #include <linux/dmi.h>
 #include <linux/init.h>
@@ -457,7 +456,7 @@ static void nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 */
 		map->queue_offset = qoff;
 		if (i != HCTX_TYPE_POLL && offset)
-			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+			blk_mq_map_hw_queues(map, dev->dev, offset);
 		else
 			blk_mq_map_queues(map);
 		qoff += map->nr_queues;

-- 
2.47.0


