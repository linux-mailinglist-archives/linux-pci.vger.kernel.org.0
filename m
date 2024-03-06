Return-Path: <linux-pci+bounces-4567-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FED2873461
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:36:26 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 81D05B23EFD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:23:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 597A5604BA;
	Wed,  6 Mar 2024 10:22:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="woGPj7Pd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f52.google.com (mail-pj1-f52.google.com [209.85.216.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BEBDC5FDD2
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 10:22:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720553; cv=none; b=TMhmyI2wftC38t3G6jig/wCWfyxlabA7b68ZkuVtPlyNbM27HqFzVd5Xynyy9tNukcnKgu2Y1zdcC0CrBZ3eiP5GyZif+C/HD6blsjqjY5/9dqy5inZGA6Esmci4TRH05wtA8rns2c6vJo/73t9xxBcKlkdPAgA3tid1Jf/6CRc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720553; c=relaxed/simple;
	bh=GNg1QejkcoZ5fK4swcrLBbBe1IA73m5a3pHFG5FA1Sc=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fYO4xW+7F6yojZVTfT0truX0WBs99WmKV9MeMwNri7IyHwky3MHzeL+fSV2WcDgH32Wo6mwkJQ9/1TJ7rC4c3KAMriMfbzl2QerYnOtowFWbbAAXqwwOzRVxNO//QGPsXd3AYspeFhif2AY3A1/1MyAtUd0nEgtr2B6/X6LMzpo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=woGPj7Pd; arc=none smtp.client-ip=209.85.216.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f52.google.com with SMTP id 98e67ed59e1d1-29b7e284d31so10358a91.1
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 02:22:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709720551; x=1710325351; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=j3vP/5bP/RBlYdf1td9wb5cvuOaEn1shwa0DYeck2dA=;
        b=woGPj7PdacXtpER1hOxi5q02WFZJ1uF/v2a9o7FjHAyxzodwYAlPBkXOCCIKpDLJSk
         p5mnDp3EnVwYF7lfxqcnoS3h5KyyN5qzMds4kNPkkNgE52OWhYG//9fI5BW25URxe91C
         TGQPVSrvTgsQTggo7+ACG6+OFXUqRbIYtVxU/USRcRRPOWRpeQq3PIyFeGYCJZumlhin
         RvYJBILw1DHTN3+CVH+rxaEmFP8HBwl7LeuEPfC0LLwupIgEtDzmF+F4CztHE+SCBIGh
         j3g6qns2a12WOVwYP+2EIOnrSNculpKWHhQMug0GPQTYinBdwcLq6/p1Ta6oR4TMruNh
         fqPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720551; x=1710325351;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=j3vP/5bP/RBlYdf1td9wb5cvuOaEn1shwa0DYeck2dA=;
        b=KtgWhtIekrYFrqV9BWG4BiTnUinfXfTHhWOGCvtvNp8fnh2MqLRChXl1EmH9Do0yhX
         3dltz9FQRXZRjV/M9JPzYyeTnKqP9LhDlqYARVE92s3m0VR8vzS44g0sBuaMP+WWuWAl
         8Mk9jAnJfxFh7jmsbxVj3hTargqXRPOyIxgPC5bHbS3CTxAv7oYqulURiVhQZd+c7GdJ
         7xQIif4TCwAieLBz0lsHRbPokuya4sBzsnF6lJKsunRnr9J4HJDz4IN1nkcujpak16WA
         LOSmNo+Y97730CcqqnAd8fXt02GQCIVnCR9HJWsEX0ztk/5FTFwGttdBIlKgiYrOAric
         7bFQ==
X-Forwarded-Encrypted: i=1; AJvYcCWB3sDB6Tt12+0nCZeFdmvvDsiaZzJcYCEPL6JB21aFjYU6/C4WpVfXA6+kQ5fHL1ULlW0tMQGIXsKOuQww+fAaaZ4C8TVcOpJM
X-Gm-Message-State: AOJu0Ywy03efcOAb9hc5knsEMoW8cXdTU6ZodpUfl36sow/s/FsqpS/9
	xKR27aLt89QnhLFgWkMrBrbvudw87Cl6BkNQRgoI+feoTmev8qank6N+rBd64TJH/RvHmhM+X2I
	=
X-Google-Smtp-Source: AGHT+IFJWhLefxgpPBPNhLypUf8mUHiWTVtuXiQSlNKB7G0ZWFGQdWmy89hjVGzwR0VhVJGZhJklCA==
X-Received: by 2002:a17:90a:dd93:b0:29a:7579:88bc with SMTP id l19-20020a17090add9300b0029a757988bcmr11410022pjv.46.1709720550661;
        Wed, 06 Mar 2024 02:22:30 -0800 (PST)
Received: from [127.0.1.1] ([117.248.1.194])
        by smtp.gmail.com with ESMTPSA id li17-20020a17090b48d100b0029ab96b13ebsm13339320pjb.40.2024.03.06.02.22.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:22:30 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 06 Mar 2024 15:51:59 +0530
Subject: [PATCH v4 3/5] PCI: dwc: Pass the eDMA mapping format flag
 directly from glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-dw-hdma-v4-3-9fed506e95be@linaro.org>
References: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
In-Reply-To: <20240306-dw-hdma-v4-0-9fed506e95be@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=3424;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=GNg1QejkcoZ5fK4swcrLBbBe1IA73m5a3pHFG5FA1Sc=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl6EPQdbpcSFeeqHfUcnEzcW09XZpqMwjds4rW7
 ouUkY/9IMKJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZehD0AAKCRBVnxHm/pHO
 9d3JB/49m7E14UAaGxtNaUW/tGfbFfFeT7L9Hqxa5OvwPAi/pI5Oh2VrUZbziA/w+y5CL5y2uRq
 MfIhLMAbL4Bmiw3W+GTGLoZa1OpuxjLc8rB8nMJf8SHxRT4yrP7M6buZQ2keE1vpet7zl4IexM/
 b+DbyZvsMTgRg4bCCoFb388eVZiRUTEsVtwE0MFRwaoDmtJ+a9L3Vz3S05Et39FePV+70ySWySe
 TjADU8T3jb7KIirsSxu6Bht3kQtDeldVIdek/NRmQd+pwRbQTc7nPQgSF8i0CCD0aOHcsJV7UEV
 tH/A38ghBvN2d+OceSAfnqCYrnScGl3GuIgwg0w61wycWg7H
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
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 16 +++++++++-------
 drivers/pci/controller/dwc/pcie-designware.h |  5 ++---
 drivers/pci/controller/dwc/pcie-rcar-gen4.c  |  2 +-
 3 files changed, 12 insertions(+), 11 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 599991b7ffb2..c59b2876e5d4 100644
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


