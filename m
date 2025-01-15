Return-Path: <linux-pci+bounces-19860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 3340CA11DD9
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 10:30:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7C94B188C849
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 09:29:56 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 31B782442EF;
	Wed, 15 Jan 2025 09:26:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="s5tXq0mi"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43DBD1EEA56;
	Wed, 15 Jan 2025 09:26:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933206; cv=none; b=PpreRxlD3XtzwLknKCk+SNUUTf+0fJZMa4D/ShJ+n6rrlOtC/8JPcRpUrEzktQL1gPgIWrPMHe7/lf4kejnX8iqc4LcYqPh4DHny6YQPYbn0B68pg3B0vUcY0+Rf02gW7C5njmWzQ92DyPboivuOOLMgvGTYgSLLPkP1hI1KUDI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933206; c=relaxed/simple;
	bh=3pEfljVZy+K3Ab7Fgeo0h2ZMek7X7ZKxdYseohmvVtQ=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=a0RpVlJPPNC/q/8/2ZdkI4eojdIAx5/GFr+911nROBnZobF3bv1izbMM0z3KK0dQN3mCSVuwsueztcK4HSSIB3sQ3YlCBz2QrpglZqK7HeQ+Mg4ayY1PZQ2o9Wrz/o9RXBZr046FxVm8f8I+UAhpnwxQ2Ba+owmWUCbJus0XVZM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=s5tXq0mi; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F5MRD5014666;
	Wed, 15 Jan 2025 10:26:25 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	reF3mDkiKmVEX2bXYi+cTFdJ9WH+4R33Xx0dlZMnTAY=; b=s5tXq0miPRIX0Y4c
	6ao6dTn2h8s2iwj/A91DOgYSLnzAc2p2gwMjMu86i+gcC1P+nMWvq1hyqXvUxsCE
	/CzeI0kMxtlf6hTbPgR4fD5jlS7Cw8KoWneFttBy9WW1RwUMSjirSk/7N7VRNo8L
	1ZUomUPogV+Rws7szcf50Y6YCTRxKFxpOXgqsEr26UZ/8a/ZoF2gkU0eOATJrgH8
	WOm/G+JgxfaWImVb+lGDaVsHmKajc3c/cjByUK7hLrQang4bhbDwejn+2xxKjHOA
	0rChMHx9rzhvnOldKHXiI06E2rcl9YgqViNH/9IW0PWrEcbb5K/yVcOI60SJbbM1
	OSCkuw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4466tjrxrq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:26:25 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 9AAED4005B;
	Wed, 15 Jan 2025 10:24:58 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id D3FF8246990;
	Wed, 15 Jan 2025 10:23:45 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 10:23:45 +0100
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
Subject: [PATCH v3 09/10] arm64: dts: st: Enable PCIe on the stm32mp257f-ev1 board
Date: Wed, 15 Jan 2025 10:21:33 +0100
Message-ID: <20250115092134.2904773-10-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250115092134.2904773-1-christian.bruel@foss.st.com>
References: <20250115092134.2904773-1-christian.bruel@foss.st.com>
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

Add PCIe RC and EP support on stm32mp257f-ev1 board, and enable RC mode
by default.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 arch/arm64/boot/dts/st/stm32mp257f-ev1.dts | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
index 1b88485a62a1..f49daa362ebb 100644
--- a/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
+++ b/arch/arm64/boot/dts/st/stm32mp257f-ev1.dts
@@ -225,6 +225,24 @@ scmi_vdd_sdcard: regulator@23 {
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
+	reset-gpios = <&gpioj 8 GPIO_ACTIVE_LOW>;
+	wake-gpios = <&gpioh 5 (GPIO_ACTIVE_LOW | GPIO_PULL_UP)>;
+	status = "okay";
+};
+
 &sdmmc1 {
 	pinctrl-names = "default", "opendrain", "sleep";
 	pinctrl-0 = <&sdmmc1_b4_pins_a>;
-- 
2.34.1


