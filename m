Return-Path: <linux-pci+bounces-15015-lists+linux-pci=lfdr.de@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from am.mirrors.kernel.org (am.mirrors.kernel.org [IPv6:2604:1380:4601:e00::3])
	by mail.lfdr.de (Postfix) with ESMTPS id EC72F9AB1CC
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 17:16:23 +0200 (CEST)
Received: from smtp.subspace.kernel.org (wormhole.subspace.kernel.org [52.25.139.140])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by am.mirrors.kernel.org (Postfix) with ESMTPS id 867C01F21405
	for <lists+linux-pci@lfdr.de>; Tue, 22 Oct 2024 15:16:23 +0000 (UTC)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
	by smtp.subspace.kernel.org (Postfix) with ESMTP id 9EAD419C547;
	Tue, 22 Oct 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org;
	dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b="ivQFemiV"
X-Original-To: linux-pci@vger.kernel.org
Received: from smtp.kernel.org (aws-us-west-2-korg-mail-1.web.codeaurora.org [10.30.226.201])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.subspace.kernel.org (Postfix) with ESMTPS id 77CA34A18
	for <linux-pci@vger.kernel.org>; Tue, 22 Oct 2024 15:16:19 +0000 (UTC)
Authentication-Results: smtp.subspace.kernel.org; arc=none smtp.client-ip=10.30.226.201
ARC-Seal:i=1; a=rsa-sha256; d=subspace.kernel.org; s=arc-20240116;
	t=1729610179; cv=none; b=WCQUYxfeKyDeBVl9Ngdl8KXdNYIpwUKrn2LaX9/V6U8R6bQ8t2V1sAzUHMuD/S3qfW9lzU0gVrJGg6qn+tD4arI7U7wxMkx/y7b+30j/zA0lRHmxG7Vr3XULvuTDPcwRttpPNXpTL/MS/yoiwn53Db4TeaVzHlzrjVk1kKzccxc=
ARC-Message-Signature:i=1; a=rsa-sha256; d=subspace.kernel.org;
	s=arc-20240116; t=1729610179; c=relaxed/simple;
	bh=3vo+Tezf/hG7U5f8ffsLl14MxsehQRUwibe+lD2jl3o=;
	h=Date:From:To:Cc:Subject:Message-ID:MIME-Version:Content-Type:
	 Content-Disposition:In-Reply-To; b=k4PHemGOGi74OrQ2eLS2z1OCwPmdyTaOBBWvVQ9OLERARjn8jY8jHRNcGIfe6Iu4hydP6CyOwO1oEKeBGBiWxAsvI7M2HYy4P6JpFO8JeQtU8hzbfaLEDgplTFC3GxrLXuAoxuNqPU7/mGiOUD2DR2IFyezDhxo4I2OUNiLxoc0=
ARC-Authentication-Results:i=1; smtp.subspace.kernel.org; dkim=pass (2048-bit key) header.d=kernel.org header.i=@kernel.org header.b=ivQFemiV; arc=none smtp.client-ip=10.30.226.201
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFA96C4CEC3;
	Tue, 22 Oct 2024 15:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1729610179;
	bh=3vo+Tezf/hG7U5f8ffsLl14MxsehQRUwibe+lD2jl3o=;
	h=Date:From:To:Cc:Subject:In-Reply-To:From;
	b=ivQFemiVu3g0JMr+J+bFUbiqEolLhZrcDDFBF1VZg0czcW+pQXwNDm+Yiy6e64sM5
	 wt2/B4lo39d0QMDiu1mBYpYRzyJFdMFeEX8FNLzHiiRmfws1NOz20gH5nBQQHP9rfZ
	 TtsDGB0aGH7x0gqAiTE4L+FAklQePcSd14SocufnFwaROKI3ZJqjjRBgUpnZfqhST+
	 euZ4lpspsKuEA9kpj72K9eGB9fV2dNa0wyeuEFJGa4ShIYuoXNamQ3t3N99p+5wSgi
	 xazFSInVCv9vmKD9cRXfs+czpURwfr6c6qzA2AKuGe5plRh0iVuXHAIPhJFKRzmQyK
	 96Zwf9GPex7Og==
Date: Tue, 22 Oct 2024 10:16:16 -0500
From: Bjorn Helgaas <helgaas@kernel.org>
To: Vivek Kasireddy <vivek.kasireddy@intel.com>
Cc: dri-devel@lists.freedesktop.org, intel-xe@lists.freedesktop.org,
	Bjorn Helgaas <bhelgaas@google.com>,
	Logan Gunthorpe <logang@deltatee.com>, linux-pci@vger.kernel.org
Subject: Re: [PATCH v2 1/5] PCI/P2PDMA: Don't enforce ACS check for functions
 of same device
Message-ID: <20241022151616.GA879071@bhelgaas>
Precedence: bulk
X-Mailing-List: linux-pci@vger.kernel.org
List-Id: <linux-pci.vger.kernel.org>
List-Subscribe: <mailto:linux-pci+subscribe@vger.kernel.org>
List-Unsubscribe: <mailto:linux-pci+unsubscribe@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20241021052236.1820329-2-vivek.kasireddy@intel.com>

On Sun, Oct 20, 2024 at 10:21:29PM -0700, Vivek Kasireddy wrote:
> Functions of the same PCI device (such as a PF and a VF) share the
> same bus and have a common root port and typically, the PF provisions
> resources for the VF. Therefore, they can be considered compatible
> as far as P2P access is considered.
> 
> Currently, although the distance (2) is correctly calculated for
> functions of the same device, an ACS check failure prevents P2P DMA
> access between them. Therefore, introduce a small function named
> pci_devs_are_p2pdma_compatible() to determine if the provider and
> client belong to the same device and facilitate P2P DMA between
> them by not enforcing the ACS check.
> 
> v2:
> - Relax the enforcment of ACS check only for Intel GPU functions
>   as they are P2PDMA compatible given the way the PF provisions
>   the resources among multiple VFs.

I don't want version history in the commit log.  If the content is
useful, just incorporate it here directly (without the version info),
and put the version-to-version changelog below the "---".

> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Logan Gunthorpe <logang@deltatee.com>
> Cc: <linux-pci@vger.kernel.org>
> Signed-off-by: Vivek Kasireddy <vivek.kasireddy@intel.com>
> ---
>  drivers/pci/p2pdma.c | 17 +++++++++++++++--
>  1 file changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 4f47a13cb500..a230e661f939 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -535,6 +535,17 @@ static unsigned long map_types_idx(struct pci_dev *client)
>  	return (pci_domain_nr(client->bus) << 16) | pci_dev_id(client);
>  }
>  
> +static bool pci_devs_are_p2pdma_compatible(struct pci_dev *provider,
> +					   struct pci_dev *client)
> +{
> +	if (provider->vendor == PCI_VENDOR_ID_INTEL) {
> +		if (pci_is_vga(provider) && pci_is_vga(client))
> +			return pci_physfn(provider) == pci_physfn(client);
> +	}

This doesn't explain why this should be specific to Intel or VGA.  As
far as I can tell, everything mentioned in the commit log is generic.

I see the previous comments
(https://lore.kernel.org/all/eddb423c-945f-40c9-b904-43ea8371f1c4@deltatee.com/),
but none of that context was captured here.

I'm not sure what you refer to by "PF provisions resources for the
VF".  Isn't it *always* the case that the architected PCI resources
(BARs) are configured by the PF?  It sounds like you're referring to
something Intel GPU-specific beyond that?

> +	return false;
> +}
> +
>  /*
>   * Calculate the P2PDMA mapping type and distance between two PCI devices.
>   *
> @@ -634,7 +645,7 @@ calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
>  
>  	*dist = dist_a + dist_b;
>  
> -	if (!acs_cnt) {
> +	if (!acs_cnt || pci_devs_are_p2pdma_compatible(provider, client)) {
>  		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
>  		goto done;
>  	}
> @@ -696,7 +707,9 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  		return -1;
>  
>  	for (i = 0; i < num_clients; i++) {
> -		pci_client = find_parent_pci_dev(clients[i]);
> +		pci_client = dev_is_pf(clients[i]) ?
> +				pci_dev_get(to_pci_dev(clients[i])) :
> +				find_parent_pci_dev(clients[i]);
>  		if (!pci_client) {
>  			if (verbose)
>  				dev_warn(clients[i],
> -- 
> 2.45.1
> 

