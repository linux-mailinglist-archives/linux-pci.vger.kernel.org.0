Return-Path: <linux-pci+bounces-7641-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 203738C9853
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 05:34:00 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 8C913B22565
	for <lists+linux-pci@lfdr.de>; Mon, 20 May 2024 03:33:57 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id DF40DF9FE;
	Mon, 20 May 2024 03:33:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="fwxld3S2"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2C0E917BA0;
	Mon, 20 May 2024 03:33:28 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1716176009; cv=none; b=qgiZjCjfS4E4ZMV8u9VTPmdD0bbfT/CSxX81bQRKeUEFT11NYSfQBo+tJWSN1mhnBL72PRlZ0zNekQl+pVbbi+vtkZFouf7YpbMacznanmsCXcdfLA8yPjyMpqobbhQ/tn5D9hbpHrZ/f/tx+J525ZT7S66PKTYGinifPhRsN6k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1716176009; c=relaxed/simple;
	bh=IWpjZjVrHHcMY45NxEN8Fg0tIAn3M9H6515N6FFfecU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pMQuyWkKePlM3cUfnLTuiaRMMKEKI5f3Sq6KwBUsd5CEOD2F7Vl7isD0lZXRSm7hIqkjAY67BgEIw+Q8rYx7arRsteS6If+NO4NXHM/4zk7o3IsFOgJ3dTYXHPjmGxpCkGMpI82u1sOlBWQeCqPRqkJ5b2W0s/lNXHE67ppZPYk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=fwxld3S2; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 44K08NDd017683;
	Mon, 20 May 2024 03:33:19 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=3c6ZA8J+NrjgO8X3OPDFmDHb3qSzPN9zlASdh9kTlEM
	=; b=fwxld3S2SPa74IGDsR1oOixE49BkWBpWJRUSmmQ7OaHnMubZah9XKLaXzxu
	cROxWhI4ii1RUbz2dEM+Wlgqtf5EMrYW81hGvOkXHd5llFUtYaakWX+KQNqC4509
	tQhmdCHLyBhOLlSQ2TGzuTClYLbSjYU7OTZ55FF54NLlvpQdpeA7XTtpCA/OXgXA
	rLH5GKdvhh8JIEfWmezMGIc//VlQ++cTes1omP6KKwKaj30GvIFYEYgCTcSu7f4O
	zrEr7x8uNPa2dxJt1ArtO7/4cOGI6IGhwZnAfrHabjSzzXJCbJbqpmHKhSZ6MU+o
	SIA+a6uKy/BRsrpWtmDshQHikVw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3y6n3takgd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 03:33:18 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 44K3XGpR026948
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 20 May 2024 03:33:16 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 19 May 2024 20:33:10 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 18 May 2024 19:01:43 +0530
Subject: [PATCH v13 2/6] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240518-opp_support-v13-2-78c73edf50de@quicinc.com>
References: <20240518-opp_support-v13-0-78c73edf50de@quicinc.com>
In-Reply-To: <20240518-opp_support-v13-0-78c73edf50de@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1716175976; l=4515;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=IWpjZjVrHHcMY45NxEN8Fg0tIAn3M9H6515N6FFfecU=;
 b=Wb8MKGlXRVVgmdoMcvls0/1T5G1rJp9BjfJOEc5abJOx6QpJMzjadshx70ZVY1ub3qGRn4jVf
 6E3z9XWywebBZrJXwtc30d5lVxJRS1SBnd5kKLGIFSVZG6gufQDNdYn
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: k8EnACTyDtmABbyFXrwhafb1T9NsP5at
X-Proofpoint-ORIG-GUID: k8EnACTyDtmABbyFXrwhafb1T9NsP5at
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-20_01,2024-05-17_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 bulkscore=0 priorityscore=1501 malwarescore=0 mlxlogscore=999
 lowpriorityscore=0 phishscore=0 spamscore=0 impostorscore=0 clxscore=1015
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405010000 definitions=main-2405200026

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
index 14772edcf0d3..ed4453db3e56 100644
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
@@ -1418,11 +1422,25 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
 
@@ -1448,7 +1466,7 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 
 	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
 	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
+		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
 			ret);
 	}
 }
@@ -1610,7 +1628,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n", ret);
 		return ret;
 	}
 
@@ -1634,7 +1652,18 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
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
@@ -1642,6 +1671,14 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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


