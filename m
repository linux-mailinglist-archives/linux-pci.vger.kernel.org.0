Return-Path: <linux-pci+bounces-12299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 94AC5961766
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 20:57:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 49674284632
	for <lists+linux-pci@lfdr.de>; Tue, 27 Aug 2024 18:57:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0E20E1D2F47;
	Tue, 27 Aug 2024 18:56:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="gn3UUkFv"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 641FE1D318E
	for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 18:56:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724784988; cv=none; b=MXd+4yzPKex5eoC2QG0ZTgP/OjUlwa86zPTTvLv35kzAWfBol+BMF+c+smws25pFrtQKmpMMhKBG2GUkHhXbAME1LgkvWc6NJvvvs5cigkUR5MGDhq1csGr18u7EfldjgR+5AzwmnbVc6k09umj94zHBs3q+LQKPwWRxLU0RJRQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724784988; c=relaxed/simple;
	bh=V4KRcC8BfWc5Sti/Fdc73KUa8QY4uocvnp5UyVnLmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=b8dVhwAc7TlVnvdlujut2nErkRPAfrStTQ9icN4DSzk40CC0/yBYsEOVnnmc+3cy7mr5pvwPpTTaswEhRgL446/Qe+HHxuXMtIvNHwsUxj2yqdQPKGsq/Om9WI/Rz+GpcGZxJhuO2QHP7cjBAdJxMWkQtvr/GtN9/9rUTcjr25A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=gn3UUkFv; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724784986;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
	b=gn3UUkFv2rLBui0GrblRb8iazE9gXbZGZL14EH8qdIU4rLjmLArW0InV3Vwr0mhBBDhDp7
	RYjMiThfYErCQSZ3rELt9chZ9w1QHnXu/jSTGGY+3RX6GU3MkTAyg/cAPpNdU7GDYL25EM
	4JQdm9ywukdHWubPAj3aqaLimcAlzpg=
Received: from mail-ej1-f69.google.com (mail-ej1-f69.google.com
 [209.85.218.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-675-CBHtphyoOdCmUp9hs7rKfA-1; Tue, 27 Aug 2024 14:56:25 -0400
X-MC-Unique: CBHtphyoOdCmUp9hs7rKfA-1
Received: by mail-ej1-f69.google.com with SMTP id a640c23a62f3a-a867ed4c129so489412966b.0
        for <linux-pci@vger.kernel.org>; Tue, 27 Aug 2024 11:56:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724784984; x=1725389784;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
        b=LJYv8Q3g2y7eUE4mfoEEpbkkCC7e0L3im7/tRR7+Hcif5P+B5LTohdRXflB+1Ah3av
         JQdjE4dAssIeAEymKh6gOqtxybOAPoHu7S1snkrlBLmGwg3/kFfvkFN0g8KqhZdBcKRA
         Q1LUbIQmb7mXnyL6T5dTYYGk4JmtV1BLZnApQRns9PFhvut6+Tkpuwz3ZfRwt9S9uWKn
         JMkgBjwHT0vTPvjeoBLPw6W7+zzsouUkXwgwNjSmzRM9+vHtl0Ac85Js2cJ5qZxqwfNO
         LJ9WGUY8eC0QL8CkB0jYrmGDGdL7oAnqspBQ4jsPvb6SKLF14bR/w/n3lCC5yZtHOxLs
         tYow==
X-Forwarded-Encrypted: i=1; AJvYcCUby+b19hIxG9ki92AEyYwN+5L2yxrOxU2/YrySXUeRg1aZOIddzybli/EP20TcIy8Mw2ogrEHsfOQ=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxjdx7RFhH2DLz9GCrJcnNMoWkv2xJoCzph4Mor1BLz7C1W365Y
	RaXHVINY2xVya/R/BKTipmNGiAc+Kpjo3fnYAZqZPLrffhhLh8JUO/1baoApKqxiR/GHAvwAd6z
	n+2YIL4BRh9MhHgeCTJSLzWJrQwaNv2PcNmtS/G2Qr4f33xFY/rhS2wBmYw==
X-Received: by 2002:a17:907:7252:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a86e3a4ce7fmr296322966b.40.1724784983729;
        Tue, 27 Aug 2024 11:56:23 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IE/x6IpxLJLbWNctYsTotEW22H/JYXErvbzu49sBel1g7SXflnutqyYs4SKAlH6O5BaH+21/w==
X-Received: by 2002:a17:907:7252:b0:a77:cf9d:f495 with SMTP id a640c23a62f3a-a86e3a4ce7fmr296318366b.40.1724784983124;
        Tue, 27 Aug 2024 11:56:23 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3dbc:3c00:460c:db7e:8195:ddb5])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a86e549c4e9sm141473066b.47.2024.08.27.11.56.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Aug 2024 11:56:22 -0700 (PDT)
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
Subject: [PATCH v4 2/7] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Tue, 27 Aug 2024 20:56:07 +0200
Message-ID: <20240827185616.45094-3-pstanner@redhat.com>
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

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Xu Yilun <yilun.xu@intel.com>
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


