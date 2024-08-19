Return-Path: <linux-pci+bounces-11820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7725C95711D
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 18:55:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A55531C231A1
	for <lists+linux-pci@lfdr.de>; Mon, 19 Aug 2024 16:55:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E3969189F32;
	Mon, 19 Aug 2024 16:53:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="J6x19d6N"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5E36B189BBE
	for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 16:52:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724086380; cv=none; b=m/vYaFeyryjFRLW7hrMyocy7/xMyNlGQwV0mVb1b+cJpnP/TqcYm0fMH/Wfoi0kHw0NvUQz7SMo0ld4z7TP+RhwfjAjqqfUKjcptPn7HvreVEDr+EC+XRA3/Qr5H6tIrWPTemw+hcyEiQ+GYHIRDbohrqCCtmas4dH0nfDcWRUU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724086380; c=relaxed/simple;
	bh=kdoJVoAn6TMYx4jeiXSMhz/dbakXLwqRf2j5XHX/mnE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=Uj2ORiUU22HnsjKYiaEbPGhhHyPou60ncDney+iB/OBaxJSFIt/gB/rwSXaBWR2DLpfi06ookRU+Qr6EljsEuhZcWJ0Esed37umDhPqh2GwA6SIeQ1bE5HhsxwISGm5pS36ADsCHlHrH08AgT6KBrrtStx/ZEQQrke/qSJm9ne8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=J6x19d6N; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724086378;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=CY9vOmK/BQyCj3xBb0Ms143MMS/6lF8CP2tePbnpXiU=;
	b=J6x19d6Nv3nssqgffnm3UOp0CjFV0EOebQdV9vhx4kgRqFmdPPwOWysn+SYxiwh28sNBGU
	6Sc1WSAIEyAdMYUd9esRI2pdP3DZO+i/nXK14nVf7g7AR98vLO4cvCZaE/iuFX1PVFfu8I
	Ulbd7RqerxEzxP7p4AhXTS+KI+F/CmE=
Received: from mail-oi1-f197.google.com (mail-oi1-f197.google.com
 [209.85.167.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-219-EekeEGPMOUaLwbvXD4ojzw-1; Mon, 19 Aug 2024 12:52:57 -0400
X-MC-Unique: EekeEGPMOUaLwbvXD4ojzw-1
Received: by mail-oi1-f197.google.com with SMTP id 5614622812f47-3dd42b1fef9so219924b6e.1
        for <linux-pci@vger.kernel.org>; Mon, 19 Aug 2024 09:52:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724086376; x=1724691176;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CY9vOmK/BQyCj3xBb0Ms143MMS/6lF8CP2tePbnpXiU=;
        b=VkJIkiShLslcYcv/uvh8izmSbhR7p7dhTLJGaGckO4E/nI0x5xLiCKk6UkGSnexz1e
         4usWTkUzS6L7I11kdTdgcItH6BnRtF96AyBpywY/SDB2McjmYqSDu25QAQd9Vvymx8/y
         CX9kv8sbm1h7zjIOPDbIprUa5c6O3FSYgjy5r7WK5yt8GMA3rPngj5N4FwCu4xVPIE5B
         M75uCaJqIvmww9qjfcGSIcQvi4NS4hxh9D4eP+EldOp+QEfhEWPj0nZMpft9Sx5OrJa2
         tUcq3owvBmzWjg3Na4PuH6+/f6BfBegOJTwQ2R4i2t25/JPTyVUmlQAV9dMXTT07+OKw
         g1nQ==
X-Forwarded-Encrypted: i=1; AJvYcCVoJg1/kMcTT2w4WI8Df8+idje0k780PAlaTv7Xtm9fbOkpKDJGnI688MTcqDrwiXSfLzb/rFitGYY=@vger.kernel.org
X-Gm-Message-State: AOJu0YwD82dQRscPUFqakYmoY8shHz8T/GtEFk8S0Eau0aHYe06UCrb4
	NahmzOqkcbGYnHDBK5Dj9DKkQIj89NwaXHBcr3MYoTJUQEs4vQ7pa62I9Z8dlS/E9JQ3ccbNWxR
	v3gdxqkeup6IQOF7HvQR2ydOvoR56uypXBztziSYJ5QQg3+WO6mqBnKivSg==
X-Received: by 2002:a05:6870:41d4:b0:25e:c0b:82c5 with SMTP id 586e51a60fabf-2701c380dc5mr6625339fac.3.1724086376412;
        Mon, 19 Aug 2024 09:52:56 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEXYRQHubDVB9l/Z5ACuWzvup4NaPaNsF9PV71SRQNM7kqNduzsiPOCl4z6zHTU6tKe3mmKcw==
X-Received: by 2002:a05:6870:41d4:b0:25e:c0b:82c5 with SMTP id 586e51a60fabf-2701c380dc5mr6625317fac.3.1724086376107;
        Mon, 19 Aug 2024 09:52:56 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff01e293sm446579885a.26.2024.08.19.09.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 19 Aug 2024 09:52:55 -0700 (PDT)
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
Subject: [PATCH 5/9] gpio: Replace deprecated PCI functions
Date: Mon, 19 Aug 2024 18:51:45 +0200
Message-ID: <20240819165148.58201-7-pstanner@redhat.com>
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

pcim_iomap_regions() and pcim_iomap_table() have been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace those functions with calls to pcim_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/gpio/gpio-merrifield.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/gpio/gpio-merrifield.c b/drivers/gpio/gpio-merrifield.c
index 421d7e3a6c66..274afcba31e6 100644
--- a/drivers/gpio/gpio-merrifield.c
+++ b/drivers/gpio/gpio-merrifield.c
@@ -78,24 +78,24 @@ static int mrfld_gpio_probe(struct pci_dev *pdev, const struct pci_device_id *id
 	if (retval)
 		return retval;
 
-	retval = pcim_iomap_regions(pdev, BIT(1) | BIT(0), pci_name(pdev));
-	if (retval)
-		return dev_err_probe(dev, retval, "I/O memory mapping error\n");
-
-	base = pcim_iomap_table(pdev)[1];
+	base = pcim_iomap_region(pdev, 1, pci_name(pdev));
+	if (IS_ERR(base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	irq_base = readl(base + 0 * sizeof(u32));
 	gpio_base = readl(base + 1 * sizeof(u32));
 
 	/* Release the IO mapping, since we already get the info from BAR1 */
-	pcim_iounmap_regions(pdev, BIT(1));
+	pcim_iounmap_region(pdev, 1);
 
 	priv = devm_kzalloc(dev, sizeof(*priv), GFP_KERNEL);
 	if (!priv)
 		return -ENOMEM;
 
 	priv->dev = dev;
-	priv->reg_base = pcim_iomap_table(pdev)[0];
+	priv->reg_base = pcim_iomap_region(pdev, 0, pci_name(pdev));
+	if (IS_ERR(priv->reg_base))
+		return dev_err_probe(dev, PTR_ERR(base), "I/O memory mapping error\n");
 
 	priv->pin_info.pin_ranges = mrfld_gpio_ranges;
 	priv->pin_info.nranges = ARRAY_SIZE(mrfld_gpio_ranges);
-- 
2.46.0


