Return-Path: <linux-pci+bounces-37667-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 0F214BC183E
	for <lists+linux-pci@lfdr.de>; Tue, 07 Oct 2025 15:37:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id B82EC19A314B
	for <lists+linux-pci@lfdr.de>; Tue,  7 Oct 2025 13:37:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B7BA32E041A;
	Tue,  7 Oct 2025 13:37:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RMz1b+fh"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f48.google.com (mail-wm1-f48.google.com [209.85.128.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 94F882E092E
	for <linux-pci@vger.kernel.org>; Tue,  7 Oct 2025 13:37:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.48
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1759844240; cv=none; b=nKx/0c4bljbc4jFMrumsG583vYCeqdmw01LIZKtEQ50JA109ASLUNotVvztK8/3qOJhs2lvY9mNO5hu/td3rWP4+S9qLheHjNb9TkL2GO1GJFJKvvGf2e4euMV7MAcJkWO72pOqlH8OCjuVQE1jXj9gE0YvuOajnEoXaUNrZW58=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1759844240; c=relaxed/simple;
	bh=mYf1sBuj5tpiBM5j8R9kjmiFpvxtUDf+9Nw/gxI48HQ=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=YonLyZ+RlFq/g1YEQ7qQvFmSBer3mP+VUIwOa8cg8r+f9Zs4zB9RUjogaitLj+CDCEQ6Sv103MveoZJyD69Q1OjT3l6Ze2O4eS2VcT2QUQunnnCi7zgEulRU4BI74FJUmDxR/osMlZ0ifN9ds/DZ54LvCHlOs9tVlfPLF3iLoC0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RMz1b+fh; arc=none smtp.client-ip=209.85.128.48
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f48.google.com with SMTP id 5b1f17b1804b1-45b4d89217aso37294545e9.2
        for <linux-pci@vger.kernel.org>; Tue, 07 Oct 2025 06:37:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1759844237; x=1760449037; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=eQLp04gFsJMZRCynh+s7cEZz15X09TZ9idlvFdtrO+Q=;
        b=RMz1b+fhuuakxiuEc/hT05atC1qhcf5b7x7ctfXA8fjJNdPlJT4arJCbETuHR/8kcj
         aqT9rBgY4zyUyJbhFsPuYgQNTVPa6abMV++3K4/mHDRbv4IflN57qvTLlbkO5Ks+bjvY
         KlDoN9GeGVbGI+rTTTqr+eJCbqQlrx6eSLZPBfiOHrXz5S5ja6TPHmjcVG7aGRw7PEFF
         YTvBUqo40GdPeGhu95u72wlHDpD4mrKRvHzOi27XhmnaKeO5AuqpO/TerEpGyd85YjMf
         MjIHXe6eUQ7B6y9s4oUZV2453pXPIxxvx8NiWzvMwkGD6eSFppWcezQXBP3HO6Y3aBGl
         kRMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1759844237; x=1760449037;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=eQLp04gFsJMZRCynh+s7cEZz15X09TZ9idlvFdtrO+Q=;
        b=m7aNBYz+9YCUU3VG8/cPuzmWDdXmmXI+FINHs/BYQk8Vz2Ag7dT0XYzDYqgFg8bPbM
         w9e6N8SoU1Rav1lcJRBq1gqC2Mj3C4qcdmzI8Mtq2Q76CvNNCQvI/1TigMcrx8+tH7FI
         dCF0aDfVjDWsmRYRRMdvSrl36emZLO38xajEHFmDVdtMOe9A5hs11ReQI6EAbXSjAo1S
         QmjNEEySgA5DbYojEpGIXBHXs7opx0X3jF6o5g5WDnqr2T9lEqeUOMn4e8vVECEUqaCA
         +WutGRnp/UR7ySGD31+HgN/OJ34ajOry0uie34HMEp2cUXGKz4jq9TafqeC+FEU/6qm4
         bUvQ==
X-Forwarded-Encrypted: i=1; AJvYcCXE4+r+MS3ZprLgpJ4l5eTmzTmqfrCeRm1C3jfdLV8rOx+0oGOvzjhKvTnre12WkaplsF6jn09FEYQ=@vger.kernel.org
X-Gm-Message-State: AOJu0YxthI9ggN5UH5N97PpXuPp5ZUWthIAyharMxSaZXAhNtQCd5iBT
	NFBhVB20lHgxGSd87LBBE8Yrz/yDSGle20k30IZPHt/JtRl1/goouSYo9bW4kr075w4=
X-Gm-Gg: ASbGncuf7HzVyDjl4rPf38Vq0c3kVmTr1tMuDlhD3XrmyOUYq7GKSjW4HQePE1aydbO
	x+MjTkKHUsQztjObdQcJQulIy6wsoglwu0s4v0rgNMocJLvzVecL9J4Ea7yBzOBWyph19PSb2QD
	VVHhdbO+mWdzAZlCioDp238rs1OiK3GbHXj8CqLCyE5eYNR1E2AXX5LecGDRsa/xl9esVnpP0gw
	kgswLI6vZHhO4CxxKZaCvbVk//MCco15USXWYEG1wp3llVlfBU3uehMA3puSIY+01kD86+FSQmZ
	7N/JLFywYcGgYVpksFvSsdt7wD62fPaQN2eTgmQer8D019NqIH7m+YxyXqkV48Qu6XXEKhJv6AV
	+EaJ28ft2Cd7/jvw3xAbA4T63u1yb+gqHPmZnm3/eOf0=
X-Google-Smtp-Source: AGHT+IHuPTLj5uLSPdpG1nZMC6jrYcURKjFpDBAde9s0YKBBPSAJjg/o0OpdbzC7j7XeAYsTHnmrvg==
X-Received: by 2002:a05:600c:1e1f:b0:45f:2805:91df with SMTP id 5b1f17b1804b1-46e714ca355mr101752075e9.20.1759844236658;
        Tue, 07 Oct 2025 06:37:16 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.59])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-46e674b6591sm272189625e9.4.2025.10.07.06.37.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Oct 2025 06:37:16 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com
To: lpieralisi@kernel.org,
	kwilczynski@kernel.org,
	mani@kernel.org,
	robh@kernel.org,
	bhelgaas@google.com,
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
Subject: [PATCH v5 1/6] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the PCIe IP on Renesas RZ/G3S
Date: Tue,  7 Oct 2025 16:36:52 +0300
Message-ID: <20251007133657.390523-2-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
References: <20251007133657.390523-1-claudiu.beznea.uj@bp.renesas.com>
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

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---

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

 .../bindings/pci/renesas,r9a08g045-pcie.yaml  | 239 ++++++++++++++++++
 1 file changed, 239 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
new file mode 100644
index 000000000000..d21d16b4e28d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045-pcie.yaml
@@ -0,0 +1,239 @@
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
+    description: System controller phandle
+    $ref: /schemas/types.yaml#/definitions/phandle
+
+patternProperties:
+  "^pcie@0,[0-0]$":
+    type: object
+    allOf:
+      - $ref: /schemas/pci/pci-device.yaml#
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
+            max-link-speed = <2>;
+            renesas,sysc = <&sysc>;
+
+            pcie_port0: pcie@0,0 {
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


