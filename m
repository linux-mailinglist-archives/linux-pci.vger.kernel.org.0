Return-Path: <linux-pci+bounces-11970-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 55B7195A391
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 19:10:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 87DDA1C228BE
	for <lists+linux-pci@lfdr.de>; Wed, 21 Aug 2024 17:10:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3986C1B253C;
	Wed, 21 Aug 2024 17:10:08 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mDZxuC6p"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 8CFBC1B2518;
	Wed, 21 Aug 2024 17:10:06 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1724260208; cv=none; b=oKYeB0D+/O/pi69CIlK07bsoGwyBOaYnAnx/NSEt+UHZ+tXs1zh7eIqg34IRo2qDl5lztcHNXpfwBoa4N4EHTyQbElTScwhc+F91W8X5ITIftoQ/rwRfen+k1E2u3AVsTLCe9dNI+aypb1h9XAq+uLsX6aTSa7DweIoev9B9fK8=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1724260208; c=relaxed/simple;
	bh=VV6Bq0dkunErQYLEFCVupR1wLSEJ2NeSyZHlMh6rb3c=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=ILj/u0nuzVHxUQ6vuCKR7790o70AQxEE3FSNFXbB84kZxUvOiewGi15Lx8DOU9H86F2e5rqXjKoZ1FwDYUZ7I7jeKpGPEBjSu1Y/EMb08LBFRzF6vQV+ht9AifDdqPr69zD6lLJIiQDeQDMuM/dgLW2udYsULvqHu0UwGOsX05I=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mDZxuC6p; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 47L8hxqH011278;
	Wed, 21 Aug 2024 17:09:46 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=a9iOF3uMridQTmqJCLXWZH
	x8X0Plui57nJG/FmM51w8=; b=mDZxuC6ptiqFRgiFdkt7UaO1fnrK6xNYY618MT
	9W9agZ8aO7i+WC5bSkLVYIQlxDyKX7kYgK3fhOdIlamMbshykcS0/TZpQUX7A9k5
	plNL9Cp+GtcKPNbXd6oZ3lT6yRcE/YGelyPXqGmwYsE+Wf4Z8YPCsPOCJ+O0OiJ/
	2IoZ8jNe0r2TgFX3k4YrO8oVP8N7bTIU06zkt5qem/3h8gerOHldE6sf+hfYqGVP
	Sw867lTNDp5dMVtqNTK/5rD6Lk/XvJF4D4tLOdXuhM1Hny7HEOJCly83ItF+Ajl0
	DE68cgs5pK+F4SjxvtU4ovZFVRJtm8fHF6HlePqOXoNe5kKA==
Received: from nalasppmta01.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 414j5768jt-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:09:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA01.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 47LH9iRU024677
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 21 Aug 2024 17:09:44 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 21 Aug 2024 10:09:43 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        "Rob Herring" <robh@kernel.org>, Bjorn Helgaas <bhelgaas@google.com>,
        Jingoo
 Han <jingoohan1@gmail.com>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Niklas Cassel <cassel@kernel.org>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v5 0/3] pci: qcom: Add 16GT/s equalization and margining settings
Date: Wed, 21 Aug 2024 10:08:41 -0700
Message-ID: <20240821170917.21018-1-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.46.0
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: 6g18XFZ-IbdOTP5HQMMner62XpABirny
X-Proofpoint-GUID: 6g18XFZ-IbdOTP5HQMMner62XpABirny
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-08-21_11,2024-08-19_03,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 mlxlogscore=927
 priorityscore=1501 clxscore=1011 bulkscore=0 phishscore=0 impostorscore=0
 adultscore=0 suspectscore=0 mlxscore=0 spamscore=0 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2408210124

Add 16GT/s specific equalization and rx lane margining settings. These
settings are inline with respective PHY settings for 16GT/s 
operation. 

In addition, current QCOM EP and RC drivers do not share common
codebase which would result in code duplication. Hence, adding
common files for code reusability among RC and EP drivers.

v4 -> v5:
- Added additional parameter bandwidth to accommodate new icc path.
- Fixed typo.
- Picked up Reviewed-by tags.

v3 -> v4:
- Addressed review comments from Mani and Konrad.
- Preceded subject line with pci: qcom: tags

v2 -> v3:
- Replaced FIELD_GET/FIELD_PREP macros for bit operations.
- Renamed cmn to common.
- Avoided unnecessary argument validations.
- Addressed review comments from Konrad and Mani.

v1 -> v2:
- Capitilized commit message to be inline with history 
- Dropped stubs from header file.
- Moved Designware specific register offsets and masks to
  pcie-designware.h header file.
- Applied settings based on bus data rate rather than link generation.
- Addressed review comments from Bjorn and Frank.

Shashank Babu Chinta Venkata (3):
  PCI: qcom: Refactor common code
  PCI: qcom: Add equalization settings for 16 GT/s
  PCI: qcom: Add RX margining settings for 16 GT/s

 MAINTAINERS                                   |   3 +
 drivers/pci/controller/dwc/Kconfig            |   5 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |  30 ++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 156 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  17 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  44 +----
 drivers/pci/controller/dwc/pcie-qcom.c        | 146 ++++++----------
 8 files changed, 271 insertions(+), 131 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h

-- 
2.46.0


