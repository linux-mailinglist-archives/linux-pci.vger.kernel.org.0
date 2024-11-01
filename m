Return-Path: <linux-pci+bounces-15794-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 3EE779B9052
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 12:34:50 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id E8ABC1F224A5
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 11:34:49 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 750A419C54A;
	Fri,  1 Nov 2024 11:34:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EwhWml0v"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8932319AD48;
	Fri,  1 Nov 2024 11:34:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460875; cv=none; b=koXK0DTFA1U5cSwgi4zGyZOsavRxpz44IhdOSLcF2HfOsxdBuasVlenHOOLpFIQqwPJh8iO2aXRBJ6QaZVEFaAlbHcLOqlo6VLcJGSRXZn3p1CTG9vG/TumQOjH0rMf8sG/MGXlPtpPAERHOYdgI5CmAeON6bjF3u7XkHl9STE4=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460875; c=relaxed/simple;
	bh=rxsjN5zN+0oj7GrrzAsD74rm7vsPBW2CCIqtF70Un80=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=pb6kftjKcPiA+vMjJShrquXemBaftKYaUj4ADtc0Qx6/Zqc+j4AaJ6fX1YWVcEXQkGxgCc1/Ht74LK8YOdPzqQrrlxEHV2g8N9pjNvVeibEJPJLqqjGbdTVFmFj+02sRDjSTJD4shigb5HqhkOJgH+qOdGT3SxF97pk/6JvaK4Y=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EwhWml0v; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279863.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A13YrUH020732;
	Fri, 1 Nov 2024 11:34:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	0pI2bqP+nnDJHjBTwr2hXe0ZgN8lGLZM/jAu6P274D0=; b=EwhWml0vwjsQ0JYI
	ZCnRjBMK4aoC/hDxSiOt5SgPTfQj9O3S/DOjf4xiaB+kdoNFQ9ZNcRGWuPuGkjzh
	+mRmVtc1ne/ELnk+GveK93zRbkidY3kYKhg+8hiFizyym5IsQ3FoYdS6Ajd+N+Ew
	bZtaAu9T5tFGBO6jzZ3fO3hUtxY7yzBdriLEy2SwMfepeTIgJToff3qrEhGXYaWW
	0FA5/b4yOMDgb+HB1LXj+QkAxOL41XlanlPrmMcmRCx21jYQxO6TVAOtUzL/lY9G
	u/LTQ7EhCbNjUvuB1eOcuOh9S33X653kKqiBtJrziF8kbUOo9Fi103D0P5nrj0U3
	0lm2qQ==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42kmp0q4xc-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 11:34:24 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1BYO2H031472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 11:34:24 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 04:34:20 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 1 Nov 2024 17:04:12 +0530
Subject: [PATCH v3 1/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241101-remove_wait-v3-1-7accf27f7202@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730460856; l=1804;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=rxsjN5zN+0oj7GrrzAsD74rm7vsPBW2CCIqtF70Un80=;
 b=AZSwHgPQUYimeqs9w/UjrdNwhIFOIEon0WGOBvCymuHnM5WLTJ0hJ2zXz+e0yQHZNKbAsy4xX
 wkCmBZgU425AGrxHkuHKnqXcnh/wZ+WDIgcKBEu4HKfCkHWM9dihFDn
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: MbXVJyYDkNedfSaOeJ3tBG9CwaAICEy_
X-Proofpoint-ORIG-GUID: MbXVJyYDkNedfSaOeJ3tBG9CwaAICEy_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 bulkscore=0 malwarescore=0 impostorscore=0 mlxscore=0 suspectscore=0
 adultscore=0 clxscore=1015 phishscore=0 spamscore=0 mlxlogscore=817
 priorityscore=1501 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010083

If the vendor drivers can detect the Link up event using mechanisms
such as Link up IRQ and can the driver can enumerate downstream devices
instead of waiting here, then waiting for Link up during probe is not
needed here, which optimizes the boot time.

So skip waiting for link to be up if the driver supports 'linkup_irq'.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index 3e41865c7290..26418873ce14 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -530,8 +530,14 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 			goto err_remove_edma;
 	}
 
-	/* Ignore errors, the link may come up later */
-	dw_pcie_wait_for_link(pci);
+	/*
+	 * Note: The link up delay is skipped only when a link up IRQ is present.
+	 * This flag should not be used to bypass the link up delay for arbitrary
+	 * reasons.
+	 */
+	if (!pp->linkup_irq)
+		/* Ignore errors, the link may come up later */
+		dw_pcie_wait_for_link(pci);
 
 	bridge->sysdata = pp;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..539c6d106bb0 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -379,6 +379,7 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	bool			linkup_irq;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


