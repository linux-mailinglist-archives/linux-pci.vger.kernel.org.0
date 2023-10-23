Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3720E7D366B
	for <lists+linux-pci@lfdr.de>; Mon, 23 Oct 2023 14:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjJWM0M (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 23 Oct 2023 08:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230014AbjJWM0L (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 23 Oct 2023 08:26:11 -0400
Received: from out30-110.freemail.mail.aliyun.com (out30-110.freemail.mail.aliyun.com [115.124.30.110])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAE96100;
        Mon, 23 Oct 2023 05:26:08 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R471e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=16;SR=0;TI=SMTPD_---0VuktyZl_1698063962;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VuktyZl_1698063962)
          by smtp.aliyun-inc.com;
          Mon, 23 Oct 2023 20:26:05 +0800
Message-ID: <d8aff089-8b7f-497c-9dbb-c02aa7abc0b6@linux.alibaba.com>
Date:   Mon, 23 Oct 2023 20:26:00 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v9 3/4] drivers/perf: add DesignWare PCIe PMU driver
To:     Yicong Yang <yangyicong@huawei.com>, chengyou@linux.alibaba.com,
        kaishen@linux.alibaba.com, helgaas@kernel.org, will@kernel.org,
        Jonathan.Cameron@huawei.com, baolin.wang@linux.alibaba.com,
        robin.murphy@arm.com
Cc:     yangyicong@hisilicon.com, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-pci@vger.kernel.org,
        rdunlap@infradead.org, mark.rutland@arm.com,
        zhuo.song@linux.alibaba.com, renyu.zj@linux.alibaba.com
References: <20231020134230.53342-1-xueshuai@linux.alibaba.com>
 <20231020134230.53342-4-xueshuai@linux.alibaba.com>
 <5d8a8073-bdd2-9416-d93c-516416fcfd5e@huawei.com>
Content-Language: en-US
In-Reply-To: <5d8a8073-bdd2-9416-d93c-516416fcfd5e@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/10/23 17:13, Yicong Yang wrote:
> Hi Shuai,
> 
> On 2023/10/20 21:42, Shuai Xue wrote:
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
> 
> Just one nit below. Otherwise looks good to me,
> 
> Reviewed-by: Yicong Yang <yangyicong@hisilicon.com>


Hi, Yicong,

Time flies indeed. I am pleasantly surprised to realize that it has been
over a year since you sayed "Glad to see another PCIe PMU device!" in the
initial version. I want to express my deepest gratitude for the significant
time and effort you have invested in providing invaluable comments. Your
dedication has played a pivotal role in greatly enhancing the quality of
the code.

Thank you so much.

Best Regards,
Shuai

>> +
>> +static int dwc_pcie_pmu_probe(struct platform_device *plat_dev)
>> +{
>> +	struct pci_dev *pdev = NULL;
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +	bool notify = false;
>> +	char *name;
>> +	u32 bdf;
>> +	int ret;
>> +
>> +	/* Match the rootport with VSEC_RAS_DES_ID, and register a PMU for it */
>> +	for_each_pci_dev(pdev) {
>> +		u16 vsec;
>> +		u32 val;
>> +
>> +		if (!(pci_is_pcie(pdev) &&
>> +		      pci_pcie_type(pdev) == PCI_EXP_TYPE_ROOT_PORT))
>> +			continue;
>> +
>> +		vsec = pci_find_vsec_capability(pdev, PCI_VENDOR_ID_ALIBABA,
>> +						DWC_PCIE_VSEC_RAS_DES_ID);
>> +		if (!vsec)
>> +			continue;
>> +
>> +		pci_read_config_dword(pdev, vsec + PCI_VNDR_HEADER, &val);
>> +		if (PCI_VNDR_HEADER_REV(val) != 0x04)
>> +			continue;
>> +		pci_dbg(pdev,
>> +			"Detected PCIe Vendor-Specific Extended Capability RAS DES\n");
>> +
>> +		bdf = PCI_DEVID(pdev->bus->number, pdev->devfn);
>> +		name = devm_kasprintf(&plat_dev->dev, GFP_KERNEL, "dwc_rootport_%x",
>> +				      bdf);
>> +		if (!name) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		/* All checks passed, go go go */
>> +		pcie_pmu = devm_kzalloc(&plat_dev->dev, sizeof(*pcie_pmu), GFP_KERNEL);
>> +		if (!pcie_pmu) {
>> +			ret = -ENOMEM;
>> +			goto out;
>> +		}
>> +
>> +		pcie_pmu->pdev = pdev;
>> +		pcie_pmu->ras_des_offset = vsec;
>> +		pcie_pmu->nr_lanes = pcie_get_width_cap(pdev);
>> +		pcie_pmu->on_cpu = -1;
>> +		pcie_pmu->pmu = (struct pmu){
>> +			.module		= THIS_MODULE,
>> +			.attr_groups	= dwc_pcie_attr_groups,
>> +			.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>> +			.task_ctx_nr	= perf_invalid_context,
>> +			.event_init	= dwc_pcie_pmu_event_init,
>> +			.add		= dwc_pcie_pmu_event_add,
>> +			.del		= dwc_pcie_pmu_event_del,
>> +			.start		= dwc_pcie_pmu_event_start,
>> +			.stop		= dwc_pcie_pmu_event_stop,
>> +			.read		= dwc_pcie_pmu_event_update,
>> +		};
>> +
>> +		/* Add this instance to the list used by the offline callback */
>> +		ret = cpuhp_state_add_instance(dwc_pcie_pmu_hp_state,
>> +					       &pcie_pmu->cpuhp_node);
>> +		if (ret) {
>> +			pci_err(pdev,
>> +				"Error %d registering hotplug @%x\n", ret, bdf);
>> +			goto out;
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
>> +		if (ret)
>> +			goto out;
>> +	}
>> +
>> +	if (notify && !bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb))
>> +		return devm_add_action_or_reset(
>> +			&plat_dev->dev, dwc_pcie_pmu_unregister_nb, NULL);
> 
> Maybe you can register the notifier firstly in the probe(). It'll be unregistered
> once failed to add the PMU. If no PMU registered it also should be ok since the
> PMU list will be empty and notifier callback will do nothing.
> 
> This may address one potential race on driver removal. Since the notifier will be
> unregistered firstly 

You are right, the added action will be released in reverse order.

> but the PMU's still registered and may have chance to
> access pointer to the root port. However it's so extreme so may never happen.
> 

Good point, I will move to bus_register_notifier() to first order in probe().

