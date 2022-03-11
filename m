Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 488E34D6B26
	for <lists+linux-pci@lfdr.de>; Sat, 12 Mar 2022 00:56:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbiCKXu4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 11 Mar 2022 18:50:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229989AbiCKXuy (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 11 Mar 2022 18:50:54 -0500
Received: from inva020.nxp.com (inva020.nxp.com [92.121.34.13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C8BBC12622;
        Fri, 11 Mar 2022 15:49:48 -0800 (PST)
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 73FE41A0432;
        Sat, 12 Mar 2022 00:49:47 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 0FB2C1A00A6;
        Sat, 12 Mar 2022 00:49:47 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id D86E54028F;
        Fri, 11 Mar 2022 16:49:45 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>
Cc:     Hou Zhiqiang <Zhiqiang.Hou@nxp.com>, Rob Herring <robh@kernel.org>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v3 4/4] dt-bindings: pci: layerscape-pci: define AER/PME interrupts
Date:   Fri, 11 Mar 2022 17:49:38 -0600
Message-Id: <20220311234938.8706-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20220311234938.8706-1-leoyang.li@nxp.com>
References: <20220311234938.8706-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
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

Also change the example from ls1021a to ls1088a for better representation.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
Reviewed-by: Rob Herring <robh@kernel.org>
---
 .../bindings/pci/layerscape-pci.txt           | 58 ++++++++++---------
 1 file changed, 32 insertions(+), 26 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 8fd6039a826b..ee8a4791a78b 100644
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
@@ -47,27 +53,27 @@ Optional properties:
 
 Example:
 
-	pcie@3400000 {
-		compatible = "fsl,ls1021a-pcie";
-		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
-		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
-		reg-names = "regs", "config";
-		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "intr";
-		fsl,pcie-scfg = <&scfg 0>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-		device_type = "pci";
-		dma-coherent;
-		num-lanes = <4>;
-		bus-range = <0x0 0xff>;
-		ranges = <0x81000000 0x0 0x00000000 0x40 0x00010000 0x0 0x00010000   /* downstream I/O */
-			  0xc2000000 0x0 0x20000000 0x40 0x20000000 0x0 0x20000000   /* prefetchable memory */
-			  0x82000000 0x0 0x40000000 0x40 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 7>;
-		interrupt-map = <0000 0 0 1 &gic GIC_SPI 91  IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 2 &gic GIC_SPI 188 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 3 &gic GIC_SPI 190 IRQ_TYPE_LEVEL_HIGH>,
-				<0000 0 0 4 &gic GIC_SPI 192 IRQ_TYPE_LEVEL_HIGH>;
-	};
+        pcie@3400000 {
+                compatible = "fsl,ls1088a-pcie";
+                reg = <0x00 0x03400000 0x0 0x00100000>, /* controller registers */
+                      <0x20 0x00000000 0x0 0x00002000>; /* configuration space */
+                reg-names = "regs", "config";
+                interrupts = <0 108 IRQ_TYPE_LEVEL_HIGH>; /* aer interrupt */
+                interrupt-names = "aer";
+                #address-cells = <3>;
+                #size-cells = <2>;
+                device_type = "pci";
+                dma-coherent;
+                num-viewport = <256>;
+                bus-range = <0x0 0xff>;
+                ranges = <0x81000000 0x0 0x00000000 0x20 0x00010000 0x0 0x00010000   /* downstream I/O */
+                          0x82000000 0x0 0x40000000 0x20 0x40000000 0x0 0x40000000>; /* non-prefetchable memory */
+                msi-parent = <&its>;
+                #interrupt-cells = <1>;
+                interrupt-map-mask = <0 0 0 7>;
+                interrupt-map = <0000 0 0 1 &gic 0 0 0 109 IRQ_TYPE_LEVEL_HIGH>,
+                                <0000 0 0 2 &gic 0 0 0 110 IRQ_TYPE_LEVEL_HIGH>,
+                                <0000 0 0 3 &gic 0 0 0 111 IRQ_TYPE_LEVEL_HIGH>,
+                                <0000 0 0 4 &gic 0 0 0 112 IRQ_TYPE_LEVEL_HIGH>;
+                iommu-map = <0 &smmu 0 1>; /* Fixed-up by bootloader */
+        };
-- 
2.25.1

