Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 3617310EDE
	for <lists+linux-pci@lfdr.de>; Wed,  1 May 2019 23:58:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726183AbfEAV6G (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 1 May 2019 17:58:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37162 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726144AbfEAV6G (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 1 May 2019 17:58:06 -0400
Received: from localhost (odyssey.drury.edu [64.22.249.253])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 1EC612085A;
        Wed,  1 May 2019 21:58:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1556747885;
        bh=xZjoieoiaF6KMd/n1aT6l4cYdvV3M1MHn1xME2jfOoc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=w840NWaiT9V+Tg8eNh8PI/Krg+/JhPyr669Tjr9cdgijUyk0rXp3PUtNGWeCzLvEh
         I6vzSRigNygg46LeXGo256EnPx1/4K2M4d8yWNuoVRMmxybHdr6X0l7HyoYuhlNmbn
         aMaq7YHh1EvHOdPyHjW2SLB5is4cpUV2nzGwCPO0=
Date:   Wed, 1 May 2019 16:58:04 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Christian =?iso-8859-1?Q?K=F6nig?= 
        <ckoenig.leichtzumerken@gmail.com>
Cc:     logang@deltatee.com, rdunlap@infradead.org,
        linux-pci@vger.kernel.org
Subject: Re: [PATCH] PCI/P2PDMA: start with a whitelist for root complexes
Message-ID: <20190501215804.GA11579@google.com>
References: <20190418115859.2394-1-christian.koenig@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190418115859.2394-1-christian.koenig@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Apr 18, 2019 at 01:58:59PM +0200, Christian König wrote:
> A lot of root complexes can still do P2P even when PCI devices
> don't share a common upstream bridge.
> 
> Start adding a whitelist and allow P2P if both participants are
> attached to known good root complex.
> 
> Signed-off-by: Christian König <christian.koenig@amd.com>

I applied this with Logan's reviewed-by to pci/peer-to-peer for v5.2,
thanks!

This should be easy to build on in the future as we discover new
hardware that supports this and as we find out any quirks in the way
they do it.

> ---
>  drivers/pci/p2pdma.c | 38 +++++++++++++++++++++++++++++++++++---
>  1 file changed, 35 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index c52298d76e64..212baaa7f93b 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -274,6 +274,31 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
>  }
>  
> +/*
> + * If we can't find a common upstream bridge take a look at the root complex and
> + * compare it to a whitelist of known good hardware.
> + */
> +static bool root_complex_whitelist(struct pci_dev *dev)
> +{
> +	struct pci_host_bridge *host = pci_find_host_bridge(dev->bus);
> +	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
> +	unsigned short vendor, device;
> +
> +	if (!root)
> +		return false;
> +
> +	vendor = root->vendor;
> +	device = root->device;
> +	pci_dev_put(root);
> +
> +	/* AMD ZEN host bridges can do peer to peer */
> +	if (vendor == PCI_VENDOR_ID_AMD && device == 0x1450)
> +		return true;
> +
> +	/* TODO: Extend that to a proper whitelist */
> +	return false;
> +}
> +
>  /*
>   * Find the distance through the nearest common upstream bridge between
>   * two PCI devices.
> @@ -317,13 +342,13 @@ static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>   * In this case, a list of all infringing bridge addresses will be
>   * populated in acs_list (assuming it's non-null) for printk purposes.
>   */
> -static int upstream_bridge_distance(struct pci_dev *a,
> -				    struct pci_dev *b,
> +static int upstream_bridge_distance(struct pci_dev *provider,
> +				    struct pci_dev *client,
>  				    struct seq_buf *acs_list)
>  {
> +	struct pci_dev *a = provider, *b = client, *bb;
>  	int dist_a = 0;
>  	int dist_b = 0;
> -	struct pci_dev *bb = NULL;
>  	int acs_cnt = 0;
>  
>  	/*
> @@ -354,6 +379,13 @@ static int upstream_bridge_distance(struct pci_dev *a,
>  		dist_a++;
>  	}
>  
> +	/* Allow the connection if both devices are on a whitelisted root
> +	 * complex, but add an arbitary large value to the distance.
> +	 */
> +	if (root_complex_whitelist(provider) &&
> +	    root_complex_whitelist(client))
> +		return 0x1000 + dist_a + dist_b;
> +
>  	return -1;
>  
>  check_b_path_acs:
> -- 
> 2.17.1
> 
