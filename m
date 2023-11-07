Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AB7E44CC
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 16:57:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235536AbjKGP5y (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 10:57:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343917AbjKGP50 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:57:26 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3079A1FE8;
        Tue,  7 Nov 2023 07:51:08 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AA76C433C7;
        Tue,  7 Nov 2023 15:51:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372267;
        bh=nfb5nN17v0+f0ezzG8nk6Y33+M5O9n95jP9ZIUTL3KQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OJuBxySvxYjFcDljS3JDPEqy1ZY3w8vpEsF0ss1QQWKIJG3u521RZuVLSDNyOhdR8
         8GRYmyFcv/bc7UG/qzLUmkqRRosuF46HAjEDvoTh0yy9sQdOUtgrsKPBtk9Bi2PanP
         glOXF81OV8qCVbHUh7KbW7xDdlI4LGTiZx4dmxDoCb2uGgxNwuOH6vdH9RLoQuc0CN
         sOaKz2FkXwQ730wL7h1gJ+WI13lPtjwOJtcBzgG3ip+goEOcbiRf+M15F2yfbFnnIq
         P4YGnlM2dyHSmVex0/lOWI1e4v97u4DWl8GgwHC1pM3LmSc4CrbKYRTONzVC+fw5B1
         fpsOqcxrevveA==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, lpieralisi@kernel.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, fancer.lancer@gmail.com, sumitg@nvidia.com,
        yoshihiro.shimoda.uh@renesas.com, vidyas@nvidia.com,
        u.kleine-koenig@pengutronix.de, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 16/30] PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
Date:   Tue,  7 Nov 2023 10:49:50 -0500
Message-ID: <20231107155024.3766950-16-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155024.3766950-1-sashal@kernel.org>
References: <20231107155024.3766950-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.61
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
index 2241029537a03..5d1ae2706f6ea 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -9,6 +9,7 @@
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -324,8 +325,7 @@ static void apply_bad_link_workaround(struct dw_pcie_rp *pp)
 	 */
 	val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA);
 	if (val & PCI_EXP_LNKSTA_LBMS) {
-		current_link_width = (val & PCI_EXP_LNKSTA_NLW) >>
-				     PCI_EXP_LNKSTA_NLW_SHIFT;
+		current_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val);
 		if (pcie->init_link_width > current_link_width) {
 			dev_warn(pci->dev, "PCIe link is bad, width reduced\n");
 			val = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base +
@@ -740,8 +740,7 @@ static void tegra_pcie_enable_system_interrupts(struct dw_pcie_rp *pp)
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKSTA);
-	pcie->init_link_width = (val_w & PCI_EXP_LNKSTA_NLW) >>
-				PCI_EXP_LNKSTA_NLW_SHIFT;
+	pcie->init_link_width = FIELD_GET(PCI_EXP_LNKSTA_NLW, val_w);
 
 	val_w = dw_pcie_readw_dbi(&pcie->pci, pcie->pcie_cap_base +
 				  PCI_EXP_LNKCTL);
@@ -900,7 +899,7 @@ static int tegra_pcie_dw_host_init(struct dw_pcie_rp *pp)
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
+	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, pcie->num_lanes);
 	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
 
 	/* Clear Slot Clock Configuration bit if SRNS configuration */
-- 
2.42.0

