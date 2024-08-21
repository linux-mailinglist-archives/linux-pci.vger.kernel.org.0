Return-Path: <linux-pci+bounces-11919-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 320DC9595AF
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 09:20:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AD1B71F25557
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 07:19:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C65C8199FC6;
	Wed, 21 Aug 2024 07:19:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VSeo7uTd"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 420F8192D83
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 07:19:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224754; cv=none; b=Ypa0gR5edDGUk9YepiQ40qqRdXuJifwOkipn31043JE7A2OrA499uudnS30Pqwi+80IeHL8IUDo2BrHcJVRRb2jTrmjaVZSUD/f0SYITUkpoPldDTCAfhdTNzSTmu2HmXoY01km8dYl73X1S4E0e32Q+/GzkwCFw/lG9oFgQdgo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224754; c=relaxed/simple;
	bh=mXOGVudfLi+KidU2SAFK83EWun0K/ZT4Bj7/UEKpbBQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=OjG+ij4msNh76S+gr3gLRxZV2MCv0pT5sJURrtU0OWUoOJWFE9Al+HGYFw/Wm6cwA7MqJqfXLC2a/q+1QHV43kyOeELKlFHVtdbvcUMGK097ybVaRPMLjJFlNW59IZuflOczeugXKz8rV78m58eQW4UJIZGiGE18OPA+34/MCys=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=VSeo7uTd; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224752;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=tC041gyCjeykzm80lE0q63CM17fX2IeQcUJmRWOoBEs=;
	b=VSeo7uTdYKavMs27SKz7mvMKmT7UpvFJa9BEoFkVOvIgb6UrL2U2JcwsTSpN9zAcV0vcWq
	SoGlL99Hla4cP8c1UzYKQePyWt6BxT9prLxF5EAUMZ8Bad/urEbpsEsKpM7omSPHLa5OWO
	XU5vaNB/M8YCcJt/DKmcyIQ064s9x6A=
Received: from mail-qk1-f200.google.com (mail-qk1-f200.google.com
 [209.85.222.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-556-5MqwUpelO_ugI6Lqn7gYqg-1; Wed, 21 Aug 2024 03:19:10 -0400
X-MC-Unique: 5MqwUpelO_ugI6Lqn7gYqg-1
Received: by mail-qk1-f200.google.com with SMTP id af79cd13be357-7a34e9c8945so657221885a.2
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 00:19:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224750; x=1724829550;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tC041gyCjeykzm80lE0q63CM17fX2IeQcUJmRWOoBEs=;
        b=cjw+9vchr9olpjhG71kyQ1T8UkbgjZMBwe0VxnbRHfadUzV1FZeX6ljZV6XJmyPxEz
         nSlqOnM5tZIQ61n3cmBMJq+E4JURUOGi67ZZhP69ESwsgrZU+FcrcyW1E8QaocFoDEF7
         NOOcF6S5QNV0u6S3km9LPomJxRzrgJ308XAEycbqhQC62QwM6/5tdz4ilta60cLLC4sY
         fA/nHdBjUeOcjdve9COZAhkuox4TuKgTeOwfaGijLzb9H+D5k5n0eDAVkIqWbqP4dkTy
         0fKNRbSPzgoAU45ZlMdZIgAV0BEtEhZ+t3yNWpRKMtUDs7XH+lXPnrVGTx92aELRK2jN
         QMsA==
X-Forwarded-Encrypted: i=1; AJvYcCXk5CFh26C5eVH2AzVDum0T3PnfCBRgf0axpnojYKKjGkwi847O7Xy+064zXfz+2Lm6fA0Li8UANO0=@vger.kernel.org
X-Gm-Message-State: AOJu0YzVsIz9sQXHl19Py9CkjyiKEdvoQCsIAnOIpDe8bkiJQrY/D6G9
	AVvDVFPKHOwm7iJiFhGpNz9XC0+vqOyAkzsZodJgFLvkgRwTEjPVSvyb9A+T76EZlWk2a/4gdIh
	PjO/3RQUfz6/Nl01aFSp8uOOCSEWhSYR9nNSeniN76iEMcYOu3GJKbqJicA==
X-Received: by 2002:a05:620a:3726:b0:7a1:e9a3:7ed5 with SMTP id af79cd13be357-7a674028608mr225747985a.21.1724224749857;
        Wed, 21 Aug 2024 00:19:09 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEDcpjkeN2s+Pkah8lNRsAeGJCiY8h2x/UjZoGAkEUi08MzdlRaM+ySap03gvKQjNGS0t9n+w==
X-Received: by 2002:a05:620a:3726:b0:7a1:e9a3:7ed5 with SMTP id af79cd13be357-7a674028608mr225743585a.21.1724224749534;
        Wed, 21 Aug 2024 00:19:09 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:09 -0700 (PDT)
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
Subject: [PATCH v2 2/9] fpga/dfl-pci.c: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:35 +0200
Message-ID: <20240821071842.8591-4-pstanner@redhat.com>
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

Port dfl-pci.c to the successor, pcim_iomap_region().

Consistently, replace pcim_iounmap_regions() with pcim_iounmap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/fpga/dfl-pci.c | 9 ++++++---
 1 file changed, 6 insertions(+), 3 deletions(-)

diff --git a/drivers/fpga/dfl-pci.c b/drivers/fpga/dfl-pci.c
index 80cac3a5f976..2099c497feec 100644
--- a/drivers/fpga/dfl-pci.c
+++ b/drivers/fpga/dfl-pci.c
@@ -41,10 +41,13 @@ struct cci_drvdata {
 
 static void __iomem *cci_pci_ioremap_bar0(struct pci_dev *pcidev)
 {
-	if (pcim_iomap_regions(pcidev, BIT(0), DRV_NAME))
+	void __iomem *bar0;
+
+	bar0 = pcim_iomap_region(pcidev, 0, DRV_NAME);
+	if (IS_ERR(bar0))
 		return NULL;
 
-	return pcim_iomap_table(pcidev)[0];
+	return bar0;
 }
 
 static int cci_pci_alloc_irq(struct pci_dev *pcidev)
@@ -296,7 +299,7 @@ static int find_dfls_by_default(struct pci_dev *pcidev,
 	}
 
 	/* release I/O mappings for next step enumeration */
-	pcim_iounmap_regions(pcidev, BIT(0));
+	pcim_iounmap_region(pcidev, 0);
 
 	return ret;
 }
-- 
2.46.0


