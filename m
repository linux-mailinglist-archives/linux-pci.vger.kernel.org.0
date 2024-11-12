Return-Path: <linux-pci+bounces-16571-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id D30239C5E71
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 18:11:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 79C09B84C86
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:29:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 367B120694C;
	Tue, 12 Nov 2024 16:28:11 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="brqAkqnn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B8B6820515D;
	Tue, 12 Nov 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428891; cv=none; b=SJu4luPTjF8lerwC16PJnhDzlRCpLfxOl+kYiOAbGnAU7DnGirxK0aZD0/gDgOWV22moZGwRQfIs3KRkCMeZIVSXMi2zu91WwJvQrFlTtkJstSGK31YEnnHrAARfI/aHaIYkawe0wQbDB6lO8Ucg99AxO/86R+/zOa2QKy4X/Ws=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428891; c=relaxed/simple;
	bh=naRvQ+5yo4RtK43aAajlp2RLL3m0v68wGRnN/zv+hgU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qGvCDQSdRlRoZHAHVzG3g32ZA1Zfw04XmXaw20RDOb/BtfMAGPL3i9VCiSmVQ1gRjWkyTHI6sNX5X4zGzsh3BYFgy5lYUoQnQKVECZ4XsvUDhvwlWsfK1kGt5cQxYeurxuV3E00LPmGpqBYgdvasu2BkvU+CpeUDtEvBjwNoTRE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=brqAkqnn; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACBuauL028527;
	Tue, 12 Nov 2024 17:24:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	UquK6XLNUwFafkFAKsgJB95GDRY9sNski5ZAMvr/D/U=; b=brqAkqnnUPkgSGz7
	mZjejOiNK4Kzsx85GzFyhmzi2szqDsVyTDk70IIQk7QCtMi6OqG93HpivP8dAKl3
	8banIemQ8O/hIJYQ14I+mgj2dLVV35k1wl4lrtb5n44DfzmLU2LyyNRrWkTR7MVz
	6gB2Ke/vF6aD1lNRy0TFH99xMkWS/7z8pqnbEpKfrclb22I/NTdBhZCfFxkFh3JU
	oXQx6Nz4uJ9UigCfZhbExc5mAAqrX76El3YtVh495kcJ3Gnevt2GoXsJuQw8rq1J
	GhAbLMyE+bY2Z8Dg6ZHelV495tvcnBmpZ0Q8D7qShpQ7kJgPQxY1n7hI0w7IBeLt
	gZBilA==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42tj64354u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 17:24:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id C8B1F40044;
	Tue, 12 Nov 2024 17:23:17 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 5295C2A2795;
	Tue, 12 Nov 2024 17:20:17 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 17:20:17 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
To: <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <cassel@kernel.org>,
        <quic_schintav@quicinc.com>, <fabrice.gasnier@foss.st.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        Christian Bruel <christian.bruel@foss.st.com>
Subject: [PATCH 1/5] dt-bindings: PCI: Add STM32MP25 PCIe root complex bindings
Date: Tue, 12 Nov 2024 17:19:21 +0100
Message-ID: <20241112161925.999196-2-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241112161925.999196-1-christian.bruel@foss.st.com>
References: <20241112161925.999196-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

Document the bindings for STM32MP25 PCIe Controller configured in
root complex mode.
Supports 4 legacy interrupts and MSI interrupts from the ARM
GICv2m controller.

Allow tuning to change payload (default 128B) thanks to the
st,max-payload-size entry.
Can also limit the Maximum Read Request Size on downstream devices to the
minimum possible value between 128B and 256B.

STM32 PCIE may be in a power domain which is the case for the STM32MP25
based boards.
Supports wake# from wake-gpios

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 .../bindings/pci/st,stm32-pcie-host.yaml      | 149 ++++++++++++++++++
 1 file changed, 149 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml

diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
new file mode 100644
index 000000000000..d7d360b63a08
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
@@ -0,0 +1,149 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/st,stm32-pcie-host.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP25 PCIe root complex driver
+
+maintainers:
+  - Christian Bruel <christian.bruel@foss.st.com>
+
+description:
+  PCIe root complex controller based on the Synopsys DesignWare PCIe core.
+
+select:
+  properties:
+    compatible:
+      const: st,stm32mp25-pcie-rc
+  required:
+    - compatible
+
+allOf:
+  - $ref: /schemas/pci/pci-host-bridge.yaml#
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
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
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: core
+
+  clocks:
+    maxItems: 1
+    description: PCIe system clock
+
+  clock-names:
+    const: core
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
+  num-lanes:
+    const: 1
+
+  msi-parent:
+    maxItems: 1
+
+  reset-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  wake-gpios:
+    description: GPIO controlled connection to WAKE# input signal
+    maxItems: 1
+
+  st,limit-mrrs:
+    description: If present limit downstream MRRS to 256B
+    type: boolean
+
+  st,max-payload-size:
+    description: Maximum Payload size to use
+    $ref: /schemas/types.yaml#/definitions/uint32
+    enum: [128, 256]
+    default: 128
+
+  wakeup-source: true
+
+  power-domains:
+    maxItems: 1
+
+  access-controllers:
+    maxItems: 1
+
+if:
+  required:
+    - wakeup-source
+then:
+  required:
+    - wake-gpios
+
+required:
+  - interrupt-map
+  - interrupt-map-mask
+  - ranges
+  - resets
+  - reset-names
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
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
+        num-lanes = <1>;
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
+        ranges = <0x01000000 0 0x10010000 0x10010000 0 0x10000>,
+                 <0x02000000 0 0x10020000 0x10020000 0 0x7fe0000>,
+                 <0x42000000 0 0x18000000 0x18000000 0 0x8000000>;
+        bus-range = <0x00 0xff>;
+        clocks = <&rcc CK_BUS_PCIE>;
+        clock-names = "core";
+        phys = <&combophy PHY_TYPE_PCIE>;
+        phy-names = "pcie-phy";
+        resets = <&rcc PCIE_R>;
+        reset-names = "core";
+        msi-parent = <&v2m0>;
+        wakeup-source;
+        wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+        access-controllers = <&rifsc 76>;
+        power-domains = <&CLUSTER_PD>;
+    };
-- 
2.34.1


