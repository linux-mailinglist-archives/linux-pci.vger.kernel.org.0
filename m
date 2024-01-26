Return-Path: <linux-pci+bounces-2575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 1E93E83D690
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:37:44 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 42F191C295A5
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 09:37:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 810D928DD1;
	Fri, 26 Jan 2024 08:57:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WkxT78/r"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f41.google.com (mail-ej1-f41.google.com [209.85.218.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 26F651420A6
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 08:57:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.41
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259427; cv=none; b=XFj+vhm4VgSh6Kjyzq+LWSOmGf9B8U9OccKuMc8mnqMK9PQ+jLp8MeJ30GET+8oGSryfRLJqLcs5sxqKJflBAEOxYOrl1XkbGXiI7ANlL6+TczgTsToWzH9puU+9T21W4IGSv+TXf12XgbZqiyW/1hjW+VUrGCBSBlLv+x6LKk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259427; c=relaxed/simple;
	bh=Kpi+e1zOQGsMvKNsg7T6zt51ptrCq+dQp4qRk2qgV5Q=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=TjO028q4WPUMfka3aFYHdTxqzSxrYbgtFuiU+/Myz693onmdjY6SS+Jx3SQZrCg/4kZr5TnHGNjEjgFdkglJGHECxDDGOLjHsQDAmf7tL2ggVA1CRDaEhNi2wM0n1rj4eXwk6uNEIQO5SLNchPbpQvFxff+OQ69KTkAyEM9Okhs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=WkxT78/r; arc=none smtp.client-ip=209.85.218.41
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f41.google.com with SMTP id a640c23a62f3a-a31914e7493so17483366b.3
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 00:57:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259423; x=1706864223; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=0J42QZRyE7hua2zyqMdnH79xAYGxt1x2MM5KxH2NKU8=;
        b=WkxT78/rfuB5UDWTKVAgj3rgyer1KsKmGx/w83GnbsgC7y+eHIHOpfzzqzH3N59e1T
         R5hG6jcZFeKta8WWJP2dDgUlSZ7VsFVv63W2JoPKt0HF0sIE45Ei+Azlaky4LcPH2zhN
         UuedgxTF8YyKLUlZaUa4ZjpOrccnUuBSjmUwt0l+kpKW7FOvThENaxJS7ObiDL7QxfSM
         dC6h/iBhK9Fa7PCGPMkLPodNYIViT7s5ZSOJ0DYr6FtHQZwz7My9PD/qucy832dUKdFQ
         iJ1sZ7Dy4x+bgI736Eju26WoRt8SvUWiqSK+/Ly7ouEtrVrQta0gWyLYPO46+BWHZEek
         2w0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259423; x=1706864223;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0J42QZRyE7hua2zyqMdnH79xAYGxt1x2MM5KxH2NKU8=;
        b=bzKOpU2cdYQvQPNcpIikpRIUoulL9UFJwKL1+FkLMPdhy7Xt2fV9OPOQoD9C8QJezb
         NPOgJHJUKoXw48KXbBe9mVrRP18X+XxhmAyD3oR1RyLoXsGyijN09PAwE/gNoNXRbEJk
         lJDqYVS6evJ0Dq2YCRNX7k3nVYpecW27NoXhykQg3WAnRjGRaK9uoSfXmP+26tcNVAnz
         eoxuLiq+JbSsp3nNwBW9Lt9F8p+Z82zPDIBli2r99JawgZ1g2faCTKpWEXon7lz/J68k
         366tL/6lO+vscXI7O+n3l2lmPUnXRps7HKVjdgvLtIDGjwD8KjxCU9WkJRlKRbj86PfE
         FcZw==
X-Gm-Message-State: AOJu0YwJzoo6px+sA+tbSB59PzYFP8IBwDIUCLcIP1/u06n3iMf062sd
	ChTSlYELTL+Qms5FV/FgPrN+wi67NLGbvd2Bm5dm2r55HukpKoPH9lTsiBOXnMA=
X-Google-Smtp-Source: AGHT+IEQt7oXP4BNEp/z5lF/C/bK7R7a6/fQ7BPln//N4qg4+gccF0swSyFD5xc68f6gK7hjOeH0WQ==
X-Received: by 2002:a17:906:7b86:b0:a34:a1ec:52c0 with SMTP id s6-20020a1709067b8600b00a34a1ec52c0mr419534ejo.41.1706259423449;
        Fri, 26 Jan 2024 00:57:03 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a31710c0d32sm390522ejz.203.2024.01.26.00.57.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:57:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 09:56:47 +0100
Subject: [PATCH v3 6/6] dt-bindings: PCI: qcom,pcie-sc8280xp: move SC8280XP
 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dt-bindings-pci-qcom-split-v3-6-f23cda4d74c0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9872;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Kpi+e1zOQGsMvKNsg7T6zt51ptrCq+dQp4qRk2qgV5Q=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls3PTQFu//+S9LbCVBLz41HSxf1FRH5PTzVTmf
 Lx/9vylNE6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbNz0wAKCRDBN2bmhouD
 10iwEACKoHtW3TLROfNr/ilxZvuTE34vuo+AGuospVmusS7wcWasbZ5/5/rXQXN9LMWVRjjhgyz
 /fk8BShRrYHEmQa0ErjZGgpUTqnZ9oExnBMqKnjV0vyWMqXEu3WM8Cvw6bsOJoMP5RGm54VoonF
 /KpbI9/rC1MDHoxKWzIW1KAuslYeAP6UGjN6Uotb5N2eNc1so7BHh9ECDznHBLwzGHckZpCLLrB
 mhlfWBYvT0JP9LseW/kDeqRrBD7/ovLuX0j2iXLFn9R0KvRXD+eUdTNPEnDhBoPRlABbbRzLuOy
 Bw3g6e51zXYzi7M9MP/fG0WlBQzpE++dREwpFYBj9GIoNrSTq2RLta8qcQkmUwqc704NiffyGG/
 BfipfYI+dsFEOxzhEQLB2GX+Im7vuUvHlF2t6AzjQ9OJmdkgPGgC29grZWJ9si2rQXiruLVNjvZ
 4WneqzSUQD0kKpFj6qR5YGNCyC01D+nHakDtepElAd9rxrDJdnNKd23gG2TxyT9osbO7N/RA5CT
 Cu496uK2S1g3mXdmhfOmnXZIOypHBpL+cLVmdnGNE7RVp7Yj2r2WRHNX25bHBBVrJM5/oHCP04b
 GXM1cpXlv/ILFYoOobb1kKHm10aUxcb+0ThMvtto/Ie07EqUjw6F32UX/g0kB0/VV3bgB8RoaQI
 FuU2GrN1FItywWg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SC8280XP compatible PCIe devices from qcom,pcie.yaml binding to a
dedicated file to make reviewing easier.

This creates equivalent schema file, except missing required compatible
which is actually redundant.

Reviewed-by: Rob Herring <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  54 -------
 2 files changed, 180 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
new file mode 100644
index 000000000000..25c9f13ae977
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sc8280xp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC8280XP PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC8280XP SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-sa8540p
+      - qcom,pcie-sc8280xp
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
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: noc_aggr_4 # NoC aggregate 4 clock
+      - const: noc_aggr_south_sf # NoC aggregate South SF clock
+      - const: cnoc_qx # Configuration NoC QX clock
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
+required:
+  - interconnects
+  - interconnect-names
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8280xp
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: msi
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sc8280xp.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c20000 {
+            compatible = "qcom,pcie-sc8280xp";
+            reg = <0x0 0x01c20000 0x0 0x3000>,
+                  <0x0 0x3c000000 0x0 0xf1d>,
+                  <0x0 0x3c000f20 0x0 0xa8>,
+                  <0x0 0x3c001000 0x0 0x1000>,
+                  <0x0 0x3c100000 0x0 0x100000>,
+                  <0x0 0x01c23000 0x0 0x1000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <2>;
+            num-lanes = <4>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            assigned-clocks = <&gcc GCC_PCIE_2A_AUX_CLK>;
+            assigned-clock-rates = <19200000>;
+            clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
+                     <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_2A_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_2A_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_2A_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ddrss_sf_tbu",
+                          "noc_aggr_4",
+                          "noc_aggr_south_sf";
+
+            dma-coherent;
+
+            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &intc 0 0 GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &intc 0 0 GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &intc 0 0 GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>;
+
+            interconnects = <&aggre2_noc MASTER_PCIE_2A 0 &mc_virt SLAVE_EBI1 0>,
+                            <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_2A 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            phys = <&pcie2a_phy>;
+            phy-names = "pciephy";
+
+            pinctrl-0 = <&pcie2a_default>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc PCIE_2A_GDSC>;
+
+            resets = <&gcc GCC_PCIE_2A_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
+            vddpe-3v3-supply = <&vreg_nvme>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 6e03a1bce5d4..c8f36978a94c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -28,11 +28,9 @@ properties:
           - qcom,pcie-ipq8074-gen3
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
-          - qcom,pcie-sa8540p
           - qcom,pcie-sa8775p
           - qcom,pcie-sc7280
           - qcom,pcie-sc8180x
-          - qcom,pcie-sc8280xp
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
       - items:
@@ -210,7 +208,6 @@ allOf:
               - qcom,pcie-sa8775p
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
-              - qcom,pcie-sc8280xp
               - qcom,pcie-sdx55
     then:
       properties:
@@ -538,36 +535,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sa8540p
-              - qcom,pcie-sc8280xp
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
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: noc_aggr_4 # NoC aggregate 4 clock
-            - const: noc_aggr_south_sf # NoC aggregate South SF clock
-            - const: cnoc_qx # Configuration NoC QX clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -623,9 +590,7 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sa8540p
               - qcom,pcie-sa8775p
-              - qcom,pcie-sc8280xp
     then:
       required:
         - interconnects
@@ -692,24 +657,6 @@ allOf:
                 - const: msi6
                 - const: msi7
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sc8280xp
-    then:
-      properties:
-        interrupts:
-          minItems: 4
-          maxItems: 4
-        interrupt-names:
-          items:
-            - const: msi0
-            - const: msi1
-            - const: msi2
-            - const: msi3
-
   - if:
       properties:
         compatible:
@@ -724,7 +671,6 @@ allOf:
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-qcs404
-              - qcom,pcie-sa8540p
     then:
       properties:
         interrupts:

-- 
2.34.1


