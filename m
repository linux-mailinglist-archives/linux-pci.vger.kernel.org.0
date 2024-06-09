Return-Path: <linux-pci+bounces-8494-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 5B1ED90143A
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 04:39:15 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C1797281D94
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 02:39:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 6F5385234;
	Sun,  9 Jun 2024 02:39:09 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gVvwqWja"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AEA225223;
	Sun,  9 Jun 2024 02:39:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900749; cv=none; b=ksqPOXo66eDw6zcMliKlC4Gbkh87azkQhgZlLc/V4J2GuUkpq5+QCkj5XRJ1ZJPJCbgvMnOgvg2CWKdgvqipSldrlf/UKyRBSpaX0AdoLtfXAXc6F8NuqqCR4Rlg8IdZNDWfMtxeZO1pry3raA7qg9HhUKQZWS++bai4m5LcchA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900749; c=relaxed/simple;
	bh=Ri5Us2htYCOxR0J+fU8iQSYS64K3qnxNjnvQ9YMgn+o=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=lg049J1b12YqqSWEC0XyH5Q3NvusO4UKbBz1NatI/ViUKSTyFtZWzHsILoTItvhRcr7Pzm3/SClZ4+C8O7GkRuhizZ3pMpMudFvCWgHwm/dXntVdEsueBCIS0dSm31vJUoEJlCn5LrGBsqJzF/LlEZkye13r214HjiEI5yxx6rg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gVvwqWja; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4591j5pr026937;
	Sun, 9 Jun 2024 02:38:55 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	IUKPYn4SCK2L32Q0KmG/mHHU/d9LwqngcdVyiH3UMtY=; b=gVvwqWja4b+auxBC
	59XQdcTkAOUWfUm11cCylkQXSq9LGaRBirnGUyHGTvcY6uIUv3NjI1rTpynPUWmE
	xEz9/JY7Zo8TzDYVCi6PZ/22DKSuLwXwav6VU04OznpDIV6Q6SbfIpj+qy8ZJi6j
	e3lEjuI6pJ7GXQFryeAHkr4cQzrLiPq78J3OnXF8IVVrNhpCjrpjpnGbfzXCGVko
	qa/OtwrdA8YdblYZY2h74Ntch5EcscOrcX8fLdD/bfb37Xfz517HzRUEdeaBYzI1
	Sgb3py39bGAIuRYdtz3/BvolxPhRbvQeUS7TDHDyWJeoiUeiTZuSlIC/lSjz4PUA
	U6L0sg==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymevx979a-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 02:38:55 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4592crFW025496
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 02:38:53 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 19:38:47 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 9 Jun 2024 08:08:18 +0530
Subject: [PATCH v14 4/4] PCI: qcom: Add OPP support to scale performance
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240609-opp_support-v14-4-801cff862b5a@quicinc.com>
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
        <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717900699; l=6487;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=Ri5Us2htYCOxR0J+fU8iQSYS64K3qnxNjnvQ9YMgn+o=;
 b=iqpRZsev4456MkiW9hC71zwxfhV0BjhC++q/Il90zhTaEOQW59q9Frh2JSEGeCBwOG65mIoT5
 5NBCCc1STiaCdVVgDftC1mkVsscwk7uEshYCMbtNmzNHStsvQAGJ2rE
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZOKR9GAFt4R_b6YDSRSuwOMHaybtNaAL
X-Proofpoint-GUID: ZOKR9GAFt4R_b6YDSRSuwOMHaybtNaAL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999 mlxscore=0
 impostorscore=0 adultscore=0 phishscore=0 malwarescore=0 clxscore=1015
 suspectscore=0 priorityscore=1501 spamscore=0 bulkscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090019

QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
maintains hardware state of a regulator by performing max aggregation of
the requests made by all of the clients.

PCIe controller can operate on different RPMh performance state of power
domain based on the speed of the link. And this performance state varies
from target to target, like some controllers support GEN3 in NOM (Nominal)
voltage corner, while some other supports GEN3 in low SVS (static voltage
scaling).

The SoC can be more power efficient if we scale the performance state
based on the aggregate PCIe link bandwidth.

Add Operating Performance Points (OPP) support to vote for RPMh state based
on the aggregate link bandwidth.

OPP can handle ICC bw voting also, so move ICC bw voting through OPP
framework if OPP entries are present.

As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
is supported.

Before PCIe link is initialized vote for highest OPP in the OPP table,
so that we are voting for maximum voltage corner for the link to come up
in maximum supported speed.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 93 +++++++++++++++++++++++++++-------
 1 file changed, 75 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ff1d891c8b9a..296e2d5036f6 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -21,6 +21,7 @@
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/pci.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -1404,15 +1405,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
+static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
+	int speed, width, ret, freq_mbps;
 	struct dw_pcie *pci = pcie->pci;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
 	u32 offset, status;
-	int speed, width;
-	int ret;
-
-	if (!pcie->icc_mem)
-		return;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1424,10 +1423,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-	if (ret) {
-		dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
-			ret);
+	if (pcie->icc_mem) {
+		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+		if (ret) {
+			dev_err(pci->dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+				ret);
+		}
+	} else {
+		freq_mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
+		if (freq_mbps < 0)
+			return;
+
+		freq_kbps = freq_mbps * 1000;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width, true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP for freq (%ld): %d\n",
+					freq_kbps * width, ret);
+		}
+		dev_pm_opp_put(opp);
 	}
 }
 
@@ -1471,7 +1486,9 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
+	unsigned long max_freq = INT_MAX;
 	struct device *dev = &pdev->dev;
+	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
@@ -1539,9 +1556,42 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	ret = qcom_pcie_icc_init(pcie);
-	if (ret)
+	/* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV) {
+		dev_err_probe(dev, ret, "Failed to add OPP table\n");
 		goto err_pm_runtime_put;
+	}
+
+	/*
+	 * Before PCIe link is initialized vote for highest OPP in the OPP table,
+	 * so that we are voting for maximum voltage corner for the link to come up
+	 * in maximum supported speed. At the end of the probe(), OPP will be
+	 * updated using qcom_pcie_icc_opp_update().
+	 */
+	if (!ret) {
+		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
+		if (IS_ERR(opp)) {
+			dev_err_probe(pci->dev, PTR_ERR(opp),
+				      "Unable to find max freq OPP\n");
+			goto err_pm_runtime_put;
+		} else {
+			ret = dev_pm_opp_set_opp(dev, opp);
+		}
+
+		dev_pm_opp_put(opp);
+		if (ret) {
+			dev_err_probe(pci->dev, ret,
+				      "Failed to set OPP for freq %ld\n",
+				      max_freq);
+			goto err_pm_runtime_put;
+		}
+	} else {
+		/* Skip ICC init if OPP is supported as it is handled by OPP */
+		ret = qcom_pcie_icc_init(pcie);
+		if (ret)
+			goto err_pm_runtime_put;
+	}
 
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
@@ -1561,7 +1611,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1586,10 +1636,14 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 	 * Set minimum bandwidth required to keep data path functional during
 	 * suspend.
 	 */
-	ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
-	if (ret) {
-		dev_err(dev, "Failed to set bandwidth for PCIe-MEM interconnect path: %d\n", ret);
-		return ret;
+	if (pcie->icc_mem) {
+		ret = icc_set_bw(pcie->icc_mem, 0, kBps_to_icc(1));
+		if (ret) {
+			dev_err(dev,
+				"Failed to set bandwidth for PCIe-MEM interconnect path: %d\n",
+				ret);
+			return ret;
+		}
 	}
 
 	/*
@@ -1622,6 +1676,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		ret = icc_disable(pcie->icc_cpu);
 		if (ret)
 			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
+
+		if (!pcie->icc_mem)
+			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
 	}
 	return ret;
 }
@@ -1647,7 +1704,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	return 0;
 }

-- 
2.42.0


