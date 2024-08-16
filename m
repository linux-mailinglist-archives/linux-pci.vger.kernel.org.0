Return-Path: <linux-pci+bounces-11754-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EB718954435
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 10:28:03 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 2A95A1C2224C
	for <lists+linux-pci@lfdr.de>; Fri, 16 Aug 2024 08:28:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37F0B155A3C;
	Fri, 16 Aug 2024 08:23:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NhycMhrY"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0E53814A084
	for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 08:23:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1723796615; cv=none; b=DhD0b0/F6R1BXurrlHYicNyQlOnljPUdCr8xfZAuWwmmXo2KN1GNc3FQJWIWibAFHukvR13MwYqUfcdjwAMRg02QeRI41RMU3UlpRzGV8bAsX55rIf9IrCOCNvY+J//X6zgCtijin/LEjm5PpqsnHOiIeK7fQIN0Iuee52OWRiE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1723796615; c=relaxed/simple;
	bh=YADw69teg6OUTw/9kGSAzVxq8RbBIlzKklSmAwNjgek=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YgQ+BOcZ2o98uXtW4Nc3joIjmg6yy226/fgrd3KNIC2y67c+4K4AWvP+CAgFluRCFo3O7YvvXqiJpfZadeMvWypGIvNdUcH1T4I4z0/qF8Z+NXcIvxys2XGS+2uiO1kbQnrRSqm2dal2HRJe1+hce86ra+qnfqGBSEqUT8bvpQQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=NhycMhrY; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1723796613;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=wR7g/AUrRep93UkGki3e8tPEClSI97kh3uS4quT0v8M=;
	b=NhycMhrYjMP7ZidkfzlRlZfIjHEbglpT7ZEbzkKT47aX3Ng/CaPEekKgPpcOA9mOkdNd/X
	IBwfixvQ/1E8i9zT4RSNwJ2p6VriXXji3FnrNhfybp/T294Bg8iq/83xyD77QTv0sNz1Ro
	1bcEi5xwJYw+KKndCJMaKLpNwk1ykoo=
Received: from mail-lj1-f197.google.com (mail-lj1-f197.google.com
 [209.85.208.197]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-575-6bzh3OzXOJWN43QniR-ezw-1; Fri, 16 Aug 2024 04:23:31 -0400
X-MC-Unique: 6bzh3OzXOJWN43QniR-ezw-1
Received: by mail-lj1-f197.google.com with SMTP id 38308e7fff4ca-2ef311ad4e6so1229231fa.0
        for <linux-pci@vger.kernel.org>; Fri, 16 Aug 2024 01:23:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1723796610; x=1724401410;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wR7g/AUrRep93UkGki3e8tPEClSI97kh3uS4quT0v8M=;
        b=j8/oSTECjlxNGcK1mneIHDkWrn1iyEsn4FHSia/0u0/Mys27fixWlKBKRD6hmVwxgE
         JO3nTA19wO5C8rxssJ8EBNvVytjWQS6Rti+C0tNx26r/c1bgF5pzO1oKydXRJLDqUDYQ
         bHJv+MSUXa2STWPIbdUneCORqW4c+H0C1Jzq9JQtNKH4wO4O7HfPA0t4ON2HDZaVbnY2
         +t7uiwv+v1CQjhGIrn4QU0+nyD6AkidZIwg+9hq0vHdx4/tnWZSZeqJIziOMQRLdTqTW
         2z96j4J984qTeRsdaguVCU/l9KdSc/wg9JSZdd8hwLg/ZSkQI0eY2ypfysSpvS/l1lfA
         iR8w==
X-Forwarded-Encrypted: i=1; AJvYcCWrsXtOokoNAyy3QI6oJKx39ZE9lxeXgH8QoHvTUfRKIP5xngErrF3QDCRD5092ompeYZdYRSXwJrnMoR+V/D/7JTeA4XWuCe22
X-Gm-Message-State: AOJu0YywaHqGfjyrq6/SXIwRHaH6dLxwpgCCF9R15dAJFL5OcTQtHxpT
	i0uLG/02um8bFOwuU7ZmHMbjOyFmu2Ub0Vp6C2ypnRcZppV6v6tG75Jg0KkrUWqk34J2/orW/JO
	5y83hD0fkx2Us1a87rkVol+iRkgMNHkasWr1KGH4+ibmK2AnYzJOPy8vvYQ==
X-Received: by 2002:a05:651c:210e:b0:2f3:b38c:a142 with SMTP id 38308e7fff4ca-2f3be6074c1mr8717821fa.6.1723796609779;
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGedci6wEskLStoN5T+/a5fQ7mQwe3Hdz3eZpzwNe45i6iFhaTa+e9V9NXIeJ1Uhhe0A/2fIA==
X-Received: by 2002:a05:651c:210e:b0:2f3:b38c:a142 with SMTP id 38308e7fff4ca-2f3be6074c1mr8717741fa.6.1723796609341;
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
Received: from eisenberg.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-429ded367ebsm71461355e9.25.2024.08.16.01.23.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Aug 2024 01:23:29 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Jie Wang <jie.wang@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Tero Kristo <tero.kristo@linux.intel.com>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	Jonathan Corbet <corbet@lwn.net>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc: qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	linux-doc@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Jiri Slaby <jirislaby@kernel.org>
Subject: [PATCH v3 08/10] serial: rp2: Replace deprecated PCI functions
Date: Fri, 16 Aug 2024 10:23:00 +0200
Message-ID: <20240816082304.14115-9-pstanner@redhat.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240816082304.14115-1-pstanner@redhat.com>
References: <20240816082304.14115-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_table() and pcim_iomap_regions_request_all() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
Reviewed-by: Jiri Slaby <jirislaby@kernel.org>
---
 drivers/tty/serial/rp2.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/drivers/tty/serial/rp2.c b/drivers/tty/serial/rp2.c
index 4132fcff7d4e..b6b30bb956fa 100644
--- a/drivers/tty/serial/rp2.c
+++ b/drivers/tty/serial/rp2.c
@@ -698,7 +698,6 @@ static int rp2_probe(struct pci_dev *pdev,
 	const struct firmware *fw;
 	struct rp2_card *card;
 	struct rp2_uart_port *ports;
-	void __iomem * const *bars;
 	int rc;
 
 	card = devm_kzalloc(&pdev->dev, sizeof(*card), GFP_KERNEL);
@@ -711,13 +710,16 @@ static int rp2_probe(struct pci_dev *pdev,
 	if (rc)
 		return rc;
 
-	rc = pcim_iomap_regions_request_all(pdev, 0x03, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc)
 		return rc;
 
-	bars = pcim_iomap_table(pdev);
-	card->bar0 = bars[0];
-	card->bar1 = bars[1];
+	card->bar0 = pcim_iomap(pdev, 0, 0);
+	if (!card->bar0)
+		return -ENOMEM;
+	card->bar1 = pcim_iomap(pdev, 1, 0);
+	if (!card->bar1)
+		return -ENOMEM;
 	card->pdev = pdev;
 
 	rp2_decode_cap(id, &card->n_ports, &card->smpte);
-- 
2.46.0


