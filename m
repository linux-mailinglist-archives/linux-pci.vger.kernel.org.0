Return-Path: <linux-pci+bounces-3808-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 9BA8285D09B
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 07:48:58 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 504601F25615
	for <lists+linux-pci@lfdr.de>; Wed, 21 Feb 2024 06:48:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 68E0D365;
	Wed, 21 Feb 2024 06:48:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="x//mPFVp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yb1-f201.google.com (mail-yb1-f201.google.com [209.85.219.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BF0032AEF1
	for <linux-pci@vger.kernel.org>; Wed, 21 Feb 2024 06:48:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.219.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708498135; cv=none; b=o36ySABufomA8bANpFhp/lwclPMp02w1XI51XLTKsL+s+g10YjoO5UXGuBo9lPLAJzAvbBfA1D2I1qvi+t7Prx1dkJgQPLvqFFHv2UZK5VT5U/53gqaIzYlspZfRc1/tTd11XKa4tlmOjH3pffMFadHdOsFlJvJ8hr5/ywfbtpU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708498135; c=relaxed/simple;
	bh=BDGDYH9wJiSifq+8//xD33twWExxvzXTI2wOkPNpnRA=;
	h=Date:Mime-Version:Message-ID:Subject:From:To:Cc:Content-Type; b=NQ3BiFPik9XuA+RLMHc3VrFcgWXBImh2WJUu69l3BitBkZAKRzl6I+XFBC+fiq1YXCVg/ilKHbLsLXgGDlE0ERgmg3AZSOVoMRbwGxiH2ayFti4DOslYERo6JZtCgA/4IIwjC6lnG7trzZ6KYZ1MddBj79KxZLOAYK9E9Fx41F0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com; dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b=x//mPFVp; arc=none smtp.client-ip=209.85.219.201
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yb1-f201.google.com with SMTP id 3f1490d57ef6-dc6ade10cb8so12785927276.0
        for <linux-pci@vger.kernel.org>; Tue, 20 Feb 2024 22:48:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1708498132; x=1709102932; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=myS5gegc6Qgw3BEET5j3eJcJ74V2mvOjiZUG7gcs3RY=;
        b=x//mPFVpPzw1lIpU8+LRQOnnkZ+rVB3/m9pRU2y4jZ6KFKKNpYuf8fXUjIfNw2yvRu
         1uDCr6k9pCH/FI7AIBj60xwS1rPo8Ul0XFvvRs1DKtPGIy8d9iuGZ4TPCzmcBIlqN5+e
         ILErKNxSsFH9MJrgRV+Q+V0Gz8RkRBxj2onFy3DToHsoOq4oBUz57zf7b9kBMWyY5XFp
         WztW0jcS1E9oSnrTYmsqQXWzYVvaBbstgZt2bmcZTZCm8ZQ4zpWfR8HuCJdoN7sTkfm5
         sWEX/zPEqsf66Uc7K/xclLe/7+iyTi4LuIqcDWCyZCwSFdj7AhjejBG6aq12Jv2NPh/N
         GzvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708498132; x=1709102932;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=myS5gegc6Qgw3BEET5j3eJcJ74V2mvOjiZUG7gcs3RY=;
        b=MacJjKOjxGoAEfowGpaYBqHp6D3srZwX3cUqK8TytmD2ZTpDdqiTM13NCg1Bc+Jfhs
         5XFJM5npMSSO0/njeENv4RevMYNuBOlsXVWVgIym0FZVFb3HFZGZV++M2psmT/5AWv8I
         pppkujHzzP6W+9cq4paxEIrk6d0lgo+oe3/Vv2SoVh55QzokqqaTsGprvXz3WS2/0Vf7
         kaufZ2xCvlyu+m4VirHQhwNTl4svNyvo4TS8f7bZ4las5B3qieJYq1Q16LR+LemoEQLC
         gIixPNOjqDWcy/YuhkJX0Jooyrf/kgW6TbLbQ9sRuJI4RmUZOqvv2jnSuNNGuwPrAfGk
         tGVQ==
X-Gm-Message-State: AOJu0YwcoBHFY5PrFGJg+U4SBdN14WISje1ZfmeqiaJt3tFRgi7ZOL+z
	iBqY56y540q3/lO8AXT+S7c33Ylrs9Tia7OVsVXktQfi2dirk3I80jEf1bxPW3imUxGqFTfFs3E
	Y1yFz5zd2ewB+M1TfYzgoUw==
X-Google-Smtp-Source: AGHT+IFgrn++Ekiw9zqyBXA8xmgdLmS/T4tJvaAPGtDqu1n9coBkxmnqkDJQ/N9hgq9dCOUJsnbs7x8OQYFjbRGHNQ==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:1584:0:b0:dcc:5463:49a8 with SMTP
 id 126-20020a251584000000b00dcc546349a8mr3708507ybv.6.1708498132741; Tue, 20
 Feb 2024 22:48:52 -0800 (PST)
Date: Wed, 21 Feb 2024 12:18:46 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.44.0.rc0.258.g7320e95886-goog
Message-ID: <20240221064846.3798047-1-ajayagarwal@google.com>
Subject: [PATCH v5] PCI: dwc: Strengthen the MSI address allocation logic
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

---
 .../pci/controller/dwc/pcie-designware-host.c | 21 ++++++++++++-------
 1 file changed, 14 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f..9c905e5c4904 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -379,15 +379,22 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
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
+		dev_warn(dev, "Failed to configure 32-bit MSI address. Devices with only 32-bit MSI support may not work properly\n");
+		ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(64));
+		if (!ret)
+			msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
+							GFP_KERNEL);
+
+		if (!msi_vaddr) {
+			dev_err(dev, "Failed to configure MSI address\n");
+			dw_pcie_free_msi(pp);
+			return -ENOMEM;
+		}
 	}
 
 	return 0;
-- 
2.44.0.rc0.258.g7320e95886-goog


