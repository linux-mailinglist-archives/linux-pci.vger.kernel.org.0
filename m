Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9DA302D4167
	for <lists+linux-pci@lfdr.de>; Wed,  9 Dec 2020 12:53:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730982AbgLILvW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Dec 2020 06:51:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730894AbgLILvW (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Dec 2020 06:51:22 -0500
Received: from michel.telenet-ops.be (michel.telenet-ops.be [IPv6:2a02:1800:110:4::f00:18])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B4F3C0613CF
        for <linux-pci@vger.kernel.org>; Wed,  9 Dec 2020 03:50:41 -0800 (PST)
Received: from ramsan.of.borg ([84.195.186.194])
        by michel.telenet-ops.be with bizsmtp
        id 2Bqd2400R4C55Sk06BqdnB; Wed, 09 Dec 2020 12:50:38 +0100
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kmxzR-009AiG-EF; Wed, 09 Dec 2020 12:50:37 +0100
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1kmwSW-009G18-93; Wed, 09 Dec 2020 11:12:32 +0100
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Rob Herring <robh+dt@kernel.org>,
        Marek Vasut <marek.vasut+renesas@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
Cc:     linux-pci@vger.kernel.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH v2] dt-bindings: pci: rcar-pci-ep: Document missing interrupts property
Date:   Wed,  9 Dec 2020 11:12:31 +0100
Message-Id: <20201209101231.2206479-1-geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

The R-Car PCIe controller does not use interrupts when configured
for endpoint mode, hence the bindings do not document the interrupts
property.  However, all DTS files provide interrupts properties, and
thus fail to validate.

Fix this by documenting the interrupts property.

Fixes: 4c0f80920923f103 ("dt-bindings: PCI: rcar: Add bindings for R-Car PCIe endpoint controller")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
Reviewed-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
---
v2:
  - Fix authorship,
  - Add Reviewed-by,
  - Drop RFC state,
  - Fix name of interrupts property in patch description,
  - Drop inappropriate Fixes tag,
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

