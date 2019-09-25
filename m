Return-Path: <linux-pci-owner@vger.kernel.org>
X-Original-To: lists+linux-pci@lfdr.de
Delivered-To: lists+linux-pci@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.lfdr.de (Postfix) with ESMTP id 5A712BDC40
	for <lists+linux-pci@lfdr.de>; Wed, 25 Sep 2019 12:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390095AbfIYKh4 (ORCPT <rfc822;lists+linux-pci@lfdr.de>);
        Wed, 25 Sep 2019 06:37:56 -0400
Received: from foss.arm.com ([217.140.110.172]:46198 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389655AbfIYKh4 (ORCPT <rfc822;linux-pci@vger.kernel.org>);
        Wed, 25 Sep 2019 06:37:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 44E331570;
        Wed, 25 Sep 2019 03:37:55 -0700 (PDT)
Received: from localhost (unknown [10.37.6.20])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B14223F694;
        Wed, 25 Sep 2019 03:37:54 -0700 (PDT)
Date:   Wed, 25 Sep 2019 11:37:53 +0100
From:   Andrew Murray <andrew.murray@arm.com>
To:     Rob Herring <robh@kernel.org>
Cc:     linux-pci@vger.kernel.org, Bjorn Helgaas <bhelgaas@google.com>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH 05/11] PCI: versatile: Use
 pci_parse_request_of_pci_ranges()
Message-ID: <20190925103752.GS9720@e119886-lin.cambridge.arm.com>
References: <20190924214630.12817-1-robh@kernel.org>
 <20190924214630.12817-6-robh@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20190924214630.12817-6-robh@kernel.org>
User-Agent: Mutt/1.10.1+81 (426a6c1) (2018-08-26)
Sender: linux-pci-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-pci.vger.kernel.org>
X-Mailing-List: linux-pci@vger.kernel.org

On Tue, Sep 24, 2019 at 04:46:24PM -0500, Rob Herring wrote:
> Convert ARM Versatile host bridge to use the common
> pci_parse_request_of_pci_ranges().
> 
> Cc: Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>
> Cc: Bjorn Helgaas <bhelgaas@google.com>
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  drivers/pci/controller/pci-versatile.c | 62 +++++---------------------
>  1 file changed, 11 insertions(+), 51 deletions(-)
> 
> diff --git a/drivers/pci/controller/pci-versatile.c b/drivers/pci/controller/pci-versatile.c
> index f59ad2728c0b..237b1abb26f2 100644
> --- a/drivers/pci/controller/pci-versatile.c
> +++ b/drivers/pci/controller/pci-versatile.c
> @@ -62,60 +62,12 @@ static struct pci_ops pci_versatile_ops = {
>  	.write	= pci_generic_config_write,
>  };
>  
> -static int versatile_pci_parse_request_of_pci_ranges(struct device *dev,
> -						     struct list_head *res)
> -{
> -	int err, mem = 1, res_valid = 0;
> -	resource_size_t iobase;
> -	struct resource_entry *win, *tmp;
> -
> -	err = devm_of_pci_get_host_bridge_resources(dev, 0, 0xff, res, &iobase);
> -	if (err)
> -		return err;
> -
> -	err = devm_request_pci_bus_resources(dev, res);
> -	if (err)
> -		goto out_release_res;
> -
> -	resource_list_for_each_entry_safe(win, tmp, res) {
> -		struct resource *res = win->res;
> -
> -		switch (resource_type(res)) {
> -		case IORESOURCE_IO:
> -			err = devm_pci_remap_iospace(dev, res, iobase);
> -			if (err) {
> -				dev_warn(dev, "error %d: failed to map resource %pR\n",
> -					 err, res);
> -				resource_list_destroy_entry(win);
> -			}
> -			break;
> -		case IORESOURCE_MEM:
> -			res_valid |= !(res->flags & IORESOURCE_PREFETCH);
> -
> -			writel(res->start >> 28, PCI_IMAP(mem));
> -			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
> -			mem++;
> -
> -			break;
> -		}
> -	}
> -
> -	if (res_valid)
> -		return 0;
> -
> -	dev_err(dev, "non-prefetchable memory resource required\n");
> -	err = -EINVAL;
> -
> -out_release_res:
> -	pci_free_resource_list(res);
> -	return err;
> -}
> -
>  static int versatile_pci_probe(struct platform_device *pdev)
>  {
>  	struct device *dev = &pdev->dev;
>  	struct resource *res;
> -	int ret, i, myslot = -1;
> +	struct resource_entry *entry;
> +	int ret, i, myslot = -1, mem = 0;

I think 'mem' should be initialised to 1, at least that's what the original
code did. However I'm not sure why it should start from 1.

Thanks,

Andrew Murray

>  	u32 val;
>  	void __iomem *local_pci_cfg_base;
>  	struct pci_bus *bus, *child;
> @@ -141,10 +93,18 @@ static int versatile_pci_probe(struct platform_device *pdev)
>  	if (IS_ERR(versatile_cfg_base[1]))
>  		return PTR_ERR(versatile_cfg_base[1]);
>  
> -	ret = versatile_pci_parse_request_of_pci_ranges(dev, &pci_res);
> +	ret = pci_parse_request_of_pci_ranges(dev, &pci_res, NULL);
>  	if (ret)
>  		return ret;
>  
> +	resource_list_for_each_entry(entry, &pci_res) {
> +		if (resource_type(entry->res) == IORESOURCE_MEM) {
> +			writel(entry->res->start >> 28, PCI_IMAP(mem));
> +			writel(PHYS_OFFSET >> 28, PCI_SMAP(mem));
> +			mem++;
> +		}
> +	}
> +
>  	/*
>  	 * We need to discover the PCI core first to configure itself
>  	 * before the main PCI probing is performed
> -- 
> 2.20.1
> 
> 
> _______________________________________________
> linux-arm-kernel mailing list
> linux-arm-kernel@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-arm-kernel
