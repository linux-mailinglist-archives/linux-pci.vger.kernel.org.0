Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 494AD2E7F58
	for <lists+linux-pci@lfdr.de>; Thu, 31 Dec 2020 11:19:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726423AbgLaKTV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 31 Dec 2020 05:19:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726155AbgLaKTV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 31 Dec 2020 05:19:21 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7C2EC061575;
        Thu, 31 Dec 2020 02:18:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id i5so12905504pgo.1;
        Thu, 31 Dec 2020 02:18:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=wt9aTWsCxTK7BCW3efLWqM4G7L9tFvgWhfSlVEaResA=;
        b=fspu6YW/lHUq6ophkaJE7TRHExxHRWfEDUYUMRj5a4s2+pQQRpa9nEjW9mlx2TlayK
         zXpX4/J7dhktZJotqLAYGLd2y240jq2Y7z0e+5o1VPCXxFZIbRxt+9kevPafIzi9AuY7
         D+fSr1LoMLn8oLp96udArYLDe+DEvTRz8KSYTPbmJ0D08RatDNtc0gUhKEttodQYGA9V
         Z22sdm8c68Tk6OQjhNKxSv887MnH8Ua2Vg0OtOUgtGrGN0ANHNhenYjXliFqOs+vnXb/
         UzNDDrnb8/WsdJjBnKsLVdZykPhBxTFi5IiknrnqlZtjIt99x0bwgRAaY7FZfkbpUphD
         Lfrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=wt9aTWsCxTK7BCW3efLWqM4G7L9tFvgWhfSlVEaResA=;
        b=lSKDLYFF4nKF4A640D1HJZftJhM6+AE6mN4u+mPqO8BE9Knoyn+juv9tIzmSdP4Gr1
         4lXw+Gf3ELZhSiamJZUnGCTHMS9y4aRp5pdS92wReouNWFvlwQq2d+cSz+RLnOv1m4DC
         W6BVlffRVJH1ZQIrJavgom9/Rl6/4NV8M87Fgui+046E1ZJrCH0OpDuhgGX4ou+VzLZD
         Tjp8JX4u5L3HzNgH9Ti8DGGC2b+PFFwJKK618OYFdRp5dhWjuOnZgSguOcfJMQJ1CxXe
         QVvpKSzDgL/tNZBpreftg/ZpzN6UzrHEsfPxvyeOg0PVulg0Ohp3YTFhRv6EQNkcppFo
         1Aaw==
X-Gm-Message-State: AOAM532oqNNEUQiuWPbeepK1ZZ9ytyBM3jPdwKE+rNldQqoOYzsLxmTL
        bdDlyXKt5wAel11xkxk4r78=
X-Google-Smtp-Source: ABdhPJw5KXc3ZEYv5eTvl93pa6DdukkfZWQ7S9owJ3qhd5bekszmoRBHslBh11Nohgeq2eheG7iQPw==
X-Received: by 2002:a63:4d59:: with SMTP id n25mr37051821pgl.122.1609409920399;
        Thu, 31 Dec 2020 02:18:40 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id a141sm45470937pfa.189.2020.12.31.02.18.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 31 Dec 2020 02:18:39 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v5 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Thu, 31 Dec 2020 18:18:24 +0800
Message-Id: <1609409905-30721-2-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1609409905-30721-1-git-send-email-wuht06@gmail.com>
References: <1609409905-30721-1-git-send-email-wuht06@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe bindings for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Signed-off-by: Hongtao Wu <billows.wu@unisoc.com>
---
 .../devicetree/bindings/pci/sprd-pcie.yaml         | 93 ++++++++++++++++++++++
 1 file changed, 93 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/sprd-pcie.yaml

diff --git a/Documentation/devicetree/bindings/pci/sprd-pcie.yaml b/Documentation/devicetree/bindings/pci/sprd-pcie.yaml
new file mode 100644
index 0000000..ede06a8
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
2.7.4

