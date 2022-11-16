Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 21C6662B6DC
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 10:46:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232501AbiKPJqo (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 04:46:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232830AbiKPJqm (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 04:46:42 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1335114D35
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 01:46:42 -0800 (PST)
Received: from fraeml745-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBykK1qj8z686pL;
        Wed, 16 Nov 2022 17:42:01 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml745-chm.china.huawei.com (10.206.15.226) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 10:46:40 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 09:46:39 +0000
Date:   Wed, 16 Nov 2022 09:46:39 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Chris Chiu" <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 1/2] PCI: Take multifunction devices into account
 when distributing resources
Message-ID: <20221116094639.00002050@Huawei.com>
In-Reply-To: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
References: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml500006.china.huawei.com (7.191.161.198) To
 lhrpeml500005.china.huawei.com (7.191.163.240)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, 14 Nov 2022 13:59:52 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> PCIe switch upstream port may be one of the functions of a multifunction
> device. The resource distribution code does not take this into account
> properly and therefore it expands the upstream port resource windows too
> much, not leaving space for the other functions (in the multifunction
> device) and this leads to an issue that Jonathan reported. He runs QEMU
> with the following topoology (QEMU parameters):
> 
>  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
>  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
>  -device e1000,bus=root_port13,addr=0.1 			\
>  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
>  -device e1000,bus=fun1
Other than the fact the example makes me look like a crazed maniac
(the wonder of minimal test cases)..

One comment inline but either way as far as I can tell (not being
particularly familiar with this code) it looks good to me.

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>


> 
> The first e1000 NIC here is another function in the switch upstream
> port. This leads to following errors:
> 
>   pci 0000:00:04.0: bridge window [mem 0x10200000-0x103fffff] to [bus 02-04]
>   pci 0000:02:00.0: bridge window [mem 0x10200000-0x103fffff] to [bus 03-04]
>   pci 0000:02:00.1: BAR 0: failed to assign [mem size 0x00020000]
>   e1000 0000:02:00.1: can't ioremap BAR 0: [??? 0x00000000 flags 0x0]
> 
> Fix this by taking into account the possible multifunction devices when
> uptream port resources are distributed.
> 
> Link: https://lore.kernel.org/linux-pci/20221014124553.0000696f@huawei.com/
> Reported-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> The previous version of the series can be found here:
> 
>   https://lore.kernel.org/linux-pci/20221103103254.30497-1-mika.westerberg@linux.intel.com/
> 
> Changes from v1:
>   * Re-worded the commit message to hopefully explain the problem
>     better
>   * Added Link: to the bug report
>   * Update the comment according to Bjorn's suggestion
>   * Dropped the ->multifunction check
>   * Use %#llx in log format.
> 
>  drivers/pci/setup-bus.c | 56 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 52 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..f3f39aa82dda 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1830,10 +1830,58 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 * bridges below.
>  	 */
>  	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> +		/* Upstream port must be the first */
> +		bridge = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> +		if (!bridge->subordinate)
> +			return;
> +
> +		/*
> +		 * It is possible to have switch upstream port as a part of a
> +		 * multifunction device. For this reason reduce the space
> +		 * available for distribution by the amount required by the
> +		 * peers of the upstream port.
> +		 */
> +		list_for_each_entry(dev, &bus->devices, bus_list) {

You 'could' use list_for_each_entry_continue().
It might be a tiny bit tidier but meh, current logic is pretty clear anyway
and avoids need to take a copy of the pointer to the first element.

> +			int i;
> +
> +			if (dev == bridge)
> +				continue;
> +
> +			for (i = 0; i < PCI_NUM_RESOURCES; i++) {
> +				const struct resource *dev_res = &dev->resource[i];
> +				resource_size_t dev_sz;
> +				struct resource *b_res;
> +
> +				if (dev_res->flags & IORESOURCE_IO) {
> +					b_res = &io;
> +				} else if (dev_res->flags & IORESOURCE_MEM) {
> +					if (dev_res->flags & IORESOURCE_PREFETCH)
> +						b_res = &mmio_pref;
> +					else
> +						b_res = &mmio;
> +				} else {
> +					continue;
> +				}
> +
> +				/* Size aligned to bridge window */
> +				align = pci_resource_alignment(bridge, b_res);
> +				dev_sz = ALIGN(resource_size(dev_res), align);
> +
> +				pci_dbg(dev, "%pR aligned to %#llx\n", dev_res,
> +					(unsigned long long)dev_sz);
> +
> +				if (dev_sz >= resource_size(b_res))
> +					memset(b_res, 0, sizeof(*b_res));
> +				else
> +					b_res->end -= dev_sz;
> +
> +				pci_dbg(bridge, "updated available to %pR\n", b_res);
> +			}
> +		}
> +
> +		pci_bus_distribute_available_resources(bridge->subordinate,
> +						       add_list, io, mmio,
> +						       mmio_pref);
>  		return;
>  	}
>  

