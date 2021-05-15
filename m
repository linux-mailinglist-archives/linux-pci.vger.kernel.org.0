Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C06A43818C9
	for <lists+linux-pci@lfdr.de>; Sat, 15 May 2021 14:41:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232164AbhEOMmP (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sat, 15 May 2021 08:42:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230004AbhEOMmP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sat, 15 May 2021 08:42:15 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B48C06174A;
        Sat, 15 May 2021 05:41:00 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id j14so25607wrq.5;
        Sat, 15 May 2021 05:41:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=29hFlM7+Y+uwzh88wBHQABcMU9Oyv+iMTUv6Oz1e+Lw=;
        b=Ac5+khIWLkEmDqtXwGl0zLNE8t3eV0qwHWKAsX3AUELcoxHWKiD6e0slrwZPZUxsm/
         bATfNAltMBYtoEaggzCJs50QmDFDXs7M5OnUIXH7LhLwDJmhbLXGEH5BFieLSngBGgpp
         20UYgdGxeeN/uE9juT2SykeGNCGK8+vDyEh1UVhAjA6ixzPb+lQrzMOCPzxQuOcIGa4Z
         UMghJbSpk7ihxxJbgVkNk9TkAlgaeKnbarPnpL/NKpVe7+8xEiosRd4LrzKkUdtPcAEd
         K8ijuMtCCchgB7AkHezvDBUoIrM0grf6i19XJ2M8b+6olj7w6jpg31qAwB6NEIma0m2O
         pXpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=29hFlM7+Y+uwzh88wBHQABcMU9Oyv+iMTUv6Oz1e+Lw=;
        b=QYLHbByHUhkh81aoNGETibgX4wGm19rzlZJv4vKj3EQiyRMYN4N2PPir0L/wH5IZji
         ifNBCtX/0xuyKgOZpu+Xbuf9/6t7EjT/HJn2DTA2dPE+vfpQLvIWOMHJ/pWS5us4BR0G
         4B7d7HGXikCja+FpGBsNSKzM+DNFP4VRwAn5GMRQazFWNcnbM3yCGuyq7OOuFX/F4Adf
         JU7c7ITluDFdFHKlVpEvqPPphxvpp7XACF1jzaia/g6io5iFs8GxuWk2LPi4HHOaB8SF
         yyAP6vZ1Xw2KRtD27NQyCkDzLtncFIOIpYHHU6vWrBMrCeD2qDgu17lrTJaImZU9AwOw
         rYBg==
X-Gm-Message-State: AOAM530SGHnQB+mIqQ8z4kYahxw/juLJHYkQsRvkaWrFkpiR61GVQ/Wt
        Fs3l65GHXkPgfYwPCXPJg+xNWPEqjO0UCMB6
X-Google-Smtp-Source: ABdhPJw73ij0S25x2szSZPCsPa+9Q/ZqkLlIxEGzrghb6i9sMblc8N+o5DBjCk7+Qus5m5ryEoxgig==
X-Received: by 2002:adf:f109:: with SMTP id r9mr6748436wro.251.1621082458973;
        Sat, 15 May 2021 05:40:58 -0700 (PDT)
Received: from localhost.localdomain (29.red-83-49-33.dynamicip.rima-tde.net. [83.49.33.29])
        by smtp.gmail.com with ESMTPSA id w7sm9472749wru.51.2021.05.15.05.40.57
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 15 May 2021 05:40:58 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-mips@vger.kernel.org
Cc:     tsbogend@alpha.franken.de, devicetree@vger.kernel.org,
        matthias.bgg@gmail.com, john@phrozen.org, bhelgaas@google.com,
        robh+dt@kernel.org, linux-staging@lists.linux.dev,
        gregkh@linuxfoundation.org, neil@brown.name,
        ilya.lipnitskiy@gmail.com, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH 1/4] dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
Date:   Sat, 15 May 2021 14:40:52 +0200
Message-Id: <20210515124055.22225-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
References: <20210515124055.22225-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree binding documentation for PCIe in MT7621 SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/pci/mediatek,mt7621-pci.yaml     | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
new file mode 100644
index 000000000000..7f5f9d583032
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/mediatek,mt7621-pci.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: MediaTek MT7621 PCIe controller
+
+maintainers:
+  - Sergio Paracuellos <sergio.paracuellos@gmail.com>
+
+description: |+
+  MediaTek MT7621 PCIe subsys supports single Root complex (RC)
+  with 3 Root Ports. Each Root Ports supports a Gen1 1-lane Link
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    const: mediatek,mt7621-pci
+
+  reg:
+    items:
+      - description: host-pci bridge registers
+      - description: pcie port 0 RC control registers
+      - description: pcie port 1 RC control registers
+      - description: pcie port 2 RC control registers
+
+  ranges:
+    maxItems: 2
+
+  resets:
+    items:
+      - description: pcie port 0 reset.
+      - description: pcie port 1 reset.
+      - description: pcie port 2 reset.
+
+  reset-names:
+    items:
+      - const: pcie0
+      - const: pcie1
+      - const: pcie2
+
+  clocks:
+    items:
+      - description: pcie port 0 clock.
+      - description: pcie port 1 clock.
+      - description: pcie port 2 clock.
+
+  clock-names:
+    items:
+      - const: pcie0
+      - const: pcie1
+      - const: pcie2
+
+  phys:
+    items:
+      - description: Dual-ported phy for pcie port 0 and 1.
+      - description: Phy for pcie port 2.
+
+  phy-names:
+    items:
+      - const: pcie-phy0
+      - const: pcie-phy2
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
+  - resets
+  - reset-names
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/mips-gic.h>
+
+    pcie: pcie@1e140000 {
+        compatible = "mediatek,mt7621-pci";
+        reg = <0x1e140000 0x100>,
+              <0x1e142000 0x100>,
+              <0x1e143000 0x100>,
+              <0x1e144000 0x100>;
+
+        #address-cells = <3>;
+        #size-cells = <2>;
+        pinctrl-names = "default";
+        pinctrl-0 = <&pcie_pins>;
+        device_type = "pci";
+        ranges = <0x02000000 0 0x00000000 0x60000000 0 0x10000000>,  /* pci memory */
+                 <0x01000000 0 0x00000000 0x1e160000 0 0x00010000>;  /* io space */
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0xF800 0 0 0>;
+        interrupt-map = <0x0000 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x0800 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>,
+                        <0x1000 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
+        resets = <&rstctrl 24>, <&rstctrl 25>, <&rstctrl 26>;
+        reset-names = "pcie0", "pcie1", "pcie2";
+        clocks = <&clkctrl 24>, <&clkctrl 25>, <&clkctrl 26>;
+        clock-names = "pcie0", "pcie1", "pcie2";
+        phys = <&pcie0_phy 1>, <&pcie2_phy 0>;
+        phy-names = "pcie-phy0", "pcie-phy2";
+        reset-gpios = <&gpio 19 GPIO_ACTIVE_LOW>;
+
+        pcie@0,0 {
+            reg = <0x0000 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SHARED 4 IRQ_TYPE_LEVEL_HIGH>;
+            ranges;
+        };
+
+        pcie@1,0 {
+            reg = <0x0800 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SHARED 24 IRQ_TYPE_LEVEL_HIGH>;
+            ranges;
+        };
+
+        pcie@2,0 {
+            reg = <0x1000 0 0 0 0>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SHARED 25 IRQ_TYPE_LEVEL_HIGH>;
+            ranges;
+        };
+    };
+...
-- 
2.25.1

