Return-Path: <linux-pci+bounces-11126-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 330569451E4
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 19:47:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B2B0D1F24E37
	for <lists+linux-pci@lfdr.de>; Thu,  1 Aug 2024 17:47:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D56D51BBBC9;
	Thu,  1 Aug 2024 17:46:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dN5RmDYL"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 32EAB1B9B37
	for <linux-pci@vger.kernel.org>; Thu,  1 Aug 2024 17:46:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.129.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722534395; cv=none; b=TGM+dYymhopWNmSXIpXI9XAnjapa5TbOSpiSWJRtim7hhHJp2dENOOPdcD1k27ojcqn7jbOv9I2hrcpDtFRKt8FPyXm/RvK9QuAw3rwpvay0kgTpMtwDc4lujnqEoNTegZExy+N5zcSzKGAG7bJWI3uEhzAE11Is+golXdXoqoM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722534395; c=relaxed/simple;
	bh=cvZkQ2qgcPVEhY7uG5u9oCildj/5ABgxLmro9w+ciu0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=bwAHSH0Qvzat/P2sWUyt3HWl8h/KKkW03FeawN6Ox+9YWbDfleJMSZ7CTmxWfvlzsm61qXsZDVQLkFd+nCGQ1l8vCBVIijW5FxG073UUP5G3jsO7Vn43a59VC4Ap/ynBR+Xm1FzhKSbRH8tAGJ3Wv4xcp5yvomEQJMIVxETeqS8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=dN5RmDYL; arc=none smtp.client-ip=170.10.129.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722534392;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=6WrcubhpDE+K1LZOYWy4Pg3YuYsECxnI/4rdk9yULNw=;
	b=dN5RmDYLjOu83Ly8y1oCrjM1bEkpQYrC9v7C8fSUXmDRET/3OfzZ8Xv3Ih2emCut1fDzU7
	b9FLgihNrtNfpMG4z/fS+V0iT00IhNEGMItTaeWkKNYEYC5wY/K7sicyS6qhZhQkaLvepW
	vR6P5KsM547MWTMmGBV9YWBiE95brHQ=
Received: from mail-ed1-f72.google.com (mail-ed1-f72.google.com
 [209.85.208.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-183-n-TrzPQZOXax8ZjFWzj0ow-1; Thu, 01 Aug 2024 13:46:31 -0400
X-MC-Unique: n-TrzPQZOXax8ZjFWzj0ow-1
Received: by mail-ed1-f72.google.com with SMTP id 4fb4d7f45d1cf-5a0f73ff43cso1109865a12.3
        for <linux-pci@vger.kernel.org>; Thu, 01 Aug 2024 10:46:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722534390; x=1723139190;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6WrcubhpDE+K1LZOYWy4Pg3YuYsECxnI/4rdk9yULNw=;
        b=gJYP2Z6fN58y3/J9fIyoWZMy57cgfpgSQDHEa6ChRtGTjpCAlyU+hHcQgDdIG7RK2K
         iRQSOGHBZwjTwJiJJVvVtbQvwiTGryPX2y+apasJ7g59y8G3GHUlYSG3nt7lfSdrx103
         tch8UkoI1GcJ5VopJHAVi1LtSfUI+RlJrTHTYK9/Z4S1KsDPdIJ9mO2TA1IS2m+zebyV
         5jyLJrXRfb2ozXzrk/BMuGMpoXdTKNk4wS3dtq0CaWL8w9W8YCjcrcbGZa0EWjcaTuFu
         +J1O4vsexatSSaCoxDNSCncASFf6sQz8eGqubC2BJjWBwmbmoU+ImIq0TwAWjFY3HHFd
         m3dQ==
X-Forwarded-Encrypted: i=1; AJvYcCVIWk5nmWDVDAiWNcMs2iDWzEx3IEyjQXbZGsGe2Jy/vmYkgsqsRrRM0ua/gaGUaTWDlPzOskYo6gsaHXenmJ15Q8Vd3woFH6xZ
X-Gm-Message-State: AOJu0Yxi5/3OcXh2ySrgW27tKUOX72Sy1qtu7vmqdsu6zj4FmbHf7RF2
	2jZUR+ac5bQpf9fh1EpAg3QstmsB+ulHz/DA0cEEpYVgcYl65KWXlVxvOO9j5iqc1jUJQHe0QS5
	RzBRtpbJdqGoiIcNjUCRyr1X84T3dXYOMDnoHSpZoRI+AmEEN5i4ew20sAw==
X-Received: by 2002:a17:906:d551:b0:a7a:acae:341b with SMTP id a640c23a62f3a-a7dc511b140mr44545766b.9.1722534389742;
        Thu, 01 Aug 2024 10:46:29 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IGCCzZ5dXYZH3j2oFHnfDRvpX7K8jxtwUgAxGoBnV6WkOFIYg3M5/pUlm1BFFzaZy+v9hgOQQ==
X-Received: by 2002:a17:906:d551:b0:a7a:acae:341b with SMTP id a640c23a62f3a-a7dc511b140mr44545066b.9.1722534389355;
        Thu, 01 Aug 2024 10:46:29 -0700 (PDT)
Received: from eisenberg.fritz.box ([2001:16b8:3d4b:3000:1a1d:18ca:1d82:9859])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-a7dc9e83848sm5339066b.177.2024.08.01.10.46.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 01 Aug 2024 10:46:29 -0700 (PDT)
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
Subject: [PATCH 02/10] ata: ahci: Replace deprecated PCI functions
Date: Thu,  1 Aug 2024 19:46:00 +0200
Message-ID: <20240801174608.50592-3-pstanner@redhat.com>
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

pcim_iomap_regions_request_all() and pcim_iomap_table() have been
deprecated by the PCI subsystem in commit e354bb84a4c1 ("PCI: Deprecate
pcim_iomap_table(), pcim_iomap_regions_request_all()").

Replace these functions with their successors, pcim_iomap() and
pcim_request_all_regions()

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 drivers/ata/acard-ahci.c | 6 ++++--
 drivers/ata/ahci.c       | 6 ++++--
 2 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/drivers/ata/acard-ahci.c b/drivers/ata/acard-ahci.c
index 547f56341705..3999305b5356 100644
--- a/drivers/ata/acard-ahci.c
+++ b/drivers/ata/acard-ahci.c
@@ -370,7 +370,7 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	/* AHCI controllers often implement SFF compatible interface.
 	 * Grab all PCI BARs just in case.
 	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << AHCI_PCI_BAR, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -386,7 +386,9 @@ static int acard_ahci_init_one(struct pci_dev *pdev, const struct pci_device_id
 	if (!(hpriv->flags & AHCI_HFLAG_NO_MSI))
 		pci_enable_msi(pdev);
 
-	hpriv->mmio = pcim_iomap_table(pdev)[AHCI_PCI_BAR];
+	hpriv->mmio = pcim_iomap(pdev, AHCI_PCI_BAR, 0);
+	if (!hpriv->mmio)
+		return -ENOMEM;
 
 	/* save initial config */
 	ahci_save_initial_config(&pdev->dev, hpriv);
diff --git a/drivers/ata/ahci.c b/drivers/ata/ahci.c
index a05c17249448..905af6b68d80 100644
--- a/drivers/ata/ahci.c
+++ b/drivers/ata/ahci.c
@@ -1869,7 +1869,7 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	/* AHCI controllers often implement SFF compatible interface.
 	 * Grab all PCI BARs just in case.
 	 */
-	rc = pcim_iomap_regions_request_all(pdev, 1 << ahci_pci_bar, DRV_NAME);
+	rc = pcim_request_all_regions(pdev, DRV_NAME);
 	if (rc == -EBUSY)
 		pcim_pin_device(pdev);
 	if (rc)
@@ -1893,7 +1893,9 @@ static int ahci_init_one(struct pci_dev *pdev, const struct pci_device_id *ent)
 	if (ahci_sb600_enable_64bit(pdev))
 		hpriv->flags &= ~AHCI_HFLAG_32BIT_ONLY;
 
-	hpriv->mmio = pcim_iomap_table(pdev)[ahci_pci_bar];
+	hpriv->mmio = pcim_iomap(pdev, ahci_pci_bar, 0);
+	if (!hpriv->mmio)
+		return -ENOMEM;
 
 	/* detect remapped nvme devices */
 	ahci_remap_check(pdev, ahci_pci_bar, hpriv);
-- 
2.45.2


