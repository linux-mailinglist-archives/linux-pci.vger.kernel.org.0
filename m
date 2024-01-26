Return-Path: <linux-pci+bounces-2573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8F05783D683
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:36:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0636F1F2BF28
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 09:36:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D4DE9141999;
	Fri, 26 Jan 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ycnxTktm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f51.google.com (mail-wm1-f51.google.com [209.85.128.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B416A14078D
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 08:57:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259423; cv=none; b=MWAxOMqFDnois+i0zVqc8QO3CN7rr7GHmKxeDXx2fSM9rJQBmAmIzFQ3noZWFYUhu3bLNfDm4t1NA8dGHY9TcZ8OmmTAI92oHOZCHzVJniIpS+aC4jjBhssd01DlUEffMFZbhnLXPYAAsKOtLsxFsnYJd2E5JZXWwarxsfCvnMI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259423; c=relaxed/simple;
	bh=L2tu3oVaNutiUYx1lhf/hq1yv4Gzm5YHggLrHFEaVTI=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Y+JL4Tq3ZIC5r13aiLwovqHnRY5YZPg+DU/eaf3R/BEZtaEgll8pADZTawrvmameUbQ1TW92akkyhVmXNy3DTYYriJSediHGU4Tl7BHoYtApUr8Do/erz1r27aNqaN0A2NFRvPoP81m6pBHZdqO27voHPDrBDPAs6D3yRYU2BZA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=ycnxTktm; arc=none smtp.client-ip=209.85.128.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f51.google.com with SMTP id 5b1f17b1804b1-40ec6a002a7so2247265e9.2
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 00:57:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259420; x=1706864220; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yb0WcvqtQcLyXdbtPa/dVBnzAG+9fpalgiYlCkLzkns=;
        b=ycnxTktmRKgPPj5TAZ32nfLvK1Kiww6C9gEaG8i55AcGaz4JVq1JHKQMmU+0CMAJ0p
         kCB80j95kAV+g1x6SRrCPd0OlmsDN6mpDQoWCUNIT209bvhTI7n/7Ir0IGiT0H4YjSzp
         hS97ACRb1Vybv2lEDnnntyuG7Bfl/2uOgfb0kgsU3EpBOzcn9p8WKFobj9uHtbLQETg4
         mWtQmX82f3/1BgGxf3E2w1uejutfjjkpm1H/V07XLhQG3wbRa8pNDSLJZG9ImqT+D0MW
         nPPSGy423g2CWIaF9/NAhOM0kzwB0vu82kCFtC4IecUq7fFvwOlnUxO59nOh4FWzX4CW
         wAzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259420; x=1706864220;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yb0WcvqtQcLyXdbtPa/dVBnzAG+9fpalgiYlCkLzkns=;
        b=iBhH43+PabxhY4AAQ+HEFFSBdKRri9+1peR0YpKKqaM3M+j55kry4EmSOd9Qh2dq9d
         ED+c7qXu2BxyeFQzRd329s1CFf37JvNoLc2Py7+2YLnIAaov7pj3Zm+RQ7Ys4B1jg+cX
         r1W7CqMoIOCAt3X0DPXyYWh4GdwxaW5orfpEY0ASI9oQvn039R6PLlmly4mjrAWV0+n1
         0Amv5++CkF5RDK+cn8YIzAbvdAX6QLwSS9ahufbuoAYFGpVjO+B77pJTAVSHjpNq8bVo
         wJfPuKdGB9lDEvTtvaWZlEiMGEKVOEY3rn05sldbJVw4/QAL3cXKY/St6pNl6o8/TUmM
         X+lw==
X-Gm-Message-State: AOJu0YwG0LURH3rBzigZV6jJv/O2lxSNVX42lkM7uXNOc8tcP2RJ5jx1
	hZs658Z6hN2CLc/F1/h83eZLtr0mt5WzmJPqRiRLBKjeK2271viQ4MBEugPQ13I=
X-Google-Smtp-Source: AGHT+IFXvKY7olw7KYjmnP4Ff66b4uPAlX1lK5/9TIk5oumoUXZuOdLj8CbaWC/jOtNQCMmALW7ywA==
X-Received: by 2002:a05:600c:1f12:b0:40e:db62:9129 with SMTP id bd18-20020a05600c1f1200b0040edb629129mr229793wmb.271.1706259419990;
        Fri, 26 Jan 2024 00:56:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a31710c0d32sm390522ejz.203.2024.01.26.00.56.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:56:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 09:56:45 +0100
Subject: [PATCH v3 4/6] dt-bindings: PCI: qcom,pcie-sm8150: move SM8150 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dt-bindings-pci-qcom-split-v3-4-f23cda4d74c0@linaro.org>
References: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
In-Reply-To: <20240126-dt-bindings-pci-qcom-split-v3-0-f23cda4d74c0@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Rob Herring <robh+dt@kernel.org>, Conor Dooley <conor+dt@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Rob Herring <robh@kernel.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=7937;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=L2tu3oVaNutiUYx1lhf/hq1yv4Gzm5YHggLrHFEaVTI=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls3PRn9rL81jv3m2XlYtmwskwYmtXrBa/iFCFC
 hAYAQaZaxCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbNz0QAKCRDBN2bmhouD
 15w+D/9T3l4ySDrrXzZsnVYLZE/HhHiGox0wZEC1xtgipMToR/15hMkEI/Ujq0lACINSYiVBex6
 Oc/eIXLD7oVE4KSi2V+D8/WJ90A8Jqy0jBkNljNXwYzs+0HkYslVh2BlL3rqPI+0tLmJ8CcxXP8
 aJkOlEatOfUCy42nEyQxDPvEI/HTGySVKL/RUH67WMtF7Mh7r51JUtsTj9PKYV9gXEXY62OsTvY
 zP33JvG0VA7drEFGNbIPOyvLuRHtKjy2/8OGl42N5txEcaUnd/Q4kICEix5aDnkHFEbdoIeeiKD
 Pf+rvWteQQVmQAR/LJCaERjG1YVRUiYtUkeZYO8IFlffyV25fTwFZZYry8PnYpxlbmNh61L8UW1
 YXf5zkT/iBE3N4M5JHaJbqMZE2v6ieUCBXZ6EFnOouijh6BbPU9xuW1LtK4LCnEfWmIDSMesedO
 wdDRcaU1TUXqucoGJuSpJQM5bxARCVJE2cHKWIqrYr9aciP1Hkx3Y3Py3wJVXs5tSauFbMQX8cY
 Wb/SdWK9iYteplPMuPGDqNxl78VDdBBYLdvFzxzvInhA6JwbOZcC4BSzlJcckc8sdFYfWcuKK4Y
 ZucJRNfjBiAKygPyLMfGJL03y3KXnfTF1u923f3UpWgHnvjx8xh+w3Il0njvxQIZb+Ag5zwuI7X
 Zl+c3U1VXzILXJQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8150 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting eight MSI interrupts, instead of only one, which was
   incomplete hardware description.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 158 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  29 ----
 2 files changed, 158 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
new file mode 100644
index 000000000000..9d569644fda9
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -0,0 +1,158 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8150 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8150 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-sm8150
+
+  reg:
+    minItems: 5
+    maxItems: 6
+
+  reg-names:
+    minItems: 5
+    items:
+      - const: parf # Qualcomm specific registers
+      - const: dbi # DesignWare PCIe registers
+      - const: elbi # External local bus interface registers
+      - const: atu # ATU address space
+      - const: config # PCIe configuration space
+      - const: mhi # MHI registers
+
+  clocks:
+    minItems: 8
+    maxItems: 8
+
+  clock-names:
+    items:
+      - const: pipe # PIPE clock
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: tbu # PCIe TBU clock
+      - const: ref # REFERENCE clock
+
+  interrupts:
+    minItems: 8
+    maxItems: 8
+
+  interrupt-names:
+    items:
+      - const: msi0
+      - const: msi1
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8150.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8150";
+            reg = <0 0x01c00000 0 0x3000>,
+                  <0 0x60000000 0 0xf1d>,
+                  <0 0x60000f20 0 0xa8>,
+                  <0 0x60001000 0 0x1000>,
+                  <0 0x60100000 0 0x100000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <0>;
+            num-lanes = <1>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+                     <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+                     <&rpmhcc RPMH_CXO_CLK>;
+            clock-names = "pipe",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "tbu",
+                          "ref";
+
+            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3",
+                              "msi4", "msi5", "msi6", "msi7";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            iommu-map = <0x0 &apps_smmu 0x1d80 0x1>,
+                        <0x100 &apps_smmu 0x1d81 0x1>;
+
+            phys = <&pcie0_phy>;
+            phy-names = "pciephy";
+
+            pinctrl-0 = <&pcie0_default_state>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc PCIE_0_GDSC>;
+
+            resets = <&gcc GCC_PCIE_0_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+            wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 14341d210063..47888b5b1a13 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -35,7 +35,6 @@ properties:
           - qcom,pcie-sc8280xp
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
-          - qcom,pcie-sm8150
           - qcom,pcie-sm8350
       - items:
           - const: qcom,pcie-msm8998
@@ -541,33 +540,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8150
-    then:
-      properties:
-        clocks:
-          minItems: 8
-          maxItems: 8
-        clock-names:
-          items:
-            - const: pipe # PIPE clock
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: tbu # PCIe TBU clock
-            - const: ref # REFERENCE clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -729,7 +701,6 @@ allOf:
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
-              - qcom,pcie-sm8150
               - qcom,pcie-sm8350
     then:
       oneOf:

-- 
2.34.1


