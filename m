Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1ED1723AF4C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Aug 2020 23:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729470AbgHCVC3 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 Aug 2020 17:02:29 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:35000 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728570AbgHCVC1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 Aug 2020 17:02:27 -0400
Received: by mail-io1-f68.google.com with SMTP id s189so32774718iod.2;
        Mon, 03 Aug 2020 14:02:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=PM8zrR6BXOfDRWMk7IOmZATjTEqDEPOnq1HMPd0fm+I=;
        b=Pth5GiV2sgoMtDvU2E4+9rNu7QJOQZUekMh3rDsA8pW6bM0JolDGZZr+g799xUvu9/
         /2LM0bbqqfFODyPdR+6eZBVjWP/gk4FW37w6MUFrupXG2wmrRrg4k+XQcADoGdLmHHUN
         GsOEIO1z1xBwq4FXVFC0uRRO8K/qiy+OKD3q7+X+9iTIv6LTTWLIlTs8RbxMFyJ30bKX
         RyaDp8hpQDuI/UoquvTYtzf3fzUMOY2naCc9kmSvcsjtou6S+ULgC/KXD/IP5gLdtfWK
         NiLkVhFAYqL9vvL/gFLo4CC0BhMU1hgVj80G4F1tmWudYO4idbyyCiE0GKCez7aZ62eR
         80pw==
X-Gm-Message-State: AOAM530UjJ5dl0/7cC2WG4lNn33pQ+3feEVsh3guR39+6ikoiepvAwD9
        RmmfX8zVWX8FxUdp86kwVQ==
X-Google-Smtp-Source: ABdhPJw96k8lyNK11/NlxPpmp4xlor/b3WWjFcRtY1Ld3dnCdpoOVounuLgtCLR+q/EA7hpBdE6Lnw==
X-Received: by 2002:a05:6638:1690:: with SMTP id f16mr1826708jat.91.1596488544963;
        Mon, 03 Aug 2020 14:02:24 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.252])
        by smtp.googlemail.com with ESMTPSA id r6sm9292280iod.7.2020.08.03.14.02.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:02:24 -0700 (PDT)
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
        Yue Wang <yue.wang@Amlogic.com>
Subject: [RFC 24/27] PCI: dwc/meson: Rework PCI config and DW port logic register accesses
Date:   Mon,  3 Aug 2020 15:01:13 -0600
Message-Id: <20200803210116.3132633-25-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200803210116.3132633-1-robh@kernel.org>
References: <20200803210116.3132633-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The meson 'elbi' registers are just the Designware 'dbi' space and all
the registers accessed are either standard PCI config space or DWC port
logic registers. Convert the accesses to use the common defines and
register accessors.

Cc: Yue Wang <yue.wang@Amlogic.com>
Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Cc: Kevin Hilman <khilman@baylibre.com>
Cc: Jingoo Han <jingoohan1@gmail.com>
Cc: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
Cc: linux-pci@vger.kernel.org
Cc: linux-amlogic@lists.infradead.org
Cc: linux-arm-kernel@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c       | 113 +++++++------------
 drivers/pci/controller/dwc/pcie-designware.h |   1 +
 2 files changed, 39 insertions(+), 75 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index d1cfc65f0a69..734aace62173 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -22,23 +22,7 @@
 
 #define to_meson_pcie(x) dev_get_drvdata((x)->dev)
 
-/* External local bus interface registers */
-#define PLR_OFFSET			0x700
-#define PCIE_PORT_LINK_CTRL_OFF		(PLR_OFFSET + 0x10)
-#define FAST_LINK_MODE			BIT(7)
-#define LINK_CAPABLE_MASK		GENMASK(21, 16)
-#define LINK_CAPABLE_X1			BIT(16)
-
-#define PCIE_GEN2_CTRL_OFF		(PLR_OFFSET + 0x10c)
-#define NUM_OF_LANES_MASK		GENMASK(12, 8)
-#define NUM_OF_LANES_X1			BIT(8)
-#define DIRECT_SPEED_CHANGE		BIT(17)
-
-#define PCIE_CAP_OFFSET			0x70
-#define PCIE_DEV_CTRL_DEV_STUS		(PCIE_CAP_OFFSET + 0x08)
-#define PCIE_CAP_MAX_PAYLOAD_MASK	GENMASK(7, 5)
 #define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
-#define PCIE_CAP_MAX_READ_REQ_MASK	GENMASK(14, 12)
 #define PCIE_CAP_MAX_READ_REQ_SIZE(x)	((x) << 12)
 
 /* PCIe specific config registers */
@@ -68,11 +52,6 @@ enum pcie_data_rate {
 	PCIE_GEN4
 };
 
-struct meson_pcie_mem_res {
-	void __iomem *elbi_base;
-	void __iomem *cfg_base;
-};
-
 struct meson_pcie_clk_res {
 	struct clk *clk;
 	struct clk *port_clk;
@@ -86,7 +65,7 @@ struct meson_pcie_rc_reset {
 
 struct meson_pcie {
 	struct dw_pcie pci;
-	struct meson_pcie_mem_res mem_res;
+	void __iomem *cfg_base;
 	struct meson_pcie_clk_res clk_res;
 	struct meson_pcie_rc_reset mrst;
 	struct gpio_desc *reset_gpio;
@@ -125,28 +104,18 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
 	return 0;
 }
 
-static void __iomem *meson_pcie_get_mem(struct platform_device *pdev,
-					struct meson_pcie *mp,
-					const char *id)
-{
-	struct device *dev = mp->pci.dev;
-	struct resource *res;
-
-	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, id);
-
-	return devm_ioremap_resource(dev, res);
-}
-
 static int meson_pcie_get_mems(struct platform_device *pdev,
 			       struct meson_pcie *mp)
 {
-	mp->mem_res.elbi_base = meson_pcie_get_mem(pdev, mp, "elbi");
-	if (IS_ERR(mp->mem_res.elbi_base))
-		return PTR_ERR(mp->mem_res.elbi_base);
+	struct dw_pcie *pci = &mp->pci;
 
-	mp->mem_res.cfg_base = meson_pcie_get_mem(pdev, mp, "cfg");
-	if (IS_ERR(mp->mem_res.cfg_base))
-		return PTR_ERR(mp->mem_res.cfg_base);
+	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
+
+	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
+	if (IS_ERR(mp->cfg_base))
+		return PTR_ERR(mp->cfg_base);
 
 	return 0;
 }
@@ -244,24 +213,14 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
 	return 0;
 }
 
-static inline void meson_elb_writel(struct meson_pcie *mp, u32 val, u32 reg)
-{
-	writel(val, mp->mem_res.elbi_base + reg);
-}
-
-static inline u32 meson_elb_readl(struct meson_pcie *mp, u32 reg)
-{
-	return readl(mp->mem_res.elbi_base + reg);
-}
-
 static inline u32 meson_cfg_readl(struct meson_pcie *mp, u32 reg)
 {
-	return readl(mp->mem_res.cfg_base + reg);
+	return readl(mp->cfg_base + reg);
 }
 
 static inline void meson_cfg_writel(struct meson_pcie *mp, u32 val, u32 reg)
 {
-	writel(val, mp->mem_res.cfg_base + reg);
+	writel(val, mp->cfg_base + reg);
 }
 
 static void meson_pcie_assert_reset(struct meson_pcie *mp)
@@ -273,27 +232,28 @@ static void meson_pcie_assert_reset(struct meson_pcie *mp)
 
 static void meson_pcie_init_dw(struct meson_pcie *mp)
 {
+	struct dw_pcie *pci = &mp->pci;
 	u32 val;
 
 	val = meson_cfg_readl(mp, PCIE_CFG0);
 	val |= APP_LTSSM_ENABLE;
 	meson_cfg_writel(mp, val, PCIE_CFG0);
 
-	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
-	val &= ~(LINK_CAPABLE_MASK | FAST_LINK_MODE);
-	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val &= ~(PORT_LINK_MODE_MASK | PORT_LINK_FAST_LINK_MODE);
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	val = meson_elb_readl(mp, PCIE_PORT_LINK_CTRL_OFF);
-	val |= LINK_CAPABLE_X1;
-	meson_elb_writel(mp, val, PCIE_PORT_LINK_CTRL_OFF);
+	val = dw_pcie_readl_dbi(pci, PCIE_PORT_LINK_CONTROL);
+	val |= PORT_LINK_MODE_1_LANES;
+	dw_pcie_writel_dbi(pci, PCIE_PORT_LINK_CONTROL, val);
 
-	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
-	val &= ~NUM_OF_LANES_MASK;
-	meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val &= ~PORT_LOGIC_LINK_WIDTH_MASK;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 
-	val = meson_elb_readl(mp, PCIE_GEN2_CTRL_OFF);
-	val |= NUM_OF_LANES_X1 | DIRECT_SPEED_CHANGE;
-	meson_elb_writel(mp, val, PCIE_GEN2_CTRL_OFF);
+	val = dw_pcie_readl_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL);
+	val |= PORT_LOGIC_LINK_WIDTH_1_LANES | PORT_LOGIC_SPEED_CHANGE;
+	dw_pcie_writel_dbi(pci, PCIE_LINK_WIDTH_SPEED_CONTROL, val);
 }
 
 static int meson_size_to_payload(struct meson_pcie *mp, int size)
@@ -315,30 +275,34 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
 
 static void meson_set_max_payload(struct meson_pcie *mp, int size)
 {
+	struct dw_pcie *pci = &mp->pci;
 	u32 val;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int max_payload_size = meson_size_to_payload(mp, size);
 
-	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
-	val &= ~PCIE_CAP_MAX_PAYLOAD_MASK;
-	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
+	val &= ~PCI_EXP_DEVCTL_PAYLOAD;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
 
-	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
 	val |= PCIE_CAP_MAX_PAYLOAD_SIZE(max_payload_size);
-	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
 }
 
 static void meson_set_max_rd_req_size(struct meson_pcie *mp, int size)
 {
+	struct dw_pcie *pci = &mp->pci;
 	u32 val;
+	u16 offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	int max_rd_req_size = meson_size_to_payload(mp, size);
 
-	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
-	val &= ~PCIE_CAP_MAX_READ_REQ_MASK;
-	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
+	val &= ~PCI_EXP_DEVCTL_READRQ;
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
 
-	val = meson_elb_readl(mp, PCIE_DEV_CTRL_DEV_STUS);
+	val = dw_pcie_readl_dbi(pci, offset + PCI_EXP_DEVCTL);
 	val |= PCIE_CAP_MAX_READ_REQ_SIZE(max_rd_req_size);
-	meson_elb_writel(mp, val, PCIE_DEV_CTRL_DEV_STUS);
+	dw_pcie_writel_dbi(pci, offset + PCI_EXP_DEVCTL, val);
 }
 
 static int meson_pcie_establish_link(struct meson_pcie *mp)
@@ -466,7 +430,6 @@ static int meson_add_pcie_port(struct meson_pcie *mp,
 	}
 
 	pp->ops = &meson_pcie_host_ops;
-	pci->dbi_base = mp->mem_res.elbi_base;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 2db6f52dfe81..b18a9a5f48d2 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -36,6 +36,7 @@
 
 #define PCIE_PORT_LINK_CONTROL		0x710
 #define PORT_LINK_DLL_LINK_EN		BIT(5)
+#define PORT_LINK_FAST_LINK_MODE	BIT(7)
 #define PORT_LINK_MODE_MASK		GENMASK(21, 16)
 #define PORT_LINK_MODE(n)		FIELD_PREP(PORT_LINK_MODE_MASK, n)
 #define PORT_LINK_MODE_1_LANES		PORT_LINK_MODE(0x1)
-- 
2.25.1

