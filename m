Return-Path: <linux-pci+bounces-40116-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id CA636C2CF00
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:58:34 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id BC049427562
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:25:53 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 163CF32AADE;
	Mon,  3 Nov 2025 15:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e8cyg3t2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f50.google.com (mail-ej1-f50.google.com [209.85.218.50])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C5743329E54
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.50
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182918; cv=none; b=ioiV+s6ZQg8HCerCSIg1xNn4TCyfRuO2+kovIvQRJ3uEn4Bnh+weHpp+wLRuOxsmJOY7evvMgLvbztuZhIShKv46wm8x9RwOErQsTyoIpUyUn5B/o8xWh5wtJebe47i2l0B31rDX86GgRKsk0aeAQE0tbFpYVCoQVsdmzWOkk8U=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182918; c=relaxed/simple;
	bh=WnS2bYSTX7sA623WUpRuAinBa1d19n2RdHWvwrXW8uY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OLLOnZT9iwTAu/bRnOHdtMvyjJtnJKHePf69qJtJGFeW/+/CWjadx5iTv/RWvdLfJxiRb5C/9Vprge0ZqSUBiXAuMaKbk50xBSeiwwy4eLO0IXRI+UcqhKKkHeJ67mk+xlLq2Oj4zzsvBHWZxTKRqSpU0F2Wk6cycMe9AKQZyJU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=e8cyg3t2; arc=none smtp.client-ip=209.85.218.50
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f50.google.com with SMTP id a640c23a62f3a-b70b40e0284so11078066b.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182914; x=1762787714; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DB7GGJ12GRBspGlSV1Cb9EY3AAP9j5lCvHlknIm8YgI=;
        b=e8cyg3t2BeHKpWxkhc0O+O+X1+IwsADSz7aieMOO7UwG08XBTEfwzLNlaNK9DK8GJt
         NYlx0NCURJIO5/rw9isyR9hSQVwUt/WDZQtc/EsFEGoSkSflhpIiN1iW3y3f52s0WBAc
         1lTg2BFZUQHG5l1O0CCA+K6IGUsdGL1jaiuT0QoIeUT6CPD/wDq2P3hXxucDTdEZQU2n
         KrdUc0+9FlIvXae80rXmb06Mm2nwy2maH5OuKk79rtvMZ4g1Zwvxj0tVKVDUn+RLEJMx
         gRQTetC3Y89JqoZfuxF2AzzIcqzR0yicyNtnZuCWiTqmFYB706BwnpYYXPAhJAO31Ydy
         Cl+w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182914; x=1762787714;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=DB7GGJ12GRBspGlSV1Cb9EY3AAP9j5lCvHlknIm8YgI=;
        b=QyHCr3qhQlUG7Zns3uUt92uzC64jJPx1HG/pxLAn+Z+BWtW2ZTc8CznNw5xmgiDPTC
         XI/kHj64j2Ha2IEzQVEmb7Vhoh6z26NJ0/mh/eZJTuFRMZ9EWYiWLK1N6CJTHChnTxMW
         M1vGgE7JMrO+1PTX963ukWg4AtpB1YeuQRnWUXN7IMY8hFikbhjSwfjRgOvhEGY4DNXT
         x18HqVkrUAUAZeQusB0LuZSS7pOKAWwDJAe1FmBX0Cswz5dxIJsJeXO55vNuqom1QyMW
         er2OMCGkdFpAaYT+r1y4t5Ow4tYeE4Ny+y6TLtP7EKDYdtz7cHqLzOgJhYJVULHlysDW
         y5+g==
X-Forwarded-Encrypted: i=1; AJvYcCVIusKXZkn3DE4i+DqNuI5J0Xo5RLMQtBUjGXwePohw4YCRRb/vfbt+OS5te/ENL1+et7J2UclcO6U=@vger.kernel.org
X-Gm-Message-State: AOJu0YwH52QTLbRpbBPlU2kclHDl3nj75Q9DTl1hk+s5wiOcXZ9R3Nvk
	qARWTRFWX7ZrdSGfk9QGHZBovt57eWgCLGSjokPt0PliThfKefGDxQgIjltwkEDoy6o=
X-Gm-Gg: ASbGncseln5ePmBLT0WR+6W/uCXC+EJG8jDyvFIx8pw0Iqm6YZ/DBf3st0lj+/wC02j
	+fxuZv3mUtm5KN4RVOcvThM2tnxO9m0Mf4bDLUaNO5MwejXSicZNpK9B3lZ0YHV7Pw2ZgYXiDzW
	nkdVL03uyDSyWFDowQzP5dCSvWShcGycZ971Z5bLsukkcXDPuj8hI9sa6LUKVsrwhfQ+QdWIcGP
	21No02AEnM2NFm2uDdOHq6jNR9wK06XN22cSqhOOvhE/IwNdMrOaIoY5jN2snGK72mhJ8H38x/h
	KcreG7vmJ0WRGYKLEqN509caPqk027KCIu7VODo8FzaBQBK+9PWNmLTdy2Xo+7IWBzpGNcm30pu
	7TAhMx1091aDi/McA8RpRUvr0OnynhQrScoue98P7ZDrQI2Iz7WtekrnexJSwCNv2pxhrCYciY+
	GOY8m50aQuaYCmNeSW
X-Google-Smtp-Source: AGHT+IEw2hrZtaelRDjrKFKWpOD0S5MLlKmwcsMQoFfWjSlEGptMfJfpkwobg2ecV6tGysmgp5yP7w==
X-Received: by 2002:a17:907:3d0c:b0:b3f:331a:a98c with SMTP id a640c23a62f3a-b70701934ffmr727209766b.4.1762182914083;
        Mon, 03 Nov 2025 07:15:14 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:13 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:49 +0100
Subject: [PATCH 09/12] dt-bindings: PCI: qcom,pcie-ipq9574: Move IPQ9574 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-9-c0f6041abf9b@linaro.org>
References: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
In-Reply-To: <20251103-dt-bindings-pci-qcom-v1-0-c0f6041abf9b@linaro.org>
To: Bjorn Helgaas <bhelgaas@google.com>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kwilczynski@kernel.org>, 
 Manivannan Sadhasivam <mani@kernel.org>, Rob Herring <robh@kernel.org>, 
 Krzysztof Kozlowski <krzk+dt@kernel.org>, 
 Conor Dooley <conor+dt@kernel.org>, Bjorn Andersson <andersson@kernel.org>
Cc: linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org, 
 devicetree@vger.kernel.org, linux-kernel@vger.kernel.org, 
 Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.14.3
X-Developer-Signature: v=1; a=openpgp-sha256; l=9892;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=WnS2bYSTX7sA623WUpRuAinBa1d19n2RdHWvwrXW8uY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbr2soV7EcYSCfzrkS3JWU+1OQik3qjZ5ZAU
 FZ2uLF0HbqJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG6wAKCRDBN2bmhouD
 1wQvD/9c9OfojUceaw5dSAQF3OvDIs0EdDGx67egP3XJKjin60/oAcB3Nvu5E/fqyFxTXe6SAZA
 VnRD8/c+NLYaSbo0vAyHvNJsqqvQbMhq8BpMMf1dKhsgLiAdyKrZghzSe1GdVmoP8MhJb0WugI8
 VjkxltlNZ58Po7bDjxeCcW8HpdNRaHSp+JxweVJew0lMI3/2YJqt85fqmaOwTK8XFNrTTenbVQ/
 yPwfLhLX1Kdmf8HnBqomUP5nqf2NA9hDHd3Pz26ZmtUpUYk9tjOlSIl4d0XEMgddXOvxGZu4kWN
 sZqsj3scGyytFwVCckrFCdmCdT1bs+fsYT7hgXkfCBbfZuDnmZKmUwtIoS1FMS8jyBOKYsbMcxV
 i9AFjpeDP39z1M7Vtex7zYW69V8qnCgccW1m9Q3FZfZH1ZsXKPlNliQLcJisEEnBvwaFM22MmOO
 GKdtqSFiI9AHC1KcT0pyJT0ALbE/crTTDeW16xg5Kp05U5NnECbDZCAn5Aq/36Q3+JVjOOwRnCP
 DCqpWCchuqJAfRs/V9/6sj3n93H8E+XbQlv59D8bWQBWtKAcv0r7TQaGJ+0pHcUetLP5xC+gC/6
 xMo7zAU9cFn9fF5UhOmKqVz05WLmpZH3pBtbFwFkSn2aiBMkOxkJ6PcV/RR+O6g4PIeQyS5965J
 Jr4uFday9cJe6xA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move IPQ9574 and compatible PCIe devices from qcom,pcie.yaml binding to
a dedicated file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Make last "reg" entry "mhi" a required one, because all in-tree DTS
   were updated to include it.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq9574.yaml | 183 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  77 ---------
 2 files changed, 183 insertions(+), 77 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
new file mode 100644
index 000000000000..4be342cc04e1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq9574.yaml
@@ -0,0 +1,183 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ipq9574.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ9574 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    oneOf:
+      - enum:
+          - qcom,pcie-ipq9574
+      - items:
+          - enum:
+              - qcom,pcie-ipq5332
+              - qcom,pcie-ipq5424
+          - const: qcom,pcie-ipq9574
+
+  reg:
+    maxItems: 6
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: elbi
+      - const: atu
+      - const: parf
+      - const: config
+      - const: mhi
+
+  clocks:
+    maxItems: 6
+
+  clock-names:
+    items:
+      - const: axi_m # AXI Master clock
+      - const: axi_s # AXI Slave clock
+      - const: axi_bridge
+      - const: rchng
+      - const: ahb
+      - const: aux
+
+  interrupts:
+    minItems: 8
+    maxItems: 9
+
+  interrupt-names:
+    minItems: 8
+    items:
+      - const: msi0
+      - const: msi1
+      - const: msi2
+      - const: msi3
+      - const: msi4
+      - const: msi5
+      - const: msi6
+      - const: msi7
+      - const: global
+
+  resets:
+    maxItems: 8
+
+  reset-names:
+    items:
+      - const: pipe
+      - const: sticky # Core sticky reset
+      - const: axi_s_sticky # AXI Slave Sticky reset
+      - const: axi_s # AXI slave reset
+      - const: axi_m_sticky # AXI Master Sticky reset
+      - const: axi_m # AXI master reset
+      - const: aux
+      - const: ahb
+
+required:
+  - resets
+  - reset-names
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,ipq9574-gcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,ipq9574.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/qcom,ipq9574-gcc.h>
+
+    pcie@10000000 {
+        compatible = "qcom,pcie-ipq9574";
+        reg = <0x10000000 0xf1d>,
+              <0x10000f20 0xa8>,
+              <0x10001000 0x1000>,
+              <0x000f8000 0x4000>,
+              <0x10100000 0x1000>,
+              <0x000fe000 0x1000>;
+        reg-names = "dbi",
+                "elbi",
+                "atu",
+                "parf",
+                "config",
+                "mhi";
+        ranges = <0x01000000 0x0 0x00000000 0x10200000 0x0 0x100000>,
+                 <0x02000000 0x0 0x10300000 0x10300000 0x0 0x7d00000>;
+
+        device_type = "pci";
+        linux,pci-domain = <1>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        clocks = <&gcc GCC_PCIE1_AXI_M_CLK>,
+                 <&gcc GCC_PCIE1_AXI_S_CLK>,
+                 <&gcc GCC_PCIE1_AXI_S_BRIDGE_CLK>,
+                 <&gcc GCC_PCIE1_RCHNG_CLK>,
+                 <&gcc GCC_PCIE1_AHB_CLK>,
+                 <&gcc GCC_PCIE1_AUX_CLK>;
+        clock-names = "axi_m",
+                      "axi_s",
+                      "axi_bridge",
+                      "rchng",
+                      "ahb",
+                      "aux";
+
+        interconnects = <&gcc MASTER_ANOC_PCIE1 &gcc SLAVE_ANOC_PCIE1>,
+                        <&gcc MASTER_SNOC_PCIE1 &gcc SLAVE_SNOC_PCIE1>;
+        interconnect-names = "pcie-mem", "cpu-pcie";
+
+        interrupts = <GIC_SPI 26 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 27 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 28 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 29 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi0",
+                          "msi1",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7";
+
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc 0 GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &intc 0 GIC_SPI 49 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &intc 0 GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &intc 0 GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>;
+
+        resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+                 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+                 <&gcc GCC_PCIE1_AXI_S_STICKY_ARES>,
+                 <&gcc GCC_PCIE1_AXI_S_ARES>,
+                 <&gcc GCC_PCIE1_AXI_M_STICKY_ARES>,
+                 <&gcc GCC_PCIE1_AXI_M_ARES>,
+                 <&gcc GCC_PCIE1_AUX_ARES>,
+                 <&gcc GCC_PCIE1_AHB_ARES>;
+        reset-names = "pipe",
+                      "sticky",
+                      "axi_s_sticky",
+                      "axi_s",
+                      "axi_m_sticky",
+                      "axi_m",
+                      "aux",
+                      "ahb";
+
+        phys = <&pcie1_phy>;
+        phy-names = "pciephy";
+
+        perst-gpios = <&tlmm 26 GPIO_ACTIVE_LOW>;
+        wake-gpios = <&tlmm 27 GPIO_ACTIVE_LOW>;
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 65caf5b5623d..8be10d950616 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -22,13 +22,7 @@ properties:
           - qcom,pcie-apq8084
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
-          - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
-      - items:
-          - enum:
-              - qcom,pcie-ipq5332
-              - qcom,pcie-ipq5424
-          - const: qcom,pcie-ipq9574
       - items:
           - const: qcom,pcie-msm8998
           - const: qcom,pcie-msm8996
@@ -153,27 +147,6 @@ allOf:
             - const: parf # Qualcomm specific registers
             - const: config # PCIe configuration space
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq9574
-    then:
-      properties:
-        reg:
-          minItems: 5
-          maxItems: 6
-        reg-names:
-          minItems: 5
-          items:
-            - const: dbi # DesignWare PCIe registers
-            - const: elbi # External local bus interface registers
-            - const: atu # ATU address space
-            - const: parf # Qualcomm specific registers
-            - const: config # PCIe configuration space
-            - const: mhi # MHI registers
-
   - if:
       properties:
         compatible:
@@ -277,55 +250,6 @@ allOf:
         resets: false
         reset-names: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq9574
-    then:
-      properties:
-        clocks:
-          minItems: 6
-          maxItems: 6
-        clock-names:
-          items:
-            - const: axi_m # AXI Master clock
-            - const: axi_s # AXI Slave clock
-            - const: axi_bridge
-            - const: rchng
-            - const: ahb
-            - const: aux
-
-        resets:
-          minItems: 8
-          maxItems: 8
-        reset-names:
-          items:
-            - const: pipe # PIPE reset
-            - const: sticky # Core Sticky reset
-            - const: axi_s_sticky # AXI Slave Sticky reset
-            - const: axi_s # AXI Slave reset
-            - const: axi_m_sticky # AXI Master Sticky reset
-            - const: axi_m # AXI Master reset
-            - const: aux # AUX Reset
-            - const: ahb # AHB Reset
-
-        interrupts:
-          minItems: 8
-        interrupt-names:
-          minItems: 8
-          items:
-            - const: msi0
-            - const: msi1
-            - const: msi2
-            - const: msi3
-            - const: msi4
-            - const: msi5
-            - const: msi6
-            - const: msi7
-            - const: global
-
   - if:
       not:
         properties:
@@ -335,7 +259,6 @@ allOf:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
-                - qcom,pcie-ipq9574
     then:
       required:
         - power-domains

-- 
2.48.1


