Return-Path: <linux-pci+bounces-16436-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [147.75.80.249])
	by mail.lfdr.de (Postfix) with ESMTPS id 265E99C39D2
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 09:42:24 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id A9E901F21D3C
	for <lists+linux-pci@lfdr.de>; Mon, 11 Nov 2024 08:42:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CE17715DBBA;
	Mon, 11 Nov 2024 08:42:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="JYccnLHB"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 14BC542A8A;
	Mon, 11 Nov 2024 08:42:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1731314538; cv=none; b=Cw57B8b/gj+jY/NPxm6InctHKL/6YdpGT0aF8z8m8k6CvgEjiZN5uFAMB1p/3A7C25J3bN22mM7ruVTzA9K1TgqzWMp3pRTuFmXB3lCT26owHYzIa36w9WUF8lFKfhD/Q9gozDqxiu6NErETbMvbWcaajdtI2jpMqQVKHAf5gsM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1731314538; c=relaxed/simple;
	bh=HaGIm0CWTjy6ovDrbfzDDfVh3nYabWup4QuT5NGPibQ=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=SgyZ7WrMXCTbno53MlIBgTZvOF9xuu+vBiWHL0fJpeMc6jRen4MOy7HVSDGjWSspCGKnRgBaEp0qS6uD/JO7TcZ4o/d5B8moqL7EP23vSiZqT/yzfaW5EFJkYFCHSIgHphxY1mioTfHzf8cCYPDa3NFgD/nXk0wxHKwQt7QSpZU=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=JYccnLHB; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4AANPtQI027759;
	Mon, 11 Nov 2024 08:42:02 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=U7uCoLnwcI4t7fzybJjno1
	qS6q4CLpM0Js6fisWQCUo=; b=JYccnLHBROThH5KULlm6KcVrZwchB0mvHQ+z6v
	uCxSVjLRVD2KCmIuKjkK7JWgyyvWJU//UDd0UrQkjWkhqtOHpHEoCforKFP+37Yf
	lyi5S6rVLQd+YTR0pilpF9hilgBqWrKWhngKr3Vdzjzvuau1UIF1MjdSTBRmLH5l
	ck0pZEx+0QnogQpLgBuKtqQ09YNPMdextP/Me9Jqjhnh9fhbC1YjSELHs5ZEX85k
	RWioTuK2VGdbTnhBPQQzKraO7W0/qqntFATHbJVth/S9yVdSM0PZyrt6H4HzTVQM
	qzNjXlJxLmG5uM30XFs4ghiOTnjl8n/vyPlnYIaWsCh/EXDg==
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42sxr5urss-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 08:42:01 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA04.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4AB8g00F016557
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 11 Nov 2024 08:42:00 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 11 Nov 2024 00:41:56 -0800
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v7 0/2] PCI: Enable runtime pm of the host bridge
Date: Mon, 11 Nov 2024 14:11:51 +0530
Message-ID: <20241111-runtime_pm-v7-0-9c164eefcd87@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAE/DMWcC/03MSwqDMBSF4a3IHTclah60o+6jSNHkWu/AqImGF
 snemwqFDv8D59shoCcMcC128Bgp0ORy6FMBZmjdExnZ3FDxSpS8VMxvbqURH/PIbG27XpS6Vp2
 CfJg99vQ6sHuTe6CwTv592FF91x+j/5moGGdSYttJU5mL4LdlI0POnM00QpNS+gCiKwWQpgAAA
 A==
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1731314516; l=3534;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=HaGIm0CWTjy6ovDrbfzDDfVh3nYabWup4QuT5NGPibQ=;
 b=YmOLULqPjhGHODju+d1djv3g5qhrmtCMXaSVNm6pciBeZ2Q6eow/BYg1lb4SeMa/4337xAD+E
 6SgdVUlYlvjDBPmbXzTrjcLK3ol2sskIO1AbGhMVG2ES7U+uhneZaoA
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: J1e5zgdnIpNCwlJ-bgfnW-cmp6NtVGep
X-Proofpoint-GUID: J1e5zgdnIpNCwlJ-bgfnW-cmp6NtVGep
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 bulkscore=0 phishscore=0
 mlxscore=0 malwarescore=0 priorityscore=1501 spamscore=0
 lowpriorityscore=0 impostorscore=0 suspectscore=0 adultscore=0
 mlxlogscore=999 clxscore=1015 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2409260000 definitions=main-2411110073

It is a property of the runtime PM framework that it can only
follow continuous dependency chains.  That is, if there is a device
with runtime PM disabled in a dependency chain, runtime PM cannot be
enabled for devices below it and above it in that chain both at the
same time.

Since runtime PM is disabled for host bridge, the state of the child
devices under the host bridge is not taken into account by PM framework
for the top level parent, PCIe controller. So PM framework, allows
the controller driver to enter runtime PM irrespective of the state
of the devices under the host bridge.

So enable runtime pm of the host bridge device, so that dependency
chain in maintained between endpoint devices and the controller driver.

PM framework expectes parent runtime pm enabled before enabling runtime
pm of the child. As PCIe starfive device is enabling runtime pm after
the pci_host_probe which enables runtime pm of the child device i.e for
the bridge device a warning is shown saying "pcie-starfive 940000000.pcie:
Enabling runtime PM for inactive device with active children" and also
shows possible circular locking dependency detected message.

As it is must to enable parent device's runtime PM before enabling child's
runtime pm as the pcie-starfive device runtime pm is enabled after child
runtime starfive device is seeing the warning.

In the first patch fix the pcie-starfive driver by enabling runtime
pm before calling pci_host_probe().

All other PCIe controller drivers are enabling runtime pm before
calling pci_host_probe() which is as expected so don't require any
fix like pcie-starfive driver.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v7:
- Bring the cover letter details to commit message as suggested by bjorn.
- Add a comment in the driver to ensure pm_runtime_enable is called
  before host bridge pm_runtime_enable().
- Link to v6: https://lore.kernel.org/r/20241017-runtime_pm-v6-0-55eab5c2c940@quicinc.com
Changes in v6:
- include the patch by mayank which fixes runtime pm enable order for
  pcie starfive driver.
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
Krishna chaitanya chundru (1):
      PCI: Enable runtime pm of the host bridge

Mayank Rana (1):
      PCI: starfive: Enable PCIe controller's runtime PM before probing host bridge

 drivers/pci/controller/plda/pcie-starfive.c | 10 +++++++---
 drivers/pci/probe.c                         | 11 +++++++++++
 2 files changed, 18 insertions(+), 3 deletions(-)
---
base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
change-id: 20241016-runtime_pm-d3dbf41736b6

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


