Return-Path: <linux-pci+bounces-1819-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 1DF248270EB
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:19:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 878C31F232DF
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:19:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA48246BA0;
	Mon,  8 Jan 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SzZADC1E"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f50.google.com (mail-ed1-f50.google.com [209.85.208.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BE5894777C
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 14:19:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f50.google.com with SMTP id 4fb4d7f45d1cf-55753dc5cf0so2179407a12.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 06:19:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723572; x=1705328372; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Tk8GMEH2iDgp9+UcEh38jMqbbPsEGwY6PJWrF1vIMYc=;
        b=SzZADC1Ettq4Doq8F9twzSawnQGxLL7hd7kPOzdEZ7uyehBUSaKPruafMbIXgAsgwA
         Jc0JseD7f1p3BCHv07fftIJI3tW/7sp1chNvOrquF2FaFcxpGNFC4SJd4ka1S1LxXkyJ
         IyTueYyE4JPyJXfJ4XkobqSrb4anRAZiHoI4VNsntG6AMezRmfo7gUUojkqK9mDTGw03
         EqHFYIqsqan+Bz+QQzC1jUcU9LlJX3s1pzplVPXBwy4ozew3zW2dLxKa7jIbvv9hCMtx
         gYK02+kgUUUvoB8Io2KHcXhZBxAiobHXQ/qIxhTjbj2NCuyfb/ZTiaBa1S7DkChVdMe/
         z+tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723572; x=1705328372;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Tk8GMEH2iDgp9+UcEh38jMqbbPsEGwY6PJWrF1vIMYc=;
        b=HiGORA+dyzjDdwSAC5qwGzeNzg3UOC+20M8SPIsIjjx+C3LzHgu7JaYC+9fiUTZguJ
         ZKdW3UGgFOC82JDxnS6XHFa/PPgTmGYWljypYG8d9cQXjykAS4XhfW4+erpjnmsoKa7r
         ABKR/cLYZ2WJfHA9qS9oF9IxTjCAoZMHdqqSRBr1/F7+HNn0zlA5CGi6zm4gyhtP0GL1
         MqjCm5LRW6CFtKYw/1U6e4ybsMVxySdOQaJh7yeqHB6WE0EBfGMjTgHJMnMNh10MEjSE
         hQzdLqP8HE7zLoOcDWtGL+Nrjh9JcipURqSUfQpOQY/ucCXBrFFKsIsQ3ebfNmfu97kn
         acnA==
X-Gm-Message-State: AOJu0YywrIj5M5TRR/5zKp0vZdAgMSJqXMjhlRL7GBrnNdBSRQWyBRTL
	gO5P5oRp6TuAHLUwrKtjhGjrzJVh2Ai9/w==
X-Google-Smtp-Source: AGHT+IEP1+7nubU1S6k3PB+PGx8xMcpRq2jDDpjENbnqKpbbbZ8f4SsdkUXllSfRjzc6bAeM/fDmdg==
X-Received: by 2002:a05:6402:1495:b0:557:5162:4ffb with SMTP id e21-20020a056402149500b0055751624ffbmr1902788edv.50.1704723572106;
        Mon, 08 Jan 2024 06:19:32 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id cm25-20020a0564020c9900b00556ee10cfe3sm4319832edb.92.2024.01.08.06.19.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:19:31 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 08 Jan 2024 15:19:14 +0100
Subject: [PATCH 1/6] dt-bindings: PCI: qcom,pcie-sm8550: move SM8550 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-dt-bindings-pci-qcom-split-v1-1-d541f05f4de0@linaro.org>
References: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
In-Reply-To: <20240108-dt-bindings-pci-qcom-split-v1-0-d541f05f4de0@linaro.org>
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
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10959;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=DpJSGu2wnJYHtYBQ7iL7qyP67ihLXzxaqzTmEpv8wfo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlnARrKyEbA+zAgkx0eM2qKj+/X6ebGbdWdu8YY
 ZxwKqEUtm6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZZwEawAKCRDBN2bmhouD
 10LQD/wMDQRJKaZFLCGuKhbyRMJY0bSlIt6e+Gyzig9d6dQf4dsBawT0ngZz32BC7eHINlTz4ej
 LNf4NxdW0dCrV5VfVxL2nbTh8YOZFvZlyQ92xUJ6ixF2fJF/Vzb/a/eJ2eJY/0rasFbZw5lSVdB
 PKHFiGx4znaPeRbR+p3IRPfTlI8BvVz4Z4+qfTgHbaRlLWdMZp2mtCClrDYY5iD+fth0uUBKudI
 mh0KM2QdUa3kVMZwkG1vaJX2gWaaQvDlvOlQDIH1SEqDBYjgJYGdZDbbdSlVMSxkl3CJs3CQZPZ
 BbQE/1as+C3od+i+/C7YAFpM+Zc/PdPDoXkoLZj9tlLALFybInYt+sYTOlhhhzTrntr8fFSSceX
 v7LTVbrIA8avQiacQYiVGVmWh0LRxaF77Ph0F7PJv51zXRQc0YSMQswodT9kvFT9pq7nv4u1snC
 yylBpyguAREI5XVtENDvreR3hfGlLm8GLAxQrRiUX9rs7C7kUnbRyrXbIYTEWpeulZb1hDDfrV1
 SFsnWLqQNKpZ7irSjhVf4unvzDX7iyodUJ5W7XlGsYyr/N1G4n0ED1x2D2i6MJwh/UN1IdxAawF
 CsjEGJgneD11EyH6kad4sXBeg4L6E2GUunt+54eOK9VkbQiOX0LligseI3nELiztgs+Oh2wo6nC
 d54iN5Tmxa4P2XA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

The qcom,pcie.yaml binding file containing all possible Qualcomm SoC
PCIe root complexes gets quite complicated with numerous if:then:
conditions customizing clocks, interrupts, regs and resets.  Adding and
reviewing new devices is difficult, so simplify it by having shared
common binding and file with only one group of compatible devices:

1. Copy all common qcom,pcie.yaml properties (so everything except
   supplies) to a new shared qcom,pcie-common.yaml schema.
2. Move SM8550 PCIe compatible devices to dedicated binding file.

This creates equivalent SM8550 schema file, except missing required
compatible which is actually redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-common.yaml  |  98 ++++++++++++
 .../devicetree/bindings/pci/qcom,pcie-sm8550.yaml  | 171 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  38 -----
 3 files changed, 269 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
new file mode 100644
index 000000000000..125136176f93
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-common.yaml
@@ -0,0 +1,98 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm PCI Express Root Complex Common Properties
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+properties:
+  reg:
+    minItems: 4
+    maxItems: 6
+
+  reg-names:
+    minItems: 4
+    maxItems: 6
+
+  interrupts:
+    minItems: 1
+    maxItems: 8
+
+  interrupt-names:
+    minItems: 1
+    maxItems: 8
+
+  iommu-map:
+    minItems: 1
+    maxItems: 16
+
+  clocks:
+    minItems: 3
+    maxItems: 13
+
+  clock-names:
+    minItems: 3
+    maxItems: 13
+
+  dma-coherent: true
+
+  interconnects:
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: pcie-mem
+      - const: cpu-pcie
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    items:
+      - const: pciephy
+
+  power-domains:
+    maxItems: 1
+
+  resets:
+    minItems: 1
+    maxItems: 12
+
+  reset-names:
+    minItems: 1
+    maxItems: 12
+
+  perst-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO controlled connection to WAKE# signal
+    maxItems: 1
+
+required:
+  - reg
+  - reg-names
+  - interrupt-map-mask
+  - interrupt-map
+  - clocks
+  - clock-names
+
+anyOf:
+  - required:
+      - interrupts
+      - interrupt-names
+      - "#interrupt-cells"
+  - required:
+      - msi-map
+      - msi-map-mask
+
+allOf:
+  - $ref: /schemas/pci/pci-bus.yaml#
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
new file mode 100644
index 000000000000..b6d025f153bc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8550.yaml
@@ -0,0 +1,171 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8550.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8550 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8550 SoC (and compatible) PCIe root complex controller is based on
+  the Synopsys DesignWare PCIe IP.
+
+properties:
+  compatible:
+    oneOf:
+      - const: qcom,pcie-sm8550
+      - items:
+          - enum:
+              - qcom,pcie-sm8650
+          - const: qcom,pcie-sm8550
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
+    minItems: 7
+    maxItems: 8
+
+  clock-names:
+    minItems: 7
+    items:
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: noc_aggr # Aggre NoC PCIe AXI clock
+      - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
+
+  resets:
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: pci # PCIe core reset
+      - const: link_down # PCIe link down reset
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
+    #include <dt-bindings/clock/qcom,sm8550-gcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8550-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8550";
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
+            num-lanes = <2>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_QTB_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ddrss_sf_tbu",
+                          "noc_aggr";
+
+            dma-coherent;
+
+            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            interconnects = <&pcie_noc MASTER_PCIE_0 0 &mc_virt SLAVE_EBI1 0>,
+                            <&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_0 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
+                        <0x100 &apps_smmu 0x1401 0x1>;
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
index a93ab3b54066..3b7dd9a4ef60 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -40,11 +40,6 @@ properties:
           - qcom,pcie-sm8350
           - qcom,pcie-sm8450-pcie0
           - qcom,pcie-sm8450-pcie1
-          - qcom,pcie-sm8550
-      - items:
-          - enum:
-              - qcom,pcie-sm8650
-          - const: qcom,pcie-sm8550
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
@@ -226,7 +221,6 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
-              - qcom,pcie-sm8550
     then:
       properties:
         reg:
@@ -715,37 +709,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8550
-    then:
-      properties:
-        clocks:
-          minItems: 7
-          maxItems: 8
-        clock-names:
-          minItems: 7
-          items:
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: noc_aggr # Aggre NoC PCIe AXI clock
-            - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
-        resets:
-          minItems: 1
-          maxItems: 2
-        reset-names:
-          minItems: 1
-          items:
-            - const: pci # PCIe core reset
-            - const: link_down # PCIe link down reset
-
   - if:
       properties:
         compatible:
@@ -883,7 +846,6 @@ allOf:
               - qcom,pcie-sm8350
               - qcom,pcie-sm8450-pcie0
               - qcom,pcie-sm8450-pcie1
-              - qcom,pcie-sm8550
     then:
       oneOf:
         - properties:

-- 
2.34.1


