Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B7E97EA56C
	for <lists+linux-pci@lfdr.de>; Mon, 13 Nov 2023 22:22:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229635AbjKMVW2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 13 Nov 2023 16:22:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231177AbjKMVW1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 13 Nov 2023 16:22:27 -0500
Received: from mail-ot1-x336.google.com (mail-ot1-x336.google.com [IPv6:2607:f8b0:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C38B4D6D
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 13:22:20 -0800 (PST)
Received: by mail-ot1-x336.google.com with SMTP id 46e09a7af769-6d2de704f53so3060854a34.2
        for <linux-pci@vger.kernel.org>; Mon, 13 Nov 2023 13:22:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1699910540; x=1700515340; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FrYNayFoFM9tHzoTUYudYEfJt3Ast+0X5hNJQGou+iA=;
        b=Rx7Tp73bY01dgzwShcepJVH6q/SnTMnmvUONYq6v5M4TDgew54xjQkW8ub3wW65N2n
         uCEJ5E1zDWt2gZni3Q6OjrmEOWRO/qD8p17rk+ZtQSU56wFRj2V9fqflMb/QCxObfFjC
         GZ9HiL7GUoLKCYLzsOYQBDs0JwbfEuZs5yAnT+ZPons+igE2wiUu7VDWIELysnZNaqNc
         baAclkf2NlMw0ev3NXoUfagBY3jYUys1H/LCZHe5e8l43djkrH1P95ii46M7wu1mFzz2
         TTpMDpUeROgu+l9r+0puYtMRqD3RW+guemz/sLwfi+ZxidS4oM09qFgis4syCsYZg4IY
         sQRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1699910540; x=1700515340;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FrYNayFoFM9tHzoTUYudYEfJt3Ast+0X5hNJQGou+iA=;
        b=wZzeNvnKJQfT7RcvZxsD+g7hm3A826OUaq9sXrOcEOb0dZWfMoXmCZlQzSZD6nVtHe
         5GEbKnZND3Z8Fn+ZD7CsPpWsQbzsBcmWoX1Pb/j8EV5Fe33ShalG6gQCzyHSMyd/+TaY
         RVu0fdYgrQ9VH+SrKPKzri900qG0rTwfP4lYYMlIGffaOjhZv3fG8ASUzmlRQ5nWKOpx
         Jyt5UdNYUyVhXtFNA4e6wwR92eURy1e4p+tmAeiKEnbymHdi7zV0EQ6K1YHMSux9JRIJ
         XMDTNZ3nwy3Pr3agkiQ7TkxDXKFgDGo98HCkl0YayxuK6PP7bFAzteRYrzvlw+Y8H79u
         vxrA==
X-Gm-Message-State: AOJu0YxAnCLpUAy07BBv8PgqEKfGjS4LNdN6+x4dArQUMFgbVNevrKSI
        TwFrT4A4XToBvxnvE0DYgf0l0A==
X-Google-Smtp-Source: AGHT+IHLEwB2a//N0oLiPvOYb1QUOnCcdMmUe5JmfmoNRzDuCCzrgCWYYZXxWDqhJaxg/lbAtusZ6A==
X-Received: by 2002:a05:6870:3051:b0:1ea:69f6:fe09 with SMTP id u17-20020a056870305100b001ea69f6fe09mr10949790oau.10.1699910540023;
        Mon, 13 Nov 2023 13:22:20 -0800 (PST)
Received: from dns-b876885-0.sjc.aristanetworks.com ([74.123.28.14])
        by smtp.gmail.com with ESMTPSA id k17-20020aa792d1000000b006bc3e8f58besm38794pfa.56.2023.11.13.13.22.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 13 Nov 2023 13:22:19 -0800 (PST)
From:   Daniel Stodden <dns@arista.com>
To:     Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
        Logan Gunthorpe <logang@deltatee.com>,
        linux-pci@vger.kernel.org
Cc:     Daniel Stodden <dns@arista.com>
Subject: [PATCH v3] switchtec: Fix stdev_release crash after suprise device loss.
Date:   Mon, 13 Nov 2023 13:21:50 -0800
Message-ID: <20231113212150.96410-2-dns@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231113212150.96410-1-dns@arista.com>
References: <20231113212150.96410-1-dns@arista.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,T_SCC_BODY_TEXT_LINE,
        T_SPF_TEMPERROR autolearn=ham autolearn_force=no version=3.4.6
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
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
---
 drivers/pci/switch/switchtec.c | 24 ++++++++++++++++--------
 1 file changed, 16 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index e69cac84b605..d8718acdb85f 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1251,13 +1251,6 @@ static void stdev_release(struct device *dev)
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
 
@@ -1301,7 +1294,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	stdev->alive = true;
-	stdev->pdev = pdev;
+	stdev->pdev = pci_dev_get(pdev);
 	INIT_LIST_HEAD(&stdev->mrpc_queue);
 	mutex_init(&stdev->mrpc_mutex);
 	stdev->mrpc_busy = 0;
@@ -1587,6 +1580,18 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
 	return 0;
 }
 
+static void switchtec_exit_pci(struct switchtec_dev *stdev)
+{
+	if (stdev->dma_mrpc) {
+		iowrite32(0, &stdev->mmio_mrpc->dma_en);
+		flush_wc_buf(stdev);
+		writeq(0, &stdev->mmio_mrpc->dma_addr);
+		dma_free_coherent(&stdev->pdev->dev, sizeof(*stdev->dma_mrpc),
+				  stdev->dma_mrpc, stdev->dma_mrpc_dma_addr);
+		stdev->dma_mrpc = NULL;
+	}
+}
+
 static int switchtec_pci_probe(struct pci_dev *pdev,
 			       const struct pci_device_id *id)
 {
@@ -1646,6 +1651,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
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

