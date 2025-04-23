Return-Path: <linux-pci+bounces-26490-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id B93E2A9830F
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 10:23:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CD3037A439C
	for <lists+linux-pci@lfdr.de>; Wed, 23 Apr 2025 08:22:17 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 46BD528BA91;
	Wed, 23 Apr 2025 08:15:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="Y77HIf4c"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 73C00274667;
	Wed, 23 Apr 2025 08:15:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1745396119; cv=none; b=eJNaSxfOJAbz0CRXSBZhXuSBn2gymg43QA9nDCsSgFnao6sUj/p8Kd7VZRIKv48boyrdSGZjkjgJtsqCsyBl4C0Q1+UiuZmXGujRXts76Q8IFxGTOAFJsR/+qxBKDZLLU8LL0FvACY5kq7QhhJxa5ZByhgMjBR24PnlfKqqhMXU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1745396119; c=relaxed/simple;
	bh=Afr2XNZYO2y/DV4KL3zXWFGDJkE6nBzrVvYEeUZ6r5w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ZZXHKJx18fYAGCMVhtGS1cob0Kby7VZxdzWf7VkFYrUBZr928aTT9ji3fYuAbGs8wyBTON5Io1lo/UQyCiOuYqTxdJfvWNjIp/paZpftxyDSDcqNyrjfcqw2ogQEMwB0GHlCXKtqrxcJVltFHYWpNvGJnh25oKAJ4/hQ8Do9uvc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=Y77HIf4c; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 53N6v6HR016613;
	Wed, 23 Apr 2025 10:14:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	Oxqz3gPKLjUeq3RC+gzdPgb15H4SWpt1bnaDWPNbrFk=; b=Y77HIf4cNnHvEe2X
	OJLpJErj/73Q9iKmsKmBM5qg5Woi4mAZzlMZMaDbeeJbNodFgNhzBDpgqxV5v3qp
	M2z+uxIcpXQOg2HjfLlqkJu8+NqCJFPhpw5iyfYNWAgFCzAiAlOlgZshQOdjJOOQ
	k6sP9gSpg6ovtgNZiQ684sgSwVLTMhu5W+PJEmYsnlJGBzWoYlAmVPlZYZ2/OPPg
	UgjyhLeWyziO1HLxPcmzq8LtYWVYcVf1hr3pOdr+h7YlaYWkOHqAbdsUOC3e/VNm
	tne0TRJTVK80Fv1XcgGDvTE/eABH4S1SUFYkIBToRMcdxi+6M1QM6SnuwZebm949
	tEwg6A==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 466jjxa11m-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 23 Apr 2025 10:14:48 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id D854540052;
	Wed, 23 Apr 2025 10:13:15 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1880AA124F9;
	Wed, 23 Apr 2025 10:12:00 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 23 Apr
 2025 10:11:59 +0200
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
Subject: [PATCH v7 6/9] arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
Date: Wed, 23 Apr 2025 10:10:48 +0200
Message-ID: <20250423081051.3907930-7-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250423081051.3907930-1-christian.bruel@foss.st.com>
References: <20250423081051.3907930-1-christian.bruel@foss.st.com>
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
index 8fdd5f020425..f0d814bc7c60 100644
--- a/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
+++ b/arch/arm64/boot/dts/st/stm32mp25-pinctrl.dtsi
@@ -82,6 +82,26 @@ pins {
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


