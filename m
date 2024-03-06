Return-Path: <linux-pci+bounces-4575-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DFD873766
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 14:11:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id AEEDB1F2315E
	for <lists+linux-pci@lfdr.de>; Wed,  6 Mar 2024 13:11:58 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1D3CD130ADC;
	Wed,  6 Mar 2024 13:11:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="bWTSpxsS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6952E130E54;
	Wed,  6 Mar 2024 13:11:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709730692; cv=none; b=q2RLRyWLAh/JQBCuzAYt12ToE/EKbqqJZpVSyqFMSwN1Vt6p18wo87hnrLbYfOngVO1B5ebUSbZH2+mlDEj+uy8h1HgUslcgDBraCREgt4Avjvqo29uAzHLHPF+Z06QT6nSoyg4j0K0Cv6flnT3FGt8SJVdIOQY4ar5ZEdNgLmQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709730692; c=relaxed/simple;
	bh=/X3/JKzMWlTemy1Vbz83/hKangDvy5EDL2t/NGy1YxI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=Qb/0reWiQUerSDC2bfGhuHaR+FYQtt9AgPc1HpeDmmmpgtrgB5JMu9Co092Ktwb9H5K9yZ6/g2zKpZ1FVEaPtxy28nmiLTTO+PLCKgDY7fzS5e4383a8ZrlB2/0juU58YKT3iZhr+jPJQR/W5f4rjQA1EnwQPS+v6XKaEOSI13I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=bWTSpxsS; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 426Bc7F0029553;
	Wed, 6 Mar 2024 13:11:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=qUWpvWyp2prKwh79gJUFUL/RZtS8UtJQSbcBUv+GZIQ=; b=bW
	TSpxsS8MGzhDbd8YDScsjUcPfIMyb9UyysUuQXxKPbefJ09MX8im67wZdmjpuOQt
	lFNGexzjqbECgEl3AJQZCT1FXJ9obpzvubYBP8u/GicsX9M57nwQVNK3DliEBZfz
	LJCSCrpTJAokC+eoKzMp/Z7uOKDqwBHw2fCCY72YNoNMY8pADD7w/oS5w15u54ma
	bL7gGEZZPJZ/mbsuJEsZRvtW+hNKtrtRd3gcsUFzRxjb6jK1ZqkREPzc+20yh6Pf
	DNgYQ0MiJDZilZhepmzirUyDA/AiyaleORvcohN5tqA+T29cXTGjDbL/QZvxqHow
	cngku/NYRSVTBsiv+nRQ==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wpm4v8n5f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Mar 2024 13:11:21 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 426DBId6019095;
	Wed, 6 Mar 2024 13:11:18 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3wp0608qkm-1;
	Wed, 06 Mar 2024 13:11:18 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 426DBHxB019086;
	Wed, 6 Mar 2024 13:11:18 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 426DBHkp019082;
	Wed, 06 Mar 2024 13:11:17 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id ABC0126B8; Wed,  6 Mar 2024 18:41:16 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org, robh@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v6 1/3] PCI: qcom: Override NO_SNOOP attribute for SA8775P RC
Date: Wed,  6 Mar 2024 18:41:10 +0530
Message-Id: <1709730673-6699-2-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
References: <1709730673-6699-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: JK4A69jvhoD70I25N4Y3f3DyZJ2dbrq4
X-Proofpoint-GUID: JK4A69jvhoD70I25N4Y3f3DyZJ2dbrq4
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-06_08,2024-03-05_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 adultscore=0
 lowpriorityscore=0 suspectscore=0 clxscore=1015 priorityscore=1501
 spamscore=0 impostorscore=0 mlxlogscore=999 phishscore=0 bulkscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403060105
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Due to some hardware changes, SA8775P has set the NO_SNOOP attribute
in its TLP for all the PCIe controllers. NO_SNOOP attribute when set,
the requester is indicating that no cache coherency issue exist for
the addressed memory on the endpoint i.e., memory is not cached. But
in reality, requester cannot assume this unless there is a complete
control/visibility over the addressed memory on the endpoint.

And worst case, if the memory is cached on the endpoint, it may lead to
memory corruption issues. It should be noted that the caching of memory
on the endpoint is not solely dependent on the NO_SNOOP attribute in TLP.

So to avoid the corruption, this patch overrides the NO_SNOOP attribute
by setting the PCIE_PARF_NO_SNOOP_OVERIDE register. This patch is not
needed for other upstream supported platforms since they do not set
NO_SNOOP attribute by default.

8775 has IP version 1.34.0 so introduce a new cfg(cfg_1_34_0) for this
platform. Assign override_no_snoop flag into struct qcom_pcie_cfg and
set it true in cfg_1_34_0 and enable cache snooping if this particular
flag is true.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 2ce2a3b..d4c1e69 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -51,6 +51,7 @@
 #define PARF_SID_OFFSET				0x234
 #define PARF_BDF_TRANSLATE_CFG			0x24c
 #define PARF_SLV_ADDR_SPACE_SIZE		0x358
+#define PARF_NO_SNOOP_OVERIDE			0x3d4
 #define PARF_DEVICE_TYPE			0x1000
 #define PARF_BDF_TO_SID_TABLE_N			0x2000
 
@@ -117,6 +118,10 @@
 /* PARF_LTSSM register fields */
 #define LTSSM_EN				BIT(8)
 
+/* PARF_NO_SNOOP_OVERIDE register fields */
+#define WR_NO_SNOOP_OVERIDE_EN			BIT(1)
+#define RD_NO_SNOOP_OVERIDE_EN			BIT(3)
+
 /* PARF_DEVICE_TYPE register fields */
 #define DEVICE_TYPE_RC				0x4
 
@@ -227,8 +232,14 @@ struct qcom_pcie_ops {
 	int (*config_sid)(struct qcom_pcie *pcie);
 };
 
+ /**
+  * struct qcom_pcie_cfg - Per SoC config struct
+  * @ops: qcom pcie ops structure
+  * @override_no_snoop: Override NO_SNOOP attribute in TLP to enable cache snooping
+  */
 struct qcom_pcie_cfg {
 	const struct qcom_pcie_ops *ops;
+	bool override_no_snoop;
 };
 
 struct qcom_pcie {
@@ -961,6 +972,13 @@ static int qcom_pcie_init_2_7_0(struct qcom_pcie *pcie)
 
 static int qcom_pcie_post_init_2_7_0(struct qcom_pcie *pcie)
 {
+	const struct qcom_pcie_cfg *pcie_cfg = pcie->cfg;
+
+	/* Override NO_SNOOP attribute in TLP to enable cache snooping */
+	if (pcie_cfg->override_no_snoop)
+		writel(WR_NO_SNOOP_OVERIDE_EN | RD_NO_SNOOP_OVERIDE_EN,
+				pcie->parf + PARF_NO_SNOOP_OVERIDE);
+
 	qcom_pcie_clear_hpc(pcie->pci);
 
 	return 0;
@@ -1334,6 +1352,11 @@ static const struct qcom_pcie_cfg cfg_1_9_0 = {
 	.ops = &ops_1_9_0,
 };
 
+static const struct qcom_pcie_cfg cfg_1_34_0 = {
+	.ops = &ops_1_9_0,
+	.override_no_snoop = true,
+};
+
 static const struct qcom_pcie_cfg cfg_2_1_0 = {
 	.ops = &ops_2_1_0,
 };
@@ -1630,7 +1653,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_9_0},
+	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8180x", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sc8280xp", .data = &cfg_1_9_0 },
-- 
2.7.4


