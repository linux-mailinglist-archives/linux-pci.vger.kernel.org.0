Return-Path: <linux-pci+bounces-5831-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id BF8B889AE8B
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 06:39:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 4DF0E1F2330D
	for <lists+linux-pci@lfdr.de>; Sun,  7 Apr 2024 04:39:37 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id E2994AD55;
	Sun,  7 Apr 2024 04:38:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Buus/LuS"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 65CFF179B7;
	Sun,  7 Apr 2024 04:38:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712464718; cv=none; b=bA7umxs8Dr7kWm9HpoweDALJH9B2RULE7JipCOONwLpsEMmeBEkri153JL5OlcO2TJj9B2Qb0eP4yBMC25iTC7XlpnOneWypdfuA8Az8b2RfBZWcP2MJtXQ+MWjm2NjLZkJb3jmlpzBX0e8gU3hT03AOnS4rS8/QXTKDzK5F/No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712464718; c=relaxed/simple;
	bh=SmVnyARR6C18XdO/vcxKGtSxiJ9PFeJ9X+aWz4yvoAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=EQJy21xW9U+wQC9tM1eJgMTswfKz0oHdcAjee3rkATTT6cFDmBXdKbQtQTgMAx9hOcvqSebiOnb4O+jtpPX8LByTLh4NLnXQMgGuodH1aLIp87GqNrGz1XHQeZ32kewtDoTeNSWtv2sGvL9Ij+bOEP2ITDkm+YpFB31Q+UCRyJ8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Buus/LuS; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4374NNpQ021406;
	Sun, 7 Apr 2024 04:38:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=xQ0HFgUWDH51RxyrDF73utrK4LcxDPGMiAFc2j/LWT8
	=; b=Buus/LuSubCt4mUXJ3867OIRca3QLX/BKefuWeA9/iR9BoyQloSr1xG1j+v
	Rs/mRHLrY4HDtKmruqP2rnD3++yMf11y1Ecwgmm50B5gI6ug8cttr/ux7xEpohV9
	DAuVvFPCWAPj9kkqunAPc72QrFcHGqsC2sL/tkIpvp9nPtpqZy+lDRX0idyh+pf6
	2KfJiw0RsCyh2ZDUWU5aEdNaAAWAH6PHj50kNba8u6s/SFtBa53Du75jNGslw9j/
	hM+852jii4PrNiRXBMNbHIZv1LlqU806txlOzfeYX/yIJVayb82kqLAa7TzfIs74
	aUGfrb0Ka7tEE9nQiyscINpBgRw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xayjys9sy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 07 Apr 2024 04:38:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4374cQsj019037
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 7 Apr 2024 04:38:27 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Sat, 6 Apr 2024 21:38:20 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 7 Apr 2024 10:07:38 +0530
Subject: [PATCH v9 5/6] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240407-opp_support-v9-5-496184dc45d7@quicinc.com>
References: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
In-Reply-To: <20240407-opp_support-v9-0-496184dc45d7@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712464667; l=2085;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=SmVnyARR6C18XdO/vcxKGtSxiJ9PFeJ9X+aWz4yvoAY=;
 b=ktEsvo3YNsgZP/3V9UZRQPKcAdobr4I8sa24LYC6zwqYXGYBDgIesYHxipFSVac0xV/zD43va
 EPHV4G3gUb9DSavdZBBHFQGu6WNPPEu7ZKqIEBsGa/fUbdY55cutPO2
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cvmVpLX7OFkicada74r4tscSZzJZpC5n
X-Proofpoint-GUID: cvmVpLX7OFkicada74r4tscSZzJZpC5n
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-07_01,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 adultscore=0
 priorityscore=1501 malwarescore=0 mlxlogscore=999 clxscore=1015
 phishscore=0 mlxscore=0 suspectscore=0 spamscore=0 lowpriorityscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404070032

Bring the switch case in pcie_link_speed_mbps() to new function to
the header file so that it can be used in other places like
in controller driver.

Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
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


