Return-Path: <linux-pci+bounces-573-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sy.mirrors.kernel.org (sy.mirrors.kernel.org [147.75.48.161])
	by mail.lfdr.de (Postfix) with ESMTPS id 4B8458072E7
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 15:46:03 +0100 (CET)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sy.mirrors.kernel.org (Postfix) with ESMTPS id CF02BB20A13
	for <lists+linux-pci@lfdr.de>; Wed,  6 Dec 2023 14:46:00 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 37B7D31A6E;
	Wed,  6 Dec 2023 14:45:59 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=quicinc.com header.i=@quicinc.com header.b="hhG8CZtO"
X-Original-To: linux-pci@vger.kernel.org
Received: from mx0a-0031df01.pphosted.com (mx0a-0031df01.pphosted.com [205.220.168.131])
	by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 261C219AE;
	Wed,  6 Dec 2023 06:45:32 -0800 (PST)
Received: from pps.filterd (m0279862.ppops.net [127.0.0.1])
	by mx0a-0031df01.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3B6CNYur000496;
	Wed, 6 Dec 2023 14:45:08 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=quicinc.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=qcppdkim1;
 bh=O8G/wda6BFaQVkzBoWMdtyiVqTBihnOqQRD4FjYIZlM=;
 b=hhG8CZtOB8WY/Dxi4ljzjRehEvwisB0TePasr5DUtm71M7EtD0Tqu7BW73iPRdOuDN7B
 Mggsodg7CRc0GXBw2BY9O+qZmwFwlab2qJvcKm5D82iblO/jWnuxTwcZ99RcfEVfdTYM
 K/ZmsioYaEKitAcVd1HuQZtJr9+9LF3QbrsehEyHQ5nilD58278/ouKQ0ESFhlyEfM1/
 Q7dh9RzwJuRFVStuBFT10fO1XdpjXZtH40UKV9+eujfXUzr1CksNN35eOTDAKz8C69yt
 SyKipdRTKY1OEk4SuAM6YVziPaT3fuRmrz7utVOfGlyUOVCzGLakH2aUQY9FpL+Ifq2f Sg== 
Received: from nalasppmta03.qualcomm.com (Global_NAT1.qualcomm.com [129.46.96.20])
	by mx0a-0031df01.pphosted.com (PPS) with ESMTPS id 3utrwq0c9c-1
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 06 Dec 2023 14:45:08 +0000
Received: from nalasex01a.na.qualcomm.com (nalasex01a.na.qualcomm.com [10.47.209.196])
	by NALASPPMTA03.qualcomm.com (8.17.1.5/8.17.1.5) with ESMTPS id 3B6Ej7jH008378
	(version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
	Wed, 6 Dec 2023 14:45:07 GMT
Received: from [10.216.30.166] (10.80.80.8) by nalasex01a.na.qualcomm.com
 (10.47.209.196) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.40; Wed, 6 Dec
 2023 06:44:59 -0800
Message-ID: <feee5e5b-565e-8575-2bbe-61b35fa8f1dd@quicinc.com>
Date: Wed, 6 Dec 2023 20:14:56 +0530
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.1
Subject: Re: [RFC,v14 0/5] Add DT based PCIe wake support in PCI core driver
Content-Language: en-US
To: Manikanta Maddireddy <mmaddireddy@nvidia.com>, <bhelgaas@google.com>,
        <thierry.reding@gmail.com>, <petlozup@nvidia.com>,
        <rafael.j.wysocki@intel.com>, <lpieralisi@kernel.org>,
        <robh@kernel.org>, <jeffy.chen@rock-chips.com>
CC: <krzysztof.kozlowski+dt@linaro.org>, <jonathanh@nvidia.com>,
        <dmitry.osipenko@collabora.com>, <viresh.kumar@linaro.org>,
        <gregkh@linuxfoundation.org>, <steven.price@arm.com>, <kw@linux.com>,
        <linux-pci@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <linux-tegra@vger.kernel.org>,
        <linux-pm@vger.kernel.org>, <vidyas@nvidia.com>
References: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
From: Krishna Chaitanya Chundru <quic_krichai@quicinc.com>
In-Reply-To: <20230208111645.3863534-1-mmaddireddy@nvidia.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-QCInternal: smtphost
X-Proofpoint-Virus-Version: vendor=nai engine=6200 definitions=5800 signatures=585085
X-Proofpoint-ORIG-GUID: OHSJrnn0ox_p4kpjO5kiG8M_WkqfhsSJ
X-Proofpoint-GUID: OHSJrnn0ox_p4kpjO5kiG8M_WkqfhsSJ
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.272,Aquarius:18.0.997,Hydra:6.0.619,FMLib:17.11.176.26
 definitions=2023-12-06_12,2023-12-06_01,2023-05-22_02
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 spamscore=0 impostorscore=0
 adultscore=0 lowpriorityscore=0 bulkscore=0 mlxlogscore=870 malwarescore=0
 suspectscore=0 mlxscore=0 priorityscore=1501 clxscore=1011 phishscore=0
 classifier=spam adjust=0 reason=mlx scancount=1 engine=8.12.0-2311290000
 definitions=main-2312060118

Hi Manikanta,

I don't see any update on this series after comments.

Is there  any plans to take up this series.

Thanks & Regards,

Krishna Chaitanya.

On 2/8/2023 4:46 PM, Manikanta Maddireddy wrote:
> Below series [1] attempted to support DT based PCIe wake feature in generic
> PCI core driver. This series was left at v13 and final comments are not
> addressed. I am continuing this series from v14 by addressing all comments
> in v13. I dropped rockchip device tree patch because I don't have hardware
> to verify it. Instead, I verified these patches on NVIDIA Jetson AGX Orin
> Developer Kit and included its device tree changes in this series.
>
> [1] https://lore.kernel.org/all/20171226023646.17722-1-jeffy.chen@rock-chips.com/
>
> Changes in v14:
> Updated commit message for DT bindings patch to reflect that DT properties
> are tied to PCI-PCI Bridge.
> Addressed review comments on PCI interrupt parsing patch.
> Dropped rockchip device tree patch.
> Added Jetson AGX OrinDeveloper Kit device tree and Tegra PMC patches.
>
> Changes in v13:
> Fix compiler error reported by kbuild test robot <fengguang.wu@intel.com>
>
> Changes in v12:
> Only add irq definitions for PCI devices and rewrite the commit message.
> Enable the wake irq in noirq stage to avoid possible irq storm.
>
> Changes in v11:
> Address Brian's comments.
> Only support 1-per-device PCIe WAKE# pin as suggested.
> Move to pcie port as Brian suggested.
>
> Changes in v10:
> Use device_set_wakeup_capable() instead of device_set_wakeup_enable(),
> since dedicated wakeirq will be lost in device_set_wakeup_enable(false).
>
> Changes in v9:
> Add section for PCI devices and rewrite the commit message.
> Fix check error in .cleanup().
> Move dedicated wakeirq setup to setup() callback and use
> device_set_wakeup_enable() to enable/disable.
> Rewrite the commit message.
>
> Changes in v8:
> Add optional "pci", and rewrite commit message.
> Add pci-of.c and use platform_pm_ops to handle the PCIe WAKE# signal.
> Rewrite the commit message.
>
> Changes in v7:
> Move PCIE_WAKE handling into pci core.
>
> Changes in v6:
> Fix device_init_wake error handling, and add some comments.
>
> Changes in v5:
> Move to pci.txt
> Rebase.
> Use "wakeup" instead of "wake"
>
> Changes in v3:
> Fix error handling.
>
> Changes in v2:
> Use dev_pm_set_dedicated_wake_irq.
>
> Jeffy Chen (3):
>    dt-bindings: PCI: Add definition of PCIe WAKE# irq and PCI irq
>    of/irq: Adjust of_pci_irq parsing for multiple interrupts
>    PCI / PM: Add support for the PCIe WAKE# signal for OF
>
> Manikanta Maddireddy (2):
>    arm64: tegra: Add PCIe port node with PCIe WAKE# for C1 controller
>    soc/tegra: pmc: Add Tegra234 PCIe wake event
>
>   Documentation/devicetree/bindings/pci/pci.txt |  8 +++
>   .../nvidia/tegra234-p3737-0000+p3701-0000.dts | 11 ++++
>   drivers/pci/of.c                              | 63 ++++++++++++++++++-
>   drivers/pci/pci-driver.c                      | 10 +++
>   drivers/pci/pci.c                             |  7 +++
>   drivers/pci/pci.h                             |  8 +++
>   drivers/soc/tegra/pmc.c                       |  1 +
>   7 files changed, 105 insertions(+), 3 deletions(-)
>

