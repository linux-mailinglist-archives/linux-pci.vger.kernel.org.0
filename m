Return-Path: <linux-pci+bounces-2025-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3FD8A82A6EE
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 05:21:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B7D3B1F23113
	for <lists+linux-pci@lfdr.de>; Thu, 11 Jan 2024 04:21:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 479A91110;
	Thu, 11 Jan 2024 04:21:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Ln+aJbhW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AAE971C16
	for <linux-pci@vger.kernel.org>; Thu, 11 Jan 2024 04:21:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-daee86e2d70so4805490276.0
        for <linux-pci@vger.kernel.org>; Wed, 10 Jan 2024 20:21:18 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1704946877; x=1705551677; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=qz/GZxn/tF2hILBwKLuyHCzoLVGu5jQ5y24x4/ztoE0=;
        b=Ln+aJbhWM5Ew8rTxpEjrj4dshe8Te94uTrkeX3ap/1el9hVEfH4hhTkHSWz51e2PYn
         Agxz57LmiH0wqzYOwiyifiXka/OBd6BQ3vLrXl0AxpWGO3iPtDl2Ax3VNjTx6pt1BU9t
         uP/n+LUQsrmkKCpkYi86jAvEqtsuYin6CXZqPukhZ5z0xXMhMh3VB5Ch8aaWwpVwO0en
         PUMe5E5mvmmGYw/HDkHEfq6FhAHURn1ZcL9Jf35Rl6UeRY9VjK4yi5HdxJrlBP0t/R1i
         75TLvXXYm9e8pnzt33+LINNtqcO0xzQmPfe6zhO48c545xaEATs4oW6V8ZWUaWy+OjJL
         Sjfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704946877; x=1705551677;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qz/GZxn/tF2hILBwKLuyHCzoLVGu5jQ5y24x4/ztoE0=;
        b=V0Tr33URY1L53lC+zBBv3UqXhm/MaBg7lOcmgCn0TyufYTjDhPvgmZzdFv+qJt0Tnj
         wI4Z42FaNbZfm6/o25SM/zSG80aH9y/H1eSRB1oCPrXnOUY/Jma1sp85E00vQ6/rDg0u
         u8hWhQ5eXf7JVVpvmvtrfHCVzurMyGhIE9jaY2GiQgad00qf+zCCse43FGdga9leJigS
         SJOY3rfDIG8mtgxKgs5/SW5fYnOvcDftk49pBKcIqQ9PCiUfgZvnvBvVRbxJENI12yFQ
         l6uBIk6fC1F/wkNKNw76iQw7Mi2OgDyCEvjp+pQVoh/mxSVQvho5LJw7s8qq1Zs2loz9
         hNFQ==
X-Gm-Message-State: AOJu0YxELLaduorb3w1oSb/G5yER7lIyHtq+VC3ziw8C1e3KZf5WK4E0
	jWgICtuDLvtUaTgLy7wgOWqTA3FNllSRDG6cTg6iIhgi
X-Google-Smtp-Source: AGHT+IF89szsak9qybJv5h97LNMEDP0yOWC0C+A95Hm+xu7LWqsPg7PukGGHVoXLvxwaUImAYpW7w7pJv0wZ3aning==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:abb1:0:b0:dbe:d0a9:2be8 with SMTP
 id v46-20020a25abb1000000b00dbed0a92be8mr23603ybi.0.1704946877609; Wed, 10
 Jan 2024 20:21:17 -0800 (PST)
Date: Thu, 11 Jan 2024 09:51:03 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.275.g3460e3d667-goog
Message-ID: <20240111042103.392939-1-ajayagarwal@google.com>
Subject: [PATCH v2] PCI: dwc: Strengthen the MSI address allocation logic
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

If there is a memory region reserved for the pci->dev, pick up
the MSI data from this region. This can be used by the platforms
described above.

Else, if the memory region is not reserved, try to allocate a
32-bit IOVA. Additionally, if this allocation also fails, attempt
a 64-bit allocation for probe to be successful. If the 64-bit MSI
address is allocated, then the EPs supporting 32-bit MSI address
will not work.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v1:
 - Use reserved memory, if it exists, to setup the MSI data
 - Fallback to 64-bit IOVA allocation if 32-bit allocation fails

 .../pci/controller/dwc/pcie-designware-host.c | 50 ++++++++++++++-----
 drivers/pci/controller/dwc/pcie-designware.h  |  1 +
 2 files changed, 39 insertions(+), 12 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7991f0e179b2..8c7c77b49ca8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -331,6 +331,8 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	u64 *msi_vaddr;
 	int ret;
 	u32 ctrl, num_ctrls;
+	struct device_node *np;
+	struct resource r;
 
 	for (ctrl = 0; ctrl < MAX_MSI_CTRLS; ctrl++)
 		pp->irq_mask[ctrl] = ~0;
@@ -374,20 +376,44 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 * order not to miss MSI TLPs from those devices the MSI target
 	 * address has to be within the lowest 4GB.
 	 *
-	 * Note until there is a better alternative found the reservation is
-	 * done by allocating from the artificially limited DMA-coherent
-	 * memory.
+	 * Check if there is memory region reserved for this device. If yes,
+	 * pick up the msi_data from this region. This will be helpful for
+	 * platforms that do not use/have 32-bit DMA addresses but want to use
+	 * endpoints which support only 32-bit MSI address.
+	 * Else, if the memory region is not reserved, try to allocate a 32-bit
+	 * IOVA. Additionally, if this allocation also fails, attempt a 64-bit
+	 * allocation. If the 64-bit MSI address is allocated, then the EPs
+	 * supporting 32-bit MSI address will not work.
 	 */
-	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
-	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+	np = of_parse_phandle(dev->of_node, "memory-region", 0);
+	if (np) {
+		ret = of_address_to_resource(np, 0, &r);
+		if (ret) {
+			dev_err(dev, "No memory address assigned to the region\n");
+			return ret;
+		}
 
-	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-					GFP_KERNEL);
-	if (!msi_vaddr) {
-		dev_err(dev, "Failed to alloc and map MSI data\n");
-		dw_pcie_free_msi(pp);
-		return -ENOMEM;
+		pp->msi_data = r.start;
+	} else {
+		dev_dbg(dev, "No %s specified\n", "memory-region");
+		ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
+		if (ret)
+			dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+						GFP_KERNEL);
+		if (!msi_vaddr) {
+			dev_warn(dev, "Failed to alloc 32-bit MSI data. Attempting 64-bit now\n");
+			dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+							GFP_KERNEL);
+		}
+
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to alloc and map MSI data\n");
+			dw_pcie_free_msi(pp);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 55ff76e3d384..c85cf4d56e98 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -317,6 +317,7 @@ struct dw_pcie_rp {
 	phys_addr_t		io_bus_addr;
 	u32			io_size;
 	int			irq;
+	u8			coherent_dma_bits;
 	const struct dw_pcie_host_ops *ops;
 	int			msi_irq[MAX_MSI_CTRLS];
 	struct irq_domain	*irq_domain;
-- 
2.43.0.275.g3460e3d667-goog


