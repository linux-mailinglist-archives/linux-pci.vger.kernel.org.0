Return-Path: <linux-pci+bounces-11026-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from ny.mirrors.kernel.org (ny.mirrors.kernel.org [IPv6:2604:1380:45d1:ec00::1])
	by mail.lfdr.de (Postfix) with ESMTPS id AAA9694181C
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 18:19:33 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by ny.mirrors.kernel.org (Postfix) with ESMTPS id CEEC41C23086
	for <lists+linux-pci@lfdr.de>; Tue, 30 Jul 2024 16:19:32 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 3E484189503;
	Tue, 30 Jul 2024 16:17:23 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="k5xYUVSM"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0b-0031df01.pphosted.com (mx0b-0031df01.pphosted.com [205.220.180.131])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 395391A616E;
	Tue, 30 Jul 2024 16:17:20 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=205.220.180.131
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1722356243; cv=none; b=su73IAySVVUea4aRpKOyM0CE1Sh4iHVcgbJW9PyDUWSfQf6dCtv8bnxhn6QI0hgJDOA5f7QlYB66QsmLLJh+hGld8jmLYNQhY7Fgt+dO9m7Tj4aqRMBK/48zv7IIyWqhYHn68QsKhYbeazrY6P/9Ad5fNkx254Xm+bLw/qO3pdc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1722356243; c=relaxed/simple;
	bh=7JXPI2iBnUG0WTE2Z+Gj5u4QLeEEINdG6mSmYcBHRP4=;
	h=Message-ID:Date:MIME-Version:Subject:To:CC:References:From:
	 In-Reply-To:Content-Type; b=YlLPe2RbYIpNfJ9wmz1tc1qx+z58YptJHL2iNtWbA0kyTWxz7NAwx9uDPY/IQbttrHmz1slZX7RbiWcLVI9sCAHzr9Lcjk99qV+TuZwQsefr3J23wo40ZHkIdxA07vG9euGRp3bsSqDga/63lkhttpnSQp5ueBOdkZVCRGO5NZc=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com; spf=pass smtp.mailfrom=quicinc.com; dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b=k5xYUVSM; arc=none smtp.client-ip=205.220.180.131
Authentication-Results: smtp.subspace.kernel.org; dmarc=pass (p=none dis=none) header.from=quicinc.com
Authentication-Results: smtp.subspace.kernel.org; spf=pass smtp.mailfrom=quicinc.com
Received: from pps.filterd (m0279868.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.18.1.2/8.18.1.2) with ESMTP id 46UFpu4P031714;
	Tue, 30 Jul 2024 16:16:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=
	cc:content-transfer-encoding:content-type:date:from:in-reply-to
	:message-id:mime-version:references:subject:to; s=qcppdkim1; bh=
	QtyNm11XvCD8/W1yH2YGAcKFdYxc9/J+Z+0y6mVs8ow=; b=k5xYUVSMZ7DuCB8q
	DhzGz5jPFXf3E6U9/OpKwxFa58VvQ/q5tcXZAK8HIbD1lmgitNF6SWEaGxpiBnw9
	F9S3NzSpr6dfqN88gVJ73Tb/xAr5flep7wEvDY7T/HIaZoQwWU1CgnHy6jePoc/E
	wurTY8p6nYO8Gt9tzARYeXec7OVIL6FTabNZCWe4pL7pYKMEeVSoa3dsT/LJVp/1
	x1hIvlA+lNuwFELxhI69+jOYn4iw08KUIPYr1crGfR7afyvRrnbTfifxrArsD1pO
	iuur7bmasXRVjZ1br1+ySq8JsrBNjnug7aGslmMYIGlO8LeqFJh+0zshwAEXl9Bd
	7efgEw==
Received: from nalasppmta05.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 40pw441dut-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 16:16:07 +0000 (GMT)
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA05.qualcomm.com (8.17.1.19/8.17.1.19) with ESMTPS id 46UGG6fm019079
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Tue, 30 Jul 2024 16:16:06 GMT
Received: from [10.110.56.150] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1544.9; Tue, 30 Jul
 2024 09:16:05 -0700
Message-ID: <22f4ecb4-f955-4401-befc-cb27b4fa4c59@quicinc.com>
Date: Tue, 30 Jul 2024 09:16:05 -0700
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH V2 0/7] Add power domain and MSI functionality with PCIe
 host generic ECAM driver
To: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
CC: <will@kernel.org>, <lpieralisi@kernel.org>, <kw@linux.com>,
        <robh@kernel.org>, <bhelgaas@google.com>, <jingoohan1@gmail.com>,
        <cassel@kernel.org>, <yoshihiro.shimoda.uh@renesas.com>,
        <s-vadapalli@ti.com>, <u.kleine-koenig@pengutronix.de>,
        <dlemoal@kernel.org>, <amishin@t-argos.ru>, <thierry.reding@gmail.com>,
        <jonathanh@nvidia.com>, <Frank.Li@nxp.com>,
        <ilpo.jarvinen@linux.intel.com>, <vidyas@nvidia.com>,
        <marek.vasut+renesas@gmail.com>, <krzk+dt@kernel.org>,
        <conor+dt@kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <devicetree@vger.kernel.org>,
        <quic_ramkri@quicinc.com>, <quic_nkela@quicinc.com>,
        <quic_shazhuss@quicinc.com>, <quic_msarkar@quicinc.com>,
        <quic_nitegupt@quicinc.com>
References: <1721067215-5832-1-git-send-email-quic_mrana@quicinc.com>
 <925d1eca-975f-4eec-bdf8-ca07a892361a@quicinc.com>
 <20240730053425.GB3122@thinkpad>
Content-Language: en-US
From: Mayank Rana <quic_mrana@quicinc.com>
In-Reply-To: <20240730053425.GB3122@thinkpad>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-GUID: I3RupqWLXtt-eDIMMr8AGmx975EvbPE_
X-Proofpoint-ORIG-GUID: I3RupqWLXtt-eDIMMr8AGmx975EvbPE_
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.293,Aquarius:18.0.1039,Hydra:6.0.680,FMLib:17.12.28.16
 definitions=2024-07-30_13,2024-07-30_01,2024-05-17_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 mlxscore=0
 priorityscore=1501 adultscore=0 mlxlogscore=962 clxscore=1015
 impostorscore=0 spamscore=0 lowpriorityscore=0 bulkscore=0 suspectscore=0
 malwarescore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.19.0-2407110000 definitions=main-2407300111



On 7/29/2024 10:34 PM, Manivannan Sadhasivam wrote:
> On Mon, Jul 29, 2024 at 10:19:45AM -0700, Mayank Rana wrote:
>> Hi Bjorn / Mani
>>
>> Gentle ping for your review/feedback on this series.
>> Thank you.
>>
> 
> I was waiting for your reply for my comment [1]. Because that will have
> influence on this series.
> 
> - Mani
> 
> [1] https://lore.kernel.org/linux-pci/20240724095407.GA2347@thinkpad/
ok. Thanks for above response, and suggesting that you are ok with 
either new ECAM driver or updating PCIE qcom driver with ECAM mode as 
well utilizing DWC specific functionality. I still believe having 
separate PCIe QCOM ecam driver would be more useful and allow decoupling 
dwc host specific code base.

I am requesting above if you can review current MSI split functionality, 
and provide feedback on that.

Regards,
Mayank
> 
>> Regards,
>> Mayank
>>
>> On 7/15/2024 11:13 AM, Mayank Rana wrote:
>>> Based on previously received feedback, this patch series adds functionalities
>>> with existing PCIe host generic ECAM driver (pci-host-generic.c) to get PCIe
>>> host root complex functionality on Qualcomm SA8775P auto platform.
>>>
>>> Previously sent RFC patchset to have separate Qualcomm PCIe ECAM platform driver:
>>> https://lore.kernel.org/all/d10199df-5fb3-407b-b404-a0a4d067341f@quicinc.com/T/
>>>
>>> 1. Interface to allow requesting firmware to manage system resources and performing
>>> PCIe Link up (devicetree binding in terms of power domain and runtime PM APIs is used in driver)
>>> 2. Performing D3 cold with system suspend and D0 with system resume (usage of GenPD
>>> framework based power domain controls these operations)
>>> 3. SA8775P is using Synopsys Designware PCIe controller which supports MSI controller.
>>> This MSI functionality is used with PCIe host generic driver after splitting existing MSI
>>> functionality from pcie-designware-host.c file into pcie-designware-msi.c file.
>>>
>>> Below architecture is used on Qualcomm SA8775P auto platform to get ECAM compliant PCIe
>>> controller based functionality. Here firmware VM based PCIe driver takes care of resource
>>> management and performing PCIe link related handling (D0 and D3cold). Linux VM based PCIe
>>> host generic driver uses power domain to request firmware VM to perform these operations
>>> using SCMI interface.
>>> ----------------
>>>
>>>
>>>                                      ┌────────────────────────┐
>>>                                      │                        │
>>>     ┌──────────────────────┐         │     SHARED MEMORY      │            ┌──────────────────────────┐
>>>     │     Firmware VM      │         │                        │            │         Linux VM         │
>>>     │ ┌─────────┐          │         │                        │            │    ┌────────────────┐    │
>>>     │ │ Drivers │ ┌──────┐ │         │                        │            │    │   PCIE host    │    │
>>>     │ │ PCIE PHY◄─┤      │ │         │   ┌────────────────┐   │            │    │  generic driver│    │
>>>     │ │         │ │ SCMI │ │         │   │                │   │            │    │                │    │
>>>     │ │PCIE CTL │ │      │ ├─────────┼───►    PCIE        ◄───┼─────┐      │    └──┬──────────▲──┘    │
>>>     │ │         ├─►Server│ │         │   │    SHMEM       │   │     │      │       │          │       │
>>>     │ │Clk, Vreg│ │      │ │         │   │                │   │     │      │    ┌──▼──────────┴──┐    │
>>>     │ │GPIO,GDSC│ └─▲──┬─┘ │         │   └────────────────┘   │     └──────┼────┤PCIE SCMI Inst  │    │
>>>     │ └─────────┘   │  │   │         │                        │            │    └──▲──────────┬──┘    │
>>>     │               │  │   │         │                        │            │       │          │       │
>>>     └───────────────┼──┼───┘         │                        │            └───────┼──────────┼───────┘
>>>                     │  │             │                        │                    │          │
>>>                     │  │             └────────────────────────┘                    │          │
>>>                     │  │                                                           │          │
>>>                     │  │                                                           │          │
>>>                     │  │                                                           │          │
>>>                     │  │                                                           │IRQ       │HVC
>>>                 IRQ │  │HVC                                                        │          │
>>>                     │  │                                                           │          │
>>>                     │  │                                                           │          │
>>>                     │  │                                                           │          │
>>> ┌─────────────────┴──▼───────────────────────────────────────────────────────────┴──────────▼──────────────┐
>>> │                                                                                                          │
>>> │                                                                                                          │
>>> │                                      HYPERVISOR                                                          │
>>> │                                                                                                          │
>>> │                                                                                                          │
>>> │                                                                                                          │
>>> └──────────────────────────────────────────────────────────────────────────────────────────────────────────┘
>>>     ┌─────────────┐    ┌─────────────┐  ┌──────────┐   ┌───────────┐   ┌─────────────┐  ┌────────────┐
>>>     │             │    │             │  │          │   │           │   │  PCIE       │  │   PCIE     │
>>>     │   CLOCK     │    │   REGULATOR │  │   GPIO   │   │   GDSC    │   │  PHY        │  │ controller │
>>>     └─────────────┘    └─────────────┘  └──────────┘   └───────────┘   └─────────────┘  └────────────┘
>>> ----------
>>> Changes in V2:
>>> - Drop new PCIe Qcom ECAM driver, and use existing PCIe designware based MSI functionality
>>> - Add power domain based functionality within existing ECAM driver
>>>
>>> Tested:
>>> - Validated NVME functionality with PCIe0 and PCIe1 on SA8775P-RIDE platform
>>>
>>> Mayank Rana (7):
>>>     PCI: dwc: Move MSI related code to separate file
>>>     PCI: dwc: Add msi_ops to allow DBI based MSI register access
>>>     PCI: dwc: Add pcie-designware-msi driver kconfig option
>>>     dt-bindings: PCI: host-generic-pci: Add power-domains binding
>>>     PCI: host-generic: Add power domain based handling for PCIe controller
>>>     dt-bindings: PCI: host-generic-pci: Add snps,dw-pcie-ecam-msi binding
>>>     PCI: host-generic: Add dwc MSI based MSI functionality
>>>
>>>    .../devicetree/bindings/pci/host-generic-pci.yaml  |  64 +++
>>>    drivers/pci/controller/dwc/Kconfig                 |   8 +
>>>    drivers/pci/controller/dwc/Makefile                |   1 +
>>>    drivers/pci/controller/dwc/pci-keystone.c          |  12 +-
>>>    drivers/pci/controller/dwc/pcie-designware-host.c  | 438 ++-------------------
>>>    drivers/pci/controller/dwc/pcie-designware-msi.c   | 413 +++++++++++++++++++
>>>    drivers/pci/controller/dwc/pcie-designware-msi.h   |  63 +++
>>>    drivers/pci/controller/dwc/pcie-designware.c       |   1 +
>>>    drivers/pci/controller/dwc/pcie-designware.h       |  26 +-
>>>    drivers/pci/controller/dwc/pcie-rcar-gen4.c        |   1 +
>>>    drivers/pci/controller/dwc/pcie-tegra194.c         |   5 +-
>>>    drivers/pci/controller/pci-host-generic.c          | 127 +++++-
>>>    12 files changed, 723 insertions(+), 436 deletions(-)
>>>    create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.c
>>>    create mode 100644 drivers/pci/controller/dwc/pcie-designware-msi.h
>>>
> 

