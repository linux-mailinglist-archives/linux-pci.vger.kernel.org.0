Return-Path: <linux-pci+bounces-37851-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 2D605BD0104
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 12:52:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 33DEB1894762
	for <lists+linux-pci@lfdr.de>; Sun, 12 Oct 2025 10:52:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D91552686A0;
	Sun, 12 Oct 2025 10:52:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="deS1KFz4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14C0E267386
	for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 10:52:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1760266346; cv=none; b=Wq2GQSRHmSVSYD5w63/YUATPZ9f805mnysetmp7m3UYX9twjp358j2ayv4CIii6HxlhNOL8BJrptNiSvPrBptqhb+Cjq0g1WX47WxZHOKXUejwpw5ZSVkKzBSVaNYHmCdr4J3LvBFe7TDWmzCfGXCji4uPV091eK2wi3fXXk/4A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1760266346; c=relaxed/simple;
	bh=MqF5cMOJ84e/bDS4TErqwcOhQLiLI58hkMImp466mJw=;
	h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type; b=VlnuhhQAZDfkrM4oypoeX9/V64q5fQzCAb+Zy7pBVtn6CvQ3qvtJ2jvGYIHTeG48rc3xAWyKTDIvi2YIy3DCr6NlWeEFCz2O/oVaURL72MpCgF8dKM0p8q2Oc2HSvIuB2FmdIVbBCnJf7kYJqMAQykq9rlpZ5H3erACzL9/C4PU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=deS1KFz4; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b3ee18913c0so519190766b.3
        for <linux-pci@vger.kernel.org>; Sun, 12 Oct 2025 03:52:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1760266343; x=1760871143; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=iOpabM86lbztALBXEjkkJUpQktj7v1p6dsQQlchyZsk=;
        b=deS1KFz4gDKafGaMIQrGPSCIOfMTel+LFfulG3Y3ZWzVS1IiWdlJ/nmy+r3jX/lDf5
         zbWhVIG3gwsHF9h1XAhkzvKPUr8VbCBy5CTtIf/iHUNzsqz+Tmv9Uqpfcoi2IeNdPW3q
         0qYqUjKb3CDXZaYo/l1gHisJCpZ0WWzThwu6VX6TsI0v08DjqpTX4Yi5zR8IgI1/uzSr
         KG5oa5FZlxCdoBAjXWs4jwMfSQvaFFMQNQIebZYTmhbs5snWJrqSBla7TVKyWY27LTgh
         iT2dL3CJmJmoj9nHTTwMSQLbiq3HgU06da+SBHLKinjRt189b2AC4W8xlZt7y2n4yyqO
         r+iA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1760266343; x=1760871143;
        h=content-transfer-encoding:mime-version:message-id:subject:to:from
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=iOpabM86lbztALBXEjkkJUpQktj7v1p6dsQQlchyZsk=;
        b=PXg2xBfg7G6LQRpEIryCfQDxx1TzRWP8eaU/Mu1QMXtbkOUIahCxfNG1JpP26bSjsE
         qOxDa8qOiyybA1GeiP+jctExthZYGEPYWk38afB/SfSA1xX1/+szSpTPFip6LBe9Gmr+
         r1rWDauL4SVRbfy2kj+oZpUuOH1XBiAB+ZPUgpnxjRoJ7bdOOXWEvMVpu+yen9lT3nxK
         7s0hJ+iYO0xboQ3+K2nodFxRzoCKfNX+EHrRBflCfTaotiTyqEh5139I0KQj04Tk4JEj
         EUFa5RrGITBTdOC9pLlLgq2nHn7qBVULdhunHr2wkKfnv06qV/5Dz0d01RbEDmvjM8ek
         ri4A==
X-Forwarded-Encrypted: i=1; AJvYcCXpg1KhWTMGXw5xjHTSeklPcf2pkcy3odhP3tpu62lj2xSiK2U9Y4ZRinMdpCl+Ae+rqkeBnadmhaA=@vger.kernel.org
X-Gm-Message-State: AOJu0YxFZs2LC44TCrZOCTINIOKPt8kYuSR1wlqepg7RI+4yYXjnbJ2n
	k+k+DCVC1UH/7P3+Ib+hMJoH0fTgHI2GkDwDPyQyxjGWMcCEh9ktNpsCPbrCVQ==
X-Gm-Gg: ASbGncvpTWY1oNy7xY1aaeeh3uLu+cqb2LE6wW2ucd28tq91Flc6trj/khrqU6vpZxC
	5EooSM0GREkFYqSmn8GtXRCfUF6D0YizikoBCFjt5u8VEWjKGc3jYk/+rfVK87oZmlKa1sYTLJG
	AREh8x+Nwg5qkuCxLd4BP7IkOn0EE7d4tuWG9grKir3+7+cVuunMbQC1VW+4qnSvuKRLPpBl6hH
	kyP8raKNrJRPYJ2fNDVeOK8xKcTy4z/69VKSEAH0QN/nwQocTvNFTpBGLEuUNAzTx7QjyDT2gnI
	gnOlVQ2yrtR52SMToeD4d8AX7cMoPTS5DU1bxRKcoYlHt+7IpyKH7UCxOIkKnGeqjtcdnChLtFD
	vD1ADg/q48HwFU6kIJNDHMK/Ni5rtYtNW75SbyqYnrW+7sYS7i93ckrInV9U+GdPlgGAgW7wKze
	c=
X-Google-Smtp-Source: AGHT+IGpnc73DvzgvhXnM6IXi/RiZA/Mw6XZR7FH07n78kbcJVw1ff18xsQwbSwwRBD8xIEozEoGuQ==
X-Received: by 2002:a17:907:3e22:b0:b3e:b226:5bad with SMTP id a640c23a62f3a-b50a9a6d8a3mr1889184266b.8.1760266343213;
        Sun, 12 Oct 2025 03:52:23 -0700 (PDT)
Received: from foxbook (bff184.neoplus.adsl.tpnet.pl. [83.28.43.184])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b55d5cacba7sm688164366b.5.2025.10.12.03.52.22
        (version=TLS1_2 cipher=AES128-SHA bits=128/128);
        Sun, 12 Oct 2025 03:52:22 -0700 (PDT)
Date: Sun, 12 Oct 2025 12:52:18 +0200
From: Michal Pecio <michal.pecio@gmail.com>
To: iommu@lists.linux.dev, linux-kernel@vger.kernel.org,
 linux-pci@vger.kernel.org
Subject: [PATCH RFC] Implement DMA Guard Pages
Message-ID: <20251012125218.45c5f972.michal.pecio@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

Hi all,

I wonder if there is any interest in a feature like this?

DMA Guard Pages are unmapped pages inserted between consecutive DMA
mappings for devices behind IOMMUs. A device accessing its mappings
out of bounds will hopefully fault instead of hitting other memory.

I wrote this hack yesterday to debug such a device, since getting
an IOMMU fault is easier to detect and more convenient than looking
at some weird malfunction and wondering where it came from.

(BTW, can a PCI driver "catch" IOMMU faults by its devices?)

It looks like a useful aid for PCI driver developers and testers,
or maybe somebody would want this in regular use for reliability?

Honestly, I was surprised that no such thing (apparently?) exists.
So I dug into dma-iommu.c and wrote my own. The implementation is
trivial, it hooks into iommu_dma_alloc_iova()/iommu_dma_free_iova()
which appear to be a bottleneck where all iova (de)allocations for
DMA mappings must pass. The allocations are increased a little, but
callers are unaware of that and only map what they wanted to map.

It even seems to work, but beware it's first time I touch this code.

Michal

---
 drivers/iommu/Kconfig     | 18 ++++++++++++++++++
 drivers/iommu/dma-iommu.c | 29 ++++++++++++++++++++++-------
 2 files changed, 40 insertions(+), 7 deletions(-)

diff --git a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
index 70d29b14d851..f607873bf39a 100644
--- a/drivers/iommu/Kconfig
+++ b/drivers/iommu/Kconfig
@@ -157,6 +157,24 @@ config IOMMU_DMA
 	select NEED_SG_DMA_LENGTH
 	select NEED_SG_DMA_FLAGS if SWIOTLB
 
+config IOMMU_DMA_GUARD_PAGES_KB
+	int "DMA Guard Pages size in KB"
+	default 0
+	depends on IOMMU_DMA && EXPERT
+	help
+	  Specify the minimum amount of Guard Pages to be inserted between
+	  consecutive DMA mappings to devices behind IOMMUs. DMA Guard Pages
+	  are not mapped to any memory and hardware attempts to access them
+	  will fault. This helps catch hardware accessing valid mappings out
+	  of bounds which could otherwise unintentionally consume or corrupt
+	  other memory mapped adjacently.
+
+	  Size will be automatically increased to one or more IOMMU pages,
+	  depending on applicable alignment constraints. Small power-of-two
+	  mappings may get as many Guard Pages as the mapping uses itself.
+
+	  If unsure, use the default size of zero to disable DMA Guard Pages.
+
 # Shared Virtual Addressing
 config IOMMU_SVA
 	select IOMMU_MM_DATA
diff --git a/drivers/iommu/dma-iommu.c b/drivers/iommu/dma-iommu.c
index 7944a3af4545..51edf148f6c4 100644
--- a/drivers/iommu/dma-iommu.c
+++ b/drivers/iommu/dma-iommu.c
@@ -746,6 +746,17 @@ static int dma_info_to_prot(enum dma_data_direction dir, bool coherent,
 	}
 }
 
+static unsigned long size_to_iova_len(struct iova_domain *iovad, size_t size)
+{
+	size_t guard_size = 0;
+
+	/* allocate optional guard pages after the requested mapping */
+	if (CONFIG_IOMMU_DMA_GUARD_PAGES_KB)
+		guard_size = iova_align(iovad, CONFIG_IOMMU_DMA_GUARD_PAGES_KB << 10);
+
+	return (size + guard_size) >> iova_shift(iovad);
+}
+
 static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 		size_t size, u64 dma_limit, struct device *dev)
 {
@@ -759,7 +770,7 @@ static dma_addr_t iommu_dma_alloc_iova(struct iommu_domain *domain,
 	}
 
 	shift = iova_shift(iovad);
-	iova_len = size >> shift;
+	iova_len = size_to_iova_len(iovad, size);
 
 	dma_limit = min_not_zero(dma_limit, dev->bus_dma_limit);
 
@@ -796,17 +807,21 @@ static void iommu_dma_free_iova(struct iommu_domain *domain, dma_addr_t iova,
 				size_t size, struct iommu_iotlb_gather *gather)
 {
 	struct iova_domain *iovad = &domain->iova_cookie->iovad;
+	unsigned long iova_len;
 
 	/* The MSI case is only ever cleaning up its most recent allocation */
-	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI)
+	if (domain->cookie_type == IOMMU_COOKIE_DMA_MSI) {
 		domain->msi_cookie->msi_iova -= size;
-	else if (gather && gather->queued)
+		return;
+	}
+
+	iova_len = size_to_iova_len(iovad, size);
+
+	if (gather && gather->queued)
 		queue_iova(domain->iova_cookie, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad),
-				&gather->freelist);
+				iova_len, &gather->freelist);
 	else
-		free_iova_fast(iovad, iova_pfn(iovad, iova),
-				size >> iova_shift(iovad));
+		free_iova_fast(iovad, iova_pfn(iovad, iova), iova_len);
 }
 
 static void __iommu_dma_unmap(struct device *dev, dma_addr_t dma_addr,
-- 
2.48.1

