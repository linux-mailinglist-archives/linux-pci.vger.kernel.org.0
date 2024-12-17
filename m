Return-Path: <linux-pci+bounces-18653-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 285E79F50A5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:15:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4484818915EC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:14:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67EC71F75A5;
	Tue, 17 Dec 2024 16:05:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="F7ywJlHh"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4383A1F759C
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 16:05:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451510; cv=none; b=Ew24iVByp6WZmPcAR09EB4YZqwth2mDIEC42vzTeFavwTJnYHxb7sq/9odujaUTBwW+tzbkHXb+9799pN8FCrTdYVY9ZE1Ix7U9JlB7xzzCqX0yFOVccImFWg7gVoHHrRyrKk1zzI7Y0qRT9+DOEoxqzPNNYPDAZWIZtzGiNN0s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451510; c=relaxed/simple;
	bh=fyIlZNVelf5SMbRdM6Ux9PY3hbaZfU1cULKHILvSoBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H3JBJiKfOeLtiT5o5inaBLMlMtJc6aVBMoatbnWm3Ow4mqMVTXOoBJfej2Y/a41IKc1cgHLzmSuNM+ZTPbH68KdKsroYTwWfWGZ5u7kv9FzXg+iH4FlJrDtWR+IruOa0sCNVmHwF5PUzHcWOsgpiFhUEav8pAOWuYYjuAVqL83s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=F7ywJlHh; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E5D4DC4CED6;
	Tue, 17 Dec 2024 16:05:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451509;
	bh=fyIlZNVelf5SMbRdM6Ux9PY3hbaZfU1cULKHILvSoBQ=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=F7ywJlHhbGbwviHYvi7RJfsUdIiJW0Z20FQx9HFCIReWRiDBYegxbkfFNvVVhIr+G
	 0UmffETaTGh+3We1956dG8dOZwnUgYj7m4pnv3OYY3oPunw+UCLr0WwldSh8cxsd4h
	 RUCj/NA3PJKO3JBhIFrrv/2r4zF9E8GAB6LQqm+CfHtJ8PxzAiFGfp3l7X3dY32uzI
	 xnWhV1dbSaiRLx0mvzmmqtq0vsY7SeYT+E8msayPSU2ZncFNihIxepnd+sI2NDkmIn
	 n8PryXTsGCDqmg/359y0Nb1KmrvFoVuvtFAZTKXh9b8rxfdIzjFnSc8IFG4FisjR6P
	 xbPJY4vSbnHuA==
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
Subject: [PATCH 3/3] debug prints - DO NOT MERGE
Date: Tue, 17 Dec 2024 17:04:51 +0100
Message-ID: <20241217160448.199310-6-cassel@kernel.org>
X-Mailer: git-send-email 2.47.1
In-Reply-To: <20241217160448.199310-4-cassel@kernel.org>
References: <Z2Gf9lv6hLROjM8e@ryzen>
 <20241217160448.199310-4-cassel@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1516; i=cassel@kernel.org; h=from:subject; bh=fyIlZNVelf5SMbRdM6Ux9PY3hbaZfU1cULKHILvSoBQ=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNITFyoULRFMnNOzcVtH0f3U/9utrVcucprUeO7RArFHe X6VSsvedJSyMIhxMciKKbL4/nDZX9ztPuW44h0bmDmsTCBDGLg4BWAipj8Z/mdu4vaszuNsvPdn 9RPjVh+uZ7KaQn/8wqbevMe/LXD9UT6GP3yRvEUlFe+ZVgf12159fdj8aqUx31Tu2QUJTA+2PHS 04QIA
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/dma/dw-edma/dw-edma-core.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 29cbd947df57..eb69a608d087 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -197,6 +197,7 @@ static int dw_edma_start_transfer(struct dw_edma_chan *chan)
 	if (!desc)
 		return 0;
 
+	trace_printk("start transfer for desc: %px\n", desc);
 	child = list_first_entry_or_null(&desc->chunk->list,
 					 struct dw_edma_chunk, list);
 	if (!child)
@@ -545,6 +546,9 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		}
 	}
 
+	if (xfer->type == EDMA_XFER_MEMCPY)
+		trace_printk("DMA_MEMCPY tx_prep desc: %px\n", desc);
+
 	return vchan_tx_prep(&chan->vc, &desc->vd, xfer->flags);
 
 err_alloc:
@@ -653,6 +657,7 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 		switch (chan->request) {
 		case EDMA_REQ_NONE:
 			desc = vd2dw_edma_desc(vd);
+			trace_printk("REQ_NONE desc: %px\n", desc);
 			if (!desc->chunks_alloc) {
 				list_del(&vd->node);
 				vchan_cookie_complete(vd);
@@ -664,6 +669,8 @@ static void dw_edma_done_interrupt(struct dw_edma_chan *chan)
 			break;
 
 		case EDMA_REQ_STOP:
+			desc = vd2dw_edma_desc(vd);
+			trace_printk("REQ_STOP desc: %px\n", desc);
 			list_del(&vd->node);
 			vchan_cookie_complete(vd);
 			chan->request = EDMA_REQ_NONE;
-- 
2.47.1


