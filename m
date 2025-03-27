Return-Path: <linux-pci+bounces-24832-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 65AF8A72E83
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 12:08:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C56F617885F
	for <lists+linux-pci@lfdr.de>; Thu, 27 Mar 2025 11:08:24 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7374C2116F6;
	Thu, 27 Mar 2025 11:07:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="WOd6RVnn"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 434AF2101BD;
	Thu, 27 Mar 2025 11:07:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1743073665; cv=none; b=cjYmet76Wof/I5GH2MKc8f3JQBbwyi3ehR3phGPgjy2/e88KfPMItpqx93qHDc0kVcbXskide3wm0gpy7s4yzUJwN0xY/fyTINDF436RghnEEaEF6VvCK61XTIv85FBU2OjgixQtooKevD9tTMNMJu53PefHBskN7HPw+mQumx0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1743073665; c=relaxed/simple;
	bh=Dvi5btozFJtTcgREwrstpdJeuJ6eZajLPIGDsvSUmLM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DtyqqzqQNusoWY3vDgVKsZ0WlzQovZekWW9kmXA8fFgYF16xrukLjMwnUfAzt6gcpSoEQthWVTaZXPzvGCsb9Z62tj+M9AmjtYP0SOV7UnobntGu+pGeuviublwbRrgmDDL3mbkNGA6utN72U0eWvzbx+L16098eqSz4jZ6YhAo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=WOd6RVnn; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACD6FC4CEEB;
	Thu, 27 Mar 2025 11:07:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1743073664;
	bh=Dvi5btozFJtTcgREwrstpdJeuJ6eZajLPIGDsvSUmLM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
	b=WOd6RVnnHMZ2iLhSj3+dDLlbVEq37EvLFtb1Cn67TjbXM3yWGmGJwXVkGbupRFTvr
	 Uu4MS0EXybE4wCWUS8GakAXOnpilNS3k2TgkmUgWc4DrWHOBs+je1UWBPYXSVwrMr5
	 fdxmUpnppAwo6LR3AKjU8agNHUQy8lUoe90iV21XOGQ9vXPLu+F28oRPZdcikkKpnV
	 qrQm4WoUPD291sWdaz7p9qzg8z88NfFMvMWpAEnsiKKwZMpj//LAlTVc53HNInR683
	 6C9NCbCTbcdDFynecOBCK5pX86uR/FXriGlep5lawP7AZvd2gAK9+Q1vm/i6bPIqc7
	 C8bytQO5hNbDg==
From: Philipp Stanner <phasta@kernel.org>
To: Jonathan Corbet <corbet@lwn.net>,
	Jens Axboe <axboe@kernel.dk>,
	Bjorn Helgaas <bhelgaas@google.com>,
	Mark Brown <broonie@kernel.org>,
	David Lechner <dlechner@baylibre.com>,
	Philipp Stanner <pstanner@redhat.com>,
	Damien Le Moal <dlemoal@kernel.org>,
	Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
	Yang Yingliang <yangyingliang@huawei.com>,
	Zijun Hu <quic_zijuhu@quicinc.com>,
	Hannes Reinecke <hare@suse.de>,
	Al Viro <viro@zeniv.linux.org.uk>,
	Li Zetao <lizetao1@huawei.com>,
	Anuj Gupta <anuj20.g@samsung.com>
Cc: linux-doc@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-block@vger.kernel.org,
	linux-pci@vger.kernel.org
Subject: [PATCH 2/2] PCI: Remove pcim_iounmap_regions()
Date: Thu, 27 Mar 2025 12:07:08 +0100
Message-ID: <20250327110707.20025-4-phasta@kernel.org>
X-Mailer: git-send-email 2.48.1
In-Reply-To: <20250327110707.20025-2-phasta@kernel.org>
References: <20250327110707.20025-2-phasta@kernel.org>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Philipp Stanner <pstanner@redhat.com>

All users of the deprecated function pcim_iounmap_regions() have been
ported by now. Remove it.

Signed-off-by: Philipp Stanner <pstanner@redhat.com>
---
 .../driver-api/driver-model/devres.rst        |  1 -
 drivers/pci/devres.c                          | 24 -------------------
 include/linux/pci.h                           |  1 -
 3 files changed, 26 deletions(-)

diff --git a/Documentation/driver-api/driver-model/devres.rst b/Documentation/driver-api/driver-model/devres.rst
index d75728eb05f8..601f1a74d34d 100644
--- a/Documentation/driver-api/driver-model/devres.rst
+++ b/Documentation/driver-api/driver-model/devres.rst
@@ -396,7 +396,6 @@ PCI
   pcim_iomap_regions()		: do request_region() and iomap() on multiple BARs
   pcim_iomap_table()		: array of mapped addresses indexed by BAR
   pcim_iounmap()		: do iounmap() on a single BAR
-  pcim_iounmap_regions()	: do iounmap() and release_region() on multiple BARs
   pcim_pin_device()		: keep PCI device enabled after release
   pcim_set_mwi()		: enable Memory-Write-Invalidate PCI transaction
 
diff --git a/drivers/pci/devres.c b/drivers/pci/devres.c
index 3431a7df3e0d..c60441555758 100644
--- a/drivers/pci/devres.c
+++ b/drivers/pci/devres.c
@@ -946,30 +946,6 @@ int pcim_request_all_regions(struct pci_dev *pdev, const char *name)
 }
 EXPORT_SYMBOL(pcim_request_all_regions);
 
-/**
- * pcim_iounmap_regions - Unmap and release PCI BARs (DEPRECATED)
- * @pdev: PCI device to map IO resources for
- * @mask: Mask of BARs to unmap and release
- *
- * Unmap and release regions specified by @mask.
- *
- * This function is DEPRECATED. Do not use it in new code.
- * Use pcim_iounmap_region() instead.
- */
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask)
-{
-	int i;
-
-	for (i = 0; i < PCI_STD_NUM_BARS; i++) {
-		if (!mask_contains_bar(mask, i))
-			continue;
-
-		pcim_iounmap_region(pdev, i);
-		pcim_remove_bar_from_legacy_table(pdev, i);
-	}
-}
-EXPORT_SYMBOL(pcim_iounmap_regions);
-
 /**
  * pcim_iomap_range - Create a ranged __iomap mapping within a PCI BAR
  * @pdev: PCI device to map IO resources for
diff --git a/include/linux/pci.h b/include/linux/pci.h
index 47b31ad724fa..7661f10913ca 100644
--- a/include/linux/pci.h
+++ b/include/linux/pci.h
@@ -2323,7 +2323,6 @@ void pcim_iounmap(struct pci_dev *pdev, void __iomem *addr);
 void __iomem * const *pcim_iomap_table(struct pci_dev *pdev);
 int pcim_request_region(struct pci_dev *pdev, int bar, const char *name);
 int pcim_iomap_regions(struct pci_dev *pdev, int mask, const char *name);
-void pcim_iounmap_regions(struct pci_dev *pdev, int mask);
 void __iomem *pcim_iomap_range(struct pci_dev *pdev, int bar,
 				unsigned long offset, unsigned long len);
 
-- 
2.48.1


