Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6D5E6465B55
	for <lists+linux-pci@lfdr.de>; Thu,  2 Dec 2021 01:46:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354820AbhLBAuN (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 Dec 2021 19:50:13 -0500
Received: from inva021.nxp.com ([92.121.34.21]:59306 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1344704AbhLBAuM (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 Dec 2021 19:50:12 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 997F72000D6;
        Thu,  2 Dec 2021 01:46:46 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3B0DC2014D7;
        Thu,  2 Dec 2021 01:46:46 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 6AE3F40007;
        Wed,  1 Dec 2021 17:46:45 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 4/4] dt-bindings: pci: layerscape-pci: define AER/PME interrupts
Date:   Wed,  1 Dec 2021 18:46:36 -0600
Message-Id: <20211202004636.5276-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211202004636.5276-1-leoyang.li@nxp.com>
References: <20211202004636.5276-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Different platforms using this controller are using different numbers of
interrupt lines and the routing of events to these interrupt lines are
different too.  So instead of trying to define names for these interrupt
lines, we define the more specific AER/PME events that are routed to
these interrupt lines.

For platforms which only has a single interrupt line for miscellaneous
controller events, we can keep using the original "intr" name for
backward compatibility.

Also change the example from ls1021a to ls2088a for better representation.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../bindings/pci/layerscape-pci.txt           | 40 +++++++++++--------
 1 file changed, 24 insertions(+), 16 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 8fd6039a826b..238967e71d82 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -31,8 +31,14 @@ Required properties:
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
+- interrupt-names: It could include the following entries:
+  "aer": Used for interrupt line which reports AER events when
+	 non MSI/MSI-X/INTx mode is used
+  "pme": Used for interrupt line which reports PME events when
+	 non MSI/MSI-X/INTx mode is used
+  "intr": Used for SoCs(like ls2080a, lx2160a, ls2080a, ls2088a, ls1088a)
+	  which has a single interrupt line for miscellaneous controller
+	  events(could include AER and PME events).
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
   The second entry is the physical PCIe controller index starting from '0'.
@@ -48,26 +54,28 @@ Optional properties:
 Example:
 
 	pcie@3400000 {
-		compatible = "fsl,ls1021a-pcie";
-		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
-		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
+		compatible = "fsl,ls2088a-pcie";
+		reg = <0x00 0x03400000 0x0 0x00100000   /* controller registers */
+		       0x80 0x00000000 0x0 0x00002000>; /* configuration space */
 		reg-names = "regs", "config";
-		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "intr";
-		fsl,pcie-scfg = <&scfg 0>;
+		interrupts = <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* AER interrupt */
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>, /* PME interrupt */
+			     <GIC_SPI 108 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
+		interrupt-names = "aer", "pme", "intr";
 		#address-cells = <3>;
 		#size-cells = <2>;
 		device_type = "pci";
 		dma-coherent;
-		num-lanes = <4>;
+		num-viewport = <8>;
 		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
-			  0xc2000000 0x0 0x20000000 0x40 0x20000000 0x0 0x20000000   /* prefetchable memory */
-			  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+		ranges = <0x81000000 0x0 0x00000000 0x80 0x00010000 0x0 0x00010000
+			  0x82000000 0x0 0x40000000 0x80 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+		msi-parent = <&its>;
+		iommu-map = <0 &smmu 0 1>; /* This is fixed-up by u-boot */
 		#interrupt-cells = <1>;
 		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-map = <0000 0 0 1 &gic 0 0 GIC_SPI 109 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 2 &gic 0 0 GIC_SPI 110 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 3 &gic 0 0 GIC_SPI 111 IRQ_TYPE_LEVEL_HIGH>,
+				<0000 0 0 4 &gic 0 0 GIC_SPI 112 IRQ_TYPE_LEVEL_HIGH>;
 	};
-- 
2.25.1

