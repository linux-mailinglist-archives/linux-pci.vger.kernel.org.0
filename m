Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 385437D21A1
	for <lists+linux-pci@lfdr.de>; Sun, 22 Oct 2023 09:27:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229588AbjJVH1b (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 22 Oct 2023 03:27:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjJVH1a (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 22 Oct 2023 03:27:30 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79635C2;
        Sun, 22 Oct 2023 00:27:27 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R961e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VubL23W_1697959640;
Received: from 30.240.48.65(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VubL23W_1697959640)
          by smtp.aliyun-inc.com;
          Sun, 22 Oct 2023 15:27:22 +0800
Message-ID: <673a0032-db43-4708-ac71-c8bef3fd8e56@linux.alibaba.com>
Date:   Sun, 22 Oct 2023 15:27:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>,
        Yicong Yang <yangyicong@huawei.com>,
        Bjorn Helgaas <helgaas@kernel.org>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        will@kernel.org, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <20231020174940.0000429e@Huawei.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <20231020174940.0000429e@Huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/21 00:49, Jonathan Cameron wrote:
> On Fri, 20 Oct 2023 21:42:29 +0800
> Shuai Xue <xueshuai@linux.alibaba.com> wrote:
> 
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is a PCIe
>> configuration space register block provided by each PCIe Root Port in a
>> Vendor-Specific Extended Capability named RAS D.E.S (Debug, Error
>> injection, and Statistics).
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - one 64-bit counter for Time Based Analysis (RX/TX data throughput and
>>   time spent in each low-power LTSSM state) and
>> - one 32-bit counter for Event Counting (error and non-error events for
>>   a specified lane)
>>
>> Note: There is no interrupt for counter overflow.
>>
>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>     30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is dwc_rootport_3018.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of bytes)::
>>
>>     $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>     PCIe TX Bandwidth = Rx_PCIe_TLP_Data_Payload / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> LGTM other than some really trivial stuff inline if you are doing a v10
> 
> Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

Hi, Jonathan,

Thank you for your prompt response.

The fact that this [3/4] patch has received a Reviewed-by tag from the
community is a momentous milestone for both the patchset itself and for me
personally. I am deeply grateful for the time and effort you have dedicated
to providing valuable comments, as it has significantly improved the code's
quality.

I will address the inline comments in the upcoming version v10. However, I
kindly request some time to wait for feedback from esteemed reviewers such
as Yicong, Bjorn, Will, or anyone else who may find this patchset
intriguing.

Best Regards and Cheers.
Shuai


>> +		}
>> +
>> +		/* Unwind when platform driver removes */
>> +		ret = devm_add_action_or_reset(
>> +			&plat_dev->dev, dwc_pcie_pmu_remove_cpuhp_instance,
>> +			&pcie_pmu->cpuhp_node);
>> +		if (ret)
>> +			goto out;
>> +
>> +		ret = perf_pmu_register(&pcie_pmu->pmu, name, -1);
>> +		if (ret) {
>> +			pci_err(pdev,
>> +				"Error %d registering PMU @%x\n", ret, bdf);
>> +			goto out;
>> +		}
>> +
>> +		/* Cache PMU to handle pci device hotplug */
>> +		list_add(&pcie_pmu->pmu_node, &dwc_pcie_pmu_head);
>> +		pcie_pmu->registered = true;
>> +		notify = true;
>> +
>> +		ret = devm_add_action_or_reset(
>> +			&plat_dev->dev, dwc_pcie_pmu_unregister_pmu, pcie_pmu);
> 
> line wrapping is a bit ugly - I would move the &plat_dev->dev to previous line.
> and I think you can get away with aligning the rest just after the (
> 

Actually, I warp this with VSCode automaticlly :(
Will move the &plat_dev->dev to previous line.


> 
> 
> 
>> +static int __init dwc_pcie_pmu_init(void)
>> +{
>> +	int ret;
>> +
>> +	ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>> +				      "perf/dwc_pcie_pmu:online",
>> +				      dwc_pcie_pmu_online_cpu,
>> +				      dwc_pcie_pmu_offline_cpu);
>> +	if (ret < 0)
>> +		return ret;
>> +
>> +	dwc_pcie_pmu_hp_state = ret;
>> +
>> +	ret = platform_driver_register(&dwc_pcie_pmu_driver);
>> +	if (ret)
>> +		goto platform_driver_register_err;
>> +
>> +	dwc_pcie_pmu_dev = platform_device_register_simple(
>> +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
>> +		ret = PTR_ERR(dwc_pcie_pmu_dev);
>> +		goto platform_device_register_error;
>> +	}
>> +
>> +	return 0;
>> +
>> +platform_device_register_error:
> 
> Trivial but I'd standardize on err or error, not mix them.

Sorry, will fix it.

> 
>> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
>> +platform_driver_register_err:
>> +	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
>> +
>> +	return ret;
>> +}
