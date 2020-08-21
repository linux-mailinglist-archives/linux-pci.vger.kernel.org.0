Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CD8724CC3B
	for <lists+linux-pci@lfdr.de>; Fri, 21 Aug 2020 05:56:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728035AbgHUD4U (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 20 Aug 2020 23:56:20 -0400
Received: from mail-io1-f68.google.com ([209.85.166.68]:41129 "EHLO
        mail-io1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727125AbgHUD4T (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 20 Aug 2020 23:56:19 -0400
Received: by mail-io1-f68.google.com with SMTP id g19so466549ioh.8;
        Thu, 20 Aug 2020 20:56:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=QjZFXqjWXEUTZiaAn5hYHKiqo62LdmVrJplZ+1XIJyE=;
        b=hB0CWFMU6DtxgaPow+TVykV1dnAabUe4jL+RsUnRGoNbamZLQItSBcjlHkYZbrQNS4
         r2kUWH1cSNuT0ihuXbjATKnW7mYOmVt+08OncIxlrl+RRTfNj4s4CmDImTBypCBsH9je
         3IfxilfYm4RW6nUt9CXfPNMQnUg9a4Epwq/fnkhA3MP0rNunh438pzgym24EIIhbqj/R
         1J+3lLwea/3Cm9ujF6LzZdrGa8+VoJncnd2qaXksj9Ea0YLyypZU1un0MlsvZMzyI6ZU
         jUjqpF4Q8kB33fYi0KC6gVjVj1SbZ3tmxMA/DgbKqa+AiVX6pBGZgMKmfgZzoDlBR2x6
         1gnQ==
X-Gm-Message-State: AOAM530OBq+rQHiFk6lodqZmWkO4PbAF4AuUCCfG8IzQjr2FyEtbHokf
        rYojFjsmfu9dl4Vwc8WTVg==
X-Google-Smtp-Source: ABdhPJyQ7RVU1iN+BVye7DF0YMFH38k7wZRJyOkmHLo92bOUBV/bqZiSaIYoT6VXndxQVqniWCKMdw==
X-Received: by 2002:a05:6638:e90:: with SMTP id p16mr976888jas.26.1597982178007;
        Thu, 20 Aug 2020 20:56:18 -0700 (PDT)
Received: from xps15.herring.priv ([64.188.179.249])
        by smtp.googlemail.com with ESMTPSA id 79sm413923ilc.9.2020.08.20.20.56.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Aug 2020 20:56:17 -0700 (PDT)
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
Subject: [PATCH v2 27/40] PCI: dwc/meson: Rework PCI config and DW port logic register accesses
Date:   Thu, 20 Aug 2020 21:54:07 -0600
Message-Id: <20200821035420.380495-28-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200821035420.380495-1-robh@kernel.org>
References: <20200821035420.380495-1-robh@kernel.org>
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
Cc: linux-amlogic@lists.infradead.org
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pci-meson.c | 76 +++++++++-----------------
 1 file changed, 25 insertions(+), 51 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-meson.c b/drivers/pci/controller/dwc/pci-meson.c
index cca423e834e8..33deb290c4e7 100644
--- a/drivers/pci/controller/dwc/pci-meson.c
+++ b/drivers/pci/controller/dwc/pci-meson.c
@@ -22,11 +22,7 @@
 
 #define to_meson_pcie(x) dev_get_drvdata((x)->dev)
 
-#define PCIE_CAP_OFFSET			0x70
-#define PCIE_DEV_CTRL_DEV_STUS		(PCIE_CAP_OFFSET + 0x08)
-#define PCIE_CAP_MAX_PAYLOAD_MASK	GENMASK(7, 5)
 #define PCIE_CAP_MAX_PAYLOAD_SIZE(x)	((x) << 5)
-#define PCIE_CAP_MAX_READ_REQ_MASK	GENMASK(14, 12)
 #define PCIE_CAP_MAX_READ_REQ_SIZE(x)	((x) << 12)
 
 /* PCIe specific config registers */
@@ -56,11 +52,6 @@ enum pcie_data_rate {
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
@@ -74,7 +65,7 @@ struct meson_pcie_rc_reset {
 
 struct meson_pcie {
 	struct dw_pcie pci;
-	struct meson_pcie_mem_res mem_res;
+	void __iomem *cfg_base;
 	struct meson_pcie_clk_res clk_res;
 	struct meson_pcie_rc_reset mrst;
 	struct gpio_desc *reset_gpio;
@@ -113,28 +104,18 @@ static int meson_pcie_get_resets(struct meson_pcie *mp)
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
+
+	pci->dbi_base = devm_platform_ioremap_resource_byname(pdev, "elbi");
+	if (IS_ERR(pci->dbi_base))
+		return PTR_ERR(pci->dbi_base);
 
-	mp->mem_res.cfg_base = meson_pcie_get_mem(pdev, mp, "cfg");
-	if (IS_ERR(mp->mem_res.cfg_base))
-		return PTR_ERR(mp->mem_res.cfg_base);
+	mp->cfg_base = devm_platform_ioremap_resource_byname(pdev, "cfg");
+	if (IS_ERR(mp->cfg_base))
+		return PTR_ERR(mp->cfg_base);
 
 	return 0;
 }
@@ -232,24 +213,14 @@ static int meson_pcie_probe_clocks(struct meson_pcie *mp)
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
@@ -287,30 +258,34 @@ static int meson_size_to_payload(struct meson_pcie *mp, int size)
 
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
@@ -436,7 +411,6 @@ static int meson_add_pcie_port(struct meson_pcie *mp,
 	}
 
 	pp->ops = &meson_pcie_host_ops;
-	pci->dbi_base = mp->mem_res.elbi_base;
 
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
-- 
2.25.1

