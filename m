Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3704F3B2889
	for <lists+linux-pci@lfdr.de>; Thu, 24 Jun 2021 09:26:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231567AbhFXH2P (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 24 Jun 2021 03:28:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbhFXH2O (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 24 Jun 2021 03:28:14 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67866C061760
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 00:25:56 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t13so3979928pgu.11
        for <linux-pci@vger.kernel.org>; Thu, 24 Jun 2021 00:25:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lk4v2x/QqDg9VeTcKEZY8wInplQhrFZZd/r+aGJnAFE=;
        b=lfu5YojMQmTHg3gKbBaPNCodpOHG+crgoh1W87Qqgd1bef2YmU+vyoXa619lt/HQWt
         X6tedtfe/oxIG/7AD277TrVM2HuXMC6IgFqqbvGvi3DKzF7Sz2qKkG1xVwi83VbhDkfc
         sgGzPrlCCOjg4+iaxz+eBQnvSP0rpf+kCyDFdXZyKLb4vKsJhOAXKUeAHHSkD2qGwQWa
         9QcjVMgr2P6YeD3y1jSs7GrT0KS1BYLII/7M9IhrH9njIApm3paW4FQPvXbdiz/QUZ2c
         lCCRLXFE14FrmrdZMa3iMrii1B+mdoFNmMZpXRRw0yyrGv+s1h/q6hS/hmF5qrVOamnt
         tsoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lk4v2x/QqDg9VeTcKEZY8wInplQhrFZZd/r+aGJnAFE=;
        b=URkSz4lwjWFNkhVja3X3IfOQiSkeEn57aDp27wokixy7tHmRlG7jQhYjCIuPKrDdl6
         uGsi8NSzud+N0EnNHqrOJfc+IYw+5zEgvNxdVdB3YDl+ljRrGtLmVZm/bX2wFbUsFIUS
         t2N4qYprUMJ39JK6UkfS2tgyJPaQMfv/d1fDTFUh5DHSdco2X6kmHDy4/FzDoQblNmpw
         oYz/Raf4+qNQnGowi4T7jmIXGDCZDrrimPy12/8ubVc1RkbgBJWVeS1C0n2AWS/uvONg
         jxJ+A8/9eZ5Qc3Czwjwn7jEpkph9Nwr1t9oK9+IXgNVCSTzMXKZpjXZLw+kwtAvLF9uC
         dwwg==
X-Gm-Message-State: AOAM531dK4YIZHZO8CDIG/V5nvo5QBeFNgOT5GhUp4Bo6eZKVlKQMAbV
        JE2979Tq38I/2gT2DyrpWr4E
X-Google-Smtp-Source: ABdhPJyNgYIow+mv3H1MDcm7lN61OKCztTkl9gdR8yqK03Xqpq2UfaWpFQKOedeWDhpan1pGZcoAyA==
X-Received: by 2002:a65:610c:: with SMTP id z12mr3570736pgu.453.1624519555883;
        Thu, 24 Jun 2021 00:25:55 -0700 (PDT)
Received: from localhost.localdomain ([120.138.12.173])
        by smtp.gmail.com with ESMTPSA id g13sm1923802pfv.65.2021.06.24.00.25.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 24 Jun 2021 00:25:55 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, smohanad@codeaurora.org,
        bjorn.andersson@linaro.org, sallenki@codeaurora.org,
        skananth@codeaurora.org, vpernami@codeaurora.org,
        vbadigan@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 1/3] dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP controller
Date:   Thu, 24 Jun 2021 12:55:32 +0530
Message-Id: <20210624072534.21191-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210624072534.21191-1-manivannan.sadhasivam@linaro.org>
References: <20210624072534.21191-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree binding for Qualcomm PCIe EP controller used in platforms
like SDX55. The EP controller is based on the Designware core with
Qualcomm specific wrappers.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 160 ++++++++++++++++++
 1 file changed, 160 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
new file mode 100644
index 000000000000..9110d33809cd
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -0,0 +1,160 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PCIe Endpoint Controller binding
+
+maintainers:
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+allOf:
+  - $ref: "pci-ep.yaml#"
+
+properties:
+  compatible:
+    const: qcom,sdx55-pcie-ep
+
+  reg:
+    items:
+      - description: Qualcomm specific PARF configuration registers
+      - description: Designware PCIe registers
+      - description: External local bus interface registers
+      - description: Address Translation Unit (ATU) registers
+      - description: Memory region used to map remote RC address space
+      - description: BAR memory region
+
+  reg-names:
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: atu
+      - const: addr_space
+      - const: mmio
+
+  clocks:
+    items:
+      - description: PCIe Auxiliary clock
+      - description: PCIe CFG AHB clock
+      - description: PCIe Master AXI clock
+      - description: PCIe Slave AXI clock
+      - description: PCIe Slave Q2A AXI clock
+      - description: PCIe Sleep clock
+      - description: PCIe Reference clock
+
+  clock-names:
+    items:
+      - const: aux
+      - const: cfg
+      - const: bus_master
+      - const: bus_slave
+      - const: slave_q2a
+      - const: sleep
+      - const: ref
+
+  qcom,perst-regs:
+    description: Reference to a syscon representing TCSR followed by the two
+                 offsets within syscon for Perst enable and Perst separation
+                 enable registers
+    $ref: "/schemas/types.yaml#/definitions/phandle-array"
+    items:
+      minItems: 3
+      maxItems: 3
+
+  interrupts:
+    items:
+      - description: PCIe Global interrupt
+      - description: PCIe Doorbell interrupt
+
+  interrupt-names:
+    items:
+      - const: global
+      - const: doorbell
+
+  reset-gpios:
+    description: GPIO that is being used as PERST# input signal
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO that is being used as WAKE# output signal
+    maxItems: 1
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: core
+
+  power-domains:
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pciephy
+
+  num-lanes:
+    default: 2
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - qcom,perst-regs
+  - interrupts
+  - interrupt-names
+  - reset-gpios
+  - resets
+  - reset-names
+  - power-domains
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sdx55.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    pcie_ep: pcie-ep@40000000 {
+        compatible = "qcom,sdx55-pcie-ep";
+        reg = <0x01c00000 0x3000>,
+              <0x40000000 0xf1d>,
+              <0x40000f20 0xc8>,
+              <0x40001000 0x1000>,
+              <0x40002000 0x1000>,
+              <0x01c03000 0x3000>;
+        reg-names = "parf", "dbi", "elbi", "atu", "addr_space",
+                    "mmio";
+
+        clocks = <&gcc GCC_PCIE_AUX_CLK>,
+             <&gcc GCC_PCIE_CFG_AHB_CLK>,
+             <&gcc GCC_PCIE_MSTR_AXI_CLK>,
+             <&gcc GCC_PCIE_SLV_AXI_CLK>,
+             <&gcc GCC_PCIE_SLV_Q2A_AXI_CLK>,
+             <&gcc GCC_PCIE_SLEEP_CLK>,
+             <&gcc GCC_PCIE_0_CLKREF_CLK>;
+        clock-names = "aux", "cfg", "bus_master", "bus_slave",
+                      "slave_q2a", "sleep", "ref";
+
+        qcom,perst-regs = <&tcsr 0xb258 0xb270>;
+
+        interrupts = <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>,
+        	     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "global", "doorbell";
+        reset-gpios = <&tlmm 57 GPIO_ACTIVE_HIGH>;
+        wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+        resets = <&gcc GCC_PCIE_BCR>;
+        reset-names = "core";
+        power-domains = <&gcc PCIE_GDSC>;
+        phys = <&pcie0_lane>;
+        phy-names = "pciephy";
+        max-link-speed = <3>;
+        num-lanes = <2>;
+
+        status = "disabled";
+    };
-- 
2.25.1

