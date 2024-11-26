Return-Path: <linux-pci+bounces-17362-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id D7F869D9ADF
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 16:57:48 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 4BEEA165EE7
	for <lists+linux-pci@lfdr.de>; Tue, 26 Nov 2024 15:57:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CA1E51DE2DA;
	Tue, 26 Nov 2024 15:55:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="m3Qkyury"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC83F1DCB0E;
	Tue, 26 Nov 2024 15:55:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732636530; cv=none; b=mCJCOlEAIXwTAw3Rqd/ueD9uWsrsw/w75oov14kMP/fmFSYTzLk73UyQEyIn1VFmliSiQC+jFKXtkd1/kw928D2qkrqBzBn9I4qgFU1849P0OzTRq369VjHw6ka8iCh5EoDxmiG19rmGH8LxdmlOXu007VrnfYO32yqzRRoxNdY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732636530; c=relaxed/simple;
	bh=cBDcw6MY+Oq4uidtM01Vq+OPI1urLBoDdxYLI1m/Ius=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=fsSwt+xiVFWl33ZkC37we+1LKyuE5aFxwGkPtWzQd7HtKILL7QAba925c1FQCSJM8HC/XlYNIxlsRWO+pDyj+Eb1xhLTr4zvFxufzpksuWJckdKOHR2WEg0KeC1X2AEoZ4HdLGVxvh/lXXeMWUfA0//igtPei/tQpx8FZX7/rN0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=m3Qkyury; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AQAl0MV023732;
	Tue, 26 Nov 2024 16:55:07 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	yZhwlZeZQoMpb1RlyyjILd8T/ILSIB2hivP2H9gbW7g=; b=m3QkyuryZz+MB9Di
	tBKaf3IHOjyjHLRLAnTsTi6mhQaghQMzXkDJv2YGOPzlnYjrAKtQQ4U5vLhgxf3V
	UO6+KKNDcT5Up2JrfYobMDw7lPI5TWWiZ8a0UKk4inoC0NSprGkvFFGGF0ZaIWRG
	QJlb98i+x4jfvNEQomssec7zA17pJIEfxToUjbkhk6rsirHc5Upshu+XZOwBC1bt
	LAz3+feLB4v3WuWws3XWAJYtm44F8qAVBImYiR/mr2zbWFK3KbBI+2ucamkYguE8
	mwv563r7oKy+IzbUQTDDBF4hQs1YS3A5P50Z0meqfgL55wK2S+may/Rq1WObtJMU
	Z7vuTg==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 4335295yhu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 26 Nov 2024 16:55:07 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 356C140048;
	Tue, 26 Nov 2024 16:53:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7DA7927B400;
	Tue, 26 Nov 2024 16:52:39 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.37; Tue, 26 Nov
 2024 16:52:39 +0100
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
Subject: [PATCH v2 5/5] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
Date: Tue, 26 Nov 2024 16:51:19 +0100
Message-ID: <20241126155119.1574564-6-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241126155119.1574564-1-christian.bruel@foss.st.com>
References: <20241126155119.1574564-1-christian.bruel@foss.st.com>
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


