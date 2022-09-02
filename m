Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D70BA5AAB0D
	for <lists+linux-pci@lfdr.de>; Fri,  2 Sep 2022 11:14:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235633AbiIBJN7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Sep 2022 05:13:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235575AbiIBJNy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Sep 2022 05:13:54 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F30FC2E95;
        Fri,  2 Sep 2022 02:13:53 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 9CA37200697;
        Fri,  2 Sep 2022 11:13:51 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 615CF200694;
        Fri,  2 Sep 2022 11:13:51 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 5C2BB1820F5D;
        Fri,  2 Sep 2022 17:13:49 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     p.zabel@pengutronix.de, l.stach@pengutronix.de,
        bhelgaas@google.com, lorenzo.pieralisi@arm.com, robh@kernel.org,
        shawnguo@kernel.org, vkoul@kernel.org,
        alexander.stein@ew.tq-group.com, marex@denx.de,
        richard.leitner@linux.dev
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com, Richard Zhu <hongxing.zhu@nxp.com>
Subject: [PATCH v6 4/7] reset: imx7: Fix the iMX8MP PCIe PHY PERST support
Date:   Fri,  2 Sep 2022 16:55:55 +0800
Message-Id: <1662108958-15800-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1662108958-15800-1-git-send-email-hongxing.zhu@nxp.com>
References: <1662108958-15800-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On i.MX7/iMX8MM/iMX8MQ, the initialized default value of PERST bit(BIT3)
of SRC_PCIEPHY_RCR is 1b'1.
But i.MX8MP has one inversed default value 1b'0 of PERST bit.

And the PERST bit should be kept 1b'1 after power and clocks are stable.
So fix the i.MX8MP PCIe PHY PERST support here.

Fixes: e08672c03981 ("reset: imx7: Add support for i.MX8MP SoC")
Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
Reviewed-by: Philipp Zabel <p.zabel@pengutronix.de>
Tested-by: Marek Vasut <marex@denx.de>
Tested-by: Richard Leitner <richard.leitner@skidata.com>
Tested-by: Alexander Stein <alexander.stein@ew.tq-group.com>
---
 drivers/reset/reset-imx7.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index 185a333df66c..d2408725eb2c 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -329,6 +329,7 @@ static int imx8mp_reset_set(struct reset_controller_dev *rcdev,
 		break;
 
 	case IMX8MP_RESET_PCIE_CTRL_APPS_EN:
+	case IMX8MP_RESET_PCIEPHY_PERST:
 		value = assert ? 0 : bit;
 		break;
 	}
-- 
2.25.1

