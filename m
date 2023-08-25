Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87ADF788589
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 13:24:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231544AbjHYLXm (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjHYLXQ (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 07:23:16 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17ADF1FD7;
        Fri, 25 Aug 2023 04:23:14 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RXHbz3MlYz6HJbL;
        Fri, 25 Aug 2023 19:22:23 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 12:23:11 +0100
Date:   Fri, 25 Aug 2023 12:23:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: Re: [PATCH 1/5] hwtracing: hisi_ptt: Disable interrupt after trace
 end
Message-ID: <20230825122310.0000073f@Huawei.com>
In-Reply-To: <20230809081825.11518-2-yangyicong@huawei.com>
References: <20230809081825.11518-1-yangyicong@huawei.com>
        <20230809081825.11518-2-yangyicong@huawei.com>
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

On Wed, 9 Aug 2023 16:18:21 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> On trace end we disable the hardware but leave the interrupt
> unmasked. Mask the interrupt to make the process reverse to
> the start. No actual issue since hardware should send no
> interrupt after disabled.
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 4 ++++
>  drivers/hwtracing/ptt/hisi_ptt.h | 1 +
>  2 files changed, 5 insertions(+)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index ba081b6d2435..5f0a8e653ae8 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -183,6 +183,10 @@ static void hisi_ptt_wait_dma_reset_done(struct hisi_ptt *hisi_ptt)
>  static void hisi_ptt_trace_end(struct hisi_ptt *hisi_ptt)
>  {
>  	writel(0, hisi_ptt->iobase + HISI_PTT_TRACE_CTRL);
> +
> +	/* Mask the interrupt on the end */
> +	writel(HISI_PTT_TRACE_INT_MASK_ALL, hisi_ptt->iobase + HISI_PTT_TRACE_INT_MASK);
> +
>  	hisi_ptt->trace_ctrl.started = false;
>  }
>  
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.h b/drivers/hwtracing/ptt/hisi_ptt.h
> index e17f045d7e72..46030aa88081 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.h
> +++ b/drivers/hwtracing/ptt/hisi_ptt.h
> @@ -47,6 +47,7 @@
>  #define HISI_PTT_TRACE_INT_STAT		0x0890
>  #define   HISI_PTT_TRACE_INT_STAT_MASK	GENMASK(3, 0)
>  #define HISI_PTT_TRACE_INT_MASK		0x0894
> +#define   HISI_PTT_TRACE_INT_MASK_ALL	GENMASK(3, 0)
>  #define HISI_PTT_TUNING_INT_STAT	0x0898
>  #define   HISI_PTT_TUNING_INT_STAT_MASK	BIT(0)
>  #define HISI_PTT_TRACE_WR_STS		0x08a0

