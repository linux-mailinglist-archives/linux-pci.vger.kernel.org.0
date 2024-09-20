Return-Path: <linux-pci+bounces-13322-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id F263597D415
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 12:19:02 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 7F2271F24D6A
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:19:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0053613F431;
	Fri, 20 Sep 2024 10:18:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="PuNwgga7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2E9CF13C9CB;
	Fri, 20 Sep 2024 10:18:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827513; cv=none; b=NbNBhIeXlXVqVfqaonWQ48KpI/+xR9L7qqhHR4XuTdM6Ii2qcYu0jH3BqvV5t8Fb/D/6vWZWyFVQWRiHESxJh4Dric0is2c/v7LxEee/FKmXq439+gPI5ZH2RRmNjMre5o4RgNgqWV+NjulZJ1FHaB4cQBlLeiRhHX30s2dl6R8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827513; c=relaxed/simple;
	bh=Jg3kUh3LENtboxvNsh4oHW5hZseAcTacMcPUOUeoOEU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=B54/BgUkG9xEd2tXSW7FDedLZ1TGZ7KiEctoH1QcVzH5W0UQXrvmsGAo4r+amZx4XqdRjwGYBHm8vJUpFqrGNHZmEDaa9M6RpYDuJ/koMINUEVUUjiNOdqbfl2LguX5mfpwjYLtDuh/UQJcMHhaaXOWhKYFc5UbqtAi1+ItZZl4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=PuNwgga7; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K7oppi005783;
	Fri, 20 Sep 2024 10:18:22 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	7OuHDf3BA4ON8W6lTL64xNpultpSc5zza/i9ehl7KEk=; b=PuNwgga7yeWB7I95
	IFeUxxdxI0KwinQlkifTS1fXVgFKtmWVKfHup2FsgAj1WNPSycn6MDP0R6AL09U1
	ZAqlnXsrVCZdz7Ag5ZmCozRN4vaWxCtNLnBOHtWty/IoU3kyau0VSX+Hrk8ccmiX
	vVQwiiqoHMeNjydEw7gdx/fV7oXt0t8DDDtfBNC4cEV23svLVy1/LUUsyv1l8cGk
	TnS+Z/spVTIZpeEKAOwUVwsE5b8C+9Z4LXg4wrjbGSv7GGHnLDTqzZXr8PFFLUgC
	+m5b6EnFO8T7C2wJldZZCmRLVb5YAn9vNEoFTDl+U19a7JRbLRxHKdxE5NEmRULI
	cx8MeA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4jj0s84-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 10:18:22 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48KAIIOt000988
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 10:18:18 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Sep 2024 03:18:13 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 20 Sep 2024 15:47:59 +0530
Subject: [PATCH v2 1/2] PCI: qcom: Skip wait for link up if global IRQ
 handler is present
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240920-remove_wait-v2-1-7c0fcb3b581d@quicinc.com>
References: <20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com>
In-Reply-To: <20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726827488; l=2707;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=Jg3kUh3LENtboxvNsh4oHW5hZseAcTacMcPUOUeoOEU=;
 b=d/KQfeZMOILbn0XfdkWrdeg29cVYm4vxmpr8wdx/nTSgaElg8uoa0gYT8CnZGG/Jw/2Ccxp+J
 3iQSQdbqrAfCffr2F69kAWtofZW4grLlGqDouXspIDh7wWfLXEQ15NH
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: yGJ3MWYGEtYf0jeZ7EtyQl2Xy5-6X2Gd
X-Proofpoint-GUID: yGJ3MWYGEtYf0jeZ7EtyQl2Xy5-6X2Gd
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 clxscore=1015 phishscore=0 impostorscore=0 bulkscore=0 adultscore=0
 suspectscore=0 lowpriorityscore=0 malwarescore=0 spamscore=0 mlxscore=0
 mlxlogscore=988 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2409200074

In cases where a global IRQ handler is present to manage link up
interrupts, it may not be necessary to wait for the link to be up
during PCI initialization which optimizes the bootup time.

Move platform_get_irq_byname_optional() above to set linkup_irq
before dw_pcie_host_init() as this flag is used in this function only.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 11 +++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  5 ++++-
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..b7d20a1bab0a 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -530,8 +530,15 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_remove_edma;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	/*
+	 * Note: The link up delay is skipped only when a link up IRQ is present.
+	 * This flag should not be used to bypass the link up delay for arbitrary
+	 * reasons.
+	 *
+	 * Ignore errors, the link may come up later.
+	 */
+	if (!pp->linkup_irq)
+		dw_pcie_wait_for_link(pci);
 
 	bridge->sysdata = pp;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index e518f81ea80c..b850f0a74695 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -348,6 +348,7 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	bool			linkup_irq;
 };
 
 struct dw_pcie_ep_ops {
diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 88a98be930e3..905c9154fc65 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1686,6 +1686,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	irq = platform_get_irq_byname_optional(pdev, "global");
+	if (irq > 0)
+		pp->linkup_irq = true;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
@@ -1699,7 +1703,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_host_deinit;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "global");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						qcom_pcie_global_irq_thread,

-- 
2.34.1


