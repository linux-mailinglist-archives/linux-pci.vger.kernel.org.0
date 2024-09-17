Return-Path: <linux-pci+bounces-13263-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 88A4A97AF2B
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 12:47:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 67845B24BA5
	for <lists+linux-pci@lfdr.de>; Tue, 17 Sep 2024 10:46:48 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7931613B7AF;
	Tue, 17 Sep 2024 10:46:43 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EWkigtX3"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DC068219ED;
	Tue, 17 Sep 2024 10:46:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726570003; cv=none; b=N4FwbtTKtB4afw/df3SMZ+3XL3Jyyb6ACwjNJDyrpzI2avRfLErfJ7xq8zm686pWSFqxQ6jb82qONJcDznvBKRMiaSbKLv3mFvEyZ1NVQwuzDWXG8QsdzqNXzQjqFMx7AVeFNfJD1zs8ChZwAvEz9KnqaG1uJ3qWXuzBgTJLxek=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726570003; c=relaxed/simple;
	bh=VwgbqRmMuYTyDjqru++XjKig9TQvq7qY0bPQ4ERYZMg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=dxikbwAqdKZz0bTjjzuyuPbXksc76F+OYUCboccl6fDWYbnJztV3aoazO+bCU/+eBroVT/ndDCjZ2q3+ew7gfK8dqad3zkFlrGM6yA1yGRgjNGBH0Kl4+w/THcIJyNIwOSin26neO/d0fIu9kiISPAMPpJwI2aXk+iIM9BsJCBw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EWkigtX3; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48H4Aron023009;
	Tue, 17 Sep 2024 10:46:34 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=uNL4ElfLyO5/Hxpc1u+Bcf
	TC25dN+5QyzOqW/uDWKlk=; b=EWkigtX3pWXCOy5Tbhrg8lnrYYbfmAFF6/9oZA
	CyB4fKKbXHHqTm2B/01I3X2RTOSTX8v2RJLSXnr9ETzzRfx80dddCEUd8/sDoRrU
	rDVejMk5Z/ciHqm8PiUZ62oeicmY9MXVEz/R+SYZ+tofA60DKEcwyGg78SNWEqOW
	9mImOlsBu033GtVgSYyurrpTEvU/Uloi8OiBc9ZKuLjlObo38/NK7WYyI6Rziz8o
	glB8q2pTkvykCvZbKUvQ5dYwNAhArEhgsXBjkOjImbR03aj47wBLeWn+DrWeTf8B
	Pj2ZPfbraRIbd5i9EA+/yLGa4U7zi9ZyApa69o5E7udU+SAA==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jdpj97-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 10:46:34 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48HAkXmT031148
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 17 Sep 2024 10:46:33 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 17 Sep 2024 03:46:28 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 17 Sep 2024 16:16:20 +0530
Subject: [PATCH] PCI: qcom: Skip wait for link up if global IRQ handler is
 present
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240917-remove_wait-v1-1-456d2551bc50@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAPtd6WYC/1XMQQ7CIBCF4as0sxYDhKq48h6mMRQGO4sWhYqah
 ruLTVy4/F/yvgUSRsIEx2aBiJkShamG2DRgBzNdkZGrDZJLxbUQLOIYMl6ehmZmnNpJdXBWew7
 1cYvo6bVq5672QGkO8b3iWXzXnyP/nCyYYHrvle9963rXnu4PsjTZrQ0jdKWUD51TOQSoAAAA
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726569988; l=3046;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=VwgbqRmMuYTyDjqru++XjKig9TQvq7qY0bPQ4ERYZMg=;
 b=VsXWHIU4Kh0jK9AgQj+PMMsiGPy6VBUR3XVayM6dnnh0uogoZNFk3R91vilnE/9rWW4squtzq
 aPS2pbRTq5zDoyBbwMEt3yraga8/KYB/1doPoJBgKi8kvVnBiFXSg6f
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: oKPnwRu_0Z3vgc9B1TSmBpiTvf-nhpCz
X-Proofpoint-GUID: oKPnwRu_0Z3vgc9B1TSmBpiTvf-nhpCz
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 impostorscore=0
 clxscore=1015 adultscore=0 mlxscore=0 suspectscore=0 malwarescore=0
 priorityscore=1501 spamscore=0 bulkscore=0 lowpriorityscore=0
 mlxlogscore=881 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409170077

In cases where a global IRQ handler is present to manage link up
interrupts, it may not be necessary to wait for the link to be up
during PCI initialization which optimizes the bootup time.

Move platform_get_irq_byname_optional() above to set bypass_link_up_wait
before dw_pcie_host_init() as this flag is used in this function only.

And also as part of the PCIe link up event, update ICC and OPP values.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 3 ++-
 drivers/pci/controller/dwc/pcie-designware.h      | 1 +
 drivers/pci/controller/dwc/pcie-qcom.c            | 7 ++++++-
 3 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..e0ddfaf9f87a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -531,7 +531,8 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	}
 
 	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	if (!pp->bypass_link_up_wait)
+		dw_pcie_wait_for_link(pci);
 
 	bridge->sysdata = pp;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e518f81ea80c..7fe0e9b1b095 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -348,6 +348,7 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	bool			bypass_link_up_wait;
 };
 
 struct dw_pcie_ep_ops {
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 88a98be930e3..bcb8c60453ba 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1552,6 +1552,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pp->bridge->bus);
 		pci_unlock_rescan_remove();
+
+		qcom_pcie_icc_opp_update(pcie);
 	} else {
 		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
 			      status);
@@ -1686,6 +1688,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	irq = platform_get_irq_byname_optional(pdev, "global");
+	if (irq > 0)
+		pp->bypass_link_up_wait = true;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
@@ -1699,7 +1705,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_host_deinit;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "global");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						qcom_pcie_global_irq_thread,

---
base-commit: 9aaeb87ce1e966169a57f53a02ba05b30880ffb8
change-id: 20240911-remove_wait-ad46248dc9f0

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


