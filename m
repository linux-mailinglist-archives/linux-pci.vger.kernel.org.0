Return-Path: <linux-pci+bounces-4006-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 7453F86737C
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 12:40:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E186D1F2BD1F
	for <lists+linux-pci@lfdr.de>; Mon, 26 Feb 2024 11:40:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DC44D9EC;
	Mon, 26 Feb 2024 11:38:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="HJgwBfj+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-qk1-f181.google.com (mail-qk1-f181.google.com [209.85.222.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3AA4E4EB3C
	for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 11:38:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.222.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708947495; cv=none; b=uH/OShz/dPb3VN+YkkwOqgvMr+GqeH5VTOEInA78/K8xean4I9msAnvbF8cazCuwuRznQ9AC4OshavXLQmiytB+zjJt+6B1sjLnaWTc8IkIj5I5ut//vWKGrA3d5qtUqv2TsfRC0RBkjtNJmPcY+9GGTLwGPm1tfS/tC+Fg2JTM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708947495; c=relaxed/simple;
	bh=LfWfeRToUlscmv4bOnNxzBmnBmixoxu2nS+JFrpB7yA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fJ1hukphKXXb5jgFCYUkyRBnXHzbXRxgvkaWELLfQfTcEKFgeWTGvaP4kr/mCTyLLr8lhJAdHG46n7jhdYLJySq2nr7h6rmQpXQwH/dnX3EGsxo/57YSsMrST0O4+59pWXbA5C+aKJgmZ+rTzNF4J8xs6xwHifCabjp/cC6ppPY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=HJgwBfj+; arc=none smtp.client-ip=209.85.222.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-qk1-f181.google.com with SMTP id af79cd13be357-787bc70dfc7so157086085a.2
        for <linux-pci@vger.kernel.org>; Mon, 26 Feb 2024 03:38:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708947492; x=1709552292; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=JxUlcjtwrOcaTenBbb8UJnxm67jDgNWVYtF4cGu05o8=;
        b=HJgwBfj+yFkMeMZTMX0U5mkMjcsjUvprZyVfTpY8eUhF14cxiAkBuzVVbiQwS/BPUi
         97mucV6g8Lo3SOk7Lh2ARFWefsrmGQila/7BI1xd1x+Kg7rgHwvKZYizAOCgeqMrID9S
         Usutkc0HmMH1scrmn41vcZgXGp06P/u4tvnSVqY+ByNPrOQBewRaiwyrrvoWH54iG35D
         F8apba0gSNyTIKrLxGUHw7miPfnko9XsQNChkCiaQOIsseyD56BfQoP1IIcFdUGQB9eR
         jkGTRnm7Me06bqA9d4Mcy+WAeFBfUcrVV/AFOESolKfIkMLBsmOarwJDBxMtMvYW1ZMq
         CbQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708947492; x=1709552292;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=JxUlcjtwrOcaTenBbb8UJnxm67jDgNWVYtF4cGu05o8=;
        b=XW7B7Fo62i1GZ8bHYgvqrb5Sx+R/sjn8Fa3PwZ+h2lrTiMZBbeDC22e6K2guKJhkol
         RTltlwqEFkJP8tMq4pus8tWIL6h5vZQ97YvXlaBU+lnJzGB0Qi+G3ZS2zkiwG7htX5rS
         3rIv7m3v3ukhbLvSC+Bxanz6jJxeicfcwwU8MIz/L3XGMt43gE2JgES8pV41hMs3SDC9
         6bFsJLtwTdYYjTNc9r1UDK35WkdkzOLG2LGpJxq923vvmyr9Jikx17BP+ZBzu+K5nzWA
         n9klBruGEQwiQg6J5PJh5BBK/yvtGpjUoSvHtAjN+4KLIYrCzzjcKgErT2ZrwuMnma0+
         V5Cg==
X-Forwarded-Encrypted: i=1; AJvYcCU7Pp56LmktTLpNH6BXqUR+FsYLLwKB+jSFbcbNGHQ9IkjFqAx05fA9xDrcvWaAKlTD56Liizdwp3nwrdCmfY3HLh4ZKC6xM1Pf
X-Gm-Message-State: AOJu0YzL7iixRWQpAAQI1v/nWYaczfRtdYr7QwxIoEEWU8MNg0macpC/
	q+8KkDklQlSgZLmsOnFTAY2B2kaWF1CwcTygf67OuO5VLhQCFki5NaoTZXYyNw==
X-Google-Smtp-Source: AGHT+IHpSBC6esd5dE1lk3BSbuDLUNXLMiyK38+8Gwr6O/JCcZBAYcA8VJRisPIoUFYcsNWA6zNeZg==
X-Received: by 2002:ac8:7d12:0:b0:42e:5f70:f17a with SMTP id g18-20020ac87d12000000b0042e5f70f17amr8687103qtb.11.1708947492124;
        Mon, 26 Feb 2024 03:38:12 -0800 (PST)
Received: from [127.0.1.1] ([117.202.184.81])
        by smtp.gmail.com with ESMTPSA id q15-20020a05620a0c8f00b007878babb96asm2341842qki.94.2024.02.26.03.38.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 26 Feb 2024 03:38:11 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 26 Feb 2024 17:07:29 +0530
Subject: [PATCH v3 4/5] PCI: qcom-ep: Add HDMA support for SA8775P SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240226-dw-hdma-v3-4-cfcb8171fc24@linaro.org>
References: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
In-Reply-To: <20240226-dw-hdma-v3-0-cfcb8171fc24@linaro.org>
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
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2794;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=K4+v7NtEJKfx2pgrszooW5RqKHWkxdFvG2huKB8ULNg=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl3HgGPMff0pTdqV0ne8r2AzpEGIe63FIvUfDcN
 Xzg1Te64IqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdx4BgAKCRBVnxHm/pHO
 9XY2B/9AGY6k/obyeFs957a00oxYiEUi14PCBQ9NzkUgCpKquGGO9hJ45G1L6CGZCVLynNyjbug
 DGUFDhCTH8ouXGXzoZ3XUAgaZzP6zv1h+1UfnzMFamf06Yx5sqogYNWD96mrAPDBZO75bTjdslK
 FeCvBXoNNwnLXev8l0t4/dQ47hlMvQFFHa3VjxnAThDC4/utBdYRdmhFwVJTig/n5FqH3sw0iZ6
 lAEkNd6cPL1d6s19AQkxPBXlQeBp61XMcELjtgsKU2rrfaRoP7QqX9jdDtFxxFCZ2nfSqu90LKZ
 Xzp/zYbgbFhrou8RhwOVC2RNUz5eWznE+Aq9Vu0OqFCq1GQD
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

From: Mrinmay Sarkar <quic_msarkar@quicinc.com>

SA8775P SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP.
Let's add support for it by passing the mapping format and the number of
read/write channels count.

The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
config struct is introduced for the sake of enabling HDMA conditionally.

It should be noted that for the eDMA support (predecessor of HDMA), there
are no mapping format and channels count specified. That is because eDMA
supports auto detection of both parameters, whereas HDMA doesn't.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
[mani: Reworded commit message, added kdoc, and minor cleanups]
Reviewed-by: Siddharth Vadapalli <s-vadapalli@ti.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 23 ++++++++++++++++++++++-
 1 file changed, 22 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 45008e054e31..89d06a3e6e06 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -149,6 +149,14 @@ enum qcom_pcie_ep_link_status {
 	QCOM_PCIE_EP_LINK_DOWN,
 };
 
+/**
+ * struct qcom_pcie_ep_cfg - Per SoC config struct
+ * @hdma_support: HDMA support on this SoC
+ */
+struct qcom_pcie_ep_cfg {
+	bool hdma_support;
+};
+
 /**
  * struct qcom_pcie_ep - Qualcomm PCIe Endpoint Controller
  * @pci: Designware PCIe controller struct
@@ -803,6 +811,7 @@ static const struct dw_pcie_ep_ops pci_ep_ops = {
 
 static int qcom_pcie_ep_probe(struct platform_device *pdev)
 {
+	const struct qcom_pcie_ep_cfg *cfg;
 	struct device *dev = &pdev->dev;
 	struct qcom_pcie_ep *pcie_ep;
 	char *name;
@@ -816,6 +825,14 @@ static int qcom_pcie_ep_probe(struct platform_device *pdev)
 	pcie_ep->pci.ops = &pci_ops;
 	pcie_ep->pci.ep.ops = &pci_ep_ops;
 	pcie_ep->pci.edma.nr_irqs = 1;
+
+	cfg = of_device_get_match_data(dev);
+	if (cfg && cfg->hdma_support) {
+		pcie_ep->pci.edma.ll_wr_cnt = 8;
+		pcie_ep->pci.edma.ll_rd_cnt = 8;
+		pcie_ep->pci.edma.mf = EDMA_MF_HDMA_NATIVE;
+	}
+
 	platform_set_drvdata(pdev, pcie_ep);
 
 	ret = qcom_pcie_ep_get_resources(pdev, pcie_ep);
@@ -874,8 +891,12 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 	qcom_pcie_disable_resources(pcie_ep);
 }
 
+static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
+	.hdma_support = true,
+};
+
 static const struct of_device_id qcom_pcie_ep_match[] = {
-	{ .compatible = "qcom,sa8775p-pcie-ep", },
+	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }

-- 
2.25.1


