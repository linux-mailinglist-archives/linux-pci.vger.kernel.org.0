Return-Path: <linux-pci+bounces-43603-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from sea.lore.kernel.org (sea.lore.kernel.org [172.234.253.10])
	by mail.lfdr.de (Postfix) with ESMTPS id A2E86CD9ED4
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 17:23:07 +0100 (CET)
Received: from smtp.subspace.kernel.org (conduit.subspace.kernel.org [100.90.174.1])
	by sea.lore.kernel.org (Postfix) with ESMTP id C9CFD303BBD2
	for <lists+linux-pci@lfdr.de>; Tue, 23 Dec 2025 16:22:26 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id EC50832827D;
	Tue, 23 Dec 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="f40u1nK2"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id B78D43148B3;
	Tue, 23 Dec 2025 16:22:24 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1766506944; cv=none; b=UOYu2gbwyYiGxW177LzPBJvyGUa3k3qRVQIH2EZelho4FvtX6ODLTpK+bPagd5u2DTjzKGlutDEdFUHO5JlbAYLMbLiHongUPKCFRbVNLOBMZemGaH+zW58I3K4n9iNDfZEAyeRfezeX4n929MFPHNRvd4hPWoO01EgQ6ogR9No=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1766506944; c=relaxed/simple;
	bh=ghdK3k8HC0d+pZ7Vp2Q/ozvdOE31c9CqJV1yRUZ01TE=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=KdLq3n+waetznZ0nlJ6cMuJ9jLbpVNRZOH9xrEgVO+TIyh9WEUUegQlwhCtPKpRt6Mqddhfxdl67PM2iqzcgxD2RQaEgCIxnCpRA4MxA1v2fn/MZsSMW564wR7w4sVb9QIw6zvh8ZrMl/E3ItNUrEDW1edqfxy49MWXaQ6tqB2E=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=f40u1nK2; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B1ABC113D0;
	Tue, 23 Dec 2025 16:22:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1766506944;
	bh=ghdK3k8HC0d+pZ7Vp2Q/ozvdOE31c9CqJV1yRUZ01TE=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=f40u1nK24Yb8eMbhaW5pQ/D7i1Rw4HmkYlX5TaH9mwqokQnCnADyqo7MXggoa8IPb
	 RNpISUHd3HLL3lvksMwbUeDM3yGyQviT/ITGnHNdDsqSLHKrefHSYxmwiwTrIH09eD
	 C7u4tgGSVl7n1ud7V0nVWOxmBKhZ81FPpfNE2hprIuQY/hnOWCQ9qAonAKje90QLGv
	 U90tPYJeovuWK16/IjTk3s/cEp3jf08zA3udDBfwuXlQZWW5HuG9NrynnyBuBu/gDR
	 wXEyLNgYsymJ2dZn1GF9P/kvdm2HOt4MHWFlQFDB2tOdRG8uNIr+/F4Es28Dv2m1ta
	 V00mrI86umqgA==
Date: Tue, 23 Dec 2025 10:22:22 -0600
From: Bjorn Helgaas <helgaas@kernel.org>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc: Manivannan Sadhasivam <mani@kernel.org>,
	Krzysztof =?utf-8?Q?Wilczy=C5=84ski?= <kwilczynski@kernel.org>,
	Kishon Vijay Abraham I <kishon@kernel.org>,
	Bjorn Helgaas <bhelgaas@google.com>, linux-kernel@vger.kernel.org,
	kernel-janitors@vger.kernel.org, linux-pci@vger.kernel.org
Subject: Re: [PATCH] scsi: target: Constify struct configfs_item_operations
 and configfs_group_operations
Message-ID: <20251223162222.GA4022020@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f1f05f6c1bc0c6f37cd680f012fe08c525364968.1765705512.git.christophe.jaillet@wanadoo.fr>

On Sun, Dec 14, 2025 at 10:45:29AM +0100, Christophe JAILLET wrote:
> 'struct configfs_item_operations' and 'configfs_group_operations' are not
> modified in this driver.
> 
> Constifying these structures moves some data to a read-only section, so
> increases overall security, especially when the structure holds some
> function pointers.

Sounds plausible, except that there's no apparent connection with scsi
(as suggested by the subject).  Will wait for a revision that matches
history of this file.

> On a x86_64, with allmodconfig:
> Before:
> ======
>    text	   data	    bss	    dec	    hex	filename
>   27503	  12184	    256	  39943	   9c07	drivers/pci/endpoint/pci-ep-cfs.o
> 
> After:
> =====
>    text	   data	    bss	    dec	    hex	filename
>   27855	  11832	    256	  39943	   9c07	drivers/pci/endpoint/pci-ep-cfs.o
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> Compile tested only.
> 
> This change is possible since commits f2f36500a63b and f7f78098690d.
> ---
>  drivers/pci/endpoint/pci-ep-cfs.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/pci/endpoint/pci-ep-cfs.c b/drivers/pci/endpoint/pci-ep-cfs.c
> index ef50c82e647f..034a31c341c9 100644
> --- a/drivers/pci/endpoint/pci-ep-cfs.c
> +++ b/drivers/pci/endpoint/pci-ep-cfs.c
> @@ -85,7 +85,7 @@ static void pci_secondary_epc_epf_unlink(struct config_item *epc_item,
>  	pci_epc_remove_epf(epc, epf, SECONDARY_INTERFACE);
>  }
>  
> -static struct configfs_item_operations pci_secondary_epc_item_ops = {
> +static const struct configfs_item_operations pci_secondary_epc_item_ops = {
>  	.allow_link	= pci_secondary_epc_epf_link,
>  	.drop_link	= pci_secondary_epc_epf_unlink,
>  };
> @@ -149,7 +149,7 @@ static void pci_primary_epc_epf_unlink(struct config_item *epc_item,
>  	pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
>  }
>  
> -static struct configfs_item_operations pci_primary_epc_item_ops = {
> +static const struct configfs_item_operations pci_primary_epc_item_ops = {
>  	.allow_link	= pci_primary_epc_epf_link,
>  	.drop_link	= pci_primary_epc_epf_unlink,
>  };
> @@ -257,7 +257,7 @@ static void pci_epc_epf_unlink(struct config_item *epc_item,
>  	pci_epc_remove_epf(epc, epf, PRIMARY_INTERFACE);
>  }
>  
> -static struct configfs_item_operations pci_epc_item_ops = {
> +static const struct configfs_item_operations pci_epc_item_ops = {
>  	.allow_link	= pci_epc_epf_link,
>  	.drop_link	= pci_epc_epf_unlink,
>  };
> @@ -508,7 +508,7 @@ static void pci_epf_release(struct config_item *item)
>  	kfree(epf_group);
>  }
>  
> -static struct configfs_item_operations pci_epf_ops = {
> +static const struct configfs_item_operations pci_epf_ops = {
>  	.allow_link		= pci_epf_vepf_link,
>  	.drop_link		= pci_epf_vepf_unlink,
>  	.release		= pci_epf_release,
> @@ -662,7 +662,7 @@ static void pci_epf_drop(struct config_group *group, struct config_item *item)
>  	config_item_put(item);
>  }
>  
> -static struct configfs_group_operations pci_epf_group_ops = {
> +static const struct configfs_group_operations pci_epf_group_ops = {
>  	.make_group     = &pci_epf_make,
>  	.drop_item      = &pci_epf_drop,
>  };
> -- 
> 2.52.0
> 

