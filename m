Return-Path: <linux-pci+bounces-8496-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BE71C901441
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 04:39:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 381F81F22066
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 02:39:47 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0F51563AE;
	Sun,  9 Jun 2024 02:39:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JXXUxu+j"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5D62417545;
	Sun,  9 Jun 2024 02:39:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900776; cv=none; b=shLMFMPaTn1LntJYhOE/OpHodgV2o2IUeTiB8H8QGV810NWZloq4EditYEq1G6V8eo3jTZLMOSBf0PfuSXnjVsP3CpzKKTpOiYvaI1Kigm8YGigvMGbpAw7F8RCUJvCUgRscYq5glqaGn+X7LJy82hm3n/GYdyEV5tdcHMEYldI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900776; c=relaxed/simple;
	bh=eFrXmFb/Z9o3AtXGYA4wDz3H9ChjTl8r2uCrxUik/Wk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=CuX1kQAgZl+Y2lUA2SEi4UARIqLDnABoRT8/c7XlDBye7xg/VBZ9tgCd8rlbOvOyrCNh0P9D13Ef4p7Ly7ohLuXV0iFHk6rE6dO1EGa7eCt9gS7tgIyf3R4/WUYDfszN3pyV/t/USd0hGjzCKeoFmkOfq52F2wxqZ6ve1OGkZjs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JXXUxu+j; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4592SeiU005055;
	Sun, 9 Jun 2024 02:38:35 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	/HV5h/uPpWapD7fJ1gbc0vj5zW23q3NYvvO1YGMvW8M=; b=JXXUxu+jgVZOdFyK
	GnD+8oUirqNTzK8IdIJNJyuGir9g2tm8yPsi+lrb/wppKNNXc1U9qrCW/LjNg5Jj
	4CQXemSQO1l/ASjjRvZze41GPoMUcu9BBivRsyEdgmM4iDLDyzLOGGcK7NjXMBry
	CyOAP5FrQlP7PONe3OU/DsatHfVs1QP1nVVzU8PhgnC12rkk5wzUbNEGPjSbaIV6
	eqfbqmxDLrLRyGky2XIE9Y7Y8Sj/8kw3ApgY0ijBOTptF3ej+TtNJ69GRRVN3ogY
	TvR+dC9CYxP3UyseES5XbJUYVtaI4eAL+D03XROHx9ApnJX7SBV7NoCAKky6ovWP
	zgT83g==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymemgh7k9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 02:38:35 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4592cXUS002321
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 02:38:33 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 19:38:26 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 9 Jun 2024 08:08:15 +0530
Subject: [PATCH v14 1/4] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240609-opp_support-v14-1-801cff862b5a@quicinc.com>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com>
In-Reply-To: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_krichai@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717900699; l=4515;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=eFrXmFb/Z9o3AtXGYA4wDz3H9ChjTl8r2uCrxUik/Wk=;
 b=A82RT4L/R4ywRpBG9dLK4gB6DaeDB2bVoXdzQy/yiY2HWP7vRnEXoseCLZ2wkyrkCcAaiuwRo
 yeeFio6ke4+Ay+q6zozC6DYUFHINej9mue9F+RtFOvc4AgHQKm3VqqJ
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: SM-UdvgblO8A-_6XfQ7dMbLRwH29_H0I
X-Proofpoint-ORIG-GUID: SM-UdvgblO8A-_6XfQ7dMbLRwH29_H0I
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406090019

To access the host controller registers of the host controller and the
endpoint BAR/config space, the CPU-PCIe ICC (interconnect) path should
be voted otherwise it may lead to NoC (Network on chip) timeout.
We are surviving because of other driver voting for this path.

As there is less access on this path compared to PCIe to mem path
add minimum vote i.e 1KBps bandwidth always which is sufficient enough
to keep the path active and is recommended by HW team.

During S2RAM (Suspend-to-RAM), the DBI access can happen very late (while
disabling the boot CPU). So do not disable the CPU-PCIe interconnect path
during S2RAM as that may lead to NoC error.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 45 +++++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 5f9f0ff19baa..ff1d891c8b9a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -253,6 +253,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
+	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
@@ -1369,6 +1370,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	if (IS_ERR(pcie->icc_mem))
 		return PTR_ERR(pcie->icc_mem);
 
+	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
+	if (IS_ERR(pcie->icc_cpu))
+		return PTR_ERR(pcie->icc_cpu);
 	/*
 	 * Some Qualcomm platforms require interconnect bandwidth constraints
 	 * to be set before enabling interconnect clocks.
@@ -1378,11 +1382,25 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
 			ret);
 		return ret;
 	}
 
+	/*
+	 * Since the CPU-PCIe path is only used for activities like register
+	 * access of the host controller and endpoint Config/BAR space access,
+	 * HW team has recommended to use a minimal bandwidth of 1KBps just to
+	 * keep the path active.
+	 */
+	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
+	if (ret) {
+		dev_err(pci->dev, "Failed to set bandwidth for CPU-PCIe interconnect path: %d\n",
+			ret);
+		icc_set_bw(pcie->icc_mem, 0, 0);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1408,7 +1426,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 
 	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
 			ret);
 	}
 }
@@ -1570,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n", ret);
 		return ret;
 	}
 
@@ -1594,7 +1612,18 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
-	return 0;
+	/*
+	 * Only disable CPU-PCIe interconnect path if the suspend is non-S2RAM.
+	 * Because on some platforms, DBI access can happen very late during the
+	 * S2RAM and a non-active CPU-PCIe interconnect path may lead to NoC
+	 * error.
+	 */
+	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+		ret = icc_disable(pcie->icc_cpu);
+		if (ret)
+			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
+	}
+	return ret;
 }
 
 static int qcom_pcie_resume_noirq(struct device *dev)
@@ -1602,6 +1631,14 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+		ret = icc_enable(pcie->icc_cpu);
+		if (ret) {
+			dev_err(dev, "Failed to enable CPU-PCIe interconnect path: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (pcie->suspended) {
 		ret = qcom_pcie_host_init(&pcie->pci->pp);
 		if (ret)

-- 
2.42.0


