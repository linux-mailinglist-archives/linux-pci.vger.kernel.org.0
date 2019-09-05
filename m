Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 16FDFAA506
	for <lists+linux-pci@lfdr.de>; Thu,  5 Sep 2019 15:50:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731917AbfIENu1 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 5 Sep 2019 09:50:27 -0400
Received: from foss.arm.com ([217.140.110.172]:45654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731008AbfIENu1 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 5 Sep 2019 09:50:27 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BCEBC28;
        Thu,  5 Sep 2019 06:50:26 -0700 (PDT)
Received: from [10.1.197.61] (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B7CB63F67D;
        Thu,  5 Sep 2019 06:50:25 -0700 (PDT)
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
 <73c22eaa-172e-0fba-7a44-381106dee50d@kernel.org>
 <a73262e6-6ece-4946-896b-2dad5ca28417@huawei.com>
From:   Marc Zyngier <maz@kernel.org>
Organization: Approximate
Message-ID: <a90e6f99-cad3-8eda-dd08-0ab05ed9ca04@kernel.org>
Date:   Thu, 5 Sep 2019 14:50:24 +0100
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:60.0) Gecko/20100101
 Thunderbird/60.8.0
MIME-Version: 1.0
In-Reply-To: <a73262e6-6ece-4946-896b-2dad5ca28417@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On 05/09/2019 14:26, John Garry wrote:
> On 05/09/2019 12:22, Marc Zyngier wrote:
>> OK, debug was slightly off, but it is interesting that the driver didn't
>> unmap the device, either because it is flagged as shared (with what?) or
>> that additional interrupts are allocated in the lpi_map for this
>> instance.
>>
>> Here's an updated debug patch. Can you please run the same thing again?
>>
> 
> As requested:
> 
> root@(none)$ echo 0000:74:02.0 > ./sys/bus/pci/drivers/hisi_sas_v3_hw/unbind
> 
> <snip>
> 
> [   78.593897] Freed devid 7410 event 0 LPI 0
> [   78.597990] Freed devid 7410 event 1 LPI 0
> [   78.602080] Freed devid 7410 event 2 LPI 0
> [   78.606169] Freed devid 7410 event 3 LPI 0
> [   78.610253] Freed devid 7410 event 4 LPI 0
> [   78.614337] Freed devid 7410 event 5 LPI 0
> [   78.618422] Freed devid 7410 event 6 LPI 0
> [   78.622506] Freed devid 7410 event 7 LPI 0
> [   78.626590] Freed devid 7410 event 8 LPI 0
> [   78.630674] Freed devid 7410 event 9 LPI 0
> [   78.634758] Freed devid 7410 event 10 LPI 0
> [   78.638930] Freed devid 7410 event 11 LPI 0
> [   78.643101] Freed devid 7410 event 12 LPI 0
> [   78.647272] Freed devid 7410 event 13 LPI 0
> [   78.651445] Freed devid 7410 event 14 LPI 0
> [   78.655616] Freed devid 7410 event 15 LPI 0
> [   78.659787] Freed devid 7410 event 16 LPI 0
> [   78.663959] Unmap devid 7410 shared 0 lpi_map 17-31

Bah. Try this for size...

	M.

diff --git a/drivers/irqchip/irq-gic-v3-its.c b/drivers/irqchip/irq-gic-v3-its.c
index 1b5c3672aea2..c3a8d732805f 100644
--- a/drivers/irqchip/irq-gic-v3-its.c
+++ b/drivers/irqchip/irq-gic-v3-its.c
@@ -2641,14 +2641,13 @@ static void its_irq_domain_free(struct irq_domain *domain, unsigned int virq,
 	struct its_node *its = its_dev->its;
 	int i;
 
+	bitmap_release_region(its_dev->event_map.lpi_map,
+			      its_get_event_id(irq_domain_get_irq_data(domain, virq)),
+			      get_count_order(nr_irqs));
+
 	for (i = 0; i < nr_irqs; i++) {
 		struct irq_data *data = irq_domain_get_irq_data(domain,
 								virq + i);
-		u32 event = its_get_event_id(data);
-
-		/* Mark interrupt index as unused */
-		clear_bit(event, its_dev->event_map.lpi_map);
-
 		/* Nuke the entry in the domain */
 		irq_domain_reset_irq_data(data);
 	}


-- 
Jazz is not dead, it just smells funny...
