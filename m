Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D27C788593
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 13:26:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238894AbjHYLZv (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 07:25:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbjHYLZV (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 07:25:21 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2D231FEC;
        Fri, 25 Aug 2023 04:25:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RXHZ53vkKz6K6C2;
        Fri, 25 Aug 2023 19:20:45 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 12:25:16 +0100
Date:   Fri, 25 Aug 2023 12:25:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: Re: [PATCH 4/5] hwtracing: hisi_ptt: Don't try to attach a task
Message-ID: <20230825122516.000053d8@Huawei.com>
In-Reply-To: <20230809081825.11518-5-yangyicong@huawei.com>
References: <20230809081825.11518-1-yangyicong@huawei.com>
        <20230809081825.11518-5-yangyicong@huawei.com>
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

On Wed, 9 Aug 2023 16:18:24 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> PTT is an uncore PMU and shouldn't be attached to any task. Block
> the usage in pmu::event_init().
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 3aba7bb6e548..916686c6a9c8 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -1003,6 +1003,9 @@ static int hisi_ptt_pmu_event_init(struct perf_event *event)
>  		return -EOPNOTSUPP;
>  	}
>  
> +	if (event->attach_state & PERF_ATTACH_TASK)
> +		return -EOPNOTSUPP;
> +
>  	if (event->attr.type != hisi_ptt->hisi_ptt_pmu.type)
>  		return -ENOENT;
>  

