Return-Path: <linux-pci+bounces-4871-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 93D2387E37D
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 07:05:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 15B9D1F22010
	for <lists+linux-pci@lfdr.de>; Mon, 18 Mar 2024 06:05:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B8A2D21A0B;
	Mon, 18 Mar 2024 06:05:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KLbBSrrt"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oa1-f44.google.com (mail-oa1-f44.google.com [209.85.160.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49933241E9
	for <linux-pci@vger.kernel.org>; Mon, 18 Mar 2024 06:05:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.160.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710741903; cv=none; b=MBILFRtbfWCKM94E8qvEj8jU8dq4yJhfhvx3H2ADA+yAx5N6oXtPqcanxPsJtiNSaxwpu36G0AWQMNIuohqKUrUoMfQtx874j8GyVx9Ivi5K8Ucq5Kb2Wa6rLIDz38ENsjo6R2qjleWeQJIcqS1kNKr66dElUmawhSZZe1d5Amo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710741903; c=relaxed/simple;
	bh=9518uHzusyON6/l8nq/MDsZdIIENA/vpevyIO/YKQtM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DnWktcYOsf3JNTayVqajzjsqKoZnCPZEqHmu6fPPNN0U7a6PjmsAkySR1XtdpKLCsX4GsYtZU6biVsPY9nZPUpgrpsiGtr3NdLgG9Ru7xQGiAxCV0DGIjYmPzRF2tKWDXf2UT5M+byvJ18U8SH9SPmKp7vkpFcZME1D4hLYJNO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KLbBSrrt; arc=none smtp.client-ip=209.85.160.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oa1-f44.google.com with SMTP id 586e51a60fabf-2226572ccf8so2424018fac.2
        for <linux-pci@vger.kernel.org>; Sun, 17 Mar 2024 23:05:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710741900; x=1711346700; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0yRbfrtGodMgh0b1jsGPT/HtG/b0h984WzovY5fb59Q=;
        b=KLbBSrrtjxHMxadwfiP2n67nLK7f2bTNp3hayQuhqIlxS4V6MVucRz57A80v74StoP
         U1UmgttrEPLZ6mfjQ7Ik9z3ehqc65XmN/RGur1z3+B3o9Eh4d2yAi4bsxF8s8Uq2lV/X
         sewFpaTyLsmKaNrDLWt232VhPJNkHNnIvftQtT/eYX25H5Yci+XOR8XlorhaShw7slRT
         UjFDmHK27eMklijAqT4mD1IdYmCeY4zTDYY12CFir+2snatlV+Ti06wAuDXWajbkw1Bm
         ztUmbt0VHrdUMg3whwHQnAK3MSNnv9oeTw8V8BdAmtNDWlLvbndAuTCMIObxRzLjfuWz
         2xMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710741900; x=1711346700;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0yRbfrtGodMgh0b1jsGPT/HtG/b0h984WzovY5fb59Q=;
        b=PLFk8ZYRUWJimDkafsepGb7WVHY1WVWa4ujKMZd4C5V3z9T3poCbWMXA97aEt77fbX
         ZER0pFfENleaIZS/DXt8mMuwKJZy6ED9TI/YChXEFqQkNrkXcWR1CfU3yj6/84bMOpZM
         n3PfxStacr4aca5TmNSHT3Qq0b/NiEPg5D9d6F4vYmBLbMsa5J+KIKd9pLGQHTgXT840
         Zlsmr9St4VVPB1N8eLTrMGdr+kv1CagKIW7OpdtHYO1mHgllZjfHpsWwD4U6nzrNuYhi
         2gm6epsApDjhzc2HkpSOw9bhrIEQNJ7d+nLCuUIAnG/5S7qCmzSKzsmfKBCfafa1Qjn3
         kmSg==
X-Forwarded-Encrypted: i=1; AJvYcCWWld8jNI2pQ5kMx1gYAZXbzwr+jDo33XKqu1DU/X5aQcSvsLKzvdNgzG6qu71L716C462ryd3fGkgSNweCPvL1qJploeSGBZPi
X-Gm-Message-State: AOJu0YxzUmg7g04pgWjk7GUTgjntTpkU+2Yn+huvUvzfWQ0qoLQwjRP/
	OiVUU/KTPmcPVzl+jpMs72mkdYubwxysohWAZ9Vks/ppIV94LNo4jyRM4dzEAA==
X-Google-Smtp-Source: AGHT+IGQZwlDaHoltTPhUcJ96E1ip9uvx1Y9JtU+ExnuHdoV9TaLgVvUv8H6XU03UqLdku0Glhc5lQ==
X-Received: by 2002:a05:6871:806:b0:221:bf34:b15f with SMTP id q6-20020a056871080600b00221bf34b15fmr14076502oap.25.1710741900223;
        Sun, 17 Mar 2024 23:05:00 -0700 (PDT)
Received: from [127.0.1.1] ([103.246.195.160])
        by smtp.gmail.com with ESMTPSA id p12-20020a62ab0c000000b006e6c5b065f5sm7064268pff.28.2024.03.17.23.04.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 17 Mar 2024 23:04:59 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 18 Mar 2024 11:34:27 +0530
Subject: [PATCH v5 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240318-dw-hdma-v5-3-f04c5cdde760@linaro.org>
References: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>
In-Reply-To: <20240318-dw-hdma-v5-0-f04c5cdde760@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: Serge Semin <fancer.lancer@gmail.com>, linux-pci@vger.kernel.org, 
 linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org, 
 linux-arm-msm@vger.kernel.org, mhi@lists.linux.dev, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=3556;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=9518uHzusyON6/l8nq/MDsZdIIENA/vpevyIO/YKQtM=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl99l3cQIzisYTJQE0dpD5oKtzUZ1SIG/Md2u40
 Te6mGwymRmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZffZdwAKCRBVnxHm/pHO
 9U4jCACguisPhjy3I+ZTNmElskawN57F8pvuIgJ2jbhjwAJNpgu31klSut6VIGivY8AwXhhkUdC
 iSS3b4n0eNDpbiXQz1uJDF2SIZyVEliGIaiF4LqIZqEsLd2wn9x1+P4WRMlJKHpzKgbbGuYkPnb
 TvBKA/hYXxL16vvKI0mp0p666DOqyM/JrMiw67IsapvP/igeqpUwTOkzGET3touNIWcSR+BEKvQ
 2GlZoOkhQDC27UefiBjL2+Ctdfw36hEY6Z4zLrWq5ABUvJ1u7P/ybF80E8fTz1COTi9EPEGIZ7N
 2bmsmcrK0TxUQ3pcOMFJRyLi2ef/COhLmjD1Q8UFgvkMl8bb
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Instead of maintaining a separate capability for glue drivers that cannot
support auto detection of the eDMA mapping format, let's pass the mapping
format directly from them.

This will simplify the code and also allow adding HDMA support that also
doesn't support auto detection of mapping format.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Tested-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index d17549f67e72..bf57a2f713da 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -894,18 +894,20 @@ static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
 {
 	u32 val;
 
+	/*
+	 * Bail out finding the mapping format if it is already set by the glue
+	 * driver. Also ensure that the edma.reg_base is pointing to a valid
+	 * memory region.
+	 */
+	if (pci->edma.mf != EDMA_MF_EDMA_LEGACY)
+		return pci->edma.reg_base ? 0 : -ENODEV;
+
 	/*
 	 * Indirect eDMA CSRs access has been completely removed since v5.40a
 	 * thus no space is now reserved for the eDMA channels viewport and
 	 * former DMA CTRL register is no longer fixed to FFs.
-	 *
-	 * Note that Renesas R-Car S4-8's PCIe controllers for unknown reason
-	 * have zeros in the eDMA CTRL register even though the HW-manual
-	 * explicitly states there must FFs if the unrolled mapping is enabled.
-	 * For such cases the low-level drivers are supposed to manually
-	 * activate the unrolled mapping to bypass the auto-detection procedure.
 	 */
-	if (dw_pcie_ver_is_ge(pci, 540A) || dw_pcie_cap_is(pci, EDMA_UNROLL))
+	if (dw_pcie_ver_is_ge(pci, 540A))
 		val = 0xFFFFFFFF;
 	else
 		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 26dae4837462..995805279021 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -51,9 +51,8 @@
 
 /* DWC PCIe controller capabilities */
 #define DW_PCIE_CAP_REQ_RES		0
-#define DW_PCIE_CAP_EDMA_UNROLL		1
-#define DW_PCIE_CAP_IATU_UNROLL		2
-#define DW_PCIE_CAP_CDM_CHECK		3
+#define DW_PCIE_CAP_IATU_UNROLL		1
+#define DW_PCIE_CAP_CDM_CHECK		2
 
 #define dw_pcie_cap_is(_pci, _cap) \
 	test_bit(DW_PCIE_CAP_ ## _cap, &(_pci)->caps)
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index e9166619b1f9..3c535ef5ea91 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -255,7 +255,7 @@ static struct rcar_gen4_pcie *rcar_gen4_pcie_alloc(struct platform_device *pdev)
 	rcar->dw.ops = &dw_pcie_ops;
 	rcar->dw.dev = dev;
 	rcar->pdev = pdev;
-	dw_pcie_cap_set(&rcar->dw, EDMA_UNROLL);
+	rcar->dw.edma.mf = EDMA_MF_EDMA_UNROLL;
 	dw_pcie_cap_set(&rcar->dw, REQ_RES);
 	platform_set_drvdata(pdev, rcar);
 

-- 
2.25.1


