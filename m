Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 69ADD29D3C4
	for <lists+linux-pci@lfdr.de>; Wed, 28 Oct 2020 22:46:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727555AbgJ1Vqq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 28 Oct 2020 17:46:46 -0400
Received: from mail-oi1-f194.google.com ([209.85.167.194]:36057 "EHLO
        mail-oi1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727552AbgJ1Vqp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 28 Oct 2020 17:46:45 -0400
Received: by mail-oi1-f194.google.com with SMTP id y186so1146944oia.3;
        Wed, 28 Oct 2020 14:46:44 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=IzJpgC50B1aEr5UEqZkrsDaDZthdlXtSVmgpDKQvfR0=;
        b=gGonjpqaOi4GHjiOHdO99qHL7noHK1rMie/PdkRskUbm0fG29aJA2c7StOC8Sjzjk3
         7sCGF9MCWMETAXLJbba7dTGLAq7lx6YG4LJU1GEO70M9g8RH5yc9NBF49ZPdj8pYDY2J
         tDZLkkVSyik2eLd7PtTNbB/f5IUQKHkF0+/MBlVlcV6hgwxPIe6V0pGDXIlFpaRcSp63
         2MT+juY2wvWVCnePXu5c7CcUutnB7Fe2bV4aYp6ACe8Fo/qcNjVD09Tvm9ZmlrUOm1N6
         0beiHn3eobmImYpneXZVwPjR8jgJAmElW7MB1KYOmjgTz4qsOttBNgy3FgdhOLmtb65F
         EdMA==
X-Gm-Message-State: AOAM533Pfaj7HN/7TubnBye66jNzX+oGFJncdzIpsdzLkJHC10/EgnqX
        KAqgiHLkTFScEJjGkwlOUL1bjhHA1Q==
X-Google-Smtp-Source: ABdhPJwkVdug/4qdZCJhvQsjCEVeaO4AKUvKQygW6QFcLOHfAO/BojTtu59syxrkhQvjVSXU4OEQTQ==
X-Received: by 2002:aca:b145:: with SMTP id a66mr658786oif.92.1603918019964;
        Wed, 28 Oct 2020 13:46:59 -0700 (PDT)
Received: from xps15.herring.priv (24-155-109-49.dyn.grandenetworks.net. [24.155.109.49])
        by smtp.googlemail.com with ESMTPSA id t17sm116123oor.3.2020.10.28.13.46.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Oct 2020 13:46:59 -0700 (PDT)
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
Subject: [PATCH 04/13] PCI: dwc/intel-gw: Remove some unneeded function wrappers
Date:   Wed, 28 Oct 2020 15:46:37 -0500
Message-Id: <20201028204646.356535-5-robh@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201028204646.356535-1-robh@kernel.org>
References: <20201028204646.356535-1-robh@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Remove some of the pointless levels of functions that just wrap or group
a series of other functions.

Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Rob Herring <robh@kernel.org>
---
 drivers/pci/controller/dwc/pcie-intel-gw.c | 47 ++++++++--------------
 1 file changed, 16 insertions(+), 31 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-intel-gw.c b/drivers/pci/controller/dwc/pcie-intel-gw.c
index 88782653ed21..c562eb7454b1 100644
--- a/drivers/pci/controller/dwc/pcie-intel-gw.c
+++ b/drivers/pci/controller/dwc/pcie-intel-gw.c
@@ -152,19 +152,6 @@ static void intel_pcie_init_n_fts(struct dw_pcie *pci)
 	pci->n_fts[0] = PORT_AFR_N_FTS_GEN12_DFT;
 }
 
-static void intel_pcie_rc_setup(struct intel_pcie_port *lpp)
-{
-	struct dw_pcie *pci = &lpp->pci;
-
-	pci->atu_base = pci->dbi_base + 0xC0000;
-
-	intel_pcie_ltssm_disable(lpp);
-	intel_pcie_link_setup(lpp);
-	intel_pcie_init_n_fts(pci);
-	dw_pcie_setup_rc(&pci->pp);
-	dw_pcie_upconfig_setup(pci);
-}
-
 static int intel_pcie_ep_rst_init(struct intel_pcie_port *lpp)
 {
 	struct device *dev = lpp->pci.dev;
@@ -216,14 +203,6 @@ static void intel_pcie_device_rst_deassert(struct intel_pcie_port *lpp)
 	gpiod_set_value_cansleep(lpp->reset_gpio, 0);
 }
 
-static int intel_pcie_app_logic_setup(struct intel_pcie_port *lpp)
-{
-	intel_pcie_device_rst_deassert(lpp);
-	intel_pcie_ltssm_enable(lpp);
-
-	return dw_pcie_wait_for_link(&lpp->pci);
-}
-
 static void intel_pcie_core_irq_disable(struct intel_pcie_port *lpp)
 {
 	pcie_app_wr(lpp, PCIE_APP_IRNEN, 0);
@@ -273,11 +252,6 @@ static int intel_pcie_get_resources(struct platform_device *pdev)
 	return 0;
 }
 
-static void intel_pcie_deinit_phy(struct intel_pcie_port *lpp)
-{
-	phy_exit(lpp->phy);
-}
-
 static int intel_pcie_wait_l2(struct intel_pcie_port *lpp)
 {
 	u32 value;
@@ -314,6 +288,7 @@ static void intel_pcie_turn_off(struct intel_pcie_port *lpp)
 static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 {
 	int ret;
+	struct dw_pcie *pci = &lpp->pci;
 
 	intel_pcie_core_rst_assert(lpp);
 	intel_pcie_device_rst_assert(lpp);
@@ -330,8 +305,18 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 		goto clk_err;
 	}
 
-	intel_pcie_rc_setup(lpp);
-	ret = intel_pcie_app_logic_setup(lpp);
+	pci->atu_base = pci->dbi_base + 0xC0000;
+
+	intel_pcie_ltssm_disable(lpp);
+	intel_pcie_link_setup(lpp);
+	intel_pcie_init_n_fts(pci);
+	dw_pcie_setup_rc(&pci->pp);
+	dw_pcie_upconfig_setup(pci);
+
+	intel_pcie_device_rst_deassert(lpp);
+	intel_pcie_ltssm_enable(lpp);
+
+	ret = dw_pcie_wait_for_link(pci);
 	if (ret)
 		goto app_init_err;
 
@@ -345,7 +330,7 @@ static int intel_pcie_host_setup(struct intel_pcie_port *lpp)
 	clk_disable_unprepare(lpp->core_clk);
 clk_err:
 	intel_pcie_core_rst_assert(lpp);
-	intel_pcie_deinit_phy(lpp);
+	phy_exit(lpp->phy);
 
 	return ret;
 }
@@ -356,7 +341,7 @@ static void __intel_pcie_remove(struct intel_pcie_port *lpp)
 	intel_pcie_turn_off(lpp);
 	clk_disable_unprepare(lpp->core_clk);
 	intel_pcie_core_rst_assert(lpp);
-	intel_pcie_deinit_phy(lpp);
+	phy_exit(lpp->phy);
 }
 
 static int intel_pcie_remove(struct platform_device *pdev)
@@ -380,7 +365,7 @@ static int __maybe_unused intel_pcie_suspend_noirq(struct device *dev)
 	if (ret)
 		return ret;
 
-	intel_pcie_deinit_phy(lpp);
+	phy_exit(lpp->phy);
 	clk_disable_unprepare(lpp->core_clk);
 	return ret;
 }
-- 
2.25.1

