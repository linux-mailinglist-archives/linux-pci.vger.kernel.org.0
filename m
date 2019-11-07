Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A794AF26B3
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 05:59:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733094AbfKGE7F (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 23:59:05 -0500
Received: from mx.socionext.com ([202.248.49.38]:53324 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfKGE7F (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 23:59:05 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Nov 2019 13:59:04 +0900
Received: from mail.mfilter.local (m-filter-1 [10.213.24.61])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id 6CFD8605F8;
        Thu,  7 Nov 2019 13:59:04 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Nov 2019 13:59:11 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id EC4601A0E9F;
        Thu,  7 Nov 2019 13:59:03 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 1/2] PCI: uniphier: Set mode register to host mode
Date:   Thu,  7 Nov 2019 13:58:14 +0900
Message-Id: <1573102695-7018-1-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

In order to avoid effect of the initial mode depending on SoCs,
this patch sets the mode register to host(RC) mode.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 3f30ee4..8fd7bad 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -33,6 +33,10 @@
 #define PCL_PIPEMON			0x0044
 #define PCL_PCLK_ALIVE			BIT(15)
 
+#define PCL_MODE			0x8000
+#define PCL_MODE_REGEN			BIT(8)
+#define PCL_MODE_REGVAL			BIT(0)
+
 #define PCL_APP_READY_CTRL		0x8008
 #define PCL_APP_LTSSM_ENABLE		BIT(0)
 
@@ -85,6 +89,12 @@ static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
 {
 	u32 val;
 
+	/* set RC MODE */
+	val = readl(priv->base + PCL_MODE);
+	val |= PCL_MODE_REGEN;
+	val &= ~PCL_MODE_REGVAL;
+	writel(val, priv->base + PCL_MODE);
+
 	/* use auxiliary power detection */
 	val = readl(priv->base + PCL_APP_PM0);
 	val |= PCL_SYS_AUX_PWR_DET;
-- 
2.7.4

