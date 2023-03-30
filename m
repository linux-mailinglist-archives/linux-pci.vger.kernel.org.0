Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CD1A6CF9BA
	for <lists+linux-pci@lfdr.de>; Thu, 30 Mar 2023 05:53:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229661AbjC3DxU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Mar 2023 23:53:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbjC3DxS (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 29 Mar 2023 23:53:18 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B80B4C15;
        Wed, 29 Mar 2023 20:53:17 -0700 (PDT)
Received: from canpemm500009.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4Pn8dT2LXCzKqdc;
        Thu, 30 Mar 2023 11:52:45 +0800 (CST)
Received: from [10.67.102.169] (10.67.102.169) by
 canpemm500009.china.huawei.com (7.192.105.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.21; Thu, 30 Mar 2023 11:53:15 +0800
CC:     <yangyicong@hisilicon.com>, <mathieu.poirier@linaro.org>,
        <suzuki.poulose@arm.com>, <corbet@lwn.net>,
        <linux-kernel@vger.kernel.org>, <linux-doc@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@huawei.com>,
        <linuxarm@huawei.com>
Subject: Re: [PATCH 1/4] hwtracing: hisi_ptt: Make cpumask only present online
 CPUs
To:     Jonathan Cameron <Jonathan.Cameron@Huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
 <20230315094316.26772-2-yangyicong@huawei.com>
 <20230328172409.000021f5@Huawei.com>
From:   Yicong Yang <yangyicong@huawei.com>
Message-ID: <94e7d85a-d580-94c5-ae2c-fe6a77c21487@huawei.com>
Date:   Thu, 30 Mar 2023 11:53:14 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.5.1
MIME-Version: 1.0
In-Reply-To: <20230328172409.000021f5@Huawei.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.67.102.169]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
 canpemm500009.china.huawei.com (7.192.105.203)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2023/3/29 0:24, Jonathan Cameron wrote:
> On Wed, 15 Mar 2023 17:43:13 +0800
> Yicong Yang <yangyicong@huawei.com> wrote:
> 
>> From: Yicong Yang <yangyicong@hisilicon.com>
>>
>> perf will try to start PTT trace on every CPU presented in cpumask sysfs
>> attribute and it will fail to start on offline CPUs(see the comments in
>> perf_event_open()). But the driver is using cpumask_of_node() to export
>> the available cpumask which may include offline CPUs and may fail the
>> perf unintendedly. Fix this by only export the online CPUs of the node.
> 
> There isn't clear documentation that I can find for cpumask_of_node()
> and chasing through on arm64 (which is what we care about for this driver)
> it's maintained via numa_add_cpu() numa_remove_cpu()
> Those are called in arch/arm64/kernel/smp.c in locations that are closely coupled
> with set_cpu_online(cpu, XXX);
> https://elixir.bootlin.com/linux/v6.3-rc4/source/arch/arm64/kernel/smp.c#L246
> https://elixir.bootlin.com/linux/v6.3-rc4/source/arch/arm64/kernel/smp.c#L303
> 
> Now there are races when the two might not be in sync but in this case
> we are just exposing the result to userspace, so chances of a race
> after this sysfs attribute has been read seems much higher to me and
> I don't think we can do anything about that.
> 
> Is there another path that I'm missing where online and node masks are out
> of sync?
> 

maybe no. This patch maybe incorrect and I need more investigation, so let's me
drop it from the series. Tested and everything seems fine now.

I found this problem and referred to commit 064f0e9302af ("mm: only display online cpus of the numa node")
which might be the same problem. But seems unnecessary that cpumask_of_node()
already include online CPUs only.

Thanks.

> Jonathan
> 
> 
>>
>> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
>> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> 
>> ---
>>  drivers/hwtracing/ptt/hisi_ptt.c | 13 +++++++++++--
>>  1 file changed, 11 insertions(+), 2 deletions(-)
>>
>> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
>> index 30f1525639b5..0a10c7ec46ad 100644
>> --- a/drivers/hwtracing/ptt/hisi_ptt.c
>> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
>> @@ -487,9 +487,18 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>>  			    char *buf)
>>  {
>>  	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
>> -	const cpumask_t *cpumask = cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev));
>> +	cpumask_var_t mask;
>> +	ssize_t n;
>>  
>> -	return cpumap_print_to_pagebuf(true, buf, cpumask);
>> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
>> +		return 0;
>> +
>> +	cpumask_and(mask, cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)),
>> +		    cpu_online_mask);
>> +	n = cpumap_print_to_pagebuf(true, buf, mask);
>> +	free_cpumask_var(mask);
>> +
>> +	return n;
>>  }
>>  static DEVICE_ATTR_RO(cpumask);
>>  
> 
> .
> 
