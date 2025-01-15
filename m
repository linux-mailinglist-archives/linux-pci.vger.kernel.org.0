Return-Path: <linux-pci+bounces-19857-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 51FEFA11D92
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 10:26:14 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 73B99160F1D
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 09:26:12 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8B4C81EEA51;
	Wed, 15 Jan 2025 09:25:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="pTQ1M0V4"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7B6941EEA2C;
	Wed, 15 Jan 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933157; cv=none; b=qOH3w8JF4oyaY06WhcJqh/MI7xQlrpBQ740kAzFWjCHzcOP1Ae9LJl5HvDvw/8dWtc9CUQAIl+Nj7CF7mM+s5Ao/0Rs+mwDhyJyTM0/m5T/t/w9x3lZsqMioS/T7K9sJ5OzQ6/ZBC2WMSPX20J2RH1OTaUVDqsmeVhj+tQHdQ3A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933157; c=relaxed/simple;
	bh=aXTC0LJuX5C56yvVAOsojnDcq3CFWFJ3pl0W/ANRx0U=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=D/4THBg6V8kypFH295xnUinqy1nkS/Pp4ZR5U6J0SJbuZ72vlhlEL7mCzMykX1WySeOK/r9MlILXPAZi82LmDv6x5lhCuAr/4Q6hnZewcoALL2e93KX33GAiAmCnULnUsbJLgl/d5ZjOlaMShppnpxeAf7ItrpUgEIdxhBX0fPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=pTQ1M0V4; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F5ML3E014124;
	Wed, 15 Jan 2025 10:25:22 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=9owZYWldyGAG1uOZhjbxaI
	MKcEQdzt2KxxW/sTB4+Tw=; b=pTQ1M0V4ZZYOGL4EXal28dnHqeq0HpQXUSpHbL
	07VsBf5mvcSEgXy2rI/rpMMT+mNJoKDUESu/Df+AvOInHKP3O6esHEyVpLVbbACC
	cLAy8xRt0gLQINxYVj8wCHj2tRW4TOQq5dc5iPXLOiXNPAgwu69T4R4xyoFcOPC8
	xZ/tKlEj1cL2PUQ4iH+WhCP9EScuT+uDUBctgM41JOnp6XUygOlqunBWnRdt9DK6
	K5QXFHjQ3lS6PEfm8r8idCN5yn/swadZrr2sgVuJ1DZQjzW74WDimCNmdl398KHr
	I80XYZcG+vLgFrjF9H5E4OdhuZsO5fULLmgfPwgtLe5n8+Dg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4466tjrxes-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:25:22 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id A8DFA4002D;
	Wed, 15 Jan 2025 10:23:49 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 498AE245F9F;
	Wed, 15 Jan 2025 10:22:35 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 10:22:35 +0100
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
Subject: [PATCH v3 0/9] Add STM32MP25 PCIe drivers
Date: Wed, 15 Jan 2025 10:21:24 +0100
Message-ID: <20250115092134.2904773-1-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-15_03,2025-01-15_02,2024-11-22_01

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
  PCI: stm32: Add PCIe endpoint support for STM32MP25
  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
  arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
  arm64: dts: st: Add PCIe Rootcomplex mode on stm32mp251
  arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board
  arm64: dts: st: Add PCIe Endpoint mode on stm32mp251

 .../bindings/pci/st,stm32-pcie-common.yaml    |  43 ++
 .../bindings/pci/st,stm32-pcie-ep.yaml        |  68 +++
 .../bindings/pci/st,stm32-pcie-host.yaml      | 120 +++++
 MAINTAINERS                                   |   7 +
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi |  20 +
 arch/arm64/boot/dts/st/stm32mp251.dtsi        |  59 ++-
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts    |  18 +
 drivers/pci/controller/dwc/Kconfig            |  24 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c    | 442 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.c       | 367 +++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h       |  17 +
 12 files changed, 1186 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

-- 
2.34.1


