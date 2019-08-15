Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id A2D008E74B
	for <lists+linux-pci@lfdr.de>; Thu, 15 Aug 2019 10:48:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731146AbfHOIsB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 15 Aug 2019 04:48:01 -0400
Received: from inva021.nxp.com ([92.121.34.21]:60798 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731135AbfHOIsA (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 15 Aug 2019 04:48:00 -0400
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id EE357200440;
        Thu, 15 Aug 2019 10:47:57 +0200 (CEST)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4599B2001CD;
        Thu, 15 Aug 2019 10:47:49 +0200 (CEST)
Received: from titan.ap.freescale.net (TITAN.ap.freescale.net [10.192.208.233])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4795640320;
        Thu, 15 Aug 2019 16:47:38 +0800 (SGT)
From:   Xiaowei Bao <xiaowei.bao@nxp.com>
To:     jingoohan1@gmail.com, gustavo.pimentel@synopsys.com,
        bhelgaas@google.com, robh+dt@kernel.org, mark.rutland@arm.com,
        shawnguo@kernel.org, leoyang.li@nxp.com, kishon@ti.com,
        lorenzo.pieralisi@arm.com, arnd@arndb.de,
        gregkh@linuxfoundation.org, minghuan.Lian@nxp.com,
        mingkai.hu@nxp.com, roy.zang@nxp.com, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org
Cc:     Xiaowei Bao <xiaowei.bao@nxp.com>
Subject: [PATCH 09/10] arm64: dts: layerscape: Add PCIe EP node for ls1088a
Date:   Thu, 15 Aug 2019 16:37:15 +0800
Message-Id: <20190815083716.4715-9-xiaowei.bao@nxp.com>
X-Mailer: git-send-email 2.9.5
In-Reply-To: <20190815083716.4715-1-xiaowei.bao@nxp.com>
References: <20190815083716.4715-1-xiaowei.bao@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP node for ls1088a to support EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
---
 arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi | 32 ++++++++++++++++++++++++++
 1 file changed, 32 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
index dfbead4..434a76c 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1088a.dtsi
@@ -471,6 +471,18 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3400000 {
+			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+			       0x20 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <24>;
+			num-ob-windows = <128>;
+			max-functions = /bits/ 8 <2>;
+			pf-offset = <0x20000>;
+			status = "disabled";
+		};
+
 		pcie@3500000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000   /* controller registers */
@@ -497,6 +509,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3500000 {
+			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+			       0x28 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			status = "disabled";
+		};
+
 		pcie@3600000 {
 			compatible = "fsl,ls1088a-pcie";
 			reg = <0x00 0x03600000 0x0 0x00100000   /* controller registers */
@@ -523,6 +545,16 @@
 			status = "disabled";
 		};
 
+		pcie_ep@3600000 {
+			compatible = "fsl,ls1088a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03600000 0x0 0x00100000
+			       0x30 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			status = "disabled";
+		};
+
 		smmu: iommu@5000000 {
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
-- 
2.9.5

