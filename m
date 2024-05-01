Return-Path: <linux-pci+bounces-6965-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [IPv6:2604:1380:40f1:3f00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AC1D18B8E4C
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 18:37:05 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id 963FFB210D3
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2024 16:37:02 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 666A4DF49;
	Wed,  1 May 2024 16:36:54 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EiYItbn/"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id ECDCCCA40;
	Wed,  1 May 2024 16:36:52 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1714581414; cv=none; b=ZUDL6QZz5kZZxZwkwRB/0r4evuCx5/RwzsCsS84XFLUnItRXmUDBeoWqz9NZk534VAqCDA8VZhmMRSCJ4TgjiIxLfq5b5JrhCkh1olGsNN1gAvas3Ee5nJH+raG7Z9mAT1iu06lXc7MHIhjd5t03HaRBfxUr920A5BsE7rjHeyQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1714581414; c=relaxed/simple;
	bh=IgMIlSYfvDVdAJDE7T4Vv5E2W0W6APz7aES5P89wtVI=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=gzwDl5JnIslOkgcz4x0Pl4p4BTJvkSAgpDP5kUnl8D0qOHumFJK18yxGNTJGtCSe7BrQAWjbtDWt5xtPsdxUonW5zOd+sF+WHpxeM5hFRW32p/1BTutHvbxh4UnqzM6Yd9EigiKLxgFIlyGg9w21Ako+MkHnDO7evsJomlNo/t8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EiYItbn/; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279865.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 441EP51N009005;
	Wed, 1 May 2024 16:36:25 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=fSZ/lf2
	7TPgmVrDdD6hg18qXkqJ+CXRl0/aTgcJH90I=; b=EiYItbn/axFx6wgtQJkaaTB
	Tcd/Awv4FNjrYPynH//U2RSDgNnuAJRL+FLqIzGqkRZ8ysy9iZ45LPL/SSKtyKW7
	qB732mePnH7jI19HJy+x5bfOVlhUvOpObb8UfTYhXm4znk43w1bqKCjuPTdOnZmu
	wkuOWfYLjnPgL1GZOlwqhJQ9sG3g8Ji5vJDkoJBXUmvP6B/ppGJp6O/dOCFH/0mi
	lRQsL9QH0x/04j9Qa7WkUx/5apdD+HFyPEmdOmuvacN3Ag1FhO+RZYpbaoBBPN9J
	YvTv9Rga2UXOawzwXQIbmdM2pa0T+Jn4bvA0+l83NFBYVD/1oMfTcMfevmVaoKA=
	=
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3xu71j9yea-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 01 May 2024 16:36:25 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA02.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 441GaO5j002665
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 1 May 2024 16:36:24 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 1 May 2024 09:36:23 -0700
From: Shashank Babu Chinta Venkata <quic_schintav@quicinc.com>
To: <jingoohan1@gmail.com>, <gustavo.pimentel@synopsys.com>,
        <manivannan.sadhasivam@linaro.org>, <andersson@kernel.org>,
        <agross@kernel.org>, <konrad.dybcio@linaro.org>, <mani@kernel.org>
CC: <quic_msarkar@quicinc.com>, <quic_kraravin@quicinc.com>,
        Lorenzo Pieralisi
	<lpieralisi@kernel.org>,
        =?UTF-8?q?Krzysztof=20Wilczy=C5=84ski?=
	<kw@linux.com>,
        Rob Herring <robh@kernel.org>, Bjorn Helgaas
	<bhelgaas@google.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Serge Semin <fancer.lancer@gmail.com>,
        Conor Dooley
	<conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v4 0/3] pci: qcom: Add 16GT/s equalization and margining settings
Date: Wed, 1 May 2024 09:35:31 -0700
Message-ID: <20240501163610.8900-1-quic_schintav@quicinc.com>
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
X-Proofpoint-GUID: zZsiEpQCBcyX6PTLPBdAsAnp2nNUFhg_
X-Proofpoint-ORIG-GUID: zZsiEpQCBcyX6PTLPBdAsAnp2nNUFhg_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1011,Hydra:6.0.650,FMLib:17.11.176.26
 definitions=2024-05-01_16,2024-04-30_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0
 mlxlogscore=733 bulkscore=0 adultscore=0 priorityscore=1501
 impostorscore=0 phishscore=0 mlxscore=0 lowpriorityscore=0 spamscore=0
 clxscore=1015 malwarescore=0 classifier=spam adjust=0 reason=mlx
 scancount=1 engine=8.19.0-2404010003 definitions=main-2405010117

Add 16GT/s specific equalization and rx lane margining settings. These
settings are inline with respective PHY settings for 16GT/s 
operation. 

In addition, current QCOM EP and RC drivers do not share common
codebase which would result in code duplication. Hence, adding
common files for code reusability among RC and EP drivers.

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

 drivers/pci/controller/dwc/Kconfig            |   5 +
 drivers/pci/controller/dwc/Makefile           |   1 +
 drivers/pci/controller/dwc/pcie-designware.h  |  30 ++++
 drivers/pci/controller/dwc/pcie-qcom-common.c | 144 ++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-common.h |  14 ++
 drivers/pci/controller/dwc/pcie-qcom-ep.c     |  44 ++----
 drivers/pci/controller/dwc/pcie-qcom.c        |  74 ++-------
 7 files changed, 218 insertions(+), 94 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-common.h

-- 
2.43.2


