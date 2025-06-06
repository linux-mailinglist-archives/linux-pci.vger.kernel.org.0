Return-Path: <linux-pci+bounces-29086-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3803AD01D6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 14:09:20 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 5EBAE16AD94
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 12:09:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4E27828852D;
	Fri,  6 Jun 2025 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VUQ6RWTf"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 356F4285417;
	Fri,  6 Jun 2025 12:08:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211687; cv=none; b=TtVxOIvQh+nlc7rzsX7nUgrOXMXN5HdiI3wz52ugXP9G2uYm+NI7aefpE4FknD4WutupGNYjGkBD6PQhhSbAut7INdxSd3lQqo1i/1blc5CsbW+emhFoLbo1Q37iA3DO2lO+mpSPKfbl48OjwMnuJebgBX1Yv1NNvsW0X5aNN24=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211687; c=relaxed/simple;
	bh=aDfuuMiWkf0lkqLLHUt1wwJ5Qz9LTVGJXcN1g2ZjIZ8=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=npZSAcXH/6Bf1gmpD24XpSg6qbunPnGhA+LaVtiJvwRMLd7SJ1wzwoXl4Zv+g85o7b/HYYUfwv1jZkwmN/denF6vR7RXbJQL3QCezlUV/g1ULBVq4s1M8SzeQxQRisu1FZ0TzgUp9W6D/qFF3h7CDTE7TmXeOVflvFhGwkXeFj4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VUQ6RWTf; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556BcsQe021223;
	Fri, 6 Jun 2025 14:07:34 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	H6eETUqWv3VVFbBigRhvmAs5gJe0ByLoViR9hRNwVhM=; b=VUQ6RWTfDfTxUYsf
	NE99pnDR4FyU9yniC82rt34B7yDFJ++TEKuUPhfAjY7+nS+GGgVuhJUi6XDiwgYU
	QQpV8daQGmxegtibEzhNeGYMAajKCmnGXdKdLCFvKETbxegpkUhBfX8kJnfL/D+m
	mlgYAbEegG4TAKtAdsjeoViST6hTuT1T4DziVuMaakrw1nZPccw5slre+GegqH9t
	IiLKr8EpXkX3JIGhFR0Pr7yUy1hLUOocF6FC/9u1wrAhGpZXI2++Thjcn576NSqr
	naDZPRLz/AAU5NjfJrLr3VHyimozl4EvreYBUs8lF+hZmvGIUNTcYTOSvV3BK63g
	vCszrg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8tbn3q-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 14:07:34 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D18E540050;
	Fri,  6 Jun 2025 14:06:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 67064AF0116;
	Fri,  6 Jun 2025 14:04:36 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 14:04:36 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>,
        <thippeswamy.havalige@amd.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 3/9] dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
Date: Fri, 6 Jun 2025 14:03:57 +0200
Message-ID: <20250606120403.2964857-4-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606120403.2964857-1-christian.bruel@foss.st.com>
References: <20250606120403.2964857-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01

STM32MP25 PCIe Controller is based on the DesignWare core configured as
end point mode from the SYSCFG register.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
Reviewed-by: Rob Herring (Arm) <robh@kernel.org>
---
 .../bindings/pci/st,stm32-pcie-ep.yaml        | 73 +++++++++++++++++++
 1 file changed, 73 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
new file mode 100644
index 000000000000..b076ada4f332
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
@@ -0,0 +1,73 @@
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
+      - description: Data Bus Interface (DBI) shadow registers.
+      - description: Internal Address Translation Unit (iATU) registers.
+      - description: PCIe configuration registers.
+
+  reg-names:
+    items:
+      - const: dbi
+      - const: dbi2
+      - const: atu
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
+              <0x48500000 0x100000>,
+              <0x48700000 0x80000>,
+              <0x10000000 0x10000000>;
+        reg-names = "dbi", "dbi2", "atu", "addr_space";
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


