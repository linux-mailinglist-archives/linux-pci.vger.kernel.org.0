Return-Path: <linux-pci+bounces-3068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C8A46848D20
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 12:24:51 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 27F85B218E5
	for <lists+linux-pci@lfdr.de>; Sun,  4 Feb 2024 11:24:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C56F3219EB;
	Sun,  4 Feb 2024 11:24:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="R3GDWnKM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f202.google.com (mail-yb1-f202.google.com [209.85.219.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 277572230C
	for <linux-pci@vger.kernel.org>; Sun,  4 Feb 2024 11:24:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.202
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707045884; cv=none; b=QlsD9sqxwaFs2Ij/tjrcSa7rLRlX7YEArZraihFXuQ6gA8hmvLiXDIouBZLQfxxqY/qexCbQ3nzTpjvYDELO4Yv8gIglz8Xx3pxjsPl4E/KkdBJiGAgc+H1RnzMCx1JpS+4aSQ/2TkyOsFn3x+F/DOQCf73tYPRISCx8uQJ9BdM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707045884; c=relaxed/simple;
	bh=3YMkJ3/U5jHiJnbEXC+x9HrR/wgi1y/VDM0eb88kaYg=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=dgN5SVXYa0ga0w5xMiVFgsuRoLEB8QM8XzHzcMRv6xMbuDCkhdfCLhoUzvNaIgetytvk1v8IienQcJzFu15V7wvrLx+TfOmTde6pLcqY8wtsg3FeXKRfE1TgTcGCQL38dHkPcyH+yrMudLnzHrPeJd618R/F8Pb3VF9n8UX0+0A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=R3GDWnKM; arc=none smtp.client-ip=209.85.219.202
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yb1-f202.google.com with SMTP id 3f1490d57ef6-dc6ba69e803so6002756276.2
        for <linux-pci@vger.kernel.org>; Sun, 04 Feb 2024 03:24:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1707045882; x=1707650682; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6bmVoePft+RwUxr61hOdSqiODUKNKhjiuspLfMzOBBM=;
        b=R3GDWnKMOGWPt/hZlZfSHvdEqA+h//cjnqFP8WiS1oSTISsdzyuSdTkFY7h0Tu8FBr
         3HN7yMD7OeSe2YPyvzOKfI4/t/0mBTCGEKfMVjyeA2awAiWjRaXS2K/nTtkWMTDlC4eN
         BLEhSlXEDhYgEzXlKeQiw12IyK4Sf2yhl8gvl6JaBzTj+TkA6Qs+ZtrEvmNVo1vAbjAR
         ZP09Uet45gTYmgHqT/uRkv232VVDJJzOmyLP9y7if4K7BgdXuym0wTIUvNEDUoafndP5
         gvjoeh63cn3tbEsFF3aJNOwC7hP/KkvdpND1xlxhU5yDqvEHT9YeKDL/xv1HOsl5DZDi
         hdaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707045882; x=1707650682;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6bmVoePft+RwUxr61hOdSqiODUKNKhjiuspLfMzOBBM=;
        b=A02jOirRvFqW8UEJbeF3dcoEGO7ZAKC4kfyNr4wubJiT2QOB9N0VD2ewS25zPv8cmA
         LpvLqPL3IyVu2aGwzKVS9CRjg1xt2znA/v26Nl5fsHkzLodkt4zdMD6E4Jlzux+2BFa9
         JxoEacAqUjHPtQ1s1C9UvEZu+FqGmCXf7r8Pl88WqF2xeqe1c3LxBPF5Vs+GKjJHqnOc
         46Yu1NZPYON9d0OLmyN/MNln/PGjyttJ6L08SpQM+7nkw9VcZwka2czvNPRp4OqLq7Mv
         XzuOXrRE0pRjVinME9Q1rU9FHifmUKG6MHycV7HtEcbYf0RB4qf8hbG6D1pGGRfIGeqO
         eETg==
X-Gm-Message-State: AOJu0Yw9c2fyuLzWkXpfeY7gerCBXuaODh9p4kJW2WQN+3cZDRIQrN0E
	Uc4oR0LyAwtFZnPp1ju9TR5jOkpwS8LyrvMKi+iWj8h+LebYH+YTvRa1hWWC77tzAmcMJS/ztue
	1Xl+erDTCPQWpzcEJYmDbGg==
X-Google-Smtp-Source: AGHT+IErtOzosb9Pv01qSPEXwxRelgy+P2wMkzAIWsHdmu6XnZkGmUQ4vCtDaOwGChJ65AkQgVfiWe8VUBftg8ku/Q==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a05:6902:200a:b0:dc2:3441:897f with
 SMTP id dh10-20020a056902200a00b00dc23441897fmr2011144ybb.6.1707045882059;
 Sun, 04 Feb 2024 03:24:42 -0800 (PST)
Date: Sun,  4 Feb 2024 16:54:25 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.594.gd9cf4e227d-goog
Message-ID: <20240204112425.125627-1-ajayagarwal@google.com>
Subject: [PATCH v3] PCI: dwc: Strengthen the MSI address allocation logic
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

There can be platforms that do not use/have 32-bit DMA addresses
but want to enumerate endpoints which support only 32-bit MSI
address. The current implementation of 32-bit IOVA allocation can
fail for such platforms, eventually leading to the probe failure.

If there vendor driver has already setup the MSI address using
some mechanism, use the same. This method can be used by the
platforms described above to support EPs they wish to.

Else, if the memory region is not reserved, try to allocate a
32-bit IOVA. Additionally, if this allocation also fails, attempt
a 64-bit allocation for probe to be successful. If the 64-bit MSI
address is allocated, then the EPs supporting 32-bit MSI address
will not work.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v2:
 - If the vendor driver has setup the msi_data, use the same

Changelog since v1:
 - Use reserved memory, if it exists, to setup the MSI data
 - Fallback to 64-bit IOVA allocation if 32-bit allocation fails

 .../pci/controller/dwc/pcie-designware-host.c | 26 ++++++++++++++-----
 1 file changed, 20 insertions(+), 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f..512eb2d6591f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -374,10 +374,18 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 * order not to miss MSI TLPs from those devices the MSI target
 	 * address has to be within the lowest 4GB.
 	 *
-	 * Note until there is a better alternative found the reservation is
-	 * done by allocating from the artificially limited DMA-coherent
-	 * memory.
+	 * Check if the vendor driver has setup the MSI address already. If yes,
+	 * pick up the same. This will be helpful for platforms that do not
+	 * use/have 32-bit DMA addresses but want to use endpoints which support
+	 * only 32-bit MSI address.
+	 * Else, if the memory region is not reserved, try to allocate a 32-bit
+	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
+	 * allocation. If the 64-bit MSI address is allocated, then the EPs
+	 * supporting 32-bit MSI address will not work.
 	 */
+	if (pp->msi_data)
+		return 0;
+
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
@@ -385,9 +393,15 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
 					GFP_KERNEL);
 	if (!msi_vaddr) {
-		dev_err(dev, "Failed to alloc and map MSI data\n");
-		dw_pcie_free_msi(pp);
-		return -ENOMEM;
+		dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+						GFP_KERNEL);
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to alloc and map MSI data\n");
+			dw_pcie_free_msi(pp);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
-- 
2.43.0.594.gd9cf4e227d-goog


