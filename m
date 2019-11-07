Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id CCAC3F26B5
	for <lists+linux-pci@lfdr.de>; Thu,  7 Nov 2019 05:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733198AbfKGE7I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 6 Nov 2019 23:59:08 -0500
Received: from mx.socionext.com ([202.248.49.38]:53331 "EHLO mx.socionext.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726582AbfKGE7I (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 6 Nov 2019 23:59:08 -0500
Received: from unknown (HELO iyokan-ex.css.socionext.com) ([172.31.9.54])
  by mx.socionext.com with ESMTP; 07 Nov 2019 13:59:06 +0900
Received: from mail.mfilter.local (m-filter-2 [10.213.24.62])
        by iyokan-ex.css.socionext.com (Postfix) with ESMTP id B9291605F8;
        Thu,  7 Nov 2019 13:59:06 +0900 (JST)
Received: from 172.31.9.51 (172.31.9.51) by m-FILTER with ESMTP; Thu, 7 Nov 2019 13:59:16 +0900
Received: from plum.e01.socionext.com (unknown [10.213.132.32])
        by kinkan.css.socionext.com (Postfix) with ESMTP id 7DCE31A0E9F;
        Thu,  7 Nov 2019 13:59:06 +0900 (JST)
From:   Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Andrew Murray <andrew.murray@arm.com>,
        Bjorn Helgaas <bhelgaas@google.com>
Cc:     linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Masami Hiramatsu <masami.hiramatsu@linaro.org>,
        Jassi Brar <jaswinder.singh@linaro.org>,
        Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Subject: [PATCH 2/2] PCI: uniphier: Add checking whether PERST# is deasserted
Date:   Thu,  7 Nov 2019 13:58:15 +0900
Message-Id: <1573102695-7018-2-git-send-email-hayashi.kunihiko@socionext.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1573102695-7018-1-git-send-email-hayashi.kunihiko@socionext.com>
References: <1573102695-7018-1-git-send-email-hayashi.kunihiko@socionext.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

When PERST# is asserted once, EP configuration will be initialized.
If PERST# has been already deasserted, it isn't necessary to assert
here.

This checks whether PERST# is deasserted using PCL_PINMON register,
and adds omit controlling PERST#.

Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
---
 drivers/pci/controller/dwc/pcie-uniphier.c | 8 ++++++++
 1 file changed, 8 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-uniphier.c b/drivers/pci/controller/dwc/pcie-uniphier.c
index 8fd7bad..1ea4220 100644
--- a/drivers/pci/controller/dwc/pcie-uniphier.c
+++ b/drivers/pci/controller/dwc/pcie-uniphier.c
@@ -22,6 +22,9 @@
 
 #include "pcie-designware.h"
 
+#define PCL_PINMON			0x0028
+#define PCL_PINMON_PERST_OUT		BIT(16)
+
 #define PCL_PINCTRL0			0x002c
 #define PCL_PERST_PLDN_REGEN		BIT(12)
 #define PCL_PERST_NOE_REGEN		BIT(11)
@@ -100,6 +103,11 @@ static void uniphier_pcie_init_rc(struct uniphier_pcie_priv *priv)
 	val |= PCL_SYS_AUX_PWR_DET;
 	writel(val, priv->base + PCL_APP_PM0);
 
+	/* return if PERST# is already deasserted */
+	val = readl(priv->base + PCL_PINMON);
+	if (val & PCL_PINMON_PERST_OUT)
+		return;
+
 	/* assert PERST# */
 	val = readl(priv->base + PCL_PINCTRL0);
 	val &= ~(PCL_PERST_NOE_REGVAL | PCL_PERST_OUT_REGVAL
-- 
2.7.4

