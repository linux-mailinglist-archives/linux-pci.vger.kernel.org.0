Return-Path: <linux-pci+bounces-17225-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 404FC9D6471
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 20:10:49 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id A9E93B226DE
	for <lists+linux-pci@lfdr.de>; Fri, 22 Nov 2024 19:10:46 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 503991DFE08;
	Fri, 22 Nov 2024 19:10:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="CBTsFGgn"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B0AEF1DFE02;
	Fri, 22 Nov 2024 19:10:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1732302630; cv=none; b=Pf7CDYs9s1DEFxTGBMiw73vg9SCASzBxMlIJdYMG5PVuVuC2SQGyDQ4tneAQnnv8YR3g6kft43Lv6oq0GemQUI/K13eiEimueb3P9z+g0QmECpeh/XPb1OK5lqi5k1pcKQwNh/TZVlKZzoHoK9atBZ0b8gs/Ma7OdR/Q8MOmab8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1732302630; c=relaxed/simple;
	bh=G7MhZdWm35M1gaIihHtcd9K+V5mSFHhK7xXwjTbLEmE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BpVrIFe60BRDx0SX3UZcYvlrStkXJ2ENUdA43sX0UXB/37DhZillzRxbMDydct+FiXaq3aFlhISo2uZpxtog8No2ita9tf4sWvqNujGKAnt+3IipCILYmw9watxwDNx6WTuEWKeZwh0ML9EWbHl5FkQ9P628qUihWEP53V8HaiY=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=CBTsFGgn; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AMDJJdg025224;
	Fri, 22 Nov 2024 19:10:17 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	Ji+V4XMLO5vGToQIEtXGOYQfcXEWqKl0NnzIeOngEXc=; b=CBTsFGgnUESZDPse
	Dz5Eu5yByIy79eNvuQB+DK5w/81cPs5v5PkkRaOxeOtqpn4d/cG7PzqDGqDqTd4N
	qMhpAv4bOP4MeerWvseVKA391V8ihCSmlFi8DgjG9L8zKdknd/j2X6gib++3VX0y
	hlDf+id6ua6fhxDjv4+HrNB//4hRjXrIq0qvHDtWtGBCxxQwWv8QdPusMabJvCid
	jrCzcNU55v7sLKLKQQz8fZmllAWe0PiuMumBPimN6XfWntc8k5+cjtEReMptZbHu
	hLACFiRK5rZAWJ8XqThEuBbyZSjoFgjkWCMvrO3bFInFEVy/7eDR8n1oRgguLMCX
	1dOexA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 43251nma3f-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:16 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AMJAFMT007664
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 22 Nov 2024 19:10:15 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 22 Nov 2024 11:10:11 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 23 Nov 2024 00:39:59 +0530
Subject: [PATCH v5 1/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241123-remove_wait2-v5-1-b5f9e6b794c2@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1732302606; l=1886;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=G7MhZdWm35M1gaIihHtcd9K+V5mSFHhK7xXwjTbLEmE=;
 b=yt0tycpZjY1RTZPpYk0RJeCoCYbx0shAT4QWI6mell82QnoXp/bs/biGbY63LEuasKRiqK22j
 zSiLZHdlv2AAHZqA7Qe4qnB6B4t3PFiX8R0QMN34i9ZYqeLlaLyvaXP
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: t0K4xC6EZbEzX4CV2y68J1QBfuH7ZV_O
X-Proofpoint-GUID: t0K4xC6EZbEzX4CV2y68J1QBfuH7ZV_O
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0 mlxscore=0
 spamscore=0 impostorscore=0 phishscore=0 mlxlogscore=935 adultscore=0
 malwarescore=0 bulkscore=0 clxscore=1015 suspectscore=0 priorityscore=1501
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411220161

If the vendor drivers can detect the Link up event using mechanisms
such as Link up IRQ and if the driver can enumerate downstream devices
instead of waiting here, then waiting for Link up during probe is not
needed here, which optimizes the boot time.

So skip waiting for link to be up if the driver supports 'use_linkup_irq'.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 2 files changed, 9 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d2291c3ceb8b..cc172255d3b6 100644
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


