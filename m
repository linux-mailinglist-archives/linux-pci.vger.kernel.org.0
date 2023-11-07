Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA5327E4507
	for <lists+linux-pci@lfdr.de>; Tue,  7 Nov 2023 17:00:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234916AbjKGQAZ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 7 Nov 2023 11:00:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344692AbjKGP7a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 7 Nov 2023 10:59:30 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 491A97DA3;
        Tue,  7 Nov 2023 07:52:22 -0800 (PST)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1DEE3C433C8;
        Tue,  7 Nov 2023 15:52:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1699372341;
        bh=Uf97kONez/vCKWsXsmx59dIbWr+W5iilYM9iQ5jVqaQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=fVZWcMu+TxEC1fPum4VE88M7uSBW5xg50pzSBVnrU+fXRBmbKz4TDMNEOAdqpCudW
         /LJZhh0m/ynYYaNxw/QwLvYaFl5d6eZ0SZ58p8faUnhoFg77Y/tI/RygPQyqY+kmrN
         mV3J8i2omcwWVrcNvX+1PMIkyBQFO7nIZ4H8ja8z9SbhecZevd20w/Dw/EzEGeTe2L
         fvae1fdZ88H+nPYrBUW7ZxTqZXIoCW1lN1O+9tcZsp3LDoLU0c6IuVqW2iFgF88iYM
         1ZyFC50t5d60pbzjA6Ql6/cFaSg8KyPSi18AGytwa5/nzvlbQPjkd9J88fx2GLprTu
         /+IjIWHZX+/Zg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Sasha Levin <sashal@kernel.org>, lpieralisi@kernel.org,
        kw@linux.com, thierry.reding@gmail.com, jonathanh@nvidia.com,
        mani@kernel.org, sumitg@nvidia.com, u.kleine-koenig@pengutronix.de,
        vidyas@nvidia.com, yoshihiro.shimoda.uh@renesas.com,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 13/22] PCI: tegra194: Use FIELD_GET()/FIELD_PREP() with Link Width fields
Date:   Tue,  7 Nov 2023 10:51:22 -0500
Message-ID: <20231107155146.3767610-13-sashal@kernel.org>
X-Mailer: git-send-email 2.42.0
In-Reply-To: <20231107155146.3767610-1-sashal@kernel.org>
References: <20231107155146.3767610-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.137
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
index 765abe0732282..2f82da76e3711 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -7,6 +7,7 @@
  * Author: Vidya Sagar <vidyas@nvidia.com>
  */
 
+#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/debugfs.h>
 #include <linux/delay.h>
@@ -328,8 +329,7 @@ static void apply_bad_link_workaround(struct pcie_port *pp)
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
@@ -889,7 +888,7 @@ static int tegra_pcie_dw_host_init(struct pcie_port *pp)
 	/* Configure Max lane width from DT */
 	val = dw_pcie_readl_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP);
 	val &= ~PCI_EXP_LNKCAP_MLW;
-	val |= (pcie->num_lanes << PCI_EXP_LNKSTA_NLW_SHIFT);
+	val |= FIELD_PREP(PCI_EXP_LNKCAP_MLW, pcie->num_lanes);
 	dw_pcie_writel_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKCAP, val);
 
 	config_gen3_gen4_eq_presets(pcie);
-- 
2.42.0

