Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5467F2F72B5
	for <lists+linux-pci@lfdr.de>; Fri, 15 Jan 2021 07:06:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727064AbhAOGFs (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Jan 2021 01:05:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbhAOGFr (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Jan 2021 01:05:47 -0500
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B268EC061757;
        Thu, 14 Jan 2021 22:05:06 -0800 (PST)
Received: by mail-pl1-x62c.google.com with SMTP id t6so4172123plq.1;
        Thu, 14 Jan 2021 22:05:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=05AmlfmDIoBOsgbfG+BqCROfcf8sceP8v0pN3rtYaqg=;
        b=ow9nSh96sLyJQ867tn5TQGbfYoPk+94JEqUSsXxAbZcAncM2YzFYPs0nkgF2sZ1ewy
         S19Zc+EClFf7TpFN70bJfM2ikOuSqDACq4WNQAjD0zefmJVg6WwGllTLfBe77EH5uKYI
         tGcNbH9dAWfSFm0xT/jwpP4pNa8I0do7hJHSpYqoJSwgoC7GKUAdcdQMdze5I1fkUe5V
         OHjxUEeZ5pzwNzPLyInu11gEUXMKFW+ReiCGq8imzjYG2/cHigMJ05Layb5uFRYay31O
         +hdWbTVwo71ikhyrgeqqSn5bQSoQi6PjKNIRKIiOJE1LUo5xqIOEMKjHdMUUdNb70pYI
         XYsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=05AmlfmDIoBOsgbfG+BqCROfcf8sceP8v0pN3rtYaqg=;
        b=D4n+4CS93SZO6y8Gb02o7/qznol/Sq5+E+NJ5GC8arDOmJXgKLGi45KrOscCRXrHTd
         bjSME/nMY9cSHQxRxFRM7vcaIuqv+DaN2v5uCFgCppR9z0JOSFhesMQBCOtKRG3djWb4
         fAltWtRacVKaNeRodcU+k15LRxx1OE1C5pM8wrHJ2pRd0AesQhewUCKT8nP0llp836i9
         WC3WG/NlGHzT5Tgn4C3jnb+ZzelIDMwWZVhgIP7E+xhDzxBFsNyy2B0bVuQfK6S03toX
         6kJ487BLWTm6zTdcGWNTscPA92Bl22R55rz7lf98+xBw+DZvLLqV8w9rRrsD+sCYPRaR
         zxmg==
X-Gm-Message-State: AOAM5333MqsWLH/g5wbZot3MHXPAxVbdDnVxbbj//n5LAR0z6Ckub/JV
        vw5I7h+6czBGDYfW+xSwXU/xtscx9oY=
X-Google-Smtp-Source: ABdhPJyVuXc8XUPxX37sEHSxqkexGcYLSqQNP62MIwK9rCXtAORAFsg9Aleps1tEdi3PaceazrFGIA==
X-Received: by 2002:a17:90b:2282:: with SMTP id kx2mr8653055pjb.77.1610690706282;
        Thu, 14 Jan 2021 22:05:06 -0800 (PST)
Received: from sh05419pcu.spreadtrum.com ([117.18.48.82])
        by smtp.gmail.com with ESMTPSA id t5sm7051929pjr.22.2021.01.14.22.05.01
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 14 Jan 2021 22:05:05 -0800 (PST)
From:   Hongtao Wu <wuht06@gmail.com>
To:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang7@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Hongtao Wu <billows.wu@unisoc.com>
Subject: [PATCH v6 1/2] dt-bindings: PCI: sprd: Document Unisoc PCIe RC host controller
Date:   Fri, 15 Jan 2021 14:04:39 +0800
Message-Id: <1610690680-28493-2-git-send-email-wuht06@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1610690680-28493-1-git-send-email-wuht06@gmail.com>
References: <1610690680-28493-1-git-send-email-wuht06@gmail.com>
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

