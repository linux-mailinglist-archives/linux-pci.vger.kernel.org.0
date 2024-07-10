Return-Path: <linux-pci+bounces-10068-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 7672592D06D
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 13:17:32 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 30F22289CD1
	for <lists+linux-pci@lfdr.de>; Wed, 10 Jul 2024 11:17:31 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2CA18190461;
	Wed, 10 Jul 2024 11:16:48 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="nsZFgH8P"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id C1ACF190686;
	Wed, 10 Jul 2024 11:16:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720610208; cv=none; b=nrblAdb4MBijBRExwCTLbcaWm/fWDsWM4HvDrAziWnw+mIQ7GnA1EK5XvtU+37wGfVFVxvqH57JcVOHJ0K7UrJprfgXEz3nd2nTfynAPsPOzRs4IBcxtWzh6nFqtWTJfg2t4I5WhXX+jFkRgHdYE+/2Pf3FJRKKIXxdXdqw+mKo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720610208; c=relaxed/simple;
	bh=1M69sQaj4QaAhL/abIhKk1HdzawocfPQ+g8t39LKD+8=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=kc8RDj5xJmUVAYP5oyyFlgsgxk1cQhFfTlpcIV3YPFjsLr40JdJPvPyzFfyb1v691moF8iOmHbsSKjl0GRjpUInvXRIxnrD6mrqyIDKWCfhsm24ZC4cNf1DzbPQWSQQ4KAHNBppJ24nu4mMGwfKMQK61EXKmosPFtA+YMQi/zQE=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=nsZFgH8P; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46A91fEA015275;
	Wed, 10 Jul 2024 11:16:39 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	1IOPEQb5RHN8DhNQ66C/acpOyjcVqxojM0lRdgCCoOU=; b=nsZFgH8P57mxBNKM
	8z+o9VUw+8JNGuP8H5hBTXuBVOjTXK4eBav/4kDLMN4EuRaZNebU+l63DJEf+SW5
	E4JMXRQk5yBiniow0Ab/Jzlk9kjdnFbq1CumVDT3dr2bFUO2cq2td7dz7bU+dK6q
	Qsx+gvBCH0kwqsC6Ldne9fURb3Wh5XtKcI6byD1Hha8SGD4lzv+JF6Y0TEuSNCOf
	9VUpSxyVLwcrinw6QhNsFW78IbZ03oUJRca+VLMIDdvFn/WQHU8CSlbprh0AGb9G
	76XyR2SmnYVYEx/lJhpiP/hvK8QEivJWNKcXD9Jo6ksxAIe235lpPLWgCpfbsSuh
	or9JsA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406y3hgrpy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:39 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46ABGcuP016533
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 10 Jul 2024 11:16:38 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 10 Jul 2024 04:16:33 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 10 Jul 2024 16:46:11 +0530
Subject: [PATCH v6 4/5] PCI: epf-mhi: Add wakeup host op
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240710-wakeup_host-v6-4-ef00f31ea38d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720610170; l=2176;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=1M69sQaj4QaAhL/abIhKk1HdzawocfPQ+g8t39LKD+8=;
 b=sr3xUwax6LaDVtz1X/8f9tQxuRDYT4xFRELvGwbyDb16BI0RVj4TG7VHZ+cFIR+JNcWiElBIp
 t+2o1TUZJtpCQ2J+rN28OpTwjCd/ALuOSqKNmMPmS3QIhwgRWMFA5FN
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 4-fh2hsV7PJbYrM6dQc1Rwp87atu3mfm
X-Proofpoint-GUID: 4-fh2hsV7PJbYrM6dQc1Rwp87atu3mfm
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-10_06,2024-07-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 lowpriorityscore=0 suspectscore=0
 clxscore=1015 mlxlogscore=879 impostorscore=0 phishscore=0
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407100077

Add wakeup host op for MHI EPF.
If the D-state is in D3cold toggle wake signal, otherwise send PME.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 11 +++++++++++
 include/linux/mhi_ep.h                       |  1 +
 2 files changed, 12 insertions(+)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 6de9014e6e53..82fc52490324 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -708,6 +708,16 @@ static int pci_epf_mhi_dma_init(struct pci_epf_mhi *epf_mhi)
 	return ret;
 }
 
+static int pci_epf_mhi_wakeup_host(struct mhi_ep_cntrl *mhi_cntrl)
+{
+	struct pci_epf_mhi *epf_mhi = to_epf_mhi(mhi_cntrl);
+	struct pci_epf *epf = epf_mhi->epf;
+	struct pci_epc *epc = epf->epc;
+
+	return pci_epc_wakeup_host(epc, epf->func_no, epf->vfunc_no,
+			(mhi_cntrl->dstate == PCI_D3cold) ? false : true);
+}
+
 static void pci_epf_mhi_dma_deinit(struct pci_epf_mhi *epf_mhi)
 {
 	destroy_workqueue(epf_mhi->dma_wq);
@@ -803,6 +813,7 @@ static int pci_epf_mhi_link_up(struct pci_epf *epf)
 	mhi_cntrl->unmap_free = pci_epf_mhi_unmap_free;
 	mhi_cntrl->read_sync = mhi_cntrl->read_async = pci_epf_mhi_iatu_read;
 	mhi_cntrl->write_sync = mhi_cntrl->write_async = pci_epf_mhi_iatu_write;
+	mhi_cntrl->wakeup_host = pci_epf_mhi_wakeup_host;
 	if (info->flags & MHI_EPF_USE_DMA) {
 		mhi_cntrl->read_sync = pci_epf_mhi_edma_read;
 		mhi_cntrl->write_sync = pci_epf_mhi_edma_write;
diff --git a/include/linux/mhi_ep.h b/include/linux/mhi_ep.h
index 7c9e5895ea2c..04646cf7782b 100644
--- a/include/linux/mhi_ep.h
+++ b/include/linux/mhi_ep.h
@@ -165,6 +165,7 @@ struct mhi_ep_cntrl {
 	int (*write_sync)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 	int (*read_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
 	int (*write_async)(struct mhi_ep_cntrl *mhi_cntrl, struct mhi_ep_buf_info *buf_info);
+	int (*wakeup_host)(struct mhi_ep_cntrl *mhi_cntrl);
 
 	enum mhi_state mhi_state;
 

-- 
2.42.0


