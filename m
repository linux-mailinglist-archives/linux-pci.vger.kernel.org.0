Return-Path: <linux-pci+bounces-6467-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64EE18AA625
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 02:12:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id C88C11F2257E
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 00:12:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B17961C2D;
	Fri, 19 Apr 2024 00:11:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BzLCz9na"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4D5515BB;
	Fri, 19 Apr 2024 00:10:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485461; cv=none; b=RoOw5xWKC+uep5Qna2nFN51qacqIHoytRuQ/kyRJYmek/DKo2FkvHAll+/EOlqmqBPrq33XNZJHjzeGRGFl/BbvZYpYo8cAwqPbUPMuntWrzA3bVJ3vDi2AU2Yoy4GYbEjLV3+x7su0GPEelCHtrmyT8+tfYgxC4qu3CV46/wAk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485461; c=relaxed/simple;
	bh=70F05dCOQlNEKaAaukwvUw1jy4gzdCWjSjxXahPRKoo=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=n5DPITHp5Jj1jFliflLS2sga0YTEtV18f3N0yZ3e3DUPUWcUkyjdF+yvzgmBZRZTjXLiaqKq2t5fp4M/tb6kaOBJSM2i5RiA/YtZK/nSsOBVc16sRkWPmQ0lMruZUqWlldLqgdOrTwcr6GNUrdGSArGEh1Q4/tK8yL2MivntT44=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BzLCz9na; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43INUKIH021705;
	Fri, 19 Apr 2024 00:10:41 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=1GgSHFolSDQ0s/SVTnaTejx6sUi0pmpGFEkKY5QWjqA=; b=Bz
	LCz9namsY01m0jx9wzoxUMlzspAyAy0q7y7oUWkC5cyiZ9VqFCnA2eZau3ynYduQ
	OzutI1LQa1vwRjCL1C8Ipakrr5Vdot90eBJsWDXJT1szB7itQX7S8wffuH1JjcGk
	N3slqQK0sKW6bTg7YDOHA6Kpj61VJj3AZ5KhxUg7gOCkhz2KSbyID0ANSJlLDqYI
	m133Dd7t2vELxfgzd7A48fv8daBbB+weGYGm6bOpgVN/gYMA3WSM5H0EbT00sXfW
	53SIDuhVka8mQ1j0PblTyXZc7/4/dwNFZq3Y2vpF1MEhHjDuB8Qr13NGthYlpzvU
	Gi0OiusEYLtJQ0qsdNoA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx54j9du-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:40 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J0Aels011143
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:40 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 17:10:39 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 1/3] PCI: qcom: Refactor common code
Date: Thu, 18 Apr 2024 17:09:34 -0700
Message-ID: <20240419001013.28788-2-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240419001013.28788-1-quic_schintav@quicinc.com>
References: <20240419001013.28788-1-quic_schintav@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YpBZ5yrmFlTXVc4unV0LYi1SSkDTPGzi
X-Proofpoint-ORIG-GUID: YpBZ5yrmFlTXVc4unV0LYi1SSkDTPGzi
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_21,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=999 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190000

Refactor common code from RC(Root Complex) and EP(End Point)
drivers and move them to a common driver. This acts as placeholder
for common source code for both drivers, thus avoiding duplication.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/Kconfig            |  5 ++
 drivers/pci/controller/dwc/Makefile           |  1 +
 drivers/pci/controller/dwc/pcie-qcom-common.c | 75 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h | 12 +++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     | 39 +---------
 drivers/pci/controller/dwc/pcie-qcom.c        | 67 ++---------------
 6 files changed, 105 insertions(+), 94 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h

diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 8afacc90c63b..1599550cd628 100644
--- a/drivers/pci/controller/dwc/Kconfig
+++ b/drivers/pci/controller/dwc/Kconfig
@@ -265,12 +265,16 @@ config PCIE_DW_PLAT_EP
 	  order to enable device-specific features PCI_DW_PLAT_EP must be
 	  selected.
 
+config PCIE_QCOM_COMMON
+	bool
+
 config PCIE_QCOM
 	bool "Qualcomm PCIe controller (host mode)"
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_MSI
 	select PCIE_DW_HOST
 	select CRC8
+	select PCIE_QCOM_COMMON
 	help
 	  Say Y here to enable PCIe controller support on Qualcomm SoCs. The
 	  PCIe controller uses the DesignWare core plus Qualcomm-specific
@@ -281,6 +285,7 @@ config PCIE_QCOM_EP
 	depends on OF && (ARCH_QCOM || COMPILE_TEST)
 	depends on PCI_ENDPOINT
 	select PCIE_DW_EP
+	select PCIE_QCOM_COMMON
 	help
 	  Say Y here to enable support for the PCIe controllers on Qualcomm SoCs
 	  to work in endpoint mode. The PCIe controller uses the DesignWare core
diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
index bac103faa523..3f557dd60c38 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
+obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP_DW_HOST) += pcie-dw-rockchip.o
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
new file mode 100644
index 000000000000..dc2120ec5fef
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -0,0 +1,75 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015, 2021 Linaro Limited.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ *
+ */
+
+#include <linux/pci.h>
+#include <linux/interconnect.h>
+
+#include "../../pci.h"
+#include "pcie-designware.h"
+#include "pcie-qcom-common.h"
+
+#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
+		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
+
+int qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, struct icc_path **icc_mem_p)
+{
+	*icc_mem_p = devm_of_icc_get(pci->dev, "pcie-mem");
+	if (IS_ERR_OR_NULL(icc_mem_p))
+		return PTR_ERR(icc_mem_p);
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_get_resource);
+
+int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem)
+{
+	int ret;
+
+	/*
+	 * Some Qualcomm platforms require interconnect bandwidth constraints
+	 * to be set before enabling interconnect clocks.
+	 *
+	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
+	 * for the pcie-mem path.
+	 */
+	ret = icc_set_bw(icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+		return ret;
+	}
+
+	return 0;
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_init);
+
+void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem)
+{
+	u32 offset, status;
+	int speed, width;
+	int ret;
+
+	if (!icc_mem)
+		return;
+
+	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
+	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
+
+	/* Only update constraints if link is up. */
+	if (!(status & PCI_EXP_LNKSTA_DLLLA))
+		return;
+
+	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
+	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
+
+	ret = icc_set_bw(icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+	if (ret)
+		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+			ret);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_update);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
new file mode 100644
index 000000000000..f0520d7301da
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -0,0 +1,12 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015, 2021 Linaro Limited.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "pcie-designware.h"
+
+int qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, struct icc_path **icc_mem_p);
+int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
+void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 36e5e80cd22f..11c99b358147 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -25,6 +25,7 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-qcom-common.h"
 
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
@@ -137,9 +138,6 @@
 #define CORE_RESET_TIME_US_MAX			1005
 #define WAKE_DELAY_US				2000 /* 2 ms */
 
-#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
-		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
-
 #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
 
 enum qcom_pcie_ep_link_status {
@@ -278,28 +276,6 @@ static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
 	writel(0, pcie_ep->elbi + ELBI_CS2_ENABLE);
 }
 
-static void qcom_pcie_ep_icc_update(struct qcom_pcie_ep *pcie_ep)
-{
-	struct dw_pcie *pci = &pcie_ep->pci;
-	u32 offset, status;
-	int speed, width;
-	int ret;
-
-	if (!pcie_ep->icc_mem)
-		return;
-
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
-
-	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
-	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
-
-	ret = icc_set_bw(pcie_ep->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-	if (ret)
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
-}
-
 static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 {
 	struct dw_pcie *pci = &pcie_ep->pci;
@@ -325,14 +301,7 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
 	if (ret)
 		goto err_phy_exit;
 
-	/*
-	 * Some Qualcomm platforms require interconnect bandwidth constraints
-	 * to be set before enabling interconnect clocks.
-	 *
-	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
-	 * for the pcie-mem path.
-	 */
-	ret = icc_set_bw(pcie_ep->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
+	ret = qcom_pcie_common_icc_init(pci, pcie_ep->icc_mem);
 	if (ret) {
 		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
 			ret);
@@ -616,7 +585,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
-	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
+	ret = qcom_pcie_common_icc_get_resource(&pcie_ep->pci, &pcie_ep->icc_mem);
 	if (IS_ERR(pcie_ep->icc_mem))
 		ret = PTR_ERR(pcie_ep->icc_mem);
 
@@ -643,7 +612,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received BME event. Link is enabled!\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
-		qcom_pcie_ep_icc_update(pcie_ep);
+		qcom_pcie_common_icc_update(pci, pcie_ep->icc_mem);
 		pci_epc_bme_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ce2a3bd932b..71f011daad1d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -32,6 +32,7 @@
 #include <linux/types.h>
 
 #include "../../pci.h"
+#include "pcie-qcom-common.h"
 #include "pcie-designware.h"
 
 /* PARF registers */
@@ -147,9 +148,6 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
-#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
-		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
-
 #define QCOM_PCIE_1_0_0_MAX_CLOCKS		4
 struct qcom_pcie_resources_1_0_0 {
 	struct clk_bulk_data clks[QCOM_PCIE_1_0_0_MAX_CLOCKS];
@@ -1363,59 +1361,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
 	.start_link = qcom_pcie_start_link,
 };
 
-static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-	int ret;
-
-	pcie->icc_mem = devm_of_icc_get(pci->dev, "pcie-mem");
-	if (IS_ERR(pcie->icc_mem))
-		return PTR_ERR(pcie->icc_mem);
-
-	/*
-	 * Some Qualcomm platforms require interconnect bandwidth constraints
-	 * to be set before enabling interconnect clocks.
-	 *
-	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
-	 * for the pcie-mem path.
-	 */
-	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
-	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
-{
-	struct dw_pcie *pci = pcie->pci;
-	u32 offset, status;
-	int speed, width;
-	int ret;
-
-	if (!pcie->icc_mem)
-		return;
-
-	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
-	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
-
-	/* Only update constraints if link is up. */
-	if (!(status & PCI_EXP_LNKSTA_DLLLA))
-		return;
-
-	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
-	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
-
-	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
-	}
-}
-
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
 {
 	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
@@ -1524,7 +1469,11 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	ret = qcom_pcie_icc_init(pcie);
+	ret = qcom_pcie_common_icc_get_resource(pcie->pci, &pcie->icc_mem);
+	if (ret)
+		goto err_pm_runtime_put;
+
+	ret = qcom_pcie_common_icc_init(pcie->pci, pcie->icc_mem);
 	if (ret)
 		goto err_pm_runtime_put;
 
@@ -1546,7 +1495,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_common_icc_update(pcie->pci, pcie->icc_mem);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1613,7 +1562,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_common_icc_update(pcie->pci, pcie->icc_mem);
 
 	return 0;
 }
-- 
2.43.2


