Return-Path: <linux-pci+bounces-40113-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 266B5C2CC0C
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:32:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 798EB189284C
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:25:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EDFD6329378;
	Mon,  3 Nov 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="abwPOHaf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f51.google.com (mail-ej1-f51.google.com [209.85.218.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 28C6E328B57
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182912; cv=none; b=Nc7VY242WMHHf9J31TvLeJBppsIkPJKIxKUa6ql6m3v/Y3ghrRxfisOUNxkl+MMvTRL99dx0a9F/aT3SQo3RuFfK1pe+XN8l1L/UAW8zvRzIuP8gVcyT9jzulPr461Wc0FLv36xWgnAomj0SZDR2XM6+672JD+D4i2rf3mKu+Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182912; c=relaxed/simple;
	bh=p3AzcyU+H/9sEOD7LW+1tv/WG5FiotCsXmVG43juuW0=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=FHxtRNHXqGYP/55ZV2OAB/iluAhaK/7bSiit2/l5reB8HvfyWKJ0DG3lq/k+2IdZixvsrASyk1TUk4Vlz5eM18jbwdVtkvc6BSbCHYLPXpvlG+mNbe6DjXFAeNFHExMWa+tB0A1wxaoHEB5nW79VbirDq7woXvqKjmmzkRVIJ0I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=abwPOHaf; arc=none smtp.client-ip=209.85.218.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f51.google.com with SMTP id a640c23a62f3a-b70afc39b87so9897766b.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182908; x=1762787708; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GOODgpMATagSSC9KFsjykKjx9bD/uygf2I/R8zmo5LQ=;
        b=abwPOHaff15tT+JdQQrXujwYPvYmofg7gp8cfWV5re4NfzUseWQ4bRPSD5ItnGqO9a
         FoE+aRra4lbB2Nzv3kmPuMU2yX8gZKf52Y4Uv0aQQQVfAsirRJJkHhyOlXW6rBOa/9x0
         HUbSPEfsKxMv267neA8qz51byH7iUXyYbt48hcRX70x+emEAg0JXLI54OYS4r4CuUQjy
         b7HMACUFg70V1Jj/ToXcgofXNiOqoES6jS9iWG+97GcZZSNdws1rh84MBJ32WNSyyons
         9Xpu+96vXjR9xmc57ippJW9pSGzSqEO5UqVWf8JxFrsGvWBeHQ1V20agsojDYK46lPOz
         N28A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182908; x=1762787708;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GOODgpMATagSSC9KFsjykKjx9bD/uygf2I/R8zmo5LQ=;
        b=NhgGHpo+SoU8ApyPNgjEwwTa+wI0cZM0r3qtJFHfezgtyF+XePiZr/nz4j8TRiMjIi
         jaanZtzglPIJBxS5yQNkJNuLbAyXIh9Pk5+YaWHExLvGJE41q0Jg8whkMV/5alYaktP5
         RcI1KxzcFjnXzOh70Sc0YLz4ShSf1BVmdagFkVXbNYJOiPOcX+4RyxkmltqrGyIWIG8H
         eM5XRBCGn7G/ueWYFlqhVmmkRzlCCQ6AEHB8sV9K74C71x49Xv08jH1hawpyqtpizFkV
         q7JcY/CwB50jZLSeCJoLezEa3+Tb6WFUA0TsntgHUfxhrrse3MAdGmVXJsN7fe4JSj4b
         6u3Q==
X-Forwarded-Encrypted: i=1; AJvYcCWc2v03as2XFhvxb0H9RO++wcCCi0olIB7LlsBvErN2uf63cm9cdxK7S2f3Y3E+0aNfdYoHkwQN8hM=@vger.kernel.org
X-Gm-Message-State: AOJu0YxGgajjEv4m77SUBOqEXFS3J74HBbv6OLPrAVteBpH3wroy7iIY
	gBHqt5ziWHmtz5K5LQ57SXM6KSUM8A8QBqKT4NH8cerd9Km6onh690Msq7dpQFYNRBA=
X-Gm-Gg: ASbGncsQUUCpFS2r/RmSAQH7jIXA7HKmENyifCTYu7Dlky9JZd3+I/Ct9sh6hpj/+wr
	IK00zRe+d43vqdloU3EcaCo9zVj89gtWXX4oXlyeSChHyIpnuqNPEGQm4Bu4z5o6LOPImnmwTBB
	4+HR31T6dVzNZrX69Rs7zLhmbqOFrJuRs+QIzuzANH96StVXIR5uaRcOJ1Mndz9bgI52OkiVnFj
	UbHEin+kumW9Ju8smh3IA0Nui2OlzlqS57SSUXbjgqC+QJmHcvrD/GhVgJu39JeeHINUKU00snz
	UFuA7BZ1uQSzZuT0rlpvZPtuBYWfKp/2X96fh+rscx7v4Tym5HSYtH6cO1YPNwzt0vK9EYpG6Yn
	UbsbdnDsMlvGvTE584p9X6Z7wgpzsgnsj02UfuO1chFfN1k5Xzi81qBEgu4QV0HBmxqECf6RS2j
	HzUXc6XYpZ0Fjh+W9k
X-Google-Smtp-Source: AGHT+IG4+g7j92ddw5ameEoEah7u7IcNne+nrGlKg3I2Mn/gp86D6SHRvwB/e6apkijHZ4Fe8ZzWUg==
X-Received: by 2002:a17:906:2683:b0:b70:bb39:6f34 with SMTP id a640c23a62f3a-b70bb398a8emr174421166b.1.1762182908431;
        Mon, 03 Nov 2025 07:15:08 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:07 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:46 +0100
Subject: [PATCH 06/12] dt-bindings: PCI: qcom,pcie-ipq6018: Move IPQ6018
 and IPQ8074 Gen3 to dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-6-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9703;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=p3AzcyU+H/9sEOD7LW+1tv/WG5FiotCsXmVG43juuW0=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbpdAq8welPQGIMbEK9HXVFZ2NyfUOYM7h/7
 5EP00xRZg+JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG6QAKCRDBN2bmhouD
 15rrEACWV0DdUGegpjXynBFDXwWL+nojgD+V5+Ad+yDR2umfYdM7QWiVX6f7s4Gyl1XYQYADINc
 labHDTGFk+QFHCu6Qmbr8eCsm9dA3SQySVwGVA0F6JxtjCs0jzGIU3PLSxsjBQIz8qmCLRjplyF
 xxwIx6Gx+ouFaeVKqvRSM92GHtL/SF9LqT4aoGKAnbrRTOjATIQd3QnSot4PJC3yj4Bnv0md2lc
 x2liLnvLJdOMSjXkNyMviIUqEswLPvNJ9b+Co9vz716UJZ01ZEoB9eaWGVUHhN0Nix/7YkCNPuQ
 iaAg9eND63rOcMm7HxcMZzC1lYhftzhaCOgIyBiO0lQCAd/sGtWrrf/2U/WzPFzgYPjaP1xW035
 iKh9OJh2Cn7A4Jy9cTCwNkGWNZGuLCSazjgRsGX+FL4T7EObG7CoVM+GAOJomtlkaa5r30VD1EB
 NBaIoxBEI84AcJssrZKnZdxKiN99dNRi5uuuFWG8B1Vmodc3A6/ZzP5R6JmDpv73p+baBuF+6z0
 ENMOMe2i9AuhpjAUMFaHZ6Otcmc1U51VJdMM2eSaylua1Qt4qxAuTbYE2PqUSrRAvKZVVcz+/B6
 4jmcH3izNpqnlLi07Sh8NINq8Rmw4G1VAyC3BFKiORwL6DaxMPCF3yyH2akN5Ze1Wt/fHZIaLUD
 sgcWB0ns2K8U1MA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move IPQ6018 and IPQ8074 Gen3 (which is the same as in IPQ6018) PCIe
devices from qcom,pcie.yaml binding to a dedicated file to make
reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Disallow legacy/incomplete description with only one interrupt and
   expect exactly nine of them.
 - Do not require power domains on IPQ6018, because old binding already
   does not require them for IPQ8074 Gen3, devices are the same and
   in-tree DTS lacks power domains.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq6018.yaml | 179 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  40 -----
 2 files changed, 179 insertions(+), 40 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq6018.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq6018.yaml
new file mode 100644
index 000000000000..6843570eb051
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq6018.yaml
@@ -0,0 +1,179 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ipq6018.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ6018 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-ipq6018
+      - qcom,pcie-ipq8074-gen3
+
+  reg:
+    minItems: 5
+    maxItems: 6
+
+  reg-names:
+    minItems: 5
+    items:
+      - const: dbi
+      - const: elbi
+      - const: atu
+      - const: parf
+      - const: config
+      - const: mhi
+
+  clocks:
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: iface # PCIe to SysNOC BIU clock
+      - const: axi_m # AXI Master clock
+      - const: axi_s # AXI Slave clock
+      - const: axi_bridge
+      - const: rchng
+
+  interrupts:
+    maxItems: 9
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
+      - const: global
+
+  resets:
+    maxItems: 8
+
+  reset-names:
+    items:
+      - const: pipe
+      - const: sleep
+      - const: sticky # Core sticky reset
+      - const: axi_m # AXI master reset
+      - const: axi_s # AXI slave reset
+      - const: ahb
+      - const: axi_m_sticky # AXI master sticky reset
+      - const: axi_s_sticky # AXI slave sticky reset
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
+    #include <dt-bindings/clock/qcom,gcc-ipq6018.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/qcom,gcc-ipq6018.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@20000000 {
+            compatible = "qcom,pcie-ipq6018";
+            reg = <0x0 0x20000000 0x0 0xf1d>,
+                  <0x0 0x20000f20 0x0 0xa8>,
+                  <0x0 0x20001000 0x0 0x1000>,
+                  <0x0 0x80000 0x0 0x4000>,
+                  <0x0 0x20100000 0x0 0x1000>;
+            reg-names = "dbi", "elbi", "atu", "parf", "config";
+            ranges = <0x81000000 0x0 0x00000000 0x0 0x20200000 0x0 0x10000>,
+                     <0x82000000 0x0 0x20220000 0x0 0x20220000 0x0 0xfde0000>;
+
+            device_type = "pci";
+            linux,pci-domain = <0>;
+            bus-range = <0x00 0xff>;
+            num-lanes = <1>;
+            max-link-speed = <3>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+                     <&gcc GCC_PCIE0_AXI_M_CLK>,
+                     <&gcc GCC_PCIE0_AXI_S_CLK>,
+                     <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>,
+                     <&gcc PCIE0_RCHNG_CLK>;
+            clock-names = "iface",
+                          "axi_m",
+                          "axi_s",
+                          "axi_bridge",
+                          "rchng";
+
+            interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0",
+                              "msi1",
+                              "msi2",
+                              "msi3",
+                              "msi4",
+                              "msi5",
+                              "msi6",
+                              "msi7",
+                              "global";
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            phys = <&pcie_phy>;
+            phy-names = "pciephy";
+
+            resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+                     <&gcc GCC_PCIE0_SLEEP_ARES>,
+                     <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+                     <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+                     <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+                     <&gcc GCC_PCIE0_AHB_ARES>,
+                     <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+                     <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
+            reset-names = "pipe",
+                          "sleep",
+                          "sticky",
+                          "axi_m",
+                          "axi_s",
+                          "ahb",
+                          "axi_m_sticky",
+                          "axi_s_sticky";
+
+            pcie@0 {
+                device_type = "pci";
+                reg = <0x0 0x0 0x0 0x0 0x0>;
+                bus-range = <0x01 0xff>;
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 62af2562ae2b..118b88a81396 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -21,11 +21,9 @@ properties:
           - qcom,pcie-apq8064
           - qcom,pcie-apq8084
           - qcom,pcie-ipq4019
-          - qcom,pcie-ipq6018
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
           - qcom,pcie-ipq8074
-          - qcom,pcie-ipq8074-gen3
           - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
       - items:
@@ -164,8 +162,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-ipq6018
-              - qcom,pcie-ipq8074-gen3
               - qcom,pcie-ipq9574
     then:
       properties:
@@ -350,39 +346,6 @@ allOf:
             - const: ahb # AHB Reset
             - const: axi_m_sticky # AXI Master Sticky reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq6018
-              - qcom,pcie-ipq8074-gen3
-    then:
-      properties:
-        clocks:
-          minItems: 5
-          maxItems: 5
-        clock-names:
-          items:
-            - const: iface # PCIe to SysNOC BIU clock
-            - const: axi_m # AXI Master clock
-            - const: axi_s # AXI Slave clock
-            - const: axi_bridge # AXI bridge clock
-            - const: rchng
-        resets:
-          minItems: 8
-          maxItems: 8
-        reset-names:
-          items:
-            - const: pipe # PIPE reset
-            - const: sleep # Sleep reset
-            - const: sticky # Core Sticky reset
-            - const: axi_m # AXI Master reset
-            - const: axi_s # AXI Slave reset
-            - const: ahb # AHB Reset
-            - const: axi_m_sticky # AXI Master Sticky reset
-            - const: axi_s_sticky # AXI Slave Sticky reset
-
   - if:
       properties:
         compatible:
@@ -443,7 +406,6 @@ allOf:
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074
-                - qcom,pcie-ipq8074-gen3
                 - qcom,pcie-ipq9574
     then:
       required:
@@ -466,9 +428,7 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074
-              - qcom,pcie-ipq8074-gen3
               - qcom,pcie-msm8996
               - qcom,pcie-msm8998
     then:

-- 
2.48.1


