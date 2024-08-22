Return-Path: <linux-pci+bounces-12003-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4921095B731
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 15:48:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 99B41B23E7E
	for <lists+linux-pci@lfdr.de>; Thu, 22 Aug 2024 13:48:33 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C1A2B1CC14A;
	Thu, 22 Aug 2024 13:48:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4SoaON4"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 020D91CB31E
	for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 13:48:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724334486; cv=none; b=NUZtrPlWukPSKIDswUO/ruFy/CkBetAkHZO92MkQ7xRUE8orEx4bLrRSM65Uv4y7Z0TenvkLfkdfRWM1Auq/q8KLjoGyuzXPMZZX02Phu8Strl+Y1iFuJ0w60ydRWOMJMFa6cifGsPnsFvg8bGWA6FpTHdGCNXgoSYdS6NkBD8g=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724334486; c=relaxed/simple;
	bh=BQY+sUCVOv9PvRxG5I1RVfUOvj0iBXM10s/oecEnuvA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=gbyGT2ceb4vQeJDk1Uy8KqKfPIEg+UzGo3W3R7hGZjr2pkgS63KVr7ssLZXJmhokKvohjVfbJ8ePyV/kv+eIwSXZO9UvfdpI2VNS/xbUnHPCdScNWyTpFW4qk9QGz3KaiozvrUIzaZmwVZpuCKSYhf/VXCXvpEqIGv43XpBVE/Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4SoaON4; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724334483;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=kI8i5GY2jMRlAmQS1bSu+iftmIP5RtQVe31XoOUBz1Q=;
	b=P4SoaON4BPmz4wbVneDzaWkrpw8P9sbXhITVhO8eabHiqoyOvFU+06QOL02GyNbGOSSrZ6
	XanuRy9GACs7harxhDREv3yFL5g5H9qex4MZhin5/H116zxUkgJzP4RSZCHwP+hsec38id
	/0hxoWSwhdPbUbNk++HCNFkem5TEqw0=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-56-rfJHTljqPYOGN9ZNwcE7uQ-1; Thu, 22 Aug 2024 09:48:02 -0400
X-MC-Unique: rfJHTljqPYOGN9ZNwcE7uQ-1
Received: by mail-wm1-f69.google.com with SMTP id 5b1f17b1804b1-42817980766so6806025e9.3
        for <linux-pci@vger.kernel.org>; Thu, 22 Aug 2024 06:48:02 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724334481; x=1724939281;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kI8i5GY2jMRlAmQS1bSu+iftmIP5RtQVe31XoOUBz1Q=;
        b=fODTnHKBuE5tUDEOODwv+RQnCJKHFj2dCUWliqvl2h5Hww907jERrT7dktRdcYUj7I
         xZ774KqdBNEKPWRGnbxzmAYNlTLGwL0rr5ww8LRG6Rkl2sk3VZ2TAy1Qfy9C8lyE2aDa
         dmTrHtlNqnsNqh9hKOHzKHI3DYBfn0HhivpYSSjUdYMjajr8eBaZVlscG3Jd6p612cLG
         2kQ246ZqpNmrSrixGOfxCXU6uZ9ndwnQiEqPGCkKX9UD9hQ+LOInHqs1onPo8uQ5+128
         qMtYu5PQ6FDNVmkFhY4UyVOvOZ1rL/gQQo1LB1UL13WuE2QXNBQvT84qDZiCsbQHd1yZ
         R77Q==
X-Forwarded-Encrypted: i=1; AJvYcCXLal9SspXC7aw7ga0CUho1i22wfiFHkTezJgXyozkTIEkeoPk7P/sCasntfsPSnTDg+BHSfMXvVxM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxhZUS41IrgLmTN5AhGqFRpkOqCsUEsRwIU1mf51EEieSwPHdLl
	sFwMDOnBdS1KUo+o7BMiL1aBPgoWkxntJNf+Pm36i11bu77QKuL+avMRxHe/kPbPZWZa78wCZtO
	CYYlM2775vz4hVPjXNQGHifCWD9YEcH21M3mbUEpiraFeLU0bbxp6nk2lfQ==
X-Received: by 2002:a5d:68cd:0:b0:36b:c126:fe6d with SMTP id ffacd0b85a97d-37308c16966mr1223211f8f.24.1724334481157;
        Thu, 22 Aug 2024 06:48:01 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGKCJk3UamU3gY39Dgnd4livDPv6g+NgCSNYxILlIqQhW519NZZIsqmP8GHU9qtEnK9x6mFHQ==
X-Received: by 2002:a5d:68cd:0:b0:36b:c126:fe6d with SMTP id ffacd0b85a97d-37308c16966mr1223157f8f.24.1724334480675;
        Thu, 22 Aug 2024 06:48:00 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ac5162322sm25057215e9.24.2024.08.22.06.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Aug 2024 06:48:00 -0700 (PDT)
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
Subject: [PATCH v3 2/9] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Thu, 22 Aug 2024 15:47:34 +0200
Message-ID: <20240822134744.44919-3-pstanner@redhat.com>
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

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/fpga/dfl-pci.c | 16 ++++------------
 1 file changed, 4 insertions(+), 12 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 80cac3a5f976..602807d6afcc 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -39,14 +39,6 @@ struct cci_drvdata {
 	struct dfl_fpga_cdev *cdev;	/* container device */
 };
 
-static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
-{
-	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
-		return NULL;
-
-	return pcim_iomap_table(pcidev)[0];
-}
-
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
 {
 	int ret, nvec = pci_msix_vec_count(pcidev);
@@ -235,9 +227,9 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	u64 v;
 
 	/* start to find Device Feature List from Bar 0 */
-	base = cci_pci_ioremap_bar0(pcidev);
-	if (!base)
-		return -ENOMEM;
+	base = pcim_iomap_region(pcidev, 0, DRV_NAME);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
 
 	/*
 	 * PF device has FME and Ports/AFUs, and VF device only has one
@@ -296,7 +288,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	}
 
 	/* release I/O mappings for next step enumeration */
-	pcim_iounmap_regions(pcidev, BIT(0));
+	pcim_iounmap_region(pcidev, 0);
 
 	return ret;
 }
-- 
2.46.0


