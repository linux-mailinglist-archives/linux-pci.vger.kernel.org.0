Return-Path: <linux-pci+bounces-40112-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 21B97C2CC5D
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:34:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 18B99188C487
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:24:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1F5B032573C;
	Mon,  3 Nov 2025 15:15:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="d1Ng/kJZ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 86667328615
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182911; cv=none; b=VNMJIXdd4kLHshrwYBgCaf/oTXv7NxHvflmDKXrGSq2wssftksZDPyu5d6LtgnOZLddUfWXMUyYzp8h+W0/p0ELKfU7qByaspzFi4/De1qTY1VSSrIJ1d2mhxlY8oM6JM2ku6l0EzWn8YF8TXPP9qn2mXzBTMHpiTX+7b2V7gEc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182911; c=relaxed/simple;
	bh=til4sQr7MWcrdM+qtVBJY/D233DcIw1zsVGcrlHAbeY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=Z2C+kNM0TWFhpx0K6Lat4cT+/qu/rU9YELRLtRGPtjKj6JodyKwI3NnpQKH4vLARLv3S2w/u/1ryj7LS85svHs1CiNCnJQJoY50VJ7gaZVb120oeg+TyfFqvSFIw6sIt/OWtPnRIGQ9HFlWwDkyOKnbXxbKS7jSjT1YWCP8cR20=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=d1Ng/kJZ; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b70b40e0321so10364866b.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182907; x=1762787707; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kqEHvrB/44YWkcS8m6XjeDj/vBPezFqRGhiIvZkEYbM=;
        b=d1Ng/kJZgp8uJanbWikkO/uysohDRkfnCprCDPLL3lR/baQDQZ2A97lZ7CQrVBYDcp
         /CCcduJBSGgQ09++8aPbCtTEmNDOjIYbhre5XVERaew9VbuVV3Xl/B+atouooCXq6c9I
         KHydQBcRc+jTz3IRbruaoeuJ0g1WUw/8FeGfC1CREe3ttV489uUvxgTkHOp22U11y3Zx
         VWx2rfQAbrPNcaLXJhvDpge9oa9WkP+nd+84NUWbrjDdX240dvdt790ZAx/YyxJCedBq
         bFTyDC+jLZoox+PAaDD8ZzKwRV1S1ey0xFWDLnCwnsiilwtMJz17HB0Mt9V2c3kDN3EV
         rJXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182907; x=1762787707;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=kqEHvrB/44YWkcS8m6XjeDj/vBPezFqRGhiIvZkEYbM=;
        b=gpoLIIq0/HNEragbZ4sBzj6AZ/0Ek093S8a71aqTUVJYL8edxxXNmnKAlNIquw4SUg
         QkikPd9kB5NwQ+u9W3mqmPCF5S+D9Es2lxu/AkZddYRSoH3VE1bYbqjqoF/AzXSNi4E8
         13SMHkGe9HeJuzMoAAMFqSl21nDN1BIQ+bAO8Tcew+SdLN48sYB//bWeqf4Szdf04C5C
         /x4W8xgj1ve53MCa5oCHCSIe5EUmTk5Hq5Uyqmfb9Y3nbBQ6KBASef0TAuUT4ecvjWgV
         bg8bkjumzKrWKxEBEdgx2svDM6MzsvDLh446iuhGZKEFwVTqoW8866eE27cs8IEiT+lw
         wjVQ==
X-Forwarded-Encrypted: i=1; AJvYcCW6cq850q3yAIKOuXgEDOFqIoU3aDX+jx1ZgM6EzzldC1MCbcyqPN2vsYZbkB4OIMt5MyZcLBki76Y=@vger.kernel.org
X-Gm-Message-State: AOJu0Yxv8FPW/NWdhMbrDl2B2Ku6kbh++WIF7yu4al4NIufrgnClyx1z
	qswNxKprYDRSzCrVYZvFG//RdKCzypMMi2rZFmIi0nwYNLRMUSCwzAoDa9tRUoPjBuE=
X-Gm-Gg: ASbGncsZiLpavltC6GSWMM28BOiUhG6V3tBJku80yYuPLjVKWjDc6o13cLvTl6I6vi8
	1woQO2NNJh/HfFN9FHBoOfpNxif0/PObCPAF8NTejJJkknOX5uU+E/vAEBXSXBE8UvfhrBwmtAO
	tI3sA+YaweQdkim2RiyxjtGd58D1UY0qskM0pzJuVN/NZntfIZ2GXdu1fZomupNey723/fokzSk
	Ir8UiORRSZeKmbEZqMLp9f4igqRGk/nU2d/kdzXri5/me/bumL+pDCPzCdnwUGUp4WzHFi6jU70
	seLn/yxiR9MqQCfiw7vsC2PNLr6dfWoOkeQBnq610v33OxqVonL0anGOKUw2/29KnJ0bYbVXk+5
	+eo8kdtC2NK3O7OpmxXNFvST+C4G20iOBA9xEOzwfpiGrMydW2p//ISXYzsPzdI3XFB9lhyixK0
	kzpRilMgsI6CS0pCOwTQIsOVw8anuPCGScFozVRQ==
X-Google-Smtp-Source: AGHT+IFzPggyxfuxTl4ykhrC9J4pjcXf9kh78gnM8Ayg9GewFhjfYbzWLVipXRWeFxb5APD/iBPRIQ==
X-Received: by 2002:a17:907:9488:b0:b70:b45d:d9c2 with SMTP id a640c23a62f3a-b70b45ded9cmr274850566b.9.1762182906750;
        Mon, 03 Nov 2025 07:15:06 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:06 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:45 +0100
Subject: [PATCH 05/12] dt-bindings: PCI: qcom,pcie-ipq5018: Move IPQ5018 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-5-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9313;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=til4sQr7MWcrdM+qtVBJY/D233DcIw1zsVGcrlHAbeY=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbo64aLs3UvHARvY7rU4JxQmgU+lguKuHs8l
 GZLBOugVS2JAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG6AAKCRDBN2bmhouD
 19KoD/9ggwDlCwWRyGTyMQUUxcqvWBOuJNDxVOJjFkFZ0rreB0XEtfjAwE6SAlW7HS+jhCIYWdj
 yjrfbnOE6yi4rwAiDLr7Y8s3f9W/H9kFKCqwD798iJfALjL9dKbQ/1TSKipPKcS2MLlmXNkdZyQ
 vUCCDFRnO9jFHxnrGtwS6NRqQnt3vUkDZ2ODc1eH1OhRlKAeDg8XVWq4BRv6QBh8dCuY4lROV/q
 nXpoe2IVHPdb4NaNwp4vrppw6lTLCFs3TrUtflkm+vVMiPAaUjST/v+T2FbJxzddX+nVpL+mqGj
 eZJbBFOKDmQtfC2jvH3heT1TGZ2OH5SYcGrh9p+vWNitef59KqTkJAQi7aD4oVQYdzy4274hHOO
 5Dvk5jiwj3w4FE85xfudy3rPqfIFT1FInc2JGYBxaDbNkahZcmuGCgjd98W2/C/ybp+tPR1uxRC
 nW5ECs1pBSHrSbwBrGszyT8/uF3hIAVfYmMd3u6ZWM2WdQbSJMcQIPimzDo4rEG2bAv1Ue4gnoH
 Zs2veCHZVEvSTlzWjghAPdqy6pqfi1NdvVs3A+FVeVROfq8gGCXbHcAamhO7RLORkPN9zc3JpNV
 gP2Z6mLWyhuTXaWWTeY3zd+8kvD37Z0A76vnYl3CosOsBH0oOs0SpO/hPIgOocbBDvR7KLXkjoq
 wdIZD/EbCY0+Jbg==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move IPQ5018 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-ipq5018.yaml | 189 +++++++++++++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         |  50 ------
 2 files changed, 189 insertions(+), 50 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-ipq5018.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq5018.yaml
new file mode 100644
index 000000000000..20c2c946f474
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-ipq5018.yaml
@@ -0,0 +1,189 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-ipq5018.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm IPQ5018 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-ipq5018
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
+    maxItems: 6
+
+  clock-names:
+    items:
+      - const: iface # PCIe to SysNOC BIU clock
+      - const: axi_m # AXI Master clock
+      - const: axi_s # AXI Slave clock
+      - const: ahb
+      - const: aux
+      - const: axi_bridge
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
+    #include <dt-bindings/clock/qcom,gcc-ipq5018.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/reset/qcom,gcc-ipq5018.h>
+
+    pcie@a0000000 {
+        compatible = "qcom,pcie-ipq5018";
+        reg = <0xa0000000 0xf1d>,
+              <0xa0000f20 0xa8>,
+              <0xa0001000 0x1000>,
+              <0x00080000 0x3000>,
+              <0xa0100000 0x1000>,
+              <0x00083000 0x1000>;
+        reg-names = "dbi",
+                    "elbi",
+                    "atu",
+                    "parf",
+                    "config",
+                    "mhi";
+        ranges = <0x01000000 0 0x00000000 0xa0200000 0 0x00100000>,
+                 <0x02000000 0 0xa0300000 0xa0300000 0 0x10000000>;
+
+        device_type = "pci";
+        linux,pci-domain = <0>;
+        bus-range = <0x00 0xff>;
+        num-lanes = <2>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+
+        /* The controller supports Gen3, but the connected PHY is Gen2-capable */
+        max-link-speed = <2>;
+
+        clocks = <&gcc GCC_SYS_NOC_PCIE0_AXI_CLK>,
+                 <&gcc GCC_PCIE0_AXI_M_CLK>,
+                 <&gcc GCC_PCIE0_AXI_S_CLK>,
+                 <&gcc GCC_PCIE0_AHB_CLK>,
+                 <&gcc GCC_PCIE0_AUX_CLK>,
+                 <&gcc GCC_PCIE0_AXI_S_BRIDGE_CLK>;
+        clock-names = "iface",
+                      "axi_m",
+                      "axi_s",
+                      "ahb",
+                      "aux",
+                      "axi_bridge";
+
+        msi-map = <0x0 &v2m0 0x0 0xff8>;
+
+        interrupts = <GIC_SPI 52 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 55 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 56 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 57 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 59 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 63 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 68 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>,
+                     <GIC_SPI 51 IRQ_TYPE_LEVEL_HIGH>;
+        interrupt-names = "msi0",
+                          "msi1",
+                          "msi2",
+                          "msi3",
+                          "msi4",
+                          "msi5",
+                          "msi6",
+                          "msi7",
+                          "global";
+
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 0x7>;
+        interrupt-map = <0 0 0 1 &intc 0 GIC_SPI 75 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &intc 0 GIC_SPI 78 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &intc 0 GIC_SPI 79 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &intc 0 GIC_SPI 83 IRQ_TYPE_LEVEL_HIGH>;
+
+        phys = <&pcie0_phy>;
+        phy-names = "pciephy";
+
+        resets = <&gcc GCC_PCIE0_PIPE_ARES>,
+                 <&gcc GCC_PCIE0_SLEEP_ARES>,
+                 <&gcc GCC_PCIE0_CORE_STICKY_ARES>,
+                 <&gcc GCC_PCIE0_AXI_MASTER_ARES>,
+                 <&gcc GCC_PCIE0_AXI_SLAVE_ARES>,
+                 <&gcc GCC_PCIE0_AHB_ARES>,
+                 <&gcc GCC_PCIE0_AXI_MASTER_STICKY_ARES>,
+                 <&gcc GCC_PCIE0_AXI_SLAVE_STICKY_ARES>;
+        reset-names = "pipe",
+                      "sleep",
+                      "sticky",
+                      "axi_m",
+                      "axi_s",
+                      "ahb",
+                      "axi_m_sticky",
+                      "axi_s_sticky";
+
+        perst-gpios = <&tlmm 15 GPIO_ACTIVE_LOW>;
+        wake-gpios = <&tlmm 16 GPIO_ACTIVE_LOW>;
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
index df58e52cc0b9..62af2562ae2b 100644
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
@@ -21,7 +21,6 @@ properties:
           - qcom,pcie-apq8064
           - qcom,pcie-apq8084
           - qcom,pcie-ipq4019
-          - qcom,pcie-ipq5018
           - qcom,pcie-ipq6018
           - qcom,pcie-ipq8064
           - qcom,pcie-ipq8064-v2
@@ -165,7 +164,6 @@ allOf:
         compatible:
           contains:
             enum:
-              - qcom,pcie-ipq5018
               - qcom,pcie-ipq6018
               - qcom,pcie-ipq8074-gen3
               - qcom,pcie-ipq9574
@@ -300,53 +298,6 @@ allOf:
             - const: ahb # AHB reset
             - const: phy_ahb # PHY AHB reset
 
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-ipq5018
-    then:
-      properties:
-        clocks:
-          minItems: 6
-          maxItems: 6
-        clock-names:
-          items:
-            - const: iface # PCIe to SysNOC BIU clock
-            - const: axi_m # AXI Master clock
-            - const: axi_s # AXI Slave clock
-            - const: ahb # AHB clock
-            - const: aux # Auxiliary clock
-            - const: axi_bridge # AXI bridge clock
-        resets:
-          minItems: 8
-          maxItems: 8
-        reset-names:
-          items:
-            - const: pipe # PIPE reset
-            - const: sleep # Sleep reset
-            - const: sticky # Core sticky reset
-            - const: axi_m # AXI master reset
-            - const: axi_s # AXI slave reset
-            - const: ahb # AHB reset
-            - const: axi_m_sticky # AXI master sticky reset
-            - const: axi_s_sticky # AXI slave sticky reset
-        interrupts:
-          minItems: 9
-          maxItems: 9
-        interrupt-names:
-          items:
-            - const: msi0
-            - const: msi1
-            - const: msi2
-            - const: msi3
-            - const: msi4
-            - const: msi5
-            - const: msi6
-            - const: msi7
-            - const: global
-
   - if:
       properties:
         compatible:
@@ -489,7 +440,6 @@ allOf:
               enum:
                 - qcom,pcie-apq8064
                 - qcom,pcie-ipq4019
-                - qcom,pcie-ipq5018
                 - qcom,pcie-ipq8064
                 - qcom,pcie-ipq8064v2
                 - qcom,pcie-ipq8074

-- 
2.48.1


