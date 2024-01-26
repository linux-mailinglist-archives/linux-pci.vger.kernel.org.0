Return-Path: <linux-pci+bounces-2572-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id A1AB583D680
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 10:36:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 5BBB528FAE3
	for <lists+linux-pci@lfdr.de>; Fri, 26 Jan 2024 09:36:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40DB014079A;
	Fri, 26 Jan 2024 08:57:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hlzlNKQ3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-wm1-f43.google.com (mail-wm1-f43.google.com [209.85.128.43])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 44A28140768
	for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 08:57:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.128.43
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1706259422; cv=none; b=MpP1UbYKOWaMeiRpAGo+Qsxo8ORXO3DSQcl2c8iw9o90n93VUoiOT2exm6WFgbQHs7yg3rgnfvxSIaKWNdbdQrBRx9GG6ERto3RcHOiD0wOGcZ8klYChLMZ9EgSwbIORgeFuDj/rbgqP9xYT57TJ4Y6b/9PI9k1v9uqVH4vSsrc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1706259422; c=relaxed/simple;
	bh=Fs0hqsceVE6tREsJFOaedH8nmI0CDFaCTGuwbMlpTHU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=fK22Ky0npnKqCWV0HVaX1RI744zo7H0EBEfQRFPD3v+gn+6tLvYjhZvH8a+9dgyUknknTa/NdNy39JXoIbkfc/Hqnce9gfcy1WjEzFl+bj7uylJeqg89A18gkyhr9yUXsIsJnAEHk4zSBvMcHj8dbVodIt8dlEquSZdU9gheldM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hlzlNKQ3; arc=none smtp.client-ip=209.85.128.43
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-wm1-f43.google.com with SMTP id 5b1f17b1804b1-40e7e2e04f0so2015665e9.1
        for <linux-pci@vger.kernel.org>; Fri, 26 Jan 2024 00:57:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1706259418; x=1706864218; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4cwlGhuyqhoddA6J3pLRTYguRcB5mi1DcrMGcpwmQIA=;
        b=hlzlNKQ3eoxsAve6qhHMiD90JiV7naUhKnZkL7tRmtaacAKjSlF1Tbu/blTFV/Dq54
         x6I2hB+LowUcKsKZTxdtDqb2KgfeGWBVwv3GBb7y58iC3IfnOc2U25Zj7ngNkAEk/NGt
         Hukqv53Z9K0GwrWg/0ZWQPl2ES14CJTItUl1f8TWHvn3Kbt0JSiHHQUgRcBsaOm9vW8A
         g2GbtYtOol3dxOUgsP18hfb8xEm1dohY33nMZI1KwfCXI8Fi6EyoV7US5XUW+y6EHTpI
         rBY4MM2XKAQ3u7Ue5k0FwfETbCMxuBiQy0ZBxhmbvktWCzc3RTrqp/FCP++ganh52qJW
         C93Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1706259418; x=1706864218;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4cwlGhuyqhoddA6J3pLRTYguRcB5mi1DcrMGcpwmQIA=;
        b=MG7iDmF5h8ahfk9ePcMHatLTdMePOJ5/eqw/lfxVUiDDrxGz1CvSC/ZgEairGJHMXM
         mYnhdPgpUQtvtOrUlugAEm8jW6uc8xrS6el2TTY8j4eWPgjxLRv6yRB4o7ZdzRg4duJm
         AX0MY5o+0sE/pVJp1mdgNHJVROUpUj+W1foych5w5YP6sSyUWGX4gXjgTIgH/8lZJv9u
         P6/hhGBTOsCTaEWXGHijjQKokESbeFrxrsAg3RlVhTH6/fb0M85OE07EgoGdqsNM1/WU
         SA+bMfWBjyM8b1lxavsplD+CvLj4qM6vvJjVjG3eEHqy7ZROBjuT8lwJYYcKVd3Ws8OI
         O4RQ==
X-Gm-Message-State: AOJu0YzKh2lhwD3+B1xQHZgMRHegEiSXu+KdEVSSykMgmtn1hWs3y4Tw
	aXGY143zI8on2qrD98d1figXVAuaUbJUMLWIoo4ZbMPgNmt5vx9Pz28GF7vMSg4=
X-Google-Smtp-Source: AGHT+IFAdaWtnDOD8PLIKIlXxeLNO/Ya+2P7RC7p6rwfBjXFfy3hnxhIZgyklb6+mzikxAP38gufYw==
X-Received: by 2002:a05:600c:43d4:b0:40e:863e:2f16 with SMTP id f20-20020a05600c43d400b0040e863e2f16mr613787wmn.128.1706259418564;
        Fri, 26 Jan 2024 00:56:58 -0800 (PST)
Received: from [127.0.1.1] ([178.197.215.66])
        by smtp.gmail.com with ESMTPSA id q15-20020a170906b28f00b00a31710c0d32sm390522ejz.203.2024.01.26.00.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 26 Jan 2024 00:56:58 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Fri, 26 Jan 2024 09:56:44 +0100
Subject: [PATCH v3 3/6] dt-bindings: PCI: qcom,pcie-sm8250: move SM8250 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240126-dt-bindings-pci-qcom-split-v3-3-f23cda4d74c0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9618;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Fs0hqsceVE6tREsJFOaedH8nmI0CDFaCTGuwbMlpTHU=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBls3PQg6VlMWZZ5x2CUW6tmGf4i7svqaIEPEWZc
 OcNtiWqTBSJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZbNz0AAKCRDBN2bmhouD
 1yTgD/wLiRL1OwFMUgB64tiTgPCBfpSOAZgUwFU2xlYkTjIPJbKEDD1SsnYbAzV24Hq4DMgMD4L
 MYA4POjoNCl5gdJ5NNVo5iNedN9KHA3HlbcDkyPUkjVHd38Qvg6ta5QL1+uNtSgXKF9lHEnEpfG
 FDAi/0skKLwT9LytsjsX8qHIuxpn79xnnHnqNEvTnXgr1W4VeRjKtVRHdry0m2S4Srpij2A7QLw
 fWI1Z2iAtBdyJYLweiYt6xryCDHkJTqtfI/w+moFDUUqR8fxaGARPlowixbpc/2ktW/HG5mkhKC
 t6MIXHfOQk5GGrbDvI+miR2LhcYBlq4QhQZC/71ts6cFI4cw4Vfz6+HEGRLg5JN15gx1D88VG8g
 ZeIHXJQaXqbuemlPqQibBSojiI9JQk++DN6cpdEZbcuDyuTjTprdWlVz3lIwfva1WARkhJgfHIl
 HQv2dsvnOSveFR4qmHBt5ma+or33BBnY43M/fyVA6MJGWkc/0dA3/WD91WwDHJXJ5LFEA1LXXbg
 DIRs9bIyAgXerSuWkS1sLEtKxMeE8AiBvQcVJqCdSV8ocSHdB1Ls+kFqUjxgPofNdrbM6PkN6Rc
 HNblgTsaPcd2ly2Z1JbgjZp53Ir6NnDsPbfvUSVbQVFreSBExHAGPhKB6Y6kiHsrCBnufFdJN3n
 m/sJL3nSHX69AyA==
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


