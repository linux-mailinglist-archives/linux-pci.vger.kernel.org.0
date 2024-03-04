Return-Path: <linux-pci+bounces-4405-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B1ED686FD62
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 10:25:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 293ED1F261D6
	for <lists+linux-pci@lfdr.de>; Mon,  4 Mar 2024 09:25:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2718936B15;
	Mon,  4 Mar 2024 09:24:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KPoBqaVB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f173.google.com (mail-pl1-f173.google.com [209.85.214.173])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5A67E22606
	for <linux-pci@vger.kernel.org>; Mon,  4 Mar 2024 09:23:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.173
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709544240; cv=none; b=uNaFdia9/pFijFWmcYLWrfvxmHvyIOyM7YyW1NJp74nn+egVSwdO+W37RzHU+Gprener9STeorfExglyZVKHyAI7wdqjJlRVV6A0DPHdSHLjGcPneRTwO5+1FdKWoRrTtRA+lxnhtEptNaWMnYJPwkxVWLif4pOal6ysqyK1Q0o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709544240; c=relaxed/simple;
	bh=ALDuMMl/4VacDFp2rXtfSsfBLEP+oKzgpufvjMRhYbo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=pj0yyZY8cc034zVO95wWouBG7Kdsx5gDQgER/qhIujCXcuhaCwEgmHgG+yEAg80pqjGQf6FfWOEluCLtnWF6MW1cP6UZGcuBOaG2dEzFYL0aYia73STSK05lD0UTaYQqlU50FoIgDKjuFXynTzVOP4AfXnpmdJlCyXCV3TFNCSA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=KPoBqaVB; arc=none smtp.client-ip=209.85.214.173
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f173.google.com with SMTP id d9443c01a7336-1dcd0431f00so26060425ad.3
        for <linux-pci@vger.kernel.org>; Mon, 04 Mar 2024 01:23:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709544237; x=1710149037; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PBtLDELmPejkFrztuVPGbGajWFWnpIeAa6/C89wcLug=;
        b=KPoBqaVBlfgxo3KifK/9RSp1qBdk5J7Z1teXaNxn8ohpoaxNn+cS13/1HoB4H938z7
         RRVOrYsA02wXOYrp8GRlAHBQlKFWkAbo4WVtNpY4Wcze+sbhxPDID+7Pb7nrITIXigFX
         zevH3T0KGocyUoNDKwZr1tqcaKLDMwZ1A7BcjYu6aFTsxej29UQVZA6c9NowdvPY3g1O
         uvl1/H7eJuI2ouYrOZx9qtxlRBEtNWbeK47aCNH+kFf7wzo+YsZuFuZSTg+kQCAAtylC
         hKt17AHwSb5uPhMyqQbl5Zz8AD09Xi56AOK7ankMrBhcgOgv31n1ZsCFfbgo4akhW0Wj
         NjUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709544237; x=1710149037;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=PBtLDELmPejkFrztuVPGbGajWFWnpIeAa6/C89wcLug=;
        b=mrW8mOMnNcHG841/WtynnRT3P14Yea/7WHeCcdJDYf5ZEg+eCLCU0RawWyf4WtoNq8
         s0Nx+Vqq06zskV6rBxCq+4uRnEM2MgIz//+/8uoxU1xAs6YEj/0mAalYcHV6lZEBNntD
         TOwE6b+bPEJvVxQQR/uBxufqheCqtutblJgej7pzzLPN8isvlqZQQ5ziixF+pel+HLZN
         zU3c9WiN3XdaJNLHgxHCmnOCgKfHXnvh5JalEA8cuKJz+Itwiqy7PXYHONMFUyxm3Dq1
         QW3ZDlJ26OzsCvohfN+NPYoFe4k1blBFh421uiFGnw28a4+zPXAzqib4s9hAeN1b6Dxc
         u06w==
X-Gm-Message-State: AOJu0YymCoJfd35Ch2reMLodxf+sh6axXuLZ9tF6Pd97VjBLDafJxopI
	NwEBs4rQfcredffUYM4Qvl9lHc4vE4HJ9lmNN1XRLJFvg1veO/t9hv8NdDtq2A==
X-Google-Smtp-Source: AGHT+IEN5Xe7smtj0LndmnN98IcerjJ8D5AUlzw5HmtSYe8uLYoKHQRtja1OtGWbt7hTGMv6A2a/3w==
X-Received: by 2002:a17:903:1248:b0:1dc:adad:f54b with SMTP id u8-20020a170903124800b001dcadadf54bmr8200670plh.44.1709544237546;
        Mon, 04 Mar 2024 01:23:57 -0800 (PST)
Received: from [127.0.1.1] ([117.202.187.165])
        by smtp.gmail.com with ESMTPSA id c5-20020a170902c1c500b001dbb06b6138sm7996648plc.252.2024.03.04.01.23.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 04 Mar 2024 01:23:57 -0800 (PST)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Mon, 04 Mar 2024 14:52:19 +0530
Subject: [PATCH v9 07/10] PCI: dwc: ep: Remove "core_init_notifier" flag
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240304-pci-dbi-rework-v9-7-29d433d99cda@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Frank Li <Frank.Li@nxp.com>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10207;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=ALDuMMl/4VacDFp2rXtfSsfBLEP+oKzgpufvjMRhYbo=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl5ZLYJdu1ZP+SJfRRxq1sVltolbiLND5zZGgry
 r3Q1JJfojuJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZeWS2AAKCRBVnxHm/pHO
 9WGrB/9Am4/9/VPPUjYtP3Q69jkVJozYMjPhxFrNTu3jRZq1kykggS1qEBSTZ+lR2BA5o1EDqD2
 OlQ+LoEgEMGQS+fWXEAYJUtKe51SSHSbtw5yBraJDCHqkev+pnc5pVWJrG1gCR5J0k9sG7uToZ8
 d2U7dDTYIWbGYst3l/8YzhaloV0dtDIKkG4Yf8oaJeXz9CNlxGDfbM0kwMsaMlDKKMRTF4XEV1X
 +G3tZuQEigOuf+y2+Xp5dDVEPaXKWMd0HMhb4SktUT38FcuR7Sg6RwTCBJmVbtESDGGLZMyJwgX
 gwC/q3T/GiMySqIT18xia4VYb+EHxiQhwxSlZYDvc7sTFIcF
X-Developer-Key: i=manivannan.sadhasivam@linaro.org; a=openpgp;
 fpr=C668AEC3C3188E4C611465E7488550E901166008

"core_init_notifier" flag is set by the glue drivers requiring refclk from
the host to complete the DWC core initialization. Also, those drivers will
send a notification to the EPF drivers once the initialization is fully
completed using the pci_epc_init_notify() API. Only then, the EPF drivers
will start functioning.

For the rest of the drivers generating refclk locally, EPF drivers will
start functioning post binding with them. EPF drivers rely on the
'core_init_notifier' flag to differentiate between the drivers.
Unfortunately, this creates two different flows for the EPF drivers.

So to avoid that, let's get rid of the "core_init_notifier" flag and follow
a single initialization flow for the EPF drivers. This is done by calling
the dw_pcie_ep_init_notify() from all glue drivers after the completion of
dw_pcie_ep_init_registers() API. This will allow all the glue drivers to
send the notification to the EPF drivers once the initialization is fully
completed.

Only difference here is that, the drivers requiring refclk from host will
send the notification once refclk is received, while others will send it
during probe time itself.

Reviewed-by: Frank Li <Frank.Li@nxp.com>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           |  2 ++
 drivers/pci/controller/dwc/pci-imx6.c             |  2 ++
 drivers/pci/controller/dwc/pci-keystone.c         |  2 ++
 drivers/pci/controller/dwc/pci-layerscape-ep.c    |  2 ++
 drivers/pci/controller/dwc/pcie-artpec6.c         |  2 ++
 drivers/pci/controller/dwc/pcie-designware-plat.c |  2 ++
 drivers/pci/controller/dwc/pcie-keembay.c         |  2 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c         |  1 -
 drivers/pci/controller/dwc/pcie-rcar-gen4.c       |  2 ++
 drivers/pci/controller/dwc/pcie-tegra194.c        |  1 -
 drivers/pci/controller/dwc/pcie-uniphier-ep.c     |  2 ++
 drivers/pci/endpoint/functions/pci-epf-test.c     | 18 +++++-------------
 include/linux/pci-epc.h                           |  3 ---
 13 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 395042b29ffc..d2d17d37d3e0 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -474,6 +474,8 @@ static int dra7xx_add_pcie_ep(struct dra7xx_pcie *dra7xx,
 		return ret;
 	}
 
+	dw_pcie_ep_init_notify(ep);
+
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index bfcafa440ddb..894b5de76e3a 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -1144,6 +1144,8 @@ static int imx6_add_pcie_ep(struct imx6_pcie *imx6_pcie,
 		return ret;
 	}
 
+	dw_pcie_ep_init_notify(ep);
+
 	/* Start LTSSM. */
 	imx6_pcie_ltssm_enable(dev);
 
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 8392894ed286..1d00c5fa14ce 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -1293,6 +1293,8 @@ static int ks_pcie_probe(struct platform_device *pdev)
 			goto err_ep_init;
 		}
 
+		dw_pcie_ep_init_notify(&pci->ep);
+
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", mode);
diff --git a/drivers/pci/controller/dwc/pci-layerscape-ep.c b/drivers/pci/controller/dwc/pci-layerscape-ep.c
index b712fdd06549..c513598a46d7 100644
--- a/drivers/pci/controller/dwc/pci-layerscape-ep.c
+++ b/drivers/pci/controller/dwc/pci-layerscape-ep.c
@@ -283,6 +283,8 @@ static int __init ls_pcie_ep_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dw_pcie_ep_init_notify(&pci->ep);
+
 	return ls_pcie_ep_interrupt_init(pcie, pdev);
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 0edd9ab3f139..fd49a67cd2b1 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -452,6 +452,8 @@ static int artpec6_pcie_probe(struct platform_device *pdev)
 			return ret;
 		}
 
+		dw_pcie_ep_init_notify(&pci->ep);
+
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", artpec6_pcie->mode);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index ca9b22e654cd..8490c5d6ff9f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -154,6 +154,8 @@ static int dw_plat_pcie_probe(struct platform_device *pdev)
 			dw_pcie_ep_deinit(&pci->ep);
 		}
 
+		dw_pcie_ep_init_notify(&pci->ep);
+
 		break;
 	default:
 		dev_err(dev, "INVALID device type %d\n", dw_plat_pcie->mode);
diff --git a/drivers/pci/controller/dwc/pcie-keembay.c b/drivers/pci/controller/dwc/pcie-keembay.c
index 250d6acf16dc..9fa9354a5f48 100644
--- a/drivers/pci/controller/dwc/pcie-keembay.c
+++ b/drivers/pci/controller/dwc/pcie-keembay.c
@@ -438,6 +438,8 @@ static int keembay_pcie_probe(struct platform_device *pdev)
 			return ret;
 		}
 
+		dw_pcie_ep_init_notify(&pci->ep);
+
 		break;
 	default:
 		dev_err(dev, "Invalid device type %d\n", pcie->mode);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 3697b4a944cc..2fb8c15e7a91 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -775,7 +775,6 @@ static void qcom_pcie_ep_init_debugfs(struct qcom_pcie_ep *pcie_ep)
 
 static const struct pci_epc_features qcom_pcie_epc_features = {
 	.linkup_notifier = true,
-	.core_init_notifier = true,
 	.msi_capable = true,
 	.msix_capable = false,
 	.align = SZ_4K,
diff --git a/drivers/pci/controller/dwc/pcie-rcar-gen4.c b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
index fb7c03639a53..0448928017f3 100644
--- a/drivers/pci/controller/dwc/pcie-rcar-gen4.c
+++ b/drivers/pci/controller/dwc/pcie-rcar-gen4.c
@@ -435,6 +435,8 @@ static int rcar_gen4_add_dw_pcie_ep(struct rcar_gen4_pcie *rcar)
 		rcar_gen4_pcie_ep_deinit(rcar);
 	}
 
+	dw_pcie_ep_init_notify(ep);
+
 	return ret;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 264ee76bf008..e02deb31a72d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -2006,7 +2006,6 @@ static int tegra_pcie_ep_raise_irq(struct dw_pcie_ep *ep, u8 func_no,
 
 static const struct pci_epc_features tegra_pcie_epc_features = {
 	.linkup_notifier = true,
-	.core_init_notifier = true,
 	.msi_capable = false,
 	.msix_capable = false,
 	.reserved_bar = 1 << BAR_2 | 1 << BAR_3 | 1 << BAR_4 | 1 << BAR_5,
diff --git a/drivers/pci/controller/dwc/pcie-uniphier-ep.c b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
index 82ccaea089be..eb1d79fdb1f1 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier-ep.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier-ep.c
@@ -410,6 +410,8 @@ static int uniphier_pcie_ep_probe(struct platform_device *pdev)
 		return ret;
 	}
 
+	dw_pcie_ep_init_notify(&priv->pci.ep);
+
 	return 0;
 }
 
diff --git a/drivers/pci/endpoint/functions/pci-epf-test.c b/drivers/pci/endpoint/functions/pci-epf-test.c
index 18c80002d3bd..fc0282b0d626 100644
--- a/drivers/pci/endpoint/functions/pci-epf-test.c
+++ b/drivers/pci/endpoint/functions/pci-epf-test.c
@@ -753,6 +753,7 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 	const struct pci_epc_features *epc_features;
 	struct pci_epc *epc = epf->epc;
 	struct device *dev = &epf->dev;
+	bool linkup_notifier = false;
 	bool msix_capable = false;
 	bool msi_capable = true;
 	int ret;
@@ -795,6 +796,10 @@ static int pci_epf_test_core_init(struct pci_epf *epf)
 		}
 	}
 
+	linkup_notifier = epc_features->linkup_notifier;
+	if (!linkup_notifier)
+		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
+
 	return 0;
 }
 
@@ -901,8 +906,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	const struct pci_epc_features *epc_features;
 	enum pci_barno test_reg_bar = BAR_0;
 	struct pci_epc *epc = epf->epc;
-	bool linkup_notifier = false;
-	bool core_init_notifier = false;
 
 	if (WARN_ON_ONCE(!epc))
 		return -EINVAL;
@@ -913,8 +916,6 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 		return -EOPNOTSUPP;
 	}
 
-	linkup_notifier = epc_features->linkup_notifier;
-	core_init_notifier = epc_features->core_init_notifier;
 	test_reg_bar = pci_epc_get_first_free_bar(epc_features);
 	if (test_reg_bar < 0)
 		return -EINVAL;
@@ -927,21 +928,12 @@ static int pci_epf_test_bind(struct pci_epf *epf)
 	if (ret)
 		return ret;
 
-	if (!core_init_notifier) {
-		ret = pci_epf_test_core_init(epf);
-		if (ret)
-			return ret;
-	}
-
 	epf_test->dma_supported = true;
 
 	ret = pci_epf_test_init_dma_chan(epf_test);
 	if (ret)
 		epf_test->dma_supported = false;
 
-	if (!linkup_notifier && !core_init_notifier)
-		queue_work(kpcitest_workqueue, &epf_test->cmd_handler.work);
-
 	return 0;
 }
 
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 40ea18f5aa02..03d22aed5ac6 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -148,8 +148,6 @@ struct pci_epc {
 /**
  * struct pci_epc_features - features supported by a EPC device per function
  * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
- * @core_init_notifier: indicate cores that can notify about their availability
- *			for initialization
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
@@ -159,7 +157,6 @@ struct pci_epc {
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
-	unsigned int	core_init_notifier : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;

-- 
2.25.1


