Return-Path: <linux-pci+bounces-4365-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 17A1D86EE72
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 05:02:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id D3A93B242A5
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 04:02:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 715058F5C;
	Sat,  2 Mar 2024 04:01:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f1kXHz4N"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C42F1179BC;
	Sat,  2 Mar 2024 04:01:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352067; cv=none; b=Sy3/duhyLy7Y/rUf68A2zmp5m218IE+i7CM4FDCcomwNTMmMfcgLwpgoezS+aRgfrlu51kd4KhJ2QVcgWIzVuBA1Dep/h/vpvx2bcKTkw6j/B9w51/KIjyWq21bzaYZB7jzPNjrZ4Xqi82D3GyZ33O6kwYNxKD5Yxk3XbjAJcEw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352067; c=relaxed/simple;
	bh=QUJ+uyOOht+Lnc6Y4adY/bs8ZcDhOvU50AmkDpCQsfQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=afqf6Xm9OnKHmcRPphzIesGuq++POjQeHN0YAkzMZrA1lnPi9mvBMfGOVNz0277IpxO0mbzX/UirwJM2VnEMpGcdgt8iJSvEYIXIWIkEDLuxfBBatZegnzHKJHWtGzDf0nyjyL1oqPkFKRoQ3arAaIkbOlH01UyaPIW6J72jo5c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f1kXHz4N; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4223k3oR016757;
	Sat, 2 Mar 2024 04:00:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=UgXdaho2g1wAGEkx5lrs8R4Q61U+T3fkNPkjg6bs7M4
	=; b=f1kXHz4N7n9Aak90wcQ+U+760SkFTu0zlkdH+9rpwa3Qx99B6dN7ik9LmpK
	LFnfLbw47rqvqz2pMzuclBixdyXS6LuuSV/A0WU2+m9fwFpmtf23sFdsqXgyJKxY
	fW9b1Xc48F4+tT1dgbGbFe2hMl2ItIOEbddtTugAweZ6Ev4a0woNW8bonysH0ZTU
	GdWrTCWS5BxMDaRGECYRw+0LjmaJ7PTB1aWvCLyknJPqypAdIlynfnzmR7XrG5DZ
	wIzrQVaSSR4aXDTzkObd1fewCdevns0UZ29PV0+1Ra+/E9J+DawKGR5Y9og5sa3p
	LXsjCdfzpXof1GV0CXAeikHhLnA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkvb700v2-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 04:00:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42240v8c022368
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Mar 2024 04:00:57 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 20:00:51 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 2 Mar 2024 09:30:01 +0530
Subject: [PATCH v8 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240302-opp_support-v8-7-158285b86b10@quicinc.com>
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
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709352004; l=5942;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=QUJ+uyOOht+Lnc6Y4adY/bs8ZcDhOvU50AmkDpCQsfQ=;
 b=hW7ITjW6G5LvtaqTuJ34NeeUYCWzHiMfeFprZaObeexidG+hGigmIx//ij8DAZ0EZVd7NgK1+
 Sb7gRxYjNI7B+iIK3DWlCVI0HKfrNZ3wGYeUrRERqZuR99URx8KejEH
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ksJOpkJ0QGO-ZZOAlhlqsbEcauEdec9Q
X-Proofpoint-ORIG-GUID: ksJOpkJ0QGO-ZZOAlhlqsbEcauEdec9Q
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 bulkscore=0 adultscore=0 mlxlogscore=999 lowpriorityscore=0 phishscore=0
 malwarescore=0 impostorscore=0 clxscore=1015 spamscore=0 mlxscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403020031

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

Different link configurations may share the same aggregate bandwidth,
e.g., a 2.5 GT/s x2 link and a 5.0 GT/s x1 link have the same bandwidth
and share the same OPP entry.

As we are moving ICC voting as part of OPP, don't initialize ICC if OPP
is supported.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 81 +++++++++++++++++++++++++++-------
 1 file changed, 66 insertions(+), 15 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index a0266bfe71f1..2ec14bfafcfc 100644
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
@@ -244,6 +245,7 @@ struct qcom_pcie {
 	const struct qcom_pcie_cfg *cfg;
 	struct dentry *debugfs;
 	bool suspended;
+	bool opp_supported;
 };
 
 #define to_qcom_pcie(x)		dev_get_drvdata((x)->dev)
@@ -1405,15 +1407,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
@@ -1425,11 +1425,30 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
+	if (pcie->opp_supported) {
+		mbps = pcie_link_speed_to_mbps(pcie_link_speed[speed]);
+		if (mbps < 0)
+			return;
+
+		freq = mbps * 1000;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
+					dev_pm_opp_get_freq(opp), ret);
+			dev_pm_opp_put(opp);
+		}
+	} else {
+		ret = icc_set_bw(pcie->icc_mem, 0,
+				 width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+		if (ret) {
+			dev_err(pci->dev,
+				"failed to set interconnect bandwidth for pcie-mem: %d\n", ret);
+		}
 	}
+
+	return;
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
@@ -1472,8 +1491,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
+	unsigned long max_freq = INT_MAX;
 	struct device *dev = &pdev->dev;
 	struct qcom_pcie *pcie;
+	struct dev_pm_opp *opp;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
 	struct dw_pcie *pci;
@@ -1540,9 +1561,36 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_pm_runtime_put;
 	}
 
-	ret = qcom_pcie_icc_init(pcie);
-	if (ret)
+	 /* OPP table is optional */
+	ret = devm_pm_opp_of_add_table(dev);
+	if (ret && ret != -ENODEV) {
+		dev_err_probe(dev, ret, "Failed to add OPP table\n");
 		goto err_pm_runtime_put;
+	}
+
+	/*
+	 * Use highest OPP here if the OPP table is present. At the end of
+	 * the probe(), OPP will be updated using qcom_pcie_icc_opp_update().
+	 */
+	if (ret != -ENODEV) {
+		opp = dev_pm_opp_find_freq_floor(dev, &max_freq);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(dev, opp);
+			if (ret)
+				dev_err_probe(pci->dev, ret,
+					      "Failed to set opp: freq %ld\n",
+					      dev_pm_opp_get_freq(opp));
+			dev_pm_opp_put(opp);
+		}
+		pcie->opp_supported = true;
+	}
+
+	/* Skip ICC init if OPP is supported as ICC bw is handled by OPP */
+	if (!pcie->opp_supported) {
+		ret = qcom_pcie_icc_init(pcie);
+		if (ret)
+			goto err_pm_runtime_put;
+	}
 
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
@@ -1562,7 +1610,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1621,10 +1669,13 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 			qcom_pcie_host_init(&pcie->pci->pp);
 			pcie->suspended = false;
 		}
-		qcom_pcie_icc_update(pcie);
+		qcom_pcie_icc_opp_update(pcie);
 		return ret;
 	}
 
+	if (pcie->opp_supported)
+		dev_pm_opp_set_opp(pcie->pci->dev, NULL);
+
 	return 0;
 }
 
@@ -1647,7 +1698,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	return 0;
 }

-- 
2.42.0


