Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5469E3AA5F8
	for <lists+linux-pci@lfdr.de>; Wed, 16 Jun 2021 23:11:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233900AbhFPVNK (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 16 Jun 2021 17:13:10 -0400
Received: from mail.kernel.org ([198.145.29.99]:41474 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S233836AbhFPVNK (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 16 Jun 2021 17:13:10 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 8645961185;
        Wed, 16 Jun 2021 21:11:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1623877863;
        bh=z2OzyDJCgpZX3W5DKmLw5Qmpho2XpHcXPPTCWYyHrN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=XjnKN56RsqwZSL+0td/zGPfupGBK64ZS1NS1j0D+Q14ew/2oSN1e3QrDiQUAK9xHb
         cF6JN0rMm40j1VitDZbEzJtGTcEYtrGaXUbvvgK/7gtNb+NGBXfIzMMdXjLRkHIyME
         je0Ln0lUdpduEQfNw4B1cQYn3ggck40+XqAdNazSG6iG6cM1iP0LUps7TgnXXT2+b6
         rxoITDGBcVIqd/TbMhRK3HccSBo0yESVM04m1Bmu55/aK0tinDxdGQG0+imIfnQJzL
         TnCgPxl9l//DuU/i/SnPyx+hilwdhEbYaRIjNSptajZlOKCjgqfgLEl+yDSdHrOoLw
         1iNBg97+yyMqg==
Date:   Wed, 16 Jun 2021 16:11:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christoph Hellwig <hch@lst.de>
Cc:     logang@deltatee.com, linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: simplify distance calculation
Message-ID: <20210616211102.GA3006716@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210614055310.3960791-1-hch@lst.de>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Mon, Jun 14, 2021 at 07:53:10AM +0200, Christoph Hellwig wrote:
> Merge __calc_map_type_and_dist and calc_map_type_and_dist_warn into
> calc_map_type_and_dist to simplify the code a bit.  This now means
> we add the devfn strings to the acs_buf unconditionallity even if
> the buffer is not printed, but that is not a lot of overhead and
> keeps the code much simpler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Applied with Logan's reviewed-by to pci/p2pdma for v5.14, thanks!

> ---
>  drivers/pci/p2pdma.c | 190 +++++++++++++++++--------------------------
>  1 file changed, 73 insertions(+), 117 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index deb097ceaf41..ca2574debb2d 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -388,79 +388,6 @@ static bool host_bridge_whitelist(struct pci_dev *a, struct pci_dev *b,
>  	return false;
>  }
>  
> -static enum pci_p2pdma_map_type
> -__calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> -		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
> -{
> -	struct pci_dev *a = provider, *b = client, *bb;
> -	int dist_a = 0;
> -	int dist_b = 0;
> -	int acs_cnt = 0;
> -
> -	if (acs_redirects)
> -		*acs_redirects = false;
> -
> -	/*
> -	 * Note, we don't need to take references to devices returned by
> -	 * pci_upstream_bridge() seeing we hold a reference to a child
> -	 * device which will already hold a reference to the upstream bridge.
> -	 */
> -
> -	while (a) {
> -		dist_b = 0;
> -
> -		if (pci_bridge_has_acs_redir(a)) {
> -			seq_buf_print_bus_devfn(acs_list, a);
> -			acs_cnt++;
> -		}
> -
> -		bb = b;
> -
> -		while (bb) {
> -			if (a == bb)
> -				goto check_b_path_acs;
> -
> -			bb = pci_upstream_bridge(bb);
> -			dist_b++;
> -		}
> -
> -		a = pci_upstream_bridge(a);
> -		dist_a++;
> -	}
> -
> -	if (dist)
> -		*dist = dist_a + dist_b;
> -
> -	return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> -
> -check_b_path_acs:
> -	bb = b;
> -
> -	while (bb) {
> -		if (a == bb)
> -			break;
> -
> -		if (pci_bridge_has_acs_redir(bb)) {
> -			seq_buf_print_bus_devfn(acs_list, bb);
> -			acs_cnt++;
> -		}
> -
> -		bb = pci_upstream_bridge(bb);
> -	}
> -
> -	if (dist)
> -		*dist = dist_a + dist_b;
> -
> -	if (acs_cnt) {
> -		if (acs_redirects)
> -			*acs_redirects = true;
> -
> -		return PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> -	}
> -
> -	return PCI_P2PDMA_MAP_BUS_ADDR;
> -}
> -
>  static unsigned long map_types_idx(struct pci_dev *client)
>  {
>  	return (pci_domain_nr(client->bus) << 16) |
> @@ -502,63 +429,96 @@ static unsigned long map_types_idx(struct pci_dev *client)
>   * PCI_P2PDMA_MAP_THRU_HOST_BRIDGE with the distance set to the number of
>   * ports per above. If the device is not in the whitelist, return
>   * PCI_P2PDMA_MAP_NOT_SUPPORTED.
> - *
> - * If any ACS redirect bits are set, then acs_redirects boolean will be set
> - * to true and their PCI device names will be appended to the acs_list
> - * seq_buf. This seq_buf is used to print a warning informing the user how
> - * to disable ACS using a command line parameter.  (See
> - * calc_map_type_and_dist_warn() below)
>   */
>  static enum pci_p2pdma_map_type
>  calc_map_type_and_dist(struct pci_dev *provider, struct pci_dev *client,
> -		int *dist, bool *acs_redirects, struct seq_buf *acs_list)
> +		int *dist, bool verbose)
>  {
> -	enum pci_p2pdma_map_type map_type;
> +	enum pci_p2pdma_map_type map_type = PCI_P2PDMA_MAP_THRU_HOST_BRIDGE;
> +	struct pci_dev *a = provider, *b = client, *bb;
> +	bool acs_redirects = false;
> +	struct seq_buf acs_list;
> +	int acs_cnt = 0;
> +	int dist_a = 0;
> +	int dist_b = 0;
> +	char buf[128];
> +
> +	seq_buf_init(&acs_list, buf, sizeof(buf));
> +
> +	/*
> +	 * Note, we don't need to take references to devices returned by
> +	 * pci_upstream_bridge() seeing we hold a reference to a child
> +	 * device which will already hold a reference to the upstream bridge.
> +	 */
> +	while (a) {
> +		dist_b = 0;
>  
> -	map_type = __calc_map_type_and_dist(provider, client, dist,
> -					    acs_redirects, acs_list);
> +		if (pci_bridge_has_acs_redir(a)) {
> +			seq_buf_print_bus_devfn(&acs_list, a);
> +			acs_cnt++;
> +		}
>  
> -	if (map_type == PCI_P2PDMA_MAP_THRU_HOST_BRIDGE) {
> -		if (!cpu_supports_p2pdma() &&
> -		    !host_bridge_whitelist(provider, client, acs_redirects))
> -			map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
> +		bb = b;
> +
> +		while (bb) {
> +			if (a == bb)
> +				goto check_b_path_acs;
> +
> +			bb = pci_upstream_bridge(bb);
> +			dist_b++;
> +		}
> +
> +		a = pci_upstream_bridge(a);
> +		dist_a++;
>  	}
>  
> -	if (provider->p2pdma)
> -		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
> -			 xa_mk_value(map_type), GFP_KERNEL);
> +	*dist = dist_a + dist_b;
> +	goto map_through_host_bridge;
>  
> -	return map_type;
> -}
> +check_b_path_acs:
> +	bb = b;
>  
> -static enum pci_p2pdma_map_type
> -calc_map_type_and_dist_warn(struct pci_dev *provider, struct pci_dev *client,
> -			    int *dist)
> -{
> -	struct seq_buf acs_list;
> -	bool acs_redirects;
> -	char buf[128];
> -	int ret;
> +	while (bb) {
> +		if (a == bb)
> +			break;
>  
> -	seq_buf_init(&acs_list, buf, sizeof(buf));
> +		if (pci_bridge_has_acs_redir(bb)) {
> +			seq_buf_print_bus_devfn(&acs_list, bb);
> +			acs_cnt++;
> +		}
>  
> -	ret = calc_map_type_and_dist(provider, client, dist, &acs_redirects,
> -				     &acs_list);
> -	if (acs_redirects) {
> +		bb = pci_upstream_bridge(bb);
> +	}
> +
> +	*dist = dist_a + dist_b;
> +
> +	if (!acs_cnt) {
> +		map_type = PCI_P2PDMA_MAP_BUS_ADDR;
> +		goto done;
> +	}
> +
> +	if (verbose) {
> +		acs_list.buffer[acs_list.len-1] = 0; /* drop final semicolon */
>  		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
>  			 pci_name(provider));
> -		/* Drop final semicolon */
> -		acs_list.buffer[acs_list.len-1] = 0;
>  		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
>  			 acs_list.buffer);
>  	}
> +	acs_redirects = true;
>  
> -	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
> -		pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
> -			 pci_name(provider));
> +map_through_host_bridge:
> +	if (!cpu_supports_p2pdma() &&
> +	    !host_bridge_whitelist(provider, client, acs_redirects)) {
> +		if (verbose)
> +			pci_warn(client, "cannot be used for peer-to-peer DMA as the client and provider (%s) do not share an upstream bridge or whitelisted host bridge\n",
> +				 pci_name(provider));
> +		map_type = PCI_P2PDMA_MAP_NOT_SUPPORTED;
>  	}
> -
> -	return ret;
> +done:
> +	if (provider->p2pdma)
> +		xa_store(&provider->p2pdma->map_types, map_types_idx(client),
> +			 xa_mk_value(map_type), GFP_KERNEL);
> +	return map_type;
>  }
>  
>  /**
> @@ -599,12 +559,8 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  			return -1;
>  		}
>  
> -		if (verbose)
> -			map = calc_map_type_and_dist_warn(provider, pci_client,
> -							  &distance);
> -		else
> -			map = calc_map_type_and_dist(provider, pci_client,
> -						     &distance, NULL, NULL);
> +		map = calc_map_type_and_dist(provider, pci_client, &distance,
> +					     verbose);
>  
>  		pci_dev_put(pci_client);
>  
> -- 
> 2.30.2
> 
