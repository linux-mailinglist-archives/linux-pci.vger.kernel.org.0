Return-Path: <linux-pci+bounces-29093-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 63656AD01F6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 14:12:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id CBC9E3B29D6
	for <lists+linux-pci@lfdr.de>; Fri,  6 Jun 2025 12:10:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C75AE289367;
	Fri,  6 Jun 2025 12:09:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="7mYPpG/V"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 035AB288C3A;
	Fri,  6 Jun 2025 12:09:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749211742; cv=none; b=bITAxadc3iNBYugRXfINpyrhwVD/Vdx9J+jIbKwgXgUb99LYDC0kQxHA+uL+lCjn6GG7nRn1+t1x1ZOldaWU3eYlDS3quj8fBSAeF80a76WK4SV+Z6HFXEEnxyZ5ATiP5HKMyawaePmdaJSSe7VYstC8aFfEKkDrKpBsF7C8K/M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749211742; c=relaxed/simple;
	bh=MOVS9MDt5D/qwfv3LrmHj9GwUfRJE7WzWMzzFrmyRuU=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=iNk4/rsqUenYbSLgxV+1/eJbbAM0O9qrlK5hawNmgYIwXuSL7LhkGsxaCFXkRyXjA/Rmk5NfSl99ZW74D2v5Tb+CO1y0Zf5EY6vAi1qVDOmtUIJbBQZg7+mlb2w+kQ8dKPUbodXFqnSX2breBMyG6ZdPhhz5YsvJEYN1cb7F/z0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=7mYPpG/V; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 556BcqsW016994;
	Fri, 6 Jun 2025 14:08:33 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	fbyPxu13Z7uJlDRT+bi78um7V/Mx+bWlVKwoNNppU5w=; b=7mYPpG/VbEDvNOoT
	neGJfSoO6tt027gTV7CotxcRrb3tF7nI6wFJgR/a+kQzMJRBZuLJTm5M6HYsTMEn
	JFuGuqT/aKj1JY9a/LP4XQxMEqvi6Wx4o9kE0uFk/+2+XMJoqOaNEhabMpRCtS3A
	7PqT7jhZB1Eyub2IhhE8Qqvrgj245j3FaPB6HX2oHNAFhZ0GowH5/udXO+5Kr2+P
	DEaUKOhgzec4qHe2W7DwW8G+PKvIpG5iNJn+/NHte8O5+6DhbvcXT6q2TIOiovV8
	A+cggqVvfTk6xMwqElGty5sOyiPbyR+2qvoDpyHgnYP3j1Ghow+KrMphQyR3vCPq
	xL+uog==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 471g8tv64a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 06 Jun 2025 14:08:33 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 6A51F40054;
	Fri,  6 Jun 2025 14:07:13 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2EC5CAFB8DE;
	Fri,  6 Jun 2025 14:06:00 +0200 (CEST)
Received: from localhost (10.130.77.120) by SHFDAG1NODE3.st.com (10.75.129.71)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Fri, 6 Jun
 2025 14:05:59 +0200
From: Christian Bruel <christian.bruel@foss.st.com>
To: <christian.bruel@foss.st.com>, <bhelgaas@google.com>,
        <lpieralisi@kernel.org>, <kwilczynski@kernel.org>,
        <manivannan.sadhasivam@linaro.org>, <robh@kernel.org>,
        <krzk+dt@kernel.org>, <conor+dt@kernel.org>,
        <mcoquelin.stm32@gmail.com>, <alexandre.torgue@foss.st.com>,
        <p.zabel@pengutronix.de>, <quic_schintav@quicinc.com>,
        <shradha.t@samsung.com>, <cassel@kernel.org>,
        <thippeswamy.havalige@amd.com>
CC: <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v11 6/9] arm64: dts: st: add PCIe pinctrl entries in stm32mp25-pinctrl.dtsi
Date: Fri, 6 Jun 2025 14:04:00 +0200
Message-ID: <20250606120403.2964857-7-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250606120403.2964857-1-christian.bruel@foss.st.com>
References: <20250606120403.2964857-1-christian.bruel@foss.st.com>
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
 definitions=2025-06-06_04,2025-06-05_01,2025-03-28_01

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


