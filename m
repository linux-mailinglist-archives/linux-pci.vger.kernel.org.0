Return-Path: <linux-pci+bounces-4361-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id BBC0A86EE5F
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 05:01:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 5CA461F23485
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 04:01:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D28D3CA7A;
	Sat,  2 Mar 2024 04:00:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="M00g1QlS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A17591401E;
	Sat,  2 Mar 2024 04:00:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352041; cv=none; b=YXEkP3zzAgP1+sbl+8CJFwlxbPpnXSu0bAmtQtxUkmhWjUrW5um+CBVtxfuxIsQn6670RBTFoMWqhdXvWCnzdI8sEVHl+eHGwME0+Hz26jTpr9dlnxyRt5Fh6EtXv6C3rFJUiOe9Rhe8laWn0FNQ5594wQNZZyKsVKEUzBQ23E8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352041; c=relaxed/simple;
	bh=juVQh0d9T+B/H5cHSGyuBUCU/bdjSwgnP9a0FrBSPPE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SgggWffrLVofux7aqoJ10KZR3DS87n9fIZYNAHQRElP6L+gZFKTXvatFdiK5f82gn317/lpkMh13TFrXI58YV9y3YtCgD848RVsCSYrbLXJ7/mwzOdqcaLRx9tF7S4kNThSMkrHWI1OWegbg5oFghDq1DTXYyIuhQU6GCwjFys8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=M00g1QlS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4223aNum016764;
	Sat, 2 Mar 2024 04:00:31 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=JTt03ap6invxnj8mxB5rD01WcQ5nu+m9RxcfWbtVUag
	=; b=M00g1QlSwj4ACPwEAyeqI6e6AUkFkx/YZIq7qNLz6UkEp6vUrRsnzL2JkTP
	tOsEWNcOv2xZWCgTXTaxAVOt8RfWMxJwqrSN9VRu7P0Ec/M90SJSeqroBX91924l
	XTCtzFpGxLPs0hAMms/qDLzVGKtj7EcdYiDG/J1Tzt6VPAfj59x7I49xzd7CR+lw
	7Ny2w9GnSqNrWYZS5227g4Fa3LhmTZOIWXl2IjzhGi4E9bVfTZH3kDom6YgrKWZs
	rz1zfAcsGupVHyENsm15pi5A3p0iQOLPHgcr+aTLbMP/t0gG0j13KRurawx7E7hq
	a62Re7RiFZSQ6iHXGnJjl6ADE5w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wku2wr3s7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 04:00:31 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42240VuF006877
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Mar 2024 04:00:31 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 20:00:24 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 2 Mar 2024 09:29:57 +0530
Subject: [PATCH v8 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240302-opp_support-v8-3-158285b86b10@quicinc.com>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
In-Reply-To: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709352003; l=3475;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=juVQh0d9T+B/H5cHSGyuBUCU/bdjSwgnP9a0FrBSPPE=;
 b=qUDwXT7fUMVUEg4okLu1zBxKWcF9DFu2g0YcLzk/H/jOjshkortpE0HcKkQhLDKjwfYwZlmn8
 qg9PJKnGkMvCn9i3wq09OD8huKK12jLJnCaXNe2NPPg8MPniTXCBEcx
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: Qioo2zdQLbKyoPmLr-49jD6uXKFl8Jk9
X-Proofpoint-GUID: Qioo2zdQLbKyoPmLr-49jD6uXKFl8Jk9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 impostorscore=0 mlxscore=0 spamscore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 suspectscore=0 adultscore=0 malwarescore=0 lowpriorityscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403020031

To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
ICC (interconnect consumers) path should be voted otherwise it may
lead to NoC (Network on chip) timeout. We are surviving because of
other driver vote for this path.

As there is less access on this path compared to PCIe to mem path
add minimum vote i.e 1KBps bandwidth always.

When suspending, disable this path after register space access
is done.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 38 ++++++++++++++++++++++++++++++++--
 1 file changed, 36 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 10f2d0bb86be..a0266bfe71f1 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -240,6 +240,7 @@ struct qcom_pcie {
 	struct phy *phy;
 	struct gpio_desc *reset;
 	struct icc_path *icc_mem;
+	struct icc_path *icc_cpu;
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
@@ -1372,6 +1373,9 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	if (IS_ERR(pcie->icc_mem))
 		return PTR_ERR(pcie->icc_mem);
 
+	pcie->icc_cpu = devm_of_icc_get(pci->dev, "cpu-pcie");
+	if (IS_ERR(pcie->icc_cpu))
+		return PTR_ERR(pcie->icc_cpu);
 	/*
 	 * Some Qualcomm platforms require interconnect bandwidth constraints
 	 * to be set before enabling interconnect clocks.
@@ -1381,7 +1385,19 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, QCOM_PCIE_LINK_SPEED_TO_BW(1));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
+			ret);
+		return ret;
+	}
+
+	/*
+	 * The config space, BAR space and registers goes through cpu-pcie path
+	 * Set peak bandwidth to 1KBps as recommended by HW team for this path
+	 * all the time.
+	 */
+	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
 			ret);
 		return ret;
 	}
@@ -1573,7 +1589,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
 		return ret;
 	}
 
@@ -1597,6 +1613,18 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
+	/* Remove CPU path vote after all the register access is done */
+	ret = icc_disable(pcie->icc_cpu);
+	if (ret) {
+		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
+		if (pcie->suspended) {
+			qcom_pcie_host_init(&pcie->pci->pp);
+			pcie->suspended = false;
+		}
+		qcom_pcie_icc_update(pcie);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1605,6 +1633,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 	struct qcom_pcie *pcie = dev_get_drvdata(dev);
 	int ret;
 
+	ret = icc_enable(pcie->icc_cpu);
+	if (ret) {
+		dev_err(dev, "failed to enable icc path of cpu-pcie: %d\n", ret);
+		return ret;
+	}
+
 	if (pcie->suspended) {
 		ret = qcom_pcie_host_init(&pcie->pci->pp);
 		if (ret)

-- 
2.42.0


