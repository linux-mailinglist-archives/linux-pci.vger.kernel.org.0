Return-Path: <linux-pci+bounces-9095-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sv.mirrors.kernel.org (sv.mirrors.kernel.org [139.178.88.99])
	by mail.lfdr.de (Postfix) with ESMTPS id 31B64912ECD
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 22:47:45 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by sv.mirrors.kernel.org (Postfix) with ESMTPS id DCA67287705
	for <lists+linux-pci@lfdr.de>; Fri, 21 Jun 2024 20:47:43 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 4AF1917B41A;
	Fri, 21 Jun 2024 20:47:40 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="mgZE+prv"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 1769C16849B;
	Fri, 21 Jun 2024 20:47:39 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1719002860; cv=none; b=NTAuXNbZjP1zhcXbnDWu2XGX3msy5cLGGHuKsFt5RXFQ+b5VF+m1agM0oo4+cRcJL3lp4S1JsZ/cFNTyRGG3dmaq0QUeLO/86cV+zWtkb0EzjEwH1+fbbTnkNAQUZjL64qNUVWcee4OmITeY7Qz6Z8b+r+mt4mZ7WNk0ilfBVoQ=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1719002860; c=relaxed/simple;
	bh=6oXviKiBbq49pqIG63dpMmIAKuxF/Q4figgiB/INR0s=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=RPcI78hBW8gKGcgsEdRD4ZMsts6R/p7BE8XP1+2QveRuhA+NyOApfyTGCZUcFP2GEc4KIlLFQdXka10/e065nvTvA6JjLcBxuiIevi/XIY3I9ArONmEJp6MqOwjVyywKMwGXPY/8thIgS+bdz6reFR92MRimcwO24NXpEvVkr9U=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=mgZE+prv; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 50BF7C2BBFC;
	Fri, 21 Jun 2024 20:47:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1719002859;
	bh=6oXviKiBbq49pqIG63dpMmIAKuxF/Q4figgiB/INR0s=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=mgZE+prvJvrR0qGr16cRFd5wxBZ+60DqVKiWrzc2/JqP0zX1t4uEG+eb7p9STep28
	 GFEtp+5Wlh7ZMOpCAEP7/Pw8BGI79tl01RS7sEnMpm1jP5279v6NnYALGdYuBQTOMe
	 QQEQ3MZ/bGLOO3jSSXpFLPhkZLHuPdDu/9RwwoLYmuEB4oZ8CNAYwo50alk9nx3q0v
	 FKl3LLJMekFrCRYY6x6VTRZsjNkxUNIms8xbhzkqEPT0w7Vrw0KG0HjuCWtBhABDna
	 mlYDTeAzZklySDxXUnTtwfdNn9S+Ve/T8B5v0hfR+GUchO4IV+ltKrQru60xWT+mcQ
	 dQllYmBRKAFaA==
Date: Fri, 21 Jun 2024 15:47:37 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
Cc: linux-pci@vger.kernel.org, bhelgaas@google.com,
	linux-kernel@vger.kernel.org, sumanesh.samanta@broadcom.com,
	sathya.prakash@broadcom.com, Logan Gunthorpe <logang@deltatee.com>
Subject: Re: [PATCH 2/2] pci/p2pdma: Modify p2p_dma_distance to detect
 virtual P2P links
Message-ID: <20240621204737.GA1374564@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1718191656-32714-3-git-send-email-shivasharan.srikanteshwara@broadcom.com>

[+cc Logan]

On Wed, Jun 12, 2024 at 04:27:36AM -0700, Shivasharan S wrote:
> Update the p2p_dma_distance() to determine virtual inter-switch P2P links
> existing between two switches and use this to calculate the DMA distance
> between two devices.
> 
> Signed-off-by: Shivasharan S <shivasharan.srikanteshwara@broadcom.com>
> ---
>  drivers/pci/Kconfig  |  1 +
>  drivers/pci/p2pdma.c | 18 +++++++++++++++++-
>  2 files changed, 18 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/pci/Kconfig b/drivers/pci/Kconfig
> index d35001589d88..3e6226ec91fd 100644
> --- a/drivers/pci/Kconfig
> +++ b/drivers/pci/Kconfig
> @@ -174,6 +174,7 @@ config PCI_P2PDMA
>  	depends on 64BIT
>  	select GENERIC_ALLOCATOR
>  	select NEED_SG_DMA_FLAGS
> +	select PCI_SW_DISCOVERY
>  	help
>  	  Enables drivers to do PCI peer-to-peer transactions to and from
>  	  BARs that are exposed in other devices that are the part of
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4f47a13cb500..780e649b3a1d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -21,6 +21,8 @@
>  #include <linux/seq_buf.h>
>  #include <linux/xarray.h>
>  
> +extern bool sw_disc_check_virtual_link(struct pci_dev *a, struct pci_dev *b);

This isn't the way we declare external references.  Probably
drivers/pci/pci.h.  Would need a "pci_" or "pcie_" prefix.

>  struct pci_p2pdma {
>  	struct gen_pool *pool;
>  	bool p2pmem_published;
> @@ -576,7 +578,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  		int *dist, bool verbose)
>  {
>  	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> -	struct pci_dev *a = provider, *b = client, *bb;
> +	struct pci_dev *a = provider, *b = client, *bb, *b_virtual_link = NULL;
>  	bool acs_redirects = false;
>  	struct pci_p2pdma *p2pdma;
>  	struct seq_buf acs_list;
> @@ -606,6 +608,17 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  			if (a == bb)
>  				goto check_b_path_acs;
>  
> +			// Physical Broadcom PEX switches can be provisioned into
> +			// multiple virtual switches.
> +			// if both upstream bridges belong to the same physical
> +			// switch, and the switch supports P2P,
> +			// p2p_dma_distance() should take into account of such
> +			// scenarios.

Copy the comment style (/* */) of the rest of the file.  Rewrap to fit
in 80 columns like the rest of the file.  Capitalize sentences.  Add
blank line between paragraphs.

> +			if (sw_disc_check_virtual_link(a, bb)) {
> +				b_virtual_link = bb;
> +				goto check_b_path_acs;
> +			}
> +
>  			bb = pci_upstream_bridge(bb);
>  			dist_b++;
>  		}
> @@ -629,6 +642,9 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  			acs_cnt++;
>  		}
>  
> +		if (b_virtual_link && bb == b_virtual_link)
> +			break;
> +
>  		bb = pci_upstream_bridge(bb);
>  	}
>  
> -- 
> 2.43.0
> 



