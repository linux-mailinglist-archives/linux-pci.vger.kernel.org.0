Return-Path: <linux-pci+bounces-16461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 60AE29C450B
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 19:35:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 33B71B2837A
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 18:03:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3CE4F1AC89A;
	Mon, 11 Nov 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="O7VWKUmM"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0B8871AC447;
	Mon, 11 Nov 2024 18:02:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731348164; cv=none; b=MR0acV/VeIwtsB46gnDQcIM2b+6JpTdYQGad85+gSmuFgHRLySlixLaSMqC2CowOJnJ5/8bAfEIXXwrrFyVGtNfFGi2CAQVVR2DPM1ACqs0bb/Rq83WxsUGEFVGUCDwtxSC/v6R0BQSKEdVQsZ3Dl9Bt/9GmYAU5QS5uP7EoeWQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731348164; c=relaxed/simple;
	bh=9sP0iy9vNDvvulLRRTbPROgoFCL1cPRRjbHOX7L9p84=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=gVuldEs3DjSgXso+D3x/gTvdwj8v7eVA0aNGyHGFJFXseM8NvpsDNc1p6scXcn5rmoYmpoSftqDmcM0T08QnM4u/aA6Sj96kGkJfW4c8jmFXlyu3cWN75+mlCJ5ekHwoYl7faELkiwIjaW9rzv+D1ju5n/cKOx9A/rCteAzuWqE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=O7VWKUmM; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8DF57C4CED5;
	Mon, 11 Nov 2024 18:02:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731348163;
	bh=9sP0iy9vNDvvulLRRTbPROgoFCL1cPRRjbHOX7L9p84=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=O7VWKUmMXeZ7nUGRFniku/BXyk9vT5a5ksJLICMRhzu+Ax8h1/0Hoe0HqByE8WOwd
	 Mhw0T222KrPnK9Y7LRPxx7qJb6/rOQ9/htYyPHhzHQjN08N81opjfFjRQdvbSA4ZsD
	 pVnSE92OLZMGXaAUj/PWObivcIGmlV+ddC7H/krnQk8/lNkN6V9NTTTTyYPu2K8NFb
	 uOQ/WpJPyJqGSLuZMp9XH3Kw1CvbncOQp5agInR7Bn/1MEr+ozad2C6tZCe+KsyV/y
	 yfd0hGKKh0asKLmrSVJW7EDkTitfMdNf8b/vYTlRnjCDZBq5rYByqoe4pFj2p7+YFI
	 xxHSqhkjFf4HQ==
From: Daniel Wagner <wagi@kernel.org>
Date: Mon, 11 Nov 2024 19:02:11 +0100
Subject: [PATCH v2 3/6] scsi: hisi_sas: replace blk_mq_pci_map_queues with
 blk_mq_hctx_map_queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241111-refactor-blk-affinity-helpers-v2-3-f360ddad231a@kernel.org>
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

For his_sas_v2_hw.c needs its own callback for retrieving the affinity.
The generic bus_type get queue affinity callback is using
pci_irq_get_affinity and not irq_data_get_affinity_mask.

This allows it to replace the open code loop with
blk_mq_hctx_map_queues at least.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas.h       |  1 -
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 22 +++++++++++-----------
 drivers/scsi/hisi_sas/hisi_sas_v3_hw.c |  4 ++--
 3 files changed, 13 insertions(+), 14 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas.h b/drivers/scsi/hisi_sas/hisi_sas.h
index d223f482488fc6cebc2838e92ae7ec70fb4e1437..010479a354eeeb47bbee24102e450aa3b7ea6197 100644
--- a/drivers/scsi/hisi_sas/hisi_sas.h
+++ b/drivers/scsi/hisi_sas/hisi_sas.h
@@ -9,7 +9,6 @@
 
 #include <linux/acpi.h>
 #include <linux/blk-mq.h>
-#include <linux/blk-mq-pci.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/dmapool.h>
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 342d75f12051d28fb1a0692b45ff568dd5b6f814..fd2f63e64376d1a444efe511a3aaa0988d9747f2 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3372,7 +3372,7 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 	for (queue_no = 0; queue_no < hisi_hba->cq_nvecs; queue_no++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[queue_no];
 
-		cq->irq_no = hisi_hba->irq_map[queue_no + 96];
+		cq->irq_no = hisi_hba->irq_map[queue_no + CQ0_IRQ_INDEX];
 		rc = devm_request_threaded_irq(dev, cq->irq_no,
 					       cq_interrupt_v2_hw,
 					       cq_thread_v2_hw, IRQF_ONESHOT,
@@ -3549,21 +3549,21 @@ static const struct attribute_group *sdev_groups_v2_hw[] = {
 	NULL
 };
 
+static const struct cpumask *hisi_hba_get_queue_affinity(struct device *dev,
+							 unsigned int queue)
+{
+	struct hisi_hba *hba = dev->driver_data;
+
+	return irq_get_affinity_mask(hba->irq_map[queue]);
+}
+
 static void map_queues_v2_hw(struct Scsi_Host *shost)
 {
 	struct hisi_hba *hisi_hba = shost_priv(shost);
 	struct blk_mq_queue_map *qmap = &shost->tag_set.map[HCTX_TYPE_DEFAULT];
-	const struct cpumask *mask;
-	unsigned int queue, cpu;
 
-	for (queue = 0; queue < qmap->nr_queues; queue++) {
-		mask = irq_get_affinity_mask(hisi_hba->irq_map[96 + queue]);
-		if (!mask)
-			continue;
-
-		for_each_cpu(cpu, mask)
-			qmap->mq_map[cpu] = qmap->queue_offset + queue;
-	}
+	blk_mq_hctx_map_queues(qmap, hisi_hba->dev, CQ0_IRQ_INDEX,
+			       hisi_hba_get_queue_affinity);
 }
 
 static const struct scsi_host_template sht_v2_hw = {
diff --git a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
index 4cd3a3eab6f1c47c962565a74cd7284dad1db12e..031db7b744e6352eb23d0dcac2c4a947c56f63d1 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v3_hw.c
@@ -3322,8 +3322,8 @@ static void hisi_sas_map_queues(struct Scsi_Host *shost)
 		if (i == HCTX_TYPE_POLL)
 			blk_mq_map_queues(qmap);
 		else
-			blk_mq_pci_map_queues(qmap, hisi_hba->pci_dev,
-					      BASE_VECTORS_V3_HW);
+			blk_mq_hctx_map_queues(qmap, &hisi_hba->pci_dev->dev,
+					       BASE_VECTORS_V3_HW, NULL);
 		qoff += qmap->nr_queues;
 	}
 }

-- 
2.47.0


