Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 7D1674C33B
	for <lists+linux-pci@lfdr.de>; Wed, 19 Jun 2019 23:45:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730578AbfFSVpE (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 19 Jun 2019 17:45:04 -0400
Received: from mail.kernel.org ([198.145.29.99]:56864 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730574AbfFSVpE (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 19 Jun 2019 17:45:04 -0400
Received: from localhost (unknown [69.71.4.100])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8E1D4208CA;
        Wed, 19 Jun 2019 21:45:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1560980703;
        bh=xq3nh0b03CKV7/ml8UOF1l5b9iR5UaRfb5yS2tTRobE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=s68rn5cWw2JOtOq9KGBN4KE3onSVG07yaJh4C0Gbk5tMytYF4TcV+5Y4/1QRVWiAD
         AyKU8mo5SwKIRGA+be5GMlmZi5DLDFKnrrbzYHXh2PTHfAYWr6mGxJUGH3fTID8PMP
         fj62g/96hZadZbVVuDhk1LacvotRxOEs0q06soXo=
Date:   Wed, 19 Jun 2019 16:45:02 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Logan Gunthorpe <logang@deltatee.com>
Cc:     "linux-pci @ vger . kernel . org" <linux-pci@vger.kernel.org>,
        linux-kernel@vger.kernel.org,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2] PCI/P2PDMA: Root complex whitelist should not apply
 when an IOMMU is present
Message-ID: <20190619214502.GE143205@google.com>
References: <20190619185626.15806-1-logang@deltatee.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20190619185626.15806-1-logang@deltatee.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Wed, Jun 19, 2019 at 12:56:26PM -0600, Logan Gunthorpe wrote:
> Presently, there is no path to DMA map P2PDMA memory, so if a TLP
> targeting this memory hits the root complex and an IOMMU is present,
> the IOMMU will reject the transaction, even if the RC would support
> P2PDMA.
> 
> So until the kernel knows to map these DMA addresses in the IOMMU,
> we should not enable the whitelist when an IOMMU is present.
> 
> Link: https://lore.kernel.org/linux-pci/20190522201252.2997-1-logang@deltatee.com/
> Fixes: 0f97da831026 ("PCI/P2PDMA: Allow P2P DMA between any devices under AMD ZEN Root Complex")
> Signed-off-by: Logan Gunthorpe <logang@deltatee.com>
> Reviewed-by: Christian König <christian.koenig@amd.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Cc: Christoph Hellwig <hch@lst.de>

Applied to for-linus for v5.2, since we merged 0f97da831026 during the v5.2
merge window, thanks!

> ---
>  drivers/pci/p2pdma.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/pci/p2pdma.c b/drivers/pci/p2pdma.c
> index a98126ad9c3a..a4994aa3acc0 100644
> --- a/drivers/pci/p2pdma.c
> +++ b/drivers/pci/p2pdma.c
> @@ -18,6 +18,7 @@
>  #include <linux/percpu-refcount.h>
>  #include <linux/random.h>
>  #include <linux/seq_buf.h>
> +#include <linux/iommu.h>
>  
>  struct pci_p2pdma {
>  	struct gen_pool *pool;
> @@ -299,6 +300,9 @@ static bool root_complex_whitelist(struct pci_dev *dev)
>  	struct pci_dev *root = pci_get_slot(host->bus, PCI_DEVFN(0, 0));
>  	unsigned short vendor, device;
>  
> +	if (iommu_present(dev->dev.bus))
> +		return false;
> +
>  	if (!root)
>  		return false;
>  
> -- 
> 2.20.1
> 
