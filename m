Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9B2632F5C6C
	for <lists+linux-pci@lfdr.de>; Thu, 14 Jan 2021 09:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727871AbhANIaW (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 14 Jan 2021 03:30:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727798AbhANIaV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 14 Jan 2021 03:30:21 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B6CAC061794;
        Thu, 14 Jan 2021 00:29:40 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id m5so2795518pjv.5;
        Thu, 14 Jan 2021 00:29:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05AmlfmDIoBOsgbfG+BqCROfcf8sceP8v0pN3rtYaqg=;
        b=ZDA9ySBuUS+e89o0UOM9AtNf2hBsFknewM2IcYRxuwLOM8fNyXRhdgcBk7yvKL6rwF
         Hk+wtOq6+BxEW1o9joyyid0ewYWGi55+N3bfdOtkhH7T32Dp+nLsKREQyi/xHPLzpes+
         z+zpuAIicv4uUJA2m/IsWv9gEiKu9WXI1uMIF6ZNrbzY5TIeXFgtwKVqZ7g3PJtKG+UK
         8PzHDwRESjY2Lv9u6MtRifEHeF3SU10LGFM3NDbd+/R2FOIfy0I7pvPtsDp0J4GCdTND
         fPoCfJicRE6Rruvfx6JgH0MtcLpkyk7PXMUNsQgPJgbP4kOJzvaKw9jLWPizCPbkWZYR
         Z3qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05AmlfmDIoBOsgbfG+BqCROfcf8sceP8v0pN3rtYaqg=;
        b=TnEgljSBvN2W+in8+/Vvlf5DE/mudoWanGGNEUCa3HEQ7K+3AYkIjQKuA5q392wiqx
         OoFZoYGxeceA/5dDmDe67h7mJDlVLvkY+wneJV2hvXABCS1MDmkz8hM6pmoXsPCcYVbX
         rvqP3nqJkvkZ5XzzwhDUGULZfNPpm1bx4QRndX37yGDNupsvRQQOKgXqUrAk9CmUKUmV
         Ng3tNRrtfrbunY3esLxVZO/jnbcbSMTbixWxeOAOK9nc0PWFdsy/Lvmca0wtqlsP91Uw
         HiCG9L+bk2L7tk358umiVY73h3rfHWpPla7vdzmDcpxEMs+D6BlgX0Yux0uKBZFSStSg
         v6Ng==
X-Gm-Message-State: AOAM5303XHP+W17I3xJsYq5Oh8+d3cZWwxHXDVhHCuffxT6VbXy0G7Ca
        hB3KU4zbPx2Mc7teuXnWv0E=
X-Google-Smtp-Source: ABdhPJwPj3vfztE9bA5Dkgo+Fj/BtR9lUnSb2CHgkR+X3ZGleu9nsY5yFVSNpVy9A7bwPyyXailfhA==
X-Received: by 2002:a17:90a:4e47:: with SMTP id t7mr3998943pjl.13.1610612980262;
        Thu, 14 Jan 2021 00:29:40 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id x22sm4776888pfc.19.2021.01.14.00.29.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 00:29:39 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [RESEND PATCH v5 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Thu, 14 Jan 2021 16:29:27 +0800
Message-Id: <1610612968-26612-2-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
References: <1610612968-26612-1-git-send-email-wuht06@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

From: Hongtao Wu <billows.wu@unisoc.com>

This series adds PCIe bindings for Unisoc SoCs.
This controller is based on DesignWare PCIe IP.

Reviewed-by: Rob Herring <robh@kernel.org>
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

