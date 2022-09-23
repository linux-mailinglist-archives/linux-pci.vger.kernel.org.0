Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F65B5E7409
	for <lists+linux-pci@lfdr.de>; Fri, 23 Sep 2022 08:26:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229484AbiIWGZ7 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 23 Sep 2022 02:25:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230235AbiIWGZ6 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 23 Sep 2022 02:25:58 -0400
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7317BFFA64;
        Thu, 22 Sep 2022 23:25:57 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id D732C215AEF;
        Fri, 23 Sep 2022 08:25:55 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8C31C215AE6;
        Fri, 23 Sep 2022 08:25:55 +0200 (CEST)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 916C0180031F;
        Fri, 23 Sep 2022 14:25:53 +0800 (+08)
From:   Richard Zhu <hongxing.zhu@nxp.com>
To:     l.stach@pengutronix.de, bhelgaas@google.com, robh+dt@kernel.org,
        lorenzo.pieralisi@arm.com, shawnguo@kernel.org, kishon@ti.com,
        kw@linux.com, frank.li@nxp.com
Cc:     hongxing.zhu@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, kernel@pengutronix.de,
        linux-imx@nxp.com
Subject: [PATCH v3 04/14] PCI: dwc: Kconfig: Add iMX PCIe EP mode support
Date:   Fri, 23 Sep 2022 14:06:50 +0800
Message-Id: <1663913220-9523-5-git-send-email-hongxing.zhu@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
References: <1663913220-9523-1-git-send-email-hongxing.zhu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Since i.MX PCIe is one dual mode PCIe controller.
Add i.MX PCIe EP mode support, and split the PCIe modes to the Root
Complex mode and Endpoint mode.

Signed-off-by: Richard Zhu <hongxing.zhu@nxp.com>
---
 drivers/pci/controller/dwc/Kconfig | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 62ce3abf0f19..a24d8cacf1be 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -92,10 +92,33 @@ config PCI_EXYNOS
 	  functions to implement the driver.
 
 config PCI_IMX6
-	bool "Freescale i.MX6/7/8 PCIe controller"
+	bool
+
+config PCI_IMX6_HOST
+	bool "Freescale i.MX6/7/8 PCIe controller host mode"
 	depends on ARCH_MXC || COMPILE_TEST
 	depends on PCI_MSI_IRQ_DOMAIN
 	select PCIE_DW_HOST
+	select PCI_IMX6
+	help
+	  Enables support for the PCIe controller Root Complex mode in the
+	  iMX6/7/8 SoCs.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCIE_DW_HOST must be selected and in order
+	  to enable device-specific features PCIE_DW_EP must be selected.
+
+config PCI_IMX6_EP
+	bool "Freescale i.MX6/7/8 PCIe controller endpoint mode"
+	depends on ARCH_MXC || COMPILE_TEST
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	select PCI_IMX6
+	help
+	  Enables support for the PCIe controller endpoint mode in the
+	  iMX6/7/8 SoCs.
+	  This controller can work either as EP or RC. In order to enable
+	  host-specific features PCIE_DW_HOST must be selected and in order
+	  to enable device-specific features PCIE_DW_EP must be selected.
 
 config PCIE_SPEAR13XX
 	bool "STMicroelectronics SPEAr PCIe controller"
-- 
2.25.1

