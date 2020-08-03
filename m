Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1921023AF40
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729447AbgHCVCS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:18 -0400
Received: from mail-il1-f196.google.com ([209.85.166.196]:41451 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729421AbgHCVCP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:15 -0400
Received: by mail-il1-f196.google.com with SMTP id c16so20531153ils.8;
        Mon, 03 Aug 2020 14:02:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=4tVnhS6O+K590csRd4/lSa2PYfRPYOAvm58gPgPLsFY=;
        b=evvNIFAW0o50ANfN2d5JvFz8cvW8j7I4oaXsj232Lq6ZKZDOzFZ8Awm0TNXJTTfnRO
         igJ3457wNYfzZ/XtvBNOaxfnEmQD1o2FInR+bLQ/3BPPZkhtF3V/aFQS9Ywauw3yUw8g
         HFlObAFW7I6WPYYYVZSjujqwTaxDLdLawy91pkezIQMk70YFd7nUVui3fcYTdhpmyx5B
         ekPvWv5pG57ytZFmag3lkyhkCY/ikgmV89Gu/si0zcv7RJJ7aj8bf3lYYMDpgf1QX8bI
         iGqvLYS8Fi9z/tONIAww5y+xO8xxOKI/Szo/fCV4yDjlKdoUGnorehibbYMxESCGhNjX
         HjGw==
X-Gm-Message-State: AOAM5330oh/pWYnxZrOfwxKs7Lxmmb4xEeEr8dpnn+VzM50GR6kdtagP
        wmm2p/NXpUA7QPU1tr4KZA==
X-Google-Smtp-Source: ABdhPJxrPD8UFPm240Z1CyA8Fd4/vL+RyL0sOj2CDP3xiqnUbs/cuHBijh90alAfV3wjw6im7IrWBQ==
X-Received: by 2002:a92:999a:: with SMTP id t26mr1365750ilk.145.1596488533931;
        Mon, 03 Aug 2020 14:02:13 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:13 -0700 (PDT)
From:   Rob Herring <robh@kernel.org>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Gustavo Pimentel <gustavo.pimentel@synopsys.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Binghui Wang <wangbinghui@hisilicon.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Fabio Estevam <festevam@gmail.com>,
        Jesper Nilsson <jesper.nilsson@axis.com>,
        Jonathan Chocron <jonnyc@amazon.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Kukjin Kim <kgene@kernel.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>,
        linux-amlogic@lists.infradead.org, linux-arm-kernel@axis.com,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-samsung-soc@vger.kernel.org,
        linux-tegra@vger.kernel.org, Lucas Stach <l.stach@pengutronix.de>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Murali Karicheri <m-karicheri2@ti.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Pratyush Anand <pratyush.anand@gmail.com>,
        Richard Zhu <hongxing.zhu@nxp.com>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Stanimir Varbanov <svarbanov@mm-sol.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Xiaowei Song <songxiaowei@hisilicon.com>,
        Yue Wang <yue.wang@Amlogic.com>, Andy Gross <agross@kernel.org>
Subject: [RFC 21/27] PCI: dwc: Check CONFIG_PCI_MSI inside dw_pcie_msi_init()
Date:   Mon,  3 Aug 2020 15:01:10 -0600
Message-Id: <20200803210116.3132633-22-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
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
Cc: linux-pci@vger.kernel.org
Cc: linux-arm-kernel@lists.infradead.org
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
index 8f08ae53f53e..7b526f4f85ce 100644
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
index 54ce3369d963..cbde683d107f 100644
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
index 28d5a1095200..969f217c5675 100644
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
index 1ff4702595b6..0e62bed7f6cb 100644
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
index 73646b677aff..4990cd010983 100644
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
index 0d93088deea3..c97c37c6314e 100644
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
index 1680dc72b416..0be17db42f56 100644
--- a/drivers/pci/controller/dwc/pcie-kirin.c
+++ b/drivers/pci/controller/dwc/pcie-kirin.c
@@ -434,9 +434,7 @@ static int kirin_pcie_host_init(struct pcie_port *pp)
 	pp->bridge->ops = &kirin_pci_ops;
 
 	kirin_pcie_establish_link(pp);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	return 0;
 }
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 138e1a2d21cc..9f1d3ba686fa 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1237,9 +1237,7 @@ static int qcom_pcie_host_init(struct pcie_port *pp)
 	}
 
 	dw_pcie_setup_rc(pp);
-
-	if (IS_ENABLED(CONFIG_PCI_MSI))
-		dw_pcie_msi_init(pp);
+	dw_pcie_msi_init(pp);
 
 	qcom_ep_reset_deassert(pcie);
 
diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index a5401a0b1e58..07ba2d833941 100644
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

