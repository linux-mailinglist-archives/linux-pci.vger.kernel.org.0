Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 935CB3A6C8C
	for <lists+linux-pci@lfdr.de>; Mon, 14 Jun 2021 18:59:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234758AbhFNRBU (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Mon, 14 Jun 2021 13:01:20 -0400
Received: from ale.deltatee.com ([204.191.154.188]:33718 "EHLO
        ale.deltatee.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233206AbhFNRBT (ORCPT
        <rfc822;linux-pci@vger.kernel.org>); Mon, 14 Jun 2021 13:01:19 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=deltatee.com; s=20200525; h=Subject:In-Reply-To:MIME-Version:Date:
        Message-ID:From:References:Cc:To:content-disposition;
        bh=tIzgvFT3Jww6YVlLNk8gXbWzFfChiBPuWv34uUgmMIw=; b=QElH4AGtAwQ14iQ3sZOYgERTBG
        olqRQDkQn8Nb7KF8nrf810a84dfJRnCXT8ERtz7uT7MO1RJdylH8I+Pgh92dj5aW5tO+nv/roaGr9
        ++zY/2Fv6l4tXZmFGPYOqiEGrqX7Y50m45jjLHAO/UE/m8fJrk/WjAcDXMJIlHvWEN7w0T+XopLer
        1N/UfAQndu73lzXyOvRPBAWo5Hxc9DXS7dqiHOqISfGRtDK9fXi+B/+qdFRHrFggyenHE1StOckA/
        HKnQ7DJyvX88dvzrF+oJvCXZuGfZnUqYecpr6FQuHghGflsMVD4vyj1Yb12fAi8z+ra8/F2Ns3I2m
        fyALFdCA==;
Received: from guinness.priv.deltatee.com ([172.16.1.162])
        by ale.deltatee.com with esmtp (Exim 4.92)
        (envelope-from <logang@deltatee.com>)
        id 1lspve-0000RM-S3; Mon, 14 Jun 2021 10:59:16 -0600
To:     Christoph Hellwig <hch@lst.de>, helgaas@kernel.org
Cc:     linux-pci@vger.kernel.org
References: <20210614055310.3960791-1-hch@lst.de>
From:   Logan Gunthorpe <logang@deltatee.com>
Message-ID: <da9cebf5-0d95-5520-6465-ebe06beaa9dc@deltatee.com>
Date:   Mon, 14 Jun 2021 10:59:14 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.10.0
MIME-Version: 1.0
In-Reply-To: <20210614055310.3960791-1-hch@lst.de>
Content-Type: text/plain; charset=utf-8
Content-Language: en-CA
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 172.16.1.162
X-SA-Exim-Rcpt-To: linux-pci@vger.kernel.org, helgaas@kernel.org, hch@lst.de
X-SA-Exim-Mail-From: logang@deltatee.com
X-Spam-Checker-Version: SpamAssassin 3.4.2 (2018-09-13) on ale.deltatee.com
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=5.0 tests=ALL_TRUSTED,BAYES_00,
        NICE_REPLY_A autolearn=ham autolearn_force=no version=3.4.2
Subject: Re: [PATCH] PCI/P2PDMA: simplify distance calculation
X-SA-Exim-Version: 4.2.1 (built Wed, 08 May 2019 21:11:16 +0000)
X-SA-Exim-Scanned: Yes (on ale.deltatee.com)
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org



On 2021-06-13 11:53 p.m., Christoph Hellwig wrote:
> Merge __calc_map_type_and_dist and calc_map_type_and_dist_warn into
> calc_map_type_and_dist to simplify the code a bit.  This now means
> we add the devfn strings to the acs_buf unconditionallity even if
> the buffer is not printed, but that is not a lot of overhead and
> keeps the code much simpler.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

Looks good to me, Thanks.

Reviewed-by: Logan Gunthorpe <logang@deltatee.com>

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
> 
