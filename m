Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DFB8F20D2F2
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jun 2020 21:11:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726842AbgF2SyD (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 Jun 2020 14:54:03 -0400
Received: from inva020.nxp.com ([92.121.34.13]:41020 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729812AbgF2SyD (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 29 Jun 2020 14:54:03 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AA4C91A12DD;
        Mon, 29 Jun 2020 17:17:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C14031A0239;
        Mon, 29 Jun 2020 17:17:14 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 9756E402E0;
        Mon, 29 Jun 2020 23:17:01 +0800 (SGT)
From:   Anson Huang <Anson.Huang@nxp.com>
To:     catalin.marinas@arm.com, will@kernel.org,
        lorenzo.pieralisi@arm.com, robh@kernel.org, bhelgaas@google.com,
        p.zabel@pengutronix.de, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        bjorn.andersson@linaro.org, leoyang.li@nxp.com, vkoul@kernel.org,
        geert+renesas@glider.be, olof@lixom.net, treding@nvidia.com,
        gustavo.pimentel@synopsys.com, amurray@thegoodpenguin.co.uk,
        vidyas@nvidia.com, xiaowei.bao@nxp.com, jonnyc@amazon.com,
        hayashi.kunihiko@socionext.com, eswara.kota@linux.intel.com,
        krzk@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org
Cc:     Linux-imx@nxp.com
Subject: [PATCH V2 1/3] reset: imx7: Support module build
Date:   Mon, 29 Jun 2020 23:05:27 +0800
Message-Id: <1593443129-18766-1-git-send-email-Anson.Huang@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add module device table, author, description and license to support
module build, and CONFIG_RESET_IMX7 is changed to default 'y' ONLY
for i.MX7D, other platforms need to select it in defconfig.

Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
---
Changes since V1:
	- make it default 'y' for SOC_IMX7D;
	- add module author, description;
	- use device_initcall instead of builtin_platform_driver() to support
	  module unload.
---
 drivers/reset/Kconfig      |  5 +++--
 drivers/reset/reset-imx7.c | 14 ++++++++++++--
 2 files changed, 15 insertions(+), 4 deletions(-)

diff --git a/drivers/reset/Kconfig b/drivers/reset/Kconfig
index d9efbfd..19f9773 100644
--- a/drivers/reset/Kconfig
+++ b/drivers/reset/Kconfig
@@ -65,9 +65,10 @@ config RESET_HSDK
 	  This enables the reset controller driver for HSDK board.
 
 config RESET_IMX7
-	bool "i.MX7/8 Reset Driver" if COMPILE_TEST
+	tristate "i.MX7/8 Reset Driver"
 	depends on HAS_IOMEM
-	default SOC_IMX7D || (ARM64 && ARCH_MXC)
+	depends on SOC_IMX7D || (ARM64 && ARCH_MXC) || COMPILE_TEST
+	default y if SOC_IMX7D
 	select MFD_SYSCON
 	help
 	  This enables the reset controller driver for i.MX7 SoCs.
diff --git a/drivers/reset/reset-imx7.c b/drivers/reset/reset-imx7.c
index d170fe6..c710f789 100644
--- a/drivers/reset/reset-imx7.c
+++ b/drivers/reset/reset-imx7.c
@@ -8,7 +8,7 @@
  */
 
 #include <linux/mfd/syscon.h>
-#include <linux/mod_devicetable.h>
+#include <linux/module.h>
 #include <linux/of_device.h>
 #include <linux/platform_device.h>
 #include <linux/reset-controller.h>
@@ -386,6 +386,7 @@ static const struct of_device_id imx7_reset_dt_ids[] = {
 	{ .compatible = "fsl,imx8mp-src", .data = &variant_imx8mp },
 	{ /* sentinel */ },
 };
+MODULE_DEVICE_TABLE(of, imx7_reset_dt_ids);
 
 static struct platform_driver imx7_reset_driver = {
 	.probe	= imx7_reset_probe,
@@ -394,4 +395,13 @@ static struct platform_driver imx7_reset_driver = {
 		.of_match_table	= imx7_reset_dt_ids,
 	},
 };
-builtin_platform_driver(imx7_reset_driver);
+
+static int __init imx7_reset_init(void)
+{
+	return platform_driver_register(&imx7_reset_driver);
+}
+device_initcall(imx7_reset_init);
+
+MODULE_AUTHOR("Andrey Smirnov <andrew.smirnov@gmail.com>");
+MODULE_DESCRIPTION("NXP i.MX7 reset driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

