Return-Path: <linux-pci+bounces-16172-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id 8CDF79BF8FD
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 23:14:38 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 156EA1F22F4B
	for <lists+linux-pci@lfdr.de>; Wed,  6 Nov 2024 22:14:38 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id D1D5F20D51B;
	Wed,  6 Nov 2024 22:14:17 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="EM6MJLgQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 083C020CCF0;
	Wed,  6 Nov 2024 22:14:15 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1730931257; cv=none; b=nOfQYo/dge64OHOjmCsrStMyHgBdneKeHLZAwEzUhzA6LSclKU6/M+OvKy3/LDXylIYvlZI7trh8ZN66n488yxB5cufsbW30slyY/dH/Z6hM46XV/lkIR/Qi7BH+1T8+oohLZ8pTGcnCCxUADuRjuY74Y7npBfw8tpSwJA8RtrM=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1730931257; c=relaxed/simple;
	bh=Q8sdEiwIQFJ96xbjzW4dGd5bOFy43v3wdUM4rFvHBV0=;
	h=From:To:CC:Subject:Date:Message-ID:MIME-Version:Content-Type; b=M3Oa7GLz/5wH+ct1Fg5y0rxinJzL1N304oJLmpXK3ZgbAzuyaFRQEG0mGYox53ddYEAbmp+S/zpUI03J5uxCieXhq4kUaGmnyZ7D/LuDwyo9DhAGUTvpS580l7IkNPby/G6JnsSVuHMApzMsPFQSr8BzdLAcFmYkGwIP0BYtgQI=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=EM6MJLgQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279869.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 4A6G2n4U013131;
	Wed, 6 Nov 2024 22:14:06 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:message-id
	:mime-version:subject:to; s=qcppdkim1; bh=K/q05KvANTLv6B0OIfx86v
	L0U0HidK4LIkWqXXcXgdo=; b=EM6MJLgQSeAye6PsZJXf4bQjEJlaNpSQbpPWOZ
	GHflXzL6aDJD37ED9ng8b5tZsXC/U+X1yx3SP7I5R3kD+pUAShdKdj5Gatm7FmNT
	U5qskvQaJKM8n9LZPPt9Wztpp3gVmbvSKum1jkLikNbZexxpfHna8VpO4iM3wkdI
	SM8znFPxbvyYw7pP9U89hj5VsKVJgogJn4qP8NU5bydcoM26KwGOVtcYKrggGt74
	Z5bqMsCfu7MJs7YV6UPxn+9EXKWb+PJ3YDnGAq1M+9QUcy6YeiYFRBDGFG3uXiyT
	xcOPxdlAo5BWcczEWQOh8cDNGhcTaa41W2jlBZoyfZewmeQA==
Received: from nalasppmta02.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 42qp2rvcgg-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Nov 2024 22:14:06 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA02.qualcomm.com (8.18.1.2/8.18.1.2) with ESMTPS id 4A6ME4Qu016602
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Nov 2024 22:14:04 GMT
Received: from hu-mrana-lv.qualcomm.com (10.49.16.6) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1544.9; Wed, 6 Nov 2024 14:14:04 -0800
From: Mayank Rana <quic_mrana@quicinc.com>
To: <jingoohan1@gmail.com>, <manivannan.sadhasivam@linaro.org>,
        <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <krzk@kernel.org>
CC: <linux-pci@vger.kernel.org>, <linux-arm-msm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <quic_krichai@quicinc.com>,
        Mayank Rana
	<quic_mrana@quicinc.com>
Subject: [PATCH v3 0/4] Add Qualcomm SA8255p based firmware managed PCIe root complex
Date: Wed, 6 Nov 2024 14:13:37 -0800
Message-ID: <20241106221341.2218416-1-quic_mrana@quicinc.com>
X-Mailer: git-send-email 2.25.1
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
X-Proofpoint-GUID: jpU7jXl3ep5c7dD8z-Stoo0H7j8ApqKj
X-Proofpoint-ORIG-GUID: jpU7jXl3ep5c7dD8z-Stoo0H7j8ApqKj
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.60.29
 definitions=2024-09-06_09,2024-09-06_01,2024-09-02_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 malwarescore=0 clxscore=1015
 bulkscore=0 priorityscore=1501 impostorscore=0 lowpriorityscore=0
 mlxlogscore=746 suspectscore=0 spamscore=0 mlxscore=0 phishscore=0
 adultscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2409260000 definitions=main-2411060170

Based on received feedback, this patch series adds support with existing
Linux qcom-pcie.c driver to get PCIe host root complex functionality on
Qualcomm SA8255P auto platform.

1. Interface to allow requesting firmware to manage system resources and
performing PCIe Link up (devicetree binding in terms of power domain and
runtime PM APIs is used in driver)

2. SA8255P is using Synopsys Designware PCIe controller which supports MSI
controller. Using existing MSI controller based functionality by exporting
important pcie dwc core driver based MSI APIs, and using those from
pcie-qcom.c driver.

Below architecture is used on Qualcomm SA8255P auto platform to get ECAM
compliant PCIe controller based functionality. Here firmware VM based PCIe
driver takes care of resource management and performing PCIe link related
handling (D0 and D3cold). Linux pcie-qcom.c driver uses power domain to
request firmware VM to perform these operations using SCMI interface.
--------------------


                                   ┌────────────────────────┐                                               
                                   │                        │                                               
  ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐       
  │     Firmware VM      │         │                        │            │         Linux VM         │       
  │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │       
  │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE Qcom    │    │       
  │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │    driver      │    │       
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
Changes in V3:
- Drop usage of PCIE host generic driver usage, and splitting of MSI functionality
- Modified existing pcie-qcom.c driver to add support for getting ECAM compliant and firmware managed
PCIe root complex functionality
Link to v2: https://lore.kernel.org/linux-arm-kernel/925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com/T/

Changes in V2:
- Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
- Add power domain based functionality within existing ECAM driver
Link to v1: https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/                                                                                                      

Tested:
- Validated NVME functionality with PCIe0 on SA8255P-RIDE platform

Mayank Rana (3):
  PCI: dwc: Export dwc MSI controller related APIs
  PCI: qcom: Add firmware managed ECAM compliant PCIe root complex
    functionality
  dt-bindings: PCI: qcom,pcie-sa8255p: Document ECAM compliant PCIe root
    complex

 .../devicetree/bindings/pci/qcom,pcie-sa8255p.yaml | 100 +++++++++++++++++++++
 drivers/pci/controller/dwc/Kconfig                 |   1 +
 drivers/pci/controller/dwc/pcie-designware-host.c  |  38 ++++----
 drivers/pci/controller/dwc/pcie-designware.h       |  14 +++
 drivers/pci/controller/dwc/pcie-qcom.c             |  69 ++++++++++++--
 5 files changed, 199 insertions(+), 23 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/pci/qcom,pcie-sa8255p.yaml

-- 
2.7.4


