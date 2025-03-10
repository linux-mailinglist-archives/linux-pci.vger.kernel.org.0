Return-Path: <linux-pci+bounces-23271-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id CD797A58C02
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 07:32:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 72D98188CD24
	for <lists+linux-pci@lfdr.de>; Mon, 10 Mar 2025 06:32:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 640661D88D7;
	Mon, 10 Mar 2025 06:31:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="B4klIQUe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E546114B950;
	Mon, 10 Mar 2025 06:31:34 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1741588296; cv=none; b=AJ3fM1Rv4Fjg9QfdXrL9gGycH4/Db1Uy5s+4gS446pM0LZx9aoJL86/ML4E9qOqhSRk1kEBtyIuKQ5kpi9QrcDKxUQ8astV1Y9WU+rlMuy284h8CNCp76/zs8fg5r+jbX0X9nhcm7N+cpjPBSOOFW9RY4vjOC734Y0iCNJzH1ao=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1741588296; c=relaxed/simple;
	bh=G/mkANVPt4ZYteSY4Vukpj93mUz9PuyLwY0vlHH6ylQ=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=ElGWK1N6Z7Orx1SALLBSGNd8GFcEnfJ/7PPVvK/R72ed+0qaJSp26s7ARjPqO+LPaFW3W/qzQMcfgULRdwvbt9tLkfHQoNSDShAwQTV9DfhpznMU+y4BXIxUZuR4doIbFk3JSE+Yz0TLmkmQJbC+7LnpiMbMKId+VkQqqcd4Wjo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=B4klIQUe; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 529MHgwU017320;
	Mon, 10 Mar 2025 06:31:13 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=o25HtlPpF5B
	qO+rZFyBEt19nz2L9zjM1JEMojgwf2Ks=; b=B4klIQUeytvUc8P9K3J+cuoop5a
	/ooVNpQ88wEOEoJ1+EjJ4oSH68LeCGfTvd0fkMfWxnnm0knznjjMf+BO5Nddsr9u
	X3CjwBullCva3aknqp4KR6mbJjmTtf/z9t0eQikyLPi/eFBQkB5F0NcZ7JpvonQQ
	oVkn43j/3d31CA+cDVeDEWFa72iSIleYAv/W2JaPeRCg7ntpoz4p7GcPZH/qquls
	HyOiJP4OiPMiD2T8XOZ7CnrORwpyBvIGkZPWeHcgsvFazcdJB5LU7338yxZVDW5I
	GuGYSeCLMAFI08TIEh+2ngM1VPpWmZ7sat1/7FV04QW0cyiWjwF9uyE2WcA==
Received: from aptaippmta02.qualcomm.com (tpe-colo-wan-fw-bordernet.qualcomm.com [103.229.16.4])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 458f2mbqfq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 06:31:13 +0000 (GMT)
Received: from pps.filterd (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 52A6VBNC011103;
	Mon, 10 Mar 2025 06:31:11 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 458yu87f30-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 06:31:11 +0000
Received: from APTAIPPMTA02.qualcomm.com (APTAIPPMTA02.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 52A6V8LA011078;
	Mon, 10 Mar 2025 06:31:11 GMT
Received: from cse-cd02-lnx.ap.qualcomm.com (cse-cd02-lnx.qualcomm.com [10.64.75.246])
	by APTAIPPMTA02.qualcomm.com (PPS) with ESMTPS id 52A6VAfp011093
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 10 Mar 2025 06:31:10 +0000
Received: by cse-cd02-lnx.ap.qualcomm.com (Postfix, from userid 4438065)
	id 3BBDC27C8; Mon, 10 Mar 2025 14:31:09 +0800 (CST)
From: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
To: bhelgaas@google.com, lpieralisi@kernel.org, kw@linux.com,
        manivannan.sadhasivam@linaro.org, robh@kernel.org, krzk+dt@kernel.org,
        conor+dt@kernel.org, vkoul@kernel.org, kishon@kernel.org,
        andersson@kernel.org, konradybcio@kernel.org,
        dmitry.baryshkov@linaro.org, neil.armstrong@linaro.org,
        abel.vesa@linaro.org
Cc: quic_ziyuzhan@quicinc.com, quic_qianyu@quicinc.com,
        quic_krichai@quicinc.com, johan+linaro@kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pci@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-phy@lists.infradead.org
Subject: [PATCH v4 4/8] PCI: qcom: Add QCS8300 PCIe support
Date: Mon, 10 Mar 2025 14:30:59 +0800
Message-Id: <20250310063103.3924525-5-quic_ziyuzhan@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
References: <20250310063103.3924525-1-quic_ziyuzhan@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: OToZP1AO1xNHpaQuxdF5_Ae-GxjZLtph
X-Proofpoint-ORIG-GUID: OToZP1AO1xNHpaQuxdF5_Ae-GxjZLtph
X-Authority-Analysis: v=2.4 cv=ab+bnQot c=1 sm=1 tr=0 ts=67ce8731 cx=c_pps a=nuhDOHQX5FNHPW3J6Bj6AA==:117 a=nuhDOHQX5FNHPW3J6Bj6AA==:17 a=Vs1iUdzkB0EA:10 a=COk6AnOGAAAA:8 a=QK6PH6bWrdAnF5Ugu2sA:9 a=TjNXssC_j7lpFel5tvFf:22
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1093,Hydra:6.0.680,FMLib:17.12.68.34
 definitions=2025-03-10_02,2025-03-07_03,2024-11-22_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 priorityscore=1501 lowpriorityscore=0 bulkscore=0
 mlxscore=0 impostorscore=0 phishscore=0 clxscore=1015 spamscore=0
 adultscore=0 suspectscore=0 classifier=spam authscore=0 authtc=n/a authcc=
 route=outbound adjust=0 reason=mlx scancount=1 engine=8.19.0-2502100000
 definitions=main-2503100049

Add support for QCS8300 SoC that uses controller version 5.90 so reusing
the 1.34.0 config.

Signed-off-by: Ziyue Zhang <quic_ziyuzhan@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index e4d3366ead1f..7d917ab0b13f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1848,6 +1848,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-ipq9574", .data = &cfg_2_9_0 },
 	{ .compatible = "qcom,pcie-msm8996", .data = &cfg_2_3_2 },
 	{ .compatible = "qcom,pcie-qcs404", .data = &cfg_2_4_0 },
+	{ .compatible = "qcom,pcie-qcs8300", .data = &cfg_1_34_0 },
 	{ .compatible = "qcom,pcie-sa8540p", .data = &cfg_sc8280xp },
 	{ .compatible = "qcom,pcie-sa8775p", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,pcie-sc7280", .data = &cfg_1_9_0 },
-- 
2.34.1


