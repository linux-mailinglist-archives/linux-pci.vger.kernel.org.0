Return-Path: <linux-pci+bounces-22221-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id AE6A4A426C2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:47:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E114819C463D
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:41:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 598BC2561C5;
	Mon, 24 Feb 2025 15:41:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="zExIzboD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5B6FD24EF7C;
	Mon, 24 Feb 2025 15:41:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411682; cv=none; b=ev2SH2SfHJtGWJ2Mwzd5RPWMpBhxRSYCUzKrE6bjQcoIQMSrcNXJ4g8xVdg+AjKjf0UEtK0RyaC4Cd25PJtj42XoXfuMnA1wEqfdywDWEnletryCfg12fqe3+ZNMT0l2pkyAVcdOp3s0svsgc/JCpwR93Lk2McUkF8AIQxNgMKU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411682; c=relaxed/simple;
	bh=C4+oUPEN9Noig0K+rNbvHo5kIRMN684zMDXD/FWHi0k=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ifWYA4FRxSEqTDBlZsy0RTJzYuqW5+CM8jl9rfLfeR8a3hT25QdSsJnKCllkrCiBpVzuFGrw5EHUN3RjZ6CZo+kYJGJQ7vnGeW5KyuO8q653cVMH72n93A+H1+ufSbMi7x1yj/pXsBbJ2wjc7//lCF+AmDdvL4zcVgQADVyQSD8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=zExIzboD; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OBmmff006971;
	Mon, 24 Feb 2025 16:41:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	qGD73/6Hfje+CHtFjpnoM4cVHsKMuplCC1K3yOtX1GM=; b=zExIzboDG8htA5Ac
	UTn2MdezQEdiUgh0gZ/dRHHNAM0IidelkQafWQk29jCd7sXXWaFm3M3BW9i+PTwV
	jP4W70ZeKmcIf/Sg5V+rJ/Jwpw5NmZpMo+HO9d2w76PsKxXWeciNB0wupaMiWlq+
	3WtRjsMWW/R+rSaPrYDdU72YJnqrrF7xaZzQmV38bqYMLO1N924cwP3O0ZwahDDm
	uPmo5Xc2WtrdsyEE1sDpkiE66QX2n6+gRti3Y5/dKdar5jSPs9mieZeyO39+xAcg
	x1oZHn0FnN1xzQlp1aNxb1bmDTU8lpzltKmRt1uPCtG+F8vP7GnZjesxmZwp2KkG
	jV3Lcw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44ys145ysq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 16:41:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DE1CE40046;
	Mon, 24 Feb 2025 16:39:35 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E14805248D1;
	Mon, 24 Feb 2025 16:33:40 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:33:40 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <johan+linaro@kernel.org>,
        <cassel@kernel.org>, <quic_schintav@quicinc.com>
CC: <fabrice.gasnier@foss.st.com>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v5 1/9] dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
Date: Mon, 24 Feb 2025 16:33:05 +0100
Message-ID: <20250224153313.3416318-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224153313.3416318-1-christian.bruel@foss.st.com>
References: <20250224153313.3416318-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01

Document the bindings for STM32MP25 PCIe Controller configured in
root complex mode with one root port.

Supports 4 INTx and MSI interrupts from the ARM GICv2m controller.

STM32 PCIe may be in a power domain which is the case for the STM32MP25
based boards.

Supports WAKE# from wake-gpios

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
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
index 000000000000..26f852e6f5b7
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
+          device_type = "pci";
+          reg = <0x0 0x0 0x0 0x0 0x0>;
+          phys = <&combophy PHY_TYPE_PCIE>;
+          wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+          reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
+          #address-cells = <3>;
+          #size-cells = <2>;
+          ranges;
+        };
+    };
-- 
2.34.1


