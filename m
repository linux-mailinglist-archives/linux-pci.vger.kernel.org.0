Return-Path: <linux-pci+bounces-1821-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 865BA8270F5
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:20:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF96D1F232FD
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:20:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 38E2347778;
	Mon,  8 Jan 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="x23WcbYw"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f41.google.com (mail-ed1-f41.google.com [209.85.208.41])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 49DCC4778D
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 14:19:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f41.google.com with SMTP id 4fb4d7f45d1cf-556c3f0d6c5so2148448a12.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 06:19:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723575; x=1705328375; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=AYUdL9LhigCUuNxpKQSG3orhjjUgFykStJlKLI4UJXQ=;
        b=x23WcbYwVeBYtT/wsCVJ+n21Nuq3uLER2CGigxmZNcpAMVpRjx/J1AnP5cwTV1QUC2
         tIog/oLV5CP7gr3jUbzpT7XK0Jjs87GP0YCKIj9HUKZ9BpaqTeXl4Yfwhp4SKUyNZY3t
         CfCRltstRaQ8xLzkVfgBHb/Yc+giRNrolP7w7ixdDjeovBoTHtLDNOYxd58sU8BO1yQW
         ZpuMsnt3IZ97a3EJQnKkM1BrlMRWqjXS6Gd4qxDioEk8w3M351qBAte9kWId4YUO1nDe
         k6g4gGMdP0iGhMxVFJC9utWAhTOEBjoSHHpk5SqawDAgozErHQW+rRsy61qiFi7ksWng
         CiRw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723575; x=1705328375;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=AYUdL9LhigCUuNxpKQSG3orhjjUgFykStJlKLI4UJXQ=;
        b=iIAsId+W/ZXelJrLE43nNFrYEhOL3wMnlgFEXxuTIfSiFKi6f5S8tYsi7Q5U3DipPs
         scrxmpyPJOjrgVyusgFfymNGBWZTeUrofIu3mS+Q1FDn2AI2o2xdKdiJJDsHpbtZ4LuI
         wxJrxq0DVPy5AUuc+WL+Uf8HhJfB26ogbKwmgwWEUBNQkzrc/1R6ZL0XuqAPTmhgcRaR
         p/Q1Yt1LNX+Aulknnps5nq0yRZ+7grwdne/8zVj3gVviZ2fHzbbTMC1QeJGITI4G/MA0
         qwe1+wxznen1UWdIVjtIADLH4jOFgs6G8AtVAW5t9EDhrLeAVLHbzq3aDUxIyzlCnn4U
         IKOg==
X-Gm-Message-State: AOJu0YyusISewb8O6uG2k4AOt9f7A6NqAFMPAcFBSMtjrCP0yrxOkMj1
	2cGQjtAlXjBm1J6LsAIMz6fNwRSoNxkDcA==
X-Google-Smtp-Source: AGHT+IHodgCGxlYFECuk7tEpv9qqfelHDER75/CPSDGqne5zTsKnw2Ne2K/eSeSVyJde46rcFDGYEg==
X-Received: by 2002:a50:d602:0:b0:555:5879:ac50 with SMTP id x2-20020a50d602000000b005555879ac50mr1286331edi.117.1704723575687;
        Mon, 08 Jan 2024 06:19:35 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id cm25-20020a0564020c9900b00556ee10cfe3sm4319832edb.92.2024.01.08.06.19.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:19:35 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 08 Jan 2024 15:19:16 +0100
Subject: [PATCH 3/6] dt-bindings: PCI: qcom,pcie-sm8250: move SM8250 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-dt-bindings-pci-qcom-split-v1-3-d541f05f4de0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9582;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=n+U3UP1WPgFwGBXXZYHM6zXxzBW41C5KWTwWZh4Wlww=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlnARtbAn8FvKzZd0s9O0WHt1pOMGQ1bj3oyWxi
 1C5AS4HBs2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZZwEbQAKCRDBN2bmhouD
 14+sEACX13p5qiDBDTJ8pnItvqtp5Bed1/J5IhvgyhjwpWRtJBV7AOjs86lJzgqsfrNBV84UVK4
 FH/Zt+5nS+t74mWtDJ4f+gTgswT0zvCyUDT+8FdYn1afvI+RBfhqlTTBUOdXslWfz4PJQZazWwQ
 3VyJDXakUOTSRKtepOPpslHA4eanCfLzqn6Vt5dWMhka0ztsL7h6GQ8H+5eJugi2NDJK1L9iz0N
 fjxgBdRptdaf2H/w0R+2EEMzZZuOIvtxnYnZMnUUnWOYq7PDupkE/5qSTqFpklC57HemYwjAav2
 i/6NUq+AidL9fVQt30rK7J2H5u9mFQB4kKWhOl+a+gV/fJjnM5E63N140wX4n88hdddCi2Bl5O/
 LfVocwK0bF7TGNcnr2eO5SXPdMx7xVnGzHFEDNPyf5ckAFQgEp/400bvPPU0oI2ni0/+n4iVGfZ
 /8h4yJZfSfmgAOaYPHAf7wmC9lSS9xROwWxeiSX99P7IrUnZnAgp3Hr5bwFpESnlt4rzalCI6pb
 hxiQBGuQRFgvLCAfYjuvlPXp9gmofR07x7bIJ14OkUD1N22CLEgeJGq2HdMktutWyZLHJHswEuN
 7riRjWkIIGKQ+AkkUJxf/QWeZHcf5B61oFqTBO0zhLSfpmZPPrDT4TqT5U5WTy8sTJuXcUjPwXU
 U125aN7ywTCbbxA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8250 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except missing required compatible
which is actually redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8250.yaml  | 180 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  48 ------
 2 files changed, 180 insertions(+), 48 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
new file mode 100644
index 000000000000..f668f0f2e497
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8250.yaml
@@ -0,0 +1,180 @@
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


