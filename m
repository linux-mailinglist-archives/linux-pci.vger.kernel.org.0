Return-Path: <linux-pci+bounces-15795-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 01A859B9054
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 12:35:08 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 75BA8B21668
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 11:35:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3A29F194C89;
	Fri,  1 Nov 2024 11:34:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DXrjFqCI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2BB2415F330;
	Fri,  1 Nov 2024 11:34:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460882; cv=none; b=N14PmQ8D8eUzpSjWxW7ocYXedApqpxdTe4pJQVPt6GrV0Ha1J1313c+eiQRpNF5VmdPYjehhPsldrBGqX/dZiZiVsiFcYEmEy1DuirFXd/eLIUHCUygXAPg67KsLsQaVCZQ558iGsXq1ee0hlFEICdsTvGgQtTIC7YH0ubFR9x8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460882; c=relaxed/simple;
	bh=ufOJLCActkFLj7Eefuq3LyPZ31PRj6Do4jEsG4+Ul+U=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=UoAAw2aCR1PNs8U73RPh5l+cIVMsS8KnTz5zynGkkpbGMzd2uzyai+XITuXN0cs9p46P2+Qe0Rc9KG8t3CXmq7cpZvgSExKkK5dqxx90YtznVBDTwttVikoeuI59HmbMNxIY/p9v86uYRLobgBOPRccfTm94x06AQh74NIXEqp4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DXrjFqCI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A14sYHM009544;
	Fri, 1 Nov 2024 11:34:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24FYY6rD9PA41qaPwE7AbrcckRbR+ehk473LrJat09w=; b=DXrjFqCIAZoY8OaE
	MXLIIDBqpmH78MqFPCw6O+XtjaetQ4vMdZM6LQCMIUGKJDWU4uBkTV0QezeNfNNg
	uHOO1aSucjI0OHoHr1iESL8MJmzFGP7iiZQD1MwaWX2Z8IYOMgQMABY7zJsJL9s0
	XAQQ/vqHEuA94F5Ff4hSgxpcTQEjyPO+obHD7TrSPqiQUlSH/t52kOyrAlcHRZN+
	Trz7I1YqW+1noBo/12Wkbntptr2+8wwcJANjRJ/3b3Kq8J4bpX4QqlzKZ7XC3ItT
	zIJkFaL6AeOi3MCcBMi+8wM4Hsma/yB8TYY5QdvPvERoC4wHk6HLERV4LH3Sop1C
	6Nj28g==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42mrce1a0g-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 11:34:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1BYRHG031485
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 11:34:27 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 04:34:24 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 1 Nov 2024 17:04:13 +0530
Subject: [PATCH v3 2/3] PCI: qcom: Set linkup_irq if global IRQ handler is
 present
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241101-remove_wait-v3-2-7accf27f7202@quicinc.com>
References: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
In-Reply-To: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730460856; l=1458;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=ufOJLCActkFLj7Eefuq3LyPZ31PRj6Do4jEsG4+Ul+U=;
 b=xrCuwjclQW82d5Ve6JKGIpPgo1NNeuKbFWWyZQ/mXTRN6j56wXvrhMvu70z6prxxoCpqhFsXR
 jAqhXHoh0+qBUCd98WyqRD8spk+KXOe3MZCMvNenu2KM53FgihDafyH
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MB2Cf9J33gKZxZLxjAKMUtJkLCU0O3Bw
X-Proofpoint-ORIG-GUID: MB2Cf9J33gKZxZLxjAKMUtJkLCU0O3Bw
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 impostorscore=0 adultscore=0 priorityscore=1501 phishscore=0 mlxscore=0
 spamscore=0 mlxlogscore=735 suspectscore=0 clxscore=1015
 lowpriorityscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411010083

In cases where a global IRQ handler is present to manage link up
interrupts, it may not be necessary to wait for the link to be up
during PCI initialization which optimizes the bootup time.

So, set linkup_irq flag if global IRQ is present and In order to set the
linkup_irq flag before calling dw_pcie_host_init() API, which waits for
link to be up, move platform_get_irq_byname_optional() API
above dw_pcie_host_init().

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef44a82be058..474b7525442d 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1692,6 +1692,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	irq = platform_get_irq_byname_optional(pdev, "global");
+	if (irq > 0)
+		pp->linkup_irq = true;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
@@ -1705,7 +1709,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_host_deinit;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "global");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						qcom_pcie_global_irq_thread,

-- 
2.34.1


