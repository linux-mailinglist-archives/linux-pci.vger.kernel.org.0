Return-Path: <linux-pci+bounces-41367-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 96B06C630ED
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 10:10:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 019E33B36D6
	for <lists+linux-pci@lfdr.de>; Mon, 17 Nov 2025 09:09:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 01D6D32695F;
	Mon, 17 Nov 2025 09:09:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="aimvKOnH"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wr1-f53.google.com (mail-wr1-f53.google.com [209.85.221.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AA006324B28
	for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 09:09:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.221.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1763370568; cv=none; b=RfFSzqbDPPfcoxY0SEH/KEyWNhpU6fUbLEEmA1kYFrMdb0HgEOns+sVCc+Rq16Ik0yuPUU0Nc2qm1pnFBoKJ2mQAEK/5bIsNDb7Vfja1kYsq+DWQ8UGW2N2ZIXgE+xi6rLcx74EfwdhxMUUVbT5aoiX+qUzRiDVy4Tiqg+qs25M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1763370568; c=relaxed/simple;
	bh=XoKkDf2LeS+dB4j+jGaPplzFpifoPzmlVbny/U4/wvI=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=K+v+l7HOccaMnj/oWv4jxovektQWO1nTRhGpFYv3WRxJU0nm2CUbmILctTZ9I0AFzymuIkXpZGTpnMJsMKumI8M4eyg/dRdBwuU/GB8tx73+9s5Btbarcbsl4RN4wxV84KFoNL1wFZGdJ2zQblbswC4r6zPuhBX+KX/6VS3HBSg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=aimvKOnH; arc=none smtp.client-ip=209.85.221.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wr1-f53.google.com with SMTP id ffacd0b85a97d-42b3d4d9ca6so3262064f8f.2
        for <linux-pci@vger.kernel.org>; Mon, 17 Nov 2025 01:09:26 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1763370565; x=1763975365; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=rMVcpUDh0PhxaZRkGzlWBnvYH60oHujPQ2IrbrYEtG0=;
        b=aimvKOnHaV2AgsITGCwCnvsZC6ygtARdkpZ24lOfA0Ld3o2ePdJuMP6X1LE0YgfZ5a
         Yb/RBbm0efm5dv34t571VkCb5OWZndmG2os3fOixpAKPVpzi+2PYXzDZKVdFHUu7a0lv
         ARwPDQzcK4Ehb4M8oNWPb+HGcggCRiZY+GwK/2RmLImPo57aPwLde9nObAUqFrEnnTKR
         5McTM6BgOVynMlv6rrdXjM6ATIKx2UnW0EOiS51b7iiNaG8Qi58Fm28+dhvWvMmbM35n
         Qdsr79X9RImDxPWVH/3knsY3qwNVFDB+U5cpAa05MxteF2FZVPE8lJx+vE0aLy4gCwRM
         zC1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1763370565; x=1763975365;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=rMVcpUDh0PhxaZRkGzlWBnvYH60oHujPQ2IrbrYEtG0=;
        b=DkuHZE+4VfgTmT2FlrRSX1QMS56RP55CCYnfYWOX08shqpZ/9aBIwumDVoGU6MBoZO
         nAKPTTxQu+tdwE6e+8vzytUv0aQsCIIDUg8WENa1ZnazgwarpJpYR3nWw7iZpM9PLH5w
         ct+LHw/el4gCjhE+2h1qLomiEPU3o3L6Zi9PhnFMAO9b3vWCsjivGbb54TIH6mj90eAU
         mZX7Hc4xlBtjtov87QU+zv3sEHEf0V+j8lKfruCr/Kf2wvJgEwSeJTBrC9zxBlqrAIsL
         wTZU/ZI5AfJTXy7HkFCO9falhciOCx+dvorB0w85exPSDQIBGCNbkAwwekB7hja3SPDo
         EPlg==
X-Forwarded-Encrypted: i=1; AJvYcCU2R79EhQxEIGIFIDC8FYLGn7tdvX4tkc/wNpZ7rtYstQHQK2NBciqHrwtkEyuRjF9zJwEYpdczMjE=@vger.kernel.org
X-Gm-Message-State: AOJu0YzssRIfk4MKJkwu/HanotRwBEpidYu9aNkJx3PakhX7v1D+qk1m
	LG9cXtuogUpgNprRN2mQ7hAX7V4B9gH3eto3VHMS9OEo7n0SBTjwaB72g9pOIUeyUho=
X-Gm-Gg: ASbGncstDsCWYGx7ov1Tg7wDmqrv8bMdudFButCGeNcsA2wrEYND9bJTo9DeE0SAnKM
	waKOtnw7ml0IyremEJQU8u2XR8AirsahssxqH0smZj9GeQVs+BMACns8aL+KR1tsScDWB8RvKen
	/ygrpDoviGI484Vq4y122b5sAHYWHbMEfSXoluTAzqOQqSdq5H1dRl/Uk5KnnSSIwpf5lBjzjfj
	3fwx0nmUVnDE+D9jBWBgsNWmT5xdkvx6PTPSISsSUeX8c3JxNsroJreDFAIQK5/ib5SwNz4eOmk
	AzG8AinSk9l9swzrT342jEdJcDk1XzkbHJNv9cRaCxWOXqe9Kc5p2JL361JAInpRQdPHUDTT4ly
	uE8gHxSNUW0ym/DmmaYYzTHVAOqkTPc8NfPYH+M+P968TGm65dwcJsDJDKmCslZ/iDxYUitMHgv
	0enda3VQdIYQ/G4/Mwemkgo6ovxJ0Us+9/+RSL3XVY
X-Google-Smtp-Source: AGHT+IFjNXqtbR49Ko3nHx3axdjWSuiRGsXO2BS0M/3+TZmVz7TQ+//hNjyXLqmDw8zxSWxO4qPtTg==
X-Received: by 2002:a05:6000:208a:b0:425:825d:15d1 with SMTP id ffacd0b85a97d-42b59384374mr10594346f8f.44.1763370564883;
        Mon, 17 Nov 2025 01:09:24 -0800 (PST)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.134])
        by smtp.gmail.com with ESMTPSA id ffacd0b85a97d-42b53f0b894sm25703786f8f.26.2025.11.17.01.09.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Nov 2025 01:09:24 -0800 (PST)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v7 1/6] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add Renesas RZ/G3S
Date: Mon, 17 Nov 2025 11:08:53 +0200
Message-ID: <20251117090859.3840888-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251117090859.3840888-1-claudiu.beznea.uj@bp.renesas.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

From: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>

The PCIe IP available on the Renesas RZ/G3S complies with the PCI Express
Base Specification 4.0. It is designed for root complex applications and
features a single-lane (x1) implementation. Add documentation for it.

Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

Changes in v7:
- collected tags

Changes in v6:
- updated the patch title
- described the functionalites that system controller has for PCIe 
- dropped /schemas/pci/pci-device.yaml# from allOf section
- dropped max-link-speed from example
- dropped pcie_port0 label from example

Changes in v5:
- dropped Tb tag
- style updates to the dma-ranges and ranges properties from
  examples section
- re-enabled the node from examples section

Changes in v4:
- dropped "s33" string from compatible name
- added port node documentation; due to this dropped Rob's Rb tag
- reorderded properties
- dropped spaces b/w "INT" and "A", "B", "C", "D" in comments

Changes in v3:
- collected tags
- updated the flags of ranges property from example

Changes in v2:
- update the interrupt names by dropping "int" and "rc" string; due
  to this the patch description was adjusted
- added "interrupt-controller" and made it mandatory
- s/clkl1pm/pm/g
- dropped the legacy-interrupt-controller node; with this the gic
  interrupt controller node was dropped as well as it is not needed
  anymore
- updated interrupt-map in example and added interrupt-controller
- added clock-names as required property as the pm clock is not
  handled though PM domains; this will allow the driver to have
  the option to request the pm clock by its name when implementation
  will be adjusted to used the pm clock
- adjusted the size of dma-ranges to reflect the usage on
  SMARC module board
- moved "renesas,sysc" at the end of the node in example to align
  with dts coding style

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 249 ++++++++++++++++++
 1 file changed, 249 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
new file mode 100644
index 000000000000..d668782546a2
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -0,0 +1,249 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/renesas,r9a08g045-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Renesas RZ/G3S PCIe host controller
+
+maintainers:
+  - Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
+
+description:
+  Renesas RZ/G3S PCIe host controller complies with PCIe Base Specification
+  4.0 and supports up to 5 GT/s (Gen2).
+
+properties:
+  compatible:
+    const: renesas,r9a08g045-pcie # RZ/G3S
+
+  reg:
+    maxItems: 1
+
+  interrupts:
+    items:
+      - description: System error interrupt
+      - description: System error on correctable error interrupt
+      - description: System error on non-fatal error interrupt
+      - description: System error on fatal error interrupt
+      - description: AXI error interrupt
+      - description: INTA interrupt
+      - description: INTB interrupt
+      - description: INTC interrupt
+      - description: INTD interrupt
+      - description: MSI interrupt
+      - description: Link bandwidth interrupt
+      - description: PME interrupt
+      - description: DMA interrupt
+      - description: PCIe event interrupt
+      - description: Message interrupt
+      - description: All interrupts
+
+  interrupt-names:
+    items:
+      - description: serr
+      - description: ser_cor
+      - description: serr_nonfatal
+      - description: serr_fatal
+      - description: axi_err
+      - description: inta
+      - description: intb
+      - description: intc
+      - description: intd
+      - description: msi
+      - description: link_bandwidth
+      - description: pm_pme
+      - description: dma
+      - description: pcie_evt
+      - description: msg
+      - description: all
+
+  interrupt-controller: true
+
+  clocks:
+    items:
+      - description: System clock
+      - description: PM control clock
+
+  clock-names:
+    items:
+      - description: aclk
+      - description: pm
+
+  resets:
+    items:
+      - description: AXI2PCIe Bridge reset
+      - description: Data link layer/transaction layer reset
+      - description: Transaction layer (ACLK domain) reset
+      - description: Transaction layer (PCLK domain) reset
+      - description: Physical layer reset
+      - description: Configuration register reset
+      - description: Configuration register reset
+
+  reset-names:
+    items:
+      - description: aresetn
+      - description: rst_b
+      - description: rst_gp_b
+      - description: rst_ps_b
+      - description: rst_rsm_b
+      - description: rst_cfg_b
+      - description: rst_load_b
+
+  power-domains:
+    maxItems: 1
+
+  dma-ranges:
+    description:
+      A single range for the inbound memory region.
+    maxItems: 1
+
+  renesas,sysc:
+    description: |
+      System controller registers control and monitor various PCIe
+      functionalities.
+
+      Control:
+      - transition to L1 state
+      - receiver termination settings
+      - RST_RSM_B signal
+
+      Monitor:
+      - clkl1pm clock request state
+      - power off information in L2 state
+      - errors (fatal, non-fatal, correctable)
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+patternProperties:
+  "^pcie@0,[0-0]$":
+    type: object
+    allOf:
+      - $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      vendor-id:
+        const: 0x1912
+
+      device-id:
+        const: 0x0033
+
+      clocks:
+        items:
+          - description: Reference clock
+
+      clock-names:
+        items:
+          - const: ref
+
+    required:
+      - device_type
+      - vendor-id
+      - device-id
+      - clocks
+      - clock-names
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+  - interrupt-map
+  - interrupt-map-mask
+  - interrupt-controller
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+  - renesas,sysc
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/r9a08g045-cpg.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@11e40000 {
+            compatible = "renesas,r9a08g045-pcie";
+            reg = <0 0x11e40000 0 0x10000>;
+            ranges = <0x02000000 0 0x30000000 0 0x30000000 0 0x08000000>;
+            /* Map all possible DRAM ranges (4 GB). */
+            dma-ranges = <0x42000000 0 0x40000000 0 0x40000000 1 0x00000000>;
+            bus-range = <0x0 0xff>;
+            interrupts = <GIC_SPI 395 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 396 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 397 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 398 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 399 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 404 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 405 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 406 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 407 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 408 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 409 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 410 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "serr", "serr_cor", "serr_nonfatal",
+                              "serr_fatal", "axi_err", "inta",
+                              "intb", "intc", "intd", "msi",
+                              "link_bandwidth", "pm_pme", "dma",
+                              "pcie_evt", "msg", "all";
+            #interrupt-cells = <1>;
+            interrupt-controller;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INTA */
+                            <0 0 0 2 &pcie 0 0 0 1>, /* INTB */
+                            <0 0 0 3 &pcie 0 0 0 2>, /* INTC */
+                            <0 0 0 4 &pcie 0 0 0 3>; /* INTD */
+            clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
+                     <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
+            clock-names = "aclk", "pm";
+            resets = <&cpg R9A08G045_PCI_ARESETN>,
+                     <&cpg R9A08G045_PCI_RST_B>,
+                     <&cpg R9A08G045_PCI_RST_GP_B>,
+                     <&cpg R9A08G045_PCI_RST_PS_B>,
+                     <&cpg R9A08G045_PCI_RST_RSM_B>,
+                     <&cpg R9A08G045_PCI_RST_CFG_B>,
+                     <&cpg R9A08G045_PCI_RST_LOAD_B>;
+            reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
+                          "rst_rsm_b", "rst_cfg_b", "rst_load_b";
+            power-domains = <&cpg>;
+            device_type = "pci";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            renesas,sysc = <&sysc>;
+
+            pcie@0,0 {
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                ranges;
+                clocks = <&versa3 5>;
+                clock-names = "ref";
+                device_type = "pci";
+                vendor-id = <0x1912>;
+                device-id = <0x0033>;
+                #address-cells = <3>;
+                #size-cells = <2>;
+            };
+        };
+    };
+
+...
-- 
2.43.0


