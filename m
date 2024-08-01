Return-Path: <linux-pci+bounces-11134-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 76025945221
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:50:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9A3EA1C2313C
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:50:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 25F721BA892;
	Thu,  1 Aug 2024 17:46:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="d66cIGsX"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 899081BF30F
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 17:46:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534412; cv=none; b=uJjCdHX45a9AkSBow4OTFMo1wRPrNzU8dgUMR+0Y2tVvKlFYP0z1tTquEnPPIYa+Hmhot4kQSZ97/xXT6i1K7MOWgq42dOfhks6dl+U7IbTxabRhcXXq2m1G+/EBPj1O3JlQ7rZLUUMVmkNh/kzglMlOpXPO6GxdCDMBZQeaZu8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534412; c=relaxed/simple;
	bh=Pv8ODNDYtz7oEjKERVc6wlqFHzZSZy1QxJE4IhyOR4w=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YhUEbWizij0Cbra+aGRgoTwrmHnUh/t5Gr/zI1uMY2PwQsfVwy7bbFCCKK7h3csnbL5t/cHr3GFF8VvkUbdMtO+cg9igriPQ/D/C548vaRWhqZio0sykCwphuOcRibtKnAmavFJRzKgrdZI8VfnITroOAt/9oeTJ9ChTpE8Rx5E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=d66cIGsX; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534408;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=09zJhy4Kbly6dnOSxC9RhwbbIyB3cmvAQjfFuNCxLhY=;
	b=d66cIGsXLgClJobePS6VskhhYjJwwbjD48hGGAhOkNb3Wt+yfGFSkOWd99f9n7xBQnCqZK
	kCGl5x9EA/sWtEzKNYntLw7Hh2LHUV2eKh2FNnk92cEDU+3mcMWtxInt/05ade+HErUAgj
	Sp2M5W4EBhoIhIC18dUaGQgS/WX5CME=
Received: from mail-ed1-f71.google.com (mail-ed1-f71.google.com
 [209.85.208.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-679-mO7JpMFbOt--NopIhh_Obw-1; Thu, 01 Aug 2024 13:46:47 -0400
X-MC-Unique: mO7JpMFbOt--NopIhh_Obw-1
Received: by mail-ed1-f71.google.com with SMTP id 4fb4d7f45d1cf-5a2b8c44b48so1974717a12.0
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 10:46:47 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534406; x=1723139206;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=09zJhy4Kbly6dnOSxC9RhwbbIyB3cmvAQjfFuNCxLhY=;
        b=rDEBItSQ9zdvkW8MMo//KyEmd8m5u+Rs4cOKSEl5vo0Bd+3ZOfeg2Uanm8ELMrQak9
         NT2Xbm+sVIR8IxiTXBLRnRtlJeawTbz0hGAh/7HaAp//xVc2SYaPCjSpGprxekpL82Vw
         e8VHwl6S8W501+sGVpZ64rsB/2QOjv2+jqoOSKxDn/JbOP+wVx1fWNGnONt5w2nF3XTT
         F2/smb7HUliH5yaqjyPLYNPaTZ2Z26H0W3v2wTi9mE+ci3mjIWkCRGHpqkNOz40NLWE3
         TTfZm+mzQARe0N7FR6zEEaIc8cDkKTdomjewgN3bjkWsOCmgsjpGr0j0hPTfRxZsVbC5
         FP/Q==
X-Forwarded-Encrypted: i=1; AJvYcCWtQIl22p+hiOaG+XOVAlaug06hEypG+ir+WMkyyhbfkuyTwNq01sQXfdqS77rjZXFOl9qLjYuKli3ynZJSQyKswfFPMoFbxytt
X-Gm-Message-State: AOJu0Yyn7u27a2YHBd8BhNJ+B+3tEzU48VMSVZ5naTqK2uQWWLb2GeEg
	UR7ENdO3+N6KhbZiphLC1xReKEWc1vwcaIg+n5XhfoTOf9VgREtDEwuQ3jjrFFKTjkBcL+adASC
	8a62WLXwzu0QNEmJHD16khcop1r9/G6TBA4cYtmHKf9NW4ne5KAoaf9qqQg==
X-Received: by 2002:a17:907:2d8a:b0:a7a:8378:6253 with SMTP id a640c23a62f3a-a7dc506e7f3mr47120766b.6.1722534406260;
        Thu, 01 Aug 2024 10:46:46 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IFySF5GV88NqHAqxRlxnt7y0NX7+8rGyEZHEIOl43GdNOi3Tk+WX4XrvRPcFqJTqbiCRuqnbw==
X-Received: by 2002:a17:907:2d8a:b0:a7a:8378:6253 with SMTP id a640c23a62f3a-a7dc506e7f3mr47115166b.6.1722534405758;
        Thu, 01 Aug 2024 10:46:45 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:45 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Jonathan Corbet <corbet@lwn.net>,
	Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Giovanni Cabiddu <giovanni.cabiddu@intel.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	"David S. Miller" <davem@davemloft.net>,
	Boris Brezillon <bbrezillon@kernel.org>,
	Arnaud Ebalard <arno@natisbad.org>,
	Srujana Challa <schalla@marvell.com>,
	Alexander Shishkin <alexander.shishkin@linux.intel.com>,
	Miri Korenblit <miriam.rachel.korenblit@intel.com>,
	Kalle Valo <kvalo@kernel.org>,
	Serge Semin <fancer.lancer@gmail.com>,
	Jon Mason <jdmason@kudzu.us>,
	Dave Jiang <dave.jiang@intel.com>,
	Allen Hubbe <allenbh@gmail.com>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Kevin Cernekee <cernekee@gmail.com>,
	Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
	Jiri Slaby <jirislaby@kernel.org>,
	Jaroslav Kysela <perex@perex.cz>,
	Takashi Iwai <tiwai@suse.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	=?UTF-8?q?Uwe=20Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>,
	Jonathan Cameron <Jonathan.Cameron@huawei.com>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Jie Wang <jie.wang@intel.com>,
	Adam Guerin <adam.guerin@intel.com>,
	Shashank Gupta <shashank.gupta@intel.com>,
	Damian Muszynski <damian.muszynski@intel.com>,
	Nithin Dabilpuram <ndabilpuram@marvell.com>,
	Bharat Bhushan <bbhushan2@marvell.com>,
	Johannes Berg <johannes.berg@intel.com>,
	Gregory Greenman <gregory.greenman@intel.com>,
	Emmanuel Grumbach <emmanuel.grumbach@intel.com>,
	Yedidya Benshimol <yedidya.ben.shimol@intel.com>,
	Breno Leitao <leitao@debian.org>,
	=?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
	John Ogness <john.ogness@linutronix.de>,
	Thomas Gleixner <tglx@linutronix.de>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-ide@vger.kernel.org,
	qat-linux@intel.com,
	linux-crypto@vger.kernel.org,
	linux-wireless@vger.kernel.org,
	ntb@lists.linux.dev,
	linux-pci@vger.kernel.org,
	linux-serial@vger.kernel.org,
	linux-sound@vger.kernel.org
Subject: [PATCH 10/10] PCI: Remove pcim_iomap_regions_request_all()
Date: Thu,  1 Aug 2024 19:46:08 +0200
Message-ID: <20240801174608.50592-11-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240801174608.50592-1-pstanner@redhat.com>
References: <20240801174608.50592-1-pstanner@redhat.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

pcim_iomap_regions_request_all() had been deprecated in
commit e354bb84a4c1 ("PCI: Deprecate pcim_iomap_table(),
pcim_iomap_regions_request_all()").

All users of this function have been ported to other interfaces by now.

Remove pcim_iomap_regions_request_all().

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/pci/devres.c                          | 56 -------------------
 include/linux/pci.h                           |  2 -
 3 files changed, 59 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index ac9ee7441887..895eef433e07 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -394,7 +394,6 @@ PCI
   pcim_enable_device()		: after success, all PCI ops become managed
   pcim_iomap()			: do iomap() on a single BAR
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
-  pcim_iomap_regions_request_all() : do request_region() on all and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
   pcim_iounmap()		: do iounmap() on a single BAR
   pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 0ec2b23e6cac..eef3ffbd5b74 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -952,62 +952,6 @@ int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 }
 EXPORT_SYMBOL(pcim_request_all_regions);
 
-/**
- * pcim_iomap_regions_request_all - Request all BARs and iomap specified ones
- *			(DEPRECATED)
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to iomap
- * @name: Name associated with the requests
- *
- * Returns: 0 on success, negative error code on failure.
- *
- * Request all PCI BARs and iomap regions specified by @mask.
- *
- * To release these resources manually, call pcim_release_region() for the
- * regions and pcim_iounmap() for the mappings.
- *
- * This function is DEPRECATED. Don't use it in new code. Instead, use one
- * of the pcim_* region request functions in combination with a pcim_*
- * mapping function.
- */
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name)
-{
-	int bar;
-	int ret;
-	void __iomem **legacy_iomap_table;
-
-	ret = pcim_request_all_regions(pdev, name);
-	if (ret != 0)
-		return ret;
-
-	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++) {
-		if (!mask_contains_bar(mask, bar))
-			continue;
-		if (!pcim_iomap(pdev, bar, 0))
-			goto err;
-	}
-
-	return 0;
-
-err:
-	/*
-	 * If bar is larger than 0, then pcim_iomap() above has most likely
-	 * failed because of -EINVAL. If it is equal 0, most likely the table
-	 * couldn't be created, indicating -ENOMEM.
-	 */
-	ret = bar > 0 ? -EINVAL : -ENOMEM;
-	legacy_iomap_table = (void __iomem **)pcim_iomap_table(pdev);
-
-	while (--bar >= 0)
-		pcim_iounmap(pdev, legacy_iomap_table[bar]);
-
-	pcim_release_all_regions(pdev);
-
-	return ret;
-}
-EXPORT_SYMBOL(pcim_iomap_regions_request_all);
-
 /**
  * pcim_iounmap_regions - Unmap and release PCI BARs
  * @pdev: PCI device to map IO resources for
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 5b5856ba63e1..8fe5d03cdac4 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2294,8 +2294,6 @@ void __iomem *pcim_iomap(struct pci_dev *pdev, int bar, unsigned long maxlen);
 void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
-int pcim_iomap_regions_request_all(struct pci_dev *pdev, int mask,
-				   const char *name);
 void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
-- 
2.45.2


