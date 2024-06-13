Return-Path: <linux-pci+bounces-8706-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 2785B906396
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 07:45:40 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id B946A283D22
	for <lists+linux-pci@lfdr.de>; Thu, 13 Jun 2024 05:45:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 003681304AA;
	Thu, 13 Jun 2024 05:45:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jnt91ElF"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6A09A18622;
	Thu, 13 Jun 2024 05:45:33 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1718257534; cv=none; b=bNkcrAue5AuAEwg2N4lXEq6ikaRzq8NqMXcUKdyZ5pS13ZJsgrXGDreu3lg+fznPNXbitSK7FxWpV3vNJYkCSyYv7hEx691uhFzh56tE5Qp3dTMkX/GJtjOSA52OUuTpLpFq50vizRsOAbHB3KEDkKYhTCEA8bLuUlAvyBLbZ+w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1718257534; c=relaxed/simple;
	bh=KsBXxwYITcXSdlkMS6rL3MY1wyPo+d0h2FTlBf/5jvk=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=rjeVqLLNiyvC11E9IjfRyZzHfqI9ZgfhHwHgY1xBdWzK0yge4Dtk6Jax8tKAgaIBTLcNGN3E/Bz020z++auYZSOt7GqaIMlQEKafCq38L87K8iVS7Q1tVpE6/8Gkl4Tt65JdWhju9UQs7YNtqnNrCOX4gitdaEqNfn9DAmaCjm0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jnt91ElF; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45CKn6oZ018799;
	Thu, 13 Jun 2024 05:45:28 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PUfH8gcBQoVjuIp6zSr1uO
	GHiSZo5qY1U/hx6A6Gfhg=; b=jnt91ElFiT7JCIYLK6tGLz/P9VXnz4Kb1q6h/J
	HYq5jJ33OfeDQ5NQCJcCR0C7cTeEEgk1P4VNjc8px803cvadjfW0Qb44mQwHa1sq
	KTXXhf5sUAVXmm67GbpU8KfqO3Ht1RrlqcXYLZwYhBNe7729oGK9LIXQbtsUZtJ9
	mUWGjZr3+ilFQ5LRDEiKlJVGFMBLmiAux/Y9oQAPcI8RCUYernpiav2QUdK2Yt4f
	gh7tRRtLpf4u1W6xeQm3DAbdPdl/O9mHUMuHyogYal+VrbJnhVRCCffj14hss9Ee
	RyHwUhkK9yGVm6uZ2PsUiE49fdgIQhahDH5MHliFKFyGsMgQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3yqbfq9pfy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 05:45:27 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45D5jQAw001163
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 13 Jun 2024 05:45:26 GMT
Received: from [169.254.0.1] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Wed, 12 Jun
 2024 22:45:26 -0700
From: Jeff Johnson <quic_jjohnson@quicinc.com>
Date: Wed, 12 Jun 2024 22:45:23 -0700
Subject: [PATCH] PCI: hotplug: add missing MODULE_DESCRIPTION() macro
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240612-md-drivers-pci-hotplug-v1-1-2b30d14d783d@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHOHamYC/x3MQQqDMBBA0avIrDuQhBJsr1K6iMnUDGgMMyqCe
 PemXb7F/ycoCZPCsztBaGflpTTYWwcxhzIScmoGZ9zdeOtwTpiEdxLFGhnzstZpG9G74Olhe7K
 9gRZXoQ8f//Hr3TwEJRwklJh/u4nLduAcdCWB6/oCiawra4cAAAA=
To: "Rafael J. Wysocki" <rafael@kernel.org>, Len Brown <lenb@kernel.org>,
        Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <kernel-janitors@vger.kernel.org>,
        "Jeff
 Johnson" <quic_jjohnson@quicinc.com>
X-Mailer: b4 0.13.0
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: nXFxAKxtMNZO2108Dfncd7t5Tyu9lZ13
X-Proofpoint-ORIG-GUID: nXFxAKxtMNZO2108Dfncd7t5Tyu9lZ13
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-12_12,2024-06-13_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 spamscore=0 phishscore=0 suspectscore=0 priorityscore=1501 impostorscore=0
 lowpriorityscore=0 bulkscore=0 adultscore=0 mlxlogscore=999 mlxscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406130038

With ARCH=arm64, make allmodconfig && make W=1 C=1 reports:
WARNING: modpost: missing MODULE_DESCRIPTION() in drivers/pci/hotplug/acpiphp_ampere_altra.o

Add the missing invocation of the MODULE_DESCRIPTION() macro.

Signed-off-by: Jeff Johnson <quic_jjohnson@quicinc.com>
---
 drivers/pci/hotplug/acpiphp_ampere_altra.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/pci/hotplug/acpiphp_ampere_altra.c b/drivers/pci/hotplug/acpiphp_ampere_altra.c
index 3fddd04851b6..f5c9e741c1d4 100644
--- a/drivers/pci/hotplug/acpiphp_ampere_altra.c
+++ b/drivers/pci/hotplug/acpiphp_ampere_altra.c
@@ -124,4 +124,5 @@ static struct platform_driver altra_led_driver = {
 module_platform_driver(altra_led_driver);
 
 MODULE_AUTHOR("D Scott Phillips <scott@os.amperecomputing.com>");
+MODULE_DESCRIPTION("ACPI PCI Hot Plug Extension for Ampere Altra");
 MODULE_LICENSE("GPL");

---
base-commit: 83a7eefedc9b56fe7bfeff13b6c7356688ffa670
change-id: 20240612-md-drivers-pci-hotplug-62a6e918e180


