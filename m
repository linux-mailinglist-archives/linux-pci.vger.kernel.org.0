Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B2FC1C21F1
	for <lists+linux-pci@lfdr.de>; Sat,  2 May 2020 02:29:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgEBA3Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 1 May 2020 20:29:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726437AbgEBA3Y (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 1 May 2020 20:29:24 -0400
Received: from mail-pl1-x642.google.com (mail-pl1-x642.google.com [IPv6:2607:f8b0:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C67C061A0E
        for <linux-pci@vger.kernel.org>; Fri,  1 May 2020 17:29:24 -0700 (PDT)
Received: by mail-pl1-x642.google.com with SMTP id t7so4222549plr.0
        for <linux-pci@vger.kernel.org>; Fri, 01 May 2020 17:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=from:to:cc:subject:date:message-id;
        bh=0gEckujgYO5yEgZCIWnLgeYgKfcc2TLCCkDUoH39Yyk=;
        b=Iw9jkJxwdpW8o7T3GhJeC2RS98jno3xBpIyuVU3DTq5SZ4c2+A+pUpk+CdFvgjObZY
         igMkXyRu4Qg9jR3GpjcBJ+btxk93gBsLxwR6GQ0KkyYlvYFNY48hgrf5Pkmf7WHCrMp7
         hLTXbnh/4wm/MjRlXsVBydzkswSdPZeSlkVP+j/aOZiUbRIWItaSk+/At8gd/ecWTd8x
         A3WuqYXYT9hsFTQ8nn7nI3vs1beW2NWk3w0nwTic98VhHK8Wz4I7hrav1Pi0gqvIYbHd
         IZagS9+Pd3+kEOi5WaevvGjnm6pJLgxR12NjKSfKnPwEefTtc3fLObiX4aDbCN6Pop73
         H13A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=0gEckujgYO5yEgZCIWnLgeYgKfcc2TLCCkDUoH39Yyk=;
        b=DSlkJ8ZaAw6VNWTMvUx/qvtFPxoOgVFD7pqdjQaqs1B0qVFgdcctfVN0iJFElK/XyD
         i/XugajabBOmqXZMETkhSejUdyygPpH4Kh3tPM+2UoFTuzi+4b8DgTTSL63BmrfAQwRP
         7R/cr1XtByh7Og3pwHfE69KlsUMnWyvPvskY/CvoR5sCAeKim6ppy/T+gYrJIldo7KfM
         rxlcOGDHhUzoCHZ71xitlLMOpY6bVa30EO+p8DL0WwcTr35taSCEIAR7xQy5Nboago5t
         cQ6TBXfi38G7frG+val3QOAaCX8/OVLnPwoczsO4jMNe1pfgh42rhJEUEq3J/xAExDPB
         +EFA==
X-Gm-Message-State: AGi0PuZND0aCh/DQelNeQ+HRgpvLvhKvgWsQ+0Vzza5GTapqqb7O/sCK
        FOsmJVw1jjYdktKthzwK3oe+f1CjESk=
X-Google-Smtp-Source: APiQypLOLqV0XKekjW6KMWr52IZeMs+tDmi2j90i1b0ur90p7W77rGfVXzy357A55biEWRxB+URsEQ==
X-Received: by 2002:a17:902:8b82:: with SMTP id ay2mr6829624plb.153.1588379363760;
        Fri, 01 May 2020 17:29:23 -0700 (PDT)
Received: from nuc7.sifive.com (c-24-5-48-146.hsd1.ca.comcast.net. [24.5.48.146])
        by smtp.gmail.com with ESMTPSA id u188sm3143644pfu.33.2020.05.01.17.29.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 01 May 2020 17:29:23 -0700 (PDT)
From:   Alan Mikhak <alan.mikhak@sifive.com>
X-Google-Original-From: Alan Mikhak < alan.mikhak@sifive.com >
To:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        efremov@linux.com, b.zolnierkie@samsung.com, vidyas@nvidia.com,
        paul.walmsley@sifive.com
Cc:     Alan Mikhak <alan.mikhak@sifive.com>
Subject: [PATCH] PCI: endpoint: functions/pci-epf-test: Support slave DMA transfer
Date:   Fri,  1 May 2020 17:29:12 -0700
Message-Id: <1588379352-22550-1-git-send-email-alan.mikhak@sifive.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Alan Mikhak <alan.mikhak@sifive.com>

Modify pci_epf_test_data_transfer() to also support slave DMA transfers.
Adds a direction parameter so caller can specify one of the supported DMA
transfer directions: DMA_MEM_TO_MEM, DMA_MEM_TO_DEV, and DMA_DEV_TO_MEM.
For DMA_MEM_TO_MEM, the function calls dmaengine_prep_dma_memcpy() as it
did before. For DMA_MEM_TO_DEV or DMA_DEV_TO_MEM direction, the function
calls dmaengine_slave_config() to configure the slave channel before it
calls dmaengine_prep_slave_single().

Modify existing callers to specify DMA_MEM_TO_MEM since that is the only
possible option so far. Rename the phys_addr local variable in some of the
callers for more readability. Tighten some of the timing function calls to
avoid counting error print time in case of error.

Signed-off-by: Alan Mikhak <alan.mikhak@sifive.com>
---
 drivers/pci/endpoint/functions/pci-epf-test.c | 67 ++++++++++++++++++---------
 1 file changed, 44 insertions(+), 23 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 60330f3e3751..1d026682febb 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -104,25 +104,41 @@ static void pci_epf_test_dma_callback(void *param)
  * The function returns '0' on success and negative value on failure.
  */
 static int pci_epf_test_data_transfer(struct pci_epf_test *epf_test,
-				      dma_addr_t dma_dst, dma_addr_t dma_src,
-				      size_t len)
+				      dma_addr_t dma_dst,
+				      dma_addr_t dma_src,
+				      size_t len,
+				      enum dma_transfer_direction dir)
 {
 	enum dma_ctrl_flags flags = DMA_CTRL_ACK | DMA_PREP_INTERRUPT;
 	struct dma_chan *chan = epf_test->dma_chan;
 	struct pci_epf *epf = epf_test->epf;
+	struct dma_slave_config sconf;
 	struct dma_async_tx_descriptor *tx;
 	struct device *dev = &epf->dev;
 	dma_cookie_t cookie;
+	dma_addr_t buf;
 	int ret;
 
 	if (IS_ERR_OR_NULL(chan)) {
-		dev_err(dev, "Invalid DMA memcpy channel\n");
+		dev_err(dev, "Invalid DMA channel\n");
 		return -EINVAL;
 	}
 
-	tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src, len, flags);
+	if (dir == DMA_MEM_TO_MEM) {
+		tx = dmaengine_prep_dma_memcpy(chan, dma_dst, dma_src,
+					       len, flags);
+	} else {
+		memset(&sconf, 0, sizeof(sconf));
+		sconf.direction = dir;
+		sconf.dst_addr = dma_dst;
+		sconf.src_addr = dma_src;
+		dmaengine_slave_config(chan, &sconf);
+
+		buf = (dir == DMA_MEM_TO_DEV) ? dma_dst : dma_src;
+		tx = dmaengine_prep_slave_single(chan, buf, len, dir, flags);
+	}
 	if (!tx) {
-		dev_err(dev, "Failed to prepare DMA memcpy\n");
+		dev_err(dev, "Failed to prepare DMA transfer\n");
 		return -EIO;
 	}
 
@@ -268,7 +284,6 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 		goto err_dst_addr;
 	}
 
-	ktime_get_ts64(&start);
 	use_dma = !!(reg->flags & FLAG_USE_DMA);
 	if (use_dma) {
 		if (!epf_test->dma_supported) {
@@ -277,14 +292,18 @@ static int pci_epf_test_copy(struct pci_epf_test *epf_test)
 			goto err_map_addr;
 		}
 
+		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 src_phys_addr, reg->size);
+						 src_phys_addr, reg->size,
+						 DMA_MEM_TO_MEM);
+		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
 	} else {
+		ktime_get_ts64(&start);
 		memcpy(dst_addr, src_addr, reg->size);
+		ktime_get_ts64(&end);
 	}
-	ktime_get_ts64(&end);
 	pci_epf_test_print_rate("COPY", reg->size, &start, &end, use_dma);
 
 err_map_addr:
@@ -310,7 +329,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	void *buf;
 	u32 crc32;
 	bool use_dma;
-	phys_addr_t phys_addr;
+	phys_addr_t src_phys_addr;
 	phys_addr_t dst_phys_addr;
 	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
@@ -319,8 +338,9 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	enum dma_transfer_direction dir = DMA_MEM_TO_MEM;
 
-	src_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+	src_addr = pci_epc_mem_alloc_addr(epc, &src_phys_addr, reg->size);
 	if (!src_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_SRC_ADDR_INVALID;
@@ -328,7 +348,7 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->src_addr,
+	ret = pci_epc_map_addr(epc, epf->func_no, src_phys_addr, reg->src_addr,
 			       reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
@@ -360,10 +380,10 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 
 		ktime_get_ts64(&start);
 		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
-						 phys_addr, reg->size);
+						 src_phys_addr, reg->size, dir);
+		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
-		ktime_get_ts64(&end);
 
 		dma_unmap_single(dma_dev, dst_phys_addr, reg->size,
 				 DMA_FROM_DEVICE);
@@ -383,10 +403,10 @@ static int pci_epf_test_read(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, src_phys_addr);
 
 err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, src_addr, reg->size);
+	pci_epc_mem_free_addr(epc, src_phys_addr, src_addr, reg->size);
 
 err:
 	return ret;
@@ -398,7 +418,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	void __iomem *dst_addr;
 	void *buf;
 	bool use_dma;
-	phys_addr_t phys_addr;
+	phys_addr_t dst_phys_addr;
 	phys_addr_t src_phys_addr;
 	struct timespec64 start, end;
 	struct pci_epf *epf = epf_test->epf;
@@ -407,8 +427,9 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	struct device *dma_dev = epf->epc->dev.parent;
 	enum pci_barno test_reg_bar = epf_test->test_reg_bar;
 	struct pci_epf_test_reg *reg = epf_test->reg[test_reg_bar];
+	enum dma_transfer_direction dir = DMA_MEM_TO_MEM;
 
-	dst_addr = pci_epc_mem_alloc_addr(epc, &phys_addr, reg->size);
+	dst_addr = pci_epc_mem_alloc_addr(epc, &dst_phys_addr, reg->size);
 	if (!dst_addr) {
 		dev_err(dev, "Failed to allocate address\n");
 		reg->status = STATUS_DST_ADDR_INVALID;
@@ -416,7 +437,7 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		goto err;
 	}
 
-	ret = pci_epc_map_addr(epc, epf->func_no, phys_addr, reg->dst_addr,
+	ret = pci_epc_map_addr(epc, epf->func_no, dst_phys_addr, reg->dst_addr,
 			       reg->size);
 	if (ret) {
 		dev_err(dev, "Failed to map address\n");
@@ -450,11 +471,11 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 		}
 
 		ktime_get_ts64(&start);
-		ret = pci_epf_test_data_transfer(epf_test, phys_addr,
-						 src_phys_addr, reg->size);
+		ret = pci_epf_test_data_transfer(epf_test, dst_phys_addr,
+						 src_phys_addr,	reg->size, dir);
+		ktime_get_ts64(&end);
 		if (ret)
 			dev_err(dev, "Data transfer failed\n");
-		ktime_get_ts64(&end);
 
 		dma_unmap_single(dma_dev, src_phys_addr, reg->size,
 				 DMA_TO_DEVICE);
@@ -476,10 +497,10 @@ static int pci_epf_test_write(struct pci_epf_test *epf_test)
 	kfree(buf);
 
 err_map_addr:
-	pci_epc_unmap_addr(epc, epf->func_no, phys_addr);
+	pci_epc_unmap_addr(epc, epf->func_no, dst_phys_addr);
 
 err_addr:
-	pci_epc_mem_free_addr(epc, phys_addr, dst_addr, reg->size);
+	pci_epc_mem_free_addr(epc, dst_phys_addr, dst_addr, reg->size);
 
 err:
 	return ret;
-- 
2.7.4

