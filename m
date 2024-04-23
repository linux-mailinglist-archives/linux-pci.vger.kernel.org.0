Return-Path: <linux-pci+bounces-6562-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 3C6D08AE0B5
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 11:10:18 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 9AF1DB261CB
	for <lists+linux-pci@lfdr.de>; Tue, 23 Apr 2024 09:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 094695915A;
	Tue, 23 Apr 2024 09:08:41 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="g72p1BZe"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B58E59148;
	Tue, 23 Apr 2024 09:08:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713863320; cv=none; b=FX+MS/fyvWPPJJMQ7YpWgyYZAk5YCNQrZbIXEPq9EjapLM8ky395y9lYGvvmSfZgyBDNAhjGeTNnzWcyFwEKbFOCPvm8ZwKdlefEQR2O8Vzepw9nMQtK45rF0bUFXPkKJKscBR0V7322BxPVYv8ZVoENGqMMimMnIn7OTA2Qttg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713863320; c=relaxed/simple;
	bh=C8I6H8q1CsCEilGm6xZcUAtD7gbeIhxcNcTyYkuj3Vo=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=NVZ2XTb2rNv8T7ri4OWjnz0gkstjBMF3d7kkhxUUWXcLaOQ6IEf5XzDS843bvNzdfO1eSQj7vpbpbzRdcL4cg7tYYQb3j5MSUY15qWmehvjf2v16QKU7ZUnXBNG6dOX7qkC0wOucxLVclB7EBrWmrTbO5UOpzo0k3X72v3ulcXg=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=g72p1BZe; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 43N5pCd2010979;
	Tue, 23 Apr 2024 09:08:27 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=xC+Wq2NeguQc2WvQitBOxzmrCHOw8Xh3tDYQPVO/dHc
	=; b=g72p1BZe5P3tKN1Khml+OrFOb7W0ra5nNHU15+RDikfZP3kkWomALBB+BO+
	burqUUKX0GjWLIalOte6Jl/EFQbQDm1oxiO8/xt3ua1xTJCSaRPkJigzGJYCEuhD
	4ktFjtsRcef0WH+aI597oeq7XT+rofB6E/4Noc+a3aK025FPekvCviOwm3J6tLxN
	nB4o8g6QVpPtUobFIozghX6jF707R3F0XnaNILKJiFh/fJZcYYkKP4qZeDghewWc
	Dgajj+ZRHOq0mgI0LGM4MSdLWe74/GDNViEnbRLdniRJtpRDfyex9bdp8MIVo8HJ
	IjHMYtdbegv1tDjUqZKTcRvBMgA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xnvtn9gx6-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43N98Qkc001248
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 23 Apr 2024 09:08:26 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Apr 2024 02:08:19 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 23 Apr 2024 14:36:59 +0530
Subject: [PATCH v11 5/6] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240423-opp_support-v11-5-15fdd40b0f95@quicinc.com>
References: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
In-Reply-To: <20240423-opp_support-v11-0-15fdd40b0f95@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Rob Herring <robh@kernel.org>,
        "Krzysztof
 Kozlowski" <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Bjorn Helgaas <bhelgaas@google.com>, <johan+linaro@kernel.org>,
        <bmasney@redhat.com>, <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_krichai@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1713863266; l=2081;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=C8I6H8q1CsCEilGm6xZcUAtD7gbeIhxcNcTyYkuj3Vo=;
 b=VEayDnO6GDqE0NBIYhGk0WP8lZMkWeLqGWuSEEjnosEKCLFRoaIJhI7WTMjTgnvCq4zWnzsV/
 LnjqnaNCLY5BIu5xDRxuQansWP8rOW55lYHhVfBOeYULHImj6jQ4aFI
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: yyGFdgl5qmoQG1pmHk1q_9UrlV1PWEJm
X-Proofpoint-ORIG-GUID: yyGFdgl5qmoQG1pmHk1q_9UrlV1PWEJm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-23_07,2024-04-22_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 lowpriorityscore=0 mlxlogscore=999 phishscore=0 priorityscore=1501
 mlxscore=0 adultscore=0 bulkscore=0 spamscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2404230025

Bring the switch case in pcie_link_speed_mbps() to new function to
the header file so that it can be used in other places like
in controller driver.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Acked-by: Bjorn Helgaas <bhelgaas@google.com>
---
 drivers/pci/pci.c | 19 +------------------
 drivers/pci/pci.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index e5f243dd4288..40487b86a75e 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -5922,24 +5922,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
 	if (err)
 		return err;
 
-	switch (to_pcie_link_speed(lnksta)) {
-	case PCIE_SPEED_2_5GT:
-		return 2500;
-	case PCIE_SPEED_5_0GT:
-		return 5000;
-	case PCIE_SPEED_8_0GT:
-		return 8000;
-	case PCIE_SPEED_16_0GT:
-		return 16000;
-	case PCIE_SPEED_32_0GT:
-		return 32000;
-	case PCIE_SPEED_64_0GT:
-		return 64000;
-	default:
-		break;
-	}
-
-	return -EINVAL;
+	return pcie_link_speed_to_mbps(to_pcie_link_speed(lnksta));
 }
 EXPORT_SYMBOL(pcie_link_speed_mbps);
 
diff --git a/drivers/pci/pci.h b/drivers/pci/pci.h
index 17fed1846847..4de10087523e 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -290,6 +290,28 @@ void pci_bus_put(struct pci_bus *bus);
 	 (speed) == PCIE_SPEED_2_5GT  ?  2500*8/10 : \
 	 0)
 
+static inline int pcie_link_speed_to_mbps(enum pci_bus_speed speed)
+{
+	switch (speed) {
+	case PCIE_SPEED_2_5GT:
+		return 2500;
+	case PCIE_SPEED_5_0GT:
+		return 5000;
+	case PCIE_SPEED_8_0GT:
+		return 8000;
+	case PCIE_SPEED_16_0GT:
+		return 16000;
+	case PCIE_SPEED_32_0GT:
+		return 32000;
+	case PCIE_SPEED_64_0GT:
+		return 64000;
+	default:
+		break;
+	}
+
+	return -EINVAL;
+}
+
 const char *pci_speed_string(enum pci_bus_speed speed);
 enum pci_bus_speed pcie_get_speed_cap(struct pci_dev *dev);
 enum pcie_link_width pcie_get_width_cap(struct pci_dev *dev);

-- 
2.42.0


