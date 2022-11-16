Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 565B062B6DF
	for <lists+linux-pci@lfdr.de>; Wed, 16 Nov 2022 10:48:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231431AbiKPJsE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Nov 2022 04:48:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233126AbiKPJsC (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Wed, 16 Nov 2022 04:48:02 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD6ACC35
        for <linux-pci@vger.kernel.org>; Wed, 16 Nov 2022 01:47:59 -0800 (PST)
Received: from fraeml710-chm.china.huawei.com (unknown [172.18.147.207])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NBypP0lMyz67bjw;
        Wed, 16 Nov 2022 17:45:33 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 fraeml710-chm.china.huawei.com (10.206.15.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 16 Nov 2022 10:47:57 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Wed, 16 Nov
 2022 09:47:57 +0000
Date:   Wed, 16 Nov 2022 09:47:56 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Chris Chiu" <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] Revert "Revert "PCI: Distribute available
 resources for root buses, too""
Message-ID: <20221116094756.0000020e@Huawei.com>
In-Reply-To: <20221114115953.40236-2-mika.westerberg@linux.intel.com>
References: <20221114115953.40236-1-mika.westerberg@linux.intel.com>
        <20221114115953.40236-2-mika.westerberg@linux.intel.com>
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

On Mon, 14 Nov 2022 13:59:53 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> This reverts commit 5632e2beaf9d5dda694c0572684dea783d8a9492.
> 
> Now that pci_bridge_distribute_available_resources() takes multifunction
> devices int account we can revert this revert to fix the original issue.

into account

Looks fine to me, but I never really figured out the original logic
properly so will leave it to others to give tags on this one.

> 
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
>  drivers/pci/setup-bus.c | 62 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 61 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index f3f39aa82dda..dfa490da728d 100644
> --- a/drivers/pci/setup-bus.c
> +++ b/drivers/pci/setup-bus.c
> @@ -1768,7 +1768,10 @@ static void adjust_bridge_window(struct pci_dev *bridge, struct resource *res,
>  	}
>  
>  	res->end = res->start + new_size - 1;
> -	remove_from_list(add_list, res);
> +
> +	/* If the resource is part of the add_list remove it now */
> +	if (add_list)
> +		remove_from_list(add_list, res);
>  }
>  
>  static void pci_bus_distribute_available_resources(struct pci_bus *bus,
> @@ -1971,6 +1974,8 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
>  	if (!bridge->is_hotplug_bridge)
>  		return;
>  
> +	pci_dbg(bridge, "distributing available resources\n");
> +
>  	/* Take the initial extra resources from the hotplug port */
>  	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
>  	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
> @@ -1982,6 +1987,59 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
>  					       available_mmio_pref);
>  }
>  
> +static bool pci_bridge_resources_not_assigned(struct pci_dev *dev)
> +{
> +	const struct resource *r;
> +
> +	/*
> +	 * Check the child device's resources and if they are not yet
> +	 * assigned it means we are configuring them (not the boot
> +	 * firmware) so we should be able to extend the upstream
> +	 * bridge's (that's the hotplug downstream PCIe port) resources
> +	 * in the same way we do with the normal hotplug case.
> +	 */
> +	r = &dev->resource[PCI_BRIDGE_IO_WINDOW];
> +	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
> +		return false;
> +	r = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> +	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
> +		return false;
> +	r = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +	if (!r->flags || !(r->flags & IORESOURCE_STARTALIGN))
> +		return false;
> +
> +	return true;
> +}
> +
> +static void pci_root_bus_distribute_available_resources(struct pci_bus *bus,
> +							struct list_head *add_list)
> +{
> +	struct pci_dev *dev, *bridge = bus->self;
> +
> +	for_each_pci_bridge(dev, bus) {
> +		struct pci_bus *b;
> +
> +		b = dev->subordinate;
> +		if (!b)
> +			continue;
> +
> +		/*
> +		 * Need to check "bridge" here too because it is NULL
> +		 * in case of root bus.
> +		 */
> +		if (bridge && pci_bridge_resources_not_assigned(dev)) {
> +			pci_bridge_distribute_available_resources(bridge, add_list);
> +			/*
> +			 * There is only PCIe upstream port on the bus
> +			 * so we don't need to go futher.
> +			 */
> +			return;
> +		}
> +
> +		pci_root_bus_distribute_available_resources(b, add_list);
> +	}
> +}
> +
>  /*
>   * First try will not touch PCI bridge res.
>   * Second and later try will clear small leaf bridge res.
> @@ -2021,6 +2079,8 @@ void pci_assign_unassigned_root_bus_resources(struct pci_bus *bus)
>  	 */
>  	__pci_bus_size_bridges(bus, add_list);
>  
> +	pci_root_bus_distribute_available_resources(bus, add_list);
> +
>  	/* Depth last, allocate resources and update the hardware. */
>  	__pci_bus_assign_resources(bus, add_list, &fail_head);
>  	if (add_list)

