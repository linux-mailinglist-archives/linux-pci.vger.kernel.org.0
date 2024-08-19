Return-Path: <linux-pci+bounces-11824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DDDCD957140
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:57:44 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 0E4541C2119F
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:57:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0C6B18C35D;
	Mon, 19 Aug 2024 16:53:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SiN2CoZ+"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D68FA18C326
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 16:53:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086402; cv=none; b=YC0OmCujuQvY+2isezDIrXsKZMe3uRzyEFic1SVzf367tVd0S62x3haW4Ov0lRXFUV5V0E08b8lzK//rr/EThYJteZQfBfDhIz7uAUx5I72n45WO1Z2VOPwR7SKdZ8fj/FomYfTn8v5U5rM6CQmG2I/sF44JmWyUacFSt9EeSY8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086402; c=relaxed/simple;
	bh=HyrnGEiWWKBKUn1JXMJcutJ0LWXBjSFgM/wwpIH/cmo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=X2SJeVDAS3CtV6IYLr+KKXB/dero9GnZlG2KPmfhGKrMMjrtpblNTYC4AhmSZo4LueDWfNzI/E/WItCldIA04N+O+FZ8cZLIoMzyDq33DpCD6FWrUH0KtdxXqLrudrPpgkQzQcoVMnqGi2jdKGpxxU81n7pzTVSmVtML4WgeGbw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=SiN2CoZ+; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086399;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=RIGjmIxgd4ZYoEGhHZhEaO790wvl9zuuKnu8/dcY7mY=;
	b=SiN2CoZ+/mlezkqMiokcpCmxDck+etGa5yltFWoOMq1PaaoJKJrmBteUUkjwmGjC7YYhy8
	EbPWLbZtUfLuaIrNrkg0oOU8La05HCgMla6cr41KxCHEQ2+ikkG5SDTst26MuvznhL5DHz
	ZUpyknN/CFfo3mdKpAjJAZjyouI33Sk=
Received: from mail-oo1-f72.google.com (mail-oo1-f72.google.com
 [209.85.161.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-84-fXMHL2ayM5ygxxifhhMgiA-1; Mon, 19 Aug 2024 12:53:18 -0400
X-MC-Unique: fXMHL2ayM5ygxxifhhMgiA-1
Received: by mail-oo1-f72.google.com with SMTP id 006d021491bc7-5daa4d72ac8so525072eaf.0
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 09:53:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086397; x=1724691197;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=RIGjmIxgd4ZYoEGhHZhEaO790wvl9zuuKnu8/dcY7mY=;
        b=GLrPTJDZ0wE6fkmHjWCLUqztls7N8aJ+JmiBeYMtDwXnJuOiZutG5WkryFZkxFXQ8u
         SPR5E7Lr7PNyW5Uk8HeVJTKC3tixq3Z3aHpxpV0bj4TGMV6CDjOZRX6dXTFBXqZsThKB
         2ZkfEkoMpjLF/CMF1ovufrmQzXu8/YmszHrP8NDguQLtcq/9dfjfWPzGdWfI16vaHqbN
         8NiHeOCXVM04AJV9zxbgaN5Y2PQtAmz4UqY+hz8EZmfGZbclKyRwg0+EZSjQJOU26uu8
         87Om696CTOnFV/00VtOhRsRLFks62od+aTNHuxK1QKJrEV/W8BenjAJGfyDa6o7rgb+h
         cVtQ==
X-Forwarded-Encrypted: i=1; AJvYcCXD+Ss1/WjkDiAo/L276f1Djq8JjF5uPrSSbsETSQxls4qFi7JPfXcpa3ddqNCEI3O+h4/IJTdHmqo=@vger.kernel.org
X-Gm-Message-State: AOJu0Yz1f0pg5KYG5FNMtWg5x+rs0ZQQOR/vRCZUZm36Gc1R8pBEq57G
	mgDjnT+Lg5qT5aLvyOuPnBrsleqHeH4rc73L4MlJ4xXZN1YR9DyD/DgfvIYXMHBqjCTtBp8Phik
	24qAAWZhixOHjnW4Xa/ZsvWa7QaNhquoSSBhynkJS8N1ZcVsO6GcsEw00nA==
X-Received: by 2002:a05:6358:6f15:b0:1ac:a26c:a617 with SMTP id e5c5f4694b2df-1b3933a2ef4mr724903455d.5.1724086397480;
        Mon, 19 Aug 2024 09:53:17 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGT/mWFQ9yoQUfbebPKob1DsZxH+iTK/HwcCt5JWpV0k06WRkWCd30wgdmfipghSMnyk6p9TQ==
X-Received: by 2002:a05:6358:6f15:b0:1ac:a26c:a617 with SMTP id e5c5f4694b2df-1b3933a2ef4mr724898255d.5.1724086397091;
        Mon, 19 Aug 2024 09:53:17 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.53.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:53:16 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: onathan Corbet <corbet@lwn.net>,
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
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Hannes Reinecke <hare@suse.de>,
	Damien Le Moal <dlemoal@kernel.org>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	"Martin K. Petersen" <martin.petersen@oracle.com>
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
Subject: [PATCH 9/9] PCI: Remove pcim_iounmap_regions()
Date: Mon, 19 Aug 2024 18:51:49 +0200
Message-ID: <20240819165148.58201-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240819165148.58201-2-pstanner@redhat.com>
References: <20240819165148.58201-2-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

All users of pcim_iounmap_regions() have been removed by now.

Remove pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/pci/devres.c                          | 21 -------------------
 include/linux/pci.h                           |  1 -
 3 files changed, 23 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index ac9ee7441887..525f08694984 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -397,7 +397,6 @@ PCI
   pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
   pcim_iounmap()		: do iounmap() on a single BAR
-  pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
   pcim_pin_device()		: keep PCI device enabled after release
   pcim_set_mwi()		: enable Memory-Write-Invalidate PCI transaction
 
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 30c813766e8b..a1689100a535 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -1014,27 +1014,6 @@ int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 }
 EXPORT_SYMBOL(pcim_iomap_regions_request_all);
 
-/**
- * pcim_iounmap_regions - Unmap and release PCI BARs
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to unmap and release
- *
- * Unmap and release regions specified by @mask.
- */
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
-{
-	int i;
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (!mask_contains_bar(mask, i))
-			continue;
-
-		pcim_iounmap_region(pdev, i);
-		pcim_remove_bar_from_legacy_table(pdev, i);
-	}
-}
-EXPORT_SYMBOL(pcim_iounmap_regions);
-
 /**
  * pcim_iomap_range - Create a ranged __iomap mapping within a PCI BAR
  * @pdev: PCI device to map IO resources for
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 7de75900854a..4eee09624932 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2302,7 +2302,6 @@ void pcim_iounmap_region(struct pci_dev *pdev, int bar);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
 int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
 				   const char *name);
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
 
-- 
2.46.0


