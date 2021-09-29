Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A4F3641CDFA
	for <lists+linux-pci@lfdr.de>; Wed, 29 Sep 2021 23:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346454AbhI2V12 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 29 Sep 2021 17:27:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:54936 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232425AbhI2V11 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 29 Sep 2021 17:27:27 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id EA12A615E0;
        Wed, 29 Sep 2021 21:25:45 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632950746;
        bh=/uohdsS46RoeYWV3Wuhg+CaUifSJS3kMzk3c77rNVMg=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=eVXGDv79IHof2T2KJbcPGS8o6/QleOYNvaSoPHLVkKfiliYVCl4rbzQ5yxKQFhBjK
         B4BHPHZnA61MT01eMZHQVYF4vh1+EwLEc2hXh9MyBMlkuCtl0eqK61s1N9P86Y77m6
         ucFWf7plzgkpHVU3PeSB38LM/0T2jH7jjZ72wiMS8aCVnREtElqmUcgHzc0Sv/ypUJ
         ULPB6rYS6+5I0Vb6EEk6jjqEUQAUFNHrWV1McFMu523E8jslPsZ2NXbht2vIVcYtPS
         uGqfYe4gH//0TFcF7gotEr9yar+AclWgiWk438ACf+RB+yq53JWLG2mNq8vLOLsTYm
         ipDtkpa68q3sA==
Date:   Wed, 29 Sep 2021 16:25:44 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com, Guenter Roeck <linux@roeck-us.net>,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Reinstate "PCI: Coalesce host bridge contiguous
 apertures"
Message-ID: <20210929212544.GA808906@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210713125007.1260304-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Jul 13, 2021 at 08:50:07PM +0800, Kai-Heng Feng wrote:
> Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> can't get the BAR it needs:
>   pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
>   pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> 
>   pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
>   pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
>   pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
>   pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
>   pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
>   pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
>   pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> 
> However, the root bus has two contiguous apertures that can contain the
> child resource requested.
> 
> Coalesce contiguous apertures so we can allocate from the entire contiguous
> region.
> 
> This is the second take of commit 65db04053efe ("PCI: Coalesce host
> bridge contiguous apertures"). The original approach sorts the apertures
> by address, but that makes NVMe stop working on QEMU ppc:sam460ex:
>   PCI host bridge to bus 0002:00
>   pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
>   pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
>   pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
> 
> After the offending commit:
>   PCI host bridge to bus 0002:00
>   pci_bus 0002:00: root bus resource [io  0x0000-0xffff]
>   pci_bus 0002:00: root bus resource [mem 0xc0ee00000-0xc0eefffff] (bus address [0x00000000-0x000fffff])
>   pci_bus 0002:00: root bus resource [mem 0xd80000000-0xdffffffff] (bus address [0x80000000-0xffffffff])
> 
> Since the apertures on HP EliteDesk 805 G6 are already in ascending
> order, doing a precautious sorting is not necessary.
> 
> Remove the sorting part to avoid the regression on ppc:sam460ex.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> Cc: Guenter Roeck <linux@roeck-us.net>
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to pci/resource for v5.16, thanks!

> ---
> v2:
>  - Bring back the original commit message.
> 
>  drivers/pci/probe.c | 31 +++++++++++++++++++++++++++----
>  1 file changed, 27 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 79177ac37880..5de157600466 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -877,11 +877,11 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>  static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  {
>  	struct device *parent = bridge->dev.parent;
> -	struct resource_entry *window, *n;
> +	struct resource_entry *window, *next, *n;
>  	struct pci_bus *bus, *b;
> -	resource_size_t offset;
> +	resource_size_t offset, next_offset;
>  	LIST_HEAD(resources);
> -	struct resource *res;
> +	struct resource *res, *next_res;
>  	char addr[64], *fmt;
>  	const char *name;
>  	int err;
> @@ -961,11 +961,34 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
>  		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
>  
> +	/* Coalesce contiguous windows */
> +	resource_list_for_each_entry_safe(window, n, &resources) {
> +		if (list_is_last(&window->node, &resources))
> +			break;
> +
> +		next = list_next_entry(window, node);
> +		offset = window->offset;
> +		res = window->res;
> +		next_offset = next->offset;
> +		next_res = next->res;
> +
> +		if (res->flags != next_res->flags || offset != next_offset)
> +			continue;
> +
> +		if (res->end + 1 == next_res->start) {
> +			next_res->start = res->start;
> +			res->flags = res->start = res->end = 0;
> +		}
> +	}
> +
>  	/* Add initial resources to the bus */
>  	resource_list_for_each_entry_safe(window, n, &resources) {
> -		list_move_tail(&window->node, &bridge->windows);
>  		offset = window->offset;
>  		res = window->res;
> +		if (!res->end)
> +			continue;
> +
> +		list_move_tail(&window->node, &bridge->windows);
>  
>  		if (res->flags & IORESOURCE_BUS)
>  			pci_bus_insert_busn_res(bus, bus->number, res->end);
> -- 
> 2.31.1
> 
