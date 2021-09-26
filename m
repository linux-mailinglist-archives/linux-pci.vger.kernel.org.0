Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16E0A418B61
	for <lists+linux-pci@lfdr.de>; Mon, 27 Sep 2021 00:05:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbhIZWHQ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Sun, 26 Sep 2021 18:07:16 -0400
Received: from mail.kernel.org ([198.145.29.99]:43540 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230075AbhIZWHQ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Sun, 26 Sep 2021 18:07:16 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 178B161100;
        Sun, 26 Sep 2021 22:05:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1632693939;
        bh=tS1/crAEA80D5CGqe8i59AVp9KB33+js3SpvHBXPsl0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=iZmH58jSpDQNmsmfnobzjpvDgVQKstAkCgWwC9bCMQ55qX/ElpLFE/uQXcqJukZhM
         8PbcaUBesc60f3FhVpMYzkQfdzysSd7fWmErKnkdRMEk8ycZDLT2XSKmgdEP8pFTFY
         45dILmh7RHQFYceO7eQoygm5IPmM66Ccrk5T3+Wr1dpLkB4WD4TrQeJ9zyMV4osuAv
         J9lrni7dcyeR8YfH/PpTQ42DhzNCWmP89sNB31jVAnZaLK6nLpW8X5dvfDQh/pkDR+
         XEqZ0tYeE8k0MMYRhYkn1hodQW/u5V58JAh/EPBqcGZPGSGTbSEsP+//h/dntNR8GQ
         WaLSLStpG+K1A==
Date:   Sun, 26 Sep 2021 17:05:37 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     "Saheed O. Bolarinwa" <refactormyself@gmail.com>
Cc:     linux-pci@vger.kernel.org, linux-kernel@vger.kernel.org,
        kw@linux.com
Subject: Re: [RFC PATCH 1/4] PCI/ASPM: Remove struct pcie_link_state.parent
Message-ID: <20210926220537.GA591345@bhelgaas>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210916085206.2268-2-refactormyself@gmail.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Sep 16, 2021 at 10:52:03AM +0200, Saheed O. Bolarinwa wrote:
> From: "Bolarinwa O. Saheed" <refactormyself@gmail.com>
> 
> Information cached in struct pcie_link_state.parent is accessible
> via struct pci_dev.
> 
> This patch:
>  - removes *parent* from the *struct pcie_link_state*
>  - adjusts all references to it to access the information directly
> 
> Signed-off-by: Bolarinwa O. Saheed <refactormyself@gmail.com>
> ---
> OPINION: the checkpatch.pl scring warns on this line:
> 	`BUG_ON(root->pdev->bus->parent->self);`
> however, I think if a root device reports a parent, that is serious!

Do you mean this warning?

  WARNING: Missing a blank line after declarations
  #967: FILE: drivers/pci/pcie/aspm.c:967:
  +	struct pcie_link_state *link;
  +	BUG_ON(root->pdev->bus->parent->self);

That's just complaining about a blank line, so no big deal.  You could
resolve that by adding the blank line in this patch.

The fact that we use BUG_ON() at all *is* a real problem.  See the
comments at the BUG() definition.  We should rework this so that
condition is either impossible and we can just remove the BUG_ON(), or
we can deal with it gracefully.  But this would be material for a
different patch.

>  drivers/pci/pcie/aspm.c | 18 +++++++++++-------
>  1 file changed, 11 insertions(+), 7 deletions(-)
> 
> diff --git a/drivers/pci/pcie/aspm.c b/drivers/pci/pcie/aspm.c
> index 013a47f587ce..48b83048aa30 100644
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
> @@ -379,6 +378,7 @@ static void encode_l12_threshold(u32 threshold_us, u32 *scale, u32 *value)
>  static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  {
>  	u32 latency, l1_switch_latency = 0;
> +	struct pci_dev *parent;
>  	struct aspm_latency *acceptable;
>  	struct pcie_link_state *link;
>  
> @@ -419,7 +419,8 @@ static void pcie_aspm_check_latency(struct pci_dev *endpoint)
>  			link->aspm_capable &= ~ASPM_STATE_L1;
>  		l1_switch_latency += 1000;
>  
> -		link = link->parent;
> +		parent = link->pdev->bus->parent->self;
> +		link = !parent ? NULL : parent->link_state;

I love the direction of this patch, but this chain of pointers
(link->pdev->bus->parent->self) is a little over the top and is
repeated several times here.

Can we simplify it a bit by making a helper function?  It's similar
but not quite the same as pci_upstream_bridge().

And maybe reverse the condition to avoid the negation?

  link = parent ? parent->link_state : NULL;

>  	}
>  }
>  
> @@ -793,9 +794,11 @@ static void pcie_config_aspm_link(struct pcie_link_state *link, u32 state)
>  
>  static void pcie_config_aspm_path(struct pcie_link_state *link)
>  {
> +	struct pci_dev *parent;
>  	while (link) {
>  		pcie_config_aspm_link(link, policy_to_aspm_state(link));
> -		link = link->parent;
> +		parent = link->pdev->bus->parent->self;
> +		link = !parent ? NULL : parent->link_state;
>  	}
>  }
>  
> @@ -872,8 +875,7 @@ static struct pcie_link_state *alloc_pcie_link_state(struct pci_dev *pdev)
>  			return NULL;
>  		}
>  
> -		link->parent = parent;
> -		link->root = link->parent->root;
> +		link->root = parent->root;
>  	}
>  
>  	list_add(&link->sibling, &link_list);
> @@ -962,7 +964,7 @@ void pcie_aspm_init_link_state(struct pci_dev *pdev)
>  static void pcie_update_aspm_capable(struct pcie_link_state *root)
>  {
>  	struct pcie_link_state *link;
> -	BUG_ON(root->parent);
> +	BUG_ON(root->pdev->bus->parent->self);
>  	list_for_each_entry(link, &link_list, sibling) {
>  		if (link->root != root)
>  			continue;
> @@ -985,6 +987,7 @@ static void pcie_update_aspm_capable(struct pcie_link_state *root)
>  /* @pdev: the endpoint device */
>  void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  {
> +	struct pci_dev *parent_dev;
>  	struct pci_dev *parent = pdev->bus->self;
>  	struct pcie_link_state *link, *root, *parent_link;
>  
> @@ -1002,7 +1005,8 @@ void pcie_aspm_exit_link_state(struct pci_dev *pdev)
>  
>  	link = parent->link_state;
>  	root = link->root;
> -	parent_link = link->parent;
> +	parent_dev = link->pdev->bus->parent->self;
> +	parent_link = !parent_dev ? NULL : parent_dev->link_state;
>  
>  	/* All functions are removed, so just disable ASPM for the link */
>  	pcie_config_aspm_link(link, 0);
> -- 
> 2.20.1
> 
