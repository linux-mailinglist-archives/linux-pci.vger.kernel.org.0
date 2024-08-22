Return-Path: <linux-pci+bounces-12004-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A252E95B73A
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:49:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 21D4C1F21900
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 13:49:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A00EC1CC882;
	Thu, 22 Aug 2024 13:48:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Q0zzxUMG"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63DE11CBEBB
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334488; cv=none; b=tTeOEcPTW+xNEpujYvQQ0so5NEG52BXGrvN5t3jJAuJurZgO738rLwsYcuW0AV709nA1je6I35ednarAx7VbnAiy+Ei90OhWHIMNjCFkXLMGePBm7eKWndUhqrIc4MXhnqVp52eI4mq9rY8+Cf7R/X3f8m91kQ8qbW83+YV35sk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334488; c=relaxed/simple;
	bh=3VAt95zZ1Dqz3XrvM2lwpkOQg6dQGTUaYO+6pcMQK9Q=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=AMHSyuBpS72YLeor1NSPu/UYIimM2NaGaAXQzPRH+uRa2rKBklMbFKDFADkBWeeiVFmg+bDXbSxxk2B9IbvNw5y7fCLPO0hFfbQMyXbd1tHY5wMnDGV0+EL4f0uaVJtKYGYSYEHSOncuNTZG9V5fDpQro1kALRqekj63jwbrtuI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Q0zzxUMG; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334485;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=jhs2ECxIqanvtxlvW30RxDZNTtb7z2CuQcsYq71BRfY=;
	b=Q0zzxUMG1EeiWu7Du2bLczWWbqhoFUwz6iQGa72dL97iIAwH93JXsxPRCXkrhwLJOS2cMd
	fuzTHyKbAaImyVD4nqfCAZ2hPi13LQHfDQ/D/Hz4vVDfb+V1RvGV3IZ+WY3IRXErVqbP5J
	62ScPBHBEk43tSgeRw5EPt7oeU4gIqg=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-622-Bu33oPv6N0OlruiX7z97qg-1; Thu, 22 Aug 2024 09:48:04 -0400
X-MC-Unique: Bu33oPv6N0OlruiX7z97qg-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-4280ec5200cso6292335e9.0
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 06:48:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334483; x=1724939283;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=jhs2ECxIqanvtxlvW30RxDZNTtb7z2CuQcsYq71BRfY=;
        b=GPNfdW1KWgZl7P09Xa4UIIp/WE2BPqjdavrSRekYM/0TLCL9oVzF7kJnV70/Alp050
         qpydUtjBqAPgkmA1PIQhj6dfbBW6PqU3WNohd3O8dbqxJXyqYZnc0mc/Je4+bPbEf1tU
         ef+3aofr++X0sHXgTBvJM8JfieQuxXdsxm4lZ3FFNF48J/Bn2iUh7p8yhYzhWHFpIyaa
         Om8K8cMKaHFMjQk57yPIdwjzVXet2CrCGxFQuBd6F+TjkSiNWgg2yjKFeEI1Fo1STwQx
         6IX2v1nauGXzVDcmYJZLm4ObPVuWPAs+c3Icp3YPO60qJPleiRKJd5urw1LQf2D1kZoS
         +E8A==
X-Forwarded-Encrypted: i=1; AJvYcCWzXVIn7fcwCoIobNePToVHoCsYzzgRNTFRpq6n9861HVXxMlj6lhTRfRqE0fgESVHjknhv7P8lyvw=@vger.kernel.org
X-Gm-Message-State: AOJu0YwxFVp987qfmEldf3rWaz4lBv7rGG3hTCbb001v+cCxDrdXgYEn
	lnTrfG4u06aad6FTqSmwpwTJcHZXjd98lom0e6SMorxZy+rhHF73HYlPQU9fjbxr33/o6NWSlSS
	OxlZGZWuGhbNNPfjE4K3jF3suhATI7o+hXVoGpzMwt2bY68MTmz8LDZDVnw==
X-Received: by 2002:a05:600c:5114:b0:426:60bc:8f4e with SMTP id 5b1f17b1804b1-42abd21f5e8mr38751195e9.5.1724334482801;
        Thu, 22 Aug 2024 06:48:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHXx12BAf3CxTnmjhd6pOZhjB7i9I5cLSUjMGAYvwAfvdwbDB7drJJLXCP1Y+6M4I79vMkMAA==
X-Received: by 2002:a05:600c:5114:b0:426:60bc:8f4e with SMTP id 5b1f17b1804b1-42abd21f5e8mr38750635e9.5.1724334482246;
        Thu, 22 Aug 2024 06:48:02 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.48.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
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
	Alexandre Torgue <alexandre.torgue@foss.st.com>,
	Jose Abreu <joabreu@synopsys.com>,
	Maxime Coquelin <mcoquelin.stm32@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Alvaro Karsz <alvaro.karsz@solid-run.com>,
	"Michael S. Tsirkin" <mst@redhat.com>,
	Jason Wang <jasowang@redhat.com>,
	Xuan Zhuo <xuanzhuo@linux.alibaba.com>,
	=?UTF-8?q?Eugenio=20P=C3=A9rez?= <eperezma@redhat.com>,
	Richard Cochran <richardcochran@gmail.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Chaitanya Kulkarni <kch@nvidia.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-stm32@st-md-mailman.stormreply.com,
	linux-arm-kernel@lists.infradead.org,
	linux-pci@vger.kernel.org,
	virtualization@lists.linux.dev
Subject: [PATCH v3 3/9] block: mtip32xx: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:35 +0200
Message-ID: <20240822134744.44919-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240822134744.44919-1-pstanner@redhat.com>
References: <20240822134744.44919-1-pstanner@redhat.com>
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


