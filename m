Return-Path: <linux-pci+bounces-17226-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 0C1089D6473
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 20:10:57 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id C6B75283E43
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 19:10:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A55351E008B;
	Fri, 22 Nov 2024 19:10:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="h63kUd6n"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1093F1DFE35;
	Fri, 22 Nov 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302632; cv=none; b=R6DdTsNyCGYV//B5ZSYbaXhRhBgwK4RL7boMAty1XpgrN5RR8ULNKn+iwXkOGFv3MowXCQ66t3rwwjCHmIZAjqN3c+pUt5NbEekELhtYG8/1B8zbUU3ln02xf8Mfd/GbqN2i8aY3fPsaiLq2c0RXVa/WVEV/2Ta3CJdi5Gp8u1A=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302632; c=relaxed/simple;
	bh=ZFOBw3BMKmVGtHb0UcVh69Xu/bqSKbBzvXx11WmbKHM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=sGc2QkJP73CDyKza3fFuQws15OS6ez5jSSc7APgytUwa4CrsEH+DbCpLYR+9jg5G0CMKkQnhRScrbvrLs7s+9iA7sQU6qdVXzkVqMQ98LlR8rRJIFUz+SIZiy7wuJb2o35ELVpouqHOI9ETOSZ2EJWjjqyL78aGvnIKLQLQqvHs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=h63kUd6n; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMA6jep027595;
	Fri, 22 Nov 2024 19:10:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Rtxr6wdyL9/5iSlhYv7c+jUJ0eJ4nm8qOAAHZrWd3p0=; b=h63kUd6nyrUY9Fvo
	9OKbMLHjNIo2bYUVRfKgepG+ZNA5xFZm4rL7CMWnqHgpXiK8E3Anof1rfSCgUE85
	/dvw0TyCEI+N+NwwPmnEUXAJ5pTQntLTvZ1KSXtdInQpQNEHfPuOKBl51NpDeoWz
	5qyWzQ9KZUoYxHIChTbql60BPpfSQJs7n7jmFHLTgtzC+dkwAy+ID5Ph1dlJHmzL
	EYyUMwnPiCSm2v4KnTM86FhP0t8sn4jJTpULFuadcsPAO0Ib0SgUxYkhUtdNLpqf
	CV4cXue/ukLVXOyKN6v+5upFMAeCyCr0iCnS0FkEOcOSempPoy1/dVoaHrXXVLr8
	ouOwDQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432d5b2vqr-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:20 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AMJAKbm015246
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:20 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Nov 2024 11:10:15 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 23 Nov 2024 00:40:00 +0530
Subject: [PATCH v5 2/3] PCI: qcom: Set use_linkup_irq if global IRQ handler
 is present
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241123-remove_wait2-v5-2-b5f9e6b794c2@quicinc.com>
References: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
In-Reply-To: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
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
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_mrana@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732302607; l=1542;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=ZFOBw3BMKmVGtHb0UcVh69Xu/bqSKbBzvXx11WmbKHM=;
 b=DOXfm8XYstztEIabuC/cLDFkQtaMpv0Sqc+5ujDinZdWjwyqgy4kxNKI9FEKOp0G7OpG8XDwD
 +Qru1/8xj6JAuGs/4Gqlt5UimkEA6gG22AJmn4YSeytKCcHCfItHHGD
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: woxJ4f__5UlQBKRuKLjkZKvG7ImsIuX7
X-Proofpoint-ORIG-GUID: woxJ4f__5UlQBKRuKLjkZKvG7ImsIuX7
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 phishscore=0 adultscore=0 clxscore=1015 impostorscore=0 suspectscore=0
 spamscore=0 bulkscore=0 lowpriorityscore=0 mlxlogscore=889 mlxscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220161

In cases where a global IRQ handler is present to manage link up
interrupts, it may not be necessary to wait for the link to be up
during PCI initialization which optimizes the bootup time.

So, set use_linkup_irq flag if global IRQ is present and in order to set
the use_linkup_irq flag before calling dw_pcie_host_init() call, which
waits for link to be up, move platform_get_irq_byname_optional() API
above dw_pcie_host_init().

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index dc102d8bd58c..656d2be9d87f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1703,6 +1703,10 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 
 	platform_set_drvdata(pdev, pcie);
 
+	irq = platform_get_irq_byname_optional(pdev, "global");
+	if (irq > 0)
+		pp->use_linkup_irq = true;
+
 	ret = dw_pcie_host_init(pp);
 	if (ret) {
 		dev_err(dev, "cannot initialize host\n");
@@ -1716,7 +1720,6 @@ static int qcom_pcie_probe(struct platform_device *pdev)
 		goto err_host_deinit;
 	}
 
-	irq = platform_get_irq_byname_optional(pdev, "global");
 	if (irq > 0) {
 		ret = devm_request_threaded_irq(&pdev->dev, irq, NULL,
 						qcom_pcie_global_irq_thread,

-- 
2.34.1


