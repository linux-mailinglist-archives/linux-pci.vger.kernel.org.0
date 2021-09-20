Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 692B8410FBB
	for <lists+linux-pci@lfdr.de>; Mon, 20 Sep 2021 09:00:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233583AbhITHBc (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 20 Sep 2021 03:01:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233550AbhITHBb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 20 Sep 2021 03:01:31 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADA2C0613D3
        for <linux-pci@vger.kernel.org>; Mon, 20 Sep 2021 00:00:03 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id il14-20020a17090b164e00b0019c7a7c362dso6803083pjb.0
        for <linux-pci@vger.kernel.org>; Mon, 20 Sep 2021 00:00:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89MYR2GbpP7RSf1Uoz2RwOf98cs9Vdc1/9C+MIGzrAw=;
        b=sPH2uCBSvIry7nqywujOjqt2c5Ip3OIQrCMqZysZogKlAIes1V4A/bGNrVYNjbavRY
         yrxgsLy4MUZ9GK85cLEoE7YxpljPsYvW1fI3u5BCoLguSsnK9SiJtlmIzPBud1rYgsWs
         8zJprxl0tn48a16uQXCDJPNZ2KeD9YEdk9nJGm/d01bYcB+gGVxLfcR725kivhGb/Qbh
         2oT5yNob8gikM8X81fw4aY4TC5m8fRz7m/OhGNS+lt7PFCKv4gEPePn+ncx6K7tilmx1
         kt8qeFRjKMiStYd/LMxvK1exdmFWytfKTqV8m/zQHgHvteZgbcQYLjy2bl5UCoJqFVIg
         M1kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89MYR2GbpP7RSf1Uoz2RwOf98cs9Vdc1/9C+MIGzrAw=;
        b=InELIZdw4O/OPlu5fNmwDhcyjkwwRJOhsWCe8HEkI9Dn3y5wqudCklvz267oOBHNrg
         LGpf1gz+GnR3J7nM6RdwUc+tMj0k+98HLixDRHTiVK/ClVz8JH6w+ZFkfM3jKf6PxBex
         vGpq9N3kgOsmuNKlZDhVyMzr6gzMGzLoMBqHykJ3BdV23vwrXPr8T+j63MSpOfUmRyoW
         hdEHwPCYTjTdhQcn3YS6+LkOaYcS11x/gQ5iyAFpNHRHBwe5L3w1wkYc5L0Iv31T9Y8o
         vMXv8VfHnzqpoX1EkB48oFiCX2xtgRLZQfbHZw84Q1xZET4tLPe076kiwuYeKgOkE2A1
         NIkw==
X-Gm-Message-State: AOAM533Rue90qQky4aT68NFdi1R2lqRjamN0ggUIe84d3FYOcoUy+SDW
        QT/fzEVENUaIpU156luDacU1
X-Google-Smtp-Source: ABdhPJzK98Uifv5h2TltL3AdAjog7S8WE3O09h5yHSFvPqwoqdE1LK5FGPFzFpr1Zj8ieVLB0XZmKQ==
X-Received: by 2002:a17:90a:bd08:: with SMTP id y8mr27342920pjr.123.1632121202677;
        Mon, 20 Sep 2021 00:00:02 -0700 (PDT)
Received: from localhost.localdomain ([59.92.98.104])
        by smtp.gmail.com with ESMTPSA id p15sm12768349pff.194.2021.09.19.23.59.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Sep 2021 00:00:02 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     kishon@ti.com, lorenzo.pieralisi@arm.com, bhelgaas@google.com,
        robh@kernel.org
Cc:     devicetree@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        hemantk@codeaurora.org, bjorn.andersson@linaro.org,
        sallenki@codeaurora.org, skananth@codeaurora.org,
        vpernami@codeaurora.org, vbadigan@codeaurora.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v8 1/3] dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP controller
Date:   Mon, 20 Sep 2021 12:29:44 +0530
Message-Id: <20210920065946.15090-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
References: <20210920065946.15090-1-manivannan.sadhasivam@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

Add devicetree binding for Qualcomm PCIe EP controller used in platforms
like SDX55. The EP controller is based on the Designware core with
Qualcomm specific wrappers.

Reviewed-by: Rob Herring <robh@kernel.org>
Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ep.yaml | 158 ++++++++++++++++++
 1 file changed, 158 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
new file mode 100644
index 000000000000..9fe6d1cef767
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
@@ -0,0 +1,158 @@
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
+                     <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "global", "doorbell";
+        reset-gpios = <&tlmm 57 GPIO_ACTIVE_LOW>;
+        wake-gpios = <&tlmm 53 GPIO_ACTIVE_LOW>;
+        resets = <&gcc GCC_PCIE_BCR>;
+        reset-names = "core";
+        power-domains = <&gcc PCIE_GDSC>;
+        phys = <&pcie0_lane>;
+        phy-names = "pciephy";
+        max-link-speed = <3>;
+        num-lanes = <2>;
+    };
-- 
2.25.1

