Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 218277B0153
	for <lists+linux-pci@lfdr.de>; Wed, 27 Sep 2023 12:08:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230461AbjI0KIV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 27 Sep 2023 06:08:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230000AbjI0KIR (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 27 Sep 2023 06:08:17 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C78A912A;
        Wed, 27 Sep 2023 03:08:13 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1F15224DBD3;
        Wed, 27 Sep 2023 18:08:12 +0800 (CST)
Received: from EXMBX171.cuchost.com (172.16.6.91) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 18:08:12 +0800
Received: from ubuntu.localdomain (113.72.144.128) by EXMBX171.cuchost.com
 (172.16.6.91) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Wed, 27 Sep
 2023 18:08:10 +0800
From:   Minda Chen <minda.chen@starfivetech.com>
To:     Daire McNamara <daire.mcnamara@microchip.com>,
        Conor Dooley <conor@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Emil Renner Berthing <emil.renner.berthing@canonical.com>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-riscv@lists.infradead.org>, <linux-pci@vger.kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Mason Huo <mason.huo@starfivetech.com>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Kevin Xie <kevin.xie@starfivetech.com>,
        Minda Chen <minda.chen@starfivetech.com>
Subject: [PATCH v7 06/19] PCI: microchip: Change the argument of plda_pcie_setup_iomems()
Date:   Wed, 27 Sep 2023 18:07:49 +0800
Message-ID: <20230927100802.46620-7-minda.chen@starfivetech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20230927100802.46620-1-minda.chen@starfivetech.com>
References: <20230927100802.46620-1-minda.chen@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [113.72.144.128]
X-ClientProxiedBy: EXCAS066.cuchost.com (172.16.6.26) To EXMBX171.cuchost.com
 (172.16.6.91)
X-YovoleRuleAgent: yovoleflag
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

If other vendor do not select PCI_HOST_COMMON,
The driver data is not struct pci_host_bridge.
So move calling platform_get_drvdata() to
mc_platform_init().

Signed-off-by: Minda Chen <minda.chen@starfivetech.com>
Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
---
 drivers/pci/controller/plda/pcie-microchip-host.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/plda/pcie-microchip-host.c b/drivers/pci/controller/plda/pcie-microchip-host.c
index c83473e3cf9f..1d253acd6bc2 100644
--- a/drivers/pci/controller/plda/pcie-microchip-host.c
+++ b/drivers/pci/controller/plda/pcie-microchip-host.c
@@ -875,11 +875,10 @@ static void plda_pcie_setup_window(void __iomem *bridge_base_addr, u32 index,
 	writel(0, bridge_base_addr + ATR0_PCIE_WIN0_SRC_ADDR);
 }
 
-static int plda_pcie_setup_iomems(struct platform_device *pdev,
+static int plda_pcie_setup_iomems(struct pci_host_bridge *bridge,
 				  struct plda_pcie_rp *port)
 {
 	void __iomem *bridge_base_addr = port->bridge_addr;
-	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	struct resource_entry *entry;
 	u64 pci_addr;
 	u32 index = 1;
@@ -1017,6 +1016,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 {
 	struct device *dev = cfg->parent;
 	struct platform_device *pdev = to_platform_device(dev);
+	struct pci_host_bridge *bridge = platform_get_drvdata(pdev);
 	void __iomem *bridge_base_addr =
 		port->axi_base_addr + MC_PCIE_BRIDGE_ADDR;
 	int ret;
@@ -1030,7 +1030,7 @@ static int mc_platform_init(struct pci_config_window *cfg)
 	mc_pcie_enable_msi(port, cfg->win);
 
 	/* Configure non-config space outbound ranges */
-	ret = plda_pcie_setup_iomems(pdev, &port->plda);
+	ret = plda_pcie_setup_iomems(bridge, &port->plda);
 	if (ret)
 		return ret;
 
-- 
2.17.1

