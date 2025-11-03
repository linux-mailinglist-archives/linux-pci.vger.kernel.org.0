Return-Path: <linux-pci+bounces-40117-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A753AC2CC7B
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:35:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 85E9718C0DCB
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:26:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A022F32AACA;
	Mon,  3 Nov 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="OtuAExru"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f49.google.com (mail-ej1-f49.google.com [209.85.218.49])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 84F8C32AAA9
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.49
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182920; cv=none; b=NJdMaxPRuKetcJvyAq/68/Dbl+WrpQu8YNAsh7ZK4NxcLzZkbFd9aO4utyW7Orzo1gADF9ofqspDHAsoz0dnBgdBFjjtdzdEOVvlHEOxCg+pdVRqcWq3yWv981z91zE1ugM7RkYa5pV3kyzxUcKavftw7nEp0WQenlJpArIz3qU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182920; c=relaxed/simple;
	bh=JIs0WoVPU+JVGjbfl1yTO+dwd+WbzXH/saIA1Vp87ZY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=vFpLDeiQTasu/ilJUA2bHoOi+ObTknpH2XDJxQ3GYYq3qM8z8tf4Qk6yuR6kFq1yEVcwuSTfbe4vhG6auxFXdIJeYBZ8KijubVsL9m0/YzLLQvFDAQG56d/MxH1jRHwqstwp0YvQ8q5hGzWCLgbI5opM3shLbSXRhRTVn6/R/M0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=OtuAExru; arc=none smtp.client-ip=209.85.218.49
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f49.google.com with SMTP id a640c23a62f3a-b70ca7d1e78so16202366b.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182915; x=1762787715; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Q9S3Co2h9iv9d5g9Ia4Eg8QLfJL34I4u37B5Qxs3wlc=;
        b=OtuAExruvgntRtOlemyW7LKIdVv/A9K7Uv5f3/WJq7UC3cvKgENdLgZKbp9L2MNB+3
         hu3uJ05JPs7T+WT9QTZ63JSnMtKGjK3TwCLRSOzEHI2pXADaq9Ht20hqo85acn+C7acN
         rSNy1Yr+HzseIeGG+1j4hpoTJJowl0p0h5sPHu42QFToLDthsqldZMAzNZoxjY94Codh
         GtBHyYDkppnnaPpPFTkmkEZIrsA1QgTnFuNV8/38LPPWNz0aaj8p9KqtSF01HZRBNIBZ
         nOQ0eqwIg8IdHf3HfVmlsX8zqUlVJrVo+o/hsVZCselv8VGQzpOVtLP2/puXEQS4Qjz2
         QS8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182915; x=1762787715;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Q9S3Co2h9iv9d5g9Ia4Eg8QLfJL34I4u37B5Qxs3wlc=;
        b=H2oBr/FtXLsVcZU2jjqmpjUkx9wfVaiykKxoXTpjZakhNfXXY/i7k9X9ML07qA+09W
         Pj427erQ1oy6+Wd5fjZ/UM64timMPEeOtYbRT2glr2FfCLY07+vQ7iVPyuWd7qpKDyDN
         fJsD3fI8HS6pJMLDpbZOz6+JmI+ox5PDGJq6P/qW9/ofrXj/I/mSIzRAJvhQTvxU9Z2t
         gXXgWvyzWAN95V9wM8gcQnfwhIn5aGqKkZf5rcJm4+tlgsdFkMVkbhYS4fuI8ug2DmkH
         TKw29ePJYKJ4UN9x6Mtag0kIH1W7C3DCa6YQ29la2ESOWSYgQrBxmF1tzq63mPGP8bXF
         FffA==
X-Forwarded-Encrypted: i=1; AJvYcCXv5PZbyDfU2Gp4vs3rddeiX0/RwJ067leZRGTpww6wpsunGOLOgapZ+l11O0tyOFBWCzsJmM+9p/w=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxo4HAdmQGB/0wbsHE3K2k6LRwJk2r6WvAWwQMA5IbJqcsqM40h
	Zgl7eexcMIQuiz96SNTNk3dEwXJ24FQKDTmDHoSp62UPy+DdchOYqGqknmkRXqcVxEA=
X-Gm-Gg: ASbGncs5udGgGyh4Ig4XqcV1ycWoAj9z2BQQHq85x/Zt8iFV+3ber6nT/OxGu7n5y39
	ChiSLa0jlmxrL2Qng43UjZi8e0dPFJRDfTFqYScn2ZbHCEfHwMlcwaxqJvpkK1W2PQRbDdsrAia
	25VHyqbSzXx1r+GbCcZPcJt+PhMmwy0g51vkQdWeZV1jJ9XOiCQu9UB+W9P5p2P3QUDqlBtglLC
	AVmMzZxxoaAUjfHkNx+YRJTM3jHAQaVoROcqIASYTkpZonwZbLD1287A9uzqZTA0xM1F9q0coxt
	bNXIOlVFqxaWxa69TU3AsVh7spLuZOgfCOqZUNDxdYMgogBdvDekT2enD5LYWT+kRUUO7TKMBMz
	vjf0NHimQ5qUyUoHwe4H1whJyX+pXetvv6M8rQnvtA953R1jVjNOQmfLEqhSOClSWfH+HFaROdc
	0usLPB0Fl6B5ppl64BST7rBaZJOGo=
X-Google-Smtp-Source: AGHT+IG/76fbEdjdkzs5fgNF/Gz3HAGbk44MCKUY19AdjUogCdvbDHpxLCm16F54kuvLLsgO7wAZUQ==
X-Received: by 2002:a17:907:7e8d:b0:b6d:6f0c:302a with SMTP id a640c23a62f3a-b707063148bmr761665166b.7.1762182915451;
        Mon, 03 Nov 2025 07:15:15 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:14 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:50 +0100
Subject: [PATCH 10/12] dt-bindings: PCI: qcom,pcie-apq8064: Move APQ8064 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-10-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=11128;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=JIs0WoVPU+JVGjbfl1yTO+dwd+WbzXH/saIA1Vp87ZY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbsrI0fimSSNDtTpvGKGLjoXQQDeE13yY35Q
 ZAL05GOsZ6JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG7AAKCRDBN2bmhouD
 1z84D/93Irx80QttHDFem+aaR9woQdUj84MO1VtpefbC8rOQHXKd9xY12s/3gxXZgZJ0QZwb2qM
 cfY64RClINjYRZxiOUVyuwyXE6BMImUft30dDltbNPUsjhMr+scKxqzZmf+JeUDrzFX1uXntJU0
 bb53pvtE9vvlzSI5hXZd0CQAiZpWmkefqH2VOF2RpLUnamtTyvN/9FfIpMfgmlYKN4qZBwzZyy5
 219+Roz9I2M+tX9Z5LEG3lLsZXDBkj+2qIQzTcFa1LO5ODkO7hTR5IZ6WeTWSzFJREEVt4BcQ5O
 DNHFaWc0pwG69Dw4u639XsYsVd4gDk8slmGU9/Uw7mz25zQ4BRBA0JnrFKZoEKLlR4lUVffj7X0
 fu5TjnEgU9Du1NG5csyvskble25jWdZ90duZ7iC3HASK10FsC0m5OIf2hZp8nwSx0UqBE5+hvm7
 klaoG28b6iQ0XUnYZ9/qKmDHx5h7CAKJNWf/0hahc5YOctJBlFpqPyNpcAPe80zdL0EXi5Z/0EU
 RwSo2FX9tzXxoXS3x3jVdtqEkTte3ub5wuumP0jytqyle47J54F4X0vVp/P8CNhuK8WQfV/5rDu
 CQ2ttpZbw30aq4G/kdoO3xMzU3bZcTCaKgBFoI7arWBxAofJjqe6SKX5louSKncn6l7ElSdFxRz
 XWh3cyV6x1SZkhQ==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move APQ8064 and IPQ8064 PCIe devices from qcom,pcie.yaml binding to a
dedicated file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-apq8064.yaml | 170 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 127 ---------------
 2 files changed, 170 insertions(+), 127 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-apq8064.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-apq8064.yaml
new file mode 100644
index 000000000000..eb5b81d1defc
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-apq8064.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-apq8064.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APQ8064/IPQ8064 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-apq8064
+      - qcom,pcie-ipq8064
+      - qcom,pcie-ipq8064-v2
+
+  reg:
+    maxItems: 4
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: elbi
+      - const: parf
+      - const: config
+
+  clocks:
+    minItems: 3
+    maxItems: 5
+
+  clock-names:
+    minItems: 3
+    items:
+      - const: core # Clocks the pcie hw block
+      - const: iface # Configuration AHB clock
+      - const: phy
+      - const: aux
+      - const: ref
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  resets:
+    minItems: 5
+    maxItems: 6
+
+  reset-names:
+    minItems: 5
+    items:
+      - const: axi
+      - const: ahb
+      - const: por
+      - const: pci
+      - const: phy
+      - const: ext
+
+  vdda-supply:
+    description: A phandle to the core analog power supply
+
+  vdda_phy-supply:
+    description: A phandle to the core analog power supply for PHY
+
+  vdda_refclk-supply:
+    description: A phandle to the core analog power supply for IC which generates reference clock
+
+required:
+  - resets
+  - reset-names
+  - vdda-supply
+  - vdda_phy-supply
+  - vdda_refclk-supply
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-apq8064
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          maxItems: 3
+        resets:
+          maxItems: 5
+        reset-names:
+          maxItems: 5
+    else:
+      properties:
+        clocks:
+          minItems: 5
+        clock-names:
+          minItems: 5
+        resets:
+          minItems: 6
+        reset-names:
+          minItems: 6
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-msm8960.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/qcom,gcc-msm8960.h>
+
+    pcie@1b500000 {
+        compatible = "qcom,pcie-apq8064";
+        reg = <0x1b500000 0x1000>,
+              <0x1b502000 0x80>,
+              <0x1b600000 0x100>,
+              <0x0ff00000 0x100000>;
+        reg-names = "dbi", "elbi", "parf", "config";
+        ranges = <0x81000000 0x0 0x00000000 0x0fe00000 0x0 0x00100000>, /* I/O */
+                 <0x82000000 0x0 0x08000000 0x08000000 0x0 0x07e00000>; /* mem */
+
+        device_type = "pci";
+        linux,pci-domain = <0>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        clocks = <&gcc PCIE_A_CLK>,
+                 <&gcc PCIE_H_CLK>,
+                 <&gcc PCIE_PHY_REF_CLK>;
+        clock-names = "core", "iface", "phy";
+
+        interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 36 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 37 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 38 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 39 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        resets = <&gcc PCIE_ACLK_RESET>,
+                 <&gcc PCIE_HCLK_RESET>,
+                 <&gcc PCIE_POR_RESET>,
+                 <&gcc PCIE_PCI_RESET>,
+                 <&gcc PCIE_PHY_RESET>;
+        reset-names = "axi", "ahb", "por", "pci", "phy";
+
+        perst-gpios = <&tlmm_pinmux 27 GPIO_ACTIVE_LOW>;
+        vdda-supply = <&pm8921_s3>;
+        vdda_phy-supply = <&pm8921_lvs6>;
+        vdda_refclk-supply = <&v3p3_fixed>;
+
+        pcie@0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            bus-range = <0x01 0xff>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 8be10d950616..a42e665a23a8 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -18,10 +18,7 @@ properties:
   compatible:
     oneOf:
       - enum:
-          - qcom,pcie-apq8064
           - qcom,pcie-apq8084
-          - qcom,pcie-ipq8064
-          - qcom,pcie-ipq8064-v2
           - qcom,pcie-msm8996
       - items:
           - const: qcom,pcie-msm8998
@@ -78,12 +75,6 @@ properties:
   vdda-supply:
     description: A phandle to the core analog power supply
 
-  vdda_phy-supply:
-    description: A phandle to the core analog power supply for PHY
-
-  vdda_refclk-supply:
-    description: A phandle to the core analog power supply for IC which generates reference clock
-
   vddpe-3v3-supply:
     description: A phandle to the PCIe endpoint power supply
 
@@ -127,26 +118,6 @@ anyOf:
 
 allOf:
   - $ref: /schemas/pci/pci-host-bridge.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8064
-              - qcom,pcie-ipq8064
-              - qcom,pcie-ipq8064v2
-    then:
-      properties:
-        reg:
-          minItems: 4
-          maxItems: 4
-        reg-names:
-          items:
-            - const: dbi # DesignWare PCIe registers
-            - const: elbi # External local bus interface registers
-            - const: parf # Qualcomm specific registers
-            - const: config # PCIe configuration space
-
   - if:
       properties:
         compatible:
@@ -168,44 +139,6 @@ allOf:
             - const: config # PCIe configuration space
             - const: mhi # MHI registers
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8064
-              - qcom,pcie-ipq8064
-              - qcom,pcie-ipq8064v2
-    then:
-      properties:
-        clocks:
-          minItems: 3
-          maxItems: 5
-        clock-names:
-          minItems: 3
-          items:
-            - const: core # Clocks the pcie hw block
-            - const: iface # Configuration AHB clock
-            - const: phy # Clocks the pcie PHY block
-            - const: aux # Clocks the pcie AUX block, not on apq8064
-            - const: ref # Clocks the pcie ref block, not on apq8064
-        resets:
-          minItems: 5
-          maxItems: 6
-        reset-names:
-          minItems: 5
-          items:
-            - const: axi # AXI reset
-            - const: ahb # AHB reset
-            - const: por # POR reset
-            - const: pci # PCI reset
-            - const: phy # PHY reset
-            - const: ext # EXT reset, not on apq8064
-      required:
-        - vdda-supply
-        - vdda_phy-supply
-        - vdda_refclk-supply
-
   - if:
       properties:
         compatible:
@@ -250,19 +183,6 @@ allOf:
         resets: false
         reset-names: false
 
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,pcie-apq8064
-                - qcom,pcie-ipq8064
-                - qcom,pcie-ipq8064v2
-    then:
-      required:
-        - power-domains
-
   - if:
       not:
         properties:
@@ -312,10 +232,7 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-apq8064
               - qcom,pcie-apq8084
-              - qcom,pcie-ipq8064
-              - qcom,pcie-ipq8064-v2
     then:
       properties:
         interrupts:
@@ -327,50 +244,6 @@ allOf:
 unevaluatedProperties: false
 
 examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    pcie@1b500000 {
-      compatible = "qcom,pcie-ipq8064";
-      reg = <0x1b500000 0x1000>,
-            <0x1b502000 0x80>,
-            <0x1b600000 0x100>,
-            <0x0ff00000 0x100000>;
-      reg-names = "dbi", "elbi", "parf", "config";
-      device_type = "pci";
-      linux,pci-domain = <0>;
-      bus-range = <0x00 0xff>;
-      num-lanes = <1>;
-      #address-cells = <3>;
-      #size-cells = <2>;
-      ranges = <0x81000000 0 0 0x0fe00000 0 0x00100000>,
-               <0x82000000 0 0 0x08000000 0 0x07e00000>;
-      interrupts = <GIC_SPI 238 IRQ_TYPE_LEVEL_HIGH>;
-      interrupt-names = "msi";
-      #interrupt-cells = <1>;
-      interrupt-map-mask = <0 0 0 0x7>;
-      interrupt-map = <0 0 0 1 &intc 0 36 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 2 &intc 0 37 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 3 &intc 0 38 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 4 &intc 0 39 IRQ_TYPE_LEVEL_HIGH>;
-      clocks = <&gcc 41>,
-               <&gcc 43>,
-               <&gcc 44>,
-               <&gcc 42>,
-               <&gcc 248>;
-      clock-names = "core", "iface", "phy", "aux", "ref";
-      resets = <&gcc 27>,
-               <&gcc 26>,
-               <&gcc 25>,
-               <&gcc 24>,
-               <&gcc 23>,
-               <&gcc 22>;
-      reset-names = "axi", "ahb", "por", "pci", "phy", "ext";
-      pinctrl-0 = <&pcie_pins_default>;
-      pinctrl-names = "default";
-      vdda-supply = <&pm8921_s3>;
-      vdda_phy-supply = <&pm8921_lvs6>;
-      vdda_refclk-supply = <&ext_3p3v>;
-    };
   - |
     #include <dt-bindings/interrupt-controller/arm-gic.h>
     #include <dt-bindings/gpio/gpio.h>

-- 
2.48.1


