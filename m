Return-Path: <linux-pci+bounces-11228-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 8554394672F
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 05:32:46 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id A8A731C20EC6
	for <lists+linux-pci@lfdr.de>; Sat,  3 Aug 2024 03:32:45 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 5728FFC01;
	Sat,  3 Aug 2024 03:32:31 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EDAoV0j9"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B009415E89;
	Sat,  3 Aug 2024 03:32:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722655951; cv=none; b=QZfHeWqyca3w2ig4hzw8Vtr7IhEPDSodZG7rR1fxFw+zhKpiq0+kKSxvtJ4Kczx7xbwx4EG973gjSvmwY/R9fhZ/9wF2fBIjJrsNbzhSdY53pOg8uKuCr+9uwxnkWmu3gy7AR6Kd5EnySBQ6GCb15kX410jZGwBAcdW81JWeIFU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722655951; c=relaxed/simple;
	bh=/UJecY37sURWFmZx6zfajLYjVRo/C7QywTe44hmNwtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=PuoaPlNCPE9uVWMjdvRAvU52z9vt2GSegFJqUamxAcJj5+okjgXzfMd/CL/aSgDe/7wuIVpWcpYJKGmM0sTF8HZ+Yo778T5lm6Cc699Scw95zBPpcVpUZHsr2HS9w+6OoRUwYnfJTCCC7cwz8D1MKp4iYlwI2WAMpuE4qmn+7gw=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EDAoV0j9; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4731m4Ug026165;
	Sat, 3 Aug 2024 03:23:29 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	eYYyX7PBqmoJ0SgL786S62//WvWZZXhOQlmh3XBA6/o=; b=EDAoV0j9em9J/X3w
	t/6A0nvBDSrJOKN93WegoUvtJaNoVYKLpyZqZD0yOZEycn0AkAseu060EGrXL8/H
	tWES/Ol5xftmzf+FByzqbukACg4cR6H2zXrbsosb2yiGiN1RYQsnTH3695BORv5h
	1qBjP8pyiLiC0q4RJIEvZGbV8/c93JSVfcD95MLguHEgvy3Xkc1ZUmJ/oeZpVbPd
	2PKDuLwdSO5FD9rpZF/JXFs5rKHyRHYnyAacaINC6WzeOFc11bfW7si25ZTy/jYW
	6M0xn2lCzMAituxmS9X4TSd10c4gcQTKYSnyTXNwCH571raVSnmUC7Vl0N90Z0La
	gAv9kA==
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40s9wmr5c3-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 03 Aug 2024 03:23:29 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4733NSUu008572
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sat, 3 Aug 2024 03:23:28 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 2 Aug 2024 20:23:22 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sat, 3 Aug 2024 08:52:50 +0530
Subject: [PATCH v2 4/8] PCI: Change the parent to correctly represent pcie
 hierarchy
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240803-qps615-v2-4-9560b7c71369@quicinc.com>
References: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
In-Reply-To: <20240803-qps615-v2-0-9560b7c71369@quicinc.com>
To: Lorenzo Pieralisi <lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?= <kw@linux.com>,
        Rob Herring
	<robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Krzysztof Kozlowski
	<krzk+dt@kernel.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Konrad Dybcio
	<konrad.dybcio@linaro.org>,
        <cros-qcom-dts-watchers@chromium.org>,
        "Bartosz
 Golaszewski" <brgl@bgdev.pl>,
        Jingoo Han <jingoohan1@gmail.com>,
        "Manivannan
 Sadhasivam" <manivannan.sadhasivam@linaro.org>
CC: <andersson@kernel.org>, <quic_vbadigan@quicinc.com>,
        <linux-arm-msm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Bartosz
 Golaszewski" <bartosz.golaszewski@linaro.org>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1722655379; l=2478;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=/UJecY37sURWFmZx6zfajLYjVRo/C7QywTe44hmNwtY=;
 b=ft0/oYYzPz1BSC1O8f5dxF9VSgTCN6N/utq+sq+chwRXNh11usVfzHXFW2SacCAna9OcwDnCo
 Ggvy0uhcKTYDrDjemyrCC5kmhlNdK2emGRHLNhw7vzrVqVixIZXRL72
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: b1MA5kdoT896RYWqnYfAwtMHA2tC0EPH
X-Proofpoint-ORIG-GUID: b1MA5kdoT896RYWqnYfAwtMHA2tC0EPH
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-02_20,2024-08-02_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 mlxlogscore=643 clxscore=1015 spamscore=0 malwarescore=0
 lowpriorityscore=3 impostorscore=0 suspectscore=0 adultscore=0 mlxscore=0
 bulkscore=3 phishscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408030020

Currently the pwrctl driver is child of pci-pci bridge driver,
this will cause issue when suspend resume is introduced in the pwr
control driver. If the supply is removed to the endpoint in the
power control driver then the config space access by the
pci-pci bridge driver can cause issues like Timeouts.

For this reason change the parent to controller from pci-pci bridge.

Fixes: 4565d2652a37 ("PCI/pwrctl: Add PCI power control core code")
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
 drivers/pci/bus.c         | 3 ++-
 drivers/pci/pwrctl/core.c | 9 ++++++++-
 2 files changed, 10 insertions(+), 2 deletions(-)

diff --git a/drivers/pci/bus.c b/drivers/pci/bus.c
index 55c853686051..15b42f0f588f 100644
--- a/drivers/pci/bus.c
+++ b/drivers/pci/bus.c
@@ -328,6 +328,7 @@ void __weak pcibios_bus_add_device(struct pci_dev *pdev) { }
  */
 void pci_bus_add_device(struct pci_dev *dev)
 {
+	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
 	struct device_node *dn = dev->dev.of_node;
 	int retval;
 
@@ -352,7 +353,7 @@ void pci_bus_add_device(struct pci_dev *dev)
 
 	if (dev_of_node(&dev->dev) && pci_is_bridge(dev)) {
 		retval = of_platform_populate(dev_of_node(&dev->dev), NULL, NULL,
-					      &dev->dev);
+					      host->dev.parent);
 		if (retval)
 			pci_err(dev, "failed to populate child OF nodes (%d)\n",
 				retval);
diff --git a/drivers/pci/pwrctl/core.c b/drivers/pci/pwrctl/core.c
index feca26ad2f6a..4f2ffa0b0a5f 100644
--- a/drivers/pci/pwrctl/core.c
+++ b/drivers/pci/pwrctl/core.c
@@ -11,6 +11,8 @@
 #include <linux/property.h>
 #include <linux/slab.h>
 
+#include "../pci.h"
+
 static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
 			     void *data)
 {
@@ -64,18 +66,23 @@ static int pci_pwrctl_notify(struct notifier_block *nb, unsigned long action,
  */
 int pci_pwrctl_device_set_ready(struct pci_pwrctl *pwrctl)
 {
+	struct pci_bus *bus;
 	int ret;
 
 	if (!pwrctl->dev)
 		return -ENODEV;
 
+	bus = pci_find_bus(of_get_pci_domain_nr(pwrctl->dev->parent->of_node), 0);
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
2.34.1


