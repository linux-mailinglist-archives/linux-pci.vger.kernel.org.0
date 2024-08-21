Return-Path: <linux-pci+bounces-11925-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 90D579595DE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 09:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 12B911F267AC
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 07:22:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5C68819ABD9;
	Wed, 21 Aug 2024 07:19:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="O+r6h94/"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A1CAD19ABC4
	for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 07:19:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724224786; cv=none; b=S08WsrS23jqf/tN8HZyu0Lw3zsJ1KEdFWp04xTympiE8T4UV1ZSMbmaaT/tej812VwCcdVpTQAepAo7STuwDAuCi3Qwjr5uFPy1U2Xxj7h7sy5FEZQg5swsb736qtUwppny3XndZWaxBNIIuBXXcFAEo4ytIifvhuysSNrLDkJo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724224786; c=relaxed/simple;
	bh=zz4g00AyrOlGbCFQ8xrM/DS+BcOL9w71mmIBYnsZsuY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=oRuWrapHAxB1ZHod2iQyRkGnjHCoess2zw/X3zcTJYuUXAOFvYG+sBqyPpt8ePAWS0nWVTzMC2D0kZUkdvQc/9xrCZOUfz4UYaNsS4tcqqy65SznMGnKuct5jfEfBSSUB1fLA9T7UUUE2wjhVYx7GCvNolBFF0Y0Rpgz6nbDz0w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=O+r6h94/; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1724224783;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=2jtoMc9tojKKL8iwWeM5ToAOyUwxh+I3f+1WrHk/fN0=;
	b=O+r6h94/9HSaTXMrJN8RYAnpwJsjhbs84mMxkigd8Kd1943MfsOOs+awbjWLc6QnYQcYy4
	UxwvpUEztPA3iSq1C64FnxxEXtVKlJoOMaNdooGn3eKWd2rqRR4zOgdyHTnVwIjnxiVC4O
	vmjIrkPE1fC+EQuB6yLXdEiGQbIJtIc=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-410-3gfV1sFANq2tr1cW66M-2Q-1; Wed, 21 Aug 2024 03:19:42 -0400
X-MC-Unique: 3gfV1sFANq2tr1cW66M-2Q-1
Received: by mail-qk1-f199.google.com with SMTP id af79cd13be357-7a1d4238d65so709438385a.0
        for <linux-pci@vger.kernel.org>; Wed, 21 Aug 2024 00:19:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1724224782; x=1724829582;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=2jtoMc9tojKKL8iwWeM5ToAOyUwxh+I3f+1WrHk/fN0=;
        b=LLHrGYWU+vLSRwWLwKssREdSsU5uAHMhzcNtC+scOvwAac74m1595At+hTY991vFQC
         zKdZCKXcpiSUfeZvqwBJcUfVV/t39y+2ctRQt1O1hutd53HO+V/34ERyNWmbuOoPtf/w
         ngwS1ZmNaDeAUJZqiemXmZvS3NOssqKwzvTL90EfYJin7sks/oUKoOdYHejAJWDxoz7Y
         cEICr2d/uhtH2bvU2zq4K7RqZ4y8/9tckf4fo1ZwMozvA6NRUtiWcN5H6sse4CVPKH+h
         DIOfh/C3aZeQmyGj6k/E2OZfHBWnhcUR3EHXWd76Q0pD0kmmPvCbLCUvXXJWAu/L5wSe
         hOUg==
X-Forwarded-Encrypted: i=1; AJvYcCXEVTzCwxiQStvAE0A5DoLNFyr7B+mYbkDDEj/J7rUaTWBp9Z/o6VxE/szzuRdKZJdoh9DQAk80a6A=@vger.kernel.org
X-Gm-Message-State: AOJu0YzkTWcPm48VcJDuJU+SPG9D5g72J/hmkVtCVL2OJ0YPhzn74oKV
	Gnw/N16GYIlqZujxlHCjjU6W8EmoHxPqOq2FQLlWHVDx6by1XK+sJpQ9hqDqkqatDPDn+9Rn49r
	FdnquaNIGl6a3CDiytEiK1Nffp+Tip6rKB864RkCaXOu7yAoYAE8jUo9zBw==
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr175953885a.32.1724224781998;
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IEujbivdy0X82ZZM2IZtk3pa0uY+R6FAaLiHcgNfg5GEA0wo0Jm6V+lDWsOUg8+jqkxdP5bpA==
X-Received: by 2002:a05:620a:3953:b0:79e:e302:7392 with SMTP id af79cd13be357-7a674047d68mr175949285a.32.1724224781630;
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id af79cd13be357-7a4ff013ef2sm596207885a.11.2024.08.21.00.19.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 21 Aug 2024 00:19:41 -0700 (PDT)
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
Subject: [PATCH v2 8/9] vdap: solidrun: Replace deprecated PCI functions
Date: Wed, 21 Aug 2024 09:18:41 +0200
Message-ID: <20240821071842.8591-10-pstanner@redhat.com>
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

solidrun utilizes pcim_iomap_regions(), which has been deprecated by the
PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()"), among other
things because it forces usage of quite a complicated bitmask mechanism.
The bitmask handling code can entirely be removed by replacing
pcim_iomap_regions() and pcim_iomap_table().

Replace pcim_iomap_regions() and pcim_iomap_table() with
pci_iomap_region().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/vdpa/solidrun/snet_main.c | 53 +++++++++++--------------------
 1 file changed, 18 insertions(+), 35 deletions(-)

diff --git a/drivers/vdpa/solidrun/snet_main.c b/drivers/vdpa/solidrun/snet_main.c
index 4d42a05d70fc..ce336f261649 100644
--- a/drivers/vdpa/solidrun/snet_main.c
+++ b/drivers/vdpa/solidrun/snet_main.c
@@ -556,36 +556,25 @@ static const struct vdpa_config_ops snet_config_ops = {
 static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 {
 	char *name;
-	int ret, i, mask = 0;
-	/* We don't know which BAR will be used to communicate..
-	 * We will map every bar with len > 0.
-	 *
-	 * Later, we will discover the BAR and unmap all other BARs.
-	 */
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (pci_resource_len(pdev, i))
-			mask |= (1 << i);
-	}
-
-	/* No BAR can be used.. */
-	if (!mask) {
-		SNET_ERR(pdev, "Failed to find a PCI BAR\n");
-		return -ENODEV;
-	}
+	unsigned short i;
 
 	name = devm_kasprintf(&pdev->dev, GFP_KERNEL, "psnet[%s]-bars", pci_name(pdev));
 	if (!name)
 		return -ENOMEM;
 
-	ret = pcim_iomap_regions(pdev, mask, name);
-	if (ret) {
-		SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
-		return ret;
-	}
-
+	/* We don't know which BAR will be used to communicate..
+	 * We will map every bar with len > 0.
+	 *
+	 * Later, we will discover the BAR and unmap all other BARs.
+	 */
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (mask & (1 << i))
-			psnet->bars[i] = pcim_iomap_table(pdev)[i];
+		if (!pci_resource_len(pdev, i))
+			continue;
+		psnet->bars[i] = pcim_iomap_region(pdev, i, name);
+		if (IS_ERR(psnet->bars[i])) {
+			SNET_ERR(pdev, "Failed to request and map PCI BARs\n");
+			return PTR_ERR(psnet->bars[i]);
+		}
 	}
 
 	return 0;
@@ -594,18 +583,15 @@ static int psnet_open_pf_bar(struct pci_dev *pdev, struct psnet *psnet)
 static int snet_open_vf_bar(struct pci_dev *pdev, struct snet *snet)
 {
 	char name[50];
-	int ret;
 
 	snprintf(name, sizeof(name), "snet[%s]-bar", pci_name(pdev));
 	/* Request and map BAR */
-	ret = pcim_iomap_regions(pdev, BIT(snet->psnet->cfg.vf_bar), name);
-	if (ret) {
+	snet->bar = pcim_iomap_region(pdev, snet->psnet->cfg.vf_bar, name);
+	if (IS_ERR(snet->bar)) {
 		SNET_ERR(pdev, "Failed to request and map PCI BAR for a VF\n");
-		return ret;
+		return PTR_ERR(snet->bar);
 	}
 
-	snet->bar = pcim_iomap_table(pdev)[snet->psnet->cfg.vf_bar];
-
 	return 0;
 }
 
@@ -653,15 +639,12 @@ static int psnet_detect_bar(struct psnet *psnet, u32 off)
 
 static void psnet_unmap_unused_bars(struct pci_dev *pdev, struct psnet *psnet)
 {
-	int i, mask = 0;
+	int i;
 
 	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
 		if (psnet->bars[i] && i != psnet->barno)
-			mask |= (1 << i);
+			pcim_iounmap_region(pdev, i);
 	}
-
-	if (mask)
-		pcim_iounmap_regions(pdev, mask);
 }
 
 /* Read SNET config from PCI BAR */
-- 
2.46.0


