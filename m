Return-Path: <linux-pci+bounces-3965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AB1EA862319
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 07:56:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2032B1F235EE
	for <lists+linux-pci@lfdr.de>; Sat, 24 Feb 2024 06:56:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 403A379EF;
	Sat, 24 Feb 2024 06:55:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OH99KU6V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-oo1-f49.google.com (mail-oo1-f49.google.com [209.85.161.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4089E1BC3A
	for <linux-pci@vger.kernel.org>; Sat, 24 Feb 2024 06:55:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.161.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708757711; cv=none; b=Su6Kh0mTaH4qsh0CUvUCqHWXd5wX6x78hIAQ7zEda6dbzpHqcWzDRKFcS/SFxIW3kYMkSyLB1sp0OwIGrxknMk1OMho+hfICaF8Nl23/o8y+D3Ea6c2McZuN859UD3YI/fMxbDO0RiEfO++jW8k5YvKGfgs6GsRUllc9osBLeFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708757711; c=relaxed/simple;
	bh=B0PhE1y+gAaNOi53fUgHsTYPDq1blQx22prPq8xyRuw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=hK26Gr8pOEQWvkO5Iy9hUfghgzY08ARA2jahEcdN9QgTw8uvDMUqefmhgj5HohHPPXVg7Ga87n9iXGBFc/6JhI5DkI2ruGMQ9hadsiZG8fXMsSjMuMZCqe6zWNpx9aQvvk6lshXnqVdMZLSW58lYH5CzEOgTqb8TsMLfLNNd890=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OH99KU6V; arc=none smtp.client-ip=209.85.161.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-oo1-f49.google.com with SMTP id 006d021491bc7-58e256505f7so1450036eaf.3
        for <linux-pci@vger.kernel.org>; Fri, 23 Feb 2024 22:55:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1708757708; x=1709362508; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=62aaJ8hjM35CBdMQwZJRm+QdPn0BmVHs5qHivB5msD0=;
        b=OH99KU6VKPIxXNil8iagDjwl66sh3nG2dLA8aDCjGjUhHKj0HwgAQPuknCwTR2IIAS
         PWamLYewsbah7oRvEOiCGeLTmmyarQMdQzQAmSJ0Y7IOfLbw/CppPXpLp5OhN6UrxaFb
         T2nu1vfor52AEA2w3cJbcsGLOkCTGaRxiUya9xL+ntH13q09uFRHZAS75hKZOcGGjK3j
         muE9Mu8pZYBxMX4aFUqv3f/yzUklY53DzyMiYjGy1SqtqUGbfetYfZIBQACqOsrufOR7
         DnwYMroKfXxAhD0WBYsDww/bE2C+9UobD0S7jLOk4htQCu4S/1AzY6IsO4MSdG9dEKzC
         lilw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1708757708; x=1709362508;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=62aaJ8hjM35CBdMQwZJRm+QdPn0BmVHs5qHivB5msD0=;
        b=DZAInQzgzngTUrG3mO3ASmeU2OuLTFQz1WqI4X1bprNr5AsRTzPrVY65fC+xyt0Pr4
         ChkwRIF3lIjD13IVZuOvNJ1bvS/NoTrSN64qSxcCLe2/XDZhy8lu1cZnutBUAUr4wk4L
         PKvq7qaG8FlZnaxWyq0Mcc4HGMddt7TEOXGDR7sSq6XaMTbUiAWx/e8HvSYENPZ5HWkz
         wlrjnHlqUR764dYCEoxV0j2I7Q8f5VkK48DFd3ts0fPoxLKv4NsfV1NoG8zfp1i5hHyc
         wQAVFrV1HjRKUgDaRJgfNIHvkm1kktFB4YE/xT7F5kAubIG2AAV1Jgh12JvcnbVliAUS
         /l2Q==
X-Gm-Message-State: AOJu0YwSeTJFDHnRocRIxy4QuhyrthW/YqvYcl/aUTRcfI2j4E/p7dRI
	l35yD+cczeaz3jtRyL+5IxAsqp+ZrjYhABXlN2Yl6HKOjh1ket8FOS2OYJRK2Q==
X-Google-Smtp-Source: AGHT+IFmu2g7YjnWyO+/FbAhAXtC82vlO+na531lz2vEodInBXJ/Z3ZWH828//qkvYbpDh1Kf6Ts+Q==
X-Received: by 2002:a05:6359:a385:b0:17b:5676:19b2 with SMTP id ky5-20020a056359a38500b0017b567619b2mr2358270rwc.10.1708757708257;
        Fri, 23 Feb 2024 22:55:08 -0800 (PST)
Received: from [127.0.1.1] ([120.138.12.46])
        by smtp.gmail.com with ESMTPSA id r5-20020aa78b85000000b006e4cb7f4393sm502932pfd.165.2024.02.23.22.55.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 23 Feb 2024 22:55:07 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Sat, 24 Feb 2024 12:24:11 +0530
Subject: [PATCH v8 05/10] PCI: dwc: ep: Rename dw_pcie_ep_init_complete()
 to dw_pcie_ep_init_registers()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240224-pci-dbi-rework-v8-5-64c7fd0cfe64@linaro.org>
References: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
In-Reply-To: <20240224-pci-dbi-rework-v8-0-64c7fd0cfe64@linaro.org>
To: Jingoo Han <jingoohan1@gmail.com>, 
 Gustavo Pimentel <gustavo.pimentel@synopsys.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kishon Vijay Abraham I <kishon@ti.com>, Vidya Sagar <vidyas@nvidia.com>, 
 Vignesh Raghavendra <vigneshr@ti.com>, Richard Zhu <hongxing.zhu@nxp.com>, 
 Lucas Stach <l.stach@pengutronix.de>, Shawn Guo <shawnguo@kernel.org>, 
 Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, NXP Linux Team <linux-imx@nxp.com>, 
 Minghuan Lian <minghuan.Lian@nxp.com>, Mingkai Hu <mingkai.hu@nxp.com>, 
 Roy Zang <roy.zang@nxp.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=4127;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=B0PhE1y+gAaNOi53fUgHsTYPDq1blQx22prPq8xyRuw=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl2ZKWFZQfzR7Hs99LrT+PCi+RLB/1HxnLjMGsr
 J6+hPdOSMmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZdmSlgAKCRBVnxHm/pHO
 9S8nB/sGefzqN5S5NxI7QGTCEqJj5WyzcqIrBNlyRwlLZEufNV9QoPWcMDT3K7lv85dog3D+BYI
 9O7sIN6jZkUX4yuojHus+c8bxlrufJKfKf48AqsCHI3ukWtoFEMA6KNq/iL2qO48uRY/yP8OeSj
 WCFyOJWxuk/oqLxfCn+ZbjwF10IoCkTIYLST6nt/f/SMpwmTKeHu2HtEfULH+tQNSJoG6ffD874
 q9ScUrqcsRySeyTsVPuVBAaxRqtGQBsudpAPQD0Dx//JXFBlHdOEts5GOzCE92aHPEm8UYlYwU7
 Pyh/usKFkhE8LK/rZ1+sKOEfGkXcohkPffRcmkHf9UphJdsh
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

The goal of the dw_pcie_ep_init_complete() API is to initialize the DWC
specific registers post registering the controller with the EP framework.

But the naming doesn't reflect its functionality and causes confusion. So,
let's rename it to dw_pcie_ep_init_registers() to make it clear that it
initializes the DWC specific registers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 6 +++---
 drivers/pci/controller/dwc/pcie-designware.h    | 4 ++--
 drivers/pci/controller/dwc/pcie-qcom-ep.c       | 2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c      | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 99d66b0fa59b..ed1f2afd830a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -603,7 +603,7 @@ static unsigned int dw_pcie_ep_find_ext_capability(struct dw_pcie *pci, int cap)
 	return 0;
 }
 
-int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_ep(ep);
 	struct dw_pcie_ep_func *ep_func;
@@ -718,7 +718,7 @@ int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
 
 	return ret;
 }
-EXPORT_SYMBOL_GPL(dw_pcie_ep_init_complete);
+EXPORT_SYMBOL_GPL(dw_pcie_ep_init_registers);
 
 int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 {
@@ -788,7 +788,7 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	 * (Ex: tegra194). Any hardware access on such platforms result
 	 * in system hang.
 	 */
-	ret = dw_pcie_ep_init_complete(ep);
+	ret = dw_pcie_ep_init_registers(ep);
 	if (ret)
 		goto err_free_epc_mem;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 351d2fe3ea4d..f8e5431a207b 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -669,7 +669,7 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 #ifdef CONFIG_PCIE_DW_EP
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
-int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep);
+int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
 void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
 void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep);
@@ -693,7 +693,7 @@ static inline int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	return 0;
 }
 
-static inline int dw_pcie_ep_init_complete(struct dw_pcie_ep *ep)
+static inline int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 {
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 59b1c0110288..3697b4a944cc 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -463,7 +463,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	      PARF_INT_ALL_LINK_UP | PARF_INT_ALL_EDMA;
 	writel_relaxed(val, pcie_ep->parf + PARF_INT_ALL_MASK);
 
-	ret = dw_pcie_ep_init_complete(&pcie_ep->pci.ep);
+	ret = dw_pcie_ep_init_registers(&pcie_ep->pci.ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto err_disable_resources;
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 68bfeed3429b..264ee76bf008 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1897,7 +1897,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val = (upper_32_bits(ep->msi_mem_phys) & MSIX_ADDR_MATCH_HIGH_OFF_MASK);
 	dw_pcie_writel_dbi(pci, MSIX_ADDR_MATCH_HIGH_OFF, val);
 
-	ret = dw_pcie_ep_init_complete(ep);
+	ret = dw_pcie_ep_init_registers(ep);
 	if (ret) {
 		dev_err(dev, "Failed to complete initialization: %d\n", ret);
 		goto fail_init_complete;

-- 
2.25.1


