Return-Path: <linux-pci+bounces-328-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id F2FF3800A5E
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 13:06:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 303151C20C25
	for <lists+linux-pci@lfdr.de>; Fri,  1 Dec 2023 12:06:42 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 05A42225D7;
	Fri,  1 Dec 2023 12:06:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Dmt90K3q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1C481722;
	Fri,  1 Dec 2023 04:06:37 -0800 (PST)
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B17bpKN004360;
	Fri, 1 Dec 2023 12:06:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=from : to : cc :
 subject : date : message-id : in-reply-to : references; s=qcppdkim1;
 bh=prNP5FasTEW2PoWfZxjSPeYpxqgOwouJysxEz0u+kH8=;
 b=Dmt90K3qjYDjT9n4LZx8x03TQSpltcbMHmhvH6dMMPZUTwyJ8T/7r7PxIu2Uvno0cMwk
 OqGxpyBW87CK1CMNmySH1/nckewHFqvQV8963Wysei96cSJDMcbnYmAt/T9hSV69AS8U
 vKFBxH7ccwzA1apOf/7t4k7ORMC7cp4SQLMEcECvjnafaegCdzTedCbToSHULCACT2EH
 DIAx2lbzDeu+ZsQnibjSmX6rSS4gkUMQWOzSXX+7ve4K+9mlLh43cpvRWR0myYJHdGFK
 M40Sb5SMgJKCQCAcoDYLQ/UEU4jtC1ZY6zvWrVre/CeIXg3etvKTjRAB9PDdboc7JRqA 7g== 
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3uq79h91c4-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Dec 2023 12:06:28 +0000
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTP id 3B1C6PSb020153;
	Fri, 1 Dec 2023 12:06:25 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3unmf08sjj-1;
	Fri, 01 Dec 2023 12:06:25 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 3B1C6PtO020147;
	Fri, 1 Dec 2023 12:06:25 GMT
Received: from hu-sgudaval-hyd.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.194])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTP id 3B1C6Pnj020146;
	Fri, 01 Dec 2023 12:06:25 +0000
Received: by hu-sgudaval-hyd.qualcomm.com (Postfix, from userid 3891782)
	id 6038A3064; Fri,  1 Dec 2023 17:36:24 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: agross@kernel.org, andersson@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, konrad.dybcio@linaro.org, mani@kernel.org,
        robh+dt@kernel.org
Cc: quic_shazhuss@quicinc.com, quic_nitegupt@quicinc.com,
        quic_ramkri@quicinc.com, quic_nayiluri@quicinc.com,
        dmitry.baryshkov@linaro.org, robh@kernel.org, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_parass@quicinc.com,
        quic_schintav@quicinc.com, quic_shijjose@quicinc.com,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>, linux-pci@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, mhi@lists.linux.dev
Subject: [PATCH v9 3/5] PCI: epf-mhi: Add "pci_epf_mhi_" prefix to the function names
Date: Fri,  1 Dec 2023 17:36:14 +0530
Message-Id: <1701432377-16899-4-git-send-email-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com>
References: <1701432377-16899-1-git-send-email-quic_msarkar@quicinc.com>
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: LHP9O9vjO-X4w41W2Lk-o4vrlyr1JVYQ
X-Proofpoint-GUID: LHP9O9vjO-X4w41W2Lk-o4vrlyr1JVYQ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-01_09,2023-11-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 bulkscore=0
 impostorscore=0 malwarescore=0 lowpriorityscore=0 priorityscore=1501
 adultscore=0 mlxscore=0 phishscore=0 suspectscore=0 spamscore=0
 mlxlogscore=746 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2311060000 definitions=main-2312010080
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>

From: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Without the prefix, the function name would appear as
"/sys/kernel/config/functions/{sdx55/sm8450}". This will be a problem if
multiple functions are supported for this endpoint device.

So let's add the "pci_epf_mhi_" prefix to identify _this_ function
uniquely. Even though it is an ABI breakage, this driver is not used
anywhere outside Qcom and myself to my knowledge. So it safe to change
the function name.

Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index b7b9d3e..5b0515a 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -677,8 +677,8 @@ static int pci_epf_mhi_probe(struct pci_epf *epf,
 }
 
 static const struct pci_epf_device_id pci_epf_mhi_ids[] = {
-	{ .name = "sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
-	{ .name = "sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
+	{ .name = "pci_epf_mhi_sdx55", .driver_data = (kernel_ulong_t)&sdx55_info },
+	{ .name = "pci_epf_mhi_sm8450", .driver_data = (kernel_ulong_t)&sm8450_info },
 	{},
 };
 
-- 
2.7.4


