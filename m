Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB5C954D52C
	for <lists+linux-pci@lfdr.de>; Thu, 16 Jun 2022 01:22:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355709AbiFOXQn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 15 Jun 2022 19:16:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352209AbiFOXQY (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 15 Jun 2022 19:16:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48E36326D8;
        Wed, 15 Jun 2022 16:16:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9C117619A2;
        Wed, 15 Jun 2022 23:16:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CD2A2C3411E;
        Wed, 15 Jun 2022 23:16:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655334980;
        bh=3cLKaeAlo+Sy59tfNtk5xZLRjzRekSFYTs9v6gKNT0M=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=SXqrIsZbTzwVX9omCBijrvdwVv+sidwhOqu9nrSWnDvrBGSJCsPU9U5fRmiASUvbC
         2rjGpSrMekg2FAsVU/Ocfe5VuTuqczVL3g0VTbxQVyG0hAT31IryBdqnXIol36fvU7
         F3qYxauFNVQZg4wXBEkBMMvoJ8NzNqztJZq/JDJqjvk+e8RgA/ZFsVjYleYHVmzYn7
         naYr41KowLJzU0LJjJ56lvuIRnyr+R3MnkOszBuJnNFp8PMbxXUqrcFz5rEXArpI0P
         6PBArsBDXEiKQVYY2wuXu+/ZImONal62PJT4XII3XW4HNyBJC6QzzQcEGNaI9Boqca
         8cCkhX2cormrw==
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
Subject: [PATCH v12 08/13] PCI: imx6: Disable i.MX6QDL clock when disabling ref clocks
Date:   Wed, 15 Jun 2022 18:15:46 -0500
Message-Id: <20220615231551.1054753-9-helgaas@kernel.org>
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

When disabling PCIe clocks, disable i.MX6QDL ref clock too.

Link: https://lore.kernel.org/r/1655189942-12678-5-git-send-email-hongxing.zhu@nxp.com
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Signed-off-by: Bjorn Helgaas <bhelgaas@google.com>
Reviewed-by: Lucas Stach <l.stach@pengutronix.de>
---
 drivers/pci/controller/dwc/pci-imx6.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 90ab9397a935..6eddd0b5f628 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -586,6 +586,14 @@ static void imx6_pcie_disable_ref_clk(struct imx6_pcie *imx6_pcie)
 	case IMX6SX:
 		clk_disable_unprepare(imx6_pcie->pcie_inbound_axi);
 		break;
+	case IMX6QP:
+	case IMX6Q:
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_REF_CLK_EN, 0);
+		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
+				IMX6Q_GPR1_PCIE_TEST_PD,
+				IMX6Q_GPR1_PCIE_TEST_PD);
+		break;
 	case IMX7D:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX7D_GPR12_PCIE_PHY_REFCLK_SEL,
-- 
2.25.1

