Return-Path: <linux-pci+bounces-34353-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 687BBB2D582
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 10:01:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 6D53872788B
	for <lists+linux-pci@lfdr.de>; Wed, 20 Aug 2025 08:01:01 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D054F24A047;
	Wed, 20 Aug 2025 08:00:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="VXyXTxlC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2F9172AE84;
	Wed, 20 Aug 2025 08:00:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1755676836; cv=none; b=dsuPssbDNBR2DRcf/5Y/5/4JuZbYjWni9vnzAJy8IqJq9POZrtix83pF788REdeEXozeCJxNFZOjNYwIvU3yvEY6QwqE5JknkOyRB6WSp7urZ3Q+4re+vXvPHqA7NTffXJcZ8lPz4hqz8Aplk1BMtPRHRrr5IEz48Y7C8sv9C1E=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1755676836; c=relaxed/simple;
	bh=y2yhNn63zhjFl6eEfpN98Ri3q1hNqRdwMaX3DtDntfo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ALK5pAFA0awYWTnOkZPWiYmb0Dzl/DGHPcZOpCBhwRfovvvo1ggacJRcuW6YqoNMwvoesd/89xnddNoeiFi/y0JFa7AEp/W5+MERBvcZrFyO/khKOyLJ4mW728ti7xLfK4DoxY0+f0yUM87zghGzzHIi16qd/UA0wOIw1yeNuc4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=VXyXTxlC; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 57K7LAVd023327;
	Wed, 20 Aug 2025 10:00:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uZHIUrwkTLMT4dP43C45QjC6tGfszmVu9NMO92SKdMg=; b=VXyXTxlC/c7XHuyl
	mefPZOdVIpG9ana6cCaDUBADy0IeiOmNPfMf+o85ehqUooMHdvfTt2jqEUKprJS/
	JYQI0N6sB5YKZeQmDVSxPd9v4NMPPa0i0M8r5pi32oLtN7Jb/XMbQKkPi5eF/Dki
	x+UAW3b/7ZrgSPcWPdbAHM6kYlaAr7GC1uI5CE9JG6vakKHar8ahNMVL2nYxH0VA
	P5j4B8ErZwhLMGCsrNZMdaF5sfW3OrobhC1EGk9787WMIzgGdgx52Q9KN8d5oWg7
	V2BHHuoXGIhdE/vtUvELfAs06l634SASc5dfeImQZ+qLuwgZVicj+pcxm5ZlRhh5
	DI2+gw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 48n7kn8uda-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Aug 2025 10:00:09 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 13C384004D;
	Wed, 20 Aug 2025 09:58:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A8EBE475830;
	Wed, 20 Aug 2025 09:57:26 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 20 Aug
 2025 09:57:26 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <lpieralisi@kernel.org>,
        <kwilczynski@kernel.org>, <mani@kernel.org>, <robh@kernel.org>,
        <bhelgaas@google.com>, <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <linus.walleij@linaro.org>, <corbet@lwn.net>, <p.zabel@pengutronix.de>,
        <shradha.t@samsung.com>, <mayank.rana@oss.qualcomm.com>,
        <namcao@linutronix.de>, <qiang.yu@oss.qualcomm.com>,
        <thippeswamy.havalige@amd.com>, <inochiama@gmail.com>,
        <quic_schintav@quicinc.com>
CC: <johan+linaro@kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-gpio@vger.kernel.org>, <linux-doc@vger.kernel.org>
Subject: [PATCH v13 10/11] arm64: dts: st: Add PCIe Endpoint mode on stm32mp251
Date: Wed, 20 Aug 2025 09:54:10 +0200
Message-ID: <20250820075411.1178729-11-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250820075411.1178729-1-christian.bruel@foss.st.com>
References: <20250820075411.1178729-1-christian.bruel@foss.st.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE3.st.com
 (10.75.129.71)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1099,Hydra:6.1.9,FMLib:17.12.80.40
 definitions=2025-08-20_03,2025-08-20_01,2025-03-28_01

Add pcie_ep node to support STM32 MP25 PCIe driver based on the
DesignWare PCIe core configured as Endpoint mode

Acked-by: Manivannan Sadhasivam <mani@kernel.org>
Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp251.dtsi | 15 +++++++++++++++
 1 file changed, 15 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp251.dtsi b/arch/arm64/boot/dts/st/stm32mp251.dtsi
index a3ed617a43d3..764b6a1623db 100644
--- a/arch/arm64/boot/dts/st/stm32mp251.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp251.dtsi
@@ -1664,6 +1664,21 @@ stmmac_axi_config_1: stmmac-axi-config {
 				};
 			};
 
+			pcie_ep: pcie-ep@48400000 {
+				compatible = "st,stm32mp25-pcie-ep";
+				reg = <0x48400000 0x100000>,
+				      <0x48500000 0x100000>,
+				      <0x48700000 0x80000>,
+				      <0x10000000 0x10000000>;
+				reg-names = "dbi", "dbi2", "atu", "addr_space";
+				clocks = <&rcc CK_BUS_PCIE>;
+				resets = <&rcc PCIE_R>;
+				phys = <&combophy PHY_TYPE_PCIE>;
+				access-controllers = <&rifsc 68>;
+				power-domains = <&CLUSTER_PD>;
+				status = "disabled";
+			};
+
 			pcie_rc: pcie@48400000 {
 				compatible = "st,stm32mp25-pcie-rc";
 				device_type = "pci";
-- 
2.34.1


