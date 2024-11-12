Return-Path: <linux-pci+bounces-16574-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 702CA9C5D50
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 17:31:09 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 337B528149B
	for <lists+linux-pci@lfdr.de>; Tue, 12 Nov 2024 16:31:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 56C2C205AC0;
	Tue, 12 Nov 2024 16:30:44 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="CYAeaJNI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8ACC8205AB1;
	Tue, 12 Nov 2024 16:30:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731429044; cv=none; b=Z0O7ual8QEw/nhMF/KP9b0sIT+tVWf+fxTvOugCwlcbSCiG6OaLfaL2dbmxuxzR5hVip/FQqv77/z/0Sd/A08H+3nu61yt+LseTb/zobw8vooj2NSkrOxe1jnUE27WSkyXj7oZsnXBmx24mv37/3xAmmVQL9tG+86D9rqsG4ayc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731429044; c=relaxed/simple;
	bh=Gqh0NgjmRLJL1MmJQqSXeXTGwLwgL3tcdsbQOFQ3jv4=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=N7EFPM9XJLmKoXDJRMXC4KxlcCU/0UMKMCRK1AyD+KpShEt+BriQ57L5fdArnu9I9Zs5vMy0i76USuCjLGeuUU97pBhQ8tKeoFHZFofa/G/E3yHeEiUnZLOHZhX11V8wf9oNFF/jKUNOAZYXC87qgPkNQaBYAxYkXy9UAi4UH2s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=CYAeaJNI; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4ACDB1KK029351;
	Tue, 12 Nov 2024 17:22:37 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=selector1; bh=grK3TrtRCUh5vGmrMEKFGC
	hLMBkQA+p427mP9eM/nRQ=; b=CYAeaJNIyVM03AaUJEH9Qb0Pi4LeJevj5Y/GaI
	sDFMK1XBipiIJ9wlkDipotAYGXr57Hd6r772a+ggyoOaDWlgG4b+JWk1/9Fuwn76
	7TjHrsnhO7TTwjc89LrH0yLFKdHH4wDT0aKSQ6uMvHbU4YR1kn+g9ZL3ZFdVSiQR
	Gtld1vrvibknO1nrVKvO5BkV2Q20t7S6W+84DVRKvoYxUC+UYyiAhuMtul4YArl3
	lg0Mzxl7q0en8xJf1gw8PTnyYTHUZvP8cD/UYyzC8X03ZSNwAy+uTTX28K4fHvbL
	goTXnmx5YR2oV7fB4UU9eoReTpFvq1VAbXIcenLlhFeGnEpg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 42tkjnjs7t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 12 Nov 2024 17:22:37 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 17B1D4002D;
	Tue, 12 Nov 2024 17:21:11 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 39CDE2C6353;
	Tue, 12 Nov 2024 17:20:06 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 12 Nov
 2024 17:20:05 +0100
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
Subject: [PATCH 0/5] Add STM32MP25 PCIe drivers
Date: Tue, 12 Nov 2024 17:19:20 +0100
Message-ID: <20241112161925.999196-1-christian.bruel@foss.st.com>
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

Christian Bruel (5):
  dt-bindings: PCI: Add STM32MP25 PCIe root complex bindings
  PCI: stm32: Add PCIe host support for STM32MP25
  dt-bindings: PCI: Add STM32MP25 PCIe endpoint bindings
  PCI: stm32: Add PCIe endpoint support for STM32MP25
  MAINTAINERS: add entry for ST STM32MP25 PCIe drivers

 .../bindings/pci/st,stm32-pcie-ep.yaml        |  97 ++++
 .../bindings/pci/st,stm32-pcie-host.yaml      | 149 ++++++
 MAINTAINERS                                   |   7 +
 drivers/pci/controller/dwc/Kconfig            |  23 +
 drivers/pci/controller/dwc/Makefile           |   2 +
 drivers/pci/controller/dwc/pcie-stm32-ep.c    | 433 +++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.c       | 493 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-stm32.h       |  24 +
 8 files changed, 1228 insertions(+)
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-ep.yaml
 create mode 100644 Documentation/devicetree/bindings/pci/st,stm32-pcie-host.yaml
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32-ep.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.c
 create mode 100644 drivers/pci/controller/dwc/pcie-stm32.h

-- 
2.34.1


