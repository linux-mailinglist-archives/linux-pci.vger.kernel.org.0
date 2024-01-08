Return-Path: <linux-pci+bounces-1823-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DE37F8270FE
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:21:11 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 38A97B227BC
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:21:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B29344643E;
	Mon,  8 Jan 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="ulg+YgN4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f48.google.com (mail-ed1-f48.google.com [209.85.208.48])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E063846424
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f48.google.com with SMTP id 4fb4d7f45d1cf-554fe147ddeso2117198a12.3
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 06:19:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723579; x=1705328379; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mMYVSsOQIqa0el4b7dJvhvf3UUspYxYiQhj5yhxNFQ0=;
        b=ulg+YgN4rV6WEd/ZPNLeV7rK9Qb/kTq8SWohy44CQCVRYQE8XoOQQVrPZGipVLMA/n
         eXdMxaVFYwOmn7BP97i/+9sLU0yRXctbbvJtz8UKr9+vJfw7BCjUT5Qy6YWtA0NhLtFo
         CWkAJrr460/UZ89bXh301RSHD7kIXSAJzTzsHCJ4aauzWgQXqR2qq0cJAots1sG8/MCm
         eLpePOgYuxX2pkn20tPtihB0zNPDlSFJZDr8eOShw4H4XbiZyWpKXqVbgFMsbWwhLFj9
         20Xnnrihu0SXd1WUMhIkpVusH2+Lw6VvFp/tmzRQ5HcegeaWxc/E/WwaNneY6rCitoHM
         31jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723579; x=1705328379;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mMYVSsOQIqa0el4b7dJvhvf3UUspYxYiQhj5yhxNFQ0=;
        b=h0/7pQ667bpl5i9Kib8Hr81kGwqqW94FZGa1y2LFB4pgf+SZx70CLRWf1U50cFUnwv
         OI/k98xsaBRIHy/efm7Tc+W176VnwIUNRth/Kelf6sp3wI9DSCZWBljamrOIG+5mGN7z
         31MXVKZj0Fntqy85V/NjpmfHRTiuLwaJllkAsjVw0MZl/5jJyAvONNvLzkjKne7z8jXs
         qxgOfUCAS4gUoTj72vBuaIlo3Y0Bu3dkfJ14v0YPz/KhUq6+bR/Z3EViLQJfeLrm3Gic
         I7VI2R2BJ7jwdQLrYskvxHcFfLRjU3vhPvT31u1tpLoNmpu6+yYBG5+tqCTH96AU1JR7
         byTg==
X-Gm-Message-State: AOJu0YwyuHqCo2Ni+ze25bEHHT479eg6YDlpaIslQP8SFait5h3/fGme
	YsJr2UHhBRilGxrr6uGNpCpxr3Sr874aAwM3gqwfXr9kxHs=
X-Google-Smtp-Source: AGHT+IGrgNFaoPrqUSkG9Oax5ackYDjZhZWCPgGBhRTwDsSxrmD5YWf3D9nrXohPJlBL/Gz5gra9LA==
X-Received: by 2002:aa7:df0c:0:b0:557:dd8:253c with SMTP id c12-20020aa7df0c000000b005570dd8253cmr1386080edy.1.1704723579367;
        Mon, 08 Jan 2024 06:19:39 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id cm25-20020a0564020c9900b00556ee10cfe3sm4319832edb.92.2024.01.08.06.19.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:19:38 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 08 Jan 2024 15:19:18 +0100
Subject: [PATCH 5/6] dt-bindings: PCI: qcom,pcie-sm8350: move SM8350 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-dt-bindings-pci-qcom-split-v1-5-d541f05f4de0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8406;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=YQxKIcZdGuD+BAZ0c00nt7v4FpqcshDqK8AOGuh0NqE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlnARvFt4yZVwodqFKCLZEr7QsVgu+mfV47Rm89
 pI/ha5TkXqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZZwEbwAKCRDBN2bmhouD
 13uWEACMcyfY6Dk/pAfsUECsQcBhVAYBJYcjVkc/t9lqe0OPfGDc0tNM1X/6XEGupxSgIjY+5QR
 Gz9kfR8L0yfNHJ8sZNk40ad7BSA0CS0U/f1zkdu1OYi2dOJgfcl+PUuj/d35jBwfl6utMuySwAN
 MJXwDhDPahLUT30sVYeDj6dIHvjOcLJ02KNwXOK8vEURYaJyXXGgZ2qdMzI0XcTYHL0ZdLmwOhH
 EHZa29frjTJCiONcVx1P/HHIKs20dWmpW7q5ltwgyAY01ZrerQpIObz1ypIzN5XymMw/WEudBno
 XITJfqBL4QlTMG3UP4ZbCbTV42JD4jKwKmBvBA+ZsrWtlOQm2t383Hsp44Ww278dgxGPoDk5w6z
 LphrJsqrN7L6wF35D6Q8Prf6HDe/S3DmRxGqqiIkhO553ByQogOREX5UoIjxglvTV/JITqHIhzW
 J4R+M3ZWAFmSi2oYOl2SSi3hw/ruzAmUCleSxEIftwQ4U1uzhQhIVzWL1xaIR2p+u1FjXTNQDBX
 NUMgyDzYBdv/q9SDnfrC/Lrc2FN+xZnUMZm4P4xxyd8vygsfyQFcUlnirt4DU2tHMSrs1fL+tAz
 sRMU0xdRVlcsUGvclqnRAccX0HSMZQlC+mElbdJS6+BEY3tNHLwT+IyGoNNTCoKTM21NxMFWrSa
 SrP1sXdNE33OLcg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8350 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except missing required compatible
which is actually redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8350.yaml  | 169 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  32 ----
 2 files changed, 169 insertions(+), 32 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
new file mode 100644
index 000000000000..fea41340b2c3
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8350.yaml
@@ -0,0 +1,169 @@
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


