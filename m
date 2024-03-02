Return-Path: <linux-pci+bounces-4364-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B0E1286EE6D
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 05:01:59 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 26D411F21284
	for <lists+linux-pci@lfdr.de>; Sat,  2 Mar 2024 04:01:59 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id C8B4112B77;
	Sat,  2 Mar 2024 04:01:02 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ccl2kzYj"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 232571756E;
	Sat,  2 Mar 2024 04:01:00 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709352062; cv=none; b=DQPi2Gt0QYkosaF92WKV60yobCW6IuXVifz3K/To08wi6BND59TIWePR7IIrPwlutDuq8vOBzVbbcrL6bVUkYweVEBQHeYPgAR7mDoKzp1rkHVhsWK5GkhD0Bnj6PpMS5hBGbp0Lz+I6N4ROAJp/I4Z+zzFGsjlRE/9RP45++hc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709352062; c=relaxed/simple;
	bh=nSpbkHHNz+FKFBbDuIW+CvRRR7bDmGt7PvmlIiVYSsQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=a6QQ7m6nzqKQZyyILdwLCPTsKdGMPqUS278LK6X8YluvENLhlc/aF/e37EDnLMDG/XtN3QQ+5ByVX4eIzc+4H70ZwxEqleLW5oLzcwMN9XDuCViHsgtqSGpKnp0Ef9ZTszzsdfjeL4mEAq+jDlaxS2R4e4ya6BP2B2cIfu/yzGo=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ccl2kzYj; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 4223xFjf021339;
	Sat, 2 Mar 2024 04:00:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:references:in-reply-to:to
	:cc; s=qcppdkim1; bh=NzS2INWWqVE2VaxwVYFo0ZkDao5Z7uZu2P/3PWHMcGI
	=; b=ccl2kzYjUR9+HKqDrThNoouCmQXHID7IwazpIoO+DkMwxbcfR+pLL/d3pKs
	AJe2LRNU/6O9+cGeZuRFq8BmCMXlxkKtYSg6Xhi1HWMIhN0UfYT5qmXBBUvdax1F
	vQjYMSWKBgGiqdUzuR5zcFKn+YIE7KdAk3u/S234dukEPxoICVu7vMgczcrSRp+l
	qiHEU/nKqJjWKpF6rPIicsYHwRpoBhWX7lTp7PSYb8kkIRr8nyMEQrUcYEIcF2gt
	1lBWaoq/PEQUaAIoyr9yCG9AYFpM1a7aw0zmcyGZeGcAExCuPKlcqiVNJQsF+l0b
	gNKCoUH7vDT7+BgKkNa+P5p6rtA==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wkuq50275-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 02 Mar 2024 04:00:52 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42240oCL007050
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 2 Mar 2024 04:00:51 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Fri, 1 Mar 2024 20:00:44 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 2 Mar 2024 09:30:00 +0530
Subject: [PATCH v8 6/7] PCI: Bring the PCIe speed to MBps logic to new
 pcie_link_speed_to_mbps()
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240302-opp_support-v8-6-158285b86b10@quicinc.com>
References: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
In-Reply-To: <20240302-opp_support-v8-0-158285b86b10@quicinc.com>
To: Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        Rob Herring
	<robh+dt@kernel.org>,
        Johan Hovold <johan+linaro@kernel.org>,
        Brian Masney
	<bmasney@redhat.com>, Georgi Djakov <djakov@kernel.org>
CC: <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <vireshk@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709352004; l=1963;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=nSpbkHHNz+FKFBbDuIW+CvRRR7bDmGt7PvmlIiVYSsQ=;
 b=j3d2h6SUWrZPRZyoY8IypkYWBISHl59nk2Y2kGCMa6t1Aa7VDgxqiqVH9XWfql8CR6f1cfLln
 xUXjjeNvqLfBej+lNNO+jM0F/8b33HlUt4Dk8FOL1dHFN65HSSH5Yz7
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bDslgW6CwmrHY1LOWqCl-OtZddYO-Xf9
X-Proofpoint-ORIG-GUID: bDslgW6CwmrHY1LOWqCl-OtZddYO-Xf9
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-01_24,2024-03-01_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 spamscore=0 clxscore=1015 suspectscore=0 mlxscore=0 phishscore=0
 adultscore=0 priorityscore=1501 bulkscore=0 mlxlogscore=923 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403020031

Bring the switch case in pcie_link_speed_mbps() to new function to
the header file so that it can be used in other places like
in controller driver.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/pci.c | 19 +------------------
 drivers/pci/pci.h | 22 ++++++++++++++++++++++
 2 files changed, 23 insertions(+), 18 deletions(-)

diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index d8f11a078924..b441ab862a8d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -6309,24 +6309,7 @@ int pcie_link_speed_mbps(struct pci_dev *pdev)
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
index 2336a8d1edab..40403783229f 100644
--- a/drivers/pci/pci.h
+++ b/drivers/pci/pci.h
@@ -282,6 +282,28 @@ void pci_bus_put(struct pci_bus *bus);
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


