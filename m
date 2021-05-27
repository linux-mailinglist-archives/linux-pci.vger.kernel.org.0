Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C199C393898
	for <lists+linux-pci@lfdr.de>; Fri, 28 May 2021 00:13:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235895AbhE0WO5 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 27 May 2021 18:14:57 -0400
Received: from mail.kernel.org ([198.145.29.99]:58342 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233563AbhE0WO4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 27 May 2021 18:14:56 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id B229C60FE9;
        Thu, 27 May 2021 22:13:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622153603;
        bh=0VCssnCyaXoacCezAXEXIMcwiumMm+CUza0JXKuGcn0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Ysiv4Ec97svTCtG94GRkIO1KBpUvRC9HT80WQVcQbk7l4bOuYYIPgo+ExOo4bm5cs
         eHp0U8P9PCeA6nP2KxC0Her5gt3x4TKWwuJnGRFs3PJrsnupjS6Esac6AHn7iyvdb7
         vkexzd0xzKfFlhiQ4tgaYyIDqdqbFNlrlr59IQemXRfFfPKKZxjBHJn4hPnjXU3bEW
         ik5drL17rXZT8waJaUZKGUQ5wYstN+ZJk7kQckLGtbJV/jH+UGaaJj1hK9sughjiOv
         GviyOAU/TUB8m6iMopa67DNEHOS8G1QMTDzgDpO3y8m8KdXG1LFfghFAcN6vkdGnGG
         blJ8ucwp9fp+Q==
Date:   Thu, 27 May 2021 17:13:19 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Kai-Heng Feng <kai.heng.feng@canonical.com>
Cc:     bhelgaas@google.com,
        "open list:PCI SUBSYSTEM" <linux-pci@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] PCI: Coalesce contiguous regions for host bridges
Message-ID: <20210527221319.GA1435795@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210401131252.531935-1-kai.heng.feng@canonical.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 01, 2021 at 09:12:52PM +0800, Kai-Heng Feng wrote:
> Built-in graphics on HP EliteDesk 805 G6 doesn't work because graphics
> can't get the BAR it needs:
> [    0.611504] pci_bus 0000:00: root bus resource [mem 0x10020200000-0x100303fffff window]
> [    0.611505] pci_bus 0000:00: root bus resource [mem 0x10030400000-0x100401fffff window]
> ...
> [    0.638083] pci 0000:00:08.1:   bridge window [mem 0xd2000000-0xd23fffff]
> [    0.638086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100401fffff 64bit pref]
> [    0.962086] pci 0000:00:08.1: can't claim BAR 15 [mem 0x10030000000-0x100401fffff 64bit pref]: no compatible bridge window
> [    0.962086] pci 0000:00:08.1: [mem 0x10030000000-0x100401fffff 64bit pref] clipped to [mem 0x10030000000-0x100303fffff 64bit pref]
> [    0.962086] pci 0000:00:08.1:   bridge window [mem 0x10030000000-0x100303fffff 64bit pref]
> [    0.962086] pci 0000:07:00.0: can't claim BAR 0 [mem 0x10030000000-0x1003fffffff 64bit pref]: no compatible bridge window
> [    0.962086] pci 0000:07:00.0: can't claim BAR 2 [mem 0x10040000000-0x100401fffff 64bit pref]: no compatible bridge window
> 
> However, the root bus has two contiguous regions that can contain the
> child resource requested.
> 
> Bjorn Helgaas pointed out that we can simply coalesce contiguous regions
> for host bridges, since host bridge don't have _SRS. So do that
> accordingly to make child resource can be contained. This change makes
> the graphics works on the system in question.
> 
> Bugzilla: https://bugzilla.kernel.org/show_bug.cgi?id=212013
> Suggested-by: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Kai-Heng Feng <kai.heng.feng@canonical.com>

Applied to pci/resource for v5.14 with subject:

  PCI: Coalesce host bridge contiguous apertures

Thanks!

> ---
> v2:
>  - Coalesce all contiguous regresion in pci_register_host_bridge(), if
>    conditions are met.
> 
>  drivers/pci/probe.c | 49 +++++++++++++++++++++++++++++++++++++++++----
>  1 file changed, 45 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/pci/probe.c b/drivers/pci/probe.c
> index 953f15abc850..3607ce7402b4 100644
> --- a/drivers/pci/probe.c
> +++ b/drivers/pci/probe.c
> @@ -19,6 +19,7 @@
>  #include <linux/hypervisor.h>
>  #include <linux/irqdomain.h>
>  #include <linux/pm_runtime.h>
> +#include <linux/list_sort.h>
>  #include "pci.h"
>  
>  #define CARDBUS_LATENCY_TIMER	176	/* secondary latency timer */
> @@ -874,14 +875,30 @@ static void pci_set_bus_msi_domain(struct pci_bus *bus)
>  	dev_set_msi_domain(&bus->dev, d);
>  }
>  
> +static int res_cmp(void *priv, struct list_head *a, struct list_head *b)
> +{
> +	struct resource_entry *entry1, *entry2;
> +
> +	entry1 = container_of(a, struct resource_entry, node);
> +	entry2 = container_of(b, struct resource_entry, node);
> +
> +	if (entry1->res->flags != entry2->res->flags)
> +		return entry1->res->flags > entry2->res->flags;
> +
> +	if (entry1->offset != entry2->offset)
> +		return entry1->offset > entry2->offset;
> +
> +	return entry1->res->start > entry2->res->start;
> +}
> +
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
> @@ -959,11 +976,35 @@ static int pci_register_host_bridge(struct pci_host_bridge *bridge)
>  	if (nr_node_ids > 1 && pcibus_to_node(bus) == NUMA_NO_NODE)
>  		dev_warn(&bus->dev, "Unknown NUMA node; performance will be reduced\n");
>  
> +	/* Sort and coalesce contiguous windows */
> +	list_sort(NULL, &resources, res_cmp);
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
> 2.30.2
> 
