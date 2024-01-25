Return-Path: <linux-pci+bounces-2545-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7C36783C30D
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 14:04:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 9C71B1C235A3
	for <lists+linux-pci@lfdr.de>; Thu, 25 Jan 2024 13:04:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 786EB50A69;
	Thu, 25 Jan 2024 13:04:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="vJMFKqZs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f54.google.com (mail-ed1-f54.google.com [209.85.208.54])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5FEEF4F89C
	for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 13:03:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.54
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706187841; cv=none; b=fWnG3ahUUEx9LojFZLkGwK5/fE8mbfOBc1uUUizkpkynnMzuMrSDGpNoa1BnA7bft+jel/udXenfRYDQcEEXiV7OtDfjepJndqqMeh1/ryNaBvc+QAeeyUqwu/ihV9ufWTMOxGT6FsPCysjcvzv7/MF40pKun0JCRVuG5P5L1vA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706187841; c=relaxed/simple;
	bh=Q/Tocvh9EXB7maJsWvrdsfs89mbAIyPguSmeuPPim+M=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=KnST6cxq+HTYWpJdyMVyrqusZua5pMntJSC8x5WmcQ6hsUx17PBnnCFmfCl8EiI5jJydbQJ/QXsZRlacjHVNBBrqWyAjKUrIN/bky4smnX2IA5RYGnlqUgm0ZhlEx6pnroofruL4TZNuBFE5lXKvcW03mwSJVBAaFX8M6HgGB9I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=vJMFKqZs; arc=none smtp.client-ip=209.85.208.54
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f54.google.com with SMTP id 4fb4d7f45d1cf-55a90b2b554so5549965a12.1
        for <linux-pci@vger.kernel.org>; Thu, 25 Jan 2024 05:03:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706187838; x=1706792638; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6M//4gavqKqAX98RMN/hrCVHrhUbgeSamdA2/agqIGQ=;
        b=vJMFKqZszgm8mKeHqVGDXjoOwVv1VmlaKQITx2H+qjUPyPhwcGXzCUCKaXWgUS4aRb
         ij/RC6Kp4Ry4GdqikNJ2fcr4sDamhBQdyRzgbNMn9mtdIAh7jDVTj3Wr+VpbrLN8nfUZ
         IDTEyBd7X6cXQPkzDohlb2iA2Oy+/ZjXmFmWgk02c9/rlOsKZXqMKcL0MThhLNqYNMdG
         fgSie+TDyRyycYrHbb/7pczYZfi1gai1LOwwmmNh4WPSA5vBksfNdSTwc4eh8q78NLt3
         SB5lQphagAovC4WpCfEQ8QxlxFdTL0PxqNESUEmICwB8iHJ3d+QINYxTU6k7E3eCiQQr
         TX3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706187838; x=1706792638;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6M//4gavqKqAX98RMN/hrCVHrhUbgeSamdA2/agqIGQ=;
        b=bDxTHeTenM6a+4lxCTp+tfezhWtGcQq+af7j1DcfalIwbGRvISdo8rXtiZMXlvM9we
         bWwZdGfGA4pIMF0SAJHxOweuHRO/H+/S3AALNnsk9m2G68Wt/nqHD+EiBnSapHZCxJyE
         Cn5XRRUkiLAcTxqttYJWuBzAXc4zFi7zNYxugv6LUJNYGAoeicaiDUA8VH2I/vt1hR2B
         W/pdOlIldQLyH4XSuK6sNDoGweGlyok24hznG//uVhIa+Oli3UabWzWHOKFEI7xh5j76
         bMDrTpiMsEKUGaWbetvIm1n+EiYObm8l6WbDSz+2NumaKIfO4w4/THpVkXC0J9sQwPBb
         6MNg==
X-Gm-Message-State: AOJu0YzYYlsPoKh3fPY9FyZFG2iwef44bw0s9jSRhEENmrdtAJ3uCcLm
	ZmiSIRelF1CNSzwZ5+CSs6N/oWFJnz6syf1H8Jtja50Wnetyngp9wBuGbNVDNW8=
X-Google-Smtp-Source: AGHT+IHRSECyVnPsASGjX1hHcootr6LAKKl1InX+5g7JuJp+LYMsXeYYCRlRcpvNoBGLaHbbfGMPOg==
X-Received: by 2002:a17:907:367:b0:a30:858f:6186 with SMTP id rs7-20020a170907036700b00a30858f6186mr641050ejb.40.1706187837612;
        Thu, 25 Jan 2024 05:03:57 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id tx24-20020a1709078e9800b00a31c5caa750sm294079ejc.177.2024.01.25.05.03.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 25 Jan 2024 05:03:57 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Thu, 25 Jan 2024 14:03:25 +0100
Subject: [PATCH v2 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240125-dt-bindings-pci-qcom-split-v2-2-6b58efd91a7a@linaro.org>
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
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.4
X-Developer-Signature: v=1; a=openpgp-sha256; l=10238;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Q/Tocvh9EXB7maJsWvrdsfs89mbAIyPguSmeuPPim+M=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlslwz/cJqG2zI6+Fs5qEAiFV1ABSwCkcUCuge4
 5GM0X0YF9SJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbJcMwAKCRDBN2bmhouD
 1w2LD/4t+JHejnCaPLlOEidnLW7DDEzOBUwqxU7uXvw/mVC7E6c6wgMrnXrnlOtcxgCN+nXNzFR
 xqsA/HL2kJ0WO3yl6+txbx3yjSGoH5xKUuLMnT0Namtuw/p/l/4ip9mwzb5bJhmYGG2+1u+DrM1
 uXRG5tweCbo3AOFkJ+Sm9tkO6GTNT02HcwDGFHaVm2OjN9Uq8wt1qSoONcOwSzvqIGb5i4Gb2/3
 w+22SRnWMmMC5eZbKmt+YN8/Wu1pQudTUWdNp/P0geOk1vq+CN6RuCcUl9gqcN2CGYcIw6NfaGy
 IRMrkAJ97CfScJyf/onbwYXeGpCoTkQuCHsxs4OjwwJs5VgKEqYjAmQxj9j96d5/Q8Zp3u95vco
 0ORhJHoMxZbDQm7GcxhKmD/jVcWGmhoScoowS73vYHZ3sZwlRC8Ex9Nvlp3vr1HZw47+lTLOJQb
 CYRK/J9VS0XQsUwpv+x+irfC5CpP206DgJ3YK2M8P2L0tdb653xtkdDIMhP/VzFUHicZr4ZtvVS
 EGmcIrzmU4/kpQ9hVr0iXLG+otCRs88CnmgRqZ9aiF99algncWwshasVx/W/wOXBLGkt3IdmNN0
 iyLWTWg2b9wUnp+rPlqQJDn1ueEHpjuI6jNMq6pY41ta84pnJwKBG8DnNmtiXFrxSMaCciHfSuR
 Jlw3Ztpa8vqAFnw==
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
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 175 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  67 --------
 2 files changed, 175 insertions(+), 67 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
new file mode 100644
index 000000000000..eff5bf7bd022
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -0,0 +1,175 @@
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


