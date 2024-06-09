Return-Path: <linux-pci+bounces-8499-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 91C7D901452
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 05:14:53 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 89542B21281
	for <lists+linux-pci@lfdr.de>; Sun,  9 Jun 2024 03:14:50 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0555679C4;
	Sun,  9 Jun 2024 03:14:45 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="owXg/ekC"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 5CDD34C79;
	Sun,  9 Jun 2024 03:14:42 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1717902884; cv=none; b=EHvVeAzj2pipDEw2dixj6U1OEful9LDyldumuYaHWs4rqv0T7rKJ8+qWOLAjGW74RdIFjRQoO8GZDfnqSfa0Eq98e97KlSGS9WeXghNqssbsw4n+XeqJ4U3899fyFvik2o72TSSKvv1MZzcsg8YsqPaBMpXLHbpw1WAVAqLSQOU=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1717902884; c=relaxed/simple;
	bh=P5S5hn/wd59hfazDFIOvh3PsyxcaB0xSntPkgTcQT+A=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=mm0VcX/rTQr/6xhD+nkVumPFroHjwhIs5jUN/JJ2Qd4dx3SLanCOHbiFYzK1xoskXWuLfiG9zpxyp4UQHrLkSKBHFDfd8LBilrWTipr4W+65fCUOVC1xBdhfztN+/w5tEBaVG23trKMr+QPg0jwrvBLKXw+wUU8Y23cxr/DU+hI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=owXg/ekC; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4592vnoU019106;
	Sun, 9 Jun 2024 03:14:37 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=EZw8ly6QFChQVLaaO7OnGU
	vETP74eZ80xU3svZ5nlfk=; b=owXg/ekC7dy8aKZurb8n8gMuW/kuxjtDDOXNUU
	osbwm4ftQTP0ueA4gBB4YQ2YeSMPmaQ+UjoPRN+FiB3TMN3PD6md6qD+5DMyrv/4
	sU897eKxhBKb/QolNzEu21Y0IHJB2r+s6ToUBb3Xfobt8Wh57dw2gY49A8f2fhk9
	xPVTimKxx1CG8IKR1wLzOQBsexRL28pmK5ls4/vU3noWiBd2xxPDieNrDimAlQu/
	J66BKXDNvV7V1dSquNdeVZ52DVBaBzNdEIVT/Y48mLDtIBQ+oss8Jxi1iExAL1C+
	7VkJ4PjcZH9bhZCmngozhCtie8xjX/lR93fnVOubk9X0tpFg==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3ymemgh8fy-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 09 Jun 2024 03:14:37 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 4593EYo3011403
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Sun, 9 Jun 2024 03:14:34 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Sat, 8 Jun 2024 20:14:31 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Sun, 9 Jun 2024 08:44:19 +0530
Subject: [PATCH v3] PCI: Enable runtime pm of the host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240609-runtime_pm-v3-1-3d0460b49d60@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAAoeZWYC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxMDMwNL3aLSvJLM3NT4glxd81SzlFRDQ0sDQ0NjJaCGgqLUtMwKsGHRsbW
 1AM4Oc1pcAAAA
To: Bjorn Helgaas <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        "Rafael J.
 Wysocki" <rjw@rjwysocki.net>, <quic_vbadigan@quicinc.com>,
        <linux-kernel@vger.kernel.org>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1717902871; l=2657;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=P5S5hn/wd59hfazDFIOvh3PsyxcaB0xSntPkgTcQT+A=;
 b=d/wxquSR8YprvLtvF38Z+kT1kOu99B53/T+n+ZMeCbmMYOYPp75ks8x+03Qd7syFW3JaNSIB2
 VOvgUCN3m34BJ/E1NhdZzKqiPyvtF8v4jvO52th9n/PgwJSMKbOEAkf
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: dJzh12uYDO6HxwNSHW30t2rGeaaoK68H
X-Proofpoint-ORIG-GUID: dJzh12uYDO6HxwNSHW30t2rGeaaoK68H
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-06-08_16,2024-06-06_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 mlxlogscore=999
 suspectscore=0 adultscore=0 impostorscore=0 spamscore=0 priorityscore=1501
 lowpriorityscore=0 phishscore=0 malwarescore=0 mlxscore=0 clxscore=1011
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.19.0-2405170001
 definitions=main-2406090024

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
Changes in v3:
- Moved the runtime API call's from the dwc driver to PCI framework
  as it is applicable for all (suggested by mani)
- Updated the commit message.
- Link to v3: https://lore.kernel.org/all/20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com
Changes in v2:
- Updated commit message as suggested by mani.
- Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
---

---
 drivers/pci/probe.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
index 20475ca30505..b7f9ff75b0b3 100644
--- a/drivers/pci/probe.c
+++ b/drivers/pci/probe.c
@@ -3108,6 +3108,10 @@ int pci_host_probe(struct pci_host_bridge *bridge)
 		pcie_bus_configure_settings(child);
 
 	pci_bus_add_devices(bus);
+
+	pm_runtime_set_active(&bridge->dev);
+	pm_runtime_enable(&bridge->dev);
+
 	return 0;
 }
 EXPORT_SYMBOL_GPL(pci_host_probe);

---
base-commit: 30417e6592bfc489a78b3fe564cfe1960e383829
change-id: 20240609-runtime_pm-7e6de1190113

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


