Return-Path: <linux-pci+bounces-3834-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBD3385E172
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 16:38:54 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 97F7B2866E0
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 15:38:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A0E1A80637;
	Wed, 21 Feb 2024 15:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="xsY1eNqF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f201.google.com (mail-yw1-f201.google.com [209.85.128.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0F4124F8AB
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 15:38:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708529927; cv=none; b=QaZ8CI/nD+uzThbU30dgkk1dCdZypnKxc3EgYdFgYCEfdZnNWXKkT4NUd78XwA/Eiy4ZvbNuLnTmwZWyZCN2RZeHxLlV+rX1YtKKWJJANo6xa84PPsrIkwIMBC2CBjJyeSxsnoPZcOdoLgz414JCcVN63zge+5b8vw+6jBU1908=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708529927; c=relaxed/simple;
	bh=78uzl1xDqzt83HAnsQfM4cddxbUW5UPndbC0TwFsBag=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=JgNSqBzfmiNSH9MxljTLt2GVFejmJ2O8YUgqRl5qXp7P4awUIXOD3REfyRXxgdgAuLcNIzB8nOudRPnxOe8wucBFXaUXm9wllT8if5M1PDBVJ4QWUuqEDAQ6vhYKaiYWTrfbEQ7knKPG7w2S5HYgOSiyeonMcIFggEC+URj7vrI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=xsY1eNqF; arc=none smtp.client-ip=209.85.128.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yw1-f201.google.com with SMTP id 00721157ae682-60886665c25so10582027b3.3
        for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 07:38:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708529925; x=1709134725; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=ZJ2tzyIr05rBncqLm2ZtihtyKMUWdNUwZ2jQddGgctk=;
        b=xsY1eNqFJR1wH8pYdUwKp/K4ajQqy+/wCpMykySJkvr4Sixl6+hnKKmiQLtG3rEN4i
         U4Ur7//G+QfNxXaDFS/e3IP8sl0kgVdvsqmwhtKNS/Y1g+Qr6LRBHSW+lX6+a4u6Y6uY
         T8MJKj5/ivBkvslb/HvMXNE9vYoxtaqrF5AxYlMmcCh+jDOYonqVh4g9uFVNvofic05Q
         fzf20mzuHt4x11PBNqSXGm+QrMqEYRGXp+wyC/tjl6GmB951K0zohKnJhoirGTfRaCXq
         fJQ5311fp9Ej2KEMdJmjxjDx+Oa1tMCrrDvK/oPVyD2Xf3sehXPrL8Pr3Q/eM2a85TTn
         6vUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708529925; x=1709134725;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJ2tzyIr05rBncqLm2ZtihtyKMUWdNUwZ2jQddGgctk=;
        b=XwnSwRXS+Nt6nSuwyVgL6DdEGwloGDXNXtBBqUPbxYVuguNPPOO+RWa7FJq3WlF0Io
         OI0LK9uUio5N0dF5EaoxvWzAjf3tC0DfMJQEMcppctoOCC5xjvd8yP+OHGI99qq8rRKb
         JK4qugSEiquGn5caFm3Zhtp3YU3rIIzwnB7QzsJsAnPBPhWrzoS8qUO7ArnOoAqP7Q9T
         B9uI9MqzrQXAzEY9PB/PmTZt7/lJIFXJ6asBYXY6hfBd3nWWtf3M4n3n0VtXUCg4vD+d
         qMD2l4EB28Oc95lJ12ljtfsM1VPjDsu68FfBrbnVA3AJulcsIDWXZlG7ad9/RK+IwxSU
         ALMA==
X-Gm-Message-State: AOJu0YzUb7mydkU85xNtGlKGCvUGGn5pB6v+qj5H8WA4XhKXaoToFmtd
	Z0uiA8uvfce4jrcwS9tjGXZxEmwW89o23xbQUYMPv5DVcADQVoUYK3XAGhlsp6pCoHJ9bXumiHN
	CcVrgp9rPaHb7ecSd0dv1hA==
X-Google-Smtp-Source: AGHT+IFJfUcKjLJvwCRgswmTN0pYef3vqFQ8plckdWdhO1jQ0hZOKpkTeHxtPGTpprSeSRsLQM8R1pCyrs9chFEDdw==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:c06:0:b0:dcc:e1a6:aca9 with SMTP
 id 6-20020a250c06000000b00dcce1a6aca9mr4899254ybm.9.1708529925073; Wed, 21
 Feb 2024 07:38:45 -0800 (PST)
Date: Wed, 21 Feb 2024 21:08:40 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221153840.1789979-1-ajayagarwal@google.com>
Subject: [PATCH v6] PCI: dwc: Strengthen the MSI address allocation logic
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>, Serge Semin <fancer.lancer@gmail.com>, 
	Robin Murphy <robin.murphy@arm.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

There can be platforms that do not use/have 32-bit DMA addresses.
The current implementation of 32-bit IOVA allocation can fail for
such platforms, eventually leading to the probe failure.

Try to allocate a 32-bit msi_data. If this allocation fails,
attempt a 64-bit address allocation. Please note that if the
64-bit MSI address is allocated, then the EPs supporting 32-bit
MSI address only will not work.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
Changelog since v5:
 - Initialize temp variable 'msi_vaddr' to NULL
 - Remove redundant print and check

Changelog since v4:
 - Remove the 'DW_PCIE_CAP_MSI_DATA_SET' flag
 - Refactor the comments and msi_data allocation logic

Changelog since v3:
 - Add a new controller cap flag 'DW_PCIE_CAP_MSI_DATA_SET'
 - Refactor the comments and print statements

Changelog since v2:
 - If the vendor driver has setup the msi_data, use the same

Changelog since v1:
 - Use reserved memory, if it exists, to setup the MSI data
 - Fallback to 64-bit IOVA allocation if 32-bit allocation fails

 .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++-------
 1 file changed, 13 insertions(+), 8 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f..d15a5c2d5b48 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -328,7 +328,7 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
-	u64 *msi_vaddr;
+	u64 *msi_vaddr = NULL;
 	int ret;
 	u32 ctrl, num_ctrls;
 
@@ -379,15 +379,20 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 * memory.
 	 */
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
-	if (ret)
-		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+	if (!ret)
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+						GFP_KERNEL);
 
-	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
-					GFP_KERNEL);
 	if (!msi_vaddr) {
-		dev_err(dev, "Failed to alloc and map MSI data\n");
-		dw_pcie_free_msi(pp);
-		return -ENOMEM;
+		dev_warn(dev, "Failed to allocate 32-bit MSI address\n");
+		dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+		msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+						GFP_KERNEL);
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to allocate MSI address\n");
+			dw_pcie_free_msi(pp);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
-- 
2.44.0.rc0.258.g7320e95886-goog


