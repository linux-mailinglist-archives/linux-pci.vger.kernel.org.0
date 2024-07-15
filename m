Return-Path: <linux-pci+bounces-10299-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id BD040931A1E
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id DD2F21C21FD5
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:15:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D70166E61B;
	Mon, 15 Jul 2024 18:14:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f5GKmpER"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 510F354670;
	Mon, 15 Jul 2024 18:14:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067295; cv=none; b=VZ2ZQ1tUSBfhD/RDg3WmZgk2wHcTNeWNR2aJMQG4CxojfvUJ0TC/PzJiEpS+8FkSX80ubMj/pWj+C4IVzlLZ/+JoEjgn9GLocYMepe+KDzXvNJ1F5Yff6BjVsurvrSL4AqT95iLJKf/x7IvOR+eYwB31P8p4nmoNPAwbajPCe/A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067295; c=relaxed/simple;
	bh=jAy1Gx1OwKTWMdqwcGmMUlFcOi4Kd5uKzJFshqI9F3I=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=MCSLnKUmxzveeTrYzhZ2N9BBOS9Ts+wpibixd8RL+pTVV8J78P0tXW8nGTIvUjDCsh2VK1Q8jCTDM141TO2H2KSaH4wXTOhqhf7AIwurekcHER9oaduCAHmePnN4WXRfCUAEuMmaMVGzmKpfLuBLefWiR5MjLEtP/6GoY0HNRdE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f5GKmpER; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH97g9015665;
	Mon, 15 Jul 2024 18:13:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-type:date:from:in-reply-to:message-id:mime-version
	:references:subject:to; s=qcppdkim1; bh=mrYMruISrghUxd+LH+/OO+b5
	GKFMf/UAsE4wqzMTguo=; b=f5GKmpER3Hh902/gtYhxjgUDK6nWxQtFVJEOWlTO
	RgtzY3ovIJLb61FZY12YEiP9WauKMyDoZBANflX4ej/HC/DeyDeWtR0VC0cxAHNd
	iz/lUnk20Eij11rnGDOCZXt2O31DhFHE6ndEU0Mmrvgi/scHDiyUSK+RVbCAVsmW
	pFUG1om9jGspb169MGk0PlquiZ05PcV2xN0Z04gIM23Tp+BF/rUVOww5eXfZZxfE
	frOZ+ikG+jXKqZHVefjxxhxVMMEH40G1i86izQmyg3Wqo+pAYbQTB6lbvlZRdWJl
	6DhTAgzb1kir/4tYp3kG+XiRuM4WZiw9bePoJox00eviAQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bhnun032-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:54 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDqju001419
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:53 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:52 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V2 3/7] PCI: dwc: Add pcie-designware-msi driver related Kconfig option
Date: Mon, 15 Jul 2024 11:13:31 -0700
Message-ID: <1721067215-5832-4-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OQNNqHbilP3_-ic9EY_h5EF22fVMgCk2
X-Proofpoint-GUID: OQNNqHbilP3_-ic9EY_h5EF22fVMgCk2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 lowpriorityscore=0 mlxlogscore=999
 suspectscore=0 phishscore=0 clxscore=1015 spamscore=0 malwarescore=0
 adultscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150142

PCIe designware MSI driver (pcie-designware-msi.c) shall be used without
enabling pcie-designware core drivers (e.g. usage with ECAM driver). Hence
add Kconfig option to enable pcie-designware-msi driver as separate module.

Signed-off-by: Mayank Rana <quic_mrana@quicinc.com>
---
 drivers/pci/controller/dwc/Kconfig               |  8 ++++++++
 drivers/pci/controller/dwc/Makefile              |  3 ++-
 drivers/pci/controller/dwc/pcie-designware-msi.h | 14 ++++++++++++++
 3 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 8afacc9..a4c8920 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -6,8 +6,16 @@ menu "DesignWare-based PCIe controllers"
 config PCIE_DW
 	bool
 
+config PCIE_DW_MSI
+	bool "DWC PCIe based MSI controller"
+	depends on PCI_MSI
+	help
+	  Say Y here to enable DWC PCIe based MSI controller to support
+	  MSI functionality.
+
 config PCIE_DW_HOST
 	bool
+	select PCIE_DW_MSI
 	select PCIE_DW
 
 config PCIE_DW_EP
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index 2ecc603..9e8e4515 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -1,6 +1,7 @@
 # SPDX-License-Identifier: GPL-2.0
 obj-$(CONFIG_PCIE_DW) += pcie-designware.o
-obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o pcie-designware-msi.o
+obj-$(CONFIG_PCIE_DW_MSI) += pcie-designware-msi.o
+obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
 obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
 obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
 obj-$(CONFIG_PCIE_BT1) += pcie-bt1.o
diff --git a/drivers/pci/controller/dwc/pcie-designware-msi.h b/drivers/pci/controller/dwc/pcie-designware-msi.h
index cf5c612..2872775f 100644
--- a/drivers/pci/controller/dwc/pcie-designware-msi.h
+++ b/drivers/pci/controller/dwc/pcie-designware-msi.h
@@ -40,10 +40,24 @@ struct dw_msi {
 	void			*private_data;
 };
 
+#if IS_ENABLED(CONFIG_PCIE_DW_MSI)
 struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
 			struct dw_msi_ops *ops, u32 num_vectors);
 int dw_pcie_allocate_domains(struct dw_msi *msi);
 void dw_pcie_msi_init(struct dw_msi *msi);
 void dw_pcie_free_msi(struct dw_msi *msi);
 irqreturn_t dw_handle_msi_irq(struct dw_msi *msi);
+#else
+static inline struct dw_msi *dw_pcie_msi_host_init(struct platform_device *pdev,
+			struct dw_msi_ops *ops, u32 num_vectors)
+{ return ERR_PTR(-ENODEV); }
+static inline int dw_pcie_allocate_domains(struct dw_msi *msi)
+{ return -ENODEV; }
+static inline void dw_pcie_msi_init(struct dw_msi *msi)
+{ }
+static inline void dw_pcie_free_msi(struct dw_msi *msi)
+{ }
+static inline irqreturn_t dw_handle_msi_irq(struct dw_msi *msi)
+{ return IRQ_NONE; }
+#endif
 #endif /* _PCIE_DESIGNWARE_MSI_H */
-- 
2.7.4


