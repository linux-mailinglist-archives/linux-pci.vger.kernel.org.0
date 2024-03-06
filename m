Return-Path: <linux-pci+bounces-4565-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EFA938733F9
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:22:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1ED911C20A9F
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:22:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 035985FEED;
	Wed,  6 Mar 2024 10:22:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="oot7RUnv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f49.google.com (mail-pj1-f49.google.com [209.85.216.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 63B015FDCC
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 10:22:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720542; cv=none; b=isYZTyixv0xujjUaIvWI/pfXVrZ1/GdYOm2eeey4AIAqzK8pzpkdIKoWsjEFn0+bkdIHCTaju2IQsK/euv3kx3rOX5ZxvMmSBJJPkO/EZB2j53GnZnG1WYrBG7/wkeVD/QTGNgf9VxTo+4dQUaQskTVKGeK3RUrRAwWIIxcJN8o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720542; c=relaxed/simple;
	bh=xjis6bKP+1qp95+QiF0S2jYEGfXq9eU6iywX/YRTDxg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Q6OlHNTZVbLy45T64ojyN6554HpUfnO+iumDyXghYeGiiTYVrbn7ZGqwFuhx50wc8HWMqO6FrABWCZc5oVm8qY+70N90sunpO4JIt/wFjTpESkTFksnRFWO8vCbhkOSDkW1iEXEoqplR5qFi+sAmEIfLlbx0On172NVYxaTNTJk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=oot7RUnv; arc=none smtp.client-ip=209.85.216.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f49.google.com with SMTP id 98e67ed59e1d1-29a2d0f69a6so4782888a91.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 02:22:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709720540; x=1710325340; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ppuKC79JHtsiaCtvi79gYVIVwf6hwtDNoJlhOkIniKM=;
        b=oot7RUnvomiyXGGUmGTWxnSqeYcizhG3usVWtCeDg6EpeTO5zj1sBG4e4dvgVUn7j3
         dHChob1A4PC/IC5nloXZ++OpoHiCkATNfIUV+k1JyXFN6bRlgoL/4ihPFNnxvwiZtIoE
         VX6Y9xP4n43maOtYlXfbuNVYAiXgfZtzpVhMsFPBU8kIRxLlVSQHRDocsm2BKCg2cXPl
         iEwsoS+AcczpeVUUzqdSFpjt39cVyPeTdGJ5ffRXxE3b17inYjT8DJcxE0DCeEGKP+zA
         GAe5TVnnFFBYzlsKDEiaO5ETAskKYxOLLYP1p+b3SDTxRDcAUJmkrsOi0o+Y/txrAS46
         WVsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720540; x=1710325340;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ppuKC79JHtsiaCtvi79gYVIVwf6hwtDNoJlhOkIniKM=;
        b=flz3Uvc/QxSSWJLmFcfBGCNwhopZ18SxpzsjXKmNbKjWj6FwjXgYx8gXNbvxUDlkHN
         TGQr1ZqmUSynChO6aWNxMkD9M8XhXt3Yex+Qr0kVXlpN1G56YGAc4sKUqEw+B9PsvgfQ
         dFY4+q9erCIz6Qg+575XN4MXMlLJCs66Lp2565xu0PIeM6IsDm7J6a3CbvasTlP8K5od
         qpYgQRKA+PLTspmOds7vPK3Ua1f6ItsO9u7QO9ZSu32bWnYJiZfl+YBEivWPoULJMpDJ
         B9Atu0btyCZ2bsMxCcrId0AyvrIO3sLY/zh/KHnlCKGdxRn7dqF2SeigRl3X/q9go4Vp
         2oaQ==
X-Forwarded-Encrypted: i=1; AJvYcCWFt8H3VOezaQYL435rJY8dzLpNRq9pjsP1dEwUl+lqx70AOVflv6uEQ8lxKd7bSMD/6fTIn/mgiMasnxK5vu8JvbhE99iA4348
X-Gm-Message-State: AOJu0Yx3OcylMYtYvFVxBp0ZLrHs/u/CqhDnR1FZ6CGZ01hxlHOFhH6Y
	zMJeytXSCvAmQPRGnXUCF5sdhVGdIX6HhFXS9ZQTGoZeTJBFhn1XjLCWJf40NwPiq8Gcfr7Cr5A
	=
X-Google-Smtp-Source: AGHT+IFnKd8zFG4FFkLPf5dnns/XQ6pv6ANmuWXMoq4yyl1z0WtB5YT7/cysYBZYGxR1ZhS70S8+0Q==
X-Received: by 2002:a17:90a:ca8e:b0:29b:4dfc:710b with SMTP id y14-20020a17090aca8e00b0029b4dfc710bmr7862034pjt.28.1709720540330;
        Wed, 06 Mar 2024 02:22:20 -0800 (PST)
Received: from [127.0.1.1] ([117.248.1.194])
        by smtp.gmail.com with ESMTPSA id li17-20020a17090b48d100b0029ab96b13ebsm13339320pjb.40.2024.03.06.02.22.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:22:19 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 06 Mar 2024 15:51:57 +0530
Subject: [PATCH v4 1/5] PCI: dwc: Refactor dw_pcie_edma_find_chip() API
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-dw-hdma-v4-1-9fed506e95be@linaro.org>
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
 Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2666;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=xjis6bKP+1qp95+QiF0S2jYEGfXq9eU6iywX/YRTDxg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl6EPQZYQ7XCCOMknukdVYfL87jQ5oeOCLcgbMh
 Gxe1UwQzA2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZehD0AAKCRBVnxHm/pHO
 9e3CB/9thwGh4M1yb5s6awK8BCruwq7nQy2+QdrPvMtxU9se6LakPl3/a+HfykMFDkeU0oy8OYd
 92/K35muS3jQ4OTWAkaIIGbrm/0cs+VCfXwkom3xHEk6KBK9g3ORDZKI46JrTplcE0WXxbitbca
 rTa9S3gqc7kHv5oWPB4TxvnWw+Oh8S65767iNU7Z3e7e2QFsbEjSU5L5ETar348B5/d6JS/12tZ
 6VwVZlna0k7+Zg5tbbVvlq4s6xcdpoDJsMVJjjcFbvGVwq8UualWrUCJ7xd/J634UCH6GZph597
 FOQfFfR3AfuxUYAa2GddMrOiBawCEGdVQkrnA6GXMFS1ZzB5
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

In order to add support for Hyper DMA (HDMA), let's refactor the existing
dw_pcie_edma_find_chip() API by moving the common code to separate
functions.

No functional change.

Suggested-by: Serge Semin <fancer.lancer@gmail.com>
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.c | 40 +++++++++++++++++++++++-----
 1 file changed, 33 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 250cf7f40b85..3a26dfc5368f 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -880,7 +880,17 @@ static struct dw_edma_plat_ops dw_pcie_edma_ops = {
 	.irq_vector = dw_pcie_edma_irq_vector,
 };
 
-static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
+static void dw_pcie_edma_init_data(struct dw_pcie *pci)
+{
+	pci->edma.dev = pci->dev;
+
+	if (!pci->edma.ops)
+		pci->edma.ops = &dw_pcie_edma_ops;
+
+	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+}
+
+static int dw_pcie_edma_find_mf(struct dw_pcie *pci)
 {
 	u32 val;
 
@@ -902,8 +912,6 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 
 	if (val == 0xFFFFFFFF && pci->edma.reg_base) {
 		pci->edma.mf = EDMA_MF_EDMA_UNROLL;
-
-		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
 	} else if (val != 0xFFFFFFFF) {
 		pci->edma.mf = EDMA_MF_EDMA_LEGACY;
 
@@ -912,12 +920,17 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 		return -ENODEV;
 	}
 
-	pci->edma.dev = pci->dev;
+	return 0;
+}
 
-	if (!pci->edma.ops)
-		pci->edma.ops = &dw_pcie_edma_ops;
+static int dw_pcie_edma_find_channels(struct dw_pcie *pci)
+{
+	u32 val;
 
-	pci->edma.flags |= DW_EDMA_CHIP_LOCAL;
+	if (pci->edma.mf == EDMA_MF_EDMA_LEGACY)
+		val = dw_pcie_readl_dbi(pci, PCIE_DMA_VIEWPORT_BASE + PCIE_DMA_CTRL);
+	else
+		val = dw_pcie_readl_dma(pci, PCIE_DMA_CTRL);
 
 	pci->edma.ll_wr_cnt = FIELD_GET(PCIE_DMA_NUM_WR_CHAN, val);
 	pci->edma.ll_rd_cnt = FIELD_GET(PCIE_DMA_NUM_RD_CHAN, val);
@@ -930,6 +943,19 @@ static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
 	return 0;
 }
 
+static int dw_pcie_edma_find_chip(struct dw_pcie *pci)
+{
+	int ret;
+
+	dw_pcie_edma_init_data(pci);
+
+	ret = dw_pcie_edma_find_mf(pci);
+	if (ret)
+		return ret;
+
+	return dw_pcie_edma_find_channels(pci);
+}
+
 static int dw_pcie_edma_irq_verify(struct dw_pcie *pci)
 {
 	struct platform_device *pdev = to_platform_device(pci->dev);

-- 
2.25.1


