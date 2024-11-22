Return-Path: <linux-pci+bounces-17227-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 479279D6476
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 20:11:12 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id AF1161612F5
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 19:11:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 40E2D1DF980;
	Fri, 22 Nov 2024 19:10:38 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="ANNIdFq9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id A06291DF72C;
	Fri, 22 Nov 2024 19:10:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302638; cv=none; b=sV+yTDHns82sMoj2+8QlB3J58+BHclzNsQNhhs7hKG6zN/KGtXn64/NrqlCiH/Q3qdkYV842GsjsTRjkq7vEiPRD0cZihywkOgbA97h0WA+h6ZZ83iLH51mW/g0K83rQm8xLabEz/uxWGjtmugfQ+4w3rKm34xOke4FfjEk27Uo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302638; c=relaxed/simple;
	bh=8NH2yB5xLLOnt00p6vqPplFTBNCd7hf+CR6j9FI9O9w=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=SyTm8q3m4I7+/gJ5rDoZBGBYQOy+BxYgMfufxtfk8cwy4XU6Vhyzc2Xf2dvK5N6IxlEEqZh2V45QKSMVuEJq0RTuw3KRG89qnYL7Ls1XeEru81JXEQ4Ll3TyUu3mEVgTt73yCeLaFVNvVgXzx81AihMSOdDX0J20R83wYTLJSs8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=ANNIdFq9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDZbnZ027713;
	Fri, 22 Nov 2024 19:10:26 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Vv7NlU8R41aOG84T042tZhwrHKwcQz1mHKXKct/Et3o=; b=ANNIdFq9Vgs52qW0
	sYFvlGHX+wFs1yoK1N3o/gbXzXorIpraFDseX1GrYpBmEBLOHu7jG+9CaC/CrdpK
	oaz8EraZAEYGAsZ3KyehRMa+6EUJyxm7u4ZG63gRKmV7MEInOSGxvY7u+66gK3w7
	9UmiOFI1KW+e8E8kgXQ3MwUFWu4PDld3dOxlBjlg/HTWvGrDtf71uZZfKUBrBb3s
	5bMoTMCF98fWBy/9eJohm7WJCErx8DkYID12bsbnwm28X1Rlzfyk7cuSrxF4q3si
	ocjS5lJqZmvrwberoNJcuYz1S/PgT0B/yqAX+3OoGuOnM/qnq2arg3fIKt7BBg2h
	GOi8dw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 432h4dtb0t-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:25 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AMJAOd3025725
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:24 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Nov 2024 11:10:20 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 23 Nov 2024 00:40:01 +0530
Subject: [PATCH v5 3/3] PCI: qcom: Update ICC and OPP values during link up
 event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241123-remove_wait2-v5-3-b5f9e6b794c2@quicinc.com>
References: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
In-Reply-To: <20241123-remove_wait2-v5-0-b5f9e6b794c2@quicinc.com>
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Konrad Dybcio <konradybcio@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kwilczynski@kernel.org>,
        <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_mrana@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732302607; l=1500;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=8NH2yB5xLLOnt00p6vqPplFTBNCd7hf+CR6j9FI9O9w=;
 b=jlHUMlK9os0a8uibvg0sVDUzDjiY3qOtLeMErY2m/f7oPN5ohfhFbaH+WVkWyPjT3nl3Os3fw
 G3zKqogA3PNANNQOGuLoQb5Z5HddzezixH879QKjol/gaxyK3xox2Js
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: ZW5XeqCWSW5aqWZuIajKE7S8NrFEYUIm
X-Proofpoint-GUID: ZW5XeqCWSW5aqWZuIajKE7S8NrFEYUIm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 suspectscore=0
 clxscore=1015 phishscore=0 malwarescore=0 impostorscore=0
 lowpriorityscore=0 mlxlogscore=897 spamscore=0 adultscore=0 mlxscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411220161

The 'commit 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up
event in 'global_irq' interrupt")' added the Link up based enumeration
support failed to update the ICC/OPP vote once link is up. Earlier, the
update happens during probe and the endpoints may or may not be enumerated
at that time. So the ICC/OPP vote was not guaranteed to be accurate. Now
with the Link up based enumeration support, the driver can request the
accurate vote based on the PCIe link.

So call qcom_pcie_icc_opp_update() in qcom_pcie_global_irq_thread() after
enumerating the endpoints.

Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index 656d2be9d87f..e4d3366ead1f 100644
--- a/drivers/pci/controller/dwc/pcie-qcom.c
+++ b/drivers/pci/controller/dwc/pcie-qcom.c
@@ -1569,6 +1569,8 @@ static irqreturn_t qcom_pcie_global_irq_thread(int irq, void *data)
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


