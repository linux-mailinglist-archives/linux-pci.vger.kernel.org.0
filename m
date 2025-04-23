Return-Path: <linux-pci+bounces-26502-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id AD4ACA984CE
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 11:07:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 9E5091B66BB5
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 09:07:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 59D8F26C3BF;
	Wed, 23 Apr 2025 09:04:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="SNDcYGrS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 778C925C820;
	Wed, 23 Apr 2025 09:04:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745399084; cv=none; b=OcyKc7FaBbR4qKZPfVvZlLefasLEQNt5eUA542A5b7lez2wVO7uxupBzqYP1HCul+3A0HvbFsfKkpBdncD7siC0Cecbm1mu8vIX6Vnb62USWHl9oNTu30mqSyEULziqOvOg10vuQ4zvhdSQ26w7NbfuiFBvAQW+jgISHQf6W2W4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745399084; c=relaxed/simple;
	bh=VA1BfQpb0E0S0JltuB3xDql95jceNCyK+7nSxLx3K24=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=IlF5PK3A5JW5Yitsru1zLho3ArIsiK+pn8fahjsZJI02IHkfVxTex3AogOKTxMBel2bMSluCW6OLlBIbF8C9zR05MKgwYExK9DJHjLe+QOdcGefhAzshdzdNVnQE9gdnjOP8r5A5iI8ovQN52PzW2y3sPbal8QDbkcSGqMJsicg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=SNDcYGrS; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6r86R016950;
	Wed, 23 Apr 2025 11:04:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=CwxI54oEXKDOyHYUHuiO02
	V7rFggwo7dFb2UR2yYR94=; b=SNDcYGrSFeB6RNBhcWeJkyUOyl6Val9NO7wtg+
	MvBjbXNCWZrh33AGxOjsz8BKDi2iBORGXP8QwUAqZEa8w/M6/G6+mNyq+fdeZ9UL
	f5Yyj+qEMYlqjcE8IdTHG+n85+zAjoiKHnHB0b8ysizANOTa27XqzDHNLyBR3a93
	rpyteymqBMbbKdnSN72wSK74N4A8zJTcR2IfTwi6owLhwJS0e6h+GogBOEjQ+X2z
	5CIzl6B3oOcI5l/ap9Mwqnb4nrEe6qf1ltZiCtNZGp/jVpP1xAy1RPREvpS4NNP2
	dZs4Qi29SlwlJQ6GDTvW5VXPPpix7IGZ2YsX0oAjiHYSoOow==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjxa8m4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 11:04:08 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 043A740061;
	Wed, 23 Apr 2025 11:02:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 23942918FC4;
	Wed, 23 Apr 2025 11:01:25 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 11:01:24 +0200
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
Subject: [PATCH v8 0/9] Add STM32MP25 PCIe drivers
Date: Wed, 23 Apr 2025 11:01:10 +0200
Message-ID: <20250423090119.4003700-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-04-23_06,2025-04-22_01,2024-11-22_01

(resend with correct patch version)

this patch depends on patch 
https://patchwork.kernel.org/project/linux-arm-kernel/list/?series=953545

Changes in v8:
   - Whitespace in comment
   
Changes in v7:
   - Use device_init_wakeup to enable wakeup
   - Fix comments (Bjorn)

Changes in v6:
   - Call device_wakeup_enable() to fix WAKE# wakeup.
   Address comments from Manivanna:
   - Fix/Add Comments
   - Fix DT indents
   - Remove dw_pcie_ep_linkup() in EP start link
   - Add PCIE_T_PVPERL_MS delay in RC PERST# deassert
   
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
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  57 +++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  21 +
 drivers/pci/controller/dwc/Kconfig            |  24 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c    | 417 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.c       | 370 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h       |  16 +
 12 files changed, 1146 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

-- 
2.34.1


