Return-Path: <linux-pci+bounces-43055-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id 2CFDBCBE619
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 15:49:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id 8A1C230D7412
	for <lists+linux-pci@lfdr.de>; Mon, 15 Dec 2025 14:42:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EEB3D219E8D;
	Mon, 15 Dec 2025 14:16:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="T8Zfqbvo"
X-Original-To: linux-pci@vger.kernel.org
Received: from mail-pf1-f175.google.com (mail-pf1-f175.google.com [209.85.210.175])
	(using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2DFE1315D27
	for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 14:16:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=209.85.210.175
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1765808192; cv=none; b=KMAfzjcgJ+raKCxTxfJTTlfmY9N1WdeQyfM2C7l0htrXkFC+jAehQQVhTpXUzqHSa7ZHee0f3FHtH1YqKswCm8vl5oi66QALW18DaRqFd64+VaVovjTxX9otHDNZWSfZAoigVrungOr4omYGc4olhdo1JaE/xDe3Ts/+WeGXnjU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1765808192; c=relaxed/simple;
	bh=0pCDhRemTg9fKTJmQ8FHzQY2fhlDQ02Wiqvb1ZF6NbE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BuyvqLIBHSYOfUw5A4XlXooj3SDoWchCJTB1BsWNdeRlV0BAnM7W5YITJzAnyCEjD/sCocuTPrSzcvQgYL0AiQma/xo/2SVCTkQ2gucWDAU8Zc/3oYFjeoWZOFLMlnEN4tYCvLpAz8jgBAmIifP1d6BGHFnygr0zdck9+H/4N/0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com; spf=pass smtp.mailfrom=gmail.com; dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b=T8Zfqbvo; arc=none smtp.client-ip=209.85.210.175
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=gmail.com
Received: by mail-pf1-f175.google.com with SMTP id d2e1a72fcca58-7b80fed1505so3397654b3a.3
        for <linux-pci@vger.kernel.org>; Mon, 15 Dec 2025 06:16:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20230601; t=1765808183; x=1766412983; darn=vger.kernel.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Y8wnqDbBImd1qmZnZ5Hjdg9GR4OXyRgE4MqO85hlduE=;
        b=T8ZfqbvoByXicCKdIGv1gb8VqvmO98GI7bgV0sPqhCRJSikZrRGu1eoUkNgcuDjuhW
         czGIBDK0YgJ5zMt14sntKRduxkkE2a9hqlRwnZelnnQ6O4E0cYhfQy2zRRk4znOU7Zzr
         IeE5ng99uFY+4QOK4YzU66nEu0bvNnCzxj903JW/Y0LC8QGkOix+X5qiAQ0NlKOeZ21R
         qGfERtIba901eR+jgla8fE7HKA5x5Nt+GpsNTplQ47mpKOSz8fzPb6YQbfj4PUaLdQs5
         1GjrPkxTCbXYS+GaX+6LzMUS34SRuoqFb5GdOR292fvsoUUuCl8pHpEE/aaH05FLF9G+
         cicQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1765808183; x=1766412983;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Y8wnqDbBImd1qmZnZ5Hjdg9GR4OXyRgE4MqO85hlduE=;
        b=rU7LdZv/GUWHV/kxFeHzOFE38WEmi4j/tXt4Bu/rNgkXJVkvmE2+8Myf2d+IIQb6Sz
         PijNiNBKMMNPS+TqAL6oV0/tDuljJxConOekR8ZvCCpuhwrBYYX7xEh05z4nI1QP8Ynw
         WgceUYQp6aLtI+1gwK+Up1WqkWiUoeixi9oi1ZqQdGlYGp4jFZooH1eJ2oX3/2ew9lmT
         6qszXtXuqUG1EYiFXMGsRh7j4D3U+tthwqjw40YafmxPQt/hTnfOV5UtxIrJEhTIIi3y
         S+nRidfM7AxU8BWIcAp/5JpnqWWxRduh8GI9USih0NBaVVUeNlzShswX3VhiXGh/J3zk
         5wqg==
X-Forwarded-Encrypted: i=1; AJvYcCXwtZ6LLL0VNaW4bTSgCwferRr2MeulMt7BjgotDisXGe85et95qASQw8ujf2B/2QV5IKToD7nIUeM=@vger.kernel.org
X-Gm-Message-State: AOJu0YwC63x+7m0LsFO8TAyhEcourXI2KDxvLh05MroSzZGb0fKDcr2k
	9tKTswQYN5Fnj3bDBRnFug153V9aOWS/WjwcRxAJ1O8lyw2A/QSaxK/u
X-Gm-Gg: AY/fxX61QUJSJsxgtTNK0Birykmg+K7lC9pR3sdzoWQKIKxuyiZ+MRh7PdnV4VI1mz4
	tPm+PClmPTWLGsylRRM1Q8oxl5nUCn8CEfOOGQA+mro6UapwLYOg0pHD66SlPucCV60CzdGRqcN
	nDw960h/v/4XBeAvvrYCf3FftutkdFL7OkoJQDCsvnx1JV6r51iaao/SLqVuhTWAWs5Q1FvfvGY
	lZU3+2IW16ngdhx4xf67LrLI5nhjZcGvAvKIQF6x5CXMFUKqAT2LzJ3Wqo2fdVP9SWlVhvnoJgC
	bjDtsYG6ga4eZDzu0rRuqult+zM4P/6VHvoQfWf17FXhP4wzEyU/t4GdTmPsQU42GpvoykBnVDc
	ecpgw2Z7094D90VbJrkdpn15htZ3uGmWcI9sMhQGeBVl5oqM+KZWkz5ajoi/O5Tkpff6bsnbj1N
	o0HN5GmklOHLLQe9Ur
X-Google-Smtp-Source: AGHT+IEn5wFJ8b8UW1wdrOP3l8owVOZAScQchleLlgVgC/ATlrAe83cGwCkEd6QxnYcKXR+rNew6HQ==
X-Received: by 2002:a05:6a00:430a:b0:7e8:4398:b36b with SMTP id d2e1a72fcca58-7f669c8517bmr9559936b3a.62.1765808182929;
        Mon, 15 Dec 2025 06:16:22 -0800 (PST)
Received: from rockpi-5b ([45.112.0.8])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-7f4c2772a51sm12938189b3a.17.2025.12.15.06.16.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 Dec 2025 06:16:22 -0800 (PST)
From: Anand Moon <linux.amoon@gmail.com>
To: Bjorn Helgaas <bhelgaas@google.com>,
	Lorenzo Pieralisi <lpieralisi@kernel.org>,
	=?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Manivannan Sadhasivam <mani@kernel.org>,
	Rob Herring <robh@kernel.org>,
	Krzysztof Kozlowski <krzk+dt@kernel.org>,
	Conor Dooley <conor+dt@kernel.org>,
	Thierry Reding <thierry.reding@gmail.com>,
	Jonathan Hunter <jonathanh@nvidia.com>,
	linux-pci@vger.kernel.org (open list:PCI SUBSYSTEM),
	devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED DEVICE TREE BINDINGS),
	linux-tegra@vger.kernel.org (open list:TEGRA ARCHITECTURE SUPPORT),
	linux-kernel@vger.kernel.org (open list)
Cc: Anand Moon <linux.amoon@gmail.com>,
	Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v2 1/4] dt-bindings: PCI: Convert nvidia,tegra-pcie to DT schema
Date: Mon, 15 Dec 2025 19:45:34 +0530
Message-ID: <20251215141603.6749-2-linux.amoon@gmail.com>
X-Mailer: git-send-email 2.50.1
In-Reply-To: <20251215141603.6749-1-linux.amoon@gmail.com>
References: <20251215141603.6749-1-linux.amoon@gmail.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit

Convert the existing text-based DT bindings documentation for the
NVIDIA Tegra PCIe host controller to a DT schema format.

Cc: Jon Hunter <jonathanh@nvidia.com>
Signed-off-by: Anand Moon <linux.amoon@gmail.com>
---
v2: Tried to address the isssue Rob pointed
[1] https://lkml.org/lkml/2025/9/26/704
improve the $suject and commit message
drop few examples only nvidia,tegra20-pcie and nvidia,tegra210-pcie

$ make dt_binding_check DT_SCHEMA_FILES=Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
---
 .../bindings/pci/nvidia,tegra-pcie.yaml       | 380 ++++++++++
 .../bindings/pci/nvidia,tegra20-pcie.txt      | 670 ------------------
 2 files changed, 380 insertions(+), 670 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
 delete mode 100644 Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt

diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
new file mode 100644
index 000000000000..e542adfe37b4
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/nvidia,tegra-pcie.yaml
@@ -0,0 +1,380 @@
+# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/nvidia,tegra-pcie.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: NVIDIA Tegra PCIe Controller
+
+maintainers:
+  - Jon Hunter <jonathanh@nvidia.com>
+  - Thierry Reding <treding@nvidia.com>
+
+description:
+  PCIe controller found on NVIDIA Tegra SoCs which supports multiple
+  root ports and platform-specific clock, reset, and power supply
+  configurations.
+
+properties:
+  compatible:
+    enum:
+      - nvidia,tegra20-pcie
+      - nvidia,tegra30-pcie
+      - nvidia,tegra124-pcie
+      - nvidia,tegra210-pcie
+      - nvidia,tegra186-pcie
+
+  reg:
+    items:
+      - description: PADS registers
+      - description: AFI registers
+      - description: Configuration space region
+
+  reg-names:
+    items:
+      - const: pads
+      - const: afi
+      - const: cs
+
+  interrupts:
+    items:
+      - description: Controller interrupt
+      - description: MSI interrupt
+
+  interrupt-names:
+    items:
+      - const: intr
+      - const: msi
+
+  clocks:
+    minItems: 3
+    items:
+      - description: PCIe clock
+      - description: AFI clock
+      - description: PLL_E clock
+      - description: Optional CML clock
+
+  clock-names:
+    description: Names of clocks used by the PCIe controller
+    minItems: 3
+    items:
+      - const: pex
+      - const: afi
+      - const: pll_e
+      - const: cml
+
+  resets:
+    items:
+      - description: PCIe reset
+      - description: AFI reset
+      - description: PCIe-X reset
+
+  reset-names:
+    items:
+      - const: pex
+      - const: afi
+      - const: pcie_x
+
+  power-domains:
+    maxItems: 1
+
+  interconnects:
+    minItems: 1
+    maxItems: 2
+
+  interconnect-names:
+    items:
+      - const: dma-mem
+      - const: write
+
+  pinctrl-names:
+    items:
+      - const: default
+      - const: idle
+
+  pinctrl-0: true
+  pinctrl-1: true
+
+  operating-points-v2:
+    description:
+      Should contain freqs and voltages and opp-supported-hw property, which
+      is a bitfield indicating SoC speedo ID mask.
+
+patternProperties:
+  "^pci@[0-9a-f]+(,[0-9a-f]+)?$":
+    type: object
+    allOf:
+      - $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      nvidia,num-lanes:
+        description: Number of lanes used by this PCIe port
+        $ref: /schemas/types.yaml#/definitions/uint32
+        enum:
+          - 1
+          - 2
+          - 4
+
+    required:
+      - nvidia,num-lanes
+
+    unevaluatedProperties: false
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra20-pcie
+              - nvidia,tegra186-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 3
+        clock-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pll_e
+        resets:
+          maxItems: 3
+        reset-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pcie_x
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra30-pcie
+              - nvidia,tegra124-pcie
+              - nvidia,tegra210-pcie
+    then:
+      properties:
+        clocks:
+          maxItems: 4
+        clock-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pll_e
+            - const: cml
+        resets:
+          maxItems: 3
+        reset-names:
+          items:
+            - const: pex
+            - const: afi
+            - const: pcie_x
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra20-pcie
+              - nvidia,tegra30-pcie
+    then:
+      required:
+        - power-domains
+        - operating-points-v2
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra186-pcie
+    then:
+      required:
+        - interconnects
+
+  - if:
+      properties:
+        compatible:
+          contains:
+            enum:
+              - nvidia,tegra210-pcie
+    then:
+      required:
+        - pinctrl-names
+        - pinctrl-0
+        - pinctrl-1
+
+unevaluatedProperties: false
+
+required:
+  - compatible
+  - reg
+  - reg-names
+  - clocks
+  - clock-names
+  - resets
+  - reset-names
+  - interrupts
+  - interrupt-map
+  - interrupt-map-mask
+
+examples:
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+        #address-cells = <1>;
+        #size-cells = <1>;
+
+        pcie@80003000 {
+            compatible = "nvidia,tegra20-pcie";
+            device_type = "pci";
+            reg = <0x80003000 0x00000800>,
+                  <0x80003800 0x00000200>,
+                  <0x90000000 0x10000000>;
+            reg-names = "pads", "afi", "cs";
+            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "intr", "msi";
+            interrupt-parent = <&intc>;
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+            bus-range = <0x00 0xff>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            ranges = <0x02000000 0 0x80000000 0x80000000 0 0x00001000>,
+                     <0x02000000 0 0x80001000 0x80001000 0 0x00001000>,
+                     <0x01000000 0 0          0x82000000 0 0x00010000>,
+                     <0x02000000 0 0xa0000000 0xa0000000 0 0x08000000>,
+                     <0x42000000 0 0xa8000000 0xa8000000 0 0x18000000>;
+
+            clocks = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 118>;
+            clock-names = "pex", "afi", "pll_e";
+            resets = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 74>;
+            reset-names = "pex", "afi", "pcie_x";
+            power-domains = <&pd_core>;
+            operating-points-v2 = <&pcie_dvfs_opp_table>;
+
+            status = "okay";
+
+            pci@1,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
+                reg = <0x000800 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <2>;
+            };
+
+            pci@2,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82001000 0 0x80001000 0 0x1000>;
+                reg = <0x001000 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <2>;
+            };
+        };
+    };
+  - |
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/interrupt-controller/irq.h>
+
+    bus {
+        #address-cells = <2>;
+        #size-cells = <2>;
+
+        pcie@1003000 {
+            compatible = "nvidia,tegra210-pcie";
+            device_type = "pci";
+            reg = <0x0 0x01003000 0x0 0x00000800>,
+                  <0x0 0x01003800 0x0 0x00000800>,
+                  <0x0 0x02000000 0x0 0x10000000>;
+            reg-names = "pads", "afi", "cs";
+            interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>,
+                         <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>;
+            interrupt-names = "intr", "msi";
+            interrupt-parent = <&gic>;
+
+            #interrupt-cells = <1>;
+            interrupt-map-mask = <0 0 0 0>;
+            interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
+
+            bus-range = <0x00 0xff>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+
+            ranges = <0x02000000 0 0x01000000 0x0 0x01000000 0 0x00001000>,
+                     <0x02000000 0 0x01001000 0x0 0x01001000 0 0x00001000>,
+                     <0x01000000 0 0x0        0x0 0x12000000 0 0x00010000>,
+                     <0x02000000 0 0x13000000 0x0 0x13000000 0 0x0d000000>,
+                     <0x42000000 0 0x20000000 0x0 0x20000000 0 0x20000000>;
+
+            clocks = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 263>,
+                     <&tegra_car 300>;
+            clock-names = "pex", "afi", "pll_e", "cml";
+            resets = <&tegra_car 70>,
+                     <&tegra_car 72>,
+                     <&tegra_car 74>;
+            reset-names = "pex", "afi", "pcie_x";
+
+            pinctrl-names = "default", "idle";
+            pinctrl-0 = <&pex_dpd_disable>;
+            pinctrl-1 = <&pex_dpd_enable>;
+
+            status = "okay";
+
+            pci@1,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
+                reg = <0x000800 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <4>;
+            };
+
+            pci@2,0 {
+                device_type = "pci";
+                assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
+                reg = <0x001000 0 0 0 0>;
+                bus-range = <0x00 0xff>;
+                status = "okay";
+
+                #address-cells = <3>;
+                #size-cells = <2>;
+                ranges;
+
+                nvidia,num-lanes = <1>;
+            };
+        };
+    };
diff --git a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt b/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
deleted file mode 100644
index d099f3476ccc..000000000000
--- a/Documentation/devicetree/bindings/pci/nvidia,tegra20-pcie.txt
+++ /dev/null
@@ -1,670 +0,0 @@
-NVIDIA Tegra PCIe controller
-
-Required properties:
-- compatible: Must be:
-  - "nvidia,tegra20-pcie": for Tegra20
-  - "nvidia,tegra30-pcie": for Tegra30
-  - "nvidia,tegra124-pcie": for Tegra124 and Tegra132
-  - "nvidia,tegra210-pcie": for Tegra210
-  - "nvidia,tegra186-pcie": for Tegra186
-- power-domains: To ungate power partition by BPMP powergate driver. Must
-  contain BPMP phandle and PCIe power partition ID. This is required only
-  for Tegra186.
-- device_type: Must be "pci"
-- reg: A list of physical base address and length for each set of controller
-  registers. Must contain an entry for each entry in the reg-names property.
-- reg-names: Must include the following entries:
-  "pads": PADS registers
-  "afi": AFI registers
-  "cs": configuration space region
-- interrupts: A list of interrupt outputs of the controller. Must contain an
-  entry for each entry in the interrupt-names property.
-- interrupt-names: Must include the following entries:
-  "intr": The Tegra interrupt that is asserted for controller interrupts
-  "msi": The Tegra interrupt that is asserted when an MSI is received
-- bus-range: Range of bus numbers associated with this controller
-- #address-cells: Address representation for root ports (must be 3)
-  - cell 0 specifies the bus and device numbers of the root port:
-    [23:16]: bus number
-    [15:11]: device number
-  - cell 1 denotes the upper 32 address bits and should be 0
-  - cell 2 contains the lower 32 address bits and is used to translate to the
-    CPU address space
-- #size-cells: Size representation for root ports (must be 2)
-- ranges: Describes the translation of addresses for root ports and standard
-  PCI regions. The entries must be 6 cells each, where the first three cells
-  correspond to the address as described for the #address-cells property
-  above, the fourth cell is the physical CPU address to translate to and the
-  fifth and six cells are as described for the #size-cells property above.
-  - The first two entries are expected to translate the addresses for the root
-    port registers, which are referenced by the assigned-addresses property of
-    the root port nodes (see below).
-  - The remaining entries setup the mapping for the standard I/O, memory and
-    prefetchable PCI regions. The first cell determines the type of region
-    that is setup:
-    - 0x81000000: I/O memory region
-    - 0x82000000: non-prefetchable memory region
-    - 0xc2000000: prefetchable memory region
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- #interrupt-cells: Size representation for interrupts (must be 1)
-- interrupt-map-mask and interrupt-map: Standard PCI IRQ mapping properties
-  Please refer to the standard PCI bus binding document for a more detailed
-  explanation.
-- clocks: Must contain an entry for each entry in clock-names.
-  See ../clocks/clock-bindings.txt for details.
-- clock-names: Must include the following entries:
-  - pex
-  - afi
-  - pll_e
-  - cml (not required for Tegra20)
-- resets: Must contain an entry for each entry in reset-names.
-  See ../reset/reset.txt for details.
-- reset-names: Must include the following entries:
-  - pex
-  - afi
-  - pcie_x
-
-Optional properties:
-- pinctrl-names: A list of pinctrl state names. Must contain the following
-  entries:
-  - "default": active state, puts PCIe I/O out of deep power down state
-  - "idle": puts PCIe I/O into deep power down state
-- pinctrl-0: phandle for the default/active state of pin configurations.
-- pinctrl-1: phandle for the idle state of pin configurations.
-
-Required properties on Tegra124 and later (deprecated):
-- phys: Must contain an entry for each entry in phy-names.
-- phy-names: Must include the following entries:
-  - pcie
-
-These properties are deprecated in favour of per-lane PHYs define in each of
-the root ports (see below).
-
-Power supplies for Tegra20:
-- avdd-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-- vdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-- avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
-  supply 1.05 V.
-- avdd-plle-supply: Power supply for PLLE, which is shared with SATA. Must
-  supply 1.05 V.
-- vddio-pex-clk-supply: Power supply for PCIe clock. Must supply 3.3 V.
-
-Power supplies for Tegra30:
-- Required:
-  - avdd-pex-pll-supply: Power supply for dedicated (internal) PCIe PLL. Must
-    supply 1.05 V.
-  - avdd-plle-supply: Power supply for PLLE, which is shared with SATA. Must
-    supply 1.05 V.
-  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
-    supply 1.8 V.
-  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
-    Must supply 3.3 V.
-- Optional:
-  - If lanes 0 to 3 are used:
-    - avdd-pexa-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-    - vdd-pexa-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - If lanes 4 or 5 are used:
-    - avdd-pexb-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-    - vdd-pexb-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-
-Power supplies for Tegra124:
-- Required:
-  - avddio-pex-supply: Power supply for analog PCIe logic. Must supply 1.05 V.
-  - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
-    Must supply 3.3 V.
-  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
-    supply 2.8-3.3 V.
-
-Power supplies for Tegra210:
-- Required:
-  - hvddio-pex-supply: High-voltage supply for PCIe I/O and PCIe output
-    clocks. Must supply 1.8 V.
-  - dvddio-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - vddio-pex-ctl-supply: Power supply for PCIe control I/O partition. Must
-    supply 1.8 V.
-
-Power supplies for Tegra186:
-- Required:
-  - dvdd-pex-supply: Power supply for digital PCIe I/O. Must supply 1.05 V.
-  - hvdd-pex-pll-supply: High-voltage supply for PLLE (shared with USB3). Must
-    supply 1.8 V.
-  - hvdd-pex-supply: High-voltage supply for PCIe I/O and PCIe output clocks.
-    Must supply 1.8 V.
-  - vddio-pexctl-aud-supply: Power supply for PCIe side band signals. Must
-    supply 1.8 V.
-
-Root ports are defined as subnodes of the PCIe controller node.
-
-Required properties:
-- device_type: Must be "pci"
-- assigned-addresses: Address and size of the port configuration registers
-- reg: PCI bus address of the root port
-- #address-cells: Must be 3
-- #size-cells: Must be 2
-- ranges: Sub-ranges distributed from the PCIe controller node. An empty
-  property is sufficient.
-- nvidia,num-lanes: Number of lanes to use for this port. Valid combinations
-  are:
-  - Root port 0 uses 4 lanes, root port 1 is unused.
-  - Both root ports use 2 lanes.
-
-Required properties for Tegra124 and later:
-- phys: Must contain an phandle to a PHY for each entry in phy-names.
-- phy-names: Must include an entry for each active lane. Note that the number
-  of entries does not have to (though usually will) be equal to the specified
-  number of lanes in the nvidia,num-lanes property. Entries are of the form
-  "pcie-N": where N ranges from 0 to the value specified in nvidia,num-lanes.
-
-Examples:
-=========
-
-Tegra20:
---------
-
-SoC DTSI:
-
-	pcie-controller@80003000 {
-		compatible = "nvidia,tegra20-pcie";
-		device_type = "pci";
-		reg = <0x80003000 0x00000800   /* PADS registers */
-		       0x80003800 0x00000200   /* AFI registers */
-		       0x90000000 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <0 98 0x04   /* controller interrupt */
-		              0 99 0x04>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x80000000 0x80000000 0 0x00001000   /* port 0 registers */
-			  0x82000000 0 0x80001000 0x80001000 0 0x00001000   /* port 1 registers */
-			  0x81000000 0 0          0x82000000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0xa0000000 0xa0000000 0 0x10000000   /* non-prefetchable memory */
-			  0xc2000000 0 0xb0000000 0xb0000000 0 0x10000000>; /* prefetchable memory */
-
-		clocks = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 118>;
-		clock-names = "pex", "afi", "pll_e";
-		resets = <&tegra_car 70>, <&tegra_car 72>, <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x80000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x80001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@80003000 {
-		status = "okay";
-
-		vdd-supply = <&pci_vdd_reg>;
-		pex-clk-supply = <&pci_clk_reg>;
-
-		/* root port 00:01.0 */
-		pci@1,0 {
-			status = "okay";
-
-			/* bridge 01:00.0 (optional) */
-			pci@0,0 {
-				reg = <0x010000 0 0 0 0>;
-
-				#address-cells = <3>;
-				#size-cells = <2>;
-
-				device_type = "pci";
-
-				/* endpoint 02:00.0 */
-				pci@0,0 {
-					reg = <0x020000 0 0 0 0>;
-				};
-			};
-		};
-	};
-
-Note that devices on the PCI bus are dynamically discovered using PCI's bus
-enumeration and therefore don't need corresponding device nodes in DT. However
-if a device on the PCI bus provides a non-probeable bus such as I2C or SPI,
-device nodes need to be added in order to allow the bus' children to be
-instantiated at the proper location in the operating system's device tree (as
-illustrated by the optional nodes in the example above).
-
-Tegra30:
---------
-
-SoC DTSI:
-
-	pcie-controller@3000 {
-		compatible = "nvidia,tegra30-pcie";
-		device_type = "pci";
-		reg = <0x00003000 0x00000800   /* PADS registers */
-		       0x00003800 0x00000200   /* AFI registers */
-		       0x10000000 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH   /* controller interrupt */
-			      GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &intc GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x00000000 0x00000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x00001000 0x00001000 0 0x00001000   /* port 1 configuration space */
-			  0x82000000 0 0x00004000 0x00004000 0 0x00001000   /* port 2 configuration space */
-			  0x81000000 0 0          0x02000000 0 0x00010000   /* downstream I/O */
-			  0x82000000 0 0x20000000 0x20000000 0 0x08000000   /* non-prefetchable memory */
-			  0xc2000000 0 0x28000000 0x28000000 0 0x18000000>; /* prefetchable memory */
-
-		clocks = <&tegra_car TEGRA30_CLK_PCIE>,
-			 <&tegra_car TEGRA30_CLK_AFI>,
-			 <&tegra_car TEGRA30_CLK_PLL_E>,
-			 <&tegra_car TEGRA30_CLK_CML0>;
-		clock-names = "pex", "afi", "pll_e", "cml";
-		resets = <&tegra_car 70>,
-			 <&tegra_car 72>,
-			 <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x00000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x00001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@3,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001800 0 0x00004000 0 0x1000>;
-			reg = <0x001800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@3000 {
-		status = "okay";
-
-		avdd-pexa-supply = <&ldo1_reg>;
-		vdd-pexa-supply = <&ldo1_reg>;
-		avdd-pexb-supply = <&ldo1_reg>;
-		vdd-pexb-supply = <&ldo1_reg>;
-		avdd-pex-pll-supply = <&ldo1_reg>;
-		avdd-plle-supply = <&ldo1_reg>;
-		vddio-pex-ctl-supply = <&sys_3v3_reg>;
-		hvdd-pex-supply = <&sys_3v3_pexs_reg>;
-
-		pci@1,0 {
-			status = "okay";
-		};
-
-		pci@3,0 {
-			status = "okay";
-		};
-	};
-
-Tegra124:
----------
-
-SoC DTSI:
-
-	pcie-controller@1003000 {
-		compatible = "nvidia,tegra124-pcie";
-		device_type = "pci";
-		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
-		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
-			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
-			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
-			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
-
-		clocks = <&tegra_car TEGRA124_CLK_PCIE>,
-			 <&tegra_car TEGRA124_CLK_AFI>,
-			 <&tegra_car TEGRA124_CLK_PLL_E>,
-			 <&tegra_car TEGRA124_CLK_CML0>;
-		clock-names = "pex", "afi", "pll_e", "cml";
-		resets = <&tegra_car 70>,
-			 <&tegra_car 72>,
-			 <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@1003000 {
-		status = "okay";
-
-		avddio-pex-supply = <&vdd_1v05_run>;
-		dvddio-pex-supply = <&vdd_1v05_run>;
-		avdd-pex-pll-supply = <&vdd_1v05_run>;
-		hvdd-pex-supply = <&vdd_3v3_lp0>;
-		hvdd-pex-pll-e-supply = <&vdd_3v3_lp0>;
-		vddio-pex-ctl-supply = <&vdd_3v3_lp0>;
-		avdd-pll-erefe-supply = <&avdd_1v05_run>;
-
-		/* Mini PCIe */
-		pci@1,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
-			phy-names = "pcie-0";
-			status = "okay";
-		};
-
-		/* Gigabit Ethernet */
-		pci@2,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>;
-			phy-names = "pcie-0";
-			status = "okay";
-		};
-	};
-
-Tegra210:
----------
-
-SoC DTSI:
-
-	pcie-controller@1003000 {
-		compatible = "nvidia,tegra210-pcie";
-		device_type = "pci";
-		reg = <0x0 0x01003000 0x0 0x00000800   /* PADS registers */
-		       0x0 0x01003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x02000000 0x0 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-		interrupts = <GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-			     <GIC_SPI 99 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 98 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x01000000 0x0 0x01000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x01001000 0x0 0x01001000 0 0x00001000   /* port 1 configuration space */
-			  0x81000000 0 0x0        0x0 0x12000000 0 0x00010000   /* downstream I/O (64 KiB) */
-			  0x82000000 0 0x13000000 0x0 0x13000000 0 0x0d000000   /* non-prefetchable memory (208 MiB) */
-			  0xc2000000 0 0x20000000 0x0 0x20000000 0 0x20000000>; /* prefetchable memory (512 MiB) */
-
-		clocks = <&tegra_car TEGRA210_CLK_PCIE>,
-			 <&tegra_car TEGRA210_CLK_AFI>,
-			 <&tegra_car TEGRA210_CLK_PLL_E>,
-			 <&tegra_car TEGRA210_CLK_CML0>;
-		clock-names = "pex", "afi", "pll_e", "cml";
-		resets = <&tegra_car 70>,
-			 <&tegra_car 72>,
-			 <&tegra_car 74>;
-		reset-names = "pex", "afi", "pcie_x";
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x01000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <4>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x01001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-	};
-
-Board DTS:
-
-	pcie-controller@1003000 {
-		status = "okay";
-
-		avdd-pll-uerefe-supply = <&avdd_1v05_pll>;
-		hvddio-pex-supply = <&vdd_1v8>;
-		dvddio-pex-supply = <&vdd_pex_1v05>;
-		dvdd-pex-pll-supply = <&vdd_pex_1v05>;
-		hvdd-pex-pll-e-supply = <&vdd_1v8>;
-		vddio-pex-ctl-supply = <&vdd_1v8>;
-
-		pci@1,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-0}>,
-			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-1}>,
-			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-2}>,
-			       <&{/padctl@7009f000/pads/pcie/lanes/pcie-3}>;
-			phy-names = "pcie-0", "pcie-1", "pcie-2", "pcie-3";
-			status = "okay";
-		};
-
-		pci@2,0 {
-			phys = <&{/padctl@7009f000/pads/pcie/lanes/pcie-4}>;
-			phy-names = "pcie-0";
-			status = "okay";
-		};
-	};
-
-Tegra186:
----------
-
-SoC DTSI:
-
-	pcie@10003000 {
-		compatible = "nvidia,tegra186-pcie";
-		power-domains = <&bpmp TEGRA186_POWER_DOMAIN_PCX>;
-		device_type = "pci";
-		reg = <0x0 0x10003000 0x0 0x00000800   /* PADS registers */
-		       0x0 0x10003800 0x0 0x00000800   /* AFI registers */
-		       0x0 0x40000000 0x0 0x10000000>; /* configuration space */
-		reg-names = "pads", "afi", "cs";
-
-		interrupts = <GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>, /* controller interrupt */
-			     <GIC_SPI 73 IRQ_TYPE_LEVEL_HIGH>; /* MSI interrupt */
-		interrupt-names = "intr", "msi";
-
-		#interrupt-cells = <1>;
-		interrupt-map-mask = <0 0 0 0>;
-		interrupt-map = <0 0 0 0 &gic GIC_SPI 72 IRQ_TYPE_LEVEL_HIGH>;
-
-		bus-range = <0x00 0xff>;
-		#address-cells = <3>;
-		#size-cells = <2>;
-
-		ranges = <0x82000000 0 0x10000000 0x0 0x10000000 0 0x00001000   /* port 0 configuration space */
-			  0x82000000 0 0x10001000 0x0 0x10001000 0 0x00001000   /* port 1 configuration space */
-			  0x82000000 0 0x10004000 0x0 0x10004000 0 0x00001000   /* port 2 configuration space */
-			  0x81000000 0 0x0        0x0 0x50000000 0 0x00010000   /* downstream I/O (64 KiB) */
-			  0x82000000 0 0x50100000 0x0 0x50100000 0 0x07F00000   /* non-prefetchable memory (127 MiB) */
-			  0xc2000000 0 0x58000000 0x0 0x58000000 0 0x28000000>; /* prefetchable memory (640 MiB) */
-
-		clocks = <&bpmp TEGRA186_CLK_AFI>,
-			 <&bpmp TEGRA186_CLK_PCIE>,
-			 <&bpmp TEGRA186_CLK_PLLE>;
-		clock-names = "afi", "pex", "pll_e";
-
-		resets = <&bpmp TEGRA186_RESET_AFI>,
-			 <&bpmp TEGRA186_RESET_PCIE>,
-			 <&bpmp TEGRA186_RESET_PCIEXCLK>;
-		reset-names = "afi", "pex", "pcie_x";
-
-		status = "disabled";
-
-		pci@1,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82000800 0 0x10000000 0 0x1000>;
-			reg = <0x000800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <2>;
-		};
-
-		pci@2,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001000 0 0x10001000 0 0x1000>;
-			reg = <0x001000 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-
-		pci@3,0 {
-			device_type = "pci";
-			assigned-addresses = <0x82001800 0 0x10004000 0 0x1000>;
-			reg = <0x001800 0 0 0 0>;
-			status = "disabled";
-
-			#address-cells = <3>;
-			#size-cells = <2>;
-			ranges;
-
-			nvidia,num-lanes = <1>;
-		};
-	};
-
-Board DTS:
-
-	pcie@10003000 {
-		status = "okay";
-
-		dvdd-pex-supply = <&vdd_pex>;
-		hvdd-pex-pll-supply = <&vdd_1v8>;
-		hvdd-pex-supply = <&vdd_1v8>;
-		vddio-pexctl-aud-supply = <&vdd_1v8>;
-
-		pci@1,0 {
-			nvidia,num-lanes = <4>;
-			status = "okay";
-		};
-
-		pci@2,0 {
-			nvidia,num-lanes = <0>;
-			status = "disabled";
-		};
-
-		pci@3,0 {
-			nvidia,num-lanes = <1>;
-			status = "disabled";
-		};
-	};
-- 
2.50.1


