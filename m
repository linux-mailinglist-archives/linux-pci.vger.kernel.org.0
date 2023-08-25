Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFD3B788598
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 13:26:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240609AbjHYL0X (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 07:26:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46984 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242332AbjHYLZ5 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 07:25:57 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D0F71FDE;
        Fri, 25 Aug 2023 04:25:55 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.206])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RXHb918W4z6J7jj;
        Fri, 25 Aug 2023 19:21:41 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 12:25:53 +0100
Date:   Fri, 25 Aug 2023 12:25:52 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: Re: [PATCH 5/5] hwtracing: hisi_ptt: Add dummy callback pmu::read()
Message-ID: <20230825122552.000033ce@Huawei.com>
In-Reply-To: <20230809081825.11518-6-yangyicong@huawei.com>
References: <20230809081825.11518-1-yangyicong@huawei.com>
        <20230809081825.11518-6-yangyicong@huawei.com>
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

On Wed, 9 Aug 2023 16:18:25 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Junhao He <hejunhao3@huawei.com>
> 
> When start trace with perf option "-C $cpu" and immediately stop it
> with SIGTERM or others, the perf core will invoke pmu::read() while
> the driver doesn't implement it. Add a dummy pmu::read() to avoid
> any issues.
> 
> Signed-off-by: Junhao He <hejunhao3@huawei.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 916686c6a9c8..7392e039b8c1 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -1184,6 +1184,10 @@ static void hisi_ptt_pmu_del(struct perf_event *event, int flags)
>  	hisi_ptt_pmu_stop(event, PERF_EF_UPDATE);
>  }
>  
> +static void hisi_ptt_pmu_read(struct perf_event *event)
> +{
> +}
> +
>  static void hisi_ptt_remove_cpuhp_instance(void *hotplug_node)
>  {
>  	cpuhp_state_remove_instance_nocalls(hisi_ptt_pmu_online, hotplug_node);
> @@ -1227,6 +1231,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>  		.stop		= hisi_ptt_pmu_stop,
>  		.add		= hisi_ptt_pmu_add,
>  		.del		= hisi_ptt_pmu_del,
> +		.read		= hisi_ptt_pmu_read,
>  	};
>  
>  	reg = readl(hisi_ptt->iobase + HISI_PTT_LOCATION);

