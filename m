Return-Path: <linux-pci+bounces-12441-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 507D29647EF
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:20:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 75F011C23D3B
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:20:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 651741B151D;
	Thu, 29 Aug 2024 14:18:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EL38qi4c"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 629A31B1431
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 14:18:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941137; cv=none; b=MlI/4FjPpQ0yNdSBgFhCY+c7sVuiyZ2ZGoTjplzBl+9PvVgigfipwFYXe14wZ0zS2HxlrJPIViBrxS5pneS9ytcc+gRnNuF7uJBOwUBbKMAf+AjLtkU8NwoZpPztQTDOGBiTZ8qsYp81cXoRvnBAcwnTlUT0iHB9/er0YYZ9u+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941137; c=relaxed/simple;
	bh=V4KRcC8BfWc5Sti/Fdc73KUa8QY4uocvnp5UyVnLmQQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=XhOxOzgRVUkfwS/aXQo8patUTtQVTsTTt/UnCWIbtsQwfTlSIo82w/6lWv86ppghBUzwdOsshZ0xpY3i37P6NH/dJlcLhm48PDR0eC+YethakDPZOdZbi4p1+qkrb9zvtg0bjJoHQLe2MToNGgF3uMm2NtYdZb9n/ez/oxESb4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=EL38qi4c; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941134;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
	b=EL38qi4cB3+4SU5JW/ydGVgTvO/anUFhfijY29tDBkoHifNcruZlRGcmW4iYtUS2ZqOF8z
	z/uVqCl9UrFhsp+I+O541cH7chFy9Al8X07LfLTkZksZW7WiGTTT3uUES8HMv57yOkaz7l
	opRmYXjMFetGoRkV72vka1gvVm5xc+8=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-500-Kay7NrtQOkSivO05azXKyQ-1; Thu, 29 Aug 2024 10:18:53 -0400
X-MC-Unique: Kay7NrtQOkSivO05azXKyQ-1
Received: by mail-wr1-f71.google.com with SMTP id ffacd0b85a97d-371a82ceaa7so540991f8f.1
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 07:18:53 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941132; x=1725545932;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j5hLs33+KllKyvrdGIaXp9UPbFVf3GpM3GrIwQsqtHc=;
        b=hexaHSFgp0CsIOwMoyoSZzZ/IT1b8rdAyOut0qE7KSs9jVF2GuhiBi7ym1HxNxABvr
         JN6+vzAkWSpAuvTM0WXv8/u0FbIeJw2p+eu4U1zfJT9huyyjQygnUrxUqxRkycoZ4XUZ
         oFyOnOhTcec2H1SVqTQNrj6Ufyhtfgx5EQxPIpdnKpKMGAo9t8Gx4+N4gUgZ3MKA1uc0
         XZXmr3FKxkuSiizLYPdiSJ6T6tt0ouIsjsWoGoW6zC39eYtj1rGtir7WIbHdQ6La54ci
         tG4BVtU3rLbz7PSHvDo8h1SlssSM0I9kXYrVBfjhiTHR1NCvZu/zMFG2cz86fS8+Q+kq
         WbjQ==
X-Forwarded-Encrypted: i=1; AJvYcCVbhIIn+R4whk1Vs9u/3xMMrfoIhyQpCnmkeKyBWsmaArYGDbIItqDti40HdSWX64RWIeSqX1JaU+U=@vger.kernel.org
X-Gm-Message-State: AOJu0Yzl1TlLkYs9jGqXoX0fC+XLHgXioiYJN4yDKrqvYuDznDWTLobB
	/lqzl/CI9eHQENnzMemp8E908MdnGGIZmiivKttADwny6HgaTiexGJp1XDW6BiwX+jWm35YHvea
	wSJxB5ag4ktPiSC0H3T5+/lImMDWdemzxPUlQa+Lemod+kclxztjGxMCjuQ==
X-Received: by 2002:a05:6000:4d0:b0:371:890c:9b5c with SMTP id ffacd0b85a97d-3749b58e35fmr2067668f8f.62.1724941132031;
        Thu, 29 Aug 2024 07:18:52 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IExu3DQrPfL2Xn0gAB2fCj8JJI6EtuIM+NkPB8RfQMu0+YrU4TAxvDtIU5CsDAlbEI3/d8Pow==
X-Received: by 2002:a05:6000:4d0:b0:371:890c:9b5c with SMTP id ffacd0b85a97d-3749b58e35fmr2067629f8f.62.1724941131450;
        Thu, 29 Aug 2024 07:18:51 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:50 -0700 (PDT)
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
Subject: [PATCH v5 2/7] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:21 +0200
Message-ID: <20240829141844.39064-3-pstanner@redhat.com>
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


