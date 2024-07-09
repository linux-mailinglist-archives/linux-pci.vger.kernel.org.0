Return-Path: <linux-pci+bounces-10001-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 4627392BD92
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 16:57:43 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id ECE8428782F
	for <lists+linux-pci@lfdr.de>; Tue,  9 Jul 2024 14:57:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 7BFB019CD06;
	Tue,  9 Jul 2024 14:57:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k/R4UAdb"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E00C519CCF6;
	Tue,  9 Jul 2024 14:57:13 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720537035; cv=none; b=M8cjsQvIgdFw4PB51xxot0uNRDpxhKtx4ZehLr4RRPHgAyfCId9C1OrkVrWQZmbCoGgf0TaeANRRczLHZKCMfGMHgMvVgY3CUbPpT/SYkdx7vAvePUz2/hn94nbL2v/tzq37x9DDhXcNFSKtKvPg+eWMOkQvmYx3o9jIz1bMQlI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720537035; c=relaxed/simple;
	bh=q183F0/HFGC/8U/gLjzUqH8Bv64w+2hrHp8UiRG815A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=h9T9ngcaoWQb39fxjKU1c7HRdbuh6yf3IeTBRWLGLGD2wdcZXrW1IoUiiWuj9wgojWPxRmKSQnO8cGOrMpL26eptoOOrkzReUvm8t1mQBaJ5NWbCMQuB5ub5nOEDq7UJJVGzzudfJJQ3BBUWl29c1LFokR1K4LQFpqHByxRelmg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k/R4UAdb; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 469A7KVD012432;
	Tue, 9 Jul 2024 14:54:05 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	CSDkESbCmZqUgbZ09QMkhUrOl3ltgh7Fjn3q70aFm1M=; b=k/R4UAdb5OrEjdUi
	18iOvHVTqKYUXYx7R46QfueRAIYntkh0OOR6S6GDVDV6CmF/vPq1gvqKdYaJBpUZ
	jyGRGEy9dam/aVAkwipkF6/QP9ZPUHBKgSNfVKgtQc6j5TqGj/Ez8T2pQZKp3T/k
	SrWkKhYGM6afqqoKLNP5zJPT6leB3unFS+ycOpfQJPfJZ57GsNtpukKQYCDCpevi
	tWxlOFcMl0hO+vJxxrbqE/vWSD7jp219ubVpy1f3mhmdDgM84L2wriSEUH0enZGZ
	zMQjvo6x8zuFA6DzZcwNn4T2JzTuzunk5ZzQw54APcAgE+vzx28kXpWSHUaRwHW7
	w338WA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406x0t70d4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Jul 2024 14:54:05 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 469Es39i022682
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Jul 2024 14:54:04 GMT
Received: from tengfan-gv.ap.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 9 Jul 2024 07:53:58 -0700
From: Tengfei Fan <quic_tengfan@quicinc.com>
Date: Tue, 9 Jul 2024 22:53:44 +0800
Subject: [PATCH v2 2/2] PCI: qcom-ep: Add HDMA support for QCS9100 SoC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240709-add_qcs9100_pcie_ep_compatible-v2-2-217742eac32b@quicinc.com>
References: <20240709-add_qcs9100_pcie_ep_compatible-v2-0-217742eac32b@quicinc.com>
In-Reply-To: <20240709-add_qcs9100_pcie_ep_compatible-v2-0-217742eac32b@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Lorenzo
 Pieralisi" <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>
CC: <kernel@quicinc.com>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, Tengfei Fan <quic_tengfan@quicinc.com>
X-Mailer: b4 0.15-dev-a66ce
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720536832; l=1616;
 i=quic_tengfan@quicinc.com; s=20240709; h=from:subject:message-id;
 bh=q183F0/HFGC/8U/gLjzUqH8Bv64w+2hrHp8UiRG815A=;
 b=x91GX2Ia9pAYVTMaewFVd/hPIWWGFBfLU9N3N31guIhozOdaji+JGEv53rHm2j57YMAwZaRjQ
 bxidEQXStQACkxrVqP4TSNMgIABdpoeiMlDzBCF8kmH5q0o8gWmFTuS
X-Developer-Key: i=quic_tengfan@quicinc.com; a=ed25519;
 pk=4VjoTogHXJhZUM9XlxbCAcZ4zmrLeuep4dfOeKqQD0c=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: AA7X_SZwvdZ6RL3bOpGGaLv4OhPi776m
X-Proofpoint-ORIG-GUID: AA7X_SZwvdZ6RL3bOpGGaLv4OhPi776m
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-09_04,2024-07-09_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 lowpriorityscore=0 impostorscore=0 adultscore=0 suspectscore=0
 phishscore=0 mlxlogscore=970 priorityscore=1501 malwarescore=0 spamscore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407090097

QCS9100 SoC supports the new Hyper DMA (HDMA) DMA Engine inside the DWC IP,
so add support for it by passing the mapping format and the number of
read/write channels count.

The PCIe EP controller used on this SoC is of version 1.34.0, so a separate
config struct is introduced for the sake of enabling HDMA conditionally.

It should be noted that for the eDMA support (predecessor of HDMA), there
are no mapping format and channels count specified. That is because eDMA
supports auto detection of both parameters, whereas HDMA doesn't.

QCS9100 is drived from SA8775p. Currently, both the QCS9100 and SA8775p
platform use non-SCMI resource. In the future, the SA8775p platform will
move to use SCMI resources and it will have new sa8775p-related device
tree. Consequently, introduce "qcom,qcs9100-pcie-ep" to the PCIe device
match table.

Signed-off-by: Tengfei Fan <quic_tengfan@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom-ep.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom-ep.c b/drivers/pci/controller/dwc/pcie-qcom-ep.c
index 236229f66c80..e2775f4ca7ee 100644
--- a/drivers/pci/controller/dwc/pcie-qcom-ep.c
+++ b/drivers/pci/controller/dwc/pcie-qcom-ep.c
@@ -904,6 +904,7 @@ static const struct qcom_pcie_ep_cfg cfg_1_34_0 = {
 };
 
 static const struct of_device_id qcom_pcie_ep_match[] = {
+	{ .compatible = "qcom,qcs9100-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sa8775p-pcie-ep", .data = &cfg_1_34_0},
 	{ .compatible = "qcom,sdx55-pcie-ep", },
 	{ .compatible = "qcom,sm8450-pcie-ep", },

-- 
2.25.1


