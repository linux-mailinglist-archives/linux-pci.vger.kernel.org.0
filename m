Return-Path: <linux-pci+bounces-4338-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7939986E685
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 17:59:28 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id DB8FAB25B83
	for <lists+linux-pci@lfdr.de>; Fri,  1 Mar 2024 16:59:25 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 50FD046B7;
	Fri,  1 Mar 2024 16:59:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="D7dfDQZb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f47.google.com (mail-ej1-f47.google.com [209.85.218.47])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5EF873D8E
	for <linux-pci@vger.kernel.org>; Fri,  1 Mar 2024 16:59:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.47
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709312357; cv=none; b=UyazwZ0nOGj/d1VFnOrzbq677ggdBNKmonih9+4OW9x0Qtf0bOENLhYxAG2PIs4km8CUkL5rJB2ytYH8FSVxcFP7RYGsPheVUuTLzT/NF4kgPaqYqoYZgZkV422jiezHdhK9HDYgWewWDuhftP0Ykyy9mV14DaQFDQxGRrQ48fY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709312357; c=relaxed/simple;
	bh=1cnXF/UECj2KO4q4f1/R4DEYEj/qecZ9dKHdF1neor8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=uL4X62frU38DuUpi5Vg2KfGb8lIgsPA4JAaYwNBby5/8FhZlXRL0gGWevjGGkiohqaIsadFuxC4lc1eLQsLMNeoTPZu1zBpjY7gGWtBDSm0pQS86BcbBwOgpur+UUk61h8Djy4jjUrtpcYlm8oAR+eWV9jmFS44x9Rfrw1jIkQo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=D7dfDQZb; arc=none smtp.client-ip=209.85.218.47
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f47.google.com with SMTP id a640c23a62f3a-a44665605f3so230160466b.2
        for <linux-pci@vger.kernel.org>; Fri, 01 Mar 2024 08:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1709312354; x=1709917154; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=q2QV/YBGu2rIpKx6/ABxZsheliBM8XOZSw2MYzMO8rk=;
        b=D7dfDQZbLSjuMnHFpQH/GUWhfeu3KBdOHWpx0DfEncn05mNagDfHmlWhuZ6aguRa6S
         5qud0L7DwZGVWz4WW8dYyczvbR9ny5n3CbqhwO6zwTJ4Jc2HbkCsQeqyW8yO2J27krqt
         gRGY1+IF3K+7tMSoa40l14bhk+uRe6nqphz6LVzTexW5s0CwrcCNzb99/v4uTH93c2Mk
         cjvvai3908Thu+YsApEd9I+9KGlGkVi/L13xTc4KAnZtqVwXNyPoGDoc2bn+BZ7Qu6II
         +Fc1DcrDmyU578UvR6yT2wqjfADn5zj4yiEdr/cjpzZk1VUB4CwSoVfWBYGtOiiGz2Qj
         lC0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1709312354; x=1709917154;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q2QV/YBGu2rIpKx6/ABxZsheliBM8XOZSw2MYzMO8rk=;
        b=iPzgwW0KIzMBHuERffkYCMlWbsyjjVsLhjXNo+kWByn5ER2z4MQZLVwsPPHXVEwDgT
         zdBmjOECUk6mYTAb6lQ24lze70VaQsVQU7MjRm4gVB1aHVe16aX+old6PWf6K0UaDix0
         xg9SrLkpnpDjW3eLLeu3WlKn+DuA7bV5zWMAezDRL8Zz9zvSD6kvGr1CQD29yPGM2G8j
         w68wPVGV2Um1Qpi1sQHsHkbuxd48zRQXEV1wtNx3dEs1+gwI4sIXbF3tupg6rRNX343J
         PXCYFZrpnSQwrzPPVsWbJLJKqf5OEx9AEAqk2SRSQ4+GIYf0GcyMVtZ0bMajkS06Mg38
         Qzjw==
X-Gm-Message-State: AOJu0YyKr+y+Uc8TarYjNB49NgS4/9ut7/HMT0RHQkDSq4be7G65+X57
	CJTJ79Xzso8i3Jn7op80cDrrR1zTZM+fmYQ6ADbh4bvDdMaoeCgWTOEiGfCOZGo=
X-Google-Smtp-Source: AGHT+IGvZyfDPO9nbrdKkjZP0VARM1cLqYtBFCF0J3atgmFGuXHaTDIirkSjRPlV27qddSnhgnh9rw==
X-Received: by 2002:a17:906:2c57:b0:a3f:5fa9:d772 with SMTP id f23-20020a1709062c5700b00a3f5fa9d772mr1631641ejh.37.1709312353969;
        Fri, 01 Mar 2024 08:59:13 -0800 (PST)
Received: from [127.0.1.1] ([188.24.162.93])
        by smtp.gmail.com with ESMTPSA id k11-20020a170906578b00b00a44b405121csm294460ejq.9.2024.03.01.08.59.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 01 Mar 2024 08:59:13 -0800 (PST)
From: Abel Vesa <abel.vesa@linaro.org>
Date: Fri, 01 Mar 2024 18:59:01 +0200
Subject: [PATCH v4 1/2] dt-bindings: PCI: qcom: Document the X1E80100 PCIe
 Controller
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20240301-x1e80100-pci-v4-1-7ab7e281d647@linaro.org>
References: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
In-Reply-To: <20240301-x1e80100-pci-v4-0-7ab7e281d647@linaro.org>
To: Bjorn Andersson <andersson@kernel.org>, 
 Konrad Dybcio <konrad.dybcio@linaro.org>, 
 Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>, 
 Lorenzo Pieralisi <lpieralisi@kernel.org>, 
 =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>, 
 Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>, 
 Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>, 
 Conor Dooley <conor+dt@kernel.org>
Cc: linux-pci@vger.kernel.org, linux-arm-msm@vger.kernel.org, 
 linux-kernel@vger.kernel.org, devicetree@vger.kernel.org, 
 Abel Vesa <abel.vesa@linaro.org>
X-Mailer: b4 0.13.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=6174; i=abel.vesa@linaro.org;
 h=from:subject:message-id; bh=1cnXF/UECj2KO4q4f1/R4DEYEj/qecZ9dKHdF1neor8=;
 b=owEBbQKS/ZANAwAKARtfRMkAlRVWAcsmYgBl4gldFvPw8/3HvDbwo2gcLZTLYOuKhwbPBWhSH
 NbVHeNrmcWJAjMEAAEKAB0WIQRO8+4RTnqPKsqn0bgbX0TJAJUVVgUCZeIJXQAKCRAbX0TJAJUV
 VsVnEACNU/RtdKUeko4mzeIUo5Fo7Iv4oGzY27wMNTnvQ+GuUH0GCxjX5CTZnaaLDdBJGZwhM+8
 Hdirn9naV3jJGUbWrrYqUqUi64jzT9CKCnU/oHZUjsK2uEOdvMe/iWjQTpybbOm+D7MXwXuxcw7
 UbTcw9zfTYgJYk9H46N9PbGqtMp8ufFI9zMFEit9r8sT3Ml5lzQgzAsY2wevXqsRyEFz4PBiw80
 JFM9UyxalLK68lO24CMb7VK7nHn5aaGAn0rnAIxgyqFWTyGDMxTsqB7Lc55NZDrAbWqGrC+6h40
 mpjCz8b8TEKh35h/Z/8pPuxcSBF6qWd8hj8T2xBpEed8EH1kstCDn5M0bQrsGd54bTL2Hx9Kznk
 x7ob66lCPQsuZh3DKkZXZFS5pjQCgMg1ljCV8TDB/fLGuzegGIBpxtSOUedL8XLBpjx9VaxuduE
 iuxVtZJ9xGyhSXC5jRU0BKxVJ5i88aEucJHp01IqlD6TeQy/14VqGZsIyX+25ynMpg0Whewajsw
 p6Iai4cPH3nDznMrpPQha5tAxmiQZA/sJm/8VJss80ABowgkxVmXl3x7Wi0Nd6lzGh2+5xmIbqa
 c6FXgi3ju/tLrVOwmpeiYBsEATCz5/EFKCkYTLpQNQfg4mLGGy6i1SL5zAOOxMvCwTd8YJfKk73
 BaSvbVdaTA9OyeA==
X-Developer-Key: i=abel.vesa@linaro.org; a=openpgp;
 fpr=6AFF162D57F4223A8770EF5AF7BF214136F41FAE

Add dedicated schema for the PCIe controllers found on X1E80100.

Signed-off-by: Abel Vesa <abel.vesa@linaro.org>
---
 .../bindings/pci/qcom,pcie-x1e80100.yaml           | 165 +++++++++++++++++++++
 1 file changed, 165 insertions(+)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
new file mode 100644
index 000000000000..1074310a8e7a
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-x1e80100.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-x1e80100.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm X1E80100 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
+
+description:
+  Qualcomm X1E80100 SoC (and compatible) PCIe root complex controller is based on
+  the Synopsys DesignWare PCIe IP.
+
+properties:
+  compatible:
+    const: qcom,pcie-x1e80100
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
+    minItems: 7
+    maxItems: 7
+
+  clock-names:
+    items:
+      - const: aux # Auxiliary clock
+      - const: cfg # Configuration clock
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a # Slave Q2A clock
+      - const: noc_aggr # Aggre NoC PCIe AXI clock
+      - const: cnoc_sf_axi # Config NoC PCIe1 AXI clock
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
+    minItems: 1
+    maxItems: 2
+
+  reset-names:
+    minItems: 1
+    items:
+      - const: pci # PCIe core reset
+      - const: link_down # PCIe link down reset
+
+allOf:
+  - $ref: qcom,pcie-common.yaml#
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/qcom,x1e80100-gcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interconnect/qcom,x1e80100-rpmh.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c08000 {
+            compatible = "qcom,pcie-x1e80100";
+            reg = <0 0x01c08000 0 0x3000>,
+                  <0 0x7c000000 0 0xf1d>,
+                  <0 0x7c000f40 0 0xa8>,
+                  <0 0x7c001000 0 0x1000>,
+                  <0 0x7c100000 0 0x100000>,
+                  <0 0x01c0b000 0 0x1000>;
+            reg-names = "parf", "dbi", "elbi", "atu", "config", "mhi";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
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
+            clocks = <&gcc GCC_PCIE_4_AUX_CLK>,
+                     <&gcc GCC_PCIE_4_CFG_AHB_CLK>,
+                     <&gcc GCC_PCIE_4_MSTR_AXI_CLK>,
+                     <&gcc GCC_PCIE_4_SLV_AXI_CLK>,
+                     <&gcc GCC_PCIE_4_SLV_Q2A_AXI_CLK>,
+                     <&gcc GCC_CFG_NOC_PCIE_ANOC_NORTH_AHB_CLK>,
+                     <&gcc GCC_CNOC_PCIE_NORTH_SF_AXI_CLK>;
+            clock-names = "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "noc_aggr",
+                          "cnoc_sf_axi";
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
+            interrupt-map = <0 0 0 1 &intc 0 0 0 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 0 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 0 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 0 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            interconnects = <&pcie_noc MASTER_PCIE_4 0 &mc_virt SLAVE_EBI1 0>,
+                            <&gem_noc MASTER_APPSS_PROC 0 &cnoc_main SLAVE_PCIE_4 0>;
+            interconnect-names = "pcie-mem", "cpu-pcie";
+
+            iommu-map = <0x0 &apps_smmu 0x1400 0x1>,
+                        <0x100 &apps_smmu 0x1401 0x1>;
+
+            phys = <&pcie4_phy>;
+            phy-names = "pciephy";
+
+            pinctrl-0 = <&pcie0_default_state>;
+            pinctrl-names = "default";
+
+            power-domains = <&gcc GCC_PCIE_4_GDSC>;
+
+            resets = <&gcc GCC_PCIE_4_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 94 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 96 GPIO_ACTIVE_HIGH>;
+        };
+    };

-- 
2.34.1


