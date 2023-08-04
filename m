Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 271A076F7DB
	for <lists+linux-pci@lfdr.de>; Fri,  4 Aug 2023 04:28:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229618AbjHDC2S (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 3 Aug 2023 22:28:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233949AbjHDC2J (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Thu, 3 Aug 2023 22:28:09 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7290ABA;
        Thu,  3 Aug 2023 19:28:08 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4RH8jx2h2ZzrRft;
        Fri,  4 Aug 2023 10:27:01 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.27; Fri, 4 Aug 2023 10:28:05 +0800
CC:     <yangyicong@hisilicon.com>, <chengyou@linux.alibaba.com>,
        <kaishen@linux.alibaba.com>, <helgaas@kernel.org>,
        <will@kernel.org>, <baolin.wang@linux.alibaba.com>,
        <robin.murphy@arm.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <rdunlap@infradead.org>,
        <mark.rutland@arm.com>, <zhuo.song@linux.alibaba.com>
Subject: Re: [PATCH v6 3/4] drivers/perf: add DesignWare PCIe PMU driver
To:     Shuai Xue <xueshuai@linux.alibaba.com>,
        Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230606074938.97724-1-xueshuai@linux.alibaba.com>
 <20230606074938.97724-4-xueshuai@linux.alibaba.com>
 <31e2b012-3a29-d063-842d-e3f7736816e7@huawei.com>
 <20230727103929.00000544@Huawei.com>
 <12958abe-4bdb-8532-bf67-8e772ed2a9dd@linux.alibaba.com>
 <edc056aa-1c53-a31e-087f-6076b795d5cc@huawei.com>
 <10176239-78c1-e276-e74f-a6e79b9c0751@linux.alibaba.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <f14c9acd-1549-1a65-4e57-a5e434cbe18d@huawei.com>
Date:   Fri, 4 Aug 2023 10:28:05 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <10176239-78c1-e276-e74f-a6e79b9c0751@linux.alibaba.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/8/4 9:39, Shuai Xue wrote:
> 
> 
> On 2023/8/1 19:46, Yicong Yang wrote:
>> On 2023/7/28 20:41, Shuai Xue wrote:
>>>
>>>
>>> On 2023/7/27 17:39, Jonathan Cameron wrote:
>>>> On Tue, 6 Jun 2023 23:14:07 +0800
>>>> Yicong Yang <yangyicong@huawei.com> wrote:
>>>>
>>>>> On 2023/6/6 15:49, Shuai Xue wrote:
>>>>>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>>>>>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>>>>>> Core controller IP which provides statistics feature. The PMU is not a PCIe
>>>>>> Root Complex integrated End Point(RCiEP) device but only register counters
>>>>>> provided by each PCIe Root Port.
>>>>>>
>>>>>> To facilitate collection of statistics the controller provides the
>>>>>> following two features for each Root Port:
>>>>>>
>>>>>> - Time Based Analysis (RX/TX data throughput and time spent in each
>>>>>>   low-power LTSSM state)
>>>>>> - Event counters (Error and Non-Error for lanes)
>>>>>>
>>>>>> Note, only one counter for each type and does not overflow interrupt.
>>>>>>
>>>>>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>>>>>> named based the BDF of Root Port. For example,
>>>>>>
>>>>>>     30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>>>>>
>>>>>> the PMU device name for this Root Port is dwc_rootport_3018.
>>>>>>
>>>>>> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>>>>>>
>>>>>>     $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>>>>>
>>>>>> average RX bandwidth can be calculated like this:
>>>>>>
>>>>>>     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
>>>>>>
>>>>>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>>>>>> Reported-by: kernel test robot <lkp@intel.com>
>>>>>> Link: https://lore.kernel.org/oe-kbuild-all/202305170639.XU3djFZX-lkp@intel.com/
>>>>>> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>>>>
>>>> I'll review on top to avoid any duplication with Yicong.
>>>
>>> Thank you! It also served as a reminder that I missed Yicong's email. It appears
>>> that Thunderbird mistakenly moved his email to the junk folder, resulting in me
>>> overlooking it.
>>>
>>>>
>>>> Note I've cropped the stuff neither of us commented on so it's
>>>> easier to spot the feedback.
>>>
>>> Thank you for noting that. My feedback is replied inline.
>>>
>>>>
>>>> Jonathan
>>>>
>>>>>> ---
>>>>>>  drivers/perf/Kconfig        |   7 +
>>>>>>  drivers/perf/Makefile       |   1 +
>>>>>>  drivers/perf/dwc_pcie_pmu.c | 706 ++++++++++++++++++++++++++++++++++++
>>>>>>  3 files changed, 714 insertions(+)
>>>>>>  create mode 100644 drivers/perf/dwc_pcie_pmu.c
>>>>>>
>>>>>> diff --git a/drivers/perf/Kconfig b/drivers/perf/Kconfig
>>>>>> index 711f82400086..6ff3921d7a62 100644
>>>>>> --- a/drivers/perf/Kconfig
>>>>>> +++ b/drivers/perf/Kconfig
>>>>>> @@ -209,6 +209,13 @@ config MARVELL_CN10K_DDR_PMU
>>>>>>  	  Enable perf support for Marvell DDR Performance monitoring
>>>>>>  	  event on CN10K platform.
>>>>>>  
>>>>>> +config DWC_PCIE_PMU
>>>>>> +	tristate "Enable Synopsys DesignWare PCIe PMU Support"
>>>>>> +	depends on (ARM64 && PCI)
>>>>>> +	help
>>>>>> +	  Enable perf support for Synopsys DesignWare PCIe PMU Performance
>>>>>> +	  monitoring event on Yitian 710 platform.
>>>>
>>>> The documentation kind of implies this isn't platform specific.
>>>> If some parts are (such as which events exist) then you may want to push
>>>> that to userspace / perftool with appropriate matching against specific SoC.
>>>>
>>>> If it is generic, then change this text to "event on platform including the Yitian 710."
>>>
>>> It is generic without any platform specific, so I will change it as you expected.
>>>
>>>>
>>>>>> +
>>>>>>  source "drivers/perf/arm_cspmu/Kconfig"
>>>>>>  
>>>>>>  source "drivers/perf/amlogic/Kconfig"
>>>>
>>>>>> new file mode 100644
>>>>>> index 000000000000..8bfcf6e0662d
>>>>>> --- /dev/null
>>>>>> +++ b/drivers/perf/dwc_pcie_pmu.c
>>>>>> @@ -0,0 +1,706 @@
>>>>
>>>> ...
>>>>
>>>>>> +
>>>>>> +struct dwc_pcie_pmu {
>>>>>> +	struct pci_dev		*pdev;		/* Root Port device */  
>>>>>
>>>>> If the root port removed after the probe of this PCIe PMU driver, we'll access the NULL
>>>>> pointer. I didn't see you hold the root port to avoid the removal.
>>>
>>> Do you mean that I should have a reference count of rootport by pci_dev_get() when allocating
>>> pcie_pmu?
>>>
>>>      pcie_pmu->pdev = pci_dev_get();
>>
>> It could be one option, but will block the removal of device from userspace. Another option
>> is to register a PCI bus notifier then on removal/added the driver can get notified and handle
>> it, for example, remove the related PMU on the removal of the root ports.
> 
> I see, but can root port be removed from userspace? I check the hotplug slot interface, no root
> port is available to power off.
> 

For hotplug maybe not, but user can remove certian device through sysfs:

echo 1 > /sys/bus/pci/devices/<root port>/remove

Thanks.
