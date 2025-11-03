Return-Path: <linux-pci+bounces-40114-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 9F95CC2CE3E
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:49:47 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E4808566A29
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:25:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D25E0328B52;
	Mon,  3 Nov 2025 15:15:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="txIchyjf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f52.google.com (mail-ej1-f52.google.com [209.85.218.52])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5DD16328631
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.52
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182914; cv=none; b=g6V516BCkjTM7YUowScu0A4gUJYy0AQAyF48tS1m/vac+QUiRGSKbu2bVqcakO8sg5n+YrcXteLUBV0XIiiMzkn4clnP9nUTs9Be2QCuBGLqR929nePYFf+Y2if3zYXzehZYt/7LJjGQQoe81Gr40gYlKLrOgOZo9TjB9T/B6co=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182914; c=relaxed/simple;
	bh=GdnyJiF2SvA5uIAMq/hgOZYgMf4S3fKIQz/rPO1rTps=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=U70J4raVnCaBX+OOTcJFitbdk/K1gagn9TtjGFd1etip6anP77vIV12iz6jWymWz+FtGjr8TyEqk9k9LEBX/lJwR/aYI2vcbNPOGUub9EC2KaoHnqD2m9NOUGLvHDIMeodbfvJl5yNhnGyrVKq4chibMo00An6hC+PYUJT35CaA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=txIchyjf; arc=none smtp.client-ip=209.85.218.52
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f52.google.com with SMTP id a640c23a62f3a-b70b40e0284so11076466b.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182911; x=1762787711; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ioIXshONfo7KD2SpyWyfHADZJi0tff/xzzkpFvsjTAc=;
        b=txIchyjf8XfgJE1gr5VQcme5KwlzLjxJp2LJr44+wzyYteAG3tnWiggoP8xr0JzsMK
         /jemLo/9ZG35/rRCyixPW+VU8qNyfoLSL/hK01fOL9LqCj7Ed3GY9B9F7w2J9n2w2CQs
         Pfns3IT2SyX7VItpbo8QQ6Eueiu5YW6vSypm1+Th7RXHaGaZ9dxZNJ3XhYcTC98YmqBL
         8AaACbtTRSSvTZqsQeOF+uFMGR+l5GS/C99uFmcXX7eQRCRwI5ddwO+AQ0lL1Hq+6v6H
         GPd9SBmmMssGYO5ENdGTkgh8eX5VcLvF+eGZcQEBpdOHS2nXsI/aiRjRb6A+DGO0h6LX
         pMUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182911; x=1762787711;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ioIXshONfo7KD2SpyWyfHADZJi0tff/xzzkpFvsjTAc=;
        b=F5paEjQbiIRYYSI3nOJf/eLY37d3lDQ6r0jB2on4O/mUDltMY2PKqc9IB+zMN3KuUf
         Lrx4mPjiEbNaOmhnLuVvYc2mwhEHN0I9Q5BKrZRkcvJBgRugGU/6dxQZGFh6vXNFThkm
         rdF8oLggtqn/KmXh+nY9XSWtrKBWTjVPDZwxSwvKcwDVhEczO8R3e0kAkukgTKYXA99l
         mIqOgb9jpMNTmHCEYSVaMqcy8tUCVzMZPwtF3KuhntVgPuCL4IpuTPX3BVwTh3tW3sM6
         Ft7sd5Ti9krWTHTQc/3/IGwpIXR5mZZ6Tr1l5sXfBtT8Qp8WdLeqJlUx3+2742fTp2og
         5qXA==
X-Forwarded-Encrypted: i=1; AJvYcCUrAeN4AmZ7+88XaYKwoXGCdvIo+/yOKzfiGZto+mi7sy672DiXVzhfxNWF1rjjglofRe2OMFJfXOU=@vger.kernel.org
X-Gm-Message-State: AOJu0YwMeCVo+U8KPlHWi3NriKYD2JwM7Fivcm1q28+1OAb6sxh32oXv
	/HNdRFItCvwzDSSx3qNETbKCoXWtCW2qW3ZtlT9Fh8hbrG1ShpO1sXMue3Ux5c9znGM=
X-Gm-Gg: ASbGncuZalFhwJpNgJI8iV5LsDbk33A0rhe3KohEXq+/tsElriQsC9wEo3eQ4veBgza
	3FERm7JTW7forAWjQnyuJDrwhlNmBZMa+aH8ta1XNduhnlLWi/uiOfku0Kg2q0ooaUVnDDXF0Ie
	lhuBFHcI9q9IeKtENvbdT8m4d0d2h+C6WyzvO9WZSW6iKGPhcLWvQzv4sS9lKFfowChnR91WoYq
	EhQwin8uwog1dDw/McygdpR9yhJHLC2wMZZiXCICAz+1WjXZ+AkGbcRoa1zkU4gPB+1TR8UrJ3C
	A7Md77+8ruUkkVcTRa1pBIbwGtwSFVo50neBYIfFldV+VXRh1r+vdLDs2hFDPoPjcIQdiKU/avk
	NlApqUXw3a5AzaQfRtgSA8/ml3kYIOc+KRx2CvGph1mI+IlpFbR4ihQyLw646XxH4VHV4N/7prk
	/+48kzrFTAETNEZ/pc
X-Google-Smtp-Source: AGHT+IF5Qs39BDlH4FucuOdA1sqzrZGMVwFxQQ9MDO96IZI88EJut/t4JwJ9XeWpVghluL43Jxeo4w==
X-Received: by 2002:a17:906:e17:b0:b70:e685:5ac8 with SMTP id a640c23a62f3a-b70e68592a2mr155321866b.3.1762182910631;
        Mon, 03 Nov 2025 07:15:10 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:09 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:47 +0100
Subject: [PATCH 07/12] dt-bindings: PCI: qcom,pcie-ipq8074: Move IPQ8074 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-7-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=8349;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=GdnyJiF2SvA5uIAMq/hgOZYgMf4S3fKIQz/rPO1rTps=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbqyfMLniFLiSlsOUX6PInIJYhb4fIEWpFiC
 1OnX5A3fQmJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG6gAKCRDBN2bmhouD
 1xCCD/9H2YGq3HOAqGewY+jOApb48tKAjtgTFslz6Zipmgbzm2cOUGnH7rkpP06/uCF2qVDsEiO
 D36EB2y9fBbeIQbfHsNorFTN0VdlbA6ulKz1EtSFvyjB5fStfAO87D4G06SWRkTuGbi9zfA1QqK
 EVfAk+Etdecus/VD5TCV25XkqZPKvmxBMognDpjustFAFeNYOMYFkzx9vppR6im0BnsVq5CIrop
 agv4QIAbGBr+oo7VM3wdgCufSueYIx0jKZghEueSvzESYqDZAZvdSnhRHGUcardsb2QOZjnIPCT
 yRUUX/rCOLRKRG8YQqxqJXAQwGZ9iN8BHLwQY5XoHi/eXk/8w7fqxtaG7chN5DvMGy6Z8oinClb
 areKTybBmtfbm/paSmqWX89s2wSNn9BJuEAst3c4GG0BTPe0ZhYhINPfTmkfAx784t2/ojJQvWt
 OwCCu8YxOG5eYBiUt6ZwLNTX6V2P81Zk2OQ+WnVwpbxVlF8l85Zekx2vFohy5IDGEvkRRIHZLnG
 8yYinS+7EBKbUP5ZH6X2PAStU1wozzqOCOAlyhtJU+Eo6oveQ7HJ5z45cNj+hsj3WyjN66f1ETn
 Q9EBQ7hsMoKMNkzQPoo8FqzRZmIk2ZWjEXTu5HOwMDKUc74XIkS3XbxH4AcgSuo4sH2RRXDelsN
 87Gy60sHe5lqeGw==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move IPQ8074 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.
 - Expecting eight MSI interrupts and one global, instead of only one,
   which was incomplete hardware description.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq8074.yaml | 165 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  35 -----
 2 files changed, 165 insertions(+), 35 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq8074.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq8074.yaml
new file mode 100644
index 000000000000..da975f943a7b
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq8074.yaml
@@ -0,0 +1,165 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ipq8074.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ8074 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-ipq8074
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
+    maxItems: 5
+
+  clock-names:
+    items:
+      - const: iface # PCIe to SysNOC BIU clock
+      - const: axi_m # AXI Master clock
+      - const: axi_s # AXI Slave clock
+      - const: ahb
+      - const: aux
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
+    maxItems: 7
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
+    #include <dt-bindings/clock/qcom,gcc-ipq8074.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+
+    pcie@10000000 {
+        compatible = "qcom,pcie-ipq8074";
+        reg = <0x10000000 0xf1d>,
+              <0x10000f20 0xa8>,
+              <0x00088000 0x2000>,
+              <0x10100000 0x1000>;
+        reg-names = "dbi", "elbi", "parf", "config";
+        ranges = <0x81000000 0x0 0x00000000 0x10200000 0x0 0x10000>,   /* I/O */
+                 <0x82000000 0x0 0x10220000 0x10220000 0x0 0xfde0000>; /* MEM */
+
+        device_type = "pci";
+        linux,pci-domain = <1>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <1>;
+        max-link-speed = <2>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        clocks = <&gcc GCC_SYS_NOC_PCIE1_AXI_CLK>,
+                 <&gcc GCC_PCIE1_AXI_M_CLK>,
+                 <&gcc GCC_PCIE1_AXI_S_CLK>,
+                 <&gcc GCC_PCIE1_AHB_CLK>,
+                 <&gcc GCC_PCIE1_AUX_CLK>;
+        clock-names = "iface",
+                      "axi_m",
+                      "axi_s",
+                      "ahb",
+                      "aux";
+
+        interrupts = <GIC_SPI 85 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 30 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 31 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 32 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 33 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 34 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 35 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 137 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 84 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi0",
+                          "msi1",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7",
+                          "global";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc 0 GIC_SPI 142 IRQ_TYPE_LEVEL_HIGH>, /* int_a */
+                        <0 0 0 2 &intc 0 GIC_SPI 143 IRQ_TYPE_LEVEL_HIGH>, /* int_b */
+                        <0 0 0 3 &intc 0 GIC_SPI 144 IRQ_TYPE_LEVEL_HIGH>, /* int_c */
+                        <0 0 0 4 &intc 0 GIC_SPI 145 IRQ_TYPE_LEVEL_HIGH>; /* int_d */
+
+        phys = <&pcie_qmp1>;
+        phy-names = "pciephy";
+
+        resets = <&gcc GCC_PCIE1_PIPE_ARES>,
+                 <&gcc GCC_PCIE1_SLEEP_ARES>,
+                 <&gcc GCC_PCIE1_CORE_STICKY_ARES>,
+                 <&gcc GCC_PCIE1_AXI_MASTER_ARES>,
+                 <&gcc GCC_PCIE1_AXI_SLAVE_ARES>,
+                 <&gcc GCC_PCIE1_AHB_ARES>,
+                 <&gcc GCC_PCIE1_AXI_MASTER_STICKY_ARES>;
+        reset-names = "pipe",
+                      "sleep",
+                      "sticky",
+                      "axi_m",
+                      "axi_s",
+                      "ahb",
+                      "axi_m_sticky";
+
+        perst-gpios = <&tlmm 58 GPIO_ACTIVE_LOW>;
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
index 118b88a81396..992a7654626c 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -23,7 +23,6 @@ properties:
           - qcom,pcie-ipq4019
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
-          - qcom,pcie-ipq8074
           - qcom,pcie-ipq9574
           - qcom,pcie-msm8996
       - items:
@@ -144,7 +143,6 @@ allOf:
               - qcom,pcie-ipq4019
               - qcom,pcie-ipq8064
               - qcom,pcie-ipq8064v2
-              - qcom,pcie-ipq8074
     then:
       properties:
         reg:
@@ -315,37 +313,6 @@ allOf:
         resets: false
         reset-names: false
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq8074
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
-            - const: ahb # AHB clock
-            - const: aux # Auxiliary clock
-        resets:
-          minItems: 7
-          maxItems: 7
-        reset-names:
-          items:
-            - const: pipe # PIPE reset
-            - const: sleep # Sleep reset
-            - const: sticky # Core Sticky reset
-            - const: axi_m # AXI Master reset
-            - const: axi_s # AXI Slave reset
-            - const: ahb # AHB Reset
-            - const: axi_m_sticky # AXI Master Sticky reset
-
   - if:
       properties:
         compatible:
@@ -405,7 +372,6 @@ allOf:
                 - qcom,pcie-ipq4019
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
-                - qcom,pcie-ipq8074
                 - qcom,pcie-ipq9574
     then:
       required:
@@ -428,7 +394,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-ipq8074
               - qcom,pcie-msm8996
               - qcom,pcie-msm8998
     then:

-- 
2.48.1


