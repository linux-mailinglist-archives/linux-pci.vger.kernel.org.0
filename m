Return-Path: <linux-pci+bounces-29299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8822BAD316D
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:14:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 51C8E1655CF
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:14:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A1E0B28B7C2;
	Tue, 10 Jun 2025 09:12:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="dE9rQFzv"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id CF1F128B50A;
	Tue, 10 Jun 2025 09:12:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546735; cv=none; b=GztI2jXB6XxbMXhzPPfhK1nfHEFjfix3xy4bntKYbWxqdI5xYSTG8mdbTVx77dTQQUoEmwnBfTyC8SuLVHCSvEr5w8MPmiRcOZBgo2CbeD26RM57Z1BzvXetpTABSm9uRoZKS+2LI9vXMRblIuCFIpoheceGKd4AqmMeDkgaG5c=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546735; c=relaxed/simple;
	bh=MOVS9MDt5D/qwfv3LrmHj9GwUfRJE7WzWMzzFrmyRuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WMP7+FmGPOJPDgzmYYnDgX4E41pJPuj/KLXdsCiEUxX7EMKzzBMTrVv5VJb1W7OHYtlkPe/dQK/ZdwYyuOrUq9SQmVckMWenKsRhe+vxObx25oXMDhykzwlnEXVZckANDotQPtN881oY36pHx6ErOgicSR7C7TnF8E7sIeHpnFE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=dE9rQFzv; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A97xx1023403;
	Tue, 10 Jun 2025 11:11:53 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	fbyPxu13Z7uJlDRT+bi78um7V/Mx+bWlVKwoNNppU5w=; b=dE9rQFzvU2LFHrY0
	i+SGOZfd5Seg64a7XHkiiwuAdfTI90aamK4JbLajML9o9yPJnKm2zTQi2I6l2AoY
	amLQqJ5vItroVJjwEOTUZ3VFRidEj9nRuuCsVg2K1VUBCd1mK/PP8S5jC7239e3I
	43y5rjRuadhpwOcAas9HwjYiLlp2KHdHvdZBEk5brN3dbCdf/Ck1rDyu9Z/h03e3
	fiPs8319Q61uqTgMlO6rSAvebtHJyRRUBlDHV4DtJRPJvud68ZXarYQJ1q6YZdWM
	KMMkMusYiGmyzqwgSKq0v3vel9qzX/M5zecNA9pszeNseKrsbBSvbZSttZsL+3Ov
	PUDKIg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474y051h0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 11:11:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 5751440069;
	Tue, 10 Jun 2025 11:10:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3FF1D2F6D2E;
	Tue, 10 Jun 2025 11:08:40 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 10 Jun
 2025 11:08:39 +0200
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
Subject: [PATCH v12 6/9] arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
Date: Tue, 10 Jun 2025 11:07:11 +0200
Message-ID: <20250610090714.3321129-7-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250610090714.3321129-1-christian.bruel@foss.st.com>
References: <20250610090714.3321129-1-christian.bruel@foss.st.com>
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

Add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
init: forces GPIO to low while probing so CLKREQ is low for
phy_init
default: restore the AFMUX after controller probe

Add Analog pins of PCIe to perform power cycle

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi | 20 +++++++++++++++++++
 1 file changed, 20 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
index aba90d555f4e..0480b9af00e8 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -133,6 +133,26 @@ pins {
 		};
 	};
 
+	pcie_pins_a: pcie-0 {
+		pins {
+			pinmux = <STM32_PINMUX('J', 0, AF4)>;
+			bias-disable;
+		};
+	};
+
+	pcie_init_pins_a: pcie-init-0 {
+		pins {
+			pinmux = <STM32_PINMUX('J', 0, GPIO)>;
+			output-low;
+		};
+	};
+
+	pcie_sleep_pins_a: pcie-sleep-0 {
+		pins {
+			pinmux = <STM32_PINMUX('J', 0, ANALOG)>;
+		};
+	};
+
 	sdmmc1_b4_pins_a: sdmmc1-b4-0 {
 		pins1 {
 			pinmux = <STM32_PINMUX('E', 4, AF10)>, /* SDMMC1_D0 */
-- 
2.34.1


