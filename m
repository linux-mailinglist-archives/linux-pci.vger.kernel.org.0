Return-Path: <linux-pci+bounces-8992-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5735490F1D1
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 17:12:51 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 9947C287644
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2024 15:12:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9F97213B7AF;
	Wed, 19 Jun 2024 15:11:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ei5asQwp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 025AA143865;
	Wed, 19 Jun 2024 15:11:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718809919; cv=none; b=uMlvknR6wjBCOOS4a/LMwomxi7ZR/6w7358Lk9NuAPWVYYljS2BGRZHw/F8ZHyomXYCmInkiB6VPfRcQegLdbiXPpOejpEKFibzNsmqE5YZT8Cd5gdqMV6xy5Ngct4n8xXvXOnp08pM8Q7Z+Uxe6lfd69PfN6ekHlysEWSwpdl8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718809919; c=relaxed/simple;
	bh=BYVRKzfXBlXgDsIeh+DrronahvhHCjFkoWzYxDAk7vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=KB+73rPFR2gkFBu1h8Ymq1TRQY/zC50IDqxMXcrv0InYvQNzlejaxx0fEsPtf9OY+y7gZSxOAwSN7PiS7DgfuQIRxTWvusanutZSv5/hqCoIRpk3aGqzO4z4QjUIGfpQOitDI1+wGRf6bgj0p7EUtqWHJ0B31JUIdWLuWuCICuk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ei5asQwp; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45J9iYN0006366;
	Wed, 19 Jun 2024 15:11:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9Se0+N+BRJGDwyaVTI7sVgqfoiejlaZi69Y8Q01wbMA=; b=Ei5asQwpNT/vw6AW
	PQEpFexUEDg/HV3w6rfB2McH+V/mVoPENos+XizPqdNI19lF9fmeSEHlCfKfZHLv
	SUy5rtZwQrW+P7kIMQeE3DscE9nMs3UE2+zZwUSm4z2wXTnV/K+8KBVuKykzgmBo
	n8FnPbN11kZQMD+WrAIB8gjzFM0v7EzvihjqpVEtoTqgNJ10+j70wziCLg4bCC3B
	ZLFe4Vak9hWZiEbCtXvCv5fATfKpHoQxBC9soXWaRItsG5lyivDpxaB75rqsW2sg
	UKkppVw78zYzC4ysDHs4S+L1kWVhHUPaMW2H6wrhV1dmuxVPvtMFMkSMtMTLUL/8
	wFNxEw==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yuj9u23ww-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:11:45 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45JFBikK027380
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 19 Jun 2024 15:11:44 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 19 Jun 2024 08:11:39 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 19 Jun 2024 20:41:13 +0530
Subject: [PATCH v15 4/4] PCI: qcom: Add OPP support to scale performance
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240619-opp_support-v15-4-aa769a2173a3@quicinc.com>
References: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>
In-Reply-To: <20240619-opp_support-v15-0-aa769a2173a3@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1718809879; l=6802;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=BYVRKzfXBlXgDsIeh+DrronahvhHCjFkoWzYxDAk7vo=;
 b=xfSrAdLwl5e6ynaIZ8MN64QeNJZK4QpCSLdIQl4n2LAdN8loS4sEu+xEtHFsfGKpf8fegPBXj
 Tiwt2h1sptSDFi6XdUJ43CpSRHnw9rEKCx6E6cg2wINJpI17rskTp4i
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: wsb0iITbWDuTAA7HR84Zn3fvvRfHBxfA
X-Proofpoint-ORIG-GUID: wsb0iITbWDuTAA7HR84Zn3fvvRfHBxfA
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-19_02,2024-06-19_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 adultscore=0 mlxlogscore=999 clxscore=1015 mlxscore=0 phishscore=0
 bulkscore=0 impostorscore=0 spamscore=0 suspectscore=0 malwarescore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406190114

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
 drivers/pci/controller/dwc/pcie-qcom.c | 97 +++++++++++++++++++++++++++-------
 1 file changed, 78 insertions(+), 19 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ff1d891c8b9a..26405fcfa499 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -18,9 +18,11 @@
 #include <linux/io.h>
 #include <linux/iopoll.h>
 #include <linux/kernel.h>
+#include <linux/limits.h>
 #include <linux/init.h>
 #include <linux/of.h>
 #include <linux/pci.h>
+#include <linux/pm_opp.h>
 #include <linux/pm_runtime.h>
 #include <linux/platform_device.h>
 #include <linux/phy/pcie.h>
@@ -29,6 +31,7 @@
 #include <linux/reset.h>
 #include <linux/slab.h>
 #include <linux/types.h>
+#include <linux/units.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -1404,15 +1407,13 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
 	return 0;
 }
 
-static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
+static void qcom_pcie_icc_opp_update(struct qcom_pcie *pcie)
 {
+	u32 offset, status, width, speed;
 	struct dw_pcie *pci = pcie->pci;
-	u32 offset, status;
-	int speed, width;
-	int ret;
-
-	if (!pcie->icc_mem)
-		return;
+	unsigned long freq_kbps;
+	struct dev_pm_opp *opp;
+	int ret, freq_mbps;
 
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
@@ -1424,10 +1425,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
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
+		freq_mbps = pcie_dev_speed_mbps(pcie_link_speed[speed]);
+		if (freq_mbps < 0)
+			return;
+
+		freq_kbps = freq_mbps * KILO;
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq_kbps * width, true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set OPP for freq (%lu): %d\n",
+					freq_kbps * width, ret);
+		}
+		dev_pm_opp_put(opp);
 	}
 }
 
@@ -1471,7 +1488,9 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
 static int qcom_pcie_probe(struct platform_device *pdev)
 {
 	const struct qcom_pcie_cfg *pcie_cfg;
+	unsigned long max_freq = ULONG_MAX;
 	struct device *dev = &pdev->dev;
+	struct dev_pm_opp *opp;
 	struct qcom_pcie *pcie;
 	struct dw_pcie_rp *pp;
 	struct resource *res;
@@ -1539,9 +1558,42 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
+				      "Failed to set OPP for freq %lu\n",
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
@@ -1561,7 +1613,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1586,10 +1638,14 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
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
@@ -1622,6 +1678,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		ret = icc_disable(pcie->icc_cpu);
 		if (ret)
 			dev_err(dev, "Failed to disable CPU-PCIe interconnect path: %d\n", ret);
+
+		if (!pcie->icc_mem)
+			dev_pm_opp_set_opp(pcie->pci->dev, NULL);
 	}
 	return ret;
 }
@@ -1647,7 +1706,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	return 0;
 }

-- 
2.42.0


