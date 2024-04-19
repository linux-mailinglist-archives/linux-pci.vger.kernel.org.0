Return-Path: <linux-pci+bounces-6466-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id 5C3248AA621
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 02:12:17 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id 8E6AC1C2157B
	for <lists+linux-pci@lfdr.de>; Fri, 19 Apr 2024 00:12:16 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 1A8E339B;
	Fri, 19 Apr 2024 00:10:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="DDGWCZ53"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AC961DDD5;
	Fri, 19 Apr 2024 00:10:47 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1713485449; cv=none; b=DSZLbeB+OH+ZA4t6unMwH7F8Ar5ZKLI3P2IneCvB6Xdkzc9AeF4MwSE0xDjnIQdh0Lvs0VzbSyoW01/If2YaCARd9h+zvc6mSe8jlXH1VrkH2FoSBLK4igeyujuC80KD2X5xEcnLxHLnE63QOGHNB0PGbhx0nPJfjEsmOq9F9GE=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1713485449; c=relaxed/simple;
	bh=vt9o9pMYCW7hhpcZsv8ddcoj4OiStUOgb8ev/ufEpqU=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=EZlwS1zAEjAotvtMPMQvoIyPfgRzYnH2gXUbtckMotqmmHJ/UquTDB3d8oen0X1G87obIHP0J5yYgxQoLWUZsqreqNZf8i9gEjzUlNQqrgyY9QukvuB9kK261FF1u5rb5R4Jt7HmEMovvvVBC+Gf5gDII02V+cwQyBrcPr45eIk=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=DDGWCZ53; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 43INbfPi004091;
	Fri, 19 Apr 2024 00:10:33 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=E+MUUFF
	9nUQU8Lod6cFIwRusIEFGRZulrqTCSTn2l4E=; b=DDGWCZ53FhT+QCfVKD32aYt
	i0jfb2R8cKDlrQ5IsA28ZWUdPjARYcZ/ht64cUfJnVTPmQbfMe8a/fxYLvgrh4TW
	EWxAbxjegTtGHWAV23EAabMwfOfF6FNX4R1IgSzpHUOuGKJcEmm5/7GLohFmNJ7d
	SiimyCaZ+KWR8nNQDBl0e49rdBf7eLYrk4up5Q4gjq570Ak+oUzMU6uc2oO7b0hp
	6HeK51qxYIF1jzS1hQnenwyacpIuxCGJHc3VTBgtgy4dSF5RAyMOarun6knvANkg
	BO2lRVz0dUjtV42JsonoHJPsNwCIDX4yDmbzNH4zwFYP+xNXX7LnR0E0/Nnfong=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xjx54j9dd-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:33 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 43J0AWOg015865
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Fri, 19 Apr 2024 00:10:32 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Thu, 18 Apr 2024 17:10:31 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <agross@kernel.org>, <andersson@kernel.org>, <konrad.dybcio@linaro.org>,
        <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Jingoo Han <jingoohan1@gmail.com>,
        Gustavo Pimentel
	<gustavo.pimentel@synopsys.com>,
        Manivannan Sadhasivam
	<manivannan.sadhasivam@linaro.org>,
        Yoshihiro Shimoda
	<yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v3 0/3] Add 16GT/s equalization and margining settings
Date: Thu, 18 Apr 2024 17:09:33 -0700
Message-ID: <20240419001013.28788-1-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
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
X-Proofpoint-GUID: CgrkrAVWo0boEGpqahhkjGnIaLHOEfu2
X-Proofpoint-ORIG-GUID: CgrkrAVWo0boEGpqahhkjGnIaLHOEfu2
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-04-18_21,2024-04-17_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 adultscore=0 mlxscore=0
 suspectscore=0 malwarescore=0 phishscore=0 mlxlogscore=764 bulkscore=0
 impostorscore=0 spamscore=0 lowpriorityscore=0 priorityscore=1501
 clxscore=1011 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2404010003 definitions=main-2404190000

Add 16GT/s specific equalization and rx lane margining settings. These
settings are inline with respective PHY settings for 16GT/s 
operation. 

In addition, current QCOM EP and RC drivers do not share common
codebase which would result in code duplication. Hence, adding
common files for code reusability among RC and EP drivers.

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
  PCI: qcom: Add equalization settings for 16GT/s
  PCI: qcom: Add rx margining settings for 16GT/s

 drivers/pci/controller/dwc/Kconfig            |   5 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |  30 ++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 129 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  14 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  44 ++----
 drivers/pci/controller/dwc/pcie-qcom.c        |  72 ++--------
 7 files changed, 201 insertions(+), 94 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h

-- 
2.43.2


