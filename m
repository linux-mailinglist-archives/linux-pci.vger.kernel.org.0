Return-Path: <linux-pci+bounces-3089-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BCC0B849F1F
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 17:01:45 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 31E751F21802
	for <lists+linux-pci@lfdr.de>; Mon,  5 Feb 2024 16:01:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF23A3A1C3;
	Mon,  5 Feb 2024 15:58:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Eb6glWys"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6E53D3FE44
	for <linux-pci@vger.kernel.org>; Mon,  5 Feb 2024 15:58:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.167.44
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1707148696; cv=none; b=W4tSBKErgEPpQipYY9rHuog2oVra05AvlO3hZsHByK08szQ7AjSPobD3OjsPTcFbz7rqEWFcdHQ76jLlGyhIfJPtVXe6w/B6Ieggm2DFUwtxmjGWmD347vmbpK07pwQok/KVNyx8f+aRwrtGkg4Nb5wd4112qP4PS005pvbtsQs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1707148696; c=relaxed/simple;
	bh=vcbSnCOl9Ca7K6y1DcHb9A1q6xEcjC/uYXGsQEdK0Ss=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OU2uGWx0NEyFJdfNU4Qf++FiorFdZX43haW+WaLeW8UPUAAs7QkVHfh6eKmbMtKeSU8Q/QXvWNa/fmHgVC5VY8N7qQ2WYp00xJjx3lPuGepsFYbefXvGWbvUaPNkWoFvDQx61hyJYNAlesqu1dRi3ctz/oDcffJOvsReb2Q51dQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Eb6glWys; arc=none smtp.client-ip=209.85.167.44
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-5114cd44fdbso2395222e87.2
        for <linux-pci@vger.kernel.org>; Mon, 05 Feb 2024 07:58:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1707148692; x=1707753492; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=nY4pmXjCfRiF3qrATiYcvxUfocgOooRXVnJHxC5fKDo=;
        b=Eb6glWys+0lAbdTq+v2vo4R3LWuR7sCJ7fLUQWhLoNh61VlZLQT5haHK3h04kxIFr8
         fY0nvSVt6aFH5yqwfZRhmBTKU7+1sh9PKje375y3FfJ6seDobHGG28FHp1/pSsUGEvg6
         YyWcw8PFaPYARB3BFQHdGA6oQJAxtsGRGU9JFS3xriQP5A/Gg7tEq8LEn7nGF1ZIUBfd
         c+HjwJl8b9aZcf3gXf3YNcT3tneSZ4g3YWZOHqkyF2t0omM06v+SHrl0cLFcqjxdGu8B
         nvCsRPzRcW6pkjGVxKjRHyUVREnv1GjKAa+yIfQ0FwNY+nUbEHgZjKm1y+zRRFjaHQXM
         Q0xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1707148692; x=1707753492;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=nY4pmXjCfRiF3qrATiYcvxUfocgOooRXVnJHxC5fKDo=;
        b=ZmOwIbRULmW/BgF4AT0fgGNJsSEUrDOXKZ6HSxjGniLY6wZewwRgiEQrR3md/W4iSe
         9Q8x/QuM0qx7+l6PwczoPvdcfp1YubW5O09phLcQU3RmVHKsFUz0QF8gNMddd2KAVuwo
         4n8apdymbqX3yVJG+xt/mefWRQwrpUfFELfbt/HGWNrW5OAZ2VQdO+1MHPW53gTHY3vU
         HRV6aLZ6SWaS5Fx8KNTqIJhgUqmTI6C64N7KvPB5Ggy4yntAQrJwu/IZV6jKslwQWrrZ
         mw4qclivu+12BlSIMITI2NJ9JKjF2QjsCBjlfSLmYbqkyzliOE3jQmdR3jwCw1Yfduh5
         aF2A==
X-Gm-Message-State: AOJu0YzKVX0kbhioI+7V7qxUPEa2Lp4nGOmOYEl/nkx4boRx83DsKHoB
	7m3Ui1XufZ3NlFZy42NYIoc8ghbWaQG55/TIxBt7lfi+U1gkqqfXx2oJoBHX19Y=
X-Google-Smtp-Source: AGHT+IHokUo0B4i7x0pWuANz/hIYvYV2w9qmY/U7jMFqWCzqaCn2q3H4PMVESjYxi//YwUqSAY/aQQ==
X-Received: by 2002:ac2:46f6:0:b0:511:437c:9646 with SMTP id q22-20020ac246f6000000b00511437c9646mr38088lfo.6.1707148692213;
        Mon, 05 Feb 2024 07:58:12 -0800 (PST)
X-Forwarded-Encrypted: i=0; AJvYcCXPuC8iXg6f4zuKwt8uukaunSLkSpTwN60Lv5xaqbnQn8L+ybzgNP3MqjtpWddPzPh+cfWhtjFkyvVHYFzWJEdk7uF1gh/r+r4pi5L5wQ93ZF5rTc4W/GrXE0elplzM4BrzJXO3ymq5f3VSJmEBXTe15b81MxmPXvvrRve8bXDSi1jIeMK7Ub0qcmCZtburwsP+U5JO2FXeRYNKTDRX8wql4eIjiN80aEWXpwNzjiZ9BoUCLlpO7Nx4vKBDUtGgxGn6kc0RZy/l8PqyoDXYEDm2BsVQ0JLCzzLxAK1p2sQz94g0N6B+4bKZ0/bH9vNjhjIbHNLEEp7fXcTcqdyr3RZHUrOTOnHa+oAx+J/vUtxodSKnwjfCvh1A1Y7sa95bREhosj9vU6cbFZse7yYB8I4YmECqairgaauZE53BRAgEgy3xhwD2TCISYICH0rWhZitKLIJT
Received: from [127.0.1.1] ([178.197.222.62])
        by smtp.gmail.com with ESMTPSA id fc11-20020a05600c524b00b0040fddae917bsm243714wmb.9.2024.02.05.07.58.10
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Feb 2024 07:58:11 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 05 Feb 2024 16:58:01 +0100
Subject: [PATCH 1/3] dt-bindings: PCI: qcom,pcie-sc8180x: move SC8180X to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240205-dt-bindings-pci-qcom-split-continued-v1-1-c333cab5eeea@linaro.org>
References: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>
In-Reply-To: <20240205-dt-bindings-pci-qcom-split-continued-v1-0-c333cab5eeea@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8406;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=vcbSnCOl9Ca7K6y1DcHb9A1q6xEcjC/uYXGsQEdK0Ss=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlwQWOIHsEjyNEhnbn+22W5d4BxCZVYM/0YFApk
 mI5VaOoWpiJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZcEFjgAKCRDBN2bmhouD
 19r5D/9ODv+KT+9zZEd/LRbKz04miXSoZSvK52iBtSX5mbxO6gogh+P4VfSwJBaG/X/0yADDu6I
 AgEwWZGXK7liP6Uhs6lg8loRPL/6yBPDryHjCxGOzKaillV6IYrSz2Bis0LSZQR9aGyD8fUBNNA
 /uI1c02KFlRFQlWkhz53an5JqqFJDdt+LQaP3tlQs2deuEwOCAq2QZEpHA4+XP7DYcNLb8Hs12r
 SjMzQEoYzWxzKSu7dibjnrvqnQSysOOTjVbhIk7Gl2Anzwtm7NwwotVLRTeu7tEBK5vH+1KHUJG
 H2xPAciFytwnSkI9ceg4VZKwMWWBHfb1NCi+NKl1dcTnayEuL6HsKRgOw+GbtVlUhkii1Uy3P2P
 ui3XNVwj3y0EyubigM8i7zwcCp+SSxt6iSZ0ug8cOrG7BRzd6AVrhuYr3CpDUfGpM8fc1HAcwKz
 s/cSdUQvban4XUu17R6+t0O/HAEjO3qEE84SB3QdwVJ9XGWdQ6nnnJ3vgMVGEYiPJOFG94IASue
 0xRwnaop8AwdhScxVzAywiK0gDIVc4QMtMzyVmGXbK1a/M4ymP5soy/gQunf/lfczq4Mqs5ySVw
 9UOOBRvDnYWkcgvK8FmdSfxOeX2KyIWAaf/cRsQWLDjDpD4E/lS1oOQCZ5oBrOaWa5Q9cvvbiFq
 H6ZAFNYy5hcdB2A==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SC8180X PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing easier.

This creates equivalent schema file, except:
 - Missing required compatible which is actually redundant.
 - Expecting eight MSI interrupts, instead of only one, which was
   incomplete hardware description.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sc8180x.yaml | 170 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  30 ----
 2 files changed, 170 insertions(+), 30 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
new file mode 100644
index 000000000000..baf1813ec0ac
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8180x.yaml
@@ -0,0 +1,170 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sc8180x.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC8180x PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC8180x SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-sc8180x
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
+      - const: ref # REFERENCE clock
+      - const: tbu # PCIe TBU clock
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
+    #include <dt-bindings/clock/qcom,gcc-sc8180x.h>
+    #include <dt-bindings/interconnect/qcom,sc8180x.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sc8180x";
+            reg = <0 0x01c00000 0 0x3000>,
+                  <0 0x60000000 0 0xf1d>,
+                  <0 0x60000f20 0 0xa8>,
+                  <0 0x60001000 0 0x1000>,
+                  <0 0x60100000 0 0x100000>;
+            reg-names = "parf",
+                        "dbi",
+                        "elbi",
+                        "atu",
+                        "config";
+            ranges = <0x01000000 0x0 0x60200000 0x0 0x60200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0x3d00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <0>;
+            num-lanes = <2>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            assigned-clocks = <&gcc GCC_PCIE_0_AUX_CLK>;
+            assigned-clock-rates = <19200000>;
+
+            clocks = <&gcc GCC_PCIE_0_PIPE_CLK>,
+                     <&gcc GCC_PCIE_0_AUX_CLK>,
+                     <&gcc GCC_PCIE_0_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_0_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_PCIE_0_CLKREF_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+            clock-names = "pipe",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ref",
+                          "tbu";
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
+            interrupt-names = "msi0",
+                          "msi1",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            interconnects = <&aggre2_noc MASTER_PCIE 0 &mc_virt SLAVE_EBI_CH0 0>,
+                            <&gem_noc MASTER_AMPSS_M0 0 &config_noc SLAVE_PCIE_0 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            iommu-map = <0x0 &apps_smmu 0x1d80 0x1>,
+                        <0x100 &apps_smmu 0x1d81 0x1>;
+
+            phys = <&pcie0_phy>;
+            phy-names = "pciephy";
+
+            power-domains = <&gcc PCIE_0_GDSC>;
+
+            resets = <&gcc GCC_PCIE_0_BCR>;
+            reset-names = "pci";
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index c8f36978a94c..9bfd35aa1df1 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -30,7 +30,6 @@ properties:
           - qcom,pcie-qcs404
           - qcom,pcie-sa8775p
           - qcom,pcie-sc7280
-          - qcom,pcie-sc8180x
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
       - items:
@@ -207,7 +206,6 @@ allOf:
             enum:
               - qcom,pcie-sa8775p
               - qcom,pcie-sc7280
-              - qcom,pcie-sc8180x
               - qcom,pcie-sdx55
     then:
       properties:
@@ -465,33 +463,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sc8180x
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
-            - const: ref # REFERENCE clock
-            - const: tbu # PCIe TBU clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -633,7 +604,6 @@ allOf:
               - qcom,pcie-msm8996
               - qcom,pcie-sa8775p
               - qcom,pcie-sc7280
-              - qcom,pcie-sc8180x
               - qcom,pcie-sdm845
     then:
       oneOf:

-- 
2.34.1


