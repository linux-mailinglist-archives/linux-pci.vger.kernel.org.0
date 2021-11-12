Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 39CE644EF53
	for <lists+linux-pci@lfdr.de>; Fri, 12 Nov 2021 23:35:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236015AbhKLWh6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Nov 2021 17:37:58 -0500
Received: from inva020.nxp.com ([92.121.34.13]:57214 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S235974AbhKLWhz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Nov 2021 17:37:55 -0500
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 64FD21A032A;
        Fri, 12 Nov 2021 23:35:03 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 27BCE1A207F;
        Fri, 12 Nov 2021 23:35:03 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 4E0D540BF1;
        Fri, 12 Nov 2021 15:35:02 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 02/11] dt-bindings: pci: layerscape-pci: define aer/pme interrupts
Date:   Fri, 12 Nov 2021 16:34:48 -0600
Message-Id: <20211112223457.10599-3-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211112223457.10599-1-leoyang.li@nxp.com>
References: <20211112223457.10599-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Some platforms using this controller have separated interrupt lines for
aer or pme events instead of having a single interrupt line for
miscellaneous events.  Define interrupts in the binding for these
interrupt lines.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 .../devicetree/bindings/pci/layerscape-pci.txt     | 14 ++++++++++----
 1 file changed, 10 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/layerscape-pci.txt b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
index 0d3d78aebe26..5697fe078072 100644
--- a/Documentation/devicetree/bindings/pci/layerscape-pci.txt
+++ b/Documentation/devicetree/bindings/pci/layerscape-pci.txt
@@ -31,8 +31,13 @@ Required properties:
 - reg: base addresses and lengths of the PCIe controller register blocks.
 - interrupts: A list of interrupt outputs of the controller. Must contain an
   entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-  "intr": The interrupt that is asserted for controller interrupts
+- interrupt-names: It could include the following entries:
+  "aer": For interrupt line reporting aer events when non MSI/MSI-X/INTx mode
+		is used
+  "pme": For interrupt line reporting pme events when non MSI/MSI-X/INTx mode
+		is used
+  "intr": For interrupt line reporting miscellaneous controller events
+  ......
 - fsl,pcie-scfg: Must include two entries.
   The first entry must be a link to the SCFG device node
   The second entry must be '0' or '1' based on physical PCIe controller index.
@@ -48,8 +53,9 @@ Example:
 		reg = <0x00 0x03400000 0x0 0x00010000   /* controller registers */
 		       0x40 0x00000000 0x0 0x00002000>; /* configuration space */
 		reg-names = "regs", "config";
-		interrupts = <GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* controller interrupt */
-		interrupt-names = "intr";
+		interrupts = <GIC_SPI 176 IRQ_TYPE_LEVEL_HIGH>, /* aer interrupt */
+			<GIC_SPI 177 IRQ_TYPE_LEVEL_HIGH>; /* pme interrupt */
+		interrupt-names = "aer", "pme";
 		fsl,pcie-scfg = <&scfg 0>;
 		#address-cells = <3>;
 		#size-cells = <2>;
-- 
2.25.1

