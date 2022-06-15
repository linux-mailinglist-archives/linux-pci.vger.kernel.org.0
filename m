Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4FCC54D517
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355146AbiFOXQz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351170AbiFOXQg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:36 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4012034B81;
        Wed, 15 Jun 2022 16:16:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 92257619B2;
        Wed, 15 Jun 2022 23:16:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AD4E6C3411A;
        Wed, 15 Jun 2022 23:16:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334986;
        bh=OTHz77xYfOj2BzCwLPsZG6pEu0uiIDa86IetAa2AHUU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=dAEULewB8TnpBmlPG1L2uOVIFqh6+hTW0iz4k3KEE5icPkIshC7xvUAWUeA7tbBvN
         PM6xf/+jRMcxz+4eYtEfFtExQTMz6PXbGUWG2pJfoZMwuaKiRUl55Iylk7LzdIJkP1
         6R07fm4CwpXDb3GQjeRj4hrKl8DxQgYDS5Q7bdKD+28ImkZsoadPY+o/IbYHB0fTpR
         +1FLQXpSUy5BRrzqN+XAHW81GsDL+DJK63p8W3Qypoy+D0VzE4oo37HN/uV3bI9b+c
         Lm71TwwwqGblLM9eg4EgMhsBGkFN7OGikMPt1+TAN8skxjjLSkNaxflKaTE5/LqCmK
         5vMIgj2rmdNmg==
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Fabio Estevam <festevam@gmail.com>,
        Francesco Dolcini <francesco.dolcini@toradex.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Bjorn Helgaas <bhelgaas@google.com>
Subject: [PATCH v12 11/13] PCI: imx6: Reduce resume time by only starting link if it was up before suspend
Date:   Wed, 15 Jun 2022 18:15:49 -0500
Message-Id: <20220615231551.1054753-12-helgaas@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220615231551.1054753-1-helgaas@kernel.org>
References: <20220615231551.1054753-1-helgaas@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Richard Zhu <hongxing.zhu@nxp.com>

Because i.MX PCIe doesn't support hot-plug feature.  In the link down
scenario, only start the PCIe link training in resume when the link is up
before system suspend to avoid the long latency in the link training
period.

[bhelgaas: drop now-unused "ret"]
Link: https://lore.kernel.org/r/1655189942-12678-8-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/controller/dwc/pci-imx6.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 7d3592540b8a..b6e5420d67b6 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -67,6 +67,7 @@ struct imx6_pcie {
 	struct dw_pcie		*pci;
 	int			reset_gpio;
 	bool			gpio_active_high;
+	bool			link_is_up;
 	struct clk		*pcie_bus;
 	struct clk		*pcie_phy;
 	struct clk		*pcie_inbound_axi;
@@ -900,6 +901,7 @@ static int imx6_pcie_start_link(struct dw_pcie *pci)
 		dev_info(dev, "Link: Gen2 disabled\n");
 	}
 
+	imx6_pcie->link_is_up = true;
 	tmp = dw_pcie_readw_dbi(pci, offset + PCI_EXP_LNKSTA);
 	dev_info(dev, "Link up, Gen%i\n", tmp & PCI_EXP_LNKSTA_CLS);
 	return 0;
@@ -1025,7 +1027,6 @@ static int imx6_pcie_suspend_noirq(struct device *dev)
 
 static int imx6_pcie_resume_noirq(struct device *dev)
 {
-	int ret;
 	struct imx6_pcie *imx6_pcie = dev_get_drvdata(dev);
 	struct pcie_port *pp = &imx6_pcie->pci->pp;
 
@@ -1036,10 +1037,8 @@ static int imx6_pcie_resume_noirq(struct device *dev)
 	imx6_pcie_init_phy(imx6_pcie);
 	imx6_pcie_deassert_core_reset(imx6_pcie);
 	dw_pcie_setup_rc(pp);
-
-	ret = imx6_pcie_start_link(imx6_pcie->pci);
-	if (ret < 0)
-		dev_info(dev, "pcie link is down after resume.\n");
+	if (imx6_pcie->link_is_up)
+		imx6_pcie_start_link(imx6_pcie->pci);
 
 	return 0;
 }
-- 
2.25.1

