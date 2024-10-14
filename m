Return-Path: <linux-pci+bounces-14420-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7A5DF99C227
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 09:55:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id ED85D1F22DA4
	for <lists+linux-pci@lfdr.de>; Mon, 14 Oct 2024 07:55:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D09F3156F3A;
	Mon, 14 Oct 2024 07:53:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fy7jAJZY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 34CDB155CBF
	for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 07:53:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728892427; cv=none; b=vFB+h8h4qilkSGQll8PhQ+p1qIDjo5ijuXuxdpeI4WQETddP2ih7KbXLkVt5+wEDs82mfWGFmV5/1N1rX5CgUUv2SnWCL5bX8l/X4oBSzZKut2m3uY3qxLPA7MooVm4BovaBxoSOcPoD6rmbWqX6o0VZGvY/M7tV8uxw4ifFQAg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728892427; c=relaxed/simple;
	bh=yzjQRsYbPqQgU1+oVL1O83MZ0bHUaj1hK69Y+ToXG5M=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=cfq0oXSdIY30Fwkb5wUNbDRV2wMOdj5My/F/2Zi+LmvnZBnnY/WhtgVWuCKfksS0qwUdkyc2/+J2BoEoVGL36//7x6J/wYDZ99vUOtprVyUFdIAN/G0HBYkfEO1Sjw6hhMTv9Qf17eActI8JsXVq876LJZat3gOADNNqNVQtmWI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=Fy7jAJZY; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1728892425;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XpYBp0Glw6qhc5uIPnL78eLKbUhbnbbx8B94lLKnhns=;
	b=Fy7jAJZYMxUxjsZ0PaL+YP/4PgJf0jIckGvwGpQmcP8kjOM5vbj7ArRtbPC1X6vlxKnKtt
	vandbXSvud5xIKpjUO5PUvYVjQadSQKkX6prUdJdKdl1C0Vh3TQ6rSbM1DBV0hOE7h9KmX
	E4lxJZjcpmAwRHPpLSetIfG647XjVlQ=
Received: from mail-ej1-f72.google.com (mail-ej1-f72.google.com
 [209.85.218.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-690-OwGq-mL5OLW4_qBKOQLa3g-1; Mon, 14 Oct 2024 03:53:42 -0400
X-MC-Unique: OwGq-mL5OLW4_qBKOQLa3g-1
Received: by mail-ej1-f72.google.com with SMTP id a640c23a62f3a-a9a194d672bso17695766b.2
        for <linux-pci@vger.kernel.org>; Mon, 14 Oct 2024 00:53:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1728892421; x=1729497221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=XpYBp0Glw6qhc5uIPnL78eLKbUhbnbbx8B94lLKnhns=;
        b=qxzAvthF3+BL3ElLLybTt++//yCy1yjXZ8SbSupcTDVVfkmtNACsUaw+mAln8fhtsR
         vY0Xhm0jNU3vvn95b0wOwEwGl5UfphJdsRPFY/tp76LqSIN6ARMcpUxqU/kIFIsSOZ/b
         FKvOXyGmTMeH/jcWb+vY2hJ18KyANz2iB/4NLA8TmLzN10luekR/oCFUC3rkwgA9z3qj
         jSj2I4nibTfFFxeLYWR6QZ7lOE/AMfGTCbMx32osnMzKNB8hFSHeo6s/UhAG4KGpdtyK
         EAlJiuuzwc8b7LcpWv1js+cgANBAQxCEU2TlgDkExqVnQ3+3yTVRqpMlHfdHcdnKcFFm
         3bDw==
X-Forwarded-Encrypted: i=1; AJvYcCWRB2goQeS1eXAxIRlkWMRSSVPKHXaxWT9wrZgNZIn1iOKX13U2YB+RgZy4xRNNXInvxT8At/V+HbQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxRT/LxoRJe5gFbOmia9iF58cFSTcHtAFNmL5VAy4TalWjesMFs
	hxZTlMpYg4xBmhpRXwSbpHt3JQ+soOGHLLOdOZOoX2OCbZnqdPbgA7sFvxOb01D+eaPoLV5n9bn
	3572DkOBQ2nifJ4a5BwPPudalNw+HZG1AU9lJJTXfro4q3XtLY1nyR9gISQ==
X-Received: by 2002:a17:907:2d89:b0:a9a:f84:fefd with SMTP id a640c23a62f3a-a9a0f84ffdcmr212769566b.36.1728892420878;
        Mon, 14 Oct 2024 00:53:40 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHFMGKWuGwtwW80fKcIghkLSWdQ8q9LlEyh0IA4xEx8zcoRTf66/z6edKXc8FjbNEyk6SOApg==
X-Received: by 2002:a17:907:2d89:b0:a9a:f84:fefd with SMTP id a640c23a62f3a-a9a0f84ffdcmr212766766b.36.1728892420454;
        Mon, 14 Oct 2024 00:53:40 -0700 (PDT)
Received: from eisenberg.fritz.box (200116b82d3798001d5778cfc1aeb0b3.dip.versatel-1u1.de. [2001:16b8:2d37:9800:1d57:78cf:c1ae:b0b3])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a99f86fa986sm243291666b.92.2024.10.14.00.53.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 14 Oct 2024 00:53:40 -0700 (PDT)
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
	Richard Cochran <richardcochran@gmail.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Keith Busch <kbusch@kernel.org>,
	Philipp Stanner <pstanner@redhat.com>,
	Li Zetao <lizetao1@huawei.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v7 4/5] gpio: Replace deprecated PCI functions
Date: Mon, 14 Oct 2024 09:53:25 +0200
Message-ID: <20241014075329.10400-5-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.2
In-Reply-To: <20241014075329.10400-1-pstanner@redhat.com>
References: <20241014075329.10400-1-pstanner@redhat.com>
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
Reviewed-by: Andy Shevchenko <andy@kernel.org>
Acked-by: Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
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
2.46.2


