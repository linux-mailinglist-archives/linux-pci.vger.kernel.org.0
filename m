Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7E6275E6D0
	for <lists+linux-pci@lfdr.de>; Mon, 24 Jul 2023 03:23:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbjGXBXW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 23 Jul 2023 21:23:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230453AbjGXBWp (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 23 Jul 2023 21:22:45 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF4B172A;
        Sun, 23 Jul 2023 18:22:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9ACEE60DFE;
        Mon, 24 Jul 2023 01:21:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65007C433C8;
        Mon, 24 Jul 2023 01:21:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1690161711;
        bh=2QNGaY2DaRrBjCfM5fLks9ZRa+p0jKlZ1NmYBYgutRs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=L7AXFRdCY3k8a0nmLGtIFCUZaGQ3Whjt2KD0g/Dq2QBNnrxYSiWYl6C3X6LmNwa3J
         YyKnySzb4nxn0ZUWnicQzsNTQ7HV7U3aMeFUMtyApX3rK6v7Nqhrzj8mRZvRPP30Ed
         QOEoZIyPCAQO86O1BQwSwKXE8W7ykM/gaxfO9Y5P4mBOE2T/0f6dpkh2xDuHJXW6/b
         ZfVtNi6qoOtyC6um/TUpi7yEL2uT+qTdEZkRt8SBjafag0Lcxr+g7zxlTkxSoDGCOG
         yZgMzjtd3Tt56m3st3TB9ffM/xdtgMA8ypNAYVadzSLreugFBeBcY5NbIDg5WdMgEL
         3qptm4RPKH8Mg==
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Sumit Gupta <sumitg@nvidia.com>,
        Bjorn Helgaas <helgaas@kernel.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Thierry Reding <treding@nvidia.com>,
        Sasha Levin <sashal@kernel.org>, kw@linux.com,
        bhelgaas@google.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, mani@kernel.org,
        Sergey.Semin@baikalelectronics.ru, robh@kernel.org,
        johan+linaro@kernel.org, dmitry.baryshkov@linaro.org,
        linux-pci@vger.kernel.org, linux-tegra@vger.kernel.org
Subject: [PATCH AUTOSEL 6.1 09/41] PCI: tegra194: Fix possible array out of bounds access
Date:   Sun, 23 Jul 2023 21:20:42 -0400
Message-Id: <20230724012118.2316073-9-sashal@kernel.org>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230724012118.2316073-1-sashal@kernel.org>
References: <20230724012118.2316073-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
X-stable-base: Linux 6.1.40
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
index 1b6b437823d22..528e73ccfa43e 100644
--- a/drivers/pci/controller/dwc/pcie-tegra194.c
+++ b/drivers/pci/controller/dwc/pcie-tegra194.c
@@ -224,6 +224,7 @@
 #define EP_STATE_ENABLED	1
 
 static const unsigned int pcie_gen_freq[] = {
+	GEN1_CORE_CLK_FREQ,	/* PCI_EXP_LNKSTA_CLS == 0; undefined */
 	GEN1_CORE_CLK_FREQ,
 	GEN2_CORE_CLK_FREQ,
 	GEN3_CORE_CLK_FREQ,
@@ -455,7 +456,11 @@ static irqreturn_t tegra_pcie_ep_irq_thread(int irq, void *arg)
 
 	speed = dw_pcie_readw_dbi(pci, pcie->pcie_cap_base + PCI_EXP_LNKSTA) &
 		PCI_EXP_LNKSTA_CLS;
-	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed - 1]);
+
+	if (speed >= ARRAY_SIZE(pcie_gen_freq))
+		speed = 0;
+
+	clk_set_rate(pcie->core_clk, pcie_gen_freq[speed]);
 
 	if (pcie->of_data->has_ltr_req_fix)
 		return IRQ_HANDLED;
@@ -1016,7 +1021,11 @@ static int tegra_pcie_dw_start_link(struct dw_pcie *pci)
 
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

