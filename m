Return-Path: <linux-pci+bounces-20466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id D5D0DA20A7B
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 13:18:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 238683A598C
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:18:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 862B319992E;
	Tue, 28 Jan 2025 12:18:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="jED4GcJK"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 355C1BA27;
	Tue, 28 Jan 2025 12:18:04 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066687; cv=none; b=Y/5+URuZP+nLyaLxUdB7H4e7HSLOgVkIK9LfcaiDcTz0J8q+LN4/Do9ZUvgwmhNQDLKpK86sxXw7z2nRBdndv1Xq7MTeDiEQDZn9Mb0DXjXlTB2scgphNqYXU9J+VbvDxyWoBpI8ZHni8CvB4Et8Fm2Iq+vJDEA3SnL5YH+fhb0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066687; c=relaxed/simple;
	bh=X0pfrVubMtPrmu5J4o+PBHCJ5HyISnT5OQLv/tjbbJQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bAIIAGP4Gm/kJE3L1C3D/ZeOLBe2ZP0z/3ZnXIL7wOvHKIdt7Fhbsrt5Bym+0p7BPLlZY4bvSuz+lcwoPQLqUM2ra8sGcVYmPLtE/Td9TVEu7VO4ct4ZQ8OwuyXvxu6r0jhorrF5H2neQwbK7PcGdA8F3unWqPEkzcCiPtqLzwc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=jED4GcJK; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369458.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50S9U0NE001758;
	Tue, 28 Jan 2025 13:17:41 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	SYTacyFClbKzLmjOqzdhJPPxLmts2g5kWZai4fotd8s=; b=jED4GcJK9P2wyC1M
	A2P/2YnwM3GkRzhmuTEk2F8eJXiIKk9UAhvbRiZYJ36WeP762egkdZFULGkiQn+T
	C69UfzBKCxIn2IxnS25Oj09CWrQ1IjIOfcyuOaw2gMPoRU8x0R/lScrIHNNy3LLd
	hrAA5EO1vExi+rn6lFd3jJCmLHy0DnGrWIiroLKZuagcbIIRmWG1YiyOHMWkmLxi
	Atvp0ODXktfuiyXRR8xZZC+nbNsGNMpsUjwleVO6PHEuZRr5WcdZISee+mmqbaRx
	xynIRLEDYhEWzRieOJVBNcznpWLOATcKbBGx6PW90oW4rViVJuI7YxZ8YIwHTgMz
	cbRVDQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44eudv165d-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:17:40 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 8F45440054;
	Tue, 28 Jan 2025 13:16:18 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A64DD28BE81;
	Tue, 28 Jan 2025 13:11:43 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 13:11:43 +0100
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
Subject: [PATCH v4 10/10] arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board
Date: Tue, 28 Jan 2025 13:07:45 +0100
Message-ID: <20250128120745.334377-11-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250128120745.334377-1-christian.bruel@foss.st.com>
References: <20250128120745.334377-1-christian.bruel@foss.st.com>
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
 engine=ICAP:2.0.293,Aquarius:18.0.1057,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-01-28_04,2025-01-27_01,2024-11-22_01

Add PCIe RC and EP support on stm32mp257f-ev1 board, and enable RC mode
by default.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 1b88485a62a1..1a3946f47b45 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -225,6 +225,28 @@ scmi_vdd_sdcard: regulator@23 {
 	};
 };
 
+&pcie_ep {
+	pinctrl-names = "default", "init";
+	pinctrl-0 = <&pcie_pins_a>;
+	pinctrl-1 = <&pcie_init_pins_a>;
+	reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
+	status = "disabled";
+};
+
+&pcie_rc {
+	pinctrl-names = "default", "init", "sleep";
+	pinctrl-0 = <&pcie_pins_a>;
+	pinctrl-1 = <&pcie_init_pins_a>;
+	pinctrl-2 = <&pcie_sleep_pins_a>;
+	wakeup-source;
+	status = "okay";
+
+	pcie@0,0 {
+		 reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
+		 wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	};
+};
+
 &sdmmc1 {
 	pinctrl-names = "default", "opendrain", "sleep";
 	pinctrl-0 = <&sdmmc1_b4_pins_a>;
-- 
2.34.1


