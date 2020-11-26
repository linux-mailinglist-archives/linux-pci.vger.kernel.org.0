Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 31DC92C56F3
	for <lists+linux-pci@lfdr.de>; Thu, 26 Nov 2020 15:21:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389684AbgKZOUn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 26 Nov 2020 09:20:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2389957AbgKZOUm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 26 Nov 2020 09:20:42 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D1C061A48
        for <linux-pci@vger.kernel.org>; Thu, 26 Nov 2020 06:20:42 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id x2Ld2300K4C55Sk062LdkG; Thu, 26 Nov 2020 15:20:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kiI8T-005s37-6m; Thu, 26 Nov 2020 15:20:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kiFvt-00H9xt-4v; Thu, 26 Nov 2020 12:59:29 +0100
From:   Geert Uytterhoeven <geert@linux-m68k.org>
To:     Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Rob Herring <robh+dt@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Marek Vasut <marek.vasut+renesas@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert@linux-m68k.org>
Subject: [PATCH/RFC] dt-bindings: pci: rcar-pci-ep: Document missing interrupts property
Date:   Thu, 26 Nov 2020 12:59:27 +0100
Message-Id: <20201126115927.4089838-1-geert@linux-m68k.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The R-Car PCIe controller does not use interrupts when configured
for endpoint mode, hence the bindings do not document the interrupt
property.  However, all DTS files provide interrupts properties, and
thus fail to validate.

Fix this by documenting the interrupts property.

Fixes: 5be478f9c24fbdf8 ("dt-bindings: Another round of adding missing 'additionalProperties'")
Fixes: 4c0f80920923f103 ("dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller")
Signed-off-by: Geert Uytterhoeven <geert@linux-m68k.org>
---
Alternatively, the interrupts properties should be removed from the
corresponding device nodes in the DTS files.  Obviously they should be
retained in the device nodes representing PCIe controllers configured in
host mode, which describe the same hardware...
---
 Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml | 9 +++++++++
 1 file changed, 9 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
index fb97f4ea0e63682b..32a3b7665ff5473c 100644
--- a/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
+++ b/Documentation/devicetree/bindings/pci/rcar-pci-ep.yaml
@@ -33,6 +33,10 @@ properties:
       - const: memory2
       - const: memory3
 
+  interrupts:
+    minItems: 3
+    maxItems: 3
+
   power-domains:
     maxItems: 1
 
@@ -54,6 +58,7 @@ required:
   - compatible
   - reg
   - reg-names
+  - interrupts
   - resets
   - power-domains
   - clocks
@@ -65,6 +70,7 @@ additionalProperties: false
 examples:
   - |
     #include <dt-bindings/clock/r8a774c0-cpg-mssr.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/power/r8a774c0-sysc.h>
 
      pcie0_ep: pcie-ep@fe000000 {
@@ -76,6 +82,9 @@ examples:
                   <0x30000000 0x8000000>,
                   <0x38000000 0x8000000>;
             reg-names = "apb-base", "memory0", "memory1", "memory2", "memory3";
+            interrupts = <GIC_SPI 116 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 117 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 118 IRQ_TYPE_LEVEL_HIGH>;
             resets = <&cpg 319>;
             power-domains = <&sysc R8A774C0_PD_ALWAYS_ON>;
             clocks = <&cpg CPG_MOD 319>;
-- 
2.25.1

