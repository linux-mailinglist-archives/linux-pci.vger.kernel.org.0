Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82F8D6778B5
	for <lists+linux-pci@lfdr.de>; Mon, 23 Jan 2023 11:10:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231975AbjAWKKd (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Jan 2023 05:10:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231934AbjAWKKV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Jan 2023 05:10:21 -0500
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 221561E2A1
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:10 -0800 (PST)
Received: by mail-wr1-x430.google.com with SMTP id h16so10233175wrz.12
        for <linux-pci@vger.kernel.org>; Mon, 23 Jan 2023 02:10:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=/pQr6KmTdUgnaHE8iXfJ0bvx2pGOLcHh3rodgiE7+Kk=;
        b=fNsjAacdBPOR5DiDkCUpjezb9Dvezn7/R1FOw2oZ6QwPNBVsWcDPdfYkSTPbKULF5H
         L6X8evzYtigZvdTanLyQe7YKEypW1MmUWAFSXc/OX09EViqzK6jhSEbwUFE0CXqf6ClZ
         xecJS89i7tQY3WnNwOsN2PxhADwmM9yP2wOXtSSOciODP5/ZScoY8iJRrd9rCWSQWr+I
         6S2U+eXdSVoQ2hLeHBv4+RRBYOoGqIlisoiMjDNUQEm0Amv4dzcoL/6Se6PRpm8aNmlZ
         0ahovNgqgULX1nnl+wkzFGtG/sy1fWqs6a8s0NEEargwtSBytuV/rX2GJW1zF3/gReFF
         UDpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/pQr6KmTdUgnaHE8iXfJ0bvx2pGOLcHh3rodgiE7+Kk=;
        b=NALMBUJKSz2N5c6O2EANcy2L7A/XVvTaZkqPhProJXxQxqFUDO1pqLqZkRwaslgi4I
         r0qaRlp5jFR55CbzldRpQBKPD7DDLtUuxX/wOjGqFpc+msqpCM4jQWArohVrbpXSzoRA
         4yuww2JeWEzszKSwfYtOczuvTVGZhFmbtrWVKc0YHDtyFZ7ngn86dWTqTJkRGLqEYTIC
         4ZGSrMJcOkzaQVtt1sVSUF7q4Ws6thHXk2URvINm9RiMoMno8OD/kRxs8YOuDFtEO4mO
         BP+CN+VCg2H85mXXSkr9D67YzbtOfTD5TGAjDH1w3++cnmShCWuXTPTcl0b0Wtr7qz3h
         Ft8g==
X-Gm-Message-State: AFqh2koZjNv3FFo4vWb+Xnm+PqdX+LE3UeQiHNcMFg5x8Cn8utjrz7Fk
        cFi+QPtmmuK3kdrtdMwSO/8RRQ==
X-Google-Smtp-Source: AMrXdXtX4ayB4/SYIKN3tEBT6oVM/Ouxw56XQljpQcVZlok0nl5I8ryh0pMDyUY+HyWaFPo2iskQvQ==
X-Received: by 2002:a5d:4bce:0:b0:2be:4ae1:215a with SMTP id l14-20020a5d4bce000000b002be4ae1215amr11722277wrt.16.1674468609550;
        Mon, 23 Jan 2023 02:10:09 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id m9-20020a056000024900b002bdec340a1csm22670403wrz.110.2023.01.23.02.10.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 23 Jan 2023 02:10:09 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Date:   Mon, 23 Jan 2023 11:10:04 +0100
Subject: [PATCH v3 7/7] dt-bindings: PCI: convert amlogic,meson-pcie.txt to
 dt-schema
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20221117-b4-amlogic-bindings-convert-v3-7-e28dd31e3bed@linaro.org>
References: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
In-Reply-To: <20221117-b4-amlogic-bindings-convert-v3-0-e28dd31e3bed@linaro.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-pci@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Convert the Amlogic Meson AXG DWC PCIe SoC controller bindings to
dt-schema.

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
 .../devicetree/bindings/pci/amlogic,axg-pcie.yaml  | 134 +++++++++++++++++++++
 .../devicetree/bindings/pci/amlogic,meson-pcie.txt |  70 -----------
 2 files changed, 134 insertions(+), 70 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
new file mode 100644
index 000000000000..a5bd90bc0712
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/amlogic,axg-pcie.yaml
@@ -0,0 +1,134 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/amlogic,axg-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Amlogic Meson AXG DWC PCIe SoC controller
+
+maintainers:
+  - Neil Armstrong <neil.armstrong@linaro.org>
+
+description:
+  Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
+
+# We need a select here so we don't match all nodes with 'snps,dw-pcie'
+select:
+  properties:
+    compatible:
+      enum:
+        - amlogic,axg-pcie
+        - amlogic,g12a-pcie
+  required:
+    - compatible
+
+properties:
+  compatible:
+    items:
+      - enum:
+          - amlogic,axg-pcie
+          - amlogic,g12a-pcie
+      - const: snps,dw-pcie
+
+  reg:
+    items:
+      - description: External local bus interface registers
+      - description: Meson designed configuration registers
+      - description: PCIe configuration space
+
+  reg-names:
+    items:
+      - const: elbi
+      - const: cfg
+      - const: config
+
+  interrupts:
+    maxItems: 1
+
+  clocks:
+    items:
+      - description: PCIe GEN 100M PLL clock
+      - description: PCIe RC clock gate
+      - description: PCIe PHY clock
+
+  clock-names:
+    items:
+      - const: pclk
+      - const: port
+      - const: general
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie
+
+  resets:
+    items:
+      - description: Port Reset
+      - description: Shared APB reset
+
+  reset-names:
+    items:
+      - const: port
+      - const: apb
+
+  num-lanes:
+    const: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - interrupts
+  - clock
+  - clock-names
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+  - interrupt-map
+  - interrupt-map-mask
+  - ranges
+  - bus-range
+  - device_type
+  - num-lanes
+  - phys
+  - phy-names
+  - resets
+  - reset-names
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pcie: pcie@f9800000 {
+        compatible = "amlogic,axg-pcie", "snps,dw-pcie";
+        reg = <0xf9800000 0x400000>, <0xff646000 0x2000>, <0xf9f00000 0x100000>;
+        reg-names = "elbi", "cfg", "config";
+        interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
+        clocks = <&pclk>, <&clk_port>, <&clk_phy>;
+        clock-names = "pclk", "port", "general";
+        resets = <&reset_pcie_port>, <&reset_pcie_apb>;
+        reset-names = "port", "apb";
+        phys = <&pcie_phy>;
+        phy-names = "pcie";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0>;
+        interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
+        bus-range = <0x0 0xff>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        device_type = "pci";
+        num-lanes = <1>;
+        ranges = <0x82000000 0 0 0xf9c00000 0 0x00300000>;
+    };
+...
diff --git a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt b/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
deleted file mode 100644
index c3a75ac6e59d..000000000000
--- a/Documentation/devicetree/bindings/pci/amlogic,meson-pcie.txt
+++ /dev/null
@@ -1,70 +0,0 @@
-Amlogic Meson AXG DWC PCIE SoC controller
-
-Amlogic Meson PCIe host controller is based on the Synopsys DesignWare PCI core.
-It shares common functions with the PCIe DesignWare core driver and
-inherits common properties defined in
-Documentation/devicetree/bindings/pci/snps,dw-pcie.yaml.
-
-Additional properties are described here:
-
-Required properties:
-- compatible:
-	should contain :
-	- "amlogic,axg-pcie" for AXG SoC Family
-	- "amlogic,g12a-pcie" for G12A SoC Family
-	to identify the core.
-- reg:
-	should contain the configuration address space.
-- reg-names: Must be
-	- "elbi"	External local bus interface registers
-	- "cfg"		Meson specific registers
-	- "config"	PCIe configuration space
-- reset-gpios: The GPIO to generate PCIe PERST# assert and deassert signal.
-- clocks: Must contain an entry for each entry in clock-names.
-- clock-names: Must include the following entries:
-	- "pclk"       PCIe GEN 100M PLL clock
-	- "port"       PCIe_x(A or B) RC clock gate
-	- "general"    PCIe Phy clock
-- resets: phandle to the reset lines.
-- reset-names: must contain "port" and "apb"
-       - "port"        Port A or B reset
-       - "apb"         Share APB reset
-- phys: should contain a phandle to the PCIE phy
-- phy-names: must contain "pcie"
-
-- device_type:
-	should be "pci". As specified in snps,dw-pcie.yaml
-
-
-Example configuration:
-
-	pcie: pcie@f9800000 {
-			compatible = "amlogic,axg-pcie", "snps,dw-pcie";
-			reg = <0x0 0xf9800000 0x0 0x400000
-					0x0 0xff646000 0x0 0x2000
-					0x0 0xf9f00000 0x0 0x100000>;
-			reg-names = "elbi", "cfg", "config";
-			reset-gpios = <&gpio GPIOX_19 GPIO_ACTIVE_HIGH>;
-			interrupts = <GIC_SPI 177 IRQ_TYPE_EDGE_RISING>;
-			#interrupt-cells = <1>;
-			interrupt-map-mask = <0 0 0 0>;
-			interrupt-map = <0 0 0 0 &gic GIC_SPI 179 IRQ_TYPE_EDGE_RISING>;
-			bus-range = <0x0 0xff>;
-			#address-cells = <3>;
-			#size-cells = <2>;
-			device_type = "pci";
-			ranges = <0x82000000 0 0 0x0 0xf9c00000 0 0x00300000>;
-
-			clocks = <&clkc CLKID_USB
-					&clkc CLKID_PCIE_A
-					&clkc CLKID_PCIE_CML_EN0>;
-			clock-names = "general",
-					"pclk",
-					"port";
-			resets = <&reset RESET_PCIE_A>,
-				<&reset RESET_PCIE_APB>;
-			reset-names = "port",
-					"apb";
-			phys = <&pcie_phy>;
-			phy-names = "pcie";
-	};

-- 
2.34.1

