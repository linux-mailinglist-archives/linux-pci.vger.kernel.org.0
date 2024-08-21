Return-Path: <linux-pci+bounces-11969-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B6CC95A38F
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:10:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 12895281F33
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:10:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7272D1B2516;
	Wed, 21 Aug 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="UA5WQJL2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43A8316A95A;
	Wed, 21 Aug 2024 17:10:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260206; cv=none; b=VMVFqR+90e5XIC6poH8ALmjh1itHJy9gyfrEl8R6cOVA13q4exWvi0FHYXcZJwb6KAuRlHwYlGfEh4B6RoRZi2vFiqAu9aunEUUOj76iQ6HJpFN9nDwHqpJjeGFDew6Rh9UF5GoJDIUoaylj8eudQYOp/PgtLlH6fupUf8l1+Ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260206; c=relaxed/simple;
	bh=xy2kJkRsk81Cn0f5OaaQgXgvsUPVgfObvRuXIenV4og=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=s67fzKndqQJlJ/TGMoy2V8bLA64HEwXpw7OsJ/UgXQWx3q+1gUcMCCf/5kNM+/wEy50C397zkMx5HeZ74Zl0jcBdP+0agFZJIQZbTSCJV1/lvZPYvf1c6ysINECYi3LtKwdAjbo8cuBI52kroQQF5auIvWLgOSq4wMOoHpRzpHY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=UA5WQJL2; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LBtRgl004730;
	Wed, 21 Aug 2024 17:09:52 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/7Zft9nKP/nsDMu1aSvzKdwITUzhb/6T84WFgnOR1b8=; b=UA5WQJL2YD+199y/
	SFlyA4kmFibtT3xQX0PmOMadlbTe8WpmwBWWM/9wlIOU73xKJl4OIR3mZ7Rlot59
	HbmLvVLnRFlsZDs73oqgaekiW99vVqIHy9ig8aBh+GBE6pT+wetIQb8My62zr9xy
	0U9TUYbtrF3UViNFN6F6AtV2K8/ssxjHi4nYO4w9/y5+cAd4LuWeN1gBTOoJ9GYq
	dV72D3o2oqsl64PJQ1vMEyuQ/mVOdUjNEOj8RFj3PQERzJAG8LfFh+QbgH02DwzZ
	1nqcs6/eimmBkFx/iXQs9cu+OnzadK3WvoVfAFmHA8x8gDJ+vfmaWn1HK1lLvTCr
	b/WB1Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414v5cc981-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:09:51 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LH9p3H001837
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:09:51 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 Aug 2024 10:09:50 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo
 Han <jingoohan1@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Niklas Cassel <cassel@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v5 1/3] PCI: qcom: Refactor common code
Date: Wed, 21 Aug 2024 10:08:42 -0700
Message-ID: <20240821170917.21018-2-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.46.0
In-Reply-To: <20240821170917.21018-1-quic_schintav@quicinc.com>
References: <20240821170917.21018-1-quic_schintav@quicinc.com>
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
X-Proofpoint-GUID: n0LHcqpHh-mFlGDkY9Lau6KvRNuzdwL0
X-Proofpoint-ORIG-GUID: n0LHcqpHh-mFlGDkY9Lau6KvRNuzdwL0
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 spamscore=0 adultscore=0 lowpriorityscore=0 bulkscore=0 impostorscore=0
 phishscore=0 priorityscore=1501 clxscore=1015 malwarescore=0
 mlxlogscore=999 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210124

Refactor common code from RC(Root Complex) and EP(End Point)
drivers and move them to a common driver. This acts as placeholder
for common source code for both drivers, thus avoiding duplication.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 MAINTAINERS                                   |   3 +
 drivers/pci/controller/dwc/Kconfig            |   5 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-qcom-common.c |  88 +++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  15 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  39 +----
 drivers/pci/controller/dwc/pcie-qcom.c        | 141 ++++++------------
 7 files changed, 161 insertions(+), 131 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h

diff --git a/MAINTAINERS b/MAINTAINERS
index c0a62489be56..ef3e62677e9f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -2785,6 +2785,7 @@ F:	drivers/iommu/msm*
 F:	drivers/mfd/ssbi.c
 F:	drivers/mmc/host/mmci_qcom*
 F:	drivers/mmc/host/sdhci-msm.c
+F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom.c
 F:	drivers/phy/qualcomm/
 F:	drivers/power/*/msm*
@@ -17844,6 +17845,7 @@ M:	Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
 L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
+F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom.c
 
 PCIE DRIVER FOR ROCKCHIP
@@ -17880,6 +17882,7 @@ L:	linux-pci@vger.kernel.org
 L:	linux-arm-msm@vger.kernel.org
 S:	Maintained
 F:	Documentation/devicetree/bindings/pci/qcom,pcie-ep.yaml
+F:	drivers/pci/controller/dwc/pcie-qcom-common.c
 F:	drivers/pci/controller/dwc/pcie-qcom-ep.c
 
 PCMCIA SUBSYSTEM
diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
index 4c38181acffa..b6d6778b0698 100644
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
index ec215b3d6191..82e51ba11031 100644
--- a/drivers/pci/controller/dwc/Makefile
+++ b/drivers/pci/controller/dwc/Makefile
@@ -14,6 +14,7 @@ obj-$(CONFIG_PCI_LAYERSCAPE) += pci-layerscape.o
 obj-$(CONFIG_PCI_LAYERSCAPE_EP) += pci-layerscape-ep.o
 obj-$(CONFIG_PCIE_QCOM) += pcie-qcom.o
 obj-$(CONFIG_PCIE_QCOM_EP) += pcie-qcom-ep.o
+obj-$(CONFIG_PCIE_QCOM_COMMON) += pcie-qcom-common.o
 obj-$(CONFIG_PCIE_ARMADA_8K) += pcie-armada8k.o
 obj-$(CONFIG_PCIE_ARTPEC6) += pcie-artpec6.o
 obj-$(CONFIG_PCIE_ROCKCHIP_DW) += pcie-dw-rockchip.o
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
new file mode 100644
index 000000000000..1d8992147bba
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -0,0 +1,88 @@
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
+#include <linux/pm_opp.h>
+#include <linux/units.h>
+
+#include "../../pci.h"
+#include "pcie-designware.h"
+#include "pcie-qcom-common.h"
+
+struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
+{
+	struct icc_path *icc_p;
+
+	icc_p = devm_of_icc_get(pci->dev, path);
+	return icc_p;
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_get_resource);
+
+int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc, u32 bandwidth)
+{
+	int ret;
+
+	ret = icc_set_bw(icc, 0, bandwidth);
+	if (ret) {
+		dev_err(pci->dev, "Failed to set interconnect bandwidth: %d\n",
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
+	u32 offset, status, width, speed;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	int ret, freq_mbps;
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
+	if (icc_mem) {
+		ret = icc_set_bw(icc_mem, 0,
+				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+				ret);
+		}
+	} else {
+		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
+		if (freq_mbps < 0)
+			return;
+
+		freq_kbps = freq_mbps * KILO;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
+						 true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
+					freq_kbps * width, ret);
+			dev_pm_opp_put(opp);
+		}
+
+	}
+
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_icc_update);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
new file mode 100644
index 000000000000..897fa18e618a
--- /dev/null
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2014-2015, 2020 The Linux Foundation. All rights reserved.
+ * Copyright (c) 2015, 2021 Linaro Limited.
+ * Copyright (c) 2024 Qualcomm Innovation Center, Inc. All rights reserved.
+ */
+
+#include "pcie-designware.h"
+
+#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
+		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
+
+struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path);
+int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
+void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..e1860026e134 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -25,6 +25,7 @@
 
 #include "../../pci.h"
 #include "pcie-designware.h"
+#include "pcie-qcom-common.h"
 
 /* PARF registers */
 #define PARF_SYS_CTRL				0x00
@@ -142,9 +143,6 @@
 #define CORE_RESET_TIME_US_MAX			1005
 #define WAKE_DELAY_US				2000 /* 2 ms */
 
-#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
-		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
-
 #define to_pcie_ep(x)				dev_get_drvdata((x)->dev)
 
 enum qcom_pcie_ep_link_status {
@@ -295,28 +293,6 @@ static void qcom_pcie_dw_write_dbi2(struct dw_pcie *pci, void __iomem *base,
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
@@ -342,14 +318,7 @@ static int qcom_pcie_enable_resources(struct qcom_pcie_ep *pcie_ep)
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
@@ -633,7 +602,7 @@ static int qcom_pcie_ep_get_resources(struct platform_device *pdev,
 	if (IS_ERR(pcie_ep->phy))
 		ret = PTR_ERR(pcie_ep->phy);
 
-	pcie_ep->icc_mem = devm_of_icc_get(dev, "pcie-mem");
+	pcie_ep->icc_mem = qcom_pcie_common_icc_get_resource(&pcie_ep->pci, "pcie-mem");
 	if (IS_ERR(pcie_ep->icc_mem))
 		ret = PTR_ERR(pcie_ep->icc_mem);
 
@@ -660,7 +629,7 @@ static irqreturn_t qcom_pcie_ep_global_irq_thread(int irq, void *data)
 	} else if (FIELD_GET(PARF_INT_ALL_BME, status)) {
 		dev_dbg(dev, "Received Bus Master Enable event\n");
 		pcie_ep->link_status = QCOM_PCIE_EP_LINK_ENABLED;
-		qcom_pcie_ep_icc_update(pcie_ep);
+		qcom_pcie_common_icc_update(pci, pcie_ep->icc_mem);
 		pci_epc_bus_master_enable_notify(pci->ep.epc);
 	} else if (FIELD_GET(PARF_INT_ALL_PM_TURNOFF, status)) {
 		dev_dbg(dev, "Received PM Turn-off event! Entering L23\n");
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 0180edf3310e..ee32590f1506 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -31,9 +31,9 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
-#include <linux/units.h>
 
 #include "../../pci.h"
+#include "pcie-qcom-common.h"
 #include "pcie-designware.h"
 
 /* PARF registers */
@@ -158,9 +158,6 @@
 
 #define QCOM_PCIE_CRC8_POLYNOMIAL		(BIT(2) | BIT(1) | BIT(0))
 
-#define QCOM_PCIE_LINK_SPEED_TO_BW(speed) \
-		Mbps_to_icc(PCIE_SPEED2MBS_ENC(pcie_link_speed[speed]))
-
 struct qcom_pcie_resources_1_0_0 {
 	struct clk_bulk_data *clks;
 	int num_clks;
@@ -1365,92 +1362,6 @@ static const struct dw_pcie_ops dw_pcie_ops = {
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
-	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
-	if (IS_ERR(pcie->icc_cpu))
-		return PTR_ERR(pcie->icc_cpu);
-	/*
-	 * Some Qualcomm platforms require interconnect bandwidth constraints
-	 * to be set before enabling interconnect clocks.
-	 *
-	 * Set an initial peak bandwidth corresponding to single-lane Gen 1
-	 * for the pcie-mem path.
-	 */
-	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
-	if (ret) {
-		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
-			ret);
-		return ret;
-	}
-
-	/*
-	 * Since the CPU-PCIe path is only used for activities like register
-	 * access of the host controller and endpoint Config/BAR space access,
-	 * HW team has recommended to use a minimal bandwidth of 1KBps just to
-	 * keep the path active.
-	 */
-	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
-	if (ret) {
-		dev_err(pci->dev, "Failed to set bandwidth for CPU-PCIe interconnect path: %d\n",
-			ret);
-		icc_set_bw(pcie->icc_mem, 0, 0);
-		return ret;
-	}
-
-	return 0;
-}
-
-static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
-{
-	u32 offset, status, width, speed;
-	struct dw_pcie *pci = pcie->pci;
-	unsigned long freq_kbps;
-	struct dev_pm_opp *opp;
-	int ret, freq_mbps;
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
-	if (pcie->icc_mem) {
-		ret = icc_set_bw(pcie->icc_mem, 0,
-				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-		if (ret) {
-			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
-				ret);
-		}
-	} else {
-		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
-		if (freq_mbps < 0)
-			return;
-
-		freq_kbps = freq_mbps * KILO;
-		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width,
-						 true);
-		if (!IS_ERR(opp)) {
-			ret = dev_pm_opp_set_opp(pci->dev, opp);
-			if (ret)
-				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
-					freq_kbps * width, ret);
-			dev_pm_opp_put(opp);
-		}
-	}
-}
-
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
 {
 	struct qcom_pcie *pcie = (struct qcom_pcie *)dev_get_drvdata(s->private);
@@ -1561,6 +1472,18 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
+	pcie->icc_mem = qcom_pcie_common_icc_get_resource(pcie->pci, "pcie-mem");
+	if (IS_ERR_OR_NULL(pcie->icc_mem)) {
+		ret = PTR_ERR(pcie->icc_mem);
+		goto err_pm_runtime_put;
+	}
+
+	pcie->icc_cpu = qcom_pcie_common_icc_get_resource(pcie->pci, "cpu-pcie");
+	if (IS_ERR_OR_NULL(pcie->icc_cpu)) {
+		ret = PTR_ERR(pcie->icc_cpu);
+		goto err_pm_runtime_put;
+	}
+
 	/* OPP table is optional */
 	ret = devm_pm_opp_of_add_table(dev);
 	if (ret && ret != -ENODEV) {
@@ -1593,10 +1516,35 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 			goto err_pm_runtime_put;
 		}
 	} else {
-		/* Skip ICC init if OPP is supported as it is handled by OPP */
-		ret = qcom_pcie_icc_init(pcie);
-		if (ret)
+		/*
+		 * Some Qualcomm platforms require interconnect bandwidth
+		 * constraints to be set before enabling interconnect clocks
+		 * Set an initial peak bandwidth corresponding to single-lane
+		 * Gen 1 for the pcie-mem path.
+		 */
+		ret = qcom_pcie_common_icc_init(pcie->pci, pcie->icc_mem,
+					QCOM_PCIE_LINK_SPEED_TO_BW(1));
+		if (ret) {
+			dev_err(pci->dev,
+			"Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+			ret);
 			goto err_pm_runtime_put;
+		}
+
+		/*
+		 * Since the CPU-PCIe path is only used for activities
+		 * like register access of the host controller and
+		 * endpoint Config/BAR space access, HW team has
+		 * recommended to use a minimal bandwidth of 1KBps just to
+		 * keep the path active.
+		 */
+		ret = qcom_pcie_common_icc_init(pcie->pci, pcie->icc_cpu, kBps_to_icc(1));
+		if (ret) {
+			dev_err(pci->dev,
+			"Failed to set bandwidth for CPU-PCIe interconnect path: %d\n",
+			ret);
+			goto err_pm_runtime_put;
+		}
 	}
 
 	ret = pcie->cfg->ops->get_resources(pcie);
@@ -1617,7 +1565,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_opp_update(pcie);
+	qcom_pcie_common_icc_update(pcie->pci, pcie->icc_mem);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1681,7 +1629,8 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
 		ret = icc_disable(pcie->icc_cpu);
 		if (ret)
-			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
+			dev_err(dev,
+			"Failed to disable CPU-PCIe interconnect path: %d\n", ret);
 
 		if (!pcie->icc_mem)
 			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
@@ -1710,7 +1659,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_opp_update(pcie);
+	qcom_pcie_common_icc_update(pcie->pci, pcie->icc_mem);
 
 	return 0;
 }
-- 
2.46.0


