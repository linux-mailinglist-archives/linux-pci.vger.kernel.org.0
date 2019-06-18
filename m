Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0714ABF9
	for <lists+linux-pci@lfdr.de>; Tue, 18 Jun 2019 22:40:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730546AbfFRUkJ (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Tue, 18 Jun 2019 16:40:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:53532 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730341AbfFRUkJ (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Tue, 18 Jun 2019 16:40:09 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F2D64206B7;
        Tue, 18 Jun 2019 20:40:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560890409;
        bh=x17FvCeBM56rG3zFRvk2baz4BO+YZfVKL1bZdkX4SVs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=rOzH6m0LLuiBMozHWP+SUkGHM0IM64fOqZ9bXAX8/wyFSipu2x/lOSPoKpsgVf5Lj
         AD5/HAPC8G66WHFXhjRHDW/cw1nGMS4ETGhg3GO0/Kxhbeo5gOcjNEalQ10nmfiwOI
         McW8TXRSaNuDI39Au7vsMLbK/c23hoXtf9hMtL5Q=
Date:   Tue, 18 Jun 2019 15:40:07 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     linux-pci@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>
Subject: Re: [PATCH] PCI/P2PDMA: Root complex whitelist should not apply when
 an IOMMU is present
Message-ID: <20190618204007.GB110859@google.com>
References: <20190522201252.2997-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190522201252.2997-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, May 22, 2019 at 02:12:52PM -0600, Logan Gunthorpe wrote:
> Presently, there is no path to DMA map P2PDMA memory, so if a TLP
> targeting this memory hits the root complex and an IOMMU is present,
> the IOMMU will reject the transaction, even if the RC would support
> P2PDMA.
> 
> So until the kernel knows to map these DMA addresses in the IOMMU,
> we should not enable the whitelist when an IOMMU is present.
> 
> While we are at it, remove the comment mentioning future work
> to add a white list.

There was a lot of discussion about this.  Did everybody come to a
consensus about what should be done?  Can you post a patch with
reviewed-by if appropriate?

> Fixes: 0f97da831026 ("PCI/P2PDMA: Allow P2P DMA between any devices under AMD ZEN Root Complex")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Cc: Christian König <christian.koenig@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> ---
>  drivers/pci/p2pdma.c | 7 +++++--
>  1 file changed, 5 insertions(+), 2 deletions(-)
> 
> Hey,
> 
> I realized recently that I missed this issue between the IOMMU and
> the whitelist when reviewing Christian's patch.
> 
> Unless there are any objections, I think this should be squashed
> with the commit marked in the Fixes tag (from pci-v5.2-changes).
> 
> Thanks,
> 
> Logan
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index 742928d0053e..4d2f6a44cba3 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -18,6 +18,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/random.h>
>  #include <linux/seq_buf.h>
> +#include <linux/iommu.h>
> 
>  struct pci_p2pdma {
>  	struct percpu_ref devmap_ref;
> @@ -284,6 +285,9 @@ static bool root_complex_whitelist(struct pci_dev *dev)
>  	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>  	unsigned short vendor, device;
> 
> +	if (iommu_present(dev->dev.bus))
> +		return false;
> +
>  	if (!root)
>  		return false;
> 
> @@ -453,8 +457,7 @@ static int upstream_bridge_distance_warn(struct pci_dev *provider,
>   *
>   * For now, "compatible" means the provider and the clients are all behind
>   * the same PCI root port. This cuts out cases that may work but is safest
> - * for the user. Future work can expand this to white-list root complexes that
> - * can safely forward between each ports.
> + * for the user.
>   */
>  int pci_p2pdma_distance_many(struct pci_dev *provider, struct device **clients,
>  			     int num_clients, bool verbose)
> --
> 2.20.1
