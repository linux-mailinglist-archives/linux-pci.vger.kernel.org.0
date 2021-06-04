Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5C93239C019
	for <lists+linux-pci@lfdr.de>; Fri,  4 Jun 2021 21:04:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230022AbhFDTGT (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Fri, 4 Jun 2021 15:06:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:49450 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S229810AbhFDTGT (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Fri, 4 Jun 2021 15:06:19 -0400
Received: by mail.kernel.org (Postfix) with ESMTPSA id 4AE5B601FA;
        Fri,  4 Jun 2021 19:04:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1622833472;
        bh=cer+Bvra6ed4Y1JhppV0+conxTw5XnnGzF6r3B03UOU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:From;
        b=Pgs6fH6TcnnUw8hfgWKlTOSTVfaEuwrfVRR8ujvSBTO324x6uWtuGOckoBCpzJ7Cb
         /wzC0Ws51l1cn/h0+mHDypRuLpORZWRkK2rN6n7inGVpTy0sIOtSEXE6TY7iUrtQNv
         IUbVAs85WZLnsAkjma8Xxz5Bl0Qjb/iTQTSAYHDUWXSfU/U6tDwXaZcC/SWh9T9F8y
         BZyhgWZxGfSS21qyebdNulqatlFqmMZx9cyuQjVNQpkXXgzIsy+i4lV/jxM98CNFYp
         40mrZty5gLW8tBI/pwa+/em5NIcUR1AWXQh8Yny2fywHYDvi1pGqGlh36R+RCqF3Qx
         RsgLqKfpASVOA==
Date:   Fri, 4 Jun 2021 14:04:30 -0500
From:   Bjorn Helgaas <helgaas@kernel.org>
To:     Wang Xingang <wangxingang5@huawei.com>
Cc:     robh@kernel.org, will@kernel.org, joro@8bytes.org,
        robh+dt@kernel.org, gregkh@linuxfoundation.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        linux-pci@vger.kernel.org, xieyingtai@huawei.com,
        John Garry <john.garry@huawei.com>
Subject: Re: [PATCH v4] iommu/of: Fix pci_request_acs() before enumerating
 PCI devices
Message-ID: <20210604190430.GA2220179@bjorn-Precision-5520>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1621566204-37456-1-git-send-email-wangxingang5@huawei.com>
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

[+cc John, who tested 6bf6c24720d3]

On Fri, May 21, 2021 at 03:03:24AM +0000, Wang Xingang wrote:
> From: Xingang Wang <wangxingang5@huawei.com>
> 
> When booting with devicetree, the pci_request_acs() is called after the
> enumeration and initialization of PCI devices, thus the ACS is not
> enabled. And ACS should be enabled when IOMMU is detected for the
> PCI host bridge, so add check for IOMMU before probe of PCI host and call
> pci_request_acs() to make sure ACS will be enabled when enumerating PCI
> devices.

I'm happy to apply this, but I'm a little puzzled about 6bf6c24720d3
("iommu/of: Request ACS from the PCI core when configuring IOMMU
linkage").  It was tested and fixed a problem, but I don't understand
how.

6bf6c24720d3 added the call to pci_request_acs() in
of_iommu_configure() so it currently looks like this:

  of_iommu_configure(dev, ...)
  {
    if (dev_is_pci(dev))
      pci_request_acs();

pci_request_acs() sets pci_acs_enable, which tells us to enable ACS
when enumerating PCI devices in the future.  But we only call
pci_request_acs() if we already *have* a PCI device.

So maybe 6bf6c24720d3 fixed a problem for *some* PCI devices, but not
all?  E.g., did we call of_iommu_configure() for one PCI device before
enumerating the rest?

> Fixes: 6bf6c24720d33 ("iommu/of: Request ACS from the PCI core when
> configuring IOMMU linkage")
> Signed-off-by: Xingang Wang <wangxingang5@huawei.com>
> ---
>  drivers/iommu/of_iommu.c | 1 -
>  drivers/pci/of.c         | 8 +++++++-
>  2 files changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/of_iommu.c b/drivers/iommu/of_iommu.c
> index a9d2df001149..54a14da242cc 100644
> --- a/drivers/iommu/of_iommu.c
> +++ b/drivers/iommu/of_iommu.c
> @@ -205,7 +205,6 @@ const struct iommu_ops *of_iommu_configure(struct device *dev,
>  			.np = master_np,
>  		};
>  
> -		pci_request_acs();
>  		err = pci_for_each_dma_alias(to_pci_dev(dev),
>  					     of_pci_iommu_init, &info);
>  	} else {
> diff --git a/drivers/pci/of.c b/drivers/pci/of.c
> index da5b414d585a..2313c3f848b0 100644
> --- a/drivers/pci/of.c
> +++ b/drivers/pci/of.c
> @@ -581,9 +581,15 @@ static int pci_parse_request_of_pci_ranges(struct device *dev,
>  
>  int devm_of_pci_bridge_init(struct device *dev, struct pci_host_bridge *bridge)
>  {
> -	if (!dev->of_node)
> +	struct device_node *node = dev->of_node;
> +
> +	if (!node)
>  		return 0;
>  
> +	/* Detect IOMMU and make sure ACS will be enabled */
> +	if (of_property_read_bool(node, "iommu-map"))
> +		pci_request_acs();
> +
>  	bridge->swizzle_irq = pci_common_swizzle;
>  	bridge->map_irq = of_irq_parse_and_map_pci;
>  
> -- 
> 2.19.1
> 
