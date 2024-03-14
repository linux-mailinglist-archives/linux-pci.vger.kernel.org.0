Return-Path: <linux-pci+bounces-4817-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id ED20A87B8E6
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 08:51:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 1C1EE1C22859
	for <lists+linux-pci@lfdr.de>; Thu, 14 Mar 2024 07:51:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DE4A52AEF5;
	Thu, 14 Mar 2024 07:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vr2vtfls"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pl1-f171.google.com (mail-pl1-f171.google.com [209.85.214.171])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5110604C7
	for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 07:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.214.171
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710402594; cv=none; b=fK+algBTAwUR/hZPhOFcLINqsZW9v0OYApUC6HRfHG79gGAZVnOzogxtyAQ83qKDSqXzbYjSBt3KTGZgsp58u/a0bMoBycayZM4YeOaHZHmTOJs31f4R7SddGcoUqptKs1uK1xYSo46L6nhE5yRZODMTHVkOWEh/HkfnT11NSAw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710402594; c=relaxed/simple;
	bh=S2uv0dCCbhiU2qhbMjneII/AXKnesPZEwsDKdaLNH1s=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=DzGrEbO2MFgPCUOJfhV7Lg2nBrJJx9ZbRAaBnzeA/YZUQW1vPA1SEKO7rKwRGgxV1M06mbCCHX6UIWCsJgZCu6B+QU5uScPw9/WD8eIDdqhbfA86EF1pLBQ1WyG/8VY6UcwGEdhp9/A3tIdhil41Yjy3UHrR4fA4SmqNBzgKdzY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vr2vtfls; arc=none smtp.client-ip=209.85.214.171
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-pl1-f171.google.com with SMTP id d9443c01a7336-1dedb92e540so1904145ad.0
        for <linux-pci@vger.kernel.org>; Thu, 14 Mar 2024 00:49:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1710402592; x=1711007392; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l1IH4JXPyGY5G2M+FE3S5VV95kQawRh2XQdzV9wj3zI=;
        b=vr2vtflsM3FYi13sFSUQNr/U0DPyyJR1RLRmGsZOaOZ4lKSV/aAO5mQJQEXtnjWJWe
         5gGazVJuM5h255fX1qOPiPwUZBI8JSegnBSLhNSqiMbHHvEU7GKzPJIUSrRgJtmuJPK1
         XqaQW+oh48iRMuAZzYKC0+6GLwCPi4qTzLgNF6IjsBnZU0gxBqdQd1vO3muPR+TrJu41
         QUYnfJRzQQ3Vd6Oi5hzvyUDZBkYloMwa610I5CVb8lR4evmMxLdovyCl9b9NBIFjPz/q
         IcrkN5POV14AN4PW49Yzt4+U8UrI7VYXtCFkeWvnVikdW8OqXPjCDhFqtmF9jDLYb5qJ
         jPFQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1710402592; x=1711007392;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=l1IH4JXPyGY5G2M+FE3S5VV95kQawRh2XQdzV9wj3zI=;
        b=ahxGNaFsovs6ud0aqCY4rOOJjWKNIPhhUzCbkFqkclY2bo+tCZ9Bc5v8Mdyd3Vd8CO
         yh/XNmaXtIy8BGzBH4ocCD7kQdJraeYx7WOctRNOcR58h/CK1jIXH0IGzwtLtZBbHFD2
         aS3RUNc20AjQDVOFiXYfJ3WJtOv5rPSbKbbyol7DwF0zpJ0U6Kr/FkkPk4T3kTYV4m3H
         Vy8/mZg5SmP+K5D7nPi7FBDKv6+mMqPlwR70F+IQyzlopoR+lwP4qvbib8bZT5twAw6b
         4/OUvLGGfAfXP+6dmfa2o1LT+ABUmrogUSA9rNmrPNkJFSS62M5FHGBHjeDchgQUWM5T
         Z08g==
X-Gm-Message-State: AOJu0YzQoj/Rudm/xi6eDH9Sc5vaxazbqcKpFvjyqtxTFZzNi3YX73Wi
	HalR74H7j3/CuoBZKJzS2/MgMbjd75vneX5sqioQ5/gf1nGVSaqZ//bLtGmLMA==
X-Google-Smtp-Source: AGHT+IFRoWC/HPBrw71SlL9Xc8OJuqzWc/bBWuQ3n9WklxGo0g0LLQYqYMly7CUmrUvwsMMbUvTFSg==
X-Received: by 2002:a17:902:da88:b0:1dd:d869:a237 with SMTP id j8-20020a170902da8800b001ddd869a237mr3907038plx.34.1710402591972;
        Thu, 14 Mar 2024 00:49:51 -0700 (PDT)
Received: from [127.0.1.1] ([117.207.30.211])
        by smtp.gmail.com with ESMTPSA id l9-20020a170903120900b001dd4fabf695sm946321plh.38.2024.03.14.00.49.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 Mar 2024 00:49:51 -0700 (PDT)
From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Date: Thu, 14 Mar 2024 13:18:06 +0530
Subject: [PATCH v10 8/8] PCI: dwc: ep: Remove "core_init_notifier" flag
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240314-pci-dbi-rework-v10-8-14a45c5a938e@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=14106;
 i=manivannan.sadhasivam@linaro.org; h=from:subject:message-id;
 bh=S2uv0dCCbhiU2qhbMjneII/AXKnesPZEwsDKdaLNH1s=;
 b=owEBbQGS/pANAwAKAVWfEeb+kc71AcsmYgBl8qvEnjDMt0fC3AEek+ZebxmAkGUV98ktdKT4w
 pi6cD4dXsCJATMEAAEKAB0WIQRnpUMqgUjL2KRYJ5dVnxHm/pHO9QUCZfKrxAAKCRBVnxHm/pHO
 9fFvB/9dsE406HBVkYP7CnZHAv77sMSzBAPSzJevA0+uFWPuaqLWI2/rgpttPDfm7VTCgMtlqO9
 SDsdL4oscB15r3Ei90fbPVvqC3TXfo1VksRWwqy9v9qA7FxckWmohHpQMRtlpYjtuKYpA6WvQP1
 IyC8guMXbFB7QzE0gYC2A2Gjj5WvgMeaTa3l/mv9NxcZLaSjvKIJjEfzIs8OtTSnmA1FpYHTnhw
 XUYk8Qgcob93j6ipCqK/4WFiVx53a3XJFwaP99oXxXEeE99NrY+EvG5ZzKMqIGRXGy2ZNFmEYbJ
 PRVWoZjTVky5Iy+iRA5J5jPXu8uYuGyDDvN55z3bSLcmrKBx
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

But this also requires the EPC core driver to deliver the notification
after EPF driver bind. Because, the glue driver can send the notification
before the EPF drivers bind() and in those cases the EPF drivers will miss
the event. To accommodate this, EPC core is now caching the state of the
EPC initialization in 'init_complete' flag and pci-ep-cfs driver sends the
notification to EPF drivers based on that after each EPF driver bind.

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
 drivers/pci/endpoint/pci-ep-cfs.c                 |  9 +++++++++
 drivers/pci/endpoint/pci-epc-core.c               | 22 ++++++++++++++++++++++
 include/linux/pci-epc.h                           |  7 ++++---
 15 files changed, 58 insertions(+), 18 deletions(-)

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
index 093dbb725e41..b7b30470b394 100644
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
index a6095561db4a..a4630b92489b 100644
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
 
diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
index 0ea64e24ed61..3b21e28f9b59 100644
--- a/drivers/pci/endpoint/pci-ep-cfs.c
+++ b/drivers/pci/endpoint/pci-ep-cfs.c
@@ -64,6 +64,9 @@ static int pci_secondary_epc_epf_link(struct config_item *epf_item,
 		return ret;
 	}
 
+	/* Send any pending EPC initialization complete to the EPF driver */
+	pci_epc_notify_pending_init(epc, epf);
+
 	return 0;
 }
 
@@ -125,6 +128,9 @@ static int pci_primary_epc_epf_link(struct config_item *epf_item,
 		return ret;
 	}
 
+	/* Send any pending EPC initialization complete to the EPF driver */
+	pci_epc_notify_pending_init(epc, epf);
+
 	return 0;
 }
 
@@ -230,6 +236,9 @@ static int pci_epc_epf_link(struct config_item *epc_item,
 		return ret;
 	}
 
+	/* Send any pending EPC initialization complete to the EPF driver */
+	pci_epc_notify_pending_init(epc, epf);
+
 	return 0;
 }
 
diff --git a/drivers/pci/endpoint/pci-epc-core.c b/drivers/pci/endpoint/pci-epc-core.c
index dcd4e66430c1..ba2ff037dfa6 100644
--- a/drivers/pci/endpoint/pci-epc-core.c
+++ b/drivers/pci/endpoint/pci-epc-core.c
@@ -753,10 +753,32 @@ void pci_epc_init_notify(struct pci_epc *epc)
 			epf->event_ops->core_init(epf);
 		mutex_unlock(&epf->lock);
 	}
+	epc->init_complete = true;
 	mutex_unlock(&epc->list_lock);
 }
 EXPORT_SYMBOL_GPL(pci_epc_init_notify);
 
+/**
+ * pci_epc_notify_pending_init() - Notify the pending EPC device initialization
+ *                                 complete to the EPF device
+ * @epc: the EPC device whose core initialization is pending to be notified
+ * @epf: the EPF device to be notified
+ *
+ * Invoke to notify the pending EPC device initialization complete to the EPF
+ * device. This is used to deliver the notification if the EPC initialization
+ * got completed before the EPF driver bind.
+ */
+void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf)
+{
+	if (epc->init_complete) {
+		mutex_lock(&epf->lock);
+		if (epf->event_ops && epf->event_ops->core_init)
+			epf->event_ops->core_init(epf);
+		mutex_unlock(&epf->lock);
+	}
+}
+EXPORT_SYMBOL_GPL(pci_epc_notify_pending_init);
+
 /**
  * pci_epc_bme_notify() - Notify the EPF device that the EPC device has received
  *			  the BME event from the Root complex
diff --git a/include/linux/pci-epc.h b/include/linux/pci-epc.h
index 40ea18f5aa02..adee6dbe4e45 100644
--- a/include/linux/pci-epc.h
+++ b/include/linux/pci-epc.h
@@ -128,6 +128,8 @@ struct pci_epc_mem {
  * @group: configfs group representing the PCI EPC device
  * @lock: mutex to protect pci_epc ops
  * @function_num_map: bitmap to manage physical function number
+ * @init_complete: flag to indicate whether the EPC initialization is complete
+ *                 or not
  */
 struct pci_epc {
 	struct device			dev;
@@ -143,13 +145,12 @@ struct pci_epc {
 	/* mutex to protect against concurrent access of EP controller */
 	struct mutex			lock;
 	unsigned long			function_num_map;
+	bool				init_complete;
 };
 
 /**
  * struct pci_epc_features - features supported by a EPC device per function
  * @linkup_notifier: indicate if the EPC device can notify EPF driver on link up
- * @core_init_notifier: indicate cores that can notify about their availability
- *			for initialization
  * @msi_capable: indicate if the endpoint function has MSI capability
  * @msix_capable: indicate if the endpoint function has MSI-X capability
  * @reserved_bar: bitmap to indicate reserved BAR unavailable to function driver
@@ -159,7 +160,6 @@ struct pci_epc {
  */
 struct pci_epc_features {
 	unsigned int	linkup_notifier : 1;
-	unsigned int	core_init_notifier : 1;
 	unsigned int	msi_capable : 1;
 	unsigned int	msix_capable : 1;
 	u8	reserved_bar;
@@ -198,6 +198,7 @@ int pci_epc_add_epf(struct pci_epc *epc, struct pci_epf *epf,
 void pci_epc_linkup(struct pci_epc *epc);
 void pci_epc_linkdown(struct pci_epc *epc);
 void pci_epc_init_notify(struct pci_epc *epc);
+void pci_epc_notify_pending_init(struct pci_epc *epc, struct pci_epf *epf);
 void pci_epc_bme_notify(struct pci_epc *epc);
 void pci_epc_remove_epf(struct pci_epc *epc, struct pci_epf *epf,
 			enum pci_epc_interface_type type);

-- 
2.25.1


