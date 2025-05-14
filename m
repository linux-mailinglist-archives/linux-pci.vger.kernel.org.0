Return-Path: <linux-pci+bounces-27726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F016FAB6E6B
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 16:49:13 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 099C41893D4F
	for <lists+linux-pci@lfdr.de>; Wed, 14 May 2025 14:49:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9520C1CCB40;
	Wed, 14 May 2025 14:48:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="gFo2VpSY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C210419CD0B;
	Wed, 14 May 2025 14:48:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1747234111; cv=none; b=c7geruIGokAZ9DbVOYjRp+1YnLVbGt8C5VlV90u4gm+Jb4D+quNI+WOxwXReHZ7pvkN3mOvUj/SbR8b8wTdkTLbLWfctnG2fR6UAimQRCxx332FHaSfnJYJAAb67bNjMuqMpY8zmPUiPYN5EO7E8NZm2xxwGyx4jVFjeO9PAOpQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1747234111; c=relaxed/simple;
	bh=fzyWanv3AY7bhUn9pT11iW3ovRXywq/2OwtHy4ygIvc=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Qq/D9D4DH/DrUCL0bGRetHm6l2yvlNKLJnHBwmfUf2XEo7gLNF/HEE9Lecukk83EXcFoTgdBtAvCR4xlZm0rT/uvVyLwOOM4gdWZpsuSGJ76a+s8UnmJHEnjhAFkIXZVQe24BmIeSU40k2QTjAoTvBFNM6mJPG+h58A7VIfYjMo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=gFo2VpSY; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 54ECd09A003528;
	Wed, 14 May 2025 16:48:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	pAj9CRw+ClAdh7C5JE3/sgKSdmco4/PWyWZmAZNAOCA=; b=gFo2VpSYCAQDAbzn
	j9mrqzWbcFS5oGsZ1+Ol7vBSlubv0N0G9Yr1e5f2sD94rKlgntEa49hEOvT2QRcf
	9u7XLaTLKJo0MZEVyTrym+6x4lb71Edyy9iSCQzyetXhMiFRetFn3SL52GnN4eNX
	7xr61TIULtuUKTfsNlTI53GgJ+F4ci0t/B2W7okThKjB2aqW4XZ/Gbw1hb63BIv8
	WYrYxtlJ7FB4mRxaDltfEEVk4sB/UQFOBXxgudHVNv0UNmlVBrMpPbid5dZc/1JU
	9OjC7GBK5vh7jT7piqVYle1IDm8NYokgfcutu/9sPojkO36Dn5WcRICQV6nQM4a4
	D5EERQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 46mbdw4b9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 14 May 2025 16:48:03 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 4315B40044;
	Wed, 14 May 2025 16:46:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id DA699B10834;
	Wed, 14 May 2025 16:45:36 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 14 May
 2025 16:45:36 +0200
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
Subject: [PATCH v10 7/9] arm64: dts: st: Add PCIe Root Complex mode on stm32mp251
Date: Wed, 14 May 2025 16:44:26 +0200
Message-ID: <20250514144428.3340709-8-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250514144428.3340709-1-christian.bruel@foss.st.com>
References: <20250514144428.3340709-1-christian.bruel@foss.st.com>
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
 definitions=2025-05-14_04,2025-05-14_03,2025-02-21_01

Add pcie_rc node to support STM32 MP25 PCIe driver based on the
DesignWare PCIe core configured as Root Complex mode

Supports Gen1/Gen2, single lane, MSI interrupts using the ARM GICv2m

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 44 ++++++++++++++++++++++++++
 1 file changed, 44 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index d6993d3dc14d..7978fd640e1e 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -122,6 +122,15 @@ intc: interrupt-controller@4ac00000 {
 		      <0x0 0x4ac20000 0x0 0x20000>,
 		      <0x0 0x4ac40000 0x0 0x20000>,
 		      <0x0 0x4ac60000 0x0 0x20000>;
+		#address-cells = <2>;
+		#size-cells = <2>;
+		ranges;
+
+		v2m0: v2m@48090000 {
+			compatible = "arm,gic-v2m-frame";
+			reg = <0x0 0x48090000 0x0 0x1000>;
+			msi-controller;
+		};
 	};
 
 	psci {
@@ -953,6 +962,41 @@ stmmac_axi_config_1: stmmac-axi-config {
 					snps,wr_osr_lmt = <0x7>;
 				};
 			};
+
+			pcie_rc: pcie@48400000 {
+				compatible = "st,stm32mp25-pcie-rc";
+				device_type = "pci";
+				reg = <0x48400000 0x400000>,
+				      <0x10000000 0x10000>;
+				reg-names = "dbi", "config";
+				#interrupt-cells = <1>;
+				interrupt-map-mask = <0 0 0 7>;
+				interrupt-map = <0 0 0 1 &intc 0 0 GIC_SPI 264 IRQ_TYPE_LEVEL_HIGH>,
+						<0 0 0 2 &intc 0 0 GIC_SPI 265 IRQ_TYPE_LEVEL_HIGH>,
+						<0 0 0 3 &intc 0 0 GIC_SPI 266 IRQ_TYPE_LEVEL_HIGH>,
+						<0 0 0 4 &intc 0 0 GIC_SPI 267 IRQ_TYPE_LEVEL_HIGH>;
+				#address-cells = <3>;
+				#size-cells = <2>;
+				ranges = <0x01000000 0x0 0x00000000 0x10010000 0x0 0x10000>,
+					 <0x02000000 0x0 0x10020000 0x10020000 0x0 0x7fe0000>,
+					 <0x42000000 0x0 0x18000000 0x18000000 0x0 0x8000000>;
+				dma-ranges = <0x42000000 0x0 0x80000000 0x80000000 0x0 0x80000000>;
+				clocks = <&rcc CK_BUS_PCIE>;
+				resets = <&rcc PCIE_R>;
+				msi-parent = <&v2m0>;
+				access-controllers = <&rifsc 68>;
+				power-domains = <&CLUSTER_PD>;
+				status = "disabled";
+
+				pcie@0,0 {
+					device_type = "pci";
+					reg = <0x0 0x0 0x0 0x0 0x0>;
+					phys = <&combophy PHY_TYPE_PCIE>;
+					#address-cells = <3>;
+					#size-cells = <2>;
+					ranges;
+				};
+			};
 		};
 
 		bsec: efuse@44000000 {
-- 
2.34.1


