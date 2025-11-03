Return-Path: <linux-pci+bounces-40119-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3E941C2CE71
	for <lists+linux-pci@lfdr.de>; Mon, 03 Nov 2025 16:52:17 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 40EA5464FEF
	for <lists+linux-pci@lfdr.de>; Mon,  3 Nov 2025 15:26:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 210463148DF;
	Mon,  3 Nov 2025 15:15:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Fqb+Ap+n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-ej1-f45.google.com (mail-ej1-f45.google.com [209.85.218.45])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C0732FE573
	for <linux-pci@vger.kernel.org>; Mon,  3 Nov 2025 15:15:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.218.45
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1762182923; cv=none; b=KbpYCZ1meqsoSRVdK5x0/UXYwrmAMtmIL6rwzg2oE72rmpxnojKHjZ8wWlphr4usiLjoig2/NsDoHj/6py7gZJSqAgzh50+k+fz4enXbfY1/G+JzjLD/my6ZDEYnL3ZfH8tMvDCDaSz95VOrlOTbPtn1Ih/6niyfivA0+7WWmaI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1762182923; c=relaxed/simple;
	bh=fiE1WYTuKmYzY56YIoVVy+YVvbVbFd8mhvn32xKDZZw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-Id:References:
	 In-Reply-To:To:Cc; b=OAL279pyfgqeapP2Andall543lo+GbmXO7ma4D47Q2NceUYSprRCZKzBQheHP32mj+m+u9XJF2uZRjuk56G/6fk0eGhH72vRX0YmcayO3hEFzJDbNZpstAvuubf609lT7dSBc5LFLShAmoPFcgZ3u3vPRiMyKB8JamacEDG9vxw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org; spf=pass smtp.mailfrom=linaro.org; dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b=Fqb+Ap+n; arc=none smtp.client-ip=209.85.218.45
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=linaro.org
Received: by mail-ej1-f45.google.com with SMTP id a640c23a62f3a-b404a8be3f1so62558766b.1
        for <linux-pci@vger.kernel.org>; Mon, 03 Nov 2025 07:15:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1762182919; x=1762787719; darn=vger.kernel.org;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WnkMx27uJCgIz5HUf8NlnnVVAnQB4Ee+Mh1yuMco5wE=;
        b=Fqb+Ap+nU4faQhNA1/5UA5NdmGOPtAlTmgYX0EU4cY9y7vpvjiwOQKjP+h5MDIiWmK
         1GuKktEKSkC15062MqWZEXjkSzkyUfR/oukPiJwoaW2M4u2d6r2xhtMDpDEfJZnp9uLG
         NMZMbeNPlhPGkOeeJdAv+jlTV3ZdSdEsSvZfqr1hsrIWnYDP4zZY2auujKWT7P1XjHTf
         FaCp19ikfMAD0qfSjGueLwLSIyODMUSkzTcWDQTKWd2KeUBGrGICiuaGSTI3zDVQO/xL
         rEQwi2A15XTPQJJTiDI3HB9eYX456vrABu1YXxsVtRacUSQFPv/K3bSu9Bz9IyVQXBAZ
         M1yg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1762182919; x=1762787719;
        h=cc:to:in-reply-to:references:message-id:content-transfer-encoding
         :mime-version:subject:date:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=WnkMx27uJCgIz5HUf8NlnnVVAnQB4Ee+Mh1yuMco5wE=;
        b=M7nBOdX2xngvThRMhBDWTk6UY7o4vc9pO//mDpPmwe+SFzb2mr4D/bTdRDMFwaQ7x9
         BICmwsPdUboaacuYKhaGb6/NUApdcj+/VaNJBLucLQY0r3PlyzKOkbryaANPtTxyioYS
         7B/dS1gnVBfLpMBcoEwvsAaaCDtkNZ2JjXNZVm7LxOL2EMCR4y3+bKrBFEs3lo6qeBSm
         UwKUFg5vxZO0hpTOsib2GwBJi5gGFAjFgPMylMtRRtWcEWnLYjbku5u206mqO+TROENt
         PPpcrlr5A5lXCiw4GzMkpQRDAVoZMfjrWjW+bC6rJkvxVMfikavafsQvh6RyeE0Zu6EQ
         XIlQ==
X-Forwarded-Encrypted: i=1; AJvYcCWmDk75atEx5ya2WmwSOXKbXCrxt13q8QfZpki1X1CguutsBXuVRstxElcqvDT9/+vreP+AEmO0r6c=@vger.kernel.org
X-Gm-Message-State: AOJu0YwrXTnTgLf2oLcUlzBbojeFOl6Bj6L2Y/jugtFN6x7k7GVXjp6M
	59VDhVWjHK0Mp9oOjBkzcZaoR8yq/zm2euchnTrmU3Yt0/HKlxJBuRpxbhK1MRDyq8E=
X-Gm-Gg: ASbGncsCerclI/04D5Zuce3eSyaQoQLI6/+zXB7CJ1W5wvzK0MRHUMusx+adLt81xKs
	Dwni+AgavJQ5XFx4qPkeHC2w+/YiRa1ZnfbVqwYXcm9DGgQWQ501BsfwiHcMTVKIPBDyPSUb1F2
	u6TBRLGmRJ3fevvtCsIF98Gj/wWOoDv8ahV/iR/D0rBxS8MsC347Nlh8okNd7II+4nt9qkldzx3
	oPmuzGYZeVQledPVgEPNUK3hHUVasIyqKcOhKBay6AyO+trDvSafI8H/q90GrvHZvbCvdme9Mxx
	Vcxmgh9BkYo5IRNDEHvEkDlisVejeF/rDMzKSExXut2iH7vtkMGmuL/qInNTGJFAa8KAJTB0tHX
	P3DwPBin3hBPaqko8hfVCC1Yq996MtD6NMNqMHKzjzIA1MGCLKtbHk8HdWxTWxf59VlVofib1j3
	8O72WO+xR5G4nwJPHqMEZieT1fQNQ=
X-Google-Smtp-Source: AGHT+IG3T7tb2Yt2A02oCGM7Q7A8bJNqhBa1XTmmGtX9j9rsUVRi2kSt6P9ULRSy/RxYjvR3tygZrA==
X-Received: by 2002:a17:906:f9da:b0:b70:b6f5:4239 with SMTP id a640c23a62f3a-b70b6f546e4mr200283966b.3.1762182918727;
        Mon, 03 Nov 2025 07:15:18 -0800 (PST)
Received: from [127.0.1.1] ([178.197.219.123])
        by smtp.gmail.com with ESMTPSA id a640c23a62f3a-b7077975dfdsm1045203066b.13.2025.11.03.07.15.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Nov 2025 07:15:17 -0800 (PST)
From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Date: Mon, 03 Nov 2025 16:14:52 +0100
Subject: [PATCH 12/12] dt-bindings: PCI: qcom,pcie-apq8084: Move APQ8084 to
 dedicated schema
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20251103-dt-bindings-pci-qcom-v1-12-c0f6041abf9b@linaro.org>
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
X-Developer-Signature: v=1; a=openpgp-sha256; l=9651;
 i=krzysztof.kozlowski@linaro.org; h=from:subject:message-id;
 bh=fiE1WYTuKmYzY56YIoVVy+YVvbVbFd8mhvn32xKDZZw=;
 b=owEBbQKS/ZANAwAKAcE3ZuaGi4PXAcsmYgBpCMbudKVoMx5Hu6yqSfD5iC+WV2eqbZKfSkUpo
 Fpmq/BPatCJAjMEAAEKAB0WIQTd0mIoPREbIztuuKjBN2bmhouD1wUCaQjG7gAKCRDBN2bmhouD
 106rD/4xXcVAS/pYQaW20Tc+H9ZmFl9U3p3o6XdS022bNxo/No7OUUjKtrhvU5IKr6I/68X+Kqk
 b+QFLo7osRt12g6O6jUCLK7Yfq9ctMVNrmxfU4gSO5OAK9w1AOjfNWvvn/vJizKy/77YOOK0W6V
 epk++c8/jG8bolWJOA5DR29XV18MmdJtzeNNL3m/r2JOGpNQwf5Qgtl23DZRG6sh4TG2kUQnK1s
 Ts5nrDgsYoXD8quriceewfTA+1DMqr86AZKy+f5KiyLByUSerbM6v2Z5gGHEC6J02pxWwiR1qPb
 fswriPDcvcnM85veV6LaglZk/Y6HbCS8bNKXoVO2kY9St6ZQ6PMrDfuuxKDAcFJw+/BcSKJhs3I
 tuqOK1qDzPEKHNzjPh1/c7vbSbpXSPNEprU4TSacsJ2Otdndn7b4xYOS/vW4gGr/8raRhEBKm5C
 Bcsek4C6YwbEb21B8djI7QSIwj5S+4Gf2EwVkP7mfrUzRJFcc/WRzyB3sbOnvBAcloxBC9gnc6T
 7n7D+k4dEV5l4G9IrL3Syz/kBDuBiY8XSEb6KH0yDxEAMaba1MatTGSIJKbEe+fUStN/cHecJbi
 JmxOtzBWQqBEHSjQDC+l3z9KYF0SvUYgMNQog5dYPZTyTYdj7sE03VDFJ3XsRp68mnomlyhaKHW
 p8blykrM8/8VRzA==
X-Developer-Key: i=krzysztof.kozlowski@linaro.org; a=openpgp;
 fpr=9BD07E0E0C51F8D59677B7541B93437D3B41629B

Move APQ8084 PCIe devices from qcom,pcie.yaml binding to a dedicated
file to make reviewing and maintenance easier.

New schema is equivalent to the old one with few changes:
 - Adding a required compatible, which is actually redundant.
 - Drop the really obvious comments next to clock/reg/reset-names items.

After moving the qcom,pcie.yaml becames empty thus can be entirely
removed.

Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
---
 .../devicetree/bindings/pci/qcom,pcie-apq8084.yaml | 109 ++++++++++
 .../devicetree/bindings/pci/qcom,pcie.yaml         | 227 ---------------------
 2 files changed, 109 insertions(+), 227 deletions(-)

diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie-apq8084.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie-apq8084.yaml
new file mode 100644
index 000000000000..a6403a3de076
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/qcom,pcie-apq8084.yaml
@@ -0,0 +1,109 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/qcom,pcie-apq8084.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: Qualcomm APQ8084 PCI Express Root Complex
+
+maintainers:
+  - Bjorn Andersson <andersson@kernel.org>
+  - Manivannan Sadhasivam <mani@kernel.org>
+
+properties:
+  compatible:
+    enum:
+      - qcom,pcie-apq8084
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
+    maxItems: 4
+
+  clock-names:
+    items:
+      - const: iface # Configuration AHB clock
+      - const: master_bus # Master AXI clock
+      - const: slave_bus # Slave AXI clock
+      - const: aux
+
+  interrupts:
+    maxItems: 1
+
+  interrupt-names:
+    items:
+      - const: msi
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    items:
+      - const: core
+
+  vdda-supply:
+    description: A phandle to the core analog power supply
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
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/gpio/gpio.h>
+    pcie@fc520000 {
+      compatible = "qcom,pcie-apq8084";
+      reg = <0xfc520000 0x2000>,
+            <0xff000000 0x1000>,
+            <0xff001000 0x1000>,
+            <0xff002000 0x2000>;
+      reg-names = "parf", "dbi", "elbi", "config";
+      device_type = "pci";
+      linux,pci-domain = <0>;
+      bus-range = <0x00 0xff>;
+      num-lanes = <1>;
+      #address-cells = <3>;
+      #size-cells = <2>;
+      ranges = <0x81000000 0 0          0xff200000 0 0x00100000>,
+               <0x82000000 0 0x00300000 0xff300000 0 0x00d00000>;
+      interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
+      interrupt-names = "msi";
+      #interrupt-cells = <1>;
+      interrupt-map-mask = <0 0 0 0x7>;
+      interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>,
+                      <0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>;
+      clocks = <&gcc 324>,
+               <&gcc 325>,
+               <&gcc 327>,
+               <&gcc 323>;
+      clock-names = "iface", "master_bus", "slave_bus", "aux";
+      resets = <&gcc 81>;
+      reset-names = "core";
+      power-domains = <&gcc 1>;
+      vdda-supply = <&pma8084_l3>;
+      phys = <&pciephy0>;
+      phy-names = "pciephy";
+      perst-gpios = <&tlmm 70 GPIO_ACTIVE_LOW>;
+      pinctrl-0 = <&pcie0_pins_default>;
+      pinctrl-names = "default";
+    };
diff --git a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml b/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
deleted file mode 100644
index b071af484a1e..000000000000
--- a/Documentation/devicetree/bindings/pci/qcom,pcie.yaml
+++ /dev/null
@@ -1,227 +0,0 @@
-# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
-%YAML 1.2
----
-$id: http://devicetree.org/schemas/pci/qcom,pcie.yaml#
-$schema: http://devicetree.org/meta-schemas/core.yaml#
-
-title: Qualcomm PCI express root complex
-
-maintainers:
-  - Bjorn Andersson <bjorn.andersson@linaro.org>
-  - Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-
-description: |
-  Qualcomm PCIe root complex controller is based on the Synopsys DesignWare
-  PCIe IP.
-
-properties:
-  compatible:
-    oneOf:
-      - enum:
-          - qcom,pcie-apq8084
-
-  reg:
-    minItems: 4
-    maxItems: 6
-
-  reg-names:
-    minItems: 4
-    maxItems: 6
-
-  interrupts:
-    minItems: 1
-    maxItems: 9
-
-  interrupt-names:
-    minItems: 1
-    maxItems: 9
-
-  iommu-map:
-    minItems: 1
-    maxItems: 16
-
-  # Common definitions for clocks, clock-names and reset.
-  # Platform constraints are described later.
-  clocks:
-    minItems: 3
-    maxItems: 13
-
-  clock-names:
-    minItems: 3
-    maxItems: 13
-
-  dma-coherent: true
-
-  interconnects:
-    maxItems: 2
-
-  interconnect-names:
-    items:
-      - const: pcie-mem
-      - const: cpu-pcie
-
-  resets:
-    minItems: 1
-    maxItems: 12
-
-  reset-names:
-    minItems: 1
-    maxItems: 12
-
-  vdda-supply:
-    description: A phandle to the core analog power supply
-
-  phys:
-    maxItems: 1
-
-  phy-names:
-    items:
-      - const: pciephy
-
-  power-domains:
-    maxItems: 1
-
-  perst-gpios:
-    description: GPIO controlled connection to PERST# signal
-    maxItems: 1
-
-  required-opps:
-    maxItems: 1
-
-  wake-gpios:
-    description: GPIO controlled connection to WAKE# signal
-    maxItems: 1
-
-required:
-  - compatible
-  - reg
-  - reg-names
-  - interrupt-map-mask
-  - interrupt-map
-  - clocks
-  - clock-names
-
-anyOf:
-  - required:
-      - interrupts
-      - interrupt-names
-      - "#interrupt-cells"
-  - required:
-      - msi-map
-
-allOf:
-  - $ref: /schemas/pci/pci-host-bridge.yaml#
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8084
-    then:
-      properties:
-        reg:
-          minItems: 4
-          maxItems: 5
-        reg-names:
-          minItems: 4
-          items:
-            - const: parf # Qualcomm specific registers
-            - const: dbi # DesignWare PCIe registers
-            - const: elbi # External local bus interface registers
-            - const: config # PCIe configuration space
-            - const: mhi # MHI registers
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8084
-    then:
-      properties:
-        clocks:
-          minItems: 4
-          maxItems: 4
-        clock-names:
-          items:
-            - const: iface # Configuration AHB clock
-            - const: master_bus # Master AXI clock
-            - const: slave_bus # Slave AXI clock
-            - const: aux # Auxiliary (AUX) clock
-        resets:
-          maxItems: 1
-        reset-names:
-          items:
-            - const: core # Core reset
-
-  - if:
-      not:
-        properties:
-          compatible:
-            contains:
-              enum:
-                - qcom,pcie-msm8996
-    then:
-      required:
-        - resets
-        - reset-names
-
-  - if:
-      properties:
-        compatible:
-          contains:
-            enum:
-              - qcom,pcie-apq8084
-    then:
-      properties:
-        interrupts:
-          maxItems: 1
-        interrupt-names:
-          items:
-            - const: msi
-
-unevaluatedProperties: false
-
-examples:
-  - |
-    #include <dt-bindings/interrupt-controller/arm-gic.h>
-    #include <dt-bindings/gpio/gpio.h>
-    pcie@fc520000 {
-      compatible = "qcom,pcie-apq8084";
-      reg = <0xfc520000 0x2000>,
-            <0xff000000 0x1000>,
-            <0xff001000 0x1000>,
-            <0xff002000 0x2000>;
-      reg-names = "parf", "dbi", "elbi", "config";
-      device_type = "pci";
-      linux,pci-domain = <0>;
-      bus-range = <0x00 0xff>;
-      num-lanes = <1>;
-      #address-cells = <3>;
-      #size-cells = <2>;
-      ranges = <0x81000000 0 0          0xff200000 0 0x00100000>,
-               <0x82000000 0 0x00300000 0xff300000 0 0x00d00000>;
-      interrupts = <GIC_SPI 243 IRQ_TYPE_LEVEL_HIGH>;
-      interrupt-names = "msi";
-      #interrupt-cells = <1>;
-      interrupt-map-mask = <0 0 0 0x7>;
-      interrupt-map = <0 0 0 1 &intc 0 244 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 2 &intc 0 245 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 3 &intc 0 247 IRQ_TYPE_LEVEL_HIGH>,
-                      <0 0 0 4 &intc 0 248 IRQ_TYPE_LEVEL_HIGH>;
-      clocks = <&gcc 324>,
-               <&gcc 325>,
-               <&gcc 327>,
-               <&gcc 323>;
-      clock-names = "iface", "master_bus", "slave_bus", "aux";
-      resets = <&gcc 81>;
-      reset-names = "core";
-      power-domains = <&gcc 1>;
-      vdda-supply = <&pma8084_l3>;
-      phys = <&pciephy0>;
-      phy-names = "pciephy";
-      perst-gpios = <&tlmm 70 GPIO_ACTIVE_LOW>;
-      pinctrl-0 = <&pcie0_pins_default>;
-      pinctrl-names = "default";
-    };
-...

-- 
2.48.1


