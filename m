Return-Path: <linux-pci+bounces-84-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 246D27F3CBC
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 05:24:36 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B05CB281A78
	for <lists+linux-pci@lfdr.de>; Wed, 22 Nov 2023 04:24:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9C0EFBE7F;
	Wed, 22 Nov 2023 04:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=arista.com header.i=@arista.com header.b="CmrO6eBJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3D9D810C
	for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 20:24:29 -0800 (PST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-1cf6a67e290so19603095ad.1
        for <linux-pci@vger.kernel.org>; Tue, 21 Nov 2023 20:24:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=arista.com; s=google; t=1700627069; x=1701231869; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=dDvpQU8CagtXY0hjWAvXFMgPMYkRqTTgJ+Oz9XdOngA=;
        b=CmrO6eBJZ/BBdskfUMhDfdx7L8EXPTXA/zbXkr0Q4hEiAYXIll3dc12FlBe37YT+Kc
         AoB4hRI33NIo1Z3eRezvVvB/eDc4zKlPQIe1qs2vL0ZWi8IYbu6Xve84vTmTlGeftMwd
         uCqIB9COqtATwSzHyY7QpauZ09hmesFe6LBjQ/aa0kgFVs7AqmNP9Eft5rizRqzPs8Cn
         mw3p5AYxzwql7v27hjWkCtNeX+Ti/oQhPHbnwTbLJF7wsOrYI8ovuwMi099g7nnpmK6d
         fHFal5OcSigg2OBBjkuepsKqW3IlGWzW9Xe6N6pK4S9dWxhKm5rzZ1pHV3hRAT2z85gf
         VuzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1700627069; x=1701231869;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=dDvpQU8CagtXY0hjWAvXFMgPMYkRqTTgJ+Oz9XdOngA=;
        b=X06ypSxQljqctRy7i7j5sZj2a3IYxAoyK4uhTmjOJAJoAKLS48CilC3eDGqB2RIiKZ
         BmyGWVtLcVD/vRhuLX4xfRMmFKvnqZWZXgv47hMDGTbCeVZeFOw3gokYuuH7lt9F+Ibw
         /VvOotspj3szsQGOQ5h9TSBVmA0y0AE/BGaRsxCgQl4XZuZ5MlF6ohP84d6RPguVCZsJ
         S0sagENNC9KMRR0MIJfOJBsrwDKSG0PKdoaYFRsnCETiUyKmXu2v6bajLWF0jTKLoeGZ
         2UlCQBufTcapQ9n0jDm+Ex2BemPLS0twtsgCsY+ysbaFUsOMRhIolPhyB5PphcL300x2
         NVlg==
X-Gm-Message-State: AOJu0YxbdpqQScbx9rVDj2lOzQyRMTETZOcAKfEKMzqbgXkXBBwKHD4K
	wE02tucOnpj850nB8rt7P4v98Q==
X-Google-Smtp-Source: AGHT+IEp+mhL88l8JX4GG3Ll5LjtbQbsH7Hxx9NCQyCY2jY2MQcy4aB4GyV5lBbls0hTmj3esBZEgQ==
X-Received: by 2002:a17:903:5c3:b0:1cf:6b8f:5af4 with SMTP id kf3-20020a17090305c300b001cf6b8f5af4mr1052131plb.43.1700627068559;
        Tue, 21 Nov 2023 20:24:28 -0800 (PST)
Received: from dns-b876885-0.sjc.aristanetworks.com ([74.123.28.13])
        by smtp.gmail.com with ESMTPSA id jd22-20020a170903261600b001c61901ed37sm8773684plb.191.2023.11.21.20.24.27
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 21 Nov 2023 20:24:28 -0800 (PST)
From: Daniel Stodden <dns@arista.com>
To: Bjorn Helgaas <helgaas@kernel.org>
Cc: Dmitry Safonov <dima@arista.com>,
	Logan Gunthorpe <logang@deltatee.com>,
	Kurt Schwemmer <kurt.schwemmer@microsemi.com>,
	linux-pci@vger.kernel.org,
	Daniel Stodden <dns@arista.com>,
	Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v4 1/1] PCI: switchtec: Fix stdev_release() crash after surprise hot remove
Date: Tue, 21 Nov 2023 20:23:16 -0800
Message-ID: <20231122042316.91208-2-dns@arista.com>
X-Mailer: git-send-email 2.41.0
In-Reply-To: <20231122042316.91208-1-dns@arista.com>
References: <20231122042316.91208-1-dns@arista.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

A PCI device hot removal may occur while stdev->cdev is held open. The call
to stdev_release() then happens during close or exit, at a point way past
switchtec_pci_remove(). Otherwise the last ref would vanish with the
trailing put_device(), just before return.

At that later point in time, the devm cleanup has already removed the
stdev->mmio_mrpc mapping. Also, the stdev->pdev reference was not a counted
one. Therefore, in DMA mode, the iowrite32() in stdev_release() will cause
a fatal page fault, and the subsequent dma_free_coherent(), if reached,
would pass a stale &stdev->pdev->dev pointer.

Fix by moving MRPC DMA shutdown into switchtec_pci_remove(), after
stdev_kill(). Counting the stdev->pdev ref is now optional, but may prevent
future accidents.

Reproducible via the script at
https://lore.kernel.org/r/20231113212150.96410-1-dns@arista.com

Link: https://lore.kernel.org/r/20231113212150.96410-2-dns@arista.com
Signed-off-by: Daniel Stodden <dns@arista.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Logan Gunthorpe <logang@deltatee.com>
Reviewed-by: Dmitry Safonov <dima@arista.com>
---
 drivers/pci/switch/switchtec.c | 25 +++++++++++++++++--------
 1 file changed, 17 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/switch/switchtec.c b/drivers/pci/switch/switchtec.c
index 5b921387eca6..1804794d0e68 100644
--- a/drivers/pci/switch/switchtec.c
+++ b/drivers/pci/switch/switchtec.c
@@ -1308,13 +1308,6 @@ static void stdev_release(struct device *dev)
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
 
@@ -1358,7 +1351,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 		return ERR_PTR(-ENOMEM);
 
 	stdev->alive = true;
-	stdev->pdev = pdev;
+	stdev->pdev = pci_dev_get(pdev);
 	INIT_LIST_HEAD(&stdev->mrpc_queue);
 	mutex_init(&stdev->mrpc_mutex);
 	stdev->mrpc_busy = 0;
@@ -1391,6 +1384,7 @@ static struct switchtec_dev *stdev_create(struct pci_dev *pdev)
 	return stdev;
 
 err_put:
+	pci_dev_put(stdev->pdev);
 	put_device(&stdev->dev);
 	return ERR_PTR(rc);
 }
@@ -1644,6 +1638,18 @@ static int switchtec_init_pci(struct switchtec_dev *stdev,
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
@@ -1703,6 +1709,9 @@ static void switchtec_pci_remove(struct pci_dev *pdev)
 	ida_free(&switchtec_minor_ida, MINOR(stdev->dev.devt));
 	dev_info(&stdev->dev, "unregistered.\n");
 	stdev_kill(stdev);
+	switchtec_exit_pci(stdev);
+	pci_dev_put(stdev->pdev);
+	stdev->pdev = NULL;
 	put_device(&stdev->dev);
 }
 
-- 
2.41.0


