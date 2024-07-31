Return-Path: <linux-pci+bounces-11049-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 753A6942EAD
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 14:36:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 2AB7628CAC6
	for <lists+linux-pci@lfdr.de>; Wed, 31 Jul 2024 12:36:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68ADC1AED46;
	Wed, 31 Jul 2024 12:36:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="f7k2X5ph"
X-Original-To: linux-pci@vger.kernel.org
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CA2721AE87A
	for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 12:36:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=170.10.133.124
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722429367; cv=none; b=Tz0wMjNs7VAii5yBcZXpBWpoD44D7Iv2r3LYo1yfeSFvyNFs8I/ay2aSsZpGkWBce726aBhjaLmF8/xyd7Y4wXFrYea9pgotOsi1iEFFEr9x7ylFlC29aUFW7kfOGcNRekQ+3mSfPMGA1EQEIwFhMdF1f3t1nwSG/k2ESvSkEXA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722429367; c=relaxed/simple;
	bh=WlOOsz/BddjK9BJ8X1xSO57i4x404QClCnZqzgYNZWY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=hvnr0iIkgavCvdxWEIujbbLdLk21cjxDAa3may5lbF1FJE1Qyj5WQSlgwOPWWN9oEDztaVNDszyYi2b9vn2ibUaeslebKuuHY5xHwYNSUgv0ISHHCWVn6ZB8RULVddOXLr6bYz8u6hiwmVc1qyj/MQUj2NSHNzE9CllusSLIKKI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com; spf=pass smtp.mailfrom=redhat.com; dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b=f7k2X5ph; arc=none smtp.client-ip=170.10.133.124
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=redhat.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=redhat.com
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
	s=mimecast20190719; t=1722429364;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=5Cq15lFRqX254TiblEFswKviVqFepxkbmzwO8PyVaqY=;
	b=f7k2X5ph9LLBStTLR3pMCOCEkdt89/0pQUf4ZPnc+a+Zg73eSpTzjw8JW6u5ZPJgv5Ph7k
	KY8OuvlhxEYzC1yIrAvm43525wLeKIcc4YmytWcWjbDoBEENdXFgLjP1992I5jht9rFOVt
	YFQBi5t1n8fYzvVJyzozOIcFGYPf3U8=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_256_GCM_SHA384) id
 us-mta-664-HwyGP1VMOW2nyBms5TLZrA-1; Wed, 31 Jul 2024 08:36:03 -0400
X-MC-Unique: HwyGP1VMOW2nyBms5TLZrA-1
Received: by mail-wm1-f72.google.com with SMTP id 5b1f17b1804b1-427feed9c71so6987385e9.0
        for <linux-pci@vger.kernel.org>; Wed, 31 Jul 2024 05:36:03 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1722429362; x=1723034162;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5Cq15lFRqX254TiblEFswKviVqFepxkbmzwO8PyVaqY=;
        b=Zpo5UgLyrgJrX/5s96IOsaSegYC9rGp7jasNDD2MoBAhWkJ+ZwWGBdXnJo/esljhE+
         1TZ3HTciacOKyoTaTqzzysISbPQLBRfhstUTaYJcfBoEsmQYwXLUdzEN0VN4pCHq3GDt
         MV6zukAD5OfnSq4yENT4TeBV8kpH/83MnDFLlcWIYIn6AiI6cJI/hB1w0SbI1PS79H/E
         GxaOYIHcvIqmzSN9jmp/XGC2hcCwZyt5DB0LoVHCLJTxiDpZ8Mv+AOQrivQnVBl/l1Gt
         v5dAumQrRgLPmoHThJtDIORU9muC11fUcCCKeI88zUmISE1kr6Dx+cmk/T/D+ZmFVdzJ
         p01g==
X-Forwarded-Encrypted: i=1; AJvYcCWGWlaKNhK3+uKddYhkQ0/ITJTBuimNZWRB8Btz2VAourzxgEoqCH8hjOAbdxTQsB2GldVnzJP7sr+RbOedDJ0XfjMozs6WFyiB
X-Gm-Message-State: AOJu0YyN1zJPvD1d/VOMgt3kgc5cTvrUeql9jiqSjoJX5msDcMjffmEJ
	CPoMZtgMRYkJyp1ZuSRIEajyLbH1nRC72ZsJwI4jAMxtpJ7IArIQA8rRYWpVePuqD1Ycllpkmhy
	Lyr+W/dmfWOP+/4kAQ248jBizOMoZqdVy3g6Z9VvnjrDm3E0su56ZJ9h4TA==
X-Received: by 2002:a05:6000:4014:b0:35f:2a75:91fd with SMTP id ffacd0b85a97d-36b34d24059mr7741549f8f.6.1722429362260;
        Wed, 31 Jul 2024 05:36:02 -0700 (PDT)
X-Google-Smtp-Source: AGHT+IERtyUidPwaNumRAOZZK4tOwj3EaThvDdekjFGdjXct9xc5jiS45HLvLSR1u6b2d6FlB8ESjg==
X-Received: by 2002:a05:6000:4014:b0:35f:2a75:91fd with SMTP id ffacd0b85a97d-36b34d24059mr7741534f8f.6.1722429361686;
        Wed, 31 Jul 2024 05:36:01 -0700 (PDT)
Received: from eisenberg.muc.redhat.com (nat-pool-muc-t.redhat.com. [149.14.88.26])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-36b367c0829sm16925976f8f.17.2024.07.31.05.36.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 31 Jul 2024 05:36:01 -0700 (PDT)
From: Philipp Stanner <pstanner@redhat.com>
To: Damien Le Moal <dlemoal@kernel.org>,
	Niklas Cassel <cassel@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>
Cc: linux-ide@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-pci@vger.kernel.org,
	Philipp Stanner <pstanner@redhat.com>
Subject: [PATCH 2/2] ata: ahci: Remove deprecated PCI functions
Date: Wed, 31 Jul 2024 14:34:56 +0200
Message-ID: <20240731123454.22780-4-pstanner@redhat.com>
X-Mailer: git-send-email 2.45.2
In-Reply-To: <20240731123454.22780-2-pstanner@redhat.com>
References: <20240731123454.22780-2-pstanner@redhat.com>
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

Replace these functions in ahci with their successors,
pcim_request_all_regions() and pcim_iomap().

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


