Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 09F7B339882
	for <lists+linux-pci@lfdr.de>; Fri, 12 Mar 2021 21:40:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234976AbhCLUj4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 12 Mar 2021 15:39:56 -0500
Received: from mail.kernel.org ([198.145.29.99]:37322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234936AbhCLUji (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 12 Mar 2021 15:39:38 -0500
Received: by mail.kernel.org (Postfix) with ESMTPSA id 7CA2864F4F;
        Fri, 12 Mar 2021 20:39:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1615581577;
        bh=9xbU4dGm9+BmmqkFklPfuZZosdug6fd3AsnEv7H5YFw=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=HwKo5k8pp1FCYm+q0FK8hZDzmOtZx9D48iVHE47cQK63UFdrBQCVKqUKLkgEBggln
         9ztDXjeFMO5NtU6M81ttmz3YIzjAGdpaoj3WUyaTpYbLYPOIKTitTDDSUkBhPVh3ei
         uZsnO60vXuNiDQWVZ67GOIH2ex/69BES8gJ7TKBgxsWmrOjmXpp0jtb76zJB+drQ+5
         ttjsPLmcKVIKwI3YB6xyobjyZP8xBLzeJdU5wwcKBBOdxC6tVTrjKJeom0pbVqECZk
         AfgwD4VNAjFL9YMwxOIBwj+mIvgXP13JwgZm35A3RHZfv+EulcxAypQ0uvjMBrvARD
         TGvtqBg9cRwfw==
Date:   Fri, 12 Mar 2021 14:39:36 -0600
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-kernel@vger.kernel.org, linux-nvme@lists.infradead.org,
        linux-block@vger.kernel.org, linux-pci@vger.kernel.org,
        linux-mm@kvack.org, iommu@lists.linux-foundation.org,
        Stephen Bates <sbates@raithlin.com>,
        Christoph Hellwig <hch@lst.de>,
        Dan Williams <dan.j.williams@intel.com>,
        Jason Gunthorpe <jgg@ziepe.ca>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Ira Weiny <iweiny@intel.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Don Dutile <ddutile@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Jakowski Andrzej <andrzej.jakowski@intel.com>,
        Minturn Dave B <dave.b.minturn@intel.com>,
        Jason Ekstrand <jason@jlekstrand.net>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Xiong Jianxin <jianxin.xiong@intel.com>
Subject: Re: [RFC PATCH v2 01/11] PCI/P2PDMA: Pass gfp_mask flags to
 upstream_bridge_distance_warn()
Message-ID: <20210312203936.GA2286981@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20210311233142.7900-2-logang@deltatee.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Thu, Mar 11, 2021 at 04:31:31PM -0700, Logan Gunthorpe wrote:
> In order to call this function from a dma_map function, it must not sleep.
> The only reason it does sleep so to allocate the seqbuf to print
> which devices are within the ACS path.

s/this function/upstream_bridge_distance_warn()/ ?
s/so to/is to/

Maybe the subject could say something about the purpose, e.g., allow
calling from atomic context or something?  "Pass gfp_mask flags" sort
of restates what we can read from the patch, but without the
motivation of why this is useful.

> Switch the kmalloc call to use a passed in gfp_mask  and don't print that
> message if the buffer fails to be allocated.
> 
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>

Acked-by: Bjorn Helgaas <bhelgaas@google.com>

> ---
>  drivers/pci/p2pdma.c | 21 +++++++++++----------
>  1 file changed, 11 insertions(+), 10 deletions(-)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 196382630363..bd89437faf06 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -267,7 +267,7 @@ static int pci_bridge_has_acs_redir(struct pci_dev *pdev)
>  
>  static void seq_buf_print_bus_devfn(struct seq_buf *buf, struct pci_dev *pdev)
>  {
> -	if (!buf)
> +	if (!buf || !buf->buffer)
>  		return;
>  
>  	seq_buf_printf(buf, "%s;", pci_name(pdev));
> @@ -495,25 +495,26 @@ upstream_bridge_distance(struct pci_dev *provider, struct pci_dev *client,
>  
>  static enum pci_p2pdma_map_type
>  upstream_bridge_distance_warn(struct pci_dev *provider, struct pci_dev *client,
> -			      int *dist)
> +			      int *dist, gfp_t gfp_mask)
>  {
>  	struct seq_buf acs_list;
>  	bool acs_redirects;
>  	int ret;
>  
> -	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, GFP_KERNEL), PAGE_SIZE);
> -	if (!acs_list.buffer)
> -		return -ENOMEM;
> +	seq_buf_init(&acs_list, kmalloc(PAGE_SIZE, gfp_mask), PAGE_SIZE);
>  
>  	ret = upstream_bridge_distance(provider, client, dist, &acs_redirects,
>  				       &acs_list);
>  	if (acs_redirects) {
>  		pci_warn(client, "ACS redirect is set between the client and provider (%s)\n",
>  			 pci_name(provider));
> -		/* Drop final semicolon */
> -		acs_list.buffer[acs_list.len-1] = 0;
> -		pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> -			 acs_list.buffer);
> +
> +		if (acs_list.buffer) {
> +			/* Drop final semicolon */
> +			acs_list.buffer[acs_list.len - 1] = 0;
> +			pci_warn(client, "to disable ACS redirect for this path, add the kernel parameter: pci=disable_acs_redir=%s\n",
> +				 acs_list.buffer);
> +		}
>  	}
>  
>  	if (ret == PCI_P2PDMA_MAP_NOT_SUPPORTED) {
> @@ -566,7 +567,7 @@ int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  
>  		if (verbose)
>  			ret = upstream_bridge_distance_warn(provider,
> -					pci_client, &distance);
> +					pci_client, &distance, GFP_KERNEL);
>  		else
>  			ret = upstream_bridge_distance(provider, pci_client,
>  						       &distance, NULL, NULL);
> -- 
> 2.20.1
> 
