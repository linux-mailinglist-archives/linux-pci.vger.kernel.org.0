Return-Path: <linux-pci+bounces-2574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D2C4383D68B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:37:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 804A9285B9D
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 09:37:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8A51A1420B7;
	Fri, 26 Jan 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="QtzAp0wF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f54.google.com (mail-wm1-f54.google.com [209.85.128.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6CC11141990
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 08:57:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259425; cv=none; b=G5l3ObZEA+dkAtzACHgI6i25OAY+GvIyGLdbSw78qoHqc7S0vCtnQWTnNXM+PZaqkwk1MeO015WsgkiKd8OJIt9+zNhJbJPM8YSYHffZ0mwJIKj06MUCc37M6tRFvr21xdsOVnHbWEInXC3G/f30sgqyqUEj0BD8i7h0RLu/UB4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259425; c=relaxed/simple;
	bh=DcOFAHWw57OZ+USGEw+XzihLlIieJcir1fqf4uIwPcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=aAVpuom3guGCk9LlpbNMTTaYwGPmWg5psvWLsksOI+qCUZSL6UZINziVm53Kwbp/+ZLittcrv7O6nhzEGRK6bbHSwXtVQv3g0gTFbnpA7iyTW+Kl3wsIMoQ6z56TuCwKgRzGr5c7x+Z3TK9Z3jAsH0mMko9NOlbdQqbt08dz7P4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=QtzAp0wF; arc=none smtp.client-ip=209.85.128.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f54.google.com with SMTP id 5b1f17b1804b1-40e7065b692so1805135e9.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 00:57:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259421; x=1706864221; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiqsI0Dmx9Laa0Xbfs3XWKEz2D4BJKsaR8JMAPM6FUQ=;
        b=QtzAp0wFOkAh0TX3nc4nbSDlHpT2aMYeMZVrQyO9eXcyBO/yUuI98fhTgDjkaoihj+
         dA0U//BCOKA1hSufqqZHXtGBK0yr0puTEy0e7LAO77pa5f0G8LVpnTFFu7PHMeA2g68u
         RQAqgunxVWWc/tUZxgfH/oKZs2R2FEsMlFuWGgzxeoQ8K9PIQfnw/ulvqSxAPc0SPHJx
         giam1d0RXRdZ8HmeueF92zz/LZF8nlyKnI7boI++s751/2C7WvDnYV/zC60gZJi+dER6
         x3Y1awlUsOUBve0tozf/X565Wc5k3k/gezGcPfUq75KCDjsHncYlsI8VH0OSQoRTfmz3
         l4Tg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259421; x=1706864221;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiqsI0Dmx9Laa0Xbfs3XWKEz2D4BJKsaR8JMAPM6FUQ=;
        b=YKsn2jEoMmtzf+cAbooaqc2NphJ/GJhndpVSRId5ShoYRjxssdMyp2EMLpwUgJPMn3
         xxaVTFGkdppcqk2R1OXKIh5wqrRNpEaJt1xoMgNFPdZHYjqRBRLS+M1rZyx+0Lt7cbXq
         XoXPof/hsBotDcmmPWpZ8yKspvYDhDEPZg8oI7WPeQFXNtHXOGizwXEEIOo0TRqMEXaN
         mkU4e3tDkPhMHXO7PpkTAsxzN4JCo+P3bw5SysMaBFUY4S5wABMrkYn8fDSiTkIg0HUw
         iuSdSqNonH8C5mUkORZgVfNmZIIiYFwIr+6lq7QvqasrlnxXcwA+r272O2WV7Kd3XdcR
         6dYw==
X-Gm-Message-State: AOJu0Yx6E76Eo4rKfCB2dYYbEq/Z2mG1vvuPFoBKszlHGNMedPX2egXJ
	QKf5UqjYR5ozhtp8p/PKDs5VDFj5XQzKoTcu8I2Ofhqjc1eIpFv6uABMIX7mczw=
X-Google-Smtp-Source: AGHT+IGu/OyLRplENoo4b3nG+aQ5WEj2ZdTj4NbJWvhaezABZYQmhTS/5hG3eo/PR176Zye3wwb6Uw==
X-Received: by 2002:a7b:c846:0:b0:40e:ce9e:fd00 with SMTP id c6-20020a7bc846000000b0040ece9efd00mr576153wml.167.1706259421652;
        Fri, 26 Jan 2024 00:57:01 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a31710c0d32sm390522ejz.203.2024.01.26.00.57.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:57:01 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 09:56:46 +0100
Subject: [PATCH v3 5/6] dt-bindings: PCI: qcom,pcie-sm8350: move SM8350 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dt-bindings-pci-qcom-split-v3-5-f23cda4d74c0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8894;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DcOFAHWw57OZ+USGEw+XzihLlIieJcir1fqf4uIwPcY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls3PSJftBHqe48kaAp0sLizKmDvNbpT1HPZXRM
 6NGK5VeLTOJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbNz0gAKCRDBN2bmhouD
 119OD/98jQ1yLgbl0mMrMm2A5nXm9/hU892DS58iB0jWuzpz228mxI6AXZlY9P/RW9JwnIkj8BP
 1oXWh4evym5TIoKFgp+PDR32d329gdR6Zb/ZVATnXAqQjd7eUHuvND1DR0atKBXxzHTuyqaIncV
 a2f3WCgztqlwAxNReP8pRdkg4VHClv4nCYy0rgwOCROg20Hf+R0Ib2ZmRIxRJ2FZLatNtBtwjgW
 bq4Y7MdR6Oprzy/ZgVUvcqBKePKNwvGAJO/lipROzb8IwOQv8RkcmU8q3M6qrNs+EA+/dsJHraR
 fj1DPgOrJ5KUKoJ7Jz1jdeVkVXOrzA2erifaC4mh4GzNjXGmznjAHYDJr8EcddJWQ3CfndWzuKj
 Aq+OkitujE45ctkPLRYbTPWMVmPFFw2RUAslYpfMzlkOz2+FEPUrqBhjEUHXENfNTdBOeAhhqDK
 QPBDTNXu9Z444MROKAO1OSQeOfG0bvsmj6DfkUuQI9FZoyzVOCulAgnybS2kHSh2Ot4AjOqZ92Y
 3OSnX/dL5nZjFYc+myBycqK+CgC98gE7JDEgzjWGSqehJ/mCK58H4nX/TUYHLJGhiaiXGgQMW/Q
 SyP/+COuk6Hq1jlBZ0sXJjMu0kx3DpPnsjLS0ObD27deazYr3BE/YQg0rsWvHPkodX8krof+s59
 2Jq7YGMLQ9lFrug==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8350 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting eight MSI interrupts, instead of only one, which was
   incomplete hardware description.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  | 184 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  32 ----
 2 files changed, 184 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
new file mode 100644
index 000000000000..9eb6e457b07f
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -0,0 +1,184 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8350.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8350 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8350 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-sm8350
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
+    maxItems: 9
+
+  clock-names:
+    minItems: 8
+    items:
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: tbu # PCIe TBU clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: aggre1 # Aggre NoC PCIe1 AXI clock
+      - const: aggre0 # Aggre NoC PCIe0 AXI clock
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
+oneOf:
+  - properties:
+      interrupts:
+        maxItems: 1
+      interrupt-names:
+        items:
+          - const: msi
+
+  - properties:
+      interrupts:
+        minItems: 8
+      interrupt-names:
+        items:
+          - const: msi0
+          - const: msi1
+          - const: msi2
+          - const: msi3
+          - const: msi4
+          - const: msi5
+          - const: msi6
+          - const: msi7
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sm8350.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8350.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8350";
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
+            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "tbu",
+                          "ddrss_sf_tbu",
+                          "aggre1",
+                          "aggre0";
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
+            iommu-map = <0x0 &apps_smmu 0x1c00 0x1>,
+                        <0x100 &apps_smmu 0x1c01 0x1>;
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
+            perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 47888b5b1a13..6e03a1bce5d4 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -35,7 +35,6 @@ properties:
           - qcom,pcie-sc8280xp
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
-          - qcom,pcie-sm8350
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
@@ -213,7 +212,6 @@ allOf:
               - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
               - qcom,pcie-sdx55
-              - qcom,pcie-sm8350
     then:
       properties:
         reg:
@@ -540,35 +538,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8350
-    then:
-      properties:
-        clocks:
-          minItems: 8
-          maxItems: 9
-        clock-names:
-          minItems: 8
-          items:
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: tbu # PCIe TBU clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: aggre1 # Aggre NoC PCIe1 AXI clock
-            - const: aggre0 # Aggre NoC PCIe0 AXI clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -701,7 +670,6 @@ allOf:
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
-              - qcom,pcie-sm8350
     then:
       oneOf:
         - properties:

-- 
2.34.1


