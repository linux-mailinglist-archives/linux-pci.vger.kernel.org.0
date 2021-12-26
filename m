Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4063947F6E3
	for <lists+linux-pci@lfdr.de>; Sun, 26 Dec 2021 14:04:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233491AbhLZNEe (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Dec 2021 08:04:34 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:41388 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231607AbhLZNEe (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Sun, 26 Dec 2021 08:04:34 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 03C0860DE9
        for <linux-pci@vger.kernel.org>; Sun, 26 Dec 2021 13:04:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 357CFC36AE8;
        Sun, 26 Dec 2021 13:04:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1640523873;
        bh=G6tDH61irBfDjT2P+wUlHj+4y4e/7TqLkhXcgJ2EV58=;
        h=Date:From:To:Subject:References:In-Reply-To:From;
        b=W8aQ1RGKY9NZCoRCzYFW34R6Dw42vX855x+ljwIfh4hqVvIKTT5q9K3PmfIdHLWSV
         tLi2eH2sF48Pjy2l+KOU6S31HZACRdn/MSYELtq/a/PpzYM+pelmR+pWmao+2xcmCo
         wJvajEZEQlr7sJvFafXZy3GmzFNtbQze8NvDMK+35+yAodiR8jG6uIogBapA6AZfR3
         ndwvsm579EAEoGrkJbMOe6JjsdHknPFbZ82baPqtGcZiXkoP4xxzDRkOh6gyEZ3ivm
         jr9/CdBgOkvsZbisABtNBYa74D3N9ksUwIXm8bVKG82EWF6WvcabVyBeM/jpRNDuIW
         KVJfQGT5Xbqxg==
Received: by pali.im (Postfix)
        id EA4AE9D0; Sun, 26 Dec 2021 14:04:29 +0100 (CET)
Date:   Sun, 26 Dec 2021 14:04:29 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Martin Mares <mj@ucw.cz>, Bjorn Helgaas <helgaas@kernel.org>,
        Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kw@linux.com>,
        Matthew Wilcox <willy@infradead.org>, linux-pci@vger.kernel.org
Subject: Re: [PATCH pciutils] lspci: Print buses of multibus PCI domain in
 ascending order
Message-ID: <20211226130429.n2p2d5piwtnhwwmr@pali>
References: <20211220195349.16316-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20211220195349.16316-1-pali@kernel.org>
User-Agent: NeoMutt/20180716
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Monday 20 December 2021 20:53:49 Pali Rohár wrote:
> Currently PCI domains are printed in ascending order. Devices on each PCI
> bus are also printed in ascending order. PCI buses behind PCI-to-PCI
> bridges are also printed in ascending order.
> 
> But buses of PCI domain are currently printed in descending order because
> function new_bus() puts newly created bus at the beginning of linked list.
> 
> In most cases PCI domain contains only one (top level) bus, so in most
> cases it is not visible this inconsistency.
> 
> Multibus PCI domains (where PCI domain contains more independent top level
> PCI buses) are available on ARM devices.
> 
> This change fixes print order of multibus PCI domains, so also top level
> PCI buses are printed in ascending order, like PCI buses behind PCI-to-PCI
> bridges.
> ---
>  ls-tree.c | 10 +++++++---
>  lspci.h   |  2 +-
>  2 files changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/ls-tree.c b/ls-tree.c
> index aeb40870865e..17a95307b3fa 100644
> --- a/ls-tree.c
> +++ b/ls-tree.c
> @@ -12,7 +12,7 @@
>  
>  #include "lspci.h"
>  
> -struct bridge host_bridge = { NULL, NULL, NULL, NULL, 0, ~0, 0, ~0, NULL };
> +struct bridge host_bridge = { NULL, NULL, NULL, NULL, NULL, 0, ~0, 0, ~0, NULL };
>  
>  static struct bus *
>  find_bus(struct bridge *b, unsigned int domain, unsigned int n)
> @@ -31,11 +31,14 @@ new_bus(struct bridge *b, unsigned int domain, unsigned int n)
>    struct bus *bus = xmalloc(sizeof(struct bus));
>    bus->domain = domain;
>    bus->number = n;
> -  bus->sibling = b->first_bus;

Oops, this is a mistake. Default value for bus->sibling needs to be
explicitly set because xmalloc() wrapper does not return zero
initialized memory. So correct change for above line should be:

-  bus->sibling = b->first_bus;
+  bus->sibling = NULL;

>    bus->first_dev = NULL;
>    bus->last_dev = &bus->first_dev;
>    bus->parent_bridge = b;
> -  b->first_bus = bus;
> +  if (b->last_bus)
> +    b->last_bus->sibling = bus;
> +  b->last_bus = bus;
> +  if (!b->first_bus)
> +    b->first_bus = bus;
>    return bus;
>  }
>  
> @@ -101,6 +104,7 @@ grow_tree(void)
>  	  last_br = &b->chain;
>  	  b->next = b->child = NULL;
>  	  b->first_bus = NULL;
> +	  b->last_bus = NULL;
>  	  b->br_dev = d;
>  	  d->bridge = b;
>  	  pacc->debug("Tree: bridge %04x:%02x:%02x.%d: %02x -> %02x-%02x\n",
> diff --git a/lspci.h b/lspci.h
> index fefee5256423..352177fcce7b 100644
> --- a/lspci.h
> +++ b/lspci.h
> @@ -90,7 +90,7 @@ void show_kernel_cleanup(void);
>  struct bridge {
>    struct bridge *chain;			/* Single-linked list of bridges */
>    struct bridge *next, *child;		/* Tree of bridges */
> -  struct bus *first_bus;		/* List of buses connected to this bridge */
> +  struct bus *first_bus, *last_bus;	/* List of buses connected to this bridge */
>    unsigned int domain;
>    unsigned int primary, secondary, subordinate;	/* Bus numbers */
>    struct device *br_dev;
> -- 
> 2.20.1
> 
