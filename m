Return-Path: <linux-pci+bounces-5926-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id A5CE489D6D1
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 12:22:11 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id C897B1C20C9A
	for <lists+linux-pci@lfdr.de>; Tue,  9 Apr 2024 10:22:10 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 8D6A4136666;
	Tue,  9 Apr 2024 10:14:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="BS00rx1q"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id DE72C1350F9;
	Tue,  9 Apr 2024 10:14:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1712657680; cv=none; b=csh9JaD8cEAhIYeyjd4nIHKaBv5rGUFc6tK5J+X5Kd2Z3FYrDVKmfPO8wo+j2UAzW/WFmVryKvvO4N7F+bbk+Gq4a+joqjeJVWBghlFgznx6aUplKYfESQJZYTXj9uu/6Eypv8VYaEDj0nZYcciLkqTvB2NCBRjBkSexJSQjTUk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1712657680; c=relaxed/simple;
	bh=SmVnyARR6C18XdO/vcxKGtSxiJ9PFeJ9X+aWz4yvoAY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kEronwxHFzmthmkfs8LRb2Ozn7q+x/j7R1kaGwMp5XtIa4xqFV3Aw7Mr0n7ISm6MwblFBVSbZ2bNatR8zzZUGUUmYCrizwA9FuX0Owop9EzU5L6B4GCCnIkg1wCv3ROvOZRGKsDL++12REpAvm2pWZ/yvzJSHYZDAKcLh0Z2ZgA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=BS00rx1q; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4399lUg9009720;
	Tue, 9 Apr 2024 10:14:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=xQ0HFgUWDH51RxyrDF73utrK4LcxDPGMiAFc2j/LWT8
	=; b=BS00rx1qgHznakJ43yHBp/Ox8m/+Guuc5UI8qzBndKtqpZmtOk02HxNvcLD
	NeccZ0TyZzQqDqB5ZFeojPMK4oGG4Ix0ohcJi5dB7WuTTJwvSbSyFRQaLH3tSd72
	WEKvbrgUyOukN3y1D+wcV30yZFVPOK3WitbOgIQqjnzjhFW547T1OUPdzzzKFSr8
	GrS1/F3/6xBLVdASMjbHDLKGUbom6RG8FRq2p0O7xwpIC1WeH7Tfe2ndZh1lQ7zp
	BTj+th4fPQJ6jhMiAwJqbmyoKFD4T4Y+HVERdODGgxG/vdIi1smCJMJqkjHbNkRr
	bZ++1HDQ5+lHeekdZVLlUuyLTSQ==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xd3bsg1bh-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 09 Apr 2024 10:14:10 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 439AE9FI027144
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 9 Apr 2024 10:14:09 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.4; Tue, 9 Apr 2024 03:14:02 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 9 Apr 2024 15:43:23 +0530
Subject: [PATCH v10 5/6] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240409-opp_support-v10-5-1956e6be343f@quicinc.com>
References: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
In-Reply-To: <20240409-opp_support-v10-0-1956e6be343f@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1712657608; l=2085;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=SmVnyARR6C18XdO/vcxKGtSxiJ9PFeJ9X+aWz4yvoAY=;
 b=zM/2kFmg9djWEH4I5XwEQg0apSjOzWU/lYw5uOGgUDqLU7NXunsSVXKf7NL/HcW3l04M8+e4V
 xf+eHXRjAzEBKqlXnDltaKUXZOJh8V6zJOSijX5scUlhGO/0NhLq5d4
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6Qonr2asSX1JsxRn1mMfKKMndjxlwF35
X-Proofpoint-ORIG-GUID: 6Qonr2asSX1JsxRn1mMfKKMndjxlwF35
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-09_06,2024-04-05_02,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 malwarescore=0
 impostorscore=0 suspectscore=0 phishscore=0 priorityscore=1501
 lowpriorityscore=0 mlxlogscore=999 clxscore=1015 adultscore=0 spamscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404090065

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


