Return-Path: <linux-pci+bounces-16861-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id B415F9CDC97
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:31:30 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 43D571F22A9C
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:31:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 793651B6D09;
	Fri, 15 Nov 2024 10:30:51 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gBDMAkDD"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E87761B6CFC;
	Fri, 15 Nov 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666651; cv=none; b=Vk4ww96HNZ0e0ZKXeFMAXHUtFgbzZFkfKcG9a4nhKDJxZeEWvx1Ydeynz3BK8CmichIAQRFHssvMI5yRovB6yTDoIdzUJyeqwhM/TK6FHMhAhsFJSvUDJrgCsiSWOcso7Whc0I9res37mVY1s82wHP1jhgI4FaCTvvIm2oj7DLo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666651; c=relaxed/simple;
	bh=1g9ovhFlUsWtAx757genx6afRDjob3rmWUH2d/1UyGA=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=cRAn5QpXRync46696oFMtE7E528dfTXX1O3WLETBYrsTsybBAwsD29/wPGDQvP2Jzs8fqbfZWLB5oCgQF+XTWFdm15K5/4z2gCjkWf1EjuVbSihrPitvVxfN+NL2Qsa5bnVCHLrQKbrffdeGo1Ez23IU1BjVkButokbSmU8k44Q=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gBDMAkDD; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF23ajN002248;
	Fri, 15 Nov 2024 10:30:42 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	uRnnirF0DYMuipocjmJ5X+ln7EFceOeemon/UN+2LLY=; b=gBDMAkDDQeYo756Q
	H5D6nmzQ061eAEA/b9/zJd18nTvdKfuXp3WlOm+iTiXeVZGF4VUIQ7/7r9xmmXxD
	h+O0wWyHZ+erEw4tOoZFug3qiP1wMYXFABfMGIf7GaaTsoOp6DXsj4f7zp7Ja9k0
	erl09FLUzfnx2Sn47xyB7IkklaGxjbE+KWA3Wbmq9kEcBsh/1ysPplcqzZnb5yeb
	XRnJxsVRWb1uwPZPZFFenS4FCZPpBcuq9vFxNZCaFUGDzubpE9JQMqjTbyovgtQG
	dDmVt8Eln81jGEa/F/v0UPzji5x3o0USO+P3MeuY75Oq7cFbMwZhueDXZTY6ZOS6
	Cjno8A==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ww6ds8p6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:42 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAUfGT030985
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:41 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:30:36 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 15 Nov 2024 16:00:22 +0530
Subject: [PATCH v4 2/3] PCI: qcom: Set linkup_irq if global IRQ handler is
 present
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241115-remove_wait1-v4-2-7e3412756e3d@quicinc.com>
References: <20241115-remove_wait1-v4-0-7e3412756e3d@quicinc.com>
In-Reply-To: <20241115-remove_wait1-v4-0-7e3412756e3d@quicinc.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_mrana@quicinc.com>,
        <andersson@kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731666627; l=1470;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=1g9ovhFlUsWtAx757genx6afRDjob3rmWUH2d/1UyGA=;
 b=wvsvHQHPyVmBa4F8c+OjrYgFAMYfcs+v59qQ+M4Ns+I1n2tcFAZTZBuIOf84LpEO9W8HkKFhc
 /lf/EPOVo6lDY9mcBgu+rnSVJFGDMwPGl33lgLVgsExF3APHSihZaDL
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: MxTWkohIVfYxfC0kxbjE6BaKRK-7DZhL
X-Proofpoint-GUID: MxTWkohIVfYxfC0kxbjE6BaKRK-7DZhL
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501 mlxscore=0
 phishscore=0 malwarescore=0 lowpriorityscore=0 impostorscore=0
 suspectscore=0 clxscore=1015 adultscore=0 mlxlogscore=869 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150089

In cases where a global IRQ handler is present to manage link up
interrupts, it may not be necessary to wait for the link to be up
during PCI initialization which optimizes the bootup time.

So, set use_linkup_irq flag if global IRQ is present and In order to set
the use_linkup_irq flag before calling dw_pcie_host_init() API, which
waits for link to be up, move platform_get_irq_byname_optional() API
above dw_pcie_host_init().

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef44a82be058..c39d1c55b50e 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1692,6 +1692,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	irq = platform_get_irq_byname_optional(pdev, "global");
+	if (irq > 0)
+		pp->use_linkup_irq = true;
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


