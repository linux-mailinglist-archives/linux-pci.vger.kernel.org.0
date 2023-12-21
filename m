Return-Path: <linux-pci+bounces-1268-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0CF1A81BD73
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 18:41:06 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 99A1D1F2188B
	for <lists+linux-pci@lfdr.de>; Thu, 21 Dec 2023 17:41:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BFEF627F4;
	Thu, 21 Dec 2023 17:41:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vs75H476"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-yw1-f202.google.com (mail-yw1-f202.google.com [209.85.128.202])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B2AA3634E2
	for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 17:40:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=flex--ajayagarwal.bounces.google.com
Received: by mail-yw1-f202.google.com with SMTP id 00721157ae682-5e9a02c6d49so10041877b3.2
        for <linux-pci@vger.kernel.org>; Thu, 21 Dec 2023 09:40:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1703180458; x=1703785258; darn=vger.kernel.org;
        h=cc:to:from:subject:message-id:mime-version:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=uW7zaKbR6/kJ1BFDqlAleJ/jUW4EbTmTavCiNPY3Suc=;
        b=vs75H4763XWV9rdQVeklcjyGoLEq1LgIL3rfKhkgyHECQaHWawJSm/VRMam4+5NkwQ
         uj7BvD6jlXlg9FcRkJ/Y3pdu3FfWIfDGRMb+HIXYV13FcPtMbVNewIJEPwfHIbV0+LEc
         sMFNdVFru2Djf01khaeQuFvRdajd6Z9nDh0s67I/G8eviMWpm6hlBKaxfdNc/u3+NoN6
         y7xJWakQnmKoLV/C8zSi7BpLDObHex4lKEVfJpsJtvObuFOK6J8Q2iN6kSSk7w46BgFz
         I/g/DquyJ8Ngt4M1CPx88XHJm8CDjk2+BYnK3Hk4IDCiVH1m1TU6JDWMoZI2fXkNDHaS
         mINg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1703180458; x=1703785258;
        h=cc:to:from:subject:message-id:mime-version:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uW7zaKbR6/kJ1BFDqlAleJ/jUW4EbTmTavCiNPY3Suc=;
        b=YSQuHkYQumtfhswYZKHha16qC8aY7B3J6P2w91a5YPhDyh+thR2267dyOwc4Idx6Bd
         B+ZnD3BHFBP1gRYWvXBOr/mo928HQHFa8JyFnpISJ7YE5udQoO2+TqZrZnkASUm4zuyc
         gjRg7O9GQtcm47wv7wn7sHUkwGM4JR6xCGGzh8jXNCOtFtZfA8pm6U53XD04DzlDyS1l
         bckXezLxn+i3otMiC8MqM6WtM4JSmDy7vYrwzcoIobcNjtixxHs4Z/ly7DtLaKdMni4L
         NNTsWyR0ivlVtDzgqoSrJBOCRZEGJitb/x8jNq/OG6940ChdT/HNFIsxocpb88Em5jVt
         6Mhg==
X-Gm-Message-State: AOJu0YzWMhpu43OvPvf/O4XulfBie+HzzB5J1NQJfLMqixkP5EwvXVe7
	xdmiwD7NUsZH3Oq+gJHMM0AZvLOjNrFlczZnsoe2s5Zf
X-Google-Smtp-Source: AGHT+IE1GVCzIsnelV8o4YSycdjmwsydBt2k3p9jHg1xE+/Nbl4P27yqOcLqj4H+oPqJ3iV5vJht6/5vkiMQQKoe2A==
X-Received: from ajaya.c.googlers.com ([fda3:e722:ac3:cc00:4f:4b78:c0a8:39b5])
 (user=ajayagarwal job=sendgmr) by 2002:a25:84c5:0:b0:dbd:ae61:8dd2 with SMTP
 id x5-20020a2584c5000000b00dbdae618dd2mr22819ybm.4.1703180458742; Thu, 21 Dec
 2023 09:40:58 -0800 (PST)
Date: Thu, 21 Dec 2023 23:10:51 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
Mime-Version: 1.0
X-Mailer: git-send-email 2.43.0.195.gebba966016-goog
Message-ID: <20231221174051.35420-1-ajayagarwal@google.com>
Subject: [PATCH] PCI: dwc: Set DMA mask to 32 only if ZONE_DMA32 is enabled
From: Ajay Agarwal <ajayagarwal@google.com>
To: Jingoo Han <jingoohan1@gmail.com>, Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
	Manivannan Sadhasivam <mani@kernel.org>, Lorenzo Pieralisi <lpieralisi@kernel.org>, 
	"=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=" <kw@linux.com>, Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
	Manu Gautam <manugautam@google.com>, Sajid Dalvi <sdalvi@google.com>, 
	William McVicker <willmcvicker@google.com>
Cc: linux-pci@vger.kernel.org, Ajay Agarwal <ajayagarwal@google.com>
Content-Type: text/plain; charset="UTF-8"

If CONFIG_ZONE_DMA32 is disabled, then the dmam_alloc_coherent
will fail to allocate the memory if there are no 32-bit addresses
available. This will lead to the PCIe RC probe failure.
Fix this by setting the DMA mask to 32 bits only if the kernel
configuration enables DMA32 zone. Else, leave the mask as is.

Signed-off-by: Ajay Agarwal <ajayagarwal@google.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 7991f0e179b2..163a78c5f9d8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -377,10 +377,17 @@ static int dw_pcie_msi_host_init(struct dw_pcie_rp *pp)
 	 * Note until there is a better alternative found the reservation is
 	 * done by allocating from the artificially limited DMA-coherent
 	 * memory.
+	 *
+	 * Set the coherent DMA mask to 32 bits only if the DMA32 zone is
+	 * supported. Otherwise, leave the mask as is.
+	 * This ensures that the dmam_alloc_coherent is successful in
+	 * allocating the memory.
 	 */
+#ifdef CONFIG_ZONE_DMA32
 	ret = dma_set_coherent_mask(dev, DMA_BIT_MASK(32));
 	if (ret)
 		dev_warn(dev, "Failed to set DMA mask to 32-bit. Devices with only 32-bit MSI support may not work properly\n");
+#endif
 
 	msi_vaddr = dmam_alloc_coherent(dev, sizeof(u64), &pp->msi_data,
 					GFP_KERNEL);
-- 
2.43.0.195.gebba966016-goog


