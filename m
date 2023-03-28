Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BA5A6CC88F
	for <lists+linux-pci@lfdr.de>; Tue, 28 Mar 2023 18:53:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjC1QxV (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 28 Mar 2023 12:53:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjC1QxU (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Tue, 28 Mar 2023 12:53:20 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80416AF10;
        Tue, 28 Mar 2023 09:53:19 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4PmG2K3Q6kz6J7vt;
        Wed, 29 Mar 2023 00:52:41 +0800 (CST)
Received: from localhost (10.195.244.179) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 28 Mar
 2023 17:53:17 +0100
Date:   Tue, 28 Mar 2023 17:53:16 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <mathieu.poirier@linaro.org>, <suzuki.poulose@arm.com>,
        <corbet@lwn.net>, <linux-kernel@vger.kernel.org>,
        <linux-doc@vger.kernel.org>, <alexander.shishkin@linux.intel.com>,
        <helgaas@kernel.org>, <linux-pci@vger.kernel.org>,
        <prime.zeng@huawei.com>, <linuxarm@huawei.com>
Subject: Re: [PATCH 4/4] hwtracing: hisi_ptt: Advertise
 PERF_PMU_CAP_NO_EXCLUDE for PTT PMU
Message-ID: <20230328175316.00004a30@Huawei.com>
In-Reply-To: <20230315094316.26772-5-yangyicong@huawei.com>
References: <20230315094316.26772-1-yangyicong@huawei.com>
        <20230315094316.26772-5-yangyicong@huawei.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.195.244.179]
X-ClientProxiedBy: lhrpeml100003.china.huawei.com (7.191.160.210) To
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

On Wed, 15 Mar 2023 17:43:16 +0800
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

Seems reasonable.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index a5cd87edb813..8c1cce32b83f 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -1216,7 +1216,7 @@ static int hisi_ptt_register_pmu(struct hisi_ptt *hisi_ptt)
>  
>  	hisi_ptt->hisi_ptt_pmu = (struct pmu) {
>  		.module		= THIS_MODULE,
> -		.capabilities	= PERF_PMU_CAP_EXCLUSIVE | PERF_PMU_CAP_ITRACE,
> +		.capabilities	= PERF_PMU_CAP_NO_EXCLUDE,
>  		.task_ctx_nr	= perf_sw_context,
>  		.attr_groups	= hisi_ptt_pmu_groups,
>  		.event_init	= hisi_ptt_pmu_event_init,

