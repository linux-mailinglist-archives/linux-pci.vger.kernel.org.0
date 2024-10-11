Return-Path: <linux-pci+bounces-14280-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id DA08E99A1E7
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 12:45:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 76A77B265DF
	for <lists+linux-pci@lfdr.de>; Fri, 11 Oct 2024 10:45:51 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 198B7216A19;
	Fri, 11 Oct 2024 10:45:03 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="gOFcQYSs"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 865F92141B9;
	Fri, 11 Oct 2024 10:45:01 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1728643502; cv=none; b=jkQooFh8BlxC+hgosUf0CFXpeQl/B9d9yfBZ4YtVNQF1ITgYzHVDE8GZXPGtIl+kBe+BQNMGI0B+cqhcGKSUhkLCaZQF2ILAQr+BgwFued0aYosSluocjWUEnPDlojFa4TzKw1f9Agdm2oCpdC0PCSQrKkCgkWRhdqX8k+HG0ZI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1728643502; c=relaxed/simple;
	bh=AC0jtNfFTl/zSciCq2rLaz6mf7W9IeDhLBASwG008cw=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=EZisQOgNJN2q3Bq5d6ZqT4BI3dU5Co7/XkPIi9bCdb4W5LG5zQ0xI+B2fFsPdZygrKRfv5WIq5Q5UKESfSQU16+EnYUldfv2hbiHKCXQYcTlHvDHS64916WGhqFx3GK8l9iGJ8Uv5jOYXh4+VF6Fh69WUBlHHaTFIuL14TpaXYM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=gOFcQYSs; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49B869w7014211;
	Fri, 11 Oct 2024 10:41:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=bPogcdfqVv1
	6bWCk+Z9Y1/hcsIco/NtXF8dpbiKItgQ=; b=gOFcQYSswC5raprfpva1X2kviHM
	Nc55+LpArIygaOtEQRbq19kivJaw1+RF3LDKfpcXYV1DKwvxtYAsf1Kq3cN+EZ/t
	kuojKmqgYu9M8yiwJeN6KupXNzisWN6yxtwh3Ne87YiGbLmqMgBhhUkUMV0JStx6
	1Pr88Y34+HwpfVEdLadY/y0Q4OQkri9Vp8yRpW+LKk21RWM35GQJ8vhYz04zfCYi
	rJ8kl/P2CtyBKJHI/XcHtsFUa53lJsqBFMPAkQ97oHxcpQlL63IMabd2A1yGKruk
	ZIKPvGwOkqiEegrlG6xVWQmg7/AmF9PD65UcSAlhi7jXglO+i5i4N256ZlQ==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 427077ggc9-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:49 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49BAfmA8026308;
	Fri, 11 Oct 2024 10:41:48 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 426wp7ac3h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:48 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49BAflXS026294;
	Fri, 11 Oct 2024 10:41:48 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 49BAfl5L026290
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 11 Oct 2024 10:41:47 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 9AD20651; Fri, 11 Oct 2024 03:41:47 -0700 (PDT)
From: Qiang Yu <quic_qianyu@quicinc.com>
To: manivannan.sadhasivam@linaro.org, vkoul@kernel.org, kishon@kernel.org,
        robh@kernel.org, andersson@kernel.org, konradybcio@kernel.org,
        krzk+dt@kernel.org, conor+dt@kernel.org, mturquette@baylibre.com,
        sboyd@kernel.org, abel.vesa@linaro.org, quic_msarkar@quicinc.com,
        quic_devipriy@quicinc.com
Cc: dmitry.baryshkov@linaro.org, kw@linux.com, lpieralisi@kernel.org,
        neil.armstrong@linaro.org, linux-arm-msm@vger.kernel.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org, Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v6 6/8] PCI: qcom: Fix the ops for SC8280X family SoC
Date: Fri, 11 Oct 2024 03:41:40 -0700
Message-Id: <20241011104142.1181773-7-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
References: <20241011104142.1181773-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-GUID: pk8frON1jYYhTsPVdgXVgN5VIrUcpjji
X-Proofpoint-ORIG-GUID: pk8frON1jYYhTsPVdgXVgN5VIrUcpjji
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 clxscore=1015 priorityscore=1501 mlxscore=0 impostorscore=0 bulkscore=0
 mlxlogscore=999 adultscore=0 suspectscore=0 spamscore=0 malwarescore=0
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410110073

On SC8280X family SoC, PCIe controllers are connected to SMMUv3, hence
they don't need the config_sid() callback in ops_1_9_0 struct. Fix it by
introducing a new ops struct, namely ops_1_21_0, so that BDF2SID mapping
won't be configured during init.

Fixes: d1997c987814 ("PCI: qcom: Disable ASPM L0s for sc8280xp, sa8540p and sa8295p")
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 88a98be930e3..468bd4242e61 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1367,6 +1367,16 @@ static const struct qcom_pcie_ops ops_2_9_0 = {
 	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
 };
 
+/* Qcom IP rev.: 1.21.0 */
+static const struct qcom_pcie_ops ops_1_21_0 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.post_init = qcom_pcie_post_init_2_7_0,
+	.host_post_init = qcom_pcie_host_post_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+};
+
 static const struct qcom_pcie_cfg cfg_1_0_0 = {
 	.ops = &ops_1_0_0,
 };
@@ -1405,7 +1415,7 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 };
 
 static const struct qcom_pcie_cfg cfg_sc8280xp = {
-	.ops = &ops_1_9_0,
+	.ops = &ops_1_21_0,
 	.no_l0s = true,
 };
 
-- 
2.34.1


