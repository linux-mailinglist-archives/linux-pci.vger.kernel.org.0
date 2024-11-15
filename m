Return-Path: <linux-pci+bounces-16862-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 920D69CDC9B
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:31:53 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 57B3A281E70
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:31:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A568E1B6CFC;
	Fri, 15 Nov 2024 10:30:55 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="LO8CnwaG"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12AFC1B85D1;
	Fri, 15 Nov 2024 10:30:53 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666655; cv=none; b=YtPGFFmgydHeL7iWyL+wvVIBrPCApZCcOMdw1RBFof63kqeXh9mmGdFX0B69ytCmWggAePEcdi+Ycv1SXUs/1cheBzDvEOaaTyfmH//d+4wwq8rWL2d5lHu1WlnOQ4AkgcpmgUXeOMZKgnIPr7hAG7a85lJMA7EA+AGF/XeU1Wk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666655; c=relaxed/simple;
	bh=SMJJgYPH0VoGR55VneQNmLBv8TSMazn2Q6TLDzZHqrU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=n6bSo0rk/WwHKJLXDIJhFXxoczDjaZLQmEdbwBeG+47jHr1qBg8W+2y3fKQf0mxf84rTgcUn44gnR7jbotH8RWX86P6b7fygvEcGnA9+OoB96XM2qdz6646Td0W423lg0YSLiDgJtSIbB2c5iwR88LsLyzv/Slqb4MjBYHlYO5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=LO8CnwaG; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF848eO000320;
	Fri, 15 Nov 2024 10:30:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	aqTsoZ//po6sfzXBBGBG7whvz+CawUtVr++XkIvxOjs=; b=LO8CnwaGxaBWiSg0
	0/XD36UIoFwgV6zaHFojnYe2t5818i5seEtxSiLy9z6wa37A3ReayG++qJuiBZkC
	Re59cMebjEREy0Kr57Dqr6WVjl5bVr3SnHuCgHxOL3sqBCEGi52cBnnYr9Rlc0FR
	Nrc2ZeXyK2s1zg10Gb2SchrKrp/OFrhCCmqzCOXQ/3Wfl9MBP7yPWQ1J7xpXHKIt
	Rgm8DzfHIMfCJP8vDlcs++ba+OzS7N+fBOKPKViKEuYc9Ku8BShI+DqGa47xuJKc
	3DbBDPC3F6RDuW/NQGoK8BYpispXsXAPJvGIZwDklroyPdmP9TqxcgxyS2Gj5QEr
	wWRtPw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42wjqak282-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:46 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAUjsI026286
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:45 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:30:41 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 15 Nov 2024 16:00:23 +0530
Subject: [PATCH v4 3/3] PCI: qcom: Update ICC and OPP values during link up
 event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241115-remove_wait1-v4-3-7e3412756e3d@quicinc.com>
References: <20241115-remove_wait1-v4-0-7e3412756e3d@quicinc.com>
In-Reply-To: <20241115-remove_wait1-v4-0-7e3412756e3d@quicinc.com>
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
        <quic_vbadigan@quicinc.com>, <quic_mrana@quicinc.com>,
        <andersson@kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731666627; l=1234;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=SMJJgYPH0VoGR55VneQNmLBv8TSMazn2Q6TLDzZHqrU=;
 b=9intVnxYhFLrDZboWXaLPVdNry23wIwyis3ZH/sI8B8nwj3bvkQJAmkSnV44VxTkBr+a+dX4r
 ByXyDLe4gyrDt5kHHhKt1oZdWY7nGS1V0YVL5Bbd4PtUg9nKqmBoorK
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: mj43ACRTjM06U-6ORqlC0OB-d6GzWrZV
X-Proofpoint-ORIG-GUID: mj43ACRTjM06U-6ORqlC0OB-d6GzWrZV
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015 impostorscore=0
 adultscore=0 phishscore=0 lowpriorityscore=0 priorityscore=1501
 spamscore=0 mlxscore=0 mlxlogscore=963 bulkscore=0 malwarescore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150089

As the wait for linkup is removed if there is a global IRQ support,
there is no guarantee that the correct icc and opp votes are updated
as part of probe.

And also global IRQ is being used as hotplug event in case link hasn't
come up as part probe, link up IRQ is the correct place to update the
ICC and OPP votes.

So, as part of the PCIe link up event, update ICC and OPP values.

Fixes: 4581403f6792 ("PCI: qcom: Enumerate endpoints based on Link up event in 'global_irq' interrupt")
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-qcom.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-qcom.c b/drivers/pci/controller/dwc/pcie-qcom.c
index c39d1c55b50e..39f5c782e2c3 100644
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


