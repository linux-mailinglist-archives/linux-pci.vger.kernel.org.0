Return-Path: <linux-pci+bounces-8495-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 5F6C690143E
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 04:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E9AB228204B
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 02:39:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 95BE55C89;
	Sun,  9 Jun 2024 02:39:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="YelJbNg8"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 08812EAC0;
	Sun,  9 Jun 2024 02:39:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717900760; cv=none; b=S5tTxxcwe+enpmfWUD7mC6Ns2xQvaClKuLOXRxaeKddwqgttcq7STbe70ou44OlVvKhQ8B5TkMqIhuebgTL7C2+buwdC3RU8qLB7V0hHK50OXn6sRABNH4/WxzEkiJ+dJflssmzPBu1tEV1n0/fTF/lqU/xe1EriCSFSOId9ikQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717900760; c=relaxed/simple;
	bh=MCUVMgtyxTcXFERMvmD9dw2SJ3819x1Qnt4A3NTao4c=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=gISjpzEppB8/NeLH5RBthtBcq3i/ODt29ruPCYOfIHBPyQqNIUbxAxH8QNVFh7Jox3c6znLYrEwi3s3AZIfB0qadMQIeZIUxRJZocqzIYRnn8Lik8XIVXiZcjtRKzCFlJdGPp2wI7VV8Y5d/SLLQrjMYpmefgqEIYK51d72AJLs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=YelJbNg8; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45920c0F013340;
	Sun, 9 Jun 2024 02:38:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Yrb0mieHsO4MN0cbe5mgqTEKKdPWEqd8I+z9RtzjzSs=; b=YelJbNg8rhGJUSEE
	ZF02X5wmkzI3MzAUMTr0oJYX02zHUw+611ShmDDWiqgiKeKfoBvhkaddZbh+emWv
	FidKGG25d29Y9xSPWY/llpVoNnR4AsA2scZflQ0FbztArYUUjPV1aTPAGjL/Q/w4
	DI0ktzyspjg3huc0dEI58jz8wjt5waeSuJapiIPosxSTF5T2w3mZ50zvZKz8JVa1
	tFebNJBIqamEB/Zd385p+RPG8PU4WAH04IrrwPua2Yp7+fXa8bR5oTpNg44Ln7lK
	b5CtgXa0wn4taBSN8AJyYe76xIkfhOxw6SwZ7N+Io0fhoabrSHUX5mYz4vZWUbSM
	vJoPfQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymfp795pa-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 02:38:48 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4592cljL002553
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 02:38:47 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 19:38:40 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 9 Jun 2024 08:08:17 +0530
Subject: [PATCH v14 3/4] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240609-opp_support-v14-3-801cff862b5a@quicinc.com>
References: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com>
In-Reply-To: <20240609-opp_support-v14-0-801cff862b5a@quicinc.com>
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
        <bmasney@redhat.com>, <djakov@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>, <quic_krichai@quicinc.com>,
        <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717900699; l=2081;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=MCUVMgtyxTcXFERMvmD9dw2SJ3819x1Qnt4A3NTao4c=;
 b=fJIVfGDPUQ9TE6EcsYslq+sT87lXO/L1R0jFp1JWimcTV2iKQguT1N4vMEs6vCeYQWKP2vvNe
 O6Js/9FFY8+CkoMtutF/olvvrZHklcrUBdudJSlmYFUf+HvEYD25ged
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: ccufxfw-l4FRWNx-WOfBVG_LE2ovKeRX
X-Proofpoint-ORIG-GUID: ccufxfw-l4FRWNx-WOfBVG_LE2ovKeRX
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0
 mlxlogscore=999 suspectscore=0 adultscore=0 spamscore=0 phishscore=0
 priorityscore=1501 clxscore=1015 bulkscore=0 impostorscore=0 mlxscore=0
 lowpriorityscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406090019

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
index d2c388761ba9..6e50fa89b913 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6027,24 +6027,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
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
index 1b021579f26a..391a5cd388bd 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -333,6 +333,28 @@ void pci_bus_put(struct pci_bus *bus);
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


