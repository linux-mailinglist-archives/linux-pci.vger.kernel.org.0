Return-Path: <linux-pci+bounces-11920-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 66B4B9595BA
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 09:20:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E7C741F259DD
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 07:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A6631A7AEA;
	Wed, 21 Aug 2024 07:19:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f1Jlm0XB"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 06DAA1A7ACE
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 07:19:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224761; cv=none; b=dZz3na/v2XvLqOTg2jyFyMkmYWmEVHzFV2rUUrGO9SP8rtilT7FQmKYbt9ulFObF0mofPl2RwL8qYVEGAaagyDeXuCx8buoDZNBUzr3b6m9H19M2C/wETHgQOZp9OHxRFWS5xw6U7HMPq3TkR0Fk++/fUi3H0yW3PPoVGFOzz7o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224761; c=relaxed/simple;
	bh=X1zz/TunuR2PG93iDywgu0fR0ZIioix5D5qvFJsuS9M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=JFPTJjQbiMXMdww73EZ5zJnZMi5A2Y30YTvA5zDYg41XG8deHSuxWzGeUcLGtKCB4/ec9QJsHRAHHZelquoESd9gk1PyCNrc5vh4NfhinOX4r5qP2YVWRX5T8JFRIOe5PtjDBKL8osE8DJIO05nWxOzM9ZIsextX5pEdL+CZjpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f1Jlm0XB; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224758;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CLI8bZjR6OdWE6SPmBhjzuWJVjW15O9K3MBwEhWkwDY=;
	b=f1Jlm0XBCSRVMrXH2dX3Dmpl1yyDUlrKBKiJiJFIstd6TtFz+J2EfasakOOMp1sjTWvJSY
	A70TRC7zZ56V6UVUGP3mq4HJ9hYcOzGKgeVn7p4rZbxrvdTuMgCelVmc62KI/9CjWWATXg
	WBfn7ieci1zo9U97oJNrHb5LI0AeIcQ=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-657-yh7r99rNPuCoKu5Pgulg6w-1; Wed, 21 Aug 2024 03:19:16 -0400
X-MC-Unique: yh7r99rNPuCoKu5Pgulg6w-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a1e9a383d1so613065885a.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 00:19:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224755; x=1724829555;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CLI8bZjR6OdWE6SPmBhjzuWJVjW15O9K3MBwEhWkwDY=;
        b=Vgu5lDnykfj0IQMmqZkAB8LwQo53jClwcbszk1rakeoXkgNO0hiSIBqNxbma4r8rdc
         gACAc+sug0RhgFi7iZALyhqnVma/oLR7SnmQmyPgMvyZTyKg6QSqk20W8IPZPns+G9Ad
         nVxcqB+vDZb3z+B7x8OnPd32NVtfFM8IR2gR+u66wkmmEP2AHIjv5xP+tthNan8qZzUT
         6I6lNeMkvDw3WlDW/CgVHaZ9Prxr8jInwSRWFyEKmFVUg2wTyiYe7zsLh2Ka7D7f8rnq
         cMwCzj+8C8vB6+7EI6gMhVnH5Xye7F2/El+6oofiz+JcCFdNAVj69uof8d2uXq9i8ao9
         8nFw==
X-Forwarded-Encrypted: i=1; AJvYcCV/F/P5TY+5f0auC/yHGMs5FXKk/NHRpkUZE6mXrysf5JpFnQVuK25fYumtEMFlqeWTNVIv1cvGcH4=@vger.kernel.org
X-Gm-Message-State: AOJu0YxaX8EUN9VCqvYPNrUNSzq09YdwMA64cQAu3cNIl/J2nYFB5mNg
	X0gcF3D6Hw9DQxISbAtvmwPLCZKtF3ncz+IrwnHn+cZ9sjLRW5XuLHs1/CTCcGp18a51dE2DVyq
	MeUoJW5upZcpavjHbH70SSTPl0QaqPqih0M1/jE/IoWFVAZl5gs2u9CCYig==
X-Received: by 2002:a05:620a:1906:b0:79e:f8b7:5c73 with SMTP id af79cd13be357-7a6740c5e31mr226525985a.55.1724224755551;
        Wed, 21 Aug 2024 00:19:15 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFtpkoHy3cS2PdzwF01k905nXUdsELS2xvQjiGeTjNuWZ60d5TFnGqma74hup77Ia1MJryw5Q==
X-Received: by 2002:a05:620a:1906:b0:79e:f8b7:5c73 with SMTP id af79cd13be357-7a6740c5e31mr226522685a.55.1724224755041;
        Wed, 21 Aug 2024 00:19:15 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:14 -0700 (PDT)
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
	Keith Busch <kbusch@kernel.org>
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
Subject: [PATCH v2 3/9] block: mtip32xx: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:36 +0200
Message-ID: <20240821071842.8591-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821071842.8591-2-pstanner@redhat.com>
References: <20240821071842.8591-2-pstanner@redhat.com>
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
 drivers/block/mtip32xx/mtip32xx.c | 11 +++++------
 1 file changed, 5 insertions(+), 6 deletions(-)

diff --git a/drivers/block/mtip32xx/mtip32xx.c b/drivers/block/mtip32xx/mtip32xx.c
index c6ef0546ffc9..fcd5806621c7 100644
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
@@ -3726,9 +3728,9 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 	}
 
 	/* Map BAR5 to memory. */
-	rv = pcim_iomap_regions(pdev, 1 << MTIP_ABAR, MTIP_DRV_NAME);
+	rv = pcim_request_region(pdev, MTIP_ABAR, MTIP_DRV_NAME);
 	if (rv < 0) {
-		dev_err(&pdev->dev, "Unable to map regions\n");
+		dev_err(&pdev->dev, "Unable to request regions\n");
 		goto iomap_err;
 	}
 
@@ -3849,8 +3851,6 @@ static int mtip_pci_probe(struct pci_dev *pdev,
 		drop_cpu(dd->work[2].cpu_binding);
 	}
 setmask_err:
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
-
 iomap_err:
 	kfree(dd);
 	pci_set_drvdata(pdev, NULL);
@@ -3925,7 +3925,6 @@ static void mtip_pci_remove(struct pci_dev *pdev)
 
 	pci_disable_msi(pdev);
 
-	pcim_iounmap_regions(pdev, 1 << MTIP_ABAR);
 	pci_set_drvdata(pdev, NULL);
 
 	put_disk(dd->disk);
-- 
2.46.0


