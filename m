Return-Path: <linux-pci+bounces-6717-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 669E28B43B1
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 03:55:36 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8252842F2
	for <lists+linux-pci@lfdr.de>; Sat, 27 Apr 2024 01:55:35 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 52FF6383AC;
	Sat, 27 Apr 2024 01:54:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h3KKRVdg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C009040853;
	Sat, 27 Apr 2024 01:54:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714182877; cv=none; b=MPrIEq+mlGNSDsVcs9HcpmByWppwh2ik0l+9mPCJ3Qxw1Lvugzh5xGsOSiQprHbK7915F8wENEK8+0ISS2f4by2x6OgPYvTcY8js0+7rdqGWmfWFugYq2XQXpkKnT1yF6kIkr25yx6kp6JUrtnMeEjJsnkyHrFMmZtjBleiBazg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714182877; c=relaxed/simple;
	bh=LY3NaLBOtk/uSA2BDdXhjA5SiK8eNO2ndH+ucouDx1g=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pklM6QKd9bqdt2livlipK8rdGGRtLN2HInEwSj1EjRSWLZOoNDXDxnyYrH5D7Qmedos0MnvwEyUOdE6MoA651GfuWeYBRet6+atYElhhKCJ5A9+KUeN7PyGmmDyavYiCE4ScLRUAXxtbIIiSZREdW1A3F/UrbVPxQhhMeCP7GUo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h3KKRVdg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43R1c3hb028297;
	Sat, 27 Apr 2024 01:54:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=Gl8T5u/RRxA+ofuhzS9t20gN2ILQOfhMYQkvltfzHpw
	=; b=h3KKRVdgxPZWkRyxlfN3iNGjTI5PqKcNf0E/M7M2boXzJAqcsIHXp5JCGR5
	Gx5CYg8Ay12qali3Ukn0/KzWtgkJUr0saQeTjoNItpfK0kMo4o0gT5qOnXuOI+OT
	g91AeDI29CY1wO7HU9abvTpI7fPeC7xPM2Lx3kLSWTyT+1YpLkIEaDI/wGvUUaGw
	VUgw3OU+eJyr6/mhaoTPBqELnwQtD4jF9WRc0EFGgWQfbXU6vLJo94D38L9ZH+VK
	ZXGhcTu7Tm3o3ZZ3BVm0VFpKroKHvTV5cHs6wpM9LuLnRa41FHyOZRk2a50I3cud
	ZYyvZy1/gDRV6vwx3fnRc+E9LTQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xranmhn8u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:54:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43R1sNKV006903
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 27 Apr 2024 01:54:23 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 26 Apr 2024 18:54:17 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 27 Apr 2024 07:22:39 +0530
Subject: [PATCH v12 6/6] PCI: qcom: Add OPP support to scale performance
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240427-opp_support-v12-6-f6beb0a1f2fc@quicinc.com>
References: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
In-Reply-To: <20240427-opp_support-v12-0-f6beb0a1f2fc@quicinc.com>
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
        <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1714182818; l=5911;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=LY3NaLBOtk/uSA2BDdXhjA5SiK8eNO2ndH+ucouDx1g=;
 b=zic6G823pDT+ORTBVFqMjXSTelB9cD6UJuTp5lWDiqUpjbJrY9EexnYNFgttihQtt5ezVFT3B
 ud/9lRpaQq0AqeY9ytpvKRAcGXqN1LgXJDdKaE58BscgfQhBGDBo9dl
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2SmRe4pUfw36H885j6Qy9IvYcD8KVqYB
X-Proofpoint-ORIG-GUID: 2SmRe4pUfw36H885j6Qy9IvYcD8KVqYB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-26_22,2024-04-26_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 lowpriorityscore=0 suspectscore=0 bulkscore=0 phishscore=0 clxscore=1015
 malwarescore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404270012

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
 drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 465d63b4be1c..40c875c518d8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -22,6 +22,7 @@
 #include <linux/of.h>
 #include <linux/of_gpio.h>
 #include <linux/pci.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -1443,15 +1444,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
@@ -1463,10 +1462,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
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
 
@@ -1510,7 +1525,9 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
+	unsigned long max_freq = INT_MAX;
 	struct device *dev = &pdev->dev;
+	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
@@ -1578,9 +1595,42 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
@@ -1600,7 +1650,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1661,6 +1711,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		ret = icc_disable(pcie->icc_cpu);
 		if (ret)
 			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
+
+		if (!pcie->icc_mem)
+			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
 	}
 	return ret;
 }
@@ -1686,7 +1739,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	return 0;
 }

-- 
2.42.0


