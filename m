Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 729D478858D
	for <lists+linux-pci@lfdr.de>; Fri, 25 Aug 2023 13:25:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232513AbjHYLYq (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 25 Aug 2023 07:24:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230170AbjHYLYP (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 25 Aug 2023 07:24:15 -0400
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B0D71FD7;
        Fri, 25 Aug 2023 04:24:13 -0700 (PDT)
Received: from lhrpeml500005.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4RXHXq5Skhz6K6Bd;
        Fri, 25 Aug 2023 19:19:39 +0800 (CST)
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.31; Fri, 25 Aug
 2023 12:24:11 +0100
Date:   Fri, 25 Aug 2023 12:24:10 +0100
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <suzuki.poulose@arm.com>, <mathieu.poirier@linaro.org>,
        <linux-kernel@vger.kernel.org>,
        <alexander.shishkin@linux.intel.com>, <helgaas@kernel.org>,
        <linux-pci@vger.kernel.org>, <prime.zeng@hisilicon.com>,
        <linuxarm@huawei.com>, <yangyicong@hisilicon.com>,
        <hejunhao3@huawei.com>
Subject: Re: [PATCH 2/5] hwtracing: hisi_ptt: Handle the interrupt in
 hardirq context
Message-ID: <20230825122410.00004d6b@Huawei.com>
In-Reply-To: <20230809081825.11518-3-yangyicong@huawei.com>
References: <20230809081825.11518-1-yangyicong@huawei.com>
        <20230809081825.11518-3-yangyicong@huawei.com>
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

On Wed, 9 Aug 2023 16:18:22 +0800
Yicong Yang <yangyicong@huawei.com> wrote:

> From: Yicong Yang <yangyicong@hisilicon.com>
> 
> Handle the trace interrupt in the hardirq context, make sure the irq
> core won't threaded it by declaring IRQF_NO_THREAD and userspace won't
> balance it by declaring IRQF_NOBALANCING. Otherwise we may violate the
> synchronization requirements of the perf core, referenced to the
> change of arm-ccn PMU commit 0811ef7e2f54 ("bus: arm-ccn: fix PMU interrupt flags").
> 
> In the interrupt handler we mainly doing 2 things:
> - Copy the data from the local DMA buffer to the AUX buffer
> - Commit the data in the AUX buffer
> 
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>

Acked-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/hwtracing/ptt/hisi_ptt.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/hwtracing/ptt/hisi_ptt.c b/drivers/hwtracing/ptt/hisi_ptt.c
> index 5f0a8e653ae8..89638ed96cf9 100644
> --- a/drivers/hwtracing/ptt/hisi_ptt.c
> +++ b/drivers/hwtracing/ptt/hisi_ptt.c
> @@ -346,9 +346,9 @@ static int hisi_ptt_register_irq(struct hisi_ptt *hisi_ptt)
>  		return ret;
>  
>  	hisi_ptt->trace_irq = pci_irq_vector(pdev, HISI_PTT_TRACE_DMA_IRQ);
> -	ret = devm_request_threaded_irq(&pdev->dev, hisi_ptt->trace_irq,
> -					NULL, hisi_ptt_isr, 0,
> -					DRV_NAME, hisi_ptt);
> +	ret = devm_request_irq(&pdev->dev, hisi_ptt->trace_irq, hisi_ptt_isr,
> +				IRQF_NOBALANCING | IRQF_NO_THREAD, DRV_NAME,
> +				hisi_ptt);
>  	if (ret) {
>  		pci_err(pdev, "failed to request irq %d, ret = %d\n",
>  			hisi_ptt->trace_irq, ret);

