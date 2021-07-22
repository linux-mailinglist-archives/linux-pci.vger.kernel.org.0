Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 209723D2321
	for <lists+linux-pci@lfdr.de>; Thu, 22 Jul 2021 14:13:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231828AbhGVLce (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 22 Jul 2021 07:32:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbhGVLcb (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 22 Jul 2021 07:32:31 -0400
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D575C061760
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 05:13:06 -0700 (PDT)
Received: by mail-pj1-x102e.google.com with SMTP id x13-20020a17090a46cdb0290175cf22899cso5209607pjg.2
        for <linux-pci@vger.kernel.org>; Thu, 22 Jul 2021 05:13:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=89MYR2GbpP7RSf1Uoz2RwOf98cs9Vdc1/9C+MIGzrAw=;
        b=Be+8ExobKhAmvk4cR8KzCeZZXYhNd2EUsa8KBNUyThuXbvHCDblKmvkqKQYrEdC/Uz
         oDxssZdiIKDof1ra6gIUfvOXLxSm31nKSGVscjHaH3xnOXvxJSAdsso6SJjClDcybdRR
         bznS6bVkGpupm3G7CAGuVFMR7/MU41W5wxlOdG8BP389+HGTwvVPyuClyzUBve+8dMRh
         Djq2JsXWgI2B3HkD55u+Bn/tl69S8B04w+/akgxE6GD2WgIuU+Gz3DGy1hCs1TPcMWJT
         3iRYXRIHJaPo3+3wHzCNwSblzPCYlQUihw3Jar3QsH2F27kGpYJN6JSB9eJx2yqYBIFS
         vgWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=89MYR2GbpP7RSf1Uoz2RwOf98cs9Vdc1/9C+MIGzrAw=;
        b=MGus2yPWypNKHwxPdoS8UAcESQ+cBBc0AULkydYtoshxk0sdFhjw2axmHgYkuTpYwA
         KK3w4lucO6caPIFMy4Pp6Iw5dmchdP7lVsuLlDZT8598wtngcPMxc2Dr9LrfPYsLrRpd
         Kcf4Zg8VYxM5NqxXJVsnJSPOC5um+OPDl74zXxE3iqMKjH3A0Sc/mjZqM9nMyoTp+D5y
         ahPrMkZfsDyxkiJvdsCXoaDk0x6/1oTYL8HEbzWnxbVE1BUpD0oM77odNvuuxRT4M8m0
         R2+flmsvy8bd9Ucsx4nJ1i9tJT7b7lq6h0DX/cj1q29u3VL1XqVAV0xvOFxNobxxdMfq
         H/WQ==
X-Gm-Message-State: AOAM532uBr7ec8hCp/FmT/mMlAYzkZRdKFnlpJApN1KOpaCypPtgHLB3
        tcUj4TbNy/SS6VERXFnLpZMG
X-Google-Smtp-Source: ABdhPJxkwcJTAhnNTd+X6qBda2XjawFGefpOArtbBE/DtHXchfIbSPSIABMFsmvTHKaMJa7AIngamg==
X-Received: by 2002:a17:90a:de16:: with SMTP id m22mr8720281pjv.38.1626955986070;
        Thu, 22 Jul 2021 05:13:06 -0700 (PDT)
Received: from localhost.localdomain ([120.138.13.30])
        by smtp.gmail.com with ESMTPSA id cp6sm2913846pjb.17.2021.07.22.05.13.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 22 Jul 2021 05:13:05 -0700 (PDT)
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
Subject: [PATCH v7 1/3] dt-bindings: pci: Add devicetree binding for Qualcomm PCIe EP controller
Date:   Thu, 22 Jul 2021 17:42:40 +0530
Message-Id: <20210722121242.47838-2-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
References: <20210722121242.47838-1-manivannan.sadhasivam@linaro.org>
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

