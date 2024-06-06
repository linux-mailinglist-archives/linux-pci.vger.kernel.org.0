Return-Path: <linux-pci+bounces-8385-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 26AF38FDF95
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 09:27:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id A3F2A287AAD
	for <lists+linux-pci@lfdr.de>; Thu,  6 Jun 2024 07:27:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 269C813BC2B;
	Thu,  6 Jun 2024 07:27:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="T/SORt1d"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f177.google.com (mail-pf1-f177.google.com [209.85.210.177])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6F06A13AD15
	for <linux-pci@vger.kernel.org>; Thu,  6 Jun 2024 07:27:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.177
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717658844; cv=none; b=lQMTw6hndCJ7uQJlWeNfxA2DS+P1EV0IS1u5PCtcT8mzlPAUOEY/o7pL+KQE3+g052F2vJVFZ/OPFuHAwdQ3s7+sbUyeP0o0aYkJ9BtefG6VBu94sor05av6TtHfHEeonhDXLEtaxr68W6Ac6WtU0zACh5PT6iVQulUtPxH0GQE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717658844; c=relaxed/simple;
	bh=XfhruISZ6W6R/LbDDvmS/1LRRcCdxW1e2vnybSWgY64=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=G6Y11Q7e86DqA4uYefDICHAqvfkHvcTyrQWF/aUIlwbCT/EndufxWCOXbvSZIEIuq6r2Qog76qh++RXGiapCkFAa8fM0CTB4BDGcaiSZouF+xv68hpinzgCSMr40G4bNTxCqIKIhzfRMsTvhvQd66D/QkqzxY8w64v+ksaSOBzQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=T/SORt1d; arc=none smtp.client-ip=209.85.210.177
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pf1-f177.google.com with SMTP id d2e1a72fcca58-7025ca8bebcso558061b3a.3
        for <linux-pci@vger.kernel.org>; Thu, 06 Jun 2024 00:27:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1717658841; x=1718263641; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=rBwbkrCA0TqUNhFf1X74rV9wZuOSuStFGznhcPYGXFs=;
        b=T/SORt1dLRFmQtt4cyBNojEVpzJU7D1W/WDasxMJDmGeqHBYqbz5/btTFnq2/1pg5J
         nUgXm+OGQrnipBRTliyHuoKa+jL6Vy/fZOZIz0kgSHJPQPsnnjt2Xr2Yosonz07faTgi
         /px0XI6GMLuvI2DjMX1/E2BigmFUscbOREUOEUgUy1nv08S1cs187klU0cB5L8ORaHHX
         +rV3jGTNCjJb5qfqTKDqAzB5pHG9iO0ygtFm4RGU0Q6IiDK5NEGCgQjpKcjXfbKwXgvG
         ATTbNonQJ78fEnJ9m1yYno504PiZ9KtkxX+BZR7/LCZGhuQejU2xaGHD1+maEt7RljBf
         Ppww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1717658841; x=1718263641;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=rBwbkrCA0TqUNhFf1X74rV9wZuOSuStFGznhcPYGXFs=;
        b=Q9W+QPj6GnqtJF5nUm7DEF9zLZUlIJgDYNri6o6L98Vgq0w4qDwtB32R36Vx/OzSis
         Ktz0DVG31JrqKzPMbuNQXLyidsAtxyefOfHrGDeWCWDGz9A8musztigbVvygyeHZnb6x
         BPkPZgTUPO41T0otoo4Hb/wnug1yl1bHNpnXtURBbDkDA2Cyd/vfdTxr1dGkMKzJaQlC
         ox6AicyyfIu0S4+qX87U1Tsex7d+W+kqUJWFhH3ojaBhSS+R4nGfVBbf/wEWtf9NLZbu
         RWQgUnLfU6FgCH2mc7sVdK+RKvAmQh+Zm06db5BaDGIAaqminz1QXTcdXhMxLRti8xyu
         Z1ZA==
X-Forwarded-Encrypted: i=1; AJvYcCX3JM+DU9DvSvzaQiSDgo1BkFwSnlwuAduIaht+kumD/z0VAqRDh3wee4Ozip1MS9HIb7BWwENJYjsgzOvPT2r5W2Qg8dsR20n6
X-Gm-Message-State: AOJu0YwdKO3c2q2T1Wcpc6K6xvbVJkcLD58VzBFYQUTw7GHcQYGbMoGc
	VVBOyovyHBG3JPAqheMr8T72Inu7aJpjAA2L2T1qXLm4VFteCqO7QEa5upZVdA==
X-Google-Smtp-Source: AGHT+IFnIUwznqu9u6MYNsnelzJn1VgHUtykElhx3ssZeiNo68mnCPqGNdTRBVe2iI9ZvQRVR2Dx9A==
X-Received: by 2002:a05:6a00:98a:b0:6e9:38d0:5019 with SMTP id d2e1a72fcca58-703e56fb190mr5742198b3a.0.1717658840683;
        Thu, 06 Jun 2024 00:27:20 -0700 (PDT)
Received: from [127.0.1.1] ([120.60.142.92])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-703fd494feasm566621b3a.100.2024.06.06.00.27.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Jun 2024 00:27:20 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 06 Jun 2024 12:56:34 +0530
Subject: [PATCH 1/5] PCI: dwc: ep: Remove dw_pcie_ep_init_notify() wrapper
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240606-pci-deinit-v1-1-4395534520dc@linaro.org>
References: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
In-Reply-To: <20240606-pci-deinit-v1-0-4395534520dc@linaro.org>
To: Vignesh Raghavendra <vigneshr@ti.com>, 
 Siddharth Vadapalli <s-vadapalli@ti.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Richard Zhu <hongxing.zhu@nxp.com>, Lucas Stach <l.stach@pengutronix.de>, 
 Shawn Guo <shawnguo@kernel.org>, Sascha Hauer <s.hauer@pengutronix.de>, 
 Pengutronix Kernel Team <kernel@pengutronix.de>, 
 Fabio Estevam <festevam@gmail.com>, Minghuan Lian <minghuan.Lian@nxp.com>, 
 Mingkai Hu <mingkai.hu@nxp.com>, Roy Zang <roy.zang@nxp.com>, 
 Jesper Nilsson <jesper.nilsson@axis.com>, Jingoo Han <jingoohan1@gmail.com>, 
 Srikanth Thokala <srikanth.thokala@intel.com>, 
 Marek Vasut <marek.vasut+renesas@gmail.com>, 
 Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>, 
 Thierry Reding <thierry.reding@gmail.com>, 
 Jonathan Hunter <jonathanh@nvidia.com>, 
 Kunihiko Hayashi <hayashi.kunihiko@socionext.com>, 
 Masami Hiramatsu <mhiramat@kernel.org>, 
 Kishon Vijay Abraham I <kishon@kernel.org>
Cc: linux-omap@vger.kernel.org, linux-pci@vger.kernel.org, 
 linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org, 
 imx@lists.linux.dev, linuxppc-dev@lists.ozlabs.org, 
 linux-arm-kernel@axis.com, linux-arm-msm@vger.kernel.org, 
 linux-renesas-soc@vger.kernel.org, linux-tegra@vger.kernel.org, 
 mhi@lists.linux.dev, Niklas Cassel <cassel@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Bjorn Helgaas <helgaas@kernel.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=8261;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=XfhruISZ6W6R/LbDDvmS/1LRRcCdxW1e2vnybSWgY64=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBmYWTCd6OusAPWj8/EhofvKCGw0bb2fJ7CBP789
 MUhRI4+ZwmJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZmFkwgAKCRBVnxHm/pHO
 9UPbCACmpesgufNbd+/06XFOPPifCGFzoXuFNZvjloHcTt5jKhb91yQtvvslDVmrsSO7MPGXfNV
 sWYep9sTwAits18G98ywyuTzVz01h0PD/4W9QSTh+3n7svU3XY9LQy/1JOfxCJMQlsLhQTijMF6
 HSJC65HnT3yTkO+pBo/AsQtv9uHgnqv3OD63v71cK1ofkiF1Gk7GQgp0buARc1SOYAQ7UyQ7ZWO
 V151SUoUGcqz0qzCJAZXQNBVsg5NmZ3bca4RsFWH77rv4NFm54xKjWT33Skf8Gs43Wz4NLrcrqc
 ZhIF2srA1GaMOp43xafLsUweSWlQI9flN6hMwWnek6Nmh2Ja
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

Currently dw_pcie_ep_init_notify() wrapper just calls pci_epc_init_notify()
directly. So this wrapper provides no benefit to the glue drivers.

So let's remove it and call pci_epc_init_notify() directly from glue
drivers.

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           |  2 +-
 drivers/pci/controller/dwc/pci-imx6.c             |  2 +-
 drivers/pci/controller/dwc/pci-keystone.c         |  2 +-
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 +-
 drivers/pci/controller/dwc/pcie-artpec6.c         |  2 +-
 drivers/pci/controller/dwc/pcie-designware-ep.c   | 12 ------------
 drivers/pci/controller/dwc/pcie-designware-plat.c |  2 +-
 drivers/pci/controller/dwc/pcie-designware.h      |  5 -----
 drivers/pci/controller/dwc/pcie-keembay.c         |  2 +-
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |  2 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 +-
 drivers/pci/controller/dwc/pcie-tegra194.c        |  2 +-
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 +-
 13 files changed, 11 insertions(+), 28 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index d2d17d37d3e0..e491d0ff3962 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -474,7 +474,7 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 		return ret;
 	}
 
-	dw_pcie_ep_init_notify(ep);
+	pci_epc_init_notify(ep->epc);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 917c69edee1d..a876b8e6e741 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1131,7 +1131,7 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		return ret;
 	}
 
-	dw_pcie_ep_init_notify(ep);
+	pci_epc_init_notify(ep->epc);
 
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index d3a7d14ee685..ca1054f5c79a 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1293,7 +1293,7 @@ static int ks_pcie_probe(struct platform_device *pdev)
 			goto err_ep_init;
 		}
 
-		dw_pcie_ep_init_notify(&pci->ep);
+		pci_epc_init_notify(pci->ep.epc);
 
 		break;
 	default:
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index 7dde6d5fa4d8..35bb481564c7 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -286,7 +286,7 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dw_pcie_ep_init_notify(&pci->ep);
+	pci_epc_init_notify(pci->ep.epc);
 
 	return ls_pcie_ep_interrupt_init(pcie, pdev);
 }
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index a4630b92489b..dc8dd7f27b78 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -452,7 +452,7 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		dw_pcie_ep_init_notify(&pci->ep);
+		pci_epc_init_notify(pci->ep.epc);
 
 		break;
 	default:
diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 47391d7d3a73..2e69f81baf99 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -27,18 +27,6 @@ void dw_pcie_ep_linkup(struct dw_pcie_ep *ep)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_ep_linkup);
 
-/**
- * dw_pcie_ep_init_notify - Notify EPF drivers about EPC initialization complete
- * @ep: DWC EP device
- */
-void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
-{
-	struct pci_epc *epc = ep->epc;
-
-	pci_epc_init_notify(epc);
-}
-EXPORT_SYMBOL_GPL(dw_pcie_ep_init_notify);
-
 /**
  * dw_pcie_ep_get_func_from_ep - Get the struct dw_pcie_ep_func corresponding to
  *				 the endpoint function
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 8490c5d6ff9f..771b9d9be077 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -154,7 +154,7 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 			dw_pcie_ep_deinit(&pci->ep);
 		}
 
-		dw_pcie_ep_init_notify(&pci->ep);
+		pci_epc_init_notify(pci->ep.epc);
 
 		break;
 	default:
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index f8e5431a207b..49ae845a3662 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -670,7 +670,6 @@ static inline void __iomem *dw_pcie_own_conf_map_bus(struct pci_bus *bus,
 void dw_pcie_ep_linkup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init(struct dw_pcie_ep *ep);
 int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep);
-void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep);
 void dw_pcie_ep_deinit(struct dw_pcie_ep *ep);
 void dw_pcie_ep_cleanup(struct dw_pcie_ep *ep);
 int dw_pcie_ep_raise_intx_irq(struct dw_pcie_ep *ep, u8 func_no);
@@ -698,10 +697,6 @@ static inline int dw_pcie_ep_init_registers(struct dw_pcie_ep *ep)
 	return 0;
 }
 
-static inline void dw_pcie_ep_init_notify(struct dw_pcie_ep *ep)
-{
-}
-
 static inline void dw_pcie_ep_deinit(struct dw_pcie_ep *ep)
 {
 }
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 98bbc83182b4..278205db60a2 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -442,7 +442,7 @@ static int keembay_pcie_probe(struct platform_device *pdev)
 			return ret;
 		}
 
-		dw_pcie_ep_init_notify(&pci->ep);
+		pci_epc_init_notify(pci->ep.epc);
 
 		break;
 	default:
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 1ecf602c225a..4d2d7457dcb3 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -482,7 +482,7 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 	val &= ~PARF_MSTR_AXI_CLK_EN;
 	writel_relaxed(val, pcie_ep->parf + PARF_MHI_CLOCK_RESET_CTRL);
 
-	dw_pcie_ep_init_notify(&pcie_ep->pci.ep);
+	pci_epc_init_notify(pcie_ep->pci.ep.epc);
 
 	/* Enable LTSSM */
 	val = readl_relaxed(pcie_ep->parf + PARF_LTSSM);
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index cfeccc2f9ee1..237a6a8818de 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -437,7 +437,7 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 		rcar_gen4_pcie_ep_deinit(rcar);
 	}
 
-	dw_pcie_ep_init_notify(ep);
+	pci_epc_init_notify(ep->epc);
 
 	return ret;
 }
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 93f5433c5c55..432ed9d9a463 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -1903,7 +1903,7 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 		goto fail_init_complete;
 	}
 
-	dw_pcie_ep_init_notify(ep);
+	pci_epc_init_notify(ep->epc);
 
 	/* Program the private control to allow sending LTR upstream */
 	if (pcie->of_data->has_ltr_req_fix) {
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index a2b844268e28..d6e73811216e 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -410,7 +410,7 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	dw_pcie_ep_init_notify(&priv->pci.ep);
+	pci_epc_init_notify(priv->pci.ep.epc);
 
 	return 0;
 }

-- 
2.25.1


