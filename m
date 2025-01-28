Return-Path: <linux-pci+bounces-20461-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 98E43A20A5B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 13:13:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id EF432188412F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:13:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 573871A8418;
	Tue, 28 Jan 2025 12:13:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="BPA9RETd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 4DE9A1A23A4;
	Tue, 28 Jan 2025 12:12:58 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066381; cv=none; b=TW4llMTDHI8dTkUAst+NUr5G6P4Zr9hBl1iItMSjCrCFJNBN8HdwSIn70YtttFd+Wfzplik6jea60M0BOHjZg0t/HB1UvYeePZmDnJrcUNAm5XGF/Qe0pFu9wE6xoPzzN9kfki58+pcBtz4p4jwmm9tMJ3NE7gRnXOmhE1umCP0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066381; c=relaxed/simple;
	bh=J8zSjG1YWRpP2BiZ7FfzE1KFXnUG0V8xG6UkQqapBhg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=utsjg8HfLOIToLasoy9GILJvHND8zfwe/X2Xv8yvSyfODLn6DEVQ7d0eEmGghsDjs0hVvVjsctQCoZSCrCSXONXeD9FYLVvX75SFOTsWXiP29icG0LImCemWTWMAEPpDdH+pEl/3QqhYCHZPJNeu7iFcOvboU0Swc29rEXAZOO4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=BPA9RETd; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S9U0Mj022168;
	Tue, 28 Jan 2025 13:12:40 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	NrWZEBaWAkproY8CI+qS1Q6z3QO/fCAcsTOlY185XKo=; b=BPA9RETdlfOYVzLY
	AARnWzUHr1ree2U8oKu3TFOzp8XCD4/+n0AkabQuNr+7guv30K413nng0e5eBgs+
	nJf964G/xmLwPkjVhzNc7oAFI9pa4htk8DwgJGmb8YhNwGUKl7Y0/UIaMF7bg7sM
	4vt1ee8OV1lT20fmi50uJW55/jp8B1agBZsZ9rKVhj2h94ubvDmzw0LbJkZvWkEx
	6TiIuSrgueP1wF7u7MdKVmvwxGVznmUD3hjEMKQCCQ6gs+cVUKBT2dyesj7zdorY
	hyspkH8TNqgt0neDeNyGLxFUbhwWAZR6MSlqn/7rYXzJdGvI7zZyQIa7WuFDZwT4
	e9vSpg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44eeqxk54v-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:12:39 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id E265E40050;
	Tue, 28 Jan 2025 13:11:10 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9ABB72DBA23;
	Tue, 28 Jan 2025 13:08:16 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 13:08:16 +0100
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kw@linux.com>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <jingoohan1@gmail.com>, <p.zabel@pengutronix.de>,
        <johan+linaro@kernel.org>, <quic_schintav@quicinc.com>,
        <cassel@kernel.org>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <fabrice.gasnier@foss.st.com>
Subject: [PATCH v4 04/10] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
Date: Tue, 28 Jan 2025 13:07:39 +0100
Message-ID: <20250128120745.334377-5-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128120745.334377-1-christian.bruel@foss.st.com>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
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
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01

STM32MP25 PCIe Controller is based on the DesignWare core configured as
end point mode from the SYSCFG register.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
Acked-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 .../bindings/pci/st,stm32-pcie-ep.yaml        | 67 +++++++++++++++++++
 1 file changed, 67 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
new file mode 100644
index 000000000000..fc1bbe19e616
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
@@ -0,0 +1,67 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/st,stm32-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STMicroelectronics STM32MP25 PCIe Endpoint
+
+maintainers:
+  - Christian Bruel <christian.bruel@foss.st.com>
+
+description:
+  PCIe endpoint controller based on the Synopsys DesignWare PCIe core.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-ep.yaml#
+  - $ref: /schemas/pci/st,stm32-pcie-common.yaml#
+
+properties:
+  compatible:
+    const: st,stm32mp25-pcie-ep
+
+  reg:
+    items:
+      - description: Data Bus Interface (DBI) registers.
+      - description: PCIe configuration registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: addr_space
+
+  reset-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  phys:
+    maxItems: 1
+
+required:
+  - phys
+  - reset-gpios
+
+unevaluatedProperties: false
+
+examples:
+  - |
+    #include <dt-bindings/clock/st,stm32mp25-rcc.h>
+    #include <dt-bindings/gpio/gpio.h>
+    #include <dt-bindings/phy/phy.h>
+    #include <dt-bindings/reset/st,stm32mp25-rcc.h>
+
+    pcie-ep@48400000 {
+        compatible = "st,stm32mp25-pcie-ep";
+        reg = <0x48400000 0x400000>,
+              <0x10000000 0x8000000>;
+        reg-names = "dbi", "addr_space";
+        clocks = <&rcc CK_BUS_PCIE>;
+        phys = <&combophy PHY_TYPE_PCIE>;
+        resets = <&rcc PCIE_R>;
+        pinctrl-names = "default", "init";
+        pinctrl-0 = <&pcie_pins_a>;
+        pinctrl-1 = <&pcie_init_pins_a>;
+        reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
+        access-controllers = <&rifsc 68>;
+        power-domains = <&CLUSTER_PD>;
+    };
-- 
2.34.1


