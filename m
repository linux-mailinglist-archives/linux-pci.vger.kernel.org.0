Return-Path: <linux-pci+bounces-26099-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 8E801A91DA7
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 15:22:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 295F47AE6E5
	for <lists+linux-pci@lfdr.de>; Thu, 17 Apr 2025 13:21:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 050D5245011;
	Thu, 17 Apr 2025 13:22:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DPBk8qOg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7EE8F23FC55;
	Thu, 17 Apr 2025 13:22:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1744896124; cv=none; b=oB5hAQHnAXEDqzmYcIKvygcsj2wU/4FjgwqWCYqftg8Hm8MTchToaPduNnbmycxrZrbX07vA+/NdF3zh2LuTqT1HOSUE6mkvbdV/ZAS1lcSuWQHcKK2+cZlX+qk92RuzfyTyX/DoD9hlc3AA1b/DndbLpdDZstw/6euwOa/E6R4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1744896124; c=relaxed/simple;
	bh=q+lQXjaZ1l+yG5MxLHXHU02zoVRchMlGeudXCp14EAg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JxwxPqvN0WiOBwLNe1v/FHX4D8MKEsNrRK7n6TCDy8nU2jc087sON/M6jUH3XFKZVoJxcD7y1n/8l7vMuEDOKo5Ce9Y5crrS7CB2uRO8+J6TgOdU9jrsVgF3+U63Gy1n2r+7jehT9U3uSZnMRMxkScQpR07KilSz5qTYlMeBR/8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DPBk8qOg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53HB3Woc009343;
	Thu, 17 Apr 2025 15:21:13 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	IzV24CKy9+GByv4nV3URGiNxMvyLfi5b2XJFt9IvXeI=; b=DPBk8qOgGpHyROfX
	1c8EKr0K7BeG+ESrIiz4M2Ar0pWmXwDOAy3cWOwCUe7G0xBiaNbIrOsUqEK/FEk9
	5zCE4iQB+5kFlwIa1kPQD1gLRMG2rL5Kw1fKkivN3U9naY/cprOf78J5LtXWxeF+
	eAHfigiKa+UciWOQgbwr4cvAIa3a+8wUOlxHvrTgKDNzUS0PWBlN3+E9TxzpVZt9
	pZGPz+o3FTzvjvU11X8GU2vi2NMborTek6gCmEjO10VOK9BqToOoVWjHsKXpDCLJ
	1pxxfMg9Y/AAhJsuWmEDM9cd3O2jTIuIUpH67SvUYt+KFYWPXUauTxiG2/HwqfKW
	7fmEfQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46034ndvfb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Apr 2025 15:21:13 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 583014002D;
	Thu, 17 Apr 2025 15:19:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EDC209968D4;
	Thu, 17 Apr 2025 15:18:48 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Thu, 17 Apr
 2025 15:18:48 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <thippeswamy.havalige@amd.com>,
        <shradha.t@samsung.com>, <quic_schintav@quicinc.com>,
        <cassel@kernel.org>, <johan+linaro@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v6 1/9] dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
Date: Thu, 17 Apr 2025 15:18:25 +0200
Message-ID: <20250417131833.3427126-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250417131833.3427126-1-christian.bruel@foss.st.com>
References: <20250417131833.3427126-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1095,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-17_03,2025-04-17_01,2024-11-22_01

Document the bindings for STM32MP25 PCIe Controller configured in
root complex mode with one root port.

Supports 4 INTx and MSI interrupts from the ARM GICv2m controller.

STM32 PCIe may be in a power domain which is the case for the STM32MP25
based boards.

Supports WAKE# from wake-gpios

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/pci/st,stm32-pcie-common.yaml    |  33 ++++++
 .../bindings/pci/st,stm32-pcie-host.yaml      | 112 ++++++++++++++++++
 2 files changed, 145 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
new file mode 100644
index 000000000000..5adbff259204
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
@@ -0,0 +1,33 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/st,stm32-pcie-common.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP25 PCIe RC/EP controller
+
+maintainers:
+  - Christian Bruel <christian.bruel@foss.st.com>
+
+description:
+  STM32MP25 PCIe RC/EP common properties
+
+properties:
+  clocks:
+    maxItems: 1
+    description: PCIe system clock
+
+  resets:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+  access-controllers:
+    maxItems: 1
+
+required:
+  - clocks
+  - resets
+
+additionalProperties: true
diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
new file mode 100644
index 000000000000..443bfe2cdc98
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
@@ -0,0 +1,112 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/st,stm32-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32MP25 PCIe Root Complex
+
+maintainers:
+  - Christian Bruel <christian.bruel@foss.st.com>
+
+description:
+  PCIe root complex controller based on the Synopsys DesignWare PCIe core.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie.yaml#
+  - $ref: /schemas/pci/st,stm32-pcie-common.yaml#
+
+properties:
+  compatible:
+    const: st,stm32mp25-pcie-rc
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: config
+
+  msi-parent:
+    maxItems: 1
+
+patternProperties:
+  '^pcie@[0-2],0$':
+    type: object
+    $ref: /schemas/pci/pci-pci-bridge.yaml#
+
+    properties:
+      reg:
+        maxItems: 1
+
+      phys:
+        maxItems: 1
+
+      reset-gpios:
+        description: GPIO controlled connection to PERST# signal
+        maxItems: 1
+
+      wake-gpios:
+        description: GPIO used as WAKE# input signal
+        maxItems: 1
+
+    required:
+      - phys
+      - ranges
+
+    unevaluatedProperties: false
+
+required:
+  - interrupt-map
+  - interrupt-map-mask
+  - ranges
+  - dma-ranges
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/interrupt-controller/arm-gic.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    pcie@48400000 {
+        compatible = "st,stm32mp25-pcie-rc";
+        device_type = "pci";
+        reg = <0x48400000 0x400000>,
+              <0x10000000 0x10000>;
+        reg-names = "dbi", "config";
+        #interrupt-cells = <1>;
+        interrupt-map-mask = <0 0 0 7>;
+        interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 2 &intc 0 0 GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 3 &intc 0 0 GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+                        <0 0 0 4 &intc 0 0 GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+        #address-cells = <3>;
+        #size-cells = <2>;
+        ranges = <0x01000000 0x0 0x00000000 0x10010000 0x0 0x10000>,
+                 <0x02000000 0x0 0x10020000 0x10020000 0x0 0x7fe0000>,
+                 <0x42000000 0x0 0x18000000 0x18000000 0x0 0x8000000>;
+        dma-ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x80000000>;
+        clocks = <&rcc CK_BUS_PCIE>;
+        resets = <&rcc PCIE_R>;
+        msi-parent = <&v2m0>;
+        access-controllers = <&rifsc 68>;
+        power-domains = <&CLUSTER_PD>;
+
+        pcie@0,0 {
+            device_type = "pci";
+            reg = <0x0 0x0 0x0 0x0 0x0>;
+            phys = <&combophy PHY_TYPE_PCIE>;
+            wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+            reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
+            #address-cells = <3>;
+            #size-cells = <2>;
+            ranges;
+        };
+    };
-- 
2.34.1


