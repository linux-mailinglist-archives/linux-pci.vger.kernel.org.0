Return-Path: <linux-pci+bounces-178-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1543E7F9FEC
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 13:46:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BEC9F280EC5
	for <lists+linux-pci@lfdr.de>; Mon, 27 Nov 2023 12:46:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC5FE1E535;
	Mon, 27 Nov 2023 12:46:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ByM5i+wZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qv1-xf2a.google.com (mail-qv1-xf2a.google.com [IPv6:2607:f8b0:4864:20::f2a])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B37731BD8
	for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:46:16 -0800 (PST)
Received: by mail-qv1-xf2a.google.com with SMTP id 6a1803df08f44-67a1c826bb6so13259486d6.1
        for <linux-pci@vger.kernel.org>; Mon, 27 Nov 2023 04:46:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1701089175; x=1701693975; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=qW88ClllHDY6AjewN5n1WX1VoidY5SA8L3B/8hzPqPI=;
        b=ByM5i+wZ7sLT7oHeruBSAjMulETO8Ub71bZPJLx7gLMiPiPktpbaapbHBjbpUPGvve
         TAnlwKhWQOhI3voXSCRlRXDkQV5nPfS76OAS9OwT8lBC323fZT6clTi1XjburpMsDGJU
         IJv+5EWPeI4J9tq5J3loPNqYuy0b6AvYUakkQBRQOzdbicXNnSgvY7Wtzq06cXeTWwN8
         PGLnM7pd5YKp7rTltl6LGZ/STOx3Gs5Uhj2Gp9OHUcsqC5FEO9S8beB73zo/zeoHuMGH
         Y0FlayrlTBkUgPDsa+XXT9Ps6ASEXU3w/awrYucgoNpZK0dxcvM5JsxnxmxYaKcCEbwE
         Y9JQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1701089175; x=1701693975;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=qW88ClllHDY6AjewN5n1WX1VoidY5SA8L3B/8hzPqPI=;
        b=SP/lQQTAfIKK+T6rn4yGTaz6iqnNM/TgANSspwyk08Td+3YLjn+FHpciWulZWoZBDX
         6fnEd9+gkJ/gDxMrFSuFnpkZCYvr8sSgXCW3mw7R93FxJ79G7x2lilYdkOVqe2q9oa6e
         XdccJ+20mKWCHM3x7dXMdxWzcmhHCWLy1vQbE11Bf8de0ti8ZuUYyg/pkJeEf8jVMDiZ
         3DcBKAgc2xyhWtksk3FZmTwZMV1P1eRjUrL2wMIulzP/Bg8MxTq7077srSbUAr9Ju94L
         DLuycjXsvIEOo171l208MOTxAFdQ9ggbzOWs9QOeM0fXAJCxlrv5fnT8TEJ1g0oVZtsJ
         2+vg==
X-Gm-Message-State: AOJu0Yxz9xUXHaDtjBQdn1LBGNlzXeO/bA5vZh9YhKCsZox4S9DitR0d
	TEuFSpj38YsfMazdd+ObtJMY
X-Google-Smtp-Source: AGHT+IFdbCFqoTtX+Sm5S1xk56menW+JLhUPVQVwmdvIov/0nHzslDYIDH2kfOOwiSGoAB/8AOKesQ==
X-Received: by 2002:a05:6214:260d:b0:67a:5174:57d4 with SMTP id gu13-20020a056214260d00b0067a517457d4mr1037634qvb.47.1701089175547;
        Mon, 27 Nov 2023 04:46:15 -0800 (PST)
Received: from localhost.localdomain ([117.213.103.241])
        by smtp.gmail.com with ESMTPSA id er10-20020a056214190a00b0067a204b4688sm2832231qvb.18.2023.11.27.04.46.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Nov 2023 04:46:15 -0800 (PST)
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
Subject: [PATCH 7/9] bus: mhi: ep: Add support for async DMA write operation
Date: Mon, 27 Nov 2023 18:15:27 +0530
Message-Id: <20231127124529.78203-8-manivannan.sadhasivam@linaro.org>
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

In order to optimize the data transfer, let's use the async DMA operation
for writing (queuing) data to the host.

In the async path, the completion event for the transfer ring will only be
sent to the host when the controller driver notifies the MHI stack of the
actual transfer completion using the callback (mhi_ep_skb_completion)
supplied in "struct mhi_ep_buf_info".

Also to accommodate the async operation, the transfer ring read offset
(ring->rd_offset) is cached in the "struct mhi_ep_chan" and updated locally
to let the stack queue further ring items to the controller driver. But the
actual read offset of the transfer ring will only be updated in the
completion callback.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/bus/mhi/ep/internal.h |  1 +
 drivers/bus/mhi/ep/main.c     | 77 ++++++++++++++++++++++++++---------
 include/linux/mhi_ep.h        |  4 ++
 3 files changed, 62 insertions(+), 20 deletions(-)

diff --git a/drivers/bus/mhi/ep/internal.h b/drivers/bus/mhi/ep/internal.h
index 8c5cf2b67951..577965f95fda 100644
--- a/drivers/bus/mhi/ep/internal.h
+++ b/drivers/bus/mhi/ep/internal.h
@@ -162,6 +162,7 @@ struct mhi_ep_chan {
 	void (*xfer_cb)(struct mhi_ep_device *mhi_dev, struct mhi_result *result);
 	enum mhi_ch_state state;
 	enum dma_data_direction dir;
+	size_t rd_offset;
 	u64 tre_loc;
 	u32 tre_size;
 	u32 tre_bytes_left;
diff --git a/drivers/bus/mhi/ep/main.c b/drivers/bus/mhi/ep/main.c
index 5748a1da0803..81d693433a5f 100644
--- a/drivers/bus/mhi/ep/main.c
+++ b/drivers/bus/mhi/ep/main.c
@@ -203,6 +203,8 @@ static int mhi_ep_process_cmd_ring(struct mhi_ep_ring *ring, struct mhi_ring_ele
 
 				goto err_unlock;
 			}
+
+			mhi_chan->rd_offset = ch_ring->rd_offset;
 		}
 
 		/* Set channel state to RUNNING */
@@ -332,7 +334,7 @@ bool mhi_ep_queue_is_empty(struct mhi_ep_device *mhi_dev, enum dma_data_directio
 	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
 	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
 
-	return !!(ring->rd_offset == ring->wr_offset);
+	return !!(mhi_chan->rd_offset == ring->wr_offset);
 }
 EXPORT_SYMBOL_GPL(mhi_ep_queue_is_empty);
 
@@ -359,7 +361,7 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 			return -ENODEV;
 		}
 
-		el = &ring->ring_cache[ring->rd_offset];
+		el = &ring->ring_cache[mhi_chan->rd_offset];
 
 		/* Check if there is data pending to be read from previous read operation */
 		if (mhi_chan->tre_bytes_left) {
@@ -438,6 +440,7 @@ static int mhi_ep_read_channel(struct mhi_ep_cntrl *mhi_cntrl,
 				tr_done = true;
 			}
 
+			mhi_chan->rd_offset = (mhi_chan->rd_offset + 1) % ring->ring_size;
 			mhi_ep_ring_inc_index(ring);
 		}
 
@@ -498,6 +501,37 @@ static int mhi_ep_process_ch_ring(struct mhi_ep_ring *ring, struct mhi_ring_elem
 	return 0;
 }
 
+static void mhi_ep_skb_completion(struct mhi_ep_buf_info *buf_info)
+{
+	struct mhi_ep_device *mhi_dev = buf_info->mhi_dev;
+	struct mhi_ep_cntrl *mhi_cntrl = mhi_dev->mhi_cntrl;
+	struct mhi_ep_chan *mhi_chan = mhi_dev->dl_chan;
+	struct mhi_ep_ring *ring = &mhi_cntrl->mhi_chan[mhi_chan->chan].ring;
+	struct mhi_ring_element *el = &ring->ring_cache[ring->rd_offset];
+	struct device *dev = &mhi_dev->dev;
+	struct mhi_result result = {};
+	int ret;
+
+	if (mhi_chan->xfer_cb) {
+		result.buf_addr = buf_info->cb_buf;
+		result.dir = mhi_chan->dir;
+		result.bytes_xferd = buf_info->size;
+
+		mhi_chan->xfer_cb(mhi_dev, &result);
+	}
+
+	dev_dbg(dev, "Sending completion for ring (%d) rd_offset: %ld\n",
+ring->er_index, ring->rd_offset);
+	ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el, buf_info->size,
+					   buf_info->code);
+	if (ret) {
+		dev_err(dev, "Error sending transfer completion event\n");
+		return;
+	}
+
+	mhi_ep_ring_inc_index(ring);
+}
+
 /* TODO: Handle partially formed TDs */
 int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 {
@@ -508,7 +542,6 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 	struct mhi_ring_element *el;
 	u32 buf_left, read_offset;
 	struct mhi_ep_ring *ring;
-	enum mhi_ev_ccs code;
 	size_t tr_len;
 	u32 tre_len;
 	int ret;
@@ -532,7 +565,7 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 			goto err_exit;
 		}
 
-		el = &ring->ring_cache[ring->rd_offset];
+		el = &ring->ring_cache[mhi_chan->rd_offset];
 		tre_len = MHI_TRE_DATA_GET_LEN(el);
 
 		tr_len = min(buf_left, tre_len);
@@ -541,33 +574,36 @@ int mhi_ep_queue_skb(struct mhi_ep_device *mhi_dev, struct sk_buff *skb)
 		buf_info.dev_addr = skb->data + read_offset;
 		buf_info.host_addr = MHI_TRE_DATA_GET_PTR(el);
 		buf_info.size = tr_len;
+		buf_info.cb = mhi_ep_skb_completion;
+		buf_info.cb_buf = skb;
+		buf_info.mhi_dev = mhi_dev;
 
-		dev_dbg(dev, "Writing %zd bytes to channel (%u)\n", tr_len, ring->ch_id);
-		ret = mhi_cntrl->write_sync(mhi_cntrl, &buf_info);
-		if (ret < 0) {
-			dev_err(dev, "Error writing to the channel\n");
-			goto err_exit;
-		}
-
-		buf_left -= tr_len;
 		/*
 		 * For all TREs queued by the host for DL channel, only the EOT flag will be set.
 		 * If the packet doesn't fit into a single TRE, send the OVERFLOW event to
 		 * the host so that the host can adjust the packet boundary to next TREs. Else send
 		 * the EOT event to the host indicating the packet boundary.
 		 */
-		if (buf_left)
-			code = MHI_EV_CC_OVERFLOW;
+		if (buf_left - tr_len)
+			buf_info.code = MHI_EV_CC_OVERFLOW;
 		else
-			code = MHI_EV_CC_EOT;
+			buf_info.code = MHI_EV_CC_EOT;
 
-		ret = mhi_ep_send_completion_event(mhi_cntrl, ring, el, tr_len, code);
-		if (ret) {
-			dev_err(dev, "Error sending transfer completion event\n");
+		dev_dbg(dev, "Writing %zd bytes to channel (%u)\n", tr_len, ring->ch_id);
+		ret = mhi_cntrl->write_async(mhi_cntrl, &buf_info);
+		if (ret < 0) {
+			dev_err(dev, "Error writing to the channel\n");
 			goto err_exit;
 		}
 
-		mhi_ep_ring_inc_index(ring);
+		buf_left -= tr_len;
+		/*
+		 * Update the read offset cached in mhi_chan. Actual read offset
+		 * will be updated by the completion handler.
+		 */
+		dev_dbg(dev, "rd_offset at the end of queue_skb: %ld\n",
+mhi_chan->rd_offset);
+		mhi_chan->rd_offset = (mhi_chan->rd_offset + 1) % ring->ring_size;
 	} while (buf_left);
 
 	mutex_unlock(&mhi_chan->lock);
@@ -807,7 +843,7 @@ static void mhi_ep_ch_ring_worker(struct work_struct *work)
 		}
 
 		/* Sanity check to make sure there are elements in the ring */
-		if (ring->rd_offset == ring->wr_offset) {
+		if (chan->rd_offset == ring->wr_offset) {
 			mutex_unlock(&chan->lock);
 			kmem_cache_free(mhi_cntrl->ring_item_cache, itr);
 			continue;
@@ -1451,6 +1487,7 @@ int mhi_ep_register_controller(struct mhi_ep_cntrl *mhi_cntrl,
 		ret = -ENOMEM;
 		goto err_destroy_tre_buf_cache;
 	}
+
 	INIT_WORK(&mhi_cntrl->state_work, mhi_ep_state_worker);
 	INIT_WORK(&mhi_cntrl->reset_work, mhi_ep_reset_worker);
 	INIT_WORK(&mhi_cntrl->cmd_ring_work, mhi_ep_cmd_ring_worker);
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 14c6e8d3f573..11bf3212f782 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -51,16 +51,20 @@ struct mhi_ep_db_info {
 
 /**
  * struct mhi_ep_buf_info - MHI Endpoint transfer buffer info
+ * @mhi_dev: MHI device associated with this buffer
  * @dev_addr: Address of the buffer in endpoint
  * @host_addr: Address of the bufffer in host
  * @size: Size of the buffer
+ * @code: Transfer completion code
  * @cb: Callback to be executed by controller drivers after transfer completion (async)
  * @cb_buf: Opaque buffer to be passed to the callback
  */
 struct mhi_ep_buf_info {
+	struct mhi_ep_device *mhi_dev;
 	void *dev_addr;
 	u64 host_addr;
 	size_t size;
+	int code;
 
 	void (*cb)(struct mhi_ep_buf_info *buf_info);
 	void *cb_buf;
-- 
2.25.1


