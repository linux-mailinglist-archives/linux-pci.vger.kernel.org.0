Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A4C62640CC4
	for <lists+linux-pci@lfdr.de>; Fri,  2 Dec 2022 19:02:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234152AbiLBSCF (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 2 Dec 2022 13:02:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234232AbiLBSBq (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Fri, 2 Dec 2022 13:01:46 -0500
Received: from frasgout.his.huawei.com (frasgout.his.huawei.com [185.176.79.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2AFE61D8
        for <linux-pci@vger.kernel.org>; Fri,  2 Dec 2022 10:01:43 -0800 (PST)
Received: from frapeml500003.china.huawei.com (unknown [172.18.147.201])
        by frasgout.his.huawei.com (SkyGuard) with ESMTP id 4NP12t2PBGz67QNP;
        Sat,  3 Dec 2022 02:01:10 +0800 (CST)
Received: from lhrpeml500005.china.huawei.com (7.191.163.240) by
 frapeml500003.china.huawei.com (7.182.85.28) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 2 Dec 2022 19:01:41 +0100
Received: from localhost (10.202.227.76) by lhrpeml500005.china.huawei.com
 (7.191.163.240) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.34; Fri, 2 Dec
 2022 18:01:40 +0000
Date:   Fri, 2 Dec 2022 18:01:40 +0000
From:   Jonathan Cameron <Jonathan.Cameron@Huawei.com>
To:     Mika Westerberg <mika.westerberg@linux.intel.com>
CC:     Bjorn Helgaas <bhelgaas@google.com>,
        "Rafael J . Wysocki" <rafael.j.wysocki@intel.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Lukas Wunner <lukas@wunner.de>,
        "Chris Chiu" <chris.chiu@canonical.com>,
        <linux-pci@vger.kernel.org>
Subject: Re: [PATCH v3 2/2] PCI: Distribute available resources for root
 buses too
Message-ID: <20221202180140.000053ae@Huawei.com>
In-Reply-To: <20221130112221.66612-3-mika.westerberg@linux.intel.com>
References: <20221130112221.66612-1-mika.westerberg@linux.intel.com>
        <20221130112221.66612-3-mika.westerberg@linux.intel.com>
Organization: Huawei Technologies Research and Development (UK) Ltd.
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-w64-mingw32)
MIME-Version: 1.0
Content-Type: text/plain; charset="US-ASCII"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.202.227.76]
X-ClientProxiedBy: lhrpeml100001.china.huawei.com (7.191.160.183) To
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

On Wed, 30 Nov 2022 13:22:21 +0200
Mika Westerberg <mika.westerberg@linux.intel.com> wrote:

> Previously we distributed spare resources only upon hot-add, so if the
> initial root bus scan found devices that had not been fully configured by
> the BIOS, we allocated only enough resources to cover what was then
> present. If some of those devices were hotplug bridges, we did not leave
> any additional resource space for future expansion.
> 
> Distribute the available resources for root buses, too, to make this work
> the same way as the normal hotplug case.
> 
> Link: https://bugzilla.kernel.org/show_bug.cgi?id=216000
> Link: https://lore.kernel.org/r/20220905080232.36087-5-mika.westerberg@linux.intel.com
> Reported-by: Chris Chiu <chris.chiu@canonical.com>
> Signed-off-by: Mika Westerberg <mika.westerberg@linux.intel.com>
> ---
> This is a new version of the patch after the revert due to the regression
> reported by Jonathan Cameron. This one changes pci_bridge_resources_not_assigned()
> to work with bridges that do not have all the resource windows
> programmed by the boot firmware (previously we expected all I/O, memory
> and prefetchable memory were all programmed).
> 

Whilst this sounds plausible my understanding of how those flags are used
is very minimal so I'll leave this one for others to review who hopefully
already know how that works!


>  drivers/pci/setup-bus.c | 56 ++++++++++++++++++++++++++++++++++++++++-
>  1 file changed, 55 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/setup-bus.c b/drivers/pci/setup-bus.c
> index d456175ddc4f..143ec80cc0b2 100644
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
> @@ -1981,6 +1984,8 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
>  	if (!bridge->is_hotplug_bridge)
>  		return;
>  
> +	pci_dbg(bridge, "distributing available resources\n");
> +
>  	/* Take the initial extra resources from the hotplug port */
>  	available_io = bridge->resource[PCI_BRIDGE_IO_WINDOW];
>  	available_mmio = bridge->resource[PCI_BRIDGE_MEM_WINDOW];
> @@ -1992,6 +1997,53 @@ static void pci_bridge_distribute_available_resources(struct pci_dev *bridge,
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
> +	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
> +		return false;
> +	r = &dev->resource[PCI_BRIDGE_MEM_WINDOW];
> +	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
> +		return false;
> +	r = &dev->resource[PCI_BRIDGE_PREF_MEM_WINDOW];
> +	if (r->flags && !(r->flags & IORESOURCE_STARTALIGN))
> +		return false;
> +
> +	return true;
> +}

