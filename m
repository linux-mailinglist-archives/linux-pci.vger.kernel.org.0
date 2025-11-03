Return-Path: <linux-pci+bounces-40111-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AFC73C2CC67
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:35:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CB28418C054E
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:24:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53193328608;
	Mon,  3 Nov 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="MJdINdI7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f53.google.com (mail-ej1-f53.google.com [209.85.218.53])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1017F3271EB
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.53
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182908; cv=none; b=Syx6EQGvCbTy5SWZCeSYyoUJKrZgDB3Imb24lg/uH+41QZtcKhs+U1R+gNF3pVdDFnCeBmjSq1CO4qJZy1hOvW0cEzgD3f8pL00WBKY2tpiQWVjPSeZrCdc6Dhzxd1n0eNLV5IDqwYTZDwB0IWnSjTXTrQ+F2Om0k+aEXOAofu4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182908; c=relaxed/simple;
	bh=fRCCTTQtkmskj6hjCG7g0ZK8BRFz/06lAV1QM0WwAQE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=LNPeBrxgFuvk3wRwLpftZJrVImSphwgWOs7Rwu1hSRgCQlE80wY32CxvwD2h1a682NuY3jmkXN4Wv9olu/LaMMgZoSOzhV4UjMGAvsITTGAbUtKhIL1qontUeuaHsd7T0NnLIjk1RrBrB5irerEJJyB8rK4JMSVLEGJ7WiHz5KE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=MJdINdI7; arc=none smtp.client-ip=209.85.218.53
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f53.google.com with SMTP id a640c23a62f3a-b70ca7d1e78so16193166b.3
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182904; x=1762787704; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=3CH8BEbEKzDsW8PM/ItxImO1L1Js03stWXoQxldbKzs=;
        b=MJdINdI7+upEOV2m9el0Ziqqg9Sm2cFfnJcXA9yTJkLPgiaMB6WcYGU/989N+vl4xJ
         jJCdS8C6gdRxHbIPAkqSruexO0UJd8yztY9WauVmHIstT6HZIGDhvWeZErKwShx/+Nrh
         F+JrKnKug7XAnVL9lk/G9pa9vFp0rxXXsaYpJT2VKb8CzsmX2hB2011uIJyEKSv6S2A+
         gVsGruJiOK0YugylnXPlzsJKz14Mv+5K4/4lKJMxFoxzJ0NH88fd5r92CHwFLnoiNmmr
         xnwGm+8HK2teqi8MyKDq+C7jVln3XXFTWfRjeGpIalJdwC15JGIZBytPYmAp1MwDO44T
         y/8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182904; x=1762787704;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3CH8BEbEKzDsW8PM/ItxImO1L1Js03stWXoQxldbKzs=;
        b=jjL4ja1o1QtA3zTIeETKLu9GM55xhi4Wa+pI+Bk1Fn4JXyN48PHfDXVzJIZ+PDffKC
         1DXRmEvJf7MnRQ97M3zCPHRE5iuuEkyJ0oduc3km/kKlBTolyWwi0o7WLQ6Wn+E88YQg
         8k5tUkbz/3Kf/RCns6er6HJ2bHhgkYCj5EJsRLaQlBh9GPyodYRYpX3/yfyJGhXmtxFt
         QMX7K1xBVn6i87wK8bcAXM/iIOqijtkr6NEbD9zHb6QMF5xCVrEwaAQe7eZZ9uz8iasg
         fBpW70446GeS1DQFZ2a2LQCv/oPQCra0tO/5Wy1zEWevLO76aTj9ZBdqGOgLB+woYVnD
         QEQg==
X-Forwarded-Encrypted: i=1; AJvYcCVsAkEwkvbzVaH3FRRYWRgpjOuGeV0EP/Gn6IBjq9vKru6E0Ok9jJDXrPLw3yJdMfkS/ZiqTlOfzNk=@vger.kernel.org
X-Gm-Message-State: AOJu0YysbloDUHtAKggf1RAm/v5P8xiAoeHzmivRHS8la13FyD6Yg3+f
	ByTf3G22A0j+7lEznUVN6yNjz+TvYcWAE0SZfaAvy3BLcLpSQCQ9ytjI6crUJ3FGpNQ=
X-Gm-Gg: ASbGncua59WQYK7XEbxpZFtrKbxkxDaSzxPOAPep0podHKH4e5EF/X8kQpwIn1lXdhw
	URDRWvrGui4yjIa5vPRxYT8ekD4HLc/rWxLxaz3NOeba9B1TduT1Iv/lWKcRVjf6rW0Dg8xC+h+
	q5gzWEzoLm84yj5Hc2BmlJbRGpGbRtE7hoNdOjYaAKGscv834WR0ugiQjD71EH8gjbLz9fUkp2e
	UF0D3HCBfZH/BsYzgManZy+4279+wC7TiM8DN2DKvp2erHSow9uWzNEYWQkDWfc0aoxY8wrQPIg
	VxSbcg7HSHivg5Hl+HnzG1Kn/q5Kexhwrc0sDN/MNBf6fWw1dbQM/KjCaImF/aFs0d/eIlky8Bo
	orlkJssNaFEvNBHiTlrwufOpj5MvIiBMFG1osUExRR7zNEWFamS62fckstQ/gIPN21SnLXKfPuj
	Mwuyy9xs5Q5X0G1qjl
X-Google-Smtp-Source: AGHT+IFVrRORCtv3FX44119ttHqsBFW4idclkLj5Q0ryiufXPmvrvDVR3N0N4VgtmkQaMTJPChrVSg==
X-Received: by 2002:a17:907:d1b:b0:b70:4757:eb14 with SMTP id a640c23a62f3a-b70708f47femr688905666b.10.1762182904245;
        Mon, 03 Nov 2025 07:15:04 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:03 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:44 +0100
Subject: [PATCH 04/12] dt-bindings: PCI: qcom,pcie-qcs404: Move QCS404 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-4-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=6892;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fRCCTTQtkmskj6hjCG7g0ZK8BRFz/06lAV1QM0WwAQE=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbnZeQOrrJg5KNngoIPwnZo26ZOFZVh1gJSv
 TkQROidDveJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG5wAKCRDBN2bmhouD
 1waqD/sGI+q6pJqbi7PSXchPg9OI9ea+TiFFoPvPOyPpH1UsAyVSlpz9BtGnr8vyp7CV/mJ+2ej
 s48NLEVogMV5nJcI2XW6gwp5lIcB3LJv70Ejt5gCsWsi7TDTyPVtF/w5yUuX43TNb+TW6ZZEOzf
 p6f2HcxbefOGrLtY5SoDa6Ehv1CrRohKDPgXOElrZEEtLoLkQUGscdVJ+Y1MuSeTZHhVqK4rNO3
 vspflW59xQdv7nvOMCtu+SJwycZI0G9SJ5CjlPKLgqkVS+Z2l7nlOB1LVaA42VtI54XPC2eF23i
 kM1280oCWqP2+uP5x0gasybk8S0xJ1VVP34i02AEvGs0iLm8xCWwwB2owFDzezCcNGGu85cR9ee
 FtD0aXBcokAEDlFYTXmCo208XC3c3cdAhnKO9Z3bghkmIs3MZZ3HmNT/u/p62geKiHhT5Sszv6Q
 YsQ/wnmTFubn0yjNgfJwnakNye7xhLfWOjxP5aZCz/jOIYe3yp5o3cdofho2Tx7C85NXgAP6Eol
 VIq+lunmlSpIOdC3i5cX2eWWTHmi+ILf4xwfL7NnPkqhREHLi9H3SzVq8oAK16bz3dw1vIV2EO9
 JY4RlYo0a4hKZJe3QCfgnQgi5hhQsMjrN9lxW4klJW6F9AIdRBOef+3QW9oEAOJxvplezWgVorK
 clYoRi/8q9jE2Vw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move QCS404 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-qcs404.yaml  | 131 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  33 ------
 2 files changed, 131 insertions(+), 33 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-qcs404.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-qcs404.yaml
new file mode 100644
index 000000000000..99b3ed43b87c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-qcs404.yaml
@@ -0,0 +1,131 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-qcs404.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm QCS404 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-qcs404
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
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: iface # AHB clock
+      - const: aux
+      - const: master_bus # AXI Master clock
+      - const: slave_bus # AXI Slave clock
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  resets:
+    maxItems: 6
+
+  reset-names:
+    items:
+      - const: axi_m # AXI Master reset
+      - const: axi_s # AXI Slave reset
+      - const: axi_m_sticky # AXI Master Sticky reset
+      - const: pipe_sticky
+      - const: pwr
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
+    #include <dt-bindings/clock/qcom,gcc-qcs404.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@10000000 {
+        compatible = "qcom,pcie-qcs404";
+        reg = <0x10000000 0xf1d>,
+              <0x10000f20 0xa8>,
+              <0x07780000 0x2000>,
+              <0x10001000 0x2000>;
+        reg-names = "dbi", "elbi", "parf", "config";
+        ranges = <0x81000000 0x0 0x00000000 0x10003000 0x0 0x00010000>, /* I/O */
+                 <0x82000000 0x0 0x10013000 0x10013000 0x0 0x007ed000>; /* memory */
+
+        device_type = "pci";
+        linux,pci-domain = <0>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        clocks = <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                 <&gcc GCC_PCIE_0_AUX_CLK>,
+                 <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                 <&gcc GCC_PCIE_0_SLV_AXI_CLK>;
+        clock-names = "iface", "aux", "master_bus", "slave_bus";
+
+        interrupts = <GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 224 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 268 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        phys = <&pcie_phy>;
+        phy-names = "pciephy";
+
+        perst-gpios = <&tlmm 43 GPIO_ACTIVE_LOW>;
+
+        resets = <&gcc GCC_PCIE_0_AXI_MASTER_ARES>,
+                 <&gcc GCC_PCIE_0_AXI_SLAVE_ARES>,
+                 <&gcc GCC_PCIE_0_AXI_MASTER_STICKY_ARES>,
+                 <&gcc GCC_PCIE_0_CORE_STICKY_ARES>,
+                 <&gcc GCC_PCIE_0_BCR>,
+                 <&gcc GCC_PCIE_0_AHB_ARES>;
+        reset-names = "axi_m",
+                      "axi_s",
+                      "axi_m_sticky",
+                      "pipe_sticky",
+                      "pwr",
+                      "ahb";
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
index 68cae47c2ef6..df58e52cc0b9 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -29,7 +29,6 @@ properties:
           - qcom,pcie-ipq8074-gen3
           - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
-          - qcom,pcie-qcs404
       - items:
           - enum:
               - qcom,pcie-ipq5332
@@ -149,7 +148,6 @@ allOf:
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064v2
               - qcom,pcie-ipq8074
-              - qcom,pcie-qcs404
     then:
       properties:
         reg:
@@ -483,35 +481,6 @@ allOf:
             - const: msi7
             - const: global
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-qcs404
-    then:
-      properties:
-        clocks:
-          minItems: 4
-          maxItems: 4
-        clock-names:
-          items:
-            - const: iface # AHB clock
-            - const: aux # Auxiliary clock
-            - const: master_bus # AXI Master clock
-            - const: slave_bus # AXI Slave clock
-        resets:
-          minItems: 6
-          maxItems: 6
-        reset-names:
-          items:
-            - const: axi_m # AXI Master reset
-            - const: axi_s # AXI Slave reset
-            - const: axi_m_sticky # AXI Master Sticky reset
-            - const: pipe_sticky # PIPE sticky reset
-            - const: pwr # PWR reset
-            - const: ahb # AHB reset
-
   - if:
       not:
         properties:
@@ -526,7 +495,6 @@ allOf:
                 - qcom,pcie-ipq8074
                 - qcom,pcie-ipq8074-gen3
                 - qcom,pcie-ipq9574
-                - qcom,pcie-qcs404
     then:
       required:
         - power-domains
@@ -588,7 +556,6 @@ allOf:
               - qcom,pcie-ipq4019
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
-              - qcom,pcie-qcs404
     then:
       properties:
         interrupts:

-- 
2.48.1


