Return-Path: <linux-pci+bounces-4816-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 191A787B8E0
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 08:51:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 3D2521C23349
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 07:51:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 277225EE72;
	Thu, 14 Mar 2024 07:49:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="FeFlooWW"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f177.google.com (mail-pl1-f177.google.com [209.85.214.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A68F55FBAE
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 07:49:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402584; cv=none; b=Tm81j7i0xpVQBU1OLHljmdRX3vlP1GmiwGJlhN83t1w1y9nU+C9IFisjnOh+JJxelAacA1jjAozP03uKQV3UmU7FidnetGmKck0bWoGVQREVwpaZPSWiQPqRJFlYG5hG7Ud9YpIEwUZ9EeTT1N/equ95FFIb7tMNTQ3gfI9zoho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402584; c=relaxed/simple;
	bh=boqks+rPWZIsvj6aCpTVxfVD8A0dgCaOVh/U3pIyzt8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fZQ3OLbZWrqB1hQ+bSJnvv7d4UjRfqNQBUnfWYg44qK+D6R94ZelOa54Qom3DPUFVapcmhoWk+SfMX+22hKKX5HoEdbipIuNQl2srB1tmy7LuPyu8wfPuck02G50UdNuPpiPbVTPtucBWaiBhEQ6Wkj7MFRskALO6PYSoLGWYo0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=FeFlooWW; arc=none smtp.client-ip=209.85.214.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f177.google.com with SMTP id d9443c01a7336-1dd878da011so4399695ad.2
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 00:49:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710402580; x=1711007380; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=oG15CX4beLBeuniF9W2ewRdqC7XGBSpAJslMsJApDnc=;
        b=FeFlooWWgLLYvdq13JrwU2iAVtyv60fF/PuatQtT5aBsE0f3nGe+ETikBrTebezJOo
         cDBjMBZDFznEOqIrnOsI8DK2FwiqWh8voxVpOz7ZxkgS1eGTN3KATfOaT9k/R+dpLFAJ
         YJml5nC2bz7g8lHzXVVDArmDtPKCWLXU2jRG0fmoiSJdC/Qq3jf7Ok/PH4QiC9SG8++f
         UgSFWH9XGaijtCHk89qPd4KCbmsGv0xN5rr4LZ6yUQbH3lAgyScqjva2WXjcIr0//iWn
         eMqxehg6cUDo2+/iX0L9c0t8msjJV54mkoAomZ33HMKKgxmwlVMzTIice4FEl7E2eNQo
         lkzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710402580; x=1711007380;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=oG15CX4beLBeuniF9W2ewRdqC7XGBSpAJslMsJApDnc=;
        b=SqxM7VAtgzcSGfPI8CBMO6j/9HvXM2SDk5O1iNeMfTTKJF0J/yyjFnDUCQ8zKL1SEY
         mTxFxW/x9jduLN6d1cFU3OBW0xu3dxQad10E3eIzgi5JWOi8UaybsaJEb90r1jcbZXVJ
         822sGCkEsE5/ADxV0GQ8ge8PWAReEK40KwyemNcirR/fQIFa0ObCNS2LENo99FvJRlKR
         7eAe0MZ4CUyV8vx4Mexb14LQne4g4pIF18IlD6bArbm/0+Ou0i03EKz/tYnW7TIE8GbX
         XXQgMsNkpKY/mxhBLraIa9XcnZPXu0H9JtveaG7YL7vr1c8xKSx2oCs+oulyNYsDsDjk
         Lapg==
X-Gm-Message-State: AOJu0Yw5TrYwYym7XrgYvnbS4BdUUmzXkmE5EpP+aeHFgT2KCjvGzzAc
	gcrvcT4bfSJ2CQSDMDHigO5mkKVCwZ3kU8IxcA65GkrFMJttqXDqSdzI/WD3bw==
X-Google-Smtp-Source: AGHT+IFKTemGoIv+4/BI+Sr5GPPsL+zXDqxidpS2ymUj3e46VG33KArpiuOjL3t0E8ECnVFGgOEKJA==
X-Received: by 2002:a17:903:187:b0:1de:e122:1826 with SMTP id z7-20020a170903018700b001dee1221826mr64009plg.38.1710402579876;
        Thu, 14 Mar 2024 00:49:39 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001dd4fabf695sm946321plh.38.2024.03.14.00.49.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 00:49:39 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 13:18:05 +0530
Subject: [PATCH v10 7/8] PCI: dwc: ep: Call dw_pcie_ep_init_registers() API
 directly from all glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-dbi-rework-v10-7-14a45c5a938e@linaro.org>
References: <20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org>
In-Reply-To: <20240314-pci-dbi-rework-v10-0-14a45c5a938e@linaro.org>
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
 Kishon Vijay Abraham I <kishon@kernel.org>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, 
 Srikanth Thokala <srikanth.thokala@intel.com>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10236;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=boqks+rPWZIsvj6aCpTVxfVD8A0dgCaOVh/U3pIyzt8=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8qvDHSISMo3EtlVPbU21S7k7KWnMxX8oflF2T
 ilBD9MxoOiJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfKrwwAKCRBVnxHm/pHO
 9ZtaB/9O7AR6EGstD7mPT1K8DDxpVZcYpDAuId5D/qybl0Ik9ZxlXhKD0HG1fv+wHmgAfyEL+1C
 nkx01BLSCztYeuU0LsgnzBKWmO21VJgY+Tx1gDPtZx2vgwRQ8aUT6LK5rQUB/+f7+a0lQD+Z3P8
 o4gFx9ZyPWnNy6tQOjOhZZCXCIHH3OZYRyNatCzlPl87D7LknxZGGtVwK5xZa7kC92Q/Cf0Asp4
 28nwrs+/o1m3omJVX48a2fW8OU76OL2iqP1eQ67CGrFwNp7YqZd7bsay7SYmRNYY4jXhNXAOkWS
 eXMKz23Wltv5PCgVpr6T0mn+UyERTXzE/t1rDuVJDe3PmAP4
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently, dw_pcie_ep_init_registers() API is directly called by the glue
drivers requiring active refclk from host. But for the other drivers, it is
getting called implicitly by dw_pcie_ep_init(). This is due to the fact
that this API initializes DWC EP specific registers and that requires an
active refclk (either from host or generated locally by endpoint itsef).

But, this causes a discrepancy among the glue drivers. So to avoid this
confusion, let's call this API directly from all glue drivers irrespective
of refclk dependency. Only difference here is that the drivers requiring
refclk from host will call this API only after the refclk is received and
other drivers without refclk dependency will call this API right after
dw_pcie_ep_init().

With this change, the check for 'core_init_notifier' flag can now be
dropped from dw_pcie_ep_init() API. This will also allow us to remove the
'core_init_notifier' flag completely in the later commits.

Reviewed-by: Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           |  7 +++++++
 drivers/pci/controller/dwc/pci-imx6.c             |  8 ++++++++
 drivers/pci/controller/dwc/pci-keystone.c         |  9 +++++++++
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |  7 +++++++
 drivers/pci/controller/dwc/pcie-artpec6.c         | 13 ++++++++++++-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 22 ----------------------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  9 +++++++++
 drivers/pci/controller/dwc/pcie-keembay.c         | 16 +++++++++++++++-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       | 12 +++++++++++-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     | 13 ++++++++++++-
 10 files changed, 90 insertions(+), 26 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 0e406677060d..395042b29ffc 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -467,6 +467,13 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 		return ret;
 	}
 
+	ret = dw_pcie_ep_init_registers(ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+		dw_pcie_ep_deinit(ep);
+		return ret;
+	}
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index dc2c036ab28c..bfcafa440ddb 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1136,6 +1136,14 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		dev_err(dev, "failed to initialize endpoint\n");
 		return ret;
 	}
+
+	ret = dw_pcie_ep_init_registers(ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+		dw_pcie_ep_deinit(ep);
+		return ret;
+	}
+
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index c0c62533a3f1..093dbb725e41 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1286,6 +1286,13 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = dw_pcie_ep_init(&pci->ep);
 		if (ret < 0)
 			goto err_get_sync;
+
+		ret = dw_pcie_ep_init_registers(&pci->ep);
+		if (ret) {
+			dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+			goto err_ep_init;
+		}
+
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", mode);
@@ -1295,6 +1302,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 
 	return 0;
 
+err_ep_init:
+	dw_pcie_ep_deinit(&pci->ep);
 err_get_sync:
 	pm_runtime_put(dev);
 	pm_runtime_disable(dev);
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 2e398494e7c0..b712fdd06549 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -276,6 +276,13 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
+	ret = dw_pcie_ep_init_registers(&pci->ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+		dw_pcie_ep_deinit(&pci->ep);
+		return ret;
+	}
+
 	return ls_pcie_ep_interrupt_init(pcie, pdev);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 9ed0a9ba7619..a6095561db4a 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -441,7 +441,18 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 		pci->ep.ops = &pcie_ep_ops;
 
-		return dw_pcie_ep_init(&pci->ep);
+		ret = dw_pcie_ep_init(&pci->ep);
+		if (ret)
+			return ret;
+
+		ret = dw_pcie_ep_init_registers(&pci->ep);
+		if (ret) {
+			dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+			dw_pcie_ep_deinit(&pci->ep);
+			return ret;
+		}
+
+		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
 	}
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 9354671644b6..3893a8c1a11c 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -815,7 +815,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	const struct pci_epc_features *epc_features;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -861,29 +860,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 		goto err_exit_epc_mem;
 	}
 
-	if (ep->ops->get_features) {
-		epc_features = ep->ops->get_features(ep);
-		if (epc_features->core_init_notifier)
-			return 0;
-	}
-
-	/*
-	 * NOTE:- Avoid accessing the hardware (Ex:- DBI space) before this
-	 * step as platforms that implement 'core_init_notifier' feature may
-	 * not have the hardware ready (i.e. core initialized) for access
-	 * (Ex: tegra194). Any hardware access on such platforms result
-	 * in system hang.
-	 */
-	ret = dw_pcie_ep_init_registers(ep);
-	if (ret)
-		goto err_free_epc_mem;
-
 	return 0;
 
-err_free_epc_mem:
-	pci_epc_mem_free_addr(epc, ep->msi_mem_phys, ep->msi_mem,
-			      epc->mem->window.page_size);
-
 err_exit_epc_mem:
 	pci_epc_mem_exit(epc);
 
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 778588b4be70..ca9b22e654cd 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -145,6 +145,15 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 
 		pci->ep.ops = &pcie_ep_ops;
 		ret = dw_pcie_ep_init(&pci->ep);
+		if (ret)
+			return ret;
+
+		ret = dw_pcie_ep_init_registers(&pci->ep);
+		if (ret) {
+			dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+			dw_pcie_ep_deinit(&pci->ep);
+		}
+
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 208d3b0ba196..250d6acf16dc 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -392,6 +392,7 @@ static int keembay_pcie_probe(struct platform_device *pdev)
 	struct keembay_pcie *pcie;
 	struct dw_pcie *pci;
 	enum dw_pcie_device_mode mode;
+	int ret;
 
 	data = device_get_match_data(dev);
 	if (!data)
@@ -426,11 +427,24 @@ static int keembay_pcie_probe(struct platform_device *pdev)
 			return -ENODEV;
 
 		pci->ep.ops = &keembay_pcie_ep_ops;
-		return dw_pcie_ep_init(&pci->ep);
+		ret = dw_pcie_ep_init(&pci->ep);
+		if (ret)
+			return ret;
+
+		ret = dw_pcie_ep_init_registers(&pci->ep);
+		if (ret) {
+			dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+			dw_pcie_ep_deinit(&pci->ep);
+			return ret;
+		}
+
+		break;
 	default:
 		dev_err(dev, "Invalid device type %d\n", pcie->mode);
 		return -ENODEV;
 	}
+
+	return 0;
 }
 
 static const struct keembay_pcie_of_data keembay_pcie_rc_of_data = {
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index 9d9d22e367bb..fb7c03639a53 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -414,6 +414,7 @@ static const struct dw_pcie_ep_ops pcie_ep_ops = {
 static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 {
 	struct dw_pcie_ep *ep = &rcar->dw.ep;
+	struct device *dev = rcar->dw.dev;
 	int ret;
 
 	if (!IS_ENABLED(CONFIG_PCIE_RCAR_GEN4_EP))
@@ -422,8 +423,17 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 	ep->ops = &pcie_ep_ops;
 
 	ret = dw_pcie_ep_init(ep);
-	if (ret)
+	if (ret) {
 		rcar_gen4_pcie_ep_deinit(rcar);
+		return ret;
+	}
+
+	ret = dw_pcie_ep_init_registers(ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+		dw_pcie_ep_deinit(ep);
+		rcar_gen4_pcie_ep_deinit(rcar);
+	}
 
 	return ret;
 }
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 3fced0d3e851..82ccaea089be 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -399,7 +399,18 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 		return ret;
 
 	priv->pci.ep.ops = &uniphier_pcie_ep_ops;
-	return dw_pcie_ep_init(&priv->pci.ep);
+	ret = dw_pcie_ep_init(&priv->pci.ep);
+	if (ret)
+		return ret;
+
+	ret = dw_pcie_ep_init_registers(&priv->pci.ep);
+	if (ret) {
+		dev_err(dev, "Failed to initialize DWC endpoint registers\n");
+		dw_pcie_ep_deinit(&priv->pci.ep);
+		return ret;
+	}
+
+	return 0;
 }
 
 static const struct uniphier_pcie_ep_soc_data uniphier_pro5_data = {

-- 
2.25.1


