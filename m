Return-Path: <linux-pci+bounces-1824-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id D83C2827103
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 15:21:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 62FE11F2250F
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jan 2024 14:21:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 056CD51024;
	Mon,  8 Jan 2024 14:19:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="eAjcPQCo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-lf1-f44.google.com (mail-lf1-f44.google.com [209.85.167.44])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 09B1D5103A
	for <linux-pci@vger.kernel.org>; Mon,  8 Jan 2024 14:19:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-lf1-f44.google.com with SMTP id 2adb3069b0e04-50e835800adso1660360e87.0
        for <linux-pci@vger.kernel.org>; Mon, 08 Jan 2024 06:19:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1704723581; x=1705328381; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zJIr3gLxozsh7CrXcoARrwWHbGQibktk/tx+W6SEOMk=;
        b=eAjcPQCoABPBvTmhBccIsIIXWorb7W8R+ECv+z4v4rVoiMo4F4iN/Nafz2bAP/kdpV
         bljSF/cqwLBaA9yh4VQNgRTWx0V8jzt4WbRoGz48a4tv0wTwedseTijoXeCAwzPQzYPB
         PT+TVvaGbRm2szaxqJKjhh82o+K8oqyDsXUvMzwIbOkFQuA1qnZTkOwDodGKPnAwO/Qh
         EOszQXiE3LP1HYAyDSDQOe9oRpQU59uM9qI/OqccG+yAra/RbwB52b6ny/IefZtdqWsp
         g1RbEUMX24AlesPEQSl2MNkSgll6tXk9K0qsQTyTwnxLBl/EtxewJjAjjvEMJqp62CJN
         maAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1704723581; x=1705328381;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zJIr3gLxozsh7CrXcoARrwWHbGQibktk/tx+W6SEOMk=;
        b=ClI0QPcbb9qAfYxbdQSSakHf34IcwQa1QInL3PTysmWdIdo7kCTmnEuFBLk21ubGKD
         ytIZOIg6gHywqQSgB3aUIH3wJsZylgNblRAga/SZMd4cMhAvmnMU07op9qOLXFwUFPiH
         2bUAw2cWWfM2AyqkTiRAdhVFSTfAJEe9ZAcKssxbtjff62SsInnhTrSxsvq7WyU5BY4+
         R0VBwGRYJHdZHAz+7HHxkedeGIumj+XjnwCXh610u9+1/7jOnYpGPhFOVysB07QlVIKk
         4E2YYdzgd+2+wiZv7O47jb46ZS/l29g4kEl9Ab9OMkV5Frz53oBGzRqyGjsM2jxa99qf
         l26A==
X-Gm-Message-State: AOJu0Yz8sWnsXsbNOHffScYfNHN2JTiJCOA/Fof8h9CSjOuMtYDHXSui
	/g3vA9095FE729yHUXS/OJefa+eo7h1jRg==
X-Google-Smtp-Source: AGHT+IF6BF3WEmz+iyt90io9cKDJUXePQXotDy57DSR1o8XX/a4S2qlPJsh8wZxYkt7svMovVscD5Q==
X-Received: by 2002:a05:6512:3c98:b0:50e:9872:ae78 with SMTP id h24-20020a0565123c9800b0050e9872ae78mr1212160lfv.196.1704723581042;
        Mon, 08 Jan 2024 06:19:41 -0800 (PST)
Received: from [127.0.1.1] ([178.197.223.112])
        by smtp.gmail.com with ESMTPSA id cm25-20020a0564020c9900b00556ee10cfe3sm4319832edb.92.2024.01.08.06.19.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 08 Jan 2024 06:19:40 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 08 Jan 2024 15:19:19 +0100
Subject: [PATCH 6/6] dt-bindings: PCI: qcom,pcie-sc8280xp: move SC8280XP to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240108-dt-bindings-pci-qcom-split-v1-6-d541f05f4de0@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9760;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=KUGAXveuGUxtLUDN9Q/9x0zJbEyqON8MU6FY9snIhUA=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBlnARwxAW+ymdGztyYbyrxrHfjah6+4fz4ZjDHB
 3is/3+4Z7aJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCZZwEcAAKCRDBN2bmhouD
 11I+D/sHtyMZ7xKrBk9rTRBibxvh30ude8J7B9O3qHoGJ47tubPvVCgwTviGhiAFRf+98+NcJ+j
 0POGYhbCDf+jElbHshaGxnYMzjoHCo1tHoTUma1YCXIPYVaNaJ+362rU6UTlp3r10SJy/HxM82Y
 LdQ4RBKKIAYFH4dr3mn5xo2FiqSNvjUiY6kpNiufeEOInNseTcho9tJADSgKVP2pJa43yF5VFqM
 ke7TTj7t8SJ1KRtUOugpinL4t6dJLc0+W+6Q/g1N9DGqOuhGB/5Wca0ktDIlODc5CfBbxy+y36a
 ZlWjdlEGl5sRcXuEuBDI1yaDi4cTD99hBEkflOuwHGdaCrwv7TrLMUEVOUIQO2oFzXeXNuFNCY+
 akD1iMGaYTfAXo+9oI/NrR41VZ/y2Yn2EbNQVewdBy+az5x5DNz7jRQXl68eC1aYjFSA0yGYiLR
 Vym74BIafRrU81Lkv0omfXsJLKsLCFtEh1wTRcWFRsK8Goybm1hEwCTTeAUOQae3A7tbEBX0xFi
 HrLYkk6nVIfhOJ8qU1reCzeDO8c9bMWwXyEGpUtljo7xKMKD/darIv1/zPs3+POa7qD6GRCAL6A
 ZWxQZO9nI2lpCpSfa848RMI26JJDeUDRT922WZJz+hD6FVLeud8F7zEws/w90zhWoTHET0p0XVO
 ilIEfX5RededRmw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SC8280XP compatible PCIe devices from qcom,pcie.yaml binding to a
dedicated file to make reviewing easier.

This creates equivalent schema file, except missing required compatible
which is actually redundant.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../bindings/pci/qcom,pcie-sc8280xp.yaml           | 180 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  54 -------
 2 files changed, 180 insertions(+), 54 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
new file mode 100644
index 000000000000..25c9f13ae977
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sc8280xp.yaml
@@ -0,0 +1,180 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sc8280xp.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SC8280XP PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm SC8280XP SoC PCIe root complex controller is based on the Synopsys
+  DesignWare PCIe IP.
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-sa8540p
+      - qcom,pcie-sc8280xp
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
+    minItems: 8
+    items:
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: ddrss_sf_tbu # PCIe SF TBU clock
+      - const: noc_aggr_4 # NoC aggregate 4 clock
+      - const: noc_aggr_south_sf # NoC aggregate South SF clock
+      - const: cnoc_qx # Configuration NoC QX clock
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+  vddpe-3v3-supply:
+    description: A phandle to the PCIe endpoint power supply
+
+required:
+  - interconnects
+  - interconnect-names
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - qcom,pcie-sc8280xp
+    then:
+      properties:
+        interrupts:
+          minItems: 4
+          maxItems: 4
+        interrupt-names:
+          items:
+            - const: msi0
+            - const: msi1
+            - const: msi2
+            - const: msi3
+    else:
+      properties:
+        interrupts:
+          maxItems: 1
+        interrupt-names:
+          items:
+            - const: msi
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,gcc-sc8280xp.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,sc8280xp.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c20000 {
+            compatible = "qcom,pcie-sc8280xp";
+            reg = <0x0 0x01c20000 0x0 0x3000>,
+                  <0x0 0x3c000000 0x0 0xf1d>,
+                  <0x0 0x3c000f20 0x0 0xa8>,
+                  <0x0 0x3c001000 0x0 0x1000>,
+                  <0x0 0x3c100000 0x0 0x100000>,
+                  <0x0 0x01c23000 0x0 0x1000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x3c200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x3c300000 0x0 0x3c300000 0x0 0x1d00000>;
+
+            bus-range = <0x00 0xff>;
+            device_type = "pci";
+            linux,pci-domain = <2>;
+            num-lanes = <4>;
+
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            assigned-clocks = <&gcc GCC_PCIE_2A_AUX_CLK>;
+            assigned-clock-rates = <19200000>;
+            clocks = <&gcc GCC_PCIE_2A_AUX_CLK>,
+                     <&gcc GCC_PCIE_2A_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_2A_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_2A_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_2A_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_DDRSS_PCIE_SF_TBU_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_4_AXI_CLK>,
+                     <&gcc GCC_AGGRE_NOC_PCIE_SOUTH_SF_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "ddrss_sf_tbu",
+                          "noc_aggr_4",
+                          "noc_aggr_south_sf";
+
+            dma-coherent;
+
+            interrupts = <GIC_SPI 86 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 523 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 524 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 525 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0", "msi1", "msi2", "msi3";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 530 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 2 &intc 0 0 GIC_SPI 531 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 3 &intc 0 0 GIC_SPI 532 IRQ_TYPE_LEVEL_HIGH>,
+                            <0 0 0 4 &intc 0 0 GIC_SPI 533 IRQ_TYPE_LEVEL_HIGH>;
+
+            interconnects = <&aggre2_noc MASTER_PCIE_2A 0 &mc_virt SLAVE_EBI1 0>,
+                            <&gem_noc MASTER_APPSS_PROC 0 &config_noc SLAVE_PCIE_2A 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            phys = <&pcie2a_phy>;
+            phy-names = "pciephy";
+
+            pinctrl-0 = <&pcie2a_default>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc PCIE_2A_GDSC>;
+
+            resets = <&gcc GCC_PCIE_2A_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 143 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 145 GPIO_ACTIVE_LOW>;
+            vddpe-3v3-supply = <&vreg_nvme>;
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
index 6e03a1bce5d4..c8f36978a94c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -28,11 +28,9 @@ properties:
           - qcom,pcie-ipq8074-gen3
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
-          - qcom,pcie-sa8540p
           - qcom,pcie-sa8775p
           - qcom,pcie-sc7280
           - qcom,pcie-sc8180x
-          - qcom,pcie-sc8280xp
           - qcom,pcie-sdm845
           - qcom,pcie-sdx55
       - items:
@@ -210,7 +208,6 @@ allOf:
               - qcom,pcie-sa8775p
               - qcom,pcie-sc7280
               - qcom,pcie-sc8180x
-              - qcom,pcie-sc8280xp
               - qcom,pcie-sdx55
     then:
       properties:
@@ -538,36 +535,6 @@ allOf:
           items:
             - const: pci # PCIe core reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sa8540p
-              - qcom,pcie-sc8280xp
-    then:
-      properties:
-        clocks:
-          minItems: 8
-          maxItems: 9
-        clock-names:
-          minItems: 8
-          items:
-            - const: aux # Auxiliary clock
-            - const: cfg # Configuration clock
-            - const: bus_master # Master AXI clock
-            - const: bus_slave # Slave AXI clock
-            - const: slave_q2a # Slave Q2A clock
-            - const: ddrss_sf_tbu # PCIe SF TBU clock
-            - const: noc_aggr_4 # NoC aggregate 4 clock
-            - const: noc_aggr_south_sf # NoC aggregate South SF clock
-            - const: cnoc_qx # Configuration NoC QX clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       properties:
         compatible:
@@ -623,9 +590,7 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-sa8540p
               - qcom,pcie-sa8775p
-              - qcom,pcie-sc8280xp
     then:
       required:
         - interconnects
@@ -692,24 +657,6 @@ allOf:
                 - const: msi6
                 - const: msi7
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sc8280xp
-    then:
-      properties:
-        interrupts:
-          minItems: 4
-          maxItems: 4
-        interrupt-names:
-          items:
-            - const: msi0
-            - const: msi1
-            - const: msi2
-            - const: msi3
-
   - if:
       properties:
         compatible:
@@ -724,7 +671,6 @@ allOf:
               - qcom,pcie-ipq8074
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-qcs404
-              - qcom,pcie-sa8540p
     then:
       properties:
         interrupts:

-- 
2.34.1


