Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB5BC640C77
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 18:45:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233452AbiLBRpz (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 12:45:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234295AbiLBRpg (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 12:45:36 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF0EE1188
        for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2022 09:45:25 -0800 (PST)
Received: from fraeml709-chm.china.huawei.com (unknown [172.18.147.200])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NP0dH2Ynxz6823d;
        Sat,  3 Dec 2022 01:42:27 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml709-chm.china.huawei.com (10.206.15.37) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 18:45:15 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 17:45:14 +0000
Date:   Fri, 2 Dec 2022 17:45:13 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Chris Chiu" <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 1/2] PCI: Take other bus devices into account when
 distributing resources
Message-ID: <20221202174513.000000e1@Huawei.com>
In-Reply-To: <20221130112221.66612-2-mika.westerberg@linux.intel.com>
References: <20221130112221.66612-1-mika.westerberg@linux.intel.com>
        <20221130112221.66612-2-mika.westerberg@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100004.china.huawei.com (7.191.162.219) To
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

On Wed, 30 Nov 2022 13:22:20 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> A PCI bridge may reside on a bus with other devices as well. The
> resource distribution code does not take this into account properly and
> therefore it expands the bridge resource windows too much, not leaving
> space for the other devices (or functions a multifunction device) and
> this leads to an issue that Jonathan reported. He runs QEMU with the
> following topoology (QEMU parameters):
> 
>  -device pcie-root-port,port=0,id=root_port13,chassis=0,slot=2	\
>  -device x3130-upstream,id=sw1,bus=root_port13,multifunction=on	\
>  -device e1000,bus=root_port13,addr=0.1 			\
>  -device xio3130-downstream,id=fun1,bus=sw1,chassis=0,slot=3	\
>  -device e1000,bus=fun1
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
Trivial comment inline. Either way..

Reviewed-by: Jonathan Cameron <Jonathan.Cameron@huawei.com>

> ---
>  drivers/pci/setup-bus.c | 66 ++++++++++++++++++++++++++++++++++++++---
>  1 file changed, 62 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index b4096598dbcb..d456175ddc4f 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1830,10 +1830,68 @@ static void pci_bus_distribute_available_resources(struct pci_bus *bus,
>  	 * bridges below.
>  	 */
>  	if (hotplug_bridges + normal_bridges == 1) {
> -		dev = list_first_entry(&bus->devices, struct pci_dev, bus_list);
> -		if (dev->subordinate)
> -			pci_bus_distribute_available_resources(dev->subordinate,
> -				add_list, io, mmio, mmio_pref);
> +		bridge = NULL;
> +
> +		/* Find the single bridge on this bus first */

> +		for_each_pci_bridge(dev, bus) {

We could cache this a few lines up where we calculate the
number of bridges. Perhaps not worth bothering though other
than it letting you get rid of the WARN_ON_ONCE. 


> +			bridge = dev;
> +			break;
> +		}
> +
> +		if (WARN_ON_ONCE(!bridge))
> +			return;
> +		if (!bridge->subordinate)
> +			return;
> +
> +		/*
> +		 * Reduce the space available for distribution by the
> +		 * amount required by the other devices on the same bus
> +		 * as this bridge.
> +		 */
> +		list_for_each_entry(dev, &bus->devices, bus_list) {
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
> +				if (!dev_sz)
> +					continue;
> +
> +				pci_dbg(dev, "resource %pR aligned to %#llx\n",
> +					dev_res, (unsigned long long)dev_sz);
> +
> +				if (dev_sz > resource_size(b_res))
> +					memset(b_res, 0, sizeof(*b_res));
> +				else
> +					b_res->end -= dev_sz;
> +
> +				pci_dbg(bridge, "updated available resources to %pR\n",
> +					b_res);
> +			}
> +		}
> +
> +		pci_bus_distribute_available_resources(bridge->subordinate,
> +						       add_list, io, mmio,
> +						       mmio_pref);
>  		return;
>  	}
>  

