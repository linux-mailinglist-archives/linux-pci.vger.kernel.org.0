Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C1577E809F
	for <lists+linux-pci@lfdr.de>; Fri, 10 Nov 2023 19:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbjKJSRR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Nov 2023 13:17:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344827AbjKJSPE (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Nov 2023 13:15:04 -0500
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 802862FEF3
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 03:35:37 -0800 (PST)
Received: by mail-pf1-x436.google.com with SMTP id d2e1a72fcca58-6b87c1edfd5so1703879b3a.1
        for <linux-pci@vger.kernel.org>; Fri, 10 Nov 2023 03:35:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699616137; x=1700220937; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Q45XplgW545lzAM8ysECM/GqD1qpkxIkFCdOGfGE3a0=;
        b=AzGZiFFe+KsG12tqbuxqd8RwajW8bB/7I3mx7sdJ+qKY2IqvTq4qDPzgpzHeY2rGL9
         aOiRWJnS593R8YsfdVWkKYJc8v9tiDQO1OzlDWQAjaJJBkqPeSeKPOcpnOq8GFsn72ws
         H+sOSR7YW7sUAqbTDk3NtE31xZNxGZvBrzNKOe/uci6DVxdFWSMIgf/B+hgugXioYPRJ
         cRoN+n1hNFINTuq2NNfOHxCNHUeG57As2StX4i8UCM/PNyHjUB4lCJeazEoYoXk13RsW
         s/FBsPkXW4SSwGwdcm4ymNZwIXx74BNNmq7q/+M8etAAPohB1tVboGVbD9XSY2WXemfq
         xRRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699616137; x=1700220937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q45XplgW545lzAM8ysECM/GqD1qpkxIkFCdOGfGE3a0=;
        b=tFOJ6hViahdn3Rdlihy4DbHZQYoVkOisZqAbYXowon1Bpxko3iK3TejdjvKBjciYSf
         y6KoPLfOxjd6y3SO7zksx4RWaSK3b3um3eh6mc3EqK292v6n178rUVuR2tSH96Lfkgbn
         6/JSY2XOqA/NB1hkH23QlxbavPh1wBz6VhFmV4BluGJwwDpeX1sgqL9kyaUFCsW3HK/Y
         rHr+jEjVxkzIon15BkWIkFB2vkYA931TUieu5SoRbGttPSU1AQLOHHMSO6WX7RkyTSon
         BYHIyRKnsTy3hAndLujbbWb9nB70XwyJdXkNkVuU5Ov83slOM6kqBqQbHY+vviF/Mr9c
         wyVA==
X-Gm-Message-State: AOJu0Yzb088abn/JeT2rpZG22V6UEY6j+sbm59oUTyy8dY7+zoW5wvJ0
        4hlhhXpUrSPfLgBLjgCZ+96OCQ==
X-Google-Smtp-Source: AGHT+IGQsh5tdz5zvVIJuYSfJp3cJ2oRZs8d0c6c1cP4GFjc/aeDQWL4Jd8V06I8VI0iZ+c+iMreFw==
X-Received: by 2002:a05:6a00:2e04:b0:690:3b59:cc7b with SMTP id fc4-20020a056a002e0400b006903b59cc7bmr8720331pfb.32.1699616136894;
        Fri, 10 Nov 2023 03:35:36 -0800 (PST)
Received: from dns-msemi-midplane-0.sjc.aristanetworks.com ([74.123.28.12])
        by smtp.gmail.com with ESMTPSA id z16-20020aa78890000000b006bdd7cbcf98sm12309574pfe.182.2023.11.10.03.35.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Nov 2023 03:35:36 -0800 (PST)
From:   Daniel Stodden <dns@arista.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deo2ltatee.com>,
        linux-pci@vger.kernel.org
Cc:     Daniel Stodden <dns@arista.com>
Subject: [PATCH 1/1] switchtec: Fix stdev_release crash after suprise device loss.
Date:   Fri, 10 Nov 2023 03:35:12 -0800
Message-ID: <20231110113512.83254-2-dns@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231110113512.83254-1-dns@arista.com>
References: <20231110113512.83254-1-dns@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

A pci device hot removal may occur while stdev->cdev is held open. The
call to stdev_release is then delivered during close or exit, at a
point way past switchtec_pci_remove. Otherwise the last ref would
vanish with the trailing put_device, just before return.

At that later point in time, the device layer has alreay removed
stdev->mrpc_mmio map. Also, the stdev->pdev reference was not a
counted one. Therefore, in dma mode, the iowrite32 in stdev_release
will cause a fatal page fault, and the subsequent dma_free_coherent,
if reached, would pass a stale &stdev->pdev->dev pointer.

Fixed by moving mrpc dma shutdown into switchtec_pci_remove, after
stdev_kill. Counting the stdev->pdev ref is now optional, but may
prevent future accidents.

Signed-off-by: Daniel Stodden <dns@arista.com>
---
 drivers/pci/switch/switchtec.c | 29 +++++++++++++++++++++--------
 1 file changed, 21 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e69cac84b605..002d0205d263 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1247,17 +1247,17 @@ static void enable_dma_mrpc(struct switchtec_dev *stdev)
 	iowrite32(SWITCHTEC_DMA_MRPC_EN, &stdev->mmio_mrpc->dma_en);
 }
 
+static void disable_dma_mrpc(struct switchtec_dev *stdev)
+{
+	iowrite32(0, &stdev->mmio_mrpc->dma_en);
+	flush_wc_buf(stdev);
+	writeq(0, &stdev->mmio_mrpc->dma_addr);
+}
+
 static void stdev_release(struct device *dev)
 {
 	struct switchtec_dev *stdev = to_stdev(dev);
 
-	if (stdev->dma_mrpc) {
-		iowrite32(0, &stdev->mmio_mrpc->dma_en);
-		flush_wc_buf(stdev);
-		writeq(0, &stdev->mmio_mrpc->dma_addr);
-		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
-				stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
-	}
 	kfree(stdev);
 }
 
@@ -1301,7 +1301,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	stdev->alive = true;
-	stdev->pdev = pdev;
+	stdev->pdev = pci_dev_get(pdev);
 	INIT_LIST_HEAD(&stdev->mrpc_queue);
 	mutex_init(&stdev->mrpc_mutex);
 	stdev->mrpc_busy = 0;
@@ -1587,6 +1587,16 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	return 0;
 }
 
+static void switchtec_exit_pci(struct switchtec_dev *stdev)
+{
+	if (stdev->dma_mrpc) {
+		disable_dma_mrpc(stdev);
+		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
+				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
+		stdev->dma_mrpc = NULL;
+	}
+}
+
 static int switchtec_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -1646,6 +1656,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	ida_simple_remove(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
 	stdev_kill(stdev);
+	switchtec_exit_pci(stdev);
+	pci_dev_put(stdev->pdev);
+	stdev->pdev = NULL;
 	put_device(&stdev->dev);
 }
 
-- 
2.41.0

