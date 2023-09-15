Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACD4C7A1F46
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 14:54:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235074AbjIOMyI (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 08:54:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235034AbjIOMyI (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 08:54:08 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id DDACE19AE;
        Fri, 15 Sep 2023 05:53:59 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 02C4E1FB;
        Fri, 15 Sep 2023 05:54:37 -0700 (PDT)
Received: from [10.1.197.1] (ewhatever.cambridge.arm.com [10.1.197.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 29E353F5A1;
        Fri, 15 Sep 2023 05:53:58 -0700 (PDT)
Message-ID: <73655f9b-9ea4-cb46-d712-20f1c4ac7c95@arm.com>
Date:   Fri, 15 Sep 2023 13:53:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH v2 5/5] hwtracing: hisi_ptt: Add dummy callback
 pmu::read()
Content-Language: en-US
To:     Yicong Yang <yangyicong@huawei.com>, mathieu.poirier@linaro.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, helgaas@kernel.org,
        linux-pci@vger.kernel.org, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com, hejunhao3@huawei.com
References: <20230914112223.27165-1-yangyicong@huawei.com>
 <20230914112223.27165-6-yangyicong@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230914112223.27165-6-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/09/2023 12:22, Yicong Yang wrote:
> From: Junhao He <hejunhao3@huawei.com>
> 
> When start trace with perf option "-C $cpu" and immediately stop it
> with SIGTERM or others, the perf core will invoke pmu::read() while
> the driver doesn't implement it. Add a dummy pmu::read() to avoid
> any issues.

What issues are we talking about here ? Shouldn't the core perf
skip the call, if pmu::read() is not available ?

Suzuki

> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/hwtracing/ptt/hisi_ptt.c | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 62a444f5228e..c1b5fd2b8974 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -1184,6 +1184,10 @@ static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
>   	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
>   }
>   
> +static void hisi_ptt_pmu_read(struct perf_event *event)
> +{
> +}
> +
>   static void hisi_ptt_remove_cpuhp_instance(void *hotplug_node)
>   {
>   	cpuhp_state_remove_instance_nocalls(hisi_ptt_pmu_online, hotplug_node);
> @@ -1227,6 +1231,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>   		.stop		= hisi_ptt_pmu_stop,
>   		.add		= hisi_ptt_pmu_add,
>   		.del		= hisi_ptt_pmu_del,
> +		.read		= hisi_ptt_pmu_read,
>   	};
>   
>   	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);

