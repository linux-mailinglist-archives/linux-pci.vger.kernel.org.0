Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2569C457A08
	for <lists+linux-pci@lfdr.de>; Sat, 20 Nov 2021 01:16:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236323AbhKTATg (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 19 Nov 2021 19:19:36 -0500
Received: from inva021.nxp.com ([92.121.34.21]:60032 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236447AbhKTATa (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 19 Nov 2021 19:19:30 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 4081E201807;
        Sat, 20 Nov 2021 01:16:27 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 04CD1200A97;
        Sat, 20 Nov 2021 01:16:27 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.142])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 2C73840A85;
        Fri, 19 Nov 2021 17:16:26 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Bjorn Helgaas <bhelgaas@google.com>,
        Rob Herring <robh+dt@kernel.org>, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Hou Zhiqiang <Zhiqiang.Hou@nxp.com>
Cc:     Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 4/4] dt-bindings: pci: layerscape-pci: define aer/pme interrupts
Date:   Fri, 19 Nov 2021 18:16:21 -0600
Message-Id: <20211120001621.21246-5-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20211120001621.21246-1-leoyang.li@nxp.com>
References: <20211120001621.21246-1-leoyang.li@nxp.com>
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
index 8fd6039a826b..bcf11bfc4bab 100644
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
   The second entry is the physical PCIe controller index starting from '0'.
@@ -52,8 +57,9 @@ Example:
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

