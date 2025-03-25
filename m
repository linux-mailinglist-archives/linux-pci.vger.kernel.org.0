Return-Path: <linux-pci+bounces-24616-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 94624A6EA13
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 08:03:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id D5C533B07AA
	for <lists+linux-pci@lfdr.de>; Tue, 25 Mar 2025 07:03:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF94E25290C;
	Tue, 25 Mar 2025 07:03:27 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="ocej6AO0"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E565B2528E3;
	Tue, 25 Mar 2025 07:03:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1742886207; cv=none; b=ABAlx3qR97yr37urJ2PDXafGxemsB+VsowxyyUu9P0F/rYNq1yvgd362UkP3KV1KWOCByx9iN5j9IFSb8RvjFIgKjDZ1etCH/InzQJ2XWwHF6nuzrlF4m7nhBmoR1eLKPX4zPxSB5SU9gx+FYnMYRkOFkjk0005782upFFRqKso=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1742886207; c=relaxed/simple;
	bh=P/gcpINfM6po823aW+NIKeMwaDweL+rsT5B/+RSCTCg=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=VaOfmckgJDeNPtiGeB2V4r9e0QQMP2o31z81WAPe0P9fTp7ELfJwGawMISJYwYG+wB6jX4rkRNnUaDTmeqvNskIVvRfWy9qkWbWMkSD29ywLTv8ZP5MpYrnxbwP1FKDqje7yRuuUJItQbzYU4JkAlyyO7kYpmDk4/b4KTIIxHE8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=ocej6AO0; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 52P2LhJo012912;
	Tue, 25 Mar 2025 08:03:03 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	RqmT8AIBzm1H3j3/7WVcQ/OgJdfYX4bMGgnV4G7ptR4=; b=ocej6AO0A3iNu6g9
	xEZT0+5xOmP2ZgGpRb/4NGdOV5dYnZWwdfAHOrlDoVLtoc8B+NOugJ8cER/d65vi
	enC4zHw1GJ/hpAEykRs6Mliqx8Uu/b+ZZpjrpCINxwfywqwlnlGN4DdpQVUYvdrH
	jxWFt9rMr4wfFKvon6Cb9uBubkId9J5zq8WuMvTVyWHtvbl11HxGVK813Y/nH1UZ
	B0me1l2cpZQAGWLbQIuAdUxHGcS4ybYfk7KRW6s41NZiutIocj13fBe4I8V4eO8V
	s7tKULTz84fVeZ4IrewdWlUhe2EAGA4VkWI6TcX85F5pZnuVXsr7bMhRRP7ag75J
	9Zkv7g==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 45hne5b0qt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 25 Mar 2025 08:03:03 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 7BD5540079;
	Tue, 25 Mar 2025 08:01:30 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C989E8518B8;
	Tue, 25 Mar 2025 08:01:13 +0100 (CET)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 25 Mar
 2025 08:01:13 +0100
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
Subject: [PATCH v5 7/9 RESEND] arm64: dts: st: Add PCIe Rootcomplex mode on stm32mp251
Date: Tue, 25 Mar 2025 07:59:33 +0100
Message-ID: <20250325065935.908886-8-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250325065935.908886-1-christian.bruel@foss.st.com>
References: <20250325065935.908886-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-25_03,2025-03-21_01,2024-11-22_01

Add pcie_rc node to support STM32 MP25 PCIe driver based on the
DesignWare PCIe core configured as Rootcomplex mode

Supports Gen1/Gen2, single lane, MSI interrupts using the ARM GICv2m

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 45 +++++++++++++++++++++++++-
 1 file changed, 44 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index f3c6cdfd7008..a8abb13ab663 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -117,12 +117,20 @@ scmi_vdda18adc: regulator@7 {
 	intc: interrupt-controller@4ac00000 {
 		compatible = "arm,cortex-a7-gic";
 		#interrupt-cells = <3>;
-		#address-cells = <1>;
+		#address-cells = <2>;
+		#size-cells = <2>;
 		interrupt-controller;
 		reg = <0x0 0x4ac10000 0x0 0x1000>,
 		      <0x0 0x4ac20000 0x0 0x2000>,
 		      <0x0 0x4ac40000 0x0 0x2000>,
 		      <0x0 0x4ac60000 0x0 0x2000>;
+		ranges;
+
+		v2m0: v2m@48090000 {
+			compatible = "arm,gic-v2m-frame";
+			reg = <0x0 0x48090000 0x0 0x1000>;
+			msi-controller;
+		};
 	};
 
 	psci {
@@ -900,6 +908,41 @@ stmmac_axi_config_1: stmmac-axi-config {
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


