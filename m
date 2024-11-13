Return-Path: <linux-pci+bounces-16666-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DF3E49C741E
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 15:29:35 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9C525283B95
	for <lists+linux-pci@lfdr.de>; Wed, 13 Nov 2024 14:29:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE534205AC8;
	Wed, 13 Nov 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="PrUHBpZy"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AE09C205AB8;
	Wed, 13 Nov 2024 14:26:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731508007; cv=none; b=AHyDWSjC09LyOI1RMqtI5GDhejRxyo0nFw7Sjg+MiJpHAEL1zZihSPuyfdEHysR2x0QmkhQFH7aq7gSj5g/UiqUFahvLjBVemNiu67B+0i9Z02D4sNr7p2LRMWRz2fdJRl8Vsx/qXhf3g9cdqyM7BQLoIXOu/cub1kfoFlc1PE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731508007; c=relaxed/simple;
	bh=SpNSH5ZDRrOAxRiK/olTF7iQajBiX0Xq/z1Pk/ry918=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=dH7Ni0oMjjkKxnBAQ7AxIPQMpH0OosWpjN7jvbYRFvq38vU+EZhXAQxgbT7JvsLyrzEz3zIxTKU9X+zIQcoNadj5oFOB1chmcJGZuF2N5S0Gy6G1jDYs8XHzi8BH26N9W8igAZN9jg+75NaywNKYdszy/oJSAYoUeHuBBW87m1E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=PrUHBpZy; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EB6DCC4CEC3;
	Wed, 13 Nov 2024 14:26:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1731508007;
	bh=SpNSH5ZDRrOAxRiK/olTF7iQajBiX0Xq/z1Pk/ry918=;
	h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
	b=PrUHBpZyfuiOxauRWic7uNSBd0YcOsQkPsaAQLQVOpmaUWq4oX6rVpQKr4NHcM0gu
	 Fmsl93jYMFkjDH8QJUmB/65Whp1YMFGRbKqb51U7hgi08YJq2Lo7B+FSucy8Myd/Wc
	 m37m34alBNH7ca5GMjbNeqdhjqcbzN8c5hjl0ybkfWlx0OOQ9StXfzMC/QYMMB2w3N
	 TW6Akra+rAyT1Ox1+6iQ2JDrzdw6mBeeulr/L/PlTwXRyZpDlT23iUUIDipmVNfGf6
	 WpRPWcCetr6Dsy04BMWVvkGWm6SE8w03UiwxHEG5HMWUHGoX9w0FyyjPoZRim4y1V4
	 4TIU+FkaVXcZw==
From: Daniel Wagner <wagi@kernel.org>
Date: Wed, 13 Nov 2024 15:26:21 +0100
Subject: [PATCH v4 07/10] scsi: hisi_sas: use blk_mq_hctx_map_queues to map
 queues
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20241113-refactor-blk-affinity-helpers-v4-7-dd3baa1e267f@kernel.org>
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

The PCI struct bus_type irq_get_affinity callback can't be used here as
hisi_sas v2 implements its own irq affinity code. Thus install a driver
specific irq_get_affinity callback. With this in place it's possible to
replace the open coded queue mapping with blk_mq_hctx_map_queues
function.

Signed-off-by: Daniel Wagner <wagi@kernel.org>
---
 drivers/scsi/hisi_sas/hisi_sas_v2_hw.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
index 342d75f12051d28fb1a0692b45ff568dd5b6f814..faa85fbf3e267cf883568d1808207e9a56c70674 100644
--- a/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
+++ b/drivers/scsi/hisi_sas/hisi_sas_v2_hw.c
@@ -3372,7 +3372,7 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 	for (queue_no = 0; queue_no < hisi_hba->cq_nvecs; queue_no++) {
 		struct hisi_sas_cq *cq = &hisi_hba->cq[queue_no];
 
-		cq->irq_no = hisi_hba->irq_map[queue_no + 96];
+		cq->irq_no = hisi_hba->irq_map[queue_no + COQ_IRQ_INDEX];
 		rc = devm_request_threaded_irq(dev, cq->irq_no,
 					       cq_interrupt_v2_hw,
 					       cq_thread_v2_hw, IRQF_ONESHOT,
@@ -3389,6 +3389,14 @@ static int interrupt_init_v2_hw(struct hisi_hba *hisi_hba)
 	return rc;
 }
 
+static const struct cpumask *hisi_sas_v2_irq_get_affinity(struct device *dev,
+							  unsigned int irq_vec)
+{
+	struct hisi_hba *hisi_hba = dev->driver_data;
+
+	return irq_get_affinity_mask(hisi_hba->irq_map[irq_vec]);
+}
+
 static int hisi_sas_v2_init(struct hisi_hba *hisi_hba)
 {
 	int rc;
@@ -3553,17 +3561,8 @@ static void map_queues_v2_hw(struct Scsi_Host *shost)
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
+	blk_mq_hctx_map_queues(qmap, hisi_hba->dev, CQ0_IRQ_INDEX);
 }
 
 static const struct scsi_host_template sht_v2_hw = {
@@ -3636,6 +3635,7 @@ static struct platform_driver hisi_sas_v2_driver = {
 		.name = DRV_NAME,
 		.of_match_table = sas_v2_of_match,
 		.acpi_match_table = ACPI_PTR(sas_v2_acpi_match),
+		.irq_get_affinity = hisi_sas_v2_irq_get_affinity,
 	},
 };
 

-- 
2.47.0


