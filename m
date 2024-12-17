Return-Path: <linux-pci+bounces-18651-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id B10E79F50AB
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:16:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2E8EE1701F8
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:14:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6856D1F7580;
	Tue, 17 Dec 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nLfhKfOZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 408E71F7545
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 16:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451503; cv=none; b=LB/gRgy8zYhojeeUWzFbNtkQq2XtVGCVdGwmH0r/sUyYd9we0JT9CPTN51f0qVCAJXLqfS+9WIhsCcBYcH9Q50k+K/ekMQt37GYn0cycjvInjSyND1Wo7XDZNug5yYYaz9c0zdjpNzyMsVCHB5PXO7xViF4nX9zfGvv6pxS1+LU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451503; c=relaxed/simple;
	bh=TU/raJvixvN4nOQHwwErByg4LJJt9dVgcIq0Gcog9v8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hCAWRFK+Emr43Txp4J9svOSoRvz/FX7iHC82XalLWuCfGqP9t9aKxU7hnMDoaWwBfOE0ilJOSHqqyqPXTJBH+aj5LvHAIhtellVa3ml4znKk5yvR50Zmbyov6UVSXaShnveX2N3qhYSQk19NisnK2mpWJb1hFIdMM5/7UthboGk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nLfhKfOZ; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 34013C4CED3;
	Tue, 17 Dec 2024 16:04:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451503;
	bh=TU/raJvixvN4nOQHwwErByg4LJJt9dVgcIq0Gcog9v8=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nLfhKfOZLiJXR4Jrh80kZasntvw2CzdkGVGxdhGFHnJkLBcvbOxj383Keav2FE0MV
	 ZxE3Ds9FO6pRBnOJdR+ZbRWwaTUIaYV7gDLLWvxnZ7UMi5hCUPFmO7V21c+i5RC/ci
	 riv9C/DUvf13gZzFbUzwIXRwENxJgbVA/BybQd9PrAewiT7wnKen7ZevgqfW1PJDAt
	 0ntTmCpvbrZZ4bTB57p/Zww8ojyWEskhGPgtVpmFMyg/lYsmTRBmFO8o4BFpx1v+Fm
	 DcAC3yYlE7RqQoGAcH3FtfjYImCWPecrgL1O8tBYsyo6hociitXmUPRueliV0CreSu
	 j/vZX3sR2vyvg==
From: Niklas Cassel <cassel@kernel.org>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Cc: Damien Le Moal <dlemoal@kernel.org>,
	Vinod Koul <vkoul@kernel.org>,
	linux-nvme@lists.infradead.org,
	Christoph Hellwig <hch@lst.de>,
	Keith Busch <kbusch@kernel.org>,
	Sagi Grimberg <sagi@grimberg.me>,
	linux-pci@vger.kernel.org,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	Rick Wertenbroek <rick.wertenbroek@gmail.com>,
	Niklas Cassel <cassel@kernel.org>
Subject: [PATCH 1/3] dmaengine: dw-edma: Add support for DMA_MEMCPY
Date: Tue, 17 Dec 2024 17:04:49 +0100
Message-ID: <20241217160448.199310-4-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <Z2Gf9lv6hLROjM8e@ryzen>
References: <Z2Gf9lv6hLROjM8e@ryzen>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=5606; i=cassel@kernel.org; h=from:subject; bh=TU/raJvixvN4nOQHwwErByg4LJJt9dVgcIq0Gcog9v8=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNITFypUPVfzczncLnnAYd6tnQZqE6f/jTy2b6VDVpftj izPHa39HaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZhI9T+G/xlTam7+fVm+8vZT U54lSvpzAnPqp39KV1jJ1/LqmrfqZEdGhneTlBdXJTm8fCDRnZLB9PeoosTxoye4w9eu+3i9ga+ PhwUA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 52 ++++++++++++++++++++++++++++--
 drivers/dma/dw-edma/dw-edma-core.h | 10 +++++-
 2 files changed, 59 insertions(+), 3 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 68236247059d..29cbd947df57 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -422,6 +422,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			return NULL;
 		if (!xfer->xfer.il->src_inc || !xfer->xfer.il->dst_inc)
 			return NULL;
+	} else if (xfer->type == EDMA_XFER_MEMCPY) {
+		if (!xfer->xfer.memcpy.len)
+			return NULL;
 	} else {
 		return NULL;
 	}
@@ -437,6 +440,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		src_addr = xfer->xfer.il->src_start;
 		dst_addr = xfer->xfer.il->dst_start;
+	} else if (xfer->type == EDMA_XFER_MEMCPY) {
+		src_addr = xfer->xfer.memcpy.src;
+		dst_addr = xfer->xfer.memcpy.dst;
 	} else {
 		src_addr = chan->config.src_addr;
 		dst_addr = chan->config.dst_addr;
@@ -455,6 +461,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
 		cnt = xfer->xfer.il->numf * xfer->xfer.il->frame_size;
 		fsz = xfer->xfer.il->frame_size;
+	} else if (xfer->type == EDMA_XFER_MEMCPY) {
+		cnt = 1;
 	}
 
 	for (i = 0; i < cnt; i++) {
@@ -477,6 +485,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			burst->sz = sg_dma_len(sg);
 		else if (xfer->type == EDMA_XFER_INTERLEAVED)
 			burst->sz = xfer->xfer.il->sgl[i % fsz].size;
+		else if (xfer->type == EDMA_XFER_MEMCPY)
+			burst->sz = xfer->xfer.memcpy.len;
 
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
@@ -495,7 +505,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 				 * and destination addresses are increased
 				 * by the same portion (data length)
 				 */
-			} else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+			} else if (xfer->type == EDMA_XFER_INTERLEAVED ||
+				   xfer->type == EDMA_XFER_MEMCPY) {
 				burst->dar = dst_addr;
 			}
 		} else {
@@ -512,7 +523,8 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 				 * and destination addresses are increased
 				 * by the same portion (data length)
 				 */
-			}  else if (xfer->type == EDMA_XFER_INTERLEAVED) {
+			}  else if (xfer->type == EDMA_XFER_INTERLEAVED ||
+				    xfer->type == EDMA_XFER_MEMCPY) {
 				burst->sar = src_addr;
 			}
 		}
@@ -595,6 +607,40 @@ dw_edma_device_prep_interleaved_dma(struct dma_chan *dchan,
 	return dw_edma_device_transfer(&xfer);
 }
 
+static struct dma_async_tx_descriptor *
+dw_edma_device_prep_dma_memcpy(struct dma_chan *dchan, dma_addr_t dst,
+			       dma_addr_t src, size_t len, unsigned long flags)
+{
+	struct dw_edma_chan *chan = dchan2dw_edma_chan(dchan);
+	enum dma_transfer_direction direction;
+	struct dw_edma_transfer xfer;
+
+	if (chan->dw->chip->flags & DW_EDMA_CHIP_LOCAL) {
+		if (chan->dir == EDMA_DIR_READ)
+			direction = DMA_DEV_TO_MEM;
+		else
+			direction = DMA_MEM_TO_DEV;
+	} else {
+		if (chan->dir == EDMA_DIR_WRITE)
+			direction = DMA_DEV_TO_MEM;
+		else
+			direction = DMA_MEM_TO_DEV;
+	}
+
+	xfer.dchan = dchan;
+	xfer.direction = direction;
+	xfer.xfer.memcpy.dst = dst;
+	xfer.xfer.memcpy.src = src;
+	xfer.xfer.memcpy.len = len;
+	xfer.flags = flags;
+	xfer.type = EDMA_XFER_MEMCPY;
+
+	/* DMA_MEMCPY does not need an initial dmaengine_slave_config() call */
+	chan->configured = true;
+
+	return dw_edma_device_transfer(&xfer);
+}
+
 static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 {
 	struct dw_edma_desc *desc;
@@ -787,6 +833,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma_cap_set(DMA_CYCLIC, dma->cap_mask);
 	dma_cap_set(DMA_PRIVATE, dma->cap_mask);
 	dma_cap_set(DMA_INTERLEAVE, dma->cap_mask);
+	dma_cap_set(DMA_MEMCPY, dma->cap_mask);
 	dma->directions = BIT(DMA_DEV_TO_MEM) | BIT(DMA_MEM_TO_DEV);
 	dma->src_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
 	dma->dst_addr_widths = BIT(DMA_SLAVE_BUSWIDTH_4_BYTES);
@@ -806,6 +853,7 @@ static int dw_edma_channel_setup(struct dw_edma *dw, u32 wr_alloc, u32 rd_alloc)
 	dma->device_prep_slave_sg = dw_edma_device_prep_slave_sg;
 	dma->device_prep_dma_cyclic = dw_edma_device_prep_dma_cyclic;
 	dma->device_prep_interleaved_dma = dw_edma_device_prep_interleaved_dma;
+	dma->device_prep_dma_memcpy = dw_edma_device_prep_dma_memcpy;
 
 	dma_set_max_seg_size(dma->dev, U32_MAX);
 
diff --git a/drivers/dma/dw-edma/dw-edma-core.h b/drivers/dma/dw-edma/dw-edma-core.h
index 71894b9e0b15..2b35dccbe8de 100644
--- a/drivers/dma/dw-edma/dw-edma-core.h
+++ b/drivers/dma/dw-edma/dw-edma-core.h
@@ -36,7 +36,8 @@ enum dw_edma_status {
 enum dw_edma_xfer_type {
 	EDMA_XFER_SCATTER_GATHER = 0,
 	EDMA_XFER_CYCLIC,
-	EDMA_XFER_INTERLEAVED
+	EDMA_XFER_INTERLEAVED,
+	EDMA_XFER_MEMCPY
 };
 
 struct dw_edma_chan;
@@ -139,12 +140,19 @@ struct dw_edma_cyclic {
 	size_t				cnt;
 };
 
+struct dw_edma_memcpy {
+	dma_addr_t			dst;
+	dma_addr_t			src;
+	size_t				len;
+};
+
 struct dw_edma_transfer {
 	struct dma_chan			*dchan;
 	union dw_edma_xfer {
 		struct dw_edma_sg		sg;
 		struct dw_edma_cyclic		cyclic;
 		struct dma_interleaved_template *il;
+		struct dw_edma_memcpy		memcpy;
 	} xfer;
 	enum dma_transfer_direction	direction;
 	unsigned long			flags;
-- 
2.47.1


