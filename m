Return-Path: <linux-pci+bounces-22222-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 9A4CBA426B4
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:45:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CFD0A17E66F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:41:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 70C532561DE;
	Mon, 24 Feb 2025 15:41:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Hs8Zm+Fe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 941042561A3;
	Mon, 24 Feb 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411683; cv=none; b=f6VeEaQ/zSKs5L8LbeKXQYriqDhZykhPHnXhsmK73cfqUXSz1UKXVcfcfWnxNd57eXxaUOqazciojTns10Z4dpZvVEbgqJ395b7DxUuG6+VJLf70X4OJA+ZTSKf2xY5ffd+8M8Vit6iXrP+G/IrzssXNuAztqMcyaR5yYipu/P0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411683; c=relaxed/simple;
	bh=dNIt5sYZC1anGLFkE3oGd0CMQ6xc95Vd2TU1BQ1udGU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=aDJRfZDv0wMOBAxHFuaBYFDhbhvr9Rx34ool3y++Y8YNoMtKzQaeH178Fo9wcVKxjcojb2ctImO5Que4C+truHQHDWMnd4OiJpFNgyMPEhFHvb4s2Fp7ICQ6dWXZJ1gDKXcQUoC76FoWp1kqExKIbIDDDWHicPUalECCjE0IjOA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Hs8Zm+Fe; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51OCWFxi017596;
	Mon, 24 Feb 2025 16:40:48 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=Xvjv8Q6GMp8xbn4OSbtSrx
	KyPI/KGWvibRYnGOJDWOI=; b=Hs8Zm+FesqP5+J67lY5LaG8Cr7/A2e2YVaMAdX
	pNapLR2nVQneDaem2Oitgbr6Sxhgl3a2F5oQquuHAAS67r8EY/6cxcUmyeRMvTV3
	fm0UG2PQAnYv7JXGT5DrjOo1ZrGSTd/GnSxOKfRTUO8S5ysLesdXh91PJ8jWOc15
	kJNqsZglSF/FcnhdLQVqXBNAZB2MI0xYmsEqkqnsaxNBremJig7MbAt5kIHsbDVl
	DqUWYOWpFSppZr1mBcJ44ElBjgtFFDJlfQjZ7lH+iAELezxHKBWQVilJxrTQlECv
	hmcDF+Qy1/WHNBShb160IMJkgYBiD0mNIK5IBrTj4kocxN3A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y4k806wv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 16:40:48 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D29D540048;
	Mon, 24 Feb 2025 16:39:23 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B319051E327;
	Mon, 24 Feb 2025 16:33:35 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:33:35 +0100
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
Subject: [PATCH v5 0/9] Add STM32MP25 PCIe drivers
Date: Mon, 24 Feb 2025 16:33:04 +0100
Message-ID: <20250224153313.3416318-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
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

Changes in v5:
   Address driver comments from Manivanna:
   - Use dw_pcie_{suspend/resume}_noirq instead of private ones.
   - Move dw_pcie_host_init() to probe
   - Add stm32_remove_pcie_port cleanup function
   - Use of_node_put in stm32_pcie_parse_port
   - Remove wakeup-source property
   - Use generic dev_pm_set_dedicated_wake_irq to support wake# irq
   
Changes in v4:
   Address bindings comments Rob Herring
   - Remove phy property form common yaml
   - Remove phy-name property
   - Move wake_gpio and reset_gpio to the host root port
   
Changes in v3:
   Address comments from Manivanna, Rob and Bjorn:
   - Move host wakeup helper to dwc core (Mani)
   - Drop num-lanes=<1> from bindings (Rob)
   - Fix PCI address of I/O region (Mani)
   - Moved PHY to a RC rootport subsection (Bjorn, Mani)
   - Replaced dma-limit quirk by dma-ranges property (Bjorn)
   - Moved out perst assert/deassert from start/stop link (Mani)
   - Drop link_up test optim (Mani)
   - DT and comments rephrasing (Bjorn)
   - Add dts entries now that the combophy entries has landed
   - Drop delaying Configuration Requests

Changes in v2:
   - Fix st,stm32-pcie-common.yaml dt_binding_check	

Changes in v1:
   Address comments from Rob Herring and Bjorn Helgaas:
   - Drop st,limit-mrrs and st,max-payload-size from this patchset
   - Remove single reset and clocks binding names and misc yaml cleanups
   - Split RC/EP common bindings to a separate schema file
   - Use correct PCIE_T_PERST_CLK_US and PCIE_T_RRS_READY_MS defines
   - Use .remove instead of .remove_new
   - Fix bar reset sequence in EP driver
   - Use cleanup blocks for error handling
   - Cosmetic fixes

Christian Bruel (9):
  dt-bindings: PCI: Add STM32MP25 PCIe Root Complex bindings
  PCI: stm32: Add PCIe host support for STM32MP25
  dt-bindings: PCI: Add STM32MP25 PCIe Endpoint bindings
  PCI: stm32: Add PCIe Endpoint support for STM32MP25
  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
  arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
  arm64: dts: st: Add PCIe Rootcomplex mode on stm32mp251
  arm64: dts: st: Add PCIe Endpoint mode on stm32mp251
  arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board

 .../bindings/pci/st,stm32-pcie-common.yaml    |  33 ++
 .../bindings/pci/st,stm32-pcie-ep.yaml        |  67 +++
 .../bindings/pci/st,stm32-pcie-host.yaml      | 112 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  20 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  58 ++-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  21 +
 drivers/pci/controller/dwc/Kconfig            |  24 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c    | 420 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.c       | 367 +++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h       |  16 +
 12 files changed, 1146 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

-- 
2.34.1


