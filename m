Return-Path: <linux-pci+bounces-27040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 82BCDAA48A0
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 12:37:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0CBEB188CC98
	for <lists+linux-pci@lfdr.de>; Wed, 30 Apr 2025 10:35:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0161725C830;
	Wed, 30 Apr 2025 10:33:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="OtbmleSb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EE4F8248F53
	for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 10:33:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1746009193; cv=none; b=UZC2WqeSxNJ0U4udt1VpIGjAMXn3SHHawmh7zOYJiO38DQdmdJt05xphwUNLj1lDxS6xDzEsbETVRd3oCdogsYyCP6it6hqeUdW3m3exz8Vj8CO6LUPohgZFopEBqjuKSE2IRWEd1NrRcfTFuCaE2VxY2vDfwIwuxuLczd4QOm8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1746009193; c=relaxed/simple;
	bh=Bb+Bq5mH+EatJ7/8Yyb5tdic+4z5Pi+Ord6hr6b9qh4=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=r+F3gyvH6SIbI8+UcTHRH9OH4zy+wyfiQhHUvMiMiDmBFGWi6HtG933t1j16aGvbOyqeQSw6BXKoji7/1Ex2Pkp8dVAOrB5NINy3af9E0qDnrfLfp4PtV5aaDqId7A+/FJb/xT3djG2D2Xy3lAhlgpVGPTt/IKa7X4FRZSPjAww=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=OtbmleSb; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-abec8b750ebso1150745366b.0
        for <linux-pci@vger.kernel.org>; Wed, 30 Apr 2025 03:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1746009188; x=1746613988; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YoWRRoUBCtB/ZPgUd2ZgkDkK1/5tN5cXWxvNrKDH+MY=;
        b=OtbmleSbMeI42ml0XZIjcX+zZ8Lfp182i6+4YOHWEaNNf0LPZmMVR4/ROupSAkB/L1
         dn6Ozv5ouqrnFODxkCKrfvZg2FJUrXdTImsuk0Pa7wjQ3Miq1eHRclYBlszUzJ/gBMrU
         XaiyZOjqyptQeDcUF6b+wb/m7JNHQ00ZfPM3sFbfaWNnqRECyP/r00uQAwNO1tiMB50v
         XXOc0Sf1MMaANjDWjODtubxaLL4whoBQlF8WjDlKOrZt5rHfEnSJMOHsolG6N04rF+tu
         4ijmHBL0Of3cuD/slC0Xyjd2G3fINV7GboJ8VrIa1bKEXIRgGetPKRKWXdcKJ0UQeQfU
         cBfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1746009188; x=1746613988;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YoWRRoUBCtB/ZPgUd2ZgkDkK1/5tN5cXWxvNrKDH+MY=;
        b=Nbh972AJJ25tBumQ1V3L/3ixzGlNC0lpOsgJ4QMB2Ss53IoVGHaX4o3rnAzS49SVoa
         1FiNj4NMGT2HmKHYa1aVbkQCnfHsmnSOEmSCCe1JIroQgbyCglEyfdqK0TYP0oRg2nt2
         goUJzvKNVf/WyCWoCSDbL5KZ8FOe9LCG6EiNlfq/GhfqQrhFbL/hc8jQHfs2zz7Kduav
         AdmqjMdOxQFzxJux/mBqspdTwmVwdMTcOIQJGGALXZCxnwlp8I3lb25+FgaLDYNf4WJy
         rFQaYKmC66gXX5GMZG27IuirA2gOUeaCxDlxz9wdwv0qg3AG/zTGg76LOmSC+t1sSeHj
         vW2A==
X-Forwarded-Encrypted: i=1; AJvYcCVsFtIQgpf+oXAOmF/8ku2/LPnedB+DZRRlGG4Dz1VvCJ0x263/mXNcRaOu61G2ykfHi/b+C/E7vLg=@vger.kernel.org
X-Gm-Message-State: AOJu0YzaMqppciGBtfyg6kLrBb4hcBU7J5mGp57GxqT/FOgJRsOytKrF
	d6LLMREHgRFstCO7HCkO/8nufouYcl4X74qP4Ug5eWA7Ni984cgfJpXidwyc6sA=
X-Gm-Gg: ASbGncvh28bTTmmQtd4f+6s2iw7y0O6DdN7jff/jgxVFu+7b5Puw1orbdnfPZt3RdMr
	g29/e1rkJu2zh0JXBLZT5htV7qtASnNOQBbPJptA5ukGQb6/eAWHVkTn01XO2ycsoez546ZQ90u
	tPBvjBhXWz/W+r5/cvUJqPeFrNN9y1gbFdY6zmB9CReXUquoyvbeY8XRqjtQbjGZVgkSPVYbYt8
	3xl/0eCEsmDcvLwVB/4zCUAjiqeBi40uQzxJUAifnBXsvMdh3t8KrUJVyLFx1l8CwZL8nyyBYDx
	P0yqLla+LOz/jawg480CaaIQ7uG0fqA3GiN9FZ6D8u0eEdFGBYDFCrwZhB6VDZ1YrZQXW1Q=
X-Google-Smtp-Source: AGHT+IE4zT0K660/YKUi/PMngnz83sua+XYwAUF10tYT8pEOxvZ7ocV0PPZvpQksStrBGl/Fb6vzjw==
X-Received: by 2002:a17:907:971c:b0:ac7:3918:50f6 with SMTP id a640c23a62f3a-acedc7b0eafmr258696366b.61.1746009188201;
        Wed, 30 Apr 2025 03:33:08 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.166])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-ace6ed6af86sm909390366b.133.2025.04.30.03.33.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 30 Apr 2025 03:33:07 -0700 (PDT)
From: Claudiu <claudiu.beznea@tuxon.dev>
X-Google-Original-From: Claudiu <claudiu.beznea.uj@bp.renesas.com>
To: bhelgaas@google.com,
	lpieralisi@kernel.org,
	kw@linux.com,
	manivannan.sadhasivam@linaro.org,
	robh@kernel.org,
	krzk+dt@kernel.org,
	conor+dt@kernel.org,
	geert+renesas@glider.be,
	magnus.damm@gmail.com,
	mturquette@baylibre.com,
	sboyd@kernel.org,
	saravanak@google.com,
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH 4/8] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the PCIe IP on Renesas RZ/G3S
Date: Wed, 30 Apr 2025 13:32:32 +0300
Message-ID: <20250430103236.3511989-5-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250430103236.3511989-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250430103236.3511989-1-claudiu.beznea.uj@bp.renesas.com>
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
The interrupts, interrupt-names, resets, reset-names, clocks, clock-names
description were obtained from the hardware manual.

Signed-off-by: Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
---
 .../pci/renesas,r9a08g045s33-pcie.yaml        | 242 ++++++++++++++++++
 1 file changed, 242 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
new file mode 100644
index 000000000000..354f9c3be139
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
@@ -0,0 +1,242 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/renesas,r9a08g045s33-pcie.yaml#
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
+    const: renesas,r9a08g045s33-pcie # RZ/G3S
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
+      - description: int_serr
+      - description: int_ser_cor
+      - description: int_serr_nonfatal
+      - description: int_serr_fatal
+      - description: axi_err_int
+      - description: inta_rc
+      - description: intb_rc
+      - description: intc_rc
+      - description: intd_rc
+      - description: intmsi_rc
+      - description: int_link_bandwidth
+      - description: int_pm_pme
+      - description: dma_int
+      - description: pcie_evt_int
+      - description: msg_int
+      - description: int_all
+
+  clocks:
+    items:
+      - description: System clock
+      - description: PM control clock
+
+  clock-names:
+    items:
+      - description: aclk
+      - description: clkl1pm
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
+  vendor-id:
+    const: 0x1912
+
+  device-id:
+    const: 0x0033
+
+  legacy-interrupt-controller:
+    description: Interrupt controller node for handling legacy PCI interrupts
+    type: object
+
+    properties:
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+      interrupt-controller: true
+
+      interrupts:
+        items:
+          - description: INTA interrupt
+          - description: INTB interrupt
+          - description: INTC interrupt
+          - description: INTD interrupt
+
+    required:
+      - "#address-cells"
+      - "#interrupt-cells"
+      - interrupt-controller
+      - interrupts
+
+    additionalProperties: false
+
+required:
+  - compatible
+  - reg
+  - clocks
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-names
+  - interrupt-map
+  - interrupt-map-mask
+  - power-domains
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+  - renesas,sysc
+  - vendor-id
+  - device-id
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
+        gic: interrupt-controller {
+            interrupt-controller;
+            #interrupt-cells = <3>;
+        };
+
+        pcie@11e40000 {
+            compatible = "renesas,r9a08g045s33-pcie";
+            reg = <0 0x11e40000 0 0x10000>;
+            ranges = <0x03000000 0 0x30000000 0 0x30000000 0 0x8000000>;
+            dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x8000000>;
+            bus-range = <0x0 0xff>;
+            clocks = <&cpg CPG_MOD R9A08G045_PCI_ACLK>,
+                     <&cpg CPG_MOD R9A08G045_PCI_CLKL1PM>;
+            clock-names = "aclk", "clkl1pm";
+            resets = <&cpg R9A08G045_PCI_ARESETN>,
+                     <&cpg R9A08G045_PCI_RST_B>,
+                     <&cpg R9A08G045_PCI_RST_GP_B>,
+                     <&cpg R9A08G045_PCI_RST_PS_B>,
+                     <&cpg R9A08G045_PCI_RST_RSM_B>,
+                     <&cpg R9A08G045_PCI_RST_CFG_B>,
+                     <&cpg R9A08G045_PCI_RST_LOAD_B>;
+            reset-names = "aresetn", "rst_b", "rst_gp_b", "rst_ps_b",
+                          "rst_rsm_b", "rst_cfg_b", "rst_load_b";
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
+            interrupt-names = "int_serr", "int_serr_cor", "int_serr_nonfatal",
+                              "int_serr_fatal", "axi_err_int", "inta_rc",
+                              "intb_rc", "intc_rc", "intd_rc",
+                              "intmsi_rc", "int_link_bandwidth", "int_pm_pme",
+                              "dma_int", "pcie_evt_int", "msg_int",
+                              "int_all";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 7>;
+            interrupt-map = <0 0 0 1 &pcie_intx 0>, /* INT A */
+                            <0 0 0 2 &pcie_intx 1>, /* INT B */
+                            <0 0 0 3 &pcie_intx 2>, /* INT C */
+                            <0 0 0 4 &pcie_intx 3>; /* INT D */
+            device_type = "pci";
+            num-lanes = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            power-domains = <&cpg>;
+            renesas,sysc = <&sysc>;
+            vendor-id = <0x1912>;
+            device-id = <0x0033>;
+
+            pcie_intx: legacy-interrupt-controller {
+                interrupt-controller;
+                #interrupt-cells = <1>;
+                #address-cells = <0>;
+                interrupt-parent = <&gic>;
+                interrupts = <GIC_SPI 400 IRQ_TYPE_LEVEL_HIGH>,
+                             <GIC_SPI 401 IRQ_TYPE_LEVEL_HIGH>,
+                             <GIC_SPI 402 IRQ_TYPE_LEVEL_HIGH>,
+                             <GIC_SPI 403 IRQ_TYPE_LEVEL_HIGH>;
+            };
+        };
+    };
+
+...
-- 
2.43.0


