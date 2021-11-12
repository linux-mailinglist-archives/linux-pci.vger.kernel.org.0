Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7713944EF54
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 23:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235995AbhKLWh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 17:37:56 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57258 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235975AbhKLWh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 17:37:56 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id C39341A2084;
        Fri, 12 Nov 2021 23:35:03 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 80D811A207F;
        Fri, 12 Nov 2021 23:35:03 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 9DA0940A77;
        Fri, 12 Nov 2021 15:35:02 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Xiaowei Bao <xiaowei.bao@nxp.com>, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 03/11] arm64: dts: ls1028a: Add PCIe EP nodes
Date:   Fri, 12 Nov 2021 16:34:49 -0600
Message-Id: <20211112223457.10599-4-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211112223457.10599-1-leoyang.li@nxp.com>
References: <20211112223457.10599-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Xiaowei Bao <xiaowei.bao@nxp.com>

Add PCIe EP nodes for ls1028a to support EP mode.

Signed-off-by: Xiaowei Bao <xiaowei.bao@nxp.com>
Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../arm64/boot/dts/freescale/fsl-ls1028a.dtsi | 24 +++++++++++++++++++
 1 file changed, 24 insertions(+)

diff --git a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
index 06b36cc65865..424dc9e5c4e4 100644
--- a/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
+++ b/arch/arm64/boot/dts/freescale/fsl-ls1028a.dtsi
@@ -642,6 +642,18 @@ pcie1: pcie@3400000 {
 			status = "disabled";
 		};
 
+		pcie_ep1: pcie_ep@3400000 {
+			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03400000 0x0 0x00100000
+			       0x80 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			status = "disabled";
+		};
+
 		pcie2: pcie@3500000 {
 			compatible = "fsl,ls1028a-pcie";
 			reg = <0x00 0x03500000 0x0 0x00100000>, /* controller registers */
@@ -669,6 +681,18 @@ pcie2: pcie@3500000 {
 			status = "disabled";
 		};
 
+		pcie_ep2: pcie_ep@3500000 {
+			compatible = "fsl,ls1028a-pcie-ep","fsl,ls-pcie-ep";
+			reg = <0x00 0x03500000 0x0 0x00100000
+			       0x88 0x00000000 0x8 0x00000000>;
+			reg-names = "regs", "addr_space";
+			interrupts = <GIC_SPI 113 IRQ_TYPE_LEVEL_HIGH>; /* PME interrupt */
+			interrupt-names = "pme";
+			num-ib-windows = <6>;
+			num-ob-windows = <8>;
+			status = "disabled";
+		};
+
 		smmu: iommu@5000000 {
 			compatible = "arm,mmu-500";
 			reg = <0 0x5000000 0 0x800000>;
-- 
2.25.1

