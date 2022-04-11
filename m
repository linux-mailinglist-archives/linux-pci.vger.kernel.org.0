Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8ED174FBC92
	for <lists+linux-pci@lfdr.de>; Mon, 11 Apr 2022 14:54:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346268AbiDKM44 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 11 Apr 2022 08:56:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35580 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346280AbiDKM4u (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 11 Apr 2022 08:56:50 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D46E71836B
        for <linux-pci@vger.kernel.org>; Mon, 11 Apr 2022 05:54:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=In-Reply-To:Content-Transfer-Encoding
        :Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
        Sender:Reply-To:Content-ID:Content-Description;
        bh=H1b8nJnoQ9ZMI7mvzbYQCh6vjsLiqbmcakillW/LgTw=; b=eI7rlQOeMbTUQXXdKgYng85kHu
        fBY0YWGvhyI1193q7YJvAT2L2yEjDmdSrZlPhH22ky0EGxpqX0aMevvTNkrL81AzgOb3h4rhKAEec
        qGY0UF3BTLU/GJnFJ+VibFDLCuOuId0EqhhrHTvTXwooUs8ap6ibdIFNmoZNSbpHK1BiA7a9Dsx97
        ZEDgRr7yCCOb4COJiZGyisMRXItn0ZwFCrX6cmDpSEcc0LLIldvHd64c9FwlqNegX5UVs8/tOzEtJ
        hwNRW3h7vO6SH2R+JriBZ7PwOAvIdzUSKtFwrJ1MbIOrQo7RIaJhC/5ZJPZzdmMBl2IzeCJTCIElU
        66l2YGhg==;
Received: from hch by bombadil.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ndtYl-0092ow-EH; Mon, 11 Apr 2022 12:54:23 +0000
Date:   Mon, 11 Apr 2022 05:54:23 -0700
From:   Christoph Hellwig <hch@infradead.org>
To:     Wangseok Lee <wangseok.lee@samsung.com>
Cc:     Christoph Hellwig <hch@infradead.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Alexander Lobakin <alexandr.lobakin@intel.com>,
        "jingoohan1@gmail.com" <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "robh@kernel.org" <robh@kernel.org>, "kw@linux.com" <kw@linux.com>,
        "bhelgaas@google.com" <bhelgaas@google.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "jesper.nilsson@axis.com" <jesper.nilsson@axis.com>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "kernel@axis.com" <kernel@axis.com>,
        Moon-Ki Jun <moonki.jun@samsung.com>,
        Robin Murphy <robin.murphy@arm.com>
Subject: Re: [PATCH] PCI: dwc: Modify the check about MSI DMA mask 32-bit
Message-ID: <YlQk/9hFnb+/TpHo@infradead.org>
References: <YkR7G/V8E+NKBA2h@infradead.org>
 <20220328143228.1902883-1-alexandr.lobakin@intel.com>
 <20220328023009epcms2p309a5dfc2ff29d0a9945f65799963193c@epcms2p3>
 <20220330035203epcms2p8fb560f4f953c5a2c8fff020432adc9bd@epcms2p8>
 <20220330093526.2728238-1-alexandr.lobakin@intel.com>
 <20220408023401epcms2p41024174e7e09d475e0186fbdb954ec7c@epcms2p4>
 <20220408053246epcms2p73d79512797c778a320394fe12e07edc6@epcms2p7>
 <20220411065905epcms2p56ee71c0142258494afb80ce26dc04039@epcms2p5>
 <CGME20220328143454epcas2p27a340d09e9f4e74af1eaa44559e372a5@epcms2p1>
 <20220411094744epcms2p152a3a161ce35835464b7e745dd86050a@epcms2p1>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220411094744epcms2p152a3a161ce35835464b7e745dd86050a@epcms2p1>
X-SRS-Rewrite: SMTP reverse-path rewritten from <hch@infradead.org> by bombadil.infradead.org. See http://www.infradead.org/rpr.html
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Apr 11, 2022 at 06:47:44PM +0900, Wangseok Lee wrote:
> >> Therefore, the dma_set_mask(32)(in dw_pcie_host_init())
> >> was modified to be performed only when
> >> the dev-dma_mask is not set larger than 32 bits.
> > 
> > So what sets dev->dma_mask to a larger than 32-bit value here?
> > We need to find and fix that.
> 
> At the code of of_dma_configure_id() of driver/of/device.c..
> In the 64bit system, if the dma start addr is used as 0x1'0000'0000
> and the size is used as 0xf'0000'0000, "u64 end" is 0xf'ffff'ffff. 
> And the dma_mask value is changed from 0xffff'ffff'ffff'ffff to
> 0xf'ffff'ffffff due to the code below.

That does look rather wrong to me, as any limitation should only
be in the bus mask.  Unless I'm missing something (and Robin should
know the code much better than I do) we should do something like
the patch below:

diff --git a/drivers/of/device.c b/drivers/of/device.c
index 874f031442dc7..b197861fcde08 100644
--- a/drivers/of/device.c
+++ b/drivers/of/device.c
@@ -113,8 +113,7 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 {
 	const struct iommu_ops *iommu;
 	const struct bus_dma_region *map = NULL;
-	u64 dma_start = 0;
-	u64 mask, end, size = 0;
+	u64 dma_start = 0, size = 0;
 	bool coherent;
 	int ret;
 
@@ -156,6 +155,9 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 			kfree(map);
 			return -EINVAL;
 		}
+
+		dev->bus_dma_limit = dma_start + size - 1;
+		dev->dma_range_map = map;
 	}
 
 	/*
@@ -169,25 +171,6 @@ int of_dma_configure_id(struct device *dev, struct device_node *np,
 		dev->dma_mask = &dev->coherent_dma_mask;
 	}
 
-	if (!size && dev->coherent_dma_mask)
-		size = max(dev->coherent_dma_mask, dev->coherent_dma_mask + 1);
-	else if (!size)
-		size = 1ULL << 32;
-
-	/*
-	 * Limit coherent and dma mask based on size and default mask
-	 * set by the driver.
-	 */
-	end = dma_start + size - 1;
-	mask = DMA_BIT_MASK(ilog2(end) + 1);
-	dev->coherent_dma_mask &= mask;
-	*dev->dma_mask &= mask;
-	/* ...but only set bus limit and range map if we found valid dma-ranges earlier */
-	if (!ret) {
-		dev->bus_dma_limit = end;
-		dev->dma_range_map = map;
-	}
-
 	coherent = of_dma_is_coherent(np);
 	dev_dbg(dev, "device is%sdma coherent\n",
 		coherent ? " " : " not ");
