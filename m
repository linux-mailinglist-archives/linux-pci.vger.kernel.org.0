Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id B6EB324CC1C
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:55:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgHUDzx (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:55:53 -0400
Received: from mail-il1-f193.google.com ([209.85.166.193]:43550 "EHLO
        mail-il1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727845AbgHUDzv (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:55:51 -0400
Received: by mail-il1-f193.google.com with SMTP id e11so323001ils.10;
        Thu, 20 Aug 2020 20:55:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dNUyiy2kVu/ughaJBkWT5/klsWfmnY1eOnmRRwapWCs=;
        b=LQVOg4bzKww3Z9rzHGiinVCdYq+7r6tIapum0fjjGFiRB8czGGvkKZIrPbOJAYwSKf
         jxVQV8g2xgxukQw965VYTMeCU9r30uRVeeDZ8E/Rj+tifZ3uoxrOcAO9FlqaYasRgkvw
         jSq2of24ZYWMnL7ahD80MISC+NI7052k6n4R1FOb0D7wXL+yXoXfaMltZX5QFGa30DvY
         f57YFSmmw+YmjyY94lGaasLM2m5QFQ9u2Z/fT1gBi8FkzX2w4eULzN+Y8Ewmn1FflX4T
         rAcU7qhEkzLJC6URWFU7mkfEsTgO67WN+8ka8y2xBYM7CTJVjYllQzf9mD6HsmAkjk7A
         3O0g==
X-Gm-Message-State: AOAM530duEzIicNigpMxHL/ULuBCZ6F7fB7Nw1u5ZB6kid3tp75tFKZk
        60qMShs5h9msInqFYigTyQ==
X-Google-Smtp-Source: ABdhPJzMoV8+5/DEmM4lA3ju060HMjXV6nuKAO3ZvJwnkwzK6l/Wx4wtZJr53/FtUHv/jZc8Veb01w==
X-Received: by 2002:a92:c88f:: with SMTP id w15mr959860ilo.285.1597982149590;
        Thu, 20 Aug 2020 20:55:49 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.55.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:55:49 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     linux-pci@vger.kernel.org, Andy Gross <agross@kernel.org>,
        Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Dilip Kota <eswara.kota@linux.intel.com>,
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
        Lucas Stach <l.stach@pengutronix.de>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Marc Zyngier <maz@kernel.org>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH v2 21/40] PCI: dwc: Check CONFIG_PCI_MSI inside dw_pcie_msi_init()
Date:   Thu, 20 Aug 2020 21:54:01 -0600
Message-Id: <20200821035420.380495-22-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Move the IS_ENABLED(CONFIG_PCI_MSI) check into dw_pcie_msi_init()
instead of duplicating it in all the drivers.

Cc: Richard Zhu <hongxing.zhu@nxp.com>
Cc: Lucas Stach <l.stach@pengutronix.de>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Cc: Sascha Hauer <s.hauer@pengutronix.de>
Cc: Pengutronix Kernel Team <kernel@pengutronix.de>
Cc: Fabio Estevam <festevam@gmail.com>
Cc: NXP Linux Team <linux-imx@nxp.com>
Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Xiaowei Song <songxiaowei@hisilicon.com>
Cc: Binghui Wang <wangbinghui@hisilicon.com>
Cc: Stanimir Varbanov <svarbanov@mm-sol.com>
Cc: Andy Gross <agross@kernel.org>
Cc: Bjorn Andersson <bjorn.andersson@linaro.org>
Cc: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc: Masahiro Yamada <yamada.masahiro@socionext.com>
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@axis.com
Cc: linux-arm-msm@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-imx6.c             |  4 +---
 drivers/pci/controller/dwc/pci-meson.c            |  8 +-------
 drivers/pci/controller/dwc/pcie-artpec6.c         | 11 +----------
 drivers/pci/controller/dwc/pcie-designware-host.c |  3 +++
 drivers/pci/controller/dwc/pcie-designware-plat.c |  4 +---
 drivers/pci/controller/dwc/pcie-histb.c           |  4 +---
 drivers/pci/controller/dwc/pcie-kirin.c           |  4 +---
 drivers/pci/controller/dwc/pcie-qcom.c            |  4 +---
 drivers/pci/controller/dwc/pcie-uniphier.c        |  3 +--
 9 files changed, 11 insertions(+), 34 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90df28c7cb0c..68a09680e728 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -847,9 +847,7 @@ static int imx6_pcie_host_init(struct pcie_port *pp)
 	imx6_setup_phy_mpll(imx6_pcie);
 	dw_pcie_setup_rc(pp);
 	imx6_pcie_establish_link(imx6_pcie);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index f4d822190359..67ca73528aad 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -377,12 +377,6 @@ static int meson_pcie_establish_link(struct meson_pcie *mp)
 	return dw_pcie_wait_for_link(pci);
 }
 
-static void meson_pcie_enable_interrupts(struct meson_pcie *mp)
-{
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(&mp->pci.pp);
-}
-
 static int meson_pcie_rd_own_conf(struct pci_bus *bus, u32 devfn,
 				  int where, int size, u32 *val)
 {
@@ -466,7 +460,7 @@ static int meson_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
-	meson_pcie_enable_interrupts(mp);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 97d50bb50f06..86f4d66d8587 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -346,15 +346,6 @@ static void artpec6_pcie_deassert_core_reset(struct artpec6_pcie *artpec6_pcie)
 	usleep_range(100, 200);
 }
 
-static void artpec6_pcie_enable_interrupts(struct artpec6_pcie *artpec6_pcie)
-{
-	struct dw_pcie *pci = artpec6_pcie->pci;
-	struct pcie_port *pp = &pci->pp;
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
-}
-
 static int artpec6_pcie_host_init(struct pcie_port *pp)
 {
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
@@ -368,7 +359,7 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	dw_pcie_setup_rc(pp);
 	artpec6_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
-	artpec6_pcie_enable_interrupts(artpec6_pcie);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 06f6cbefeb95..1c750659aef8 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -276,6 +276,9 @@ void dw_pcie_msi_init(struct pcie_port *pp)
 	struct device *dev = pci->dev;
 	u64 msi_target;
 
+	if (!IS_ENABLED(CONFIG_PCI_MSI))
+		return;
+
 	pp->msi_page = alloc_page(GFP_KERNEL);
 	pp->msi_data = dma_map_page(dev, pp->msi_page, 0, PAGE_SIZE,
 				    DMA_FROM_DEVICE);
diff --git a/drivers/pci/controller/dwc/pcie-designware-plat.c b/drivers/pci/controller/dwc/pcie-designware-plat.c
index 712456f6ce36..e3e300669ed5 100644
--- a/drivers/pci/controller/dwc/pcie-designware-plat.c
+++ b/drivers/pci/controller/dwc/pcie-designware-plat.c
@@ -39,9 +39,7 @@ static int dw_plat_pcie_host_init(struct pcie_port *pp)
 
 	dw_pcie_setup_rc(pp);
 	dw_pcie_wait_for_link(pci);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-histb.c b/drivers/pci/controller/dwc/pcie-histb.c
index af1deae2b15d..afc1abbe49aa 100644
--- a/drivers/pci/controller/dwc/pcie-histb.c
+++ b/drivers/pci/controller/dwc/pcie-histb.c
@@ -202,9 +202,7 @@ static int histb_pcie_host_init(struct pcie_port *pp)
 	pp->bridge->ops = &histb_pci_ops;
 
 	histb_pcie_establish_link(pp);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-kirin.c b/drivers/pci/controller/dwc/pcie-kirin.c
index 8a01ab0a4a65..6f01ae013326 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -429,9 +429,7 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 	pp->bridge->ops = &kirin_pci_ops;
 
 	kirin_pcie_establish_link(pp);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 3aac77a295ba..fe7fc2ccd76d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1280,9 +1280,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	}
 
 	dw_pcie_setup_rc(pp);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	qcom_ep_reset_deassert(pcie);
 
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 3a7f403b57b8..48176265c867 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -322,8 +322,7 @@ static int uniphier_pcie_host_init(struct pcie_port *pp)
 	if (ret)
 		return ret;
 
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
-- 
2.25.1

