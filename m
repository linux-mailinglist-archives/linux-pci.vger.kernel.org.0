Return-Path: <linux-pci+bounces-10064-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id B8F9992D036
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:10:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 658202846A1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:10:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 64BAF18FDC7;
	Wed, 10 Jul 2024 11:08:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Fn4UcLnB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E338318FDDE;
	Wed, 10 Jul 2024 11:08:57 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720609739; cv=none; b=K1mjvV8mi8wFmnLCBpNO7G1xDNKS9PQo1gMqyQEHw2nN1OGPJHPLh6/McmxazLeaI1x0wabxvGKI7sNdrkzHLUIwTbV1Mi6ASFiCMRyS/eP50UuGeGZsstr1o38zvgzECDqPY2/SmjC4isBoLMoH1RsOy+vNSblXwZCQkRZpySs=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720609739; c=relaxed/simple;
	bh=sNSmlaFT8GMQD/kiM+wV8aqxn2SQiVisO8vrATvj/Z8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BWlRFy2k8lwOqHwvWOR/80IlWWK0BQna8fdhvchn9R4vR3VAWJssBKGhdLRYZFIF0zkRjUq6JPoRRcVRdGCjv7p1qUe+cjHtK+9n0GpW83fICb+sB/i8X4a798WL2kxnqlX+RLzcVsQxZMop//umOBhHVqjfLLjD7ALZa1gLTfc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Fn4UcLnB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A4NXn4030713;
	Wed, 10 Jul 2024 11:08:47 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	lkltbZ8Rj0N7ZQ2MS8y2Uf/sIKt4S6/RYtcBe+ypCe0=; b=Fn4UcLnBX4CdYvFq
	U3QduBVHkuEBCUKUSN2rW3OQNl/UJG5vl/0Fn5YtUyIllgV7gm3xVMDg0liRoVMc
	IvmuvgzWEtpp0dfBx/10hrQnwvckEouoFllFj/cEmvxK+kK34veq2jBvfUBZqF6s
	DOyDzDy4R1uNr8NChJ3zdffm6/Rgi03Xx2oWRW3PLuVoSs/SvmdJ/Hdy4aECmz8N
	MOJeJnQkxesmTy6Vje9u8Iw/S7TOe1R7qnj4ZA+7kA2Ja/Rmd2jj6aCDYL6oraYP
	zrwa5ni8TfRq5lMextxg8rIAbv1wX1MOdRXdpt30tJFRlF+AISVlPL5eeA1F+wQJ
	itaAGQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we90yhj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46AB8k5d025122
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:08:46 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:08:40 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:38:17 +0530
Subject: [PATCH v7 4/4] PCI: epf-mhi: Add support for handling D-state
 notify from EPC
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-dstate_notifier-v7-4-8d45d87b2b24@quicinc.com>
References: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
In-Reply-To: <20240710-dstate_notifier-v7-0-8d45d87b2b24@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Lorenzo Pieralisi <lpieralisi@kernel.org>,
        Rob Herring
	<robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720609699; l=1803;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=sNSmlaFT8GMQD/kiM+wV8aqxn2SQiVisO8vrATvj/Z8=;
 b=RnCkMXimzqjTSLGhyAjfHzalAWF1i1gsJB+BgYE+0lj42Pd/YI4QVZ5LLGb53yqONRm5h7Itq
 FqoX50NO2rzA2aJvwrZjD01RCABdAREvaxfA4/Sh9n/7gyRs7zjDJjh
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: EhlpC7mepEndcM4bfwMkL-ZxePXrOYyU
X-Proofpoint-GUID: EhlpC7mepEndcM4bfwMkL-ZxePXrOYyU
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 impostorscore=0
 bulkscore=0 spamscore=0 suspectscore=0 lowpriorityscore=0 phishscore=0
 priorityscore=1501 mlxlogscore=859 malwarescore=0 mlxscore=0 clxscore=1015
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2407100076

Add support for handling D-state notify for MHI EPF.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
 include/linux/mhi_ep.h                       |  3 +++
 2 files changed, 14 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 7d070b1def11..6de9014e6e53 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -863,6 +863,16 @@ static int pci_epf_mhi_bus_master_enable(struct pci_epf *epf)
 	return 0;
 }
 
+static int pci_epf_mhi_dstate_notify(struct pci_epf *epf, pci_power_t state)
+{
+	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
+	struct mhi_ep_cntrl *mhi_cntrl = &epf_mhi->mhi_cntrl;
+
+	mhi_cntrl->dstate = state;
+
+	return 0;
+}
+
 static int pci_epf_mhi_bind(struct pci_epf *epf)
 {
 	struct pci_epf_mhi *epf_mhi = epf_get_drvdata(epf);
@@ -921,6 +931,7 @@ static const struct pci_epc_event_ops pci_epf_mhi_event_ops = {
 	.link_up = pci_epf_mhi_link_up,
 	.link_down = pci_epf_mhi_link_down,
 	.bus_master_enable = pci_epf_mhi_bus_master_enable,
+	.dstate_notify = pci_epf_mhi_dstate_notify,
 };
 
 static int pci_epf_mhi_probe(struct pci_epf *epf,
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 7b40fc8cbe77..7c9e5895ea2c 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -8,6 +8,7 @@
 
 #include <linux/dma-direction.h>
 #include <linux/mhi.h>
+#include <linux/pci.h>
 
 #define MHI_EP_DEFAULT_MTU 0x8000
 
@@ -167,6 +168,8 @@ struct mhi_ep_cntrl {
 
 	enum mhi_state mhi_state;
 
+	pci_power_t dstate;
+
 	u32 max_chan;
 	u32 mru;
 	u32 event_rings;

-- 
2.42.0


