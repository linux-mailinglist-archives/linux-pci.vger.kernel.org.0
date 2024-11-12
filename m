Return-Path: <linux-pci+bounces-16533-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8CB49C5C08
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:36:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 2B4FBB2520D
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 13:29:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ADC2018452E;
	Tue, 12 Nov 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ilNPdlws"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7953117DFE4;
	Tue, 12 Nov 2024 13:26:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731418009; cv=none; b=flH6tmOTq+3rwZ0a6L60Er3j5ztHoaJst88aWDsASel2Nh/46DbozwFzWDTh1GzmzSAXz15y2mKJBk8o9BwxMq6F9FrgNjohl5NgBDOolkdCqljjqLsNb5F8FKGb92iU2GHH3U09FSmGjkFRNlH0ngcK0+60BFMmLZloXQ0d4iw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731418009; c=relaxed/simple;
	bh=RegDNRd/lr0MFK2+1vfE44AKVERDtzrWcNdGMCKSRKo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TRY9eOZuGLBS1KNHCM2tuVLyuMvA0r4vy2lzEn8Ny1GoPwd80UjkpH8J2p50Yld4Lnf4gWRNyDcEHpfHBoRE9tgw9nbZSGoSFCq7lU967PqLvHShhcv97MYcgrC5KjnIxoqB5WtXao5FWM04VPjBuREJzFf89rSm7ent+OiLkrY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ilNPdlws; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C8DBCC4CECD;
	Tue, 12 Nov 2024 13:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731418009;
	bh=RegDNRd/lr0MFK2+1vfE44AKVERDtzrWcNdGMCKSRKo=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=ilNPdlws7yXbQ8bmRsc/poGBJggAcDP154iwDc3+mmq/wDKTt7ura5T7CBGh+A1ki
	 sYnbpWptarwhStEMx+cbtyoZy7qfwVAczZyuUpKFCLKTQDfv9gm2DFDQ3hQCqhe0oA
	 dIGoqNrCf/XPEYG9OHebRwx64qmv0aNRWaZMZEKDXnSPy8Jspd0T62lng4pven29Kz
	 fnbDOB6h0iwEtEyg7hMiHonYxGdNYGlcvOaHwKgyHSzlXjaVmuZ3eQb/M218GS1H2T
	 HAohHWyTheMxsU6Pjb4nUhaxF9JPRC+euuu0DytXQ7HGKvWH1unH+G+ECY6DNoWTM1
	 gCYQUhLS8rf8Q==
From: Daniel Wagner <wagi@kernel.org>
Date: Tue, 12 Nov 2024 14:26:21 +0100
Subject: [PATCH v3 6/8] nvme: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241112-refactor-blk-affinity-helpers-v3-6-573bfca0cbd8@kernel.org>
References: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
In-Reply-To: <20241112-refactor-blk-affinity-helpers-v3-0-573bfca0cbd8@kernel.org>
To: Jens Axboe <axboe@kernel.dk>, Bjorn Helgaas <bhelgaas@google.com>, 
 "Michael S. Tsirkin" <mst@redhat.com>, Jason Wang <jasowang@redhat.com>, 
 Xuan Zhuo <xuanzhuo@linux.alibaba.com>, 
 =?utf-8?q?Eugenio_P=C3=A9rez?= <eperezma@redhat.com>, 
 "Martin K. Petersen" <martin.petersen@oracle.com>, 
 Keith Busch <kbusch@kernel.org>, Christoph Hellwig <hch@lst.de>, 
 Sagi Grimberg <sagi@grimberg.me>, 
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: linux-block@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-pci@vger.kernel.org, virtualization@lists.linux.dev, 
 linux-scsi@vger.kernel.org, megaraidlinux.pdl@broadcom.com, 
 mpi3mr-linuxdrv.pdl@broadcom.com, MPT-FusionLinux.pdl@broadcom.com, 
 storagedev@microchip.com, linux-nvme@lists.infradead.org, 
 Daniel Wagner <wagi@kernel.org>
X-Mailer: b4 0.14.2

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
index 4b9fda0b1d9a33af4d7030b72532835b205e9cbb..cb8ca574594d7eb5f959cf9eb03be445223b2666 100644
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
+			blk_mq_hctx_map_queues(map, dev->dev, offset);
 		else
 			blk_mq_map_queues(map);
 		qoff += map->nr_queues;

-- 
2.47.0


