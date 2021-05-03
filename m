Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E0437371FF1
	for <lists+linux-pci@lfdr.de>; Mon,  3 May 2021 20:52:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229567AbhECSxj (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 3 May 2021 14:53:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52814 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbhECSxh (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 3 May 2021 14:53:37 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACD42C061763
        for <linux-pci@vger.kernel.org>; Mon,  3 May 2021 11:52:42 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id s82so3927801wmf.3
        for <linux-pci@vger.kernel.org>; Mon, 03 May 2021 11:52:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzeBqd1gevTueDMjmk9D8/zrEvbhxBIODrElU9+Y96o=;
        b=jGMMllvUoT36ygFDsqFwMbvLwBGzTzEaP/vabhFesprPzBadYCNN8lN2V+ZPEYv7JX
         SFmx3WzZrrnIqOlxmLe+xC5SziL1E3NUd7qRCrEpfkWX6nascJjFu44eMuVGPR5rm4go
         Y6oSDpJhmVUIDe1hwVCtgrG+PoqSQnsBwPjWjKAZSKBZ3YVuLXKuZ8UEvWRnx9UlsR/h
         TF1vDay7JA0mzH55zC5zSMMtZf02MUc1ntSChhbuKh8l5a9K+hqoqa0cT/v30i7BKQLK
         OsM15ko7SThHRwISyzJV/N8jIpb2yBJdoNE9K2bP4MYcDlzCH88GRPWcX0bMbdHnYgi3
         KScA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=uzeBqd1gevTueDMjmk9D8/zrEvbhxBIODrElU9+Y96o=;
        b=ttEmhTTBHtE75/srXJO/CJ53ToBo2KzQ8dKMqTF+SnbcWnSUGp1Ikhsgeepm+PYWK+
         u/tRcZ/FupbzVCWfFRh8gyFFsGx7C7q+gCi8XL4KhCx7Wq04XSmlaNYG3tPEoIbHIli2
         aDqfaBM7fzyiKZVaMEPGjKDhDdkAO3is9ZmHzvsdPBJsKND8MCt4ebQYdHDOxEu0XXVg
         8xWHgpByLTPLV8lvO+DddpAYVBR3pJ2GBDAhxBaeH9FXie25lIQs70imBr9nl2D0x6R0
         uqE5YXt3B2xpnMZMFKhGj7cjb4/+BlOtwdL2Vv92Z1eL3B5YKnwtOSyE55E1XOLCi241
         rfNw==
X-Gm-Message-State: AOAM530BYaprg2cQR2rVGB6GsmACCdlJqifr3FR3pLom/y5iboZ+vRK7
        D5RkksRklmS+aj+JGW73JCS7fQ==
X-Google-Smtp-Source: ABdhPJzkHkFE0Z1ree2fqaRCOt+/xkdW6102n5/3TJoyDttBpUh594AjorlBUPU67JIBEekLwJ3qEg==
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr22718286wmp.108.1620067961080;
        Mon, 03 May 2021 11:52:41 -0700 (PDT)
Received: from localhost.localdomain (laubervilliers-658-1-213-31.w90-63.abo.wanadoo.fr. [90.63.244.31])
        by smtp.googlemail.com with ESMTPSA id i14sm711228wmq.1.2021.05.03.11.52.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 May 2021 11:52:40 -0700 (PDT)
From:   Corentin Labbe <clabbe@baylibre.com>
To:     bhelgaas@google.com, linus.walleij@linaro.org, robh+dt@kernel.org,
        ulli.kroll@googlemail.com
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-pci@vger.kernel.org,
        Corentin Labbe <clabbe@baylibre.com>
Subject: [PATCH 1/2] dt-bindings: pci: convert faraday,ftpci100 to yaml
Date:   Mon,  3 May 2021 18:52:27 +0000
Message-Id: <20210503185228.1518131-1-clabbe@baylibre.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Converts pci/faraday,ftpci100.txt to yaml.
Some change are also made:
- example has wrong interrupts place

Signed-off-by: Corentin Labbe <clabbe@baylibre.com>
---
 .../bindings/pci/faraday,ftpci100.txt         | 135 -----------
 .../bindings/pci/faraday,ftpci100.yaml        | 211 ++++++++++++++++++
 2 files changed, 211 insertions(+), 135 deletions(-)
 delete mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
 create mode 100644 Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml

diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt b/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
deleted file mode 100644
index 5f8cb4962f8d..000000000000
--- a/Documentation/devicetree/bindings/pci/faraday,ftpci100.txt
+++ /dev/null
@@ -1,135 +0,0 @@
-Faraday Technology FTPCI100 PCI Host Bridge
-
-This PCI bridge is found inside that Cortina Systems Gemini SoC platform and
-is a generic IP block from Faraday Technology. It exists in two variants:
-plain and dual PCI. The plain version embeds a cascading interrupt controller
-into the host bridge. The dual version routes the interrupts to the host
-chips interrupt controller.
-
-The host controller appear on the PCI bus with vendor ID 0x159b (Faraday
-Technology) and product ID 0x4321.
-
-Mandatory properties:
-
-- compatible: ranging from specific to generic, should be one of
-  "cortina,gemini-pci", "faraday,ftpci100"
-  "cortina,gemini-pci-dual", "faraday,ftpci100-dual"
-  "faraday,ftpci100"
-  "faraday,ftpci100-dual"
-- reg: memory base and size for the host bridge
-- #address-cells: set to <3>
-- #size-cells: set to <2>
-- #interrupt-cells: set to <1>
-- bus-range: set to <0x00 0xff>
-- device_type, set to "pci"
-- ranges: see pci.txt
-- interrupt-map-mask: see pci.txt
-- interrupt-map: see pci.txt
-- dma-ranges: three ranges for the inbound memory region. The ranges must
-  be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB, 64MB,
-  128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked as
-  pre-fetchable.
-
-Optional properties:
-- clocks: when present, this should contain the peripheral clock (PCLK) and the
-  PCI clock (PCICLK). If these are not present, they are assumed to be
-  hard-wired enabled and always on. The PCI clock will be 33 or 66 MHz.
-- clock-names: when present, this should contain "PCLK" for the peripheral
-  clock and "PCICLK" for the PCI-side clock.
-
-Mandatory subnodes:
-- For "faraday,ftpci100" a node representing the interrupt-controller inside the
-  host bridge is mandatory. It has the following mandatory properties:
-  - interrupt: see interrupt-controller/interrupts.txt
-  - interrupt-controller: see interrupt-controller/interrupts.txt
-  - #address-cells: set to <0>
-  - #interrupt-cells: set to <1>
-
-I/O space considerations:
-
-The plain variant has 128MiB of non-prefetchable memory space, whereas the
-"dual" variant has 64MiB. Take this into account when describing the ranges.
-
-Interrupt map considerations:
-
-The "dual" variant will get INT A, B, C, D from the system interrupt controller
-and should point to respective interrupt in that controller in its
-interrupt-map.
-
-The code which is the only documentation of how the Faraday PCI (the non-dual
-variant) interrupts assigns the default interrupt mapping/swizzling has
-typically been like this, doing the swizzling on the interrupt controller side
-rather than in the interconnect:
-
-interrupt-map-mask = <0xf800 0 0 7>;
-interrupt-map =
-	<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-	<0x4800 0 0 2 &pci_intc 1>,
-	<0x4800 0 0 3 &pci_intc 2>,
-	<0x4800 0 0 4 &pci_intc 3>,
-	<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-	<0x5000 0 0 2 &pci_intc 2>,
-	<0x5000 0 0 3 &pci_intc 3>,
-	<0x5000 0 0 4 &pci_intc 0>,
-	<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-	<0x5800 0 0 2 &pci_intc 3>,
-	<0x5800 0 0 3 &pci_intc 0>,
-	<0x5800 0 0 4 &pci_intc 1>,
-	<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-	<0x6000 0 0 2 &pci_intc 0>,
-	<0x6000 0 0 3 &pci_intc 1>,
-	<0x6000 0 0 4 &pci_intc 2>;
-
-Example:
-
-pci@50000000 {
-	compatible = "cortina,gemini-pci", "faraday,ftpci100";
-	reg = <0x50000000 0x100>;
-	interrupts = <8 IRQ_TYPE_LEVEL_HIGH>, /* PCI A */
-			<26 IRQ_TYPE_LEVEL_HIGH>, /* PCI B */
-			<27 IRQ_TYPE_LEVEL_HIGH>, /* PCI C */
-			<28 IRQ_TYPE_LEVEL_HIGH>; /* PCI D */
-	#address-cells = <3>;
-	#size-cells = <2>;
-	#interrupt-cells = <1>;
-
-	bus-range = <0x00 0xff>;
-	ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
-		 <0x01000000 0 0          0x50000000 0 0x00100000>,
-		 /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
-		 <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
-
-	/* DMA ranges */
-	dma-ranges =
-	/* 128MiB at 0x00000000-0x07ffffff */
-	<0x02000000 0 0x00000000 0x00000000 0 0x08000000>,
-	/* 64MiB at 0x00000000-0x03ffffff */
-	<0x02000000 0 0x00000000 0x00000000 0 0x04000000>,
-	/* 64MiB at 0x00000000-0x03ffffff */
-	<0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
-
-	interrupt-map-mask = <0xf800 0 0 7>;
-	interrupt-map =
-		<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
-		<0x4800 0 0 2 &pci_intc 1>,
-		<0x4800 0 0 3 &pci_intc 2>,
-		<0x4800 0 0 4 &pci_intc 3>,
-		<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
-		<0x5000 0 0 2 &pci_intc 2>,
-		<0x5000 0 0 3 &pci_intc 3>,
-		<0x5000 0 0 4 &pci_intc 0>,
-		<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
-		<0x5800 0 0 2 &pci_intc 3>,
-		<0x5800 0 0 3 &pci_intc 0>,
-		<0x5800 0 0 4 &pci_intc 1>,
-		<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
-		<0x6000 0 0 2 &pci_intc 0>,
-		<0x6000 0 0 3 &pci_intc 0>,
-		<0x6000 0 0 4 &pci_intc 0>;
-	pci_intc: interrupt-controller {
-		interrupt-parent = <&intcon>;
-		interrupt-controller;
-		#address-cells = <0>;
-		#interrupt-cells = <1>;
-	};
-};
diff --git a/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
new file mode 100644
index 000000000000..9be27e71526c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/faraday,ftpci100.yaml
@@ -0,0 +1,211 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/faraday,ftpci100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Faraday Technology FTPCI100 PCI Host Bridge
+
+maintainers:
+  - Linus Walleij <linus.walleij@linaro.org>
+
+description: |
+    This PCI bridge is found inside that Cortina Systems Gemini SoC platform and
+    is a generic IP block from Faraday Technology. It exists in two variants:
+    plain and dual PCI. The plain version embeds a cascading interrupt controller
+    into the host bridge. The dual version routes the interrupts to the host
+    chips interrupt controller.
+    The host controller appear on the PCI bus with vendor ID 0x159b (Faraday
+    Technology) and product ID 0x4321.
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    oneOf:
+      - items:
+          - const: "cortina,gemini-pci"
+          - const: "faraday,ftpci100"
+      - items:
+          - const: "cortina,gemini-pci-dual"
+          - const: "faraday,ftpci100-dual"
+      - const: "faraday,ftpci100"
+      - const: "faraday,ftpci100-dual"
+
+  reg:
+    minItems: 1
+
+  "#address-cells":
+    const: 3
+
+  "#size-cells":
+    const: 2
+
+  "#interrupt-cells":
+    const: 1
+
+  bus-range:
+    items:
+      - const: 0x00
+      - const: 0xff
+
+  ranges:
+    minItems: 2
+    description: see pci.txt
+
+  dma-ranges:
+    minItems: 3
+    description: |
+      three ranges for the inbound memory region. The ranges must
+      be aligned to a 1MB boundary, and may be 1MB, 2MB, 4MB, 8MB, 16MB, 32MB, 64MB,
+      128MB, 256MB, 512MB, 1GB or 2GB in size. The memory should be marked as
+      pre-fetchable.
+
+  clocks:
+    minItems: 2
+    description: |
+      when present, this should contain the peripheral clock (PCLK) and the
+      PCI clock (PCICLK). If these are not present, they are assumed to be
+      hard-wired enabled and always on. The PCI clock will be 33 or 66 MHz.
+
+  clock-names:
+    items:
+      - const: "PCLK"
+      - const: "PCICLK"
+
+  interrupt-controller:
+    allOf:
+      - $ref: /schemas/interrupt-controller.yaml#
+    type: object
+    properties:
+      interrupts:
+        minItems: 1
+
+      interrupt-controller: true
+
+      "#address-cells":
+        const: 0
+
+      "#interrupt-cells":
+        const: 1
+
+    required:
+      - interrupts
+      - interrupt-controller
+      - "#address-cells"
+      - "#interrupt-cells"
+
+required:
+  - reg
+  - compatible
+  - "#address-cells"
+  - "#size-cells"
+  - "#interrupt-cells"
+  - bus-range
+  - ranges
+  - interrupt-map-mask
+  - interrupt-map
+  - dma-ranges
+
+if:
+  properties:
+    compatible:
+      contains:
+        items:
+          - const: cortina,gemini-pci
+          - const: faraday,ftpci100
+then:
+  required:
+    - interrupt-controller
+
+unevaluatedProperties: false
+
+#I/O space considerations:
+
+#The plain variant has 128MiB of non-prefetchable memory space, whereas the
+#"dual" variant has 64MiB. Take this into account when describing the ranges.
+
+#Interrupt map considerations:
+
+#The "dual" variant will get INT A, B, C, D from the system interrupt controller
+#and should point to respective interrupt in that controller in its
+#interrupt-map.
+
+#The code which is the only documentation of how the Faraday PCI (the non-dual
+#variant) interrupts assigns the default interrupt mapping/swizzling has
+#typically been like this, doing the swizzling on the interrupt controller side
+#rather than in the interconnect:
+
+#interrupt-map-mask = <0xf800 0 0 7>;
+#interrupt-map =
+#	<0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+#	<0x4800 0 0 2 &pci_intc 1>,
+#	<0x4800 0 0 3 &pci_intc 2>,
+#	<0x4800 0 0 4 &pci_intc 3>,
+#	<0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+#	<0x5000 0 0 2 &pci_intc 2>,
+#	<0x5000 0 0 3 &pci_intc 3>,
+#	<0x5000 0 0 4 &pci_intc 0>,
+#	<0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+#	<0x5800 0 0 2 &pci_intc 3>,
+#	<0x5800 0 0 3 &pci_intc 0>,
+#	<0x5800 0 0 4 &pci_intc 1>,
+#	<0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+#	<0x6000 0 0 2 &pci_intc 0>,
+#	<0x6000 0 0 3 &pci_intc 1>,
+#	<0x6000 0 0 4 &pci_intc 2>;
+
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/irq.h>
+    pci@50000000 {
+      compatible = "cortina,gemini-pci", "faraday,ftpci100";
+      reg = <0x50000000 0x100>;
+      device_type = "pci";
+      #address-cells = <3>;
+      #size-cells = <2>;
+      #interrupt-cells = <1>;
+
+      bus-range = <0x00 0xff>;
+      ranges = /* 1MiB I/O space 0x50000000-0x500fffff */
+        <0x01000000 0 0          0x50000000 0 0x00100000>,
+        /* 128MiB non-prefetchable memory 0x58000000-0x5fffffff */
+        <0x02000000 0 0x58000000 0x58000000 0 0x08000000>;
+
+      /* DMA ranges */
+      dma-ranges =
+        /* 128MiB at 0x00000000-0x07ffffff */
+        <0x02000000 0 0x00000000 0x00000000 0 0x08000000>,
+        /* 64MiB at 0x00000000-0x03ffffff */
+        <0x02000000 0 0x00000000 0x00000000 0 0x04000000>,
+        /* 64MiB at 0x00000000-0x03ffffff */
+        <0x02000000 0 0x00000000 0x00000000 0 0x04000000>;
+
+      interrupt-map-mask = <0xf800 0 0 7>;
+      interrupt-map =
+        <0x4800 0 0 1 &pci_intc 0>, /* Slot 9 */
+        <0x4800 0 0 2 &pci_intc 1>,
+        <0x4800 0 0 3 &pci_intc 2>,
+        <0x4800 0 0 4 &pci_intc 3>,
+        <0x5000 0 0 1 &pci_intc 1>, /* Slot 10 */
+        <0x5000 0 0 2 &pci_intc 2>,
+        <0x5000 0 0 3 &pci_intc 3>,
+        <0x5000 0 0 4 &pci_intc 0>,
+        <0x5800 0 0 1 &pci_intc 2>, /* Slot 11 */
+        <0x5800 0 0 2 &pci_intc 3>,
+        <0x5800 0 0 3 &pci_intc 0>,
+        <0x5800 0 0 4 &pci_intc 1>,
+        <0x6000 0 0 1 &pci_intc 3>, /* Slot 12 */
+        <0x6000 0 0 2 &pci_intc 0>,
+        <0x6000 0 0 3 &pci_intc 0>,
+        <0x6000 0 0 4 &pci_intc 0>;
+      pci_intc: interrupt-controller {
+        interrupt-parent = <&intcon>;
+        interrupt-controller;
+        interrupts = <8 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <0>;
+        #interrupt-cells = <1>;
+      };
+    };
-- 
2.26.3

