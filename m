Return-Path: <linux-pci+bounces-16438-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 891039C39D9
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 09:42:56 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 499B42809E4
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:42:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A06D31662FA;
	Mon, 11 Nov 2024 08:42:25 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="f/tbztO+"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id EDB4C42A8A;
	Mon, 11 Nov 2024 08:42:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314545; cv=none; b=qdml50+9fv1nu3hTVXWExWlQuJst7HL73sLq6BlGSd334X0JDKG9VLyHHevw3WlwFpGM4c/aeU06EDpEGxHsWANhSThwwCPar3q2Q/i9pTlyEbKJCTL8uTrm2wi0NS2QvS1aTlDllvMbOe0sTrFwaFtvMpfUIILXEC2bAHzBv5w=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314545; c=relaxed/simple;
	bh=GTSsRAiY6D0Kv1J8orTeqC9Aa9fKwg8DBMPqBUnATNY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=BoqpgqWOcrJLq74KYtLyIwhxSQ7NIVKXkneqho2BLLk2gty9+20HO6+TAscmXXvyjH4snv9RFf12KsuYtJAUQ/703WwVIYPPyN4CeXV+J4J/MR0q9yeBWIqKm1ev7rapTjFoT5AznySdhj9h1bq+EMOwcMKKNrKYTokOmeND2oA=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=f/tbztO+; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AB5rEQA022578;
	Mon, 11 Nov 2024 08:42:10 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	KIUfbbB9s4N1V0V29npH483ei5fNji8z5FHXd7QUnF8=; b=f/tbztO+5pGS8ZqT
	T9E14qrwURIBuR7hO3Rttl9Fg/WJdDGTl4pDbPEdQdcaKFfu4dekHK2so/i0OPDk
	/EaoxrYkF4MYF1ZjClhjQY3RxK8IBS1Ig+umQ7Gg02RPRhbN9t9p6HLg13bTni+i
	E/KeFIsHEl+Gu/3oX1a4jsIU759iCtJ8pMYJE2rx0lMNJvNj57AuF/huoh24vK01
	v2DnNpKoM9Er46Z+6hZoBDreehqLsTFjATg74rnZT8ZSH8vL4g+G7WY9v1fnFlR0
	SsFldE5fuBrExhSkFti2DUefqsL3aNdy3ZYzco7VNDK+VZscIf+MCjtnIxW7DJUu
	kn/mJg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42uc608bsu-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 08:42:09 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AB8g8aU016847
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 08:42:08 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 00:42:04 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Mon, 11 Nov 2024 14:11:53 +0530
Subject: [PATCH v7 2/2] PCI: Enable runtime pm of the host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241111-runtime_pm-v7-2-9c164eefcd87@quicinc.com>
References: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
In-Reply-To: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
To: Kevin Xie <kevin.xie@starfivetech.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>
CC: <Markus.Elfring@web.de>, <quic_mrana@quicinc.com>, <rafael@kernel.org>,
        <m.szyprowski@samsung.com>, <linux-pm@vger.kernel.org>,
        <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Krishna
 chaitanya chundru" <quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731314516; l=4592;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=GTSsRAiY6D0Kv1J8orTeqC9Aa9fKwg8DBMPqBUnATNY=;
 b=4Lg6qf3C549Yo6zEgsFpKEOf2Cjl2Id/IMN3LoobS/bKi/mRJ7pxYjYx/yaJTv7K6a6N/6j0e
 JtiBisHO5RWBnTZEITOupkKK6vG1nDomOh1WoOIoHSmoeQDQVuxl6EP
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: s9G8rTVz0_F4-om04P9LAzRv_kTS6k0f
X-Proofpoint-ORIG-GUID: s9G8rTVz0_F4-om04P9LAzRv_kTS6k0f
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 malwarescore=0
 phishscore=0 suspectscore=0 impostorscore=0 mlxlogscore=999 adultscore=0
 lowpriorityscore=0 priorityscore=1501 clxscore=1015 mlxscore=0 bulkscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2411110073

The Controller driver is the parent device of the PCIe host bridge,
PCI-PCI bridge and PCIe endpoint as shown below.

        PCIe controller(Top level parent & parent of host bridge)
                        |
                        v
        PCIe Host bridge(Parent of PCI-PCI bridge)
                        |
                        v
        PCI-PCI bridge(Parent of endpoint driver)
                        |
                        v
                PCIe endpoint driver

Now, when the controller device goes to runtime suspend, PM framework
will check the runtime PM state of the child device (host bridge) and
will find it to be disabled. So it will allow the parent (controller
device) to go to runtime suspend. Only if the child device's state was
'active' it will prevent the parent to get suspended.

It is a property of the runtime PM framework that it can only
follow continuous dependency chains.  That is, if there is a device
with runtime PM disabled in a dependency chain, runtime PM cannot be
enabled for devices below it and above it in that chain both at the
same time.

Since runtime PM is disabled for host bridge, the state of the child
devices under the host bridge is not taken into account by PM framework
for the top level parent, PCIe controller. So PM framework, allows
the controller driver to enter runtime PM irrespective of the state
of the devices under the host bridge. And this causes the topology
breakage and also possible PM issues like controller driver goes to
runtime suspend while endpoint driver is doing some transfers.

Because of the above, in order to enable runtime PM for a PCIe
controller device, one needs to ensure that runtime PM is enabled for
all devices in every dependency chain between it and any PCIe endpoint
(as runtime PM is enabled for PCIe endpoints).

This means that runtime PM needs to be enabled for the host bridge
device, which is present in all of these dependency chains.

After this change, the host bridge device will be runtime-suspended
by the runtime PM framework automatically after suspending its last
child and it will be runtime-resumed automatically before resuming its
first child which will allow the runtime PM framework to track
dependencies between the host bridge device and all of its
descendants.

PM framework expectes parent runtime pm enabled before enabling runtime
pm of the child. Ensure pm_runtime_enable() is called for the controller
drivers, before calling pci_host_probe() as pm frameworks expects if the
parent device supports runtime pm then it needs to enabled before child
runtime pm.

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v7:
- update commit text & and add a comment in the driver as suggested by bjorn.
Changes in v6:
- no change
Changes in v5:
- call pm_runtime_no_callbacks() as suggested by Rafael.
- include the commit texts as suggested by Rafael.
- Link to v4: https://lore.kernel.org/linux-pci/20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com/
Changes in v4:
- Changed pm_runtime_enable() to devm_pm_runtime_enable() (suggested by mayank)
- Link to v3: https://lore.kernel.org/lkml/20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com/
Changes in v3:
- Moved the runtime API call's from the dwc driver to PCI framework
  as it is applicable for all (suggested by mani)
- Updated the commit message.
- Link to v2: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
Changes in v2:
- Updated commit message as suggested by mani.
- Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
---
 drivers/pci/probe.c | 11 +++++++++++
 1 file changed, 11 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..ee30e6024f52 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3106,6 +3106,17 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
+
+	/*
+	 * Ensure pm_runtime_enable() is called for the controller drivers,
+	 * before calling pci_host_probe() as pm frameworks expects if the
+	 * parent device supports runtime pm then it needs to enabled before
+	 * child runtime pm.
+	 */
+	pm_runtime_set_active(&bridge->dev);
+	pm_runtime_no_callbacks(&bridge->dev);
+	devm_pm_runtime_enable(&bridge->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);

-- 
2.34.1


