Return-Path: <linux-pci+bounces-6563-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 646908AE0BB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 11:10:52 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id AE5CFB237FD
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 09:10:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5A4685823F;
	Tue, 23 Apr 2024 09:08:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZPTtj8hl"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9FC5F59B56;
	Tue, 23 Apr 2024 09:08:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863325; cv=none; b=sxXXob/vCp4OAUTNe+5uWoq7vRz5+mrvB+GPoSIfnXL3iXK6ixkGHl7jGeEJ/GWeptXJNfYCxlEkl51p4uQ1EWKPEtcMhY9H55AacnBzPTyj0vWBhHka/UqOTOgyffiPeA20TFaITmZ4zFt2Xo1gLdUqsjCaf/7YIX8gQeK09GI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863325; c=relaxed/simple;
	bh=wwNv0pI2dMCLeSzhSpOy/MncHRyQ8g1i4vlar+nCwXg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=bfy7yciiopXFowdHiGVYlyu0sKyFWV1TuQD23JO+YuLjxfutkMMVQ9nHXvhFTMK/ZhonHTtoK8/FIa2g7iPoRGhXKfcsSgARy9QnNyJRba1tEBwpvyOB1e/kSAbGY1rhjTqUIgVjTZEBOyR/sQaA4gtKacwWkQl59rqn4+sn9oM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZPTtj8hl; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N8Ni04017570;
	Tue, 23 Apr 2024 09:08:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=DzTEn0h78zzgvHCZTdcWfLx+CrnPL+niHNjH4pJ1fC8
	=; b=ZPTtj8hlo1mShx7H6qW+GnkFfsh1RqucS/V3ws1nbYk7J5Jzl/i46ldo7zQ
	CZ9ZLkfq431/Otzz7FLinadZtpeWY/2H8jWC+23p8ExDY19TmEWl/8sY0AIHIKO2
	DNFDXQGZheoIFrFkXExSHcrlWFnVBOm/MTebggkJlMtA5VY9PA4gjmlQoDrpooA6
	8TNy7j+/3W516x9U96/qQLxSgD25CahtKGLeiMd3HQ3VNvWroWzqstPfN8v5ajSW
	LuY+nP6iOwyii8HppuvcoXZYBNOk7C9KBpWumonZv/mHoJ0IrA0B2UMmebtqb14q
	4hlrwnExClx95vflaxSnAWs7euA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xp6n2gde2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:33 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N98W7j031875
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:32 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 02:08:26 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 23 Apr 2024 14:37:00 +0530
Subject: [PATCH v11 6/6] PCI: qcom: Add OPP support to scale performance
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240423-opp_support-v11-6-15fdd40b0f95@quicinc.com>
References: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
In-Reply-To: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713863266; l=5815;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=wwNv0pI2dMCLeSzhSpOy/MncHRyQ8g1i4vlar+nCwXg=;
 b=/wkgG3cJms8d4E4TIKUeCCyVI1I4iEO2IGXCw/HJu3+oigMAozJyBNqCMGr25/i6phoETJymI
 Om1fUSC3ZbQAnnopG6YHryEOtkhZBYrEjmVRTjnfxOlVivKZqhKQ55e
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B0390ZIcVmepJJsBiIrUPH0Byf6hBex-
X-Proofpoint-ORIG-GUID: B0390ZIcVmepJJsBiIrUPH0Byf6hBex-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_07,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 spamscore=0
 priorityscore=1501 adultscore=0 suspectscore=0 mlxlogscore=999 bulkscore=0
 phishscore=0 malwarescore=0 mlxscore=0 lowpriorityscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2404010003
 definitions=main-2404230025

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

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 81 ++++++++++++++++++++++++++++------
 1 file changed, 67 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 465d63b4be1c..66bda30305a8 100644
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
 	struct dw_pcie *pci = pcie->pci;
-	u32 offset, status;
+	u32 offset, status, freq;
+	struct dev_pm_opp *opp;
 	int speed, width;
-	int ret;
-
-	if (!pcie->icc_mem)
-		return;
+	int ret, mbps;
 
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
+		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
+		if (mbps < 0)
+			return;
+
+		freq = mbps * 1000;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set opp for freq (%ld): %d\n",
+					dev_pm_opp_get_freq(opp), ret);
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
+				      "Failed to set OPP for freq (%ld): %d\n",
+				      max_freq, ret);
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


