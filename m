Return-Path: <linux-pci+bounces-28704-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CC85BAC8CCA
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 13:20:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 755D64E5B8F
	for <lists+linux-pci@lfdr.de>; Fri, 30 May 2025 11:20:34 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A867522C322;
	Fri, 30 May 2025 11:19:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b="RIjmqaub"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f45.google.com (mail-wm1-f45.google.com [209.85.128.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 79E5E22B594
	for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 11:19:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1748603993; cv=none; b=jKWaH21LF3sHVsYpZ/TZtiUTCYT39/LuZi2prfA+nY2GKUJPaGmHr7cTZYPOHKwIe8K9i9HWJIoXaTCfkPMpY9mi0N3srJqEX5pt8RNzsmUePphi5I9IJbpJFMNsD/pRxMnB9275ueltqD4vAk802OBUcqrXNgim4IOXHxJUDA0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1748603993; c=relaxed/simple;
	bh=ns2/6HM9DUUKQWgTZTHH3dZVC94HZ2UxMpbY4SNaI0s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=T6sH6E0suWWVfAGwwq9PjjxjL/89cjvzhvyol754n5zSMXF6xvgVcyqepY18O/jCJj85URWiqa/MzlG0MZLuCFsiBF5nfEZtJCd/XBq60ZXACScvUBbYwiK/f2pwtpJXJhUAnPz+WPmxvbLwz/kAOGy7jPzoks7DtVWdJbxxsL8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev; spf=pass smtp.mailfrom=tuxon.dev; dkim=pass (2048-bit key) header.d=tuxon.dev header.i=@tuxon.dev header.b=RIjmqaub; arc=none smtp.client-ip=209.85.128.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=none (p=none dis=none) header.from=tuxon.dev
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=tuxon.dev
Received: by mail-wm1-f45.google.com with SMTP id 5b1f17b1804b1-450cf0025c0so13605935e9.3
        for <linux-pci@vger.kernel.org>; Fri, 30 May 2025 04:19:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tuxon.dev; s=google; t=1748603990; x=1749208790; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=NRhFPy/WSaCOJP9APyJMZ4CnadrynNoxtIF0zSIL6mg=;
        b=RIjmqaubfatb8vLWLsdi2NNjp+byq1n33u8GrI4qKZ7Dvp9M0MsCfcqKkpD+tI6ONY
         X4ChhIIMFoySXGSDn1UvTT0FpmJlDlMuKHKffWyuzJHf7aYvKORTnA4GfmKqEirveSe6
         kKKcmDhRigLFJbj+Dbr1CIyLDXO6ABYPL1zDTt69JVeagD0CQswFvCMSjOps3atTjflf
         c5An3JzN4pjLRQs/V/TT/ODFcj9K7BHAo59Zss6P04T/1lROhvZtswMeG63NNcoVbvw3
         7Xn3iR+l6v3x7ehVu2B3/vE9nYCxsBbJcwQMorUjgRKmnVfU7eL0/0BKVGeVrc7aTcjz
         7ZVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1748603990; x=1749208790;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NRhFPy/WSaCOJP9APyJMZ4CnadrynNoxtIF0zSIL6mg=;
        b=EvLMcRUWPPnxpXxHHY0YQwZR1qRdDCC+B4+xoCI6Glc4Kbi+hR9JUwZEso2NGa458X
         5dRGWSMgJKqTSYZq2aGWmAq1Tt/EUf4tThK5nyp9kO2KQdYYt5RLfKaJMVzLav3em2sl
         e54KaEJCQ4WH7Df/JKChki7rV9iUKMvJbcMtHJnu3zX0aHpTjG5R/j0rw2jDoquj8R7f
         Sc6+5MkSjtFlAkq416UKk+Z1G9Dm23uo30gvgln8RGLCIE/0j0+0hpGkG3UPQFaN96RS
         YGOeBSyxw16h5usWC1saqM2oQA0Y8fbkzlu5h8oQAqB9Daat/hKvI/Rm9QlPkwmHAivO
         t6AA==
X-Forwarded-Encrypted: i=1; AJvYcCXrQ4mN0SJDjVTKx4HwrTlbD8+87rfcU2bzSvzwjeXjC/qoQPUDxjVihwvXpfiZv/EzZ+xHffprW2Q=@vger.kernel.org
X-Gm-Message-State: AOJu0YzXNUJEBwv5FOJlxhpB83ET5bIcJEA0Z8oT46SyF27GReToZh2+
	tIrROJwgVpH19hDwHYxpBAQlsEwekF/Z1TOOmvuaMk3v755qgb/sjvflz5poazp/buE=
X-Gm-Gg: ASbGnctOcHJKsvYaf4et1srj70wpu1UzEnSN4gEdIgmNAqJYTyfx0jyteS4Yfsl8OPu
	JVatRvstMd/an7WE4ykLv7NYgHXwFrspcXI/oruVY6X72rNRdMXf5mZucwWGokW01rfy221z6Ss
	BQfuOhqWLpGE8HDSSgE3EQl1/7Nzurl9zfcacUWSFfk1i7V3B5MuSjwk59VWdXeOXjS4DykQT39
	hSzPowaAeolx+QHconnD0hcXStc77nBs47W8DNEVFAc9FuF3VhcXFnFaAsGwzoiULeLX/70i7Vh
	5d/C0iVXJyDhdjBaQ6ZgO3akboFet388caky+VEG3fcCeY9Opr+AsrRQZPbGpQvWJFyfvzj+ljY
	XjuT9yA==
X-Google-Smtp-Source: AGHT+IFM8W21a8CSEqnfheEWvs2NWYLaDxAcaJALbnProLcKAOdd/gUtEAjS+UJvMRJJ0qPulokYPA==
X-Received: by 2002:a05:600c:1910:b0:441:b698:3431 with SMTP id 5b1f17b1804b1-450d6590912mr23046025e9.28.1748603989725;
        Fri, 30 May 2025 04:19:49 -0700 (PDT)
Received: from claudiu-X670E-Pro-RS.. ([82.78.167.126])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-450dc818f27sm3986435e9.18.2025.05.30.04.19.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 May 2025 04:19:49 -0700 (PDT)
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
	p.zabel@pengutronix.de
Cc: claudiu.beznea@tuxon.dev,
	linux-pci@vger.kernel.org,
	linux-renesas-soc@vger.kernel.org,
	devicetree@vger.kernel.org,
	linux-kernel@vger.kernel.org,
	linux-arm-kernel@lists.infradead.org,
	linux-clk@vger.kernel.org,
	john.madieu.xa@bp.renesas.com,
	Claudiu Beznea <claudiu.beznea.uj@bp.renesas.com>
Subject: [PATCH v2 3/8] dt-bindings: PCI: renesas,r9a08g045s33-pcie: Add documentation for the PCIe IP on Renesas RZ/G3S
Date: Fri, 30 May 2025 14:19:12 +0300
Message-ID: <20250530111917.1495023-4-claudiu.beznea.uj@bp.renesas.com>
X-Mailer: git-send-email 2.43.0
In-Reply-To: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
References: <20250530111917.1495023-1-claudiu.beznea.uj@bp.renesas.com>
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

 .../pci/renesas,r9a08g045s33-pcie.yaml        | 202 ++++++++++++++++++
 1 file changed, 202 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
new file mode 100644
index 000000000000..8ba30c084d1b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/renesas,r9a08g045s33-pcie.yaml
@@ -0,0 +1,202 @@
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
+  vendor-id:
+    const: 0x1912
+
+  device-id:
+    const: 0x0033
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
+        pcie@11e40000 {
+            compatible = "renesas,r9a08g045s33-pcie";
+            reg = <0 0x11e40000 0 0x10000>;
+            ranges = <0x03000000 0 0x30000000 0 0x30000000 0 0x8000000>;
+            dma-ranges = <0x42000000 0 0x48000000 0 0x48000000 0 0x38000000>;
+            bus-range = <0x0 0xff>;
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
+            interrupt-map = <0 0 0 1 &pcie 0 0 0 0>, /* INT A */
+                            <0 0 0 2 &pcie 0 0 0 1>, /* INT B */
+                            <0 0 0 3 &pcie 0 0 0 2>, /* INT C */
+                            <0 0 0 4 &pcie 0 0 0 3>; /* INT D */
+            device_type = "pci";
+            num-lanes = <1>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            power-domains = <&cpg>;
+            vendor-id = <0x1912>;
+            device-id = <0x0033>;
+            renesas,sysc = <&sysc>;
+        };
+    };
+
+...
-- 
2.43.0


