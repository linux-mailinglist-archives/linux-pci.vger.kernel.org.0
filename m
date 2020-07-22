Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB2F228E74
	for <lists+linux-pci@lfdr.de>; Wed, 22 Jul 2020 05:13:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731630AbgGVDN1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 21 Jul 2020 23:13:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:38558 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731621AbgGVDN1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 21 Jul 2020 23:13:27 -0400
Received: from embeddedor (unknown [201.162.241.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1C73E207CD;
        Wed, 22 Jul 2020 03:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595387606;
        bh=dtoCdUEmKe3K+GX9hTYYwHUWlcrljUxsFv8D57+cspo=;
        h=Date:From:To:Cc:Subject:From;
        b=vk2YMEdFcMgL1qzpSDrii3EXT+ZwZWyG3yjeh6eLsVrNH5wW8lCkZrVG7sGmOczxz
         W9p1C7EmhHkpzPAJiRBP6s/LV6+2J1J6CJ5U9KXnreZh1+YRkScE+hu6r2box0BAjR
         Qj9HYehoxzxiWxlmDRdQvSRGPKahBz4IbZ4EcBEY=
Date:   Tue, 21 Jul 2020 22:19:03 -0500
From:   "Gustavo A. R. Silva" <gustavoars@kernel.org>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH v2][next] PCI: imx6: Use fallthrough pseudo-keyword
Message-ID: <20200722031903.GA3711@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Replace the existing /* fall through */ comments and its variants with
the new pseudo-keyword macro fallthrough[1]. Also, remove unnecessary
fall-through markings when it is the case.

[1] https://www.kernel.org/doc/html/v5.7/process/deprecated.html?highlight=fallthrough#implicit-switch-case-fall-through

Signed-off-by: Gustavo A. R. Silva <gustavoars@kernel.org>
---
Changes in v2:
 - Update URL. Use proper URL to Linux v5.7 documentation.

 drivers/pci/controller/dwc/pci-imx6.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pci-imx6.c b/drivers/pci/controller/dwc/pci-imx6.c
index 8f08ae53f53e..6c78903b49be 100644
--- a/drivers/pci/controller/dwc/pci-imx6.c
+++ b/drivers/pci/controller/dwc/pci-imx6.c
@@ -439,7 +439,7 @@ static int imx6_pcie_enable_ref_clk(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_TEST_POWERDOWN, 0);
 		break;
-	case IMX6QP:		/* FALLTHROUGH */
+	case IMX6QP:
 	case IMX6Q:
 		/* power up core phy and enable ref clock */
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR1,
@@ -642,7 +642,7 @@ static void imx6_pcie_init_phy(struct imx6_pcie *imx6_pcie)
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6SX_GPR12_PCIE_RX_EQ_MASK,
 				   IMX6SX_GPR12_PCIE_RX_EQ_2);
-		/* FALLTHROUGH */
+		fallthrough;
 	default:
 		regmap_update_bits(imx6_pcie->iomuxc_gpr, IOMUXC_GPR12,
 				   IMX6Q_GPR12_PCIE_CTL_2, 0 << 10);
@@ -1107,7 +1107,7 @@ static int imx6_pcie_probe(struct platform_device *pdev)
 			dev_err(dev, "pcie_aux clock source missing or invalid\n");
 			return PTR_ERR(imx6_pcie->pcie_aux);
 		}
-		/* fall through */
+		fallthrough;
 	case IMX7D:
 		if (dbi_base->start == IMX8MQ_PCIE2_BASE_ADDR)
 			imx6_pcie->controller_id = 1;
-- 
2.27.0

