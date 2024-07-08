Return-Path: <linux-pci+bounces-9904-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id B2035929B5D
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 06:49:57 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id E34F928144A
	for <lists+linux-pci@lfdr.de>; Mon,  8 Jul 2024 04:49:55 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id B62B18BF3;
	Mon,  8 Jul 2024 04:49:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jCMJRGub"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 0545F3FC2;
	Mon,  8 Jul 2024 04:49:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1720414194; cv=none; b=Mx4k+Lzyyo6uzR5/+yygLtaPqrzPKddi8SU5HQatxrXGGwAH8qk3hYRMI/JLiP8ytGZDZhqskCuK4z3tczHPBVSpzn0suxdjmIKrJU9h0fxWZ9VgMYNHiVtykFIDMjlDUlyeEWfvr7k0WcPHQBdyEACJWYaYNQM+HipDT3hEDyI=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1720414194; c=relaxed/simple;
	bh=HFHX6/j0fZnBrcHqUG/aof8fao83sPgjSobeTkmBrtY=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=Uwj267cNi9KTuWu8NewAXiQgUxuDiwiz0AX4dKcv8nEnvP6rs+X+HfSvVLkCz2gqyV+MBCOWBMxMkUH2cC7OuUmZ0mcWEUE21RJH29zm6OzjOOOYHGOh6KwSsG+/nTtRbdo4eOv9l8ZAD3YY/rIAu+Y7KHfYdbKLKEbyDyEdhio=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jCMJRGub; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4680Vtff018388;
	Mon, 8 Jul 2024 04:49:49 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=rYYj9r5ufhTN6Pwk3/h8vz
	CVmy+0ksye8H+v/LX3QtQ=; b=jCMJRGubudKO/eMjiBdpw3DSr2gKtQ0kJGT2hQ
	+oQKaFPXXqaMiFU/dGSOgV5xDmGj2OMzAYMy8A6cmH96Y6ufTCchYBoDgziIgZ4g
	TB6vbNlGLLiZmhIbQUbGmLtx53+ZID3hPVTeeXVik0aUlhVNcOfUKe1WB2Z3Yny/
	k0UiRvGF2r+Khsn9im6vEued+EvgMrrzVf86+we2sSIPqZotnZiUDzY+BhKipdBT
	IxJR2Z08ZHDCm4zExSCJO69GUsNcLdNTJMwNbyMajEN05H8XCERlkhjx9MTOeqo7
	NhB5Rzv0b/LMRPLfSdqovelgvKu8f0/uLLhPMPhgj1qy393g==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 406we8tnte-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 08 Jul 2024 04:49:49 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4684nmhj017085
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 8 Jul 2024 04:49:48 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sun, 7 Jul 2024 21:49:44 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Mon, 8 Jul 2024 10:19:40 +0530
Subject: [PATCH v4] PCI: Enable runtime pm of the host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240708-runtime_pm-v4-1-c02a3663243b@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAONvi2YC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyTHQUlJIzE
 vPSU3UzU4B8JSMDIxMDcwML3aLSvJLM3NT4glxdS3OL5OSk5EQzQ2MDJaCGgqLUtMwKsGHRsbW
 1AJgso+tcAAAA
To: Bjorn Helgaas <bhelgaas@google.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1720414184; l=2819;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=HFHX6/j0fZnBrcHqUG/aof8fao83sPgjSobeTkmBrtY=;
 b=nIWj0T3cB/h9iCeB0OmtXC/3JeurmEFaSHsechBIPAvDq6FNZQAqKBCesZW9Mt0Q5BRAZlkXL
 FD3hjFZr2QHCuuo3c2Jjzp4yeWQ9I//EBRUouiD+ssdsu76HZ3+lXal
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: VNmQjuoYWvxTeNHW2jL4i6RLdJ38j_nW
X-Proofpoint-ORIG-GUID: VNmQjuoYWvxTeNHW2jL4i6RLdJ38j_nW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-08_01,2024-07-05_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 malwarescore=0 priorityscore=1501 clxscore=1015 impostorscore=0
 lowpriorityscore=0 spamscore=0 mlxlogscore=999 phishscore=0 mlxscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407080035

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

Since runtime PM is disabled for host bridge, the state of the child
devices under the host bridge is not taken into account by PM framework
for the top level parent, PCIe controller. So PM framework, allows
the controller driver to enter runtime PM irrespective of the state
of the devices under the host bridge. And this causes the topology
breakage and also possible PM issues like controller driver goes to
runtime suspend while endpoint driver is doing some transfers.

So enable runtime PM for the host bridge, so that controller driver
goes to suspend only when all child devices goes to runtime suspend.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
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
 drivers/pci/probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 8e696e547565..fd49563a44d9 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3096,6 +3096,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 	}
 
 	pci_bus_add_devices(bus);
+
+	pm_runtime_set_active(&bridge->dev);
+	devm_pm_runtime_enable(&bridge->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);

---
base-commit: 1613e604df0cd359cf2a7fbd9be7a0bcfacfabd0
change-id: 20240708-runtime_pm-978ccbca6130

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


