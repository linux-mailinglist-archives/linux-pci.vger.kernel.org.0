Return-Path: <linux-pci+bounces-2548-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6473283C31C
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 14:05:19 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 135C029000E
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 13:05:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 713D955771;
	Thu, 25 Jan 2024 13:04:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="dcNIkmL7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f43.google.com (mail-ej1-f43.google.com [209.85.218.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 409ED524A4
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 13:04:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187848; cv=none; b=tV8Vj4iI6fbf6U6xU1ZSQS8B/+EKOPkHA6YDW1hPTwbFec2SVoFYSc6sRw9/7z+MCDnZcmAOIyEkUGJlRRL48bX0vOw8NojzKvVmmYDIsMe92wiO8lTlgjYbgHsasS4Mlf5Iu98jngcUxqp4gSXCPgG3GfnYn417w/k93Kq/Tc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187848; c=relaxed/simple;
	bh=DcOFAHWw57OZ+USGEw+XzihLlIieJcir1fqf4uIwPcY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=g5MrDF30Q/cMc140vofuWVS6tukaERo0WhteGQR81HEBc7AxO21t2mfdZTAyU9dCecwQvcepJ4gkuUBmbi3jy52fyAA+Ae89sj44UJ51FF/UDuRt8QL02uGQds85X9Uq7rt6UdaVtUWnyJ+1Ntj3zZkJKkLgZb90T+E/bi1Zc9k=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=dcNIkmL7; arc=none smtp.client-ip=209.85.218.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f43.google.com with SMTP id a640c23a62f3a-a298accc440so738600166b.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 05:04:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187844; x=1706792644; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NiqsI0Dmx9Laa0Xbfs3XWKEz2D4BJKsaR8JMAPM6FUQ=;
        b=dcNIkmL7A6aFfVuH4ADLsXslm3k6Nb1zR2ocWpv40wC00DuEXhUQlfHXbDrHcTa3cU
         js5IzMUYUPeOoMvMJ1KKJbO1DrxxbVyBFl4O87FaBStSW3rVsfouUT7COaCPdJwPBk8l
         EKfaqJ7fUFfQSUqUEPVbpMsBSnCq4fXAgRbjmrdw3hBxVr4ZyDAix4aYX9URDpLQPe9c
         /LvmeFk4MCyuQf4O3LFqDEdJ7lqIGmUA7FLmQ8V71uSn4JavDJmZSwGl05we5sNgV1+L
         z5FaWcP3hxX8734kw5CPMuR2/nRh44pT9UphhrGga67Weq2Mx4QK+XGQ9WiUCm+La8+r
         oZMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187844; x=1706792644;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=NiqsI0Dmx9Laa0Xbfs3XWKEz2D4BJKsaR8JMAPM6FUQ=;
        b=KFNR9AdNbcFDgVb0Qddu14Vfl82H9yTbHnMcbaKRuW8xDTEIw/ZVpoIm6KIL3AG4fR
         9b9+sefXGDUIgnfInX+zytvxUkhirrobpN9kESqyKl7FG/cvdEl/+dKhWS2KwXjey65M
         6JPIGjBjUlhOVVkGYrj0g1ENtJyp+7yxvGwijKDuWXyDQtalR4iWUITc6cBqcQFKx2fR
         7oxQ6LaY2ZGcfm8DFFGIfX8PiA3AWXVKbBTtRNdjPHYsTrsYYqv5CzqVQi3l9qBG8487
         Zv0O8jT9Qqc2dwlKKuGJvss//G9Y2EAmh0PIhLTRJWvmAY8brWyDdily7Bln49ObtP2v
         poIA==
X-Gm-Message-State: AOJu0Yy7gNXQ+IVi76XSQABjWr4UN/VheS5cqRf1img4w7m+QjHpQC75
	5nzhizXdl9RwTU0BAq+OxYmYbGX2V+CrjSdQsUk9ROsKr85rbc6ytHAtJEl+5+8=
X-Google-Smtp-Source: AGHT+IFUvTM5m592yKicQ3s/A0fwsx85MTpgBhTZS2fdGg2fGPTF9QSzP2yBZRvItX+AZMGZvGIxuQ==
X-Received: by 2002:a17:906:e2ce:b0:a31:6be0:b9f with SMTP id gr14-20020a170906e2ce00b00a316be00b9fmr688457ejb.74.1706187844443;
        Thu, 25 Jan 2024 05:04:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a31c5caa750sm294079ejc.177.2024.01.25.05.04.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:04:04 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jan 2024 14:03:28 +0100
Subject: [PATCH v2 5/6] dt-bindings: PCI: qcom,pcie-sm8350: move SM8350 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dt-bindings-pci-qcom-split-v2-5-6b58efd91a7a@linaro.org>
References: <20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org>
In-Reply-To: <20240125-dt-bindings-pci-qcom-split-v2-0-6b58efd91a7a@linaro.org>
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
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlslw1OjFtoDrk+JZg/0xa6/zLbkqt3DhIk73GF
 plbKXxNA2CJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbJcNQAKCRDBN2bmhouD
 10RZD/9Skhtd+ZgQomiax6Tqh8P4bBU1e4xmEnN8RtVq7F/EUVhFyCYjSOVVCiwKII8DloRDeJy
 AELdoMhq2OG47lsVdBC9IJ71nevaCMe2ICFonUyrCs/z4UUXrcbfiQtAbKobQZYLJ+JbFaxc+k9
 Kql3J88cz95w3EQHhkag2yVSgzdRHZSkgcFGmIsNDh5LJuGdozyBeuuZlAT7uPyOn4PaGcW1A4d
 7bFT3/E4O7l08rFSNVdCyiG+d9xT7DAdFIVWlkgxwusluGuktyc0JMXHnglHL6JVlxrwfohLDOx
 1zCxg4DGgGnlv8AYM5mmz2rW0QQeSisK6TwyAXpMh03UNkqpILbrbddurxmBwkzMhNEavQDMmMu
 kD5vVAbtYdfUNcq27YpVzVVg3BUt2G8gwZd2HmUugwQSvY0IBmCyntMg/y6Pmu3Yuh8SeFJb7J2
 WUxD7f4sr0wZh2/ZgFhK0F0Aud2KpmhRRV8CGyt4reXOfNXsBH7+XzhDaBzM2Be9JMhdDyQe57+
 A40UWAsfdMM8xzBqS0pSRvFn0sdPh1TPKonRszaYgcKxDS+WuMkLwvBGwcWX6uz27nz5i8HYhZY
 x/8yB5j4Ob6aihZ/aI5rfgcRrODnndcV3T6yHoS62wZIUctBVSE0DSGhk/zDNG680nMYQfivgB9
 8ikV9CzxcPgxrew==
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


