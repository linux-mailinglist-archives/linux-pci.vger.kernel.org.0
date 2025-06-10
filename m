Return-Path: <linux-pci+bounces-29300-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 0476FAD3178
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 11:15:10 +0200 (CEST)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 1882D18901DB
	for <lists+linux-pci@lfdr.de>; Tue, 10 Jun 2025 09:14:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC13B28C01F;
	Tue, 10 Jun 2025 09:12:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="RLzw02Jx"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 143E128A409;
	Tue, 10 Jun 2025 09:12:14 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=185.132.182.106
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1749546736; cv=none; b=BXrPKdLOhLWItrsqHGW6izBIMNoOBBFUk5FL9t3LNCgfqz6eAS5k0wz1EN7eh2YVdTD+/pVZLGxuF2dJe6dmTFwFJzVPEOF2x4L68ESM3t9nV900npiW5rLRW883Np3xaY8TPROJSKIFqzlK6ojcF/PuNxa2+c1fFmGds8uHuQY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1749546736; c=relaxed/simple;
	bh=iDTKJ+4e3QyZ+FCS6rf1Us5x01M24Uaq2OiAjrjVDD4=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qPiXJ8gKiZ2WBfYfErKUBbybIZhsoPBIhRYM+8fnvwadlT7gtsG8+TTJfFkzGUOnwTrrujTGWUX+Nj24oWLt0ksT2pB+VRP/lk0MY7D5+NYg4zulcmc2OhOy2FKKv4b1ocESD2tD8Z+DkxBJlue/7fT6Nx74BOr2cyaLdL2m/1o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=RLzw02Jx; arc=none smtp.client-ip=185.132.182.106
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 55A8BhbK030186;
	Tue, 10 Jun 2025 11:11:54 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	lgmM6CujAyNaahpodTKHEeub4g8Zqun/6/CKaxUzZjQ=; b=RLzw02JxB1KOwLI4
	HIX/mpzNbAjBLJsae+oFXd+p8YmcW+ANdKWkmfD2LBtVEpu4KabebCYiEKAB/fLA
	AGKs205XDgKsUFKvNkG//0AEcA2fOO9Ttvg+fw1Zyvt5o6Wxome8uMU94BaD+R/8
	aV78WNnWQ1uObPNfpbNJYB+Jm1BbcJK7alqsf0j9bMmbKHI9CEsBKcou5D9PV5yi
	6IhirMev5BV324YFit82ZocqkspdzjpFanz+Q3hHooDK/4QJS14gVFBycCJ+VcfX
	DcRzTTvesZr7FhOmCNF8ftNWLK3hwOnevxZWuS8hb4qWcuH8yWI3bdglwnP3iQAB
	JplYKQ==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 474cs2kxbh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 10 Jun 2025 11:11:53 +0200 (MEST)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 44E4040068;
	Tue, 10 Jun 2025 11:10:30 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 999AF38C0C5;
	Tue, 10 Jun 2025 11:08:39 +0200 (CEST)
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
Subject: [PATCH v12 5/9] MAINTAINERS: add entry for ST STM32MP25 PCIe drivers
Date: Tue, 10 Jun 2025 11:07:10 +0200
Message-ID: <20250610090714.3321129-6-christian.bruel@foss.st.com>
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

Add myself as maintainer of STM32MP25 PCIe host and PCIe endpoint drivers

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index a7a147f31468..398260d28bbf 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -19068,6 +19068,13 @@ L:	linux-samsung-soc@vger.kernel.org
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
 M:	Manivannan Sadhasivam <mani@kernel.org>
-- 
2.34.1


