Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D04D716E
	for <lists+linux-pci@lfdr.de>; Tue, 15 Oct 2019 10:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbfJOIsQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 15 Oct 2019 04:48:16 -0400
Received: from inva020.nxp.com ([92.121.34.13]:59618 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729390AbfJOIsP (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 15 Oct 2019 04:48:15 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 10B311A0A1F;
        Tue, 15 Oct 2019 10:48:13 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 383401A07D5;
        Tue, 15 Oct 2019 10:48:06 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id EC4EF40314;
        Tue, 15 Oct 2019 16:47:56 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     Zhiqiang.Hou@nxp.com, bhelgaas@google.com, robh+dt@kernel.org,
        mark.rutland@arm.com, shawnguo@kernel.org, leoyang.li@nxp.com,
        kishon@ti.com, lorenzo.pieralisi@arm.com, Minghuan.Lian@nxp.com,
        andrew.murray@arm.com, mingkai.hu@nxp.com,
        linux-pci@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH v2 5/6] arm64: dts: lx2160a: Add PCIe EP node
Date:   Tue, 15 Oct 2019 16:37:01 +0800
Message-Id: <20191015083702.21792-6-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20191015083702.21792-1-xiaowei.bao@nxp.com>
References: <20191015083702.21792-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add the LX2160A PCIe EP node.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
v2: 
 - No change.

 arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi | 56 ++++++++++++++++++++++++++
 1 file changed, 56 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
index f60e5ac..18330df 100644
--- a/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-lx2160a.dtsi
@@ -1005,6 +1005,15 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3400000 {
+			compatible = "fsl,lx2160a-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+			       0x80 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			apio-wins = <8>;
+			status = "disabled";
+		};
+
 		pcie@3500000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
@@ -1032,6 +1041,15 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3500000 {
+			compatible = "fsl,lx2160a-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+			       0x88 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			apio-wins = <8>;
+			status = "disabled";
+		};
+
 		pcie@3600000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
@@ -1059,6 +1077,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3600000 {
+			compatible = "fsl,lx2160a-pcie-ep";
+			reg = <0x00 0x03600000 0x0 0x00100000
+			       0x90 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			apio-wins = <256>;
+			max-functions = /bits/ 8 <2>;
+			status = "disabled";
+		};
+
 		pcie@3700000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03700000 0x0 0x00100000   /* controller registers */
@@ -1086,6 +1114,15 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3700000 {
+			compatible = "fsl,lx2160a-pcie-ep";
+			reg = <0x00 0x03700000 0x0 0x00100000
+			       0x98 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			apio-wins = <8>;
+			status = "disabled";
+		};
+
 		pcie@3800000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03800000 0x0 0x00100000   /* controller registers */
@@ -1113,6 +1150,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3800000 {
+			compatible = "fsl,lx2160a-pcie-ep";
+			reg = <0x00 0x03800000 0x0 0x00100000
+			       0xa0 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			apio-wins = <256>;
+			max-functions = /bits/ 8 <2>;
+			status = "disabled";
+		};
+
 		pcie@3900000 {
 			compatible = "fsl,lx2160a-pcie";
 			reg = <0x00 0x03900000 0x0 0x00100000   /* controller registers */
@@ -1140,5 +1187,14 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3900000 {
+			compatible = "fsl,lx2160a-pcie-ep";
+			reg = <0x00 0x03900000 0x0 0x00100000
+			       0xa8 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			apio-wins = <8>;
+			status = "disabled";
+		};
+
 	};
 };
-- 
2.9.5

