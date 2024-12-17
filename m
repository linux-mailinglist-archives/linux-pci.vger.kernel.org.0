Return-Path: <linux-pci+bounces-18652-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0AF2E9F50AC
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 17:16:55 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6F8B416A31F
	for <lists+linux-pci@lfdr.de>; Tue, 17 Dec 2024 16:14:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA7CA1F7545;
	Tue, 17 Dec 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="nEZywKqd"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A3B041F758C
	for <linux-pci@vger.kernel.org>; Tue, 17 Dec 2024 16:05:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1734451506; cv=none; b=WlFjhlkOs9clDzUcJH5pQBw94dkslxd0SG0tFk/Thh9VBXS4afUog4042yh4PGix5NM1T0ZtHs37u6iBZkL0VK/tyi5SR3iF3at0DT4LsgTVFaAMQVeM2+iQKrjRPNXPS9N5S1DcHhbKDJZifzvRW930JVoiPPT4UQ1hNOtiff0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1734451506; c=relaxed/simple;
	bh=DB82UMamGsd29tTD7UzEWTxuioiXlTLHeqMQU4t60m0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=FX9/UnBd4Rjua90g+xDRbfpPOYF5coYKgflsehUGTmi/7fboTXUNsDYhh+ZyCYKwBZNirBnz5i9q9mnd5jyitbqYrKdpoCeYBoKZQJLuFwKJTx75PwaXGbci2OI86ncerrbLGOh5pVXWG1OuMYguvUAU7TiFYfwX9MEIqVGE1x8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=nEZywKqd; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 8B802C4CED3;
	Tue, 17 Dec 2024 16:05:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1734451506;
	bh=DB82UMamGsd29tTD7UzEWTxuioiXlTLHeqMQU4t60m0=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=nEZywKqdk9Fly9JEBUaBV2yzsGp9UkLourKYNdejmv+7jBrlRB8ivW9ayZD6dpb/q
	 Tt5zNo+HhSzueKpRw9NqHbb5XynM0RLioVL+8cNUHPPAKVn0wsm/uL2acyPJOJCtnE
	 XDjuoLypww1Mu8fJPhiYc2OfgtekLpzzCh3kuyAFyOsXaeVy5a5QlPn7pILKy1yKf4
	 8MgaJwQws486++DCNIZrCCJBp0WMvi0lvCG6zDlvC3vhbhitLOMfxN0QEWLqT1BvTl
	 Shgs0q/bBHVV0C3zyrWs4Im90RfFny5v+3XEmk0ncmQbtNOtrWzlEtroRxtFXwOcKO
	 b5x8tmwIsduXg==
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
Subject: [PATCH 2/3] PCI: endpoint: pci-epf-test: Use private DMA_MEMCPY channel
Date: Tue, 17 Dec 2024 17:04:50 +0100
Message-ID: <20241217160448.199310-5-cassel@kernel.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=2298; i=cassel@kernel.org; h=from:subject; bh=DB82UMamGsd29tTD7UzEWTxuioiXlTLHeqMQU4t60m0=; b=owGbwMvMwCV2MsVw8cxjvkWMp9WSGNITFyrE71W9Gyr9WzUvwuv7/oV3rEqubi46ULo7qibg1 zLjEKNFHaUsDGJcDLJiiiy+P1z2F3e7TzmueMcGZg4rE8gQBi5OAZjIU1FGhrlz2PeJbXrNNvUZ z8WannShqgeFHz5zrCkxkFcQK561qpyRYXKLmGWH3YLVrw6u1NE8EnJ4Va5f50JDNZMPn5kWr78 owA4A
X-Developer-Key: i=cassel@kernel.org; a=openpgp; fpr=5ADE635C0E631CBBD5BE065A352FE6582ED9B5DA
Content-Transfer-Encoding: 8bit

First try to use a DMA channel with DMA_PRIVATE and DMA_MEMCPY.
If there is no such channel, fall back to a DMA_MEMCPY channel
(without DMA_PRIVATE).

Signed-off-by: Niklas Cassel <cassel@kernel.org>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 24 +++----------------
 1 file changed, 3 insertions(+), 21 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index ef6677f34116..8315225d81bd 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -123,11 +123,9 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 {
 	struct dma_chan *chan = (dir == DMA_MEM_TO_DEV) ?
 				 epf_test->dma_chan_tx : epf_test->dma_chan_rx;
-	dma_addr_t dma_local = (dir == DMA_MEM_TO_DEV) ? dma_src : dma_dst;
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct pci_epf *epf = epf_test->epf;
 	struct dma_async_tx_descriptor *tx;
-	struct dma_slave_config sconf = {};
 	struct device *dev = &epf->dev;
 	int ret;
 
@@ -136,24 +134,7 @@ static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
 		return -EINVAL;
 	}
 
-	if (epf_test->dma_private) {
-		sconf.direction = dir;
-		if (dir == DMA_MEM_TO_DEV)
-			sconf.dst_addr = dma_remote;
-		else
-			sconf.src_addr = dma_remote;
-
-		if (dmaengine_slave_config(chan, &sconf)) {
-			dev_err(dev, "DMA slave config fail\n");
-			return -EIO;
-		}
-		tx = dmaengine_prep_slave_single(chan, dma_local, len, dir,
-						 flags);
-	} else {
-		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len,
-					       flags);
-	}
-
+	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
 	if (!tx) {
 		dev_err(dev, "Failed to prepare DMA memcpy\n");
 		return -EIO;
@@ -225,7 +206,8 @@ static int pci_epf_test_init_dma_chan(struct pci_epf_test *epf_test)
 	filter.dma_mask = BIT(DMA_DEV_TO_MEM);
 
 	dma_cap_zero(mask);
-	dma_cap_set(DMA_SLAVE, mask);
+	dma_cap_set(DMA_PRIVATE, mask);
+	dma_cap_set(DMA_MEMCPY, mask);
 	dma_chan = dma_request_channel(mask, epf_dma_filter_fn, &filter);
 	if (!dma_chan) {
 		dev_info(dev, "Failed to get private DMA rx channel. Falling back to generic one\n");
-- 
2.47.1


