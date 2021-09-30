Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id BE4EC41E40C
	for <lists+linux-pci@lfdr.de>; Fri,  1 Oct 2021 00:40:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345719AbhI3Wlp (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Thu, 30 Sep 2021 18:41:45 -0400
Received: from mail.kernel.org ([198.145.29.99]:42544 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1346149AbhI3Wlp (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Thu, 30 Sep 2021 18:41:45 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id A65FF619E7;
        Thu, 30 Sep 2021 22:40:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1633041602;
        bh=tEUZDNk08RLI2Q8s7uNHjFnnEV4JanF0tL7ihxBzlvc=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=CBXeYWRQIzd3Uuh3eTVhBDPBs6ffuHrEu05iYZv5ewerbdnBozZCe/XfoUFOTEpH5
         LfAMZYSjphGVnYHo3kOcJwiraGavZZk3W6GMzpwGZpftES+vIHphlgcNFVWcusmLq2
         xPh7V57memkvUoPsYwz9CdI27hmGVGSBe/+HhK1n5zfMhNHwlIqCskxbU5tmrb6cYA
         qVBjBmcEczssYwa9Qdn5VslynowdsxWKVmUpHrdtD+/goGycK/qDTJHMt/NK82Lav5
         rg4pR71yhkDsShTuUjkb6VwAmPvwbqOFZZO9LDsmWIzoZpXvOU1W93kOoVUlAjyRL2
         CVr2JRZ/514LA==
Date:   Thu, 30 Sep 2021 17:40:00 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 1/4] PCI/ASPM: Remove struct pcie_link_state.parent
Message-ID: <20210930224000.GA908006@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210929004315.22558-2-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Sep 29, 2021 at 02:43:12AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> Information cached in struct pcie_link_state.parent is accessible
> via struct pci_dev.
> 
> This patch:
>  - removes *parent* from the *struct pcie_link_state*
>  - creates pci_get_parent() which returns the parent of a pci_dev
>  - replaces references to pcie_link_state.parent with a call to
>    pci_get_parent()
>  - removes BUG_ON(root->parent), instead uses the parent's root
> 
> Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> ---
>  drivers/pci/pcie/aspm.c | 36 ++++++++++++++++++++++++++----------
>  1 file changed, 26 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 013a47f587ce..414c04ffe962 100644
> --- a/drivers/pci/pcie/aspm.c
> +++ b/drivers/pci/pcie/aspm.c
> @@ -50,7 +50,6 @@ struct pcie_link_state {
>  	struct pci_dev *pdev;		/* Upstream component of the Link */
>  	struct pci_dev *downstream;	/* Downstream component, function 0 */
>  	struct pcie_link_state *root;	/* pointer to the root port link */
> -	struct pcie_link_state *parent;	/* pointer to the parent Link state */
>  	struct list_head sibling;	/* node in link_list */
>  
>  	/* ASPM state */
> @@ -139,6 +138,14 @@ static int policy_to_clkpm_state(struct pcie_link_state *link)
>  	return 0;
>  }
>  
> +static struct pci_dev *pci_get_parent(struct pci_dev *pdev)
> +{
> +	if (!pdev || !pdev->bus->parent || !pdev->bus->parent->self)
> +		return NULL;
> +
> +	return pdev->bus->parent->self;
> +}

I LOVE the idea of getting rid of the pcie_link_state.parent pointer.
I think it's dumb to maintain a shadow hierarchy when we already HAVE
a hierarchy in struct pci_dev.

I'm not in love with the pci_get_parent() name because a pci_dev
doesn't really have a "parent."  The closest thing to a parent would
be the bridge upstream from the device, and that's not what this
returns.

This actually has to start from a Downstream Port (not an Endpoint)
because the struct pcie_link_state is always associated with the
upstream end of the link.

And it actually returns the bridge that is *two* levels up, because
that's the upstream end of the next link, so it's more like the
"grandparent" of pdev, not the "parent."

Example from my laptop:

  0a:04.0 Downstream Port (switch A)    to [bus 0c-3d]
  0c:00.0 Upstream Port (switch B)      to [bus 0d-3d]
  0d:01.0 Downstream Port (switch B)    to [bus 0e]
  0e:00.0 Upstream Port (Endpoint)      USB controller

Here there are two links:

  0a:04.0 --- 0c:00.0
  0d:01.0 --- 0e:00.0

and the pcie_link_states are associated with 0a:04.0 and 0d:01.0.

If we start from 0d:01.0, which is the upstream end of the last link:

  "pdev" is a pci_dev of a downstream port, e.g., 0d:01.0.
  "pdev->bus" is the pci_bus pdev is on: [bus 0d].
  "pdev->bus->self" is the bridge leading to "bus": 0c:00.0.
  "pdev->bus->parent" is the parent pci_bus of [bus 0d]: [bus 0c].
  "pdev->bus->parent->self" is the bridge leading to [bus 0c]: 0a:04.0.

Sorry for the rambling, just trying to get this all clear in my head.

Almost all the calls of pci_get_parent() look like this:

  parent = pci_get_parent(link->pdev);
  link = parent ? parent->link_state : NULL;

What if you made something like this:

  struct pcie_link_state *pcie_upstream_link(struct pcie_link_state *link)
  {
    struct pci_dev *bridge;

    bridge = pci_upstream_bridge(link->pdev);
    if (!bridge)
      return NULL;

    bridge = pci_upstream_bridge(bridge);
    return bridge ? bridge->link_state : NULL;
  }

>  static void pcie_set_clkpm_nocheck(struct pcie_link_state *link, int enable)
>  {
>  	struct pci_dev *child;
> @@ -379,6 +386,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
>  	u32 latency, l1_switch_latency = 0;
> +	struct pci_dev *parent;
>  	struct aspm_latency *acceptable;
>  	struct pcie_link_state *link;
>  
> @@ -419,7 +427,8 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  			link->aspm_capable &= ~ASPM_STATE_L1;
>  		l1_switch_latency += 1000;
>  
> -		link = link->parent;
> +		parent = pci_get_parent(link->pdev);
> +		link = parent ? parent->link_state : NULL;
>  	}
>  }
>  
> @@ -793,9 +802,11 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)
>  {
> +	struct pci_dev *parent;

Missing a blank line here.

>  	while (link) {
>  		pcie_config_aspm_link(link, policy_to_aspm_state(link));
> -		link = link->parent;
> +		parent = pci_get_parent(link->pdev);
> +		link = parent ? parent->link_state : NULL;
>  	}
>  }
>  
> @@ -864,16 +875,15 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  	    !pdev->bus->parent->self) {
>  		link->root = link;
>  	} else {
> -		struct pcie_link_state *parent;
> +		struct pci_dev *parent;
>  
> -		parent = pdev->bus->parent->self->link_state;
> -		if (!parent) {
> +		parent = pci_get_parent(pdev);
> +		if (!parent->link_state) {
>  			kfree(link);
>  			return NULL;
>  		}
>  
> -		link->parent = parent;
> -		link->root = link->parent->root;
> +		link->root = parent->link_state->root;
>  	}
>  
>  	list_add(&link->sibling, &link_list);
> @@ -962,7 +972,11 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  static void pcie_update_aspm_capable(struct pcie_link_state *root)
>  {
>  	struct pcie_link_state *link;
> -	BUG_ON(root->parent);
> +	struct pci_dev *parent = pci_get_parent(root->pdev);
> +
> +	if (parent && parent->link_state)
> +		root = parent->link_state->root;
> +
>  	list_for_each_entry(link, &link_list, sibling) {
>  		if (link->root != root)
>  			continue;
> @@ -985,6 +999,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
>  /* @pdev: the endpoint device */
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  {
> +	struct pci_dev *parent_dev;
>  	struct pci_dev *parent = pdev->bus->self;
>  	struct pcie_link_state *link, *root, *parent_link;
>  
> @@ -1002,7 +1017,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  
>  	link = parent->link_state;
>  	root = link->root;
> -	parent_link = link->parent;
> +	parent_dev = pci_get_parent(link->pdev);
> +	parent_link = parent_dev ? parent_dev->link_state : NULL;
>  
>  	/* All functions are removed, so just disable ASPM for the link */
>  	pcie_config_aspm_link(link, 0);
> -- 
> 2.20.1
> 
