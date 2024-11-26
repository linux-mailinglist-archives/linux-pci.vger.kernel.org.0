Return-Path: <linux-pci+bounces-17344-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 9D9419D97F3
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 14:05:23 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 458231670D9
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 13:05:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 414E71D4340;
	Tue, 26 Nov 2024 13:05:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="DNvlWt8f"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 819FA2F32;
	Tue, 26 Nov 2024 13:05:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732626319; cv=none; b=JHon8KW8w1Msoh9YIGO7G0iKM7gphDF9Fs6gw1lu3PfCnWzb0hAee1SiyJNdrgZoZCxvPgTCw5Z4iZP3svS+aeS+9159UHzwDIO5zdbsZ62CTObtiudr0nQqRf7YIrNTRC8X6RAlENb/PiAu2lmOdEu2A+cBpBOHWIxDdg8sSpw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732626319; c=relaxed/simple;
	bh=cBDcw6MY+Oq4uidtM01Vq+OPI1urLBoDdxYLI1m/Ius=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=bSbQEjgpfiVV2YijUcmiHpNW/8mAIGT2Mxap6pQ2a0ziR7F2mL8JqckLlomRKK2djCF5qFMM9nPMqD3bGzwATfQS2HCiiAKpZt6aelM1AULGvcj7XQDRFOBiSuf/L2l2g2/vwNxdm/sxBl+6tKj5jJY2hc9Zri3BQGizIhsUGqc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=DNvlWt8f; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAk5IR003880;
	Tue, 26 Nov 2024 14:04:49 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yZhwlZeZQoMpb1RlyyjILd8T/ILSIB2hivP2H9gbW7g=; b=DNvlWt8fMZLqD2vB
	Q9QLpb1qcsyiTWu3gtk+Bkx63qc4m+sSPpRgbySdIJlB9BoonWYpyWhkgBAWyuAC
	AasjTihhT1bbCzUb/3dG0wYY0KUTprTEnwneAm1ffAcGeE3yDCi4G2l9gj6Oc/d5
	cyEDonQFb3cL4uACUQuckK9izDu/mO7OX8ODAW7/1iticGXoJkf/vIRDqxLboFm5
	ZlABrfnOrqIc5KCoQ/CQJAcfKSP838OTceXo9ASSGvjt4gkQXiaGFZWa296ezSkA
	6RQQ5CMVTupGa4k4j4Y2A+DN4MKOlDz7mRhUHkSov5GZUiWxM7cgfkf8LLgRcusD
	+Nxh/w==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4336tfmxca-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 14:04:49 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DA1C140050;
	Tue, 26 Nov 2024 14:03:32 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 4C970286EC2;
	Tue, 26 Nov 2024 14:01:29 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Nov
 2024 14:01:29 +0100
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
Subject: [PATCH v1 5/5] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
Date: Tue, 26 Nov 2024 14:00:04 +0100
Message-ID: <20241126130004.1570091-6-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126130004.1570091-1-christian.bruel@foss.st.com>
References: <20241126130004.1570091-1-christian.bruel@foss.st.com>
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

Add myself as maintainer of STM32MP25 PCIe host and PCIe endpoint drivers

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 4803908768e8..277e1cc0769e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17912,6 +17912,13 @@ L:	linux-samsung-soc@vger.kernel.org
 S:	Maintained
 F:	drivers/pci/controller/dwc/pci-exynos.c
 
+PCI DRIVER FOR STM32MP25
+M:	Christian Bruel <christian.bruel@foss.st.com>
+L:	linux-pci@vger.kernel.org
+S:	Maintained
+F:	Documentation/devicetree/bindings/pci/st,stm32-pcie-*.yaml
+F:	drivers/pci/controller/dwc/*stm32*
+
 PCI DRIVER FOR SYNOPSYS DESIGNWARE
 M:	Jingoo Han <jingoohan1@gmail.com>
 M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
-- 
2.34.1


