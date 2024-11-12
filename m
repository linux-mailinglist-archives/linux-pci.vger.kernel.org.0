Return-Path: <linux-pci+bounces-16568-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3F0B29C5D3E
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:28:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D80E41F2427C
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:28:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B9E5B20604A;
	Tue, 12 Nov 2024 16:28:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="tiy4gtBq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id D639A205AB0;
	Tue, 12 Nov 2024 16:28:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731428889; cv=none; b=U3KEaKCILf1XpZm4uu56zGz4Xf6D86mnj53VQ+wq2GOk+7ZlKzfOony8GZW7Cf+d6vmzn1fA2CzMfxyx23byy6f+59oc/WINyxbE0dimmXK73CantSC9t0bxbkctPDrswGkG/b2RAUfKw0+H+RNLFVsp+xGBXu+EqYS61dU1Tk4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731428889; c=relaxed/simple;
	bh=BQBq2KwyTn0BX6cEv2Ucx0Vx/gddarbz/pp8l7bdnbg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hzmvX5WSmlxO+ZfwvRU+1UwmeIVz7bQqVgqdp0ONysm1rwcD4w3/pgwsLKx4odsNc+qvuveDgMyuSDmTcGAPvnt908gRBBYupG2e09HgAygxhfEgHuNyjfQzLtgBsKzJiblASeqaghrGwGpcs+S1hfWhrAhogUIENLCkOkv39fY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=tiy4gtBq; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACCREXx025206;
	Tue, 12 Nov 2024 17:24:42 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	M79B9yXRhahhsdQQ5jt3NuyPZPc3ZVTz3ctnb7+EBi4=; b=tiy4gtBq+20FlFJ1
	tY1F6oe843WF14AFHeJzF37W2dZbs4848CWrC2xdgw/TPSVXPmEgAwp97F+zcqxC
	6xyjsWcuMEcCIFNpkKPb8TcTK5Yt1t4Zt1cUu8rK82wzWbDTYVloPOP+ZV/uVBoe
	ad4Cfgs2EsI2usGlg/jZMDSxh51ZLRpdtiQFRX1Jkp0fgnLpGHePs+CynbRaOnIY
	ib3TPh2ZUPqLV0DV0OeqNzfCpLTjZZQ1tcq3+fLDnRK+GxP5JShR9p+aSaHNVCj4
	6pHRaWTiKuZplFW/uxdTGpr3E6hc/K1Wl/8/nh2K0+39FFYcGDfUikULFKm8APoG
	H0g9VQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42syy1ndgb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 17:24:42 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9773840059;
	Tue, 12 Nov 2024 17:23:21 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 16E912AC00C;
	Tue, 12 Nov 2024 17:20:28 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 17:20:27 +0100
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
Subject: [PATCH 3/5] dt-bindings: PCI: Add STM32MP25 PCIe endpoint bindings
Date: Tue, 12 Nov 2024 17:19:23 +0100
Message-ID: <20241112161925.999196-4-christian.bruel@foss.st.com>
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

STM32MP25 PCIe Controller is based on the DesignWare core configured as
end point mode from the SYSCFG register.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 .../bindings/pci/st,stm32-pcie-ep.yaml        | 97 +++++++++++++++++++
 1 file changed, 97 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml

diff --git a/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
new file mode 100644
index 000000000000..f0d215982794
--- /dev/null
+++ b/Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
@@ -0,0 +1,97 @@
+# SPDX-License-Identifier: (GPL-2.0 OR BSD-2-Clause)
+%YAML 1.2
+---
+$id: http://devicetree.org/schemas/pci/st,stm32-pcie-ep.yaml#
+$schema: http://devicetree.org/meta-schemas/core.yaml#
+
+title: STM32MP25 PCIe endpoint driver
+
+maintainers:
+  - Christian Bruel <christian.bruel@foss.st.com>
+
+description:
+  PCIe endpoint controller based on the Synopsys DesignWare PCIe core.
+
+allOf:
+  - $ref: /schemas/pci/snps,dw-pcie-common.yaml#
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
+  clocks:
+    maxItems: 1
+    description: PCIe system clock
+
+  clock-names:
+    const: core
+
+  resets:
+    maxItems: 1
+
+  reset-names:
+    const: core
+
+  phys:
+    maxItems: 1
+
+  phy-names:
+    const: pcie-phy
+
+  reset-gpios:
+    description: GPIO controlled connection to PERST# signal
+    maxItems: 1
+
+  access-controllers:
+    maxItems: 1
+
+  power-domains:
+    maxItems: 1
+
+required:
+  - resets
+  - reset-names
+  - clocks
+  - clock-names
+  - phys
+  - phy-names
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
+        num-lanes = <1>;
+        reg = <0x48400000 0x400000>,
+              <0x10000000 0x8000000>;
+        reg-names = "dbi", "addr_space";
+        clocks = <&rcc CK_BUS_PCIE>;
+        clock-names = "core";
+        phys = <&combophy PHY_TYPE_PCIE>;
+        phy-names = "pcie-phy";
+        resets = <&rcc PCIE_R>;
+        reset-names = "core";
+        pinctrl-names = "default", "init";
+        pinctrl-0 = <&pcie_pins_a>;
+        pinctrl-1 = <&pcie_init_pins_a>;
+        reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
+        power-domains = <&CLUSTER_PD>;
+        access-controllers = <&rifsc 68>;
+    };
-- 
2.34.1


