Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42FC86CD050
	for <lists+linux-pci@lfdr.de>; Wed, 29 Mar 2023 04:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjC2Crj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 22:47:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35434 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229807AbjC2Cri (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 22:47:38 -0400
Received: from out-38.mta1.migadu.com (out-38.mta1.migadu.com [IPv6:2001:41d0:203:375::26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50CD32D75
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 19:47:37 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680058054;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=nfK5Bb/iQJxJA2jxL79gxKdT1HVYp9O1g7qgmHm1uQk=;
        b=iCOY3VWCX4xuq01cJayOvUmJJE5x6ejDdSKqr8YYhWgJjyFds5/P3zbe5Wve64JP+cmol8
        Pn5vYgnV4ddfO5aldVRQCS2WU2Q6AHcD4/8x6y8Pe/NyBHZP+6UGgiioo9xlXVcFDoUOdJ
        wsZ4lSD6sP2lT6LfzVHVn2bvx+WzYCA=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Logan Gunthorpe <logang@deltatee.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
Date:   Wed, 29 Mar 2023 10:47:31 +0800
Message-Id: <20230329024731.5604-1-cai.huoqing@linux.dev>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,TO_EQ_FM_DIRECT_MX
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove pci_p2pmem_dma() reference,
because pci_p2pmem_dma() method is not existed.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
v2->v3:
  Update commit log-pci_p2pmem_dma() method is not existed.

v2 link:
  https://lore.kernel.org/lkml/20230328110610.3824-1-cai.huoqing@linux.dev/

 drivers/pci/p2pdma.c | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9e8205572830..6cd98ffca198 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -746,8 +746,7 @@ EXPORT_SYMBOL_GPL(pci_has_p2pmem);
 
 /**
  * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
- *	the specified list of clients and shortest distance (as determined
- *	by pci_p2pmem_dma())
+ *	the specified list of clients and shortest distance
  * @clients: array of devices to check (NULL-terminated)
  * @num_clients: number of client devices in the list
  *
-- 
2.34.1

