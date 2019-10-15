Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 73589D717E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 10:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbfJOIsL (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 04:48:11 -0400
Received: from inva021.nxp.com ([92.121.34.21]:38068 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbfJOIsK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 04:48:10 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id E280C200056;
        Tue, 15 Oct 2019 10:48:07 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 14D55200913;
        Tue, 15 Oct 2019 10:48:01 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 7354A402CA;
        Tue, 15 Oct 2019 16:47:52 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v2 2/6] dt-bindings: Add DT binding for PCIE GEN4 EP of the layerscape
Date:   Tue, 15 Oct 2019 16:36:58 +0800
Message-Id: <20191015083702.21792-3-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191015083702.21792-1-xiaowei.bao@nxp.com>
References: <20191015083702.21792-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the documentation for the Device Tree binding of the layerscape
PCIe GEN4 controller with EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2: 
 - remove the status entry in EP Example.

 .../bindings/pci/layerscape-pcie-gen4.txt          | 27 +++++++++++++++++++++-
 1 file changed, 26 insertions(+), 1 deletion(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt b/Documentation/devicetree/bindings/pci/layerscape-pcie-gen4.txt
index b40fb5d..06f9309 100644
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
@@ -50,3 +65,13 @@ Example:
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
+	};
-- 
2.9.5

