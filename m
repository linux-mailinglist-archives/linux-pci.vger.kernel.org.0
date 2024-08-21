Return-Path: <linux-pci+bounces-11972-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CF3E595A399
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:11:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4F5051F2432C
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:11:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 12B601B2ED2;
	Wed, 21 Aug 2024 17:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ifUPjVAD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 43F771B250D;
	Wed, 21 Aug 2024 17:10:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260225; cv=none; b=bsEm2wJ83K/O2P+senb01se4nTpk09oXGFC8I4d8DpOPgz+hLR6sx4zxkOOGq2IRfFgUTH2mJTTQa91Xq9yaJ/6fXK7wQac2gPTqWnZHw7BC1dc9ftGcBNxivMyuFxqJ61ANEL11EIXlM1gadPgMhp2zJPDTNlvstM+TbR0qxrI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260225; c=relaxed/simple;
	bh=g4W952WdFN30lpGjb7TrhveeZcM7mvo4dxbCOXDWdFE=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=A2/pq2dNgkPaofod4iweC+bbDwsYEBruzngkK84SJ+ajvuKTkLJnB+WMLe5brxRrdo2JVb8/W0L6KexMkDDhOFpvOrDI2Uxx6Fbs5RTyEwdOcKp8WTe1TeqdvqnMjwHtM+go+BVqExNkzeneLMz29jPBBjovvQq0muhLKcsmLn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ifUPjVAD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47LD9xS6013240;
	Wed, 21 Aug 2024 17:10:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9FtNXLFtW8feuDRP7rxJ98tYr7Mmx1CYHOKO/5KY1vI=; b=ifUPjVADzklYtn37
	UKXuhptj4BiV/oGqkhC/xc+s0bxBGlx+W4px5GsU/kOV29dmL8lAlo27VF5VJ3m8
	AgpM6GCp0aK3jtq8CxY2CcmxVIIwsV1mwpV85kRoONd2BDMFQj2iM2P/jyEatJT9
	GJqNJdfRjNOUjLY1cWmtXVigbN/i53lVXMbvFH3EM6xIYy82zvs9FOeBHyVlfSXF
	twSqHamwGxJ+phn1TQIdrGH3vyoiDUTMkxsiKLyIJkkbS6yhqhxI+d/eq7+PoopQ
	SiOovpvvb8a7i3L99Rq/QeufnGr8X1K+UQG6xNDFn8aseQLSRg97yFYaUxVe1HWA
	UB/91w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414pe5nea3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:10:06 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LHA4N0012131
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:10:04 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 Aug 2024 10:10:04 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        Niklas Cassel <cassel@kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v5 3/3] PCI: qcom: Add RX margining settings for 16 GT/s
Date: Wed, 21 Aug 2024 10:08:44 -0700
Message-ID: <20240821170917.21018-4-quic_schintav@quicinc.com>
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
X-Proofpoint-ORIG-GUID: 1Ed1t2w0Q0fogmKhtNvpHPcUMorZBlKF
X-Proofpoint-GUID: 1Ed1t2w0Q0fogmKhtNvpHPcUMorZBlKF
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 suspectscore=0
 mlxscore=0 lowpriorityscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 clxscore=1015 spamscore=0 mlxlogscore=989 phishscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210124

Add RX lane margining settings for 16 GT/s(GEN 4) data rate. These
settings improve link stability while operating at high date rates
and helps to improve signal quality.

Signed-off-by: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-designware.h  | 18 +++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 31 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  1 +
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  4 ++-
 drivers/pci/controller/dwc/pcie-qcom.c        |  4 ++-
 5 files changed, 56 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 50265a2fbb9f..3d55ddf351a8 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -209,6 +209,24 @@
 
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
index e085075557cd..3fa91cb52f5b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.c
@@ -52,6 +52,37 @@ void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci)
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
 	struct icc_path *icc_p;
diff --git a/drivers/pci/controller/dwc/pcie-qcom-common.h b/drivers/pci/controller/dwc/pcie-qcom-common.h
index c281582de12c..71ff675d6af0 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-common.h
+++ b/drivers/pci/controller/dwc/pcie-qcom-common.h
@@ -14,3 +14,4 @@ struct icc_path *qcom_pcie_common_icc_get_resource(struct dw_pcie *pci, const ch
 int qcom_pcie_common_icc_init(struct dw_pcie *pci, struct icc_path *icc_mem, u32 bandwidth);
 void qcom_pcie_common_icc_update(struct dw_pcie *pci, struct icc_path *icc_mem);
 void qcom_pcie_common_set_16gt_eq_settings(struct dw_pcie *pci);
+void qcom_pcie_common_set_16gt_rx_margining_settings(struct dw_pcie *pci);
diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 823e33a4d745..aff9ae9778a1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -455,8 +455,10 @@ static int qcom_pcie_perst_deassert(struct dw_pcie *pci)
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
index 829b34391af1..0256fb5131d7 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -280,8 +280,10 @@ static int qcom_pcie_start_link(struct dw_pcie *pci)
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
2.46.0


