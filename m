Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA88F3436B9
	for <lists+linux-pci@lfdr.de>; Mon, 22 Mar 2021 03:44:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229786AbhCVCn6 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 21 Mar 2021 22:43:58 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:14119 "EHLO
        szxga04-in.huawei.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229613AbhCVCnt (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 21 Mar 2021 22:43:49 -0400
Received: from DGGEMS413-HUB.china.huawei.com (unknown [172.30.72.60])
        by szxga04-in.huawei.com (SkyGuard) with ESMTP id 4F3f0G3krZz19Gm7;
        Mon, 22 Mar 2021 10:41:50 +0800 (CST)
Received: from [10.174.177.87] (10.174.177.87) by
 DGGEMS413-HUB.china.huawei.com (10.3.19.213) with Microsoft SMTP Server id
 14.3.498.0; Mon, 22 Mar 2021 10:43:37 +0800
Subject: Re: [PATCH] pci: fix memory leak when virtio pci hotplug
To:     Zhiqiang Liu <liuzhiqiang26@huawei.com>, <rjw@rjwysocki.net>,
        <lenb@kernel.org>, <bhelgaas@google.com>
CC:     <linux-acpi@vger.kernel.org>, <linux-pci@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, linfeilong <linfeilong@huawei.com>
References: <c48998b7-5308-e196-66b5-905fc8c4edc4@huawei.com>
From:   Wu Bo <wubo40@huawei.com>
Message-ID: <768d4a60-7442-fbdd-9c00-cc927a54d340@huawei.com>
Date:   Mon, 22 Mar 2021 10:43:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:78.0) Gecko/20100101
 Thunderbird/78.2.2
MIME-Version: 1.0
In-Reply-To: <c48998b7-5308-e196-66b5-905fc8c4edc4@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.177.87]
X-CFilter-Loop: Reflected
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 2021/3/21 23:29, Zhiqiang Liu wrote:
> From: Feilong Lin <linfeilong@huawei.com>
> 
> Repeated hot-plugging of pci devices for a virtual
> machine driven by virtio, we found that there is a
> leak in kmalloc-4k, which was confirmed as the memory
> of the pci_device structure. Then we found out that
> it was missing pci_dev_put() after pci_get_slot() in
> enable_slot() of acpiphp_glue.c.
> 
> Signed-off-by: Feilong Lin <linfeilong@huawei.com>
> Reviewed-by: Zhiqiang Liu <liuzhiqiang26@huawei.com>
> ---
>   drivers/pci/hotplug/acpiphp_glue.c | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/pci/hotplug/acpiphp_glue.c b/drivers/pci/hotplug/acpiphp_glue.c
> index 3365c93abf0e..f031302ad401 100644
> --- a/drivers/pci/hotplug/acpiphp_glue.c
> +++ b/drivers/pci/hotplug/acpiphp_glue.c
> @@ -533,6 +533,7 @@ static void enable_slot(struct acpiphp_slot *slot, bool bridge)
>   			slot->flags &= ~SLOT_ENABLED;
>   			continue;
>   		}
> +		pci_dev_put(dev);
>   	}
>   }
> 
Reviewed-by: Wu Bo <wubo40@huawei.com>
