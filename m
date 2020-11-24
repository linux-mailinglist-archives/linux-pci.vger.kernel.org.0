Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 625092C1DC5
	for <lists+linux-pci@lfdr.de>; Tue, 24 Nov 2020 06:55:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727193AbgKXFyJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 24 Nov 2020 00:54:09 -0500
Received: from relmlor2.renesas.com ([210.160.252.172]:59419 "EHLO
        relmlie6.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728510AbgKXFyJ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 24 Nov 2020 00:54:09 -0500
X-IronPort-AV: E=Sophos;i="5.78,365,1599490800"; 
   d="scan'208";a="63462372"
Received: from unknown (HELO relmlir6.idc.renesas.com) ([10.200.68.152])
  by relmlie6.idc.renesas.com with ESMTP; 24 Nov 2020 14:49:06 +0900
Received: from localhost.localdomain (unknown [10.166.15.86])
        by relmlir6.idc.renesas.com (Postfix) with ESMTP id A23574200F86;
        Tue, 24 Nov 2020 14:49:06 +0900 (JST)
From:   Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
To:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
Subject: [PATCH 2/2] arm64: dts: renesas: r8a77951: Add PCIe EP nodes
Date:   Tue, 24 Nov 2020 14:42:18 +0900
Message-Id: <20201124054218.3005-3-yuya.hamamachi.sx@renesas.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20201124054218.3005-1-yuya.hamamachi.sx@renesas.com>
References: <20201124054218.3005-1-yuya.hamamachi.sx@renesas.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP nodes for R8A77951 SoC dtsi.

Signed-off-by: Yuya Hamamachi <yuya.hamamachi.sx@renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a77951.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a77951.dtsi b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
index 644308dd886c..9d60bcf69e4f 100644
--- a/arch/arm64/boot/dts/renesas/r8a77951.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a77951.dtsi
@@ -2727,6 +2727,44 @@ pciec1: pcie@ee800000 {
 			status = "disabled";
 		};
 
+		pciec0_ep: pcie-ep@fe000000 {
+			compatible = "renesas,r8a7795-pcie-ep",
+				     "renesas,rcar-gen3-pcie-ep";
+			reg = <0x0 0xfe000000 0 0x80000>,
+			      <0x0 0xfe100000 0 0x100000>,
+			      <0x0 0xfe200000 0 0x200000>,
+			      <0x0 0x30000000 0 0x8000000>,
+			      <0x0 0x38000000 0 0x8000000>;
+			reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+			interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 319>;
+			clock-names = "pcie";
+			resets = <&cpg 319>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pciec1_ep: pcie-ep@ee800000 {
+			compatible = "renesas,r8a7795-pcie-ep",
+				     "renesas,rcar-gen3-pcie-ep";
+			reg = <0x0 0xee800000 0 0x80000>,
+			      <0x0 0xee900000 0 0x100000>,
+			      <0x0 0xeea00000 0 0x200000>,
+			      <0x0 0xc0000000 0 0x8000000>,
+			      <0x0 0xc8000000 0 0x8000000>;
+			reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+			interrupts = <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>,
+				     <GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>;
+			clocks = <&cpg CPG_MOD 318>;
+			clock-names = "pcie";
+			resets = <&cpg 318>;
+			power-domains = <&sysc R8A7795_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		imr-lx4@fe860000 {
 			compatible = "renesas,r8a7795-imr-lx4",
 				     "renesas,imr-lx4";
-- 
2.25.1

