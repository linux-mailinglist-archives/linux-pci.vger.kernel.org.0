Return-Path: <linux-pci+bounces-2571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4C54E83D67B
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:36:05 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 710AB1C2928E
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 09:36:04 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 549DD14076C;
	Fri, 26 Jan 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="jJLZtqDG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4C19713EFF2
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 08:56:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259420; cv=none; b=nP0FyzW/ZLbs3ffkrzmk8I9cOKUq7U955DCwvdRCnq4LNy+aDld2XUNWRbjzUDdDiB1zympIYxLssyNsb0VHJSD05yGHDxtldL3Cxb/HSuFV9nx9gQRgUgN8NNWhSNKfie77Vek8zK+Rf5u6OGYvxJsWZPmTSSp8G7YJwOQaOw4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259420; c=relaxed/simple;
	bh=XhAcg0QYBx9ubfzmIVUUsWDWIxssYMoM0+StLqp8MFo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=f60g5DobDbDp8kK2N36rVwTLslXsJfOpgGA/ukaLmdZuBpGWP7qFuX+tmlA5ukz76QLCZk4AiqxFaU/seQptFigErXcZPnXeh2aVUg9Xr8ZyzA6xdmL5BFexY/ia5u4nXmdlbQHafW2GPe2hgSJ95sN/BBdXyZCijbvRt41arrE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=jJLZtqDG; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a350a021120so7456166b.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 00:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259416; x=1706864216; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=b/Hyf+ii2vngvt1+jF9pUc5XMJgEB9A2SXkhaKt2OpI=;
        b=jJLZtqDGdfTb1nWKVlhzl+somtXagBiLpT1jdQGAXIBl0L5BvGu5+dND6xH6zvEIV5
         FVhFrmh+6xjJR7jXdG5bb0k43YsQWpCATojMppjq1oZw139KKXX74umv3M6PLqi34gyW
         C/cyNBpwDfx8pQyGRy1ZjzJxTC0beDwsfGjyw9PQGYIwhurIh7LlRSMh+dr2TejgUHyH
         9ho+JtRaJDFuSnBaEmhNbDQpZ0e4yy3kJTiMVkqOKWAd6IZnyS3HN2wDXcSaz9MeFkYn
         riCY4MpBx7yW388YEhmOF70lWnQ9UXSJzDswCgyuai4OE5dl6U2+Rnu9s9xPFAKUVmtY
         OK2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259416; x=1706864216;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=b/Hyf+ii2vngvt1+jF9pUc5XMJgEB9A2SXkhaKt2OpI=;
        b=SBN7QypdEcR8FOu/cOmug1HZ89BAJwT2A0Sbuu2VFwxVgLUJq4EDFjL4PidRqn1wJr
         9752gJ/tQS0sn395uyr2ib9RF0QZ7hmeBjhbKacbmlJC90FYTP49VfYEeJyPOvF1fjwB
         g74D5k1f2M0uMUXMFmjFIa8h98/psb047dDPl4xTI3HHkQZlPIIyNAoEzczngGGv4NYZ
         RKE+CHBD72xPoe9FMG5N9UWZXuxrF6TcLMWcELzDpKJ+Bk/D/ZMtfmnfU6sc88Np+NXv
         qCRXyGzbQc60V4ijNF/I1gmMuHiejufnj1LmljtlltA9HgtuF11twPD6Q2lmaEvba4/r
         Plog==
X-Gm-Message-State: AOJu0YwrQ9IgEEJKU7pubj8t2W9rPRS6m/0+9QeUolybwYBtJjt5cVbL
	9+TMR3GRxu3DsKzN3mQx0p8h4JKJ/Ik7opkfgpaC/1b8j0fsLO2URok6K5ofjtc=
X-Google-Smtp-Source: AGHT+IFdB6ifMXjUATF1ESfEGoJYFnCdA5+uvFdBWAzebUhLMG5ntvzJ7a6i6Q6VA+l8tidNqQKQEQ==
X-Received: by 2002:a17:906:f758:b0:a30:ab56:b5c9 with SMTP id jp24-20020a170906f75800b00a30ab56b5c9mr496823ejb.54.1706259416526;
        Fri, 26 Jan 2024 00:56:56 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a31710c0d32sm390522ejz.203.2024.01.26.00.56.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:56:56 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 09:56:43 +0100
Subject: [PATCH v3 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dt-bindings-pci-qcom-split-v3-2-f23cda4d74c0@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10285;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=XhAcg0QYBx9ubfzmIVUUsWDWIxssYMoM0+StLqp8MFo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls3PPbgZqZZcGY9YAdNTNcKr+q15dRfflfBDfB
 sDXLh7NnCuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbNzzwAKCRDBN2bmhouD
 17GOD/9Q/49S6jJJ5aPSrpruHbRABpI1Ozq9xE9oxLe9lWR8rsv24GyquKoQaZm6mQnk9IgK5UL
 LuCYxsU2qemIWlqeRqqGKn7Y7oA896J1Q1x0u+LNQTRFlknU9muhhMhkIwPvk24UA68UtX7Omc4
 3Gu7LXAz6U/aJI3WgW9E79FUL7cGarzq94WaM6Dj5oyQZitPgbTG/PoCKVzLLBzhYYkurt1AgPv
 0NtcGmrZ4QP0WjcvnQ7GSJASCe0HH1dUbHmUaz6K/tCXbxrBRRuoWRDP+5Sdi4haGDofL+Oi3k3
 3iNed8PSX9JU/8uboqlt5MO7n29bVDxbTnQYsttYJbIAMxzLopvdi52WdiNOUCvEZz1WzspiLqh
 x6IssMUb2sChwXr6u/udXAqEPGsKI8S3wp7L/gQNWVIsPiTRLev4DscnkRuUKlL++dhB19wz47z
 bxc6+/AUCKq6hq+tl9O/FmI7Cns+j2xpb8T0ymwAZCvxepq5EJxjAD+46bxv/2zqOYGA+FdKkL4
 m6NJyDsc+CWXLllqKYb2Pvh6A73IC6SHW/u2C50rJ+u64MlzUmfOQFZzE2dScRmEikKVZozYdGm
 kOsexBwhfyBvStQC6HYkDg8qSqCkxkqH+3/UFGM50GOcqy0XyN0MseZjPbg1LOY/MRI9z/Q/ibO
 7i8Qs8+JVSPE6vA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8450 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting eight MSI interrupts, instead of only one, which was
   incomplete hardware description.

Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 178 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  67 --------
 2 files changed, 178 insertions(+), 67 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
new file mode 100644
index 000000000000..1496d6993ab4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -0,0 +1,178 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8450.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8450 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8450 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-sm8450-pcie0
+      - qcom,pcie-sm8450-pcie1
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
+    minItems: 11
+    maxItems: 12
+
+  clock-names:
+    minItems: 11
+    items:
+      - const: pipe # PIPE clock
+      - const: pipe_mux # PIPE MUX
+      - const: phy_pipe # PIPE output clock
+      - const: ref # REFERENCE clock
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - enum: [aggre0, aggre1] # Aggre NoC PCIe0/1 AXI clock
+      - const: aggre1 # Aggre NoC PCIe1 AXI clock
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
+    #include <dt-bindings/clock/qcom,gcc-sm8450.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8450.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8450-pcie0";
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
+            max-link-speed = <2>;
+            num-lanes = <1>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+                     <&gcc GCC_PCIE_0_PIPE_CLK_SRC>,
+                     <&pcie0_phy>,
+                     <&rpmhcc RPMH_CXO_CLK>,
+                     <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_0_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_1_AXI_CLK>;
+            clock-names = "pipe",
+                          "pipe_mux",
+                          "phy_pipe",
+                          "ref",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ddrss_sf_tbu",
+                          "aggre0",
+                          "aggre1";
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
+            interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+            msi-map = <0x0 &gic_its 0x5981 0x1>,
+                      <0x100 &gic_its 0x5980 0x1>;
+            msi-map-mask = <0xff00>;
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
index 3b7dd9a4ef60..791ddab8ddc7 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -38,8 +38,6 @@ properties:
           - qcom,pcie-sm8150
           - qcom,pcie-sm8250
           - qcom,pcie-sm8350
-          - qcom,pcie-sm8450-pcie0
-          - qcom,pcie-sm8450-pcie1
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
@@ -219,8 +217,6 @@ allOf:
               - qcom,pcie-sdx55
               - qcom,pcie-sm8250
               - qcom,pcie-sm8350
-              - qcom,pcie-sm8450-pcie0
-              - qcom,pcie-sm8450-pcie1
     then:
       properties:
         reg:
@@ -648,67 +644,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8450-pcie0
-    then:
-      properties:
-        clocks:
-          minItems: 12
-          maxItems: 12
-        clock-names:
-          items:
-            - const: pipe # PIPE clock
-            - const: pipe_mux # PIPE MUX
-            - const: phy_pipe # PIPE output clock
-            - const: ref # REFERENCE clock
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: aggre0 # Aggre NoC PCIe0 AXI clock
-            - const: aggre1 # Aggre NoC PCIe1 AXI clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8450-pcie1
-    then:
-      properties:
-        clocks:
-          minItems: 11
-          maxItems: 11
-        clock-names:
-          items:
-            - const: pipe # PIPE clock
-            - const: pipe_mux # PIPE MUX
-            - const: phy_pipe # PIPE output clock
-            - const: ref # REFERENCE clock
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: aggre1 # Aggre NoC PCIe1 AXI clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -844,8 +779,6 @@ allOf:
               - qcom,pcie-sm8150
               - qcom,pcie-sm8250
               - qcom,pcie-sm8350
-              - qcom,pcie-sm8450-pcie0
-              - qcom,pcie-sm8450-pcie1
     then:
       oneOf:
         - properties:

-- 
2.34.1


