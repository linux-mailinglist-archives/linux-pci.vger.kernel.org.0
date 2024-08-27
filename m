Return-Path: <linux-pci+bounces-12300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 31A2E961767
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 20:57:24 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D76EE2846FD
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:57:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EF11E1D2F52;
	Tue, 27 Aug 2024 18:56:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ca8dF3tz"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0851C1D364C
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 18:56:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784990; cv=none; b=EaGgDyd347BdkNApOLVMlEbapwzqU73MeW8xqy/4VtnFNln97/IOUWVgks61Xro5Ed/tCnCM1p77TuPA5imtlQ7W+NG9zRoHdW7LryQOhkj+7W677auNQ40Fy31M8DPRWYfOd6Kqfy4vsIn8kq2hOWNI5YoswGj9hi1OcUQmjeE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784990; c=relaxed/simple;
	bh=fTrgv2t55oAUxzibv4M/cg1vJVaL3hV6ZXIaCSwKC84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=eo01voWn9csfy1S6Bfp+Cte6D4yq+2UjZwLzrhuHNwS1ua4zD/CNAYxCu7fC5Y3T2Gp7r8uztk0mmKMpwwOyETMdFxkaRBvmBcxRSU3Jp6vIME7F1kuVay9OEsBPxdtq4vX3VBcCkvFB/ietb0bL7rBLR/eyuVESHKYwjGfkdPs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ca8dF3tz; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784988;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=HqjxyDwTPmZ6BYMSZzIwABwfoKN2gGr5LIW5fe/qQ18=;
	b=ca8dF3tzUWxqmsKWRq0bRpbHPr5aS/1J3Uo+J+7PF1s6lFHIeU64i8llq1+U4xLXyGU1mV
	/WGJNazubBJ2ZmMjlbA8ahmqdQ5muMZIQ0ain3VaBx2h61dn3eOdlQNxcNCYHg761+Cc9H
	r2OJt5HXIE5INVEZYrlUDmo8TEh62i0=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-19-MSWAv_HYM7qeUDXkWdVUhg-1; Tue, 27 Aug 2024 14:56:26 -0400
X-MC-Unique: MSWAv_HYM7qeUDXkWdVUhg-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a8691010836so528536066b.2
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 11:56:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784985; x=1725389785;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=HqjxyDwTPmZ6BYMSZzIwABwfoKN2gGr5LIW5fe/qQ18=;
        b=Gat5G7HTPrJyoBtdGrGqcYL85/9XxzJLsokly0ZSSOgIOKbzuBvX808/ljxkzwrL8A
         HaRk8VCnNOQcyVOEJQmft0XyB0qTNPrapxx4jDnqH2Tl7oNrN6fmuEtP5P/U27JU6ghl
         eSCw6Q6vCnGpoeHf1UyMuqYnUxnXoaA+SIyKhKFXJPRmSxswguVODU2G0wWe6JL3rkIn
         xyMLVwa4jRbzIRpBCqmaVL9wW88zymOr/DKznxO9yDXJxecmfP4RA6aIdK8gXu/AXYgG
         JVmPgDAEQ65CwW30NJGRT7bHdT/OiDItVUfNKnZkbw4LtFThYlToDrGvZRAxfrUQRKqM
         GHnA==
X-Forwarded-Encrypted: i=1; AJvYcCUjiqxmZn5fQ8S990CWn4eyg7BshnAbXkBkmU6ZWlBhsCbxcys/3iTWArPgbkvJeGYyXxJEivZALb8=@vger.kernel.org
X-Gm-Message-State: AOJu0YwvMc1tiGnkIoi2npvjmClBKcQojFBHPd/GjPRQsnqIcdFR/ipa
	PixEGBcxUagwcvo7uAkTtqg5Aq+J4b2wO+oCvXgxO6L+75SMSCGuqlwzwpy3R3CihsT8pniCnxr
	uaEFljpSq1HaDIMj1DmFDJbzJD0OS7DOLOm4YlzfaQicVRxpxJtbetdQ5gQ==
X-Received: by 2002:a17:907:7da2:b0:a86:a976:68b8 with SMTP id a640c23a62f3a-a86e3d4d658mr271844966b.65.1724784985499;
        Tue, 27 Aug 2024 11:56:25 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFDVUpmOrCHBb5EyYmwKTK2LAwSrZ+h4YrVzu5NhP0Bxj6DB/rtzoi35gU4kno9vPxrThGKfw==
X-Received: by 2002:a17:907:7da2:b0:a86:a976:68b8 with SMTP id a640c23a62f3a-a86e3d4d658mr271842866b.65.1724784984946;
        Tue, 27 Aug 2024 11:56:24 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:24 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: ens Axboe <axboe@kernel.dk>,
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
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v4 3/7] block: mtip32xx: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:08 +0200
Message-ID: <20240827185616.45094-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240827185616.45094-1-pstanner@redhat.com>
References: <20240827185616.45094-1-pstanner@redhat.com>
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
---
 drivers/block/mtip32xx/mtip32xx.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..bd40a06e4c0f 100644
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
 
 	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
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


