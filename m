Return-Path: <linux-pci+bounces-15796-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 217B19B9057
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 12:35:20 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id AA4082818E6
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 11:35:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0371B19ADA6;
	Fri,  1 Nov 2024 11:34:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="kz9BuXze"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 2D44719DF40;
	Fri,  1 Nov 2024 11:34:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460886; cv=none; b=m7TvSSf7W2ARqW3rdtgZkh7YvbQDq/FgujZd2A5Nd+kID3zkvPnO4T480QE6nSm0p+HGCt+YJwYexzH97vESKCobG/sQtKMEdC2z8v0x9azdBbtbg2UnT0k3CYokKVOZBGfF/aG25X0rhS/h/5513sKv21pK3hw3wU22gBJWPkw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460886; c=relaxed/simple;
	bh=XK8jHN4bI6L37/KmZEIa9NFsKAQWG3YSYzP4qmstAdw=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=K1T6oU1gyuzi+cOVj9vBHLt3nKJf8npGbsFkE0j5gxmDCRTe7cY21fbAdzQ2GrqKadcMdoKVsl29E4DcOjstKoFbwOiMaPEaI9cuupgauJoAio1memNsrzTsuQYnZcU2pJTdbOVF7Zcklk1k8PFmuq2AQ2/ZF2eXkYLHgPt9A48=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=kz9BuXze; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A15AC7R004019;
	Fri, 1 Nov 2024 11:34:32 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	TkcsRg+Ahg9XchoRb/A5U1N77EYM0JB4I7gwzuiM8hw=; b=kz9BuXzeleLxXboQ
	eR8UoU6IV/j45Z1ysCeoEQidZUykH6lWVBxSpbSnwTRKkeAjSTxV1h7b0hsNDOZ1
	wdFFSUOnbfaXv2hROVfA4eVMqC8fPbiERrDxNX18oWxeKvjey+sl25iXso4awg0x
	HnM3TuReKn9vlzLC5/x0dIBK8vxmq40JrthkWKcT88NEBwq8HlfEZds/0oYo4FVW
	5j9dYlEcCiyddRmXJXaJYcTv7TxnckfcvCaYRSOUp1/9YOtBdMuQDBTCAYr4GeON
	3LDzhb5xKoRqlVpD46VOLPh2wfpDXE+n2nHIfQohr00Jt9jdD2DBfsFyhgPy93Kw
	hxX31Q==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kns3q017-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 11:34:32 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1BYVBD028904
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 11:34:31 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 04:34:28 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 1 Nov 2024 17:04:14 +0530
Subject: [PATCH v3 3/3] PCI: qcom: Update ICC and OPP values during link up
 event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241101-remove_wait-v3-3-7accf27f7202@quicinc.com>
References: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
In-Reply-To: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730460856; l=882;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=XK8jHN4bI6L37/KmZEIa9NFsKAQWG3YSYzP4qmstAdw=;
 b=XkkMxLs+YEuteC76oljkF/p79nSlcg07xiDagQjnX0SINgiFrFaucBwPJS56k0xrNzaipVi06
 blBVSc8RQGSAGB9Q3FeByd2mFm3XP8Q3PPwFQQlUkbXVhm+vYKUqTsh
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: C4026sBi7OmNr1YkqmVqEXOPQYtxN44V
X-Proofpoint-ORIG-GUID: C4026sBi7OmNr1YkqmVqEXOPQYtxN44V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 suspectscore=0
 adultscore=0 spamscore=0 phishscore=0 mlxlogscore=698 malwarescore=0
 bulkscore=0 clxscore=1015 lowpriorityscore=0 impostorscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010082

As part of the PCIe link up event, update ICC and OPP values
as at this point only driver can know the link speed and
width of the PCIe link.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 474b7525442d..5826c0e7ca0b 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1558,6 +1558,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
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


