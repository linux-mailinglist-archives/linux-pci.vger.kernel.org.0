Return-Path: <linux-pci+bounces-10479-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 64AAC93476D
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 07:14:30 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 0FFDA1F2294F
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 05:14:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4C85F43AAB;
	Thu, 18 Jul 2024 05:14:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="n45wJRbp"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AD86A40875;
	Thu, 18 Jul 2024 05:14:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279661; cv=none; b=UoXWoy8S2QydLBnVf0TGHL0eklX13/u0OGB6l6uvQlqd+L84Jt7VXvRPQR0pr807TcCCSvRIPe+XIMNTmeVYQnY3RUJ655JSROHQTQnOpUPjbPRi8nBbfSBHgSx+xzYLEr2117UZAto8//d/w2r0Ws9nP5MM86r6xR0F0hMCp1I=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279661; c=relaxed/simple;
	bh=2kx/Q+x5sjsXZhabUVsXGvQDFVCh7Hab1940FLSxm+0=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=JtcFho44KKgoSIvhwIIHZp+j87RQRJ5omsn2DKKWAfO+C+QOtEj1xVlqyIfdn3VvC6aagXQ8F2XKNEPgnT9/PTB2shk0V5ksu6sivanGk045m3GQ6ebSQtu7bd5TVkH7QHPqsi0/ihZNYExQcB5/USuNjRzv/CFR0WNAdBog0aM=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=n45wJRbp; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I3NeZL024353;
	Thu, 18 Jul 2024 05:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	rx56ZxTqUMiXA5M46CXrPcZe14wpPojqezS5K79kgFM=; b=n45wJRbpieiZRDY1
	uXJN+PAZkUho7l91U/qEdCVtmPFrooUBfSh8NobDnaQ08H39qbevX74KDah2H7Jy
	BGtszumDVVaVOKMXdDIOKN1JAtP1TAuUb+1ilNTkGYzu3lnARheHidh0BGY17MpP
	x9yl5j5GMTWl/I975TFR7QinEydjPCHMvpUgzpyu+LedQF9V9AsAcTVszUAhyoG+
	s+QxLbMnu1n7HgNKRpfIaEaa5Y4o/3wJSma1FPY8Bqcvxw4fRKUtjU3uaCIBKqhS
	R82rg4sOTafHEgf/rrQR5wO7JMhL+4LqFYGF7tPqWvC7t4wPTnT/P9tj2SEJES2X
	jFykiA==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfu4dfw-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:14:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I5E8o9026481
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:14:08 GMT
Received: from hu-pyarlaga-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 22:14:08 -0700
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_pyarlaga@quicinc.com>
Subject: [PATCH v2 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to struct dw_pcie
Date: Wed, 17 Jul 2024 22:12:57 -0700
Message-ID: <20240718051258.1115271-2-quic_pyarlaga@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240718051258.1115271-1-quic_pyarlaga@quicinc.com>
References: <20240718051258.1115271-1-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: B5IGtcJ1npUfGxLSPhY07pBANnD3K83V
X-Proofpoint-ORIG-GUID: B5IGtcJ1npUfGxLSPhY07pBANnD3K83V
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_02,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=802 phishscore=0
 spamscore=0 suspectscore=0 adultscore=0 clxscore=1015 mlxscore=0
 priorityscore=1501 lowpriorityscore=0 bulkscore=0 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180034

Both DBI and ATU physical base addresses are needed by pcie_qcom.c
driver to program the location of DBI and ATU blocks in Qualcomm
PCIe Controller specific PARF hardware block.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware.c | 2 ++
 drivers/pci/controller/dwc/pcie-designware.h | 2 ++
 2 files changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
index 1b5aba1f0c92..bc3a5d6b0177 100644
--- a/drivers/pci/controller/dwc/pcie-designware.c
+++ b/drivers/pci/controller/dwc/pcie-designware.c
@@ -112,6 +112,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 		pci->dbi_base = devm_pci_remap_cfg_resource(pci->dev, res);
 		if (IS_ERR(pci->dbi_base))
 			return PTR_ERR(pci->dbi_base);
+		pci->dbi_phys_addr = res->start;
 	}
 
 	/* DBI2 is mainly useful for the endpoint controller */
@@ -134,6 +135,7 @@ int dw_pcie_get_resources(struct dw_pcie *pci)
 			pci->atu_base = devm_ioremap_resource(pci->dev, res);
 			if (IS_ERR(pci->atu_base))
 				return PTR_ERR(pci->atu_base);
+			pci->atu_phys_addr = res->start;
 		} else {
 			pci->atu_base = pci->dbi_base + DEFAULT_DBI_ATU_OFFSET;
 		}
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 53c4c8f399c8..efc72989330c 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -407,8 +407,10 @@ struct dw_pcie_ops {
 struct dw_pcie {
 	struct device		*dev;
 	void __iomem		*dbi_base;
+	phys_addr_t		dbi_phys_addr;
 	void __iomem		*dbi_base2;
 	void __iomem		*atu_base;
+	phys_addr_t		atu_phys_addr;
 	size_t			atu_size;
 	u32			num_ib_windows;
 	u32			num_ob_windows;
-- 
2.25.1


