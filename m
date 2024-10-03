Return-Path: <linux-pci+bounces-13750-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 0772498E99D
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 08:02:55 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 277951C2153C
	for <lists+linux-pci@lfdr.de>; Thu,  3 Oct 2024 06:02:54 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id ED51854648;
	Thu,  3 Oct 2024 06:02:50 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Rzv2mLqV"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5870B537F8;
	Thu,  3 Oct 2024 06:02:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1727935370; cv=none; b=m0LI0exxy+j3aNBoofJ6cGQx22h05j5l5gsurGCA9yZYstp3AhKBynpFD1sEmB5TxDuBFqaoX/NDjPY9iWb9bJPWOMjZyaSUc9YLR33h0km4Xct2GHZxkeBleg86ZKywl4ZxcBYym2NXTXi9T7tRZ2qPcGvZAo5TTm3Av7+sM8k=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1727935370; c=relaxed/simple;
	bh=F8GDCslAgsUOoE731zAw6OuNtX2SqofaBhAZbD6N9qg=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=GGvvGPMLReZq3Ojw0PIKA0YYRiRWVfFPytrpbGeUyVeFhVcbfR3dW2UZMDrBhC/aFvKYPXrQfro9dzRnoixDaLImK/njsBKQENwKgOjLd9Hd4a6QDzKVk1VX8CktpNA4fjm308bkeZ4LZ8YCf66npN3RvcsXxoavSUSMswa1mn8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Rzv2mLqV; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4934WRmP028676;
	Thu, 3 Oct 2024 06:02:44 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=PDw8pqLJAly7c6CRwcwGAm
	M+HBxihR7mh9tQMSt3P2E=; b=Rzv2mLqVs7+dFIyr1ZQcNi6On6bv/yCIUJEIZp
	m3Yh+aiE/YFb8ANzMrOmNZ4a8bJBgMIEuHg+1a7SCcq+Bpp/XkHCLC+1amcqin23
	9wUI9J+ArDDu4uIOm7gaIKBbH4AtoYf7ogoIVIA3bRduzHpNqWtzQWCzM7OG1jk0
	InswmgoaybS18TKLKGlNilyb8DCBeMaP7cNJOqNrMROlsodrAd10flAkjBrU3lat
	JzhjCaKqga6yMUNi8VBxt4gwrnyDrkMDBLMi6y4yFQdVSWlqnBpG2X2kz6MHESVf
	OtvvihWAeAdoFmQtXD6dVLxwsCCQz0DT7EjxT56qGQgB3Ipg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 41yprasu6h-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 03 Oct 2024 06:02:44 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49362gp7011282
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 3 Oct 2024 06:02:42 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 2 Oct 2024 23:02:39 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Thu, 3 Oct 2024 11:32:32 +0530
Subject: [PATCH v5] PCI: Enable runtime pm of the host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20241003-runtime_pm-v5-1-3ebd1a395d45@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAHcz/mYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHUUlJIzE
 vPSU3UzU4B8JSMDIxNDAwNj3aLSvJLM3NT4glxdM1PTFBMLY1OzZIskJaCGgqLUtMwKsGHRsbW
 1ABmMwNFcAAAA
To: Bjorn Helgaas <bhelgaas@google.com>, <manivannan.sadhasivam@linaro.org>
CC: <Markus.Elfring@web.de>, <quic_mrana@quicinc.com>, <rafael@kernel.org>,
        <linux-pm@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_vbadigan@quicinc.com>,
        <quic_ramkri@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1727935359; l=4076;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=F8GDCslAgsUOoE731zAw6OuNtX2SqofaBhAZbD6N9qg=;
 b=TMG5HkivjlRmPOUB4On9A0f3hICrauZP7dCrIhwQ2Qvbg5Sy6LEhsXrtTob/eNEWO+21fD5e8
 SEUZ8X2kH2/ACTu44VNkdXM34jByd2jBMDigKP4u4NUWIvyfrjSJuRE
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: 6G2QIuIKwFXMYp6aCQkhupgBGxUk9UOG
X-Proofpoint-ORIG-GUID: 6G2QIuIKwFXMYp6aCQkhupgBGxUk9UOG
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 lowpriorityscore=0
 malwarescore=0 spamscore=0 mlxscore=0 phishscore=0 impostorscore=0
 clxscore=1011 adultscore=0 mlxlogscore=999 bulkscore=0 priorityscore=1501
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2408220000 definitions=main-2410030040

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

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
---
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

---
base-commit: c02d24a5af66a9806922391493205a344749f2c4
change-id: 20241003-runtime_pm-655d48356c8b

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


