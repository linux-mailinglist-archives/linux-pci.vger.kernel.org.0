Return-Path: <linux-pci+bounces-10688-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [147.75.199.223])
	by mail.lfdr.de (Postfix) with ESMTPS id C1DB293AB39
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 04:28:41 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id EAABC1C22D5D
	for <lists+linux-pci@lfdr.de>; Wed, 24 Jul 2024 02:28:40 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 49F441C6B4;
	Wed, 24 Jul 2024 02:28:18 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="mrxqKlBm"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 7537F1B7E9;
	Wed, 24 Jul 2024 02:28:16 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721788098; cv=none; b=d4X7WcOhFn0kKGM1cO8gVoRCKHvYaCmvMTZmWSX4GtNsZxyVw9QfhWOVWYpOFsQ7KhuufIqYcgq2mA1t6L04mJNoBXjIVZMud0zTsWsnQkGVB7q5l/EtjAot5He1D+CXDEOnWMHwJOo+XiRPinEMjv/a3Y8q/e5J8azbIOWApqg=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721788098; c=relaxed/simple;
	bh=cDRYinNTcJfG3NFoF3+R+6ix6ze7FaT/m9QPqur/oJg=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=OXh74DIeqpBd8ssRtQYGcyd0+AJVnolOt6BOk7mz0ebZTJz6iB4fo+Gmfa/AvT3XR+gShbHYR01Y8lWJ3dc+QcujOBsIQZ39lqXYBpY/eoGbzbu4G20dmToCZtz8EBWjGYK+caL/yjRVtFy5NY8Ec2BLl0i8VoIEGOl3PPWE7fc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=mrxqKlBm; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279873.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46NHVRDO011183;
	Wed, 24 Jul 2024 02:28:03 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=VSHU3mm7kCkNin9t6L5UA6
	nFf9IJi8ADAKuZjNgyRRU=; b=mrxqKlBmRnYYo+WYCG7VIJrAyxVblQEVw/JFqL
	ZGTnx85Run5fMroFhc74QOBVQJ3ZR7TfR4DPGvHRS2sl7avDoPi22bPaUxwLV6m/
	I/oTU2REK5sHuHJje2pv9AYVnRfNbz2IrIpBXG3j/A2mh+nM49m7nHNWEUega4Zb
	XuDwhCi77AVquDb1/gpdOg1OgAlg0cgsMQa7Kr3hMuTr/7o0lHuhLMltUA16Ssre
	l/Cng9pCtIUP5dAoFAhU70aH5YwKY9IeakhK+zAIPV2E5ZxSm8TfRLGNA5yNKFKZ
	ChrkszKFvadyPUFr38QpSUnFemq5lc4V81ngwAH93oOo0x5w==
Received: from nasanppmta01.qualcomm.com (i-global254.qualcomm.com [199.106.103.254])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40g2kn0ygx-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 02:28:03 +0000 (GMT)
Received: from nasanex01b.na.qualcomm.com (nasanex01b.na.qualcomm.com [10.46.141.250])
	by NASANPPMTA01.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46O2S21J030621
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 24 Jul 2024 02:28:02 GMT
Received: from hu-pyarlaga-lv.qualcomm.com (10.49.16.6) by
 nasanex01b.na.qualcomm.com (10.46.141.250) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Tue, 23 Jul 2024 19:28:01 -0700
From: Prudhvi Yarlagadda <quic_pyarlaga@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <lpieralisi@kernel.org>, <kw@linux.com>, <robh@kernel.org>,
        <bhelgaas@google.com>
CC: <linux-pci@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <quic_mrana@quicinc.com>,
        <quic_pyarlaga@quicinc.com>
Subject: [PATCH v3 0/2] PCI: qcom: Avoid DBI and ATU register space mirroring
Date: Tue, 23 Jul 2024 19:27:17 -0700
Message-ID: <20240724022719.2868490-1-quic_pyarlaga@quicinc.com>
X-Mailer: git-send-email 2.25.1
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-ClientProxiedBy: nalasex01b.na.qualcomm.com (10.47.209.197) To
 nasanex01b.na.qualcomm.com (10.46.141.250)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: M9gkwsjG1BWfH2hMMTcyay3ibS_RCVfb
X-Proofpoint-GUID: M9gkwsjG1BWfH2hMMTcyay3ibS_RCVfb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-24_01,2024-07-23_02,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 bulkscore=0
 spamscore=0 mlxscore=0 priorityscore=1501 impostorscore=0 suspectscore=0
 adultscore=0 clxscore=1015 mlxlogscore=757 lowpriorityscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407240017

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

Changes in v3:
- Updated the functions qcom_pcie_configure_dbi_atu_base() and
  qcom_pcie_configure_dbi_base() to make having 'dbi_phys_addr' mandatory
  before programming PARF_SLV_ADDR_SPACE_SIZE register as suggested by
  Mayank Rana.
- Link to v2: https://lore.kernel.org/linux-pci/20240718051258.1115271-1-quic_pyarlaga@quicinc.com/T/

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


