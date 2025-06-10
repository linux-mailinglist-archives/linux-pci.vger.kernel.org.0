Return-Path: <linux-pci+bounces-29291-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 88147AD314B
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:11:26 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 36E117A76DD
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:10:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 53C6528A71E;
	Tue, 10 Jun 2025 09:11:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="bFql7YiF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 56F5928A705;
	Tue, 10 Jun 2025 09:11:10 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546673; cv=none; b=dD+zEQt+EOAdGHLm2i/FP8HI0xcq64oZFnm3rz95Ub8TjWubVj/U7fZO7M+SrCL92k+ZhO7hVP8vCs2niduu12FQojJRJnsStzgb8DfBkHPmjbMAni7DNYNsH4cfBuieqlDCLFFS7PQ8tiHUxdbeN33yWo/GqyiT+n306qGmUjI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546673; c=relaxed/simple;
	bh=+KSZuNsvYqqgj2q1pcCsABuRQ9g9JJvOtUVc1NBAQQQ=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=GYqo/F3KqG92/AGA9le5yAuNh7G7KeoErTt6ulCIHBenfsLBRLOBcG8pSVjonGbz13vJzrUqDKdLqo+kTTt33tEH2e7snQE5w39MIqHauZ3/ATeqH3LQWsy04gHA5w8gxADugybbNR2bLrf9bagBFnUjDJ80KVYmV3nR9wbbcEw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=bFql7YiF; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8Bhap030186;
	Tue, 10 Jun 2025 11:10:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=gXPNgQ8R4em34zlLDlZZ+0
	eTK9mlCISpwFo17g9ndzA=; b=bFql7YiFA77Z/Em78XCZZihmsqEvC4dIueNQDK
	ZBfGObSJfxjWOhY6RnK6aCkSitigJ4TMjohCGAG3k9jyCCCaa4rSymi5pZsBmOBQ
	bRv8amW+We7g4kaLUeZITVaFkfAx8wc5kkCBlqPUlrZ2j37HBTa7zO/UlYO5qO4L
	9az7PuIJ/tSdYBbIxpNcHTs9f4WMcKMX3/o8iMp9KznVEJFDX5d9U2E+VAlGKyTj
	zdUhUfyWTHdHOuQP8Qde+9kF2W6qTH22yWilG8ZAaNoxnlRtyPjzSjPYBnoc4zVP
	bDfi9AhJZTZ5gSFBpOuR9G51ljQavG50EvcyttnJNGLFK+qg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474cs2kx41-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 11:10:39 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 535D740050;
	Tue, 10 Jun 2025 11:09:31 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7C0A4210227;
	Tue, 10 Jun 2025 11:07:36 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 11:07:36 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <johan+linaro@kernel.org>,
        <cassel@kernel.org>, <shradha.t@samsung.com>,
        <thippeswamy.havalige@amd.com>, <quic_schintav@quicinc.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v12 0/9] Add STM32MP25 PCIe drivers
Date: Tue, 10 Jun 2025 11:07:05 +0200
Message-ID: <20250610090714.3321129-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.0.736,FMLib:17.12.80.40
 definitions=2025-06-10_03,2025-06-09_02,2025-03-28_01

Changes in v12;
   Fix warning reported by kernel test robot <lkp@intel.com>

Changes in v11;
   Address comments from Manivanna:
   - RC driver: Do not call pm_runtime_get_noresume in probe
                More uses of dev_err_probe
   - EP driver: Use level triggered PERST# irq

Changes in v10;
   - Update pcie_ep bindings with dbi2 and atu regs,
     thus remove Reviewed-by and Acked-by.
   
Changes in v9:
   - Describe atu and dbi2 shadowed registers in pcie_ep node
   Address RC and EP drivers comments from Manivanna:
   - Use dev_error_probe() for pm_runtime_enable() calls
   - Reword Kconfig help message
   - Move pm_runtime_get_noresume() before devm_pm_runtime_enable()

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
  arm64: dts: st: Add PCIe Root Complex mode on stm32mp251
  arm64: dts: st: Add PCIe Endpoint mode on stm32mp251
  arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board

 .../bindings/pci/st,stm32-pcie-common.yaml    |  33 ++
 .../bindings/pci/st,stm32-pcie-ep.yaml        |  73 ++++
 .../bindings/pci/st,stm32-pcie-host.yaml      | 112 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  20 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  59 +++
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  21 +
 drivers/pci/controller/dwc/Kconfig            |  24 ++
 drivers/pci/controller/dwc/Makefile           |   2 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c    | 384 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.c       | 368 +++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h       |  16 +
 12 files changed, 1119 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h


base-commit: b27cc623e01be9de1580eaa913508b237a7a9673
-- 
2.34.1


