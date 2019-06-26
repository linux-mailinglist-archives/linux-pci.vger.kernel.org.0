Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2AA3156776
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2019 13:21:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726104AbfFZLU5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 26 Jun 2019 07:20:57 -0400
Received: from inva020.nxp.com ([92.121.34.13]:42470 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727177AbfFZLU4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 26 Jun 2019 07:20:56 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id B0E411A09F0;
        Wed, 26 Jun 2019 13:20:53 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 65E361A09DA;
        Wed, 26 Jun 2019 13:20:43 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id D91FF402FB;
        Wed, 26 Jun 2019 19:20:30 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, kstewart@linuxfoundation.org,
        pombredanne@nexb.com, shawn.lin@rock-chips.com,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCHv2 2/2] PCI: layerscape: EP and RC drivers are compiled separately
Date:   Wed, 26 Jun 2019 19:11:39 +0800
Message-Id: <20190626111139.32878-2-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.14.1
In-Reply-To: <20190626111139.32878-1-xiaowei.bao@nxp.com>
References: <20190626111139.32878-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Compile the EP and RC drivers separately with different configuration
options, this looks clearer.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2:
 - No change.

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

