Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D2AB6CC7D3
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 18:24:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230119AbjC1QYR (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 12:24:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1QYQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 12:24:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7A19A5D1;
        Tue, 28 Mar 2023 09:24:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PmFMb6p3kz6J7gX;
        Wed, 29 Mar 2023 00:22:35 +0800 (CST)
Received: from localhost (10.195.244.179) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Mar
 2023 17:24:10 +0100
Date:   Tue, 28 Mar 2023 17:24:09 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 1/4] hwtracing: hisi_ptt: Make cpumask only present
 online CPUs
Message-ID: <20230328172409.000021f5@Huawei.com>
In-Reply-To: <20230315094316.26772-2-yangyicong@huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
        <20230315094316.26772-2-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.179]
X-ClientProxiedBy: lhrpeml500004.china.huawei.com (7.191.163.9) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 15 Mar 2023 17:43:13 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> perf will try to start PTT trace on every CPU presented in cpumask sysfs
> attribute and it will fail to start on offline CPUs(see the comments in
> perf_event_open()). But the driver is using cpumask_of_node() to export
> the available cpumask which may include offline CPUs and may fail the
> perf unintendedly. Fix this by only export the online CPUs of the node.

There isn't clear documentation that I can find for cpumask_of_node()
and chasing through on arm64 (which is what we care about for this driver)
it's maintained via numa_add_cpu() numa_remove_cpu()
Those are called in arch/arm64/kernel/smp.c in locations that are closely coupled
with set_cpu_online(cpu, XXX);
https://elixir.bootlin.com/linux/v6.3-rc4/source/arch/arm64/kernel/smp.c#L246
https://elixir.bootlin.com/linux/v6.3-rc4/source/arch/arm64/kernel/smp.c#L303

Now there are races when the two might not be in sync but in this case
we are just exposing the result to userspace, so chances of a race
after this sysfs attribute has been read seems much higher to me and
I don't think we can do anything about that.

Is there another path that I'm missing where online and node masks are out
of sync?

Jonathan


> 
> Fixes: ff0de066b463 ("hwtracing: hisi_ptt: Add trace function support for HiSilicon PCIe Tune and Trace device")
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 13 +++++++++++--
>  1 file changed, 11 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 30f1525639b5..0a10c7ec46ad 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -487,9 +487,18 @@ static ssize_t cpumask_show(struct device *dev, struct device_attribute *attr,
>  			    char *buf)
>  {
>  	struct hisi_ptt *hisi_ptt = to_hisi_ptt(dev_get_drvdata(dev));
> -	const cpumask_t *cpumask = cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev));
> +	cpumask_var_t mask;
> +	ssize_t n;
>  
> -	return cpumap_print_to_pagebuf(true, buf, cpumask);
> +	if (!alloc_cpumask_var(&mask, GFP_KERNEL))
> +		return 0;
> +
> +	cpumask_and(mask, cpumask_of_node(dev_to_node(&hisi_ptt->pdev->dev)),
> +		    cpu_online_mask);
> +	n = cpumap_print_to_pagebuf(true, buf, mask);
> +	free_cpumask_var(mask);
> +
> +	return n;
>  }
>  static DEVICE_ATTR_RO(cpumask);
>  

