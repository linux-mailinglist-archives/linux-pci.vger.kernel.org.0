Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6A31C244E12
	for <lists+linux-pci@lfdr.de>; Fri, 14 Aug 2020 19:34:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728566AbgHNRdz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 14 Aug 2020 13:33:55 -0400
Received: from relmlor1.renesas.com ([210.160.252.171]:51303 "EHLO
        relmlie5.idc.renesas.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726270AbgHNRdy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 14 Aug 2020 13:33:54 -0400
X-IronPort-AV: E=Sophos;i="5.76,313,1592838000"; 
   d="scan'208";a="54596904"
Received: from unknown (HELO relmlir5.idc.renesas.com) ([10.200.68.151])
  by relmlie5.idc.renesas.com with ESMTP; 15 Aug 2020 02:33:53 +0900
Received: from localhost.localdomain (unknown [10.226.36.204])
        by relmlir5.idc.renesas.com (Postfix) with ESMTP id 5DE2D40061B7;
        Sat, 15 Aug 2020 02:33:50 +0900 (JST)
From:   Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
To:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Prabhakar <prabhakar.csengg@gmail.com>,
        Biju Das <biju.das.jz@bp.renesas.com>
Subject: [PATCH 4/5] arm64: dts: renesas: r8a774b1: Add PCIe EP nodes
Date:   Fri, 14 Aug 2020 18:30:36 +0100
Message-Id: <20200814173037.17822-5-prabhakar.mahadev-lad.rj@bp.renesas.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
References: <20200814173037.17822-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add PCIe EP nodes to R8A774B1 (RZ/G2N) SoC dtsi.

Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Reviewed-by: Biju Das <biju.das.jz@bp.renesas.com>
---
 arch/arm64/boot/dts/renesas/r8a774b1.dtsi | 38 +++++++++++++++++++++++
 1 file changed, 38 insertions(+)

diff --git a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
index 1e51855c7cd3..e45ac177eb58 100644
--- a/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
+++ b/arch/arm64/boot/dts/renesas/r8a774b1.dtsi
@@ -2238,6 +2238,44 @@
 			status = "disabled";
 		};
 
+		pciec0_ep: pcie_ep@fe000000 {
+			compatible = "renesas,r8a774b1-pcie-ep",
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
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
+		pciec1_ep: pcie_ep@ee800000 {
+			compatible = "renesas,r8a774b1-pcie-ep",
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
+			power-domains = <&sysc R8A774B1_PD_ALWAYS_ON>;
+			status = "disabled";
+		};
+
 		fdp1@fe940000 {
 			compatible = "renesas,fdp1";
 			reg = <0 0xfe940000 0 0x2400>;
-- 
2.17.1

