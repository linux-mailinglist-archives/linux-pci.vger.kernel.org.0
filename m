Return-Path: <linux-pci+bounces-16462-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 11C5C9C446D
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:04:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CB6AE28110A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:04:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 27A5F1B5ED1;
	Mon, 11 Nov 2024 18:02:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="Bq3mErFB"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E63FC1B5820;
	Mon, 11 Nov 2024 18:02:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348167; cv=none; b=K+v85BNnlgImUcta2IWDkkV1pSmpkkWZ8MZ+OpyzVQWSzrGSb6cr9ZdmiovB8que6f2qkRjWpYdQWvroDLEdPz1iLqoF9WEbXgqPdGDZXCOwlqGNZWWplC7hLqgsQsDvec/vtUKo/M5EchkKHBSQIKbTEyZduEfNDoDpC/XOPaY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348167; c=relaxed/simple;
	bh=WAeDsicX+euuIW0kqweV/QZoBg2yhq9mlxveHEyExKw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=cKU0h6Aa3d9sSX0EgJUq8AdLo075llwqlch+ErZv+OO3iKW9tfCu23jICUYxc1B/By0cJAWtjUaL1XCWqrpFNJNe9jG8pjgBtv5CULKuypdS9MshhPYAF5+IMs8CTSdLC0QsLxrX3GLfNCh3gqDWrMO71U90ab61o+uQ/hKUQD4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=Bq3mErFB; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AE5EC4AF09;
	Mon, 11 Nov 2024 18:02:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348166;
	bh=WAeDsicX+euuIW0kqweV/QZoBg2yhq9mlxveHEyExKw=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=Bq3mErFBO211kbc9/EzMp4ADTv5smrPyzd3ptoGPx7LmVPB72o7SOjlJqdOm7fwcN
	 aKEYn11CpLFPdaHYl/wY87SF+596lyMZL1e+7iu1AgxSVu58E3vLN47tFsIoghG7P0
	 wmKG/tT0QdZVcRuFS5amZr+dK+F7GgxkNmixF94bbXT2tbFO2IjrmXohOPoZ5qfRGC
	 0DJXez0cshPfRmG9ty0jnODhXB2VrwL9lmfYSQYKDzOrhpiKDPYbhRJWRNZ35I4Zqj
	 8V32Z37iwUQK5qi4OoLGgtpKckEz1/6J1ji/3hXzubojvP1LcfSSJpEFpE0zO5WINi
	 DSt/tpJroFktA==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:12 +0100
Subject: [PATCH v2 4/6] nvme: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-4-f360ddad231a@kernel.org>
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

From: Daniel Wagner <dwagner@suse.de>

Replace all users of blk_mq_pci_map_queues with the more generic
blk_mq_hctx_map_queues. This in preparation to retire
blk_mq_pci_map_queues.

Reviewed-by: Christoph Hellwig <hch@lst.de>
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
index 4b9fda0b1d9a33af4d7030b72532835b205e9cbb..2180ad4797923422361615d1387c2b5d3181d0a4 100644
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
+			blk_mq_hctx_map_queues(map, dev->dev, offset, NULL);
 		else
 			blk_mq_map_queues(map);
 		qoff += map->nr_queues;

-- 
2.47.0


