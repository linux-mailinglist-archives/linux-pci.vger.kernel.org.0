Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 2076FAA46D
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 15:27:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726008AbfIEN1I (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 09:27:08 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:6226 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726619AbfIEN1H (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 09:27:07 -0400
Received: from DGGEMS414-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 9C0502EBBF44F5BF49AC;
        Thu,  5 Sep 2019 21:27:05 +0800 (CST)
Received: from [127.0.0.1] (10.202.227.238) by DGGEMS414-HUB.china.huawei.com
 (10.3.19.214) with Microsoft SMTP Server id 14.3.439.0; Thu, 5 Sep 2019
 21:26:59 +0800
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     Marc Zyngier <maz@kernel.org>,
        Andrew Murray <andrew.murray@arm.com>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
 <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
 <20190904102537.GV9720@e119886-lin.cambridge.arm.com>
 <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
 <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
 <651b4d5f-2d86-65dc-1232-580445852752@kernel.org>
 <8ac8e372-15a0-2f95-089c-c189b619ea62@huawei.com>
 <73c22eaa-172e-0fba-7a44-381106dee50d@kernel.org>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
From:   John Garry <john.garry@huawei.com>
Message-ID: <a73262e6-6ece-4946-896b-2dad5ca28417@huawei.com>
Date:   Thu, 5 Sep 2019 14:26:54 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:45.0) Gecko/20100101
 Thunderbird/45.3.0
MIME-Version: 1.0
In-Reply-To: <73c22eaa-172e-0fba-7a44-381106dee50d@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.238]
X-CFilter-Loop: Reflected
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/09/2019 12:22, Marc Zyngier wrote:
> OK, debug was slightly off, but it is interesting that the driver didn't
> unmap the device, either because it is flagged as shared (with what?) or
> that additional interrupts are allocated in the lpi_map for this
> instance.
>
> Here's an updated debug patch. Can you please run the same thing again?
>

As requested:

root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind

<snip>

[   78.593897] Freed devid 7410 event 0 LPI 0
[   78.597990] Freed devid 7410 event 1 LPI 0
[   78.602080] Freed devid 7410 event 2 LPI 0
[   78.606169] Freed devid 7410 event 3 LPI 0
[   78.610253] Freed devid 7410 event 4 LPI 0
[   78.614337] Freed devid 7410 event 5 LPI 0
[   78.618422] Freed devid 7410 event 6 LPI 0
[   78.622506] Freed devid 7410 event 7 LPI 0
[   78.626590] Freed devid 7410 event 8 LPI 0
[   78.630674] Freed devid 7410 event 9 LPI 0
[   78.634758] Freed devid 7410 event 10 LPI 0
[   78.638930] Freed devid 7410 event 11 LPI 0
[   78.643101] Freed devid 7410 event 12 LPI 0
[   78.647272] Freed devid 7410 event 13 LPI 0
[   78.651445] Freed devid 7410 event 14 LPI 0
[   78.655616] Freed devid 7410 event 15 LPI 0
[   78.659787] Freed devid 7410 event 16 LPI 0
[   78.663959] Unmap devid 7410 shared 0 lpi_map 17-31
root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
[   86.074545] scsi host0: hisi_sas_v3_hw
[   87.299141] Reusing ITT for devID 7410
[   87.322337] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
sh: echo: write error: No such device
root@(none)$


And here's a working log (without specifying nr_cpus=1), just for reference:

root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind

<snip>

[   28.412419] Freed devid 7410 event 0 LPI 0
[   28.416505] Freed devid 7410 event 1 LPI 0
[   28.420590] Freed devid 7410 event 2 LPI 0
[   28.424674] Freed devid 7410 event 3 LPI 0
[   28.428759] Freed devid 7410 event 4 LPI 0
[   28.432844] Freed devid 7410 event 5 LPI 0
[   28.436929] Freed devid 7410 event 6 LPI 0
[   28.441013] Freed devid 7410 event 7 LPI 0
[   28.445099] Freed devid 7410 event 8 LPI 0
[   28.449183] Freed devid 7410 event 9 LPI 0
[   28.453268] Freed devid 7410 event 10 LPI 0
[   28.457439] Freed devid 7410 event 11 LPI 0
[   28.461611] Freed devid 7410 event 12 LPI 0
[   28.465782] Freed devid 7410 event 13 LPI 0
[   28.469954] Freed devid 7410 event 14 LPI 0
[   28.474126] Freed devid 7410 event 15 LPI 0
[   28.478298] Freed devid 7410 event 16 LPI 0
[   28.482469] Freed devid 7410 event 17 LPI 0
[   28.486641] Freed devid 7410 event 18 LPI 0
[   28.490812] Freed devid 7410 event 19 LPI 0
[   28.494984] Freed devid 7410 event 20 LPI 0
[   28.499155] Freed devid 7410 event 21 LPI 0
[   28.503327] Freed devid 7410 event 22 LPI 0
[   28.507498] Freed devid 7410 event 23 LPI 0
[   28.511670] Freed devid 7410 event 24 LPI 0
[   28.515842] Freed devid 7410 event 25 LPI 0
[   28.520017] Freed devid 7410 event 26 LPI 0
[   28.524189] Freed devid 7410 event 27 LPI 0
[   28.528360] Freed devid 7410 event 28 LPI 0
[   28.532531] Freed devid 7410 event 29 LPI 0
[   28.536703] Freed devid 7410 event 30 LPI 0
[   28.540874] Freed devid 7410 event 31 LPI 0
[   28.545047] Unmap devid 7410 shared 0 lpi_map
[   28.552084] Unmap devid 7410
root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
[   34.900373] scsi host0: hisi_sas_v3_hw
[   36.112726] ITS: alloc 9920:32
[   36.115771] ITT 32 entries, 5 bits
[   36.119442] ID:0 pID:9920 vID:23
[   36.122661] ID:1 pID:9921 vID:24
[   36.125878] ID:2 pID:9922 vID:25
[   36.129095] ID:3 pID:9923 vID:26
[   36.132309] ID:4 pID:9924 vID:27
[   36.135526] ID:5 pID:9925 vID:28
[   36.138742] ID:6 pID:9926 vID:29
[   36.141959] ID:7 pID:9927 vID:30
[   36.145175] ID:8 pID:9928 vID:31
[   36.148390] ID:9 pID:9929 vID:32
[   36.151606] ID:10 pID:9930 vID:33
[   36.154910] ID:11 pID:9931 vID:34
[   36.158214] ID:12 pID:9932 vID:35
[   36.161517] ID:13 pID:9933 vID:36
[   36.164820] ID:14 pID:9934 vID:37
[   36.168121] ID:15 pID:9935 vID:38
[   36.171424] ID:16 pID:9936 vID:39
[   36.174727] ID:17 pID:9937 vID:40
[   36.178031] ID:18 pID:9938 vID:41
[   36.181334] ID:19 pID:9939 vID:42
[   36.184636] ID:20 pID:9940 vID:43
[   36.187939] ID:21 pID:9941 vID:44
[   36.191242] ID:22 pID:9942 vID:45
[   36.194545] ID:23 pID:9943 vID:46
[   36.197848] ID:24 pID:9944 vID:47
[   36.201152] ID:25 pID:9945 vID:48
[   36.204453] ID:26 pID:9946 vID:49
[   36.207756] ID:27 pID:9947 vID:50
[   36.211060] ID:28 pID:9948 vID:51
[   36.214363] ID:29 pID:9949 vID:52
[   36.217667] ID:30 pID:9950 vID:53
[   36.220970] ID:31 pID:9951 vID:54

<snip>


Cheers,
John

> Thanks,
>
> 	M.
>
> diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
> index 1b5c3672aea2..07375171900a 100644
> --- a/drivers/irqchip/irq-gic-v3-its.c
> +++ b/drivers/irqchip/irq-gic-v3-its.c
> @@ -3,7 +3,7 @@
>   * Copyright (C) 2013-2017 ARM Limited, All Rights Reserved.
>   * Author: Marc Zyngier <marc.zyngier@arm.com>
>   */
> -
> +#define DEBUG 1
>  #include <linux/acpi.h>
>  #include <linux/acpi_iort.h>
>  #include <linux/bitmap.h>
> @@ -2649,6 +2649,8 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  		/* Mark interrupt index as unused */
>  		clear_bit(event, its_dev->event_map.lpi_map);
>
> +		pr_debug("Freed devid %x event %d LPI %ld\n", its_dev->device_id, event, data->hwirq);
> +
>  		/* Nuke the entry in the domain */
>  		irq_domain_reset_irq_data(data);
>  	}
> @@ -2659,6 +2661,9 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  	 * If all interrupts have been freed, start mopping the
>  	 * floor. This is conditionned on the device not being shared.
>  	 */
> +	pr_debug("Unmap devid %x shared %d lpi_map %*pbl\n",
> +		 its_dev->device_id, its_dev->shared,
> +		 its_dev->event_map.nr_lpis, its_dev->event_map.lpi_map);
>  	if (!its_dev->shared &&
>  	    bitmap_empty(its_dev->event_map.lpi_map,
>  			 its_dev->event_map.nr_lpis)) {
> @@ -2667,6 +2672,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
>  			     its_dev->event_map.nr_lpis);
>  		kfree(its_dev->event_map.col_map);
>
> +		pr_debug("Unmap devid %x\n", its_dev->device_id);
>  		/* Unmap device/itt */
>  		its_send_mapd(its_dev, 0);
>  		its_free_device(its_dev);


