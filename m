Return-Path: <linux-pci+bounces-15793-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id C3EAB9B904F
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 12:34:37 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 88D5C2816CD
	for <lists+linux-pci@lfdr.de>; Fri,  1 Nov 2024 11:34:36 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id A882815278E;
	Fri,  1 Nov 2024 11:34:32 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hqf/hcz/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id BB31D152787;
	Fri,  1 Nov 2024 11:34:30 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730460872; cv=none; b=dDSlx+Szav2/7Y+3ZS7Z4nUwQ7M159zLsZCdqONVxAuqSKDzFoAH8BIwjkN/9oFFKP8NpuSReoxevjSdbocdpbFlUVvFSGmxStGNXIO/bHWs2zXBciABZjz3jNrca01ajQ1JY+mqn+VK294Kv9os3vlIKTyomDea3iMyBVbIh9o=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730460872; c=relaxed/simple;
	bh=cCuPEw1nRggX80IpVX6loag2/fvtqa/cNWHz9a3fcKc=;
	h=From:Subject:Date:Message-ID:MIME-Version:Content-Type:To:CC; b=fD+L6fzqD8X0wjgicnG2IbQgFjuSEO1YNy7B4/ZqLI8Ys3TMEkg6ddELtuu5xIgD2YRAdfkK8bLHy59v/K2mW/H2aLUweRt/2jA2lBqk5ooMz6UVuZYyi1MgaMhR1ngtDWWGFU5KWeZiVzVFRQLun2wmMzzzbv8SitcqVOX5kok=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=hqf/hcz/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A19AodI004729;
	Fri, 1 Nov 2024 11:34:21 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=m22GMBiTbZ801k2VT01Pmi
	NYrtHEJ0pScFTFygIcNQY=; b=hqf/hcz/vzNVvUr4rCd7NrwxBPMHZveafhuuVT
	GxpnYjCWBVdVHj0tDWfKDw366MJ9KoAfbRDjtmzdmNQc1oP6Crn2u4d2Tg4o1wjl
	b+Ij4EO1IQXDbhgNLS3ICP4gVPY7NjYpooncT24BZtqtTDovoOFgFuxaUH4AqgW2
	AAd3B309AF532Cig4eHNtt3KhDRYdeOkvPrFayePzIvGcytseyfWd/HHkqPTf+iN
	h9B8fN2gH3WIcB0CPlxfGdbh/Ll1YFd1zpaxdYDJBQ2crj+kcf/HY/cjtEFPg+Vo
	2k/vL4hJiJncugA5pq4XCbOB/4q18wOFyeFeH5S2HyT6dzCw==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42m65pc83c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 01 Nov 2024 11:34:21 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A1BYKra028857
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 1 Nov 2024 11:34:20 GMT
Received: from hu-krichai-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Fri, 1 Nov 2024 04:34:17 -0700
From: Krishna chaitanya chundru <quic_krichai@quicinc.com>
Subject: [PATCH v3 0/3] PCI: dwc: Skip waiting for link up if vendor
 drivers can detect Link up event
Date: Fri, 1 Nov 2024 17:04:11 +0530
Message-ID: <20241101-remove_wait-v3-0-7accf27f7202@quicinc.com>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIALO8JGcC/6tWKk4tykwtVrJSqFYqSi3LLM7MzwNyjHUUlJIzE
 vPSU3UzU4B8JSMDIxNDQwND3aLU3Pyy1PjyxMwSXQuDxBQTY1MT80QTEyWgjoKi1LTMCrBp0bG
 1tQB3KwIBXQAAAA==
To: Jingoo Han <jingoohan1@gmail.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?utf-8?q?Krzysztof_Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_vbadigan@quicinc.com>,
        Krishna chaitanya chundru
	<quic_krichai@quicinc.com>
X-Mailer: b4 0.14.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1730460856; l=1776;
 i=quic_krichai@quicinc.com; s=20230907; h=from:subject:message-id;
 bh=cCuPEw1nRggX80IpVX6loag2/fvtqa/cNWHz9a3fcKc=;
 b=fQxlNzG6q2Ff7pfDCBuNEEm0XpeAiZKsaGwif/kcmswGQu43nq7/HB1y3TfsYEe6pl4hge82W
 bT+IS1jBT49DJLZTcm3fgSwFxxtYMS4t1qICIcD1AKsCDXMZ7QjGrTA
X-Developer-Key: i=quic_krichai@quicinc.com; a=ed25519;
 pk=10CL2pdAKFyzyOHbfSWHCD0X0my7CXxj8gJScmn1FAg=
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 5bpbokblD4pLXamt9h4kMBVsQxGixpVW
X-Proofpoint-GUID: 5bpbokblD4pLXamt9h4kMBVsQxGixpVW
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxscore=0 spamscore=0
 phishscore=0 malwarescore=0 clxscore=1015 priorityscore=1501
 mlxlogscore=453 suspectscore=0 lowpriorityscore=0 bulkscore=0 adultscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411010083

If the vendor drivers can detect the Link up event using mechanisms
such as Link up IRQ, then waiting for Link up during probe is not
needed. if the drivers can be notified when the link comes up,
vendor driver can enumerate downstream devices instead of waiting
here, which optimizes the boot time.

So skip waiting for link to be up if the driver supports 'linkup_irq'.

Currently, only Qcom RC driver supports the 'linkup_irq' as it can detect
the Link Up event using its own 'global IRQ' interrupt. So set
'linkup_irq' flag for QCOM drivers.

As part of the PCIe link up event, the ICC and OPP values are updated.

Signed-off-by: Krishna chaitanya chundru <quic_krichai@quicinc.com>
---
Changes in v3:
- seperate dwc changes and qcom changes as suggested (mani)
- update commit & comments as suggested (mani & bjorn)
Changes in v2:
- Updated the bypass_link_up_wait name to linkup_irq  & added comment as
  suggested (mani).
- seperated the icc and opp update patch (mani).
- Link to v1: https://lore.kernel.org/r/20240917-remove_wait-v1-1-456d2551bc50@quicinc.com

---
Krishna chaitanya chundru (3):
      PCI: dwc: Skip waiting for link up if vendor drivers can detect Link up event
      PCI: qcom: Set linkup_irq if global IRQ handler is present
      PCI: qcom: Update ICC and OPP values during link up event

 drivers/pci/controller/dwc/pcie-designware-host.c | 10 ++++++++--
 drivers/pci/controller/dwc/pcie-designware.h      |  1 +
 drivers/pci/controller/dwc/pcie-qcom.c            |  7 ++++++-
 3 files changed, 15 insertions(+), 3 deletions(-)
---
base-commit: 070f00ffd0bac88ed5e874c9ae0378f75e2203f3
change-id: 20241101-remove_wait-80ad43547a44

Best regards,
-- 
Krishna chaitanya chundru <quic_krichai@quicinc.com>


