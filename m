Return-Path: <linux-pci+bounces-12444-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F7D3964853
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 16:28:50 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8AB79B2D2B5
	for <lists+linux-pci@lfdr.de>; Thu, 29 Aug 2024 14:21:39 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D8031B3F22;
	Thu, 29 Aug 2024 14:19:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ELZn2oHk"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E51BA1B3735
	for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 14:18:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724941141; cv=none; b=ro4q59P2LYwX5pnwW5+TWg2qutdBISIVXZ6FLiOs89AZi3DRoDVYUCwGOnSJd142j2GJTbAd9fKfhnHZurwNBCWqHNzETDSRIRbKTmw9eB8Vr+X3HOjUV0DInI9u3tO9OVKFCkgw1332oWTwGSSVlloI6xcc052pRu4iLJkVXr0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724941141; c=relaxed/simple;
	bh=nzy04PgDjxRp4clOpzx7ZwAQtwC8BOnrH0UdBVVoGHw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=dyPuWUzBNtRHCI0J147eycmfZpPlk2bdjtzB4zry1Ju9UBOeByiYpZAizWhIlwXbg+pHj25TWDx6NArEyOk6Qa9GUX4odjjYnZi4AOF52dvIQyd5sXJIMJWbJ4U1ZtqLAbNEQkvHfxE/r/1dWj2yZ67Wknej6WVI9esCXWpg+n0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=ELZn2oHk; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724941139;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=osuRWDMAcWp5GKuvb2jQp7XxiFBFhqIKDkkqm4u4oTc=;
	b=ELZn2oHkwFpBO06izRWY/dmYlxh11Gnowgq4+iJ1tP7NpNoy19z13508x1uICYiwK+5Fcu
	Cd7j7tYtS08FdEVXBrXVo5lZ5IVlaYvVPfuUb8WeLVjPr79MnbuT/qu14oNLxELUtCoyLd
	uMATzfdhuwG4fMrKtOzBG/Ir7KLXU6M=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-440-t2tKQ9gJO_OTiH2VYQI-ww-1; Thu, 29 Aug 2024 10:18:57 -0400
X-MC-Unique: t2tKQ9gJO_OTiH2VYQI-ww-1
Received: by mail-wr1-f69.google.com with SMTP id ffacd0b85a97d-3718c0b4905so565025f8f.2
        for <linux-pci@vger.kernel.org>; Thu, 29 Aug 2024 07:18:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724941137; x=1725545937;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=osuRWDMAcWp5GKuvb2jQp7XxiFBFhqIKDkkqm4u4oTc=;
        b=NInahvnqO1Kdz84noKok4+USQh2atXjDzek0tsIj85j0fMawHpM6o15uECmtYsupv7
         L0wHBJ6MK5Sqpj+Z2JpTWCPTiGZAXl6yXROVd3CjaYTw2jN+Va9PSqBO0EMkr2wfwQkS
         RIO7Bzg96MO5QkHntYQstVnhskZ7cWJ2roulOyYkcEfZqw8cvWl/+MySIxdHzZfdmi/p
         HgnLQy3mgjHxIVfWvKYrI9fSaU77lfik39aOKkAMBQwgmQ65oC8lDno+T+DuyzhinoGo
         dak7QmMU7sbCbtEIMpZkR+l330G+bGc5lXEB8uA3PiUggaOMABMacsa9lEPB0lZlQpPi
         ya3w==
X-Forwarded-Encrypted: i=1; AJvYcCUsEDg7I72Y7LpLKzqOYIV9Ay0mrMu+SxxYWoQvHdjhwgI5lBIZnVRNaZE5LcW8ef3AhPhYSpPOSJE=@vger.kernel.org
X-Gm-Message-State: AOJu0YxJ0sUAxO389337hGYnfYtOuHxrRRsH5wRTp9JBvSf15FH1Le2Y
	lHzKtIIFVav7vyBp1PzCOv4Bc7vVCB96EunpL9I0F++bguO+eiHM5J+WFI6YW+fFIGxNGufL4F5
	X5FkeHiWlnkuoIqG8N4kmf53Q6RXwDNdLGECx+vhVfXVILYjEpndXvcvgqw==
X-Received: by 2002:adf:f24c:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3749b5503f3mr2024897f8f.28.1724941136563;
        Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFYRK3DCkIWLqUxz0XY2NMNmO7BWhVLf+DW2Gbx1uLqQ4PTQOElvgJY4ok5jVfTKZaAWaobsQ==
X-Received: by 2002:adf:f24c:0:b0:371:8e8b:39d4 with SMTP id ffacd0b85a97d-3749b5503f3mr2024838f8f.28.1724941136092;
        Thu, 29 Aug 2024 07:18:56 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-42ba63abebdsm52670425e9.27.2024.08.29.07.18.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 29 Aug 2024 07:18:55 -0700 (PDT)
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
Subject: [PATCH v5 5/7] ethernet: cavium: Replace deprecated PCI functions
Date: Thu, 29 Aug 2024 16:16:24 +0200
Message-ID: <20240829141844.39064-6-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by
the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Furthermore, the driver contains an unneeded call to
pcim_iounmap_regions() in its probe() function's error unwind path.

Replace the deprecated PCI functions with pcim_iomap_region().

Remove the unnecessary call to pcim_iounmap_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/net/ethernet/cavium/common/cavium_ptp.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/net/ethernet/cavium/common/cavium_ptp.c b/drivers/net/ethernet/cavium/common/cavium_ptp.c
index 9fd717b9cf69..984f0dd7b62e 100644
--- a/drivers/net/ethernet/cavium/common/cavium_ptp.c
+++ b/drivers/net/ethernet/cavium/common/cavium_ptp.c
@@ -239,12 +239,11 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	if (err)
 		goto error_free;
 
-	err = pcim_iomap_regions(pdev, 1 << PCI_PTP_BAR_NO, pci_name(pdev));
+	clock->reg_base = pcim_iomap_region(pdev, PCI_PTP_BAR_NO, pci_name(pdev));
+	err = PTR_ERR_OR_ZERO(clock->reg_base);
 	if (err)
 		goto error_free;
 
-	clock->reg_base = pcim_iomap_table(pdev)[PCI_PTP_BAR_NO];
-
 	spin_lock_init(&clock->spin_lock);
 
 	cc = &clock->cycle_counter;
@@ -292,7 +291,7 @@ static int cavium_ptp_probe(struct pci_dev *pdev,
 	clock_cfg = readq(clock->reg_base + PTP_CLOCK_CFG);
 	clock_cfg &= ~PTP_CLOCK_CFG_PTP_EN;
 	writeq(clock_cfg, clock->reg_base + PTP_CLOCK_CFG);
-	pcim_iounmap_regions(pdev, 1 << PCI_PTP_BAR_NO);
+	pcim_iounmap_region(pdev, PCI_PTP_BAR_NO);
 
 error_free:
 	devm_kfree(dev, clock);
-- 
2.46.0


