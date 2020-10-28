Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BA6F829D397
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:45:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726174AbgJ1VpW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:45:22 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:33670 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726906AbgJ1VpS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:45:18 -0400
Received: by mail-oi1-f196.google.com with SMTP id s21so1165415oij.0;
        Wed, 28 Oct 2020 14:45:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3f0Grh42ZXhkDcqsiWAcs+2warthhi55z2r1eiQ7l4U=;
        b=dzh53Ba1a4wjEPNIm6hmVuEQ1r5ebdcHXkyiDX8l7kL4Ssz9Y6/itQyd5YxgqqKOOQ
         +CZGes8FhmaFRpWKIA4k87g+fSYcc2vlfBjndmecUzB8vl9WsTdF8ttVzqZnj0DDhUBU
         fdPN6JYemGwHWHpJnnIP4gtnjCLpLMZWZSECswO0cK7tNqFCbGC/Q6O5gRsIPYICuvWS
         d25wFp1/bFczsJ83ubPwuJdeZc3zl3q71W8ce/dTpiG1wm43FXDk3MxFfTYfBAZhzQ5v
         VAttw6t84tOawneY02l5wU38LpczvX0Y98hFxsMhSCXXaL7Kf3C8cS1a/qOF817I1/Mw
         BnTg==
X-Gm-Message-State: AOAM532SpXBaBJwyriZ4MJorjNCherPvTgeVSeoA+5vlaO6xAnOHwk8q
        f0U/tQF0p5p4SVPLeJJr6Ms7ctT0xg==
X-Google-Smtp-Source: ABdhPJzFXxcT0tFjUFgUe2veP94zpqVlbkMj7iwKYTjRdv+miSgd8eDz4naCuErppyRGeYwRvb3fGw==
X-Received: by 2002:aca:37c5:: with SMTP id e188mr605435oia.159.1603918040453;
        Wed, 28 Oct 2020 13:47:20 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:47:19 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Fabio Estevam <festevam@gmail.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Minghuan Lian <minghuan.Lian@nxp.com>,
        Mingkai Hu <mingkai.hu@nxp.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Roy Zang <roy.zang@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>
Subject: [PATCH 12/13] PCI: dwc: Move dw_pcie_setup_rc() to DWC common code
Date:   Wed, 28 Oct 2020 15:46:45 -0500
Message-Id: <20201028204646.356535-13-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

All RC complex drivers must call dw_pcie_setup_rc(). The ordering of the
call shouldn't be too important other than being after any RC resets.

There's a few calls of dw_pcie_setup_rc() left as drivers implementing
suspend/resume need it.

Cc: Kishon Vijay Abraham I <kishon@ti.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Kukjin Kim <kgene@kernel.org>
Cc: Krzysztof Kozlowski <krzk@kernel.org>
Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Murali Karicheri <m-karicheri2@ti.com>
Cc: Minghuan Lian <minghuan.Lian@nxp.com>
Cc: Mingkai Hu <mingkai.hu@nxp.com>
Cc: Roy Zang <roy.zang@nxp.com>
Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Neil Armstrong <narmstrong@baylibre.com>
Cc: Jerome Brunet <jbrunet@baylibre.com>
Cc: Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc: Thomas Petazzoni <thomas.petazzoni@bootlin.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Pratyush Anand <pratyush.anand@gmail.com>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-omap@vger.kernel.org
Cc: linux-samsung-soc@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@axis.com
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-dra7xx.c           | 1 -
 drivers/pci/controller/dwc/pci-exynos.c           | 1 -
 drivers/pci/controller/dwc/pci-imx6.c             | 1 -
 drivers/pci/controller/dwc/pci-keystone.c         | 2 --
 drivers/pci/controller/dwc/pci-layerscape.c       | 2 --
 drivers/pci/controller/dwc/pci-meson.c            | 2 --
 drivers/pci/controller/dwc/pcie-armada8k.c        | 2 --
 drivers/pci/controller/dwc/pcie-artpec6.c         | 1 -
 drivers/pci/controller/dwc/pcie-designware-host.c | 1 +
 drivers/pci/controller/dwc/pcie-designware-plat.c | 8 --------
 drivers/pci/controller/dwc/pcie-histb.c           | 3 ---
 drivers/pci/controller/dwc/pcie-kirin.c           | 2 --
 drivers/pci/controller/dwc/pcie-qcom.c            | 1 -
 drivers/pci/controller/dwc/pcie-spear13xx.c       | 2 --
 drivers/pci/controller/dwc/pcie-uniphier.c        | 2 --
 15 files changed, 1 insertion(+), 30 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-dra7xx.c b/drivers/pci/controller/dwc/pci-dra7xx.c
index 72a5a2bf933b..b105af63854a 100644
--- a/drivers/pci/controller/dwc/pci-dra7xx.c
+++ b/drivers/pci/controller/dwc/pci-dra7xx.c
@@ -181,7 +181,6 @@ static int dra7xx_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct dra7xx_pcie *dra7xx = to_dra7xx_pcie(pci);
 
-	dw_pcie_setup_rc(pp);
 	dra7xx_pcie_enable_interrupts(dra7xx);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pci-exynos.c b/drivers/pci/controller/dwc/pci-exynos.c
index 3939fe22e8a2..5c10a5432896 100644
--- a/drivers/pci/controller/dwc/pci-exynos.c
+++ b/drivers/pci/controller/dwc/pci-exynos.c
@@ -372,7 +372,6 @@ static int exynos_pcie_host_init(struct pcie_port *pp)
 	phy_init(ep->phy);
 
 	exynos_pcie_deassert_core_reset(ep);
-	dw_pcie_setup_rc(pp);
 	exynos_pcie_assert_reset(ep);
 
 	exynos_pcie_enable_interrupts(ep);
diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index c808b563486f..4ba0b1195ecf 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -834,7 +834,6 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	imx6_pcie_init_phy(imx6_pcie);
 	imx6_pcie_deassert_core_reset(imx6_pcie);
 	imx6_setup_phy_mpll(imx6_pcie);
-	dw_pcie_setup_rc(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pci-keystone.c b/drivers/pci/controller/dwc/pci-keystone.c
index 90b222b020a3..5a4bcc2b1ddb 100644
--- a/drivers/pci/controller/dwc/pci-keystone.c
+++ b/drivers/pci/controller/dwc/pci-keystone.c
@@ -807,8 +807,6 @@ static int __init ks_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
-	dw_pcie_setup_rc(pp);
-
 	ks_pcie_stop_link(pci);
 	ks_pcie_setup_rc_app_regs(ks_pcie);
 	writew(PCI_IO_RANGE_TYPE_32 | (PCI_IO_RANGE_TYPE_32 << 8),
diff --git a/drivers/pci/controller/dwc/pci-layerscape.c b/drivers/pci/controller/dwc/pci-layerscape.c
index 0d84986c4c16..400ebbebd00f 100644
--- a/drivers/pci/controller/dwc/pci-layerscape.c
+++ b/drivers/pci/controller/dwc/pci-layerscape.c
@@ -136,8 +136,6 @@ static int ls_pcie_host_init(struct pcie_port *pp)
 
 	ls_pcie_drop_msg_tlp(pcie);
 
-	dw_pcie_setup_rc(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index 2df0adcf0bf2..04589f0decb2 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -380,8 +380,6 @@ static int meson_pcie_host_init(struct pcie_port *pp)
 	meson_set_max_payload(mp, MAX_PAYLOAD_SIZE);
 	meson_set_max_rd_req_size(mp, MAX_READ_REQ_SIZE);
 
-	dw_pcie_setup_rc(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-armada8k.c b/drivers/pci/controller/dwc/pcie-armada8k.c
index dd2926bbb901..4e2552dcf982 100644
--- a/drivers/pci/controller/dwc/pcie-armada8k.c
+++ b/drivers/pci/controller/dwc/pcie-armada8k.c
@@ -171,8 +171,6 @@ static int armada8k_pcie_host_init(struct pcie_port *pp)
 	u32 reg;
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 
-	dw_pcie_setup_rc(pp);
-
 	if (!dw_pcie_link_up(pci)) {
 		/* Disable LTSSM state machine to enable configuration */
 		reg = dw_pcie_readl_dbi(pci, PCIE_GLOBAL_CONTROL_REG);
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 7ee8f3c83f8f..fcba9915a606 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -328,7 +328,6 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
 	artpec6_pcie_wait_for_phy(artpec6_pcie);
-	dw_pcie_setup_rc(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 025514e00a42..785850a022c7 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -423,6 +423,7 @@ int dw_pcie_host_init(struct pcie_port *pp)
 			goto err_free_msi;
 	}
 
+	dw_pcie_setup_rc(pp);
 	dw_pcie_msi_init(pp);
 
 	if (!dw_pcie_link_up(pci) && pci->ops->start_link) {
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index dec24e595c3e..9b397c807261 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -33,15 +33,7 @@ struct dw_plat_pcie_of_data {
 
 static const struct of_device_id dw_plat_pcie_of_match[];
 
-static int dw_plat_pcie_host_init(struct pcie_port *pp)
-{
-	dw_pcie_setup_rc(pp);
-
-	return 0;
-}
-
 static const struct dw_pcie_host_ops dw_plat_pcie_host_ops = {
-	.host_init = dw_plat_pcie_host_init,
 };
 
 static int dw_plat_pcie_establish_link(struct dw_pcie *pci)
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index 210777c793ea..86f9d16c50d7 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -196,9 +196,6 @@ static int histb_pcie_host_init(struct pcie_port *pp)
 	regval |= PCIE_WM_RC;
 	histb_pcie_writel(hipcie, PCIE_SYS_CTRL0, regval);
 
-	/* setup root complex */
-	dw_pcie_setup_rc(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index f84ac1b36b2c..ac4bbdaf5324 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -405,8 +405,6 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 {
 	pp->bridge->ops = &kirin_pci_ops;
 
-	dw_pcie_setup_rc(pp);
-
 	return 0;
 }
 
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index eb107179d544..e49791c4f846 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1280,7 +1280,6 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 			goto err_disable_phy;
 	}
 
-	dw_pcie_setup_rc(pp);
 	qcom_ep_reset_deassert(pcie);
 
 	return 0;
diff --git a/drivers/pci/controller/dwc/pcie-spear13xx.c b/drivers/pci/controller/dwc/pcie-spear13xx.c
index 31475e4493a7..1a9e353bef55 100644
--- a/drivers/pci/controller/dwc/pcie-spear13xx.c
+++ b/drivers/pci/controller/dwc/pcie-spear13xx.c
@@ -130,8 +130,6 @@ static int spear13xx_pcie_host_init(struct pcie_port *pp)
 
 	spear13xx_pcie->app_base = pci->dbi_base + 0x2000;
 
-	dw_pcie_setup_rc(pp);
-
 	/*
 	 * this controller support only 128 bytes read size, however its
 	 * default value in capability register is 512 bytes. So force
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index e6616408a29c..2457e9dd098d 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -314,8 +314,6 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
 
 	uniphier_pcie_irq_enable(priv);
 
-	dw_pcie_setup_rc(pp);
-
 	return 0;
 }
 
-- 
2.25.1

