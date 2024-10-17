Return-Path: <linux-pci+bounces-14804-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 6CBE69A270A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:39:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 3158C280E7A
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:39:52 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 2FEB61E0DB6;
	Thu, 17 Oct 2024 15:36:29 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="G5vIiorJ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ADD291DF252;
	Thu, 17 Oct 2024 15:36:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179389; cv=none; b=T7TpBvb1MGZ5HniVWkNn6CROyilTplNhFbLnx/uJ4v02xJwxuvziuyDJqwqrLpwFQvdoaRod6Ck7Odoa1Aq0H1XRTkxLiMVo2oLVwo03GwrXKHaylYeMxYlYoiih3HIUi5jqxOuyB/7T+qHBTZVYJXE9lXRizYnxl0ZpzbrUh/Q=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179389; c=relaxed/simple;
	bh=llSVQH0QoXZvzZ7i15pua9CmboZduEdW7xXVZb9NBPM=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:References:
	 In-Reply-To:To:CC; b=jrLbdDyrx+X/psMPL9TPvHxEqyCB17OXYEvix6PPPGjSB+KQKu5FE12pynBdKEO0fFf6ErvAZZmM05oZc3ljF399UUVDbISAq8WpFc/aZjBrhpxPwkpWEuxVPC4pkSMYjgh7Tuwlc2e6SA6YpssOL7Q6kCgGVDQgKKd49w4ADV0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=G5vIiorJ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279872.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H8r81l012429;
	Thu, 17 Oct 2024 15:36:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	ZfAPWNLhffIIiMnpGSSlH+Tku4cnW4zq9d01veekPAY=; b=G5vIiorJUiCBQ8tk
	EM0u2wpOIZk8AzADq2DCeSpxGzWILVhdPRGqk2QeVONOo65iW78DdzKC/8lsfGNR
	q+snCUZVkxAoosLP2DP2cXeXLYt5FrKdOyVJ2TC8raVIqsy6Y24rEQan2LskQc3j
	5FzYHoJdR3yslib5jzlRQpIlSuy/VEJsX+pebh5Qi27a+viVKCpND/TfRBXKv3G/
	bSSrIUydoCq7kI2dOJANmY6+3B76DIiG5xeme3CpjcUWUfJZm5fKuOkcRsbW3zrf
	NX0bvnA5fow0D6KOASHWkaJD7KC1xdl69pTPJWGuwHjcdknN3W/JPh11RhfKlF9Q
	y9SeiQ==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42abbxvkvb-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:36:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HFa5dV020314
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:36:05 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 08:36:01 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Thu, 17 Oct 2024 21:05:51 +0530
Subject: [PATCH v6 2/2] PCI: Enable runtime pm of the host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241017-runtime_pm-v6-2-55eab5c2c940@quicinc.com>
References: <20241017-runtime_pm-v6-0-55eab5c2c940@quicinc.com>
In-Reply-To: <20241017-runtime_pm-v6-0-55eab5c2c940@quicinc.com>
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729179352; l=3930;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=llSVQH0QoXZvzZ7i15pua9CmboZduEdW7xXVZb9NBPM=;
 b=OmRc9u26RdgyYNKBosU1tQn6OU1Tx42+UBOFF2KAqDp9M8fyis3Nshr5kwNb6xcumEAqmE5RR
 AMSpWlLbwpRCQinEBoXScmJefSgz6wdYL6uj8eduD3q7OtKvRCgDzTo
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: bbPYzdNBGg0Uu81EuQLqZXbfNatAOFS2
X-Proofpoint-GUID: bbPYzdNBGg0Uu81EuQLqZXbfNatAOFS2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 clxscore=1015
 priorityscore=1501 impostorscore=0 mlxscore=0 mlxlogscore=999 bulkscore=0
 spamscore=0 malwarescore=0 lowpriorityscore=0 suspectscore=0 adultscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2409260000
 definitions=main-2410170107

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

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
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
 drivers/pci/probe.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 4f68414c3086..8409e1dde0d1 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3106,6 +3106,11 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
+
+	pm_runtime_set_active(&bridge->dev);
+	pm_runtime_no_callbacks(&bridge->dev);
+	devm_pm_runtime_enable(&bridge->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);

-- 
2.34.1


