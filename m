Return-Path: <linux-pci+bounces-10478-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id BCA6493476A
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 07:14:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7749728383E
	for <lists+linux-pci@lfdr.de>; Thu, 18 Jul 2024 05:14:22 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 792E61E515;
	Thu, 18 Jul 2024 05:14:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="oVepOezg"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id AF9C440861;
	Thu, 18 Jul 2024 05:14:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721279660; cv=none; b=dUA7DXZoRRCq01LNPYJS+WiBeeyYukRUIKOiRClaZaIwMAh//Zk5txQtERsp/t/xVClbTl3f/hFggPu9PctRfLtTMmZF6tK3jnpozOVV9kJFz3LLawezQK8BQya5Zu2brKoHkar5sBvWxw+1ABTW5qjz2PfgQeKesZmak6xhDV0=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721279660; c=relaxed/simple;
	bh=IgIV3ieduuDHqSOU0RL5eHnuwzQ64R0B+w5H5eq1Bl8=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=DFoocy6CPZaC211cbJKdKeOdazejAmlVlOKx6QgblJSaUx8KyuJF7n/mYjyL7HXRRzxiOFQCl/GJSeRxvlomtOplkZQgIV6dyOb7vgPpeDKYBKkb6ccVYGcvF4YdJFY8aPjyuoXI1ppIPzUYnC8eW6NSuTy02N1pOG9SVL5ur54=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=oVepOezg; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279870.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46I3xqCZ028332;
	Thu, 18 Jul 2024 05:14:09 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=V4URHr1Ej5I++V7lawRyU0
	KS1UvL8E8ZW0zAGO1LUng=; b=oVepOezgGYx4THP7MrW96pXMX6BPvE7slm6ZT7
	d6AqZQc7D6UsOdX3DDL7MwlgBmz/nqK6TbmVjimorLKnuZ0ff1C90Ws0S9D+VtFQ
	njdihQwR4SnBgWs9GvnctH/3N1lvOalCBohpgGPbb0DPYt1pRnOj5mMWZjoI1SN4
	Z+NPzdPDkkCfr0DHYZSFIXRbKa/JN57t7Z+El1f3N8m7xFOJy+wXaGBSEpzh4OCB
	l4JidKV4xoKvmJMeyr8E2ECvyn74K3y2c1HrJ8ftWylAD4F0ljhOpmuB6rE4JLow
	+alhnJrf6Wte1tmIL41+W/0JLsgGeMyZiPaEcdqfO7+1tvGw==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40dwfpmdsv-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:14:09 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46I5E8Td026472
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Thu, 18 Jul 2024 05:14:08 GMT
Received: from hu-pyarlaga-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 17 Jul 2024 22:14:07 -0700
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_pyarlaga@quicinc.com>
Subject: [PATCH v2 0/2] PCI: qcom: Avoid DBI ant ATU register space mirroring
Date: Wed, 17 Jul 2024 22:12:56 -0700
Message-ID: <20240718051258.1115271-1-quic_pyarlaga@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: GN1j8Z-8JlVicN2gjcN6K2u9FQ6tq0Ve
X-Proofpoint-GUID: GN1j8Z-8JlVicN2gjcN6K2u9FQ6tq0Ve
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-18_02,2024-07-17_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 priorityscore=1501
 lowpriorityscore=0 suspectscore=0 clxscore=1011 bulkscore=0 mlxscore=0
 adultscore=0 phishscore=0 spamscore=0 malwarescore=0 mlxlogscore=745
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407180034

Qualcomm PCIe controller has a wrapper called PARF which supports the
relocation of DBI and ATU address space within the system memory. PARF
gets the location of DBI and ATU from PARF_DBI_BASE_ADDR and
PARF_ATU_BASE_ADDR registers. PARF also mirrors the memory block
containing DBI and ATU registers within the system memory. And the size
of this memory block is programmed in PARF_SLV_ADDR_SPACE_SIZE register.

Power on reset of values of the above mentioned registers are good enough
on platforms which require smaller size (less than 16MB) BAR memory. For
platforms that need bigger BAR memory size, this mirroring of DBI and ATU
address space by PARF conflicts with BAR memory.

So to allow usage of bigger size of BAR, it is required to program
PARF registers to prevent mirroring of DBI and ATU blocks and provide
the physical addresses of DBI and ATU to PARF.

This patch series stores physical addresses of DBI and ATU address space
in 'struct dw_pcie' and programs the required PARF registers in the
pcie_qcom.c driver.

Changes in v2:
- Updated commit message as suggested by Bjorn Helgaas.
- Updated function name from qcom_pcie_avoid_dbi_atu_mirroring()
  to qcom_pcie_configure_dbi_atu_base() as suggested by Bjorn Helgaas.
- Removed check for pdev in qcom_pcie_configure_dbi_atu_base() as
  suggested by Bjorn Helgaas.
- Moved the qcom_pcie_configure_dbi_atu_base() call in the
  qcom_pcie_init_2_7_0() to the same place where PARF_DBI_BASE_ADDR
  register is being programmed as suggested by Bjorn Helgaas.
- Added 'dbi_phys_addr', 'atu_phys_addr' in the 'struct dw_pcie' to store
  the physical addresses of dbi, atu base registers in
  dw_pcie_get_resources() as suggested by Manivannan Sadhasivam.
- Added separate functions qcom_pcie_configure_dbi_atu_base() and
  qcom_pcie_configure_dbi_base() to program PARF register of different
  PARF versions. This is to disable DBI mirroring in all Qualcomm PCIe
  controllers as suggested by Manivannan Sadhasivam.
- Link to v1: https://lore.kernel.org/linux-pci/a01404d2-2f4d-4fb8-af9d-3db66d39acf7@quicinc.com/T/

Tested:
- Validated NVME functionality with PCIe6a on x1e80100 platform.
- Validated WiFi functionality with PCIe4 on x1e80100 platform.

Prudhvi Yarlagadda (2):
  PCI: dwc: Add dbi_phys_addr and atu_phys_addr to struct dw_pcie
  PCI: qcom: Avoid DBI and ATU register space mirror to BAR/MMIO region

 drivers/pci/controller/dwc/pcie-designware.c |  2 +
 drivers/pci/controller/dwc/pcie-designware.h |  2 +
 drivers/pci/controller/dwc/pcie-qcom.c       | 62 ++++++++++++++------
 3 files changed, 49 insertions(+), 17 deletions(-)

-- 
2.25.1


