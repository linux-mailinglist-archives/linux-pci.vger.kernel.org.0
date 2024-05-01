Return-Path: <linux-pci+bounces-6967-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 1F9558B8E51
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 18:37:39 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C99F9282D62
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 16:37:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 88696DF49;
	Wed,  1 May 2024 16:37:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kAQ3yZw8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E011B1B59A;
	Wed,  1 May 2024 16:37:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581427; cv=none; b=a5wlrYCXDpUm9CLVyQeWoPLF8j6G+7TTMWfnSf8F2KUyg97X4KWoULH2wg6pDQXSzKLu8ipq+AaLQAGR/tEIdWVioXZKiwJDJnY0QoFm+UIZBPehnOdH2XnW/Y0TAP5t5JUhDqoqgcREJ3YHiVQDRhZAEMT/t7zpfLi0lFkKPvg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581427; c=relaxed/simple;
	bh=yF8dPiRP5cP3fXnEcgflGw4Fpd7IDI6fSilI+0JEMiA=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WXGS1JgILLoIhPX6RKSZ5CkKuTClcbMHUOFse2sEWHjJ5rYBvrBXBTuVAHEbqxoFt1Iqw0d+0zY8NHf+a9yv4lEw7zwlo56wMPmfqn4f7QeE13mnuaKQinA2i+JOrNrNsTcITRGtGlzrZp8IAEGV0rTZ4A8rUCYh781SPFG771s=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kAQ3yZw8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 441ER7qG027190;
	Wed, 1 May 2024 16:36:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references
	:mime-version:content-transfer-encoding:content-type; s=
	qcppdkim1; bh=cXaenI9+leuO7eYu3ig6KGqchQBjeXNHDhPjF3tdXJQ=; b=kA
	Q3yZw8Ail239tgk1adip42HBjJ18Yx0+3KTXEuDX3YT20eppV7Mkyvy/pLrDG+ox
	f3WjdNYBmvyl0KahWqb/UoRkLzIT91+0RSmcbcwXekEi9DZ2J+SFuPwPWkCGoVKJ
	FKGUr5upKsEWItYjyuujYmUFruwLL2z+fAkzVnboP1AbY87ld6F8nZ25kWKfVEg3
	ZRvwwdcg65rFqY5Mwy/tYIy+kxFneOvb/pfetBIKIpzeEYTe+zgX5dNQvzfhdzuW
	xAVlmnB1UjBPOxzOLhIqe/MWm3E9LpvZWhRT23xUbZsl04uH7erxMZdwbKrg055P
	EQHqnbrn3jAWXJ+rMOAQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xup5krfs7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 16:36:48 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 441Gal6d023532
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 16:36:47 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 09:36:46 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <manivannan.sadhasivam@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>, <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v4 3/3] PCI: qcom: Add RX margining settings for 16 GT/s
Date: Wed, 1 May 2024 09:35:34 -0700
Message-ID: <20240501163610.8900-4-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
In-Reply-To: <20240501163610.8900-1-quic_schintav@quicinc.com>
References: <20240501163610.8900-1-quic_schintav@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 6pESSpz_z8xm8orijpm67aKzyVuUv5bZ
X-Proofpoint-GUID: 6pESSpz_z8xm8orijpm67aKzyVuUv5bZ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 phishscore=0
 priorityscore=1501 suspectscore=0 adultscore=0 clxscore=1015
 impostorscore=0 spamscore=0 mlxlogscore=930 lowpriorityscore=0 bulkscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2405010117

Add RX lane margining settings for 16 GT/s(GEN 4) data rate. These
settings improve link stability while operating at high date rates
and helps to improve signal quality.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 18 +++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 31 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 ++-
 drivers/pci/controller/dwc/pcie-qcom.c        |  4 ++-
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index ed0045043847..343450c04e05 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -203,6 +203,24 @@
 
 #define PCIE_PL_CHK_REG_ERR_ADDR			0xB28
 
+/*
+ * 16 GT/s (GEN4) lane margining register definitions
+ */
+#define GEN4_LANE_MARGINING_1_OFF		0xb80
+#define MARGINING_MAX_VOLTAGE_OFFSET		GENMASK(29, 24)
+#define MARGINING_NUM_VOLTAGE_STEPS		GENMASK(22, 16)
+#define MARGINING_MAX_TIMING_OFFSET		GENMASK(13, 8)
+#define MARGINING_NUM_TIMING_STEPS		GENMASK(5, 0)
+
+#define GEN4_LANE_MARGINING_2_OFF		0xb84
+#define MARGINING_IND_ERROR_SAMPLER		BIT(28)
+#define MARGINING_SAMPLE_REPORTING_METHOD	BIT(27)
+#define MARGINING_IND_LEFT_RIGHT_TIMING		BIT(26)
+#define MARGINING_IND_UP_DOWN_VOLTAGE		BIT(25)
+#define MARGINING_VOLTAGE_SUPPORTED		BIT(24)
+#define MARGINING_MAXLANES			GENMASK(20, 16)
+#define MARGINING_SAMPLE_RATE_TIMING		GENMASK(13, 8)
+#define MARGINING_SAMPLE_RATE_VOLTAGE		GENMASK(5, 0)
 /*
  * iATU Unroll-specific register definitions
  * From 4.80 core version the address translation will be made by unroll
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.c b/drivers/pci/controller/dwc/pcie-qcom-common.c
index 16c277b2e9d4..fe6f7dde5d8c 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -53,6 +53,37 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
 }
 EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_eq_settings);
 
+void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci)
+{
+	u32 reg;
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_1_OFF);
+	reg &= ~(MARGINING_MAX_VOLTAGE_OFFSET |
+		MARGINING_NUM_VOLTAGE_STEPS |
+		MARGINING_MAX_TIMING_OFFSET |
+		MARGINING_NUM_TIMING_STEPS);
+	reg |= FIELD_PREP(MARGINING_MAX_VOLTAGE_OFFSET, 0x24) |
+		FIELD_PREP(MARGINING_NUM_VOLTAGE_STEPS, 0x78) |
+		FIELD_PREP(MARGINING_MAX_TIMING_OFFSET, 0x32) |
+		FIELD_PREP(MARGINING_NUM_TIMING_STEPS, 0x10);
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_1_OFF, reg);
+
+	reg = dw_pcie_readl_dbi(pci, GEN4_LANE_MARGINING_2_OFF);
+	reg |= MARGINING_IND_ERROR_SAMPLER |
+		MARGINING_SAMPLE_REPORTING_METHOD |
+		MARGINING_IND_LEFT_RIGHT_TIMING |
+		MARGINING_VOLTAGE_SUPPORTED;
+	reg &= ~(MARGINING_IND_UP_DOWN_VOLTAGE |
+		MARGINING_MAXLANES |
+		MARGINING_SAMPLE_RATE_TIMING |
+		MARGINING_SAMPLE_RATE_VOLTAGE);
+	reg |= FIELD_PREP(MARGINING_MAXLANES, pci->num_lanes) |
+		FIELD_PREP(MARGINING_SAMPLE_RATE_TIMING, 0x3f) |
+		FIELD_PREP(MARGINING_SAMPLE_RATE_VOLTAGE, 0x3f);
+	dw_pcie_writel_dbi(pci, GEN4_LANE_MARGINING_2_OFF, reg);
+}
+EXPORT_SYMBOL_GPL(qcom_pcie_common_set_16gt_rx_margining_settings);
+
 struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const char *path)
 {
 	struct icc_path *icc_mem_p;
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index 5c01f6c18b3b..c7eb87aa0677 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -11,3 +11,4 @@ struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const ch
 int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
+void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 7940222d35f6..2aea78da9c5b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -438,8 +438,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
 		goto err_disable_resources;
 	}
 
-	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_eq_settings(pci);
+		qcom_pcie_common_set_16gt_rx_margining_settings(pci);
+	}
 
 	/*
 	 * The physical address of the MMIO region which is exposed as the BAR
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 525942f2cf98..9b3d7729b34b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -263,8 +263,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
 {
 	struct qcom_pcie *pcie = to_qcom_pcie(pci);
 
-	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT)
+	if (pcie_link_speed[pci->link_gen] == PCIE_SPEED_16_0GT) {
 		qcom_pcie_common_set_16gt_eq_settings(pci);
+		qcom_pcie_common_set_16gt_rx_margining_settings(pci);
+	}
 
 	/* Enable Link Training state machine */
 	if (pcie->cfg->ops->ltssm_enable)
-- 
2.43.2


