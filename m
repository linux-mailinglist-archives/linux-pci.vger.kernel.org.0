Return-Path: <linux-pci+bounces-4512-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AE78E8719EB
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 10:49:31 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id D21FA1C20F84
	for <lists+linux-pci@lfdr.de>; Tue,  5 Mar 2024 09:49:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0796E535B9;
	Tue,  5 Mar 2024 09:49:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Hab/4V8O"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3CFC4535AB;
	Tue,  5 Mar 2024 09:49:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1709632165; cv=none; b=vDPM8pmJAXzsCfTmuxXpkvHXhjRak1z64OVgJW86lGl37LfSqpiHI+HlVcIfqlUKnnxW9MpjWxT9SZUtE9e6JXFdJZHsxpFbwWq+GYbT5BNpwE6PBGRDrtKyVLAuQ5+X/AAbu7iCFnhd+W6CmHSHc6UBpaHy4UmKCnTBeoWB1ik=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1709632165; c=relaxed/simple;
	bh=5E821RFhqqoYavc661H3Vby84CJMt3ugUPHZ0daBHkQ=;
	h=From:Date:Subject:MIME-Version:Content-Type:Message-ID:To:CC; b=J34ayuFnTShzCoNz2IzGUiRMq+Fub0F8RR7X+iyEZK5LutwANf0ntxkDFIIKUEMjjHAZk0l4xr0T4ZScr8PgMrULALhEc9/Rau0CxgxVer1s/aqmQ/SvFj/0AP0+itr2z+yTcxQdhaU0EBtj8ekpIEu5+5YXtio9QAWw/bGf91o=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Hab/4V8O; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42553t6u029981;
	Tue, 5 Mar 2024 09:49:15 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:date:subject:mime-version:content-type
	:content-transfer-encoding:message-id:to:cc; s=qcppdkim1; bh=37x
	Rd+lDnWXrIknF2wufL57eoqOYbhNwCDos2tpE4Ww=; b=Hab/4V8Ogipy1SXWbej
	rMZBfN3pqRBAz3DiXVp4xm0NN+92fBoUapenjI+UKuiizakPcH+g57a0NRyhzF5w
	6TJd5OffvbQgMx/c4CwQWes4JkfXmUcXWy3lJQXup7C4/PRS0aUtKQ7Rjpr2Dmbx
	zpjlwrPrCHuyqARt5HlP/q4vYUeEPQL5HsCVHWCp1xq6PSh7TuD7vKcttIbSLCIK
	CmNvCjUjReQJGhztLMlubHgP7Apl5a+sDS043N2TJ1TLfJ52xUAF1F7Rd8KXGlDF
	BNVavQBL4krIDByDToWLAlrC/3DFmVwg7d+H/AGxHZdaW2tW7DoAG0ms+1lk9f3v
	Eyw==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wnucrrnxj-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 05 Mar 2024 09:49:14 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 4259nDpM027674
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 5 Mar 2024 09:49:13 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Tue, 5 Mar 2024 01:49:09 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Date: Tue, 5 Mar 2024 15:19:01 +0530
Subject: [PATCH v2] PCI: dwc: Enable runtime pm of the host bridge
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-ID: <20240305-runtime_pm_enable-v2-1-a849b74091d1@quicinc.com>
X-B4-Tracking: v=1; b=H4sIAI7q5mUC/32NWw6CMBBFt0Lm25pOeRj8Yh+GEGhHmUQKttBoS
 PduZQF+npPcc3fw5Jg8XLMdHAX2PNsE6pSBHnv7IMEmMSipCqmwFm6zK0/ULVNHth+eJAaj8VJ
 jMZhSQtotju78Ppq3NvHIfp3d57gI+LP/agEFCpPXVSVzlKUsmtfGmq0+63mCNsb4BdVSMm60A
 AAA
To: Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <quic_vbadigan@quicinc.com>, <quic_ramkri@quicinc.com>,
        <quic_nitegupt@quicinc.com>, <quic_skananth@quicinc.com>,
        <quic_parass@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.13-dev-83828
X-Developer-Signature: v=1; a=ed25519-sha256; t=1709632149; l=2100;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=5E821RFhqqoYavc661H3Vby84CJMt3ugUPHZ0daBHkQ=;
 b=G3dl0g0NBTsD6FjHqaBqA2TnM9x871FV2qppYqJMGXtQaJdm33pKXg7Ni/R7iYxTsnA96q7N+
 6SffEACZtmWBb2JTyyKrdpHHrJwKU5dwkObI0hkvKQHyB6LNZzDUhlr
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: bBbxfCd8AWUJgsQOvlJrv9AZuqxY1ORy
X-Proofpoint-ORIG-GUID: bBbxfCd8AWUJgsQOvlJrv9AZuqxY1ORy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-05_07,2024-03-04_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 clxscore=1011 bulkscore=0
 spamscore=0 adultscore=0 mlxscore=0 phishscore=0 priorityscore=1501
 malwarescore=0 impostorscore=0 mlxlogscore=999 lowpriorityscore=0
 suspectscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2402120000 definitions=main-2403050078

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

Since runtime PM is disabled for host bridge, the state of the child
devices under the host bridge is not taken into account by PM framework
for the top level parent, PCIe controller. So PM framework, allows
the controller driver to enter runtime PM irrespective of the state
of the devices under the host bridge. And this causes the topology
breakage and also possible PM issues.

So enable pm runtime for the host bridge, so that controller driver
goes to suspend only when all child devices goes to runtime suspend.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v2:
- Updated commit message as suggested by mani.
- Link to v1: https://lore.kernel.org/r/20240219-runtime_pm_enable-v1-1-d39660310504@quicinc.com
---
 drivers/pci/controller/dwc/pcie-designware-host.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pci/controller/dwc/pcie-designware-host.c b/drivers/pci/controller/dwc/pcie-designware-host.c
index d5fc31f8345f..57756a73df30 100644
--- a/drivers/pci/controller/dwc/pcie-designware-host.c
+++ b/drivers/pci/controller/dwc/pcie-designware-host.c
@@ -16,6 +16,7 @@
 #include <linux/of_pci.h>
 #include <linux/pci_regs.h>
 #include <linux/platform_device.h>
+#include <linux/pm_runtime.h>
 
 #include "../../pci.h"
 #include "pcie-designware.h"
@@ -505,6 +506,9 @@ int dw_pcie_host_init(struct dw_pcie_rp *pp)
 	if (pp->ops->post_init)
 		pp->ops->post_init(pp);
 
+	pm_runtime_set_active(&bridge->dev);
+	pm_runtime_enable(&bridge->dev);
+
 	return 0;
 
 err_stop_link:

---
base-commit: 6613476e225e090cc9aad49be7fa504e290dd33d
change-id: 20240219-runtime_pm_enable-bdc17914bd50

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


