Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B30D723F1A
	for <lists+linux-pci@lfdr.de>; Tue,  6 Jun 2023 12:17:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232303AbjFFKR2 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 6 Jun 2023 06:17:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230013AbjFFKR1 (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 6 Jun 2023 06:17:27 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4049FEA;
        Tue,  6 Jun 2023 03:17:26 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.226])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4Qb5xb5bzMz6J7K1;
        Tue,  6 Jun 2023 18:17:07 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.23; Tue, 6 Jun
 2023 11:17:24 +0100
Date:   Tue, 6 Jun 2023 11:17:23 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH v3 4/4] hwtracing: hisi_ptt: Advertise
 PERF_PMU_CAP_NO_EXCLUDE for PTT PMU
Message-ID: <20230606111723.000022d9@Huawei.com>
In-Reply-To: <20230523093228.48149-5-yangyicong@huawei.com>
References: <20230523093228.48149-1-yangyicong@huawei.com>
        <20230523093228.48149-5-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100002.china.huawei.com (7.191.160.241) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, 23 May 2023 17:32:28 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> The PTT trace collects PCIe TLP headers from the PCIe link and don't
> have the ability to exclude certain context. It doesn't support itrace
> as well. So only advertise PERF_PMU_CAP_NO_EXCLUDE. This will greatly
> save the storage of final data. Tested tracing idle link for ~15s,
> without this patch we'll collect ~28.682MB data for context related
> information and with this patch it reduced to ~0.226MB.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
Interesting - I didn't know about this flag.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 65f4288a1915..b9917db849bf 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -1210,7 +1210,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>  
>  	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>  		.module		= THIS_MODULE,
> -		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  		.task_ctx_nr	= perf_sw_context,
>  		.attr_groups	= hisi_ptt_pmu_groups,
>  		.event_init	= hisi_ptt_pmu_event_init,

