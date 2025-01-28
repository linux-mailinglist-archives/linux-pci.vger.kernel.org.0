Return-Path: <linux-pci+bounces-20464-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 455F7A20A69
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 13:15:32 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E0E0A7A5180
	for <lists+linux-pci@lfdr.de>; Tue, 28 Jan 2025 12:15:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC4661D5ACF;
	Tue, 28 Jan 2025 12:13:12 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="mEm2BxPg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx08-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0A5C61D5AA8;
	Tue, 28 Jan 2025 12:13:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1738066392; cv=none; b=hGE8qN29gju4e8vy394lC/juKPa0YUST047LZcVp6x2Rtnewzt85DeCkhDKSiHhUmuyYSg6y1QoK17A9Yt2x88SwNto2KqyvHaelA/Hg79c6tiJAhFg0myoj8Zp7BKK2a6FvL3q36PL/bYD+7aa6yDqDXuV8rFQLDVSsCYlVtJE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1738066392; c=relaxed/simple;
	bh=vKDi5xgvTrZCoKFl1m7ddGnON65Hg5ZWsSaeio9sU+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=S8zYoWugfYGpDLYCYVX3UhOSKcLuogRF8IAELX+e7EhDcCLsgW+wT2z6/4QHKy9snzE/z65lx3h3uZnd1tkBc+kzF8XcoEjDdTzVgYU5Y4XrX1feRpWpfCrwWijq2u+wEyx9a84pfKgZdxKvt5nEJDjHZBAxYgHbLK/SIlNiCNo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=mEm2BxPg; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0369457.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50SC5RF5029927;
	Tue, 28 Jan 2025 13:12:54 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uDpJOAomZghklfUCnDYi43O2k6CX4C8BmcC2QxhH3UY=; b=mEm2BxPgi+3tKAs1
	Egl2YNuObmOrIhDiBXe7RZ+IeI/mHnKBc1OQzSxEjkV+ZJeMjzbMHijckVkje+S0
	d8uzcWB1w43WPanf+fTdAvB42FLnJ26FotdixHP73+weIa30UuuSAZDNg1zGINQ6
	E325SlZJKlvxSPNC9D9UV1zp2HXnaoEFPi37cNovD4rKbL4Kp5y5bv2sGm+8Y/DQ
	XhwbekfdJAkRvuGiszP9FHN1Hfo93uryh/aLxeGoRdPGUt7DTFVosOsfMQk1m2Oy
	D+M7TdT0Hs0+XeOLAzV1ZuJh8TSPV0Q96l+/uHYGx1rwZc8RcD79lamTWlGRS1Sa
	HkXxTw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44exxc012c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 28 Jan 2025 13:12:54 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 27A624006F;
	Tue, 28 Jan 2025 13:11:26 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 513552DE899;
	Tue, 28 Jan 2025 13:09:36 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Tue, 28 Jan
 2025 13:09:36 +0100
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
Subject: [PATCH v4 06/10] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
Date: Tue, 28 Jan 2025 13:07:41 +0100
Message-ID: <20250128120745.334377-7-christian.bruel@foss.st.com>
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

Add myself as maintainer of STM32MP25 PCIe host and PCIe endpoint drivers

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 33b9cd11a3a4..d8f2de1a3543 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -18108,6 +18108,13 @@ L:	linux-samsung-soc@vger.kernel.org
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


