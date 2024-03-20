Return-Path: <linux-pci+bounces-4928-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [IPv6:2604:1380:45e3:2400::1])
	by mail.lfdr.de (Postfix) with ESMTPS id 64422880BE2
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 08:18:42 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 1D8DD282A56
	for <lists+linux-pci@lfdr.de>; Wed, 20 Mar 2024 07:18:41 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CB16A1EEE7;
	Wed, 20 Mar 2024 07:18:37 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="jeghJ6gY"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 3A2D31DA52;
	Wed, 20 Mar 2024 07:18:35 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1710919117; cv=none; b=hshGso8b2P6R9NZKTLNi7/0UtvuMOk5wKvLUrOtWXwdiDMed8CcwRGNKHci4ZQGKgcsePx2IwWQal6u6FoQEJC5ILYxfKCUSVNFg+5rQOrZdFlDwxTYk3mQfJUQ2VXhLRqermMcUbruXpUeeelYEeHx2be4h6jTgXCR69mq3GJg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1710919117; c=relaxed/simple;
	bh=jqc8a9d42oydseBd3MnOQ/UjUHTr0g9bjfXF7lZPXpw=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=Taz/75PaCVO7In3RS29FpOe+IBBXA7D7nrOT9vzbBhGmWHTm1Wnbp1fHDiU4Na68WgBzCC7WBjGTwzN/O1qigioxqNp7E+FOfoLpewFOxiOkYPJbCOm94eBwxhg06aFPAar4fd6mXLoPrl9OBUFqvE/O1rJjRVB+H06ier2bZ1g=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=jeghJ6gY; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279867.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.24/8.17.1.24) with ESMTP id 42K5FgvE022444;
	Wed, 20 Mar 2024 07:15:45 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	from:to:cc:subject:date:message-id:mime-version
	:content-transfer-encoding:content-type; s=qcppdkim1; bh=dY/Gvrm
	QwRrpRQxywaFZUf2snZsP3/BS7HqmpdE/MfI=; b=jeghJ6gYE9kWO/pvVxU4ZQw
	SFxSCzVUSdWkKLUjrqIByzEd2goN/FUjSYBBE6lM9VVtlEmQ7hwofv/MKnqOmUi1
	hrNxKCNRC3jNJvt1WbidfSkE3SsZdWS2u/q9elxzW1/43umLvCWoYvHxwbwHGTUT
	H3xwphS9LHhmzbRIkAxFC9KND3Z4gB9vT+gZ9O9GHrJRDbOiVuJTwgKeQKGTBBbc
	ssG044LoqcsrgtWr5r2UmstqfH5TkZY58zT4Vp+vH/XYYTSgtzXWgyg75oucCVQX
	LUqj3VjS0OLo9mFSHMFtI7Q5aQy9pudI7Yx9a/nCLWdKW4PyMq9gh6OVuCIsb8g=
	=
Received: from nalasppmta04.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3wyfqbhbfe-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:15:45 +0000 (GMT)
Received: from nalasex01b.na.qualcomm.com (nalasex01b.na.qualcomm.com [10.47.209.197])
	by NALASPPMTA04.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 42K7FiKN011803
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 20 Mar 2024 07:15:44 GMT
Received: from adas-linux5.qualcomm.com (10.80.80.8) by
 nalasex01b.na.qualcomm.com (10.47.209.197) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.40; Wed, 20 Mar 2024 00:15:43 -0700
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
        Serge Semin <fancer.lancer@gmail.com>,
        Yoshihiro Shimoda <yoshihiro.shimoda.uh@renesas.com>,
        Conor Dooley
	<conor.dooley@microchip.com>,
        <linux-kernel@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>
Subject: [PATCH v2 0/3] Add Gen4 equalization and margining settings
Date: Wed, 20 Mar 2024 00:14:44 -0700
Message-ID: <20240320071527.13443-1-quic_schintav@quicinc.com>
X-Mailer: git-send-email 2.43.2
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01b.na.qualcomm.com (10.47.209.197)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: cChc3fyZuxQVLduKB9Q4Z_0GMi4-BD5o
X-Proofpoint-GUID: cChc3fyZuxQVLduKB9Q4Z_0GMi4-BD5o
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.1011,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2024-03-20_04,2024-03-18_03,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 phishscore=0
 lowpriorityscore=0 impostorscore=0 bulkscore=0 adultscore=0
 priorityscore=1501 mlxscore=0 mlxlogscore=746 clxscore=1011 spamscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2403140001 definitions=main-2403200057

Add Gen4 specific equalization and rx margining settings. These
settings are inline with respective PHY settings for Gen4
operation. 

In addition, current QCOM EP and RC drivers do not share common
codebase which would result in code duplication. Hence, adding
common files for code reusability among RC and EP drivers.

v1 -> v2:
- Capitilized commit message to be inline with history 
- Dropped stubs from header file.
- Moved Designware specific register offsets and masks to
  pcie-designware.h header file.
- Applied settings based on bus data rate rather than link generation.
- Addressed review comments from Bjorn and Frank.

Shashank Babu Chinta Venkata (3):
  PCI: qcom: Refactor common code
  PCI: qcom: Add equalization settings for gen4
  PCI: qcom: Add rx margining settings for gen4

 drivers/pci/controller/dwc/Kconfig           |   5 +
 drivers/pci/controller/dwc/Makefile          |   1 +
 drivers/pci/controller/dwc/pcie-designware.h |  38 +++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.c   | 152 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-qcom-cmn.h   |  28 ++++
 drivers/pci/controller/dwc/pcie-qcom-ep.c    |  44 ++----
 drivers/pci/controller/dwc/pcie-qcom.c       |  72 ++-------
 7 files changed, 246 insertions(+), 94 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.c
 create mode 100644 drivers/pci/controller/dwc/pcie-qcom-cmn.h

-- 
2.43.2


