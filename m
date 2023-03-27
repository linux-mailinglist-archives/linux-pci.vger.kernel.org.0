Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12EDF6C9C40
	for <lists+linux-pci@lfdr.de>; Mon, 27 Mar 2023 09:36:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232591AbjC0Hgx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 27 Mar 2023 03:36:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjC0Hgs (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 27 Mar 2023 03:36:48 -0400
Received: from out-9.mta0.migadu.com (out-9.mta0.migadu.com [91.218.175.9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4716A4EF6
        for <linux-pci@vger.kernel.org>; Mon, 27 Mar 2023 00:36:27 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1679902568;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=fp2UGoKTvW/kaP4d5q8HelXdsHSzblTbfWgf46WTYd0=;
        b=EH8MBW5PJCzwaboGFaolhM2uo+0sG3UzIlZCJxOEZ/XMw35SH4MR16wtNAF0kuxnf2jOP4
        +LCSpY9kaEWd4ro/i2bdKhkyuo7uus9rsd4jpeT4oYQAvR08wTiNUpvJuqu3ex93D4+oxD
        aHFZxxCWLdV7pbO4/12fdQYM+u18c0U=
From:   Cai Huoqing <cai.huoqing@linux.dev>
To:     cai.huoqing@linux.dev
Cc:     Bjorn Helgaas <bhelgaas@google.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] PCI/P2PDMA: Fix the comments on pci_p2pmem_find_many()
Date:   Mon, 27 Mar 2023 15:36:04 +0800
Message-Id: <20230327073604.5449-1-cai.huoqing@linux.dev>
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

Use pci_p2pdma_map_segment() instead of pci_p2pmem_dma(),
because pci_p2pmem_dma() is already removed.

Signed-off-by: Cai Huoqing <cai.huoqing@linux.dev>
---
 drivers/pci/p2pdma.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
index 9e8205572830..4f1798ecf38f 100644
--- a/drivers/pci/p2pdma.c
+++ b/drivers/pci/p2pdma.c
@@ -747,7 +747,7 @@ EXPORT_SYMBOL_GPL(pci_has_p2pmem);
 /**
  * pci_p2pmem_find_many - find a peer-to-peer DMA memory device compatible with
  *	the specified list of clients and shortest distance (as determined
- *	by pci_p2pmem_dma())
+ *	by pci_p2pdma_map_segment())
  * @clients: array of devices to check (NULL-terminated)
  * @num_clients: number of client devices in the list
  *
-- 
2.34.1

