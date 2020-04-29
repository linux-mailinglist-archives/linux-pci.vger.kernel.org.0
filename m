Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6CF411BD189
	for <lists+linux-pci@lfdr.de>; Wed, 29 Apr 2020 03:10:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgD2BKq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Apr 2020 21:10:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726451AbgD2BKp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Apr 2020 21:10:45 -0400
Received: from mail-pj1-x1041.google.com (mail-pj1-x1041.google.com [IPv6:2607:f8b0:4864:20::1041])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 73649C03C1AD
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2020 18:10:45 -0700 (PDT)
Received: by mail-pj1-x1041.google.com with SMTP id a32so80150pje.5
        for <linux-pci@vger.kernel.org>; Tue, 28 Apr 2020 18:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=+tkvHJiORDuD9q2tyEU1ZAJYf1nqy44zTSwWoOUTzwY=;
        b=jp+A/PSmOqvf4Bh5HmmTLiDY59o40n1Ahz0ZBiYaDwWZ5nQbj3KdTnWLATLo7/0NRj
         9c+YZqUtsJlNJKJLSOWrE4YPDqZ+VLIDjxyBXivW8B7QJZqp46ZdMNVm80la9RVXMyu/
         z3QH8SYiqx+5gBgq9G6/bKF4BozsTevmm9eg1LLtUAKDeWm76lJiBTsjJA23kzbHMoW9
         WkWUdCdxAF1XueXLOfY5D0nepmGdioddbBFLlIMJpXZndWIyS2pzpY/eQeRlvRnEeW1j
         uRJgfbpYyB3IwcCT6momC2fCe0jhQ0UE1jQZT1eTlLy3wiGyojY/hFd2qUXR16xINjcw
         sStA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=+tkvHJiORDuD9q2tyEU1ZAJYf1nqy44zTSwWoOUTzwY=;
        b=A2p8DW0X91xZYAvVMGOKFZpwaakSSYK53Q89A+YZueJANFvMRbMu9jnhZ6Bbi4SHGl
         PsoiebvMx3Oj+VbRVS4SHHJa2l3MQP8fILTCDR7y2yINHx3tKBOF/buLMiLxsTHNxuze
         ZWJJuRu9Sv7CU2FlBqNQHhDnQsqF+GuI4VVMrBA/vvt75ybavX/E1A3MqiSMH6kvd6GL
         +/08HL5I+Ael3rB4ECRmyOQUczDJ9yHGdXobrrqHPfRDGGdCOKh7hsVsXjUOudI3PwQ0
         NVBBNcuWk8bFYTlwWtO5Xe47OHrKnb7/vliXuPuyXGgOrp/J8x6/cGRlMm8bVm87/wxF
         +x+g==
X-Gm-Message-State: AGi0Pua7XZe9I5Ew4DKIyAMvJsVG8aSyg/EMxXwb6hPdq44/7dvopIHg
        qg+Rv9P25ra1k6bOHhjroUYoOQ==
X-Google-Smtp-Source: APiQypLhOHgepikQE2jDvuaQt68+C/2B+QbOygZnVbwQf1VUZSTRtQckXQfUyZUYW9oYuTbwje7BZQ==
X-Received: by 2002:a17:902:bb82:: with SMTP id m2mr10064593pls.291.1588122644708;
        Tue, 28 Apr 2020 18:10:44 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id b5sm16243391pfb.190.2020.04.28.18.10.43
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 28 Apr 2020 18:10:43 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     dmaengine@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, gustavo.pimentel@synopsys.com,
        dan.j.williams@intel.com, vkoul@kernel.org, kishon@ti.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH][next] dmaengine: dw-edma: support local dma device transfer semantics
Date:   Tue, 28 Apr 2020 18:10:33 -0700
Message-Id: <1588122633-1552-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify dw_edma_device_transfer() to also support the semantics of dma
device transfer for additional use cases involving pcitest utility as a
local initiator.

For its original use case, dw-edma supported the semantics of dma device
transfer from the perspective of a remote initiator who is located across
the PCIe bus from dma channel hardware.

To a remote initiator, DMA_DEV_TO_MEM means using a remote dma WRITE
channel to transfer from remote memory to local memory. A WRITE channel
would be employed on the remote device in order to move the contents of
remote memory to the bus destined for local memory.

To a remote initiator, DMA_MEM_TO_DEV means using a remote dma READ
channel to transfer from local memory to remote memory. A READ channel
would be employed on the remote device in order to move the contents of
local memory to the bus destined for remote memory.

From the perspective of a local dma initiator who is co-located on the
same side of the PCIe bus as the dma channel hardware, the semantics of
dma device transfer are flipped.

To a local initiator, DMA_DEV_TO_MEM means using a local dma READ channel
to transfer from remote memory to local memory. A READ channel would be
employed on the local device in order to move the contents of remote
memory to the bus destined for local memory.

To a local initiator, DMA_MEM_TO_DEV means using a local dma WRITE channel
to transfer from local memory to remote memory. A WRITE channel would be
employed on the local device in order to move the contents of local memory
to the bus destined for remote memory.

To support local dma initiators, dw_edma_device_transfer() is modified to
now examine the direction field of struct dma_slave_config for the channel
which initiators can configure by calling dmaengine_slave_config().

If direction is configured as either DMA_DEV_TO_MEM or DMA_MEM_TO_DEV,
local initiator semantics are used. If direction is a value other than
DMA_DEV_TO_MEM nor DMA_MEM_TO_DEV, then remote initiator semantics are
used. This should maintain backward compatibility with the original use
case of dw-edma.

The dw-edma-test utility is an example of a remote initiator. From reading
its patch, dw-edma-test does not specifically set the direction field of
struct dma_slave_config. Since dw_edma_device_transfer() also does not
check the direction field of struct dma_slave_config, it seems safe to use
this convention in dw-edma to support both local and remote initiator
semantics.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>

This patch depends on the following patches:

[PATCH v2] dmaengine: dw-edma: Decouple dw-edma-core.c from struct pci_dev
https://patchwork.kernel.org/patch/11491757/

[PATCH v2,next] dmaengine: dw-edma: Check MSI descriptor before copying
https://patchwork.kernel.org/patch/11504849/

Rebased on linux-next next-20200428 which has above patches applied.
---
 drivers/dma/dw-edma/dw-edma-core.c | 27 ++++++++++++++++++++-------
 1 file changed, 20 insertions(+), 7 deletions(-)

diff --git a/drivers/dma/dw-edma/dw-edma-core.c b/drivers/dma/dw-edma/dw-edma-core.c
index 306ab50462be..ed430ad9b3dd 100644
--- a/drivers/dma/dw-edma/dw-edma-core.c
+++ b/drivers/dma/dw-edma/dw-edma-core.c
@@ -323,7 +323,7 @@ static struct dma_async_tx_descriptor *
 dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 {
 	struct dw_edma_chan *chan = dchan2dw_edma_chan(xfer->dchan);
-	enum dma_transfer_direction direction = xfer->direction;
+	enum dma_transfer_direction dir = xfer->direction;
 	phys_addr_t src_addr, dst_addr;
 	struct scatterlist *sg = NULL;
 	struct dw_edma_chunk *chunk;
@@ -332,10 +332,26 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 	u32 cnt;
 	int i;
 
-	if ((direction == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE) ||
-	    (direction == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ))
+	if (!chan->configured)
 		return NULL;
 
+	switch (chan->config.direction) {
+	case DMA_DEV_TO_MEM: /* local dma */
+		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_READ)
+			break;
+		return NULL;
+	case DMA_MEM_TO_DEV: /* local dma */
+		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_WRITE)
+			break;
+		return NULL;
+	default: /* remote dma */
+		if (dir == DMA_MEM_TO_DEV && chan->dir == EDMA_DIR_READ)
+			break;
+		if (dir == DMA_DEV_TO_MEM && chan->dir == EDMA_DIR_WRITE)
+			break;
+		return NULL;
+	}
+
 	if (xfer->cyclic) {
 		if (!xfer->xfer.cyclic.len || !xfer->xfer.cyclic.cnt)
 			return NULL;
@@ -344,9 +360,6 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 			return NULL;
 	}
 
-	if (!chan->configured)
-		return NULL;
-
 	desc = dw_edma_alloc_desc(chan);
 	if (unlikely(!desc))
 		goto err_alloc;
@@ -387,7 +400,7 @@ dw_edma_device_transfer(struct dw_edma_transfer *xfer)
 		chunk->ll_region.sz += burst->sz;
 		desc->alloc_sz += burst->sz;
 
-		if (direction == DMA_DEV_TO_MEM) {
+		if (chan->dir == EDMA_DIR_WRITE) {
 			burst->sar = src_addr;
 			if (xfer->cyclic) {
 				burst->dar = xfer->xfer.cyclic.paddr;
-- 
2.7.4

