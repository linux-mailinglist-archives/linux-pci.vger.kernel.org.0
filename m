Return-Path: <linux-pci+bounces-10069-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 49DB292D071
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:17:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 0552A289CD8
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:17:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 06BB719149A;
	Wed, 10 Jul 2024 11:16:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="MzfIGJ4p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 9D396191478;
	Wed, 10 Jul 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610209; cv=none; b=Jzj3MyNIMOwqeEpJY+npZVHwYUOCBpqLIm1Pwms6T1D/B8k1mMYJ8HrZks1AZszEjcTc+H9Q0qOATiQzwXOCLekMYkqH95SXJXIr06O7INpCWJ4fzC5qm9ZPhlx+utVFzzfX8RlXCPyF+NwNE8dwzv0nlM6peUaA91f0O+5OCWc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610209; c=relaxed/simple;
	bh=Vb4VfWEEZ11hPnr63kIgpUnhSXDFicNz6OjjT6G1Dr4=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=Xi///cwJoN5L5G71IHuZiSob5w+O8NDdcTsGuDjVYZT6wcXLdIILSUIUi4xyG6TqEmBsmr/upke0keGFWcLFNUyNZanK8/nXMDM2Es+MzbV2OMPLTNwqh8aDXQmSXw9DdTcTFOyjYPnfpLhuKzMF4cr9jLFjwIhKjB6vnkctUSE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=MzfIGJ4p; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A9s9Zn006570;
	Wed, 10 Jul 2024 11:16:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	24yxeffEdWpV5EDkIZnw2qvG3lbLf/oEIK8MLUSOLR0=; b=MzfIGJ4pnKlzyGcK
	zNkPcyeLZE3N20EviXh8eQ6chBz2KJi9hSWcaQMQ1GVDstrWYjVEqwuSOt6Vq5DJ
	mpRLPZDfcKcUr/mlhCTFQFECLMqlQq893ObbOWJM3zyAW/fvDsG+9o4YLCCtISIR
	P71FKgQnE5qT1naGvWjmcxKs7UTIA0QbhT8wI1bqOlJkcxw4jaOf+CTE94h/KZZU
	U+r9YJafwOU4lr/3akHieEQ1GFOSx80jxSbwrzE1tndsNMc9U9BqBZ+Yij3SqUKA
	6nqyYn4KOLlfdTgfYO5b2K4Vwpw+sGBcLVICNH8QptZblugemeUaEW29e/7WEikP
	mv73Zg==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406wmmsa24-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:28 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABGRXl031443
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:27 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:16:22 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:46:09 +0530
Subject: [PATCH v6 2/5] PCI: dwc: Add wakeup host op to pci_epc_ops
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-wakeup_host-v6-2-ef00f31ea38d@quicinc.com>
References: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
In-Reply-To: <20240710-wakeup_host-v6-0-ef00f31ea38d@quicinc.com>
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I
	<kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Jonathan Corbet
	<corbet@lwn.net>,
        Jingoo Han <jingoohan1@gmail.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        Rob Herring <robh@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <mhi@lists.linux.dev>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>, <quic_nitegupt@quicinc.com>,
        <quic_skananth@quicinc.com>, <quic_parass@quicinc.com>,
        "Krishna chaitanya
 chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720610170; l=1895;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=Vb4VfWEEZ11hPnr63kIgpUnhSXDFicNz6OjjT6G1Dr4=;
 b=C4mQURunhHONgdPzD5JysCo60TFXIObUcigEkQbQeQKiCcKph5sBjF7X4BRzw43rpHB8LsX2J
 bnL0hLHdxCAATyc/mZNrRP7jHzO4M66VRDm1l48k5jm33MFWqrjhaOJ
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: lCBykg9wxUA09Ul8Rfi0en9kApSD-Dny
X-Proofpoint-ORIG-GUID: lCBykg9wxUA09Ul8Rfi0en9kApSD-Dny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1015
 priorityscore=1501 lowpriorityscore=0 spamscore=0 bulkscore=0 adultscore=0
 impostorscore=0 suspectscore=0 malwarescore=0 mlxscore=0 mlxlogscore=823
 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100077

Add wakeup host op to wake up host from D3cold or D3hot.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-ep.c | 12 ++++++++++++
 drivers/pci/controller/dwc/pcie-designware.h    |  1 +
 2 files changed, 13 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-ep.c b/drivers/pci/controller/dwc/pcie-designware-ep.c
index 43ba5c6738df..a20b6bec6078 100644
--- a/drivers/pci/controller/dwc/pcie-designware-ep.c
+++ b/drivers/pci/controller/dwc/pcie-designware-ep.c
@@ -440,6 +440,17 @@ dw_pcie_ep_get_features(struct pci_epc *epc, u8 func_no, u8 vfunc_no)
 	return ep->ops->get_features(ep);
 }
 
+static bool dw_pcie_ep_wakeup_host(struct pci_epc *epc, u8 func_no, u8 vfunc_no,
+				   bool send_pme)
+{
+	struct dw_pcie_ep *ep = epc_get_drvdata(epc);
+
+	if (!ep->ops->wakeup_host)
+		return false;
+
+	return ep->ops->wakeup_host(ep, func_no, send_pme);
+}
+
 static const struct pci_epc_ops epc_ops = {
 	.write_header		= dw_pcie_ep_write_header,
 	.set_bar		= dw_pcie_ep_set_bar,
@@ -454,6 +465,7 @@ static const struct pci_epc_ops epc_ops = {
 	.start			= dw_pcie_ep_start,
 	.stop			= dw_pcie_ep_stop,
 	.get_features		= dw_pcie_ep_get_features,
+	.wakeup_host		= dw_pcie_ep_wakeup_host,
 };
 
 /**
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 53c4c8f399c8..da15ccd7a3f5 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -365,6 +365,7 @@ struct dw_pcie_ep_ops {
 	 */
 	unsigned int (*get_dbi_offset)(struct dw_pcie_ep *ep, u8 func_no);
 	unsigned int (*get_dbi2_offset)(struct dw_pcie_ep *ep, u8 func_no);
+	bool	(*wakeup_host)(struct dw_pcie_ep *ep, u8 func_no, bool send_pme);
 };
 
 struct dw_pcie_ep_func {

-- 
2.42.0


