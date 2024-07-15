Return-Path: <linux-pci+bounces-10295-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id CA7C8931A15
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 20:15:06 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 7C5902833BF
	for <lists+linux-pci@lfdr.de>; Mon, 15 Jul 2024 18:15:05 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 0CC9053364;
	Mon, 15 Jul 2024 18:14:49 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Es+kdtml"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 6798D7172F;
	Mon, 15 Jul 2024 18:14:46 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.168.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1721067288; cv=none; b=XYE0BfDXI8tDZ9qN7kj7sHVIM9vJq3RykQ1eAxQWwltyRfM9kJNJ/54GCPXMA/P4NNk+p0vI9dofSG9LLcDusXy/UnpQtwdICWqaUh9dp458OsaLJPDsk56f+aQxvJ5tuzSkKQNwUEFKmEH4YMwWzWiv+8AV86sEWRSTO7EcHKc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1721067288; c=relaxed/simple;
	bh=xWstY61TUtn1p0uPhKxILQmPzuC49JKSvAwwEE5C+aM=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=SYK4UjNlTGpmkwXCpwq/hl9lG59376fOa4wRSCed/Jufrh2y+QVvRMaszkQ4R3R1IZgr4pO9WclT2xvUTmrFN4ndf93+Enf3NRnhqPWWSWxhPN73QvykqV5E8wHoTfmIiW727dgptLwORSLDcW4KwmtGjt/IDZlNw8/1bEmOte8=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Es+kdtml; arc=none smtp.client-ip=205.220.168.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279866.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46FH8tdc022654;
	Mon, 15 Jul 2024 18:13:53 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=WZjt28mLQ+pVdTQSgCI/Md
	hVfG1xpKu6rzR+SJgi02c=; b=Es+kdtml38MX6mo5T9ikoZOthNP1o5gJntaG4+
	wtdaPbln9BSp1f2wL75rG2iu+xROseWLocVcGUP48bPkaDqLoEGaN/LZfhxAU/TM
	uFUmEhyHoCnBKF9tT5FIJ0lme1J85AU2zPBGiJIuy83j1ah1E8Z6i3vBO8vH8h1O
	/o7B5NNT4a6JMj+dYP4cDofzHxOilROiBgxpSZJ24xXFHG9PWWw32gLTZRcfAdUf
	sNmOoLbNp39UWvMmvgCMWfRAMuaNd3DuITO24D3ASD3GjvIRuPKLOPyshKMTSKvx
	+JQs/Rit4il8LC7pf4ZmKvvpTSR3/hlXTfwPNSCNy3NZnZnQ==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40bjv8mwpg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:53 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46FIDqtJ027895
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 15 Jul 2024 18:13:52 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Mon, 15 Jul 2024 11:13:51 -0700
From: Mayank Rana <quic_mrana@quicinc.com>
To: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <manivannan.sadhasivam@linaro.org>, <cassel@kernel.org>,
        <yoshihiro.shimoda.uh@renesas.com>, <s-vadapalli@ti.com>,
        <u.kleine-koenig@pengutronix.de>, <dlemoal@kernel.org>,
        <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>
CC: <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>, Mayank Rana <quic_mrana@quicinc.com>
Subject: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe host generic ECAM driver
Date: Mon, 15 Jul 2024 11:13:28 -0700
Message-ID: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.7.4
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nalasex01c.na.qualcomm.com (10.47.97.35) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: vNad0KtoDvCl2c3rmgSj_NjVgYbfkL11
X-Proofpoint-GUID: vNad0KtoDvCl2c3rmgSj_NjVgYbfkL11
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-15_12,2024-07-11_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 impostorscore=0
 suspectscore=0 spamscore=0 malwarescore=0 clxscore=1011 priorityscore=1501
 phishscore=0 lowpriorityscore=0 mlxscore=0 adultscore=0 bulkscore=0
 mlxlogscore=756 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2406140001 definitions=main-2407150141

Based on previously received feedback, this patch series adds functionalities
with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
host root complex functionality on Qualcomm SA8775P auto platform.

Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/                                                                                                      

1. Interface to allow requesting firmware to manage system resources and performing
PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
framework based power domain controls these operations)
3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
This MSI functionality is used with PCIe host generic driver after splitting existing MSI
functionality from pcie-designware-host.c file into pcie-designware-msi.c file.

Below architecture is used on Qualcomm SA8775P auto platform to get ECAM compliant PCIe
controller based functionality. Here firmware VM based PCIe driver takes care of resource
management and performing PCIe link related handling (D0 and D3cold). Linux VM based PCIe
host generic driver uses power domain to request firmware VM to perform these operations
using SCMI interface.
----------------


                                   ┌────────────────────────┐                                               
                                   │                        │                                               
  ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐       
  │     Firmware VM      │         │                        │            │         Linux VM         │       
  │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │       
  │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE host    │    │       
  │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │  generic driver│    │       
  │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │       
  │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │       
  │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │       
  │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │       
  │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │       
  │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │       
  │               │  │   │         │                        │            │       │          │       │       
  └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘       
                  │  │             │                        │                    │          │               
                  │  │             └────────────────────────┘                    │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
                  │  │                                                           │IRQ       │HVC            
              IRQ │  │HVC                                                        │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
                  │  │                                                           │          │               
┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
│                                                                                                          │
│                                                                                                          │
│                                      HYPERVISOR                                                          │
│                                                                                                          │
│                                                                                                          │
│                                                                                                          │
└──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
                                                                                                            
  ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐        
  │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │        
  │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │        
  └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘        
                                                                                                            
----------
Changes in V2:
- Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
- Add power domain based functionality within existing ECAM driver

Tested:
- Validated NVME functionality with PCIe0 and PCIe1 on SA8775P-RIDE platform

Mayank Rana (7):
  PCI: dwc: Move MSI related code to separate file
  PCI: dwc: Add msi_ops to allow DBI based MSI register access
  PCI: dwc: Add pcie-designware-msi driver kconfig option
  dt-bindings: PCI: host-generic-pci: Add power-domains binding
  PCI: host-generic: Add power domain based handling for PCIe controller
  dt-bindings: PCI: host-generic-pci: Add snps,dw-pcie-ecam-msi binding
  PCI: host-generic: Add dwc MSI based MSI functionality

 .../devicetree/bindings/pci/host-generic-pci.yaml  |  64 +++
 drivers/pci/controller/dwc/Kconfig                 |   8 +
 drivers/pci/controller/dwc/Makefile                |   1 +
 drivers/pci/controller/dwc/pci-keystone.c          |  12 +-
 drivers/pci/controller/dwc/pcie-designware-host.c  | 438 ++-------------------
 drivers/pci/controller/dwc/pcie-designware-msi.c   | 413 +++++++++++++++++++
 drivers/pci/controller/dwc/pcie-designware-msi.h   |  63 +++
 drivers/pci/controller/dwc/pcie-designware.c       |   1 +
 drivers/pci/controller/dwc/pcie-designware.h       |  26 +-
 drivers/pci/controller/dwc/pcie-rcar-gen4.c        |   1 +
 drivers/pci/controller/dwc/pcie-tegra194.c         |   5 +-
 drivers/pci/controller/pci-host-generic.c          | 127 +++++-
 12 files changed, 723 insertions(+), 436 deletions(-)
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.c
 create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.h

-- 
2.7.4


