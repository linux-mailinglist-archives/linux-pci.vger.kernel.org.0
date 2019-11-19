Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 62BBC101208
	for <lists+linux-pci@lfdr.de>; Tue, 19 Nov 2019 04:15:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727514AbfKSDPX (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 18 Nov 2019 22:15:23 -0500
Received: from mga07.intel.com ([134.134.136.100]:24657 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727334AbfKSDPW (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Mon, 18 Nov 2019 22:15:22 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 18 Nov 2019 19:15:21 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.68,322,1569308400"; 
   d="scan'208";a="289464730"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 18 Nov 2019 19:15:21 -0800
Received: from [10.226.38.254] (unknown [10.226.38.254])
        by linux.intel.com (Postfix) with ESMTP id BA98F5800FE;
        Mon, 18 Nov 2019 19:15:18 -0800 (PST)
Subject: Re: [PATCH v7 2/3] dwc: PCI: intel: PCIe RC controller driver
To:     Jingoo Han <jingoohan1@gmail.com>,
        "gustavo.pimentel@synopsys.com" <gustavo.pimentel@synopsys.com>,
        "lorenzo.pieralisi@arm.com" <lorenzo.pieralisi@arm.com>,
        "andrew.murray@arm.com" <andrew.murray@arm.com>,
        "helgaas@kernel.org" <helgaas@kernel.org>,
        "robh@kernel.org" <robh@kernel.org>,
        "martin.blumenstingl@googlemail.com" 
        <martin.blumenstingl@googlemail.com>,
        "linux-pci@vger.kernel.org" <linux-pci@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "andriy.shevchenko@intel.com" <andriy.shevchenko@intel.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "cheol.yong.kim@intel.com" <cheol.yong.kim@intel.com>,
        "chuanhua.lei@linux.intel.com" <chuanhua.lei@linux.intel.com>,
        "qi-ming.wu@intel.com" <qi-ming.wu@intel.com>
References: <cover.1573784557.git.eswara.kota@linux.intel.com>
 <99a29f5a4ce18df26bd300ac6728433ec025631b.1573784557.git.eswara.kota@linux.intel.com>
 <SL2P216MB01056231B6036941BEF71738AA700@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <50dabbc6-eae5-5ae5-95a0-f195c1ef7362@linux.intel.com>
 <SL2P216MB010580C028A7F88E8FB72574AA4D0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
 <5fc0001f-e73c-af1d-4182-d2d2448741fd@linux.intel.com>
 <SL2P216MB0105BEFFAFEAB06F408C31A2AA4C0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
From:   Dilip Kota <eswara.kota@linux.intel.com>
Message-ID: <32f19457-c35f-656c-e434-d52ddb38de25@linux.intel.com>
Date:   Tue, 19 Nov 2019 11:15:17 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <SL2P216MB0105BEFFAFEAB06F408C31A2AA4C0@SL2P216MB0105.KORP216.PROD.OUTLOOK.COM>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org


On 11/19/2019 10:33 AM, Jingoo Han wrote:
> On 11/18/19, 8:26 PM, Dilip Kota wrote:
>> On 11/19/2019 12:40 AM, Jingoo Han wrote:
>>> ﻿On 11/18/19, 2:58 AM, Dilip Kota wrote:
>>>
>>>> On 11/16/2019 4:40 AM, Jingoo Han wrote:
>>>>> On 11/14/19, 9:31 PM, Dilip Kota wrote:
>>>>>
>>>>>> Add support to PCIe RC controller on Intel Gateway SoCs.
>>>>>> PCIe controller is based of Synopsys DesignWare PCIe core.
>>>>>>
>>>>>> Intel PCIe driver requires Upconfigure support, Fast Training
>>>>>> Sequence and link speed configurations. So adding the respective
>>>>>> helper functions in the PCIe DesignWare framework.
>>>>>> It also programs hardware autonomous speed during speed
>>>>>> configuration so defining it in pci_regs.h.
>>>>>>
>>>>>> Signed-off-by: Dilip Kota <eswara.kota@linux.intel.com>
>>>>>> Reviewed-by: Andrew Murray <andrew.murray@arm.com>
>>>>>> Acked-by: Gustavo Pimentel <gustavo.pimentel@synopsys.com>
>>>>>> ---
>>>>> [.....]
>>>>>
>>>>>>     drivers/pci/controller/dwc/Kconfig           |  10 +
>>>>>>     drivers/pci/controller/dwc/Makefile          |   1 +
>>>>>>     drivers/pci/controller/dwc/pcie-designware.c |  57 +++
>>>>>>     drivers/pci/controller/dwc/pcie-designware.h |  12 +
>>>>>>     drivers/pci/controller/dwc/pcie-intel-gw.c   | 542 +++++++++++++++++++++++++++
>>>>>>     include/uapi/linux/pci_regs.h                |   1 +
>>>>>>     6 files changed, 623 insertions(+)
>>>>>>     create mode 100644 drivers/pci/controller/dwc/pcie-intel-gw.c
>>>>>>
>>>>>> diff --git a/drivers/pci/controller/dwc/Kconfig b/drivers/pci/controller/dwc/Kconfig
>>>>>> index 0ba988b5b5bc..fb6d474477df 100644
>>>>>> --- a/drivers/pci/controller/dwc/Kconfig
>>>>>> +++ b/drivers/pci/controller/dwc/Kconfig
>>>>>> @@ -82,6 +82,16 @@ config PCIE_DW_PLAT_EP
>>>>>>     	  order to enable device-specific features PCI_DW_PLAT_EP must be
>>>>>>     	  selected.
>>>>>>     
>>>>>> +config PCIE_INTEL_GW
>>>>>> +	bool "Intel Gateway PCIe host controller support"
>>>>>> +	depends on OF && (X86 || COMPILE_TEST)
>>>>>> +	select PCIE_DW_HOST
>>>>>> +	help
>>>>>> +	  Say 'Y' here to enable PCIe Host controller support on Intel
>>>>>> +	  Gateway SoCs.
>>>>>> +	  The PCIe controller uses the DesignWare core plus Intel-specific
>>>>>> +	  hardware wrappers.
>>>>>> +
>>>>> Please add this config alphabetical order!
>>>>> So, this config should be after 'config PCI_IMX6'.
>>>>> There is no reason to put this config at the first place.
>>>>>
>>>>>>     config PCI_EXYNOS
>>>>>>     	bool "Samsung Exynos PCIe controller"
>>>>>>     	depends on SOC_EXYNOS5440 || COMPILE_TEST
>>>>>> diff --git a/drivers/pci/controller/dwc/Makefile b/drivers/pci/controller/dwc/Makefile
>>>>>> index b30336181d46..99db83cd2f35 100644
>>>>>> --- a/drivers/pci/controller/dwc/Makefile
>>>>>> +++ b/drivers/pci/controller/dwc/Makefile
>>>>>> @@ -3,6 +3,7 @@ obj-$(CONFIG_PCIE_DW) += pcie-designware.o
>>>>>>     obj-$(CONFIG_PCIE_DW_HOST) += pcie-designware-host.o
>>>>>>     obj-$(CONFIG_PCIE_DW_EP) += pcie-designware-ep.o
>>>>>>     obj-$(CONFIG_PCIE_DW_PLAT) += pcie-designware-plat.o
>>>>>> +obj-$(CONFIG_PCIE_INTEL_GW) += pcie-intel-gw.o
>>>>> Ditto.
>>>> PCIE_INTEL_GW wouldnt come after PCI_IMX6, the complete Makefile and
>>>> Kconfig are not in order,( PCI_* and PCIE_* are not in any order). So i
>>>> just followed PCIE_DW and placed PCIE_INTEL_GW after PCIE_DW as I is
>>>> after D (and i see PCI_* immediately after the PCIE_DW*, so i placed
>>>> PCIE_INTEL_GW after PCIE_DW* and before PCI_*).
>>> Hey, although some of them are not in order, you don't have a right to do so.
>>> If some people do not follow the law, it does not mean that you can break the law.
>>> Anyway, if you don't follow an alphabetical order, my answer is NACK.
>>> Also, other people or I will send a patch to fix the order of other drivers.
>> I am not against following the order. I kept PCIE_INTEL_GW after
>> PCIE_DW* by checking the best possible order.
>> As per the alphabetical order, i see all CONFIG_PCIE_* comes first and
>> CONFIG_PCI_* follows. So, by following this, i placed PCIE_INTEL_GW
>> after PCIE_DW* (for the same reason PCIE_INTEL_GW cannot be placed after
>> PCI_IMX6).
>> Even after re-ordering the Kconfig and Makefile, still PCIE_INTEL_GW
>> comes after PCIE_DW_PLAT( and PCIE_HISI_STB).
> Are you kidding me?
>
> Most PCIE_* drivers are located after PCI_*. Look at PCIE_QCOM, PCIE_ARMADA_8K,
> PCIE_ARTPEC6, PCIE_KIRIN, PCIE_HISI_STB, PCIE_TEGRA194, PCIE_UNIPHIER, PCIE_AL.
Ok, So the understanding is PCIE_DW* will be at top as they are 
framework and then comes CONFIG_PCI_*, CONFIG_PCIE_*.
> Put PCIE_INTEL_GW between PCIE_ARTPEC6_EP and PCIE_KIRIN.

Ok. I will update in the next patch version.

Regards,
Dilip

>
>
>> Regards,
> Dilip
>
>>
>>> Regards,
>>> Dilip
>>> Best regards,
>>> Jingoo Han
>>>
>>>>     obj-$(CONFIG_PCI_DRA7XX) += pci-dra7xx.o
>>>>     obj-$(CONFIG_PCI_EXYNOS) += pci-exynos.o
>>>>     obj-$(CONFIG_PCI_IMX6) += pci-imx6.o
>>>> diff --git a/drivers/pci/controller/dwc/pcie-designware.c b/drivers/pci/controller/dwc/pcie-designware.c
>>>> index 820488dfeaed..479e250695a0 100644
>>> [.....]
