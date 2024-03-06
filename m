Return-Path: <linux-pci+bounces-4568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C5CD873404
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 11:23:39 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 80E011C218C5
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 10:23:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1DEE1604DB;
	Wed,  6 Mar 2024 10:22:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="devYprfi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pj1-f47.google.com (mail-pj1-f47.google.com [209.85.216.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 55FB7604DD
	for <linux-pci@vger.kernel.org>; Wed,  6 Mar 2024 10:22:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.216.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709720560; cv=none; b=rBzytHzf7JKMR6Dc1xCMFT16yiv44v4uJJ1j5WAvpmAYKcEttcZ6lzZ3C5FawG6WSwybK41CazjkVG7i+CH+1ckmHPCwLHDcd3NBVcCwpoTQJGUd6eu2Apg6wxpObiV4pHmpuOI5rKPlmhW8jkZ4+4ERtJFHmRV/pScRuseNl3c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709720560; c=relaxed/simple;
	bh=4ZnKA2x084i8aSzeb+7VZUZvD2DTTkxxYBoxaNu0hmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Bwd7OAtgrA0bI0vvAA6b5TP0fNVHgvf8MhxEKv16hfnT+O6GqnEEe3AWiqtrq9EG7WEI1vxyU1enGGqj3GH9mZVAmtnPbN+B/HSKpcKs6PiUoP7dkpx7TtOqQpiHovCjiSCdkZWE2KPZ2TmN5FsBEopPGJKLwJVQ9gOGItTXVTI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=devYprfi; arc=none smtp.client-ip=209.85.216.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pj1-f47.google.com with SMTP id 98e67ed59e1d1-29b780569d1so263576a91.3
        for <linux-pci@vger.kernel.org>; Wed, 06 Mar 2024 02:22:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709720558; x=1710325358; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1wxOBAUjX0dYGb91gU5vDpZ+Txgxi8ueraivd/YvJ1A=;
        b=devYprfi0zsaZ4ex5CVciXf/imG9hIzAvErfYu7Jbr491OqInEQwMD68EOJNU2brs6
         z+x/RcEJXqJeHXhCaJvzgumiDuTpZNWj35v1bFrec+9AHx6gqrJoZMHPCszVmcFSdxK+
         J7Y4prNQLWbqZin4IRsir/R6XFgkJz0qYOC2lIzPvC22dUXZxq21BXOmP/BWdBN+DUmO
         bFyUSn8qDW4ItrnG4dhzii6u/hqgK+eGHvkiAZ36MUoitNjndMKsK6Lq7U8TOq97pJpI
         xKDTMYfMriyYdhmslLHaCZxDdJ7hy0Srvz4I4us/+gvLrU4XOpbPHiKdwzr0SuJiABkN
         mdEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709720558; x=1710325358;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=1wxOBAUjX0dYGb91gU5vDpZ+Txgxi8ueraivd/YvJ1A=;
        b=pjPaF7m+BuWvSykxZzhD5iuoZg5/52CjlaYPXZZnIEQn07IhUmKHaYWS7tvSrhseF6
         AqjHZMjlm28qOM04++CbGAevTOo0sN2sx2ywUHtZlwV598m8Mz/DKUA4tuu27SyMZhWB
         Cy+2MHbyo8GzWgsltKwzq3zlSOBEP7dT7wwqvwNQFJa6v2dpA50eR4hdMniBjYSo4aWb
         nQnjoo4iyczG/FV1KDtxI9oLm1WShSiTOWWlKsILBgCaySYrQfH7tuIXMc6dYrBwD7pV
         eVDuCcLUBDNTWpKTJl0qcYMXh0ASKbEXecOak9/bzCVYXtFCJ2QFbx0dQFtRReAd5F7K
         NFwg==
X-Forwarded-Encrypted: i=1; AJvYcCU97N63ZgnD+gMp2femukV7P20lgP/ph1p80TBH7ym5DQKzBRydqclOc8AbxN3iFtrS+HiIsj5AB54iRFCDT7RpuWz0MCOkVQKR
X-Gm-Message-State: AOJu0YxmwGWcGeV0iB/PkhUUxD/1kepzcSjjOeaW0t0Rum8kV7JjSaB1
	qcjJ5rB2poFuAWkQ0MMne8IPMipjW0xn8pqWGWCIxMwPJKWBWA08KlDZ6k6TYqWQEFJzEI88sz8
	=
X-Google-Smtp-Source: AGHT+IFt/jN5PP6cll3iW1yMT23xerTJ8Y3kAB8zT+L7Hm2yDLJnNfOuhwh0KHs3a8jnQSvt5oUnsg==
X-Received: by 2002:a17:90a:ed03:b0:29b:3921:7d47 with SMTP id kq3-20020a17090aed0300b0029b39217d47mr7779118pjb.40.1709720557493;
        Wed, 06 Mar 2024 02:22:37 -0800 (PST)
Received: from [127.0.1.1] ([117.248.1.194])
        by smtp.gmail.com with ESMTPSA id li17-20020a17090b48d100b0029ab96b13ebsm13339320pjb.40.2024.03.06.02.22.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Mar 2024 02:22:36 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 06 Mar 2024 15:52:00 +0530
Subject: [PATCH v4 4/5] PCI: qcom-ep: Add HDMA support for SA8775P SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240306-dw-hdma-v4-4-9fed506e95be@linaro.org>
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
 Mrinmay Sarkar <quic_msarkar@quicinc.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=2836;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=P0A1uqJu0LyM0UHwxugMbNA2eTzT8rsr5vWTX7qvQq0=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl6EPQbIMh5HjM5LP7GgjMmJHMg31rPfk/zEMb6
 pHHFEm8fUOJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZehD0AAKCRBVnxHm/pHO
 9efXB/9M4qLkv1lPrTQ+6yhvUAYgowFbhtqPznIjzdaHKRCNYTVj5/vpBv+DqAngkReu7ClI+5+
 HeppdovvBrasp169dG1oOaZsCZQzHWu4iAfvmtjEV2N+oWByZrNiR8Fw8KR0ysf7cFIgm0HvFaI
 wiH1QaC4mI0+pii3ZvjC6hyc8BuOVZDAFmbRzSn3RcKkmVj8FlEADMTzAqvdl2oxdt6dXk12T5h
 vO7qCx/215TN6LKm6HsY/AAVZhwNEAmGcbNC29gcLRa59amz316daG19OTZp1X8ReTwV89mx24g
 bSUcNd3pNl+UL1T428oI0D5UD+9+cQm1VU9o7KC5koMDuYUJ
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
Reviewed-by: Frank Li <Frank.Li@nxp.com>
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


