Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE6866CBD06
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 13:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229654AbjC1LGU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 07:06:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231913AbjC1LGS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 07:06:18 -0400
Received: from out-46.mta1.migadu.com (out-46.mta1.migadu.com [95.215.58.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3EF3B3ABE
        for <linux-pci@vger.kernel.org>; Tue, 28 Mar 2023 04:06:16 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1680001573;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=Y8D9sO9I+gaBvRQLJtfXH/K5nhza2Ci/mHxkKAkahbg=;
        b=euwok7u6FQ4r8zkspXkYk0fOnl51bx0DY9e/YFW5p2M2HHij3/WdGDk3xEH9moRFvGDbRO
        E1N/fBuMI8FcMqoRD80EIZz7ypznK2jYnraCQlEPXrQLq8glpi59pxtzJkI9Nl0Ku/Wr/7
        1L3vaMfz4di8biob1tbQAEkc19SUpx4=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
Date:   Tue, 28 Mar 2023 19:06:10 +0800
Message-Id: <20230328110610.3824-1-cai.huoqing@linux.dev>
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
because pci_p2pmem_dma() method is already removed.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
v1->v2:
  1.remove pci_p2pmem_dma() reference directly instead of
    using pci_p2pdma_map_segment().

v1 link:
  https://lore.kernel.org/lkml/eea970cd-d781-9d4c-e020-9086505a4ba7@deltatee.com/

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

