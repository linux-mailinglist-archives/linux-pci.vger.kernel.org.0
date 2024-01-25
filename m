Return-Path: <linux-pci+bounces-2546-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 1396D83C313
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 14:04:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 388491C21DE8
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 13:04:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B808B50A95;
	Thu, 25 Jan 2024 13:04:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="SIS9fa1t"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D8BC50A7D
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187843; cv=none; b=eO9/S0Th1N7WWq9D0dY5bjp+kuRmaoU/Id3vWHVVXo6ohy0Coicq2sr473e6tLFuHgWZfjfrA06D/9kovn0TNl+l1zdV8QyEDSrluZDtvUW+yp9RLJ2m/FU3KrEAdAoQCG6F03NdLCiIyZKaCFwL/7UYZ2jl47JGEu5rPqC//Ho=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187843; c=relaxed/simple;
	bh=Fs0hqsceVE6tREsJFOaedH8nmI0CDFaCTGuwbMlpTHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=APzKzVirD2qBvW08gywuiPrK7QSNJSv9HZIbGaDadDVWtWOx5yZ+UXKBBUnSis4p9VaklDt2Py27lg3xf3d5wfVzhwRUVfD4H7gqXoFBDtJXDM18v8cioZLCYznGBeuTYc2PpgPdMtr+ieIfqvqBfxm/MzC21Dwr4Y75vIkle2w=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=SIS9fa1t; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-55a86795a3bso7166840a12.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 05:04:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187840; x=1706792640; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cwlGhuyqhoddA6J3pLRTYguRcB5mi1DcrMGcpwmQIA=;
        b=SIS9fa1tuf+HESum1E9Dh5zACY62UXY2+8bk2JesGjoQ3gD6w12iGWOSVf3qPHJLYo
         O2vcnBlWpqz2Mf2DjbpTrTG2D4cLAADQ3bnykGqhFIMpOITtY4eDs/fM+sySwsC6Wh0P
         6EBRikVaj7/5GdvWaGnj6+Sctf09hFXiVeWuJofWa8yqZ3w3+h01CwBroCsjDsaC8GqX
         pOtr4KRllExbWqEi0THcyNbVSFqrGhGlO70zNDYC4Gni02f3LAJpVKQXzk/N4KLVkNLg
         nGQWJltK2l4+6m6Y9XEQStj3BN0jVICVnAX8YY0EIYgzp07+AMfuIaFr1FGNvS5CiRiL
         IMuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187840; x=1706792640;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cwlGhuyqhoddA6J3pLRTYguRcB5mi1DcrMGcpwmQIA=;
        b=Rnm774Lg+18SK7nPKMmQO/xyAnd4mTEErm4VjOudnceShiF4M94IGA7b1YaRT/zCNv
         KPnsViU5DLdbcjw2np1JbaLhlyAGtrwWJwnnCi76cYyzaVnM16+EgbHcjAgIVLlfq4Rl
         C0h2/pr1vQyLmafuVbHOOSfWvSNPG7XcwaBz+Q68ivkixyqPN6BuTgWjfxOVyBGKa6kk
         Dtl4rAWNZXy1Hx0bVbehjKlXjbMMwWBCq7NftUVUlWtpzoPWf/j+PTndxfk3471Mu/h8
         sQFpF5BoFplgpDleBBGEt5xG/OyHvCVmy3o9j8KmNS39sp3XI5kWZ3YMTnXB9FO7u5ux
         I34g==
X-Gm-Message-State: AOJu0YzKu01BtItYdy4exm3pYFDwgY7GOLb4CY577bUnqSKrivF1pI6I
	GkTGURS4DbX4XvmjEe2HaU2c2A77XMo6VoyiDAFR1D+/iW/QMlPh3nuPybJTAAw=
X-Google-Smtp-Source: AGHT+IGInoMH0yZzpvX8Thf7z1XTPFLy44oKKovqayrplxJjfhd/PVTdMRTGo2DBQuytPEd+ecV21Q==
X-Received: by 2002:a17:907:c28b:b0:a31:8b4c:c6d2 with SMTP id tk11-20020a170907c28b00b00a318b4cc6d2mr291675ejc.173.1706187839971;
        Thu, 25 Jan 2024 05:03:59 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a31c5caa750sm294079ejc.177.2024.01.25.05.03.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:03:59 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jan 2024 14:03:26 +0100
Subject: [PATCH v2 3/6] dt-bindings: PCI: qcom,pcie-sm8250: move SM8250 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dt-bindings-pci-qcom-split-v2-3-6b58efd91a7a@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9618;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Fs0hqsceVE6tREsJFOaedH8nmI0CDFaCTGuwbMlpTHU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlslw0kCIu/egB7eh8Ejs6y5DCkGHWi66k4EV1P
 1N7yGLNbTGJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbJcNAAKCRDBN2bmhouD
 1524D/9JW4fNFbTETzoU3PGafU0cWM7v4bDz0fh+Iv0+aKuauusWAntjVbCT3ETbN63mDN5mx3p
 mMFObpa3bxuc1gbVFiTtR0+JNvEF4wy5xNHaGtOd0dE6RDfTFMlieroLb/MToOe7/KZHfDdP88Y
 eaXExpmi2mR5pzgCYLTlWFuYWJPjmBEVdVPR80UbXf9gOHUoe8GB2gD674AM9LkdR0XbdhX0F6R
 W0ZJtvD3UftXR7o1E2vMeQ7r00r8Vh2JuFg0oIaMcSlBgOXSxzwuB5jVIFR8AXUMjkycn5kYNGj
 RmY4sExzTEh/GyhzKUAItD39FlwcoQhry9P2jz1F35cmdYd9hNvrVJNKzQC8AnyTPZkIHNq5SP4
 ck0WslIUUvBFWyplxBbuHqCd7Xg4BtBgM26FHeiwt10HHu2vLlM1vw4rknCIa9YyyJfcq5nwGzS
 gSbysnpTzANGxvFRF78d8vqFQiXLZZc0cfUgLcbyjkGwJHgZAi6kiIcQnMRRezIcc2S4xkwIowF
 M/sSmlvSrGSaMzTLP45uiGZNVihgaXSE1VtiaclyihnDtQI0pjNtfo5LP7vs9v79sg8n5ag0GQv
 6XHEuMbW2JiFxKOxTZsoCBP0/74uHZoFJSjRFpLkCm6e4Fo3KEWyQJ5pWmS3NFeUXsGnAg0WU+M
 uPoZccwD5zF/1kg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8250 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting eight MSI interrupts, instead of only one, which was
   incomplete hardware description.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  | 173 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  48 ------
 2 files changed, 173 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
new file mode 100644
index 000000000000..4d060bce6f9d
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -0,0 +1,173 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8250.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8250 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8250 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-sm8250
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
+    # Unfortunately the "optional" ref clock is used in the middle of the list
+    oneOf:
+      - items:
+          - const: pipe # PIPE clock
+          - const: aux # Auxiliary clock
+          - const: cfg # Configuration clock
+          - const: bus_master # Master AXI clock
+          - const: bus_slave # Slave AXI clock
+          - const: slave_q2a # Slave Q2A clock
+          - const: ref # REFERENCE clock
+          - const: tbu # PCIe TBU clock
+          - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - items:
+          - const: pipe # PIPE clock
+          - const: aux # Auxiliary clock
+          - const: cfg # Configuration clock
+          - const: bus_master # Master AXI clock
+          - const: bus_slave # Slave AXI clock
+          - const: slave_q2a # Slave Q2A clock
+          - const: tbu # PCIe TBU clock
+          - const: ddrss_sf_tbu # PCIe SF TBU clock
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
+    #include <dt-bindings/clock/qcom,gcc-sm8250.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8250.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8250";
+            reg = <0 0x01c00000 0 0x3000>,
+                  <0 0x60000000 0 0xf1d>,
+                  <0 0x60000f20 0 0xa8>,
+                  <0 0x60001000 0 0x1000>,
+                  <0 0x60100000 0 0x100000>,
+                  <0 0x01c03000 0 0x1000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
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
+                     <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>;
+            clock-names = "pipe",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "tbu",
+                          "ddrss_sf_tbu";
+
+            dma-coherent;
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
+            perst-gpios = <&tlmm 79 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 81 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 791ddab8ddc7..14341d210063 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -36,7 +36,6 @@ properties:
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
           - qcom,pcie-sm8150
-          - qcom,pcie-sm8250
           - qcom,pcie-sm8350
       - items:
           - const: qcom,pcie-msm8998
@@ -215,7 +214,6 @@ allOf:
               - qcom,pcie-sc8180x
               - qcom,pcie-sc8280xp
               - qcom,pcie-sdx55
-              - qcom,pcie-sm8250
               - qcom,pcie-sm8350
     then:
       properties:
@@ -570,51 +568,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8250
-    then:
-      oneOf:
-          # Unfortunately the "optional" ref clock is used in the middle of the list
-        - properties:
-            clocks:
-              minItems: 9
-              maxItems: 9
-            clock-names:
-              items:
-                - const: pipe # PIPE clock
-                - const: aux # Auxiliary clock
-                - const: cfg # Configuration clock
-                - const: bus_master # Master AXI clock
-                - const: bus_slave # Slave AXI clock
-                - const: slave_q2a # Slave Q2A clock
-                - const: ref # REFERENCE clock
-                - const: tbu # PCIe TBU clock
-                - const: ddrss_sf_tbu # PCIe SF TBU clock
-        - properties:
-            clocks:
-              minItems: 8
-              maxItems: 8
-            clock-names:
-              items:
-                - const: pipe # PIPE clock
-                - const: aux # Auxiliary clock
-                - const: cfg # Configuration clock
-                - const: bus_master # Master AXI clock
-                - const: bus_slave # Slave AXI clock
-                - const: slave_q2a # Slave Q2A clock
-                - const: tbu # PCIe TBU clock
-                - const: ddrss_sf_tbu # PCIe SF TBU clock
-      properties:
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -777,7 +730,6 @@ allOf:
               - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
               - qcom,pcie-sm8150
-              - qcom,pcie-sm8250
               - qcom,pcie-sm8350
     then:
       oneOf:

-- 
2.34.1


