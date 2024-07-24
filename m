Return-Path: <linux-pci+bounces-10687-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 2AFFA93AB38
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 04:28:37 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 496321C22DCB
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 02:28:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B750E1BF58;
	Wed, 24 Jul 2024 02:28:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CjJOPW9F"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id E17CE1A702;
	Wed, 24 Jul 2024 02:28:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788097; cv=none; b=FsfCgNye8NU/GOiQmXj/ZA/Zdzl6wrW3fi/30x15IStvSXYtUI4O0dSmEbvwhSABEn6vIPMScagDcTu/uU1UsPQYTwLUuF0oVkd19zors33VJ0+2SHUv1NCT0NVzrdVNJqBcY8BKHCKWXvZq+i8y3YqL4G1klBIppOatLD2j0Gk=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788097; c=relaxed/simple;
	bh=r52PAi0eP5qD6KyZJXLXasPBsrN2ox3DmGZQLKZ2mSM=;
	h=From:To:CC:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=qxoPrRARdce+2F+35XRQQvjUX0qEDM3v3Y25SBOXcOB/IJGLCJ8FA7tPxK3BvZ4CxHcsgt65eGnUC57cgXKqdnuNOI4j+nNmdErbUB28g3FkbZDacg5AY8RQJOBB+me3WbFdWdHH+JdgFhhjcGCdidhdCF8bDBy/mufgZZa6Iw4=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CjJOPW9F; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NHljFM028604;
	Wed, 24 Jul 2024 02:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZdIkX7kUndl41QIO8ox6Xv1KABMlZ20FNjhMnqEqeko=; b=CjJOPW9FQxyFs3j4
	zUCwoHYyrofuiYqTKaYX12R5X/DJGjK1UV3HhLQQu8QPXFj93b9ZrPi8nnGf8L5Y
	NGIvcCorQduevZh41SBc5OFphb6DmjafOH21aM5Ycpm2YfdI6VzZXNM893D4kdQt
	0GBfmuEZgtuk7VQWw7xKcZoitGHZGVtq4eM6GKUlb0xr+41+xRc9y1FXq/COxg4p
	sLf/5WFXJp1YQgOMdisnrNvjcRT3RPhzq4OQw7/sair8xhfItXuAf7+6kqb2wIEt
	hkRdkPt84ZWo7XLVmN1GMFcDMx5xFoaoIlyKh0/DJIgi3+hf9cpgj42iLWL9ENdb
	4kNY1Q==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g5m70t99-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 02:28:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46O2S2d1030638
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 02:28:02 GMT
Received: from hu-pyarlaga-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Jul 2024 19:28:02 -0700
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_pyarlaga@quicinc.com>
Subject: [PATCH v3 1/2] PCI: dwc: Add dbi_phys_addr and atu_phys_addr to struct dw_pcie
Date: Tue, 23 Jul 2024 19:27:18 -0700
Message-ID: <20240724022719.2868490-2-quic_pyarlaga@quicinc.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
References: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: g8gd-yKOJI3lLsU7y1ZZgvhLQHFm7-mN
X-Proofpoint-ORIG-GUID: g8gd-yKOJI3lLsU7y1ZZgvhLQHFm7-mN
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_01,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 suspectscore=0
 mlxlogscore=861 adultscore=0 bulkscore=0 mlxscore=0 spamscore=0
 priorityscore=1501 lowpriorityscore=0 clxscore=1015 malwarescore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240017

Both DBI and ATU physical base addresses are needed by pcie_qcom.c
driver to program the location of DBI and ATU blocks in Qualcomm
PCIe Controller specific PARF hardware block.

Signed-off-by: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
Reviewed-by: Mayank Rana <quic_mrana@quicinc.com>
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


