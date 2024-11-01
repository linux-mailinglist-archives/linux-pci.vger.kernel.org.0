Return-Path: <linux-pci+bounces-15771-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 8C1A99B89AD
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 04:10:21 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id BC6341C21A92
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 03:10:20 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B395C14A0BC;
	Fri,  1 Nov 2024 03:09:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="A5aL0ckF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 93813144304;
	Fri,  1 Nov 2024 03:09:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730430564; cv=none; b=oR3dhOpazZh4zKuoZnLBx/M0jlkNG70IlNoNmbnFz16q9l/Kjza2UI52W4XVkdrmRHPUTrfHrELPcvQoxsWGqR6srBzxzGnANZ2opXw/lYEZcq0cDqKq0CPWM2kjjCvmIbdrAz+YpVMCyGHtEKEzyY5o9lghPvjDMa8awOBJoBY=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730430564; c=relaxed/simple;
	bh=I2K+Hv4rIjqzGpRZrRub+7WGFaaUzZg4R3gB/+ppUoI=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=fwJ530PMWR8dkDhxPfoLfRv9PrqNv1qLTQZKRwyZPhp6PqAx748N19jieQdo6qJPxWcuoikDrNp2ciTaR07/mnFiEkVcV9G2JhoJtgVK1X7vjt5T9lujG2YoZ5Hhg0vBRXn4i5U1NznzFJW0rLtr6GVAnropuD5U8XD2+mOc7x0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=A5aL0ckF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49VJmblg004938;
	Fri, 1 Nov 2024 03:09:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=ZyocTeYHvqr
	igpvnoV97o41Bqk9TKKnlgnlh6q22uRA=; b=A5aL0ckF+uiwp97yLikpwTIQKIB
	bBLVPCIvbiz2lxFvb852h9ui3N8rlYX6IuArRYbgTJlmSNIFu4j0TncRwBns6Z/O
	o15iYn/7FODArVLQbLwzx0h/7od0rZ+Odc4LsTS1TwIfRAlYy+1mkLhkqSn4GU8b
	240pUOXuPTcYGYgPMpCv8sudwaRNeCudzPZ+7Hbg0YwPS0VzwKAL6aAejSajxbs+
	U6brG0dEjSiNmojWpsnZxo4hYwtbi67iztkDMKnvoIFLnxnhTQ1C+VzqL91Vlqcp
	56RuX5y2hRpy15SH+070bEu0ZRvf8UVFBn5w4aY5nGuoBUq855CfUU14K5Q==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42ku65cf5x-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:10 +0000 (GMT)
Received: from pps.filterd (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4A1340f9005682;
	Fri, 1 Nov 2024 03:09:08 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 42kw9eaba7-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:08 +0000
Received: from NALASPPMTA03.qualcomm.com (NALASPPMTA03.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4A1398vw011703;
	Fri, 1 Nov 2024 03:09:08 GMT
Received: from hu-devc-lv-u22-c.qualcomm.com (hu-qianyu-lv.qualcomm.com [10.81.25.114])
	by NALASPPMTA03.qualcomm.com (PPS) with ESMTPS id 4A1398fQ011699
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 03:09:08 +0000
Received: by hu-devc-lv-u22-c.qualcomm.com (Postfix, from userid 4098150)
	id 786BE65D; Thu, 31 Oct 2024 20:09:08 -0700 (PDT)
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
Subject: [PATCH v8 4/5] PCI: qcom: Disable ASPM L0s for X1E80100
Date: Thu, 31 Oct 2024 20:09:01 -0700
Message-Id: <20241101030902.579789-5-quic_qianyu@quicinc.com>
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
X-Proofpoint-GUID: CXZWWhR80ejP3fYbGKSpkaVSRB9dyU4-
X-Proofpoint-ORIG-GUID: CXZWWhR80ejP3fYbGKSpkaVSRB9dyU4-
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=999
 suspectscore=0 bulkscore=0 lowpriorityscore=0 mlxscore=0
 priorityscore=1501 impostorscore=0 phishscore=0 clxscore=1015
 malwarescore=0 spamscore=0 adultscore=0 classifier=spam adjust=0
 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411010021

Currently, the cfg_1_9_0 which is being used for X1E80100 doesn't disable
ASPM L0s. However, hardware team recommends to disable L0s as the PHY init
sequence is not tuned support L0s. Hence reuse cfg_sc8280xp for X1E80100.

Note that the config_sid() callback is not present in cfg_sc8280xp, don't
concern about this because config_sid() callback is originally a no-op
for X1E80100.

Signed-off-by: Qiang Yu <quic_qianyu@quicinc.com>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 52e3d71028d8..16af237663ec 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1853,7 +1853,7 @@ static const struct of_device_id qcom_pcie_match[] = {
 	{ .compatible = "qcom,pcie-sm8450-pcie0", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8450-pcie1", .data = &cfg_1_9_0 },
 	{ .compatible = "qcom,pcie-sm8550", .data = &cfg_1_9_0 },
-	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_1_9_0 },
+	{ .compatible = "qcom,pcie-x1e80100", .data = &cfg_sc8280xp },
 	{ }
 };
 
-- 
2.34.1


