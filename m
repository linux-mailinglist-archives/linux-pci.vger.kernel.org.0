Return-Path: <linux-pci+bounces-12596-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 7FA3F967F68
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 08:26:22 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 060F3B220EC
	for <lists+linux-pci@lfdr.de>; Mon,  2 Sep 2024 06:26:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D0E7D185B7A;
	Mon,  2 Sep 2024 06:24:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="P4r7jA2Q"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4FEA3183CCB
	for <linux-pci@vger.kernel.org>; Mon,  2 Sep 2024 06:24:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1725258273; cv=none; b=P8GHFQrPxKdYYCA7uYfXVwbmQO93aT93yndGhLzl4w58e9B1HwQCanWwu//D1o/135aQNH8Asio/WhxLa7sCZ2nbt2Tml2XxtXYN5fJYxMp+MEdi+PTmrVVlsaDJP/p/NEWEY4DhjsZbI+Wse7o148Qndq/w9hxBvVLX0h9JIfI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1725258273; c=relaxed/simple;
	bh=Fc7LqA4dsnee2e9i3xlXjC/frSEy4rrwVedoLFfxfmw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=rA7kunJdLqDHqaX6HXp/+eaDQHA05h7MXsbmvcd0fs2kvUFqvWyvgszX3EUW9dDA7nR1czN+8CRNpQVE3o5Eyg1Kopa47Wrl7VrQXQ02Qvq+mQ+uvzQRCfbfCaBfoG54Pj3l7UByMX0pkNVwZha3GrrNS7IsvBlHhubyPAQCHDA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=P4r7jA2Q; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1725258271;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
	b=P4r7jA2Q1KAHjsmkQDCMyioXqUbd4AjDGo9s86C3tZUoA4SbFOTpnw3KQcQiCG+LqN2QaU
	wzFpK8fkmeRFoiooqQ43y/cFE1YjD5ulYANnwExNgo9jlctvCRb259z6h8y988tm2Lj7vf
	Umbw49z9ru96Ow/Vd0MgeDrz4DP84MM=
Received: from mail-vs1-f72.google.com (mail-vs1-f72.google.com
 [209.85.217.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-554-kAf4G84lNX6GM2loEbRdpw-1; Mon, 02 Sep 2024 02:24:30 -0400
X-MC-Unique: kAf4G84lNX6GM2loEbRdpw-1
Received: by mail-vs1-f72.google.com with SMTP id ada2fe7eead31-498df3b7e0fso1835983137.2
        for <linux-pci@vger.kernel.org>; Sun, 01 Sep 2024 23:24:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1725258270; x=1725863070;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/H9qQSvRoJEHuC9fzeIRZ7nyD5NIc+bT7koxtRIZd8A=;
        b=d8OJgLdvmkcxybgoVeLpfchgu3X4M3o84SF5/6dXddypYCFpv+k+O0rtsI8JCLEK3m
         y19ts9T1y0u9rhTxPAEPwL/eAOfiwWoUvm4PMYAVKRRUh6vDoEl9QnkSsU4SumuoRR/U
         3Vo3tWre3rG6DSJoZqqBvkX+Em/a9lGVJsSkhnjpuqYF9by0d9jxi4IaYiHjDSZ61CwF
         rdW1OjWWJ8HQI40b005pvHtXq43mJpV3ojGJ6GVMpeTJlIKgqX+f5F9id0EQdD9Gy59w
         mGN1qWtNt43I31v2TBeBvZS+jNx1oHH8K7R86yfJ9Ku69zqDthQHdXCYSK/DNb1aPlWo
         mArw==
X-Forwarded-Encrypted: i=1; AJvYcCVte5d8LU0xEgxSJXLRyy/toL9TcByeqTAxIsExDUKB1lb0Wr3sIqZwolsRgnFNlnd9qHvqw+yskRQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxwRuhZAEjfwZMB1PGc/0ieLhGTqdiCZA6JrhEUCJrXwe0101tn
	woWfLyPVb6cwezDyS60oI0n+s3XiNp7JEIODsuAKDEMgY+Zid86g+zIJmNhSDLMFTrbQwiFwZuA
	OHzp4PcEA50IEHKoB3NgEtDMrAnXfBXjvK8l3BVLIuD4OV52tMDE4JB5vXg==
X-Received: by 2002:a05:6102:3e89:b0:498:ede5:b20f with SMTP id ada2fe7eead31-49a779a41c8mr7270568137.19.1725258269946;
        Sun, 01 Sep 2024 23:24:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IHvKk7L/2Q+f5ePTEDKBoGd9wpJAI1J/cRLRuOI8ztSXLRi4Uiggu4Svtva7Pn5OPFtOZyMyA==
X-Received: by 2002:a05:6102:3e89:b0:498:ede5:b20f with SMTP id ada2fe7eead31-49a779a41c8mr7270533137.19.1725258269592;
        Sun, 01 Sep 2024 23:24:29 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a806d3a34asm389211385a.84.2024.09.01.23.24.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Sep 2024 23:24:29 -0700 (PDT)
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
	John Garry <john.g.garry@oracle.com>,
	Chaitanya Kulkarni <kch@nvidia.com>,
	Philipp Stanner <pstanner@redhat.com>
Cc: linux-block@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-fpga@vger.kernel.org,
	linux-gpio@vger.kernel.org,
	netdev@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Bartosz Golaszewski <bartosz.golaszewski@linaro.org>
Subject: [PATCH v6 4/5] gpio: Replace deprecated PCI functions
Date: Mon,  2 Sep 2024 08:23:41 +0200
Message-ID: <20240902062342.10446-6-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240902062342.10446-2-pstanner@redhat.com>
References: <20240902062342.10446-2-pstanner@redhat.com>
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
2.46.0


