Return-Path: <linux-pci+bounces-6897-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 0064C8B7C64
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 17:58:01 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AF71328132D
	for <lists+linux-pci@lfdr.de>; Tue, 30 Apr 2024 15:58:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E5367172BD6;
	Tue, 30 Apr 2024 15:56:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nKHUy0nz"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 403F3172BC6;
	Tue, 30 Apr 2024 15:56:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714492601; cv=none; b=tUf663qPBcK6sMsjOuj27t0ejndRpfjdm2OkYCH4Noau3MISih0YN8DQvQB2Gg+kJy6ryQvI4U4Ao//W1Us5VyY4azJafbwrLRk5K9SAgBJUV5ZjJ/vLriC6zCRCsn2oumzotp7rzYK7pqeHoIQ/u3VEIsRUFAm95Fyx5JQjoDU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714492601; c=relaxed/simple;
	bh=u4IgZKgSqkJ8S3Q9RctjnjagFB4IRFtxZbCY1ltX7qM=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References; b=pEDnbE+9dtw79bx2RA+tk/I9DMh4gYlGL2wpjrxUiHD8qCdX7Gw91cAwdU4ekrTGg/1TPC2tUm4lW5WRz0as/QLY/erpAJ1F2XuCvljqWubzVtD5Rdz3EglSU3AY4Dx49ws9Rj9DTt0rhbo5mdq5S5vGRrm2d2T15jSFTS9PdDg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nKHUy0nz; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43UBMnse009744;
	Tue, 30 Apr 2024 15:56:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:in-reply-to:references; s=
	qcppdkim1; bh=Mpjm17i6B4MRL/9Zsqr4cHQqmIHEkNPKZyKlvRv22IU=; b=nK
	HUy0nzhzG568t4rYqiC4q05+6iaNRhdTXDDJwms4m4l4Aw3VLQu+mKLMVEje2bjb
	XbENnYn0obxTFSTRzxrtpjX0I0EdHcf78vjxy9V+xAcmi4ACc7M99VIIqycbV6UK
	PKgZsSdYR1PxPK4eN9GxiSN7r4sI5vTYD8khatGSvwiTBuV8mrrgTYFbbrAqoYgY
	Kiyw62obLhlAcybcPoTU3fyk+q5nlbRyGbEWWPxHVoMU/Bj9/BRy1uO4ldGLUuys
	W+AzqNVcur/KWxJV+xtb2cme8xsNQrJRVpcT/s90D2tpEEC0CltB2EJZAZEN/7LF
	nSGscyeI++7TseLxlCow==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xtyptgpba-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Apr 2024 15:56:32 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 43UFtqoJ032542;
	Tue, 30 Apr 2024 15:55:52 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3xrtem1a7v-1;
	Tue, 30 Apr 2024 15:55:52 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 43UFtqMf032537;
	Tue, 30 Apr 2024 15:55:52 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 43UFtqY6032516;
	Tue, 30 Apr 2024 15:55:52 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id C26F13BD6; Tue, 30 Apr 2024 21:25:51 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org,
        manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        quic_krichai@quicinc.com, quic_vbadigan@quicinc.com,
        quic_schintav@quicinc.com, Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v11 2/3] PCI: qcom-ep: Add support for SA8775P SOC
Date: Tue, 30 Apr 2024 21:25:38 +0530
Message-Id: <1714492540-15419-3-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
References: <1714492540-15419-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AnEdzKqwuJVEYGYEyiGS5N5-umweLOek
X-Proofpoint-ORIG-GUID: AnEdzKqwuJVEYGYEyiGS5N5-umweLOek
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-04-30_09,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0
 priorityscore=1501 adultscore=0 clxscore=1015 mlxscore=0 suspectscore=0
 malwarescore=0 impostorscore=0 lowpriorityscore=0 mlxlogscore=999
 spamscore=0 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404300112
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

Add support for SA8775P SoC to the Qualcomm PCIe Endpoint Controller
driver. Adding new compatible string as it has different set of clocks
compared to other SoCs.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 2fb8c15..a95c755 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -875,6 +875,7 @@ static void qcom_pcie_ep_remove(struct platform_device *pdev)
 }
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
+	{ .compatible = "qcom,sa8775p-pcie-ep", },
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },
 	{ }
-- 
2.7.4


