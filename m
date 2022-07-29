Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C006E584E6F
	for <lists+linux-pci@lfdr.de>; Fri, 29 Jul 2022 11:58:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230301AbiG2J6T (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 29 Jul 2022 05:58:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229572AbiG2J6S (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 29 Jul 2022 05:58:18 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 584F739BBC;
        Fri, 29 Jul 2022 02:58:16 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LvNDP3QxmzjXTx;
        Fri, 29 Jul 2022 17:55:17 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Jul 2022 17:58:13 +0800
CC:     <yangyicong@hisilicon.com>, <alexander.shishkin@linux.intel.com>,
        <leo.yan@linaro.org>, <james.clark@arm.com>, <will@kernel.org>,
        <robin.murphy@arm.com>, <acme@kernel.org>, <peterz@infradead.org>,
        <corbet@lwn.net>, <mathieu.poirier@linaro.org>,
        <mark.rutland@arm.com>, <jonathan.cameron@huawei.com>,
        <john.garry@huawei.com>, <helgaas@kernel.org>,
        <lorenzo.pieralisi@arm.com>, <suzuki.poulose@arm.com>,
        <joro@8bytes.org>, <shameerali.kolothum.thodi@huawei.com>,
        <mingo@redhat.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-pci@vger.kernel.org>, <linux-perf-users@vger.kernel.org>,
        <iommu@lists.linux-foundation.org>, <iommu@lists.linux.dev>,
        <linux-doc@vger.kernel.org>, <prime.zeng@huawei.com>,
        <liuqi115@huawei.com>, <zhangshaokun@hisilicon.com>,
        <linuxarm@huawei.com>, <bagasdotme@gmail.com>
Subject: Re: [PATCH v11 2/8] hwtracing: hisi_ptt: Add trace function support
 for HiSilicon PCIe Tune and Trace device
To:     Greg KH <gregkh@linuxfoundation.org>
References: <20220721130116.43366-1-yangyicong@huawei.com>
 <20220721130116.43366-3-yangyicong@huawei.com> <YuKZKGKMz+UcbETM@kroah.com>
 <33f372f6-36bf-f84e-bca0-86347fa4d579@huawei.com>
 <YuOi3i0XHV++z1YI@kroah.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <db1beba9-8db8-b14a-9078-99750a9f49a3@huawei.com>
Date:   Fri, 29 Jul 2022 17:58:12 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <YuOi3i0XHV++z1YI@kroah.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[ reply again in plain text, sorry for the wrong format ]

On 2022/7/29 17:05, Greg KH wrote:
> On Fri, Jul 29, 2022 at 03:29:14PM +0800, Yicong Yang wrote:
>>>> +	/*
>>>> +	 * Handle the interrupt on the same cpu which starts the trace to avoid
>>>> +	 * context mismatch. Otherwise we'll trigger the WARN from the perf
>>>> +	 * core in event_function_local().
>>>> +	 */
>>>> +	WARN_ON(irq_set_affinity(pci_irq_vector(hisi_ptt->pdev, HISI_PTT_TRACE_DMA_IRQ),
>>>> +				 cpumask_of(cpu)));
>>>
>>> If this hits, you just crashed the machine :(
>>>
>>
>> We'll likely to have a calltrace here without crash the machine and reboot in
>> most time, unless user has set panic_on_warn.
> 
> Again, please do not use WARN_ON for this, please read:
> 	https://elixir.bootlin.com/linux/v5.19-rc8/source/include/asm-generic/bug.h#L74
> 
> If you want a traceback (what would you do with that?), then call the
> function to give you that.  Don't crash people's boxes.
> 

ok, will change to a dev_warn/err() per documented.

>>> Please properly recover from errors if you hit them, like this.  Don't
>>> just give up and throw a message to userspace and watch the machine
>>> reboot with all data lost.
>>>
>>> Same for the other WARN_ON() instances here.  Handle the error and
>>> report it properly up the call chain.
>>>
>>
>> The driver use WARN_ON() in two places, once in pmu::start() and another in cpu teardown's
>> callback, both when the irq_set_affinity() failed. This is common to behave so when driver
>> fails to set irq affinity in pmu::start() and cpu_teardown():
> 
> Don't repeat broken patterns please.
> 
>> yangyicong@ubuntu:~/mainline_linux/linux/drivers$ grep -rn WARN_ON ./ | grep irq_set_affinity
>> ./perf/arm_smmuv3_pmu.c:649:    WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(target)));
>> ./perf/arm_smmuv3_pmu.c:895:    WARN_ON(irq_set_affinity(smmu_pmu->irq, cpumask_of(smmu_pmu->on_cpu)));
>> ./perf/arm-ccn.c:1214:          WARN_ON(irq_set_affinity(ccn->irq, cpumask_of(dt->cpu)));
>> ./perf/qcom_l2_pmu.c:796:       WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(cpu)));
>> ./perf/qcom_l2_pmu.c:834:       WARN_ON(irq_set_affinity(cluster->irq, cpumask_of(target)));
>> ./perf/arm_dmc620_pmu.c:624:    WARN_ON(irq_set_affinity(irq->irq_num, cpumask_of(target)));
>> ./perf/fsl_imx8_ddr_perf.c:674: WARN_ON(irq_set_affinity(pmu->irq, cpumask_of(pmu->cpu)));
>> ./perf/xgene_pmu.c:1793:        WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
>> ./perf/xgene_pmu.c:1826:        WARN_ON(irq_set_affinity(xgene_pmu->irq, &xgene_pmu->cpu));
>> ./perf/hisilicon/hisi_pcie_pmu.c:658:           WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(cpu)));
>> ./perf/hisilicon/hisi_pcie_pmu.c:684:   WARN_ON(irq_set_affinity(pcie_pmu->irq, cpumask_of(target)));
>> ./perf/hisilicon/hisi_uncore_pmu.c:495: WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(cpu)));
>> ./perf/hisilicon/hisi_uncore_pmu.c:528: WARN_ON(irq_set_affinity(hisi_pmu->irq, cpumask_of(target)));
> 
> Great, you can fix all of these up as well any time :)
> 

will have a look on this.

Thanks.

