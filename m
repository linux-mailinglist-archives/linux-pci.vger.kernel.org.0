Return-Path: <linux-pci+bounces-6828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C4FA8B6A41
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 08:14:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AC4AB1C214D2
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 06:14:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id F11FB1865A;
	Tue, 30 Apr 2024 06:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="R8nGO2hQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pg1-f182.google.com (mail-pg1-f182.google.com [209.85.215.182])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E90618EA2
	for <linux-pci@vger.kernel.org>; Tue, 30 Apr 2024 06:13:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.215.182
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714457640; cv=none; b=VTRN9fwiOyV6GF4pyI2uTn3D323/Ipm7Gb+zqCvVxDpXDCbjlqS6Vmu6zNN/4JcJNSnlJ56opHa6vsU9voUMIi3yoCCFGBuxdvsXg8F9aJRDuo3HW7cPhpdn2pF/XJb5bL0XfeK6ezVclxBS+zP1h/riHCYRqTQMAdt/sGQoflk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714457640; c=relaxed/simple;
	bh=jt1D2ByjrZn+3+b2hbWiJrAvnVxKB+ZADxZB6BY649I=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DSeOkYLOHYcMv71qJxKYm+WVmu+8lb6lRnFIEjt7gC113sGTJ1MrdGzWhA9G6q0976NtD5Ymx2BpBtHXK428TS5hkAbPx561GTxIWBnjNuvvl5qVLd4nlojDcSVjRN0L5cYGmYzeihk/8vR5u8mefwseZi3ObN+svMyTmsiS2KA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=R8nGO2hQ; arc=none smtp.client-ip=209.85.215.182
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pg1-f182.google.com with SMTP id 41be03b00d2f7-5e8470c1cb7so3610270a12.2
        for <linux-pci@vger.kernel.org>; Mon, 29 Apr 2024 23:13:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1714457639; x=1715062439; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=wXh9sF7R3fzAgfyMkAPr9tJsPtu8XJez/oIKM/eXa7g=;
        b=R8nGO2hQFErTYN1HJ1ExPKNtnSmJ1DRfz5XfAbofqxErMW7pIsM+sNwc2m5PnNHgIs
         u6SPbnNFtkAcjj8YXbStJZr/2wLIYESrPrbetxVLwthCwDuMl6b4N/X4bePRpFTlivCy
         hE4u8bjKf19ouUV44V3+F9OFFx3fYL2Kl6UUnmh0Vax0GXdC0i5cm42QhnzSxeKPMtI1
         uQ7FovKPAg3JPRrBFm71tr5siAboC+/ibG6XBq1/DXsg9cBiPW6s8Axb7PfrVSJjXktG
         60/GBwO98qfi/p/xc30viW5TsaKwpUfBIzDeQQOL9qYLs8Q5XIpYIPqX8TqkgK+KvK8b
         IBFw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1714457639; x=1715062439;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=wXh9sF7R3fzAgfyMkAPr9tJsPtu8XJez/oIKM/eXa7g=;
        b=n40OZTvoWVYTbivdqzyI9sGcC4vdi6mTfRKNO2sp4aFKXu1x9KmmoG1+VoE4+4AlLi
         1w+nCndl1JXhYSvUUVvAQFGNuV7O8dMIVUZgYAzhyBWSWLRSz+amO9EXoPwXhQ6VpITk
         wU3EQjhKPId25i7kifgvPeM8dRkTCy9SHKqpgMoyXTK0DEZRZkZKwWaoUrIUW31T53Iw
         LEpSbEzr2mbhnZKMzpxLT5rO108Ld33vvubz0cDUgIiVxyf0WdInCmunMMOoFH4yyxpG
         ga+5n4IZx1du2D9w8JUo1D+EjsDQjFp7krD2n2aXy5Zjp4qK9vahvmoG0vqmmxqddi2h
         n7yg==
X-Gm-Message-State: AOJu0YyA6RpFJbdK47p+qWLAf5O3UZbKurq11/UkvGgzdR86WxpNbiTM
	dd5MeBO/Rw47kk4aeQfZGe3ppozrIi4z1FOm0YOnkTzttwvujB/8vkeXS2gKWQ==
X-Google-Smtp-Source: AGHT+IERNIpcVXnSkXOmcaImsK+5bkppIPbBwq2zMma4pGcKZ6IuGe+V26L0xyysFM6Tlh3EGcEAVw==
X-Received: by 2002:a05:6a21:8801:b0:1ae:42f0:dd40 with SMTP id ta1-20020a056a21880100b001ae42f0dd40mr11483048pzc.10.1714457638098;
        Mon, 29 Apr 2024 23:13:58 -0700 (PDT)
Received: from [127.0.1.1] ([220.158.156.15])
        by smtp.gmail.com with ESMTPSA id bi2-20020a170902bf0200b001e27ad5199csm21393298plb.281.2024.04.29.23.13.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Apr 2024 23:13:57 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Tue, 30 Apr 2024 11:43:42 +0530
Subject: [PATCH v4 01/10] PCI: qcom-ep: Disable resources unconditionally
 during PERST# assert
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240430-pci-epf-rework-v4-1-22832d0d456f@linaro.org>
References: <20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org>
In-Reply-To: <20240430-pci-epf-rework-v4-0-22832d0d456f@linaro.org>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jingoo Han <jingoohan1@gmail.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, mhi@lists.linux.dev, 
 linux-tegra@vger.kernel.org, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=1435;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=jt1D2ByjrZn+3+b2hbWiJrAvnVxKB+ZADxZB6BY649I=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmMIway5+22p+3zzxNye4e9nY6gatrHr6KQJdEi
 xojXepGaKCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZjCMGgAKCRBVnxHm/pHO
 9exSCACQpshGLWqd2q2FIap/b/j21N7ezIygTykNAuBoxRvI52wZ7AgL4XAc7ehW7jUy7ug5Yj4
 TTAr9ibRkE5YNpUxp2kwf08BbNC5DRpcuZCIQYpK1rXSXrQBmDkotbUlhyVLxbe7jiQJsXxMetC
 K/WGd+ng5BS8AmHl2eEkY4QMivJbKBKS5edIIKZ16T2pxXe3vyIonISkA1AIwtlpGT9MU6mu4cf
 6VlwgFmFLZqzZ6M1H1FFyVRFfLDUMRbDmW65qFy07zxaptW12SOqb3qt3wiknS/pnqHopJ90JYg
 TkFD1kWZCtArPpPV3V8m+m1BYaStbdLk91RodRTAtyF0wDmH
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

All EP specific resources are enabled during PERST# deassert. As a counter
operation, all resources should be disabled during PERST# assert. There is
no point in skipping that if the link was not enabled.

This will also result in enablement of the resources twice if PERST# got
deasserted again. So remove the check from qcom_pcie_perst_assert() and
disable all the resources unconditionally.

Fixes: f55fee56a631 ("PCI: qcom-ep: Add Qualcomm PCIe Endpoint controller driver")
Reviewed-by: Niklas Cassel <cassel@kernel.org>
Tested-by: Niklas Cassel <cassel@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2fb8c15e7a91..50b1635e3cbb 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -500,12 +500,6 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 static void qcom_pcie_perst_assert(struct dw_pcie *pci)
 {
 	struct qcom_pcie_ep *pcie_ep = to_pcie_ep(pci);
-	struct device *dev = pci->dev;
-
-	if (pcie_ep->link_status == QCOM_PCIE_EP_LINK_DISABLED) {
-		dev_dbg(dev, "Link is already disabled\n");
-		return;
-	}
 
 	dw_pcie_ep_cleanup(&pci->ep);
 	qcom_pcie_disable_resources(pcie_ep);

-- 
2.25.1


