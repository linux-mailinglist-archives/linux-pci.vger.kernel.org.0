Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E48A6B380D
	for <lists+linux-pci@lfdr.de>; Fri, 10 Mar 2023 09:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229817AbjCJIFy (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 10 Mar 2023 03:05:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49184 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230155AbjCJIFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 10 Mar 2023 03:05:47 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D164B718B;
        Fri, 10 Mar 2023 00:05:45 -0800 (PST)
Received: from cryzen.lan (cpc87451-finc19-2-0-cust61.4-2.cable.virginm.net [82.11.51.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: tanureal)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D95BB66030A1;
        Fri, 10 Mar 2023 08:05:43 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678435544;
        bh=Ugt/cIk2aYivDAu6VNt7dUsTeai7krVEsAmcZ9e7wWs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CevpKLSirdoo2LRhQoamcTSJtt7F++p/wpiqgJW7eBklKIdW4EJ4vfYNY0kUZClX9
         +YMt0O23e8kqR31xxPwcmoiFvvJXoIc9U/dugfsZhmhU4+RDxSARFdSC+s1tO8ai2n
         WsAfeDzQm+E/bbgdbS8v441+Mm0LGU5WnpGtGFRDOPVeE4jAsfA7yKtJm8bWlkKSPf
         VbB8Oq6kBpIQGe0gqCi1SYUzJO7HE/8Y2OCQxU64oj8TjCcVeyJCymwiEBb0gKrl7W
         qlO8JCZ0PM5V+j0xXwXmmDzCQk/87w4aAM9fzYmxij1wS3Rx1LsfFom03zQojeSx3/
         3JgO9x9VrouMA==
From:   Lucas Tanure <lucas.tanure@collabora.com>
To:     Vinod Koul <vkoul@kernel.org>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Marc Zyngier <maz@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Krzysztof Wilczynski <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     Qu Wenruo <wqu@suse.com>,
        Piotr Oniszczuk <piotr.oniszczuk@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Kever Yang <kever.yang@rock-chips.com>,
        linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org,
        Lucas Tanure <lucas.tanure@collabora.com>,
        kernel@collabora.com, Andrew Powers-Holmes <aholmes@omnom.net>
Subject: [PATCH 4/7] phy: rockchip: Add naneng combo phy support for RK3588
Date:   Fri, 10 Mar 2023 08:05:15 +0000
Message-Id: <20230310080518.78054-5-lucas.tanure@collabora.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230310080518.78054-1-lucas.tanure@collabora.com>
References: <20230310080518.78054-1-lucas.tanure@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add support for RK3588 combo phy

This is based on prior work from XiaoDong Huang and
Peter Geis fixing this issue specifically for Rockchip 356x.

Co-developed-by: Andrew Powers-Holmes <aholmes@omnom.net>
Signed-off-by: Andrew Powers-Holmes <aholmes@omnom.net>
Signed-off-by: Lucas Tanure <lucas.tanure@collabora.com>
---
 .../rockchip/phy-rockchip-naneng-combphy.c    | 184 ++++++++++++++++++
 1 file changed, 184 insertions(+)

diff --git a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
index 7b213825fb5d..7b8b001e4f9e 100644
--- a/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
+++ b/drivers/phy/rockchip/phy-rockchip-naneng-combphy.c
@@ -63,6 +63,9 @@
 #define PHYREG18			0x44
 #define PHYREG18_PLL_LOOP		0x32
 
+#define PHYREG27			0x6C
+#define PHYREG27_RX_TRIM_RK3588		0x4C
+
 #define PHYREG32			0x7C
 #define PHYREG32_SSC_MASK		GENMASK(7, 4)
 #define PHYREG32_SSC_DIR_SHIFT		4
@@ -114,7 +117,10 @@ struct rockchip_combphy_grfcfg {
 	struct combphy_reg con2_for_sata;
 	struct combphy_reg con3_for_sata;
 	struct combphy_reg pipe_con0_for_sata;
+	struct combphy_reg pipe_con1_for_sata;
 	struct combphy_reg pipe_xpcs_phy_ready;
+	struct combphy_reg pipe_pcie1l0_sel;
+	struct combphy_reg pipe_pcie1l1_sel;
 };
 
 struct rockchip_combphy_cfg {
@@ -559,11 +565,189 @@ static const struct rockchip_combphy_cfg rk3568_combphy_cfgs = {
 	.combphy_cfg	= rk3568_combphy_cfg,
 };
 
+static int rk3588_combphy_cfg(struct rockchip_combphy_priv *priv)
+{
+	const struct rockchip_combphy_grfcfg *cfg = priv->cfg->grfcfg;
+	unsigned long rate;
+	u32 val;
+
+	switch (priv->type) {
+	case PHY_TYPE_PCIE:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_pcie, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_pcie, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l0_sel, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_pcie1l1_sel, true);
+		break;
+	case PHY_TYPE_USB3:
+		/* Set SSC downward spread spectrum */
+		rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK,
+					 PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT,
+					 PHYREG32);
+
+		/* Enable adaptive CTLE for USB3.0 Rx. */
+		val = readl(priv->mmio + PHYREG15);
+		val |= PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + PHYREG15);
+
+		/* Set PLL KVCO fine tuning signals. */
+		rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
+					 PHYREG33_PLL_KVCO_VALUE << PHYREG33_PLL_KVCO_SHIFT,
+					 PHYREG33);
+
+		/* Enable controlling random jitter. */
+		writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+
+		/* Set PLL input clock divider 1/2. */
+		rockchip_combphy_updatel(priv, PHYREG6_PLL_DIV_MASK,
+					 PHYREG6_PLL_DIV_2 << PHYREG6_PLL_DIV_SHIFT,
+					 PHYREG6);
+
+		writel(PHYREG18_PLL_LOOP, priv->mmio + PHYREG18);
+		writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txcomp_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_txelec_sel, false);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->usb_mode_set, true);
+		break;
+	case PHY_TYPE_SATA:
+		/* Enable adaptive CTLE for SATA Rx. */
+		val = readl(priv->mmio + PHYREG15);
+		val |= PHYREG15_CTLE_EN;
+		writel(val, priv->mmio + PHYREG15);
+		/*
+		 * Set tx_rterm=50ohm and rx_rterm=44ohm for SATA.
+		 * 0: 60ohm, 8: 50ohm 15: 44ohm (by step abort 1ohm)
+		 */
+		val = PHYREG7_TX_RTERM_50OHM << PHYREG7_TX_RTERM_SHIFT;
+		val |= PHYREG7_RX_RTERM_44OHM << PHYREG7_RX_RTERM_SHIFT;
+		writel(val, priv->mmio + PHYREG7);
+
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con0_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con1_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con2_for_sata, true);
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->con3_for_sata, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con0_for_sata, true);
+		rockchip_combphy_param_write(priv->pipe_grf, &cfg->pipe_con1_for_sata, true);
+		break;
+	case PHY_TYPE_SGMII:
+	case PHY_TYPE_QSGMII:
+	default:
+		dev_err(priv->dev, "incompatible PHY type\n");
+		return -EINVAL;
+	}
+
+	rate = clk_get_rate(priv->refclk);
+
+	switch (rate) {
+	case REF_CLOCK_24MHz:
+		if (priv->type == PHY_TYPE_USB3 || priv->type == PHY_TYPE_SATA) {
+			/* Set ssc_cnt[9:0]=0101111101 & 31.5KHz. */
+			val = PHYREG15_SSC_CNT_VALUE << PHYREG15_SSC_CNT_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG15_SSC_CNT_MASK,
+						 val, PHYREG15);
+
+			writel(PHYREG16_SSC_CNT_VALUE, priv->mmio + PHYREG16);
+		}
+		break;
+
+	case REF_CLOCK_25MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_25m, true);
+		break;
+	case REF_CLOCK_100MHz:
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_100m, true);
+		if (priv->type == PHY_TYPE_PCIE) {
+			/* PLL KVCO fine tuning. */
+			val = 4 << PHYREG33_PLL_KVCO_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG33_PLL_KVCO_MASK,
+						 val, PHYREG33);
+
+			/* Enable controlling random jitter. */
+			writel(PHYREG12_PLL_LPF_ADJ_VALUE, priv->mmio + PHYREG12);
+
+			/* Set up rx_trim: PLL LPF C1 85pf R1 1.25kohm */
+			writel(PHYREG27_RX_TRIM_RK3588, priv->mmio + PHYREG27);
+
+			/* Set up su_trim:  */
+			writel(PHYREG11_SU_TRIM_0_7, priv->mmio + PHYREG11);
+		} else if (priv->type == PHY_TYPE_SATA) {
+			/* downward spread spectrum +500ppm */
+			val = PHYREG32_SSC_DOWNWARD << PHYREG32_SSC_DIR_SHIFT;
+			val |= PHYREG32_SSC_OFFSET_500PPM << PHYREG32_SSC_OFFSET_SHIFT;
+			rockchip_combphy_updatel(priv, PHYREG32_SSC_MASK, val, PHYREG32);
+		}
+		break;
+	default:
+		dev_err(priv->dev, "Unsupported rate: %lu\n", rate);
+		return -EINVAL;
+	}
+
+	if (priv->ext_refclk) {
+		rockchip_combphy_param_write(priv->phy_grf, &cfg->pipe_clk_ext, true);
+		if (priv->type == PHY_TYPE_PCIE && rate == REF_CLOCK_100MHz) {
+			val = PHYREG13_RESISTER_HIGH_Z << PHYREG13_RESISTER_SHIFT;
+			val |= PHYREG13_CKRCV_AMP0;
+			rockchip_combphy_updatel(priv, PHYREG13_RESISTER_MASK, val, PHYREG13);
+
+			val = readl(priv->mmio + PHYREG14);
+			val |= PHYREG14_CKRCV_AMP1;
+			writel(val, priv->mmio + PHYREG14);
+		}
+	}
+
+	if (priv->enable_ssc) {
+		val = readl(priv->mmio + PHYREG8);
+		val |= PHYREG8_SSC_EN;
+		writel(val, priv->mmio + PHYREG8);
+	}
+
+	return 0;
+}
+
+static const struct rockchip_combphy_grfcfg rk3588_combphy_grfcfgs = {
+	/* pipe-phy-grf */
+	.pcie_mode_set		= { 0x0000, 5, 0, 0x00, 0x11 },
+	.usb_mode_set		= { 0x0000, 5, 0, 0x00, 0x04 },
+	.pipe_rxterm_set	= { 0x0000, 12, 12, 0x00, 0x01 },
+	.pipe_txelec_set	= { 0x0004, 1, 1, 0x00, 0x01 },
+	.pipe_txcomp_set	= { 0x0004, 4, 4, 0x00, 0x01 },
+	.pipe_clk_25m		= { 0x0004, 14, 13, 0x00, 0x01 },
+	.pipe_clk_100m		= { 0x0004, 14, 13, 0x00, 0x02 },
+	.pipe_rxterm_sel	= { 0x0008, 8, 8, 0x00, 0x01 },
+	.pipe_txelec_sel	= { 0x0008, 12, 12, 0x00, 0x01 },
+	.pipe_txcomp_sel	= { 0x0008, 15, 15, 0x00, 0x01 },
+	.pipe_clk_ext		= { 0x000c, 9, 8, 0x02, 0x01 },
+	.pipe_phy_status	= { 0x0034, 6, 6, 0x01, 0x00 },
+	.con0_for_pcie		= { 0x0000, 15, 0, 0x00, 0x1000 },
+	.con1_for_pcie		= { 0x0004, 15, 0, 0x00, 0x0000 },
+	.con2_for_pcie		= { 0x0008, 15, 0, 0x00, 0x0101 },
+	.con3_for_pcie		= { 0x000c, 15, 0, 0x00, 0x0200 },
+	.con0_for_sata		= { 0x0000, 15, 0, 0x00, 0x0129 },
+	.con1_for_sata		= { 0x0004, 15, 0, 0x00, 0x0000 },
+	.con2_for_sata		= { 0x0008, 15, 0, 0x00, 0x80c1 },
+	.con3_for_sata		= { 0x000c, 15, 0, 0x00, 0x0407 },
+	/* pipe-grf */
+	.pipe_con0_for_sata	= { 0x0000, 11, 5, 0x00, 0x22 },
+	.pipe_con1_for_sata	= { 0x0000, 2, 0, 0x00, 0x2 },
+	.pipe_pcie1l0_sel	= { 0x0100, 0, 0, 0x01, 0x0 },
+	.pipe_pcie1l1_sel	= { 0x0100, 1, 1, 0x01, 0x0 },
+};
+
+static const struct rockchip_combphy_cfg rk3588_combphy_cfgs = {
+	.grfcfg		= &rk3588_combphy_grfcfgs,
+	.combphy_cfg	= rk3588_combphy_cfg,
+};
+
 static const struct of_device_id rockchip_combphy_of_match[] = {
 	{
 		.compatible = "rockchip,rk3568-naneng-combphy",
 		.data = &rk3568_combphy_cfgs,
 	},
+	{
+		.compatible = "rockchip,rk3588-naneng-combphy",
+		.data = &rk3588_combphy_cfgs,
+	},
 	{ },
 };
 MODULE_DEVICE_TABLE(of, rockchip_combphy_of_match);
-- 
2.39.2

