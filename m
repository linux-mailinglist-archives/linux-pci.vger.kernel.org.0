Return-Path: <linux-pci+bounces-3926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B58F38614AD
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 15:51:43 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D37D81C22E00
	for <lists+linux-pci@lfdr.de>; Fri, 23 Feb 2024 14:51:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CC644823D7;
	Fri, 23 Feb 2024 14:49:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="VJ1AqxM7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A1EF8288E;
	Fri, 23 Feb 2024 14:49:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1708699755; cv=none; b=gKpOcYzSyVKKeJMoUJF//09VttIBL4t1HQl6jF+zPZqdFSPig4a8GOrv84N1/rBX/Zm9KzzfcfjJoH+IVOGcZUpIei8EuOW4GHss268i9ovJWr3ZtbuHl50mhpTphbfewwznTEvuSIYKRgeQO+4NIk8mgoLWQionnOB2QEgH+9s=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1708699755; c=relaxed/simple;
	bh=htYpAfVMJfmMQf2P/nWz0eI+h8ja8l42Yw3ds3OE4gY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jLpxYRmS8yk10y+vEIqeetFd43gMlQQK244X0RvVvz61wZSM8icw6lNIFJH1S01aezIPTo0lA371+sAZWdOApD5zV48rd6gS1ZIHLxJ91vu3f7p+f03svJg0OFbdVbH/2m9phkrx+UbX+YUSbxf05pXqHamTITn3YICkOu70boQ=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=VJ1AqxM7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 41NCrBfm019756;
	Fri, 23 Feb 2024 14:49:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=bIFvd5a7Gq+s8Ic6RoQhPi68JfGBADm7tLEEN1LBupU
	=; b=VJ1AqxM7OzBjEdvu2+I5mOjHUThtdLiZKQb7f4FmKNgKXfBZwLIsY2rlNib
	EHVAMPmoivrAgQ3f2tn++zmfoRDiz00PTgLwAatyyeuMpfIhnpjp27keTYkRA4V5
	P992qcSo5ISzhlpp6ge50+f57FN42DrtjxREtHO2TgKNdHoi58u3oVq36KQo9E5i
	5ZMhHCMo26QLNd9bKwev7aaC70cgcI1OaMAfTY16kmEzpc2WHzBoVI6u1Dr4T1AJ
	9T4QnUXshaWh+mxfOVKgc1lCIHXWCeyg8drofrNngUMTPzqmH4u9PJx+0Str6yDg
	1NgTJW95awMoZj7bV9keHliUZgQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3weqxd0smt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:49:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 41NEn56g028193
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 23 Feb 2024 14:49:05 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 23 Feb 2024 06:48:58 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 23 Feb 2024 20:18:04 +0530
Subject: [PATCH v7 7/7] PCI: qcom: Add OPP support to scale performance
 state of power domain
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240223-opp_support-v7-7-10b4363d7e71@quicinc.com>
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
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1708699693; l=5956;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=htYpAfVMJfmMQf2P/nWz0eI+h8ja8l42Yw3ds3OE4gY=;
 b=lIvHrnTXWPXJJsZF+CsA/dI+cTiR0qbxRI6mJdzSmOXc1qwHl3GfBIs66kDtdAFz+bItYVZkn
 O1qkfQtZ05UBInrjF/b+Mwd57YyKvcCQyB8S/OtyNOXYSWAMCuv8YGP
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: YIg7-vSIXYn_5QVSpP1e4QxxXsRHnGE2
X-Proofpoint-ORIG-GUID: YIg7-vSIXYn_5QVSpP1e4QxxXsRHnGE2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-02-22_15,2024-02-23_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 impostorscore=0
 lowpriorityscore=0 bulkscore=0 mlxlogscore=999 malwarescore=0
 suspectscore=0 phishscore=0 spamscore=0 priorityscore=1501 adultscore=0
 clxscore=1015 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2402230108

QCOM Resource Power Manager-hardened (RPMh) is a hardware block which
maintains hardware state of a regulator by performing max aggregation of
the requests made by all of the clients.

PCIe controller can operate on different RPMh performance state of power
domain based up on the speed of the link. And this performance state varies
from target to target.

It is manadate to scale the performance state based up on the PCIe speed
link operates so that SoC can run under optimum power conditions.

Add Operating Performance Points(OPP) support to vote for RPMh state based
upon the speed link is operating.

OPP can handle ICC bw voting also, so move ICC bw voting through OPP
framework if OPP entries are present.

In PCIe certain speeds like GEN1x2 & GEN2x1 or GEN3x2 & GEN4x1 use
same bw and frequency and thus the OPP entry, so use frequency based
search to reduce number of entries in the OPP table.

Don't initialize ICC if OPP is supported.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 75 +++++++++++++++++++++++++++-------
 1 file changed, 61 insertions(+), 14 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 088ebd2e5865..c608bec8b9cb 100644
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
@@ -1404,16 +1406,14 @@ static int qcom_pcie_icc_init(struct qcom_pcie *pcie)
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
 	int ret;
 
-	if (!pcie->icc_mem)
-		return;
-
 	offset = dw_pcie_find_capability(pci, PCI_CAP_ID_EXP);
 	status = readw(pci->dbi_base + offset + PCI_EXP_LNKSTA);
 
@@ -1424,11 +1424,26 @@ static void qcom_pcie_icc_update(struct qcom_pcie *pcie)
 	speed = FIELD_GET(PCI_EXP_LNKSTA_CLS, status);
 	width = FIELD_GET(PCI_EXP_LNKSTA_NLW, status);
 
-	ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
-	if (ret) {
-		dev_err(pci->dev, "failed to set interconnect bandwidth: %d\n",
-			ret);
+	if (pcie->opp_supported) {
+		freq = PCIE_MBS2FREQ(pcie_link_speed[speed]);
+
+		opp = dev_pm_opp_find_freq_exact(pci->dev, freq * width, true);
+		if (!IS_ERR(opp)) {
+			ret = dev_pm_opp_set_opp(pci->dev, opp);
+			if (ret)
+				dev_err(pci->dev, "Failed to set opp: freq %ld ret %d\n",
+					dev_pm_opp_get_freq(opp), ret);
+			dev_pm_opp_put(opp);
+		}
+	} else {
+		ret = icc_set_bw(pcie->icc_mem, 0, width * QCOM_PCIE_LINK_SPEED_TO_BW(speed));
+		if (ret) {
+			dev_err(pci->dev, "failed to set interconnect bandwidth for pcie-mem: %d\n",
+				ret);
+		}
 	}
+
+	return;
 }
 
 static int qcom_pcie_link_transition_count(struct seq_file *s, void *data)
@@ -1471,8 +1486,10 @@ static void qcom_pcie_init_debugfs(struct qcom_pcie *pcie)
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
@@ -1539,9 +1556,36 @@ static int qcom_pcie_probe(struct platform_device *pdev)
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
+	 * Use highest OPP here if the OPP table is present. At the end of the probe(),
+	 * OPP will be updated using qcom_pcie_icc_opp_update().
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
+	/* Skip ICC init if OPP is supported as ICC bw vote is handled by OPP framework */
+	if (!pcie->opp_supported) {
+		ret = qcom_pcie_icc_init(pcie);
+		if (ret)
+			goto err_pm_runtime_put;
+	}
 
 	ret = pcie->cfg->ops->get_resources(pcie);
 	if (ret)
@@ -1561,7 +1605,7 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_phy_exit;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	if (pcie->mhi)
 		qcom_pcie_init_debugfs(pcie);
@@ -1612,7 +1656,7 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		pcie->suspended = true;
 	}
 
-	/* Remove cpu path vote after all the register access is done */
+	/* Remove CPU path vote after all the register access is done */
 	ret = icc_disable(pcie->icc_cpu);
 	if (ret) {
 		dev_err(dev, "failed to disable icc path of cpu-pcie: %d\n", ret);
@@ -1624,6 +1668,9 @@ static int qcom_pcie_suspend_noirq(struct device *dev)
 		return ret;
 	}
 
+	if (pcie->opp_supported)
+		dev_pm_opp_set_opp(pcie->pci->dev, NULL);
+
 	return 0;
 }
 
@@ -1646,7 +1693,7 @@ static int qcom_pcie_resume_noirq(struct device *dev)
 		pcie->suspended = false;
 	}
 
-	qcom_pcie_icc_update(pcie);
+	qcom_pcie_icc_opp_update(pcie);
 
 	return 0;
 }

-- 
2.42.0


