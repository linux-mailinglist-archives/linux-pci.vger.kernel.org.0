Return-Path: <linux-pci+bounces-1822-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8FC208270F9
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:20:46 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3A6E628137A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:20:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D672247F6A;
	Mon,  8 Jan 2024 14:19:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qFsW/zte"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f47.google.com (mail-ed1-f47.google.com [209.85.208.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 315764A9A0
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 14:19:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f47.google.com with SMTP id 4fb4d7f45d1cf-5571e662b93so1555868a12.2
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 06:19:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723577; x=1705328377; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=mVpt434jNRVRohV7kr2LuWzc6/sexF7PFmFs+zIPX64=;
        b=qFsW/zte+lkO0Gyn1sGKXxu4zzMJC8zi6sWexxUIDoKy8d14M0Ao+KBLy3QGPGzkfp
         GwtFY1hQq+Yc4cFLKzOvIXvZK1V5ote8d8ly/yFndrQ6JovL24D27RgyQqzlZAOGXIuy
         enH5b78tj1pmTR3lWY9fWHPWQh+dZhK32LT+LLOV03udkD3kg9lDC8GUrOHGQgf9hIJT
         MCVO+TdFq8Lx8pc6QlxrCPdxsNeRdkNFEMZinpy0Aj3JmjcDZoJ2tIeQQXFzYBDkmmKd
         wFsMEkd/I6JtWhp4PNmSu5xJXfwHQ3ASygn3PyuIyeFs2Xk3O9GkPiLt7YgwzOSl8oOR
         VBrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723577; x=1705328377;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mVpt434jNRVRohV7kr2LuWzc6/sexF7PFmFs+zIPX64=;
        b=pKbpnE0yUGlfqPDiazR0j/Gxv3D3HFGqQLan9C7/+3aU8sRvQHM5y46zNyZ7b8JOpI
         MDBMlzK89gm0Wj4/cdV1efTGXvvbenWdCXbHmmpYu4wIVMHAdoohcF5s4z17W50K6G6i
         jYTEoK7V0sSieS4Q05o9juqItnipwzF4R2pqasA1pJsL0RFoztV39haS93lCZNGMOqaQ
         OzP/cBFgt+lY1wuoE2RFIpuI5lzp23IfMjBthC3CBP0mKvwKIX8HgWtbsYS3Q7VJZREU
         YQ0wty28jLZWk3IVeSw9qXbipLDxveDH1fZNvpQEOCXif6D2JSCFS5/w1jVGw+CReX1m
         kr2A==
X-Gm-Message-State: AOJu0YwL8Uk1pJa7Ll7YvYzQSM28MyOOui3km4oFIFwOzEhzi1Lnz8wz
	CGqfQPnB5v1uT4ENtpHuTuVkAJOhtW24Dg==
X-Google-Smtp-Source: AGHT+IHibpWAtiMj6g/1Ub2GoYdmfVeIcmSM1yTtzc72S9QHGlRzY1/1p0TUACoKTJHjbSVzf4VyZw==
X-Received: by 2002:a05:6402:22fa:b0:552:1ca9:3d51 with SMTP id dn26-20020a05640222fa00b005521ca93d51mr1926375edb.15.1704723577565;
        Mon, 08 Jan 2024 06:19:37 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id cm25-20020a0564020c9900b00556ee10cfe3sm4319832edb.92.2024.01.08.06.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:19:37 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 08 Jan 2024 15:19:17 +0100
Subject: [PATCH 4/6] dt-bindings: PCI: qcom,pcie-sm8150: move SM8150 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-dt-bindings-pci-qcom-split-v1-4-d541f05f4de0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=7378;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=Nqn0ZdTHTBHxb1tUaI+NvAqCuySp7YX/Q+1216+S1Pg=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlnARuGJz4E//2l+Z1a64pBG1KvUptgo9pD5QwP
 OSasXEFt6GJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZZwEbgAKCRDBN2bmhouD
 1+UdD/9oyLqrY5UtxAUDoU5GsFDdfL0DDOWTGP7m05AhA9sVra6wp9sU4kSm3TLT4+2tkANJikB
 viH361X3yjWudTNnD+BQuGmcL20K474isue9fNmR6ktRVR6oWHXe3lhmnXT51W5mqa82Hnyez7b
 gCoH/dpAnelYCz58ywFshqJaerWex/eBg2IjbybSScy9pnl7Vna6Egmm9d1RGV3JFrL3sc53yKi
 7Bvfez/ae+5XKaxr1Tsp4Ri25J2wrRe+1LH1MG6srgqcV9XMXfWyfwCFZY1Kac+j/Bn2rW9uNHH
 tW6M8DAcKFiDG+/VzZIFOIsaodwrf4qYo9/MEnD85P34v3ZmWkDMdZ/omuM5p+DGUAaZ7f6dXTj
 lrfb9oHYgXS2dGDNrz8gdtFy+i3b3LAKQUJXzeY7xgac3PfOjrheyhBRylMnlsJ0+Ia7rc8y1z5
 0MzQuQRsz7FF4LKkduP4z7VYt3fsAIfnMu/0KTqcUVt20VDTxJtsG8eCinriLLhW9rUCYHcgajb
 pUnJn4dhDOH6goHOamGwDOn6s1/Zgkm0kfo2jB6VYQW0blUM2YM8sQPUSNPSa/39scfRuoqIoZE
 7fyeaIwnehVwk+oUeCPA86ukq4tz2WPLT3cb+TIzVHO5zP4BTP3w9Zo9EEyI3RL2B/p+w4zygvs
 lO7GbUwC2yx7rJg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SM8150 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except missing required compatible
which is actually redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sm8150.yaml  | 157 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  29 ----
 2 files changed, 157 insertions(+), 29 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
new file mode 100644
index 000000000000..acb69501e81c
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sm8150.yaml
@@ -0,0 +1,157 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sm8150.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SM8150 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SM8150 SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-sm8150
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
+    maxItems: 8
+
+  clock-names:
+    items:
+      - const: pipe # PIPE clock
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: tbu # PCIe TBU clock
+      - const: ref # REFERENCE clock
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
+    #include <dt-bindings/clock/qcom,gcc-sm8150.h>
+    #include <dt-bindings/clock/qcom,rpmh.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sm8150.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sm8150";
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
+                     <&rpmhcc RPMH_CXO_CLK>;
+            clock-names = "pipe",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "tbu",
+                          "ref";
+
+            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            iommu-map = <0x0 &apps_smmu 0x1d80 0x1>,
+                        <0x100 &apps_smmu 0x1d81 0x1>;
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
+            perst-gpios = <&tlmm 35 GPIO_ACTIVE_HIGH>;
+            wake-gpios = <&tlmm 37 GPIO_ACTIVE_HIGH>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 14341d210063..47888b5b1a13 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -35,7 +35,6 @@ properties:
           - qcom,pcie-sc8280xp
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
-          - qcom,pcie-sm8150
           - qcom,pcie-sm8350
       - items:
           - const: qcom,pcie-msm8998
@@ -541,33 +540,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sm8150
-    then:
-      properties:
-        clocks:
-          minItems: 8
-          maxItems: 8
-        clock-names:
-          items:
-            - const: pipe # PIPE clock
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: tbu # PCIe TBU clock
-            - const: ref # REFERENCE clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -729,7 +701,6 @@ allOf:
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
-              - qcom,pcie-sm8150
               - qcom,pcie-sm8350
     then:
       oneOf:

-- 
2.34.1


