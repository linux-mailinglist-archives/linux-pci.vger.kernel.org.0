Return-Path: <linux-pci+bounces-40115-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id A7D7CC2CC68
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:35:13 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id CAEB9189E23A
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2BBA6328612;
	Mon,  3 Nov 2025 15:15:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="hdiAQeK9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 489CC328B55
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182917; cv=none; b=OMHKNpTP7zubNotL8KviF/SBJe37tGQhF+E54NB6C7+93pgx1xqfbgVGI+yH3Z9gmTGAGOfnZmds8rwMzg7dwaGeVmV5+uN1bT2qfo1xC+fdn5IxeTJbs327kduFZAeHIZWjv707FMLi77FUuq3diBI452FkaZp+BrUZmnFdBQ0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182917; c=relaxed/simple;
	bh=EdqAb+QTLdzor0jomhHKcam0nKS8WZX2EFMgXyS87bo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=nTUm4tlTGbTsRt+pVsn74aXrSWtrDMOMmxS6/K9o1yHkxmDBOqgb7IPs0ycuV2uskwShlYdwzO2eSOIThENhVsn947MH5KGKg4mxK1tirABFPOzQHgzcxF0CSF1ATuEqcGsr4LHpUYqFRTVmeP4WJA7Zw+OHnw17GWuqU3hcUBU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=hdiAQeK9; arc=none smtp.client-ip=209.85.208.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-64096b85a86so384991a12.0
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182913; x=1762787713; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bP55BFojGLn6ZNuGYj2iTi5j3Dqka9a3d+sXrd5Rfu8=;
        b=hdiAQeK9Gx83jAorrqw+SBwYrru4IuJEDPn2a3Lrx4axWMtZ77p21+EDcykxPawun/
         NCFSOeLWe9m7o1XDx8f9ymagkemXpCHS/aTAsDZTfsSVwyZM/o0K9FQ6PPnty5evvogQ
         UWMjEMXGxVNEOevC+iFiFsAY8gReb0SG+GqHfcqO7zHE+lqSusQUb+/KWJ+ZVAgmiwj6
         oKKtkY0InHFFgLpFJtFIyTE2lT4S3nPa2ayykYQu6jgBx1/dJ0VNJoedc68J3QLmcS6O
         K4HgL74+qV8fkuKPTfbP5DzVMge0FHaZjkDpv52CTEqpuQlRLi7nkwCi5IYJUKBYRlYf
         y4yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182913; x=1762787713;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=bP55BFojGLn6ZNuGYj2iTi5j3Dqka9a3d+sXrd5Rfu8=;
        b=AM/EATXT4OljI2pNvRaJTscr3GB/13ba27YcB2pEZPziGeXJxrM6vZ6xem/lYk+Ujl
         5Z6PzV3v9og+kJxStLU/Nt56G6KTuj6owg9NxzFH6GZHI+6LRKnKTkWlLhlyEclkviBO
         YzRUOrT0ZQ2VAkoRpSfyxBN0s6+mbFYB4Qa4i2l8A2AxzjGUANpkP/gzvbMQ1/spWcEC
         2zXT1UmXo81SIfJA1xGGMYK0UA2V8yERqxoujdFJaQ7mpJRVkPsxRAdvOJHa00GFE2Gw
         1q7YvH47Hruw0/7Z+0+x7KQMipWnymqvvTQx+S2hD+7bWh2boX1ZULdyGgX8OT4Yim/J
         sZMA==
X-Forwarded-Encrypted: i=1; AJvYcCXiLTmCafNFi91z+YtzCZgBqwwO4ozDJMR3wkXKAB2+IO0WO1ZRdVotokqVw09UCwMIBOjfBMezFpo=@vger.kernel.org
X-Gm-Message-State: AOJu0YwYV0GWggUT2i26uGLAjEtbPfNUa8O2ckmwDCgDKKZnM7nIyb69
	E9Pme9Vw569idLq6WUz/J17rAM16blAKeP9N35p+yTp+Y21IB4BmeU981PBqP6459Uw=
X-Gm-Gg: ASbGncuPpUt0z6OW8wTyJ4o1pYkcW8Ekej3Ym2GdkCepnuD5XmuZOxTArpelmzQpefL
	7j0IHZA4ZbztoNhUokAyhbenXsLY1fc2k63ERc9SX8IPWxCIptyRv8JDiCP4x5d3atwnzl7QPym
	g2REMm+lxyVpP9zdLZxZqp8LZKTVIiUYeMaG+bjGsbeky10UBVlrHLLpbSamFySH64b9CNM5+Du
	eBfTj67TRRCYes/A5J9srPL+7GrcC92zkjWNSU/ld4xvlT5gBlSuMkpNlgdjHCD0wIpmQbiPcsh
	sFjfielBg+1P+1G5FRRgmAE9Xeux820X32s5PI7+k6U8ZY7Xwg1oelkA3lfQyILzF+UQ+53qgDf
	yAWwrgE/GjjnBiBhwKxiYT8sd9nL8o8MQ/C6cyhcdsX8dLox2w0/G2m2njhNbyJXTxKXObBoY0w
	XWSz9zAhH7TCTVz5buMFlAQFWrj7Q=
X-Google-Smtp-Source: AGHT+IHjbubUS+X+NEgxmES4CkHnwB6udchMGFD7akUPgmMm/FuvoavlSxK3tykSTHZPnBxbcCvWpg==
X-Received: by 2002:a17:907:3f13:b0:b65:c8b8:144f with SMTP id a640c23a62f3a-b70705fb91fmr581926566b.6.1762182912646;
        Mon, 03 Nov 2025 07:15:12 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:48 +0100
Subject: [PATCH 08/12] dt-bindings: PCI: qcom,pcie-ipq4019: Move IPQ4019 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-8-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7615;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=EdqAb+QTLdzor0jomhHKcam0nKS8WZX2EFMgXyS87bo=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbqqaZ9LTptcbEg4uhSefLjp+85I/Ut/mMVu
 H9nfwbNr06JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG6gAKCRDBN2bmhouD
 1/7JD/sFEdKV1keZziofkPvYVBb8IX16CWFlZfjn8Ro/QQ2o80DxPldefYyUijIseFZr+KyWyYv
 URU14WcfYGjNStpjW5YE4dhkJwET1yvPMLMEnneOkkuVsHE+hzBvQwGA2mm/SYSI3EewvR+/ckH
 s1LIW6jQ8QR9D9pXXgpPTmE6qCpH/tjZ+wjuKy1/V1SMN8s4s02RJlWr9/K5RvpCKRGsl9xNmuz
 dAyFyjB3enxj9nSPy4K4kNy1Ct5dV+gN9FGcoUECxQUJ+v0yNLUkKT6CY8Zf4vD2xmvfoI/9iJs
 ATMFLPc+ate6t8OCqPxyFg2IoTlm/XCA7WnpdYdNf7EjFLSKFklMpGh2oBX6LjSvndDvzKn5lBr
 YhANiNu2uzvgL7ki9D29dy9HeYRrCuUia+P1RBEbOvnFxVuRzxNOsmBmKSqCI+hwReAUgZWHYbo
 hvWRs7NZNdTOhymuhJUE6qjml0pYBABzFiZmhNP8ctpFON/apYYEs+bVcRQrx57yGe3ZMs41bUA
 Jioq5QKu67A8xLt8FjBJk0IUV2aV4fjmWQVITvfxkbIJG96gKO7G3OuujDezw1AnMHfw+HpKKAL
 Kf/9jeIRB5sYsTmLOj5+EUcBbMarrIpG6u03IHGC8CsTaBkocCFj0z55aMwhZNBNnZFwrLAJJUP
 RrNXPot3NCn4QeA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move IPQ4019 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq4019.yaml | 146 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  38 ------
 2 files changed, 146 insertions(+), 38 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq4019.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq4019.yaml
new file mode 100644
index 000000000000..fd6ecd1c43a1
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq4019.yaml
@@ -0,0 +1,146 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ipq4019.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ4019 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-ipq4019
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
+    maxItems: 3
+
+  clock-names:
+    items:
+      - const: aux
+      - const: master_bus # Master AXI clock
+      - const: slave_bus # Slave AXI clock
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  resets:
+    maxItems: 12
+
+  reset-names:
+    items:
+      - const: axi_m # AXI master reset
+      - const: axi_s # AXI slave reset
+      - const: pipe
+      - const: axi_m_vmid
+      - const: axi_s_xpu
+      - const: parf
+      - const: phy
+      - const: axi_m_sticky # AXI master sticky reset
+      - const: pipe_sticky
+      - const: pwr
+      - const: ahb
+      - const: phy_ahb
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
+    #include <dt-bindings/clock/qcom,gcc-ipq4019.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@40000000 {
+        compatible = "qcom,pcie-ipq4019";
+        reg = <0x40000000 0xf1d>,
+              <0x40000f20 0xa8>,
+              <0x80000 0x2000>,
+              <0x40100000 0x1000>;
+        reg-names = "dbi", "elbi", "parf", "config";
+        ranges = <0x81000000 0x0 0x00000000 0x40200000 0x0 0x00100000>,
+                 <0x82000000 0x0 0x40300000 0x40300000 0x0 0x00d00000>;
+
+        device_type = "pci";
+        linux,pci-domain = <0>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        clocks = <&gcc GCC_PCIE_AHB_CLK>,
+                 <&gcc GCC_PCIE_AXI_M_CLK>,
+                 <&gcc GCC_PCIE_AXI_S_CLK>;
+        clock-names = "aux",
+                      "master_bus",
+                      "slave_bus";
+
+        interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        resets = <&gcc PCIE_AXI_M_ARES>,
+                 <&gcc PCIE_AXI_S_ARES>,
+                 <&gcc PCIE_PIPE_ARES>,
+                 <&gcc PCIE_AXI_M_VMIDMT_ARES>,
+                 <&gcc PCIE_AXI_S_XPU_ARES>,
+                 <&gcc PCIE_PARF_XPU_ARES>,
+                 <&gcc PCIE_PHY_ARES>,
+                 <&gcc PCIE_AXI_M_STICKY_ARES>,
+                 <&gcc PCIE_PIPE_STICKY_ARES>,
+                 <&gcc PCIE_PWR_ARES>,
+                 <&gcc PCIE_AHB_ARES>,
+                 <&gcc PCIE_PHY_AHB_ARES>;
+        reset-names = "axi_m",
+                      "axi_s",
+                      "pipe",
+                      "axi_m_vmid",
+                      "axi_s_xpu",
+                      "parf",
+                      "phy",
+                      "axi_m_sticky",
+                      "pipe_sticky",
+                      "pwr",
+                      "ahb",
+                      "phy_ahb";
+
+        perst-gpios = <&tlmm 38 GPIO_ACTIVE_LOW>;
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
index 992a7654626c..65caf5b5623d 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -20,7 +20,6 @@ properties:
       - enum:
           - qcom,pcie-apq8064
           - qcom,pcie-apq8084
-          - qcom,pcie-ipq4019
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
           - qcom,pcie-ipq9574
@@ -140,7 +139,6 @@ allOf:
           contains:
             enum:
               - qcom,pcie-apq8064
-              - qcom,pcie-ipq4019
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064v2
     then:
@@ -258,40 +256,6 @@ allOf:
           items:
             - const: core # Core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq4019
-    then:
-      properties:
-        clocks:
-          minItems: 3
-          maxItems: 3
-        clock-names:
-          items:
-            - const: aux # Auxiliary (AUX) clock
-            - const: master_bus # Master AXI clock
-            - const: slave_bus # Slave AXI clock
-        resets:
-          minItems: 12
-          maxItems: 12
-        reset-names:
-          items:
-            - const: axi_m # AXI master reset
-            - const: axi_s # AXI slave reset
-            - const: pipe # PIPE reset
-            - const: axi_m_vmid # VMID reset
-            - const: axi_s_xpu # XPU reset
-            - const: parf # PARF reset
-            - const: phy # PHY reset
-            - const: axi_m_sticky # AXI sticky reset
-            - const: pipe_sticky # PIPE sticky reset
-            - const: pwr # PWR reset
-            - const: ahb # AHB reset
-            - const: phy_ahb # PHY AHB reset
-
   - if:
       properties:
         compatible:
@@ -369,7 +333,6 @@ allOf:
             contains:
               enum:
                 - qcom,pcie-apq8064
-                - qcom,pcie-ipq4019
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq9574
@@ -428,7 +391,6 @@ allOf:
             enum:
               - qcom,pcie-apq8064
               - qcom,pcie-apq8084
-              - qcom,pcie-ipq4019
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064-v2
     then:

-- 
2.48.1


