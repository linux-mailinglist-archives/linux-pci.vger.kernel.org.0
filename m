Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32075788590
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 13:25:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230170AbjHYLZS (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 07:25:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238894AbjHYLZB (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 07:25:01 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74DA21FD7;
        Fri, 25 Aug 2023 04:24:59 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RXHYj6wy3z67QxM;
        Fri, 25 Aug 2023 19:20:25 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 12:24:57 +0100
Date:   Fri, 25 Aug 2023 12:24:56 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: Re: [PATCH 3/5] hwtracing: hisi_ptt: Optimize the trace data
 committing
Message-ID: <20230825122456.00002e3f@Huawei.com>
In-Reply-To: <20230809081825.11518-4-yangyicong@huawei.com>
References: <20230809081825.11518-1-yangyicong@huawei.com>
        <20230809081825.11518-4-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,
        RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, 9 Aug 2023 16:18:23 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

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
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 15 +++++++--------
>  1 file changed, 7 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 89638ed96cf9..3aba7bb6e548 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -274,15 +274,14 @@ static int hisi_ptt_update_aux(struct hisi_ptt *hisi_ptt, int index, bool stop)
>  	buf->pos += size;
>  
>  	/*
> -	 * Just commit the traced data if we're going to stop. Otherwise if the
> -	 * resident AUX buffer cannot contain the data of next trace buffer,
> -	 * apply a new one.
> +	 * Always commit the data to the AUX buffer in time to make sure
> +	 * userspace got enough time to consume the data.
> +	 *
> +	 * If we're not going to stop, apply a new one and check whether
> +	 * there's enough room for the next trace.
>  	 */
> -	if (stop) {
> -		perf_aux_output_end(handle, buf->pos);
> -	} else if (buf->length - buf->pos < HISI_PTT_TRACE_BUF_SIZE) {
> -		perf_aux_output_end(handle, buf->pos);
> -
> +	perf_aux_output_end(handle, size);
> +	if (!stop) {
>  		buf = perf_aux_output_begin(handle, event);
>  		if (!buf)
>  			return -EINVAL;

