Return-Path: <linux-pci+bounces-9302-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id A9CBE91810E
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 14:39:08 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 2AC6A1F239EE
	for <lists+linux-pci@lfdr.de>; Wed, 26 Jun 2024 12:39:08 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0D871181BB7;
	Wed, 26 Jun 2024 12:38:22 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="S6qPrmU/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8C42818410C;
	Wed, 26 Jun 2024 12:38:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719405501; cv=none; b=Z1zxcBZ7ocUa53Ax1KlfSbCJzEYcrzr0nQpDzolaVXR/ooQGLsZZpV8PbkjqJPK253rt8nVcOW3EookTbO+Sd+T1rJQo2Y+pyblw8o00VZzRbR/tXk2bvVwgHX1KLGs/qNhH0MYtTVxWcsFHmokusF1+ltkBE0+CWRPAMfwwWJw=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719405501; c=relaxed/simple;
	bh=o73P9a6+O7XFPmCnQ9h8UKwsslsAIZP78jJFcmgXucE=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=TkJpTaVG5DiQWuJEX6seoRjrC1qjf5+at7BMnoVtoxtckdaAu4TE8Dpp73Sg5WO2MGTFulOVD+uU5ULRm76mBfbLhFeEKst6imZIvjWO7yifMPxA07fkMpIFf5k/nLe2RsG3LUSqMGQvAja/dZa72gRQTOUi4mYR7Ptcv60zsPA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=S6qPrmU/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279864.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 45QAfT5r015135;
	Wed, 26 Jun 2024 12:38:14 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	T2CK97+90lnoz0uMNsrtK/cOkMtHDtD2Fz/f8CzsiYY=; b=S6qPrmU/67AMFbou
	yh13jdkiNHq8jBk1PYKyZEhwGxjjloOvUNKEDo7GOvHx2JxxI1JMPw5pCqA0NNUq
	2L9blYyvyWhqKKg0GVnB0703lAUy9t43Net9GPhLLzb8G23/3vyrw4TtDugrO9gi
	kOEgDdGjB0Smm4xqaleqmjXlOIZH2uIEShC5s/8LJ/e5ySvcc3hKpbvSgAJ3Ej1o
	ft2AriWZc4i5goW7TrOL6ACn3LoNloAeaj0dHSacFVTSdoph9epTUDCJ2dIqsfbD
	HGo9VG132XHkPME/RuK7tCuZchvye43B6IMRNkpd2vXLPdFGYTViQe6A52pTVrMp
	NZ48QQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ywqshsn8y-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:13 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 45QCcCsi002760
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 26 Jun 2024 12:38:12 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 26 Jun 2024 05:38:07 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Wed, 26 Jun 2024 18:07:51 +0530
Subject: [PATCH RFC 3/7] pci: Change the parent of the platform devices for
 child OF nodes
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240626-qps615-v1-3-2ade7bd91e02@quicinc.com>
References: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
In-Reply-To: <20240626-qps615-v1-0-2ade7bd91e02@quicinc.com>
To: Bartosz Golaszewski <brgl@bgdev.pl>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Conor Dooley
	<conor+dt@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        Jingoo Han <jingoohan1@gmail.com>
CC: <quic_vbadigan@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <linux-arm-msm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1719405471; l=2484;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=o73P9a6+O7XFPmCnQ9h8UKwsslsAIZP78jJFcmgXucE=;
 b=FtCKxhvs5D+vmvL9iESiZMmFM1UCNW4pokyCdk6crWHFlFMqJSXoi/yfn2mxR6Ly9uYASbxiG
 LDj2eg6kYTqAAwKSapdXHD3ab6o6sGeOofiLVshcOCCYfRV6nqZknjZ
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: n9BSs_OYnN20c9tUZGj_hPGqWWS-uRxM
X-Proofpoint-GUID: n9BSs_OYnN20c9tUZGj_hPGqWWS-uRxM
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-26_07,2024-06-25_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 clxscore=1015
 bulkscore=0 phishscore=0 suspectscore=0 lowpriorityscore=0 malwarescore=0
 mlxscore=0 impostorscore=0 mlxlogscore=809 priorityscore=1501 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2406140001
 definitions=main-2406260094

Currently the power control driver is child of pci-pci bridge driver,
this will cause issue when suspend resume is introduced in the pwr
control driver. If the supply is removed to the endpoint in the
power control driver then the config space access initaited by the
pci-pci bridge driver can cause issues like Timeouts.

For this reason change the parent to controller from pci-pci bridge.
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/bus.c         | 5 +++--
 drivers/pci/pwrctl/core.c | 7 ++++++-
 2 files changed, 9 insertions(+), 3 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 3e3517567721..eedab4aabd81 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -335,6 +335,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
 void pci_bus_add_device(struct pci_dev *dev)
 {
 	struct device_node *dn = dev->dev.of_node;
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	int retval;
 
 	/*
@@ -356,9 +357,9 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	pci_dev_assign_added(dev, true);
 
-	if (pci_is_bridge(dev)) {
+	if (pci_is_bridge(dev) && host) {
 		retval = of_platform_populate(dev->dev.of_node, NULL, NULL,
-					      &dev->dev);
+					      host->dev.parent);
 		if (retval)
 			pci_err(dev, "failed to populate child OF nodes (%d)\n",
 				retval);
diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
index feca26ad2f6a..4c0d0f3b15f8 100644
--- a/drivers/pci/pwrctl/core.c
+++ b/drivers/pci/pwrctl/core.c
@@ -10,6 +10,7 @@
 #include <linux/pci-pwrctl.h>
 #include <linux/property.h>
 #include <linux/slab.h>
+#include "../pci.h"
 
 static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 			     void *data)
@@ -64,18 +65,22 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
  */
 int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
 {
+	struct pci_bus *bus = pci_find_bus(of_get_pci_domain_nr(pwrctl->dev->parent->of_node), 0);
 	int ret;
 
 	if (!pwrctl->dev)
 		return -ENODEV;
 
+	if (!bus)
+		return -ENODEV;
+
 	pwrctl->nb.notifier_call = pci_pwrctl_notify;
 	ret = bus_register_notifier(&pci_bus_type, &pwrctl->nb);
 	if (ret)
 		return ret;
 
 	pci_lock_rescan_remove();
-	pci_rescan_bus(to_pci_dev(pwrctl->dev->parent)->bus);
+	pci_rescan_bus(bus);
 	pci_unlock_rescan_remove();
 
 	return 0;

-- 
2.42.0


