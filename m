Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78E9B7A2144
	for <lists+linux-pci@lfdr.de>; Fri, 15 Sep 2023 16:44:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235795AbjIOOow (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 15 Sep 2023 10:44:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235789AbjIOOow (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 15 Sep 2023 10:44:52 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 295161BC7;
        Fri, 15 Sep 2023 07:44:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4B96E1FB;
        Fri, 15 Sep 2023 07:45:24 -0700 (PDT)
Received: from [10.57.94.184] (unknown [10.57.94.184])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4F4253F738;
        Fri, 15 Sep 2023 07:44:45 -0700 (PDT)
Message-ID: <03da788f-584b-1be5-2cc3-70a9e57c11ba@arm.com>
Date:   Fri, 15 Sep 2023 15:44:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.15.0
Subject: Re: [PATCH v2 3/5] hwtracing: hisi_ptt: Optimize the trace data
 committing
To:     Yicong Yang <yangyicong@huawei.com>, mathieu.poirier@linaro.org,
        jonathan.cameron@huawei.com, linux-kernel@vger.kernel.org
Cc:     alexander.shishkin@linux.intel.com, helgaas@kernel.org,
        linux-pci@vger.kernel.org, prime.zeng@hisilicon.com,
        linuxarm@huawei.com, yangyicong@hisilicon.com, hejunhao3@huawei.com
References: <20230914112223.27165-1-yangyicong@huawei.com>
 <20230914112223.27165-4-yangyicong@huawei.com>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
In-Reply-To: <20230914112223.27165-4-yangyicong@huawei.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 14/09/2023 12:22, Yicong Yang wrote:
> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Currently during the PTT trace, we'll only commit the data
> to the perf core when its full, which means after 4 interrupts
> and totally 16MiB data while the AUX buffer is 16MiB length.
> Then the userspace gets notified and handle the data. The driver
> cannot apply a new AUX buffer immediately until the committed data
> are handled and there's enough room in the buffer again.
> 
> This patch tries to optimize this by commit the data in every
> interrupts in a 4MiB granularity. Then the userspace can have
> enough time to consume the data and there's always enough room
> in the AUX buffer.

Instead of always committing at 4M, could we not use the existing
markers used by the handle->wakeup to decide if we should commit it ?


Suzuki

> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> ---
>   drivers/hwtracing/ptt/hisi_ptt.c | 15 +++++++--------
>   1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 3041238a6e54..4f355df8da23 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -274,15 +274,14 @@ static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
>   	buf->pos += size;
>   
>   	/*
> -	 * Just commit the traced data if we're going to stop. Otherwise if the
> -	 * resident AUX buffer cannot contain the data of next trace buffer,
> -	 * apply a new one.
> +	 * Always commit the data to the AUX buffer in time to make sure
> +	 * userspace got enough time to consume the data.
> +	 *
> +	 * If we're not going to stop, apply a new one and check whether
> +	 * there's enough room for the next trace.
>   	 */
> -	if (stop) {
> -		perf_aux_output_end(handle, buf->pos);
> -	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
> -		perf_aux_output_end(handle, buf->pos);
> -
> +	perf_aux_output_end(handle, size);
> +	if (!stop) {
>   		buf = perf_aux_output_begin(handle, event);
>   		if (!buf)
>   			return -EINVAL;

