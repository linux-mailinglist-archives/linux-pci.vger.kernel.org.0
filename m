Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 45088B334D
	for <lists+linux-pci@lfdr.de>; Mon, 16 Sep 2019 04:28:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729460AbfIPC21 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 15 Sep 2019 22:28:27 -0400
Received: from inva021.nxp.com ([92.121.34.21]:48990 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727857AbfIPC21 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 15 Sep 2019 22:28:27 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4124A200512;
        Mon, 16 Sep 2019 04:28:25 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 2D4AD200513;
        Mon, 16 Sep 2019 04:28:18 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id B1612402CA;
        Mon, 16 Sep 2019 10:28:09 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of the layerscape
Date:   Mon, 16 Sep 2019 10:17:38 +0800
Message-Id: <20190916021742.22844-3-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190916021742.22844-1-xiaowei.bao@nxp.com>
References: <20190916021742.22844-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the documentation for the Device Tree binding of the layerscape
PCIe GEN4 controller with EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
 .../bindings/pci/layerscape-pcie-gen4.txt          | 28 +++++++++++++++++++++-
 1 file changed, 27 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
index b40fb5d..414a86c 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
@@ -3,6 +3,8 @@ NXP Layerscape PCIe Gen4 controller
 This PCIe controller is based on the Mobiveil PCIe IP and thus inherits all
 the common properties defined in mobiveil-pcie.txt.
 
+HOST MODE
+=========
 Required properties:
 - compatible: should contain the platform identifier such as:
   "fsl,lx2160a-pcie"
@@ -23,7 +25,20 @@ Required properties:
 - msi-parent : See the generic MSI binding described in
   Documentation/devicetree/bindings/interrupt-controller/msi.txt.
 
-Example:
+DEVICE MODE
+=========
+Required properties:
+- compatible: should contain the platform identifier such as:
+  "fsl,lx2160a-pcie-ep"
+- reg: base addresses and lengths of the PCIe controller register blocks.
+  "regs": PCIe controller registers.
+  "addr_space" EP device CPU address.
+- apio-wins: number of requested apio outbound windows.
+
+Optional Property:
+- max-functions: Maximum number of functions that can be configured (default 1).
+
+RC Example:
 
 	pcie@3400000 {
 		compatible = "fsl,lx2160a-pcie";
@@ -50,3 +65,14 @@ Example:
 				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
 				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 	};
+
+EP Example:
+
+	pcie_ep@3400000 {
+		compatible = "fsl,lx2160a-pcie-ep";
+		reg = <0x00 0x03400000 0x0 0x00100000
+		       0x80 0x00000000 0x8 0x00000000>;
+		reg-names = "regs", "addr_space";
+		apio-wins = <8>;
+		status = "disabled";
+	};
-- 
2.9.5

