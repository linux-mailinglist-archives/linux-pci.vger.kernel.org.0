Return-Path: <linux-pci+bounces-16040-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A952A9BCC5A
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 13:08:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BF1321C2280F
	for <lists+linux-pci@lfdr.de>; Tue,  5 Nov 2024 12:08:11 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5044A1D47C3;
	Tue,  5 Nov 2024 12:08:07 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="D7ilBz1H"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9CEE91420A8;
	Tue,  5 Nov 2024 12:08:05 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730808487; cv=none; b=thfmonRT3/juZffcETjXsOQnKYxaGmRTz1Z4UcwBAbqZROzo7CzfdUHB2vS9Rga6ymMC7tKxlshusnagbFt4eq+iUJCBALX4DduzydEdtnEQNsaFEo/2z55acI/saFtHJxCEk7olgp+xsEfSphE6cTnatA5aUEsmEi6iuGSdn90=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730808487; c=relaxed/simple;
	bh=/kqVLKSAToLpMYlZF7SwfQXhYepUQVt59Dvr/vkRwfg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=QJAvNvrI8Jbf6E9WfA1l9cJSlvwRSMOaiki7SEYVAr0B/nobs23FjOwkuhU1QzlkfEkvlDV+i1M4XGPcOMxxAubk+/xugE4mhszPuV9onOPaU6Ayj9cH0jF4kqzmrU+HyPCqQrTqXoZO1e1mfUEUSlKPBqVTmwfKlfxCiofwZfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=D7ilBz1H; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A59rhN8015691;
	Tue, 5 Nov 2024 12:07:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=oz0kIhBlG3QiX4+nJ8CPHc
	g2oCy+qLzPNL05ndtC0Yk=; b=D7ilBz1Hf/Te+k/4vrK6vi7b1oHbgvz8UwFSoC
	Fm/33Bl7E5wL8l8cVbMt8b9A8TibTCA3Em9HcFjlYqtHIxKvNL539X3cHDjUyaJB
	46x6BmQSUjiQKQBuMCEymkjWwp5Hle4kGD64ZU3rMr4rvV/YX59QjvtQE0ppCkBC
	CxBtIi+kkUHMU+ckTkkJaZzkYNseFylNADRPWzrsYgZt9i9bkfepiTVeRYI1Hg46
	wDS+RcD+RGib4BRZdkUuym5QQl/mELrBxn7TK9DNvDODAJ7AGzOqM8VjE0TEgVl5
	hd7gz5mEBKxiL51k2+yp+AL24O//K07XYFMFGL/3PTIaj/9g==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42nd4yqecx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Nov 2024 12:07:54 +0000 (GMT)
Received: from nasanex01c.na.qualcomm.com (nasanex01c.na.qualcomm.com [10.45.79.139])
	by NASANPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A5C7ruV012660
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Nov 2024 12:07:53 GMT
Received: from zhonhan-gv.qualcomm.com (10.80.80.8) by
 nasanex01c.na.qualcomm.com (10.45.79.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 5 Nov 2024 04:07:51 -0800
From: Zhongqiu Han <quic_zhonhan@quicinc.com>
To: <manivannan.sadhasivam@linaro.org>, <kw@linux.com>, <kishon@kernel.org>,
        <bhelgaas@google.com>, <lpieralisi@kernel.org>, <dlemoal@kernel.org>
CC: <quic_zhonhan@quicinc.com>, <mhi@lists.linux.dev>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: [PATCH] PCI: epf-mhi: Fix potential NULL dereference in pci_epf_mhi_bind()
Date: Tue, 5 Nov 2024 20:07:35 +0800
Message-ID: <20241105120735.1240728-1-quic_zhonhan@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nasanex01c.na.qualcomm.com (10.45.79.139)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: pbjjv8jdCXNqXKAHFywCM8kyacJ0uTRB
X-Proofpoint-ORIG-GUID: pbjjv8jdCXNqXKAHFywCM8kyacJ0uTRB
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=801
 malwarescore=0 bulkscore=0 impostorscore=0 priorityscore=1501
 lowpriorityscore=0 mlxscore=0 phishscore=0 clxscore=1011 adultscore=0
 spamscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411050093

If platform_get_resource_byname() fails and returns NULL, dereferencing
res->start will cause a NULL pointer access. Add a check to prevent it.

Fixes: 1bf5f25324f7 ("PCI: endpoint: Add PCI Endpoint function driver for MHI bus")
Signed-off-by: Zhongqiu Han <quic_zhonhan@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7d070b1def11..2712026733ab 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -873,6 +873,11 @@ static int pci_epf_mhi_bind(struct pci_epf *epf)
 
 	/* Get MMIO base address from Endpoint controller */
 	res = platform_get_resource_byname(pdev, IORESOURCE_MEM, "mmio");
+	if (!res) {
+		dev_err(&pdev->dev, "Failed to get MMIO base address\n");
+		return -ENODEV;
+	}
+
 	epf_mhi->mmio_phys = res->start;
 	epf_mhi->mmio_size = resource_size(res);
 
-- 
2.25.1


