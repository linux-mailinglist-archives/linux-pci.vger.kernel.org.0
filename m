Return-Path: <linux-pci+bounces-4404-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F267886FD5A
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:25:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7DC5D1F25813
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:25:03 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E94243611A;
	Mon,  4 Mar 2024 09:23:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qx/ZNE13"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f170.google.com (mail-pl1-f170.google.com [209.85.214.170])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4BC2225A6
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 09:23:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.170
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544230; cv=none; b=Q9Ni+ERqhdisHX69b3V+ZxVC1IZ5wtgRbhqDgJKLmrLXek8Ik+tWIBLaivj/fd2TkIaRTuRNm1N6QhaytN3Wjl4GmVeJ9oFsgxHKBXOG4Wg2RxxwVnQWNz3e5Xl8qp4twhtrgDEG94YVwhJrFvlxHAY96ZSLtvFtfgZquzNR4fk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544230; c=relaxed/simple;
	bh=YU6uuC25aD6HmjqNZdabeo9wTfVLw6zZvEjqCvQIMnE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=eT4FBGwEFu6lMHekIKsPwI0Uovvs+wggA2hHkE+pqAHkKwt4ggAvD+jCi4SmuVGgkfU2BItHnBnYjeZamcsv1dOUkQ+ETDWrZn5osS/wpGcTgsv5CiB+m90jDstJH+p5EwiLUyRb8NApDPYU8uzzIsbow/hR3C1dSUx4ZkPmE5U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=qx/ZNE13; arc=none smtp.client-ip=209.85.214.170
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f170.google.com with SMTP id d9443c01a7336-1dcafff3c50so35564005ad.0
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 01:23:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709544227; x=1710149027; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nT6lhmjvLXnA6i0OgikSdr/3C7tCoAH1ArKKxud/V4I=;
        b=qx/ZNE13UEkDEU8RWiSgOQmEOyTsuLCEpFuO4YXc6ePNBuDD/5qIPWEE15o96Tm21V
         otFSCe+zquoQJHf1PLA+39RfnI41bQP/Cu9gBt3bwvnckjbJSvMwczQHIgyN9wdmNG+D
         euk4iDIFtiZxAggcjD59R6w5lSoqAW1ChxdbSdu9cTnQ95gNLt1P71qQ077tIYr8JqU+
         vCa+euJwrpePx/UCxF8Vez3RjYRPmNMyig2HWzWEAbNz4gGAEEyA7ZarJE5EyauXpyIc
         0XLtNpWej4AWzUKV4FWvbuZZ1/C1OUyIrm4FFC5BDfp1+dY7thJMqmdHmswC1uwONEzx
         36qA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544227; x=1710149027;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nT6lhmjvLXnA6i0OgikSdr/3C7tCoAH1ArKKxud/V4I=;
        b=ssXKjzAfX+4tL31RoG/3QJmooEdcIYl9eVb8CG1YTU+gTH9jELDRqUy2lCiNueFm+a
         n30eHEHDt8N/uhEx0zYCuTMcQwfLbP+hOi3cerlPM5Y1p5nQ7dpeILUUhR2zMT/H0PCC
         E5Do4yUcllQN+21EIJ7Z0/cEesjVwnIhV6E5k1Ic7J2Ima+2+xpLHbj+75oofaJY0twK
         uL663jHM3Cy7mWTnJ2jK7IR/pW+QIffqofGK3Xyvbv4C8CAi5FJOl91h1d0LjTeNHiRZ
         uNXLiRfgD+wFL2vBfa8Q53ySYaxV4L2SiZkgI1mG0FHGhx8DpEYDFAWoHxcqmnTGDEY2
         xpWg==
X-Gm-Message-State: AOJu0YyYG9WC1l8MXS2DRQiRY+Rr86ezmPAVadm1viSsYxYp1qJeRp7v
	8pkidCP+6T/IBAhu/yMJ/7+wRjHOos7uSbcuAXtuyAtXVIDGGcuyIOK8Z2Hqew==
X-Google-Smtp-Source: AGHT+IGy2gVMxfQcLXNAPFLGR/EZCaOMpmjXIGIDKqxAW82XTLx5cKbvopxX1qPbtWq2PFFkOrQAPw==
X-Received: by 2002:a17:902:64cf:b0:1dc:efb2:95fe with SMTP id y15-20020a17090264cf00b001dcefb295femr8420199pli.48.1709544227173;
        Mon, 04 Mar 2024 01:23:47 -0800 (PST)
Received: from [127.0.1.1] ([117.202.187.165])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001dbb06b6138sm7996648plc.252.2024.03.04.01.23.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:23:46 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 04 Mar 2024 14:52:18 +0530
Subject: [PATCH v9 06/10] PCI: dwc: ep: Call dw_pcie_ep_init_registers()
 API directly from all glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci-dbi-rework-v9-6-29d433d99cda@linaro.org>
References: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
In-Reply-To: <20240304-pci-dbi-rework-v9-0-29d433d99cda@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10177;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=YU6uuC25aD6HmjqNZdabeo9wTfVLw6zZvEjqCvQIMnE=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl5ZLYcIN2HtmxaUjM9mZ+eAEiEUUHetTxfGNBF
 qInukUvYL2JATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZeWS2AAKCRBVnxHm/pHO
 9R45B/4+vSlFur+3TnDh9W6PyQJuO4RhVfMvG37PfQ2rthtfMX8QDM2v9G6eKpzgoZwpnw8oxpu
 v2NDu0oalF9ro0U+tNK87E4rgKxwcJULYSuRbMT6+iYK2YfcdB7EndVkB3tXhmRPUSP2iFV7MWN
 yvnMfKMhMxU0zrS/zvxc+h7JbrrKhK/utJ3Q/sEGwjnWstufpuQ/T+8zbvJaB9jBDh7Wqta8iTg
 haMgVoC8mZJfuDzRdwC3VZZt+AO051NNOi/miX3pDSQZ8EUPI3lHz0o1cLjRhTi8FM1KzFtjY0V
 mlZlJbrlsW1heORRWJXseycsufD/K3pRjM48y3ts6HVAd07R
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
index c0c62533a3f1..8392894ed286 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1286,6 +1286,13 @@ static int ks_pcie_probe(struct platform_device *pdev)
 		ret = dw_pcie_ep_init(&pci->ep);
 		if (ret < 0)
 			goto err_get_sync;
+
+		ret = dw_pcie_ep_init_registers(&pci->ep);
+		if (ret < 0) {
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
index 9ed0a9ba7619..0edd9ab3f139 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -441,7 +441,18 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 
 		pci->ep.ops = &pcie_ep_ops;
 
-		return dw_pcie_ep_init(&pci->ep);
+		ret = dw_pcie_ep_init(&pci->ep);
+		if (ret < 0)
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
index ed1f2afd830a..278bdc9b2269 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -729,7 +729,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	const struct pci_epc_features *epc_features;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -775,29 +774,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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


