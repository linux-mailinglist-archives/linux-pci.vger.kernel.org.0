Return-Path: <linux-pci+bounces-10981-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 997B193FC5F
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 19:22:16 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id 4FAF4280D73
	for <lists+linux-pci@lfdr.de>; Mon, 29 Jul 2024 17:22:15 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id CCA7315ECD0;
	Mon, 29 Jul 2024 17:21:26 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="Ns+vfzAQ"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id F36565028C;
	Mon, 29 Jul 2024 17:21:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722273686; cv=none; b=MCo64GAzmR9/JdiBbbPKLHIDuRGG7j7Y7OZMY2KS/zMXjHOB9VBQMRpyAOqki2SIPyjXDxPq0cQ3QWQNslmInZVifihp3DHuCjgFlabqZ94fuq1+a0XGxYFgWg3CyN0DOnJGjW085fnTemTmjXsWLQfc0RKDsPQq8fOpxKMGUQo=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722273686; c=relaxed/simple;
	bh=4fQr//Ka7sTy/VMt7ggKFrz3+ahovq34k1sJWhkzznQ=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=r6BvVQa2tE0llxqL6VD5o9JsTRuBEsd7EulqbdD8RuMm+Golbi7MMdzQfQcUwHnWTVIZqzzVsJUfQX1hzuUIKoechG5c3Lq+YRTxhxQxPmA7NYXU5O7NGt/NNBxAOqz2bK2wdWmvBF2EQ8knx1isu3jyn0v12SpIIc9NjeaZ1Rs=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=Ns+vfzAQ; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279871.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46TAG9PJ030809;
	Mon, 29 Jul 2024 17:19:48 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	9cUy14n2UN04pp4Q33jv4wdH2wJt0tYU3Imvp2lZlLM=; b=Ns+vfzAQCwgtKVra
	8A/9VBAiSvWr5yKACWl3Rmv3WHBLyn7ZW9CHE3dxZf5d1oTl2vT2oSu/GnIlAL7H
	8sH5uRX6BE2vO9/f/6q8ygKf1sGCgGHtAN09N6WVCCFRgB0gWulr9M6W4+IDZ/Nm
	NI416IfE7tRItLXkkmUqldb1cZIbg0Oerej+eVHT6vrrBSdiWnnYyG/4/SmlrE+6
	TDYs1P7wwh9pTEOF/+C3+jlQq0NAY7054P/Pp8YnRndivu5ldJd6b3iuseGJ6RhU
	BYYSOFgPWyOliQGnB+uM3rwzCtoGV6zcGdIay0SZqJ0m912WPsapab2K5zx95llD
	1WJzYw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40mrfxn15u-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 17:19:47 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46THJkIj017051
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Mon, 29 Jul 2024 17:19:46 GMT
Received: from [10.110.106.247] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Mon, 29 Jul
 2024 10:19:45 -0700
Message-ID: <925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com>
Date: Mon, 29 Jul 2024 10:19:45 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
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
        <quic_nitegupt@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: j3DfV2Yq7u24d5QjiHxI1vJcR5BX8XOb
X-Proofpoint-ORIG-GUID: j3DfV2Yq7u24d5QjiHxI1vJcR5BX8XOb
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-29_15,2024-07-26_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 suspectscore=0 adultscore=0
 lowpriorityscore=0 priorityscore=1501 mlxlogscore=965 malwarescore=0
 bulkscore=0 phishscore=0 clxscore=1015 mlxscore=0 spamscore=0
 impostorscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407290116

Hi Bjorn / Mani

Gentle ping for your review/feedback on this series.
Thank you.

Regards,
Mayank

On 7/15/2024 11:13 AM, Mayank Rana wrote:
> Based on previously received feedback, this patch series adds functionalities
> with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
> host root complex functionality on Qualcomm SA8775P auto platform.
> 
> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
> 
> 1. Interface to allow requesting firmware to manage system resources and performing
> PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
> 2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
> framework based power domain controls these operations)
> 3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
> This MSI functionality is used with PCIe host generic driver after splitting existing MSI
> functionality from pcie-designware-host.c file into pcie-designware-msi.c file.
> 
> Below architecture is used on Qualcomm SA8775P auto platform to get ECAM compliant PCIe
> controller based functionality. Here firmware VM based PCIe driver takes care of resource
> management and performing PCIe link related handling (D0 and D3cold). Linux VM based PCIe
> host generic driver uses power domain to request firmware VM to perform these operations
> using SCMI interface.
> ----------------
> 
> 
>                                     ┌────────────────────────┐
>                                     │                        │
>    ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐
>    │     Firmware VM      │         │                        │            │         Linux VM         │
>    │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │
>    │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE host    │    │
>    │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │  generic driver│    │
>    │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │
>    │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │
>    │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │
>    │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │
>    │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │
>    │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │
>    │               │  │   │         │                        │            │       │          │       │
>    └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘
>                    │  │             │                        │                    │          │
>                    │  │             └────────────────────────┘                    │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
>                    │  │                                                           │IRQ       │HVC
>                IRQ │  │HVC                                                        │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
>                    │  │                                                           │          │
> ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
> │                                                                                                          │
> │                                                                                                          │
> │                                      HYPERVISOR                                                          │
> │                                                                                                          │
> │                                                                                                          │
> │                                                                                                          │
> └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
>                                                                                                              
>    ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐
>    │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │
>    │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │
>    └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘
>                                                                                                              
> ----------
> Changes in V2:
> - Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
> - Add power domain based functionality within existing ECAM driver
> 
> Tested:
> - Validated NVME functionality with PCIe0 and PCIe1 on SA8775P-RIDE platform
> 
> Mayank Rana (7):
>    PCI: dwc: Move MSI related code to separate file
>    PCI: dwc: Add msi_ops to allow DBI based MSI register access
>    PCI: dwc: Add pcie-designware-msi driver kconfig option
>    dt-bindings: PCI: host-generic-pci: Add power-domains binding
>    PCI: host-generic: Add power domain based handling for PCIe controller
>    dt-bindings: PCI: host-generic-pci: Add snps,dw-pcie-ecam-msi binding
>    PCI: host-generic: Add dwc MSI based MSI functionality
> 
>   .../devicetree/bindings/pci/host-generic-pci.yaml  |  64 +++
>   drivers/pci/controller/dwc/Kconfig                 |   8 +
>   drivers/pci/controller/dwc/Makefile                |   1 +
>   drivers/pci/controller/dwc/pci-keystone.c          |  12 +-
>   drivers/pci/controller/dwc/pcie-designware-host.c  | 438 ++-------------------
>   drivers/pci/controller/dwc/pcie-designware-msi.c   | 413 +++++++++++++++++++
>   drivers/pci/controller/dwc/pcie-designware-msi.h   |  63 +++
>   drivers/pci/controller/dwc/pcie-designware.c       |   1 +
>   drivers/pci/controller/dwc/pcie-designware.h       |  26 +-
>   drivers/pci/controller/dwc/pcie-rcar-gen4.c        |   1 +
>   drivers/pci/controller/dwc/pcie-tegra194.c         |   5 +-
>   drivers/pci/controller/pci-host-generic.c          | 127 +++++-
>   12 files changed, 723 insertions(+), 436 deletions(-)
>   create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.c
>   create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.h
> 

