Return-Path: <linux-pci+bounces-1820-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 164948270F3
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:20:22 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 797351F2327E
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:20:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 932BE47A59;
	Mon,  8 Jan 2024 14:19:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="lGcTLKij"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f45.google.com (mail-ed1-f45.google.com [209.85.208.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A756146B96
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 14:19:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f45.google.com with SMTP id 4fb4d7f45d1cf-5534dcfdd61so3304016a12.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 06:19:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723574; x=1705328374; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+78zlVt1FV8yyOp2vqGnSaeurNFRzarHLtyM2gLYMeI=;
        b=lGcTLKijVCDp7HFFp0s3Sq+fr1iPKFo6jjiwsplCKH8X7Q/Quy9VkmxoRnRdUkJCV7
         SfQ9r1tHb6nDU7KqFjXTeLemL7Jbka7oHGm7lbv7gLOosyflbpzYEoSedeTr8Y7ePEK3
         sdUB1U2a/aN+/Y/fCq6ma7WT3pi0Cq5lDxUmqMbVPIq1u723ujdJVwDqwYj29AsNjnBB
         KvgRaHGKZV3VKNu0cZve8x3b1VF9hyVV+Zdba5r9u7jB9QF8fLvlAeb1bMSrT5LdEwr0
         y3bTH52tjg9N5Hng1iS3r369WpUxkc2r6O7t0ErxM3Tn8OMvl8tBFFB8eskscFidHsLy
         LUcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723574; x=1705328374;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+78zlVt1FV8yyOp2vqGnSaeurNFRzarHLtyM2gLYMeI=;
        b=pKdW231bryJ4keyPU17uaL/HXcJXHEzUNci1Iws0RCHaIeaNomjysPcVGO8xKtLwQ1
         doxO2Xeqlh9jlaX0NOU3hGKTCF/Fp2R4hQG/8CwxNSomCpzmBzXonkl9XafQhhdkCJ7F
         iGNI4FfrzjACsbR+GudVONRR2XU/1MXKAn5z2aOUN6wekzSSehDAvcu2A0XW0bQC23pX
         hTBRI/vNPJJFB19r6ECz1+i8iGhfQJw/iwJ4CP1efu0UL0b82JBmnKnLauX04zA4uUZs
         A96fNKM85kkusAWnoYLUURQ5IS6xazYG/2msqFJDgJ2KS4OLKskErQyfk5HMR1wePVPh
         hNVg==
X-Gm-Message-State: AOJu0YxhQIkxrKdNHLuPtfmQnm8di4VH5Dgj3TjShxRgaWIrR+VZ39m1
	4EdCvWFtA7fi+WcqtDyLRG++Mj3iPavO4w==
X-Google-Smtp-Source: AGHT+IGXx4D8W9yRqemsnU4p+Rf0h4Dvj7Du3AEs2vn2cgRufRWQtRHd3g6m7U4mPrYJGg3XkIw6TQ==
X-Received: by 2002:a50:9f62:0:b0:556:86ae:48cc with SMTP id b89-20020a509f62000000b0055686ae48ccmr3455741edf.3.1704723573891;
        Mon, 08 Jan 2024 06:19:33 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id cm25-20020a0564020c9900b00556ee10cfe3sm4319832edb.92.2024.01.08.06.19.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:19:33 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 08 Jan 2024 15:19:15 +0100
Subject: [PATCH 2/6] dt-bindings: PCI: qcom,pcie-sm8450: move SM8450 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-dt-bindings-pci-qcom-split-v1-2-d541f05f4de0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=10937;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=tpvQUXvg5E9u86IBOEmNel446qGis5zrjX+q7vXISSk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlnARsx69OmRrKdYl3w2pSnLG+UpmH+GF05InmJ
 9iJUx+jfuiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZZwEbAAKCRDBN2bmhouD
 13jcD/9CXd9QJR2rI8j6JwI5dvbq6iXerljPjdkpfkAtlZuk5eh8APlApOz/wL1MFKtZx2vNomI
 Ooawu3qliH4X3I4XRqvP17mudthyOOKYdhmj42k0vIRAYjsk9mMQU5ncc3bzE2DTJLgJEsqdc9P
 g0hGWWaW6ObNsWe3jPGAh0ZqPlI7Dq8EV5fLHza0gnZZ5X8NjzhuSN4GGKNdCoiRSjT5U2a6dE2
 Z7YrcRJvAkEBHsxhjdw3ATB89Khs2nHOhcYFzROc4kOzw/EjCaH7UutogwT/Sys/er5DQSz7R0y
 Ynjiylcty/tN5SaIEPUeuGnLIm27mR7wyc5HTregOGXuBBJhFWOdYAoPu9+XARW0/n/yBkIjLaf
 ZafUGuz+XZfZTFOBgniWEsn/OBpvGJmky31tHcT9GclNEKETxzM56cPKqnu8SMt0MRxsJkZoRl4
 QhYRjD5qRVukXrHGEDaaFaq5kLaFe9+/yMPi/ZEeWaoArB0QWe25IQj0mnEUBfLoi5uY2rmj3VG
 Cd182GKSDwW4g9vRZnUJEk1AIQCmvzD6F1Xop0SPoxqEAJRiCqZvdJdbKgFl6NUw0+BguzRkLgN
 lPkk995V+UvXtDSidcY9xN29Ft7obTRFNl12EM0IR6Ui56GXCQFzpJcIPirDwHhqYI8fpI7LPSA
 IlOipCF5gkY+c8Q==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8450 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except missing required compatible
which is actually redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8450.yaml  | 215 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  67 -------
 2 files changed, 215 insertions(+), 67 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
new file mode 100644
index 000000000000..59ba809b6204
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8450.yaml
@@ -0,0 +1,215 @@
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
+    maxItems: 12
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
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8450-pcie0
+    then:
+      properties:
+        clocks:
+          minItems: 12
+          maxItems: 12
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre0 # Aggre NoC PCIe0 AXI clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sm8450-pcie1
+    then:
+      properties:
+        clocks:
+          minItems: 11
+          maxItems: 11
+        clock-names:
+          items:
+            - const: pipe # PIPE clock
+            - const: pipe_mux # PIPE MUX
+            - const: phy_pipe # PIPE output clock
+            - const: ref # REFERENCE clock
+            - const: aux # Auxiliary clock
+            - const: cfg # Configuration clock
+            - const: bus_master # Master AXI clock
+            - const: bus_slave # Slave AXI clock
+            - const: slave_q2a # Slave Q2A clock
+            - const: ddrss_sf_tbu # PCIe SF TBU clock
+            - const: aggre1 # Aggre NoC PCIe1 AXI clock
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
+            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi";
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


