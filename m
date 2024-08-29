Return-Path: <linux-pci+bounces-12442-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 6B4A69647F5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:20:38 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 24EF3282B88
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:20:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E95571B29D5;
	Thu, 29 Aug 2024 14:18:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FDou6UKl"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C9DA01B1502
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 14:18:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941138; cv=none; b=cDa6tdtvrBy8bmIra9hM2ONRvevfbBGgleSTCPcQEjva6GkBVVG99bDygZjLIfbHIISJ2htc3zcsoqlXLauHfUWXjWKUfofmE6xvtB8xMjRThd9qyDJBNEZNQX0qaKbdK/zG6kD82zR4JkuD3lGA6ystk9YaLL7ayqKbw/vIGB8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941138; c=relaxed/simple;
	bh=s4GctkYHbXn3tfM8TOsiQdy7M4dRLmQpFi1urTUZZ7M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=H26jRQT7O6+bXWz2f0aMdhx1bii9mVUFL4QmQpU/465vnrD8Cg7tj8RyK176zeBb84OORgelQ3KtMl/m8CrxrT+WULyxG+/qjz2AOd3x7C20JGhvnY1f95fXMWhlQzuc1qcrTg/LVAMYgnbXeIQsYPW2I8m8EC4w70KcRDEWNqU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=FDou6UKl; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941136;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=YtYR/gGTmDbAPYmIYRccbXqwblJKOZwAhQg2Y6pwqmg=;
	b=FDou6UKlDy2zWhBKbARnQSHyn0ORsHEAJhgfiAh/69L4yPujA2Y8JPyTIan5q7LTQ/KGQ7
	7Xljob7AmkgP6Z63QYuCZ0f09cJiEpDrbDuGrFLqo34zQIXIJakLrdUGtQZ+QBKc+sC/Sy
	tnHis7lrHyCUDcxKDLaCHhmL0xWiDts=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-474-NkxTViTrMGSDtisKuX-x1Q-1; Thu, 29 Aug 2024 10:18:54 -0400
X-MC-Unique: NkxTViTrMGSDtisKuX-x1Q-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-42bb6f7e7adso6798695e9.0
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 07:18:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941133; x=1725545933;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YtYR/gGTmDbAPYmIYRccbXqwblJKOZwAhQg2Y6pwqmg=;
        b=c+7vcQjN9Rj4ac9/6FJl5VldkBVCQwvVPc+IfIbmP9Rw9eVuq9ZT5sCj38/GRbyTle
         lv7/JsYqSUmriVpmJ1eCjVbEU1DBctuU4d9fArL+Q+xJZ7drdFJBrhWGRKQcNrcN76YK
         twzKepc6dLMEjHMUevL9qBi0VadUTEL9oTjiaygEdN9uFqCnmOaWDidQO4HqWmyM+zig
         OqJSNrHG3apnfszswwQeJjyTtI+RMl6w5GfMxxaIGLRqfbaJw8+r+r4nbKFu79gKRihw
         D9PJEHSPPOX6aq/scL7HkBuFs/zxJHZeUszrfEPaDrqD2iZCSQVZkMunjEnJmGIQqxtg
         GBqA==
X-Forwarded-Encrypted: i=1; AJvYcCWP9CGxbIlD7CwTReksb//EDLZ5pTMOo+Y413rI8AL7rlz7MxuMDgomkExhe/JqLDrSS3BP0DikWX4=@vger.kernel.org
X-Gm-Message-State: AOJu0YwkQ+1vxVJPDo38M8Fw52y5U2DtGnTkUOnwh83kyvGwQHQXOPZG
	eoPVi4ZyhxFlCmjXKqT9iCT/YRGlox8nMoSL0pQUisF/qpqmK4pTyOjClMfpcyMVTPptAdeDO1c
	9vhMRxkdQucYd/GfNMoejsy8YyXs1GRsLyq0cMflhmHq3sxtcPhU3jcFDHw==
X-Received: by 2002:a7b:c449:0:b0:42b:aecb:d280 with SMTP id 5b1f17b1804b1-42bb27a1021mr25083895e9.27.1724941133425;
        Thu, 29 Aug 2024 07:18:53 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGM4L32QAy6bG5zGi4CSR/e0PXgXREM2OUI07zkgBOIcbPjvtDeXtGrw5+r/WVKmA9y9IZ/KA==
X-Received: by 2002:a7b:c449:0:b0:42b:aecb:d280 with SMTP id 5b1f17b1804b1-42bb27a1021mr25083605e9.27.1724941132945;
        Thu, 29 Aug 2024 07:18:52 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:52 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jens Axboe <axboe@kernel.dk>,
	Wu Hao <hao.wu@intel.com>,
	Tom Rix <trix@redhat.com>,
	Moritz Fischer <mdf@kernel.org>,
	Xu Yilun <yilun.xu@intel.com>,
	Andy Shevchenko <andy@kernel.org>,
	Linus Walleij <linus.walleij@linaro.org>,
	Bartosz Golaszewski <brgl@bgdev.pl>,
	"David S. Miller" <davem@davemloft.net>,
	Eric Dumazet <edumazet@google.com>,
	Jakub Kicinski <kuba@kernel.org>,
	Paolo Abeni <pabeni@redhat.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	John Garry <john.g.garry@oracle.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v5 3/7] block: mtip32xx: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:22 +0200
Message-ID: <20240829141844.39064-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240829141844.39064-1-pstanner@redhat.com>
References: <20240829141844.39064-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

In mtip32xx, these functions can easily be replaced by their respective
successors, pcim_request_region() and pcim_iomap(). Moreover, the
driver's calls to pcim_iounmap_regions() in probe()'s error path and in
remove() are not necessary. Cleanup can be performed by PCI devres
automatically.

Replace pcim_iomap_regions() and pcim_iomap_table().

Remove the calls to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Reviewed-by: Jens Axboe <axboe@kernel.dk>
---
 drivers/block/mtip32xx/mtip32xx.c | 18 ++++++++----------
 1 file changed, 8 insertions(+), 10 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..e4331b065a5e 100644
--- a/drivers/block/mtip32xx/mtip32xx.c
+++ b/drivers/block/mtip32xx/mtip32xx.c
@@ -2716,7 +2716,9 @@ static int mtip_hw_init(struct driver_data *dd)
 	int rv;
 	unsigned long timeout, timetaken;
 
-	dd->mmio = pcim_iomap_table(dd->pdev)[MTIP_ABAR];
+	dd->mmio = pcim_iomap(dd->pdev, MTIP_ABAR, 0);
+	if (!dd->mmio)
+		return -ENOMEM;
 
 	mtip_detect_product(dd);
 	if (dd->product_type == MTIP_PRODUCT_UNKNOWN) {
@@ -3722,14 +3724,14 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	rv = pcim_enable_device(pdev);
 	if (rv < 0) {
 		dev_err(&pdev->dev, "Unable to enable device\n");
-		goto iomap_err;
+		goto setmask_err;
 	}
 
-	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
+	/* Request BAR5. */
+	rv = pcim_request_region(pdev, MTIP_ABAR, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
-		goto iomap_err;
+		dev_err(&pdev->dev, "Unable to request regions\n");
+		goto setmask_err;
 	}
 
 	rv = dma_set_mask_and_coherent(&pdev->dev, DMA_BIT_MASK(64));
@@ -3849,9 +3851,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-
-iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
 	return rv;
@@ -3925,7 +3924,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.46.0


