Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D329E4C6B1
	for <lists+linux-pci@lfdr.de>; Thu, 20 Jun 2019 07:14:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725872AbfFTFOP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Jun 2019 01:14:15 -0400
Received: from mail-pg1-f196.google.com ([209.85.215.196]:36498 "EHLO
        mail-pg1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731545AbfFTFN6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Jun 2019 01:13:58 -0400
Received: by mail-pg1-f196.google.com with SMTP id f21so931143pgi.3
        for <linux-pci@vger.kernel.org>; Wed, 19 Jun 2019 22:13:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=endlessm-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Zwj6pgAx91kNYKKDkKkwVwInhzJr8JOsFqA27cQX0yg=;
        b=DsUCzuNwoq+s82zrDbpZ6P/+pskSxBDybu/8VtCsiUDpgLrVQFQxRohID+bwwOZDsl
         Ubh5ciW1UjRV7K6gJeAeQHtYVYg7dNojI7ywf+ASjVLdqnkl/ncm/2OKU+VtCXOH2hJ8
         2W67MSTp+/cGr7636Y+H15jCPIsdLjo9yfBBVoFpIyT4EWHEH5AxHNR1eH61fm4SDs68
         5ajpkq7Y8GBYGh6Jl+2QwgwY17vNkeg4d6JFNZA9gOEHiKl8E7aJyGDILcvODeWOUiUO
         /jJB0a6aR4Uw4VJoQfg+4HPCPaAp00J4WqDNapjsi6FkmVQ5anWMWbtL3t3H/EHF7oRe
         Q4Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Zwj6pgAx91kNYKKDkKkwVwInhzJr8JOsFqA27cQX0yg=;
        b=M6fEdiDPE3kQPMv1p2SRomARr5Et/ISklOCLp4zn5Mo/F07Eq/3oqzbZ5oUCNPaHd0
         66BAeaW0i77/fwNdTuUI1tFvg0qvBGTXFmqZRU9GgzISIJek8WFqPWAuKEt5Cjs7gfow
         F5Yp2EHrb6lN/KOtA0ZC5HjR0EuGetUGbbQb0RtUFg+e9VIFo+RYE4Rb3x97taVaGXSd
         uBMecoLT+5oq+//SajYLBKqIs/eCyZP2zZvdABt43TezjSITOJyDHT4RTRyLfZYQSdsB
         ZT0uzVAWqmLHcqJu94AYQlIrXydzvHi9wHOuHO5EEogdIyUVHCgdI39YaI8wtzR/IshX
         WWJQ==
X-Gm-Message-State: APjAAAVfH0AKbYDr9ShP9Zl158vtZ2AguLTObJqE/nvjeFG0ASD191JO
        s9YTU80YOf32bQQkcoBRuHtLMw==
X-Google-Smtp-Source: APXvYqz8lRzH76PxRjN8/H5sESe6sWft2hZvgBcc6QsytNXjQErqAx3GdiHgMbR6NHktxkhPrtmnKA==
X-Received: by 2002:a65:508b:: with SMTP id r11mr10762504pgp.387.1561007637598;
        Wed, 19 Jun 2019 22:13:57 -0700 (PDT)
Received: from limbo.local (123-204-46-122.static.seed.net.tw. [123.204.46.122])
        by smtp.gmail.com with ESMTPSA id j2sm26383423pfn.135.2019.06.19.22.13.54
        (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
        Wed, 19 Jun 2019 22:13:57 -0700 (PDT)
From:   Daniel Drake <drake@endlessm.com>
To:     axboe@kernel.dk, kbusch@kernel.org, hch@lst.de, sagi@grimberg.me
Cc:     linux-nvme@lists.infradead.org, linux-pci@vger.kernel.org,
        bhelgaas@google.com, linux-ide@vger.kernel.org, linux@endlessm.com,
        linux-kernel@vger.kernel.org, hare@suse.de,
        alex.williamson@redhat.com, dan.j.williams@intel.com
Subject: [PATCH v2 3/5] nvme: introduce nvme_dev_ops
Date:   Thu, 20 Jun 2019 13:13:31 +0800
Message-Id: <20190620051333.2235-4-drake@endlessm.com>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20190620051333.2235-1-drake@endlessm.com>
References: <20190620051333.2235-1-drake@endlessm.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In preparation for a platform device nvme driver, move the bus specific
portions of nvme to nvme_dev_ops, or otherwise rewrite routines to use a
generic 'struct device' instead of 'struct pci_dev'.

Based on earlier work by Dan Williams.

Signed-off-by: Daniel Drake <drake@endlessm.com>
---
 drivers/nvme/host/pci.c | 410 +++++++++++++++++++++++++++-------------
 1 file changed, 275 insertions(+), 135 deletions(-)

 I took Dan William's earlier patch here and refreshed it for the
latest nvme driver, which has gained a few more places where it uses
the PCI device, so nvme_dev_ops grew a bit more.

Is this a suitable way of handling this case? It feels a little
unclean to have both the NVMe host layer and the PCI-specific dev ops
in the same file. Maybe it makes sense because NVMe is inherently a PCI
thing under normal circumstances? Or would it be cleaner for me to
rename "pci.c" to "mmio.c" and then separate the pci dev ops into
a new "pci.c"?

diff --git a/drivers/nvme/host/pci.c b/drivers/nvme/host/pci.c
index 42990b93349d..23bda524f16b 100644
--- a/drivers/nvme/host/pci.c
+++ b/drivers/nvme/host/pci.c
@@ -89,10 +89,51 @@ struct nvme_queue;
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown);
 static bool __nvme_disable_io_queues(struct nvme_dev *dev, u8 opcode);
 
+struct nvme_dev_ops {
+	/* Enable device (required) */
+	int (*enable)(struct nvme_dev *dev);
+
+	/* Disable device (required) */
+	void (*disable)(struct nvme_dev *dev);
+
+	/* Allocate IRQ vectors for given number of io queues (required) */
+	int (*setup_irqs)(struct nvme_dev *dev, int nr_io_queues);
+
+	/* Get the IRQ vector for a specific queue */
+	int (*q_irq)(struct nvme_queue *q);
+
+	/* Allocate device-specific SQ command buffer (optional) */
+	int (*cmb_alloc_sq_cmds)(struct nvme_queue *nvmeq, size_t size,
+				 struct nvme_command **sq_cmds,
+				 dma_addr_t *sq_dma_addr);
+
+	/* Free device-specific SQ command buffer (optional) */
+	void (*cmb_free_sq_cmds)(struct nvme_queue *nvmeq,
+				 struct nvme_command *sq_cmds, size_t size);
+
+	/* Device-specific mapping of blk queues to CPUs (optional) */
+	int (*map_queues)(struct nvme_dev *dev, struct blk_mq_queue_map *map,
+			  int offset);
+
+	/* Check if device is enabled on the bus (required) */
+	int (*is_enabled)(struct nvme_dev *dev);
+
+	/* Check if channel is in running state (required) */
+	int (*is_offline)(struct nvme_dev *dev);
+
+	/* Check if device is present and responding (optional) */
+	bool (*is_present)(struct nvme_dev *dev);
+
+	/* Check & log device state before it gets reset (optional) */
+	void (*warn_reset)(struct nvme_dev *dev);
+};
+
 /*
  * Represents an NVM Express device.  Each nvme_dev is a PCI function.
  */
 struct nvme_dev {
+	const struct resource *res;
+	const struct nvme_dev_ops *ops;
 	struct nvme_queue *queues;
 	struct blk_mq_tag_set tagset;
 	struct blk_mq_tag_set admin_tagset;
@@ -178,6 +219,7 @@ static inline struct nvme_dev *to_nvme_dev(struct nvme_ctrl *ctrl)
  */
 struct nvme_queue {
 	struct nvme_dev *dev;
+	char irqname[24];	/* nvme4294967295-65535\0 */
 	spinlock_t sq_lock;
 	struct nvme_command *sq_cmds;
 	 /* only used for poll queues: */
@@ -384,6 +426,11 @@ static unsigned int nvme_pci_iod_alloc_size(struct nvme_dev *dev,
 	return alloc_size + sizeof(struct scatterlist) * nseg;
 }
 
+static int nvme_pci_q_irq(struct nvme_queue *nvmeq)
+{
+	return pci_irq_vector(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector);
+}
+
 static int nvme_admin_init_hctx(struct blk_mq_hw_ctx *hctx, void *data,
 				unsigned int hctx_idx)
 {
@@ -444,7 +491,14 @@ static int queue_irq_offset(struct nvme_dev *dev)
 	return 0;
 }
 
-static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
+static int nvme_pci_map_queues(struct nvme_dev *dev,
+			       struct blk_mq_queue_map *map,
+			       int offset)
+{
+	return blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+}
+
+static int nvme_map_queues(struct blk_mq_tag_set *set)
 {
 	struct nvme_dev *dev = set->driver_data;
 	int i, qoff, offset;
@@ -464,8 +518,8 @@ static int nvme_pci_map_queues(struct blk_mq_tag_set *set)
 		 * affinity), so use the regular blk-mq cpu mapping
 		 */
 		map->queue_offset = qoff;
-		if (i != HCTX_TYPE_POLL && offset)
-			blk_mq_pci_map_queues(map, to_pci_dev(dev->dev), offset);
+		if (i != HCTX_TYPE_POLL && offset && dev->ops->map_queues)
+			dev->ops->map_queues(dev, map, offset);
 		else
 			blk_mq_map_queues(map);
 		qoff += map->nr_queues;
@@ -1068,7 +1122,7 @@ static irqreturn_t nvme_irq_check(int irq, void *data)
  */
 static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 {
-	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
+	struct nvme_dev *dev = nvmeq->dev;
 	u16 start, end;
 	int found;
 
@@ -1082,9 +1136,9 @@ static int nvme_poll_irqdisable(struct nvme_queue *nvmeq, unsigned int tag)
 		found = nvme_process_cq(nvmeq, &start, &end, tag);
 		spin_unlock(&nvmeq->cq_poll_lock);
 	} else {
-		disable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+		disable_irq(dev->ops->q_irq(nvmeq));
 		found = nvme_process_cq(nvmeq, &start, &end, tag);
-		enable_irq(pci_irq_vector(pdev, nvmeq->cq_vector));
+		enable_irq(dev->ops->q_irq(nvmeq));
 	}
 
 	nvme_complete_cqes(nvmeq, start, end);
@@ -1232,7 +1286,7 @@ static bool nvme_should_reset(struct nvme_dev *dev, u32 csts)
 	return true;
 }
 
-static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
+static void nvme_pci_warn_reset(struct nvme_dev *dev)
 {
 	/* Read a config register to help see what died. */
 	u16 pci_status;
@@ -1241,13 +1295,10 @@ static void nvme_warn_reset(struct nvme_dev *dev, u32 csts)
 	result = pci_read_config_word(to_pci_dev(dev->dev), PCI_STATUS,
 				      &pci_status);
 	if (result == PCIBIOS_SUCCESSFUL)
-		dev_warn(dev->ctrl.device,
-			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS=0x%hx\n",
-			 csts, pci_status);
+		dev_warn(dev->ctrl.device, "PCI_STATUS=0x%hx\n", pci_status);
 	else
 		dev_warn(dev->ctrl.device,
-			 "controller is down; will reset: CSTS=0x%x, PCI_STATUS read failed (%d)\n",
-			 csts, result);
+			 "PCI_STATUS read failed (%d)\n", result);
 }
 
 static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
@@ -1263,14 +1314,18 @@ static enum blk_eh_timer_return nvme_timeout(struct request *req, bool reserved)
 	 * the recovery mechanism will surely fail.
 	 */
 	mb();
-	if (pci_channel_offline(to_pci_dev(dev->dev)))
+	if (dev->ops->is_offline(dev))
 		return BLK_EH_RESET_TIMER;
 
 	/*
 	 * Reset immediately if the controller is failed
 	 */
 	if (nvme_should_reset(dev, csts)) {
-		nvme_warn_reset(dev, csts);
+		dev_warn(dev->ctrl.device,
+			 "controller is down; will reset: CSTS=0x%x\n",
+			 csts);
+		if (dev->ops->warn_reset)
+			dev->ops->warn_reset(dev);
 		nvme_dev_disable(dev, false);
 		nvme_reset_ctrl(&dev->ctrl);
 		return BLK_EH_DONE;
@@ -1367,8 +1422,8 @@ static void nvme_free_queue(struct nvme_queue *nvmeq)
 		return;
 
 	if (test_and_clear_bit(NVMEQ_SQ_CMB, &nvmeq->flags)) {
-		pci_free_p2pmem(to_pci_dev(nvmeq->dev->dev),
-				nvmeq->sq_cmds, SQ_SIZE(nvmeq->q_depth));
+		nvmeq->dev->ops->cmb_free_sq_cmds(nvmeq, nvmeq->sq_cmds,
+						  SQ_SIZE(nvmeq->q_depth));
 	} else {
 		dma_free_coherent(nvmeq->dev->dev, SQ_SIZE(nvmeq->q_depth),
 				nvmeq->sq_cmds, nvmeq->sq_dma_addr);
@@ -1401,7 +1456,7 @@ static int nvme_suspend_queue(struct nvme_queue *nvmeq)
 	if (!nvmeq->qid && nvmeq->dev->ctrl.admin_q)
 		blk_mq_quiesce_queue(nvmeq->dev->ctrl.admin_q);
 	if (!test_and_clear_bit(NVMEQ_POLLED, &nvmeq->flags))
-		pci_free_irq(to_pci_dev(nvmeq->dev->dev), nvmeq->cq_vector, nvmeq);
+		free_irq(nvmeq->dev->ops->q_irq(nvmeq), nvmeq);
 	return 0;
 }
 
@@ -1449,19 +1504,49 @@ static int nvme_cmb_qdepth(struct nvme_dev *dev, int nr_io_queues,
 	return q_depth;
 }
 
-static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
-				int qid, int depth)
+static int nvme_pci_cmb_alloc_sq_cmds(struct nvme_queue *nvmeq,
+				      size_t size,
+				      struct nvme_command **sq_cmds,
+				      dma_addr_t *sq_dma_addr)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
+	struct nvme_command *cmds;
+	dma_addr_t dma_addr;
 
-	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)) {
-		nvmeq->sq_cmds = pci_alloc_p2pmem(pdev, SQ_SIZE(depth));
-		nvmeq->sq_dma_addr = pci_p2pmem_virt_to_bus(pdev,
-						nvmeq->sq_cmds);
-		if (nvmeq->sq_dma_addr) {
-			set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
-			return 0; 
-		}
+	cmds = pci_alloc_p2pmem(pdev, size);
+	if (!cmds)
+		return -ENOMEM;
+
+	dma_addr = pci_p2pmem_virt_to_bus(pdev, cmds);
+	if (!dma_addr) {
+		pci_free_p2pmem(pdev, cmds, size);
+		return -EIO;
+	}
+
+	*sq_cmds = cmds;
+	*sq_dma_addr = dma_addr;
+	return 0;
+}
+
+static void nvme_pci_cmb_free_sq_cmds(struct nvme_queue *nvmeq,
+				     struct nvme_command *sq_cmds,
+				     size_t size)
+{
+	pci_free_p2pmem(to_pci_dev(nvmeq->dev->dev), sq_cmds, size);
+}
+
+static int nvme_alloc_sq_cmds(struct nvme_dev *dev, struct nvme_queue *nvmeq,
+			      int qid, int depth)
+{
+	if (qid && dev->cmb_use_sqes && (dev->cmbsz & NVME_CMBSZ_SQS)
+			&& dev->ops->cmb_alloc_sq_cmds
+			&& dev->ops->cmb_alloc_sq_cmds(nvmeq,
+						       SQ_SIZE(depth),
+						       &nvmeq->sq_cmds,
+						       &nvmeq->sq_dma_addr)
+				== 0) {
+		set_bit(NVMEQ_SQ_CMB, &nvmeq->flags);
+		return 0;
 	}
 
 	nvmeq->sq_cmds = dma_alloc_coherent(dev->dev, SQ_SIZE(depth),
@@ -1487,6 +1572,8 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 		goto free_cqdma;
 
 	nvmeq->dev = dev;
+	snprintf(nvmeq->irqname, sizeof(nvmeq->irqname), "nvme%dq%d",
+		 dev->ctrl.instance, qid);
 	spin_lock_init(&nvmeq->sq_lock);
 	spin_lock_init(&nvmeq->cq_poll_lock);
 	nvmeq->cq_head = 0;
@@ -1507,16 +1594,16 @@ static int nvme_alloc_queue(struct nvme_dev *dev, int qid, int depth)
 
 static int queue_request_irq(struct nvme_queue *nvmeq)
 {
-	struct pci_dev *pdev = to_pci_dev(nvmeq->dev->dev);
-	int nr = nvmeq->dev->ctrl.instance;
+	struct nvme_dev *dev = nvmeq->dev;
 
-	if (use_threaded_interrupts) {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq_check,
-				nvme_irq, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	} else {
-		return pci_request_irq(pdev, nvmeq->cq_vector, nvme_irq,
-				NULL, nvmeq, "nvme%dq%d", nr, nvmeq->qid);
-	}
+	if (use_threaded_interrupts)
+		return request_threaded_irq(dev->ops->q_irq(nvmeq),
+					    nvme_irq_check, nvme_irq,
+					    IRQF_SHARED, nvmeq->irqname,
+					    nvmeq);
+	else
+		return request_irq(dev->ops->q_irq(nvmeq), nvme_irq,
+				   IRQF_SHARED, nvmeq->irqname, nvmeq);
 }
 
 static void nvme_init_queue(struct nvme_queue *nvmeq, u16 qid)
@@ -1597,7 +1684,7 @@ static const struct blk_mq_ops nvme_mq_ops = {
 	.commit_rqs	= nvme_commit_rqs,
 	.init_hctx	= nvme_init_hctx,
 	.init_request	= nvme_init_request,
-	.map_queues	= nvme_pci_map_queues,
+	.map_queues	= nvme_map_queues,
 	.timeout	= nvme_timeout,
 	.poll		= nvme_poll,
 };
@@ -1656,15 +1743,15 @@ static unsigned long db_bar_size(struct nvme_dev *dev, unsigned nr_io_queues)
 
 static int nvme_remap_bar(struct nvme_dev *dev, unsigned long size)
 {
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct device *ddev = dev->dev;
 
 	if (size <= dev->bar_mapped_size)
 		return 0;
-	if (size > pci_resource_len(pdev, 0))
+	if (size > resource_size(dev->res))
 		return -ENOMEM;
 	if (dev->bar)
-		iounmap(dev->bar);
-	dev->bar = ioremap(pci_resource_start(pdev, 0), size);
+		devm_iounmap(ddev, dev->bar);
+	dev->bar = devm_ioremap(ddev, dev->res->start, size);
 	if (!dev->bar) {
 		dev->bar_mapped_size = 0;
 		return -ENOMEM;
@@ -1784,7 +1871,7 @@ static u32 nvme_cmb_size(struct nvme_dev *dev)
 	return (dev->cmbsz >> NVME_CMBSZ_SZ_SHIFT) & NVME_CMBSZ_SZ_MASK;
 }
 
-static void nvme_map_cmb(struct nvme_dev *dev)
+static void nvme_pci_map_cmb(struct nvme_dev *dev)
 {
 	u64 size, offset;
 	resource_size_t bar_size;
@@ -2059,14 +2146,31 @@ static void nvme_calc_irq_sets(struct irq_affinity *affd, unsigned int nrirqs)
 	affd->nr_sets = nr_read_queues ? 2 : 1;
 }
 
-static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
+static int nvme_pci_setup_irqs(struct nvme_dev *dev, int nr_io_queues)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct nvme_queue *adminq = &dev->queues[0];
 	struct irq_affinity affd = {
 		.pre_vectors	= 1,
 		.calc_sets	= nvme_calc_irq_sets,
 		.priv		= dev,
 	};
+
+	/* Deregister the admin queue's interrupt */
+	free_irq(pci_irq_vector(pdev, 0), adminq);
+
+	/*
+	 * If we enable msix early due to not intx, disable it again before
+	 * setting up the full range we need.
+	 */
+	pci_free_irq_vectors(pdev);
+
+	return pci_alloc_irq_vectors_affinity(pdev, 1, nr_io_queues,
+			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+}
+
+static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
+{
 	unsigned int irq_queues, this_p_queues;
 
 	/*
@@ -2086,8 +2190,7 @@ static int nvme_setup_irqs(struct nvme_dev *dev, unsigned int nr_io_queues)
 	dev->io_queues[HCTX_TYPE_DEFAULT] = 1;
 	dev->io_queues[HCTX_TYPE_READ] = 0;
 
-	return pci_alloc_irq_vectors_affinity(pdev, 1, irq_queues,
-			      PCI_IRQ_ALL_TYPES | PCI_IRQ_AFFINITY, &affd);
+	return dev->ops->setup_irqs(dev, irq_queues);
 }
 
 static void nvme_disable_io_queues(struct nvme_dev *dev)
@@ -2099,7 +2202,6 @@ static void nvme_disable_io_queues(struct nvme_dev *dev)
 static int nvme_setup_io_queues(struct nvme_dev *dev)
 {
 	struct nvme_queue *adminq = &dev->queues[0];
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 	int result, nr_io_queues;
 	unsigned long size;
 
@@ -2133,15 +2235,6 @@ static int nvme_setup_io_queues(struct nvme_dev *dev)
 	adminq->q_db = dev->dbs;
 
  retry:
-	/* Deregister the admin queue's interrupt */
-	pci_free_irq(pdev, 0, adminq);
-
-	/*
-	 * If we enable msix early due to not intx, disable it again before
-	 * setting up the full range we need.
-	 */
-	pci_free_irq_vectors(pdev);
-
 	result = nvme_setup_irqs(dev, nr_io_queues);
 	if (result <= 0)
 		return -EIO;
@@ -2292,6 +2385,18 @@ static int nvme_dev_add(struct nvme_dev *dev)
 	return 0;
 }
 
+static int nvme_enable(struct nvme_dev *dev)
+{
+	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
+
+	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
+				io_queue_depth);
+	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
+	dev->dbs = dev->bar + 4096;
+
+	return 0;
+}
+
 static int nvme_pci_enable(struct nvme_dev *dev)
 {
 	int result = -ENOMEM;
@@ -2302,15 +2407,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 
 	pci_set_master(pdev);
 
-	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
-	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
-		goto disable;
-
-	if (readl(dev->bar + NVME_REG_CSTS) == -1) {
-		result = -ENODEV;
-		goto disable;
-	}
-
 	/*
 	 * Some devices and/or platforms don't advertise or work with INTx
 	 * interrupts. Pre-enable a single MSIX or MSI vec for setup. We'll
@@ -2320,12 +2416,13 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	if (result < 0)
 		return result;
 
-	dev->ctrl.cap = lo_hi_readq(dev->bar + NVME_REG_CAP);
+	if (dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(64)) &&
+	    dma_set_mask_and_coherent(dev->dev, DMA_BIT_MASK(32)))
+		return -ENXIO;
 
-	dev->q_depth = min_t(int, NVME_CAP_MQES(dev->ctrl.cap) + 1,
-				io_queue_depth);
-	dev->db_stride = 1 << NVME_CAP_STRIDE(dev->ctrl.cap);
-	dev->dbs = dev->bar + 4096;
+	result = nvme_enable(dev);
+	if (result)
+		goto disable;
 
 	/*
 	 * Temporary fix for the Apple controller found in the MacBook8,1 and
@@ -2344,7 +2441,7 @@ static int nvme_pci_enable(struct nvme_dev *dev)
                         "set queue depth=%u\n", dev->q_depth);
 	}
 
-	nvme_map_cmb(dev);
+	nvme_pci_map_cmb(dev);
 
 	pci_enable_pcie_error_reporting(pdev);
 	pci_save_state(pdev);
@@ -2355,13 +2452,6 @@ static int nvme_pci_enable(struct nvme_dev *dev)
 	return result;
 }
 
-static void nvme_dev_unmap(struct nvme_dev *dev)
-{
-	if (dev->bar)
-		iounmap(dev->bar);
-	pci_release_mem_regions(to_pci_dev(dev->dev));
-}
-
 static void nvme_pci_disable(struct nvme_dev *dev)
 {
 	struct pci_dev *pdev = to_pci_dev(dev->dev);
@@ -2374,13 +2464,27 @@ static void nvme_pci_disable(struct nvme_dev *dev)
 	}
 }
 
+static int nvme_pci_is_enabled(struct nvme_dev *dev)
+{
+	return pci_is_enabled(to_pci_dev(dev->dev));
+}
+
+static int nvme_pci_is_offline(struct nvme_dev *dev)
+{
+	return pci_channel_offline(to_pci_dev(dev->dev));
+}
+
+static bool nvme_pci_is_present(struct nvme_dev *dev)
+{
+	return pci_device_is_present(to_pci_dev(dev->dev));
+}
+
 static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 {
 	bool dead = true, freeze = false;
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
 
 	mutex_lock(&dev->shutdown_lock);
-	if (pci_is_enabled(pdev)) {
+	if (dev->ops->is_enabled(dev)) {
 		u32 csts = readl(dev->bar + NVME_REG_CSTS);
 
 		if (dev->ctrl.state == NVME_CTRL_LIVE ||
@@ -2389,7 +2493,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 			nvme_start_freeze(&dev->ctrl);
 		}
 		dead = !!((csts & NVME_CSTS_CFS) || !(csts & NVME_CSTS_RDY) ||
-			pdev->error_state  != pci_channel_io_normal);
+			dev->ops->is_offline(dev));
 	}
 
 	/*
@@ -2407,7 +2511,7 @@ static void nvme_dev_disable(struct nvme_dev *dev, bool shutdown)
 	}
 	nvme_suspend_io_queues(dev);
 	nvme_suspend_queue(&dev->queues[0]);
-	nvme_pci_disable(dev);
+	dev->ops->disable(dev);
 
 	blk_mq_tagset_busy_iter(&dev->tagset, nvme_cancel_request, &dev->ctrl);
 	blk_mq_tagset_busy_iter(&dev->admin_tagset, nvme_cancel_request, &dev->ctrl);
@@ -2495,7 +2599,7 @@ static void nvme_reset_work(struct work_struct *work)
 	nvme_sync_queues(&dev->ctrl);
 
 	mutex_lock(&dev->shutdown_lock);
-	result = nvme_pci_enable(dev);
+	result = dev->ops->enable(dev);
 	if (result)
 		goto out_unlock;
 
@@ -2603,10 +2707,10 @@ static void nvme_reset_work(struct work_struct *work)
 static void nvme_remove_dead_ctrl_work(struct work_struct *work)
 {
 	struct nvme_dev *dev = container_of(work, struct nvme_dev, remove_work);
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
+	struct device *ddev = dev->dev;
 
-	if (pci_get_drvdata(pdev))
-		device_release_driver(&pdev->dev);
+	if (dev_get_drvdata(ddev))
+		device_release_driver(ddev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
@@ -2630,9 +2734,9 @@ static int nvme_mmio_reg_read64(struct nvme_ctrl *ctrl, u32 off, u64 *val)
 
 static int nvme_mmio_get_address(struct nvme_ctrl *ctrl, char *buf, int size)
 {
-	struct pci_dev *pdev = to_pci_dev(to_nvme_dev(ctrl)->dev);
+	struct device *ddev = to_nvme_dev(ctrl)->dev;
 
-	return snprintf(buf, size, "%s", dev_name(&pdev->dev));
+	return snprintf(buf, size, "%s", dev_name(ddev));
 }
 
 static const struct nvme_ctrl_ops nvme_mmio_ctrl_ops = {
@@ -2648,21 +2752,19 @@ static const struct nvme_ctrl_ops nvme_mmio_ctrl_ops = {
 	.get_address		= nvme_mmio_get_address,
 };
 
-static int nvme_dev_map(struct nvme_dev *dev)
-{
-	struct pci_dev *pdev = to_pci_dev(dev->dev);
-
-	if (pci_request_mem_regions(pdev, "nvme"))
-		return -ENODEV;
-
-	if (nvme_remap_bar(dev, NVME_REG_DBS + 4096))
-		goto release;
-
-	return 0;
-  release:
-	pci_release_mem_regions(pdev);
-	return -ENODEV;
-}
+static const struct nvme_dev_ops nvme_pci_dev_ops = {
+	.enable			= nvme_pci_enable,
+	.disable		= nvme_pci_disable,
+	.setup_irqs		= nvme_pci_setup_irqs,
+	.q_irq			= nvme_pci_q_irq,
+	.cmb_alloc_sq_cmds	= nvme_pci_cmb_alloc_sq_cmds,
+	.cmb_free_sq_cmds	= nvme_pci_cmb_free_sq_cmds,
+	.map_queues		= nvme_pci_map_queues,
+	.is_enabled		= nvme_pci_is_enabled,
+	.is_offline		= nvme_pci_is_offline,
+	.is_present		= nvme_pci_is_present,
+	.warn_reset		= nvme_pci_warn_reset,
+};
 
 static unsigned long check_vendor_combination_bug(struct pci_dev *pdev)
 {
@@ -2704,16 +2806,24 @@ static void nvme_async_probe(void *data, async_cookie_t cookie)
 	nvme_put_ctrl(&dev->ctrl);
 }
 
-static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+static int nvme_probe(struct device *ddev, struct resource *res,
+		      const struct nvme_dev_ops *ops, unsigned long quirks)
 {
 	int node, result = -ENOMEM;
 	struct nvme_dev *dev;
-	unsigned long quirks = id->driver_data;
 	size_t alloc_size;
 
-	node = dev_to_node(&pdev->dev);
+	if (!ops || !ops->enable
+		 || !ops->disable
+		 || !ops->setup_irqs
+		 || !ops->q_irq
+		 || !ops->is_enabled
+		 || !ops->is_offline)
+		return -EINVAL;
+
+	node = dev_to_node(ddev);
 	if (node == NUMA_NO_NODE)
-		set_dev_node(&pdev->dev, first_memory_node);
+		set_dev_node(ddev, first_memory_node);
 
 	dev = kzalloc_node(sizeof(*dev), GFP_KERNEL, node);
 	if (!dev)
@@ -2724,12 +2834,16 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	if (!dev->queues)
 		goto free;
 
-	dev->dev = get_device(&pdev->dev);
-	pci_set_drvdata(pdev, dev);
+	dev->ops = ops;
+	dev->res = res;
+	dev->dev = get_device(ddev);
+	dev_set_drvdata(ddev, dev);
 
-	result = nvme_dev_map(dev);
-	if (result)
-		goto put_pci;
+	dev->bar = devm_ioremap(ddev, dev->res->start, 8192);
+	if (!dev->bar) {
+		result = -ENODEV;
+		goto put_dev;
+	}
 
 	INIT_WORK(&dev->ctrl.reset_work, nvme_reset_work);
 	INIT_WORK(&dev->remove_work, nvme_remove_dead_ctrl_work);
@@ -2737,9 +2851,7 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 
 	result = nvme_setup_prp_pools(dev);
 	if (result)
-		goto unmap;
-
-	quirks |= check_vendor_combination_bug(pdev);
+		goto put_dev;
 
 	/*
 	 * Double check that our mempool alloc size will cover the biggest
@@ -2758,12 +2870,13 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 		goto release_pools;
 	}
 
-	result = nvme_init_ctrl(&dev->ctrl, &pdev->dev, &nvme_mmio_ctrl_ops,
-			quirks);
+	result = nvme_init_ctrl(&dev->ctrl, ddev, &nvme_mmio_ctrl_ops,
+				quirks);
 	if (result)
 		goto release_mempool;
 
-	dev_info(dev->ctrl.device, "pci function %s\n", dev_name(&pdev->dev));
+	dev_info(dev->ctrl.device, "%s function %s\n",
+		 ddev->bus ? ddev->bus->name : "", dev_name(ddev));
 
 	nvme_get_ctrl(&dev->ctrl);
 	async_schedule(nvme_async_probe, dev);
@@ -2774,16 +2887,41 @@ static int nvme_probe(struct pci_dev *pdev, const struct pci_device_id *id)
 	mempool_destroy(dev->iod_mempool);
  release_pools:
 	nvme_release_prp_pools(dev);
- unmap:
-	nvme_dev_unmap(dev);
- put_pci:
-	put_device(dev->dev);
+ put_dev:
+	put_device(ddev);
  free:
 	kfree(dev->queues);
 	kfree(dev);
 	return result;
 }
 
+static void nvme_pci_release_regions(void *data)
+{
+	struct pci_dev *pdev = data;
+
+	pci_release_mem_regions(pdev);
+}
+
+static int nvme_pci_probe(struct pci_dev *pdev, const struct pci_device_id *id)
+{
+	int rc;
+	unsigned long quirks = id->driver_data;
+
+	rc = pci_request_mem_regions(pdev, "nvme");
+	if (rc)
+		return rc;
+
+	rc = devm_add_action_or_reset(&pdev->dev, nvme_pci_release_regions,
+			pdev);
+	if (rc)
+		return rc;
+
+	quirks |= check_vendor_combination_bug(pdev);
+
+	return nvme_probe(&pdev->dev, &pdev->resource[0], &nvme_pci_dev_ops,
+			  quirks);
+}
+
 static void nvme_reset_prepare(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
@@ -2796,7 +2934,7 @@ static void nvme_reset_done(struct pci_dev *pdev)
 	nvme_reset_ctrl_sync(&dev->ctrl);
 }
 
-static void nvme_shutdown(struct pci_dev *pdev)
+static void nvme_pci_shutdown(struct pci_dev *pdev)
 {
 	struct nvme_dev *dev = pci_get_drvdata(pdev);
 	nvme_dev_disable(dev, true);
@@ -2807,14 +2945,14 @@ static void nvme_shutdown(struct pci_dev *pdev)
  * state. This function must not have any dependencies on the device state in
  * order to proceed.
  */
-static void nvme_remove(struct pci_dev *pdev)
+static void nvme_remove(struct device *ddev)
 {
-	struct nvme_dev *dev = pci_get_drvdata(pdev);
+	struct nvme_dev *dev = dev_get_drvdata(ddev);
 
 	nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DELETING);
-	pci_set_drvdata(pdev, NULL);
+	dev_set_drvdata(ddev, NULL);
 
-	if (!pci_device_is_present(pdev)) {
+	if (dev->ops->is_present && !dev->ops->is_present(dev)) {
 		nvme_change_ctrl_state(&dev->ctrl, NVME_CTRL_DEAD);
 		nvme_dev_disable(dev, true);
 		nvme_dev_remove_admin(dev);
@@ -2830,15 +2968,18 @@ static void nvme_remove(struct pci_dev *pdev)
 	nvme_free_queues(dev, 0);
 	nvme_uninit_ctrl(&dev->ctrl);
 	nvme_release_prp_pools(dev);
-	nvme_dev_unmap(dev);
 	nvme_put_ctrl(&dev->ctrl);
 }
 
+static void nvme_pci_remove(struct pci_dev *pdev)
+{
+	nvme_remove(&pdev->dev);
+}
+
 #ifdef CONFIG_PM_SLEEP
 static int nvme_suspend(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	nvme_dev_disable(ndev, true);
 	return 0;
@@ -2846,8 +2987,7 @@ static int nvme_suspend(struct device *dev)
 
 static int nvme_resume(struct device *dev)
 {
-	struct pci_dev *pdev = to_pci_dev(dev);
-	struct nvme_dev *ndev = pci_get_drvdata(pdev);
+	struct nvme_dev *ndev = dev_get_drvdata(dev);
 
 	nvme_reset_ctrl(&ndev->ctrl);
 	return 0;
@@ -2956,9 +3096,9 @@ MODULE_DEVICE_TABLE(pci, nvme_id_table);
 static struct pci_driver nvme_driver = {
 	.name		= "nvme",
 	.id_table	= nvme_id_table,
-	.probe		= nvme_probe,
-	.remove		= nvme_remove,
-	.shutdown	= nvme_shutdown,
+	.probe		= nvme_pci_probe,
+	.remove		= nvme_pci_remove,
+	.shutdown	= nvme_pci_shutdown,
 	.driver		= {
 		.pm	= &nvme_dev_pm_ops,
 	},
-- 
2.20.1

