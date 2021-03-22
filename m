Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E1CAE343CA4
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 10:21:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229692AbhCVJVI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 22 Mar 2021 05:21:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229986AbhCVJUn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 22 Mar 2021 05:20:43 -0400
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A594C061574;
        Mon, 22 Mar 2021 02:20:43 -0700 (PDT)
Received: by mail-pf1-x431.google.com with SMTP id h3so10517732pfr.12;
        Mon, 22 Mar 2021 02:20:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=RVAz0+ouDuR21X4no2DnOhvrQl4rpka/BX2xvBQ+F5w=;
        b=FvgawQbPwtVVr3Uq6IHuMO6RbvHwe0YZe22hWPWjAqws8Gl7OdyBIISLwN4NYTDpP9
         uLigfy3zVc1VZtvmAqwgMGtOjHZKgJL3W4kVEb4vs70dRRWpJGjiiHcTQFXU5fiVlztj
         tKn3BXwideKw1iCIpS52QqdtGQOTlYZooSGv6YGTb+zmoPJwJU9pCuMVM9hKYJJqIcdq
         qFYl48bHaUp1IUNYjsSRKp1V1HdzN4FRPxncFYoW5tjQNgJXaqfc4sXULP+FH4mNzEWU
         ev2rxXoj4z5HSlLstUL1GPfTE3CQeu7qtdRbmSJm61Gqp9EaZVlv52f5PneluGLXupFI
         uZJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=RVAz0+ouDuR21X4no2DnOhvrQl4rpka/BX2xvBQ+F5w=;
        b=eWBaY1g8Q/NCPcmQ7F1hdPv8AQ41pf4ZxM+xkQkEsLbVs3vHWCkdNQHjBdJX2L7Ei+
         SKmj8bO2ae30/x4xjmsLKHYtov0Eec37uKK4qV9Gv2JwzgkKtwrBLNYcUK8NNj1GHaUg
         irnxZqCCZhp9wHE2joNFUEVf1QKP1bsdOnM/lcUNAReS5yUShTsZR86mmzY7A/HGAiD6
         y/6Dat/dOsEHMyBMAEJj0Nlkw/5lljIK7iLpIxB+t0NY1WmLxvQwUcxw/bC0Uhy/i7c5
         K4kZwcMPY+TtVyAJrJf6+LVWgcB0qcji6JEVcVvRz8Jyl5jN4G6ESnVzpN26+KpWpcZf
         UwfA==
X-Gm-Message-State: AOAM531JNxrr0Kc1aHSCaAASsxRmyD34wTcE2Q3Q2/kTu1dXLuQJP9hb
        uUYE7zOEqAunIF6tjPb1Zg/26enXVpM=
X-Google-Smtp-Source: ABdhPJwvmpEl9G6MVMadYbziq59DvMZYMc75NlvbL0UfcKpwg9X+b27EtwoyQEr7/uYusXMsWbGmEw==
X-Received: by 2002:a62:764c:0:b029:1ef:20d2:b44 with SMTP id r73-20020a62764c0000b02901ef20d20b44mr20287432pfc.45.1616404842970;
        Mon, 22 Mar 2021 02:20:42 -0700 (PDT)
Received: from ubt.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id w17sm11987756pfu.29.2021.03.22.02.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Mar 2021 02:20:42 -0700 (PDT)
From:   Chunyan Zhang <zhang.lyra@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        Hongtao Wu <wuht06@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        linux-kernel@vger.kernel.org, Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Chunyan Zhang <chunyan.zhang@unisoc.com>
Subject: [RESEND PATCH V6 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Mon, 22 Mar 2021 17:18:30 +0800
Message-Id: <20210322091831.662279-2-zhang.lyra@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210322091831.662279-1-zhang.lyra@gmail.com>
References: <20210322091831.662279-1-zhang.lyra@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe bindings for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
Signed-off-by: Chunyan Zhang <zhang.lyra@gmail.com>
---
 .../devicetree/bindings/pci/sprd-pcie.yaml    | 93 +++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
new file mode 100644
index 000000000000..ede06a80d24f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
@@ -0,0 +1,93 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/sprd-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: SoC PCIe Host Controller Device Tree Bindings
+
+maintainers:
+  - Hongtao Wu <billows.wu@unisoc.com>
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+properties:
+  compatible:
+    items:
+      - const: sprd,ums9520-pcie
+
+  reg:
+    minItems: 2
+    items:
+      - description: Controller control and status registers.
+      - description: PCIe configuration registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+
+  ranges:
+    maxItems: 2
+
+  num-lanes:
+    maximum: 1
+    description: Number of lanes to use for this port.
+
+  interrupts:
+    minItems: 1
+    description: Builtin MSI controller and PCIe host controller.
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  sprd,regmap-aon:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Phandle to the AON system controller node (to access the
+      AON_ACCESS_PCIE_EN register on ums9520).
+  sprd,regmap-pmu:
+    $ref: '/schemas/types.yaml#/definitions/phandle'
+    description:
+      Phandle to the PMU system controller node (to access the PERST_N_ASSERT
+      register on ums9520).
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - num-lanes
+  - ranges
+  - interrupts
+  - interrupt-names
+
+additionalProperties: true
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    ipa {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie0: pcie@2b100000 {
+            compatible = "sprd,ums9520-pcie";
+            reg = <0x0 0x2b100000 0x0 0x2000>,
+                  <0x2 0x00000000 0x0 0x2000>;
+            reg-names = "dbi", "config";
+            #address-cells = <3>;
+            #size-cells = <2>;
+            device_type = "pci";
+            ranges = <0x01000000 0x0 0x00000000 0x2 0x00002000 0x0 0x00010000>,
+                     <0x03000000 0x0 0x10000000 0x2 0x10000000 0x1 0xefffffff>;
+            num-lanes = <1>;
+            interrupts = <GIC_SPI 153 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi";
+
+            sprd,regmap-aon = <&aon_regs>;
+            sprd,regmap-pmu = <&pmu_regs>;
+        };
+    };
-- 
2.25.1

