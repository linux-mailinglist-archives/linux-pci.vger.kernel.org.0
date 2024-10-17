Return-Path: <linux-pci+bounces-14802-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 995809A2702
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 17:39:31 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FB4E280A49
	for <lists+linux-pci@lfdr.de>; Thu, 17 Oct 2024 15:39:30 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 787981E0B7A;
	Thu, 17 Oct 2024 15:36:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="AZIjvdgP"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8B66D1E0488;
	Thu, 17 Oct 2024 15:36:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729179386; cv=none; b=LMZQiA39l76QvEiY+z7ePNFr+DursdBN2NXEbVfMoG5XYnmRXvM33dGOL4JUYNjCXmbzPLnzfNrKguOiMYYfsYDzn0C6iKMp66s4VV6vVkebJ2r1lKF7wBPRFnBzBGScoNVZeOCJ2f1mCZWvYyjThMrQpcdrBd+ytVIdXmX9EsA=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729179386; c=relaxed/simple;
	bh=rMoVbOjsdNs0tgHS8GhSs7UqgJqZFwlqgjMCdaHfD0Y=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=F9l1B7DiDrtxxTt19VQWJ/ZTFUA01p6WzlR0oyWynSHSg3mIVpBKVMZR8jKqUbw/JtbMiThhXWq46sMi+GMhNZfKLvQ39TPiFWvaJii3KcyMxQ935UtTZZ8Kz9oikhbosXqUKTwdil/WY76uGe4OgKdaHuAY6qmban/lC7FzpYc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=AZIjvdgP; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 49H7klFO007441;
	Thu, 17 Oct 2024 15:35:58 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=iqBhkS/+7zCSZ/Q16nLk07
	LE2oh6XJsuib5XbAC5EZA=; b=AZIjvdgPXOdKPa5SiyQF/rHSjXN2LjRQqDgt7c
	BIZAevTTVbAj38f4Z/poC0h94haUtkxWSL+2yNx8msYrKVQetOx9U1XUgPHOUn2m
	kfo9wYTceyPyzDe/BcNaU0+ZQQJRYr06U1zh05fT09bMEA/NBjOaaF5dPBO8ctg8
	/Hs8fSAgiTU8xy6YcHHEriRT5IipVz185iACO4xi6XUptYigUgcfdsK87EUOeGqi
	ze4VyyYR3bTGmhXnWEcpSViNgvLtL/NgUrD7OQ8tjx50Fdaw4RpqrOTVba50fdMw
	t+79SDOzEck9Q4a+nZj76KXoVrEw62BdxJNYX5xe0JKbzd+w==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 429mjy8p1u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:35:58 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 49HFZu4H028086
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 17 Oct 2024 15:35:56 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 17 Oct 2024 08:35:53 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v6 0/2] PCI: Enable runtime pm of the host bridge
Date: Thu, 17 Oct 2024 21:05:49 +0530
Message-ID: <20241017-runtime_pm-v6-0-55eab5c2c940@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANUuEWcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyzHQUlJIzE
 vPSU3UzU4B8JSMDIxNDA0Mz3aLSvJLM3NT4glzdFOOUpDQTQ3NjsyQzJaCGgqLUtMwKsGHRsbW
 1AK6aYf1cAAAA
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
X-Developer-Signature: v=1; a=ed25519-sha256; t=1729179352; l=3234;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=rMoVbOjsdNs0tgHS8GhSs7UqgJqZFwlqgjMCdaHfD0Y=;
 b=oUXU5+9za95j1TPaIXGXO2D+zRkgft4JNt6mTOm24KUuO3menvWTUwiikZnL1TKTUelI6iAQu
 3QPnMHyEAQcDQsmmYb603S1lWhc8FwxXKKbhRYz03qXcogZyguFkvik
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: UMI6oOzJs1esLZN00Z8vIQku21nwrkJy
X-Proofpoint-ORIG-GUID: UMI6oOzJs1esLZN00Z8vIQku21nwrkJy
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=987 phishscore=0
 mlxscore=0 lowpriorityscore=0 malwarescore=0 priorityscore=1501
 impostorscore=0 clxscore=1011 spamscore=0 suspectscore=0 adultscore=0
 bulkscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2410170107

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
 drivers/pci/probe.c                         |  5 +++++
 2 files changed, 12 insertions(+), 3 deletions(-)
---
base-commit: 2f87d0916ce0d2925cedbc9e8f5d6291ba2ac7b2
change-id: 20241016-runtime_pm-d3dbf41736b6

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


