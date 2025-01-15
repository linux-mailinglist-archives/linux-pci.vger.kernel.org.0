Return-Path: <linux-pci+bounces-19856-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 4EEFEA11D90
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 10:26:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 6FBBC1602EA
	for <lists+linux-pci@lfdr.de>; Wed, 15 Jan 2025 09:26:06 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 639501ACE12;
	Wed, 15 Jan 2025 09:25:56 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b="77W+QIs5"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 82C381EEA34;
	Wed, 15 Jan 2025 09:25:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=91.207.212.93
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1736933156; cv=none; b=K3lLPUFBMtLacUs6JobxWYebc5f8Onq+lpsPLAJmWWcxPmAMqEjWqoLZVmZXwBuhgVeyGL6h/kEwwA+fGsz29JGwEb5vmmVtuxGb/Q8GVwxBAo/ehik7EtHBTvI42eCDYBzkHS3IMsWfqqHIXbUQfE3ncsyXppvXPIpJPezhO2o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1736933156; c=relaxed/simple;
	bh=NGRjFJsVgeTrG4s67v8MZeELMDTZt2DLg/MRMLsQ46w=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=gRv9/IIiCWTYsGD1q0y/8ADppWzm/nnLCNh2J0hlYfahWIPOswE5dB6e0zlK1FaTTyn3ioqmfq0SBC1sMIRutdg9TKmnVuH+bbO6N+9OWRV1JrISBzADJhki0De/654cF0q7To4eeSJWo28LUx3Y/aZ3noGa9WzwjJ0dXVDVi40=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com; spf=pass smtp.mailfrom=foss.st.com; dkim=pass (2048-bit key) header.d=foss.st.com header.i=@foss.st.com header.b=77W+QIs5; arc=none smtp.client-ip=91.207.212.93
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=foss.st.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=foss.st.com
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
	by mx07-00178001.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 50F9BMmA032417;
	Wed, 15 Jan 2025 10:25:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=selector1; bh=
	LCgsY73vctF07UL0jpejFuqgl70gK02rg3oWbuscZtA=; b=77W+QIs5hYl1w1E4
	af3I/Yw1+mCxE4qieETdXiZB0PsKsTnGfKM55rsmoO7h9idRA7IJcAbwdHF5nREp
	Ir0gGCOkUdxr43fjr5MQWB2HrxPi00lo+LngLtFjAE9CRSScTeJNlRJrbZIvlZzt
	SLdo2iu95WDerFbYRkd5qi/BDqu3T9zl/6eZYI7HjtcbccLldjQmRfJPbL+4DC1C
	Y97/0r9OXErEJfluIHUWcYksur1SpJE4mjSCLJy4UOGYR0ifAcFC+nloh7py+fMH
	ZMTqxpfJAHvOymjYZF580IDOOaqqYQI7TIsjXhiOJO3UWbwnEeUue9Dsuek/6A9u
	jZzjKw==
Received: from beta.dmz-ap.st.com (beta.dmz-ap.st.com [138.198.100.35])
	by mx07-00178001.pphosted.com (PPS) with ESMTPS id 446a5wg26w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 15 Jan 2025 10:25:21 +0100 (CET)
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
	by beta.dmz-ap.st.com (STMicroelectronics) with ESMTP id 0D45A4004C;
	Wed, 15 Jan 2025 10:23:54 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node3.st.com [10.75.129.71])
	by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 9A1D624645C;
	Wed, 15 Jan 2025 10:22:41 +0100 (CET)
Received: from localhost (10.129.178.212) by SHFDAG1NODE3.st.com
 (10.75.129.71) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.39; Wed, 15 Jan
 2025 10:22:41 +0100
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
Subject: [PATCH v3 02/10] PCI: dwc: Add dw_pcie_wake_irq_handler helper
Date: Wed, 15 Jan 2025 10:21:26 +0100
Message-ID: <20250115092134.2904773-3-christian.bruel@foss.st.com>
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

Introduce dw_pcie_wake_irq_handler function to support host wakeup from
the WAKE# irq.

Signed-off-by: Christian Bruel <christian.bruel@foss.st.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 15 +++++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h      |  2 ++
 2 files changed, 17 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index bcbbe02f8f86..35cbb686d3f3 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -16,6 +16,7 @@
 #include <linux/of_pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/suspend.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -991,3 +992,17 @@ int dw_pcie_resume_noirq(struct dw_pcie *pci)
 	return ret;
 }
 EXPORT_SYMBOL_GPL(dw_pcie_resume_noirq);
+
+irqreturn_t dw_pcie_wake_irq_handler(int irq, void *arg)
+{
+	struct device *dev = arg;
+
+	dev_dbg(dev, "host wakeup by EP");
+
+	/* Notify PM core we are wakeup source */
+	pm_wakeup_event(dev, 0);
+	pm_system_wakeup();
+
+	return IRQ_HANDLED;
+}
+EXPORT_SYMBOL_GPL(dw_pcie_wake_irq_handler);
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 110cbac7dde1..434cb6a00f01 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -502,6 +502,8 @@ void dw_pcie_edma_remove(struct dw_pcie *pci);
 int dw_pcie_suspend_noirq(struct dw_pcie *pci);
 int dw_pcie_resume_noirq(struct dw_pcie *pci);
 
+irqreturn_t dw_pcie_wake_irq_handler(int irq, void *arg);
+
 static inline void dw_pcie_writel_dbi(struct dw_pcie *pci, u32 reg, u32 val)
 {
 	dw_pcie_write_dbi(pci, reg, 0x4, val);
-- 
2.34.1


