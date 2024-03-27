Return-Path: <linux-pci+bounces-5225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CB8CB88D6B8
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 07:41:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 430D31F2B0C3
	for <lists+linux-pci@lfdr.de>; Wed, 27 Mar 2024 06:41:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2B82C28DDA;
	Wed, 27 Mar 2024 06:38:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JcZ6r7Ee"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f181.google.com (mail-pl1-f181.google.com [209.85.214.181])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A79A5249F9
	for <linux-pci@vger.kernel.org>; Wed, 27 Mar 2024 06:38:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.181
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1711521531; cv=none; b=Uz4vxTxh1h56VgYEMldqNbMNTU21IMUFg8ffJbaSe7vAEpT5Z9WsveIVKPnf4QT9EJyS/i5fFbqKAuHiiesv1ltOZr23S2G+aZnh4B4aqwEfVKAIbzxsKtYAACLai2+ztK0Ee0Xr2r6meSLr1ZuEBX17veUd844RPaNK6lOZQ1c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1711521531; c=relaxed/simple;
	bh=HT8mYRFEiEOrZ4AEzvjFFuqf3lA4zb6wHwZveBg0F/Y=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=jaDlGChHLWAr7HVA/NlFwOfHv1TjipXRFsdeIVOrpEIEUrJH4dDwyw5/Qv5RyxeY1U82ZwI4JYRg+x6hYYp+wGyUW9KUHGFPjtu1NG+0NJcd7G50RcaR1oWXUCEHa7prISayVJD4BfslSaDyGchBv9JWQzwPWhpHzLDIs146ibc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=JcZ6r7Ee; arc=none smtp.client-ip=209.85.214.181
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f181.google.com with SMTP id d9443c01a7336-1de0f92e649so45281185ad.0
        for <linux-pci@vger.kernel.org>; Tue, 26 Mar 2024 23:38:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1711521527; x=1712126327; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=X+vm2xfJuGQk9g8hvOnhJ4uj198JRCu1Uxsa6mYgQcI=;
        b=JcZ6r7Ee++fFS2oRN9IOq9NNg8NQztkeDp48pySkp3xg4u/65aRKnk5kh1qUJA3ONw
         7N7UkJTuLTN3rfP/BgZT6fS5CWSSWKVRBOqfAp6xS5Qzn1yoxa0Ky6RFmEsqxbVZDwHG
         7jKqtxFOsCbd3YyyJlCQORlzAT46sXWAoJa6iEWUGMRKrdtFT6YH/x2IW4j7Qb5ihld4
         vPs9iAs3BVD+yjoubSEKyXNBtsCD814kS8gjIMyccPC0V54j5dVm0bAgwLDNJUWh13bG
         MVNnVNBbzBZZZdBHMFNpi5PEzhXk3tqLsO58voDxZtN21hXWGZLIbTf2H+cnqvKGz2RM
         DnCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1711521527; x=1712126327;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=X+vm2xfJuGQk9g8hvOnhJ4uj198JRCu1Uxsa6mYgQcI=;
        b=imdddDl4K9laEgua55bKBRvi+vuAqnywAFih1KrwFPLavtrpQJ1t8lg0t35QQXYS21
         7/SNq52X5Yp6lGVqHW3yjD762xGst5Y7nLRuuCaHDrewQz/Du/2bfdHAep1V4TmxleP/
         tDgi0d+MY0E4cSdyHAwHejXlp6Uzuc85G60MMQxQGuqtSLsOf+hRUeSVD5Sn5+bQ9vPf
         cPKdIPN3y7DmElvEtBAeTjaUCm1mJcMPSgDMt1qi7fThv566Ze5RdaahPviJNbHap38F
         u2OfVA6FYSUL3NWcJPOHLo7XiB3vB4yoqwc1lK5YETQ98HwMDlXKAATnbKYedXqh8NcL
         MeWA==
X-Gm-Message-State: AOJu0Yzdm39ifqppisXM0Jm666ynYI7Y5vAM6JXjkiALWHyV8DoG1rsj
	v0c0bV/58gSI91L7nAQsfYvhcrZuKCu/kovMtf01AEBjxVS4om2Oy5o9IPTTfw==
X-Google-Smtp-Source: AGHT+IHXhlZ06x6s0gya6VOw+TWhnjhfFzBzoUrpzm4OTZ/GQqMBYUFp8otoB42XMXdypFy2Un7rbA==
X-Received: by 2002:a17:902:7246:b0:1e0:2b2c:2e45 with SMTP id c6-20020a170902724600b001e02b2c2e45mr5100710pll.49.1711521526813;
        Tue, 26 Mar 2024 23:38:46 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.28.168])
        by smtp.gmail.com with ESMTPSA id r9-20020a170902be0900b001e14807c7dfsm602553pls.86.2024.03.26.23.38.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 26 Mar 2024 23:38:46 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Wed, 27 Mar 2024 12:05:53 +0530
Subject: [PATCH v11 7/8] PCI: dwc: ep: Call dw_pcie_ep_init_registers() API
 directly from all glue drivers
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240327-pci-dbi-rework-v11-7-6f5259f90673@linaro.org>
References: <20240327-pci-dbi-rework-v11-0-6f5259f90673@linaro.org>
In-Reply-To: <20240327-pci-dbi-rework-v11-0-6f5259f90673@linaro.org>
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
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Shawn Lin <shawn.lin@rock-chips.com>, Heiko Stuebner <heiko@sntech.de>
Cc: linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-tegra@vger.kernel.org, linux-omap@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, 
 Niklas Cassel <cassel@kernel.org>, linux-arm-kernel@axis.com, 
 linux-rockchip@lists.infradead.org, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10284;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=HT8mYRFEiEOrZ4AEzvjFFuqf3lA4zb6wHwZveBg0F/Y=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmA75Wsxw9U7N5x7/STcj+Acu5a6KytXfPANi3l
 /XDJJI97oqJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZgO+VgAKCRBVnxHm/pHO
 9Z9fB/4hnssnxHBSrvxgAiOhgzWRSTAOyrUzUzACpwkISltJK4PvwEU2sUNdnyBXyG8xzTY9SzR
 m8VVNC2BXui03vP1NN6rmeiek2QGIXV9qVeALQx3LeGGXcnC2yivk+2ye46/d+4VLEJ10sGOe8W
 fEEU87Visy0kgXjxreu/GC5KFOO+j9e7tylD2XKT1o3waF7RzuDoZf9tBgMctpMxQMYXhWr8b4U
 m+PsuyU2dZtE8iYgbM4vuRMgvNKsKjOr/xQTJGvOVOPviURZGYC7ISeiOzUKkKz6u/p15hQ4m4k
 0uNsODTwuEd/NAODOWAJFOpaj1LvQsRpP50iUKG5DE7yRX0W
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
Reviewed-by: Niklas Cassel <cassel@kernel.org>
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
index 0c13fdb8554e..e0c654f242d2 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -814,7 +814,6 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
 	struct device *dev = pci->dev;
 	struct platform_device *pdev = to_platform_device(dev);
 	struct device_node *np = dev->of_node;
-	const struct pci_epc_features *epc_features;
 
 	INIT_LIST_HEAD(&ep->func_list);
 
@@ -860,29 +859,8 @@ int dw_pcie_ep_init(struct dw_pcie_ep *ep)
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


