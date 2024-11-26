Return-Path: <linux-pci+bounces-17347-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id EAE919D97F9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:05:52 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 609A3281FB2
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:05:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 053261D54DA;
	Tue, 26 Nov 2024 13:05:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="YeY2nuOk"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3BEA31D5146;
	Tue, 26 Nov 2024 13:05:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626321; cv=none; b=aCnOIn30anLvff4XAHaYkFGTd4/bjFOPehuqZKLC92tAicNjFIM0mVDcT1MFdC1ChzYPOAdhJck0Ig4E277GWww42kjuSjPSjlAJu46NiXy3xa9O6vjvt01HOSUwfZT16bDFEkSsTli8w2Vub2gmB+NDV56NIHeOiBfSYAzU7Mg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626321; c=relaxed/simple;
	bh=bs+D/VLQKALMxSpo6LsDkKVnb9wdoMMKnJiwVmzmF+k=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=TiYomv53JoXf1eqm3PBRaRS2zkImdcq312JUyZbL8MbqR/tlLG3e8qwI8SMDuZ7zosNucIZBfMUJ8l9JRZCa0mpdtH1TEGAgfxEZ2VVm8UXHdEYuqq76a8sUa7MB4BJ0geIASxexVhM+1Mg6oKJhXCEoAxWcdy0Uw7RBi43+9Ow=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=YeY2nuOk; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAk54s003890;
	Tue, 26 Nov 2024 14:04:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=cqT5IxySTKXfbHsipjA41j
	fpwmNQnAvDQits4qChS3A=; b=YeY2nuOkbe0Jvh4UjGdW6+PDtxnZl4c7DH6xqV
	VTtm2wb3GOp7LjPismVzkYp219DSb+JiLXBWdw86Kvtr4dhfiNS6qIPC3eQlvQGo
	X5AxngvJ/XeZvaMcjl52ZK+E8i8EcohuetNQvuclxQub0tZx356Up3f8ENjWK1Pq
	0o3Lc13qS/7ZvDARSd/zXMYg91hA24lRm8JYZmPegR5kwoCMZI4v/frx8iljw1Tx
	5AuPXloIYPNFoCihIqNpS2tkjp93o8ir4Mu8yig5m1ZWYxkClUohj0ePOusXMkE6
	PW1OylwOXEvDK/dAMj+b1Vp/u3YqKSQns7Pg+ZaYRoDyRK8w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4336tfmxcr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 14:04:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id B96E34004C;
	Tue, 26 Nov 2024 14:03:28 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 659DD26EEEE;
	Tue, 26 Nov 2024 14:00:26 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Nov
 2024 14:00:26 +0100
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
Subject: [PATCH v1 0/5] Add STM32MP25 PCIe drivers
Date: Tue, 26 Nov 2024 13:59:59 +0100
Message-ID: <20241126130004.1570091-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01

This patch series adds PCIe drivers STM32MP25 SoC from STMicrolectronics
and respective yaml schema for the root complex and device modes.

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
   
Christian Bruel (5):
  dt-bindings: PCI: Add STM32MP25 PCIe root complex bindings
  PCI: stm32: Add PCIe host support for STM32MP25
  dt-bindings: PCI: Add STM32MP25 PCIe endpoint bindings
  PCI: stm32: Add PCIe endpoint support for STM32MP25
  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers

 .../bindings/pci/st,stm32-pcie-common.yaml    |  45 ++
 .../bindings/pci/st,stm32-pcie-ep.yaml        |  61 +++
 .../bindings/pci/st,stm32-pcie-host.yaml      |  99 ++++
 MAINTAINERS                                   |   7 +
 drivers/pci/controller/dwc/Kconfig            |  24 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c    | 445 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.c       | 402 ++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h       |  17 +
 9 files changed, 1102 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-common.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

-- 
2.34.1


