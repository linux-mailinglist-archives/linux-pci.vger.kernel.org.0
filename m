Return-Path: <linux-pci+bounces-3922-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id C1A1B861496
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:50:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 50C1D1F24DD2
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 14:50:21 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C5001823B3;
	Fri, 23 Feb 2024 14:48:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="HdHpmetc"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 198FE823A9;
	Fri, 23 Feb 2024 14:48:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699729; cv=none; b=YG36fxT7m4kDEFypr30o358RCsAtQ3JcII4EfczWkWkuHktuTL5PSKAVwn61dwl8k8CNf8vuif1HfWfoskqgr3KA3E4IumykNb42Sj90APlnwTvtYbddvmiwbVyIp2Cf+B2+2Fjy/kqBZhuCrEoqfJmDtjE/HJFyF+Xdlmjkzc4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699729; c=relaxed/simple;
	bh=vglpgn/ps8SLoXIdyjk86qEk7CHXziuguq6+bZAxhqY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=fCGAVL+GEwGosjR8tc+GxNih6H1afmL60NX29LQqiZqTgB3scbBg82ePrJN7BTXHv2HYiUedgxBbz5fk7PbYbXDkEMQuBK2UqeBs9PIF2o851uV8C6FLDTHKxlsm41l/WKgd46Av8ol65zgtnb/CHJ+Kf3HgiRO87Gvw8EcBqKU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=HdHpmetc; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NBXDoI019305;
	Fri, 23 Feb 2024 14:48:40 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=ioNHvIch7dV1L9IffTvensIGOBfZ95sdZbeKQgtA32w
	=; b=HdHpmetc5x0l1J7XKGtkb1/VNMDfn7oIy4eHbsBNyjbavLIUPBwiddbsoft
	lRlXGeKI6YRy4DXLq37zw+GYk4RmnZ4jFTLGyvfz5acWEGI0G8AqzqsvGFGN8wkX
	/eBki+ct71AtjvJMygjq/7ddWqYVTDwCAht+y4+gpC+P+lKrv+ZUGfKkRvgpwz+u
	nKHn9jrtYrTVIU+3z0uBSlGhYASzk7gwAc9Q5bfmSNflFTBm3O/ts4YkDFpmQApn
	o4lGg+iDaglD8gmKAUVrNLwP1ETYUBbFazluIFlZt+8SlVNsJWiXzv5mjbJcA2MW
	DIkAQcZBGz9vp7B4zbjuRw+t+qw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqcf8v9k-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:40 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NEmd1A032169
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:48:39 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 06:48:32 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 23 Feb 2024 20:18:00 +0530
Subject: [PATCH v7 3/7] PCI: qcom: Add ICC bandwidth vote for CPU to PCIe
 path
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-opp_support-v7-3-10b4363d7e71@quicinc.com>
References: <20240223-opp_support-v7-0-10b4363d7e71@quicinc.com>
In-Reply-To: <20240223-opp_support-v7-0-10b4363d7e71@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708699692; l=3475;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=vglpgn/ps8SLoXIdyjk86qEk7CHXziuguq6+bZAxhqY=;
 b=ndOUH8K80P3pJIHvjwCwOnA0jmofVClSSj863fpp+6iOOJJtiijVxCw2/UWRhk3Ps89JMCHYz
 oaQVbkhnUKZAO6fJzdZCR7kX1t7Ybkof5yAGfMH47hqbHXXf4BPL/hW
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: rOdFr3FVQNtEyh1JWHiITGm0uqcePEx_
X-Proofpoint-GUID: rOdFr3FVQNtEyh1JWHiITGm0uqcePEx_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 impostorscore=0 clxscore=1015 priorityscore=1501 suspectscore=0
 spamscore=0 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230108

To access PCIe registers, PCIe BAR space, config space the CPU-PCIe
ICC(interconnect consumers) path should be voted otherwise it may
lead to NoC(Network on chip) timeout. We are surviving because of
other driver vote for this path.
As there is less access on this path compared to PCIe to mem path
add minimum vote i.e 1KBps bandwidth always.

In suspend remove the disable this path after register space access
is done.

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 37 ++++++++++++++++++++++++++++++++--
 1 file changed, 35 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 10f2d0bb86be..088ebd2e5865 100644
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
@@ -1381,7 +1385,18 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
+	 * The config space, BAR space and registers goes through cpu-pcie path.
+	 * Set peak bandwidth to 1KBps as recommended by HW team for this path all the time.
+	 */
+	ret = icc_set_bw(pcie->icc_cpu, 0, kBps_to_icc(1));
+	if (ret) {
+		dev_err(pci->dev, "failed to set interconnect bandwidth for cpu-pcie: %d\n",
 			ret);
 		return ret;
 	}
@@ -1573,7 +1588,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 */
 	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
 	if (ret) {
-		dev_err(dev, "Failed to set interconnect bandwidth: %d\n", ret);
+		dev_err(dev, "Failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
 		return ret;
 	}
 
@@ -1597,6 +1612,18 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
+	/* Remove cpu path vote after all the register access is done */
+	ret = icc_disable(pcie->icc_cpu);
+	if (ret) {
+		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
+		if (pcie->suspended) {
+			qcom_pcie_host_init(&pcie->pci->pp);
+			pcie->suspended = false;
+		}
+		qcom_pcie_icc_opp_update(pcie);
+		return ret;
+	}
+
 	return 0;
 }
 
@@ -1605,6 +1632,12 @@ static int qcom_pcie_resume_noirq(struct device *dev)
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


