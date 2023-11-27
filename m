Return-Path: <linux-pci+bounces-172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 65F6B7F9FDE
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 13:45:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D386EB20D8E
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 12:45:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4491A18E11;
	Mon, 27 Nov 2023 12:45:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="tI7iWclB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A3F2182
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:45:49 -0800 (PST)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-679dd3055faso22143086d6.0
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:45:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089148; x=1701693948; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=no0VTw7AaZRHaEYiXHFJsL4mdLmGMlJqeRVIKxNTTiA=;
        b=tI7iWclB75NeVByt/ZumuGf8SutG07BYCTzXF84OO+tks/LGUIgFZUChblMVyoUwh5
         Z9y8r2Zk6Fgb0YKn6LueXNK0DBxILp18b9M6vRShEYEUNHGezHkJO7HYWLRt4SobBF6q
         29II976loJCqCIOJ8y/PdnB7IpFHLjAhZZyxnNOTFJbZgsy2uej4zJGnxm+HLOKRS1XA
         R3qTVLixahPR2oyw6CR3zTslzeQoouf5yh3jFb+pJTw1vUtF+asaMmN1vmsWsJ0RgURe
         QyQJ5RY6aNjl1GCxw3BPtiK/+mhFq6xwjBiovWn6Hbz0Izkm/Gv5CdkdIgO8ucuYic/d
         Gafg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089148; x=1701693948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=no0VTw7AaZRHaEYiXHFJsL4mdLmGMlJqeRVIKxNTTiA=;
        b=QznyOv+3OZk+FTOzfACRsgSCN3BzDCH/Do8gpxPb0kfwm/LXixVHQduhA6UTgPkO8q
         IXahw/Cu7S7dHgkvnDt1L/Y+d8o0QLyN31STWZdMzdim5UHFeyQ5hvqlqGr8f7gdRubS
         9I4cocfAp9ccEd+wuTzaerffo9Tw8JTYMzGqDXGR7Rw7dpnhcRUKknZpkBXFf5QYkBIk
         NLe8oatDFfIMfEQW2XYk04HtFYaAdOnlm6K4gjbWzg5eDsG8Vhd5TZEXKEJwvM2+Lpqc
         SRTNji+uvXUdMRN+XkVsdB9krQmVlRoNvsV1I8pN0iNCRyMrL7KyPHb0vIKedFX+CUZ4
         RbXA==
X-Gm-Message-State: AOJu0YyCQGP//54Bg2V+YUqqYEWTTG9lSKSTGkZPlShyu4ZzyDMieB4W
	O6giNxvdzhWP3R3OUz1mPCF1
X-Google-Smtp-Source: AGHT+IEDsR6fqa+PkwYSpn0j413uev3E0r+IobYut8mCcD//Br+4lRGXm5ATAklV35mB//KZGADMyw==
X-Received: by 2002:a0c:e887:0:b0:67a:2ae3:a971 with SMTP id b7-20020a0ce887000000b0067a2ae3a971mr6857772qvo.2.1701089148388;
        Mon, 27 Nov 2023 04:45:48 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.45.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:45:47 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To: lpieralisi@kernel.org,
	kw@linux.com
Cc: kishon@kernel.org,
	bhelgaas@google.com,
	mhi@lists.linux.dev,
	linux-arm-msm@vger.kernel.org,
	linux-pci@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH 1/9] bus: mhi: ep: Pass mhi_ep_buf_info struct to read/write APIs
Date: Mon, 27 Nov 2023 18:15:21 +0530
Message-Id: <20231127124529.78203-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
References: <20231127124529.78203-1-manivannan.sadhasivam@linaro.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

In the preparation of DMA async support, let's pass the parameters to
read_from_host() and write_to_host() APIs using mhi_ep_buf_info structure.

No functional change.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/main.c                    | 23 +++----
 drivers/bus/mhi/ep/ring.c                    | 41 ++++++------
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 66 +++++++++++---------
 include/linux/mhi_ep.h                       | 16 ++++-
 4 files changed, 84 insertions(+), 62 deletions(-)

diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 4c8773881e1f..cdf5a84d1f21 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -344,10 +344,9 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 	struct mhi_ep_chan *mhi_chan = &mhi_cntrl->mhi_chan[ring->ch_id];
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
 	size_t tr_len, read_offset, write_offset;
+	struct mhi_ep_buf_info buf_info = {};
 	struct mhi_ring_element *el;
 	bool tr_done = false;
-	void *write_addr;
-	u64 read_addr;
 	u32 buf_left;
 	int ret;
 
@@ -376,11 +375,13 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 
 		read_offset = mhi_chan->tre_size - mhi_chan->tre_bytes_left;
 		write_offset = len - buf_left;
-		read_addr = mhi_chan->tre_loc + read_offset;
-		write_addr = result->buf_addr + write_offset;
+
+		buf_info.host_addr = mhi_chan->tre_loc + read_offset;
+		buf_info.dev_addr = result->buf_addr + write_offset;
+		buf_info.size = tr_len;
 
 		dev_dbg(dev, "Reading %zd bytes from channel (%u)\n", tr_len, ring->ch_id);
-		ret = mhi_cntrl->read_from_host(mhi_cntrl, read_addr, write_addr, tr_len);
+		ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
 		if (ret < 0) {
 			dev_err(&mhi_chan->mhi_dev->dev, "Error reading from channel\n");
 			return ret;
@@ -503,12 +504,11 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
 	struct device *dev = &mhi_chan->mhi_dev->dev;
+	struct mhi_ep_buf_info buf_info = {};
 	struct mhi_ring_element *el;
 	u32 buf_left, read_offset;
 	struct mhi_ep_ring *ring;
 	enum mhi_ev_ccs code;
-	void *read_addr;
-	u64 write_addr;
 	size_t tr_len;
 	u32 tre_len;
 	int ret;
@@ -537,11 +537,13 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 
 		tr_len = min(buf_left, tre_len);
 		read_offset = skb->len - buf_left;
-		read_addr = skb->data + read_offset;
-		write_addr = MHI_TRE_DATA_GET_PTR(el);
+
+		buf_info.dev_addr = skb->data + read_offset;
+		buf_info.host_addr = MHI_TRE_DATA_GET_PTR(el);
+		buf_info.size = tr_len;
 
 		dev_dbg(dev, "Writing %zd bytes to channel (%u)\n", tr_len, ring->ch_id);
-		ret = mhi_cntrl->write_to_host(mhi_cntrl, read_addr, write_addr, tr_len);
+		ret = mhi_cntrl->write_to_host(mhi_cntrl, &buf_info);
 		if (ret < 0) {
 			dev_err(dev, "Error writing to the channel\n");
 			goto err_exit;
@@ -1449,7 +1451,6 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		ret = -ENOMEM;
 		goto err_destroy_tre_buf_cache;
 	}
-
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
 	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
diff --git a/drivers/bus/mhi/ep/ring.c b/drivers/bus/mhi/ep/ring.c
index a1071c13761b..7ea952860def 100644
--- a/drivers/bus/mhi/ep/ring.c
+++ b/drivers/bus/mhi/ep/ring.c
@@ -30,7 +30,8 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 {
 	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
-	size_t start, copy_size;
+	struct mhi_ep_buf_info buf_info = {};
+	size_t start;
 	int ret;
 
 	/* Don't proceed in the case of event ring. This happens during mhi_ep_ring_start(). */
@@ -43,30 +44,34 @@ static int __mhi_ep_cache_ring(struct mhi_ep_ring *ring, size_t end)
 
 	start = ring->wr_offset;
 	if (start < end) {
-		copy_size = (end - start) * sizeof(struct mhi_ring_element);
-		ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase +
-						(start * sizeof(struct mhi_ring_element)),
-						&ring->ring_cache[start], copy_size);
+		buf_info.size = (end - start) * sizeof(struct mhi_ring_element);
+		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
+		buf_info.dev_addr = &ring->ring_cache[start];
+
+		ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
 		if (ret < 0)
 			return ret;
 	} else {
-		copy_size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
-		ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase +
-						(start * sizeof(struct mhi_ring_element)),
-						&ring->ring_cache[start], copy_size);
+		buf_info.size = (ring->ring_size - start) * sizeof(struct mhi_ring_element);
+		buf_info.host_addr = ring->rbase + (start * sizeof(struct mhi_ring_element));
+		buf_info.dev_addr = &ring->ring_cache[start];
+
+		ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
 		if (ret < 0)
 			return ret;
 
 		if (end) {
-			ret = mhi_cntrl->read_from_host(mhi_cntrl, ring->rbase,
-							&ring->ring_cache[0],
-							end * sizeof(struct mhi_ring_element));
+			buf_info.host_addr = ring->rbase;
+			buf_info.dev_addr = &ring->ring_cache[0];
+			buf_info.size = end * sizeof(struct mhi_ring_element);
+
+			ret = mhi_cntrl->read_from_host(mhi_cntrl, &buf_info);
 			if (ret < 0)
 				return ret;
 		}
 	}
 
-	dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, copy_size);
+	dev_dbg(dev, "Cached ring: start %zu end %zu size %zu\n", start, end, buf_info.size);
 
 	return 0;
 }
@@ -102,6 +107,7 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
 {
 	struct mhi_ep_cntrl *mhi_cntrl = ring->mhi_cntrl;
 	struct device *dev = &mhi_cntrl->mhi_dev->dev;
+	struct mhi_ep_buf_info buf_info = {};
 	size_t old_offset = 0;
 	u32 num_free_elem;
 	__le64 rp;
@@ -133,12 +139,11 @@ int mhi_ep_ring_add_element(struct mhi_ep_ring *ring, struct mhi_ring_element *e
 	rp = cpu_to_le64(ring->rd_offset * sizeof(*el) + ring->rbase);
 	memcpy_toio((void __iomem *) &ring->ring_ctx->generic.rp, &rp, sizeof(u64));
 
-	ret = mhi_cntrl->write_to_host(mhi_cntrl, el, ring->rbase + (old_offset * sizeof(*el)),
-				       sizeof(*el));
-	if (ret < 0)
-		return ret;
+	buf_info.host_addr = ring->rbase + (old_offset * sizeof(*el));
+	buf_info.dev_addr = el;
+	buf_info.size = sizeof(*el);
 
-	return 0;
+	return mhi_cntrl->write_to_host(mhi_cntrl, &buf_info);
 }
 
 void mhi_ep_ring_init(struct mhi_ep_ring *ring, enum mhi_ep_ring_type type, u32 id)
diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index daa09289eede..6dc918a8a023 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -209,28 +209,28 @@ static void pci_epf_mhi_raise_irq(struct mhi_ep_cntrl *mhi_cntrl, u32 vector)
 			  vector + 1);
 }
 
-static int pci_epf_mhi_iatu_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
-				 void *to, size_t size)
+static int pci_epf_mhi_iatu_read(struct mhi_ep_cntrl *mhi_cntrl,
+				 struct mhi_ep_buf_info *buf_info)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	size_t offset = get_align_offset(epf_mhi, from);
+	size_t offset = get_align_offset(epf_mhi, buf_info->host_addr);
 	void __iomem *tre_buf;
 	phys_addr_t tre_phys;
 	int ret;
 
 	mutex_lock(&epf_mhi->lock);
 
-	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, from, &tre_phys, &tre_buf,
-				      offset, size);
+	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, buf_info->host_addr, &tre_phys,
+				      &tre_buf, offset, buf_info->size);
 	if (ret) {
 		mutex_unlock(&epf_mhi->lock);
 		return ret;
 	}
 
-	memcpy_fromio(to, tre_buf, size);
+	memcpy_fromio(buf_info->dev_addr, tre_buf, buf_info->size);
 
-	__pci_epf_mhi_unmap_free(mhi_cntrl, from, tre_phys, tre_buf, offset,
-				 size);
+	__pci_epf_mhi_unmap_free(mhi_cntrl, buf_info->host_addr, tre_phys,
+				 tre_buf, offset, buf_info->size);
 
 	mutex_unlock(&epf_mhi->lock);
 
@@ -238,27 +238,27 @@ static int pci_epf_mhi_iatu_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 }
 
 static int pci_epf_mhi_iatu_write(struct mhi_ep_cntrl *mhi_cntrl,
-				  void *from, u64 to, size_t size)
+				  struct mhi_ep_buf_info *buf_info)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
-	size_t offset = get_align_offset(epf_mhi, to);
+	size_t offset = get_align_offset(epf_mhi, buf_info->host_addr);
 	void __iomem *tre_buf;
 	phys_addr_t tre_phys;
 	int ret;
 
 	mutex_lock(&epf_mhi->lock);
 
-	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, to, &tre_phys, &tre_buf,
-				      offset, size);
+	ret = __pci_epf_mhi_alloc_map(mhi_cntrl, buf_info->host_addr, &tre_phys,
+				      &tre_buf, offset, buf_info->size);
 	if (ret) {
 		mutex_unlock(&epf_mhi->lock);
 		return ret;
 	}
 
-	memcpy_toio(tre_buf, from, size);
+	memcpy_toio(tre_buf, buf_info->dev_addr, buf_info->size);
 
-	__pci_epf_mhi_unmap_free(mhi_cntrl, to, tre_phys, tre_buf, offset,
-				 size);
+	__pci_epf_mhi_unmap_free(mhi_cntrl, buf_info->host_addr, tre_phys,
+				 tre_buf, offset, buf_info->size);
 
 	mutex_unlock(&epf_mhi->lock);
 
@@ -270,8 +270,8 @@ static void pci_epf_mhi_dma_callback(void *param)
 	complete(param);
 }
 
-static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
-				 void *to, size_t size)
+static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl,
+				 struct mhi_ep_buf_info *buf_info)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
@@ -284,13 +284,13 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 	dma_addr_t dst_addr;
 	int ret;
 
-	if (size < SZ_4K)
-		return pci_epf_mhi_iatu_read(mhi_cntrl, from, to, size);
+	if (buf_info->size < SZ_4K)
+		return pci_epf_mhi_iatu_read(mhi_cntrl, buf_info);
 
 	mutex_lock(&epf_mhi->lock);
 
 	config.direction = DMA_DEV_TO_MEM;
-	config.src_addr = from;
+	config.src_addr = buf_info->host_addr;
 
 	ret = dmaengine_slave_config(chan, &config);
 	if (ret) {
@@ -298,14 +298,16 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 		goto err_unlock;
 	}
 
-	dst_addr = dma_map_single(dma_dev, to, size, DMA_FROM_DEVICE);
+	dst_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+				  DMA_FROM_DEVICE);
 	ret = dma_mapping_error(dma_dev, dst_addr);
 	if (ret) {
 		dev_err(dev, "Failed to map remote memory\n");
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, dst_addr, size, DMA_DEV_TO_MEM,
+	desc = dmaengine_prep_slave_single(chan, dst_addr, buf_info->size,
+					   DMA_DEV_TO_MEM,
 					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
@@ -332,15 +334,15 @@ static int pci_epf_mhi_edma_read(struct mhi_ep_cntrl *mhi_cntrl, u64 from,
 	}
 
 err_unmap:
-	dma_unmap_single(dma_dev, dst_addr, size, DMA_FROM_DEVICE);
+	dma_unmap_single(dma_dev, dst_addr, buf_info->size, DMA_FROM_DEVICE);
 err_unlock:
 	mutex_unlock(&epf_mhi->lock);
 
 	return ret;
 }
 
-static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl, void *from,
-				  u64 to, size_t size)
+static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl,
+				  struct mhi_ep_buf_info *buf_info)
 {
 	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
 	struct device *dma_dev = epf_mhi->epf->epc->dev.parent;
@@ -353,13 +355,13 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl, void *from,
 	dma_addr_t src_addr;
 	int ret;
 
-	if (size < SZ_4K)
-		return pci_epf_mhi_iatu_write(mhi_cntrl, from, to, size);
+	if (buf_info->size < SZ_4K)
+		return pci_epf_mhi_iatu_write(mhi_cntrl, buf_info);
 
 	mutex_lock(&epf_mhi->lock);
 
 	config.direction = DMA_MEM_TO_DEV;
-	config.dst_addr = to;
+	config.dst_addr = buf_info->host_addr;
 
 	ret = dmaengine_slave_config(chan, &config);
 	if (ret) {
@@ -367,14 +369,16 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl, void *from,
 		goto err_unlock;
 	}
 
-	src_addr = dma_map_single(dma_dev, from, size, DMA_TO_DEVICE);
+	src_addr = dma_map_single(dma_dev, buf_info->dev_addr, buf_info->size,
+				  DMA_TO_DEVICE);
 	ret = dma_mapping_error(dma_dev, src_addr);
 	if (ret) {
 		dev_err(dev, "Failed to map remote memory\n");
 		goto err_unlock;
 	}
 
-	desc = dmaengine_prep_slave_single(chan, src_addr, size, DMA_MEM_TO_DEV,
+	desc = dmaengine_prep_slave_single(chan, src_addr, buf_info->size,
+					   DMA_MEM_TO_DEV,
 					   DMA_CTRL_ACK | DMA_PREP_INTERRUPT);
 	if (!desc) {
 		dev_err(dev, "Failed to prepare DMA\n");
@@ -401,7 +405,7 @@ static int pci_epf_mhi_edma_write(struct mhi_ep_cntrl *mhi_cntrl, void *from,
 	}
 
 err_unmap:
-	dma_unmap_single(dma_dev, src_addr, size, DMA_TO_DEVICE);
+	dma_unmap_single(dma_dev, src_addr, buf_info->size, DMA_TO_DEVICE);
 err_unlock:
 	mutex_unlock(&epf_mhi->lock);
 
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index ce85d42b685d..96f3a133540d 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -49,6 +49,18 @@ struct mhi_ep_db_info {
 	u32 status;
 };
 
+/**
+ * struct mhi_ep_buf_info - MHI Endpoint transfer buffer info
+ * @dev_addr: Address of the buffer in endpoint
+ * @host_addr: Address of the bufffer in host
+ * @size: Size of the buffer
+ */
+struct mhi_ep_buf_info {
+	void *dev_addr;
+	u64 host_addr;
+	size_t size;
+};
+
 /**
  * struct mhi_ep_cntrl - MHI Endpoint controller structure
  * @cntrl_dev: Pointer to the struct device of physical bus acting as the MHI
@@ -137,8 +149,8 @@ struct mhi_ep_cntrl {
 			 void __iomem **virt, size_t size);
 	void (*unmap_free)(struct mhi_ep_cntrl *mhi_cntrl, u64 pci_addr, phys_addr_t phys,
 			   void __iomem *virt, size_t size);
-	int (*read_from_host)(struct mhi_ep_cntrl *mhi_cntrl, u64 from, void *to, size_t size);
-	int (*write_to_host)(struct mhi_ep_cntrl *mhi_cntrl, void *from, u64 to, size_t size);
+	int (*read_from_host)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	int (*write_to_host)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 
 	enum mhi_state mhi_state;
 
-- 
2.25.1


