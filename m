Return-Path: <linux-pci+bounces-16860-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id CA4BE9CDC95
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 11:31:18 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 755B91F22755
	for <lists+linux-pci@lfdr.de>; Fri, 15 Nov 2024 10:31:18 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5B7A01B6CEB;
	Fri, 15 Nov 2024 10:30:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AMkbm3pI"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B6CCD1B4F0F;
	Fri, 15 Nov 2024 10:30:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731666649; cv=none; b=XLZ+Xw+TPdsXaC1iAhcRPdqWTljYwkZ8ULspADdX05mo3O9QrI5ZndxlXlZVvLsNsD+r1UJE3IoAlnzKBq6/+1xBk1TC4Uow1QZlst8wuMUihoOPhWQ6sd6wwzrgq/r7IDTTPxONa+xmf8utQ0dBnQxs6550t9ZJyFnNcsj8YaE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731666649; c=relaxed/simple;
	bh=VbDv3VmH4BfqeU0tgRfXeULFVj1/pBCdJ7CHRcqO1uU=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=uJn+zUUfiVFi/wyW2ey2JZotJ4RQh+H00CYnZpAsoaKFJuAU1xCqdaJUdkkzFJaqg6pwyRKk7nOvwcizJxTKpk4y2tpBaaffl8dG173KUWRjNC1fFeEWQw7Yu2CQtiDFKc6dOev1T6qauJwDIHniejwHd4UD/JrRWaiEQ+zPI6I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AMkbm3pI; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AF9E0o7005146;
	Fri, 15 Nov 2024 10:30:38 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eGwr6qJXD1dZwYMwMOVIOVRmHcCIRn7koaz4FfucVgU=; b=AMkbm3pIdYDf0ZDr
	IjC03TJHqW9g2Wt16kzNH0qe2PDE0FJ8+1M7elh1tAgMuD2jBTYqO+FvNmUYFjIF
	spD+EOeECEyuAfkK2D++ixrRpZeJX4WRHJBJX0WI5StCecv5PYDAyTlVguLro0Ld
	z+HK6qj1hcqSJTjpECLGtAdY2DEkK/hiVLuzJhsEn7zxAWUruCdDaTSYabGlRLxH
	2PpJFLaHyXVAhgzQ68Vk4BjpVm5PdDZSg+Je7iHSd4w+9DSgkVUeo5jkd948CmnN
	4W6TjIBZffp+9BSY+WiE4PaKloyZedugvRNzBB4jgxae+T9yY8wA+vcpSB+DkP5S
	DSS5ng==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42x3g0r7uf-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AFAUaBs005953
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 15 Nov 2024 10:30:36 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 15 Nov 2024 02:30:32 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Fri, 15 Nov 2024 16:00:21 +0530
Subject: [PATCH v4 1/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241115-remove_wait1-v4-1-7e3412756e3d@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731666627; l=1812;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=VbDv3VmH4BfqeU0tgRfXeULFVj1/pBCdJ7CHRcqO1uU=;
 b=e4MCwvIySteGarsyItU3a5dgpd2BB6gxVhbyhGZUaA05k19I2TjrD3UuOS72f2P4J1dAi4R7M
 PEwhx7ZJxT/CUEA9QeXcGKkdAZtREowYDpXFa1S36rgj3BVGdGmjha9
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: paOokC8OoKEq3K1kz5m3ylI5LsOxnP1b
X-Proofpoint-GUID: paOokC8OoKEq3K1kz5m3ylI5LsOxnP1b
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 lowpriorityscore=0 adultscore=0 bulkscore=0 priorityscore=1501
 impostorscore=0 malwarescore=0 clxscore=1015 spamscore=0 mlxlogscore=935
 mlxscore=0 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411150089

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
index 3e41865c7290..c8208a6c03d1 100644
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
+	if (!pp->use_linkup_irq)
+		/* Ignore errors, the link may come up later */
+		dw_pcie_wait_for_link(pci);
 
 	bridge->sysdata = pp;
 
diff --git a/drivers/pci/controller/dwc/pcie-designware.h b/drivers/pci/controller/dwc/pcie-designware.h
index 347ab74ac35a..1d0ec47e1986 100644
--- a/drivers/pci/controller/dwc/pcie-designware.h
+++ b/drivers/pci/controller/dwc/pcie-designware.h
@@ -379,6 +379,7 @@ struct dw_pcie_rp {
 	bool			use_atu_msg;
 	int			msg_atu_index;
 	struct resource		*msg_res;
+	bool			use_linkup_irq;
 };
 
 struct dw_pcie_ep_ops {

-- 
2.34.1


