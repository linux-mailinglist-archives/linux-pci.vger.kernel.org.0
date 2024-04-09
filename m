Return-Path: <linux-pci+bounces-5923-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 5463A89D6A8
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 12:17:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id BFCB41F22498
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 10:17:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 67FF612FF65;
	Tue,  9 Apr 2024 10:14:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="WWrELiyJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 010E512F582;
	Tue,  9 Apr 2024 10:14:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657643; cv=none; b=cp9eovMedcIpSB8LgInEvJ7W7vdhvg8NRqn7Sbekaov9IiNy4yfSM6L6GDMhUO7/gbDaPJwZyKSWZRlm7WpkAhEM2uf+BujGPsVWuha/WAhDYhKd3S+5RUTdKALtLSEFylskksTPe6M5z82npW8UPOSBiZMzbudtrtJDUDSKLXg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657643; c=relaxed/simple;
	bh=doTlu9hJMteNLLn17emxRLL3Aqbs4pHtWminEV2S2ag=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TNXWphNy/59gn9oDH0Gb0D1QbflhCbHaFWS1yHxtDmYtB+6W9uvn5SHdSBGRJE85LZDVxywmSbalZ0u7kwoy5UbS0ZI2hII69K73h9DJGGS/GGKmroW1HR/p/bWRGmnFnz/WkIZQ+Yk802MVuCKPtfcDmAG3ub9aO6H2p0jRZYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=WWrELiyJ; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4399gwqb008002;
	Tue, 9 Apr 2024 10:13:50 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=pIXUiWeNABMgCXpXoHnncdRYT8+KmyyXAwxmQPprqWg
	=; b=WWrELiyJJrcqT6zHZpgtlldZtYHAwUwmHnM29VMHQ9n5gz1UxwdW4psin5T
	xsD8VHjE8X0BwW+2UbbqiklmkZs4xORzcVGH7EEOMjtkQEIjw/4v++bu7kXv9p32
	BfrHWaLyRXJdrCf5c/WzP6MD0bEJR2T9S/7VLf8TBs0f3c8fBkNlYs6zRAHtKTm4
	EVCVyfFprG2ZKH4Cx2O2Wtsvb4Z7INnQo5eIIuFOeWsQzQ9cZW3KZIr6tG45Jt/E
	ABf4Ni72iKDrqInItIMfJAHeU5qI155u9YWRZqcPDgPXRgtpnAyvHPDuSf8PKwdn
	3skytk37hTRhzmtG+qSOClX23Nw==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd39q01vj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 10:13:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439ADmw0007891
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 10:13:48 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 03:13:42 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 9 Apr 2024 15:43:20 +0530
Subject: [PATCH v10 2/6] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240409-opp_support-v10-2-1956e6be343f@quicinc.com>
References: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
In-Reply-To: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
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
        <bmasney@redhat.com>, <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_krichai@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>,
        Bryan O'Donoghue
	<bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712657607; l=4274;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=doTlu9hJMteNLLn17emxRLL3Aqbs4pHtWminEV2S2ag=;
 b=SmcBuYldTtRAJDZKGewM+TS45NYrvTlAVdCZCEYOOiMs8Zjxw3law3lbq2zK9fx+rP81VQPFM
 BKFHUGLIuR8AWzwBG0wG6hcLcT9jcb2hlulBGnJPPvqPEVGT7LFSv2M
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: p3eq3Doj3zHHHrpN6RhXx-P8wVgSiEck
X-Proofpoint-ORIG-GUID: p3eq3Doj3zHHHrpN6RhXx-P8wVgSiEck
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_06,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 priorityscore=1501 mlxscore=0 mlxlogscore=999 clxscore=1015
 impostorscore=0 suspectscore=0 adultscore=0 bulkscore=0 phishscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090065

To access PCIe registers of the host controller and endpoint PCIe
BAR space, config space the CPU-PCIe ICC (interconnect) path should
be voted otherwise it may lead to NoC (Network on chip) timeout.
We are surviving because of other driver voting for this path.

As there is less access on this path compared to PCIe to mem path
add minimum vote i.e 1KBps bandwidth always which is sufficient enough
to keep the path active and is recommended by HW team.

In suspend to ram case there can be some DBI access. Except in suspend
to ram case disable CPU-PCIe ICC path after register space access
is done.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 43 ++++++++++++++++++++++++++++++----
 1 file changed, 39 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..e53422171c01 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -245,6 +245,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
+	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
@@ -1409,6 +1410,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	if (IS_ERR(pcie->icc_mem))
 		return PTR_ERR(pcie->icc_mem);
 
+	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
+	if (IS_ERR(pcie->icc_cpu))
+		return PTR_ERR(pcie->icc_cpu);
 	/*
 	 * Some Qualcomm platforms require interconnect bandwidth constraints
 	 * to be set before enabling interconnect clocks.
@@ -1418,7 +1422,20 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "Failed to set interconnect bandwidth for PCIe-MEM: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * Since the CPU-PCIe path is only used for activities like register
+	 * access of the host controller and endpoint Config/BAR space access,
+	 * HW team has recommended to use a  minimal bandwidth of 1KBps just to
+	 * keep the path active.
+	 */
+	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
+	if (ret) {
+		dev_err(pci->dev, "Failed to set interconnect bandwidth for CPU-PCIe: %d\n",
 			ret);
 		return ret;
 	}
@@ -1448,7 +1465,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 
 	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "Failed to set interconnect bandwidth for PCIe-MEM: %d\n",
 			ret);
 	}
 }
@@ -1610,7 +1627,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(dev, "Failed to set interconnect bandwidth for PCIe-MEM: %d\n", ret);
 		return ret;
 	}
 
@@ -1634,7 +1651,17 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
-	return 0;
+	/*
+	 * In suspend to ram case there are DBI access, except in suspend to ram case
+	 * remove the vote for CPU-PCIe path now, since at this point onwards,
+	 * no register access will be done.
+	 */
+	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+		ret = icc_disable(pcie->icc_cpu);
+		if (ret)
+			dev_err(dev, "Failed to disable Interconnect path of CPU-PCIe: %d\n", ret);
+	}
+	return ret;
 }
 
 static int qcom_pcie_resume_noirq(struct device *dev)
@@ -1642,6 +1669,14 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	if (pm_suspend_target_state != PM_SUSPEND_MEM) {
+		ret = icc_enable(pcie->icc_cpu);
+		if (ret) {
+			dev_err(dev, "Failed to enable Interconnect path of CPU-PCIe: %d\n", ret);
+			return ret;
+		}
+	}
+
 	if (pcie->suspended) {
 		ret = qcom_pcie_host_init(&pcie->pci->pp);
 		if (ret)

-- 
2.42.0


