Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id E73C0AA135
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 13:23:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388350AbfIELWz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 07:22:55 -0400
Received: from foss.arm.com ([217.140.110.172]:42526 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2388335AbfIELWz (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 07:22:55 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5A4A628;
        Thu,  5 Sep 2019 04:22:54 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4DEA53F718;
        Thu,  5 Sep 2019 04:22:52 -0700 (PDT)
Subject: Re: PCI/kernel msi code vs GIC ITS driver conflict?
To:     John Garry <john.garry@huawei.com>,
        Andrew Murray <andrew.murray@arm.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Bjorn Helgaas <bhelgaas@google.com>,
        Linux PCI <linux-pci@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>,
        "luojiaxing@huawei.com" <luojiaxing@huawei.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <f5e948aa-e32f-3f74-ae30-31fee06c2a74@huawei.com>
 <5fd4c1cf-76c1-4054-3754-549317509310@kernel.org>
 <ef258ec7-877c-406a-3d88-80ff79b823f2@huawei.com>
 <20190904102537.GV9720@e119886-lin.cambridge.arm.com>
 <8f1c1fe6-c0d4-1805-b119-6a48a4900e6d@kernel.org>
 <84f6756f-79f2-2e46-fe44-9a46be69f99d@huawei.com>
 <651b4d5f-2d86-65dc-1232-580445852752@kernel.org>
 <8ac8e372-15a0-2f95-089c-c189b619ea62@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <73c22eaa-172e-0fba-7a44-381106dee50d@kernel.org>
Date:   Thu, 5 Sep 2019 12:22:45 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <8ac8e372-15a0-2f95-089c-c189b619ea62@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/09/2019 11:35, John Garry wrote:
>>>
>>> Hi Marc,
>>>
>>> As requested, I enabled debug for that driver and here are some kernel
>>> log snippets:
>>>
>>> [    8.435707] hisi_sas_v3_hw 0000:74:02.0: Adding to iommu group 0
>>> [    8.461467] scsi host0: hisi_sas_v3_hw
>>> [    9.683463] ITS: alloc 9920:32
>>> [    9.686509] ITT 32 entries, 5 bits
>>> [    9.690044] ID:0 pID:9920 vID:23
>>> [    9.693263] ID:1 pID:9921 vID:24
>>> [    9.696480] ID:2 pID:9922 vID:25
>>> [    9.699696] ID:3 pID:9923 vID:26
>>> [    9.702911] ID:4 pID:9924 vID:27
>>> [    9.706128] ID:5 pID:9925 vID:28
>>> [    9.709344] ID:6 pID:9926 vID:29
>>> [    9.712560] ID:7 pID:9927 vID:30
>>> [    9.715776] ID:8 pID:9928 vID:31
>>> [    9.718990] ID:9 pID:9929 vID:32
>>> [    9.722207] ID:10 pID:9930 vID:33
>>> [    9.725510] ID:11 pID:9931 vID:34
>>> [    9.728813] ID:12 pID:9932 vID:35
>>> [    9.732116] ID:13 pID:9933 vID:36
>>> [    9.735419] ID:14 pID:9934 vID:37
>>> [    9.738721] ID:15 pID:9935 vID:38
>>> [    9.742024] ID:16 pID:9936 vID:39
>>>
>>> <snip>
>>>
>>> (none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
>>>
>>> <snip>
>>>
>>> root@(none)$
>>> $ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
>>> [   41.110557] scsi host0: hisi_sas_v3_hw
>>> [   42.335455] Reusing ITT for devID 7410
>>> [   42.359151] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2
>>> sh: echo: write error: No such device
>>> root@(none)$
>>
>> Very interesting. Somehow, we think that this is a *new* device that
>> aliases with itself. Needless to say, that's unexpected. My hunch is
>> that something goes wrong when freeing the device. Can you try adding
>> the patch below and report what is happening on unbind?
>>
> 
> Hi Marc,
> 
> Here's the new snippet for unbind + bind:
> 
> (none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
> 
> <snip>
> 
> [  102.189618] Freed devid 7410 LPI 0
> [  102.193019] Freed devid 7410 LPI 0
> [  102.196420] Freed devid 7410 LPI 0
> [  102.199854] Freed devid 7410 LPI 0
> [  102.203242] Freed devid 7410 LPI 0
> [  102.206640] Freed devid 7410 LPI 0
> [  102.210036] Freed devid 7410 LPI 0
> [  102.213426] Freed devid 7410 LPI 0
> [  102.216816] Freed devid 7410 LPI 0
> [  102.220206] Freed devid 7410 LPI 0
> [  102.223596] Freed devid 7410 LPI 0
> [  102.226984] Freed devid 7410 LPI 0
> [  102.230373] Freed devid 7410 LPI 0
> [  102.233763] Freed devid 7410 LPI 0
> [  102.237152] Freed devid 7410 LPI 0
> [  102.240542] Freed devid 7410 LPI 0
> [  102.243931] Freed devid 7410 LPI 0
> root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/bind
> [  111.662451] scsi host0: hisi_sas_v3_hw
> [  112.887353] Reusing ITT for devID 7410
> [  112.911275] hisi_sas_v3_hw: probe of 0000:74:02.0 failed with error -2


OK, debug was slightly off, but it is interesting that the driver didn't 
unmap the device, either because it is flagged as shared (with what?) or 
that additional interrupts are allocated in the lpi_map for this 
instance.

Here's an updated debug patch. Can you please run the same thing again?

Thanks,

	M.

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b5c3672aea2..07375171900a 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -3,7 +3,7 @@
  * Copyright (C) 2013-2017 ARM Limited, All Rights Reserved.
  * Author: Marc Zyngier <marc.zyngier@arm.com>
  */
-
+#define DEBUG 1
 #include <linux/acpi.h>
 #include <linux/acpi_iort.h>
 #include <linux/bitmap.h>
@@ -2649,6 +2649,8 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 		/* Mark interrupt index as unused */
 		clear_bit(event, its_dev->event_map.lpi_map);
 
+		pr_debug("Freed devid %x event %d LPI %ld\n", its_dev->device_id, event, data->hwirq);
+
 		/* Nuke the entry in the domain */
 		irq_domain_reset_irq_data(data);
 	}
@@ -2659,6 +2661,9 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	 * If all interrupts have been freed, start mopping the
 	 * floor. This is conditionned on the device not being shared.
 	 */
+	pr_debug("Unmap devid %x shared %d lpi_map %*pbl\n",
+		 its_dev->device_id, its_dev->shared,
+		 its_dev->event_map.nr_lpis, its_dev->event_map.lpi_map);
 	if (!its_dev->shared &&
 	    bitmap_empty(its_dev->event_map.lpi_map,
 			 its_dev->event_map.nr_lpis)) {
@@ -2667,6 +2672,7 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 			     its_dev->event_map.nr_lpis);
 		kfree(its_dev->event_map.col_map);
 
+		pr_debug("Unmap devid %x\n", its_dev->device_id);
 		/* Unmap device/itt */
 		its_send_mapd(its_dev, 0);
 		its_free_device(its_dev);


-- 
Jazz is not dead, it just smells funny...
