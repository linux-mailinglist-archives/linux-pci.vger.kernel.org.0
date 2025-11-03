Return-Path: <linux-pci+bounces-40110-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from dfw.mirrors.kernel.org (dfw.mirrors.kernel.org [IPv6:2605:f480:58:1:0:1994:3:14])
	by mail.lfdr.de (Postfix) with ESMTPS id 9ADECC2CBBE
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:30:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by dfw.mirrors.kernel.org (Postfix) with ESMTPS id 9374B4F4547
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:23:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0633232720F;
	Mon,  3 Nov 2025 15:15:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nkbXxNjy"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ed1-f51.google.com (mail-ed1-f51.google.com [209.85.208.51])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9979A326D44
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.208.51
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182906; cv=none; b=i+6vwImEaF8Cqyfm/qZugnQ2EBNmYdV1Yy9a9+SSXsJFla6pr1HaHDVTDczEopeOUsHIjA8rMoAq4kttTv1IYaaiQZiqPitbVIyUNRpA09/Pc7g5aymYg1EcPZvxvCTw0zkhxC67VsRQdFCw9/D3K5y9CF6rbkFW7fmA5UuRBI8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182906; c=relaxed/simple;
	bh=ebhFwk1A+stuafBc1xiTkv9rAh5xmlwxW8L4Te/AXXk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=luyEXZOqMRWY+jDTvBCYMrCfFfAdIZ1DWaUXYga5sjRVM7gBAzxCNGf0mVWIVl3CbfKMAMVjc+PRhDtHkJa0Hy2pG8CzmWDD3YEC2ulvyzTofaJoMLOzGFmMpJtEo9tJIWrQZZrcfs0gFHC5jo6TuLjICW+Du5BncylO6yBXAAM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=nkbXxNjy; arc=none smtp.client-ip=209.85.208.51
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ed1-f51.google.com with SMTP id 4fb4d7f45d1cf-63c479268efso955808a12.2
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182903; x=1762787703; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Bi08syHZ3YpmBy75TyhPcic3H1G70rE6+4Jz6VE3HGk=;
        b=nkbXxNjy9HgchVaEK86vjIIi0e0zbcIg5ogCsrv6+Cc2UcB1cgqfKe0JP7nK6H7iOe
         On5DV+2Kw0uAo6H9Umwgwc1ugpG9I8cLWjaOF7tbuzKdrVvmnctN8VZHjJZARgOJOhvZ
         KiYKInbp4P/O32yyk+cP+ePy/3jLKh0j9XfBPRVH5QdrHoYnoBor4vzdgaRIshKn0NbL
         oJF5sasRilJBtXg7iItIrQ2vSt+/RSHDqweGjEjlEBY9O+7nDhdHCGf+T/ayVQplMwRk
         LVwwnytbFJpRqgFsnO6dE2OD4WeqlMbbl0FO6CO+uT1FV55T4rItOkZdtRFiXcIe2vBN
         WPVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182903; x=1762787703;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Bi08syHZ3YpmBy75TyhPcic3H1G70rE6+4Jz6VE3HGk=;
        b=vevgX7n7enzY8W2WCRE11h6DyMFxt/SZQPjW+nucF0ma1LIek3qmSOrvJbigN2zB4X
         l/jxNFJy9aZcYZh/k3TTVLd5Gy1+S66hQmEPNO9tH9p8YGChaxGUi8TiaLXL7G+XXrPO
         JNVYH8n8OBgSeoC//sgYzFaah/lTKGtlQQYXA8FpzHbqQk81FgUWjfWt7GaZi42ZDSjO
         Z4Y/mn5y7smX2ddvdLila5cE38iicbg00nZmN+YuX9KFy5seIzNdypoD554R841Wf057
         8Eyurg8YF5Q5g4CkaauBCPgn2rAHEQF+4x38MxVsPBXEzjFErXbeiVvarcXmHtxlIGTg
         xPIQ==
X-Forwarded-Encrypted: i=1; AJvYcCWG/lpyaPoy8bxplDiUAkzFuRTYcd84XmlFYDEMz4zwSDdpvOR8WPxvzubqTJoio3byEdCIMpyzayc=@vger.kernel.org
X-Gm-Message-State: AOJu0YzwJEFfvfTCI3LpfhHBHHeryFrEzwWR+owhGIW7argYCXynCLx9
	pS3SgybTyX+F5A9ECO8DbWiue/U0hb/cieBzvuo/mZKpbKn6KVqftHGJtpAlGIy5DMg=
X-Gm-Gg: ASbGnctdb+x4Y55v2lmp8HajsQd1J+QiktKs6XtfyqMIwiwdAxugsXR1o3kKiQDYraZ
	TMF+orcEGHJNIFSWryEEBBDreFsSY2CvGpdy4LMy33y+9HIFFxXzYMeN9m2TKXHdkRxk4a+mEJC
	NY5XfKXvHq+4coBPK34FYQQjGJD9dAl+kqQsB5WmXEbTbPxI746oUsfuThTgj7gO0L92BI0Xxlm
	2VqeARna9fK3OjLUzYFCZoYIQbvahdXsbBXrzVtl6BkOoX/sF0HvvOBBISvT8VTwHE6RbTOH4NV
	xNkj+s1F2ivjopKrjL76BLWG/U3Jy5te+NXdSpJ7jx5tcjR3OG0GqJ8BUyo388RCT8DQWK66U/W
	gXWTnwBuZCeN4rvbD2wZJjlg4VLXnbIsMZ23m99uINMk0HeG74mEqxG0F5xBG978Yqog08T5nqL
	CQGFu6Tht/5aslHI3A
X-Google-Smtp-Source: AGHT+IGtocCy63qnSLfMJVVArR2dbi4Cz6gXTnyicwhP/3CN4gsoRWGxXCqtF6kgYnr+w5cSsXhWfw==
X-Received: by 2002:a17:907:3e0c:b0:b6d:6d44:d255 with SMTP id a640c23a62f3a-b70700af393mr733413266b.1.1762182902899;
        Mon, 03 Nov 2025 07:15:02 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:02 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:43 +0100
Subject: [PATCH 03/12] dt-bindings: PCI: qcom,pcie-sdm845: Move SDM845 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-3-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9758;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=ebhFwk1A+stuafBc1xiTkv9rAh5xmlwxW8L4Te/AXXk=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbmbi7l97iwOeqpi65bEi2LNPWMWugEsVGxM
 DhgAAIinnuJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG5gAKCRDBN2bmhouD
 18cID/4iSI0uqmVsWFFt33YB7p6bBQKn21YtAOmf1xp7/gCXDnhttm7bMKBWERns4mDmJAkoE5k
 f3U5KS07E1WblUhHvS2kJOd+XNIsyb+WhhgYLkM44P0mGbTUqIydzcbMSfRd6qMLflq+prGCzEv
 ilO9RElvS7MEVGx26MCrbuHdjxfmmCvBAdcvTlMOdE+c1WcxqqPQkRu2LcTHnMIIYDSETDqY0z6
 lrR698GelIQHWF/up6MW8Z2VzX3bqoff/yrrAiWQCR8/vMaUqQ588vE719SYai8p3cMgLT7wOKg
 hsGa6vrIMHIE5Wo1HN7ct8U71gd7yNkNVKwQA76JPGdzK0hd2cUmMwgc7a6Eh1t/KZ+Ac3jLybY
 1BSAY7AwAwmCNeAQ62SvEhbz5bmOnfqXIqt28mO4ZzBZk1vws2KPdkwtd+Pd13X3EhqHDZqBpS4
 BxN9rhysu8iGDhuk79hWqJsCRyYlcMNyJWFYfDKU0pvavWY2IKn07392BXZ6LKuigyq6yYvn3CU
 wF2mZlP5/b3mi7xpIMnU1vdDRn9Svimggt2BQrl5gY4nnfC4x0e2RXCmSJSLDIyfOM5mq1RIi02
 NUYZIFJi4HcdTDm6ZtHMLkGKhfFqW82j7/LO11TL7wwNBhMrEd4O2Y4X42WdVyKxduTN7E7SWA6
 KS8j8FtGQOCFTVg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move SDM845 PCIe devices from qcom,pcie.yaml binding to a dedicated file
to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Expecting eight MSI interrupts and one global, instead of only one,
   which was incomplete hardware description.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-sdm845.yaml  | 190 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  46 -----
 2 files changed, 190 insertions(+), 46 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-sdm845.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-sdm845.yaml
new file mode 100644
index 000000000000..1ec9e4f3ff57
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-sdm845.yaml
@@ -0,0 +1,190 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-sdm845.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm SDM845 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-sdm845
+
+  reg:
+    minItems: 4
+    maxItems: 5
+
+  reg-names:
+    minItems: 4
+    items:
+      - const: parf
+      - const: dbi
+      - const: elbi
+      - const: config
+      - const: mhi
+
+  clocks:
+    minItems: 7
+    maxItems: 8
+
+  clock-names:
+    minItems: 7
+    items:
+      - const: pipe
+      - const: aux
+      - const: cfg
+      - const: bus_master # Master AXI clock
+      - const: bus_slave # Slave AXI clock
+      - const: slave_q2a
+      - enum: [ ref, tbu ]
+      - const: tbu
+
+  interrupts:
+    minItems: 8
+    maxItems: 9
+
+  interrupt-names:
+    minItems: 8
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
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: pci
+
+required:
+  - power-domains
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
+    #include <dt-bindings/clock/qcom,gcc-sdm845.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    soc {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1c00000 {
+            compatible = "qcom,pcie-sdm845";
+            reg = <0x0 0x01c00000 0x0 0x2000>,
+                  <0x0 0x60000000 0x0 0xf1d>,
+                  <0x0 0x60000f20 0x0 0xa8>,
+                  <0x0 0x60100000 0x0 0x100000>,
+                  <0x0 0x01c07000 0x0 0x1000>;
+            reg-names = "parf", "dbi", "elbi", "config", "mhi";
+            ranges = <0x01000000 0x0 0x00000000 0x0 0x60200000 0x0 0x100000>,
+                     <0x02000000 0x0 0x60300000 0x0 0x60300000 0x0 0xd00000>;
+
+            device_type = "pci";
+            linux,pci-domain = <0>;
+            bus-range = <0x00 0xff>;
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
+                     <&gcc GCC_AGGRE_NOC_PCIE_TBU_CLK>;
+            clock-names = "pipe",
+                          "aux",
+                          "cfg",
+                          "bus_master",
+                          "bus_slave",
+                          "slave_q2a",
+                          "tbu";
+
+            interrupts = <GIC_SPI 141 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 146 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 147 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 148 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 140 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "msi0",
+                              "msi1",
+                              "msi2",
+                              "msi3",
+                              "msi4",
+                              "msi5",
+                              "msi6",
+                              "msi7",
+                              "global";
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0x7>;
+            interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 149 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                            <0 0 0 2 &intc 0 0 GIC_SPI 150 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                            <0 0 0 3 &intc 0 0 GIC_SPI 151 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                            <0 0 0 4 &intc 0 0 GIC_SPI 152 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+            iommu-map = <0x0 &apps_smmu 0x1c10 0x1>,
+                        <0x100 &apps_smmu 0x1c11 0x1>,
+                        <0x200 &apps_smmu 0x1c12 0x1>,
+                        <0x300 &apps_smmu 0x1c13 0x1>,
+                        <0x400 &apps_smmu 0x1c14 0x1>,
+                        <0x500 &apps_smmu 0x1c15 0x1>,
+                        <0x600 &apps_smmu 0x1c16 0x1>,
+                        <0x700 &apps_smmu 0x1c17 0x1>,
+                        <0x800 &apps_smmu 0x1c18 0x1>,
+                        <0x900 &apps_smmu 0x1c19 0x1>,
+                        <0xa00 &apps_smmu 0x1c1a 0x1>,
+                        <0xb00 &apps_smmu 0x1c1b 0x1>,
+                        <0xc00 &apps_smmu 0x1c1c 0x1>,
+                        <0xd00 &apps_smmu 0x1c1d 0x1>,
+                        <0xe00 &apps_smmu 0x1c1e 0x1>,
+                        <0xf00 &apps_smmu 0x1c1f 0x1>;
+
+            power-domains = <&gcc PCIE_0_GDSC>;
+
+            phys = <&pcie0_phy>;
+            phy-names = "pciephy";
+
+            resets = <&gcc GCC_PCIE_0_BCR>;
+            reset-names = "pci";
+
+            perst-gpios = <&tlmm 35 GPIO_ACTIVE_LOW>;
+            wake-gpios = <&tlmm 134 GPIO_ACTIVE_HIGH>;
+
+            vddpe-3v3-supply = <&pcie0_3p3v_dual>;
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
index de6439a45ef4..68cae47c2ef6 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -30,7 +30,6 @@ properties:
           - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
           - qcom,pcie-qcs404
-          - qcom,pcie-sdm845
       - items:
           - enum:
               - qcom,pcie-ipq5332
@@ -194,7 +193,6 @@ allOf:
             enum:
               - qcom,pcie-apq8084
               - qcom,pcie-msm8996
-              - qcom,pcie-sdm845
     then:
       properties:
         reg:
@@ -514,49 +512,6 @@ allOf:
             - const: pwr # PWR reset
             - const: ahb # AHB reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-sdm845
-    then:
-      oneOf:
-          # Unfortunately the "optional" ref clock is used in the middle of the list
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
-                - const: ref # REFERENCE clock
-                - const: tbu # PCIe TBU clock
-        - properties:
-            clocks:
-              minItems: 7
-              maxItems: 7
-            clock-names:
-              items:
-                - const: pipe # PIPE clock
-                - const: aux # Auxiliary clock
-                - const: cfg # Configuration clock
-                - const: bus_master # Master AXI clock
-                - const: bus_slave # Slave AXI clock
-                - const: slave_q2a # Slave Q2A clock
-                - const: tbu # PCIe TBU clock
-      properties:
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: pci # PCIe core reset
-
   - if:
       not:
         properties:
@@ -598,7 +553,6 @@ allOf:
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-msm8996
               - qcom,pcie-msm8998
-              - qcom,pcie-sdm845
     then:
       oneOf:
         - properties:

-- 
2.48.1


