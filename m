Return-Path: <linux-pci+bounces-22220-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id DBE21A426D2
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 16:49:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3060844363F
	for <lists+linux-pci@lfdr.de>; Mon, 24 Feb 2025 15:41:19 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0AA5B25485A;
	Mon, 24 Feb 2025 15:41:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="K+h5fwCq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1DD9F1C7009;
	Mon, 24 Feb 2025 15:41:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1740411680; cv=none; b=RaHvZ5PiaUMGnoYKwpqa5mrKKZc3bf7em/AdkROjz0F7pkmhBRy+a1fTIK6vmdzXufpZlo4tDhP5uIY2FZi0PSsq1F1W77YkKXsdTg3acYaDLHthGxGoU4uELfCB9/VAXCUDKrKa86l7cO5qnLBSU2RRMXTqMUjZIqQSwc+jp+M=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1740411680; c=relaxed/simple;
	bh=vKDi5xgvTrZCoKFl1m7ddGnON65Hg5ZWsSaeio9sU+g=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=Ez/RwzMC57HX16m74SyAzVhoEHtmwh43M5yVASh7CTyGpc0I+4nOOR2ZEi4JPKjGudE2cD0G8uJg1XuZj98JoYBiTb2XFOTvdBgBRix5jH1VyHCgh7iDWmpyBEZEC1U+A/W6bfeH3DLgDEN03A60QeBT033XnszyJUQzxsdZGrc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=K+h5fwCq; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 51ODsk3S009014;
	Mon, 24 Feb 2025 16:41:00 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	uDpJOAomZghklfUCnDYi43O2k6CX4C8BmcC2QxhH3UY=; b=K+h5fwCq9NhYrt9h
	gHinuno5UpiLFZlY8O0rYFFF8CHLZ5C2GO/B1bK0GN56htO/4pE30gcZBMzfvvSk
	KMZZzPTY8xdaqXdcFlwqsvgQDyT+i/M/StU3LzMvX+paAWFYxnS61v8mKBAl9oOs
	mCdwIYCj+MFSbqzlMq5MX8CQ+EIUVy9SClBXBHkw6M1RGp97pgndi1uMz3CHlAfB
	F/dStvRT0iODrWFTqXyDUMt/pc4wrDSU8952OsvkNUBpZghcXtQ3MdgvX2jjHJ27
	4nD9MuyDrHYU2iZ/TdqKUkTUslnXMbdc6KIqJvwCK/terqY0SsuxR7MYq+aW+RRS
	47HQnQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 44y4vm0fd7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 24 Feb 2025 16:41:00 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id DB66540047;
	Mon, 24 Feb 2025 16:39:45 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C992653E8E3;
	Mon, 24 Feb 2025 16:34:46 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Mon, 24 Feb
 2025 16:34:46 +0100
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
Subject: [PATCH v5 5/9] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
Date: Mon, 24 Feb 2025 16:33:09 +0100
Message-ID: <20250224153313.3416318-6-christian.bruel@foss.st.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250224153313.3416318-1-christian.bruel@foss.st.com>
References: <20250224153313.3416318-1-christian.bruel@foss.st.com>
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
 definitions=2025-02-24_06,2025-02-24_02,2024-11-22_01

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


