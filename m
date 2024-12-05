Return-Path: <linux-pci+bounces-17726-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id B61699E4DD1
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 07:55:10 +0100 (CET)
Received: from smtp.subspace.kernel.org (relay.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-ECDSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id D06EA188146F
	for <lists+linux-pci@lfdr.de>; Thu,  5 Dec 2024 06:55:09 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 069DC1AF0CB;
	Thu,  5 Dec 2024 06:54:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jQnTOVvg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8AFD71AC8A6;
	Thu,  5 Dec 2024 06:54:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1733381691; cv=none; b=C34LbkFZidhkA73gGME1YRob1XTk9YVi+hrL1r1LkJhc6Vd5iwqYpUQpweoxxC40WJnl/KF/zSQC7oy0mzD2WAEW6CuTG/HixnQq8glHCwZsnJ2fk9QB/uTx7wtcONeLcz0IBbWZJTWG/i0RzmfdyL7KtARfGxgsgcLjgyP1VV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1733381691; c=relaxed/simple;
	bh=i2aij3jJW4LIokgYlDAv47DGzT5P5Jt+3ipMT0HNPDs=;
	h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
	 MIME-Version; b=TfRJc6gdF/JjWhDlJb1vrMuRyi/rpi4gvep0qTngu+PMDjZKeQtjMDV7MnLg0V5SdJxDvhEUZOTlxCGvndr03DGg5+FQNbRcepNMMq9YQFHiDTuP7h9l1jFVCe29oYgPwEGgLPbYRfz8iK2NGy2iBxFUvgIia9IzgIDNLcaUe5A=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=qualcomm.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jQnTOVvg; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=qualcomm.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4B4LvSqc031695;
	Thu, 5 Dec 2024 06:54:36 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:date:from:in-reply-to:message-id
	:mime-version:references:subject:to; s=qcppdkim1; bh=QmXoyfMWCk5
	HFoqZjHGTbrs78qRaBC98YJfr7qh0Wcg=; b=jQnTOVvgccHrS96GYkm6yJ0zA5T
	+vLd0qnBx7eqvPY1MdvzL/mppd0d9gR86oqvdX+1oAvsyTSFk12Il6e3DDhcbuvO
	cVErRQ37g0zugrySW9LjtstjqtcsZODXU1VL0gJBAs93RgsrhYuXdkus1t6yJAln
	8A+pkMbPGoradQeV17MNBhT1yIjve16npGAdxwLJzW9RR5UTMMPIv8+EhNUyBwpy
	eJyyivnMa1AABgQWmIWw/KewelBNqiSd01sC756yRfruKv1G49aaxMEyfZi8GUAP
	9xs9r9gw+QWRvsTGEbBURaKMWWd2yAviB5god/bk0Weu8TXuaBu5f5g1BcA==
Received: from apblrppmta01.qualcomm.com (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43ayem91mf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:36 +0000 (GMT)
Received: from pps.filterd (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTP id 4B56sQdP022751;
	Thu, 5 Dec 2024 06:54:33 GMT
Received: from pps.reinject (localhost [127.0.0.1])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 437usmedsq-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:33 +0000
Received: from APBLRPPMTA01.qualcomm.com (APBLRPPMTA01.qualcomm.com [127.0.0.1])
	by pps.reinject (8.17.1.5/8.17.1.5) with ESMTP id 4B56sXti023239;
	Thu, 5 Dec 2024 06:54:33 GMT
Received: from hu-devc-hyd-u20-c-new.qualcomm.com (hu-msarkar-hyd.qualcomm.com [10.213.111.249])
	by APBLRPPMTA01.qualcomm.com (PPS) with ESMTPS id 4B56sWiT023238
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 05 Dec 2024 06:54:33 +0000
Received: by hu-devc-hyd-u20-c-new.qualcomm.com (Postfix, from userid 3891782)
	id A727D213F4; Thu,  5 Dec 2024 12:24:31 +0530 (+0530)
From: Mrinmay Sarkar <quic_msarkar@quicinc.com>
To: manivannan.sadhasivam@linaro.org
Cc: quic_shazhuss@quicinc.com, quic_ramkri@quicinc.com,
        quic_nayiluri@quicinc.com, quic_krichai@quicinc.com,
        quic_vbadigan@quicinc.com, quic_nitegupt@quicinc.com,
        Mrinmay Sarkar <quic_msarkar@quicinc.com>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?= <kw@linux.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>, Slark Xiao <slark_xiao@163.com>,
        Qiang Yu <quic_qianyu@quicinc.com>,
        Fabio Porcedda <fabio.porcedda@gmail.com>,
        Johan Hovold <johan+linaro@kernel.org>,
        Mank Wang <mank.wang@netprisma.us>, mhi@lists.linux.dev,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org
Subject: [PATCH v1 2/2] PCI: epf-mhi: Update device id for SA8775P
Date: Thu,  5 Dec 2024 12:24:20 +0530
Message-Id: <20241205065422.2515086-3-quic_msarkar@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
References: <20241205065422.2515086-1-quic_msarkar@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-QCInternal: smtphost
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 2JfDosy_995zWdBZ8ujgmMrWlWB28KhR
X-Proofpoint-ORIG-GUID: 2JfDosy_995zWdBZ8ujgmMrWlWB28KhR
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011
 priorityscore=1501 mlxlogscore=999 phishscore=0 malwarescore=0 mlxscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2411120000 definitions=main-2412050051

Add change to assign proper device id for SA8775P EP.

Signed-off-by: Mrinmay Sarkar <quic_msarkar@quicinc.com>
---
 drivers/pci/endpoint/functions/pci-epf-mhi.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/pci/endpoint/functions/pci-epf-mhi.c b/drivers/pci/endpoint/functions/pci-epf-mhi.c
index 54286a40bdfb..6643a88c7a0c 100644
--- a/drivers/pci/endpoint/functions/pci-epf-mhi.c
+++ b/drivers/pci/endpoint/functions/pci-epf-mhi.c
@@ -125,7 +125,7 @@ static const struct pci_epf_mhi_ep_info sm8450_info = {
 
 static struct pci_epf_header sa8775p_header = {
 	.vendorid = PCI_VENDOR_ID_QCOM,
-	.deviceid = 0x0306,               /* FIXME: Update deviceid for sa8775p EP */
+	.deviceid = 0x0116,
 	.baseclass_code = PCI_CLASS_OTHERS,
 	.interrupt_pin = PCI_INTERRUPT_INTA,
 };
-- 
2.25.1


