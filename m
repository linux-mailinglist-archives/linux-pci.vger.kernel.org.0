Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id D5FB48ACED
	for <lists+linux-pci@lfdr.de>; Tue, 13 Aug 2019 05:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726789AbfHMDDR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 12 Aug 2019 23:03:17 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37186 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726483AbfHMDDR (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 12 Aug 2019 23:03:17 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BFCB91A0717;
        Tue, 13 Aug 2019 05:03:14 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 757D01A0022;
        Tue, 13 Aug 2019 05:03:06 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 28A63402BF;
        Tue, 13 Aug 2019 11:02:56 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        minghuan.Lian@nxp.com, mingkai.hu@nxp.com, roy.zang@nxp.com,
        l.stach@pengutronix.de, kishon@ti.com, tpiepho@impinj.com,
        leonard.crestez@nxp.com, andrew.smirnov@gmail.com,
        yue.wang@amlogic.com, hayashi.kunihiko@socionext.com,
        dwmw@amazon.co.uk, jonnyc@amazon.com, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-arm-kernel@lists.infradead.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCHv4 2/2] PCI: layerscape: Add CONFIG_PCI_LAYERSCAPE_EP to build EP/RC separately
Date:   Tue, 13 Aug 2019 10:53:17 +0800
Message-Id: <20190813025317.48290-2-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190813025317.48290-1-xiaowei.bao@nxp.com>
References: <20190813025317.48290-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add CONFIG_PCI_LAYERSCAPE_EP to build EP/RC separately.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - No change.
v3:
 - modify the commit message.
v4:
 - send the patch again with '--to'.

 drivers/pci/controller/dwc/Kconfig  |   20 ++++++++++++++++++--
 drivers/pci/controller/dwc/Makefile |    3 ++-
 2 files changed, 20 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index a6ce1ee..a41ccf5 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -131,13 +131,29 @@ config PCI_KEYSTONE_EP
 	  DesignWare core functions to implement the driver.
 
 config PCI_LAYERSCAPE
-	bool "Freescale Layerscape PCIe controller"
+	bool "Freescale Layerscape PCIe controller - Host mode"
 	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
 	depends on PCI_MSI_IRQ_DOMAIN
 	select MFD_SYSCON
 	select PCIE_DW_HOST
 	help
-	  Say Y here if you want PCIe controller support on Layerscape SoCs.
+	  Say Y here if you want to enable PCIe controller support on Layerscape
+	  SoCs to work in Host mode.
+	  This controller can work either as EP or RC. The RCW[HOST_AGT_PEX]
+	  determines which PCIe controller works in EP mode and which PCIe
+	  controller works in RC mode.
+
+config PCI_LAYERSCAPE_EP
+	bool "Freescale Layerscape PCIe controller - Endpoint mode"
+	depends on OF && (ARM || ARCH_LAYERSCAPE || COMPILE_TEST)
+	depends on PCI_ENDPOINT
+	select PCIE_DW_EP
+	help
+	  Say Y here if you want to enable PCIe controller support on Layerscape
+	  SoCs to work in Endpoint mode.
+	  This controller can work either as EP or RC. The RCW[HOST_AGT_PEX]
+	  determines which PCIe controller works in EP mode and which PCIe
+	  controller works in RC mode.
 
 config PCI_HISI
 	depends on OF && (ARM64 || COMPILE_TEST)
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index b085dfd..824fde7 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -8,7 +8,8 @@ obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
 obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
 obj-$(CONFIG_PCIE_SPEAR13XX) += pcie-spear13xx.o
 obj-$(CONFIG_PCI_KEYSTONE) += pci-keystone.o
-obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o pci-layerscape-ep.o
+obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
+obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
-- 
1.7.1

