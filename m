Return-Path: <linux-pci+bounces-14720-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2F1919A18F4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 05:04:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 53F8F1C247A4
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 03:04:44 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C49113635C;
	Thu, 17 Oct 2024 03:04:36 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="aCwUxNT8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3712538FB0;
	Thu, 17 Oct 2024 03:04:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729134276; cv=none; b=pFAYniORk3+92ktyrXsrqrJpYIitu0j0twxQaRfxfRXz6MD9Lh+DRV5JgfJAXu7o38z0rmUZ0Y9Ztm4ZZooVqqFqg9O0vvGUHs8R+jddS0QHbTubL1Me6/8u/bQaI+O7XE35KRGxQ2jPD0ktObyezsJKu/TOkac/3QQ1zjEeslw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729134276; c=relaxed/simple;
	bh=8zE3Xr5JP9ncFstx5jErEw2s/5yzdYBpkFZheyslSNs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=j90hNBKcXAU+04+rIucvB9TmUin25X4LawMNiFeZQ1fJIGqE18kkNnCdxpP9fBQIBXuqvnTvk7LSJTwIadSdTvife6yfAeu90/yW+56xvSQ8Tc6CMTjdbPn8CEOSoXC9pVBStl9kEyMhlPA0xarARcwJiWAOIyeA3nv/Sd6LAPU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=aCwUxNT8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49GJAs1B013221;
	Thu, 17 Oct 2024 03:04:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=6A+Nb0queve
	urvBNDd2vOP+w4mERVifM20uwHto3X1Q=; b=aCwUxNT8glttCjAVS00ZsVsB6Ws
	R4YxPWTsOEST+qJY8O1rMkRreptXAreuQ6MfKRtPP2j5olDTQWN39RC9NdbuHM0S
	kbKaav970jH6kgnHax5DVFHOmruW63ApgTDOhIn4NVXuwKCNsXYqKEF6gmvPo/ex
	X3u568Ma1QCUmITDT7E2TSm9daIDgziZ6twKRkXcs2OdFc1Snq2FpsvxJ8Idh8Cl
	h2JJWHhiG4n0nHyuFvVmTT3zkqhVhBjjy5YhgO+HYCDfYudpI+Jn/XCBgJSb1Uby
	/lye1sl+c6MgocLGZZ1xLe8v3ek6MeDZYsyocyTQ8qcDE4nuSpC21bCjluA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abbxtkjq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:04:20 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 49H2wd5O019941;
	Thu, 17 Oct 2024 03:04:19 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 42aj55ku0w-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:04:19 +0000
Received: from NALASPPMTA05.qualcomm.com (NALASPPMTA05.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 49H301hg021671;
	Thu, 17 Oct 2024 03:04:18 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA05.qualcomm.com (PPS) with ESMTPS id 49H34ItY028351
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 03:04:18 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 81173650; Wed, 16 Oct 2024 20:04:18 -0700 (PDT)
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
        linux-clk@vger.kernel.org, johan+linaro@kernel.org,
        Qiang Yu <quic_qianyu@quicinc.com>
Subject: [PATCH v7 5/7] PCI: qcom: Remove BDF2SID mapping config for SC8280X family SoC
Date: Wed, 16 Oct 2024 20:04:10 -0700
Message-Id: <20241017030412.265000-6-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241017030412.265000-1-quic_qianyu@quicinc.com>
References: <20241017030412.265000-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: PlsxN7ofUOsYMUc0WlTFl8elfxSH2X8-
X-Proofpoint-GUID: PlsxN7ofUOsYMUc0WlTFl8elfxSH2X8-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410170021

On SC8280X family SoC, PCIe controllers are connected to SMMUv3, hence
they don't need the config_sid() callback in ops_1_9_0 struct. Fix it by
introducing a new ops struct, namely ops_1_21_0 which is same as ops_1_9_0
without config_sid() callback so that BDF2SID mapping won't be configured
during init.

Fixes: 70574511f3fc ("PCI: qcom: Add support for SC8280XP")
Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


