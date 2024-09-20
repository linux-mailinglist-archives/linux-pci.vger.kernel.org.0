Return-Path: <linux-pci+bounces-13323-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7868197D419
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 12:19:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id E4934B21538
	for <lists+linux-pci@lfdr.de>; Fri, 20 Sep 2024 10:19:13 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id BF699143738;
	Fri, 20 Sep 2024 10:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ZFEzgftd"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E4F5713F42A;
	Fri, 20 Sep 2024 10:18:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1726827515; cv=none; b=Eu1ngkvXmchM6gFyJQwhQZlXjKBfqZXxlcf4I0pWtbADR+lDa4PM559V+3l075iyzS/7t7FMtTJ1q1tcRgNm37Lzmprptp5niq/Bx5HLUmSAegL4Ijmd2uVmUo91nQWq0IRV7uz8/KGFFWEvQ2LObpUghbOgYRPzZ46big00OIE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1726827515; c=relaxed/simple;
	bh=WqFbDQmqFviB9l/g3PWxbXx8WunsDECucD4saIKHSk8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BslH+y65tWEQUIF3Nz3pRaGT7jCP+tjubk/kv6M1G1t7gqKNQlNIa7qNh04qRiaUQ+CZbJjGbkQE9hT8YTuvzUbpT6DTN3xhLxZiUpwEOA3TaeSjBL3uMC2sv9pPAWAXQyqwIqtscHHRjhjztE6OU95FER6DykMtHArtfQyWc3U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ZFEzgftd; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 48K84wK4018275;
	Fri, 20 Sep 2024 10:18:24 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Gps7Aqc61ge6OVffTiQsKh9NKg7fZh4wMJ4GMswcuYI=; b=ZFEzgftdT3nZa5r5
	NWkBOeUQ3pGizoBKAKU9F8jlM0QojDbHNqAgNU/X/kjJrWFBd/jSy97Y4OZt/zML
	As1wSfSib5LH5aOOE58tbcKuA1KIpHzSP/PpBqNuz4OOXnyngRXT87uuvKJdG+Zz
	F9pxqYEd/gvZxpS9yu4WqxARSmhp0qVwGYlwbzQRx5HO45M6pHGaYfc+i+LKdBSE
	hZ7wnSC9kzjmWGtk3+0YRoUlWb72lYJvuSsFiVl5dDiuwhgLpB0DuO3Aj6qfz6fN
	RRK1sG53+bEn8LaQs4rsR08nCyBLQH0TB/s4hpy1FvW21ERPlw5hd/JRXNpZTy2B
	TsaGHQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41n4j70rpd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 10:18:23 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 48KAIMol009997
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 20 Sep 2024 10:18:22 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 20 Sep 2024 03:18:18 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 20 Sep 2024 15:48:00 +0530
Subject: [PATCH v2 2/2] PCI: qcom: Update ICC and OPP values during link up
 event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240920-remove_wait-v2-2-7c0fcb3b581d@quicinc.com>
References: <20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com>
In-Reply-To: <20240920-remove_wait-v2-0-7c0fcb3b581d@quicinc.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_vpernami@quicinc.com>, <quic_mrana@quicinc.com>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1726827488; l=882;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=WqFbDQmqFviB9l/g3PWxbXx8WunsDECucD4saIKHSk8=;
 b=ZztJzp1oMGyJWafQ5x0QVBhn9mAJGi/eaJwtGXQGLexC7ciKcy+MNJ6bh2r+cMlW+KI9YP9ft
 08LZPZUugaOAdk9WFyV6hTi+yoG2Gwc1WcQPPoEgF0dpIoHwTrnR/Yq
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 23euj0xX18U9BmmtV1eF85uMBtXkQxZO
X-Proofpoint-GUID: 23euj0xX18U9BmmtV1eF85uMBtXkQxZO
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=716
 mlxscore=0 malwarescore=0 bulkscore=0 priorityscore=1501 clxscore=1015
 adultscore=0 suspectscore=0 lowpriorityscore=0 spamscore=0 impostorscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2408220000
 definitions=main-2409200074

As part of the PCIe link up event, update ICC and OPP values
as at this point only driver can know the link speed and
width of the PCIe link.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 905c9154fc65..e3c17276027a 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1552,6 +1552,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
 		pci_lock_rescan_remove();
 		pci_rescan_bus(pp->bridge->bus);
 		pci_unlock_rescan_remove();
+
+		qcom_pcie_icc_opp_update(pcie);
 	} else {
 		dev_WARN_ONCE(dev, 1, "Received unknown event. INT_STATUS: 0x%08x\n",
 			      status);

-- 
2.34.1


