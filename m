Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 76B953D41F0
	for <lists+linux-pci@lfdr.de>; Fri, 23 Jul 2021 23:06:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231934AbhGWU0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Jul 2021 16:26:23 -0400
Received: from finn.gateworks.com ([108.161.129.64]:57822 "EHLO
        finn.localdomain" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S231754AbhGWU0X (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Jul 2021 16:26:23 -0400
Received: from 068-189-091-139.biz.spectrum.com ([68.189.91.139] helo=tharvey.pdc.gateworks.com)
        by finn.localdomain with esmtp (Exim 4.93)
        (envelope-from <tharvey@gateworks.com>)
        id 1m727R-0057Vc-KE; Fri, 23 Jul 2021 20:50:05 +0000
From:   Tim Harvey <tharvey@gateworks.com>
To:     Richard Zhu <hongxing.zhu@nxp.com>,
        Lucas Stach <l.stach@pengutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
Cc:     Tim Harvey <tharvey@gateworks.com>
Subject: [PATCH 4/6] reset: imx7: add resets for PCIe
Date:   Fri, 23 Jul 2021 13:49:56 -0700
Message-Id: <20210723204958.7186-5-tharvey@gateworks.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20210723204958.7186-1-tharvey@gateworks.com>
References: <20210723204958.7186-1-tharvey@gateworks.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add reset for PCIe clock and PHY.

Signed-off-by: Tim Harvey <tharvey@gateworks.com>
---
 drivers/reset/reset-imx7.c | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 185a333df66c..423707e1fd59 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -191,6 +191,7 @@ static const struct imx7_src_signal imx8mq_src_signals[IMX8MQ_RESET_NUM] = {
 	[IMX8MQ_RESET_PCIEPHY]			= { SRC_PCIEPHY_RCR,
 						    BIT(2) | BIT(1) },
 	[IMX8MQ_RESET_PCIEPHY_PERST]		= { SRC_PCIEPHY_RCR, BIT(3) },
+	[IMX8MQ_RESET_PCIE_CTRL_APPS_CLK_REQ]	= { SRC_PCIEPHY_RCR, BIT(4) },
 	[IMX8MQ_RESET_PCIE_CTRL_APPS_EN]	= { SRC_PCIEPHY_RCR, BIT(6) },
 	[IMX8MQ_RESET_PCIE_CTRL_APPS_TURNOFF]	= { SRC_PCIEPHY_RCR, BIT(11) },
 	[IMX8MQ_RESET_HDMI_PHY_APB_RESET]	= { SRC_HDMI_RCR, BIT(0) },
@@ -234,7 +235,9 @@ static int imx8mq_reset_set(struct reset_controller_dev *rcdev,
 			udelay(10);
 		break;
 
+	case IMX8MQ_RESET_PCIEPHY_PERST:
 	case IMX8MQ_RESET_PCIE_CTRL_APPS_EN:
+	case IMX8MQ_RESET_PCIE_CTRL_APPS_CLK_REQ:
 	case IMX8MQ_RESET_PCIE2_CTRL_APPS_EN:
 	case IMX8MQ_RESET_MIPI_DSI_PCLK_RESET_N:
 	case IMX8MQ_RESET_MIPI_DSI_ESC_RESET_N:
-- 
2.17.1

