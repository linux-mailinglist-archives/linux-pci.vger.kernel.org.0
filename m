Return-Path: <linux-pci+bounces-8566-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C0B76902DED
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 03:21:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 402E8B219B5
	for <lists+linux-pci@lfdr.de>; Tue, 11 Jun 2024 01:21:29 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A33636FB9;
	Tue, 11 Jun 2024 01:21:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="O4Np/Qh7"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 12DB0E574;
	Tue, 11 Jun 2024 01:21:21 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718068883; cv=none; b=Lm1hgtDgGwijvmZN10QmkXJe0U30tQDt6n+AAuml7Y1PezXdNEZivm3NiD/i46zyOKjr699eWRxz6TEKTX4TFHLKROByjkNoLywi/80oZmTWgO5GYdcVVXTYd9GCy593TFYZdPyr0U6BgyATGUpQvdXUG2sfZFhXdq1MdHRWYEo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718068883; c=relaxed/simple;
	bh=ziA4GEXPGVP/ZuWwx2ngxGPwva+R10QqvAr0aHW90uM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=nHw/GahfJ+Io4fIYk84Oor3HKQYTfIvDWV1jevED8H7UUV4g0mfrwnWmBXmAQA3EnfY1jfsrjWduLPq5iCb28MXbLrR/mhKnFYclG8QMEsvj0oVIhTDpOn6cSJZQCcvO9maCM95P1jDFd0uXZK1VWHo+bGy8ALcjj3dV+cTaT2c=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=O4Np/Qh7; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45ADjgRL029937;
	Tue, 11 Jun 2024 01:21:20 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=s/LOV7p9oalQRhbSNfugW4
	CFWJbZeIawxPRY2AK7TQ0=; b=O4Np/Qh71fh0PAZXXGGeyT5pMrP9sbV+0qni31
	cPW5i8PtFS6bmV3oOuBEsOGSJ0d3/2P20w8SNgDKiPvZcisYJW3/2UttpP/ZxJuA
	ETc0cbA9IeaYIyPoRfGJQ9y5ne2eU/nSw6MnNpIJPjNe7fvTJ1SiDcI4irwqbz/J
	kmm4n8Rch1KhPho22pmG+Y08+uBAPqSVBps1nH2JrlBgeUq1cYTVekounjkSHMyR
	2u3MYpXGA2+GW4pxVnz27M/UwFggXPnPMziK6Nz8u54P6GKQaqjytlN9NYiPJkeS
	+tFzcWhHcOiWVfhH+SWG2/pqefvFPnXouxEZTV+ynaulubRw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymd0edkev-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 01:21:19 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45B1LH1K008357
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 11 Jun 2024 01:21:17 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 10 Jun
 2024 18:21:17 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Mon, 10 Jun 2024 18:21:16 -0700
Subject: [PATCH] PCI: add missing MODULE_DESCRIPTION() macros
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240610-md-drivers-pci-v1-1-139c135853ea@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAIumZ2YC/x3MwQqDMAyA4VeRnBdodYxurzJ2SNuoAe0kcSKI7
 75ux+/w/wcYq7DBozlAeROTd6nwlwbSSGVglFwNrWuv7uYdzhmzysZquCTB0PkUQ9+5QHeo0aL
 cy/4fPl/VkYwxKpU0/jaTlM+OM9nKCuf5BXiAAr9/AAAA
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <kernel-janitors@vger.kernel.org>,
        Jeff Johnson <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: _EvmJxNROH0H0hv8Lu_sL0nD5LG_bz08
X-Proofpoint-ORIG-GUID: _EvmJxNROH0H0hv8Lu_sL0nD5LG_bz08
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-10_08,2024-06-10_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxlogscore=911
 lowpriorityscore=0 priorityscore=1501 malwarescore=0 suspectscore=0
 adultscore=0 spamscore=0 mlxscore=0 clxscore=1015 bulkscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2405170001 definitions=main-2406110009

When ARCH=x86, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-stub.o
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/pci-pf-stub.o

Add the missing invocations of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/pci/pci-pf-stub.c | 1 +
 drivers/pci/pci-stub.c    | 1 +
 2 files changed, 2 insertions(+)

diff --git a/drivers/pci/pci-pf-stub.c b/drivers/pci/pci-pf-stub.c
index 45855a5e9fca..04815fcb0ce7 100644
--- a/drivers/pci/pci-pf-stub.c
+++ b/drivers/pci/pci-pf-stub.c
@@ -39,4 +39,5 @@ static struct pci_driver pf_stub_driver = {
 };
 module_pci_driver(pf_stub_driver);
 
+MODULE_DESCRIPTION("Simple stub driver for PCI SR-IOV PF device");
 MODULE_LICENSE("GPL");
diff --git a/drivers/pci/pci-stub.c b/drivers/pci/pci-stub.c
index d1f4c1ce7bd1..d4fec791b321 100644
--- a/drivers/pci/pci-stub.c
+++ b/drivers/pci/pci-stub.c
@@ -92,5 +92,6 @@ static void __exit pci_stub_exit(void)
 module_init(pci_stub_init);
 module_exit(pci_stub_exit);
 
+MODULE_DESCRIPTION("Simple stub driver to reserve a PCI device");
 MODULE_LICENSE("GPL");
 MODULE_AUTHOR("Chris Wright <chrisw@sous-sol.org>");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240610-md-drivers-pci-831cb8f308a9


