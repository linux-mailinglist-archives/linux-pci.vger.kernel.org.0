Return-Path: <linux-pci+bounces-15766-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id E4D2B9B8995
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 04:09:27 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 100531C20DD5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 03:09:27 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4ED8713DDD3;
	Fri,  1 Nov 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="l8pFGGZ6"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 15F72137745;
	Fri,  1 Nov 2024 03:09:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430562; cv=none; b=tsOF6vJOAnEUgo93HYvKUS9Hp3Kzz3rEDx6ASDRI/Bo3X7eTm6n9qOt3yA1PeKrIlotoIpS2ueUbOQz8nFL607lyGckh7XCrkpq59RpfxeMIwRDhlTIdD6pBU6FtWdjno4dQUTe8Cn3utN0sZcHFlNwdz35dC8qlaOqH2wZU9D8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430562; c=relaxed/simple;
	bh=dxhaPhE6A7KZ32GeqYsizcJJsdNy4bSnGJQsVeS7Cgo=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=Tt4ULyOvnkDK02XtUbyfa1WntBm2YFciWcZJ72Rkk+KzQEFQ1D2ROEW6yJyHkBc4XH/LQcPj3FHUOnNBCJy2cVigB/NW0NreFEewErT4EJLrs5HB4srRc5S1F/aztcgtzT1gWIvieSysv5njQgwR8Sc3d71fwmlBac0bstLYekE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=l8pFGGZ6; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VLxQml026368;
	Fri, 1 Nov 2024 03:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=yGShb+quKPn
	4odpjqhRYRBifxU1oxb8U/vmcjX1AbJE=; b=l8pFGGZ6G0UHPcauQa7w/aO/R/E
	e/QfRiY7YyU6AqQVMv3KgAa8Nx52oNdRwbCCcZfMEM8XGhOgd8PRWLCBiHmxARRC
	N1aaYeXdHKCCdKLM343SDtbvl6aMjhPBWAF/RtIC65h8K8zh2FdO2Ab9ljSPhPRM
	VDzFeblKUF3v4GxYzoDVjmkJSxGtg29QQm4QIKtjNMlYOlM2eDBzcbO4QtuSZVkm
	rz9UqIAc7aMXUb8kQsFdSmAepPbmUJOwBHaztGnFDT5/bPgoSjA8pbA7u67L+LtC
	JfYjGMYJ2gN5ZMjiancIO71Sw8DElGQAy82CI8+JRVAe5D9vWAqQ1DS4iew==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42grguspmw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:09 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1386tG010641;
	Fri, 1 Nov 2024 03:09:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 42kw9eaba1-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:08 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A136I1D008069;
	Fri, 1 Nov 2024 03:09:08 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4A13972s011685
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:08 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id BA6D465D; Thu, 31 Oct 2024 20:09:07 -0700 (PDT)
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
Subject: [PATCH v8 3/5] PCI: qcom: Remove BDF2SID mapping config for SC8280X family SoC
Date: Thu, 31 Oct 2024 20:09:00 -0700
Message-Id: <20241101030902.579789-4-quic_qianyu@quicinc.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20241101030902.579789-1-quic_qianyu@quicinc.com>
References: <20241101030902.579789-1-quic_qianyu@quicinc.com>
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
X-Proofpoint-ORIG-GUID: YPDxUHATXiSQbKOOJHuSHN8jws-AjLxf
X-Proofpoint-GUID: YPDxUHATXiSQbKOOJHuSHN8jws-AjLxf
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0 clxscore=1015
 lowpriorityscore=0 adultscore=0 mlxscore=0 bulkscore=0 suspectscore=0
 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=999 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411010021

The SC8280XP PCIe devicetree nodes do not specify an 'iommu-map' so the
config_sid() callback is effectively a no-op. Hence introduce a new ops
struct, namely ops_1_21_0 which is same as ops_1_9_0 except that it
doesn't have config_sid() callback to clean it up.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 12 +++++++++++-
 1 file changed, 11 insertions(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index ef44a82be058..52e3d71028d8 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1364,6 +1364,16 @@ static const struct qcom_pcie_ops ops_1_9_0 = {
 	.config_sid = qcom_pcie_config_sid_1_9_0,
 };
 
+/* Qcom IP rev.: 1.21.0  Synopsys IP rev.: 5.60a */
+static const struct qcom_pcie_ops ops_1_21_0 = {
+	.get_resources = qcom_pcie_get_resources_2_7_0,
+	.init = qcom_pcie_init_2_7_0,
+	.post_init = qcom_pcie_post_init_2_7_0,
+	.host_post_init = qcom_pcie_host_post_init_2_7_0,
+	.deinit = qcom_pcie_deinit_2_7_0,
+	.ltssm_enable = qcom_pcie_2_3_2_ltssm_enable,
+};
+
 /* Qcom IP rev.: 2.9.0  Synopsys IP rev.: 5.00a */
 static const struct qcom_pcie_ops ops_2_9_0 = {
 	.get_resources = qcom_pcie_get_resources_2_9_0,
@@ -1411,7 +1421,7 @@ static const struct qcom_pcie_cfg cfg_2_9_0 = {
 };
 
 static const struct qcom_pcie_cfg cfg_sc8280xp = {
-	.ops = &ops_1_9_0,
+	.ops = &ops_1_21_0,
 	.no_l0s = true,
 };
 
-- 
2.34.1


