Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B2F124CC6E
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:57:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727066AbgHUD47 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:59 -0400
Received: from mail-io1-f67.google.com ([209.85.166.67]:39301 "EHLO
        mail-io1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727808AbgHUD44 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:56 -0400
Received: by mail-io1-f67.google.com with SMTP id z17so474139ioi.6;
        Thu, 20 Aug 2020 20:56:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=kP/T61es9DvAAR9dLPg8gUF5gI5xlrq862DmcnbYwx4=;
        b=hGkzWBLGrpkVM2xvYyHglkH68vpOSJ3gtVhmNPi/UK5ZGeHUxXLkyaYQqpQ0BbUJ+A
         39rHe3NwLHFHtNNmVMLNAtimg4EAabPOx4BsYI1GtAiwLTahVHDIJxfR7VNQT3BXg2Ya
         Fk4Za1YXLoBTdizfj7bow5kHXnfcV5crHrgiVrtvKj+Jl0cKtQr6NufIW19W/bWYpHjP
         SJXRPr0qlLq97RTPz681M5gUgPflXtbxXiXAapYBzNB6Wh5oa0cIzaTHn1JILzhokTli
         82exVMhYWQqZdQ9EqQ1J/1I6RrZ8lO/yfsoRmSta7nE9tWeR+4omtBp6vjbiopRy9+vT
         JyJg==
X-Gm-Message-State: AOAM532sCh6XQo09h8U0JwhzTcGAcyaOaNqAD4PMt8i4pQxVNscWG3LS
        QxJphWH4rZcC8hlejwiQKQ==
X-Google-Smtp-Source: ABdhPJzKcMsIuzXYEJD3GGVjx/id1u+aBxnnd2EyAyGfwElnMjqt0JTVFjjDQ4nmrXUWaFGgMPtkpA==
X-Received: by 2002:a05:6638:214d:: with SMTP id z13mr971479jaj.7.1597982214483;
        Thu, 20 Aug 2020 20:56:54 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:53 -0700 (PDT)
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
Subject: [PATCH v2 39/40] PCI: dwc: Move N_FTS setup to common setup
Date:   Thu, 20 Aug 2020 21:54:19 -0600
Message-Id: <20200821035420.380495-40-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The Designware controller has common registers to set number of fast
training sequence ordered sets. The Artpec6, Intel, and Tegra driver
initialize these register fields. Let's move the initialization to the
common setup code and drivers just have to provide the value.

There's a slight change in that the common clock mode N_FTS field is
now initialized. Previously only the Intel driver set this. It's not
clear from the code if common clock mode is used in the Artpec6 or Tegra
driver. It depends on the DWC configuration. Given the field is not
initialized while the others are, it seems unlikely common clock mode
is used.

Cc: Jesper Nilsson <jesper.nilsson@axis.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: Thierry Reding <thierry.reding@gmail.com>
Cc: Jonathan Hunter <jonathanh@nvidia.com>
Cc: linux-tegra@vger.kernel.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-artpec6.c    | 37 +++-----------------
 drivers/pci/controller/dwc/pcie-designware.c | 28 +++++++++------
 drivers/pci/controller/dwc/pcie-designware.h |  3 +-
 drivers/pci/controller/dwc/pcie-intel-gw.c   | 27 +++++---------
 drivers/pci/controller/dwc/pcie-tegra194.c   | 25 ++-----------
 5 files changed, 35 insertions(+), 85 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-artpec6.c b/drivers/pci/controller/dwc/pcie-artpec6.c
index 86f4d66d8587..929448e9e0bc 100644
--- a/drivers/pci/controller/dwc/pcie-artpec6.c
+++ b/drivers/pci/controller/dwc/pcie-artpec6.c
@@ -44,13 +44,6 @@ struct artpec_pcie_of_data {
 
 static const struct of_device_id artpec6_pcie_of_match[];
 
-/* PCIe Port Logic registers (memory-mapped) */
-#define PL_OFFSET			0x700
-
-#define ACK_F_ASPM_CTRL_OFF		(PL_OFFSET + 0xc)
-#define ACK_N_FTS_MASK			GENMASK(15, 8)
-#define ACK_N_FTS(x)			(((x) << 8) & ACK_N_FTS_MASK)
-
 /* ARTPEC-6 specific registers */
 #define PCIECFG				0x18
 #define  PCIECFG_DBG_OEN		BIT(24)
@@ -289,30 +282,6 @@ static void artpec6_pcie_init_phy(struct artpec6_pcie *artpec6_pcie)
 	}
 }
 
-static void artpec6_pcie_set_nfts(struct artpec6_pcie *artpec6_pcie)
-{
-	struct dw_pcie *pci = artpec6_pcie->pci;
-	u32 val;
-
-	if (artpec6_pcie->variant != ARTPEC7)
-		return;
-
-	/*
-	 * Increase the N_FTS (Number of Fast Training Sequences)
-	 * to be transmitted when transitioning from L0s to L0.
-	 */
-	val = dw_pcie_readl_dbi(pci, ACK_F_ASPM_CTRL_OFF);
-	val &= ~ACK_N_FTS_MASK;
-	val |= ACK_N_FTS(180);
-	dw_pcie_writel_dbi(pci, ACK_F_ASPM_CTRL_OFF, val);
-
-	/*
-	 * Set the Number of Fast Training Sequences that the core
-	 * advertises as its N_FTS during Gen2 or Gen3 link training.
-	 */
-	dw_pcie_link_set_n_fts(pci, 180);
-}
-
 static void artpec6_pcie_assert_core_reset(struct artpec6_pcie *artpec6_pcie)
 {
 	u32 val;
@@ -351,11 +320,14 @@ static int artpec6_pcie_host_init(struct pcie_port *pp)
 	struct dw_pcie *pci = to_dw_pcie_from_pp(pp);
 	struct artpec6_pcie *artpec6_pcie = to_artpec6_pcie(pci);
 
+	if (artpec6_pcie->variant == ARTPEC7) {
+		pci->n_fts[0] = 180;
+		pci->n_fts[1] = 180;
+	}
 	artpec6_pcie_assert_core_reset(artpec6_pcie);
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
 	artpec6_pcie_wait_for_phy(artpec6_pcie);
-	artpec6_pcie_set_nfts(artpec6_pcie);
 	dw_pcie_setup_rc(pp);
 	artpec6_pcie_establish_link(pci);
 	dw_pcie_wait_for_link(pci);
@@ -403,7 +375,6 @@ static void artpec6_pcie_ep_init(struct dw_pcie_ep *ep)
 	artpec6_pcie_init_phy(artpec6_pcie);
 	artpec6_pcie_deassert_core_reset(artpec6_pcie);
 	artpec6_pcie_wait_for_phy(artpec6_pcie);
-	artpec6_pcie_set_nfts(artpec6_pcie);
 
 	for (bar = 0; bar < PCI_STD_NUM_BARS; bar++)
 		dw_pcie_ep_reset_bar(pci, bar);
diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 61e1faba15bf..3cb21247619c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -510,17 +510,6 @@ static void dw_pcie_link_set_max_speed(struct dw_pcie *pci, u32 link_gen)
 }
 EXPORT_SYMBOL_GPL(dw_pcie_link_set_max_speed);
 
-void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts)
-{
-	u32 val;
-
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_N_FTS_MASK;
-	val |= n_fts & PORT_LOGIC_N_FTS_MASK;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-}
-EXPORT_SYMBOL_GPL(dw_pcie_link_set_n_fts);
-
 static u8 dw_pcie_iatu_unroll_enabled(struct dw_pcie *pci)
 {
 	u32 val;
@@ -551,6 +540,23 @@ void dw_pcie_setup(struct dw_pcie *pci)
 	if (pci->link_gen > 0)
 		dw_pcie_link_set_max_speed(pci, pci->link_gen);
 
+	/* Configure Gen1 N_FTS */
+	if (pci->n_fts[0]) {
+		val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
+		val &= ~(PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK);
+		val |= PORT_AFR_N_FTS(pci->n_fts[0]);
+		val |= PORT_AFR_CC_N_FTS(pci->n_fts[0]);
+		dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
+	}
+
+	/* Configure Gen2+ N_FTS */
+	if (pci->n_fts[1]) {
+		val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+		val &= ~PORT_LOGIC_N_FTS_MASK;
+		val |= pci->n_fts[pci->link_gen - 1];
+		dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
+	}
+
 	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
 	val &= ~PORT_LINK_FAST_LINK_MODE;
 	val |= PORT_LINK_DLL_LINK_EN;
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 0b48298362cd..d8771db247f4 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -34,6 +34,7 @@
 #define PORT_AFR_N_FTS_MASK		GENMASK(15, 8)
 #define PORT_AFR_N_FTS(n)		FIELD_PREP(PORT_AFR_N_FTS_MASK, n)
 #define PORT_AFR_CC_N_FTS_MASK		GENMASK(23, 16)
+#define PORT_AFR_CC_N_FTS(n)		FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, n)
 #define PORT_AFR_ENTER_ASPM		BIT(30)
 #define PORT_AFR_L0S_ENTRANCE_LAT_SHIFT	24
 #define PORT_AFR_L0S_ENTRANCE_LAT_MASK	GENMASK(26, 24)
@@ -253,6 +254,7 @@ struct dw_pcie {
 	unsigned int		version;
 	int			num_lanes;
 	int			link_gen;
+	u8			n_fts[2];
 };
 
 #define to_dw_pcie_from_pp(port) container_of((port), struct dw_pcie, pp)
@@ -271,7 +273,6 @@ void dw_pcie_write_dbi(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 void dw_pcie_write_dbi2(struct dw_pcie *pci, u32 reg, size_t size, u32 val);
 int dw_pcie_link_up(struct dw_pcie *pci);
 void dw_pcie_upconfig_setup(struct dw_pcie *pci);
-void dw_pcie_link_set_n_fts(struct dw_pcie *pci, u32 n_fts);
 int dw_pcie_wait_for_link(struct dw_pcie *pci);
 void dw_pcie_prog_outbound_atu(struct dw_pcie *pci, int index,
 			       int type, u64 cpu_addr, u64 pci_addr,
diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 333f11561807..5650cb78acba 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -67,7 +67,6 @@ struct intel_pcie_port {
 	void __iomem		*app_base;
 	struct gpio_desc	*reset_gpio;
 	u32			rst_intrvl;
-	u32			n_fts;
 	struct clk		*core_clk;
 	struct reset_control	*core_rst;
 	struct phy		*phy;
@@ -138,37 +137,29 @@ static void intel_pcie_link_setup(struct intel_pcie_port *lpp)
 	pcie_rc_cfg_wr(lpp, offset + PCI_EXP_LNKCTL, val);
 }
 
-static void intel_pcie_port_logic_setup(struct intel_pcie_port *lpp)
+static void intel_pcie_init_n_fts(struct dw_pcie *pci)
 {
-	u32 val, mask;
-	struct dw_pcie *pci = &lpp->pci;
-
-	switch (pcie_link_speed[pci->link_gen]) {
-	case PCIE_SPEED_8_0GT:
-		lpp->n_fts = PORT_AFR_N_FTS_GEN3;
+	switch (pci->link_gen) {
+	case 3:
+		pci->n_fts[1] = PORT_AFR_N_FTS_GEN3;
 		break;
-	case PCIE_SPEED_16_0GT:
-		lpp->n_fts = PORT_AFR_N_FTS_GEN4;
+	case 4:
+		pci->n_fts[1] = PORT_AFR_N_FTS_GEN4;
 		break;
 	default:
-		lpp->n_fts = PORT_AFR_N_FTS_GEN12_DFT;
+		pci->n_fts[1] = PORT_AFR_N_FTS_GEN12_DFT;
 		break;
 	}
-
-	mask = PORT_AFR_N_FTS_MASK | PORT_AFR_CC_N_FTS_MASK;
-	val = FIELD_PREP(PORT_AFR_N_FTS_MASK, lpp->n_fts) |
-	       FIELD_PREP(PORT_AFR_CC_N_FTS_MASK, lpp->n_fts);
-	pcie_rc_cfg_wr_mask(lpp, PCIE_PORT_AFR, mask, val);
+	pci->n_fts[0] = PORT_AFR_N_FTS_GEN12_DFT;
 }
 
 static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
 {
 	intel_pcie_ltssm_disable(lpp);
 	intel_pcie_link_setup(lpp);
+	intel_pcie_init_n_fts(&lpp->pci);
 	dw_pcie_setup_rc(&lpp->pci.pp);
 	dw_pcie_upconfig_setup(&lpp->pci);
-	intel_pcie_port_logic_setup(lpp);
-	dw_pcie_link_set_n_fts(&lpp->pci, lpp->n_fts);
 }
 
 static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index 91ef4b3e860d..1560c449757d 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -881,17 +881,6 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 
 	dw_pcie_writel_dbi(pci, PCI_BASE_ADDRESS_0, 0);
 
-	/* Configure FTS */
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
-	val &= ~PORT_AFR_N_FTS_MASK;
-	val |= PORT_AFR_N_FTS(N_FTS_VAL);
-	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
-
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_N_FTS_MASK;
-	val |= FTS_VAL;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-
 	/* Enable as 0xFFFF0001 response for CRS */
 	val = dw_pcie_readl_dbi(pci, PORT_LOGIC_AMBA_ERROR_RESPONSE_DEFAULT);
 	val &= ~(AMBA_ERROR_RESPONSE_CRS_MASK << AMBA_ERROR_RESPONSE_CRS_SHIFT);
@@ -1794,17 +1783,6 @@ static void pex_ep_event_pex_rst_deassert(struct tegra_pcie_dw *pcie)
 	val &= ~GEN3_RELATED_OFF_GEN3_ZRXDC_NONCOMPL;
 	dw_pcie_writel_dbi(pci, GEN3_RELATED_OFF, val);
 
-	/* Configure N_FTS & FTS */
-	val = dw_pcie_readl_dbi(pci, PCIE_PORT_AFR);
-	val &= ~PORT_AFR_N_FTS_MASK;
-	val |= PORT_AFR_N_FTS(FTS_VAL);
-	dw_pcie_writel_dbi(pci, PCIE_PORT_AFR, val);
-
-	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
-	val &= ~PORT_LOGIC_N_FTS_MASK;
-	val |= FTS_VAL;
-	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
-
 	pcie->pcie_cap_base = dw_pcie_find_capability(&pcie->pci,
 						      PCI_CAP_ID_EXP);
 	clk_set_rate(pcie->core_clk, GEN4_CORE_CLK_FREQ);
@@ -2033,6 +2011,9 @@ static int tegra_pcie_dw_probe(struct platform_device *pdev)
 	pci = &pcie->pci;
 	pci->dev = &pdev->dev;
 	pci->ops = &tegra_dw_pcie_ops;
+	pci->n_fts[0] = N_FTS_VAL;
+	pci->n_fts[1] = FTS_VAL;
+
 	pp = &pci->pp;
 	pcie->dev = &pdev->dev;
 	pcie->mode = (enum dw_pcie_device_mode)data->mode;
-- 
2.25.1

