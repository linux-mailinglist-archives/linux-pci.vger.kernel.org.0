Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 744D77144EE
	for <lists+linux-pci@lfdr.de>; Mon, 29 May 2023 08:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231640AbjE2Gdn (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 29 May 2023 02:33:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231569AbjE2Gdn (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 29 May 2023 02:33:43 -0400
Received: from out30-111.freemail.mail.aliyun.com (out30-111.freemail.mail.aliyun.com [115.124.30.111])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 150B4E8;
        Sun, 28 May 2023 23:33:26 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045192;MF=xueshuai@linux.alibaba.com;NM=1;PH=DS;RN=14;SR=0;TI=SMTPD_---0Vjgj2wz_1685342001;
Received: from 30.240.113.228(mailfrom:xueshuai@linux.alibaba.com fp:SMTPD_---0Vjgj2wz_1685342001)
          by smtp.aliyun-inc.com;
          Mon, 29 May 2023 14:33:22 +0800
Message-ID: <1a1af428-0794-514d-1d79-52e3796a0707@linux.alibaba.com>
Date:   Mon, 29 May 2023 14:33:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.10.1
Subject: Re: [PATCH v5 3/4] drivers/perf: add DesignWare PCIe PMU driver
Content-Language: en-US
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        chengyou@linux.alibaba.com, kaishen@linux.alibaba.com,
        helgaas@kernel.org, yangyicong@huawei.com, will@kernel.org,
        Jonathan.Cameron@huawei.com, robin.murphy@arm.com
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-pci@vger.kernel.org, rdunlap@infradead.org,
        mark.rutland@arm.com, zhuo.song@linux.alibaba.com
References: <20220917121036.14864-1-xueshuai@linux.alibaba.com>
 <20230522035428.69441-4-xueshuai@linux.alibaba.com>
 <505a5d3a-c970-8d15-ea60-444a3630c199@linux.alibaba.com>
From:   Shuai Xue <xueshuai@linux.alibaba.com>
In-Reply-To: <505a5d3a-c970-8d15-ea60-444a3630c199@linux.alibaba.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2023/5/29 14:13, Baolin Wang wrote:
> 
> 
> On 5/22/2023 11:54 AM, Shuai Xue wrote:
>> This commit adds the PCIe Performance Monitoring Unit (PMU) driver support
>> for T-Head Yitian SoC chip. Yitian is based on the Synopsys PCI Express
>> Core controller IP which provides statistics feature. The PMU is not a PCIe
>> Root Complex integrated End Point(RCiEP) device but only register counters
>> provided by each PCIe Root Port.
>>
>> To facilitate collection of statistics the controller provides the
>> following two features for each Root Port:
>>
>> - Time Based Analysis (RX/TX data throughput and time spent in each
>>    low-power LTSSM state)
>> - Event counters (Error and Non-Error for lanes)
>>
>> Note, only one counter for each type and does not overflow interrupt.
>>
>> This driver adds PMU devices for each PCIe Root Port. And the PMU device is
>> named based the BDF of Root Port. For example,
>>
>>      30:03.0 PCI bridge: Device 1ded:8000 (rev 01)
>>
>> the PMU device name for this Root Port is dwc_rootport_3018.
>>
>> Example usage of counting PCIe RX TLP data payload (Units of 16 bytes)::
>>
>>      $# perf stat -a -e dwc_rootport_3018/Rx_PCIe_TLP_Data_Payload/
>>
>> average RX bandwidth can be calculated like this:
>>
>>      PCIe TX Bandwidth = PCIE_TX_DATA * 16B / Measure_Time_Window
>>
>> Signed-off-by: Shuai Xue <xueshuai@linux.alibaba.com>
>> Reported-by: kernel test robot <lkp@intel.com>
>> Link: https://lore.kernel.org/oe-kbuild-all/202305170639.XU3djFZX-lkp@intel.com/
>> ---
> 
> [snip]
> 
>> +static int dwc_pcie_pmu_remove(struct platform_device *pdev)
>> +{
>> +    struct dwc_pcie_pmu_priv *priv = platform_get_drvdata(pdev);
>> +    struct dwc_pcie_pmu *pcie_pmu;
>> +
>> +    list_for_each_entry(pcie_pmu, &priv->pmu_nodes, pmu_node) {
>> +        cpuhp_state_remove_instance(dwc_pcie_pmu_hp_state,
>> +                        &pcie_pmu->cpuhp_node);
>> +        perf_pmu_unregister(&pcie_pmu->pmu);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static int dwc_pcie_pmu_probe(struct platform_device *pdev)
>> +{
>> +    struct dwc_pcie_pmu_priv *priv;
>> +
>> +    priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
>> +    if (!priv)
>> +        return -ENOMEM;
>> +
>> +    priv->dev = &pdev->dev;
>> +    platform_set_drvdata(pdev, priv);
>> +
>> +    /* If one PMU registration fails, remove all. */
>> +    if (__dwc_pcie_pmu_probe(priv))
>> +        dwc_pcie_pmu_remove(pdev);
> 
> In this case, you should return error from __dwc_pcie_pmu_probe() instead of returning 0, to release the requested resources of the PMU deivce.

You are right, will fix it in next version.

> 
>> +
>> +    return 0;
>> +}
>> +
>> +static void dwc_pcie_pmu_migrate(struct dwc_pcie_pmu *pcie_pmu, unsigned int cpu)
>> +{
>> +    /* This PMU does NOT support interrupt, just migrate context. */
>> +    perf_pmu_migrate_context(&pcie_pmu->pmu, pcie_pmu->oncpu, cpu);
>> +    pcie_pmu->oncpu = cpu;
>> +}
>> +
>> +static int dwc_pcie_pmu_online_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
>> +{
>> +    struct dwc_pcie_pmu *pcie_pmu;
>> +    struct pci_dev *pdev;
>> +    int node;
>> +
>> +    pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
>> +    pdev = pcie_pmu->pdev;
>> +    node = dev_to_node(&pdev->dev);
>> +
>> +    if (node != NUMA_NO_NODE && cpu_to_node(pcie_pmu->oncpu) != node &&
>> +        cpu_to_node(cpu) == node)
>> +        dwc_pcie_pmu_migrate(pcie_pmu, cpu);
>> +
>> +    return 0;
>> +}
>> +
>> +static int dwc_pcie_pmu_offline_cpu(unsigned int cpu, struct hlist_node *cpuhp_node)
>> +{
>> +    struct dwc_pcie_pmu *pcie_pmu;
>> +    struct pci_dev *pdev;
>> +    int node;
>> +    cpumask_t mask;
>> +    unsigned int target;
>> +
>> +    pcie_pmu = hlist_entry_safe(cpuhp_node, struct dwc_pcie_pmu, cpuhp_node);
>> +    if (cpu != pcie_pmu->oncpu)
>> +        return 0;
>> +
>> +    pdev = pcie_pmu->pdev;
>> +    node = dev_to_node(&pdev->dev);
>> +    if (cpumask_and(&mask, cpumask_of_node(node), cpu_online_mask) &&
>> +        cpumask_andnot(&mask, &mask, cpumask_of(cpu)))
>> +        target = cpumask_any(&mask);
>> +    else
>> +        target = cpumask_any_but(cpu_online_mask, cpu);
>> +    if (target < nr_cpu_ids)
>> +        dwc_pcie_pmu_migrate(pcie_pmu, target);
>> +
>> +    return 0;
>> +}
>> +
>> +static struct platform_driver dwc_pcie_pmu_driver = {
>> +    .probe = dwc_pcie_pmu_probe,
>> +    .remove = dwc_pcie_pmu_remove,
>> +    .driver = {.name = "dwc_pcie_pmu",},
>> +};
>> +
>> +static int __init dwc_pcie_pmu_init(void)
>> +{
>> +    int ret;
>> +
>> +    ret = cpuhp_setup_state_multi(CPUHP_AP_ONLINE_DYN,
>> +                      "perf/dwc_pcie_pmu:online",
>> +                      dwc_pcie_pmu_online_cpu,
>> +                      dwc_pcie_pmu_offline_cpu);
>> +    if (ret < 0)
>> +        return ret;
>> +
>> +    dwc_pcie_pmu_hp_state = ret;
>> +
>> +    ret = platform_driver_register(&dwc_pcie_pmu_driver);
>> +    if (ret) {
>> +        cpuhp_remove_multi_state(dwc_pcie_pmu_hp_state);
>> +        return ret;
>> +    }
>> +
>> +    dwc_pcie_pmu_dev = platform_device_register_simple(
>> +                "dwc_pcie_pmu", PLATFORM_DEVID_NONE, NULL, 0);
>> +    if (IS_ERR(dwc_pcie_pmu_dev)) {
>> +        platform_driver_unregister(&dwc_pcie_pmu_driver);
>> +        return PTR_ERR(dwc_pcie_pmu_dev);
>> +    }
>> +
>> +    return 0;
>> +}
>> +
>> +static void __exit dwc_pcie_pmu_exit(void)
>> +{
>> +    platform_device_unregister(dwc_pcie_pmu_dev);
>> +    platform_driver_unregister(&dwc_pcie_pmu_driver);
> 
> You should also call 'cpuhp_remove_multi_state()' when exiting the driver.

Good catch, will add it in next version.


> 
> With above issues fixed, you can add:
> Reviewed-by: Baolin Wang <baolin.wang@linux.alibaba.com>

Thank you :)

Best Regards,
Shuai
