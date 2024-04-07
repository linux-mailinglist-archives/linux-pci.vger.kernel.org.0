Return-Path: <linux-pci+bounces-5828-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 00EE389AE7F
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 06:38:47 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AB2732822C7
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 04:38:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8DF9A1879;
	Sun,  7 Apr 2024 04:38:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jYrCQpuq"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EC002101F7;
	Sun,  7 Apr 2024 04:38:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712464698; cv=none; b=U5ifgfaAlKU/2+feylOwCB3J81B+xjk3SlDgtd1VGxvh9z6DFY5MgouqLzHyrkI4/7aNzjoHubwOEn2Oahvd2FNpDrcnp/NBPaRy+3DAIEbg5rz0QfvtpGLhO0gnVDSLJv9nD85BQuFQYIZ8nYVv4I48aljQkcEkORJhnDCj8D4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712464698; c=relaxed/simple;
	bh=T0xWNPl2918P0E+BEa6vfkOKQ0KiOjVGFpYhfRkqZRk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Djn4V/bhLvq2oUT63uPxDr34MN89O0eKxVSQUnVmzJoZO8gNkS252ElYef3s45SRiNOL5PwWmIUFQGb1iKXsNaxSSVbOX0jUbmCXMKn5dMwynF7rhfee64u7BXDyMZj9oZmH3E6ZqnthJxjZo9DrVANjvd5Jbin4EB8Xhx7IF7M=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jYrCQpuq; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4374BHiT022050;
	Sun, 7 Apr 2024 04:38:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=BTNSRt+dK6KmOOn3S6tCyvN3LVUmL68OtRYEnUqHz4s
	=; b=jYrCQpuqdz1ZIy4/9jxmSqlBkZVDiQmqNnsTY7Yv0RFdmvp+k6zu7yIxANI
	6E2UKvfMrxMVf1QjN8ARQaxxy9ccKP71QrPosz5hQTT2ZYy7A32GhdOCzuiiEdm/
	1bFj8yScbm4qU2aHhPSioOW4J82MikqSsprVhnZNfhCHjesW7jT3sLz2T4rIyC4t
	/4cEQljgrJxJVEytIQ6uyodGffZcD71S0hJqbtlxy6EO3vglOoQmjEpf4Odli2LZ
	h1doJPIXINvGC+uhDfYBAInyl78vvdAbxm2N4UiNkQOnwexopHptii406ZsCL483
	39xz4AFU7bPi3nonqK5JnX5x7uA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xawbv1e6f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 04:38:08 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4374c72v007884
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 04:38:07 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 6 Apr 2024 21:38:00 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 7 Apr 2024 10:07:35 +0530
Subject: [PATCH v9 2/6] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240407-opp_support-v9-2-496184dc45d7@quicinc.com>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
In-Reply-To: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712464666; l=3863;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=T0xWNPl2918P0E+BEa6vfkOKQ0KiOjVGFpYhfRkqZRk=;
 b=rwRsLc0X2da3sPgVldfj0R0pfXTnOX4jH7Ceo6BwiQs6nbBxRakwkmcLMHktURuO0x+KsFMy7
 OkcKpnvkKTzAwMSRThNmiDm089Mi0D4gdwKMIsnvyQ/8qxL0UPEZ4yu
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: hebKs99CeKUzC1GnT8kS1p88NE5i-65S
X-Proofpoint-GUID: hebKs99CeKUzC1GnT8kS1p88NE5i-65S
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_02,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 mlxscore=0 malwarescore=0 spamscore=0
 bulkscore=0 adultscore=0 mlxlogscore=999 phishscore=0 lowpriorityscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404070033

To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
ICC (interconnect consumers) path should be voted otherwise it may
lead to NoC (Network on chip) timeout. We are surviving because of
other driver vote for this path.

As there is less access on this path compared to PCIe to mem path
add minimum vote i.e 1KBps bandwidth always which is recommended
by HW team.

When suspending, disable this path after register space access
is done.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++----
 1 file changed, 34 insertions(+), 4 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 14772edcf0d3..b4893214b2d3 100644
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
@@ -1418,7 +1422,19 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * Since the CPU-PCIe path is only used for activities like register
+	 * access, Config/BAR space access, HW team has recommended to use a
+	 * minimal bandwidth of 1KBps just to keep the link active.
+	 */
+	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth for CPU-PCIe: %d\n",
 			ret);
 		return ret;
 	}
@@ -1448,7 +1464,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 
 	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "failed to set interconnect bandwidth for PCIe-MEM: %d\n",
 			ret);
 	}
 }
@@ -1610,7 +1626,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(dev, "Failed to set interconnect bandwidth for PCIe-MEM: %d\n", ret);
 		return ret;
 	}
 
@@ -1634,7 +1650,15 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
-	return 0;
+	/*
+	 * Remove the vote for CPU-PCIe path now, since at this point onwards,
+	 * no register access will be done.
+	 */
+	ret = icc_disable(pcie->icc_cpu);
+	if (ret)
+		dev_err(dev, "failed to disable icc path of CPU-PCIe: %d\n", ret);
+
+	return ret;
 }
 
 static int qcom_pcie_resume_noirq(struct device *dev)
@@ -1642,6 +1666,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	ret = icc_enable(pcie->icc_cpu);
+	if (ret) {
+		dev_err(dev, "failed to enable icc path of CPU-PCIe: %d\n", ret);
+		return ret;
+	}
+
 	if (pcie->suspended) {
 		ret = qcom_pcie_host_init(&pcie->pci->pp);
 		if (ret)

-- 
2.42.0


