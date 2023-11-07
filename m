Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B9527E4520
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 17:01:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344411AbjKGQBr (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 11:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343739AbjKGQAN (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 11:00:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AEC58683;
        Tue,  7 Nov 2023 07:53:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C7C40C433CA;
        Tue,  7 Nov 2023 15:53:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372401;
        bh=eqPnjWdwbpgoqmlLb0H40IZgj3+eyJcYzK7r4A4nm0o=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ByxU6UFTKwio+6x8GBhIagTPaYw0/qAZALqJRWKd+diXOmx3CXXZ8Cau8QRiwUjbP
         K80UeVDLgP/wS224ZuEPl55QwmsZ7BSBHPLV2qRqjIdcEI2pbyItManmGlEZ0K+M4J
         6p/U2qc4VzmjuNV//7SSvPRHvXd4Ga97a8SgFgyUXnaO1KKF82GuxCMVG1RLDsrkTO
         klzFILO+BEBvzKmLzgmBsj24NAGJX907VqNsvM/z8V2i/qRliOqqoE2lp9KZCaIRgw
         Vnj4Z7gZrhMEPbnVlThbeg1urCTtOBYwKQ+1Db6f83/3trF55jKsGV5QVYL8SG5ZZY
         0fxk95iGYMnXg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, lpieralisi@kernel.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, sumitg@nvidia.com,
        yoshihiro.shimoda.uh@renesas.com, robh@kernel.org,
        vidyas@nvidia.com, u.kleine-koenig@pengutronix.de,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.10 11/16] PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
Date:   Tue,  7 Nov 2023 10:52:30 -0500
Message-ID: <20231107155249.3768098-11-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155249.3768098-1-sashal@kernel.org>
References: <20231107155249.3768098-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.10.199
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>

[ Upstream commit 759574abd78e3b47ec45bbd31a64e8832cf73f97 ]

Use FIELD_GET() to extract PCIe Negotiated Link Width field instead of
custom masking and shifting.

Similarly, change custom code that misleadingly used
PCI_EXP_LNKSTA_NLW_SHIFT to prepare value for PCI_EXP_LNKCAP write
to use FIELD_PREP() with correct field define (PCI_EXP_LNKCAP_MLW).

Link: https://lore.kernel.org/r/20230919125648.1920-5-ilpo.jarvinen@linux.intel.com
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index a215777df96c7..80c2015b49d8f 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -7,6 +7,7 @@
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -346,8 +347,7 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
 	 */
 	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 	if (val & PCI_EXP_LNKSTA_LBMS) {
-		current_link_width = (val & PCI_EXP_LNKSTA_NLW) >>
-				     PCI_EXP_LNKSTA_NLW_SHIFT;
+		current_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
 		if (pcie->init_link_width > current_link_width) {
 			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
 			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
@@ -731,8 +731,7 @@ static void tegra_pcie_enable_system_interrupts(struct pcie_port *pp)
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKSTA);
-	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
-				PCI_EXP_LNKSTA_NLW_SHIFT;
+	pcie->init_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val_w);
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKCTL);
@@ -885,7 +884,7 @@ static void tegra_pcie_prepare_host(struct pcie_port *pp)
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
+	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, pcie->num_lanes);
 	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
 
 	config_gen3_gen4_eq_presets(pcie);
-- 
2.42.0

