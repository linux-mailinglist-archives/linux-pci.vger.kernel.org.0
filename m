Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7634D75E742
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 03:26:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231428AbjGXB0Z (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 21:26:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231197AbjGXBZ7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 21:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CF103A9B;
        Sun, 23 Jul 2023 18:23:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7217F60EEE;
        Mon, 24 Jul 2023 01:23:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 85711C433C7;
        Mon, 24 Jul 2023 01:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161824;
        bh=uL2rN0ne+qRm7I+ih7jR60OsmA7MDjG3+PK+nxGqKWI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mYYVPtycg75hQZz1dJ3E4AOPBxRWNv8XXVfX3xajHbcLyhZy/HLJMRMwsUtfyamEU
         QzvFRm30dO6qhM3+CFTRplLto9legYwVyfAq4UeKlsUb3T1bQRcivxzXCjA+0wpgte
         h5gYgRSXm8DDGL6Hp16+tKxo37brN1r7SkKx8y1ba7kn+IZ/rP+NTf13b0H3dls8tB
         i97W/rq/4CaUtr/ArF5Tikc+FdhwmNM8yPLvFAde4myhWnBPENH0ovgWTc41htuB3K
         GP29V5/BTPtE8tC1cUIEW7Fk99qeYBl5pl8+QeC2IMGooJWdixiquxCo9ENddIhI/A
         /GYYirasJ575w==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sumit Gupta <sumitg@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, lorenzo.pieralisi@arm.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, vidyas@nvidia.com, linux-pci@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 5.15 03/23] PCI: tegra194: Fix possible array out of bounds access
Date:   Sun, 23 Jul 2023 21:23:14 -0400
Message-Id: <20230724012334.2317140-3-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012334.2317140-1-sashal@kernel.org>
References: <20230724012334.2317140-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 5.15.121
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Sumit Gupta <sumitg@nvidia.com>

[ Upstream commit 205b3d02d57ce6dce96f6d2b9c230f56a9bf9817 ]

Add check to fix the possible array out of bounds violation by
making speed equal to GEN1_CORE_CLK_FREQ when its value is more
than the size of "pcie_gen_freq" array. This array has size of
four but possible speed (CLS) values are from "0 to 0xF". So,
"speed - 1" values are "-1 to 0xE".

Suggested-by: Bjorn Helgaas <helgaas@kernel.org>
Signed-off-by: Sumit Gupta <sumitg@nvidia.com>
Link: https://lore.kernel.org/lkml/72b9168b-d4d6-4312-32ea-69358df2f2d0@nvidia.com/
Acked-by: Lorenzo Pieralisi <lpieralisi@kernel.org>
Signed-off-by: Thierry Reding <treding@nvidia.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 drivers/pci/controller/dwc/pcie-tegra194.c | 13 +++++++++++--
 1 file changed, 11 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-tegra194.c b/drivers/pci/controller/dwc/pcie-tegra194.c
index bdd84765e6460..765abe0732282 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -239,6 +239,7 @@
 #define EP_STATE_ENABLED	1
 
 static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,	/* PCI_EXP_LNKSTA_CLS == 0; undefined */
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
@@ -452,7 +453,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	/* If EP doesn't advertise L1SS, just return */
 	val = dw_pcie_readl_dbi(pci, pcie->cfg_link_cap_l1sub);
@@ -989,7 +994,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	tegra_pcie_enable_interrupts(pp);
 
-- 
2.39.2

