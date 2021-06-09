Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C4D6A3A1676
	for <lists+linux-pci@lfdr.de>; Wed,  9 Jun 2021 16:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237303AbhFIOFB (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 9 Jun 2021 10:05:01 -0400
Received: from mail-wr1-f54.google.com ([209.85.221.54]:40939 "EHLO
        mail-wr1-f54.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbhFIOE7 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 9 Jun 2021 10:04:59 -0400
Received: by mail-wr1-f54.google.com with SMTP id y7so20982706wrh.7;
        Wed, 09 Jun 2021 07:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=7yE+bj7E/38rPyfMQ2Y7dkil8U8S07gxBd4g0tEIxB0=;
        b=WB0mQW93aLe0XCJEduYwuCEbPh8fSgth2vOFaI9jksGO436mZxlTOCOi9B4RCUiW9B
         YB5Yl1P/wPzg4MUG/7j2k4AHMzYqhD9f82sYCGfw2LGJ4zk6KoId+LUtv2wNxP2nukI3
         wotwnRRvd8d17fUr1tww/Dh19h+2xNCpkCVg2FZq4gFFhZ/j3kzBfl/EBcK1b+Z1y49/
         ydxGyBsu4lKEfbC1HKolK5fkmgosTJKR203dA0D+OgCKTrw28luKbTD8zs2bzce9JeiM
         qtp+lID54399quyLhqBQpOAeVbV0CBFh0w8WSYTQZV5VjMgwaKEM4QbIof1fBGwYF2K0
         T/aQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=7yE+bj7E/38rPyfMQ2Y7dkil8U8S07gxBd4g0tEIxB0=;
        b=D1xKC/ZhZWJ4WgFju5iZpt/+tdD8QKX93qF91aKOxOpn+tZo0CKQ3EHSw4KZ+Z/fxv
         NkV6POFuZr3iEe7i9CoGRPj5UkaIWFRotHgsW2dkH8BAPM5DjUnpS/gIao6OfEtIJpRh
         IHLhEUqBNxHMom+Wf03i4h31TrowMzYh4SqZD6tyf3AJxczz8qxoFXFjZER2o3YOBTe4
         gi9UUlWe0hKHiv1rqE9zfW6J6gjeH/LQxh+wIiD+o8B9zyTjn9hoXxoQa44Ahhan/mFM
         euAFWLMgZsncmYemwTauQtR+/0z3ci9Gk/A6G3xKqQcbgwwQUWza/7pBTaIpK251PxHA
         ns1A==
X-Gm-Message-State: AOAM531gB4c26KlLtvZW0300/l8Sky5k6tQlZT3JHH/zE/LPsghhQsSV
        ns9CDoUJ7snnCgoHY/ieJuowmudRtMANtA==
X-Google-Smtp-Source: ABdhPJwcu313t4cHLi5huMgbhItuz+9FzoqplAwz1E0g+t8h/trcjldWLl02okuffAMbvIZ3ozVdGQ==
X-Received: by 2002:a5d:6c6d:: with SMTP id r13mr28364425wrz.350.1623247323612;
        Wed, 09 Jun 2021 07:02:03 -0700 (PDT)
Received: from localhost.localdomain (103.red-81-47-144.staticip.rima-tde.net. [81.47.144.103])
        by smtp.gmail.com with ESMTPSA id m23sm5673912wms.2.2021.06.09.07.02.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 09 Jun 2021 07:02:03 -0700 (PDT)
From:   Sergio Paracuellos <sergio.paracuellos@gmail.com>
To:     linux-pci@vger.kernel.org
Cc:     linux-mips@vger.kernel.org, tsbogend@alpha.franken.de,
        devicetree@vger.kernel.org, matthias.bgg@gmail.com,
        john@phrozen.org, bhelgaas@google.com, robh+dt@kernel.org,
        linux-staging@lists.linux.dev, gregkh@linuxfoundation.org,
        neil@brown.name, ilya.lipnitskiy@gmail.com,
        linux-kernel@vger.kernel.org, pali@kernel.org
Subject: [PATCH v2 1/3] dt-bindings: mt7621-pci: PCIe binding documentation for MT7621 SoCs
Date:   Wed,  9 Jun 2021 16:01:57 +0200
Message-Id: <20210609140159.20476-2-sergio.paracuellos@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
References: <20210609140159.20476-1-sergio.paracuellos@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add device tree binding documentation for PCIe in MT7621 SoCs.

Signed-off-by: Sergio Paracuellos <sergio.paracuellos@gmail.com>
---
 .../bindings/pci/mediatek,mt7621-pci.yaml     | 142 ++++++++++++++++++
 1 file changed, 142 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml

diff --git a/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
new file mode 100644
index 000000000000..716b77d6c830
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/mediatek,mt7621-pci.yaml
@@ -0,0 +1,142 @@
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
+patternProperties:
+  'pcie@[0-2],0':
+    type: object
+    $ref: /schemas/pci/pci-bus.yaml#
+
+    properties:
+      resets:
+        maxItems: 1
+
+      clocks:
+        maxItems: 1
+
+      phys:
+        maxItems: 1
+
+    required:
+      - "#interrupt-cells"
+      - interrupt-map-mask
+      - interrupt-map
+      - resets
+      - clocks
+      - phys
+      - phy-names
+      - ranges
+
+    unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - ranges
+  - "#interrupt-cells"
+  - interrupt-map-mask
+  - interrupt-map
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
+            resets = <&rstctrl 24>;
+            clocks = <&clkctrl 24>;
+            phys = <&pcie0_phy 1>;
+            phy-names = "pcie-phy0";
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
+            resets = <&rstctrl 25>;
+            clocks = <&clkctrl 25>;
+            phys = <&pcie0_phy 1>;
+            phy-names = "pcie-phy1";
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
+            resets = <&rstctrl 26>;
+            clocks = <&clkctrl 26>;
+            phys = <&pcie2_phy 0>;
+            phy-names = "pcie-phy2";
+            ranges;
+        };
+    };
+...
-- 
2.25.1

