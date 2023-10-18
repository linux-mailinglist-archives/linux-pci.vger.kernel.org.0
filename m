Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 347457CD2AF
	for <lists+linux-pci@lfdr.de>; Wed, 18 Oct 2023 05:33:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229453AbjJRDdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 17 Oct 2023 23:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjJRDdn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 17 Oct 2023 23:33:43 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC314BA;
        Tue, 17 Oct 2023 20:33:39 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R181e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=15;SR=0;TI=SMTPD_---0VuPEjZM_1697600015;
Received: from 30.240.113.74(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0VuPEjZM_1697600015)
          by smtp.aliyun-inc.com;
          Wed, 18 Oct 2023 11:33:37 +0800
Message-ID: <0704f9f6-1e9a-4587-b92f-c799b932b755@linux.alibaba.com>
Date:   Wed, 18 Oct 2023 11:33:34 +0800
MIME-Version: 1.0
User-Agent: Mozilla Thunderbird
From:   Shuai Xue <xueshuai@linux.alibaba.com>
Subject: Re: [PATCH v8 3/4] drivers/perf: add DesignWare PCIe PMU driver
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
Cc:     chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        baolin.wang@linux.alibaba.com, robin.murphy@arm.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com,
        renyu.zj@linux.alibaba.com
References: <20231017013235.27831-1-xueshuai@linux.alibaba.com>
 <20231017013235.27831-4-xueshuai@linux.alibaba.com>
 <20231017103959.00006ec3@Huawei.com>
Content-Language: en-US
In-Reply-To: <20231017103959.00006ec3@Huawei.com>
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



On 2023/10/17 17:39, Jonathan Cameron wrote:
> On Tue, 17 Oct 2023 09:32:34 +0800
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
>> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
> 
> Question follow through from previous patch comment, why not just
> multiply it by 16 when you read it?  Is something in perf going to
> overflow?

As we discussed in Path 1/4, the unit 16 is not general for all groups of
Time Based Analysis, I prefer to leave unit part to end perf users.

> 
>>
>>     $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>     PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
> 
> Most of the comments inline aren't perf driver specific.  To me that
> part of it looks fine but I'm only an intermittent reviewer of perf
> drivers, so that needs more eyes!
> 
> Anyhow, to my eyes this is coming together well but there are a few things
> that don't look quite right yet.

Thank you for valuable comments, I will try my best to address them :)

> 
> ...
> 
>> +#define DWC_PCIE_LANE_EVENT_MAX_PERIOD		GENMASK_ULL(31, 0)
>> +#define DWC_PCIE_TIME_BASED_EVENT_MAX_PERIOD	GENMASK_ULL(63, 0)
>> +
>> +struct dwc_pcie_pmu {
>> +	struct pmu		pmu;
>> +	struct pci_dev		*pdev;		/* Root Port device */
>> +	u16			ras_des;	/* RAS DES capability offset */
> 
> Could call it ras_des_offset as then the comment wouldn't be needed...

Agreed, will fix it.

> 
>> +	u32			nr_lanes;
>> +
>> +	struct list_head	pmu_node;
>> +	struct hlist_node	cpuhp_node;
>> +	struct perf_event	*event[DWC_PCIE_EVENT_TYPE_MAX];
>> +	int			on_cpu;
>> +	bool			registered;
>> +};
>>
> 
> 
>> +static void dwc_pcie_pmu_unregister_pmu(void *data)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu = data;
>> +
>> +	if (!pcie_pmu->registered)
>> +		return;
>> +
>> +	perf_pmu_unregister(&pcie_pmu->pmu);
>> +	pcie_pmu->registered = false;
>> +	list_del(&pcie_pmu->pmu_node);
> For simplicity or reviewing I'd expect either:
> a) Exact reverse order of what happened in probe.
> b) A comment on why not.
> 
> That probably jus means that the perf_pmu_unregister
> should be first.

I guess you mean perf_pmu_unregister should be last?
Bellow is the exact reverse order of what happened in probe.

	pcie_pmu->registered = false;
	list_del(&pcie_pmu->pmu_node);
	perf_pmu_unregister(&pcie_pmu->pmu);

> 
>> +}
> 
> 
> ...
> 
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
>> +		if (PCI_VNDR_HEADER_REV(val) != 0x04 ||
>> +		    PCI_VNDR_HEADER_LEN(val) != 0x100)
> 
> I'm curious - why check the header length?  Paranoia / defensive coding or does it vary?
> I'd expect it to be fixed for a given revision. Ideally it should be backwards compatible
> so that revs above 4 will always work (possibly with missing features) with rev 4 targeting
> software but I guess we can't guaranteed that...

Kind of defensive coding. Agreed, I will remove the hender length check to make the driver more
compatible.
> 
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
>> +		pcie_pmu->ras_des = vsec;
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
>> +			pci_err(pcie_pmu->pdev,
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
>> +			pci_err(pcie_pmu->pdev,
>> +				"Error %d registering PMU @%x\n", ret, bdf);
>> +			goto out;
>> +		}
>> +		ret = devm_add_action_or_reset(
>> +			&plat_dev->dev, dwc_pcie_pmu_unregister_pmu, pcie_pmu);
>> +		if (ret)
>> +			goto out;
> This is messy because your devm callback also deals with the bit below.
> So if the _or_reset here happens because this call fails, the list_del will
> happen on something that was never added.  Simple fix is move this down to after
> pcie_pmu->registered given none of the next few line of code can fail anyway.

Goot point. I missed the fact that if devm_add_action_or_reset() fails, the action
dwc_pcie_pmu_unregister_pmu() will be called right away.

Will fix it in next version.


> 
>> +
>> +		/* Cache PMU to handle pci device hotplug */
>> +		list_add(&pcie_pmu->pmu_node, &dwc_pcie_pmu_head);
>> +		pcie_pmu->registered = true;
>> +		notify = true;
>> +	}
>> +
>> +	if (notify && bus_register_notifier(&pci_bus_type, &dwc_pcie_pmu_nb))
>> +		notify = false;
> As mentioned below, I'd expect the bus_unregister_notifier to be in a remove()
> callback, or you could use a devm_add_action_or_reset() an a simple callback.
> You can register that as
> 
> 	if (notify) {
> 		if (bus_register_notifier() == 0)
> 			ret = devm_add_action_or_reset(unreg_notifier,
> 						       &dwc_pcie_pmu_nb);
> 	}
> and then you don't need to track if it was registered or not as the
> cleanup only happens if it was.

Good suggestion. Will also use devm_add_action_or_reset() to unwind.

> 
> 
>> +
>> +	if (notify)
>> +		dwc_pcie_pmu_notify = true;
>> +
>> +	return 0;
>> +
>> +out:
>> +	pci_dev_put(pdev);
>> +
>> +	return ret;
>> +}
>> +
> 
> 
> ...
> 
>> +
>> +static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
>> +{
>> +	struct dwc_pcie_pmu *pcie_pmu;
>> +	struct pci_dev *pdev;
>> +	int node;
>> +	cpumask_t mask;
>> +	unsigned int target;
>> +
>> +	pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
>> +	/* Nothing to do if this CPU doesn't own the PMU */
>> +	if (cpu != pcie_pmu->on_cpu)
>> +		return 0;
>> +
>> +	pcie_pmu->on_cpu = -1;
>> +	pdev = pcie_pmu->pdev;
>> +	node = dev_to_node(&pdev->dev);
>> +	if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
>> +	    cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
>> +		target = cpumask_any(&mask);
>> +	else
>> +		target = cpumask_any_but(cpu_online_mask, cpu);
>> +
>> +	if (target >= nr_cpu_ids) {
>> +		pci_err(pcie_pmu->pdev, "There is no CPU to set\n");
> 
> You have a local variable for pdev, use it here as well.

Will use local pdev directly.

> 
>> +		return 0;
>> +	}
>> +
>> +	/* This PMU does NOT support interrupt, just migrate context. */
>> +	perf_pmu_migrate_context(&pcie_pmu->pmu, cpu, target);
>> +	pcie_pmu->on_cpu = target;
>> +
>> +	return 0;
>> +}
>> +
>> +static struct platform_driver dwc_pcie_pmu_driver = {
>> +	.probe = dwc_pcie_pmu_probe,
>> +	.driver = {.name = "dwc_pcie_pmu",},
>> +};
>> +
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
>> +	if (ret) {
>> +		cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
>> +		return ret;
>> +	}
>> +
>> +	dwc_pcie_pmu_dev = platform_device_register_simple(
>> +				"dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>> +	if (IS_ERR(dwc_pcie_pmu_dev)) {
>> +		platform_driver_unregister(&dwc_pcie_pmu_driver);
> 
> Why no cpuhp_remove_multi_state() in this error path?
> 
> I'd move to the approach of a gotos and a single error handling block as
> that makes this sort of thing easier to spot.

Agreed, will use the approach of a gotos to handle errors.

> 
>> +		return PTR_ERR(dwc_pcie_pmu_dev);
>> +	}
>> +
>> +	return 0;
>> +}
>> +
>> +static void __exit dwc_pcie_pmu_exit(void)
>> +{
>> +	platform_device_unregister(dwc_pcie_pmu_dev);
>> +	platform_driver_unregister(&dwc_pcie_pmu_driver);
>> +	cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
>> +
>> +	if (dwc_pcie_pmu_notify)
> 
> If you have something unusual like this a driver module_exit() it definitely
> deserves a comment on why.  I'm surprised by this as I'd expect the notifier
> to be unregistered in the driver remove so not sure why this is here.
> I've lost track of earlier discussions so if this was addressed then all
> we need is a comment here for the next person to run into it!

All replied above, I will unregistered the notifier by devm_add_action_or_reset().

I am curious about that what the difference between unregistered in module_exit()
and remove()?

> 
>> +		bus_unregister_notifier(&pci_bus_type, &dwc_pcie_pmu_nb);
>> +}
